# AGENTS.md

This file provides guidance to Codex (Codex.ai/code) when working with code in this repository.

## Project Overview

**WMS** (внутреннее имя `SWN`) — корпоративная **ERP**-система от NEURON Grup SRL: закупки, продажи, фискальная часть (накладные, чеки), банк и касса, прайс-листы, складской учёт. Написана на Delphi (Object Pascal), использует VCL и базу данных InterBase/Firebird. Версия 5.5.x. Это back-office; та же база Firebird обслуживает и витрину интернет-магазина fantastic.md (см. `fantastic.web/` ниже).

Система состоит из четырёх исполняемых файлов (`sources/`, `DB Service/`, `DB Service Manager/`, `WmsUpdater/`), объединённых в группу `wms project.groupproj`.

## Кодировка исходников (критично при редактировании)

Кодировка в репозитории **смешанная** — единого правила «всё cp1251» нет. Перед правкой **каждого** файла определи его кодировку по байтам; выбор не той кодировки при записи тихо портит файл целиком.

**Три категории:**

| Признак | Кодировка | Как править |
|---|---|---|
| BOM `EF BB BF` в начале | **UTF-8 с BOM** | PowerShell + `New-Object System.Text.UTF8Encoding($true)` |
| Есть байты ≥ 0x80, BOM нет | **ANSI Windows-1251** | PowerShell + `[System.Text.Encoding]::GetEncoding(1251)` |
| Нет байтов ≥ 0x80 | **чистый ASCII** | обычные Edit/Write безопасны |

Примеры: cp1251 — `sources/SWN.dpr`, `frmGoodsEditorDlg.pas` и большинство legacy-юнитов с русскими комментариями (иногда кириллица встречается прямо в идентификаторах Pascal и в путях секции `uses`, напр. `frmОстаткиТовараDocDialog`). UTF-8 с BOM — файлы, тронутые недавно, напр. `sources/classes/Goods/frmContentGoodsEditorDialog.pas` (румынские комментарии с диакритикой + идентификатор `cSecurityFlag_Website_Фильтры_...`). Все `.md` в корне (`CLAUDE.md`, `AGENTS.md`) — UTF-8 без BOM, LF.

**Чем именно ломается:**

- Edit/Write пишут UTF-8 без BOM → **кириллица cp1251-файла превращается в U+FFFD** (так был испорчен `SWN.dpr` 2026-07-04).
- Запись UTF-8-файла через `GetEncoding(1251)` конвертирует его в cp1251 **без ошибки**: `ă/â/î` → `a/a/i` (best-fit), `ș/ț` → `?`, кириллица ужимается с 2 байт до 1, BOM исчезает — и Delphi потом читает файл как ANSI (так был испорчен `frmContentGoodsEditorDialog.pas` 2026-08-07).

**Проверка (обязательна для файлов с не-ASCII):** посчитай байты ≥ 0x80 **до** и **после** записи. Уменьшение = порча; чинить из `__history/<файл>.~N~` (бэкапы RAD Studio, но могут быть многомесячной давности).

**Прочее:**

- **Новые** файлы держи в ASCII (без кириллицы — используй румынский без диакритики), тогда обычный Write безопасен.
- В `.dfm` кириллицу в caption'ах записывай escape-кодами `#NNNN` (ASCII-безопасно), а не сырыми байтами; существующие `.dfm` на практике почти все чистый ASCII.
- Сохраняй `\r\n` в `.pas` / `.dfm` / `.dpr`.
- Осторожно с якорями для замен: в части legacy-файлов **смешанные отступы** (4 и 6 пробелов в одном файле).

## Build System

Сборка через Embarcadero RAD Studio (Delphi). Компилятор: DCC32. Формат проектов: MSBuild (`.dproj`).

**Платформа/конфигурация:** все четыре проекта собираются под **Win32** (конфигурация по умолчанию — `Release`). Явно задать параметры: `msbuild sources/SWN.dproj /p:Config=Release /p:Platform=Win32`.

Автоматических тестов нет.

**Сборка из bash-инструмента** (пути с пробелами) — через временный `.bat`, который вызывает `rsvars.bat` и `msbuild`:
```bat
call "C:\Program Files (x86)\Embarcadero\Studio\37.0\bin\rsvars.bat"
cd /d "D:\Projects\MyProjects\WMS\sources"
msbuild SWN.dproj /p:Config=Release /p:Platform=Win32
```

