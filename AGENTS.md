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

**Групповой проект:** `wms project.groupproj` — собирает все четыре компонента.

**Запуск сборки из командной строки (MSBuild):**
```
msbuild "wms project.groupproj"
msbuild sources/SWN.dproj
msbuild "DB Service/SWNService.dproj"
msbuild "DB Service Manager/SWNServiceManager.dproj"
msbuild WmsUpdater/SWNUpdater.dproj
```

**Платформа/конфигурация:** все четыре проекта собираются под **Win32** (конфигурация по умолчанию — `Release`). Явно задать параметры: `msbuild sources/SWN.dproj /p:Config=Release /p:Platform=Win32`.

**Настройки сборки:**
- `swm configuration.optset` — основные настройки
- `My release.optset` — настройки release-сборки
- Выходные файлы: `../exe/` (исполняемые), `../dcu/` (скомпилированные unit-ы)

**Утилиты:**
- `dcu/~clear.bat` — очистка скомпилированных unit-ов
- `exe/~clear.bat` — очистка исполняемых файлов
- `DB Service/install service.bat` — установка SWNService как Windows-службы
- `DB Service/uninstall service.bat` — удаление службы

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

| Приложение | Проект | Назначение |
|---|---|---|
| `SWN.exe` | `sources/SWN.dpr` | Основное приложение WMS |
| `SWNService.exe` | `DB Service/SWNService.dpr` | Windows-служба для фоновых операций с БД |
| `SWNServiceManager.exe` | `DB Service Manager/SWNServiceManager.dpr` | UI для управления службой и задачами |
| `SWNUpdater.exe` | `WmsUpdater/SWNUpdater.dpr` | Автообновление приложения |
| `WMSParsers.exe` | `Parsers/WMSParsers.dpr` | Парсеры сайтов поставщиков: цены (h-t.md — 262735, maximum.md — 229873) и контент Maximum (картинки + характеристики → `TS_PRICELIST_ITEMS_IMAGES` / `_DESCRIPTION`); плюс **импорт прайс-листов по API** (Accent 198, DMLink 229466, Olis Grup 251465, NexDistribution 275640, Triomac 209280 — группа `/parser:pricelists`): новый прайс + 4 переоценки как в frame78 (`PriceListReevaluationUnit`, CLOSE_REEVALUARE) + картинки; задачи идут **параллельно**, каждая в своём TThread со своим соединением (`RunParserJobsParallel`), закрытия переоценок — по очереди; `/reevaluare:test` = переоценки с ROLLBACK. Окно + режим `/auto` для Task Scheduler (`install-pricelist-task.ps1`: 09:00 и 14:00). В конце каждого запуска (`RunParserJobsParallel` → `NotifyParserRun`) итог ценовых задач ставится в Telegram-канал `PRICELISTS` («Online :: Fantastic»), ошибки и подозрительные сайты — в `ERRORS` (через `SP_TELEGRAM_SEND`, отправляет SWNService; `/telegram:no` — отключить). Новая задача = наследник `TParserJob` (для цен — `TSupplierPriceSource` + `TSupplierPriceJob`) + строка в `ParserRunnerUnit.ParserJobs`. Фрейм 124 в WMS использует те же юниты из `Parsers/`. В `wms project.groupproj` не входит |

## Architecture

### Основное приложение (`sources/`)

**Точка входа:** `SWN.dpr` (`program SWN`) — **главное приложение проекта**. Огромная секция `uses` (~970 строк) регистрирует все формы, фреймы и диалоги (frames, frameUtils, classes, Print, FiscalPrinter, Updater). Блок инициализации подключает `madExcept`, VCL-темы/стили и создаёт `frmMainForm`.

**MDI-архитектура:** `TfrmMainForm` (MainForm.pas) — главное MDI-окно с навигацией через dxBar/dxNavBar.

**Слои:**

- `DataModuleDB.pas` (`TdmDB`) — главный модуль данных: подключение к InterBase через IBDAC, транзакции, query-объекты для всех основных сущностей.
- `DataModuleAdditions.pas` — дополнительный модуль данных.
- `sources/classes/` — бизнес-логика, разбитая по доменам (60+ папок): `Goods/`, `Customer/`, `Stocks/`, `Banks/`, `Currency/`, `PriceLists/`, `Export1C/`, и т.д.
- `sources/frames/` — 134+ VCL-фрейма для разных типов документов; базовый класс `SWNBaseFrameUnit.pas`.
- `sources/frameUtils/` — диалоговые утилиты для каждого типа документа (100+ папок, нумерованные по типу: `01 - Приходный кассовый ордер`, `09 - NAKLADNAIA`, и т.д.).
- `sources/Print/` — система отчётов и печати (`ReportFunctions.pas`, `frmPrintWizardDialog.pas`, `frmPrintEngineDialog.pas`).
- `sources/Security/` — аутентификация (`LoginDialog.pas`) и авторизация.
- `sources/FiscalPrinter/` — фискальные устройства за общим интерфейсом `IFiscalDevice` (`FiscalDeviceUnit.pas`, чек целиком): MCC Tremol только через сервер ZFPLab (`TremolFiscalDevice.pas`, не через `zfpcom.dll`) и облачная касса ECC Fiscal Partner (`FiscalPrinter/ECC/`, REST + журнал `TFP_ECC_TRANSACTION`). Устройство выбирается по `FP_DEVICES` (фирма + компьютер), тип — `FP_DEVICES.DEVICE_TYPE` (0 Tremol, 1 ECC).
- `sources/SOAP/` — веб-сервисы (интеграция с поставщиками).

