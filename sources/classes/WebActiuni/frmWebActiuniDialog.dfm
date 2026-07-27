object frmWebActiuniDlg: TfrmWebActiuniDlg
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = #1042#1077#1073'-'#1072#1082#1094#1080#1080
  ClientHeight = 660
  ClientWidth = 981
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 981
    Height = 64
    Title = #1042#1077#1073'-'#1072#1082#1094#1080#1080
    Text = #1059#1087#1088#1072#1074#1083#1077#1085#1080#1077' '#1074#1077#1073'-'#1072#1082#1094#1080#1103#1084#1080' '#1085#1072' '#1089#1072#1081#1090#1077
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
    Width = 965
    Height = 529
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alClient
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 1
    object pnLeft: TPanel
      Left = 0
      Top = 0
      Width = 398
      Height = 529
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 0
      object cxGridActiuni: TcxGrid
        Left = 0
        Top = 30
        Width = 398
        Height = 499
        Align = alClient
        TabOrder = 0
        object cxGridATable: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          ScrollbarAnnotations.CustomAnnotations = <>
          OnCellDblClick = cxGridATableCellDblClick
          OnFocusedRecordChanged = cxGridATableFocusedRecordChanged
          DataController.DataSource = IBCDataSourceActiuni
          DataController.KeyFieldNames = 'ACTIUNEID'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsCustomize.ColumnFiltering = False
          OptionsCustomize.ColumnSorting = False
          OptionsCustomize.ColumnsQuickCustomization = True
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
          OptionsView.ScrollBars = ssVertical
          OptionsView.ColumnAutoWidth = True
          OptionsView.GridLineColor = 13750737
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          Styles.Header = dmAdditions.cxStyle_GridHeader
          Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
          object cxGridA_ACTIUNEID: TcxGridDBColumn
            Caption = 'ID'
            DataBinding.FieldName = 'ACTIUNEID'
            Visible = False
            HeaderAlignmentHorz = taCenter
            MinWidth = 40
            Options.HorzSizing = False
            Width = 40
          end
          object cxGridA_TITLE_RUS: TcxGridDBColumn
            Caption = #1040#1082#1094#1080#1103
            DataBinding.FieldName = 'TITLE_RUS'
          end
          object cxGridA_START_DATE: TcxGridDBColumn
            Caption = #1053#1072#1095#1072#1083#1086
            DataBinding.FieldName = 'START_DATE'
            HeaderAlignmentHorz = taCenter
            MinWidth = 70
            Options.HorzSizing = False
            Width = 70
          end
          object cxGridA_END_DATE: TcxGridDBColumn
            Caption = #1050#1086#1085#1077#1094
            DataBinding.FieldName = 'END_DATE'
            HeaderAlignmentHorz = taCenter
            MinWidth = 70
            Options.HorzSizing = False
            Width = 70
          end
          object cxGridA_FLG_ENDED: TcxGridDBColumn
            DataBinding.FieldName = 'FLG_ENDED'
            Visible = False
            VisibleForCustomization = False
          end
        end
        object cxGridALevel: TcxGridLevel
          GridView = cxGridATable
        end
      end
      object dxBarDockControl1: TdxBarDockControl
        Left = 0
        Top = 0
        Width = 398
        Height = 30
        Align = dalTop
        BarManager = dxBarManager
        SunkenBorder = True
        UseOwnSunkenBorder = True
      end
    end
    object pnRight: TPanel
      Left = 398
      Top = 0
      Width = 567
      Height = 529
      Align = alClient
      BevelOuter = bvNone
      Padding.Left = 2
      TabOrder = 1
      object cxGridGoods: TcxGrid
        Left = 2
        Top = 30
        Width = 565
        Height = 352
        Align = alClient
        TabOrder = 0
        object cxGridGTable: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          ScrollbarAnnotations.CustomAnnotations = <>
          OnFocusedRecordChanged = cxGridGTableFocusedRecordChanged
          DataController.DataSource = IBCDataSourceGoods
          DataController.KeyFieldNames = 'ACTIUNEID;GOODSID'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <
            item
              Kind = skCount
              Column = cxGridG_TITLE
            end>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.IncSearch = True
          OptionsCustomize.ColumnFiltering = False
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
          Styles.Header = dmAdditions.cxStyle_GridHeader
          Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
          object cxGridG_GOODSID: TcxGridDBColumn
            Caption = 'ID'
            DataBinding.FieldName = 'GOODSID'
            HeaderAlignmentHorz = taCenter
            MinWidth = 50
            Options.HorzSizing = False
            SortIndex = 0
            SortOrder = soAscending
            Width = 50
          end
          object cxGridG_IMG: TcxGridDBColumn
            PropertiesClassName = 'TcxImageComboBoxProperties'
            Properties.DefaultImageIndex = 12
            Properties.Images = dmAdditions.cxImageList_SWN
            Properties.Items = <>
            MinWidth = 24
            Options.Focusing = False
            Options.HorzSizing = False
            Options.Moving = False
            Options.Sorting = False
            VisibleForCustomization = False
            Width = 24
          end
          object cxGridG_TITLE: TcxGridDBColumn
            Caption = #1058#1086#1074#1072#1088
            DataBinding.FieldName = 'TITLE'
          end
        end
        object cxGridGLevel: TcxGridLevel
          GridView = cxGridGTable
        end
      end
      object dxBarDockControl2: TdxBarDockControl
        Left = 2
        Top = 0
        Width = 565
        Height = 30
        Align = dalTop
        BarManager = dxBarManager
        SunkenBorder = True
        UseOwnSunkenBorder = True
      end
      object pnClientBottom: TPanel
        AlignWithMargins = True
        Left = 2
        Top = 386
        Width = 565
        Height = 143
        Margins.Left = 0
        Margins.Top = 4
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alBottom
        BevelKind = bkFlat
        BevelOuter = bvNone
        ShowCaption = False
        TabOrder = 2
        object cxDBImage1: TcxDBImage
          Left = 8
          Top = 8
          DataBinding.DataField = 'IMAGE'
          DataBinding.DataSource = IBCDataSourceGoodsInfo
          Enabled = False
          Properties.GraphicClassName = 'TdxPNGImage'
          TabOrder = 0
          Height = 120
          Width = 120
        end
        object cxDBLabel1: TcxDBLabel
          Left = 134
          Top = 8
          DataBinding.DataField = 'VENDOR'
          DataBinding.DataSource = IBCDataSourceGoodsInfo
          ParentColor = False
          Properties.ShowEndEllipsis = True
          Style.BorderStyle = ebsFlat
          Style.Color = clWindow
          Height = 21
          Width = 407
        end
        object cxDBLabel2: TcxDBLabel
          Left = 134
          Top = 35
          DataBinding.DataField = 'BASE_PARAM'
          DataBinding.DataSource = IBCDataSourceGoodsInfo
          ParentColor = False
          Properties.ShowEndEllipsis = True
          Style.BorderStyle = ebsFlat
          Style.Color = clWindow
          Height = 21
          Width = 135
        end
        object cxDBLabel3: TcxDBLabel
          Left = 275
          Top = 35
          DataBinding.DataField = 'CODE'
          DataBinding.DataSource = IBCDataSourceGoodsInfo
          ParentColor = False
          Properties.ShowEndEllipsis = True
          Style.BorderStyle = ebsFlat
          Style.Color = clWindow
          Height = 21
          Width = 266
        end
        object cxDBLabel4: TcxDBLabel
          Left = 134
          Top = 62
          DataBinding.DataField = 'DETAILS'
          DataBinding.DataSource = IBCDataSourceGoodsInfo
          ParentColor = False
          Properties.ShowEndEllipsis = True
          Style.BorderStyle = ebsFlat
          Style.Color = clWindow
          Height = 21
          Width = 407
        end
        object cxDBLabel5: TcxDBLabel
          Left = 134
          Top = 89
          Hint = #1062#1077#1085#1072' 1'
          DataBinding.DataField = 'PRICE1_LEI'
          DataBinding.DataSource = IBCDataSourceGoodsInfo
          ParentColor = False
          ParentShowHint = False
          Properties.ShowEndEllipsis = True
          ShowHint = True
          Style.BorderStyle = ebsFlat
          Style.Color = clWindow
          Height = 21
          Width = 95
        end
        object cxDBLabel6: TcxDBLabel
          Left = 235
          Top = 89
          Hint = #1062#1077#1085#1072' 2'
          DataBinding.DataField = 'PRICE2_LEI'
          DataBinding.DataSource = IBCDataSourceGoodsInfo
          ParentColor = False
          ParentShowHint = False
          Properties.ShowEndEllipsis = True
          ShowHint = True
          Style.BorderStyle = ebsFlat
          Style.Color = clWindow
          Height = 21
          Width = 95
        end
        object cxDBLabel7: TcxDBLabel
          Left = 336
          Top = 89
          Hint = #1062#1077#1085#1072' 3'
          DataBinding.DataField = 'PRICE3_LEI'
          DataBinding.DataSource = IBCDataSourceGoodsInfo
          ParentColor = False
          ParentShowHint = False
          Properties.ShowEndEllipsis = True
          ShowHint = True
          Style.BorderStyle = ebsFlat
          Style.Color = clWindow
          Height = 21
          Width = 95
        end
        object cxDBLabel8: TcxDBLabel
          Left = 437
          Top = 89
          Hint = #1062#1077#1085#1072' 4'
          DataBinding.DataField = 'PRICE4_LEI'
          DataBinding.DataSource = IBCDataSourceGoodsInfo
          ParentColor = False
          ParentShowHint = False
          Properties.ShowEndEllipsis = True
          ShowHint = True
          Style.BorderStyle = ebsFlat
          Style.Color = clWindow
          Height = 21
          Width = 95
        end
      end
    end
  end
  object pnButtons: TPanel
    Left = 0
    Top = 609
    Width = 981
    Height = 51
    Align = alBottom
    BevelOuter = bvNone
    Padding.Left = 8
    Padding.Top = 4
    Padding.Right = 24
    Padding.Bottom = 16
    TabOrder = 2
    object btnOk: TButton
      AlignWithMargins = True
      Left = 765
      Top = 4
      Width = 90
      Height = 31
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 12
      Margins.Bottom = 0
      Align = alRight
      Caption = 'Ok'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
    object btnCancel: TButton
      Left = 867
      Top = 4
      Width = 90
      Height = 31
      Align = alRight
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
      'Default')
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    ImageOptions.Images = dmAdditions.cxImageList_SWN
    ImageOptions.StretchGlyphs = False
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 480
    Top = 12
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
      FloatLeft = 844
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbActiuneNew'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbActiuneModify'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbActiuneDelete'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbSortActiuni'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBar2: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Custom 2'
      CaptionButtons = <>
      DockControl = dxBarDockControl2
      DockedDockControl = dxBarDockControl2
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 844
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbGoodsAdd'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbGoodsDelete'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbGoodsDeleteAll'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object bbActiuneNew: TdxBarButton
      Caption = #1053#1086#1074#1072#1103
      Category = 0
      Hint = #1053#1086#1074#1072#1103
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 16429
      OnClick = bbActiuneNewClick
    end
    object bbActiuneModify: TdxBarButton
      Caption = #1048#1079#1084#1077#1085#1080#1090
      Category = 0
      Hint = #1048#1079#1084#1077#1085#1080#1090
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 113
      OnClick = bbActiuneModifyClick
    end
    object bbActiuneDelete: TdxBarButton
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Category = 0
      Hint = #1059#1076#1072#1083#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 42
      ShortCut = 16430
      OnClick = bbActiuneDeleteClick
    end
    object bbGoodsAdd: TdxBarButton
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1090#1086#1074#1072#1088
      Category = 0
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1090#1086#1074#1072#1088
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 45
      OnClick = bbGoodsAddClick
    end
    object bbGoodsDelete: TdxBarButton
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Category = 0
      Hint = #1059#1076#1072#1083#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 42
      ShortCut = 46
      OnClick = bbGoodsDeleteClick
    end
    object bbSortActiuni: TdxBarButton
      Caption = #1057#1086#1088#1090#1080#1088#1086#1074#1072#1090#1100
      Category = 0
      Hint = #1057#1086#1088#1090#1080#1088#1086#1074#1072#1090#1100
      Visible = ivAlways
      ImageIndex = 38
      OnClick = bbSortActiuniClick
    end
    object bbGoodsDeleteAll: TdxBarButton
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1074#1089#1105
      Category = 0
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1074#1089#1105
      Visible = ivAlways
      ImageIndex = 35
      OnClick = bbGoodsDeleteAllClick
    end
  end
  object IBCTrUpdate: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 64
    Top = 248
  end
  object IBCQueryActiuni: TIBCQuery
    KeyFields = 'ACTIUNEID'
    KeyGenerator = 'SQ_TWEB_ACTIUNI_ID'
    GeneratorMode = gmInsert
    SQLInsert.Strings = (
      'INSERT INTO TWEB_ACTIUNI'
      
        '  (ACTIUNEID, START_DATE, END_DATE, TITLE_ROM, TITLE_RUS, TEXT_R' +
        'OM, TEXT_RUS, IMAGE_MASK, IMAGE_LOGO, '
      
        '   BUTTON_TITLE_ROM, BUTTON_TITLE_RUS, NAV_LINK, DT, FLG_HIDE_BU' +
        'TTON)'
      'VALUES'
      
        '  (:ACTIUNEID, :START_DATE, :END_DATE, :TITLE_ROM, :TITLE_RUS, :' +
        'TEXT_ROM, :TEXT_RUS, :IMAGE_MASK, :IMAGE_LOGO,'
      
        '   :BUTTON_TITLE_ROM, :BUTTON_TITLE_RUS, :NAV_LINK, :DT, :FLG_HI' +
        'DE_BUTTON)')
    SQLDelete.Strings = (
      'DELETE FROM TWEB_ACTIUNI'
      'WHERE'
      '  ACTIUNEID = :Old_ACTIUNEID')
    SQLUpdate.Strings = (
      'UPDATE TWEB_ACTIUNI'
      'SET'
      '  ACTIUNEID = :ACTIUNEID, '
      '  DT = :DT,'
      '  START_DATE = :START_DATE, '
      '  END_DATE = :END_DATE, '
      '  TITLE_ROM = :TITLE_ROM, '
      '  TITLE_RUS = :TITLE_RUS, '
      '  TEXT_ROM = :TEXT_ROM, '
      '  TEXT_RUS = :TEXT_RUS, '
      '  IMAGE_MASK = :IMAGE_MASK, '
      '  IMAGE_LOGO = :IMAGE_LOGO, '
      '  BUTTON_TITLE_ROM = :BUTTON_TITLE_ROM, '
      '  BUTTON_TITLE_RUS = :BUTTON_TITLE_RUS,'
      '  NAV_LINK = :NAV_LINK,'
      '  FLG_HIDE_BUTTON = :FLG_HIDE_BUTTON'
      'WHERE'
      '  ACTIUNEID = :Old_ACTIUNEID')
    SQLRefresh.Strings = (
      'SELECT '
      ' ACTIUNEID, '
      ' START_DATE, '
      ' END_DATE, '
      ' TITLE_ROM, '
      ' TITLE_RUS, '
      ' TEXT_ROM, '
      ' TEXT_RUS, '
      ' IMAGE_MASK, '
      ' IMAGE_LOGO, '
      ' BUTTON_TITLE_ROM, '
      ' BUTTON_TITLE_RUS,'
      ' NAV_LINK,'
      ' FLG_HIDE_BUTTON '
      'FROM '
      ' TWEB_ACTIUNI'
      'WHERE'
      ' ACTIUNEID = :ACTIUNEID')
    SQLLock.Strings = (
      'SELECT NULL FROM TWEB_ACTIUNI'
      'WHERE'
      'ACTIUNEID = :Old_ACTIUNEID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = IBCTrUpdate
    UpdateTransaction = IBCTrUpdate
    SQL.Strings = (
      'SELECT'
      ' TWEB_ACTIUNI.*,'
      ' IIF(END_DATE<CURRENT_DATE,1,0) FLG_ENDED'
      'FROM'
      ' TWEB_ACTIUNI'
      'WHERE'
      ' DT=:DT'
      'ORDER BY'
      ' ORDERNO')
    AutoCommit = False
    LockMode = lmLockImmediate
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Options.RequiredFields = False
    LocalConstraints = False
    Left = 64
    Top = 200
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DT'
        Value = nil
      end>
  end
  object IBCDataSourceActiuni: TIBCDataSource
    DataSet = IBCQueryActiuni
    Left = 64
    Top = 156
  end
  object IBCQueryGoods: TIBCQuery
    SQLInsert.Strings = (
      'INSERT INTO TWEB_ACTIUNI_GOODS'
      '  (ACTIUNEID, GOODSID)'
      'VALUES'
      '  (:ACTIUNEID, :GOODSID)')
    SQLDelete.Strings = (
      'DELETE FROM TWEB_ACTIUNI_GOODS'
      'WHERE'
      '  ACTIUNEID = :Old_ACTIUNEID AND GOODSID = :Old_GOODSID')
    SQLRefresh.Strings = (
      'SELECT '
      ' ACTIUNEID, '
      ' GOODSID,'
      
        ' (SELECT TITLE FROM TS_GOODS WHERE TS_GOODS.GOODSID=TWEB_ACTIUNI' +
        '_GOODS.GOODSID)'
      'FROM '
      ' TWEB_ACTIUNI_GOODS'
      'WHERE'
      ' ACTIUNEID = :ACTIUNEID'
      ' AND '
      ' GOODSID = :GOODSID')
    Connection = dmDB.IBCConnection
    Transaction = IBCTrUpdate
    UpdateTransaction = IBCTrUpdate
    SQL.Strings = (
      'SELECT'
      ' ACTIUNEID,'
      ' GOODSID,'
      
        ' (SELECT TITLE FROM TS_GOODS WHERE TS_GOODS.GOODSID=TWEB_ACTIUNI' +
        '_GOODS.GOODSID)'
      'FROM'
      ' TWEB_ACTIUNI_GOODS'
      'ORDER BY GOODSID')
    MasterFields = 'ACTIUNEID'
    DetailFields = 'ACTIUNEID'
    MasterSource = IBCDataSourceActiuni
    AutoCommit = False
    RefreshOptions = [roAfterInsert]
    Options.DetailDelay = 500
    Left = 500
    Top = 228
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ACTIUNEID'
        Value = nil
      end>
  end
  object IBCDataSourceGoods: TIBCDataSource
    DataSet = IBCQueryGoods
    Left = 500
    Top = 180
  end
  object IBCQueryGoodsInfo: TIBCQuery
    SQLInsert.Strings = (
      'INSERT INTO TWEB_ACTIUNI_GOODS'
      '  (ACTIUNEID, GOODSID)'
      'VALUES'
      '  (:ACTIUNEID, :GOODSID)')
    SQLDelete.Strings = (
      'DELETE FROM TWEB_ACTIUNI_GOODS'
      'WHERE'
      '  ACTIUNEID = :Old_ACTIUNEID AND GOODSID = :Old_GOODSID')
    SQLRefresh.Strings = (
      'SELECT '
      ' ACTIUNEID, '
      ' GOODSID,'
      
        ' (SELECT TITLE FROM TS_GOODS WHERE TS_GOODS.GOODSID=TWEB_ACTIUNI' +
        '_GOODS.GOODSID)'
      'FROM '
      ' TWEB_ACTIUNI_GOODS'
      'WHERE'
      ' ACTIUNEID = :ACTIUNEID'
      ' AND '
      ' GOODSID = :GOODSID')
    Connection = dmDB.IBCConnection
    Transaction = IBCTrUpdate
    SQL.Strings = (
      'SELECT '
      
        'GOODSID, VENDOR, BASE_PARAM, CODE, DETAILS, PRICE1_LEI, PRICE2_L' +
        'EI, PRICE3_LEI, PRICE4_LEI,'
      '(SELECT FIRST 1 IMAGE'
      ' FROM TS_GOODS_IMAGE'
      ' WHERE TS_GOODS_IMAGE.GOODSID=VW_TS_GOODS.GOODSID'
      '       AND TS_GOODS_IMAGE.DATA_START IS NULL'
      '       AND TS_GOODS_IMAGE.DATA_END IS NULL'
      ' ORDER BY GOODS_IMAGE_ID'
      ') IMAGE'
      'FROM VW_TS_GOODS')
    MasterFields = 'GOODSID'
    DetailFields = 'GOODSID'
    MasterSource = IBCDataSourceGoods
    ReadOnly = True
    AutoCommit = False
    Options.DetailDelay = 500
    Left = 660
    Top = 376
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'GOODSID'
        Value = nil
      end>
  end
  object IBCDataSourceGoodsInfo: TIBCDataSource
    DataSet = IBCQueryGoodsInfo
    Left = 660
    Top = 328
  end
end
