# Template — UI Feedback Pass

Copy, fill, send. This is the feedback format that consistently produced good rounds (numbered items + screenshots + desired behavior), with the standing instructions you used to retype every time now baked into the footer.

---

UI refinement pass — update via design system changes where the same flaw could exist elsewhere.

1. <what's wrong> — <where> [Image #1]. Desired: <what it should do/look like>.
2. <what's wrong> [Image #2]. Desired: <...>.
3. ...

Backend/behavior fixes:
1. <bug: what you did, what happened, what should happen>.
2. ...

Standing instructions:
- Fix at the design-system level (tokens/components) when the flaw isn't screen-specific; sweep for other instances of the same pattern.
- Verify every item live in the running app (screenshot or state assertion) before reporting it done; list anything only I can verify on-device.
- Report a per-item status table: fixed & verified / fixed, unverifiable here / not done + why.
- Then commit and push (stage only the files this pass touched).

---

## Notes for the author (you)

- One issue per number. A number with three complaints gets partially fixed.
- Every visual item earns a screenshot; the screenshot is the acceptance criterion.
- Say the *desired* behavior, not just the complaint — "chips too rounded" produced a guess; "less rounded or elongated, whichever is closer to best practice" produced the right fix first try.
- The executing agent should use the `ui-pass` skill (`.claude/skills/ui-pass/`).