### Жизненный цикл форм/диалогов (`SWNBaseUnit.pas`)

Диалоги наследуются от базовых классов и переопределяют виртуальные методы вместо прямой работы с `TForm`:

- `TSWNCustomForm` — база всех форм. Переопределяемые: `Prepare` (инициализация/открытие запросов, старт транзакции), `IsFormDataPosted: Boolean` (валидация + `Post`/`Commit`; вернуть `False` — форма не закроется по OK), `WhenCancelForm` (`Cancel`/`Rollback`).
- `TSWNMasteredFormClass` (через `TSWNBaseFormClass`) — редакторы записей. Конструктор `Create(AOwner, MasterDataSet, MasterDataSource)`; поля `fMasterDataSet`/`fMasterDataSource`; переопределяемый `BindingDataSource` (привязка DB-контролов к `fMasterDataSource`). Запись идёт в `fMasterDataSet.UpdateTransaction` — «Renunță» откатывает всё разом.

Типовой менеджер-справочник: своя `IBCTransactionUpdate`, в `Prepare` — `StartTransaction` + открытие запросов, в `IsFormDataPosted` — `Post` активных датасетов + `Commit`, в `WhenCancelForm` — `Rollback`. Grid'ы — DevExpress cxGrid поверх `IBCDataSource`; master-detail через `MasterSource` + одноимённый параметр.

### Типы документов

Система ориентирована на документооборот: 40+ типов документов, каждый со своим фреймом в `/frames/` и диалогами в `/frameUtils/`. Константы типов — в `SWNTypes.pas`.

### База данных

- **СУБД:** InterBase / Firebird, порт 3050
- **Доступ:** IBDAC-компоненты (`IBCConnection`, `IBCTransaction`, `IBCQuery`)
- **Транзакции:** `IBCTrDefaultSelect` / `IBCTrDefaultUpdate` — основные; для специфических операций — отдельные транзакции
- **Константы подключения:** `sources/SWNConst.pas`
- **DDL-скрипты:** `DB Model/*.sql` — правки схемы, которые **вручную** прогоняет DBA на базе (пиши их повторно-запускаемыми: проверка через `RDB$RELATION_FIELDS`, `EXECUTE BLOCK`). Определения многих объектов (updatable-view `VW_*`, процедуры `SP_*` / `WEB_*`) **живут только в БД**, в репозитории их нет — читай через `RDB$VIEW_SOURCE` / `RDB$PROCEDURE_SOURCE`.
- **Editable views:** формы часто пишут не в таблицу, а в updatable-view `VW_*` (напр. `VW_TS_GOODS`, `VW_TWEB_CATALOG`) — SQL `SQLInsert`/`SQLUpdate` заданы прямо в `.dfm`. При добавлении колонки её нужно провести и в базовую таблицу, и в view, и в эти `SQLInsert`/`SQLUpdate`.
- **Grid-браузеры** нередко берут данные из процедур (`SELECT A.* FROM SP_GET_...(:params) A`) — вычисляемые поля добавляются во внешний `SELECT`.

### Приложения-спутники (`DB Service`, `DB Service Manager`, `WmsUpdater`)

Три вспомогательных проекта — самостоятельные приложения со своими юнитами (не разделяют код с `sources/`; одноимённые файлы вроде `TaskClass.pas` дублируются в каждом проекте).

