object frmProcuriBrowserDlg: TfrmProcuriBrowserDlg
  Left = 0
  Top = 0
  ActiveControl = cxGridProcura
  BorderStyle = bsDialog
  Caption = #1044#1086#1074#1077#1088#1077#1085#1085#1086#1089#1090#1080
  ClientHeight = 612
  ClientWidth = 987
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 987
    Height = 64
    Title = #1044#1086#1074#1077#1088#1077#1085#1085#1086#1089#1090#1080
    Text = #1059#1087#1088#1072#1074#1083#1077#1085#1080#1077' '#1076#1086#1074#1077#1088#1077#1085#1086#1089#1090#1102#1084#1080
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
  object cxGridProcura: TcxGrid
    AlignWithMargins = True
    Left = 8
    Top = 142
    Width = 971
    Height = 411
    Margins.Left = 8
    Margins.Top = 0
    Margins.Right = 8
    Margins.Bottom = 12
    Align = alClient
    TabOrder = 3
    object cxGridProcuraTable: TcxGridDBTableView
      OnKeyDown = cxGridProcuraTableKeyDown
      Navigator.Buttons.CustomButtons = <>
      ScrollbarAnnotations.CustomAnnotations = <>
      OnCellDblClick = cxGridProcuraTableCellDblClick
      OnFocusedRecordChanged = cxGridProcuraTableFocusedRecordChanged
      DataController.DataSource = IBCDataSourcePROCURA
      DataController.KeyFieldNames = 'PROCURAID'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.IncSearch = True
      OptionsBehavior.ImmediateEditor = False
      OptionsCustomize.ColumnFiltering = False
      OptionsCustomize.ColumnsQuickCustomization = True
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.InvertSelect = False
      OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
      OptionsView.ScrollBars = ssVertical
      OptionsView.ColumnAutoWidth = True
      OptionsView.GridLineColor = 13750737
      OptionsView.GroupByBox = False
      OptionsView.GroupRowStyle = grsOffice11
      OptionsView.Indicator = True
      Styles.OnGetContentStyle = cxGridProcuraTableStylesGetContentStyle
      Styles.GroupByBox = dmAdditions.cxStyle_GridGroup
      Styles.Header = dmAdditions.cxStyle_GridHeader
      object cxGridProcuraTable_PROCURAID: TcxGridDBColumn
        AlternateCaption = #1050#1086#1076' '#1076#1086#1074#1077#1088#1077#1085#1085#1086#1089#1090#1080
        Caption = #1050#1086#1076
        DataBinding.FieldName = 'PROCURAID'
        Visible = False
        HeaderAlignmentHorz = taCenter
        MinWidth = 50
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 50
      end
      object cxGridProcuraTable_PROCURA_NO: TcxGridDBColumn
        Caption = #1053#1086#1084#1077#1088' '#1076#1086#1074#1077#1088#1077#1085#1086#1089#1090#1080
        DataBinding.FieldName = 'PROCURA_NO'
        HeaderAlignmentHorz = taCenter
        MinWidth = 120
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 120
      end
      object cxGridProcuraTable_DELEGAT: TcxGridDBColumn
        Caption = #1044#1086#1074#1077#1088#1077#1085#1085#1086#1077' '#1083#1080#1094#1086
        DataBinding.FieldName = 'DELEGAT'
        Width = 80
      end
      object cxGridProcuraTable_CUSTOMER_NAME: TcxGridDBColumn
        Caption = #1060#1080#1088#1084#1072
        DataBinding.FieldName = 'CUSTOMER_NAME'
        Width = 100
      end
      object cxGridProcuraTable_DATA_START: TcxGridDBColumn
        Caption = #1044#1072#1090#1072' '#1074#1099#1076#1072#1095#1080
        DataBinding.FieldName = 'DATA_START'
        HeaderAlignmentHorz = taCenter
        MinWidth = 90
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 90
      end
      object cxGridProcuraTable_DATA_END: TcxGridDBColumn
        Caption = #1055#1077#1088#1080#1086#1076' '#1076#1086
        DataBinding.FieldName = 'DATA_END'
        HeaderAlignmentHorz = taCenter
        MinWidth = 90
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 90
      end
      object cxGridProcuraTable_FLG_EXPIRED: TcxGridDBColumn
        AlternateCaption = #1055#1088#1086#1089#1088#1086#1095#1077#1085#1085#1072
        Caption = #1055#1088#1086#1089
        DataBinding.FieldName = 'FLG_EXPIRED'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        HeaderAlignmentHorz = taCenter
        MinWidth = 40
        Options.HorzSizing = False
        Width = 40
      end
      object cxGridProcuraTable_CREATED_BY_NAME: TcxGridDBColumn
        Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
        DataBinding.FieldName = 'CREATED_BY_NAME'
        Width = 60
      end
    end
    object cxGridProcuraLevel: TcxGridLevel
      GridView = cxGridProcuraTable
    end
  end
  object pnMenus: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 971
    Height = 30
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 2
    Align = alTop
    AutoSize = True
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 1
    object dxBarDockControl1: TdxBarDockControl
      Left = 0
      Top = 0
      Width = 971
      Height = 30
      Align = dalTop
      BarManager = dxBarManager
      SunkenBorder = True
      UseOwnSunkenBorder = True
    end
  end
  object pnBottom: TPanel
    Left = 0
    Top = 565
    Width = 987
    Height = 47
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 4
    DesignSize = (
      987
      47)
    object btnCancel: TcxButton
      Left = 873
      Top = 3
      Width = 90
      Height = 29
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100
      ModalResult = 2
      TabOrder = 1
    end
    object btnOk: TcxButton
      Left = 769
      Top = 3
      Width = 90
      Height = 29
      Anchors = [akTop, akRight]
      Caption = #1042#1099#1073#1088#1072#1090#1100
      Default = True
      TabOrder = 0
      OnClick = btnOkClick
    end
  end
  object pnFilter: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 104
    Width = 971
    Height = 35
    Margins.Left = 8
    Margins.Top = 0
    Margins.Right = 8
    Align = alTop
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = 14021119
    Padding.Left = 2
    Padding.Top = 2
    Padding.Right = 2
    Padding.Bottom = 2
    ParentBackground = False
    TabOrder = 2
    object sbShowAll: TSpeedButton
      Left = 876
      Top = 2
      Width = 89
      Height = 27
      Align = alRight
      Caption = #1087#1086#1082#1072#1079#1072#1090#1100' '#1074#1089#1077
      OnClick = sbShowAllClick
      ExplicitHeight = 19
    end
    object cxLabel1: TcxLabel
      Left = 2
      Top = 2
      Align = alLeft
      Caption = #1055#1086#1082#1072#1079#1099#1074#1072#1102#1090#1089#1103' '#1076#1086#1074#1077#1088#1077#1085#1085#1086#1089#1090#1080' '#1090#1086#1083#1100#1082#1086' '#1076#1083#1103
      Properties.Alignment.Vert = taVCenter
      AnchorY = 16
    end
    object lbCustomerTitle: TcxLabel
      Left = 230
      Top = 2
      Align = alClient
      Caption = 'lbCustomerTitle'
      Style.TextColor = clNavy
      Style.TextStyle = [fsBold]
      Properties.Alignment.Vert = taVCenter
      AnchorY = 16
    end
  end
  object dxBarManager: TdxBarManager
    AllowReset = False
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
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 472
    Top = 236
    PixelsPerInch = 96
    object dxBarManagerBar1: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Procura'
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 728
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbNewProcura'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbEditProcura'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbDeleteProcura'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbSearch'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbShowLast30Days'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object bbNewProcura: TdxBarButton
      Caption = #1053#1086#1074#1072#1103' '#1076#1086#1074#1077#1088#1077#1085#1085#1086#1089#1090#1100
      Category = 0
      Hint = #1053#1086#1074#1072#1103' '#1076#1086#1074#1077#1088#1077#1085#1085#1086#1089#1090#1100
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 45
      OnClick = bbNewProcuraClick
    end
    object bbEditProcura: TdxBarButton
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      Category = 0
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 115
      OnClick = bbEditProcuraClick
    end
    object bbDeleteProcura: TdxBarButton
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Category = 0
      Hint = #1059#1076#1072#1083#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 42
      ShortCut = 46
      OnClick = bbDeleteProcuraClick
    end
    object bbShowLast30Days: TdxBarButton
      Caption = #1047#1072' '#1087#1086#1089#1083#1077#1076#1085#1080#1077' 30 '#1076#1085#1077#1081' '#1090#1086#1083#1100#1082#1086
      Category = 0
      Hint = #1047#1072' '#1087#1086#1089#1083#1077#1076#1085#1080#1077' 30 '#1076#1085#1077#1081' '#1090#1086#1083#1100#1082#1086
      Visible = ivAlways
      ButtonStyle = bsChecked
      OnClick = bbShowLast30DaysClick
    end
    object bbSearch: TdxBarButton
      Caption = #1055#1086#1080#1089#1082
      Category = 0
      Hint = #1055#1086#1080#1089#1082
      Visible = ivAlways
      ImageIndex = 4
      ShortCut = 114
      OnClick = bbSearchClick
    end
  end
  object IBCQueryPROCURA: TIBCQuery
    KeyFields = 'PROCURAID'
    KeyGenerator = 'SQ_TS_PROCURI_ID'
    GeneratorMode = gmInsert
    SQLInsert.Strings = (
      'INSERT INTO VW_TS_PROCURI'
      
        '  (PROCURAID, CUSTOMERID, PROCURA_NO, DELEGAT, DATA_START, DATA_' +
        'END, CREATED_BY, CREATED_DATE, FLG_EXPIRED)'
      'VALUES'
      
        '  (:PROCURAID, :CUSTOMERID, :PROCURA_NO, :DELEGAT, :DATA_START, ' +
        ':DATA_END, :CREATED_BY, :CREATED_DATE, :FLG_EXPIRED)')
    SQLDelete.Strings = (
      'DELETE FROM VW_TS_PROCURI'
      'WHERE'
      '  PROCURAID = :Old_PROCURAID')
    SQLUpdate.Strings = (
      'UPDATE VW_TS_PROCURI'
      'SET'
      
        '  PROCURAID = :PROCURAID, CUSTOMERID = :CUSTOMERID, PROCURA_NO =' +
        ' :PROCURA_NO, DELEGAT = :DELEGAT, DATA_START = :DATA_START, DATA' +
        '_END = :DATA_END, CREATED_BY = :CREATED_BY, CREATED_DATE = :CREA' +
        'TED_DATE, FLG_EXPIRED = :FLG_EXPIRED'
      'WHERE'
      '  PROCURAID = :Old_PROCURAID')
    SQLRefresh.Strings = (
      'SELECT '
      ' *'
      'FROM '
      ' VW_TS_PROCURI'
      'WHERE'
      ' PROCURAID = :PROCURAID')
    SQLLock.Strings = (
      'SELECT NULL FROM TS_PROCURI'
      'WHERE'
      'PROCURAID = :Old_PROCURAID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = IBCTrPROCURAUpdate
    SQL.Strings = (
      'SELECT'
      ' *'
      'FROM '
      ' VW_TS_PROCURI')
    AutoCommit = False
    LockMode = lmLockImmediate
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Left = 76
    Top = 356
  end
  object IBCDataSourcePROCURA: TIBCDataSource
    DataSet = IBCQueryPROCURA
    Left = 76
    Top = 304
  end
  object IBCTrPROCURAUpdate: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 76
    Top = 412
  end
end
