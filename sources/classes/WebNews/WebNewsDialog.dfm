object frmWebNewsDlg: TfrmWebNewsDlg
  Left = 0
  Top = 0
  ActiveControl = cxGridNews
  BorderIcons = [biSystemMenu, biMaximize]
  BorderStyle = bsDialog
  Caption = 'Web '#1053#1086#1074#1086#1089#1090#1080
  ClientHeight = 519
  ClientWidth = 569
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
    Width = 569
    Height = 64
    Title = 'Web '#1053#1086#1074#1086#1089#1090#1080
    Text = #1059#1087#1088#1072#1074#1083#1077#1085#1080#1103' '#1085#1086#1074#1086#1089#1090#1103#1084#1080' '#1085#1072' '#1089#1072#1081#1090#1077
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
    ImageIndex = 30
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 553
    Height = 389
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    BevelOuter = bvNone
    Caption = 'pnClient'
    TabOrder = 1
    object cxGridNews: TcxGrid
      Left = 0
      Top = 30
      Width = 553
      Height = 359
      Align = alClient
      TabOrder = 1
      object cxGridNewsTable: TcxGridDBTableView
        NavigatorButtons.ConfirmDelete = False
        OnCellDblClick = cxGridNewsTableCellDblClick
        OnFocusedRecordChanged = cxGridNewsTableFocusedRecordChanged
        DataController.DataModeController.GridMode = True
        DataController.DataSource = IBCDataSourceNews
        DataController.KeyFieldNames = 'NEWSID'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnMoving = False
        OptionsCustomize.ColumnSorting = False
        OptionsCustomize.ColumnsQuickCustomization = True
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsSelection.InvertSelect = False
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1085#1086#1074#1086#1089#1090#1077#1081'>'
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        Styles.Header = dmAdditions.cxStyle_GridHeader
        object cxGridNews_NEWSID: TcxGridDBColumn
          Caption = 'ID'
          DataBinding.FieldName = 'NEWSID'
          Visible = False
          MinWidth = 40
          Options.HorzSizing = False
          Width = 40
        end
        object cxGridNews_TITLE: TcxGridDBColumn
          Caption = #1053#1086#1074#1086#1089#1090#1100
          DataBinding.FieldName = 'TITLE'
        end
        object cxGridNews_POSTEDTIME: TcxGridDBColumn
          Caption = #1044#1072#1090#1072
          DataBinding.FieldName = 'POSTEDTIME'
          HeaderAlignmentHorz = taCenter
          MinWidth = 140
          Options.HorzSizing = False
          SortIndex = 0
          SortOrder = soDescending
          Width = 140
        end
      end
      object cxGridNewsLevel: TcxGridLevel
        GridView = cxGridNewsTable
      end
    end
    object dxBarDockControl1: TdxBarDockControl
      Left = 0
      Top = 0
      Width = 553
      Height = 30
      Align = dalTop
      BarManager = dxBarManager
      SunkenBorder = True
      UseOwnSunkenBorder = True
    end
  end
  object btnClose: TButton
    Left = 460
    Top = 474
    Width = 90
    Height = 29
    Caption = #1047#1072#1082#1088#1099#1090#1100
    ModalResult = 2
    TabOrder = 6
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
    Left = 324
    Top = 8
    DockControlHeights = (
      0
      0
      0
      0)
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
      FloatLeft = 593
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbAddNew'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbModifyNews'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbDeleteNews'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = True
    end
    object bbAddNew: TdxBarButton
      Caption = #1053#1086#1074#1072#1103
      Category = 0
      Hint = #1053#1086#1074#1072#1103
      Visible = ivAlways
      ImageIndex = 40
      OnClick = bbAddNewClick
    end
    object bbModifyNews: TdxBarButton
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      Category = 0
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 41
      OnClick = bbModifyNewsClick
    end
    object bbDeleteNews: TdxBarButton
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Category = 0
      Hint = #1059#1076#1072#1083#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 42
      OnClick = bbDeleteNewsClick
    end
  end
  object IBCQueryNews: TIBCQuery
    KeyFields = 'NEWSID'
    KeyGenerator = 'SQ_TS_WEB_NEWS_ID'
    GeneratorMode = gmInsert
    SQLInsert.Strings = (
      'INSERT INTO VW_TS_WEB_NEWS'
      '  (NEWSID, TITLE, TEXT, POSTEDTIME)'
      'VALUES'
      '  (:NEWSID, :TITLE, :TEXT, :POSTEDTIME)')
    SQLDelete.Strings = (
      'DELETE FROM VW_TS_WEB_NEWS'
      'WHERE'
      '  NEWSID = :Old_NEWSID')
    SQLUpdate.Strings = (
      'UPDATE VW_TS_WEB_NEWS'
      'SET'
      ' NEWSID = :NEWSID,'
      ' TITLE = :TITLE, '
      ' TEXT = :TEXT,'
      ' POSTEDTIME = :POSTEDTIME'
      'WHERE'
      '  NEWSID = :Old_NEWSID')
    SQLRefresh.Strings = (
      'SELECT * FROM VW_TS_WEB_NEWS'
      'WHERE'
      '  NEWSID = :NEWSID')
    SQLLock.Strings = (
      'SELECT NULL FROM TS_WEB_NEWS'
      'WHERE'
      'NEWSID = :Old_NEWSID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    AutoCommit = False
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Left = 168
    Top = 256
  end
  object IBCDataSourceNews: TIBCDataSource
    DataSet = IBCQueryNews
    Left = 172
    Top = 204
  end
end
