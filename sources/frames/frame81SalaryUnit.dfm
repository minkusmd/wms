inherited frame81Salary: Tframe81Salary
  Width = 1410
  Height = 822
  Font.Height = -12
  ExplicitWidth = 1410
  ExplicitHeight = 822
  object cxGridZap: TcxGrid
    Left = 0
    Top = 0
    Width = 1410
    Height = 514
    Align = alClient
    TabOrder = 2
    LookAndFeel.NativeStyle = True
    LookAndFeel.SkinName = ''
    ExplicitWidth = 1310
    ExplicitHeight = 301
    object cxGridZapTable: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      Navigator.Buttons.First.Visible = True
      Navigator.Buttons.PriorPage.Visible = True
      Navigator.Buttons.Prior.Visible = True
      Navigator.Buttons.Next.Visible = True
      Navigator.Buttons.NextPage.Visible = True
      Navigator.Buttons.Last.Visible = True
      Navigator.Buttons.Insert.Visible = True
      Navigator.Buttons.Append.Visible = False
      Navigator.Buttons.Delete.Visible = True
      Navigator.Buttons.Edit.Visible = True
      Navigator.Buttons.Post.Visible = True
      Navigator.Buttons.Cancel.Visible = True
      Navigator.Buttons.Refresh.Visible = True
      Navigator.Buttons.SaveBookmark.Visible = True
      Navigator.Buttons.GotoBookmark.Visible = True
      Navigator.Buttons.Filter.Visible = True
      ScrollbarAnnotations.CustomAnnotations = <>
      DataController.KeyFieldNames = 'DOCID'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.IncSearch = True
      OptionsBehavior.ImmediateEditor = False
      OptionsCustomize.ColumnsQuickCustomization = True
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.InvertSelect = False
      OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
      OptionsView.ScrollBars = ssVertical
      OptionsView.ColumnAutoWidth = True
      OptionsView.GridLineColor = 13750737
      OptionsView.GroupRowStyle = grsOffice11
      Styles.GroupByBox = dmAdditions.cxStyle_GridGroup
      Styles.Header = dmAdditions.cxStyle_GridHeader
      Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
      object cxGridZap_FLG_CLOSED: TcxGridDBColumn
        Caption = 'Inchis'
        DataBinding.FieldName = 'FLG_CLOSED'
        DataBinding.IsNullValueType = True
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        HeaderAlignmentHorz = taCenter
        MinWidth = 50
        Options.IncSearch = False
        Options.Grouping = False
        Options.HorzSizing = False
        Options.Sorting = False
        Width = 50
      end
      object cxGridZap_DOCID: TcxGridDBColumn
        Caption = 'Cod'
        DataBinding.FieldName = 'DOCID'
        DataBinding.IsNullValueType = True
        HeaderAlignmentHorz = taCenter
        MinWidth = 80
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 80
      end
      object cxGridZap_DATA: TcxGridDBColumn
        Caption = 'Data'
        DataBinding.FieldName = 'DATA'
        DataBinding.IsNullValueType = True
        PropertiesClassName = 'TcxDateEditProperties'
        DateTimeGrouping = dtgByDate
        HeaderAlignmentHorz = taCenter
        MinWidth = 110
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 110
      end
      object cxGridZap_DT_NAME: TcxGridDBColumn
        Caption = 'Subdiviziune'
        DataBinding.FieldName = 'DT_NAME'
        DataBinding.IsNullValueType = True
        HeaderAlignmentHorz = taCenter
        Options.Grouping = False
        Styles.Content = dmAdditions.cxStyle_Bold
        Width = 200
      end
      object cxGridZap_SUMA: TcxGridDBColumn
        Caption = 'Suma'
        DataBinding.FieldName = 'SUMA'
        DataBinding.IsNullValueType = True
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 70
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 70
      end
      object cxGridZap_CURRENCY_NAME: TcxGridDBColumn
        Caption = 'Valuta'
        DataBinding.FieldName = 'CURRENCY_NAME'
        DataBinding.IsNullValueType = True
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        MinWidth = 70
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 70
      end
      object cxGridZap_VAT: TcxGridDBColumn
        Caption = 'TVA'
        DataBinding.FieldName = 'VAT'
        DataBinding.IsNullValueType = True
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        Visible = False
        HeaderAlignmentHorz = taCenter
        MinWidth = 70
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 70
      end
      object cxGridZap_RATE: TcxGridDBColumn
        Caption = 'Rata'
        DataBinding.FieldName = 'RATE'
        DataBinding.IsNullValueType = True
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 70
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 70
      end
      object cxGridZap_RATEUSD: TcxGridDBColumn
        Caption = 'Rata USD'
        DataBinding.FieldName = 'RATEUSD'
        DataBinding.IsNullValueType = True
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 70
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 70
      end
      object cxGridZap_PARENTDOCID: TcxGridDBColumn
        Caption = #1050#1086#1076' '#1088#1086#1076'.'
        DataBinding.FieldName = 'PARENTDOCID'
        DataBinding.IsNullValueType = True
        Visible = False
        HeaderAlignmentHorz = taCenter
        MinWidth = 70
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 70
      end
      object cxGridZap_FLG_ACNT: TcxGridDBColumn
        Caption = 'Cntb'
        DataBinding.FieldName = 'FLG_ACNT'
        DataBinding.IsNullValueType = True
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        HeaderAlignmentHorz = taCenter
        MinWidth = 40
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 40
      end
      object cxGridZap_CREATED_BY_NAME: TcxGridDBColumn
        Caption = 'Operator'
        DataBinding.FieldName = 'CREATED_BY_NAME'
        DataBinding.IsNullValueType = True
        HeaderAlignmentHorz = taCenter
        Options.Grouping = False
        Width = 112
      end
      object cxGridZap_CT: TcxGridDBColumn
        DataBinding.FieldName = 'CT'
        DataBinding.IsNullValueType = True
        Visible = False
        HeaderAlignmentHorz = taCenter
        VisibleForCustomization = False
      end
      object cxGridZap_DT: TcxGridDBColumn
        DataBinding.FieldName = 'DT'
        DataBinding.IsNullValueType = True
        Visible = False
        HeaderAlignmentHorz = taCenter
        VisibleForCustomization = False
      end
      object cxGridZap_DTSC_NAME: TcxGridDBColumn
        Caption = 'Analitica'
        DataBinding.FieldName = 'DTSC_NAME'
        DataBinding.IsNullValueType = True
        HeaderAlignmentHorz = taCenter
        Width = 100
      end
    end
    object cxGridZapLevel: TcxGridLevel
      GridView = cxGridZapTable
    end
  end
  object cxSplitter: TcxSplitter
    Left = 0
    Top = 514
    Width = 1410
    Height = 8
    HotZoneClassName = 'TcxMediaPlayer9Style'
    AlignSplitter = salBottom
    MinSize = 200
    Control = pnBottom
    ExplicitTop = 301
    ExplicitWidth = 1310
  end
  object pnBottom: TPanel
    Left = 0
    Top = 522
    Width = 1410
    Height = 300
    Align = alBottom
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    ShowCaption = False
    TabOrder = 0
    ExplicitTop = 309
    ExplicitWidth = 1310
    object dxBarDockControl1: TdxBarDockControl
      Left = 0
      Top = 0
      Width = 1406
      Height = 30
      Align = dalTop
      BarManager = dxBarManager
      SunkenBorder = True
      UseOwnSunkenBorder = True
      ExplicitWidth = 1306
    end
    object Panel1: TPanel
      Left = 0
      Top = 36
      Width = 849
      Height = 253
      BevelKind = bkFlat
      BevelOuter = bvNone
      Color = clWindow
      ParentBackground = False
      TabOrder = 1
      object cxGridCustomers: TcxGrid
        Left = 0
        Top = 0
        Width = 845
        Height = 249
        Align = alClient
        TabOrder = 0
        object cxGridCustomereTable: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          ScrollbarAnnotations.CustomAnnotations = <>
          DataController.DataSource = IBCDataSourceEMP
          DataController.KeyFieldNames = 'DOCID;CT'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <
            item
              Format = '0.00'
              Kind = skSum
            end
            item
              Kind = skCount
              Column = cxGridCustomere_CT_NAME
            end
            item
              Kind = skSum
            end
            item
              Kind = skSum
            end
            item
              Kind = skSum
              Column = cxGridCustomere_SUMA_CALCULATA
            end>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.AlwaysShowEditor = True
          OptionsBehavior.IncSearch = True
          OptionsCustomize.ColumnsQuickCustomization = True
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.InvertSelect = False
          OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
          OptionsView.ScrollBars = ssVertical
          OptionsView.ColumnAutoWidth = True
          OptionsView.Footer = True
          OptionsView.GridLineColor = 13750737
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          Styles.Footer = dmAdditions.cxStyle_GridHeader
          Styles.Header = dmAdditions.cxStyle_GridHeader
          Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
          object cxGridCustomere_CT: TcxGridDBColumn
            Caption = #1050#1086#1076
            DataBinding.FieldName = 'CT'
            DataBinding.IsNullValueType = True
            Visible = False
            HeaderAlignmentHorz = taCenter
            Width = 50
          end
          object cxGridCustomere_IMG: TcxGridDBColumn
            DataBinding.IsNullValueType = True
            PropertiesClassName = 'TcxImageComboBoxProperties'
            Properties.DefaultImageIndex = 20
            Properties.Images = dmAdditions.cxImageList_SWN
            Properties.Items = <>
            HeaderAlignmentHorz = taCenter
            MinWidth = 24
            Options.Focusing = False
            Options.HorzSizing = False
            Options.Sorting = False
            VisibleForCustomization = False
            Width = 24
          end
          object cxGridCustomere_CT_NAME: TcxGridDBColumn
            Caption = 'Salariat'
            DataBinding.FieldName = 'CT_NAME'
            DataBinding.IsNullValueType = True
            HeaderAlignmentHorz = taCenter
            SortIndex = 0
            SortOrder = soAscending
            Width = 133
          end
          object cxGridCustomere_SUMA_CALCULATA: TcxGridDBColumn
            Caption = 'Calculat'
            DataBinding.FieldName = 'SUMA_CALCULATA'
            DataBinding.IsNullValueType = True
            HeaderAlignmentHorz = taCenter
            Width = 57
          end
          object cxGridCustomere_SUMA_AVANS: TcxGridDBColumn
            Caption = 'Avansuri'
            DataBinding.FieldName = 'SUMA_AVANS'
            DataBinding.IsNullValueType = True
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00'
            HeaderAlignmentHorz = taCenter
            Width = 53
          end
          object cxGridCustomere_SUMA_BONUS: TcxGridDBColumn
            Caption = 'Premii'
            DataBinding.FieldName = 'SUMA_BONUS'
            DataBinding.IsNullValueType = True
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00'
            HeaderAlignmentHorz = taCenter
            Width = 52
          end
          object cxGridCustomereSUMA_PENALITATI: TcxGridDBColumn
            AlternateCaption = 'bonus/amenzi'
            Caption = '+/-'
            DataBinding.FieldName = 'SUMA_PENALITATI'
            DataBinding.IsNullValueType = True
            HeaderAlignmentHorz = taCenter
            Width = 41
          end
          object cxGridCustomere_ORE_LUCRATE: TcxGridDBColumn
            Caption = 'Ore lipse'
            DataBinding.FieldName = 'ORE_LIPSITE'
            DataBinding.IsNullValueType = True
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00'
            HeaderAlignmentHorz = taCenter
            Width = 45
          end
          object cxGridCustomere_COMMENTS: TcxGridDBColumn
            Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080
            DataBinding.FieldName = 'COMMENTS'
            DataBinding.IsNullValueType = True
            Visible = False
            HeaderAlignmentHorz = taCenter
            Width = 80
          end
        end
        object cxGridCustomersLevel: TcxGridLevel
          GridView = cxGridCustomereTable
        end
      end
    end
    object Panel2: TPanel
      Left = 855
      Top = 36
      Width = 442
      Height = 253
      BevelKind = bkFlat
      BevelOuter = bvNone
      Color = clWindow
      ParentBackground = False
      TabOrder = 2
      object cxGrid2: TcxGrid
        Left = 0
        Top = 0
        Width = 438
        Height = 249
        Align = alClient
        TabOrder = 0
        object cxGrid_Articles: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          ScrollbarAnnotations.CustomAnnotations = <>
          DataController.DataSource = IBCDataSourceEmpDetail
          DataController.KeyFieldNames = 'DOCID;empid;articleid'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsView.ColumnAutoWidth = True
          OptionsView.Footer = True
          OptionsView.GroupByBox = False
          object cxGrid2_ARTICLE_NAME: TcxGridDBColumn
            Caption = 'Articol'
            DataBinding.FieldName = 'ARTICLE_NAME'
            DataBinding.IsNullValueType = True
            HeaderAlignmentHorz = taCenter
            Width = 358
          end
          object cxGrid2_SUMA_MDL: TcxGridDBColumn
            Caption = 'Suma'
            DataBinding.FieldName = 'SUMA_MDL'
            DataBinding.IsNullValueType = True
            HeaderAlignmentHorz = taCenter
            MinWidth = 80
            Options.HorzSizing = False
            Width = 80
          end
        end
        object cxGrid2Level1: TcxGridLevel
          GridView = cxGrid_Articles
        end
      end
    end
  end
  object dxDocPopupMenu: TcxGridPopupMenu
    Grid = cxGridZap
    PopupMenus = <
      item
        GridView = cxGridZapTable
        HitTypes = [gvhtCell, gvhtRecord]
        Index = 0
        PopupMenu = dxBarPopupMenu1
      end>
    UseBuiltInPopupMenus = False
    AlwaysFireOnPopup = True
    Left = 240
    Top = 188
  end
  object dxBarPopupMenu1: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbDocClose'
      end
      item
        Visible = True
        ItemName = 'bbDocOpen'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbDocComments'
      end>
    UseOwnFont = False
    Left = 468
    Top = 196
    PixelsPerInch = 96
  end
  object dxBarManager: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Default')
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    ImageOptions.Images = dmAdditions.cxImageList_SWN
    ImageOptions.StretchGlyphs = False
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 520
    Top = 80
    PixelsPerInch = 96
    object dxBarManagerBar1: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Custom 1'
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1211
      FloatTop = 0
      FloatClientWidth = 172
      FloatClientHeight = 108
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbFillCustomers'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbAddCustomer'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbModifyCustomer'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbDeleetCustomer'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbCalcSalary'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbCustomerTools'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object bbDocClose: TdxBarButton
      Caption = #1047#1072#1082#1088#1099#1090#1100' '#1076#1086#1082#1091#1084#1077#1085#1090'...'
      Category = 0
      Hint = #1047#1072#1082#1088#1099#1090#1100' '#1076#1086#1082#1091#1084#1077#1085#1090
      Visible = ivAlways
      ShortCut = 120
    end
    object bbDocOpen: TdxBarButton
      Caption = #1054#1090#1082#1088#1099#1090#1100' '#1076#1086#1082#1091#1084#1077#1085#1090'...'
      Category = 0
      Hint = #1054#1090#1082#1088#1099#1090#1100' '#1076#1086#1082#1091#1084#1077#1085#1090
      Visible = ivAlways
    end
    object bbFillCustomers: TdxBarButton
      Caption = 'Completa'#539'i lista cu angaja'#539'i'
      Category = 0
      Hint = 'Completa'#539'i lista cu angaja'#539'i'
      Visible = ivAlways
      ImageIndex = 10
      OnClick = bbFillCustomersClick
    end
    object bbAddCustomer: TdxBarButton
      Caption = 'Nou'
      Category = 0
      Hint = 'Nou'
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 45
    end
    object bbDeleetCustomer: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      ShortCut = 16430
    end
    object bbModifyCustomer: TdxBarButton
      Caption = 'Modifica'
      Category = 0
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 115
    end
    object bbCalcSalary: TdxBarButton
      Caption = 'Calculeaza'
      Category = 0
      Hint = 'Calculeaza'
      Visible = ivAlways
      ImageIndex = 25
      ShortCut = 117
    end
    object bbCustomerTools: TdxBarSubItem
      Caption = 'Intrumente'
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbRecalcMissedHours'
        end
        item
          Visible = True
          ItemName = 'btnCopyGrid'
        end>
    end
    object bbRecalcMissedHours: TdxBarButton
      Caption = 'Calculeaza orele lipsa'
      Category = 0
      Hint = 'Calculeaza orele lipsa'
      Visible = ivAlways
    end
    object bbDocComments: TdxBarButton
      Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080'...'
      Category = 0
      Hint = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080
      Visible = ivAlways
    end
    object btnCopyGrid: TdxBarButton
      Caption = 'Copy to clipboard'
      Category = 0
      Hint = 'Copy to clipboard'
      Visible = ivAlways
    end
  end
  object IBCDataSourceEMP: TIBCDataSource
    DataSet = IBCQueryEMP
    Left = 608
    Top = 196
  end
  object IBCQueryEMP: TIBCQuery
    SQLInsert.Strings = (
      'INSERT INTO VW_TDB_EMP_SALARY'
      
        '  (DOCID, CT, CT_NAME, SUMA_TOT, SUMA_AVANS, SUMA_DATORII, SUMA_' +
        'SAL_BAZA, SUMA_FACTURI_ELIBERATE, SUMA_FACTURI_NEINCHISE, SUMA_B' +
        'ONUS, SUMA_PENALITATI, SUMA_CARD, ORE_LUCRATE, ORE_LIPSITE, AMEN' +
        'ZI, INVENTARIERE, COMMENTS, suma_impozit)'
      'VALUES'
      
        '  (:DOCID, :CT, :CT_NAME, :SUMA_TOT, :SUMA_AVANS, :SUMA_DATORII,' +
        ' :SUMA_SAL_BAZA, :SUMA_FACTURI_ELIBERATE, :SUMA_FACTURI_NEINCHIS' +
        'E, :SUMA_BONUS, :SUMA_PENALITATI, :SUMA_CARD, :ORE_LUCRATE, :ORE' +
        '_LIPSITE, :AMENZI, :INVENTARIERE, :COMMENTS, :suma_impozit)')
    SQLDelete.Strings = (
      'DELETE FROM VW_TDB_EMP_SALARY'
      'WHERE'
      '  DOCID = :Old_DOCID AND CT = :Old_CT')
    SQLUpdate.Strings = (
      'UPDATE VW_TDB_EMP_SALARY'
      'SET'
      
        '  DOCID = :DOCID, CT = :CT, CT_NAME = :CT_NAME, SUMA_TOT = :SUMA' +
        '_TOT, SUMA_AVANS = :SUMA_AVANS, SUMA_DATORII = :SUMA_DATORII, SU' +
        'MA_SAL_BAZA = :SUMA_SAL_BAZA, SUMA_FACTURI_ELIBERATE = :SUMA_FAC' +
        'TURI_ELIBERATE, SUMA_FACTURI_NEINCHISE = :SUMA_FACTURI_NEINCHISE' +
        ', SUMA_BONUS = :SUMA_BONUS, SUMA_PENALITATI = :SUMA_PENALITATI, ' +
        'SUMA_CARD = :SUMA_CARD, ORE_LUCRATE = :ORE_LUCRATE, ORE_LIPSITE ' +
        '= :ORE_LIPSITE, AMENZI = :AMENZI, INVENTARIERE = :INVENTARIERE, ' +
        'COMMENTS = :COMMENTS, suma_impozit = :suma_impozit'
      'WHERE'
      '  DOCID = :Old_DOCID AND CT = :Old_CT')
    SQLRefresh.Strings = (
      
        'SELECT DOCID, CT, CT_NAME, SUMA_TOT, SUMA_AVANS, SUMA_DATORII, S' +
        'UMA_SAL_BAZA, SUMA_FACTURI_ELIBERATE, SUMA_FACTURI_NEINCHISE, SU' +
        'MA_BONUS, SUMA_PENALITATI, SUMA_CARD, ORE_LUCRATE, ORE_LIPSITE, ' +
        'AMENZI, INVENTARIERE, COMMENTS, suma_impozit FROM VW_TDB_EMP_SAL' +
        'ARY'
      'WHERE'
      '  DOCID = :DOCID AND CT = :CT')
    SQLLock.Strings = (
      'SELECT NULL FROM TDB_EMP_SALARY'
      'WHERE'
      'DOCID = :Old_DOCID AND CT = :Old_CT'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'SELECT'
      ' *'
      'FROM'
      ' VW_TDB_EMP_SALARY'
      'ORDER BY'
      ' CT_NAME')
    MasterFields = 'DOCID'
    DetailFields = 'DOCID'
    MasterSource = dmDB.IBCDataSourceDocs
    AutoCommit = False
    LockMode = lmLockImmediate
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Options.RequiredFields = False
    Options.DetailDelay = 50
    LocalConstraints = False
    Left = 608
    Top = 248
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DOCID'
        Value = nil
      end>
  end
  object IBCQueryEmpDetail: TIBCQuery
    KeyFields = 'DOCID;empid;articleid'
    SQLInsert.Strings = (
      'INSERT INTO VW_TDB_EMP_SALARY_DETAIL'
      '  (DOCID, EMDPID, ARTICLEID, ARTICLE_NAME, SUMA_MDL)'
      'VALUES'
      '  (:DOCID, :EMDPID, :ARTICLEID, :ARTICLE_NAME, :SUMA_MDL)')
    SQLDelete.Strings = (
      'DELETE FROM VW_TDB_EMP_SALARY_DETAIL'
      'WHERE'
      
        '  DOCID = :Old_DOCID AND EMDPID = :Old_EMDPID AND ARTICLEID = :O' +
        'ld_ARTICLEID')
    SQLUpdate.Strings = (
      'UPDATE VW_TDB_EMP_SALARY_DETAIL'
      'SET'
      
        '  DOCID = :DOCID, EMDPID = :EMDPID, ARTICLEID = :ARTICLEID, ARTI' +
        'CLE_NAME = :ARTICLE_NAME, SUMA_MDL = :SUMA_MDL'
      'WHERE'
      
        '  DOCID = :Old_DOCID AND EMDPID = :Old_EMDPID AND ARTICLEID = :O' +
        'ld_ARTICLEID')
    SQLRefresh.Strings = (
      
        'SELECT DOCID, EMDPID, ARTICLEID, ARTICLE_NAME, SUMA_MDL FROM VW_' +
        'TDB_EMP_SALARY_DETAIL'
      'WHERE'
      '  DOCID = :DOCID AND EMDPID = :EMDPID AND ARTICLEID = :ARTICLEID')
    SQLLock.Strings = (
      'SELECT NULL FROM VW_TDB_EMP_SALARY_DETAIL'
      'WHERE'
      
        'DOCID = :Old_DOCID AND EMDPID = :Old_EMDPID AND ARTICLEID = :Old' +
        '_ARTICLEID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM VW_TDB_EMP_SALARY_DETAIL'
      ''
      ') q')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'SELECT'
      ' *'
      'FROM'
      'VW_TDB_EMP_SALARY_DETAIL'
      'ORDER BY'
      'article_name')
    MasterFields = 'DOCID;CT'
    DetailFields = 'DOCID;EMDPID'
    MasterSource = IBCDataSourceEMP
    AutoCommit = False
    LockMode = lmLockImmediate
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Options.RequiredFields = False
    Options.DetailDelay = 50
    LocalConstraints = False
    Left = 944
    Top = 248
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DOCID'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'CT'
        Value = nil
      end>
  end
  object IBCDataSourceEmpDetail: TIBCDataSource
    DataSet = IBCQueryEmpDetail
    Left = 944
    Top = 196
  end
end
