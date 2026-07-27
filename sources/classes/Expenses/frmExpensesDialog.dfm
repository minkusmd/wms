object frmExpensesDlg: TfrmExpensesDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1099#1077' '#1088#1072#1089#1093#1086#1076#1099
  ClientHeight = 692
  ClientWidth = 1125
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 1125
    Height = 64
    Title = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1099#1077' '#1088#1072#1089#1093#1086#1076#1099
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
    ImageList = dmAdditions.cxImageList_DialogIcons
    ImageIndex = 11
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 1109
    Height = 566
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 1
    object cxGrid: TcxGrid
      Left = 0
      Top = 30
      Width = 1109
      Height = 536
      Align = alClient
      TabOrder = 0
      object cxGridTable: TcxGridDBTableView
        OnKeyDown = cxGridTableKeyDown
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        OnFocusedRecordChanged = cxGridTableFocusedRecordChanged
        DataController.DataSource = IBCDataSourceExp
        DataController.KeyFieldNames = 'ADDEXPENSEID'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.IncSearch = True
        OptionsCustomize.ColumnsQuickCustomization = True
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.InvertSelect = False
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
        OptionsView.ScrollBars = ssVertical
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        Styles.Header = dmAdditions.cxStyle_GridHeader
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        object cxGrid_ADDEXPENSEID: TcxGridDBColumn
          Caption = 'ID'
          DataBinding.FieldName = 'ADDEXPENSEID'
          Visible = False
          HeaderAlignmentHorz = taCenter
          MinWidth = 50
          Options.Filtering = False
          Options.HorzSizing = False
          Width = 50
        end
        object cxGrid_DOCTYPE_NAME: TcxGridDBColumn
          Caption = #1058#1080#1087' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
          DataBinding.FieldName = 'DOCTYPE_NAME'
          Width = 100
        end
        object cxGrid_DOCID: TcxGridDBColumn
          Caption = #1044#1086#1082'. ID'
          DataBinding.FieldName = 'DOCID'
          HeaderAlignmentHorz = taCenter
          MinWidth = 60
          Options.HorzSizing = False
          Width = 60
        end
        object cxGrid_CREATED_DATE: TcxGridDBColumn
          Caption = #1044#1072#1090#1072
          DataBinding.FieldName = 'CREATED_DATE'
          OnGetDisplayText = cxGrid_CREATED_DATEGetDisplayText
          HeaderAlignmentHorz = taCenter
          MinWidth = 110
          Options.Filtering = False
          Options.HorzSizing = False
          Width = 110
        end
        object cxGrid_DT_NAME: TcxGridDBColumn
          Caption = #1060#1080#1088#1084#1072
          DataBinding.FieldName = 'DT_NAME'
          Width = 100
        end
        object cxGrid_CT_NAME: TcxGridDBColumn
          Caption = #1050#1086#1085#1090#1088#1072#1075#1077#1085#1090
          DataBinding.FieldName = 'CT_NAME'
          Width = 100
        end
        object cxGrid_ANALITICA_TITLE: TcxGridDBColumn
          Caption = #1040#1085#1072#1083#1080#1090#1080#1082#1072
          DataBinding.FieldName = 'ANALITICA_TITLE'
          Width = 100
        end
        object cxGrid_DETAILS: TcxGridDBColumn
          Caption = #1054#1087#1080#1089#1072#1085#1080#1077
          DataBinding.FieldName = 'DETAILS'
          Options.Filtering = False
          Width = 100
        end
        object cxGrid_SUMA: TcxGridDBColumn
          Caption = #1057#1091#1084#1084#1072
          DataBinding.FieldName = 'SUMA'
          HeaderAlignmentHorz = taCenter
          MinWidth = 60
          Options.Filtering = False
          Options.HorzSizing = False
          Width = 60
        end
        object cxGrid_CREATED_BY_NAME: TcxGridDBColumn
          Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
          DataBinding.FieldName = 'CREATED_BY_NAME'
          Width = 100
        end
      end
      object cxGridLevel: TcxGridLevel
        GridView = cxGridTable
      end
    end
    object dxBarDockControl1: TdxBarDockControl
      Left = 0
      Top = 0
      Width = 1109
      Height = 30
      Align = dalTop
      BarManager = dxBarManager1
      SunkenBorder = True
      UseOwnSunkenBorder = True
    end
  end
  object btnClose: TButton
    Left = 1020
    Top = 649
    Width = 90
    Height = 29
    Cancel = True
    Caption = #1047#1072#1082#1088#1099#1090#1100
    ModalResult = 1
    TabOrder = 2
  end
  object dxBarManager1: TdxBarManager
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
    Left = 456
    Top = 12
    PixelsPerInch = 96
    object dxBarManager1Bar1: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 836
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbNew'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbEdit'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbDelete'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object bbNew: TdxBarButton
      Caption = #1053#1086#1074#1099#1081
      Category = 0
      Hint = #1053#1086#1074#1099#1081
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 45
      OnClick = bbNewClick
    end
    object bbEdit: TdxBarButton
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      Category = 0
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 115
      OnClick = bbEditClick
    end
    object bbDelete: TdxBarButton
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Category = 0
      Hint = #1059#1076#1072#1083#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 42
      ShortCut = 46
      OnClick = bbDeleteClick
    end
  end
  object IBCDataSourceExp: TIBCDataSource
    DataSet = IBCQueryExp
    Left = 76
    Top = 216
  end
  object IBCQueryExp: TIBCQuery
    KeyFields = 'ADDEXPENSEID'
    KeyGenerator = 'SQ_TDB_ADD_EXPENSES_ID'
    GeneratorMode = gmInsert
    SQLInsert.Strings = (
      'INSERT INTO TDB_ADD_EXPENSES'
      '  (ADDEXPENSEID, DOCID, DT, CT, ANALITICAID, DETAILS, SUMA)'
      'VALUES'
      
        '  (:ADDEXPENSEID, :DOCID, :DT, :CT, :ANALITICAID, :DETAILS, :SUM' +
        'A)')
    SQLDelete.Strings = (
      'DELETE FROM TDB_ADD_EXPENSES'
      'WHERE'
      '  ADDEXPENSEID = :Old_ADDEXPENSEID')
    SQLUpdate.Strings = (
      'UPDATE TDB_ADD_EXPENSES'
      'SET'
      ' DOCID = :DOCID, '
      ' DT = :DT, '
      ' CT = :CT, '
      ' ANALITICAID = :ANALITICAID,'
      ' DETAILS = :DETAILS, '
      ' SUMA = :SUMA'
      'WHERE'
      ' ADDEXPENSEID = :Old_ADDEXPENSEID')
    SQLRefresh.Strings = (
      'SELECT '
      '*'
      'FROM '
      ' VW_TDB_ADD_EXPENSES'
      'WHERE'
      ' ADDEXPENSEID = :ADDEXPENSEID')
    SQLLock.Strings = (
      'SELECT NULL FROM TDB_ADD_EXPENSES'
      'WHERE'
      ' ADDEXPENSEID = :Old_ADDEXPENSEID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = IBCTrUpdate
    SQL.Strings = (
      'SELECT'
      '*'
      'FROM '
      ' VW_TDB_ADD_EXPENSES')
    AutoCommit = False
    LockMode = lmLockImmediate
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Left = 76
    Top = 152
  end
  object IBCTrUpdate: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 76
    Top = 284
  end
end
