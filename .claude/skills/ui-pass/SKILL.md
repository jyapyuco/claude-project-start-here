---
name: ui-pass
description: Use when the user gives a numbered list of UI/UX feedback items to fix in one round — visual bugs, spacing, dark mode, alignment, interaction behavior — often with screenshots attached.
---

# UI Pass — Execute a Numbered Feedback Round

## Overview

A UI pass is a batch of numbered visual/interaction fixes. The failure modes this skill exists to prevent (all observed repeatedly in this user's history): items silently dropped from long lists, symptoms patched at one screen while the same flaw lives elsewhere, and "fixed" claimed without ever rendering the screen.

## The contract

1. **Number-lock the list.** Restate every item as a checklist (one todo per item) before touching code. An item you can't act on gets a status, never silence.
2. **Classify each item: system or local.** Ask "can this same flaw exist on another screen?" If yes → fix the design-system token/component (color, radius, spacing, typography), not the instance. Dark mode was "fixed" three times on this principle's violation before a design-system sweep actually ended it.
3. **Fix, then verify each item live.** Launch the app, navigate to the actual screen, and observe the change — screenshot or DOM/state assertion. A green build or passing analyze is not verification for visual work. Use the project's run/verify skill if one exists.
4. **Report a per-item status table:** `fixed & verified` / `fixed, not verifiable here (say why + how the user can check)` / `not done (why)`.
5. **Only then commit** — stage only the files the pass touched. Commit/push only when asked (or when the project's conventions say terse go-aheads mean go).

## Quick reference

| Situation | Action |
|---|---|
| Item is ambiguous | Pick the best-practice reading, state it in the report; don't stall the batch |
| Same flaw suspected elsewhere | Grep for the pattern (hardcoded color, magic padding) and fix at the source |
| Item can't be verified in this environment (native gesture, camera) | Mark it; list it under "yours to check on device" |
| New symptom appears while fixing | Re-diagnose it fresh; don't re-apply the last fix |

## Common mistakes

- Fixing item 3's symptom on the Settings screen when the token is wrong app-wide.
- Answering a 7-item list with 5 fixes and no mention of the other 2.
- "All items complete" with zero screenshots — the user's next message will be a screenshot proving otherwise.
- Treating attached screenshots as decoration: each image defines done for its item.
