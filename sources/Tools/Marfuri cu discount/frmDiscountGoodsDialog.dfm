object frmDiscountGoodsDlg: TfrmDiscountGoodsDlg
  Left = 0
  Top = 0
  ActiveControl = cxGridGroup
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = #1057#1082#1080#1076#1082#1072' '#1085#1072' 2-'#1102' '#1087#1086#1082#1091#1087#1082#1091
  ClientHeight = 667
  ClientWidth = 967
  Color = clBtnFace
  Constraints.MinHeight = 500
  Constraints.MinWidth = 900
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
    Width = 967
    Height = 64
    Title = #1057#1082#1080#1076#1082#1072' '#1085#1072' 2-'#1102' '#1087#1086#1082#1091#1087#1082#1091
    Text = #1040#1076#1084#1080#1085#1080#1089#1090#1088#1080#1088#1086#1074#1072#1085#1080#1077' '#1090#1086#1074#1072#1088#1086#1074' '#1076#1083#1103' '#1072#1082#1094#1080#1080' "'#1057#1082#1080#1076#1082#1072' '#1085#1072' 2-'#1102' '#1087#1086#1082#1091#1087#1082#1091'"'
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
    ImageIndex = 1
    ExplicitWidth = 884
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 951
    Height = 538
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alClient
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 1
    object pnGoods: TPanel
      Left = 409
      Top = 0
      Width = 542
      Height = 538
      Align = alClient
      BevelOuter = bvNone
      Padding.Left = 2
      ShowCaption = False
      TabOrder = 0
      object dxBarDockControl2: TdxBarDockControl
        Left = 2
        Top = 0
        Width = 540
        Height = 30
        Align = dalTop
        BarManager = dxBarManager
        SunkenBorder = True
        UseOwnSunkenBorder = True
      end
      object cxGridGoods: TcxGrid
        Left = 2
        Top = 30
        Width = 540
        Height = 508
        Align = alClient
        TabOrder = 1
        ExplicitWidth = 457
        ExplicitHeight = 357
        object cxGridGoodsTable: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          ScrollbarAnnotations.CustomAnnotations = <>
          OnCellDblClick = cxGridGoodsTableCellDblClick
          OnFocusedRecordChanged = cxGridGoodsTableFocusedRecordChanged
          DataController.DataSource = IBCDataSourceGoods
          DataController.KeyFieldNames = 'GDISCOUNTID;GOODSID'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <
            item
              Kind = skCount
              Column = cxGridGoods_TITLE
              VisibleForCustomization = False
            end>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.CopyCaptionsToClipboard = False
          OptionsBehavior.CopyPreviewToClipboard = False
          OptionsCustomize.ColumnFiltering = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsSelection.MultiSelect = True
          OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1090#1086#1074#1072#1088#1086#1074'>'
          OptionsView.ScrollBars = ssVertical
          OptionsView.ColumnAutoWidth = True
          OptionsView.Footer = True
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          Styles.Header = dmAdditions.cxStyle_GridHeader
          Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
          object cxGridGoods_GOODSID: TcxGridDBColumn
            Caption = #1050#1086#1076
            DataBinding.FieldName = 'GOODSID'
            HeaderAlignmentHorz = taCenter
            MinWidth = 60
            Options.HorzSizing = False
            Width = 60
          end
          object cxGridGoods_IMG: TcxGridDBColumn
            PropertiesClassName = 'TcxImageComboBoxProperties'
            Properties.DefaultImageIndex = 12
            Properties.Images = dmAdditions.cxImageList_SWN
            Properties.Items = <>
            MinWidth = 24
            Options.Focusing = False
            Options.HorzSizing = False
            Width = 24
          end
          object cxGridGoods_TITLE: TcxGridDBColumn
            Caption = #1053#1072#1079#1074#1072#1085#1080#1077
            DataBinding.FieldName = 'TITLE'
          end
          object cxGridGoodsTableColumn1: TcxGridDBColumn
            Caption = #1062#1077#1085#1072' 1, '#1083#1077#1080
            DataBinding.FieldName = 'PRICE'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00'
            HeaderAlignmentHorz = taCenter
            MinWidth = 80
            Options.HorzSizing = False
            Width = 80
          end
          object cxGridGoods_DISCOUNT_VALUE: TcxGridDBColumn
            Caption = #1057#1082#1080#1076#1082#1072
            DataBinding.FieldName = 'DISCOUNT_VALUE_UNIT'
            PropertiesClassName = 'TcxLabelProperties'
            Properties.Alignment.Horz = taRightJustify
            HeaderAlignmentHorz = taCenter
            MinWidth = 70
            Options.HorzSizing = False
            Width = 70
          end
        end
        object cxGridGoodsLevel: TcxGridLevel
          GridView = cxGridGoodsTable
        end
      end
    end
    object pnGroups: TPanel
      Left = 0
      Top = 0
      Width = 409
      Height = 538
      Align = alLeft
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 1
      object dxBarDockControl1: TdxBarDockControl
        Left = 0
        Top = 0
        Width = 409
        Height = 30
        Align = dalTop
        BarManager = dxBarManager
        SunkenBorder = True
        UseOwnSunkenBorder = True
      end
      object cxGridGroup: TcxGrid
        Left = 0
        Top = 30
        Width = 409
        Height = 508
        Align = alClient
        TabOrder = 1
        ExplicitHeight = 357
        object cxGridGroupTable: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          ScrollbarAnnotations.CustomAnnotations = <>
          OnCellDblClick = cxGridGroupTableCellDblClick
          OnFocusedRecordChanged = cxGridGroupTableFocusedRecordChanged
          DataController.DataSource = IBCDataSourceGroups
          DataController.KeyFieldNames = 'GDISCOUNTID'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.CopyCaptionsToClipboard = False
          OptionsBehavior.CopyPreviewToClipboard = False
          OptionsCustomize.ColumnFiltering = False
          OptionsCustomize.ColumnSorting = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1075#1088#1091#1087#1087'>'
          OptionsView.ScrollBars = ssVertical
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          Styles.Header = dmAdditions.cxStyle_GridHeader
          Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
          object cxGridGroup_GDISCOUNTID: TcxGridDBColumn
            Caption = #1050#1086#1076
            DataBinding.FieldName = 'GDISCOUNTID'
            HeaderAlignmentHorz = taCenter
            MinWidth = 50
            Options.HorzSizing = False
            Width = 50
          end
          object cxGridGroup_TITLE: TcxGridDBColumn
            Caption = #1053#1072#1079#1074#1072#1085#1080#1077
            DataBinding.FieldName = 'TITLE'
          end
          object cxGridGroup_PERIOD: TcxGridDBColumn
            Caption = #1055#1077#1088#1080#1086#1076
            OnGetDisplayText = cxGridGroup_PERIODGetDisplayText
            HeaderAlignmentHorz = taCenter
            MinWidth = 120
            Options.HorzSizing = False
            Width = 120
          end
          object cxGridGroup_START_DATE: TcxGridDBColumn
            DataBinding.FieldName = 'START_DATE'
            Visible = False
            VisibleForCustomization = False
          end
          object cxGridGroup_END_DATE: TcxGridDBColumn
            DataBinding.FieldName = 'END_DATE'
            Visible = False
            VisibleForCustomization = False
          end
        end
        object cxGridGroupLevel: TcxGridLevel
          GridView = cxGridGroupTable
        end
      end
    end
  end
  object pnButtons: TPanel
    Left = 0
    Top = 618
    Width = 967
    Height = 49
    Align = alBottom
    BevelOuter = bvNone
    Padding.Top = 4
    Padding.Right = 24
    Padding.Bottom = 16
    TabOrder = 2
    ExplicitTop = 467
    ExplicitWidth = 884
    object btnClose: TButton
      Left = 853
      Top = 4
      Width = 90
      Height = 29
      Align = alRight
      Caption = #1047#1072#1082#1088#1099#1090#1100
      ModalResult = 2
      TabOrder = 0
      ExplicitLeft = 770
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
    Left = 436
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
      FloatLeft = 807
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbGroupNew'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbGroupEdit'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbGroupDelete'
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
      FloatLeft = 807
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarSubItem2'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbGoodsEdit'
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
    object bbGroupNew: TdxBarButton
      Caption = #1053#1086#1074#1072#1103
      Category = 0
      Hint = #1053#1086#1074#1072#1103
      Visible = ivAlways
      ImageIndex = 40
      OnClick = bbGroupNewClick
    end
    object bbGroupEdit: TdxBarButton
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      Category = 0
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 41
      OnClick = bbGroupEditClick
    end
    object bbGroupDelete: TdxBarButton
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Category = 0
      Hint = #1059#1076#1072#1083#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 42
      OnClick = bbGroupDeleteClick
    end
    object bbGoodsNew: TdxBarButton
      Caption = #1053#1086#1074#1099#1081' '#1090#1086#1074#1072#1088'...'
      Category = 0
      Hint = #1053#1086#1074#1099#1081' '#1090#1086#1074#1072#1088
      Visible = ivAlways
      ShortCut = 45
      OnClick = bbGoodsNewClick
    end
    object bbGoodsEdit: TdxBarButton
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      Category = 0
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 115
      OnClick = bbGoodsEditClick
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
    object bbGoodsNewMore: TdxBarButton
      Caption = #1042#1099#1073#1088#1072#1090#1100' '#1090#1086#1074#1072#1088' '#1080#1079' '#1089#1087#1088#1072#1074#1086#1095#1085#1080#1082#1072'...'
      Category = 0
      Hint = #1042#1099#1073#1088#1072#1090#1100' '#1090#1086#1074#1072#1088' '#1080#1079' '#1089#1087#1088#1072#1074#1086#1095#1085#1080#1082#1072
      Visible = ivAlways
      ImageIndex = 50
      OnClick = bbGoodsNewMoreClick
    end
    object bbGoodsDeleteAll: TdxBarButton
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1074#1089#1077
      Category = 0
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1074#1089#1077
      Visible = ivAlways
      ImageIndex = 35
      OnClick = bbGoodsDeleteAllClick
    end
    object dxBarSubItem1: TdxBarSubItem
      Caption = #1048#1085#1089#1090#1088#1091#1084#1077#1085#1090#1099
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbCopyGoodsInActiune'
        end>
    end
    object bbCopyGoodsInActiune: TdxBarButton
      Caption = #1057#1082#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1090#1086#1074#1072#1088#1099' '#1074' '#1040#1082#1094#1080#1102'...'
      Category = 0
      Hint = #1057#1082#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1090#1086#1074#1072#1088#1099' '#1074' '#1040#1082#1094#1080#1102
      Visible = ivAlways
      ImageIndex = 29
      OnClick = bbCopyGoodsInActiuneClick
    end
    object dxBarSubItem2: TdxBarSubItem
      Caption = #1053#1086#1074#1099#1081
      Category = 0
      Visible = ivAlways
      ImageIndex = 40
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbGoodsNew'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbGoodsNewMore'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbGoodsNewFromFolder'
        end>
    end
    object bbGoodsNewFromFolder: TdxBarButton
      Caption = #1042#1099#1073#1088#1072#1090#1100' '#1075#1088#1091#1087#1087#1091' '#1090#1086#1074#1072#1088#1086#1074'...'
      Category = 0
      Hint = #1042#1099#1073#1088#1072#1090#1100' '#1075#1088#1091#1087#1087#1091' '#1090#1086#1074#1072#1088#1086#1074
      Visible = ivAlways
      ImageIndex = 13
      OnClick = bbGoodsNewFromFolderClick
    end
  end
  object IBCQueryGroups: TIBCQuery
    KeyFields = 'GDISCOUNTID'
    KeyGenerator = 'SQ_TDB_GOODS_DISCOUNT_ID'
    GeneratorMode = gmInsert
    SQLInsert.Strings = (
      'INSERT INTO TDB_GOODS_DISCOUNT'
      
        '  (GDISCOUNTID, TITLE, START_DATE, END_DATE, DISCOUNT_TYPE, SMS_' +
        'TEMPLATE)'
      'VALUES'
      
        '  (:GDISCOUNTID, :TITLE, :START_DATE, :END_DATE, :DISCOUNT_TYPE,' +
        ' :SMS_TEMPLATE)')
    SQLDelete.Strings = (
      'DELETE FROM TDB_GOODS_DISCOUNT'
      'WHERE'
      '  GDISCOUNTID = :Old_GDISCOUNTID')
    SQLUpdate.Strings = (
      'UPDATE TDB_GOODS_DISCOUNT'
      'SET'
      
        '  GDISCOUNTID = :GDISCOUNTID, TITLE = :TITLE, START_DATE = :STAR' +
        'T_DATE, END_DATE = :END_DATE, DISCOUNT_TYPE = :DISCOUNT_TYPE, SM' +
        'S_TEMPLATE = :SMS_TEMPLATE'
      'WHERE'
      '  GDISCOUNTID = :Old_GDISCOUNTID')
    SQLRefresh.Strings = (
      
        'SELECT GDISCOUNTID, TITLE, START_DATE, END_DATE, DISCOUNT_TYPE, ' +
        'SMS_TEMPLATE FROM TDB_GOODS_DISCOUNT'
      'WHERE'
      '  GDISCOUNTID = :GDISCOUNTID')
    SQLLock.Strings = (
      'SELECT NULL FROM TDB_GOODS_DISCOUNT'
      'WHERE'
      'GDISCOUNTID = :Old_GDISCOUNTID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = IBCTrUpdate
    SQL.Strings = (
      'SELECT'
      '*'
      'FROM TDB_GOODS_DISCOUNT')
    AutoCommit = False
    LockMode = lmLockImmediate
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Options.RequiredFields = False
    LocalConstraints = False
    Left = 84
    Top = 212
  end
  object IBCDataSourceGroups: TIBCDataSource
    DataSet = IBCQueryGroups
    Left = 84
    Top = 156
  end
  object IBCDataSourceGoods: TIBCDataSource
    DataSet = IBCQueryGoods
    Left = 524
    Top = 156
  end
  object IBCQueryGoods: TIBCQuery
    SQLInsert.Strings = (
      'INSERT INTO TDB_GOODS_DISC_LIST'
      '  (GDISCOUNTID, GOODSID, DISCOUNT_VALUE)'
      'VALUES'
      '  (:GDISCOUNTID, :GOODSID, :DISCOUNT_VALUE)')
    SQLDelete.Strings = (
      'DELETE FROM TDB_GOODS_DISC_LIST'
      'WHERE'
      '  GDISCOUNTID = :Old_GDISCOUNTID AND GOODSID = :Old_GOODSID')
    SQLUpdate.Strings = (
      'UPDATE TDB_GOODS_DISC_LIST'
      'SET'
      '  GDISCOUNTID = :GDISCOUNTID,'
      '  GOODSID = :GOODSID,'
      '  DISCOUNT_VALUE = :DISCOUNT_VALUE'
      'WHERE'
      '  GDISCOUNTID = :Old_GDISCOUNTID AND GOODSID = :Old_GOODSID')
    SQLRefresh.Strings = (
      'SELECT'
      ' GDISCOUNTID,'
      ' GOODSID, '
      ' DISCOUNT_VALUE,'
      
        ' DISCOUNT_VALUE || IIF((SELECT DISCOUNT_TYPE FROM TDB_GOODS_DISC' +
        'OUNT WHERE TDB_GOODS_DISCOUNT.GDISCOUNTID=TDB_GOODS_DISC_LIST.GD' +
        'ISCOUNTID)=1,'#39'%'#39','#39'LEI'#39') DISCOUNT_VALUE_UNIT,'
      
        ' (SELECT TITLE FROM TS_GOODS WHERE TS_GOODS.GOODSID=TDB_GOODS_DI' +
        'SC_LIST.GOODSID),'
      
        ' (SELECT PRICE FROM GET_GOODS_PRICE(TDB_GOODS_DISC_LIST.GOODSID,' +
        '1,496,0))'
      'FROM TDB_GOODS_DISC_LIST'
      'WHERE'
      
        '  TDB_GOODS_DISC_LIST.GDISCOUNTID = :GDISCOUNTID AND GOODSID = :' +
        'GOODSID')
    SQLLock.Strings = (
      'SELECT NULL FROM TDB_GOODS_DISC_LIST'
      'WHERE'
      'GDISCOUNTID = :Old_GDISCOUNTID AND GOODSID = :Old_GOODSID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = IBCTrUpdate
    SQL.Strings = (
      'SELECT'
      ' GDISCOUNTID,'
      ' GOODSID, '
      ' DISCOUNT_VALUE,'
      
        ' DISCOUNT_VALUE || IIF((SELECT DISCOUNT_TYPE FROM TDB_GOODS_DISC' +
        'OUNT WHERE TDB_GOODS_DISCOUNT.GDISCOUNTID=TDB_GOODS_DISC_LIST.GD' +
        'ISCOUNTID)=1,'#39'%'#39','#39'LEI'#39') DISCOUNT_VALUE_UNIT,'
      
        ' (SELECT TITLE FROM TS_GOODS WHERE TS_GOODS.GOODSID=TDB_GOODS_DI' +
        'SC_LIST.GOODSID),'
      
        ' (SELECT PRICE FROM GET_GOODS_PRICE(TDB_GOODS_DISC_LIST.GOODSID,' +
        '1,496,0))'
      'FROM TDB_GOODS_DISC_LIST')
    MasterFields = 'GDISCOUNTID'
    DetailFields = 'GDISCOUNTID'
    MasterSource = IBCDataSourceGroups
    AutoCommit = False
    LockMode = lmLockImmediate
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Options.RequiredFields = False
    Options.DetailDelay = 500
    LocalConstraints = False
    Left = 524
    Top = 212
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'GDISCOUNTID'
        Value = nil
      end>
  end
  object IBCTrUpdate: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 200
    Top = 192
  end
end
