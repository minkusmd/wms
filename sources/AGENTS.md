# Repository Guidelines

## Project Structure and Modules

This repository contains the WMS/SWN ERP suite, built with Delphi VCL and
Firebird/InterBase. The main Win32 application is in `sources/` (`SWN.dpr` and
`SWN.dproj`). Business logic is grouped under `classes/`; document UI frames
are in `frames/`; document-specific dialogs live in `frameUtils/`. Reports,
security, fiscal-printer, and SOAP code have dedicated subdirectories.

Companion applications are `DB Service/`, `DB Service Manager/`, and
`WmsUpdater/`. Database-model assets are under `DB Model/`; installer files
are under `Install/`. The `fantastic.web/` directory is a separate PHP project
with its own repository guidance.

## Build and Development

Build with RAD Studio/MSBuild for Win32 Release:

```bat
msbuild "wms project.groupproj"
msbuild SWN.dproj /p:Config=Release /p:Platform=Win32
```

Run `SWN.exe` from `../exe/` after a successful build. There is no automated
test suite; compile the affected project and exercise the changed form or
workflow manually. If the executable is running, a linker lock can occur even
when compilation succeeds.

## Coding Style and Safety

Use Object Pascal conventions already present in the unit: `T` for classes,
`frm` for forms, `frame` for frames, and `dm` for data modules. Keep paired
`.pas` and `.dfm` files synchronized. Preserve CRLF line endings.

Source encodings are mixed. Before changing a non-ASCII file, determine
whether it is UTF-8 with BOM or Windows-1251, preserve that encoding, and
compare non-ASCII byte counts before and after saving. New source files should
remain ASCII where practical; put DFM Cyrillic captions in `#NNNN` escapes.

## Database Changes

Place schema changes in `DB Model/` as repeatable Firebird SQL. A new editable
view field usually requires matching base-table, view, and DFM `SQLInsert` /
`SQLUpdate` changes. Coordinate execution of DDL with the DBA.

## Commits and Pull Requests

Use concise, imperative commit subjects; the existing history uses styles such
as `chore: ...` and short feature descriptions. Keep commits focused. Pull
requests should describe the user-visible change, list database scripts and
manual verification, link the work item when available, and include screenshots
for changed VCL dialogs.
