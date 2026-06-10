---
name: new-project
description: Use once after copying the StartHere template to bootstrap a new project — fills in CLAUDE.md placeholders, resets memory, verifies hooks, and makes the initial commit. Also use if CLAUDE.md still shows "Not yet bootstrapped".
---

# Bootstrap a New Project

Run through this checklist in order. Use TodoWrite/tasks to track the steps.

## 1. Confirm identity

Ask the user (one AskUserQuestion is fine):
- Project name and one-sentence purpose.
- Greenfield, or wrapping existing code? If existing code will be added/imported, where from?
- Intended stack (skip if existing code answers this).

## 2. Git

If this folder is not already a git repository: `git init`. Confirm `.gitignore` exists (the template ships one).

## 3. Explore or interview

- **Existing code present:** dispatch the `code-explorer` agent to map the stack, build/test commands, and conventions actually in use.
- **Greenfield:** derive commands/conventions from the user's stated stack; mark anything uncertain as TBD rather than inventing it.

## 4. Fill CLAUDE.md

Replace every `<!-- FILLED BY /new-project -->` placeholder:
- **Project** — one paragraph: what it is, who it's for, current state. Delete the "(Not yet bootstrapped)" line.
- **Commands** — real commands for this stack; delete rows that don't apply. Verify each command actually runs before recording it (greenfield: record the planned command and mark it `(unverified)`).
- **Conventions** — stack-specific conventions; keep the Universal rules block as-is.

Keep CLAUDE.md lean. Don't add sections; don't pad.

## 5. Reset memory

The template's memory files ship clean, but if this folder was copied from a *used* project, reset:
- `memory/MEMORY.md` Highlights → `*(none yet)*` (keep the structure).
- `decisions.md`, `gotchas.md`, `conventions.md` → header + `*(none yet)*`.
- `journal.md` → header only.

Then record the first decision in `decisions.md`: the chosen stack and why (dated today).

## 6. Verify the harness

- Run each hook script with synthetic input and confirm it behaves:
  - `session-start.ps1` → outputs JSON with `additionalContext`.
  - `guard.ps1` with a `git status` command → exit 0; with `rm -rf /` → exit 2.
  - `statusline.ps1` → one-line output.
- Confirm `.claude/settings.json` parses (`Get-Content .claude/settings.json -Raw | ConvertFrom-Json`).
- Remind the user that agents/skills load at session start — a restart picks up any edits made during bootstrap.

## 7. Initial commit

Stage everything and commit: `chore: bootstrap <project-name> from StartHere template`.

## 8. Report

Tell the user what was configured, what's still TBD (unverified commands, missing stack details), and the suggested first step (usually: brainstorm the first feature).
