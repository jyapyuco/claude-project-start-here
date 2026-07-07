# Claude Playbook

The distilled do/route guide from the 2026-07 usage review (`claude-usage-review-2026-07.md` has the evidence). One page; read the review when you want the receipts.

## Route the task

| You want to… | Do this |
|---|---|
| Fix a batch of UI/UX issues you found | Send the `docs/templates/ui-feedback-pass.md` format → Claude runs the `ui-pass` skill |
| Know if a full-stack/auth change actually works | Say "live-smoke it" — never be the first human to click a changed flow |
| Find problems before users do | "Run a persona audit" (findings land in a file, not the chat) |
| Get finished work out the door | "Ship it" — gate, narrow staging, deploy-aware push |
| Start a new product | Fill `docs/templates/greenfield-app-spec.md` — principles, layout, stack, anti-goals. Adjectives alone ("clean", "polished") cost you days of taste rounds |
| Bring an old repo up to this template | "Adopt StartHere into <repo>" (`adopt-starthere` skill). QuantumCircuit is the outstanding candidate |
| Make a repo more autonomous | Run `docs/templates/agent-native-audit.md`; save the output to `docs/plans/` |

## Standing rules (so you never retype them)

- Operating Instructions live in **one place**: `~/claude-memory/operating-instructions.md`, auto-loaded everywhere via `~/.claude/CLAUDE.md`. Edit there; never paste into a project again.
- Generalizable lessons → `~/claude-memory/global-lessons.md` (via `/dream` or `/remember`). Project facts → that project's `memory/`.

## Files, not chat scrollback

Anything that must outlive the session goes in a file *before* the session ends: specs → `docs/specs/`, plans → `docs/plans/`, audit findings → a findings doc, deferred bugs → `memory/gotchas.md`. Then `/clear` is free and a crash costs nothing. If you're about to re-paste something you typed before, stop — that content wants to be a file or a skill.

## The five habits that paid off — keep them

1. Ask for a **recommendation with pushback**, not a menu.
2. **Lock decisions explicitly** ("Lock in Zustand") so they're never relitigated.
3. Screenshots + numbered items + *desired behavior* as feedback format.
4. Persona audits before launches.
5. Turning repeated work into skills the moment you notice the repeat (you did this for consulting on day one — apply the same reflex to code projects).

## The three habits to drop

1. **Don't hand-QA what automation can reach.** Demand live verification evidence (screenshot, server-side row/log) with every "done".
2. **Don't accept point fixes for systemic flaws.** If the same visual bug could exist on another screen, the fix is a design-system token, and the answer should mention the sweep.
3. **Don't grow agents/infra speculatively.** Add a specialist agent or skill when a real task repeats, not when a project starts.
