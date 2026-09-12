# DevExpress VCL and FastReport Playbook

Read this reference for data-aware UI, grids, editors, report data, templates, preview, export, or printing work.

## DevExpress VCL

- Identify the actual view class (`TcxGridDBTableView`, banded view, card view, tree list, and so on), its `DataController.DataSource`, repository items, styles, and layout persistence before editing.
- Keep persistent dataset fields, grid column `DataBinding.FieldName`, editor `DataBinding.DataField`, lookup keys, display fields, summaries, sorting, grouping, and filters aligned.
- Prefer the project's existing repository items and style controllers over creating nearly identical component-local configuration.
- Wrap bulk runtime grid changes in the component's supported `BeginUpdate`/`EndUpdate` pattern and restore state in `finally`.
- Preserve user layout and column settings. A newly added column may require an explicit default position without resetting saved layouts.
- Put business validation in the dataset/domain layer when it must hold outside one editor. Use UI events for interaction behavior, presentation, and immediate feedback.
- Check event signatures against the installed DevExpress version and nearby code. Do not invent an event or property based on another release.
- For data-aware controls, reason about dataset states (`dsBrowse`, `dsEdit`, `dsInsert`), posting, cancellation, focus changes, and validation order.

## FastReport VCL

- Determine whether the report is embedded in a `TfrxReport`, loaded from an `.fr3`, generated in code, or retrieved from storage. Preserve that ownership and loading model.
- Trace every report source: Delphi dataset -> `TfrxDBDataset` -> report `DataSet`/`DataSetName` or `UserName` -> band/object expressions.
- Keep aliases and field names stable unless every expression, variable, script, grouping, sort, and total that consumes them is updated.
- Set parameters and variables before report preparation. Open required datasets within the established transaction and close only datasets owned by the current operation.
- Inspect report script language and installed FastReport version before changing script syntax or component properties.
- Preserve two-pass, pagination, grouping, aggregate, and page-total behavior. Changes to visibility or band height can alter pagination even when the data is correct.
- Validate printer and export assumptions separately. Preview success does not prove direct printing, PDF export, fonts, images, or barcode output are correct.
- Do not rewrite binary report artifacts. For text `.fr3` files, preserve encoding and use the report designer for changes that are unsafe to make textually.

## UI and report verification

- Open, insert, edit, post, cancel, refresh, and reopen the affected dataset path.
- Check empty, one-row, multi-row, null, long-text, and large-result cases relevant to the change.
- Verify sorting, filtering, grouping, summaries, lookup display, keyboard navigation, and saved layout behavior for affected controls.
- Preview the report and inspect page breaks, repeated headers, totals, locale-sensitive dates/numbers, fonts, images, and blank pages.
- Exercise the requested print/export route when available; otherwise state precisely which visual or device-specific behavior remains unverified.