**Подводные камни:**
- Если `SWN.exe` **запущен**, сборка падает на линковке с **F2039** (`Cannot open exe`), но **компиляция проходит** — полезно для быстрой проверки синтаксиса без закрытия приложения.
- Новые формы/юниты **не подхватываются автоматически** — их нужно вручную добавить в секцию `uses` файла `SWN.dpr` (иначе не попадут в сборку).
- Проверяй свежесть по времени модификации `../dcu/<Unit>.dcu` и `../exe/SWN.exe` — билд инкрементальный.

## Applications

`Parsers/WMSParsers.dpr` (`WMSParsers.exe`) — парсеры поставщиков и импорт прайс-листов по API; отдельный проект, в `wms project.groupproj` **не входит**. Детали — `Parsers/AGENTS.md`.

`PriceWatch/WMSPriceWatch.dpr` (`WMSPriceWatch.exe`) — круглосуточный мониторинг цен конкурентов (xstore.md, neocomputer.md, geek.md — список и regex-ы парсинга в `TWEB_COMPETITOR_SITES`), сопоставление с нашими товарами, Excel + Telegram раз в 3 часа; отдельный проект на общих библиотеках (DevExpress, IBDAC, `SWNConst`, `TelegramApiUnit`), схема — `DB Model/competitor_prices.sql`. Детали — `PriceWatch/AGENTS.md`.

`PriceImport/` — сервис на **Python** (не Delphi): автоматический импорт прайс-листов поставщиков в окна 09–10 и 15–16, сравнение с `TS_GOODS_FOREIGN` (повторяет 4 переоценки WMS), пороги с карантином, отчёт в Telegram (`PRICELIST_IMPORT`). Этапы: 1 — dry-run, 2 — применение через документы 1414 (по умолчанию выключено), 3 — Telegram-бот `pi bot` для Excel поставщиков без API. Схема — `DB Model/price_import_stage1..3.sql`, план — `Documents/plan-import-automat-pricelisturi-2026-10-27.md`. Детали — `PriceImport/AGENTS.md`.

## Architecture

### Основное приложение (`sources/`)

- `sources/FiscalPrinter/` — фискальные устройства за общим интерфейсом `IFiscalDevice` (`FiscalDeviceUnit.pas`, чек целиком): MCC Tremol только через сервер ZFPLab (`TremolFiscalDevice.pas`, не через `zfpcom.dll`) и облачная касса ECC Fiscal Partner (`FiscalPrinter/ECC/`, REST + журнал `TFP_ECC_TRANSACTION`). Устройство выбирается по `FP_DEVICES` (фирма + компьютер), тип — `FP_DEVICES.DEVICE_TYPE` (0 Tremol, 1 ECC).

### Жизненный цикл форм/диалогов (`SWNBaseUnit.pas`)

Диалоги наследуются от базовых классов и переопределяют виртуальные методы вместо прямой работы с `TForm`:

- `TSWNCustomForm` — база всех форм. Переопределяемые: `Prepare` (инициализация/открытие запросов, старт транзакции), `IsFormDataPosted: Boolean` (валидация + `Post`/`Commit`; вернуть `False` — форма не закроется по OK), `WhenCancelForm` (`Cancel`/`Rollback`).
- `TSWNMasteredFormClass` (через `TSWNBaseFormClass`) — редакторы записей. Конструктор `Create(AOwner, MasterDataSet, MasterDataSource)`; поля `fMasterDataSet`/`fMasterDataSource`; переопределяемый `BindingDataSource` (привязка DB-контролов к `fMasterDataSource`). Запись идёт в `fMasterDataSet.UpdateTransaction` — «Renunță» откатывает всё разом.

Типовой менеджер-справочник: своя `IBCTransactionUpdate`, в `Prepare` — `StartTransaction` + открытие запросов, в `IsFormDataPosted` — `Post` активных датасетов + `Commit`, в `WhenCancelForm` — `Rollback`. Grid'ы — DevExpress cxGrid поверх `IBCDataSource`; master-detail через `MasterSource` + одноимённый параметр.

### База данных

