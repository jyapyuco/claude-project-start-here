# Template — Agent-Native Codebase Audit

Your prompt (2026-07-06, babylou-app) — preserved as a reusable template. Run it per codebase every few months, or before scaling up autonomous agent work on a repo.

---

Act as a principal architect reviewing this codebase with a single goal: make it agent-native. Definition: coding agents should be able to pick up a user bug report or a roadmap feature, then reproduce, implement, test, and verify it on a real build with minimal human input.

Audit four things:

1. **Human-judgment chokepoints:** every place where a change currently requires my personal judgment or tribal knowledge. Which of these could become written conventions, decision tables, or CLAUDE.md rules an agent can follow on its own?
2. **Verification gaps:** for each core subsystem, what is missing for an agent to verify its own change end-to-end? (behavior tests, live probes, mock event injection, log assertions, screenshot diffs)
3. **Reproduction paths:** given a typical user bug report (text plus diagnostic bundle), what would an agent need to reproduce it autonomously? What fixtures or replay harnesses are missing?
4. **Structural obstacles:** modules too entangled for an agent to change safely without reading the whole repo. Propose boundaries.

Deliverable: a prioritized plan ranked by human-attention-saved per unit of effort. The top 5 items must be specified concretely enough that an agent could start each one from this document alone.

---

## Notes for the author (you)

- Save the deliverable to `docs/plans/YYYY-MM-DD-agent-native-audit.md` so the top-5 items are dispatchable later — the audit's value dies if it lives only in a conversation.
- Follow-up pattern: dispatch one implementer per top-5 item, each starting from the audit document alone (that's the test that the audit was specific enough).
