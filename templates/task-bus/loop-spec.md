---
loop_id: LOOP-<name>
owner: hermes-ops
checker: hermes-orchestrator
schedule: "0 3 * * *"          # cron, or describe an event trigger
max_iterations: 8
budget_tokens: 200000
requires_approval_before:
  - destructive operations
  - credential rotation
  - production changes
state_file: /srv/agent-bus/loops/<name>/state.md
log_dir: /srv/agent-bus/loops/<name>/logs
status: draft                  # draft | manual-proven | live
---

# Goal

One sentence. What is true when this loop is done. Must be objective.

# Trigger

Schedule or event that starts a run. (Mirror `schedule` above in words.)

# Loop Protocol

Repeat each iteration until the verifier passes or a stop condition fires:

1. DISCOVER — read state; work out what still needs doing.
2. PLAN — state the single highest-impact next step.
3. EXECUTE — make the smallest change toward the goal.
4. VERIFY — run the gate below. Record the result honestly.
5. ITERATE — pass? stop. Otherwise update state and fix the weakest point.

# Verifier (the gate)

The hard check that can fail the work. Prefer a machine check.

```text
gate: <command / condition that returns pass or fail>
fail: <what counts as a failure>
```

# Maker / Checker

- maker: <agent that does the work — fast, cheap>
- checker: <separate agent that runs the verifier — strict, often stronger>

The maker never signs off on its own result.

# Stop Condition

- success: verifier passes.
- hard limit: `max_iterations` reached OR `budget_tokens` exhausted.

# On Stop

Write a summary: what changed, what still fails, accept/reject decision.

# State

What each pass records so the next run resumes instead of restarting:

- done:
- failed:
- next:

# Output

Where the result and artifacts go (outbox path, report, notification).

# Failure Handling

What happens on hard-limit stop, on a dead verifier, on an expired token.
Who gets paged. What must never auto-retry.

# Cost

- budget per run: see `budget_tokens`.
- metric to watch: cost per accepted change (not tokens spent).
- review trigger: accept rate below ~50% means fix the verifier or kill it.
