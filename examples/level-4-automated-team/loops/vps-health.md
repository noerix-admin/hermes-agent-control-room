---
loop_id: LOOP-vps-health
owner: hermes-ops
checker: hermes-orchestrator
schedule: "*/30 * * * *"       # every 30 minutes
max_iterations: 5
budget_tokens: 80000
requires_approval_before:
  - restarting a service in production
  - changing firewall rules
state_file: /srv/agent-bus/loops/vps-health/state.md
log_dir: /srv/agent-bus/loops/vps-health/logs
status: draft
---

# Goal

Every expected service is up, disk is below threshold, and each agent
gateway/dashboard port responds.

# Trigger

Every 30 minutes via cron.

# Loop Protocol

1. DISCOVER — read state; note any issue still open from the last run.
2. PLAN — pick the next unhealthy check.
3. EXECUTE — for a known-safe fix (e.g. restart a crashed non-prod unit),
   apply it; otherwise record and escalate.
4. VERIFY — re-run the gate below.
5. ITERATE — all green? stop. Otherwise update state and continue.

# Verifier (the gate)

```text
gate: all expected systemd units == active,
      disk usage < 85%,
      each registered gateway/dashboard port returns HTTP < 500,
      no container in a restart loop
fail: any unit inactive, disk >= 85%, port dead, container restarting
```

# Maker / Checker

- maker: hermes-ops runs checks and any allowed self-heal.
- checker: hermes-orchestrator confirms the green state and approves any
  production restart before it happens.

# Stop Condition

- success: all checks green.
- hard limit: 5 iterations. If still failing, escalate — do not loop on a
  problem that needs a human.

# On Stop

Summary: checks green, checks failed, actions taken, what was escalated.

# State

- done: checks passing
- failed: check + reason + whether self-heal was attempted
- next: open issues

# Output

Result file to `/srv/agent-bus/tasks/ops/outbox`. Page the operator on any
failure that self-heal did not clear.

# Failure Handling

- Production restart needs approval first (see frontmatter).
- Disk over threshold: report, do not auto-delete anything.
- Repeated same failure across runs: stop self-healing, escalate.

# Cost

- budget per run: 80k tokens.
- metric: cost per run kept low — this loop runs 48x/day.
- review trigger: if it self-heals the same unit every run, the unit is the
  problem; fix the root cause instead of looping.
