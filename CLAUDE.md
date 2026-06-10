# Project

<!-- FILLED BY /new-project: one paragraph — what this project is, who it's for, current state. -->
*(Not yet bootstrapped. Run `/new-project` to set this project up.)*

# Commands

<!-- FILLED BY /new-project: the real commands for this stack. Delete rows that don't apply. -->
| Action | Command |
|---|---|
| Build | *(TBD)* |
| Run all tests | *(TBD)* |
| Run a single test | *(TBD)* |
| Lint / format | *(TBD)* |
| Run the app | *(TBD)* |

# Conventions

<!-- FILLED BY /new-project: stack-specific conventions (naming, structure, error handling). -->

Universal rules (always apply):
- Match the style of surrounding code; don't introduce a second way to do something that already has one.
- No drive-by refactors — change only what the task requires; note other issues in `memory/gotchas.md` instead.
- Keep files small and focused; a file doing too much is a signal to split it.
- Comments explain constraints the code can't show, never what the next line does.
- Never commit secrets. `.env*` files are off-limits to read and to commit.

# Workflow

This project leans on the **superpowers** plugin — use its skills, don't improvise:
- New feature or behavior change → `superpowers:brainstorming` first; specs go in `docs/specs/`.
- Multi-step work → write a plan with `superpowers:writing-plans` into `docs/plans/` before touching code.
- All implementation → `superpowers:test-driven-development`.
- Any bug or unexpected behavior → `superpowers:systematic-debugging` before proposing fixes.
- Before claiming done → `superpowers:verification-before-completion`. Evidence, then assertions.

# Agents

Delegate to keep this context clean — subagents return summaries, not dumps. Details: @docs/orchestration.md

| Agent | Use when |
|---|---|
| code-explorer | Mapping unfamiliar code before planning or fixing |
| planner | Designing an implementation approach for multi-step work |
| implementer | Executing a written plan or well-defined task (TDD) |
| code-reviewer | After meaningful changes, before commit/PR |
| test-runner | Running suites and diagnosing failures |
| security-auditor | Auth/input/crypto/secrets-adjacent changes |
| docs-writer | READMEs, changelogs, API docs |
| web-researcher | Library choices, best practices, anything post-cutoff |
| refactorer | Behavior-preserving cleanups backed by tests |
| dependency-auditor | Outdated or vulnerable dependencies, upgrade planning |

# Memory

@memory/MEMORY.md

Protocol:
- Learned a durable fact mid-session (decision, gotcha, preference)? Run `/remember` now — don't wait.
- Dreaming runs automatically at session end and distills the transcript into memory. Run `/dream` manually after important sessions you want consolidated immediately.
- Resuming work? `memory/journal.md` has one digest line per past session.
- `MEMORY.md` is an index — keep it short; details live in the topic files next to it.
- Generalizable lessons (useful in *any* project) belong in `~/claude-memory/global-lessons.md`, not here.
