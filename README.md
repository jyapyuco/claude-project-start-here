# StartHere — Agentic Project Template

A copyable starting point for projects built with Claude Code. It bundles a lean `CLAUDE.md`, ten specialized subagents, an automated memory/dreaming system, and a safety harness — so every new project starts with the practices that normally take weeks to accumulate.

## Quick start

1. **Copy** this folder and rename it to your project name.
2. Open a terminal in the copy and run `claude`.
3. Run **`/new-project`** — it interviews you (or explores existing code), fills in the stack-specific sections of `CLAUDE.md`, resets the memory files, verifies the hooks, and makes the initial commit.
4. Build things.

> One-time setup (already done on this machine): `~/claude-memory/global-lessons.md` exists and `~/.claude/CLAUDE.md` imports it. On a new machine, recreate both — see "Two-tier memory" below.

## What's inside

```
CLAUDE.md                 Project memory Claude loads every session (placeholders until /new-project)
docs/orchestration.md     Conventions for multi-agent work
docs/specs/, docs/plans/  Where designs and implementation plans accumulate
.claude/settings.json     Hooks, permissions, statusline (committed, shared)
.claude/agents/           10 subagents: explorer, planner, implementer, reviewer,
                          test-runner, security-auditor, docs-writer, web-researcher,
                          refactorer, dependency-auditor
.claude/skills/           /new-project (bootstrap), /dream (reflect), /remember (save a fact)
.claude/hooks/            PowerShell scripts wired into the session lifecycle
memory/                   Project memory: index, decisions, gotchas, conventions, journal
```

This template assumes the **superpowers** plugin is installed (brainstorming, TDD, debugging, planning workflows). `CLAUDE.md` references those skills rather than duplicating them.

## Two-tier memory & dreaming

**Tier 1 — project memory** (`memory/`, committed): decisions made and why, gotchas discovered, conventions learned, plus a `journal.md` with one digest line per session. `CLAUDE.md` imports the index (`MEMORY.md`) so every session starts already knowing what past sessions learned.

**Tier 2 — global lessons** (`~/claude-memory/global-lessons.md`): lessons that would help in *any* project. Loaded in every project via an import in `~/.claude/CLAUDE.md`. This is how best practices compound across projects.

**Dreaming**: when a session ends, a `SessionEnd` hook runs a headless `claude -p` (Haiku — cheap) over the transcript. It distills durable lessons into the right memory tier, updates the index, and appends a journal line. Trivial sessions are skipped. You can also trigger it deliberately with `/dream`, or save a single fact mid-session with `/remember`.

```
session ──ends──> dream.ps1 ──claude -p (haiku)──> memory/*   (project facts)
                                              └──> ~/claude-memory/global-lessons.md (general lessons)
next session ──starts──> session-start.ps1 injects recent journal + git status
```

## The harness

Configured in `.claude/settings.json`:

- **SessionStart hook** — injects the last few journal entries and git status, so Claude resumes with continuity.
- **SessionEnd hook** — the dreaming pipeline above. Logs to `.claude/hooks/dream.log` (gitignored). Never blocks shutdown.
- **PreToolUse guard** (`guard.ps1`) — blocks catastrophic shell commands (recursive deletes of roots, force-push to main, hard reset, disk formatting, dumping `.env` files). Tune the patterns in the script.
- **Permissions** — read-only git commands pre-allowed; `.env*` and `secrets/` reads denied; everything else asks as normal.
- **Statusline** — `directory | git branch (dirty marker) | model`.

## Tuning

- **Dreaming cost/aggressiveness**: edit `.claude/hooks/dream.ps1` — the model (`haiku` by default), and the minimum transcript size that triggers a dream.
- **Guard patterns**: edit `.claude/hooks/guard.ps1`. Keep it conservative — block disasters, not normal work.
- **Permissions**: `/fewer-permission-prompts` after a few sessions, or edit `permissions.allow` in settings.
- **Agents**: each is a markdown file in `.claude/agents/` — adjust tools, model, or prompt freely. They load at session start.

## Portability notes

Hooks are PowerShell (Windows-first, exec-form so Git Bash isn't required). On macOS/Linux, port the four scripts in `.claude/hooks/` to bash and update the `command`/`args` entries in `settings.json`.
