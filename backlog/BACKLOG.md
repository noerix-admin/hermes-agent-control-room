# Control Room Backlog

Single source of truth for fleet work that has not been dispatched yet.

See `docs/backlog.md` for the concept, status flow, and how items move to the
task bus. Use `templates/backlog/backlog-item.md` for items that need detail.

Never put raw secrets in this file. Reference `env-map.md` entries by name.

## Active

| ID | Title | Agent | Priority | Size | Status | Depends on | Task ID |
|---|---|---|---|---|---|---|---|
| BL-2026-08-30-001 | Register the first Hermes agent in `agents/` | hermes-ops | high | M | ready | — | — |
| BL-2026-08-30-002 | Fill in `env-map.md` secret names for the first agent | hermes-ops | high | S | ready | BL-2026-08-30-001 | — |
| BL-2026-08-30-003 | Write the recovery runbook for the first agent | hermes-ops | normal | M | idea | BL-2026-08-30-001 | — |

## Done

| ID | Title | Agent | Completed | Task ID |
|---|---|---|---|---|
| — | — | — | — | — |

## Dropped

| ID | Title | Reason | Decided |
|---|---|---|---|
| — | — | — | — |
