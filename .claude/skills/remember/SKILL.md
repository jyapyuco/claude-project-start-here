---
name: remember
description: Use to save one durable fact to memory right now — a decision, gotcha, convention, or generalizable lesson — without waiting for session-end dreaming. Use when the user says "remember this" or when a hard-won fact emerges mid-session.
---

# Remember — Save One Fact Now

## 1. Identify the fact

State the fact in one or two sentences. If invoked with arguments, that's the fact; if the user said "remember this", it's whatever was just established. If it's vague ("remember what we did"), ask what specifically was non-obvious — don't save narration.

Refuse politely if it's something the repo already records (code structure, git history) — point to where it lives instead.

## 2. Classify → target file

| Kind | Target |
|---|---|
| Choice made with rationale | `.claude/memory/decisions.md` |
| Trap/quirk specific to this project | `.claude/memory/gotchas.md` |
| How the user wants work done here | `.claude/memory/conventions.md` |
| Would help in *any* project | `~/.claude/memory/global-lessons.md` |

## 3. Dedupe, then write

Read the target file. If an entry already covers this, update it in place. Otherwise append in the file's stated format, with an absolute date. Include the **why** — a fact without rationale is half a fact. Never store secrets.

## 4. Index

If the fact is load-bearing (would change how a session starts working), add a one-liner to `.claude/memory/MEMORY.md` under Highlights.

## 5. Confirm

Tell the user in one line what was saved and where.
