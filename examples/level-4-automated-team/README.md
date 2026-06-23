# Level 4: Automated Agent Team

Use this level only after Level 3 works manually.

Add:

- recurring workflows (loops)
- security audits
- backup checks
- weekly reports
- optional direct gateway/API calls

Automation should follow the Agent Control Room, not replace it.

## Loops Live Here

A recurring workflow is only a loop if it has a goal, a verifier gate, a stop
condition, a maker/checker split, and a cost guardrail. A bare cron schedule is
not a loop. See `docs/loops.md` for the model and `templates/task-bus/loop-spec.md`
for the spec to fill in.

Plan loops with the `agent-team-cron-planner` skill.

### Worked Examples

- `loops/backup-verify.md` — nightly restore + checksum gate.
- `loops/vps-health.md` — disk / ports / units gate every 30 minutes.
- `loops/production-error-sweep.md` — root-cause fix + PR + green CI gate.
- `loops/loop-auditor.md` — weekly meta-loop scoring the loop portfolio.

For more proven patterns mapped to agents, see `docs/loop-library.md`.

### What Stays a Single Prompt

Not every recurring task should be a loop. If nothing can automatically reject
the output (a weekly SEO report, content planning — quality is a matter of
taste), keep it a single prompt or keep a human in the gate. Forcing a loop
where a prompt would do just burns tokens.
