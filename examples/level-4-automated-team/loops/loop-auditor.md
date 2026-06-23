---
loop_id: LOOP-loop-auditor
owner: hermes-orchestrator
checker: user
schedule: "0 9 * * 1"         # weekly, Monday 09:00
max_iterations: 1
budget_tokens: 60000
requires_approval_before:
  - retiring or killing a live loop
state_file: /srv/agent-bus/loops/loop-auditor/state.md
log_dir: /srv/agent-bus/loops/loop-auditor/logs
status: draft
---

# Goal

Every live loop has a current health verdict (KEEP / PIVOT / RETIRE / KILL)
backed by its accept rate and cost per accepted change. No loop runs unaudited.

# Trigger

Weekly, Monday 09:00. This is the meta-loop that keeps the other loops honest.

# Loop Protocol

A single pass over the portfolio (this loop does not iterate toward a fix — it
classifies and reports):

1. DISCOVER — list all loops with `status: live`.
2. PLAN — collect each loop's last-week metrics from its log dir.
3. EXECUTE — compute accept rate and cost per accepted change per loop.
4. VERIFY — assign a verdict by the gate below.
5. ITERATE — n/a (single pass); write the report.

# Verifier (the gate)

```text
KEEP   : accept rate >= 50% and cost per accepted change trending flat/down
PIVOT  : valuable output but accept rate 30-50% -> fix the verifier/prompt
RETIRE : accept rate < 30%, or output no longer used
KILL   : Ralph Wiggum behaviour seen (exits half-done, runs with no real gate)
fail   : a loop with no recorded metrics -> cannot audit -> flag as blind
```

# Maker / Checker

- maker: hermes-orchestrator computes metrics and proposes verdicts.
- checker: the operator (user) approves any RETIRE or KILL before it takes
  effect. The orchestrator does not retire its own loops unilaterally.

# Stop Condition

- success: every live loop has a verdict and the report is written.
- hard limit: 1 iteration. No metrics for a loop is itself a finding, not a
  reason to loop.

# On Stop

Report: table of loop / accept rate / cost per accepted change / verdict, plus
the list of blind loops (no metrics) and a recommended action per loop.

# State

- done: loops audited this week
- failed: loops with missing metrics
- next: verdicts awaiting operator approval

# Output

Audit report to `/srv/agent-bus/tasks/ops/outbox`. RETIRE/KILL actions wait for
operator approval.

# Cost

- budget per run: 60k tokens.
- metric: this loop's own cost should stay tiny relative to what it saves by
  killing wasteful loops.
- review trigger: if it never recommends a change, either the portfolio is
  healthy or the thresholds are too loose — sanity-check the thresholds.
