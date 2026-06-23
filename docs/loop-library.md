# Loop Library

A curated catalog of loop patterns, mapped to this Control Room's agents and
levels. Use it to pick a proven shape instead of inventing one.

Source and full prompts: ForwardFuture Loop Library —
<https://signals.forwardfuture.ai/loop-library/> (61 loops across Engineering,
Evaluation, Operations, Content, Design). This page keeps only the patterns
that fit a Hermes agent team and notes which are true loops vs human-gated.

Before adopting any pattern, run it through the four-criteria test in
`docs/loops.md`. A pattern being listed here does not mean it should be a loop
in your setup.

## How to Read This

```text
true loop      -> a machine check can fail the work; safe to automate
loop + human   -> machine check exists, but a person signs off on severity
single prompt  -> no machine check; quality is a matter of taste
```

## Operations (-> hermes-ops)

| Pattern                  | Does                              | Gate                          | Type        |
| ------------------------ | -------------------------------- | ----------------------------- | ----------- |
| Backup verification      | restore + compare to source      | checksum + file count + age   | true loop   |
| VPS health check         | services / disk / ports          | units active, disk, HTTP      | true loop   |
| Production error sweep    | find + fix actionable prod errors| root cause traced, PR + CI    | true loop   |
| Repo maintainer (5-min)  | triage repo work on a timer      | tests + live proof + green CI | true loop   |
| Security audit           | scan ports / secrets / tokens    | scan clean; human signs off   | loop + human|

Worked specs: `examples/level-4-automated-team/loops/`.

## Engineering (-> hermes-dev)

| Pattern               | Does                             | Gate                              | Type      |
| --------------------- | -------------------------------- | --------------------------------- | --------- |
| Docs sweep            | align docs with code             | reviewable PR opened              | true loop |
| 100% test coverage    | add meaningful tests             | coverage target reached           | true loop |
| Test stabilizer       | find + fix flaky tests           | N consecutive full-suite passes   | true loop |
| Quality streak        | fix until a streak passes        | N consecutive realistic passes    | true loop |
| Architecture refactor | refactor incrementally           | live test + autoreview each step  | true loop |
| Fresh-clone onboarding| test README in clean env         | one clean clone reaches ready     | true loop |
| Accessibility repair  | fix a11y barriers                | no blocker remains                | true loop |

## Evaluation / Meta (-> hermes-orchestrator)

These are checker-side patterns. They are how you keep the maker/checker split
honest and the portfolio healthy.

| Pattern                  | Does                                  | Gate                                  | Type        |
| ------------------------ | ------------------------------------- | ------------------------------------- | ----------- |
| Multi-LLM convergence    | two systems review until both approve | both approve the same unchanged build | true loop   |
| Devil's advocate         | challenge a decision before commit    | no high-impact objection remains      | loop + human|
| Self-improving champion  | promote a change only on a win        | challenger beats champion on holdouts | true loop   |
| Loop auditor             | review the loop portfolio             | KEEP/PIVOT/RETIRE/KILL by metrics     | true loop   |

Worked spec: `examples/level-4-automated-team/loops/loop-auditor.md`.

## Content / Design (-> hermes-cmo, hermes-seo)

Mostly **not** loops. Quality is a matter of taste, so keep a human in the gate
or keep them single prompts. The one exception with a real machine signal:

| Pattern              | Does                          | Gate                              | Type        |
| -------------------- | ----------------------------- | --------------------------------- | ----------- |
| SEO/GEO visibility   | fix technical search gaps     | recrawl; no critical issues left  | loop + human|
| Content drafting     | draft posts / campaigns       | none (taste)                      | single prompt|

## Adopting a Pattern

1. Confirm it passes the four-criteria test (`docs/loops.md`).
2. Copy `templates/task-bus/loop-spec.md` and fill every section.
3. Assign a checker that is not the maker.
4. Set a hard `max_iterations` and token budget.
5. Run it manually until reliable, then schedule it.
