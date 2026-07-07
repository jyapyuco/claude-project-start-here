# Template — Greenfield App Spec Prompt

Modeled on your most effective build prompt (the QuantumCircuit IDE revamp spec). The versions that worked stated *principles + layout + stack + interaction requirements*; the versions that flailed stated a vibe ("clean, glassmorphism") and iterated for days. Fill every section; delete none.

---

Build <one-line product statement, with 2–3 named products as quality anchors — "inspired by X, Y, Z">.

Core UX principles:
- <3–6 principles, e.g. progressive disclosure, information density, live feedback>

Tech stack:
- <framework, styling, state, key libs — or "recommend and lock in with me before building">

Layout (by screen region):
1. <region>: <contents and behavior>
2. <region>: <contents and behavior>

Design language:
- <named references, mood, density, motion policy, semantic color rules>

Key features:
- <bulleted, each independently checkable>

Interaction requirements:
- <the feel: drag smoothness, keyboard-first, undo/redo, performance floors>

Out of scope / defer:
- <what NOT to build now — prevents invented paid tiers, placeholder integrations>

Working agreement:
- Brainstorm/spec first if any section above is thin; write the spec to docs/specs/ before code.
- Where uncertain — especially design/product calls — ask, but come with a recommended option.
- State assumptions. Push back with alternatives and a clear recommendation when you disagree.
- Verify against the running app (screenshots), not just a green build, before calling a milestone done.

---

## Notes for the author (you)

- Reference screenshots/URLs of apps you like are worth more than adjectives. "Neumorphism like these 3 sites" worked; "sophisticated" didn't.
- Name the anti-goal too ("not retro space-like") — it prunes half the search space.
- If you'll want it on multiple platforms (web + Android + iOS), say so in this prompt, not month two.
