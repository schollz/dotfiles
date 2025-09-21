#!/usr/bin/env bash
# quick PR + auto-merge helper for git + gh
# Usage (via git alias): git pr [optional commit title]

set -euo pipefail

err() { printf "\e[31m%s\e[0m\n" "$*" >&2; }
log() { printf "\e[90m%s\e[0m\n" "$*" >&2; }

git rev-parse --is-inside-work-tree >/dev/null

# Derive base branch from origin/HEAD, fallback to main
base="$(git symbolic-ref --short refs/remotes/origin/HEAD 2>/dev/null || true)"
base="$(basename "${base:-}")"
[ -z "$base" ] && base="main"

# Commit/PR message
if [ "$#" -gt 0 ]; then
  msg="$*"
else
  msg="chore: quick PR $(date -u +"%Y-%m-%d %H:%M:%S UTC")"
fi

# Ensure gh exists
if ! command -v gh >/dev/null 2>&1; then
  err "gh CLI not found. Install from https://cli.github.com and run: gh auth login"
  exit 1
fi

# Refresh index
git update-index -q --refresh || true

# Refuse if there are any UNTRACKED files
if git ls-files --others --exclude-standard | grep -q .; then
  err "Refusing: repository has UNTRACKED files."
  err "Please commit/stash/remove them (script never stages untracked)."
  exit 1
fi

# Stage ONLY tracked changes & deletions (not untracked)
git add -u

# If nothing to commit, exit clearly
if git diff --cached --quiet; then
  err "Nothing to commit (no staged changes)."
  err "Tip: This tool only stages tracked modifications/deletions. New files must be added manually."
  exit 1
fi

# Remember current branch
current_branch="$(git rev-parse --abbrev-ref HEAD)"

# Create unique branch from current HEAD (keeps your index)
rand="$(date +%Y%m%d-%H%M%S)-${USER:-u}-$( (command -v openssl >/dev/null && openssl rand -hex 3) || printf "%04d" $RANDOM)"
branch="pr/$rand"

log "Creating branch '$branch' from '$current_branch'…"
git switch -c "$branch" >/dev/null

# Commit staged content
log "Committing staged changes…"
git commit -m "$msg" >/dev/null

log "Fetching base '$base' and pushing branch…"
git fetch origin "$base" >/dev/null 2>&1 || true
git push -u origin "$branch" >/dev/null

title="$(git log -1 --pretty=%s)"
body="$(git log -1 --pretty=%b)"

# Create PR
log "Creating PR against '$base'…"
if ! gh pr create --head "$branch" --base "$base" --title "$title" --body "$body" >/dev/null 2>&1; then
  log "PR may already exist; continuing…"
fi

# Wait for PR number
prn=""
for i in 1 2 3 4 5 6 7 8; do
  prn="$(gh pr list --state open --head "$branch" --json number -q '.[0].number' 2>/dev/null || true)"
  [ -n "$prn" ] && { log "PR #$prn is ready."; break; }
  sleep $((i*2))
done

if [ -z "$prn" ]; then
  err "PR did not appear in time. You can merge later with:"
  err "  gh pr merge --squash --delete-branch --subject \"$title\" --body \"$body\""
  git switch "$base" >/dev/null
  exit 1
fi

# Merge with retries
log "Merging PR #$prn (squash)…"
merged=0
for i in 1 2 3 4 5; do
  if gh pr merge "$prn" --squash --delete-branch --subject "$title" --body "$body" >/dev/null; then
    merged=1
    log "Merged PR #$prn."
    break
  fi
  log "Merge attempt $i failed; retrying…"
  sleep $((i*3))
done

if [ "$merged" -ne 1 ]; then
  err "Merge failed after retries. Resolve checks/conflicts and try again:"
  err "  gh pr merge $prn --squash --delete-branch --subject \"$title\" --body \"$body\""
  git switch "$base" >/dev/null
  exit 1
fi

# Return to base and fast-forward
log "Switching back to '$base' and fast-forwarding…"
git switch "$base" >/dev/null
git pull --ff-only >/dev/null

log "Done."
