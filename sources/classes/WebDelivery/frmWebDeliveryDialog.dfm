object frmWebDeliveryDlg: TfrmWebDeliveryDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  ClientHeight = 509
  ClientWidth = 872
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
    Width = 872
    Height = 64
    Text = #1040#1076#1084#1080#1085#1080#1089#1090#1088#1080#1088#1086#1074#1072#1085#1080#1077' '#1092#1080#1088#1084' '#1080' '#1087#1091#1085#1082#1090#1086#1074' '#1076#1086#1089#1090#1072#1074#1082#1080
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
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 856
    Height = 381
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object pnDeliveryFirms: TPanel
      Left = 0
      Top = 0
      Width = 305
      Height = 381
      Align = alLeft
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 0
      object dxBarDockControl1: TdxBarDockControl
        Left = 0
        Top = 0
        Width = 305
        Height = 30
        Align = dalTop
        BarManager = dxBarManager
        SunkenBorder = True
        UseOwnSunkenBorder = True
      end
      object cxGridFirms: TcxGrid
        Left = 0
        Top = 30
        Width = 305
        Height = 351
        Align = alClient
        TabOrder = 1
        object cxGridFirmsTable: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          ScrollbarAnnotations.CustomAnnotations = <>
          OnFocusedRecordChanged = cxGridFirmsTableFocusedRecordChanged
          DataController.DataSource = IBCDataSourceFirms
          DataController.KeyFieldNames = 'CUSTOMERID'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.CopyCaptionsToClipboard = False
          OptionsCustomize.ColumnFiltering = False
          OptionsCustomize.ColumnGrouping = False
          OptionsCustomize.ColumnsQuickCustomization = True
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1092#1080#1088#1084' '#1076#1083#1103' '#1076#1086#1089#1090#1072#1074#1082#1080'>'
          OptionsView.ScrollBars = ssVertical
          OptionsView.ColumnAutoWidth = True
          OptionsView.GridLineColor = 13750737
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          Styles.Header = dmAdditions.cxStyle_GridHeader
          object cxGridFirms_CUSTOMERID: TcxGridDBColumn
            Caption = #1050#1086#1076
            DataBinding.FieldName = 'CUSTOMERID'
            Visible = False
            MinWidth = 50
            Options.HorzSizing = False
            Width = 50
          end
          object cxGridFirms_DISPLAYNAME: TcxGridDBColumn
            Caption = #1060#1080#1088#1084#1072
            DataBinding.FieldName = 'DISPLAYNAME'
          end
          object cxGridFirms_ORDERNO: TcxGridDBColumn
            DataBinding.FieldName = 'ORDERNO'
            Visible = False
            SortIndex = 0
            SortOrder = soAscending
            VisibleForCustomization = False
          end
        end
        object cxGridFirmsLevel: TcxGridLevel
          GridView = cxGridFirmsTable
        end
      end
    end
    object pnDeliveryCities: TPanel
      AlignWithMargins = True
      Left = 307
      Top = 0
      Width = 549
      Height = 381
      Margins.Left = 2
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alClient
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 1
      object dxBarDockControl3: TdxBarDockControl
        Left = 0
        Top = 0
        Width = 549
        Height = 30
        Align = dalTop
        BarManager = dxBarManager
        SunkenBorder = True
        UseOwnSunkenBorder = True
      end
      object cxGridCities: TcxGrid
        Left = 0
        Top = 30
        Width = 549
        Height = 351
        Align = alClient
        TabOrder = 1
        object cxGridCitiesTable: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          ScrollbarAnnotations.CustomAnnotations = <>
          OnCellDblClick = cxGridCitiesTableCellDblClick
          OnFocusedRecordChanged = cxGridCitiesTableFocusedRecordChanged
          DataController.DataSource = IBCDataSourceCity
          DataController.KeyFieldNames = 'CUSTOMERID;DISTRICTID;CITYID;GOODSID'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsCustomize.ColumnFiltering = False
          OptionsCustomize.ColumnGrouping = False
          OptionsCustomize.ColumnMoving = False
          OptionsCustomize.ColumnSorting = False
          OptionsCustomize.ColumnsQuickCustomization = True
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1085#1072#1089#1077#1083#1105#1085#1085#1099#1093' '#1087#1091#1085#1082#1090#1086#1074'>'
          OptionsView.ScrollBars = ssVertical
          OptionsView.ColumnAutoWidth = True
          OptionsView.GridLineColor = 13750737
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          Styles.Header = dmAdditions.cxStyle_GridHeader
          object cxGridCities_DISTRICTID: TcxGridDBColumn
            Caption = #1050#1086#1076' '#1088#1072#1081#1086#1085
            DataBinding.FieldName = 'DISTRICTID'
            Visible = False
            MinWidth = 60
            Options.HorzSizing = False
            Width = 60
          end
          object cxGridCities_DISTRICT_TITLE: TcxGridDBColumn
            Caption = #1056#1072#1081#1086#1085
            DataBinding.FieldName = 'DISTRICT_TITLE'
          end
          object cxGridCities_CITYID: TcxGridDBColumn
            Caption = #1050#1086#1076' '#1075#1086#1088#1086#1076
            DataBinding.FieldName = 'CITYID'
            Visible = False
            MinWidth = 60
            Options.HorzSizing = False
            Width = 60
          end
          object cxGridCities_CITY_TITLE: TcxGridDBColumn
            Caption = #1043#1086#1088#1086#1076
            DataBinding.FieldName = 'CITY_TITLE'
            OnGetDisplayText = cxGridCities_CITY_TITLEGetDisplayText
          end
          object cxGridCities_PRICE_LEI: TcxGridDBColumn
            Caption = #1062#1077#1085#1072', '#1083#1077#1081
            DataBinding.FieldName = 'PRICE1_LEI'
            HeaderAlignmentHorz = taCenter
            MinWidth = 70
            Options.HorzSizing = False
            Width = 70
          end
          object cxGridCities_TIME_UNIT: TcxGridDBColumn
            Caption = #1045#1076'.'#1074#1088#1077#1084#1077#1085#1080
            DataBinding.FieldName = 'TIME_UNIT'
            PropertiesClassName = 'TcxLabelProperties'
            Properties.Alignment.Horz = taCenter
            OnGetDisplayText = cxGridCities_TIME_UNITGetDisplayText
            HeaderAlignmentHorz = taCenter
            MinWidth = 70
            Options.HorzSizing = False
            Width = 70
          end
          object cxGridCities_TIME: TcxGridDBColumn
            Caption = #1042#1088#1077#1084#1103
            PropertiesClassName = 'TcxLabelProperties'
            Properties.Alignment.Horz = taCenter
            OnGetDisplayText = cxGridCities_TIMEGetDisplayText
            HeaderAlignmentHorz = taCenter
            MinWidth = 60
            Options.HorzSizing = False
            Width = 60
          end
          object cxGridCities_TIME_MIN: TcxGridDBColumn
            DataBinding.FieldName = 'TIME_MIN'
            Visible = False
            VisibleForCustomization = False
          end
          object cxGridCities_TIME_MAX: TcxGridDBColumn
            DataBinding.FieldName = 'TIME_MAX'
            Visible = False
            VisibleForCustomization = False
          end
        end
        object cxGridCitiesLevel: TcxGridLevel
          GridView = cxGridCitiesTable
        end
      end
    end
  end
  object btnClose: TcxButton
    Left = 760
    Top = 464
    Width = 90
    Height = 29
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
    Left = 468
    Top = 16
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
      FloatLeft = 827
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbNewFirma'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbModifyFirma'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbDeleteFirma'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          Visible = True
          ItemName = 'bbSortFirms'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBar3: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Custom 3'
      CaptionButtons = <>
      DockControl = dxBarDockControl3
      DockedDockControl = dxBarDockControl3
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 827
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbNewLocation'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbModifyLocation'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbDeleteLocation'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object bbNewFirma: TdxBarButton
      Caption = #1053#1086#1074#1072#1103
      Category = 0
      Hint = #1053#1086#1074#1072#1103' '#1092#1080#1088#1084#1072' '#1076#1083#1103' '#1076#1086#1089#1090#1072#1074#1082#1080
      Visible = ivAlways
      ImageIndex = 40
      OnClick = bbNewFirmaClick
    end
    object bbModifyFirma: TdxBarButton
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      Category = 0
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 41
      OnClick = bbModifyFirmaClick
    end
    object bbDeleteFirma: TdxBarButton
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Category = 0
      Hint = #1059#1076#1072#1083#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 42
      OnClick = bbDeleteFirmaClick
    end
    object bbSortFirms: TdxBarButton
      Caption = #1057#1086#1088#1090#1080#1088#1086#1074#1072#1090#1100
      Category = 0
      Hint = #1057#1086#1088#1090#1080#1088#1086#1074#1072#1090#1100
      Visible = ivAlways
      ImageIndex = 38
      OnClick = bbSortFirmsClick
    end
    object bbNewLocation: TdxBarButton
      Caption = #1053#1086#1074#1099#1081
      Category = 0
      Hint = #1053#1086#1074#1099#1081
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 45
      OnClick = bbNewLocationClick
    end
    object bbModifyLocation: TdxBarButton
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      Category = 0
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 115
      OnClick = bbModifyLocationClick
    end
    object bbDeleteLocation: TdxBarButton
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Category = 0
      Hint = #1059#1076#1072#1083#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 42
      ShortCut = 46
      OnClick = bbDeleteLocationClick
    end
  end
  object IBCQueryFirms: TIBCQuery
    SQLInsert.Strings = (
      'INSERT INTO TWEB_DELIVERY_FIRMS'
      
        '  (FIRMAID, CUSTOMERID, TITLE_ROM, TITLE_RUS, DESCRIPTION_ROM, D' +
        'ESCRIPTION_RUS)'
      'VALUES'
      
        '  (:FIRMAID, :CUSTOMERID, :TITLE_ROM, :TITLE_RUS, :DESCRIPTION_R' +
        'OM, :DESCRIPTION_RUS)')
    SQLDelete.Strings = (
      'DELETE FROM TWEB_DELIVERY_FIRMS'
      'WHERE'
      '  FIRMAID = :Old_FIRMAID'
      '  AND'
      '  CUSTOMERID = :Old_CUSTOMERID')
    SQLUpdate.Strings = (
      'UPDATE TWEB_DELIVERY_FIRMS'
      'SET'
      ' FIRMAID = :FIRMAID,'
      ' CUSTOMERID = :CUSTOMERID, '
      ' TITLE_ROM = :TITLE_ROM, '
      ' TITLE_RUS = :TITLE_RUS,'
      ' DESCRIPTION_ROM = :DESCRIPTION_ROM, '
      ' DESCRIPTION_RUS = :DESCRIPTION_RUS'
      'WHERE'
      ' FIRMAID = :Old_FIRMAID'
      ' AND'
      ' CUSTOMERID = :Old_CUSTOMERID')
    SQLRefresh.Strings = (
      'SELECT '
      ' FIRMAID,'
      ' CUSTOMERID, '
      
        ' (SELECT DISPLAYNAME FROM TS_CUSTOMER WHERE TS_CUSTOMER.CUSTOMER' +
        'ID=TWEB_DELIVERY_FIRMS.CUSTOMERID),'
      ' TITLE_ROM, '
      ' TITLE_RUS,'
      ' DESCRIPTION_ROM, '
      ' DESCRIPTION_RUS,'
      ' ORDERNO'
      'FROM '
      ' TWEB_DELIVERY_FIRMS'
      'WHERE'
      '  FIRMAID = :FIRMAID'
      '  AND'
      '  CUSTOMERID = :CUSTOMERID')
    SQLLock.Strings = (
      'SELECT NULL FROM TWEB_DELIVERY_FIRMS'
      'WHERE'
      '  FIRMAID = :Old_FIRMAID'
      '  AND'
      '  CUSTOMERID = :Old_CUSTOMERID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = IBCTransactionUpdate
    SQL.Strings = (
      'SELECT '
      ' FIRMAID,'
      ' CUSTOMERID, '
      
        ' (SELECT DISPLAYNAME FROM TS_CUSTOMER WHERE TS_CUSTOMER.CUSTOMER' +
        'ID=TWEB_DELIVERY_FIRMS.CUSTOMERID),'
      ' TITLE_ROM, '
      ' TITLE_RUS,'
      ' DESCRIPTION_ROM, '
      ' DESCRIPTION_RUS,'
      ' ORDERNO'
      'FROM '
      ' TWEB_DELIVERY_FIRMS'
      'WHERE'
      ' FIRMAID=:firma')
    AutoCommit = False
    LockMode = lmLockImmediate
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Options.RequiredFields = False
    LocalConstraints = False
    Left = 104
    Top = 220
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'firma'
        Value = nil
      end>
  end
  object IBCTransactionUpdate: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 268
    Top = 188
  end
  object IBCDataSourceFirms: TIBCDataSource
    DataSet = IBCQueryFirms
    Left = 104
    Top = 164
  end
  object IBCQueryCity: TIBCQuery
    SQLInsert.Strings = (
      'INSERT INTO TWEB_DELIVERY_LOCATIONS'
      
        '  (FIRMAID, CUSTOMERID, DISTRICTID, CITYID, GOODSID, TIME_UNIT, ' +
        'TIME_MIN, TIME_MAX, TITLE_ROM, TITLE_RUS, COMMENTS_ROM, COMMENTS' +
        '_RUS)'
      'VALUES'
      
        '  (:FIRMAID, :CUSTOMERID, :DISTRICTID, :CITYID, :GOODSID, :TIME_' +
        'UNIT, :TIME_MIN, :TIME_MAX, :TITLE_ROM, :TITLE_RUS, :COMMENTS_RO' +
        'M, :COMMENTS_RUS)')
    SQLDelete.Strings = (
      'DELETE FROM TWEB_DELIVERY_LOCATIONS'
      'WHERE'
      
        '  FIRMAID = :Old_FIRMAID AND CUSTOMERID = :Old_CUSTOMERID AND DI' +
        'STRICTID = :Old_DISTRICTID AND CITYID = :Old_CITYID AND GOODSID ' +
        '= :Old_GOODSID')
    SQLUpdate.Strings = (
      'UPDATE TWEB_DELIVERY_LOCATIONS'
      'SET'
      
        '  FIRMAID = :FIRMAID, CUSTOMERID = :CUSTOMERID, DISTRICTID = :DI' +
        'STRICTID, CITYID = :CITYID, GOODSID = :GOODSID, TIME_UNIT = :TIM' +
        'E_UNIT, TIME_MIN = :TIME_MIN, TIME_MAX = :TIME_MAX, '
      '  TITLE_ROM = :TITLE_ROM, TITLE_RUS = :TITLE_RUS,'
      '  COMMENTS_ROM = :COMMENTS_ROM, COMMENTS_RUS = :COMMENTS_RUS'
      'WHERE'
      
        '  FIRMAID = :Old_FIRMAID AND CUSTOMERID = :Old_CUSTOMERID AND DI' +
        'STRICTID = :Old_DISTRICTID AND CITYID = :Old_CITYID AND GOODSID ' +
        '= :Old_GOODSID')
    SQLRefresh.Strings = (
      'SELECT '
      ' FIRMAID,'
      ' CUSTOMERID,'
      ' DISTRICTID,'
      
        ' (SELECT TITLE FROM TS_SYSS WHERE TS_SYSS.SYSSID=DISTRICTID) DIS' +
        'TRICT_TITLE,'
      ' CITYID,'
      
        ' (SELECT TITLE FROM TS_SYSS WHERE TS_SYSS.SYSSID=CITYID) CITY_TI' +
        'TLE,'
      ' TIME_UNIT,'
      ' TIME_MIN,'
      ' TIME_MAX,'
      ' TITLE_ROM,'
      ' TITLE_RUS,'
      ' COMMENTS_ROM,'
      ' COMMENTS_RUS,'
      ' GOODSID,'
      
        ' (SELECT PRICE1_LEI FROM VW_TS_GOODS WHERE VW_TS_GOODS.GOODSID=T' +
        'WEB_DELIVERY_LOCATIONS.GOODSID) PRICE1_LEI,'
      
        ' (SELECT TITLE FROM TS_GOODS WHERE TS_GOODS.GOODSID=TWEB_DELIVER' +
        'Y_LOCATIONS.GOODSID) GOODS_TITLE'
      ''
      'FROM TWEB_DELIVERY_LOCATIONS'
      'WHERE'
      
        '  FIRMAID = :FIRMAID AND CUSTOMERID = :CUSTOMERID AND DISTRICTID' +
        ' = :DISTRICTID AND CITYID = :CITYID AND GOODSID = :GOODSID')
    SQLLock.Strings = (
      'SELECT NULL FROM TWEB_DELIVERY_LOCATIONS'
      'WHERE'
      
        'FIRMAID = :Old_FIRMAID AND CUSTOMERID = :Old_CUSTOMERID AND DIST' +
        'RICTID = :Old_DISTRICTID AND CITYID = :Old_CITYID AND GOODSID = ' +
        ':Old_GOODSID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = IBCTransactionUpdate
    SQL.Strings = (
      'SELECT '
      ' FIRMAID,'
      ' CUSTOMERID,'
      ' DISTRICTID,'
      
        ' (SELECT TITLE FROM TS_SYSS WHERE TS_SYSS.SYSSID=DISTRICTID) DIS' +
        'TRICT_TITLE,'
      ' CITYID,'
      
        ' (SELECT TITLE FROM TS_SYSS WHERE TS_SYSS.SYSSID=CITYID) CITY_TI' +
        'TLE,'
      ' TIME_UNIT,'
      ' TIME_MIN,'
      ' TIME_MAX,'
      ' TITLE_ROM,'
      ' TITLE_RUS,'
      ' COMMENTS_ROM,'
      ' COMMENTS_RUS,'
      ' GOODSID,'
      
        ' (SELECT PRICE1_LEI FROM VW_TS_GOODS WHERE VW_TS_GOODS.GOODSID=T' +
        'WEB_DELIVERY_LOCATIONS.GOODSID) PRICE1_LEI,'
      
        ' (SELECT TITLE FROM TS_GOODS WHERE TS_GOODS.GOODSID=TWEB_DELIVER' +
        'Y_LOCATIONS.GOODSID) GOODS_TITLE'
      'FROM'
      ' TWEB_DELIVERY_LOCATIONS')
    MasterFields = 'FIRMAID;CUSTOMERID'
    DetailFields = 'FIRMAID;CUSTOMERID'
    MasterSource = IBCDataSourceFirms
    AutoCommit = False
    LockMode = lmLockImmediate
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Options.RequiredFields = False
    LocalConstraints = False
    Left = 496
    Top = 240
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'FIRMAID'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'CUSTOMERID'
        Value = nil
      end>
  end
  object IBCDataSourceCity: TIBCDataSource
    DataSet = IBCQueryCity
    Left = 496
    Top = 188
  end
end
