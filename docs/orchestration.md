# Multi-Agent Orchestration Conventions

How the main agent uses subagents in this project. Referenced from CLAUDE.md; read when coordinating non-trivial work.

## When to delegate vs. work inline

Work **inline** when the task is small, the files are already in context, or you'd spend more tokens briefing an agent than doing the work.

**Delegate** when:
- A side task would flood the main context with search results, logs, or file contents you won't reference again (exploration, test output, research).
- The task benefits from a focused system prompt and restricted tools (review, audit).
- Two or more independent tasks can run in parallel (see `superpowers:dispatching-parallel-agents`).

## The standard loop

For any feature or significant change:

1. **code-explorer** — map the relevant code. Returns a `file:line` map and architecture notes.
2. **planner** — design the approach. Output goes to `docs/plans/YYYY-MM-DD-<topic>.md`.
3. **implementer** — execute the plan with TDD. One task per dispatch; don't hand it a vague goal.
4. **test-runner** — verify the suite passes; diagnoses failures to root cause.
5. **code-reviewer** — review the diff before commit. It keeps persistent memory of codebase patterns, so use it consistently.

Quality/ops agents (**security-auditor**, **refactorer**, **dependency-auditor**, **docs-writer**, **web-researcher**) are dispatched on demand, not as part of every loop.

## Briefing agents

A subagent starts cold — it has its system prompt and the working directory, nothing else. Every dispatch must include:
- The goal and the definition of done.
- Relevant file paths and what's already known about them.
- Constraints (don't touch X, follow pattern in Y).
- The expected output shape ("return a summary with file:line references", "return the diff").

## Output contract

Subagents return **conclusions, not raw material**. Never paste a subagent's file dumps or full logs into the main conversation — if its answer is too long, the briefing asked for the wrong thing.

## Isolation and parallelism

- Risky or parallel implementation work → give the agent `isolation: worktree` (or use `superpowers:using-git-worktrees`) so it works on an isolated copy.
- Long-running suites or builds → background tasks; don't block the conversation polling.
- Two agents must never edit the same files concurrently. Partition by file/module before dispatching in parallel.

## Artifacts

| Artifact | Location | Produced by |
|---|---|---|
| Design specs | `docs/specs/` | brainstorming sessions |
| Implementation plans | `docs/plans/` | planner agent / writing-plans skill |
| Project memory | `memory/` | /remember, /dream, dreaming hook |
| Cross-project lessons | `~/claude-memory/global-lessons.md` | /dream (promotion) |
