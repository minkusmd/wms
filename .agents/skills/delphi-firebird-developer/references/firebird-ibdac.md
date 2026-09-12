# Firebird 5 and IBDAC Playbook

Read this reference for database access, schema, query, transaction, stored-object, or concurrency work.

## Inspect before changing

- Identify the exact connection and transaction components used by every affected dataset. Do not infer write ownership from a component's name alone; inspect the `.dfm` properties and lifecycle code.
- Read `SQL`, `SQLInsert`, `SQLUpdate`, `SQLDelete`, `SQLRefresh`, parameter declarations, persistent fields, `MasterSource`, and master/detail parameter mappings together.
- Query Firebird system metadata for objects whose definitions are absent from the repository. Relevant sources include `RDB$VIEW_SOURCE`, `RDB$PROCEDURE_SOURCE`, relation fields, triggers, indices, dependencies, and privileges.
- Confirm identifier casing, dialect, character set, collation, nullability, domains, computed fields, and trigger-generated values before generating SQL.

## IBDAC rules

- Reuse established `TIBCConnection`, read transaction, and update transaction components. Avoid creating a second connection or transaction when the surrounding form/data module already owns the unit of work.
- Respect the owner's transaction lifecycle: start in preparation code, post pending datasets before commit, and cancel/rollback on cancellation when that is the local pattern.
- Do not call `Commit` from a helper that participates in a larger user operation. Let the owning form, service task, or data module define the atomic boundary.
- Use typed parameters and assign null intentionally. Verify parameter names and types on every SQL statement, including update and refresh SQL.
- After insert/update, refresh generated keys and trigger-computed values through the project's established `RETURNING`, refresh SQL, or requery pattern.
- Preserve master/detail behavior, cached updates, update-table mappings, key fields, and optimistic-locking predicates.
- Close or disable controls only when necessary, and restore state in `finally`. Preserve bookmarks only when the dataset supports them safely.

## Firebird 5 rules

- Use Firebird syntax supported by the connected server and the project's SQL dialect. Avoid syntax copied from PostgreSQL, SQL Server, or newer/older Firebird versions without verification.
- Keep client-entered values in parameters. Dynamic SQL is reserved for identifiers or structural choices and must be narrowly validated.
- Model `NULL` explicitly. Use `IS NULL`, `IS NOT NULL`, `COALESCE`, or null-safe comparison where the intended semantics require them.
- Consider Firebird's transaction isolation, record versioning, lock conflicts, and long-running read transactions when diagnosing stale data or concurrency failures.
- Treat views used for editing as contracts. A new writable field may require changes to the base table, view, triggers, privileges, IBDAC update SQL, persistent fields, and refresh SQL.
- Treat selectable stored procedures as result-set contracts. Adding an output requires both the procedure definition and every outer select/query consumer to remain compatible.
- Write repository DDL migrations to be safely repeatable when local conventions require it. Check metadata before adding or altering objects, and document operations that cannot be made idempotent safely.
- Do not change production data or deploy schema changes without explicit authorization. Preparing a migration script does not authorize executing it.

## Database change checklist

- Base table/domain and null/default semantics
- Primary, unique, foreign-key, and index impact
- View/procedure/trigger definitions and dependencies
- Grants for application users and services
- Dataset SQL plus update/refresh SQL
- Persistent Delphi fields and parameter types
- Master/detail and transaction behavior
- DevExpress editors/grids and FastReport consumers
- Repeatability, rollback expectations, and deployment notes
