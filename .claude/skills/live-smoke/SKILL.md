---
name: live-smoke
description: Use before claiming any full-stack or auth-adjacent change works — signup, sign-in, invites, password reset, sync, uploads, payments — or when tests/analyze/build are green but nothing has exercised the deployed path end-to-end.
---

# Live Smoke — Prove It Against the Real Stack

## Overview

Static gates lie by omission. In this user's history, 485 green unit tests coexisted with a production signup that 504'd for every user, a table that had never synced a single row, and invite links that couldn't be accepted — each found only when the running app was driven against the live backend. A change to an auth/data flow is unproven until a real client has executed it against the real (or staging) backend.

## The loop

1. **Get real config.** Pull URL/keys from the backend's MCP server or env — never invent them.
2. **Create throwaway credentials.** A disposable account (`verify.<app>.<date>@…` pattern) — never the user's real account. If email confirmation blocks you, note it as a finding, not a workaround target.
3. **Drive the actual app** — browser automation (Playwright/Chrome tools) for web, emulator for mobile. Exercise the specific failing/changed path: right screen, real input.
4. **Verify server-side, not just UI.** After the flow, check the backend: did the row land (SQL via MCP), what do the auth/API logs say, what status codes fired? A UI that looks fine over a rolled-back write is the classic trap.
5. **Clean up.** Delete throwaway accounts/data — ask before deleting anything in prod you didn't create this session.
6. **Report with evidence:** the request/status/row you observed, plus what you could NOT exercise (e.g., real inbox delivery, native camera) as explicitly unverified.

## Environment notes (hard-won)

- Flutter web renders to canvas: enable semantics first (`flt-semantics-placeholder` click) or the DOM is one opaque node. Wrap `window.fetch` to observe network; the SDK uses fetch, not XHR.
- First page load after a redeploy serves the OLD service-worker bundle — reload once before concluding a fix didn't deploy.
- Auth log timing is diagnostic: ~150ms responses never touched SMTP; multi-second ones did.

## Common mistakes

- "Tests pass, build is green, done" on a flow no test drives end-to-end.
- Verifying the UI transition but never checking the row/status code behind it.
- Testing only the happy path you just fixed — re-run the adjacent flows (sign-in after fixing signup; reset after fixing confirm) since they share routes and templates.
- Leaving test accounts in prod.
