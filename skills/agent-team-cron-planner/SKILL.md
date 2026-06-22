---
name: agent-team-cron-planner
description: Use when planning recurring multi-agent Hermes workflows (loops) after manual delegation works. Turns a proven manual workflow into a loop with a verifier gate, a stop condition, a maker/checker split, and a cost guardrail.
---

# Agent Team Cron Planner

Plan recurring workflows (loops) for an established agent team.

A cron schedule alone is not a loop. A loop is a goal the team works toward,
checks against a hard gate, and repeats until the goal is met or a stop
condition fires. See `docs/loops.md` for the full model.

Only use after the manual workflow works. Build order:

```text
manual & reliable -> save as skill -> wrap in a loop -> put on a schedule
```

## Step 1: Confirm It Should Be a Loop

Build a loop only when all four are true. Otherwise keep it a single prompt or
a human-gated review.

1. Repeats at least weekly.
2. Something can automatically reject bad output.
3. The agent can do it end to end.
4. "Done" is objective, not a matter of taste.

```text
loop          -> nightly backup verification, daily VPS health check
loop + human  -> monthly security audit (machine scan + human sign-off)
single prompt -> weekly SEO report, content planning (quality = taste)
```

## Step 2: Write the Loop Spec

Copy `templates/task-bus/loop-spec.md` and fill every section. A complete loop
plan defines:

- owner agent and **checker** agent (must differ — the maker/checker split)
- schedule or event trigger
- goal (objective, one sentence)
- loop protocol (discover, plan, execute, verify, iterate)
- **verifier (the gate)** — the hard check that can fail the work
- **stop condition** — success OR `max_iterations` / `budget_tokens`
- state file (what each pass records so the next run resumes)
- output destination
- approval requirements
- failure handling
- logs / artifacts
- **cost** — budget per run + cost-per-accepted-change as the metric to watch

## Step 3: Pressure-Test the Plan

Reject the plan if any of these is true:

- No machine check can fail the work (the loop would just spin).
- The maker also signs off on its own result (no real gate).
- There is no hard limit, only a success exit (Ralph Wiggum loop — runs until
  it breaks or drains the budget).
- No state, so the loop repeats the same mistake every run.
- No cost budget and no accept-rate review.

## Examples

Worked loop specs live in `examples/level-4-automated-team/loops/`:

- `backup-verify.md` — nightly restore + checksum gate
- `vps-health.md` — daily ports / disk / units gate