- **`SWNService`** (`ServiceMain.pas`) — `TServiceSWN = class(TService)`. По таймеру (`TTimerThread`) прогоняет коллекцию задач `TSWNServiceTaskCollection` и действий `TServiceActionCollection`. Задача (`TSWNServiceTask`) — это вызов **хранимой процедуры** (`StoredProcedure`) по расписанию: `CalendarTarget` (день/неделя/месяц) + `RunMode` (`trmExactTime` — в конкретное время / `trmInterval` — с интервалом). Если имя процедуры начинается с `@`, вместо процедуры выполняется Delphi-джоб из `DB Service\ServiceJobsUnit.pas` на том же соединении (сейчас `@ECC_ONLINE` — `ECCOnlineFiscalUnit.pas`, фискализация онлайн-оплат на кассе ECC); лог джоба — `<рабочая папка>\<имя>.log`. Параллельно работает постоянный поток `TSWNTelegramService` (`DB Service\TelegramServiceUnit.pas`): `TIBCAlerter` (`EventHandler = ehNativeAlerter`) слушает `NEW_TELEGRAM` и отправляет очередь `TELEGRAM_MESSAGES` в Telegram (каналы `TELEGRAM_CHANNELS`, токен — `TS_API_CONFIG` / `TELEGRAM`); любая процедура ставит сообщение через `SP_TELEGRAM_SEND('ERRORS', ...)`; лог — `telegram.log`; DDL — `DB Model/telegram_messages.sql`.
- **`SWNServiceManager`** (`frmMain.pas`, `TaskConfigDialog.pas`) — UI для настройки этих задач и параметров подключения к БД (`SetupConnectionDialog`, `SelectDBUserDialog`). Конфиг службы хранится в файле настроек (`DB Service Managersettings.dat` в корне репозитория).
- **`SWNUpdater`** (`Main.pas`, `SwnUpdaterTools.pas`, `SWNValueStorageUnit.pas`) — автообновление `SWN.exe`.

### Ключевые сторонние библиотеки

- **DevExpress:** cxGrid, cxTreeList, cxScheduler, dxBar, dxNavBar, cxEdit
- **IBDAC:** доступ к InterBase/Firebird
- **Raize Components:** UI-компоненты
- **Indy:** HTTP/TCP (IdHttp, IdTCPClient)
- **madExcept:** обработка исключений
- **ZFPCOM:** фискальные принтеры

### Внешние интеграции

- **1C ERP** (`sources/classes/Export1C/`)
- **Фискальные устройства**: MCC Tremol (ZFPLab) и ECC Fiscal Partner (`sources/FiscalPrinter/`)
- **MAIB** — платёжная система (`sources/classes/Banks/`)
- **ЕЦБ** — курсы валют
- **B2B API / SOAP** — поставщики
- **Веб-магазины** (`sources/classes/WebShops/`, `WebCatalog/`)
- **MIA Victoriabank** — мгновенные платежи по QR для заказов с сайта. Всё общение с банком — на стороне сайта (`fantastic.web`, см. его CLAUDE.md); WMS только читает состояние и просит через процедуры `WEB_MIA_VB_*` (`DB Model/mia_vb_payments.sql`): `sources/classes/WebMia/` (колонка «Plata MIA» и окно «Plata MIA…» во фрейме 24 — ссылка на оплату, SMS, возврат). Фискализация — `@ECC_ONLINE` через view `VW_WEB_MIA_PAYMENTS`. План и состояние: `Documents/plan-integrare-mia-victoriabank-2026-10-06.md`

## Key Conventions

- Формы: префикс `frm*` (например, `frmMainForm`)
- Фреймы: префикс `frame*`
- Модули данных: префикс `dm*` или `DataModule*`
- Классы сущностей: суффикс `Info` или `Class` (например, `TGoodsInfo`, `TFirmaInfo`)
- Файлы форм: `.dfm` (парные к `.pas`)

## Installer

NSIS-скрипт: `Install/SWN_Install.nsi`. Устанавливает в `Program Files\1C STOCK`, регистрирует `zfpcom.dll`.

## Other Directories

- `DB Model/` — схема базы данных (Erwin `.DM1` файлы)
- `DB Backup/` — backup инкрементальный через nbackup (L0 неделя / L1 день / L2 час / L3 15 мин, без блокировки базы): `nbackup-sw.ps1` (Task Scheduler на сервере БД, каждые 15 мин), `nbackup-sw-restore.ps1`, `install-nbackup-task.ps1`; см. README там же
- `Consts/` — константы и конфигурационные файлы
- `Reports/` — определения отчётов
- `WebProjects/` — шаблоны и ресурсы для веб
- `Documents/` — пользовательская документация
- `XML/` — XML-конфигурация и данные
- `fantastic.web/` — **отдельный проект** (свой `.git`, свой `AGENTS.md`): сайт **fantastic.md** — интернет-магазин на Yii2/PHP. Работает с **той же базой Firebird** (`SW`), что и WMS; со стороны WMS его питают `sources/classes/WebShops/`, `WebCatalog/` и views `VW_TWEB_*`. Внутри этой папки следуй её собственному `AGENTS.md`, а не Delphi-инструкциям (в т.ч. правило кодировки cp1251 к PHP не относится).

## Парный файл CLAUDE.md

В корне лежит `CLAUDE.md` (инструкции для Claude Code) — идентичная копия этого файла. При существенных правках архитектуры/сборки синхронизируй оба, чтобы они не расходились.
