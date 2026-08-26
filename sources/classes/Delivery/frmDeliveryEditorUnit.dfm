object frmDeliveryEditorDlg: TfrmDeliveryEditorDlg
  Left = 0
  Top = 0
  Caption = 'frmDeliveryEditorDlg'
  ClientHeight = 441
  ClientWidth = 1048
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object cxGroupBox2: TcxGroupBox
    Left = -3
    Top = 39
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Informtie despre destinatar'
    PanelStyle.CaptionIndent = 3
    TabOrder = 0
    Height = 190
    Width = 867
    object cxDBLookupComboBox2: TcxDBLookupComboBox
      Left = 139
      Top = 47
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      DataBinding.DataField = 'DISTRICTID'
      Properties.IncrementalFilteringOptions = [ifoHighlightSearchText, ifoUseContainsOperator]
      Properties.KeyFieldNames = 'SYSSID'
      Properties.ListColumns = <
        item
          FieldName = 'TITLE'
        end>
      Properties.ListOptions.RowSelect = False
      Properties.ListOptions.ShowHeader = False
      Properties.ListOptions.SyncMode = True
      TabOrder = 0
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
      TabOrder = 1
    end
    object cxDBLookupComboBox3: TcxDBLookupComboBox
      Left = 358
      Top = 47
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      DataBinding.DataField = 'CITYID'
      Properties.IncrementalFilteringOptions = [ifoHighlightSearchText, ifoUseContainsOperator]
      Properties.KeyFieldNames = 'SYSSID'
      Properties.ListColumns = <
        item
          FieldName = 'TITLE'
        end>
      Properties.ListOptions.RowSelect = False
      Properties.ListOptions.ShowHeader = False
      Properties.ListOptions.SyncMode = True
      TabOrder = 2
      Width = 153
    end
    object cxLabel5: TcxLabel
      Left = 315
      Top = 47
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Oras'
      TabOrder = 3
    end
    object cxDBDateEdit1: TcxDBDateEdit
      Left = 585
      Top = 47
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      DataBinding.DataField = 'DELIVERY_DATE'
      TabOrder = 4
      Width = 101
    end
    object cxLabel6: TcxLabel
      Left = 543
      Top = 47
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Data'
      TabOrder = 5
    end
    object cxLabel7: TcxLabel
      Left = 710
      Top = 47
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Ora'
      TabOrder = 6
    end
    object cxDBTimeEdit1: TcxDBTimeEdit
      Left = 746
      Top = 47
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      DataBinding.DataField = 'DELIVERY_TIME'
      Properties.ImmediatePost = True
      Properties.TimeFormat = tfHourMin
      TabOrder = 7
      Width = 92
    end
    object cxLabel8: TcxLabel
      Left = 20
      Top = 74
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Strada'
      TabOrder = 8
    end
    object cxDBMemo1: TcxDBMemo
      Left = 139
      Top = 74
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      DataBinding.DataField = 'DELIVERY_ADDRESS'
      ParentFont = False
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -12
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = []
      Style.IsFontAssigned = True
      TabOrder = 9
      Height = 19
      Width = 699
    end
    object cxLabel9: TcxLabel
      Left = 20
      Top = 117
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Telefon'
      TabOrder = 10
    end
    object cxDBTextEdit2: TcxDBTextEdit
      Left = 139
      Top = 114
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      DataBinding.DataField = 'PHONE_NUMBER'
      TabOrder = 11
      Width = 372
    end
    object cxLabel10: TcxLabel
      Left = 20
      Top = 140
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Mentiuni'
      TabOrder = 12
    end
    object cxDBMemo2: TcxDBMemo
      Left = 139
      Top = 145
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      DataBinding.DataField = 'COMMENTS'
      TabOrder = 13
      Height = 41
      Width = 699
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
    Left = 160
    Top = 200
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'SYSSID'
        Value = nil
      end>
  end
  object IBCDataSourceCities: TIBCDataSource
    DataSet = IBCQueryCities
    Left = 160
    Top = 144
  end
  object IBCQueryDistricts: TIBCQuery
    KeyFields = 'SYSSID'
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'select * from SP_GET_SYSS_LIST(3)'
      'order by title')
    Left = 80
    Top = 200
  end
  object IBCDataSourceDistricts: TIBCDataSource
    DataSet = IBCQueryDistricts
    Left = 88
    Top = 144
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
    Left = 236
    Top = 201
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DOCID'
        Value = nil
      end>
  end
  object IBCDSDelivery: TIBCDataSource
    DataSet = IBCQueryDelivery
    Left = 236
    Top = 149
  end
end
