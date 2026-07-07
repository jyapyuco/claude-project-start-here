---
name: persona-audit
description: Use when asked to find product/UX issues proactively — "use the app as a first-time user", pre-launch polish, or a sweep after features land with no specific bug report to chase.
---

# Persona Audit — Find What a Real User Would Hit

## Overview

A persona audit is a structured self-drive of the running app from a named user's point of view, producing a prioritized findings file — not a pile of immediate fixes. Its power is that it finds the bugs the owner stopped seeing: this project pattern's best session found a fully broken prod signup, dead invite links, and fake settings toggles in one pass.

## Steps

1. **Name 2–4 personas** with different entry points (first-time signup, invited/secondary user, returning user, platform variants). Different personas hit different routes — an invitee exercises deep links the owner never touches.
2. **Drive the real app live** per persona (see the live-smoke skill for setup: real config, throwaway credentials, server-side verification). Walk their actual journey end-to-end, including the boring parts — empty states, emails, error paths, a second device/browser.
3. **Log every finding immediately** in a findings file (`docs/` or the scratchpad, promoted later): one line each — persona, screen, what happened vs expected, severity **P1** (blocks the journey) / **P2** (erodes trust) / **P3** (polish).
4. **Stop and prioritize before fixing.** Present the ranked list. Fix P1s first, in batches, each verified live. Unfixed items stay in the file as the backlog — they must survive the session.
5. **Clean up** persona accounts/data (ask before prod deletes).

## Severity anchors

| P | Meaning | Example from history |
|---|---|---|
| P1 | A persona cannot complete their core journey | Signup 504s for everyone; invite link lands on 404 |
| P2 | Works but breaks trust or misleads | Settings toggle that does nothing; unreadable button |
| P3 | Polish | Chip radius, animation taste |

## Common mistakes

- Fixing the first finding immediately and never finishing the walk — the audit's value is coverage.
- Auditing only the owner persona; invitees and returning users hit different code.
- Findings living only in the conversation — session ends, backlog gone. Write the file.
- Reporting opinions ("feels dated") without a reproducible observation behind each item.