- **DDL-скрипты:** `DB Model/*.sql` — правки схемы, которые **вручную** прогоняет DBA на базе (пиши их повторно-запускаемыми: проверка через `RDB$RELATION_FIELDS`, `EXECUTE BLOCK`). Определения многих объектов (updatable-view `VW_*`, процедуры `SP_*` / `WEB_*`) **живут только в БД**, в репозитории их нет — читай через `RDB$VIEW_SOURCE` / `RDB$PROCEDURE_SOURCE`.
- **Editable views:** формы часто пишут не в таблицу, а в updatable-view `VW_*` (напр. `VW_TS_GOODS`, `VW_TWEB_CATALOG`) — SQL `SQLInsert`/`SQLUpdate` заданы прямо в `.dfm`. При добавлении колонки её нужно провести и в базовую таблицу, и в view, и в эти `SQLInsert`/`SQLUpdate`.
- **Grid-браузеры** нередко берут данные из процедур (`SELECT A.* FROM SP_GET_...(:params) A`) — вычисляемые поля добавляются во внешний `SELECT`.

### Приложения-спутники (`DB Service`, `DB Service Manager`, `WmsUpdater`)

Три вспомогательных проекта — самостоятельные приложения со своими юнитами (не разделяют код с `sources/`; одноимённые файлы вроде `TaskClass.pas` дублируются в каждом проекте).

- **`SWNService`** выполняет задачи по расписанию (хранимые процедуры и Delphi-джобы `@...`) и отправляет очередь Telegram; любая процедура ставит сообщение через `SP_TELEGRAM_SEND('ERRORS', ...)`. Детали — `DB Service/AGENTS.md`.

### Внешние интеграции

- **MIA Victoriabank** — мгновенные платежи по QR для заказов с сайта. Всё общение с банком — на стороне сайта (`fantastic.web`, см. его CLAUDE.md); WMS только читает состояние и просит через процедуры `WEB_MIA_VB_*` (`DB Model/mia_vb_payments.sql`): `sources/classes/WebMia/` (колонка «Plata MIA» и окно «Plata MIA…» во фрейме 24 — ссылка на оплату, SMS, возврат). Фискализация — `@ECC_ONLINE` через view `VW_WEB_MIA_PAYMENTS`. План и состояние: `Documents/plan-integrare-mia-victoriabank-2026-10-06.md`

## Other Directories

- `fantastic.web/` — **отдельный проект** (свой `.git`, свой `AGENTS.md`): сайт **fantastic.md** — интернет-магазин на Yii2/PHP. Работает с **той же базой Firebird** (`SW`), что и WMS; со стороны WMS его питают `sources/classes/WebShops/`, `WebCatalog/` и views `VW_TWEB_*`. Внутри этой папки следуй её собственному `AGENTS.md`, а не Delphi-инструкциям (в т.ч. правило кодировки cp1251 к PHP не относится).
- `CurieriWMS/` — **отдельный проект** (свой `.git`, свой `AGENTS.md`; PHP/composer/artisan только в Docker — локальный PHP 8.5 в `C:\php` принадлежит fantastic.web): веб-приложение водителей/курьеров для телефона (PHP/Laravel + Livewire 4 + Alpine.js, Docker Compose) — маршрут, забор у поставщиков, доставка клиенту. Работает с той же базой Firebird `SW`; диспетчер остаётся в WMS (Delphi). Исходники PHP — UTF-8, правило cp1251 к ним не относится. План: `Documents/plan-dispecerat-achizitii-livrari-2026-10-08.md` (§9A).
- `WmsWeb/` — веб-приложение **Laravel 13 / PHP 8.5**, только в Docker (`compose.yaml`: app + Nginx на :8090 + тестовая Firebird 5 на 127.0.0.1:3052); драйверы Firebird — `pdo_firebird`, `interbase` (`ibase_*`) и Eloquent `harrygulliford/laravel-firebird`, подключение `firebird` берёт `FB_*` из `.env`. Лежит в репозитории WMS (своего `.git` нет). Исходники PHP — UTF-8. Детали — `WmsWeb/CLAUDE.md`.

## Парный файл CLAUDE.md

В корне лежит `CLAUDE.md` (инструкции для Claude Code) — идентичная копия этого файла. При существенных правках архитектуры/сборки синхронизируй оба, чтобы они не расходились.
