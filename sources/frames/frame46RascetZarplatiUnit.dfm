inherited frame46RascetZarplati: Tframe46RascetZarplati
  Width = 1144
  Height = 645
  Font.Height = -15
  ExplicitWidth = 1144
  ExplicitHeight = 645
  PixelsPerInch = 120
  object cxGridZap: TcxGrid
    Left = 0
    Top = 0
    Width = 1144
    Height = 335
    Align = alClient
    TabOrder = 2
    LookAndFeel.NativeStyle = True
    LookAndFeel.SkinName = ''
    object cxGridZapTable: TcxGridDBTableView
      OnKeyDown = cxGridZapTableKeyDown
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
      OnCellDblClick = cxGridZapTableCellDblClick
      OnCustomDrawCell = cxGridZapTableCustomDrawCell
      DataController.KeyFieldNames = 'DOCID'
      FilterRow.SeparatorWidth = 8
      FixedDataRows.SeparatorWidth = 8
      NewItemRow.SeparatorWidth = 8
      OptionsBehavior.IncSearch = True
      OptionsBehavior.ImmediateEditor = False
      OptionsCustomize.ColumnsQuickCustomization = True
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.InvertSelect = False
      OptionsView.NavigatorOffset = 63
      OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
      OptionsView.ScrollBars = ssVertical
      OptionsView.ColumnAutoWidth = True
      OptionsView.FixedColumnSeparatorWidth = 3
      OptionsView.GridLineColor = 13750737
      OptionsView.GroupRowStyle = grsOffice11
      Preview.LeftIndent = 25
      Preview.RightIndent = 6
      RowLayout.MinValueWidth = 100
      Styles.GroupByBox = dmAdditions.cxStyle_GridGroup
      Styles.Header = dmAdditions.cxStyle_GridHeader
      Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
      object cxGridZap_FLG_CLOSED: TcxGridDBColumn
        Caption = 'Inchis'
        DataBinding.FieldName = 'FLG_CLOSED'
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
        HeaderAlignmentHorz = taCenter
        MinWidth = 80
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 80
      end
      object cxGridZap_DATA: TcxGridDBColumn
        Caption = 'Data'
        DataBinding.FieldName = 'DATA'
        PropertiesClassName = 'TcxDateEditProperties'
        OnGetDisplayText = cxGridZap_DATAGetDisplayText
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
        Options.Grouping = False
        Styles.Content = dmAdditions.cxStyle_Bold
        Width = 200
      end
      object cxGridZap_SUMA: TcxGridDBColumn
        Caption = 'Suma'
        DataBinding.FieldName = 'SUMA'
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
        Options.Grouping = False
        Width = 112
      end
      object cxGridZap_CT: TcxGridDBColumn
        DataBinding.FieldName = 'CT'
        Visible = False
        VisibleForCustomization = False
      end
      object cxGridZap_DT: TcxGridDBColumn
        DataBinding.FieldName = 'DT'
        Visible = False
        VisibleForCustomization = False
      end
      object cxGridZap_DTSC_NAME: TcxGridDBColumn
        Caption = 'Analitica'
        DataBinding.FieldName = 'DTSC_NAME'
        Width = 100
      end
    end
    object cxGridZapLevel: TcxGridLevel
      GridView = cxGridZapTable
    end
  end
  object cxSplitter: TcxSplitter
    Left = 0
    Top = 335
    Width = 1144
    Height = 10
    HotZoneClassName = 'TcxMediaPlayer9Style'
    AlignSplitter = salBottom
    MinSize = 200
    Control = pnBottom
  end
  object pnBottom: TPanel
    Left = 0
    Top = 345
    Width = 1144
    Height = 300
    Align = alBottom
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 0
    object cxGridCustomers: TcxGrid
      Left = 0
      Top = 34
      Width = 1144
      Height = 266
      Align = alClient
      TabOrder = 1
      object cxGridCustomereTable: TcxGridDBTableView
        OnKeyDown = cxGridCustomereTableKeyDown
        OnCellDblClick = cxGridCustomereTableCellDblClick
        OnCustomDrawCell = cxGridCustomereTableCustomDrawCell
        OnFocusedRecordChanged = cxGridCustomereTableFocusedRecordChanged
        DataController.DataSource = IBCDataSourceEMP
        DataController.KeyFieldNames = 'DOCID;CT'
        DataController.Summary.FooterSummaryItems = <
          item
            Format = '0.00'
            Kind = skSum
            Column = cxGridCustomere_SUMA_TOT
          end
          item
            Kind = skCount
            Column = cxGridCustomere_CT_NAME
          end
          item
            Kind = skSum
            Column = cxGridCustomere_SUMA_IMPOZIT
          end
          item
            Kind = skSum
            Column = cxGridCustomere_SUMA_CARD
          end
          item
            Kind = skSum
            Column = cxGridCustomere_SUMA_CALCULATA
          end>
        FilterRow.SeparatorWidth = 8
        FixedDataRows.SeparatorWidth = 8
        NewItemRow.SeparatorWidth = 8
        OptionsBehavior.AlwaysShowEditor = True
        OptionsBehavior.IncSearch = True
        OptionsCustomize.ColumnsQuickCustomization = True
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.InvertSelect = False
        OptionsView.NavigatorOffset = 63
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
        OptionsView.ScrollBars = ssVertical
        OptionsView.ColumnAutoWidth = True
        OptionsView.FixedColumnSeparatorWidth = 3
        OptionsView.Footer = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        Preview.LeftIndent = 25
        Preview.RightIndent = 6
        RowLayout.MinValueWidth = 100
        Styles.Footer = dmAdditions.cxStyle_GridHeader
        Styles.Header = dmAdditions.cxStyle_GridHeader
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        object cxGridCustomere_CT: TcxGridDBColumn
          Caption = #1050#1086#1076
          DataBinding.FieldName = 'CT'
          Visible = False
          HeaderAlignmentHorz = taCenter
          Width = 50
        end
        object cxGridCustomere_IMG: TcxGridDBColumn
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.DefaultImageIndex = 20
          Properties.Images = dmAdditions.cxImageList_SWN
          Properties.Items = <>
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
          SortIndex = 0
          SortOrder = soAscending
          Width = 133
        end
        object cxGridCustomere_SUMA_TOT: TcxGridDBColumn
          Caption = 'Total'
          DataBinding.FieldName = 'SUMA_TOT'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          HeaderAlignmentHorz = taCenter
          Styles.Content = dmAdditions.cxStyle_Bold
          Width = 53
        end
        object cxGridCustomere_SUMA_CALCULATA: TcxGridDBColumn
          Caption = 'Calculat'
          DataBinding.FieldName = 'SUMA_CALCULATA'
          Width = 57
        end
        object cxGridCustomere_SUMA_SAL_BAZA: TcxGridDBColumn
          Caption = 'Sal de baza'
          DataBinding.FieldName = 'SUMA_SAL_BAZA'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          HeaderAlignmentHorz = taCenter
          Width = 51
        end
        object cxGridCustomere_SUMA_AVANS: TcxGridDBColumn
          Caption = 'Avansuri'
          DataBinding.FieldName = 'SUMA_AVANS'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          HeaderAlignmentHorz = taCenter
          Width = 53
        end
        object cxGridCustomere_SUMA_DATORII: TcxGridDBColumn
          Caption = 'Datorii'
          DataBinding.FieldName = 'SUMA_DATORII'
          OnCustomDrawCell = cxGridCustomere_SUMA_DATORIICustomDrawCell
          HeaderAlignmentHorz = taCenter
          Styles.Content = dmAdditions.cxStyle_FilterGroupAutoG
          Width = 51
        end
        object cxGridCustomere_SUMA_FACTURI_ELIBERATE: TcxGridDBColumn
          Caption = 'Vinzari inchise'
          DataBinding.FieldName = 'SUMA_FACTURI_ELIBERATE'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          HeaderAlignmentHorz = taCenter
          Width = 53
        end
        object cxGridCustomere_SUMA_FACTURI_NEINCHISE: TcxGridDBColumn
          Caption = 'Vinzari neinchise'
          DataBinding.FieldName = 'SUMA_FACTURI_NEINCHISE'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          HeaderAlignmentHorz = taCenter
          Width = 51
        end
        object cxGridCustomere_SUMA_BONUS: TcxGridDBColumn
          Caption = 'Premii'
          DataBinding.FieldName = 'SUMA_BONUS'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          HeaderAlignmentHorz = taCenter
          Styles.OnGetContentStyle = cxGridCustomere_SUMA_BONUSStylesGetContentStyle
          Width = 52
        end
        object cxGridCustomere_BONUS_WEB_DESCRIPTION: TcxGridDBColumn
          Caption = 'Bonus web'
          DataBinding.FieldName = 'BONUS_WEB_DESCRIPTION'
          HeaderAlignmentHorz = taCenter
          Width = 49
        end
        object cxGridCustomere_AMENZI: TcxGridDBColumn
          Caption = 'Penalitati'
          DataBinding.FieldName = 'AMENZI'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          HeaderAlignmentHorz = taCenter
          Styles.OnGetContentStyle = cxGridCustomere_AMENZIStylesGetContentStyle
          Width = 52
        end
        object cxGridCustomereSUMA_PENALITATI: TcxGridDBColumn
          AlternateCaption = 'bonus/amenzi'
          Caption = '+/-'
          DataBinding.FieldName = 'SUMA_PENALITATI'
          HeaderAlignmentHorz = taCenter
          Width = 41
        end
        object cxGridCustomere_SUMA_CARD: TcxGridDBColumn
          AlternateCaption = 'Card bancar'
          Caption = 'Card bancar'
          DataBinding.FieldName = 'SUMA_CARD'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          HeaderAlignmentHorz = taCenter
          Styles.Content = dmAdditions.cxStyle_CalcProfitGreen
          Width = 52
        end
        object cxGridCustomere_SUMA_IMPOZIT: TcxGridDBColumn
          Caption = 'Impozite'
          DataBinding.FieldName = 'SUMA_IMPOZIT'
          Width = 60
        end
        object cxGridCustomere_INVENT: TcxGridDBColumn
          Caption = 'Inventariere'
          DataBinding.FieldName = 'INVENTARIERE'
          Width = 41
        end
        object cxGridCustomere_ORE_LUCRATE: TcxGridDBColumn
          Caption = 'Ore lipse'
          DataBinding.FieldName = 'ORE_LIPSITE'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          HeaderAlignmentHorz = taCenter
          Width = 45
        end
        object cxGridCustomere_COMMENTS: TcxGridDBColumn
          Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080
          DataBinding.FieldName = 'COMMENTS'
          Visible = False
          Width = 80
        end
      end
      object cxGridCustomersLevel: TcxGridLevel
        GridView = cxGridCustomereTable
      end
    end
    object dxBarDockControl1: TdxBarDockControl
      Left = 0
      Top = 0
      Width = 1144
      Height = 34
      Align = dalTop
      BarManager = dxBarManager
      SunkenBorder = True
      UseOwnSunkenBorder = True
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
  object dxBarManager: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
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
    PixelsPerInch = 120
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
      FloatClientWidth = 0
      FloatClientHeight = 0
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
      OnClick = bbDocCloseClick
    end
    object bbDocOpen: TdxBarButton
      Caption = #1054#1090#1082#1088#1099#1090#1100' '#1076#1086#1082#1091#1084#1077#1085#1090'...'
      Category = 0
      Hint = #1054#1090#1082#1088#1099#1090#1100' '#1076#1086#1082#1091#1084#1077#1085#1090
      Visible = ivAlways
      OnClick = bbDocOpenClick
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
      OnClick = bbAddCustomerClick
    end
    object bbDeleetCustomer: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      ShortCut = 16430
      OnClick = bbDeleetCustomerClick
    end
    object bbModifyCustomer: TdxBarButton
      Caption = 'Modifica'
      Category = 0
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 115
      OnClick = bbModifyCustomerClick
    end
    object bbCalcSalary: TdxBarButton
      Caption = 'Calculeaza'
      Category = 0
      Hint = 'Calculeaza'
      Visible = ivAlways
      ImageIndex = 25
      ShortCut = 117
      OnClick = bbCalcSalaryClick
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
      OnClick = bbRecalcMissedHoursClick
    end
    object bbDocComments: TdxBarButton
      Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080'...'
      Category = 0
      Hint = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080
      Visible = ivAlways
      OnClick = bbDocCommentsClick
    end
    object btnCopyGrid: TdxBarButton
      Caption = 'Copy to clipboard'
      Category = 0
      Hint = 'Copy to clipboard'
      Visible = ivAlways
      OnClick = btnCopyGridClick
    end
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
  object IBCDataSourceEMP: TIBCDataSource
    DataSet = IBCQueryEMP
    Left = 608
    Top = 196
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
    PixelsPerInch = 120
  end
end
