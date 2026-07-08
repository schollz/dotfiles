#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -ne 2 ]; then
  echo "Usage: $0 OLD_TAG NEW_TAG"
  echo "Example: $0 10.4.7 10.4.8"
  exit 1
fi

OLD_TAG="$1"
NEW_TAG="$2"

# Replace OLD_TAG with NEW_TAG in text files, ignoring .git folders.
# Uses perl instead of sed for macOS/Linux-compatible in-place editing.
find . -name .git -prune -o -type f -print0 |
  while IFS= read -r -d '' file; do
    if LC_ALL=C grep -Iq "$OLD_TAG" "$file"; then
      OLD_TAG="$OLD_TAG" NEW_TAG="$NEW_TAG" perl -pi -e 's/\Q$ENV{OLD_TAG}\E/$ENV{NEW_TAG}/g' "$file"
      echo "updated: $file"
    fi
  done

# Create GitHub release with the new tag as both tag and title.
gh release create "$NEW_TAG" --title "$NEW_TAG" --generate-notes
