object frmWebShopsDlg: TfrmWebShopsDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  ClientHeight = 470
  ClientWidth = 982
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    982
    470)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 982
    Height = 64
    Text = #1040#1076#1084#1080#1085#1080#1089#1090#1088#1080#1088#1086#1074#1072#1085#1080#1077' '#1075#1086#1088#1086#1076#1086#1074' '#1080' '#1084#1072#1075#1072#1079#1080#1085#1086#1074' '#1087#1088#1086#1076#1072#1078
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
    ImageIndex = 15
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 966
    Height = 342
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 1
    object pnCity: TPanel
      Left = 0
      Top = 0
      Width = 341
      Height = 342
      Align = alLeft
      BevelOuter = bvNone
      Caption = 'pnCity'
      TabOrder = 0
      object dxBarDockControl1: TdxBarDockControl
        Left = 0
        Top = 0
        Width = 341
        Height = 30
        Align = dalTop
        BarManager = dxBarManager
        SunkenBorder = True
        UseOwnSunkenBorder = True
      end
      object cxGridCity: TcxGrid
        Left = 0
        Top = 30
        Width = 341
        Height = 312
        Align = alClient
        TabOrder = 1
        object cxGridCityTable: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          ScrollbarAnnotations.CustomAnnotations = <>
          OnCellDblClick = cxGridCityTableCellDblClick
          OnFocusedRecordChanged = cxGridCityTableFocusedRecordChanged
          DataController.DataSource = IBCDataSourceCity
          DataController.KeyFieldNames = 'CITYID'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.CopyCaptionsToClipboard = False
          OptionsCustomize.ColumnFiltering = False
          OptionsCustomize.ColumnGrouping = False
          OptionsCustomize.ColumnSorting = False
          OptionsCustomize.ColumnsQuickCustomization = True
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1075#1086#1088#1086#1076#1086#1074'>'
          OptionsView.ColumnAutoWidth = True
          OptionsView.GridLineColor = 13750737
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          Styles.Header = dmAdditions.cxStyle_GridHeader
          object cxGridCity_CITYID: TcxGridDBColumn
            Caption = #1050#1086#1076
            DataBinding.FieldName = 'CITYID'
            Visible = False
            MinWidth = 50
            Options.HorzSizing = False
            Width = 50
          end
          object cxGridCity_CITY_TITLE: TcxGridDBColumn
            Caption = #1043#1086#1088#1086#1076
            DataBinding.FieldName = 'CITY_TITLE'
          end
          object cxGridCity_TELEFOANE: TcxGridDBColumn
            Caption = #1058#1077#1083#1077#1092#1086#1085#1099
            DataBinding.FieldName = 'TELEFOANE'
          end
          object cxGridCity_EMAIL: TcxGridDBColumn
            Caption = 'E-Mail'
            DataBinding.FieldName = 'EMAIL'
          end
          object cxGridCity_ORDERNO: TcxGridDBColumn
            DataBinding.FieldName = 'ORDERNO'
            Visible = False
            SortIndex = 0
            SortOrder = soAscending
            VisibleForCustomization = False
          end
        end
        object cxGridCityLeve: TcxGridLevel
          GridView = cxGridCityTable
        end
      end
    end
    object pnShop: TPanel
      Left = 341
      Top = 0
      Width = 625
      Height = 342
      Align = alClient
      BevelOuter = bvNone
      Caption = 'pnShop'
      Padding.Left = 2
      TabOrder = 1
      object dxBarDockControl2: TdxBarDockControl
        Left = 2
        Top = 0
        Width = 623
        Height = 30
        Align = dalTop
        BarManager = dxBarManager
        SunkenBorder = True
        UseOwnSunkenBorder = True
      end
      object cxGridShop: TcxGrid
        Left = 2
        Top = 30
        Width = 623
        Height = 312
        Align = alClient
        TabOrder = 1
        object cxGridShopTable: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          ScrollbarAnnotations.CustomAnnotations = <>
          OnCellDblClick = cxGridShopTableCellDblClick
          OnFocusedRecordChanged = cxGridShopTableFocusedRecordChanged
          DataController.DataSource = IBCDataSourceShop
          DataController.KeyFieldNames = 'FIRMAID;CITYID;CUSTOMERID'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.CopyCaptionsToClipboard = False
          OptionsCustomize.ColumnFiltering = False
          OptionsCustomize.ColumnGrouping = False
          OptionsCustomize.ColumnSorting = False
          OptionsCustomize.ColumnsQuickCustomization = True
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1084#1072#1075#1072#1079#1080#1085#1086#1074'>'
          OptionsView.ColumnAutoWidth = True
          OptionsView.GridLineColor = 13750737
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          Styles.Header = dmAdditions.cxStyle_GridHeader
          object cxGridShop_CUSTOMER_NAME: TcxGridDBColumn
            Caption = #1060#1080#1088#1084#1072
            DataBinding.FieldName = 'CUSTOMER_NAME'
            Width = 100
          end
          object cxGridShop_ADRESA: TcxGridDBColumn
            Caption = #1040#1076#1088#1077#1089
            DataBinding.FieldName = 'ADRESA'
            MinWidth = 140
            Options.HorzSizing = False
            Width = 140
          end
          object cxGridShop_TELEFOANE: TcxGridDBColumn
            Caption = #1058#1077#1083#1077#1092#1086#1085#1099
            DataBinding.FieldName = 'TELEFOANE'
            MinWidth = 120
            Options.HorzSizing = False
            Width = 120
          end
          object cxGridShop_FAX: TcxGridDBColumn
            Caption = #1060#1072#1082#1089
            DataBinding.FieldName = 'FAX'
            Visible = False
            MinWidth = 60
            Options.HorzSizing = False
            Width = 60
          end
          object cxGridShop_EMAIL: TcxGridDBColumn
            Caption = #1045'-'#1052#1101#1081#1083
            DataBinding.FieldName = 'EMAIL'
            MinWidth = 140
            Options.HorzSizing = False
            Width = 140
          end
          object cxGridShop_ORDERNO: TcxGridDBColumn
            DataBinding.FieldName = 'ORDERNO'
            Visible = False
            SortIndex = 0
            SortOrder = soAscending
            VisibleForCustomization = False
            IsCaptionAssigned = True
          end
          object cxGridShopTableColumn1: TcxGridDBColumn
            AlternateCaption = #1057#1072#1084#1086#1074#1099#1074#1086#1079' '#1080#1079' '#1084#1072#1075#1072#1079#1080#1085#1072
            Caption = #1057#1042
            DataBinding.FieldName = 'FLG_SELF_PICKUP'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ValueChecked = 1
            Properties.ValueUnchecked = 0
            HeaderAlignmentHorz = taCenter
            MinWidth = 40
            Options.HorzSizing = False
            Width = 40
          end
        end
        object cxGridShopLevel: TcxGridLevel
          GridView = cxGridShopTable
        end
      end
    end
  end
  object btnClose: TcxButton
    Left = 871
    Top = 425
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1047#1072#1082#1088#1099#1090#1100
    ModalResult = 2
    TabOrder = 2
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
    Left = 496
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
      FloatLeft = 811
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbCity_New'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbCity_Modify'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbCity_Delete'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbCity_Sort'
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
      FloatLeft = 811
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbShop_New'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbShop_Modify'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbShop_Delete'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbShop_Sort'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object bbCity_New: TdxBarButton
      Caption = #1053#1086#1074#1099#1081
      Category = 0
      Hint = #1053#1086#1074#1099#1081
      Visible = ivAlways
      ImageIndex = 40
      OnClick = bbCity_NewClick
    end
    object bbCity_Modify: TdxBarButton
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      Category = 0
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 113
      OnClick = bbCity_ModifyClick
    end
    object bbCity_Delete: TdxBarButton
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Category = 0
      Hint = #1059#1076#1072#1083#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 42
      OnClick = bbCity_DeleteClick
    end
    object bbCity_Sort: TdxBarButton
      Caption = #1057#1086#1088#1090#1080#1088#1086#1074#1072#1090#1100
      Category = 0
      Hint = #1057#1086#1088#1090#1080#1088#1086#1074#1072#1090#1100
      Visible = ivAlways
      ImageIndex = 38
      OnClick = bbCity_SortClick
    end
    object bbShop_New: TdxBarButton
      Caption = #1053#1086#1074#1099#1081
      Category = 0
      Hint = #1053#1086#1074#1099#1081
      Visible = ivAlways
      ImageIndex = 40
      OnClick = bbShop_NewClick
    end
    object bbShop_Modify: TdxBarButton
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      Category = 0
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 115
      OnClick = bbShop_ModifyClick
    end
    object bbShop_Delete: TdxBarButton
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Category = 0
      Hint = #1059#1076#1072#1083#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 42
    end
    object bbShop_Sort: TdxBarButton
      Caption = #1057#1086#1088#1090#1080#1088#1086#1074#1072#1090#1100
      Category = 0
      Hint = #1057#1086#1088#1090#1080#1088#1086#1074#1072#1090#1100
      Visible = ivAlways
      ImageIndex = 38
    end
  end
  object IBCQueryCity: TIBCQuery
    SQLInsert.Strings = (
      'INSERT INTO TWEB_ORASE_MAGAZINE'
      '  (FIRMAID, CITYID, TELEFOANE, EMAIL, ORDERNO)'
      'VALUES'
      '  (:FIRMAID, :CITYID, :TELEFOANE, :EMAIL, :ORDERNO)')
    SQLDelete.Strings = (
      'DELETE FROM TWEB_ORASE_MAGAZINE'
      'WHERE'
      '  CITYID = :Old_CITYID'
      '  AND'
      '  FIRMAID = :Old_FIRMAID')
    SQLUpdate.Strings = (
      'UPDATE TWEB_ORASE_MAGAZINE'
      'SET'
      '  CITYID = :CITYID, '
      '  TELEFOANE = :TELEFOANE, '
      '  EMAIL = :EMAIL, '
      '  ORDERNO = :ORDERNO'
      'WHERE'
      '  CITYID = :Old_CITYID'
      '  AND'
      '  FIRMAID = :Old_FIRMAID')
    SQLRefresh.Strings = (
      'SELECT '
      ' FIRMAID,'
      ' CITYID, '
      
        ' (SELECT TITLE FROM TS_SYSS WHERE TS_SYSS.SYSSID=CITYID) CITY_TI' +
        'TLE,'
      ' TELEFOANE, '
      ' EMAIL, '
      ' ORDERNO '
      'FROM '
      ' TWEB_ORASE_MAGAZINE'
      'WHERE'
      ' FIRMAID = :FIRMAID'
      ' AND'
      ' CITYID = :CITYID')
    SQLLock.Strings = (
      'SELECT NULL FROM TWEB_ORASE_MAGAZINE'
      'WHERE'
      '  FIRMAID = :Old_FIRMAID'
      '  AND'
      '  CITYID = :Old_CITYID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = IBCTrUpdate
    SQL.Strings = (
      'SELECT '
      ' FIRMAID,'
      ' CITYID, '
      
        ' (SELECT TITLE FROM TS_SYSS WHERE TS_SYSS.SYSSID=CITYID) CITY_TI' +
        'TLE,'
      ' TELEFOANE, '
      ' EMAIL, '
      ' ORDERNO '
      'FROM '
      ' TWEB_ORASE_MAGAZINE'
      'WHERE'
      ' FIRMAID = :firma')
    AutoCommit = False
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Options.RequiredFields = False
    LocalConstraints = False
    Left = 108
    Top = 212
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'firma'
        Value = nil
      end>
  end
  object IBCDataSourceCity: TIBCDataSource
    DataSet = IBCQueryCity
    Left = 108
    Top = 160
  end
  object IBCTrUpdate: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 224
    Top = 136
  end
  object IBCQueryShop: TIBCQuery
    SQLInsert.Strings = (
      'INSERT INTO TWEB_MAGAZINE'
      
        '  (FIRMAID, CITYID, CUSTOMERID, ADRESA, TELEFOANE, FAX, EMAIL, F' +
        'LG_SELF_PICKUP, IMAGE_MAP, GMAP_URL)'
      'VALUES'
      
        '  (:FIRMAID, :CITYID, :CUSTOMERID, :ADRESA, :TELEFOANE, :FAX, :E' +
        'MAIL, :FLG_SELF_PICKUP, :IMAGE_MAP, :GMAP_URL)')
    SQLDelete.Strings = (
      'DELETE FROM TWEB_MAGAZINE'
      'WHERE'
      ' FIRMAID = :Old_FIRMAID '
      ' AND '
      ' CITYID = :Old_CITYID '
      ' AND '
      ' CUSTOMERID = :Old_CUSTOMERID')
    SQLUpdate.Strings = (
      'UPDATE TWEB_MAGAZINE'
      'SET'
      ' FIRMAID = :FIRMAID, '
      ' CITYID = :CITYID, '
      ' CUSTOMERID = :CUSTOMERID, '
      ' ADRESA = :ADRESA, '
      ' TELEFOANE = :TELEFOANE, '
      ' FAX = :FAX, '
      ' EMAIL = :EMAIL, '
      ' FLG_SELF_PICKUP = :FLG_SELF_PICKUP,'
      ' IMAGE_MAP = :IMAGE_MAP,'
      ' GMAP_URL = :GMAP_URL'
      'WHERE'
      ' FIRMAID = :Old_FIRMAID '
      ' AND '
      ' CITYID = :Old_CITYID '
      ' AND '
      ' CUSTOMERID = :Old_CUSTOMERID')
    SQLRefresh.Strings = (
      'SELECT '
      ' FIRMAID, '
      ' CITYID, '
      ' CUSTOMERID, '
      
        ' (SELECT DISPLAYNAME FROM TS_CUSTOMER WHERE TS_CUSTOMER.CUSTOMER' +
        'ID=TWEB_MAGAZINE.CUSTOMERID) CUSTOMER_NAME,'
      ' ADRESA, '
      ' TELEFOANE, '
      ' FAX, '
      ' EMAIL, '
      ' ORDERNO, '
      ' FLG_SELF_PICKUP,'
      ' IMAGE_MAP,'
      ' GMAP_URL'
      'FROM '
      ' TWEB_MAGAZINE'
      'WHERE'
      ' FIRMAID = :FIRMAID '
      ' AND '
      ' CITYID = :CITYID '
      ' AND '
      ' CUSTOMERID = :CUSTOMERID')
    SQLLock.Strings = (
      'SELECT NULL FROM TWEB_MAGAZINE'
      'WHERE'
      ' FIRMAID = :Old_FIRMAID '
      ' AND '
      ' CITYID = :Old_CITYID '
      ' AND '
      ' CUSTOMERID = :Old_CUSTOMERID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = IBCTrUpdate
    SQL.Strings = (
      'SELECT '
      ' FIRMAID, '
      ' CITYID, '
      ' CUSTOMERID, '
      
        ' (SELECT DISPLAYNAME FROM TS_CUSTOMER WHERE TS_CUSTOMER.CUSTOMER' +
        'ID=TWEB_MAGAZINE.CUSTOMERID) CUSTOMER_NAME,'
      ' ADRESA, '
      ' TELEFOANE, '
      ' FAX, '
      ' EMAIL, '
      ' ORDERNO, '
      ' FLG_SELF_PICKUP,'
      ' IMAGE_MAP, '
      ' GMAP_URL '
      'FROM '
      ' TWEB_MAGAZINE')
    MasterFields = 'FIRMAID;CITYID'
    DetailFields = 'FIRMAID;CITYID'
    MasterSource = IBCDataSourceCity
    AutoCommit = False
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Options.RequiredFields = False
    LocalConstraints = False
    Left = 416
    Top = 216
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'FIRMAID'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'CITYID'
        Value = nil
      end>
  end
  object IBCDataSourceShop: TIBCDataSource
    DataSet = IBCQueryShop
    Left = 416
    Top = 160
  end
end
