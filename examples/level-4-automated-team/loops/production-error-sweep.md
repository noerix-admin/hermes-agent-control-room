---
loop_id: LOOP-production-error-sweep
owner: hermes-dev
checker: hermes-orchestrator
schedule: "0 */6 * * *"        # every 6 hours
max_iterations: 5
budget_tokens: 250000
requires_approval_before:
  - merging the pull request
  - production deploys
  - schema or data migrations
state_file: /srv/agent-bus/loops/production-error-sweep/state.md
log_dir: /srv/agent-bus/loops/production-error-sweep/logs
status: draft
---

# Goal

Each actionable production error has a root-cause fix in a reviewable pull
request with green CI. No actionable errors left untriaged.

# Trigger

Scheduled log review every 6 hours.

# Loop Protocol

1. DISCOVER — read state and the latest error logs; list actionable errors
   not yet addressed this cycle.
2. PLAN — pick the highest-impact actionable error.
3. EXECUTE — trace the root cause, write the smallest fix, add a regression
   test, open a PR.
4. VERIFY — run the gate below.
5. ITERATE — pass? record the PR, take the next error. No actionable errors
   left? stop with success.

# Verifier (the gate)

```text
gate: root cause identified (not just the symptom),
      regression test added that fails without the fix,
      full test suite green + lint clean,
      CI green on the opened PR
fail: symptom-only patch, no failing-without-fix test, red CI
```

# Maker / Checker

- maker: hermes-dev traces, fixes, and opens the PR — fast, cheap model.
- checker: hermes-orchestrator confirms the root cause is real and the
  regression test actually fails without the fix — stricter, stronger model.
  The maker never self-approves the merge.

# Stop Condition

- success: no actionable errors remain.
- hard limit: 5 iterations, or token budget exhausted. Noise and
  unreproducible one-offs are not actionable — skip them, do not loop on them.

# On Stop

Summary: errors fixed (with PR links), errors skipped as non-actionable,
anything escalated for a human.

# State

- done: errors fixed this cycle + PR links
- failed: error + why the fix did not land
- next: actionable errors still open

# Output

PRs opened against the relevant repo; result file to
`/srv/agent-bus/tasks/dev/outbox`. Merging stays a human decision.

# Failure Handling

- Cannot find a real root cause: stop on that error, escalate, do not ship a
  symptom patch.
- Same error recurs after a "fix": reopen, mark the previous fix as wrong.
- Never auto-merge or auto-deploy (see frontmatter).

# Cost

- budget per run: 250k tokens (tracing reads a lot of context).
- metric: cost per merged fix, not errors looked at.
- review trigger: if most PRs get rejected in review, the maker is shipping
  symptom patches — tighten the root-cause gate.
