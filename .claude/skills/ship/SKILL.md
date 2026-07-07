---
name: ship
description: Use when the user says "commit and push", "push to main", or finished work needs to leave the machine — especially when a push triggers a deploy pipeline.
---

# Ship — Verify, Stage Narrowly, Commit, Push

## Overview

"Commit and push" is this user's single most-typed instruction. It is a gate sequence, not two git commands. The failures this prevents: pushing with the gate never re-run, `git add .` sweeping in another session's or an agent's unrelated work, and pushing to a branch without knowing it deploys to production.

## The sequence

1. **Re-run the gate.** Whatever this project's checks are (tests, analyze, build — see CLAUDE.md Commands), run them now and compare against the recorded baseline. For UI/full-stack changes with no covering test, a live check of the changed flow stands in (see live-smoke). Report the delta, not just "green".
2. **Review `git status` line by line.** Stage only files the task touched. Anything else present: name it and leave it. Never blanket-`git add` a directory to be safe — it isn't.
3. **Commit** with a message stating what and why, matching the repo's existing message style.
4. **Know what push does before pushing.** Check for CI/CD workflows on this branch (`.github/workflows`). If push-to-main = deploy-to-prod, say so in one line ("pushing main deploys the web app; rollback = revert commit + push") as you do it — the user's terse "push it" already authorized the action, not amnesia about its blast radius.
5. **Close with state:** commit hash, what's pushed, what remains dirty and why, and the deploy run to watch if one started.

## Quick reference

| Situation | Action |
|---|---|
| Gate fails on something you didn't touch | Report it as pre-existing with evidence; ship only if the user confirms |
| Mixed file (your change + concurrent work in one file) | Git can't split it — say so, get a call |
| User said "commit and push" once, earlier | That authorized that batch, not all future ones; ask-free shipping needs a standing convention |
| Push rejected / CI red after push | Investigate before retrying; never force-push to shared branches |

## Common mistakes

- Treating "commit and push" as permission to skip the gate — it's an instruction to finish, which includes the gate.
- Committing generated artifacts, screenshots, or scratch files that landed in the tree during the session.
- A perfect commit followed by silence about the CI deploy that then failed.
