object frmPWMain: TfrmPWMain
  Left = 0
  Top = 0
  Caption = 'WMS PriceWatch'
  ClientHeight = 760
  ClientWidth = 1380
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnDestroy = FormDestroy
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 1380
    Height = 64
    Align = alTop
    Title = 'Monitorizarea preturilor concurentilor'
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
  object pnToolbar: TPanel
    Left = 0
    Top = 64
    Width = 1380
    Height = 70
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object btnStart: TcxButton
      Left = 8
      Top = 7
      Width = 110
      Height = 31
      Caption = 'Start monitor'
      TabOrder = 0
      OnClick = btnStartClick
    end
    object btnStop: TcxButton
      Left = 124
      Top = 7
      Width = 110
      Height = 31
      Caption = 'Stop'
      TabOrder = 1
      OnClick = btnStopClick
    end
    object btnReportNow: TcxButton
      Left = 256
      Top = 7
      Width = 170
      Height = 31
      Caption = 'Raport acum (Excel + Telegram)'
      TabOrder = 2
      OnClick = btnReportNowClick
    end
    object btnSites: TcxButton
      Left = 448
      Top = 7
      Width = 130
      Height = 31
      Caption = 'Site-uri concurenti...'
      TabOrder = 3
      OnClick = btnSitesClick
    end
    object btnCategories: TcxButton
      Left = 584
      Top = 7
      Width = 130
      Height = 31
      Caption = 'Categorii...'
      TabOrder = 4
      OnClick = btnCategoriesClick
    end
    object btnRefresh: TcxButton
      Left = 736
      Top = 7
      Width = 130
      Height = 31
      Caption = 'Actualizeaza grid-urile'
      TabOrder = 5
      OnClick = btnRefreshClick
    end
    object lbState: TLabel
      Left = 8
      Top = 46
      Width = 900
      Height = 15
      AutoSize = False
      Caption = 'Monitorul este oprit.'
    end
    object lbNextReport: TLabel
      Left = 920
      Top = 46
      Width = 440
      Height = 15
      AutoSize = False
      Caption = ''
    end
  end
  object pcMain: TPageControl
    Left = 0
    Top = 134
    Width = 1380
    Height = 626
    ActivePage = tsLog
    Align = alClient
    TabOrder = 1
    OnChange = pcMainChange
    object tsSummary: TTabSheet
      Caption = 'Rezumat (produsele noastre)'
      object pnSummaryTop: TPanel
        Left = 0
        Top = 0
        Width = 1372
        Height = 30
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object lbSummaryInfo: TLabel
          Left = 8
          Top = 7
          Width = 1300
          Height = 15
          AutoSize = False
          Caption = ''
        end
      end
      object cxGridSummary: TcxGrid
        Left = 0
        Top = 30
        Width = 1372
        Height = 566
        Align = alClient
        TabOrder = 1
        object cxGridSummaryTable: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = IBCDataSourceSummary
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.IncSearch = True
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.GroupByBox = True
          Styles.OnGetContentStyle = cxGridSummaryTableStylesGetContentStyle
          object colS_CAT_TITLE: TcxGridDBColumn
            Caption = 'Categorie'
            DataBinding.FieldName = 'CAT_TITLE'
            Width = 130
          end
          object colS_GOODSID: TcxGridDBColumn
            Caption = 'GOODSID'
            DataBinding.FieldName = 'GOODSID'
            Width = 70
          end
          object colS_CODE: TcxGridDBColumn
            Caption = 'Cod'
            DataBinding.FieldName = 'CODE'
            Width = 160
          end
          object colS_TITLE: TcxGridDBColumn
            Caption = 'Denumire'
            DataBinding.FieldName = 'TITLE'
            Width = 480
          end
          object colS_OUR_PRICE: TcxGridDBColumn
            Caption = 'Pretul nostru'
            DataBinding.FieldName = 'OUR_PRICE'
            Width = 90
          end
          object colS_MIN_PRICE: TcxGridDBColumn
            Caption = 'Min concurent'
            DataBinding.FieldName = 'MIN_PRICE'
            Width = 90
          end
          object colS_MIN_SITE: TcxGridDBColumn
            Caption = 'Site'
            DataBinding.FieldName = 'MIN_SITE'
            Width = 100
          end
          object colS_DIFF_LEI: TcxGridDBColumn
            Caption = 'Diferenta lei'
            DataBinding.FieldName = 'DIFF_LEI'
            Width = 90
          end
          object colS_DIFF_PCT: TcxGridDBColumn
            Caption = 'Diferenta %'
            DataBinding.FieldName = 'DIFF_PCT'
            Width = 80
          end
          object colS_SITES_CNT: TcxGridDBColumn
            Caption = 'Site-uri'
            DataBinding.FieldName = 'SITES_CNT'
            Width = 60
          end
        end
        object cxGridSummaryLevel: TcxGridLevel
          GridView = cxGridSummaryTable
        end
      end
    end
    object tsItems: TTabSheet
      Caption = 'Produse la concurenti'
      object pnItemsTop: TPanel
        Left = 0
        Top = 0
        Width = 1372
        Height = 44
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object lbSite: TLabel
          Left = 8
          Top = 13
          Width = 22
          Height = 15
          Caption = 'Site'
        end
        object cbSite: TComboBox
          Left = 36
          Top = 10
          Width = 160
          Height = 23
          Style = csDropDownList
          TabOrder = 0
        end
        object lbCategory: TLabel
          Left = 212
          Top = 13
          Width = 54
          Height = 15
          Caption = 'Categorie'
        end
        object cbCategory: TComboBox
          Left = 272
          Top = 10
          Width = 200
          Height = 23
          Style = csDropDownList
          TabOrder = 1
        end
        object chkUnmatched: TCheckBox
          Left = 488
          Top = 12
          Width = 130
          Height = 17
          Caption = 'Doar neasociate'
          TabOrder = 2
        end
        object btnItemsRefresh: TcxButton
          Left = 624
          Top = 6
          Width = 90
          Height = 31
          Caption = 'Arata'
          TabOrder = 3
          OnClick = btnItemsRefreshClick
        end
        object btnMatchManual: TcxButton
          Left = 740
          Top = 6
          Width = 150
          Height = 31
          Caption = 'Asociaza manual...'
          TabOrder = 4
          OnClick = btnMatchManualClick
        end
        object btnReject: TcxButton
          Left = 896
          Top = 6
          Width = 140
          Height = 31
          Caption = 'Respinge asocierea'
          TabOrder = 5
          OnClick = btnRejectClick
        end
        object btnResetAuto: TcxButton
          Left = 1042
          Top = 6
          Width = 130
          Height = 31
          Caption = 'Inapoi la automat'
          TabOrder = 6
          OnClick = btnResetAutoClick
        end
        object btnOpenUrl: TcxButton
          Left = 1178
          Top = 6
          Width = 130
          Height = 31
          Caption = 'Deschide pe site'
          TabOrder = 7
          OnClick = btnOpenUrlClick
        end
      end
      object cxGridItems: TcxGrid
        Left = 0
        Top = 44
        Width = 1372
        Height = 552
        Align = alClient
        TabOrder = 1
        object cxGridItemsTable: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = IBCDataSourceItems
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.IncSearch = True
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.GroupByBox = True
          Styles.OnGetContentStyle = cxGridItemsTableStylesGetContentStyle
          object colI_SITE_CODE: TcxGridDBColumn
            Caption = 'Site'
            DataBinding.FieldName = 'SITE_CODE'
            Width = 100
          end
          object colI_CAT_TITLE: TcxGridDBColumn
            Caption = 'Categorie'
            DataBinding.FieldName = 'CAT_TITLE'
            Width = 120
          end
          object colI_TITLE: TcxGridDBColumn
            Caption = 'Denumire pe site'
            DataBinding.FieldName = 'TITLE'
            Width = 360
          end
          object colI_PRICE: TcxGridDBColumn
            Caption = 'Pret'
            DataBinding.FieldName = 'PRICE'
            Width = 70
          end
          object colI_OLD_PRICE: TcxGridDBColumn
            Caption = 'Pret taiat'
            DataBinding.FieldName = 'OLD_PRICE'
            Width = 70
          end
          object colI_PREV_PRICE: TcxGridDBColumn
            Caption = 'Pret anterior'
            DataBinding.FieldName = 'PREV_PRICE'
            Width = 80
          end
          object colI_FLG_IN_STOCK: TcxGridDBColumn
            Caption = 'Stoc'
            DataBinding.FieldName = 'FLG_IN_STOCK'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ValueChecked = 1
            Properties.ValueGrayed = 0
            Properties.ValueUnchecked = 0
            Width = 45
          end
          object colI_GOODSID: TcxGridDBColumn
            Caption = 'GOODSID'
            DataBinding.FieldName = 'GOODSID'
            Width = 70
          end
          object colI_OUR_TITLE: TcxGridDBColumn
            Caption = 'Produsul nostru'
            DataBinding.FieldName = 'OUR_TITLE'
            Width = 360
          end
          object colI_OUR_PRICE: TcxGridDBColumn
            Caption = 'Pretul nostru'
            DataBinding.FieldName = 'OUR_PRICE'
            Width = 80
          end
          object colI_DIFF_LEI: TcxGridDBColumn
            Caption = 'Diferenta'
            DataBinding.FieldName = 'DIFF_LEI'
            Width = 70
          end
          object colI_MATCH_NAME: TcxGridDBColumn
            Caption = 'Asociere'
            DataBinding.FieldName = 'MATCH_NAME'
            Width = 60
          end
          object colI_MATCH_SCORE: TcxGridDBColumn
            Caption = 'Scor'
            DataBinding.FieldName = 'MATCH_SCORE'
            Width = 50
          end
          object colI_LAST_SEEN: TcxGridDBColumn
            Caption = 'Vazut ultima data'
            DataBinding.FieldName = 'LAST_SEEN'
            Width = 110
          end
          object colI_LAST_PRICE_CHANGE: TcxGridDBColumn
            Caption = 'Pret schimbat la'
            DataBinding.FieldName = 'LAST_PRICE_CHANGE'
            Width = 110
          end
          object colI_MATCH_KEY: TcxGridDBColumn
            Caption = 'Cuvinte-cheie'
            DataBinding.FieldName = 'MATCH_KEY'
            Width = 200
          end
        end
        object cxGridItemsLevel: TcxGridLevel
          GridView = cxGridItemsTable
        end
      end
    end
    object tsScans: TTabSheet
      Caption = 'Scanari'
      object cxGridScans: TcxGrid
        Left = 0
        Top = 0
        Width = 1372
        Height = 596
        Align = alClient
        TabOrder = 0
        object cxGridScansTable: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = IBCDataSourceScans
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
          object colSC_STARTED: TcxGridDBColumn
            Caption = 'Inceput'
            DataBinding.FieldName = 'STARTED'
            Width = 120
          end
          object colSC_FINISHED: TcxGridDBColumn
            Caption = 'Sfirsit'
            DataBinding.FieldName = 'FINISHED'
            Width = 120
          end
          object colSC_SITE_CODE: TcxGridDBColumn
            Caption = 'Site'
            DataBinding.FieldName = 'SITE_CODE'
            Width = 100
          end
          object colSC_CAT_TITLE: TcxGridDBColumn
            Caption = 'Categorie'
            DataBinding.FieldName = 'CAT_TITLE'
            Width = 140
          end
          object colSC_PAGES: TcxGridDBColumn
            Caption = 'Pagini'
            DataBinding.FieldName = 'PAGES'
            Width = 60
          end
          object colSC_ITEMS_FOUND: TcxGridDBColumn
            Caption = 'Produse'
            DataBinding.FieldName = 'ITEMS_FOUND'
            Width = 70
          end
          object colSC_ITEMS_NEW: TcxGridDBColumn
            Caption = 'Noi'
            DataBinding.FieldName = 'ITEMS_NEW'
            Width = 50
          end
          object colSC_PRICE_CHANGES: TcxGridDBColumn
            Caption = 'Preturi schimbate'
            DataBinding.FieldName = 'PRICE_CHANGES'
            Width = 100
          end
          object colSC_STATUS_NAME: TcxGridDBColumn
            Caption = 'Stare'
            DataBinding.FieldName = 'STATUS_NAME'
            Width = 70
          end
          object colSC_ERROR_TEXT: TcxGridDBColumn
            Caption = 'Eroare'
            DataBinding.FieldName = 'ERROR_TEXT'
            Width = 400
          end
        end
        object cxGridScansLevel: TcxGridLevel
          GridView = cxGridScansTable
        end
      end
    end
    object tsLog: TTabSheet
      Caption = 'Jurnal'
      object mmLog: TMemo
        Left = 0
        Top = 0
        Width = 1372
        Height = 596
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Consolas'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        ScrollBars = ssBoth
        TabOrder = 0
        WordWrap = False
      end
    end
  end
  object pnHidden: TPanel
    Left = 1200
    Top = 70
    Width = 100
    Height = 40
    BevelOuter = bvNone
    TabOrder = 2
    Visible = False
  end
  object tmTick: TTimer
    Enabled = False
    Interval = 1000
    OnTimer = tmTickTimer
    Left = 1000
    Top = 200
  end
  object IBCConnection: TIBCConnection
    LoginPrompt = False
    Left = 1000
    Top = 256
  end
  object IBCTransactionRead: TIBCTransaction
    DefaultConnection = IBCConnection
    Left = 1080
    Top = 256
  end
  object IBCQuerySummary: TIBCQuery
    SQL.Strings = (
      'SELECT * FROM SP_COMPETITOR_SUMMARY'
      'ORDER BY CAT_TITLE, TITLE')
    AutoCommit = False
    Left = 1000
    Top = 312
  end
  object IBCDataSourceSummary: TIBCDataSource
    DataSet = IBCQuerySummary
    Left = 1080
    Top = 312
  end
  object IBCQueryItems: TIBCQuery
    SQL.Strings = (
      'SELECT i.ITEMID, i.SITEID, i.CATID, s.SITE_CODE, c.TITLE AS CAT_TITLE, i.TITLE, i.PRICE, i.OLD_PRICE, i.PREV_PRICE,'
      '  i.FLG_IN_STOCK, i.GOODSID, i.MATCH_TYPE,'
      '  CASE i.MATCH_TYPE WHEN 1 THEN ''auto'' WHEN 2 THEN ''manual'' WHEN 3 THEN ''respins'' ELSE '''' END AS MATCH_NAME,'
      '  i.MATCH_SCORE, g.TITLE AS OUR_TITLE, m.PRICE1_LEI AS OUR_PRICE,'
      '  CASE WHEN i.MATCH_TYPE IN (1, 2) AND m.PRICE1_LEI IS NOT NULL THEN m.PRICE1_LEI - i.PRICE END AS DIFF_LEI,'
      '  i.LAST_SEEN, i.LAST_PRICE_CHANGE, i.ITEM_URL, i.MATCH_KEY'
      'FROM TWEB_COMPETITOR_ITEMS i'
      'JOIN TWEB_COMPETITOR_SITES s ON s.SITEID = i.SITEID'
      'JOIN TWEB_COMPETITOR_CATEGORIES c ON c.CATID = i.CATID'
      'LEFT JOIN TS_GOODS g ON g.GOODSID = i.GOODSID'
      'LEFT JOIN WEB_GET_GOODS_MIN_INFO(COALESCE(i.GOODSID, 0)) m ON 1 = 1'
      'WHERE i.FLG_ACTIVE = 1'
      '  AND (:SITEID1 = 0 OR i.SITEID = :SITEID2)'
      '  AND (:CATID1 = 0 OR i.CATID = :CATID2)'
      '  AND (:UNM = 0 OR i.GOODSID IS NULL OR i.MATCH_TYPE NOT IN (1, 2))'
      'ORDER BY s.SITE_CODE, c.ORDERNO, i.TITLE')
    AutoCommit = False
    Left = 1000
    Top = 368
    ParamData = <
      item
        DataType = ftInteger
        Name = 'SITEID1'
        ParamType = ptInput
        Value = 0
      end
      item
        DataType = ftInteger
        Name = 'SITEID2'
        ParamType = ptInput
        Value = 0
      end
      item
        DataType = ftInteger
        Name = 'CATID1'
        ParamType = ptInput
        Value = 0
      end
      item
        DataType = ftInteger
        Name = 'CATID2'
        ParamType = ptInput
        Value = 0
      end
      item
        DataType = ftInteger
        Name = 'UNM'
        ParamType = ptInput
        Value = 0
      end>
  end
  object IBCDataSourceItems: TIBCDataSource
    DataSet = IBCQueryItems
    Left = 1080
    Top = 368
  end
  object IBCQueryScans: TIBCQuery
    SQL.Strings = (
      'SELECT FIRST 300 sc.SCANID, sc.STARTED, sc.FINISHED, s.SITE_CODE, c.TITLE AS CAT_TITLE, sc.PAGES,'
      '  sc.ITEMS_FOUND, sc.ITEMS_NEW, sc.PRICE_CHANGES, sc.STATUS,'
      '  CASE sc.STATUS WHEN 0 THEN ''OK'' WHEN 1 THEN ''eroare'' WHEN 2 THEN ''suspect'' ELSE '''' END AS STATUS_NAME,'
      '  sc.ERROR_TEXT'
      'FROM TWEB_COMPETITOR_SCANS sc'
      'JOIN TWEB_COMPETITOR_SITES s ON s.SITEID = sc.SITEID'
      'JOIN TWEB_COMPETITOR_CATEGORIES c ON c.CATID = sc.CATID'
      'ORDER BY sc.STARTED DESC')
    AutoCommit = False
    Left = 1000
    Top = 424
  end
  object IBCDataSourceScans: TIBCDataSource
    DataSet = IBCQueryScans
    Left = 1080
    Top = 424
  end
  object cxStyleRepository: TcxStyleRepository
    Left = 1000
    Top = 488
    PixelsPerInch = 96
    object stRed: TcxStyle
      AssignedValues = [svColor]
      Color = 13421823
    end
    object stGreen: TcxStyle
      AssignedValues = [svColor]
      Color = 13434828
    end
  end
end
