# Agent Loops

A loop is a recurring workflow where an agent works toward a goal, checks its
own result against a hard gate, and repeats until the goal is met or a stop
condition fires.

Loops live at **Level 4**. Do not build one until the same workflow runs
reliably by hand. Automating an unproven workflow is how loops run all night
and produce nothing.

## Loop vs Single Prompt

A prompt produces one answer and waits for you. A loop runs the full cycle on
its own:

```text
Discover -> Plan -> Execute -> Verify -> Iterate
```

The three steps that decide whether a loop helps or wastes money:

- **Verify** is the heart. Without a real check, the agent grades its own
  homework and the model that did the work is a generous grader.
- **State** is what makes it learn. Each pass records what was tried, what
  failed, and what is next, so the next run resumes instead of restarting.
- **Stop** is what keeps it sane. Two exits only: success, or a hard limit.

## Should This Be a Loop?

Build a loop only when **all four** are true:

1. The task repeats, at least weekly.
2. Something can automatically reject bad output (test, build, linter, scan,
   measurable condition).
3. The agent can do it end to end, not hand half of it back.
4. "Done" is objective, not a matter of taste.

Miss one, keep it a single prompt or a human-gated review.

| Workflow                   | Auto-verifiable?         | Verdict             |
| -------------------------- | ------------------------ | ------------------- |
| nightly backup verification| yes (restore + checksum) | loop                |
| daily VPS health check     | yes (ports, disk, units) | loop                |
| monthly security audit     | partly (scan yes)        | loop + human gate   |
| weekly SEO report          | no (quality = taste)     | single prompt       |
| weekly content planning    | no                       | single prompt       |

Ops and infrastructure work loops well because it is hard-verifiable.
Creative and judgement work stays a prompt or keeps a human in the gate.

## The Four Primitives

Every Control Room loop must define these. A cron schedule alone is not a loop.

### 1. Verifier (the gate)

A hard check that can fail the work, owned by something other than the maker.
Prefer machine checks: exit code, test result, checksum, port state, HTTP
status, a measurable threshold. If no check can fail the work, the loop just
spins — do not build it.

See [Verifier Patterns](#verifier-patterns) below.

### 2. Stop Condition

Two exits, both mandatory:

- **Success:** verifier passes.
- **Hard limit:** max iterations reached, or token/time budget exhausted.

`ON STOP` always reports what changed and what still fails. A loop with only a
success exit is the Ralph Wiggum loop: it runs until it succeeds, breaks, or
drains the account.

### 3. Maker / Checker Split

The agent that does the work must not be the only judge of it. Use the task
bus: the **maker** writes a result to its outbox; a separate **checker**
(different instructions, often a stronger model on higher effort) reads it and
runs the verifier. Maker fast and cheap, checker slow and strict. That
separation is most of the quality.

In this Control Room the orchestrator is the natural checker, or a dedicated
`hermes-ops` reviewer for infra loops.

### 4. Cost Guardrail

Loops re-send context every pass, and it grows each pass. Two models double it.

- Set a **token/iteration budget** per run.
- Track the metric that matters: **cost per accepted change**, not tokens
  spent or loops run.
- Below a ~50% accept rate the loop costs more than it gives back — fix the
  verifier or kill the loop.
- Put cheap models on the boring steps, the strong model only on the checker.

## Verifier Patterns

Reusable gates for common Control Room loops.

```text
backup verification
  gate: restore latest backup to a scratch path,
        compare checksum + file count to source,
        assert age < 24h
  fail: checksum mismatch, missing files, stale backup

vps health
  gate: all expected systemd units active,
        disk usage < threshold,
        each dashboard/gateway port responds,
        no container in restart loop
  fail: unit inactive, disk over threshold, port dead

security audit
  gate (machine): no unexpected open ports,
        no .env committed, no raw secrets matched by scan,
        token rotation dates not expired
  human gate: a person signs off on severity before any change

deploy / code loop
  gate: tests green + lint clean + type check clean + build passes
  fail: any non-zero exit
```

## Build Order

The order matters more than the tooling. Skipping ahead is how loops blow up
while you sleep.

```text
1. Run it manually until reliable.
2. Save the instructions as a skill.
3. Wrap the skill in a loop (add the gate and the stop condition).
4. Put it on a schedule (cron / GitHub Actions).
```

## Where Loops Live in This Repo

- Plan a loop with the `agent-team-cron-planner` skill.
- Write the spec from `templates/task-bus/loop-spec.md`.
- Run it through the task bus (`docs/task-bus.md`) for the maker/checker split.
- Worked examples: `examples/level-4-automated-team/loops/`.
- Proven loop patterns mapped to agents: `docs/loop-library.md`.
