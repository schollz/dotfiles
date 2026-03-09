#!/usr/bin/env -S uv --quiet run --script
# /// script
# requires-python = ">=3.13"
# dependencies = [
#     "openai",
#     "rich",
# ]
# ///

import sys
import platform
import subprocess
from openai import OpenAI
from rich.console import Console
from rich.panel import Panel
from rich.syntax import Syntax
from rich.spinner import Spinner
from rich.live import Live
from rich.text import Text

console = Console()
client = OpenAI()

def system_prompt():
    os_name = platform.system().lower()
    if os_name == "windows":
        env = "Windows environment. Return a single runnable PowerShell command."
    else:
        env = "Linux/macOS environment. Return a single runnable POSIX shell command."
    return f"""
You translate natural language into a single runnable command.
{env}
Return only the command with no explanation.
Do not include markdown or formatting.
""".strip()

def generate_command(task: str) -> str:
    with Live(Spinner("dots", text="thinking"), console=console, refresh_per_second=12):
        r = client.responses.create(
            model="gpt-4.1",
            input=[
                {"role": "system", "content": system_prompt()},
                {"role": "user", "content": task},
            ],
        )
    return r.output_text.strip()

def run_command(cmd: str):
    if platform.system().lower() == "windows":
        p = subprocess.Popen(
            ["powershell", "-NoProfile", "-Command", cmd],
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            text=True,
            bufsize=1,
        )
    else:
        p = subprocess.Popen(
            cmd,
            shell=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            text=True,
            bufsize=1,
        )

    for line in iter(p.stdout.readline, ""):
        console.print(line.rstrip(), highlight=False)
    p.wait()
    return p.returncode

def main():
    if len(sys.argv) < 2:
        console.print("usage: do <task>")
        sys.exit(1)

    task = " ".join(sys.argv[1:])

    cmd = generate_command(task)

    console.print()
    console.print(Panel(Syntax(cmd, "bash", theme="monokai", line_numbers=False), title="command"))

    run_command(cmd)

    console.print()
    console.print(Panel(cmd, title="executed"))

if __name__ == "__main__":
    main()
