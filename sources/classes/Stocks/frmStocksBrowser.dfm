object frmStocksBrowserDlg: TfrmStocksBrowserDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1057#1082#1083#1072#1076#1099
  ClientHeight = 487
  ClientWidth = 716
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  DesignSize = (
    716
    487)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 716
    Height = 64
    Title = #1057#1082#1083#1072#1076#1099
    Text = #1059#1087#1088#1072#1074#1083#1077#1085#1080#1077' '#1089#1082#1083#1072#1076#1072#1084#1080
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
    ImageIndex = 0
  end
  object pnMain: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 700
    Height = 361
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 0
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelOuter = bvNone
    TabOrder = 1
    object dxBarDockControl1: TdxBarDockControl
      AlignWithMargins = True
      Left = 0
      Top = 0
      Width = 700
      Height = 30
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 1
      Align = dalTop
      AllowDocking = False
      BarManager = dxBarManager
    end
    object cxGridStock: TcxGrid
      Left = 0
      Top = 31
      Width = 700
      Height = 330
      Align = alClient
      TabOrder = 1
      object cxGridStockTable: TcxGridDBTableView
        PopupMenu = dxBarPopupMenu
        OnKeyDown = cxGridStockTableKeyDown
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
        OnCellDblClick = cxGridStockTableCellDblClick
        OnFocusedRecordChanged = cxGridStockTableFocusedRecordChanged
        DataController.DataSource = IBCDataSourceStock
        DataController.KeyFieldNames = 'STOCKID'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.IncSearch = True
        OptionsBehavior.ImmediateEditor = False
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnGrouping = False
        OptionsCustomize.ColumnsQuickCustomization = True
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.InvertSelect = False
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
        OptionsView.ScrollBars = ssVertical
        OptionsView.ShowEditButtons = gsebForFocusedRecord
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        Styles.Header = dmAdditions.cxStyle_GridHeader
        object cxGridStockTable_FLG_FOLDER: TcxGridDBColumn
          DataBinding.FieldName = 'FLG_FOLDER'
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.DefaultImageIndex = 27
          Properties.Images = dmAdditions.cxImageList_SWN
          Properties.Items = <
            item
              ImageIndex = 27
              Value = 0
            end
            item
              ImageIndex = 13
              Value = 1
            end>
          Properties.ReadOnly = True
          MinWidth = 24
          Options.Editing = False
          Options.Filtering = False
          Options.Focusing = False
          Options.IncSearch = False
          Options.FilteringPopup = False
          Options.ShowEditButtons = isebNever
          Options.Grouping = False
          Options.HorzSizing = False
          Options.Moving = False
          Options.ShowCaption = False
          Options.Sorting = False
          VisibleForCustomization = False
          Width = 24
        end
        object cxGridStockTableID: TcxGridDBColumn
          AlternateCaption = #1050#1086#1076' '#1089#1082#1083#1072#1076#1072
          Caption = #1050#1086#1076
          DataBinding.FieldName = 'STOCKID'
          HeaderAlignmentHorz = taCenter
          MinWidth = 50
          Options.HorzSizing = False
          Width = 50
        end
        object cxGridStockTableTITLE: TcxGridDBColumn
          Caption = #1053#1072#1079#1074#1072#1085#1080#1077
          DataBinding.FieldName = 'TITLE'
          Styles.OnGetContentStyle = cxGridStockTableTITLEStylesGetContentStyle
          VisibleForCustomization = False
          Width = 200
        end
        object cxGridStockTableDSC: TcxGridDBColumn
          AlternateCaption = #1054#1087#1080#1089#1072#1085#1080#1077' '#1089#1082#1083#1072#1076#1072
          Caption = #1054#1087#1080#1089#1072#1085#1080#1077
          DataBinding.FieldName = 'DESCRIPTION'
          Width = 160
        end
        object cxGridStock_FLG_VISISIBLE_FOR_SALE: TcxGridDBColumn
          AlternateCaption = #1055#1088#1086#1076#1072#1078#1080
          Caption = #1055#1088#1086#1076
          DataBinding.FieldName = 'FLG_VISISIBLE_FOR_SALE'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          HeaderAlignmentHorz = taCenter
          MinWidth = 40
          Options.HorzSizing = False
          Width = 40
        end
        object cxGridStock_FLG_ADMINISTRATIA: TcxGridDBColumn
          AlternateCaption = #1040#1076#1084#1080#1085#1080#1089#1090#1088#1080#1094#1080#1103
          Caption = #1040#1076#1084
          DataBinding.FieldName = 'FLG_ADMINISTRATIA'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          HeaderAlignmentHorz = taCenter
          MinWidth = 40
          Options.HorzSizing = False
          Width = 40
        end
        object cxGridStock_FLG_RMA: TcxGridDBColumn
          AlternateCaption = #1056#1077#1084#1086#1085#1090
          Caption = 'RMA'
          DataBinding.FieldName = 'FLG_RMA'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          HeaderAlignmentHorz = taCenter
          MinWidth = 40
          Options.HorzSizing = False
          Width = 40
        end
      end
      object cxGridStockLevel: TcxGridLevel
        GridView = cxGridStockTable
      end
    end
  end
  object btnOk: TcxButton
    Left = 508
    Top = 444
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = #1042#1099#1073#1088#1072#1090#1100
    TabOrder = 2
    OnClick = btnOkClick
  end
  object btnCancel: TcxButton
    Left = 608
    Top = 444
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
  object dxBarManager: TdxBarManager
    AllowReset = False
    AutoDockColor = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    CanCustomize = False
    Categories.Strings = (
      'Default'
      'Tools')
    Categories.ItemsVisibles = (
      2
      2)
    Categories.Visibles = (
      True
      True)
    DockColor = clBtnFace
    ImageOptions.Images = dmAdditions.cxImageList_SWN
    PopupMenuLinks = <>
    ShowFullMenusAfterDelay = False
    ShowShortCutInHint = True
    SunkenBorder = True
    UseSystemFont = True
    Left = 432
    Top = 12
    PixelsPerInch = 96
    object dxBarManager1Bar2: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Toolbar'
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 38
      FloatTop = 185
      FloatClientWidth = 51
      FloatClientHeight = 24
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbHome'
        end
        item
          Visible = True
          ItemName = 'bbBack'
        end
        item
          Visible = True
          ItemName = 'bbForward'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbItem'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbAdditionalTools'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbSearch'
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
      Caption = #1053#1086#1074#1099#1081' '#1089#1082#1083#1072#1076
      Category = 0
      Hint = #1053#1086#1074#1099#1081' '#1089#1082#1083#1072#1076
      Visible = ivAlways
      ImageIndex = 27
      ShortCut = 16429
      OnClick = bbNewClick
    end
    object bbModify: TdxBarButton
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      Category = 0
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 115
      OnClick = bbModifyClick
    end
    object bbRemove: TdxBarButton
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Category = 0
      Hint = #1059#1076#1072#1083#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 42
      ShortCut = 16430
      OnClick = bbRemoveClick
    end
    object bbHome: TdxBarButton
      Caption = #1053#1072#1095#1072#1083#1086
      Category = 0
      Hint = #1053#1072#1095#1072#1083#1086
      Visible = ivAlways
      ImageIndex = 5
      ShortCut = 16420
      OnClick = bbHomeClick
    end
    object bbBack: TdxBarButton
      Caption = #1053#1072#1079#1072#1076
      Category = 0
      Hint = #1053#1072#1079#1072#1076
      Visible = ivAlways
      ImageIndex = 6
      OnClick = bbBackClick
    end
    object bbForward: TdxBarButton
      Caption = #1042#1087#1077#1088#1077#1076
      Category = 0
      Hint = #1042#1087#1077#1088#1077#1076
      Visible = ivAlways
      ImageIndex = 7
      OnClick = bbForwardClick
    end
    object bbItem: TdxBarSubItem
      Caption = #1057#1082#1083#1072#1076
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbNewFolder'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbNew'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbModify'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbRemove'
        end>
    end
    object bbNewFolder: TdxBarButton
      Caption = #1053#1086#1074#1072#1103' '#1075#1088#1091#1087#1087#1072
      Category = 0
      Hint = #1053#1086#1074#1072#1103' '#1075#1088#1091#1087#1087#1072
      Visible = ivAlways
      ImageIndex = 13
      OnClick = bbNewFolderClick
    end
    object bbAdditionalTools: TdxBarSubItem
      Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1086
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbChangeParent'
        end>
    end
    object bbSearch: TdxBarButton
      Caption = #1055#1086#1080#1089#1082
      Category = 0
      Hint = #1055#1086#1080#1089#1082
      Visible = ivAlways
      ImageIndex = 4
      ShortCut = 16454
      OnClick = bbSearchClick
    end
    object bbChangeParent: TdxBarButton
      Caption = #1048#1079#1084#1077#1085#1077#1085#1080#1077' '#1087#1088#1077#1076#1082#1072
      Category = 1
      Hint = #1048#1079#1084#1077#1085#1077#1085#1080#1077' '#1087#1088#1077#1076#1082#1072
      Visible = ivAlways
      OnClick = bbChangeParentClick
    end
  end
  object IBCQueryStock: TIBCQuery
    KeyFields = 'STOCKID'
    KeyGenerator = 'SQ_TS_STOCKS_STOCKID'
    GeneratorMode = gmInsert
    SQLInsert.Strings = (
      'INSERT INTO VW_TS_STOCKS'
      
        '  (STOCKID, PARENTID, FLG_FOLDER, TITLE, DESCRIPTION, FLG_VISISI' +
        'BLE_FOR_SALE, FLG_ADMINISTRATIA, FLG_RMA, ACC$MASK)'
      'VALUES'
      
        '  (:STOCKID, :PARENTID, :FLG_FOLDER, :TITLE, :DESCRIPTION, :FLG_' +
        'VISISIBLE_FOR_SALE, :FLG_ADMINISTRATIA, :FLG_RMA, :ACC$MASK)')
    SQLDelete.Strings = (
      'DELETE FROM TS_STOCKS'
      'WHERE'
      '  STOCKID = :Old_STOCKID')
    SQLUpdate.Strings = (
      'UPDATE VW_TS_STOCKS'
      'SET'
      
        ' STOCKID = :STOCKID, PARENTID = :PARENTID, FLG_FOLDER = :FLG_FOL' +
        'DER, TITLE = :TITLE, DESCRIPTION = :DESCRIPTION,'
      ' FLG_VISISIBLE_FOR_SALE = :FLG_VISISIBLE_FOR_SALE, '
      ' FLG_ADMINISTRATIA = :FLG_ADMINISTRATIA,'
      ' FLG_RMA = :FLG_RMA,'
      ' ACC$MASK = :ACC$MASK'
      'WHERE'
      ' STOCKID = :Old_STOCKID')
    SQLRefresh.Strings = (
      'SELECT'
      ' STOCKID,'
      ' PARENTID,'
      ' FLG_FOLDER,'
      ' TITLE,'
      ' DESCRIPTION,'
      ' FLG_VISISIBLE_FOR_SALE,'
      ' FLG_ADMINISTRATIA,'
      ' FLG_RMA,'
      ' ACC$MASK'
      'FROM'
      ' VW_TS_STOCKS'
      'WHERE'
      ' STOCKID = :STOCKID')
    SQLLock.Strings = (
      'SELECT NULL FROM TS_STOCKS'
      'WHERE'
      ' STOCKID = :Old_STOCKID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = IBCTrUpdateStocks
    SQL.Strings = (
      'SELECT'
      ' STOCKID,'
      ' PARENTID,'
      ' FLG_FOLDER,'
      ' TITLE,'
      ' DESCRIPTION,'
      ' FLG_VISISIBLE_FOR_SALE,'
      ' FLG_ADMINISTRATIA,'
      ' FLG_RMA,'
      ' ACC$MASK'
      'FROM'
      ' VW_TS_STOCKS'
      'WHERE '
      ' STOCKID>=0'
      'ORDER BY '
      ' FLG_FOLDER DESC, TITLE')
    AutoCommit = False
    LockMode = lmLockImmediate
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Options.RequiredFields = False
    LocalConstraints = False
    Left = 64
    Top = 328
  end
  object IBCDataSourceStock: TIBCDataSource
    DataSet = IBCQueryStock
    Left = 64
    Top = 272
  end
  object IBCTrUpdateStocks: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 64
    Top = 384
  end
  object dxBarPopupMenu: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbNewFolder'
      end
      item
        Visible = True
        ItemName = 'bbNew'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbModify'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbRemove'
      end>
    UseOwnFont = False
    Left = 196
    Top = 152
    PixelsPerInch = 96
  end
end
