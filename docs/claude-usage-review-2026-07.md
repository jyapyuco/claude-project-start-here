# Claude Usage Review — 2026-07-06

A retrospective over all local Claude Code history: 82 sessions / ~80 MB of transcripts across 8 project directories, the full 248-prompt input history (`~/.claude/history.jsonl`, Dec 2025 → today), every project's `memory/` files, and a transcript-mining pass over the 47 babylou-app sessions. Every artifact this review produced is listed at the end.

**Evidence key:** claims cite the prompt-history line (#N), a memory file, or the transcript-mining pass. Where something is inferred rather than observed, it says so.

---

## 1. What you actually use Claude for most

**Confirmed, by volume:** you are not primarily using Claude to write new code. You use it to **iterate running products against your own manual QA** — and, almost as much, to **build the machinery around Claude itself**.

| Rank | Activity | Evidence |
|---|---|---|
| 1 | **Babylou app iteration** — ~57% of all sessions (47/82) and ~60% of transcript volume. Within it, the dominant loop: you use the app, find breakage, report numbered findings with screenshots, Claude fixes, you say "commit and push". Auth/signup/email flows alone consumed 10+ sessions. | history #17–#57, #141–#242; transcript mining |
| 2 | **Agentic-infrastructure engineering** — the StartHere template, agent rosters, CLAUDE.md engineering, memory/dreaming, MCP setup, the ConsultingEnv skill suite. Roughly a fifth of all prompts are *about Claude* rather than about a product. | #74, #86, #115, #118, #121–122, #46–47, #88 |
| 3 | **Greenfield generation** — QuantumCircuit, ConsultingFirmGame, Storyline Studio: large spec prompt → full build → taste-driven UI rounds. | #70, #89/#91, #167, #208 |
| 4 | **Business/ops advisory** — Google Play account types, DUNS/company formation, company naming, DNS, storage-vendor choices. Small in tokens, real in frequency. | #56, #136, #169–#172, #223 |

The gap between self-image and reality: your prompts describe you as *building apps*; the transcripts show the scarce resource you actually spend is **your own manual verification time** — you served as the QA loop for months (see Q5.4).

## 2. Repeated tasks that were never turned into anything reusable

Now they are — each row names the artifact created today.

| Repeated task | Occurrences (evidence) | Now |
|---|---|---|
| The "UI refinement pass": numbered feedback + screenshots → fixes → verify → ship | 10+ rounds (#51, #81, #97–98, #101, #106, #113, #141–142, #176, #185, #188) | `.claude/skills/ui-pass/` + `docs/templates/ui-feedback-pass.md` |
| Live end-to-end smoke: throwaway creds + Playwright + Supabase MCP | Requested ad-hoc each time (#189, #26, #224, #227; conventions.md records the correction verbatim) | `.claude/skills/live-smoke/` |
| Persona-driven audit ("pretend you're a new parent") | #207 — your single most productive session (490→635 tests, 7 deployed fix batches) | `.claude/skills/persona-audit/` |
| "Commit and push" as a gate | 15+ prompts (#6, #29, #37, #52, #143–144, #160, #238…) | `.claude/skills/ship/` |
| Retrofitting agentic infra onto an existing repo | Done by hand for babylou (#121–122); QuantumCircuit still un-adopted (12 bespoke agents, no memory, no journal) | `.claude/skills/adopt-starthere/` |
| The big greenfield spec prompt | #89 pasted twice (#91), variants at #70, #167, #208 | `docs/templates/greenfield-app-spec.md` |
| Codebase-wide quality audits ("end to end code review", "UX/UI audit", agent-native audit) | #38, #83–84, #122, #248 | `docs/templates/agent-native-audit.md` |

Counter-example worth naming: **BabylouPitch/ConsultingEnv got this right** — deck building, kickoff, research, and brand work became 10 skills + COM tool scripts on day one, and the second engagement reused them wholesale. The coding projects never got the same treatment until today.

## 3. Instructions you kept rewriting by hand

- **The Operating Instructions block** — pasted verbatim into three projects within 90 minutes (#178 StartHere, #179 + #181 babylou, after a failed first attempt) and reviewed again (#180). ~1,400 words retyped/repasted per project, guaranteed to drift. **Fixed:** now a single file, `~/claude-memory/operating-instructions.md`, imported by `~/.claude/CLAUDE.md` into every session of every project. Rollback: delete the two `@`-import lines. The inline copies in StartHere's and babylou's CLAUDE.md are now redundant — delete whenever convenient.
- **"Always validate by launching the app and capturing screenshots… then commit and push"** (#177, plus ~7 rephrasing across sessions per the transcript mining). Now the core contract of `ui-pass`, `live-smoke`, and `ship`.
- **"Update via design system changes where it makes sense" / "no hardcoded colors"** (#36, #185, #188, #101) — now step 2 of `ui-pass`.
- **"Come with a recommendation; push back; state assumptions"** (#122, #167, #207) — present in the Operating Instructions ("At a fork, lead with your recommendation"), so the global import covers it.
- **Re-pasted context after `/clear`** — the same multi-item request re-sent because the session that held it was cleared (#185→#188 same day; #197→#200; #89→#91). Not an instruction problem but the same disease: state living in conversations instead of files. Remedy in the playbook (§ "Files, not chat scrollback").

## 4. Workflows that deserved to become permanent skills

Created today, each verified by giving a fresh subagent only the skill file plus a realistic scenario and checking its plan against the historical failure modes:

1. **`ui-pass`** — executes a numbered feedback round: number-locked checklist, design-system-vs-local classification, live per-item verification, per-item status table, narrow staging.
2. **`live-smoke`** — proves auth/data flows against the real stack: throwaway creds, drive the real app, verify server-side (SQL/logs), clean up. Encodes the hard-won environment traps (Flutter canvas semantics, stale service-worker bundle, SMTP log timing).
3. **`persona-audit`** — the #207 session as a repeatable method: personas → full walks → P1/P2/P3 findings *file* → prioritize → fix in verified batches.
4. **`ship`** — "commit and push" as a gate: re-run gate vs baseline, stage only task files, know whether push deploys, close with state.
5. **`adopt-starthere`** — merge (never copy) the template into an existing repo; agent reconciliation; `/doctor`-verified. **First real use available now: E:\QuantumCircuit.**

Deliberately *not* made into skills: brainstorming/TDD/debugging/verification (superpowers already covers them — the skills above cross-reference rather than duplicate) and the consulting deck workflows (already skills in ConsultingEnv/BabylouPitch).

## 5. Where your approach was simply wrong — stop doing these

1. **Pasting standing instructions into individual projects.** Three hand-pastes of the same 1,400-word block in one evening (#178–181), including one titled "Icorporate" — each copy a fork that drifts. Global instructions belong in one imported file. (Fixed today; see Q3.)

2. **Fixing systemic UI flaws one screen at a time.** January's dark-mode arc: fix the settings page (#20) → "there should be an option…" (#21) → "implementation seems wrong… text conflicts with background" (#22) → "working terribly, especially Settings" (#34) → "check other screens too" (#35) → only then "do not use hardcoded colors anywhere, leverage a central design system" (#36). Five rounds to reach the instruction that should have been round one. When a visual bug is a token bug, demand the token fix first — `ui-pass` now hard-codes this.

3. **Being the QA department yourself.** For months the cycle was: Claude claims done → *you* manually sign up, click around, screenshot the breakage, paste it back (#17, #27, #31–32, #49, #51, #226, #240, #242…). The single question "Can't you create test credentials, use playwright, and access our Supabase account via MCP?" (#189) changed the project's trajectory — the resulting live run found a production-killing bug (baby_profiles never synced; prod signup 504ing for everyone) that **485 green unit tests had hidden**. You should essentially never be the first person to click a flow Claude changed. That's `live-smoke` now, and your on-device time should be spent only on what automation genuinely can't reach (real inbox delivery, native camera, touch feel).

4. **Declaring auth flows done one facet at a time.** The email/auth cluster reopened 6+ times across June–July: invite acceptance → invitee verification → "already signed in as a different user" fallback (#228) → signup email never arrives (#240) → reset link 404s on `/auth/confir` (#242). Each fix was verified only on the facet just touched. Auth is one surface: signup, confirm, sign-in, reset, invite, deep-link — smoke them together every time any one changes (`live-smoke` step 6 now says exactly this).

5. **Agent sprawl before agent need.** QuantumCircuit got 12 bespoke agents (one per QC vendor) in week one (#74) — no memory folder, no journal, and no evidence of dispatches; babylou accumulated duplicate/broken agent files that `/doctor` flagged (#41) and you then spent a session cleaning up (#46). Infrastructure earns its place by being used; port the standard set, add specialists when a real task demands one.

6. **Letting state live in conversations.** `/clear` ~20+ times, then re-pasting the same request; a computer crash forcing "could you verify whether my last request was implemented?" (#201); findings and plans that evaporated with the session. Anything with a lifespan longer than the current session goes in a file: specs in `docs/specs/`, plans in `docs/plans/`, audit findings in a findings doc, follow-ups in `memory/gotchas.md`. (This review itself is the demonstration.)

7. **Minor but real: driving infra through chat trial-and-error.** `az login` in a session without az on PATH (#134–135), `claude mcp add` syntax fumbles (already captured as global lessons). For CLI/config problems, the pattern that worked was letting Claude read the error and drive the fix — the pattern that didn't was retyping variants by hand.

**What you were right about, for balance:** demanding recommendations-with-pushback (#122), the persona-audit instinct (#207), locking decisions explicitly ("Lock in Zustand", #93–95), the Master-Plan-as-source-of-truth discipline in ConsultingFirmGame, and turning consulting work into skills immediately. The template you built (StartHere) is genuinely good — today's artifacts extend it rather than replace it.

---

## Artifacts produced by this review

| Artifact | Path |
|---|---|
| This review | `docs/claude-usage-review-2026-07.md` |
| Day-to-day playbook | `docs/claude-playbook.md` |
| Skill: UI feedback round | `.claude/skills/ui-pass/SKILL.md` |
| Skill: live full-stack smoke | `.claude/skills/live-smoke/SKILL.md` |
| Skill: persona audit | `.claude/skills/persona-audit/SKILL.md` |
| Skill: ship gate | `.claude/skills/ship/SKILL.md` |
| Skill: retrofit template onto existing repo | `.claude/skills/adopt-starthere/SKILL.md` |
| Template: UI feedback pass prompt | `docs/templates/ui-feedback-pass.md` |
| Template: greenfield app spec prompt | `docs/templates/greenfield-app-spec.md` |
| Template: agent-native audit prompt | `docs/templates/agent-native-audit.md` |
| Global operating instructions (single source) | `~/claude-memory/operating-instructions.md` + import in `~/.claude/CLAUDE.md` |

Since StartHere is the template you copy for new projects, the five skills and three templates propagate to every future project automatically. For existing projects, copy `.claude/skills/` + `docs/templates/` across, or run `adopt-starthere`.
