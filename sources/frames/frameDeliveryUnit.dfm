object frameDelivery: TframeDelivery
  Left = 0
  Top = 0
  Width = 1002
  Height = 280
  Margins.Left = 4
  Margins.Top = 4
  Margins.Right = 4
  Margins.Bottom = 4
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object cxGroupBox1: TcxGroupBox
    Left = 14
    Top = 31
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Transportator'
    PanelStyle.CaptionIndent = 3
    TabOrder = 0
    Height = 242
    Width = 471
    object cxLabel1: TcxLabel
      Left = 20
      Top = 50
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Curier'
      ParentFont = False
      Style.Font.Charset = RUSSIAN_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -12
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = []
      Style.IsFontAssigned = True
      TabOrder = 0
      Transparent = True
    end
    object beCurier: TcxDBButtonEdit
      Left = 90
      Top = 49
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      DataBinding.DataField = 'COURIER_NAME'
      DataBinding.DataSource = IBCDSDelivery
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      Properties.OnButtonClick = beCurierPropertiesButtonClick
      TabOrder = 1
      Width = 361
    end
    object cxLabel2: TcxLabel
      Left = 20
      Top = 23
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'AWB'
      ParentFont = False
      Style.Font.Charset = RUSSIAN_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -12
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = []
      Style.IsFontAssigned = True
      TabOrder = 2
      Transparent = True
    end
    object cxDBTextEdit1: TcxDBTextEdit
      Left = 90
      Top = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      DataBinding.DataField = 'AWB'
      DataBinding.DataSource = IBCDSDelivery
      TabOrder = 3
      Width = 361
    end
    object cxDBCheckBox1: TcxDBCheckBox
      Left = 90
      Top = 81
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Ramburs'
      DataBinding.DataField = 'FLG_RAMBURS'
      DataBinding.DataSource = IBCDSDelivery
      Properties.Alignment = taLeftJustify
      Properties.ImmediatePost = True
      Properties.NullStyle = nssUnchecked
      Properties.ValueChecked = '1'
      Properties.ValueUnchecked = '0'
      Style.TransparentBorder = False
      TabOrder = 4
      Transparent = True
    end
    object cxDBCheckBox2: TcxDBCheckBox
      Left = 310
      Top = 102
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Factura'
      DataBinding.DataField = 'FLG_INVOICE_ONDELIVERY'
      DataBinding.DataSource = IBCDSDelivery
      Properties.Alignment = taLeftJustify
      Properties.ImmediatePost = True
      Properties.NullStyle = nssUnchecked
      Properties.ValueChecked = '1'
      Properties.ValueUnchecked = '0'
      Style.TransparentBorder = False
      TabOrder = 5
      Transparent = True
    end
    object cxDBCheckBox3: TcxDBCheckBox
      Left = 90
      Top = 102
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Numarar'
      DataBinding.DataField = 'FLG_CASHONDELIVERY'
      DataBinding.DataSource = IBCDSDelivery
      Properties.Alignment = taLeftJustify
      Properties.ImmediatePost = True
      Properties.NullStyle = nssUnchecked
      Properties.ValueChecked = '1'
      Properties.ValueUnchecked = '0'
      Style.TransparentBorder = False
      TabOrder = 6
      Transparent = True
    end
    object cxDBCheckBox4: TcxDBCheckBox
      Left = 200
      Top = 81
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Card bancar'
      DataBinding.DataField = 'FLG_POS_TERMINAL'
      DataBinding.DataSource = IBCDSDelivery
      Properties.Alignment = taLeftJustify
      Properties.ImmediatePost = True
      Properties.NullStyle = nssUnchecked
      Properties.ValueChecked = '1'
      Properties.ValueUnchecked = '0'
      Style.TransparentBorder = False
      TabOrder = 7
      Transparent = True
    end
    object cxDBCheckBox5: TcxDBCheckBox
      Left = 200
      Top = 102
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Credit'
      DataBinding.DataField = 'FLG_CREDIT'
      DataBinding.DataSource = IBCDSDelivery
      Properties.Alignment = taLeftJustify
      Properties.ImmediatePost = True
      Properties.NullStyle = nssUnchecked
      Properties.ValueChecked = '1'
      Properties.ValueUnchecked = '0'
      Style.TransparentBorder = False
      TabOrder = 8
      Transparent = True
    end
  end
  object cxGroupBox2: TcxGroupBox
    Left = 488
    Top = 32
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Informtie despre destinatar'
    PanelStyle.CaptionIndent = 3
    TabOrder = 5
    Height = 241
    Width = 509
    object cxDBLookupComboBox1: TcxDBLookupComboBox
      Left = 139
      Top = 19
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      DataBinding.DataField = 'STATEID'
      DataBinding.DataSource = IBCDSDelivery
      Properties.IncrementalFilteringOptions = [ifoHighlightSearchText, ifoUseContainsOperator]
      Properties.KeyFieldNames = 'SYSSID'
      Properties.ListColumns = <
        item
          FieldName = 'TITLE'
        end>
      Properties.ListOptions.RowSelect = False
      Properties.ListOptions.ShowHeader = False
      Properties.ListOptions.SyncMode = True
      Properties.ListSource = IBCDataSourceStatutLivrari
      TabOrder = 0
      Width = 354
    end
    object cxLabel3: TcxLabel
      Left = 20
      Top = 24
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Statut livrare'
      TabOrder = 1
    end
    object cxDBLookupComboBox2: TcxDBLookupComboBox
      Left = 139
      Top = 47
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      DataBinding.DataField = 'DISTRICTID'
      DataBinding.DataSource = IBCDSDelivery
      Properties.IncrementalFilteringOptions = [ifoHighlightSearchText, ifoUseContainsOperator]
      Properties.KeyFieldNames = 'SYSSID'
      Properties.ListColumns = <
        item
          FieldName = 'TITLE'
        end>
      Properties.ListOptions.RowSelect = False
      Properties.ListOptions.ShowHeader = False
      Properties.ListOptions.SyncMode = True
      Properties.ListSource = IBCDataSourceDistricts
      TabOrder = 2
      Width = 152
    end
    object cxLabel4: TcxLabel
      Left = 20
      Top = 47
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Raion'
      TabOrder = 3
    end
    object cxDBLookupComboBox3: TcxDBLookupComboBox
      Left = 358
      Top = 47
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      DataBinding.DataField = 'CITYID'
      DataBinding.DataSource = IBCDSDelivery
      Properties.IncrementalFilteringOptions = [ifoHighlightSearchText, ifoUseContainsOperator]
      Properties.KeyFieldNames = 'SYSSID'
      Properties.ListColumns = <
        item
          FieldName = 'TITLE'
        end>
      Properties.ListOptions.RowSelect = False
      Properties.ListOptions.ShowHeader = False
      Properties.ListOptions.SyncMode = True
      Properties.ListSource = IBCDataSourceCities
      TabOrder = 4
      Width = 139
    end
    object cxLabel5: TcxLabel
      Left = 315
      Top = 47
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Oras'
      TabOrder = 5
    end
    object cxDBDateEdit1: TcxDBDateEdit
      Left = 137
      Top = 75
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      DataBinding.DataField = 'DELIVERY_DATE'
      DataBinding.DataSource = IBCDSDelivery
      TabOrder = 6
      Width = 101
    end
    object cxLabel6: TcxLabel
      Left = 19
      Top = 75
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Data'
      TabOrder = 7
    end
    object cxLabel7: TcxLabel
      Left = 262
      Top = 79
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Ora'
      TabOrder = 8
    end
    object cxDBTimeEdit1: TcxDBTimeEdit
      Left = 298
      Top = 75
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      DataBinding.DataField = 'DELIVERY_TIME'
      DataBinding.DataSource = IBCDSDelivery
      Properties.ImmediatePost = True
      Properties.TimeFormat = tfHourMin
      TabOrder = 9
      Width = 92
    end
    object cxLabel8: TcxLabel
      Left = 20
      Top = 113
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Adresa'
      TabOrder = 10
    end
    object cxDBMemo1: TcxDBMemo
      Left = 139
      Top = 118
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      DataBinding.DataField = 'DELIVERY_ADDRESS'
      DataBinding.DataSource = IBCDSDelivery
      ParentFont = False
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -12
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = []
      Style.IsFontAssigned = True
      TabOrder = 11
      Height = 41
      Width = 362
    end
    object cxLabel9: TcxLabel
      Left = 20
      Top = 161
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Telefon'
      TabOrder = 12
    end
    object cxDBTextEdit2: TcxDBTextEdit
      Left = 139
      Top = 164
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      DataBinding.DataField = 'PHONE_NUMBER'
      DataBinding.DataSource = IBCDSDelivery
      TabOrder = 13
      Width = 150
    end
    object cxLabel10: TcxLabel
      Left = 20
      Top = 184
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Mentiuni'
      TabOrder = 14
    end
    object cxDBMemo2: TcxDBMemo
      Left = 139
      Top = 189
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      DataBinding.DataField = 'COMMENTS'
      DataBinding.DataSource = IBCDSDelivery
      TabOrder = 15
      Height = 41
      Width = 362
    end
  end
  object IBCQueryCities: TIBCQuery
    KeyFields = 'SYSSID'
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      'select * from ts_syss where parentid=2')
    MasterFields = 'SYSSID'
    DetailFields = 'VALUE_INT'
    MasterSource = IBCDataSourceDistricts
    Left = 440
    Top = 80
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'SYSSID'
        Value = nil
      end>
  end
  object IBCDataSourceCities: TIBCDataSource
    DataSet = IBCQueryCities
    Left = 328
    Top = 80
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
    PopupMenuLinks = <>
    UseSystemFont = False
    Left = 344
    Top = 136
    PixelsPerInch = 96
    DockControlHeights = (
      0
      0
      28
      0)
    object dxBarManager1Bar1: TdxBar
      Caption = 'Custom 1'
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 0
      DockedTop = 0
      DockingStyle = dsTop
      FloatLeft = 1138
      FloatTop = 0
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbModifyDelivery'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbSaveDelivery'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbDeleteDelivery'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbPrint'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object bbModifyDelivery: TdxBarButton
      Caption = 'Modifica'
      Category = 0
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 41
      OnClick = bbModifyDeliveryClick
    end
    object bbSaveDelivery: TdxBarButton
      Caption = 'Salveaza'
      Category = 0
      Hint = 'Salveaza'
      Visible = ivAlways
      ImageIndex = 32
      OnClick = bbSaveDeliveryClick
    end
    object bbDeleteDelivery: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      OnClick = bbDeleteDeliveryClick
    end
    object bbPrint: TdxBarButton
      Caption = 'Tipar'
      Category = 0
      Hint = 'Tipar'
      Visible = ivAlways
      ImageIndex = 28
      OnClick = bbPrintClick
    end
  end
  object IBCQueryDelivery: TIBCQuery
    KeyFields = 'DOCID'
    SQLInsert.Strings = (
      'INSERT INTO VW_TDB_DOCS_DELIVERY'
      
        '  (DOCID, COURIERID, COURIER_NAME, DELIVERY_ADDRESS, DELIVERY_TI' +
        'ME, DELIVERY_DATE, FLG_CASHONDELIVERY, FLG_INVOICE_ONDELIVERY, F' +
        'LG_POS_TERMINAL, FLG_CREDIT, TRANSMIS_CURIER, AWB, DRIVERID, DRI' +
        'VER_NAME, DISTRICTID, DISTRICT_NAME, CITYID, CITY_NAME, COMMENTS' +
        ', STATEID, STATE_NAME, PHONE_NUMBER)'
      'VALUES'
      
        '  (:DOCID, :COURIERID, :COURIER_NAME, :DELIVERY_ADDRESS, :DELIVE' +
        'RY_TIME, :DELIVERY_DATE, :FLG_CASHONDELIVERY, :FLG_INVOICE_ONDEL' +
        'IVERY, :FLG_POS_TERMINAL, :FLG_CREDIT, :TRANSMIS_CURIER, :AWB, :' +
        'DRIVERID, :DRIVER_NAME, :DISTRICTID, :DISTRICT_NAME, :CITYID, :C' +
        'ITY_NAME, :COMMENTS, :STATEID, :STATE_NAME, :PHONE_NUMBER)')
    SQLDelete.Strings = (
      'DELETE FROM VW_TDB_DOCS_DELIVERY'
      'WHERE'
      '  DOCID = :Old_DOCID')
    SQLUpdate.Strings = (
      'UPDATE VW_TDB_DOCS_DELIVERY'
      'SET'
      
        '  DOCID = :DOCID, COURIERID = :COURIERID, COURIER_NAME = :COURIE' +
        'R_NAME, DELIVERY_ADDRESS = :DELIVERY_ADDRESS, DELIVERY_TIME = :D' +
        'ELIVERY_TIME, DELIVERY_DATE = :DELIVERY_DATE, FLG_CASHONDELIVERY' +
        ' = :FLG_CASHONDELIVERY, FLG_INVOICE_ONDELIVERY = :FLG_INVOICE_ON' +
        'DELIVERY, FLG_POS_TERMINAL = :FLG_POS_TERMINAL, FLG_CREDIT = :FL' +
        'G_CREDIT, TRANSMIS_CURIER = :TRANSMIS_CURIER, AWB = :AWB, DRIVER' +
        'ID = :DRIVERID, DRIVER_NAME = :DRIVER_NAME, DISTRICTID = :DISTRI' +
        'CTID, DISTRICT_NAME = :DISTRICT_NAME, CITYID = :CITYID, CITY_NAM' +
        'E = :CITY_NAME, COMMENTS = :COMMENTS, STATEID = :STATEID, STATE_' +
        'NAME = :STATE_NAME, PHONE_NUMBER = :PHONE_NUMBER'
      'WHERE'
      '  DOCID = :Old_DOCID')
    SQLRefresh.Strings = (
      
        'SELECT DOCID, COURIERID, COURIER_NAME, DELIVERY_ADDRESS, DELIVER' +
        'Y_TIME, DELIVERY_DATE, FLG_CASHONDELIVERY, FLG_INVOICE_ONDELIVER' +
        'Y, FLG_POS_TERMINAL, FLG_CREDIT, TRANSMIS_CURIER, AWB, DRIVERID,' +
        ' DRIVER_NAME, DISTRICTID, DISTRICT_NAME, CITYID, CITY_NAME, COMM' +
        'ENTS, STATEID, STATE_NAME, PHONE_NUMBER FROM VW_TDB_DOCS_DELIVER' +
        'Y'
      'WHERE'
      '  DOCID = :DOCID')
    SQLLock.Strings = (
      'SELECT NULL FROM TDB_DOCS_DELIVERY'
      'WHERE'
      'DOCID = :Old_DOCID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM VW_TDB_DOCS_DELIVERY'
      ''
      ') q')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'select *'
      'from VW_TDB_DOCS_DELIVERY DD  ')
    MasterFields = 'DOCID'
    DetailFields = 'DOCID'
    MasterSource = dmDB.IBCDataSourceDocs
    AfterInsert = IBCQueryDeliveryAfterInsert
    Left = 708
    Top = 121
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DOCID'
        Value = nil
      end>
  end
  object IBCDSDelivery: TIBCDataSource
    DataSet = IBCQueryDelivery
    OnStateChange = IBCDSDeliveryStateChange
    Left = 708
    Top = 77
  end
  object IBCQueryDistricts: TIBCQuery
    KeyFields = 'SYSSID'
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'select * from SP_GET_SYSS_LIST(3)'
      'order by title')
    Left = 168
    Top = 144
  end
  object IBCDataSourceDistricts: TIBCDataSource
    DataSet = IBCQueryDistricts
    Left = 88
    Top = 144
  end
  object IBCQueryStatutLivrari: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'select * from ts_syss where parentid = 56 order by syssid')
    Left = 560
    Top = 124
  end
  object IBCDataSourceStatutLivrari: TIBCDataSource
    DataSet = IBCQueryStatutLivrari
    Left = 560
    Top = 68
  end
end
