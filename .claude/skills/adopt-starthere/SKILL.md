---
name: adopt-starthere
description: Use when retrofitting an EXISTING codebase with this template's agentic setup (CLAUDE.md, agents, hooks, memory, skills) — as opposed to new-project, which bootstraps a fresh copy of the template.
---

# Adopt StartHere — Retrofit the Template onto an Existing Repo

## Overview

Copying this template's `.claude/` into a repo that already has one produces the documented failure set: duplicate agents with conflicting definitions, agent files with broken frontmatter that `/doctor` flags, a CLAUDE.md that contradicts the repo's real commands, and memory files that never get read. Adoption is a merge, not a copy.

## Steps

1. **Inventory what exists.** List the target's `.claude/` (agents, hooks, skills, settings), CLAUDE.md, and any memory/docs folders. Note customizations worth keeping (project-specific agents, docs, permissions).
2. **Merge CLAUDE.md — never overwrite.** Keep the target's real Commands table, conventions, and project description; bring in the template's Workflow, Agents, and Memory sections. The template's placeholder text must not survive into the result.
3. **Port infrastructure:** hooks (`dream.ps1`, `guard.ps1`, `session-start.ps1`, `statusline.ps1`), skills (`dream`, `remember`, plus the workflow skills), `memory/` scaffold (MEMORY.md index + decisions/gotchas/conventions/journal), `docs/orchestration.md`. Seed memory files empty — do not invent history.
4. **Reconcile agents.** Where the template and target define the same agent, keep the better-written one — a project-tuned agent beats the generic template one. Every agent file needs valid frontmatter (`name` + `description`); subfolders under `.claude/agents/` are a known source of parse errors.
5. **Merge settings.json permissions** — union, don't replace; keep the target's allowlist.
6. **Verify:** run `/doctor` (zero agent parse errors), confirm `/agents` lists what CLAUDE.md claims, confirm hooks fire (session-start log), and that memory paths in settings are writable (memory lives OUTSIDE `.claude/` because automated writes into `.claude/` are blocked).
7. **Commit the adoption as its own commit**, touching nothing else.

## Common mistakes

- Overwriting a tuned CLAUDE.md with the template's "(Not yet bootstrapped)" placeholder.
- Leaving both the template's and the repo's copy of the same agent → duplicate/parse errors in `/doctor`.
- Creating a dozen bespoke agents nobody dispatches; port the standard set, add specialists only when a real task needs one.
- Putting memory under `.claude/` where hooks can't write it.
