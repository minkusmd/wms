object fmAnalizePriceList: TfmAnalizePriceList
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = #1040#1085#1072#1083#1080#1079' '#1087#1088#1072#1081#1089' '#1083#1080#1089#1090#1086#1074
  ClientHeight = 689
  ClientWidth = 936
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
    Width = 936
    Height = 64
    Title = #1040#1085#1072#1083#1080#1079' '#1087#1088#1072#1081#1089' '#1083#1080#1089#1090#1086#1074
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
  object Panel1: TPanel
    Left = 0
    Top = 64
    Width = 936
    Height = 35
    Align = alTop
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 1
    object cxLabel1: TcxLabel
      Left = 7
      Top = 8
      Caption = #1050#1086#1085#1090#1088#1072#1075#1077#1085#1090
    end
    object beCT_NAME: TcxButtonEdit
      Left = 77
      Top = 6
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      Properties.OnButtonClick = cxButtonEdit1PropertiesButtonClick
      TabOrder = 1
      Width = 337
    end
    object btnSave: TButton
      Left = 428
      Top = 4
      Width = 75
      Height = 25
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      TabOrder = 0
      OnClick = btnSaveClick
    end
  end
  object cxGridPrice: TcxGrid
    Left = 0
    Top = 99
    Width = 936
    Height = 545
    Align = alClient
    TabOrder = 2
    object cxGridPriceTable: TcxGridDBTableView
      OnKeyDown = cxGridPriceTableKeyDown
      Navigator.Buttons.CustomButtons = <>
      ScrollbarAnnotations.CustomAnnotations = <>
      OnCustomDrawCell = cxGridPriceTableCustomDrawCell
      DataController.DataSource = IBCDSPriceList
      DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsCustomize.ColumnsQuickCustomization = True
      OptionsSelection.MultiSelect = True
      OptionsSelection.CellMultiSelect = True
      OptionsSelection.InvertSelect = False
      OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
      OptionsView.ScrollBars = ssVertical
      OptionsView.ColumnAutoWidth = True
      OptionsView.GridLineColor = 13750737
      OptionsView.GroupByBox = False
      OptionsView.Indicator = True
      Styles.Header = dmAdditions.cxStyle_GridHeader
      object cxGridPriceTableCUSTOMERID: TcxGridDBColumn
        DataBinding.FieldName = 'CUSTOMERID'
        Visible = False
        VisibleForCustomization = False
      end
      object cxGridPriceTableDISPLAYNAME: TcxGridDBColumn
        DataBinding.FieldName = 'DISPLAYNAME'
        Visible = False
        VisibleForCustomization = False
        Width = 137
      end
      object cxGridPriceTableGOODSID: TcxGridDBColumn
        Caption = #1057#1080#1089#1090'. '#1050#1086#1076
        DataBinding.FieldName = 'GOODSID'
        Width = 47
      end
      object cxGridPriceTableGOODS_NAME: TcxGridDBColumn
        Caption = #1057#1080#1089#1090#1077#1084#1085#1086#1077' '#1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
        DataBinding.FieldName = 'GOODS_NAME'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Default = True
            Kind = bkEllipsis
          end>
        Properties.ClickKey = 115
        Properties.OnButtonClick = cxGrid1DBTableView1GOODS_NAMEPropertiesButtonClick
        Width = 146
      end
      object cxGridPriceTableFK_GOODSID: TcxGridDBColumn
        Caption = #1050#1086#1076' '#1082#1086#1085#1082#1091#1088#1077#1085#1090#1072
        DataBinding.FieldName = 'FK_GOODSID'
        Width = 55
      end
      object cxGridPriceTableFK_GOODS_TITLE: TcxGridDBColumn
        Caption = #1053#1072#1079#1074#1072#1085#1080#1077
        DataBinding.FieldName = 'FK_GOODS_TITLE'
        Width = 491
      end
      object cxGridPriceTableFK_PRICE: TcxGridDBColumn
        Caption = #1062#1077#1085#1072' '#1087#1072#1088#1090#1085#1077#1088#1072
        DataBinding.FieldName = 'FK_PRICE'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        Width = 100
      end
      object cxGridPriceTablePRICECOLUMN: TcxGridDBColumn
        Caption = #1050'.'#1062
        DataBinding.FieldName = 'PRICECOLUMN'
        Visible = False
        Width = 56
      end
      object cxGridPriceTableUPDATED_DATE: TcxGridDBColumn
        Caption = #1048#1079#1084
        DataBinding.FieldName = 'UPDATED_DATE'
        Visible = False
        Width = 68
      end
      object cxGridPriceTableColumn1: TcxGridDBColumn
        Caption = #1062#1077#1085#1072' 1'
        DataBinding.FieldName = 'PRICE1'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        Width = 80
      end
      object cxGridPriceTableColumn2: TcxGridDBColumn
        Caption = #1062#1077#1085#1072' 2'
        DataBinding.FieldName = 'PRICE2'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        Visible = False
        HeaderAlignmentHorz = taCenter
        Width = 80
      end
      object cxGridPriceTableColumn3: TcxGridDBColumn
        Caption = #1062#1077#1085#1072' 3'
        DataBinding.FieldName = 'PRICE3'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        Visible = False
        HeaderAlignmentHorz = taCenter
        Width = 80
      end
      object cxGridPriceTableColumn4: TcxGridDBColumn
        Caption = #1062#1077#1085#1072' 4'
        DataBinding.FieldName = 'PRICE4'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        Width = 80
      end
    end
    object cxGridPriceLevel: TcxGridLevel
      GridView = cxGridPriceTable
    end
  end
  object pnBottom: TPanel
    Left = 0
    Top = 644
    Width = 936
    Height = 45
    Align = alBottom
    BevelOuter = bvNone
    Padding.Left = 8
    Padding.Top = 8
    Padding.Right = 16
    Padding.Bottom = 8
    TabOrder = 3
    object btnClose: TcxButton
      Left = 830
      Top = 8
      Width = 90
      Height = 29
      Align = alRight
      Caption = #1047#1072#1082#1088#1099#1090#1100
      ModalResult = 1
      TabOrder = 0
      OnClick = btnCloseClick
    end
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
    Style = bmsFlat
    UseSystemFont = True
    Left = 636
    Top = 24
    PixelsPerInch = 96
    object bbSourceInsertCodes: TdxBarButton
      Caption = #1042#1089#1090#1072#1074#1080#1090#1100' '#1050#1086#1076#1099
      Category = 0
      Hint = #1042#1089#1090#1072#1074#1080#1090#1100' '#1090#1086#1083#1100#1082#1086' '#1082#1086#1083#1086#1085#1082#1091' '#1050#1086#1076
      Visible = ivAlways
      ImageIndex = 24
      ShortCut = 16433
    end
    object bbSourceInsertTitles: TdxBarButton
      Caption = #1042#1089#1090#1072#1074#1080#1090#1100' '#1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1103
      Category = 0
      Hint = #1042#1089#1090#1072#1074#1080#1090#1100' '#1090#1086#1083#1100#1082#1086' '#1082#1086#1083#1086#1085#1082#1091' '#1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
      Visible = ivAlways
      ImageIndex = 24
      ShortCut = 16434
    end
    object bbSourceDeleteAll: TdxBarButton
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Category = 0
      Hint = #1059#1076#1072#1083#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 35
    end
    object bbSourceInsertPrices: TdxBarButton
      Caption = #1042#1089#1090#1072#1074#1080#1090#1100' '#1062#1077#1085#1099
      Category = 0
      Hint = #1042#1089#1090#1072#1074#1080#1090#1100' '#1090#1086#1083#1100#1082#1086' '#1082#1086#1083#1086#1085#1082#1091' '#1062#1077#1085#1072
      Visible = ivAlways
      ImageIndex = 24
      ShortCut = 16435
    end
    object bbSourceInsertAll: TdxBarButton
      Caption = #1042#1089#1090#1072#1074#1080#1090#1100
      Category = 0
      Hint = #1042#1089#1090#1072#1074#1080#1090#1100' '#1074#1089#1077' '#1082#1086#1083#1086#1085#1082#1080' '#1089#1088#1072#1079#1091
      Visible = ivAlways
      ImageIndex = 24
      ShortCut = 120
    end
    object bbSelectGoodsAsLinked: TdxBarButton
      Caption = #1042#1099#1073#1088#1072#1090#1100' '#1090#1086#1074#1072#1088
      Category = 0
      Hint = #1042#1099#1073#1088#1072#1090#1100' '#1090#1086#1074#1072#1088
      Visible = ivAlways
      ImageIndex = 43
      ShortCut = 13
    end
    object beSourceProgressFirma: TdxBarEdit
      Caption = #1050#1083#1080#1077#1085#1090
      Category = 0
      Hint = #1050#1083#1080#1077#1085#1090
      Visible = ivAlways
      ShowCaption = True
      ReadOnly = True
    end
    object bbSourceProgressSelectedFirma: TdxBarButton
      Caption = #1042#1099#1073#1088#1072#1090#1100
      Category = 0
      Hint = #1042#1099#1073#1088#1072#1090#1100
      Visible = ivAlways
      ImageIndex = 13
      OnClick = bbSourceProgressSelectedFirmaClick
    end
    object bbSelectGoods: TdxBarButton
      Caption = #1056#1091#1095#1085#1086#1081' '#1087#1086#1080#1089#1082
      Category = 0
      Hint = #1056#1091#1095#1085#1086#1081' '#1087#1086#1080#1089#1082
      Visible = ivAlways
      ImageIndex = 4
      ShortCut = 16454
    end
    object bbDeleteProcessSource: TdxBarButton
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Category = 0
      Hint = #1059#1076#1072#1083#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 35
      ShortCut = 46
    end
    object cmbFinalAction: TdxBarCombo
      Caption = #1044#1077#1081#1089#1090#1074#1080#1077
      Category = 0
      Hint = #1044#1077#1081#1089#1090#1074#1080#1077
      Visible = ivAlways
      ShowCaption = True
      Text = #1057#1086#1079#1076#1072#1090#1100' '#1090#1086#1083#1100#1082#1086' '#1089#1074#1103#1079#1080
      ShowEditor = False
      Items.Strings = (
        #1057#1086#1079#1076#1072#1090#1100' '#1090#1086#1083#1100#1082#1086' '#1089#1074#1103#1079#1080
        #1057#1086#1079#1076#1072#1090#1100' '#1089#1074#1103#1079#1080' '#1080' '#1086#1073#1085#1086#1074#1080#1090#1100' '#1094#1077#1085#1099)
      ItemIndex = 0
    end
    object bbProcessData: TdxBarButton
      Caption = #1057#1076#1077#1083#1072#1090#1100
      Category = 0
      Hint = #1057#1076#1077#1083#1072#1090#1100
      Visible = ivAlways
      ImageIndex = 45
    end
    object bbStartSearchPrices: TdxBarButton
      Caption = #1055#1086#1080#1089#1082' '#1087#1088#1072#1081#1089#1072
      Category = 0
      Hint = #1055#1086#1080#1089#1082' '#1087#1088#1072#1081#1089#1072
      Visible = ivAlways
      ImageIndex = 4
      PaintStyle = psCaptionGlyph
      ShortCut = 114
      OnClick = bbStartSearchPricesClick
    end
    object dxBarButton1: TdxBarButton
      Caption = 'New Button'
      Category = 0
      Hint = 'New Button'
      Visible = ivAlways
    end
  end
  object IBCQueryPriceList: TIBCQuery
    SQLInsert.Strings = (
      'INSERT INTO TDB_CUST_PRICELIST_DETAIL'
      
        '  (CUSTOMERID, GOODSID, FK_GOODSID, FK_GOODS_TITLE, FK_PRICE, PR' +
        'ICECOLUMN, UPDATED_DATE)'
      'VALUES'
      
        '  (:CUSTOMERID, :GOODSID, :FK_GOODSID, :FK_GOODS_TITLE, :FK_PRIC' +
        'E, :PRICECOLUMN, :UPDATED_DATE)')
    SQLUpdate.Strings = (
      'UPDATE TDB_CUST_PRICELIST_DETAIL'
      'SET'
      
        '  CUSTOMERID = :CUSTOMERID, GOODSID = :GOODSID, FK_GOODSID = :FK' +
        '_GOODSID, FK_GOODS_TITLE = :FK_GOODS_TITLE, FK_PRICE = :FK_PRICE' +
        ', PRICECOLUMN = :PRICECOLUMN, UPDATED_DATE = :UPDATED_DATE'
      'WHERE'
      '  CUSTOMERID = :Old_CUSTOMERID AND FK_GOODSID = :Old_FK_GOODSID')
    SQLRefresh.Strings = (
      
        'SELECT CUSTOMERID, GOODSID, FK_GOODSID, FK_GOODS_TITLE, FK_PRICE' +
        ', PRICECOLUMN, UPDATED_DATE FROM TDB_CUST_PRICELIST_DETAIL'
      'WHERE'
      '  CUSTOMERID = :CUSTOMERID AND FK_GOODSID = :FK_GOODSID')
    SQLLock.Strings = (
      'SELECT NULL FROM TDB_CUST_PRICELIST_DETAIL'
      'WHERE'
      'CUSTOMERID = :Old_CUSTOMERID AND FK_GOODSID = :Old_FK_GOODSID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'SELECT T1.*, C1.*, G.TITLE GOODS_NAME'
      'FROM VW_TDB_CUST_PRICELIST_DETAIL T1'
      'INNER JOIN TS_CUSTOMER C1 ON C1.CUSTOMERID = T1.CUSTOMERID'
      'LEFT OUTER JOIN TS_GOODS G ON G.GOODSID = T1.GOODSID'
      'WHERE T1.CUSTOMERID = :CUSTOMERID')
    Options.SetFieldsReadOnly = False
    Left = 536
    Top = 200
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CUSTOMERID'
        Value = nil
      end>
  end
  object IBCDSPriceList: TIBCDataSource
    DataSet = IBCQueryPriceList
    Left = 440
    Top = 200
  end
end
