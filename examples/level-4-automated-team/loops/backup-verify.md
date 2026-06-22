---
loop_id: LOOP-backup-verify
owner: hermes-ops
checker: hermes-orchestrator
schedule: "0 3 * * *"          # nightly at 03:00
max_iterations: 3
budget_tokens: 120000
requires_approval_before:
  - deleting any backup
  - rotating credentials
state_file: /srv/agent-bus/loops/backup-verify/state.md
log_dir: /srv/agent-bus/loops/backup-verify/logs
status: draft
---

# Goal

The latest backup of each registered agent restores cleanly and matches its
source, and is less than 24 hours old.

# Trigger

Nightly cron at 03:00.

# Loop Protocol

1. DISCOVER — read state; list agents whose backup is unverified tonight.
2. PLAN — pick the next unverified agent.
3. EXECUTE — restore its latest backup to a scratch path.
4. VERIFY — run the gate below.
5. ITERATE — pass? mark verified, take the next agent. Fail? record and stop
   per the stop condition.

# Verifier (the gate)

```text
gate: restore latest backup to /srv/scratch/restore-<agent>,
      assert checksum(restore) == checksum(source manifest),
      assert file_count(restore) == file_count(source manifest),
      assert age(backup) < 24h
fail: checksum mismatch, missing/extra files, or backup older than 24h
```

# Maker / Checker

- maker: hermes-ops runs the restore and computes checksums.
- checker: hermes-orchestrator re-reads the manifest comparison and confirms
  pass/fail before the run is marked verified.

# Stop Condition

- success: every registered agent verified.
- hard limit: 3 iterations, or a failing verifier (stop immediately on a
  failed restore — do not retry a bad backup, escalate it).

# On Stop

Write a summary: agents verified, agents failed, age of each backup.

# State

- done: agents verified this cycle
- failed: agent + failure reason
- next: agents still unverified

# Output

Result file to `/srv/agent-bus/tasks/ops/outbox`. On any failure, page the
operator — a failed backup is not a silent log line.

# Failure Handling

- Failed restore: stop, escalate, never auto-delete or auto-rotate.
- Stale backup (>24h): flag the backup job itself as broken, not the data.

# Cost

- budget per run: 120k tokens.
- metric: cost per verified agent.
- review trigger: if restores routinely fail, the backup job is broken — fix
  it rather than re-running the loop.
