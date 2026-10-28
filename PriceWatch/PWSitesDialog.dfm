object frmPWSitesDlg: TfrmPWSitesDlg
  Left = 0
  Top = 0
  Caption = 'Site-urile concurentilor'
  ClientHeight = 700
  ClientWidth = 1180
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 1180
    Height = 64
    Align = alTop
    Title = 'Site-urile concurentilor'
    Text = ''
    FontTitle.Charset = DEFAULT_CHARSET
    FontTitle.Color = clWindowText
    FontTitle.Height = -13
    FontTitle.Name = 'Segoe UI'
    FontTitle.Style = [fsBold]
    FontText.Charset = DEFAULT_CHARSET
    FontText.Color = clWindowText
    FontText.Height = -12
    FontText.Name = 'Segoe UI'
    FontText.Style = []
  end
  object pnTop: TPanel
    Left = 0
    Top = 64
    Width = 1180
    Height = 230
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object cxGridSites: TcxGrid
      Left = 0
      Top = 0
      Width = 1180
      Height = 230
      Align = alClient
      TabOrder = 0
      object cxGridSitesTable: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = IBCDataSourceSites
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.Deleting = False
        OptionsData.Inserting = False
        OptionsView.GroupByBox = False
        object colSITE_CODE: TcxGridDBColumn
          Caption = 'Cod'
          DataBinding.FieldName = 'SITE_CODE'
          Width = 100
        end
        object colTITLE: TcxGridDBColumn
          Caption = 'Denumire'
          DataBinding.FieldName = 'TITLE'
          Width = 130
        end
        object colBASE_URL: TcxGridDBColumn
          Caption = 'Adresa'
          DataBinding.FieldName = 'BASE_URL'
          Width = 180
        end
        object colFLG_ACTIVE: TcxGridDBColumn
          Caption = 'Activ'
          DataBinding.FieldName = 'FLG_ACTIVE'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = 1
          Properties.ValueGrayed = 0
          Properties.ValueUnchecked = 0
          Width = 50
        end
        object colDELAY_MIN_MS: TcxGridDBColumn
          Caption = 'Pauza min, ms'
          DataBinding.FieldName = 'DELAY_MIN_MS'
          Width = 85
        end
        object colDELAY_MAX_MS: TcxGridDBColumn
          Caption = 'Pauza max, ms'
          DataBinding.FieldName = 'DELAY_MAX_MS'
          Width = 85
        end
        object colPAGE_URL_TPL: TcxGridDBColumn
          Caption = 'Sablon pagina'
          DataBinding.FieldName = 'PAGE_URL_TPL'
          Width = 170
        end
        object colMAX_PAGES: TcxGridDBColumn
          Caption = 'Max pagini'
          DataBinding.FieldName = 'MAX_PAGES'
          Width = 65
        end
        object colPROXY_URL: TcxGridDBColumn
          Caption = 'Proxy'
          DataBinding.FieldName = 'PROXY_URL'
          Width = 150
        end
        object colLAST_RUN: TcxGridDBColumn
          Caption = 'Ultima rulare'
          DataBinding.FieldName = 'LAST_RUN'
          Options.Editing = False
          Width = 110
        end
        object colLAST_STATUS: TcxGridDBColumn
          Caption = 'Stare'
          DataBinding.FieldName = 'LAST_STATUS'
          Options.Editing = False
          Width = 200
        end
        object colFAIL_COUNT: TcxGridDBColumn
          Caption = 'Esecuri'
          DataBinding.FieldName = 'FAIL_COUNT'
          Options.Editing = False
          Width = 55
        end
        object colBLOCKED_UNTIL: TcxGridDBColumn
          Caption = 'In pauza pina la'
          DataBinding.FieldName = 'BLOCKED_UNTIL'
          Options.Editing = False
          Width = 110
        end
      end
      object cxGridSitesLevel: TcxGridLevel
        GridView = cxGridSitesTable
      end
    end
  end
  object splMain: TSplitter
    Left = 0
    Top = 294
    Width = 1180
    Height = 5
    Cursor = crVSplit
    Align = alTop
  end
  object pcDetails: TPageControl
    Left = 0
    Top = 299
    Width = 1180
    Height = 357
    ActivePage = tsRegex
    Align = alClient
    TabOrder = 1
    object tsRegex: TTabSheet
      Caption = 'Regex-urile site-ului'
      object lbItemRegex: TLabel
        Left = 12
        Top = 8
        Width = 300
        Height = 15
        Caption = 'ITEM_REGEX - blocul HTML al unui produs (se aplica pe pagina)'
      end
      object mmItemRegex: TDBMemo
        Left = 12
        Top = 26
        Width = 560
        Height = 60
        DataField = 'ITEM_REGEX'
        DataSource = IBCDataSourceSites
        ScrollBars = ssVertical
        TabOrder = 0
      end
      object lbNameRegex: TLabel
        Left = 12
        Top = 94
        Width = 200
        Height = 15
        Caption = 'NAME_REGEX - denumirea (grupul 1)'
      end
      object edNameRegex: TDBEdit
        Left = 12
        Top = 112
        Width = 560
        Height = 23
        DataField = 'NAME_REGEX'
        DataSource = IBCDataSourceSites
        TabOrder = 1
      end
      object lbUrlRegex: TLabel
        Left = 12
        Top = 141
        Width = 200
        Height = 15
        Caption = 'URL_REGEX - linkul produsului (grupul 1)'
      end
      object edUrlRegex: TDBEdit
        Left = 12
        Top = 159
        Width = 560
        Height = 23
        DataField = 'URL_REGEX'
        DataSource = IBCDataSourceSites
        TabOrder = 2
      end
      object lbPriceRegex: TLabel
        Left = 12
        Top = 188
        Width = 200
        Height = 15
        Caption = 'PRICE_REGEX - pretul curent (grupul 1)'
      end
      object edPriceRegex: TDBEdit
        Left = 12
        Top = 206
        Width = 560
        Height = 23
        DataField = 'PRICE_REGEX'
        DataSource = IBCDataSourceSites
        TabOrder = 3
      end
      object lbOldPriceRegex: TLabel
        Left = 12
        Top = 235
        Width = 200
        Height = 15
        Caption = 'OLDPRICE_REGEX - pretul taiat (optional)'
      end
      object edOldPriceRegex: TDBEdit
        Left = 12
        Top = 253
        Width = 560
        Height = 23
        DataField = 'OLDPRICE_REGEX'
        DataSource = IBCDataSourceSites
        TabOrder = 4
      end
      object lbCodeRegex: TLabel
        Left = 592
        Top = 8
        Width = 200
        Height = 15
        Caption = 'CODE_REGEX - codul produsului pe site (optional)'
      end
      object edCodeRegex: TDBEdit
        Left = 592
        Top = 26
        Width = 560
        Height = 23
        DataField = 'CODE_REGEX'
        DataSource = IBCDataSourceSites
        TabOrder = 5
      end
      object lbStockRegex: TLabel
        Left = 592
        Top = 55
        Width = 200
        Height = 15
        Caption = 'STOCK_REGEX - textul despre stoc (optional)'
      end
      object edStockRegex: TDBEdit
        Left = 592
        Top = 73
        Width = 560
        Height = 23
        DataField = 'STOCK_REGEX'
        DataSource = IBCDataSourceSites
        TabOrder = 6
      end
      object lbNoStockWords: TLabel
        Left = 592
        Top = 102
        Width = 300
        Height = 15
        Caption = 'NOSTOCK_WORDS - cuvinte "fara stoc", separate prin ;'
      end
      object edNoStockWords: TDBEdit
        Left = 592
        Top = 120
        Width = 560
        Height = 23
        DataField = 'NOSTOCK_WORDS'
        DataSource = IBCDataSourceSites
        TabOrder = 7
      end
      object lbBlockRegex: TLabel
        Left = 592
        Top = 149
        Width = 300
        Height = 15
        Caption = 'BLOCK_REGEX - semne de blocare (captcha, challenge)'
      end
      object edBlockRegex: TDBEdit
        Left = 592
        Top = 167
        Width = 560
        Height = 23
        DataField = 'BLOCK_REGEX'
        DataSource = IBCDataSourceSites
        TabOrder = 8
      end
      object lbUserAgent: TLabel
        Left = 592
        Top = 196
        Width = 300
        Height = 15
        Caption = 'USER_AGENT fix (gol = rotatie automata)'
      end
      object edUserAgent: TDBEdit
        Left = 592
        Top = 214
        Width = 560
        Height = 23
        DataField = 'USER_AGENT'
        DataSource = IBCDataSourceSites
        TabOrder = 9
      end
      object lbNote: TLabel
        Left = 592
        Top = 243
        Width = 60
        Height = 15
        Caption = 'Observatii'
      end
      object edNote: TDBEdit
        Left = 592
        Top = 261
        Width = 560
        Height = 23
        DataField = 'NOTE'
        DataSource = IBCDataSourceSites
        TabOrder = 10
      end
    end
    object tsTest: TTabSheet
      Caption = 'Testeaza parsarea'
      object pnTestTop: TPanel
        Left = 0
        Top = 0
        Width = 1172
        Height = 40
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object lbTestUrl: TLabel
          Left = 12
          Top = 11
          Width = 110
          Height = 15
          Caption = 'URL-ul unei categorii'
        end
        object edTestUrl: TcxTextEdit
          Left = 130
          Top = 8
          TabOrder = 0
          Width = 800
        end
        object btnTest: TcxButton
          Left = 940
          Top = 5
          Width = 130
          Height = 31
          Caption = 'Descarca si parseaza'
          TabOrder = 1
          OnClick = btnTestClick
        end
      end
      object mmTest: TMemo
        Left = 0
        Top = 40
        Width = 1172
        Height = 287
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Consolas'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        ScrollBars = ssBoth
        TabOrder = 1
        WordWrap = False
      end
    end
  end
  object pnBottom: TPanel
    Left = 0
    Top = 656
    Width = 1180
    Height = 44
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object btnAdd: TcxButton
      Left = 8
      Top = 7
      Width = 110
      Height = 31
      Caption = 'Adauga site'
      TabOrder = 0
      OnClick = btnAddClick
    end
    object btnDelete: TcxButton
      Left = 124
      Top = 7
      Width = 100
      Height = 31
      Caption = 'Sterge'
      TabOrder = 1
      OnClick = btnDeleteClick
    end
    object btnUnblock: TcxButton
      Left = 240
      Top = 7
      Width = 130
      Height = 31
      Caption = 'Scoate din pauza'
      TabOrder = 2
      OnClick = btnUnblockClick
    end
    object btnOk: TcxButton
      Left = 946
      Top = 7
      Width = 110
      Height = 31
      Anchors = [akTop, akRight]
      Caption = 'Salveaza'
      Default = True
      ModalResult = 1
      TabOrder = 3
    end
    object btnCancel: TcxButton
      Left = 1062
      Top = 7
      Width = 110
      Height = 31
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Renunta'
      ModalResult = 2
      TabOrder = 4
    end
  end
  object IBCQuerySites: TIBCQuery
    KeyFields = 'SITEID'
    SQLInsert.Strings = (
      'INSERT INTO TWEB_COMPETITOR_SITES'
      '  (SITEID, SITE_CODE, TITLE, BASE_URL, FLG_ACTIVE, DELAY_MIN_MS, DELAY_MAX_MS, PAGE_URL_TPL, FIRST_PAGE, MAX_PAGES,'
      '   PROXY_URL, USER_AGENT, ITEM_REGEX, NAME_REGEX, URL_REGEX, PRICE_REGEX, OLDPRICE_REGEX, CODE_REGEX, STOCK_REGEX,'
      '   NOSTOCK_WORDS, BLOCK_REGEX, NOTE)'
      'VALUES'
      '  (:SITEID, :SITE_CODE, :TITLE, :BASE_URL, :FLG_ACTIVE, :DELAY_MIN_MS, :DELAY_MAX_MS, :PAGE_URL_TPL, :FIRST_PAGE, :MAX_PAGES,'
      '   :PROXY_URL, :USER_AGENT, :ITEM_REGEX, :NAME_REGEX, :URL_REGEX, :PRICE_REGEX, :OLDPRICE_REGEX, :CODE_REGEX, :STOCK_REGEX,'
      '   :NOSTOCK_WORDS, :BLOCK_REGEX, :NOTE)')
    SQLDelete.Strings = (
      'DELETE FROM TWEB_COMPETITOR_SITES'
      'WHERE'
      '  SITEID = :Old_SITEID')
    SQLUpdate.Strings = (
      'UPDATE TWEB_COMPETITOR_SITES'
      'SET'
      '  SITE_CODE = :SITE_CODE, TITLE = :TITLE, BASE_URL = :BASE_URL, FLG_ACTIVE = :FLG_ACTIVE,'
      '  DELAY_MIN_MS = :DELAY_MIN_MS, DELAY_MAX_MS = :DELAY_MAX_MS, PAGE_URL_TPL = :PAGE_URL_TPL,'
      '  FIRST_PAGE = :FIRST_PAGE, MAX_PAGES = :MAX_PAGES, PROXY_URL = :PROXY_URL, USER_AGENT = :USER_AGENT,'
      '  ITEM_REGEX = :ITEM_REGEX, NAME_REGEX = :NAME_REGEX, URL_REGEX = :URL_REGEX, PRICE_REGEX = :PRICE_REGEX,'
      '  OLDPRICE_REGEX = :OLDPRICE_REGEX, CODE_REGEX = :CODE_REGEX, STOCK_REGEX = :STOCK_REGEX,'
      '  NOSTOCK_WORDS = :NOSTOCK_WORDS, BLOCK_REGEX = :BLOCK_REGEX, NOTE = :NOTE,'
      '  LAST_STATUS = :LAST_STATUS, FAIL_COUNT = :FAIL_COUNT, BLOCKED_UNTIL = :BLOCKED_UNTIL'
      'WHERE'
      '  SITEID = :Old_SITEID')
    SQLRefresh.Strings = (
      'SELECT * FROM TWEB_COMPETITOR_SITES'
      'WHERE'
      '  SITEID = :SITEID')
    BeforePost = IBCQuerySitesBeforePost
    OnNewRecord = IBCQuerySitesNewRecord
    SQL.Strings = (
      'SELECT * FROM TWEB_COMPETITOR_SITES'
      'ORDER BY SITE_CODE')
    AutoCommit = False
    Left = 64
    Top = 120
  end
  object IBCDataSourceSites: TIBCDataSource
    DataSet = IBCQuerySites
    Left = 152
    Top = 120
  end
  object IBCTransactionUpdate: TIBCTransaction
    Left = 240
    Top = 120
  end
end
