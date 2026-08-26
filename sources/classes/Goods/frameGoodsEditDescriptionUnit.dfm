object frameGoodsEditDescription: TframeGoodsEditDescription
  Left = 0
  Top = 0
  Width = 926
  Height = 232
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object cxLabel2: TLabel
    Left = 12
    Top = 158
    Width = 101
    Height = 15
    Caption = 'Parametri auxiliari'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object cxLabel17: TLabel
    Left = 549
    Top = 19
    Width = 33
    Height = 15
    Caption = 'Brand'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label1: TLabel
    Left = 16
    Top = 20
    Width = 90
    Height = 15
    Caption = 'Tip produs, Web'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label2: TLabel
    Left = 16
    Top = 61
    Width = 77
    Height = 15
    Caption = 'Model RO/RU'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label3: TLabel
    Left = 13
    Top = 132
    Width = 100
    Height = 15
    Cursor = crHandPoint
    Caption = 'Parametri  RO/RU'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    OnClick = Label3Click
  end
  object Label4: TLabel
    Left = 16
    Top = 92
    Width = 55
    Height = 15
    Caption = 'Model RU'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object lcbVENDOR_ID: TcxDBLookupComboBox
    Left = 583
    Top = 16
    TabStop = False
    DataBinding.DataField = 'VENDOR_ID'
    DataBinding.DataSource = IBCDataSourceGOODS
    ParentFont = False
    Properties.DropDownRows = 16
    Properties.ImmediatePost = True
    Properties.IncrementalFilteringOptions = [ifoHighlightSearchText, ifoUseContainsOperator]
    Properties.KeyFieldNames = 'VENDORID'
    Properties.ListColumns = <
      item
        Caption = #1050#1086#1076
        Fixed = True
        Width = 50
        FieldName = 'VENDORID'
      end
      item
        FieldName = 'TITLE'
      end>
    Properties.ListFieldIndex = 1
    Properties.ListOptions.ShowHeader = False
    Properties.ListOptions.SyncMode = True
    Properties.ListSource = IBCDataSourceVendors
    Properties.OnChange = lcbVENDOR_IDPropertiesChange
    TabOrder = 3
    OnExit = cmbWEBGOODSTYPE_IDExit
    Width = 250
  end
  object cmbWEBGOODSTYPE_ID: TcxDBLookupComboBox
    Left = 118
    Top = 15
    TabStop = False
    DataBinding.DataField = 'WEBGOODSTYPE_ID'
    DataBinding.DataSource = IBCDataSourceGOODS
    ParentFont = False
    Properties.DropDownRows = 16
    Properties.DropDownWidth = 400
    Properties.ImmediatePost = True
    Properties.IncrementalFilteringOptions = [ifoHighlightSearchText, ifoUseContainsOperator]
    Properties.KeyFieldNames = 'GOODSTYPEID'
    Properties.ListColumns = <
      item
        Caption = #1050#1086#1076
        Fixed = True
        Width = 50
        FieldName = 'GOODSTYPEID'
      end
      item
        Caption = 'Rom'#226'nesc'
        SortOrder = soAscending
        Width = 140
        FieldName = 'TITLE'
      end
      item
        Caption = #1056#1091#1089#1089#1082#1080#1081
        Width = 140
        FieldName = 'TITLE_RUS'
      end>
    Properties.ListFieldIndex = 1
    Properties.ListOptions.ShowHeader = False
    Properties.ListOptions.SyncMode = True
    Properties.ListSource = IBCDataSourceWebGoodsType
    Properties.OnChange = cmbWEBGOODSTYPE_IDPropertiesChange
    TabOrder = 4
    OnExit = cmbWEBGOODSTYPE_IDExit
    Width = 220
  end
  object edCODE: TcxDBTextEdit
    Left = 119
    Top = 55
    DataBinding.DataField = 'CODE'
    DataBinding.DataSource = IBCDataSourceGOODS
    ParentFont = False
    TabOrder = 5
    OnExit = edCODEExit
    OnKeyUp = edCODEKeyUp
    Width = 793
  end
  object edBASE_PARAM: TcxDBTextEdit
    Left = 119
    Top = 124
    DataBinding.DataField = 'BASE_PARAM'
    DataBinding.DataSource = IBCDataSourceGOODS
    ParentFont = False
    TabOrder = 7
    OnExit = edBASE_PARAMExit
    OnKeyUp = edBASE_PARAMKeyUp
    Width = 392
  end
  object edDETAILS: TcxDBTextEdit
    Left = 119
    Top = 153
    DataBinding.DataField = 'DETAILS'
    DataBinding.DataSource = IBCDataSourceGOODS
    ParentFont = False
    TabOrder = 9
    OnExit = cmbWEBGOODSTYPE_IDExit
    Width = 547
  end
  object edCODE_RU: TcxDBTextEdit
    Left = 119
    Top = 84
    DataBinding.DataField = 'CODE_RU'
    DataBinding.DataSource = IBCDataSourceGOODS
    ParentFont = False
    TabOrder = 6
    OnExit = cmbWEBGOODSTYPE_IDExit
    Width = 793
  end
  object edBASE_PARAM_RU: TcxDBTextEdit
    Left = 517
    Top = 124
    DataBinding.DataField = 'BASE_PARAM_RU'
    DataBinding.DataSource = IBCDataSourceGOODS
    ParentFont = False
    TabOrder = 8
    OnExit = cmbWEBGOODSTYPE_IDExit
    Width = 395
  end
  object cmbColors: TcxDBLookupComboBox
    Left = 672
    Top = 153
    TabStop = False
    DataBinding.DataField = 'COLORID'
    DataBinding.DataSource = IBCDataSourceGOODS
    ParentFont = False
    Properties.DropDownRows = 16
    Properties.DropDownWidth = 400
    Properties.ImmediatePost = True
    Properties.IncrementalFilteringOptions = [ifoHighlightSearchText, ifoUseContainsOperator]
    Properties.KeyFieldNames = 'SYSSID'
    Properties.ListColumns = <
      item
        MinWidth = 64
        Width = 120
        FieldName = 'TITLE'
      end
      item
        MinWidth = 64
        Width = 120
        FieldName = 'VALUE_STR'
      end>
    Properties.ListOptions.ShowHeader = False
    Properties.ListSource = IBCDataSourceColors
    TabOrder = 10
    Width = 240
  end
  object cxButton1: TcxButton
    Left = 480
    Top = 14
    Width = 63
    Height = 25
    Caption = 'Catalog'
    TabOrder = 0
    TabStop = False
    OnClick = cxButton1Click
  end
  object cxButton2: TcxButton
    Left = 839
    Top = 14
    Width = 79
    Height = 25
    Caption = 'Catalog'
    TabOrder = 1
    TabStop = False
    OnClick = cxButton2Click
  end
  object cxDBLookupComboBox1: TcxDBLookupComboBox
    Left = 344
    Top = 15
    TabStop = False
    DataBinding.DataField = 'WEBGOODSTYPE_ID'
    DataBinding.DataSource = IBCDataSourceGOODS
    ParentFont = False
    Properties.DropDownRows = 16
    Properties.DropDownWidth = 400
    Properties.ImmediatePost = True
    Properties.IncrementalFilteringOptions = [ifoHighlightSearchText, ifoUseContainsOperator]
    Properties.KeyFieldNames = 'GOODSTYPEID'
    Properties.ListColumns = <
      item
        FieldName = 'GOODSTYPEID'
      end
      item
        FieldName = 'TITLE'
      end
      item
        SortOrder = soAscending
        FieldName = 'TITLE_RUS'
      end>
    Properties.ListFieldIndex = 2
    Properties.ListOptions.ShowHeader = False
    Properties.ListOptions.SyncMode = True
    Properties.ListSource = IBCDataSourceWebGoodsType
    Properties.OnChange = cmbWEBGOODSTYPE_IDPropertiesChange
    TabOrder = 2
    OnExit = cmbWEBGOODSTYPE_IDExit
    Width = 130
  end
  object Panel1: TPanel
    Left = 12
    Top = 182
    Width = 901
    Height = 41
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 11
    object lbWebNameRo: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 891
      Height = 31
      Align = alClient
      AutoSize = False
      Caption = 'test info'
      Color = clWhite
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = False
      WordWrap = True
      ExplicitTop = 0
    end
  end
  object IBCDataSourceGOODS: TIBCDataSource
    DataSet = IBCQueryGOODS
    Left = 456
    Top = 112
  end
  object IBCQueryVendors: TIBCQuery
    SQL.Strings = (
      'SELECT'
      '    VENDORID,'
      '    TITLE,'
      '    URL'
      'FROM'
      '    GET_VENDORS')
    Left = 608
    Top = 112
  end
  object IBCDataSourceVendors: TIBCDataSource
    DataSet = IBCQueryVendors
    Left = 392
    Top = 112
  end
  object IBCQueryWebGoodsType: TIBCQuery
    KeyFields = 'GOODSTYPEID'
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT'
      '*'
      'FROM'
      ' TS_GOODS_TYPE'
      'WHERE'
      ' GOODSTYPEID<>-1'
      ' order by title')
    Left = 576
    Top = 112
  end
  object IBCDataSourceWebGoodsType: TIBCDataSource
    DataSet = IBCQueryWebGoodsType
    Left = 360
    Top = 112
  end
  object IBCQueryGOODS: TIBCQuery
    SQLInsert.Strings = (
      'INSERT INTO VW_TS_GOODS'
      
        '  (GOODSID, PARENTID, FLG_FOLDER, BASE_PARAM, BASE_PARAM_RU, COD' +
        'E, CODE_RU, TITLE, DETAILS, FLG_SOCIAL, FLG_OLD, FLG_REQUIRE_CER' +
        'TIFICAT, FLG_PRICE_NBM, FLG_SUPPLIER_PROMO, WARRANTY, GOODS_ACNT' +
        '_ID, GOODS_TYPE_ID, GOODS_TYPE_NAME, WEBGOODSTYPE_ID, WEBGOODSTY' +
        'PE_TITLE, WEBGOODSTYPE_TITLE_RU, VENDOR_ID, USERID, UMID, SERIAL' +
        '_TYPE_ID, ORDERNO, USER_FULLNAME, CREATE_DATE, NAMEACNT, PRICE1,' +
        ' PRICE2, PRICE3, PRICE4, PRICE5, PRICE6, PRICE7, PRICE1_LEI, PRI' +
        'CE2_LEI, PRICE3_LEI, PRICE4_LEI, PRICE5_LEI, PRICE6_LEI, PRICE7_' +
        'LEI, PRICEC1_LEI, PRICEC2_LEI, PRICEC3_LEI, PRICEC4_LEI, PRICEC5' +
        '_LEI, PRICEC6_LEI, PRICEC7_LEI, PRICE1_USD, PRICE2_USD, PRICE3_U' +
        'SD, PRICE4_USD, PRICE5_USD, PRICE6_USD, PRICE7_USD, CURRENCYID, ' +
        'CURRENCY_TITLE, VENDOR, UM_TITLE, QTY_ACCOUNT, MINQTY, DELIVERY_' +
        'TYPEID, DELIVERY_TYPENAME, VAT, CASHBACK_PERCENT, colorid)'
      'VALUES'
      
        '  (:GOODSID, :PARENTID, :FLG_FOLDER, :BASE_PARAM, :BASE_PARAM_RU' +
        ', :CODE, :CODE_RU, :TITLE, :DETAILS, :FLG_SOCIAL, :FLG_OLD, :FLG' +
        '_REQUIRE_CERTIFICAT, :FLG_PRICE_NBM, :FLG_SUPPLIER_PROMO, :WARRA' +
        'NTY, :GOODS_ACNT_ID, :GOODS_TYPE_ID, :GOODS_TYPE_NAME, :WEBGOODS' +
        'TYPE_ID, :WEBGOODSTYPE_TITLE, :WEBGOODSTYPE_TITLE_RU, :VENDOR_ID' +
        ', :USERID, :UMID, :SERIAL_TYPE_ID, :ORDERNO, :USER_FULLNAME, :CR' +
        'EATE_DATE, :NAMEACNT, :PRICE1, :PRICE2, :PRICE3, :PRICE4, :PRICE' +
        '5, :PRICE6, :PRICE7, :PRICE1_LEI, :PRICE2_LEI, :PRICE3_LEI, :PRI' +
        'CE4_LEI, :PRICE5_LEI, :PRICE6_LEI, :PRICE7_LEI, :PRICEC1_LEI, :P' +
        'RICEC2_LEI, :PRICEC3_LEI, :PRICEC4_LEI, :PRICEC5_LEI, :PRICEC6_L' +
        'EI, :PRICEC7_LEI, :PRICE1_USD, :PRICE2_USD, :PRICE3_USD, :PRICE4' +
        '_USD, :PRICE5_USD, :PRICE6_USD, :PRICE7_USD, :CURRENCYID, :CURRE' +
        'NCY_TITLE, :VENDOR, :UM_TITLE, :QTY_ACCOUNT, :MINQTY, :DELIVERY_' +
        'TYPEID, :DELIVERY_TYPENAME, :VAT, :CASHBACK_PERCENT, :colorid)')
    SQLDelete.Strings = (
      'DELETE FROM VW_TS_GOODS'
      'WHERE'
      '  GOODSID = :Old_GOODSID')
    SQLUpdate.Strings = (
      'UPDATE VW_TS_GOODS'
      'SET'
      
        '  GOODSID = :GOODSID, PARENTID = :PARENTID, FLG_FOLDER = :FLG_FO' +
        'LDER, BASE_PARAM = :BASE_PARAM, BASE_PARAM_RU = :BASE_PARAM_RU, '
      
        '  CODE = :CODE, CODE_RU = :CODE_RU, TITLE = :TITLE, DETAILS = :D' +
        'ETAILS, FLG_SOCIAL = :FLG_SOCIAL, FLG_OLD = :FLG_OLD, '
      
        '  FLG_REQUIRE_CERTIFICAT = :FLG_REQUIRE_CERTIFICAT, FLG_PRICE_NB' +
        'M = :FLG_PRICE_NBM, FLG_SUPPLIER_PROMO = :FLG_SUPPLIER_PROMO, '
      
        '  WARRANTY = :WARRANTY, GOODS_ACNT_ID = :GOODS_ACNT_ID, GOODS_TY' +
        'PE_ID = :GOODS_TYPE_ID, GOODS_TYPE_NAME = :GOODS_TYPE_NAME, '
      
        '  WEBGOODSTYPE_ID = :WEBGOODSTYPE_ID, WEBGOODSTYPE_TITLE = :WEBG' +
        'OODSTYPE_TITLE, WEBGOODSTYPE_TITLE_RU = :WEBGOODSTYPE_TITLE_RU, '
      
        '  VENDOR_ID = :VENDOR_ID, USERID = :USERID, UMID = :UMID, SERIAL' +
        '_TYPE_ID = :SERIAL_TYPE_ID, ORDERNO = :ORDERNO, '
      
        '  USER_FULLNAME = :USER_FULLNAME, CREATE_DATE = :CREATE_DATE, NA' +
        'MEACNT = :NAMEACNT, '
      
        '  PRICE1 = :PRICE1, PRICE2 = :PRICE2, PRICE3 = :PRICE3, PRICE4 =' +
        ' :PRICE4, PRICE5 = :PRICE5, PRICE6 = :PRICE6, PRICE7 = :PRICE7, '
      
        '  PRICE1_LEI = :PRICE1_LEI, PRICE2_LEI = :PRICE2_LEI, PRICE3_LEI' +
        ' = :PRICE3_LEI, PRICE4_LEI = :PRICE4_LEI, PRICE5_LEI = :PRICE5_L' +
        'EI, '
      
        '  PRICE6_LEI = :PRICE6_LEI, PRICE7_LEI = :PRICE7_LEI, PRICEC1_LE' +
        'I = :PRICEC1_LEI, PRICEC2_LEI = :PRICEC2_LEI, PRICEC3_LEI = :PRI' +
        'CEC3_LEI, '
      
        '  PRICEC4_LEI = :PRICEC4_LEI, PRICEC5_LEI = :PRICEC5_LEI, PRICEC' +
        '6_LEI = :PRICEC6_LEI, PRICEC7_LEI = :PRICEC7_LEI, PRICE1_USD = :' +
        'PRICE1_USD, '
      
        '  PRICE2_USD = :PRICE2_USD, PRICE3_USD = :PRICE3_USD, PRICE4_USD' +
        ' = :PRICE4_USD, PRICE5_USD = :PRICE5_USD, PRICE6_USD = :PRICE6_U' +
        'SD, '
      
        '  PRICE7_USD = :PRICE7_USD, CURRENCYID = :CURRENCYID, CURRENCY_T' +
        'ITLE = :CURRENCY_TITLE, VENDOR = :VENDOR, UM_TITLE = :UM_TITLE, '
      
        '  QTY_ACCOUNT = :QTY_ACCOUNT, MINQTY = :MINQTY, DELIVERY_TYPEID ' +
        '= :DELIVERY_TYPEID, DELIVERY_TYPENAME = :DELIVERY_TYPENAME, VAT ' +
        '= :VAT, '
      '  CASHBACK_PERCENT = :CASHBACK_PERCENT, colorid = :colorid'
      'WHERE'
      '  GOODSID = :Old_GOODSID')
    SQLRefresh.Strings = (
      'SELECT * FROM VW_TS_GOODS'
      'WHERE'
      '  GOODSID = :GOODSID')
    SQLLock.Strings = (
      'SELECT NULL FROM TS_GOODS'
      'WHERE'
      'GOODSID = :Old_GOODSID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM VW_TS_GOODS'
      ''
      ') q')
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'select * from vw_ts_goods where goodsid = :goodsid')
    Left = 544
    Top = 113
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'goodsid'
        Value = nil
      end>
  end
  object IBCQueryColors: TIBCQuery
    SQL.Strings = (
      'select * from ts_syss where parentid=53')
    Left = 641
    Top = 112
  end
  object IBCDataSourceColors: TIBCDataSource
    DataSet = IBCQueryColors
    Left = 422
    Top = 113
  end
end
