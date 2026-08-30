# Central Backlog

The backlog is the Control Room's single, shared list of work that has not
been dispatched yet. It is the planning surface for the whole agent fleet.

It lives in the Control Room on purpose.

```text
Control Room  = what the fleet SHOULD do and what it IS   (registry, docs, backlog)
Task Bus      = work in flight right now                  (inbox, working, outbox)
Agent memory  = one agent's private runtime state         (rimax / KImemory / noerix-os)
```

## Why It Lives Here, Not In An Agent Memory Repo

A backlog is fleet-level governance, so it belongs in the control plane, not
inside a single agent's runtime memory.

- The Control Room is already the registry and runbook library. The backlog is
  the same kind of durable, human-owned truth.
- Agent memory repos are per-agent runtime state. Storing the shared backlog in
  one of them couples fleet planning to one agent's lifecycle: rebuild or reset
  that agent and the roadmap goes with it.
- Any agent, orchestrator, or operator can already read the Control Room. That
  is exactly the audience a central backlog needs.

Keep the split clean: the backlog records intent, the task bus runs it, agent
memory holds only what a single agent needs at runtime.

## Where It Lives

```text
backlog/
  BACKLOG.md          living list of items
templates/backlog/
  backlog-item.md     template for a detailed item
```

Lightweight items can live as a single row in `backlog/BACKLOG.md`. When an item
needs real detail, copy the template into a per-item file next to `BACKLOG.md`
and link it from the row.

## Status Flow

```text
idea -> ready -> dispatched -> done
                   |
                   +-> blocked (waiting on a dependency or decision)
                   +-> dropped (decided not to do)
```

| Status | Meaning |
|---|---|
| `idea` | Captured, not yet refined or committed to. |
| `ready` | Refined, has a definition of done, safe to pick up. |
| `dispatched` | Handed to the task bus; `dispatched_task_id` points at the task. |
| `blocked` | Waiting on a dependency, approval, or decision. |
| `done` | Delivered and verified. |
| `dropped` | Consciously not doing. Keep the row for the record. |

## Fields

- `item_id` — stable id, `BL-YYYY-MM-DD-NNN`. Never reused.
- `priority` — `low` / `normal` / `high` / `urgent`.
- `size` — rough effort: `S` / `M` / `L` / `XL`.
- `agent` — the agent slug expected to do the work, or `unassigned`.
- `depends_on` — item ids that must finish first.
- `dispatched_task_id` — the task-bus `task_id` once dispatched.

## From Backlog To Task Bus

The backlog is upstream of the task bus. Refining and dispatching is a handoff,
not a copy of everything.

```text
1. Capture the item in backlog/BACKLOG.md as `idea`.
2. Refine it: fill in a definition of done, set priority and size -> `ready`.
3. When it is time to run it, create a task file from
   templates/task-bus/task-template.md in the target agent's inbox.
4. Set the item to `dispatched` and record the task_id in dispatched_task_id.
5. When the task bus reports the result as done, set the item to `done`.
```

This keeps one clear line: the backlog is why, the task bus is now, and every
dispatched item can be traced from intent to the task that delivered it.

## Rules

- One backlog. Do not fork per-agent backlogs; assign items with the `agent`
  field instead.
- Never paste secrets. Reference `env-map.md` entries by name.
- Do not delete `done` or `dropped` rows. The backlog is also a record of what
  the fleet chose to do and chose not to do.
