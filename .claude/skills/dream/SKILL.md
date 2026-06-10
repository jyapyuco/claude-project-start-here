---
name: dream
description: Use to consolidate this session's lessons into durable memory — distills decisions, gotchas, conventions, and generalizable lessons into the right memory tier and writes a journal digest. Invoked automatically at session end; run manually after important sessions.
---

# Dream — Session Reflection

Distill what this session learned into memory. Work from the conversation in context, or from a transcript file if one was provided in the invocation.

## 1. Review

Scan the session for durable material:
- **Decisions** — choices made with rationale (architecture, libraries, approach). The *why* matters more than the *what*.
- **Gotchas** — things that failed surprisingly, environment quirks, traps that cost time.
- **Conventions** — user corrections and confirmed preferences about how to work.
- **State** — what was being worked on, where it was left, the known next step.
- **Generalizable lessons** — insights that would help in *any* project, not just this one.

## 2. The bar for "durable"

Save it only if a future session would act differently for knowing it. Skip: anything derivable from the code or git history, session-local details, raw narration of what happened, anything already recorded. **Never store secrets, tokens, or credentials.** If nothing clears the bar, write only the journal line and stop.

## 3. Write — project tier (`.claude/memory/`)

For each item, check the target file for an existing entry first — update it rather than duplicating; delete entries proven wrong.
- Decisions → `decisions.md` (`## YYYY-MM-DD — <decision>`, with **Why:**)
- Gotchas → `gotchas.md`
- Conventions → `conventions.md`
- Significant items also get a one-liner in `MEMORY.md` Highlights (newest first; prune stale lines while you're there — the index must stay short).

Use absolute dates, never "today" or "last week".

## 4. Write — global tier (`~/.claude/memory/global-lessons.md`)

Promote only lessons that pass the test: *would this change behavior in a project with a completely different codebase?* (Tool behaviors, workflow insights, cross-cutting technique.) Same dedupe rule: update existing entries rather than appending near-duplicates. Project-specific facts never go here.

## 5. Journal

Append one line to `.claude/memory/journal.md`:
`- YYYY-MM-DD HH:mm — <what was worked on; state left in; next step if known>`

## 6. Report

If running interactively, summarize in a few lines what was saved to each tier (or that nothing cleared the bar). If running headless, the writes are the output.
