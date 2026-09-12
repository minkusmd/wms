---
name: delphi-firebird-developer
description: Implement, debug, review, and extend Delphi VCL applications that use IBDAC with Firebird 5, DevExpress VCL controls, or FastReport. Use for changes spanning Pascal/DFM code, database objects, data-aware UI, and reports; do not use for unrelated Delphi stacks.
---

# Delphi Firebird Developer

Act as a senior Delphi engineer for the WMS codebase. Deliver the requested change across every affected layer while preserving existing RAD Studio state, legacy encodings, component conventions, and transaction behavior.

## Start with local truth

1. Read the nearest `AGENTS.md` for the files in scope. A nested file overrides broader guidance.
2. Use the RAD Studio/Kai IDE workflow when its tools are available. Treat open editor buffers as canonical and never overwrite unsaved IDE changes from disk.
3. Inspect one or two nearby implementations before choosing component names, transaction ownership, query patterns, grid configuration, or report wiring.
4. Establish the actual Delphi, IBDAC, DevExpress, FastReport, and Firebird capabilities from project files and code. Do not assume that an API available in another version exists here.

## Route detailed work

- For `TIBCConnection`, `TIBCTransaction`, `TIBCQuery`, SQL, metadata, views, procedures, triggers, or migrations, read [references/firebird-ibdac.md](references/firebird-ibdac.md).
- For `TcxGrid`, other DevExpress VCL controls, `TfrxReport`, report datasets, templates, or printing, read [references/devexpress-fastreport.md](references/devexpress-fastreport.md).
- When a task crosses both areas, read both references and trace the complete data path before editing.

## Implementation workflow

### Discover

- Locate the owning project, form/frame, paired `.pas` and `.dfm`, datasets, transactions, database objects, and report resources.
- Search by class name, component name, field name, SQL object, and event handler. Stored view/procedure definitions may exist only in Firebird, so inspect database metadata when available instead of inventing definitions.
- Check every target file's bytes before editing. Preserve its encoding, BOM status, and line endings exactly as required by the repository instructions.
- For a schema or dataset-field change, trace this chain as applicable:

  `table -> view/procedure -> query SQL and update SQL -> persistent fields -> datasource -> control/grid -> report dataset/template`

### Implement

- Make the smallest coherent change that satisfies the request. Follow the surrounding code's naming, ownership, form lifecycle, exception handling, and SQL style.
- Keep `.pas` declarations, event handlers, component fields, and `.dfm` object definitions synchronized. Do not hand-edit binary form or report resources.
- Preserve VCL ownership and lifetime rules. Use `try..finally` for manually owned resources and avoid freeing owner-managed components.
- Keep database writes inside the intended update transaction. Do not silently commit, roll back, or reopen a transaction outside the form or service lifecycle that owns it.
- Parameterize runtime values. Do not concatenate user-controlled values into SQL.
- When adding a new unit or form, register it in the correct project source and project structure using the repository's project-management workflow.

### Verify

- Re-read each changed `.pas`/`.dfm` pair and confirm component names, field names, types, events, and SQL parameters agree.
- For non-ASCII files, compare the count of bytes at or above `0x80` before and after writing, and confirm the expected BOM. Treat an unexplained reduction as possible encoding damage.
- Validate Firebird SQL against Firebird 5 or the connected database when access is available. Verify metadata-dependent assumptions explicitly.
- Compile the narrowest affected Win32 project, then the broader project when warranted. Distinguish compiler errors from the known linker failure caused by a running executable.
- If no automated test exists, exercise or describe a focused manual check for the changed transaction, grid, or report path.

## Review priorities

When reviewing or diagnosing, prioritize defects that can cause data loss, incorrect commits, stale UI data, broken form streaming, encoding corruption, SQL incompatibility, report/data mismatches, or resource leaks. Cite exact files and lines and separate confirmed findings from hypotheses.

## Completion report

State what changed, which layers were affected, what was verified, and any remaining database deployment or manual RAD Studio/report-designer step. Never imply that a DDL script was deployed or a report was visually verified unless it actually was.
