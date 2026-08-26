object frmSerialNumbersCardDlg: TfrmSerialNumbersCardDlg
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = #1057#1077#1088#1080#1081#1085#1099#1077' '#1085#1086#1084#1077#1088#1072' '#1076#1083#1103' '#1082#1072#1088#1090#1086#1095#1077#1082
  ClientHeight = 564
  ClientWidth = 551
  Color = clBtnFace
  Constraints.MaxWidth = 600
  Constraints.MinHeight = 600
  Constraints.MinWidth = 500
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 551
    Height = 64
    Title = #1057#1077#1088#1080#1081#1085#1099#1077' '#1085#1086#1084#1077#1088#1072' '#1076#1083#1103' '#1082#1072#1088#1090#1086#1095#1077#1082
    Text = #1059#1087#1088#1072#1074#1083#1077#1085#1080#1077' '#1089#1077#1088#1080#1081#1085#1099#1084#1080' '#1085#1086#1084#1077#1088#1072#1084#1080' '#1074#1099#1073#1088#1072#1085#1085#1086#1075#1086' '#1090#1086#1074#1072#1088#1072
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
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 535
    Height = 437
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 1
    Align = alTop
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    object lbInfo: TLabel
      AlignWithMargins = True
      Left = 8
      Top = 407
      Width = 515
      Height = 18
      Margins.Left = 8
      Margins.Top = 8
      Margins.Right = 8
      Margins.Bottom = 8
      Align = alBottom
      Alignment = taCenter
      AutoSize = False
      Color = 28895
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = False
      Layout = tlCenter
      ExplicitLeft = -35
      ExplicitTop = 417
      ExplicitWidth = 656
    end
    object pnGoods: TPanel
      Left = 0
      Top = 0
      Width = 531
      Height = 47
      Align = alTop
      BevelOuter = bvNone
      Color = clWindow
      ParentBackground = False
      TabOrder = 0
      DesignSize = (
        531
        47)
      object cxLabel2: TLabel
        Left = 432
        Top = 17
        Width = 39
        Height = 15
        Caption = #1050#1086#1083'-'#1074#1086
        Transparent = True
      end
      object edGoodsName: TcxTextEdit
        Left = 156
        Top = 14
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        Properties.AutoSelect = False
        Properties.ReadOnly = True
        TabOrder = 0
        Text = 'edGoodsName'
        Width = 265
      end
      object edGoodsID: TcxTextEdit
        Left = 105
        Top = 14
        TabStop = False
        Properties.Alignment.Horz = taRightJustify
        Properties.ReadOnly = True
        TabOrder = 1
        Text = 'edGoodsID'
        Width = 48
      end
      object cxLabel1: TcxLabel
        Left = 12
        Top = 15
        Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
        Transparent = True
      end
      object edQTY: TcxTextEdit
        Left = 477
        Top = 14
        TabStop = False
        Properties.ReadOnly = True
        Style.TextStyle = [fsBold]
        TabOrder = 3
        Width = 46
      end
    end
    object dxBarDockControl1: TdxBarDockControl
      AlignWithMargins = True
      Left = 8
      Top = 47
      Width = 515
      Height = 30
      Margins.Left = 8
      Margins.Top = 0
      Margins.Right = 8
      Margins.Bottom = 0
      Align = dalTop
      BarManager = dxBarManager
      SunkenBorder = True
      UseOwnSunkenBorder = True
    end
    object cxGridSerials: TcxGrid
      AlignWithMargins = True
      Left = 8
      Top = 77
      Width = 515
      Height = 322
      Margins.Left = 8
      Margins.Top = 0
      Margins.Right = 8
      Margins.Bottom = 0
      Align = alClient
      TabOrder = 2
      object cxGridSerialsTable: TcxGridDBTableView
        NavigatorButtons.ConfirmDelete = False
        NavigatorButtons.First.Visible = True
        NavigatorButtons.PriorPage.Visible = True
        NavigatorButtons.Prior.Visible = True
        NavigatorButtons.Next.Visible = True
        NavigatorButtons.NextPage.Visible = True
        NavigatorButtons.Last.Visible = True
        NavigatorButtons.Insert.Visible = True
        NavigatorButtons.Append.Visible = False
        NavigatorButtons.Delete.Visible = True
        NavigatorButtons.Edit.Visible = True
        NavigatorButtons.Post.Visible = True
        NavigatorButtons.Cancel.Visible = True
        NavigatorButtons.Refresh.Visible = True
        NavigatorButtons.SaveBookmark.Visible = True
        NavigatorButtons.GotoBookmark.Visible = True
        NavigatorButtons.Filter.Visible = True
        OnCellDblClick = cxGridSerialsTableCellDblClick
        OnFocusedRecordChanged = cxGridSerialsTableFocusedRecordChanged
        DataController.DataModeController.GridMode = True
        DataController.DataSource = IBCDataSourceSNCard
        DataController.KeyFieldNames = 'DOCID;DTDEP;CTDEP;GOODSCOMPLECT_ID;GOODSID;SN'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnMoving = False
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsSelection.InvertSelect = False
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
        OptionsView.ScrollBars = ssVertical
        OptionsView.ShowEditButtons = gsebForFocusedRecord
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        Styles.ContentEven = dmAdditions.cxStyle_GridContentEven
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        Styles.Header = dmAdditions.cxStyle_GridHeader
        object cxGridSerialsTable_IMG: TcxGridDBColumn
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.DefaultImageIndex = 31
          Properties.Images = dmAdditions.cxImageList_SWN
          Properties.Items = <>
          MinWidth = 24
          Options.Filtering = False
          Options.IncSearch = False
          Options.ShowEditButtons = isebNever
          Options.HorzSizing = False
          Options.Moving = False
          Options.ShowCaption = False
          Options.Sorting = False
          Width = 24
        end
        object cxGridSerialsTable_SN: TcxGridDBColumn
          Caption = #1057#1077#1088#1080#1081#1085#1099#1081' '#1085#1086#1084#1077#1088
          DataBinding.FieldName = 'SN'
          Width = 100
        end
        object cxGridSerialsTable_PRICECOLUMN: TcxGridDBColumn
          Caption = #1050#1086#1083#1086#1085#1082#1072' '#1094#1077#1085
          DataBinding.FieldName = 'PRICECOLUMN'
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taCenter
          HeaderAlignmentHorz = taCenter
          MinWidth = 80
          Options.Filtering = False
          Options.HorzSizing = False
          Width = 80
        end
        object cxGridSerialsTable_SERVICEDISCOUNT: TcxGridDBColumn
          Caption = #1057#1082#1080#1076#1082#1072' '#1085#1072' '#1089#1077#1088#1074#1080#1089
          DataBinding.FieldName = 'SERVICEDISCOUNT'
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taCenter
          OnGetDisplayText = cxGridSerialsTable_SERVICEDISCOUNTGetDisplayText
          HeaderAlignmentHorz = taCenter
          MinWidth = 100
          Options.Filtering = False
          Options.HorzSizing = False
          Width = 100
        end
      end
      object cxGridSerialsLevel: TcxGridLevel
        GridView = cxGridSerialsTable
      end
    end
  end
  object pnBottom: TPanel
    Left = 0
    Top = 521
    Width = 551
    Height = 43
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    DesignSize = (
      551
      43)
    object btnOk: TcxButton
      Left = 334
      Top = 0
      Width = 90
      Height = 29
      Anchors = [akTop, akRight]
      Caption = '&Ok'
      TabOrder = 0
      OnClick = btnOkClick
    end
    object btnCancel: TcxButton
      Left = 438
      Top = 0
      Width = 90
      Height = 29
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100
      ModalResult = 2
      TabOrder = 1
    end
  end
  object dxBarManager: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'General'
      'Tools')
    Categories.ItemsVisibles = (
      2
      2)
    Categories.Visibles = (
      True
      True)
    ImageOptions.Images = dmAdditions.cxImageList_SWN
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 412
    Top = 252
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
      Caption = 'NPN'
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 3
      FloatTop = 386
      FloatClientWidth = 110
      FloatClientHeight = 79
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbNewSerial'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbModifySerial'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbRemoveSerial'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarSubItem1'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object bbNewSerial: TdxBarButton
      Caption = #1053#1086#1074#1099#1081
      Category = 0
      Hint = #1053#1086#1074#1099#1081
      Visible = ivAlways
      ImageIndex = 40
      OnClick = bbNewSerialClick
    end
    object bbModifySerial: TdxBarButton
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      Category = 0
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 115
      OnClick = bbModifySerialClick
    end
    object bbRemoveSerial: TdxBarButton
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Category = 0
      Hint = #1059#1076#1072#1083#1080#1090#1100
      Visible = ivAlways
      ButtonStyle = bsDropDown
      DropDownMenu = dxBarDelPopupMenu
      ImageIndex = 42
      ShortCut = 46
      OnClick = bbRemoveSerialClick
    end
    object dxBarSubItem1: TdxBarSubItem
      Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1086
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbGenerateSerials'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton3'
        end>
    end
    object bbRemoveAllSerials: TdxBarButton
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1074#1089#1077' '#1085#1086#1084#1077#1088#1072
      Category = 0
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1074#1089#1077' '#1085#1086#1084#1077#1088#1072
      Visible = ivAlways
      OnClick = bbRemoveAllSerialsClick
    end
    object dxBarButton3: TdxBarButton
      Caption = #1069#1082#1089#1087#1086#1088#1090' '#1089#1077#1088#1080#1081#1085#1099#1093' '#1085#1086#1084#1077#1088#1086#1074'...'
      Category = 1
      Hint = #1069#1082#1089#1087#1086#1088#1090' '#1089#1077#1088#1080#1081#1085#1099#1093' '#1085#1086#1084#1077#1088#1086#1074
      Visible = ivAlways
    end
    object bbGenerateSerials: TdxBarButton
      Caption = #1043#1077#1085#1077#1088#1072#1090#1086#1088' '#1085#1086#1084#1077#1088#1086#1074'...'
      Category = 1
      Hint = #1043#1077#1085#1077#1088#1072#1090#1086#1088' '#1085#1086#1084#1077#1088#1086#1074
      Visible = ivAlways
    end
  end
  object IBCQuerySNCard: TIBCQuery
    UpdatingTable = 'VW_TDB_SN_CARDS'
    SQLInsert.Strings = (
      'INSERT INTO VW_TDB_SN_CARDS'
      
        '  (DOCID, DTDEP, CTDEP, GOODSCOMPLECT_ID, GOODSID, SN, COMPLECT_' +
        'SN, '
      '   CREATED_BY, PRICECOLUMN, SERVICEDISCOUNT)'
      'VALUES'
      
        '  (:DOCID, :DTDEP, :CTDEP, :GOODSCOMPLECT_ID, :GOODSID, :SN, :CO' +
        'MPLECT_SN, '
      '  :CREATED_BY, :PRICECOLUMN, :SERVICEDISCOUNT)')
    SQLDelete.Strings = (
      'DELETE FROM VW_TDB_SN_CARDS'
      'WHERE'
      ' DOCID = :Old_DOCID AND '
      ' DTDEP = :Old_DTDEP AND '
      ' CTDEP = :Old_CTDEP AND '
      ' GOODSCOMPLECT_ID = :Old_GOODSCOMPLECT_ID AND '
      ' GOODSID = :Old_GOODSID AND '
      ' SN = :Old_SN')
    SQLUpdate.Strings = (
      'UPDATE VW_TDB_SN_CARDS'
      'SET'
      ' DOCID = :DOCID, '
      ' DTDEP = :DTDEP,'
      ' CTDEP = :CTDEP,'
      ' GOODSCOMPLECT_ID = :GOODSCOMPLECT_ID,'
      ' GOODSID = :GOODSID,'
      ' SN = :SN, '
      ' COMPLECT_SN = :COMPLECT_SN,'
      ' CREATED_BY = :CREATED_BY,'
      ' PRICECOLUMN = :PRICECOLUMN, '
      ' SERVICEDISCOUNT = :SERVICEDISCOUNT'
      'WHERE'
      ' DOCID = :Old_DOCID AND '
      ' DTDEP = :Old_DTDEP AND '
      ' CTDEP = :Old_CTDEP AND '
      ' GOODSCOMPLECT_ID = :Old_GOODSCOMPLECT_ID AND '
      ' GOODSID = :Old_GOODSID AND '
      ' SN = :Old_SN')
    SQLRefresh.Strings = (
      'SELECT'
      ' DOCID,'
      ' DTDEP,'
      ' CTDEP,'
      ' GOODSCOMPLECT_ID,'
      ' GOODSID,'
      ' SN,'
      ' COMPLECT_SN,'
      ' CREATED_BY,'
      ' PRICECOLUMN,'
      ' SERVICEDISCOUNT,'
      ' CREATED_BY_NAME'
      'FROM'
      '  VW_TDB_SN_CARDS'
      'WHERE'
      ' DOCID = :DOCID AND '
      ' DTDEP = :DTDEP AND '
      ' CTDEP = :CTDEP AND '
      ' GOODSCOMPLECT_ID = :GOODSCOMPLECT_ID AND '
      ' GOODSID = :GOODSID AND '
      ' SN = :SN')
    SQLLock.Strings = (
      'SELECT NULL FROM TDB_SN_CARDS'
      'WHERE'
      ' DOCID = :Old_DOCID AND '
      ' DTDEP = :Old_DTDEP AND '
      ' CTDEP = :Old_CTDEP AND '
      ' GOODSCOMPLECT_ID = :Old_GOODSCOMPLECT_ID AND '
      ' GOODSID = :Old_GOODSID AND '
      ' SN = :Old_SN'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT'
      ' DOCID,'
      ' DTDEP,'
      ' CTDEP,'
      ' GOODSCOMPLECT_ID,'
      ' GOODSID,'
      ' SN,'
      ' COMPLECT_SN,'
      ' CREATED_BY,'
      ' PRICECOLUMN,'
      ' SERVICEDISCOUNT,'
      ' CREATED_BY_NAME'
      'FROM'
      ' VW_TDB_SN_CARDS')
    MasterFields = 'DOCID;DTDEP;CTDEP;GOODSCOMPLECT_ID;GOODSID'
    DetailFields = 'DOCID;DTDEP;CTDEP;GOODSCOMPLECT_ID;GOODSID'
    AutoCommit = False
    LockMode = lmLockImmediate
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Options.QueryRecCount = True
    Left = 148
    Top = 280
  end
  object IBCDataSourceSNCard: TIBCDataSource
    DataSet = IBCQuerySNCard
    Left = 148
    Top = 232
  end
  object dxBarDelPopupMenu: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbRemoveAllSerials'
      end>
    UseOwnFont = False
    Left = 260
    Top = 188
  end
end
