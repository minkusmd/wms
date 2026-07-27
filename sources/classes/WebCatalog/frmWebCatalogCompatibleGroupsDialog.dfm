object frmWebCatalogCompatibleGroupsDlg: TfrmWebCatalogCompatibleGroupsDlg
  Left = 0
  Top = 0
  ActiveControl = cxGrid
  BorderStyle = bsDialog
  Caption = #1057#1086#1074#1084#1077#1089#1090#1080#1084#1099#1077' '#1090#1086#1074#1072#1088#1099
  ClientHeight = 330
  ClientWidth = 564
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
    Width = 564
    Height = 64
    Title = #1057#1086#1074#1084#1077#1089#1090#1080#1084#1099#1077' '#1090#1086#1074#1072#1088#1099
    Text = #1042#1099#1073#1077#1088#1080#1090#1077' '#1075#1088#1091#1087#1087#1099' '#1089#1086#1074#1084#1077#1089#1090#1080#1084#1099#1093' '#1090#1086#1074#1072#1088#1086#1074
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
  object btnClose: TButton
    Left = 456
    Top = 288
    Width = 90
    Height = 29
    Cancel = True
    Caption = #1047#1072#1082#1088#1099#1090#1100
    ModalResult = 1
    TabOrder = 1
  end
  object pnClient: TPanel
    Left = 0
    Top = 64
    Width = 564
    Height = 209
    Align = alTop
    BevelOuter = bvNone
    Padding.Left = 8
    Padding.Top = 8
    Padding.Right = 8
    ShowCaption = False
    TabOrder = 2
    object dxBarDockControl1: TdxBarDockControl
      Left = 8
      Top = 8
      Width = 548
      Height = 30
      Align = dalTop
      BarManager = dxBarManager
      SunkenBorder = True
      UseOwnSunkenBorder = True
    end
    object cxGrid: TcxGrid
      Left = 8
      Top = 38
      Width = 548
      Height = 171
      Align = alClient
      TabOrder = 1
      object cxGridTable: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        OnFocusedRecordChanged = cxGridTableFocusedRecordChanged
        DataController.DataSource = IBCDataSourceCompatible
        DataController.KeyFieldNames = 'PARENT_CATALOGID;COMPATIBLE_CATALOGID'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnGrouping = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsSelection.InvertSelect = False
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
        OptionsView.ScrollBars = ssVertical
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        Styles.Header = dmAdditions.cxStyle_GridHeader
        object cxGrid_COMPATIBLE_CATALOGID: TcxGridDBColumn
          Caption = #1050#1086#1076
          DataBinding.FieldName = 'COMPATIBLE_CATALOGID'
          HeaderAlignmentHorz = taCenter
          MinWidth = 50
          Options.HorzSizing = False
          Width = 50
        end
        object cxGrid_COMPATIBLE_TITLE_ROM: TcxGridDBColumn
          Caption = 'Denumirea'
          DataBinding.FieldName = 'COMPATIBLE_TITLE_ROM'
          Width = 100
        end
        object cxGrid_COMPATIBLE_TITLE_RUS: TcxGridDBColumn
          Caption = #1053#1072#1079#1074#1072#1085#1080#1077
          DataBinding.FieldName = 'COMPATIBLE_TITLE_RUS'
          Width = 100
        end
      end
      object cxGridLevel: TcxGridLevel
        GridView = cxGridTable
      end
    end
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
    Left = 368
    Top = 8
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
      FloatLeft = 588
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbAdd'
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
    object bbAdd: TdxBarButton
      Caption = #1053#1086#1074#1072#1103
      Category = 0
      Hint = #1053#1086#1074#1072#1103
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 45
      OnClick = bbAddClick
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
  object IBCQueryCompatible: TIBCQuery
    SQLInsert.Strings = (
      'INSERT INTO TWEB_CATALOG_COMPATIBLE'
      '  (PARENT_CATALOGID, COMPATIBLE_CATALOGID)'
      'VALUES'
      '  (:PARENT_CATALOGID, :COMPATIBLE_CATALOGID)')
    SQLDelete.Strings = (
      'DELETE FROM TWEB_CATALOG_COMPATIBLE'
      'WHERE'
      '  PARENT_CATALOGID = :Old_PARENT_CATALOGID '
      '  AND '
      '  COMPATIBLE_CATALOGID = :Old_COMPATIBLE_CATALOGID')
    SQLUpdate.Strings = (
      'UPDATE TWEB_CATALOG_COMPATIBLE'
      'SET'
      '  PARENT_CATALOGID = :PARENT_CATALOGID, '
      '  COMPATIBLE_CATALOGID = :COMPATIBLE_CATALOGID'
      'WHERE'
      '  PARENT_CATALOGID = :Old_PARENT_CATALOGID '
      '  AND '
      '  COMPATIBLE_CATALOGID = :Old_COMPATIBLE_CATALOGID')
    SQLRefresh.Strings = (
      'SELECT '
      ' PARENT_CATALOGID, '
      ' COMPATIBLE_CATALOGID, '
      ' PARENT_TITLE_ROM, '
      ' PARENT_TITLE_RUS, '
      ' COMPATIBLE_TITLE_ROM, '
      ' COMPATIBLE_TITLE_RUS '
      'FROM '
      ' VW_TWEB_CATALOG_COMPATIBLE'
      'WHERE'
      ' PARENT_CATALOGID = :PARENT_CATALOGID '
      ' AND '
      ' COMPATIBLE_CATALOGID = :COMPATIBLE_CATALOGID')
    SQLLock.Strings = (
      'SELECT NULL FROM TWEB_CATALOG_COMPATIBLE'
      'WHERE'
      ' PARENT_CATALOGID = :Old_PARENT_CATALOGID '
      ' AND '
      ' COMPATIBLE_CATALOGID = :Old_COMPATIBLE_CATALOGID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT '
      ' PARENT_CATALOGID, '
      ' COMPATIBLE_CATALOGID, '
      ' PARENT_TITLE_ROM, '
      ' PARENT_TITLE_RUS, '
      ' COMPATIBLE_TITLE_ROM, '
      ' COMPATIBLE_TITLE_RUS '
      'FROM '
      ' VW_TWEB_CATALOG_COMPATIBLE'
      'WHERE'
      ' PARENT_CATALOGID = :id')
    AutoCommit = False
    LockMode = lmLockImmediate
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Options.RequiredFields = False
    LocalConstraints = False
    Left = 88
    Top = 200
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        Value = nil
      end>
  end
  object IBCDataSourceCompatible: TIBCDataSource
    DataSet = IBCQueryCompatible
    Left = 88
    Top = 140
  end
end
