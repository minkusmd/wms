object dmDB: TdmDB
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 521
  Width = 1311
  object IBCTrDefaultUpdate: TIBCTransaction
    DefaultConnection = IBCConnection
    Left = 152
    Top = 88
  end
  object IBCConnection: TIBCConnection
    Database = 'sw'
    Options.Charset = 'UTF8'
    Options.UseUnicode = True
    Options.EnableMemos = True
    Options.DisconnectedMode = True
    Options.LocalFailover = True
    Options.EnableBCD = True
    DefaultTransaction = IBCTrDefaultSelect
    ClientLibrary = 'fbclient.dll'
    Port = '3050'
    SSLOptions.Enabled = False
    Username = 'SYSDBA'
    Server = '192.168.106.254'
    LoginPrompt = False
    OnConnectionLost = IBCConnectionConnectionLost
    Left = 96
    Top = 24
    EncryptedPassword = '8AFF96FF98FF8DFF9AFF8CFFCCFFCDFFCEFF'
  end
  object IBCTrDefaultSelect: TIBCTransaction
    DefaultConnection = IBCConnection
    IsolationLevel = iblReadOnlyReadCommitted
    Left = 40
    Top = 88
  end
  object IBCQueryTemp: TIBCQuery
    Connection = IBCConnection
    Transaction = IBCTrDefaultSelect
    UpdateTransaction = IBCTrDefaultUpdate
    AutoCommit = False
    Options.BooleanDomainFields = True
    Options.DescribeParams = True
    Options.RequiredFields = False
    LocalConstraints = False
    Left = 48
    Top = 216
  end
  object IBCQuerySchedulerEvents: TIBCQuery
    KeyFields = 'ID'
    KeyGenerator = 'SQ_TS_SCHEDULER_EVENTS_ID'
    SQLInsert.Strings = (
      'INSERT INTO TS_SCHEDULER_EVENTS'
      
        '  (ID, PARENTID, CUSTOMERID, TYPE, "START", FINISH, OPTIONS, CAP' +
        'TION, RECURRENCEINDEX, RECURRENCEINFO, RESOURCEID, LOCATION, MES' +
        'SAGE, REMINDERDATE, REMINDERMINUTES, STATE, LABELCOLOR, ACTUALST' +
        'ART, ACTUALFINISH, SYNCIDFIELD)'
      'VALUES'
      
        '  (:ID, :PARENTID, :CUSTOMERID, :TYPE, :START, :FINISH, :OPTIONS' +
        ', :CAPTION, :RECURRENCEINDEX, :RECURRENCEINFO, :RESOURCEID, :LOC' +
        'ATION, :MESSAGE, :REMINDERDATE, :REMINDERMINUTES, :STATE, :LABEL' +
        'COLOR, :ACTUALSTART, :ACTUALFINISH, :SYNCIDFIELD)')
    SQLDelete.Strings = (
      'DELETE FROM TS_SCHEDULER_EVENTS'
      'WHERE'
      '  ID = :Old_ID')
    SQLUpdate.Strings = (
      'UPDATE TS_SCHEDULER_EVENTS'
      'SET'
      
        '  ID = :ID, PARENTID = :PARENTID, CUSTOMERID = :CUSTOMERID, TYPE' +
        ' = :TYPE, "START" = :START, FINISH = :FINISH, OPTIONS = :OPTIONS' +
        ', CAPTION = :CAPTION, RECURRENCEINDEX = :RECURRENCEINDEX, RECURR' +
        'ENCEINFO = :RECURRENCEINFO, RESOURCEID = :RESOURCEID, LOCATION =' +
        ' :LOCATION, MESSAGE = :MESSAGE, REMINDERDATE = :REMINDERDATE, RE' +
        'MINDERMINUTES = :REMINDERMINUTES, STATE = :STATE, LABELCOLOR = :' +
        'LABELCOLOR, ACTUALSTART = :ACTUALSTART, ACTUALFINISH = :ACTUALFI' +
        'NISH, SYNCIDFIELD = :SYNCIDFIELD'
      'WHERE'
      '  ID = :Old_ID')
    SQLRefresh.Strings = (
      
        'SELECT TS_SCHEDULER_EVENTS.ID, TS_SCHEDULER_EVENTS.PARENTID, TS_' +
        'SCHEDULER_EVENTS.CUSTOMERID, TS_SCHEDULER_EVENTS.TYPE, TS_SCHEDU' +
        'LER_EVENTS."START", TS_SCHEDULER_EVENTS.FINISH, TS_SCHEDULER_EVE' +
        'NTS.OPTIONS, TS_SCHEDULER_EVENTS.CAPTION, TS_SCHEDULER_EVENTS.RE' +
        'CURRENCEINDEX, TS_SCHEDULER_EVENTS.RECURRENCEINFO, TS_SCHEDULER_' +
        'EVENTS.RESOURCEID, TS_SCHEDULER_EVENTS.LOCATION, TS_SCHEDULER_EV' +
        'ENTS.MESSAGE, TS_SCHEDULER_EVENTS.REMINDERDATE, TS_SCHEDULER_EVE' +
        'NTS.REMINDERMINUTES, TS_SCHEDULER_EVENTS.STATE, TS_SCHEDULER_EVE' +
        'NTS.LABELCOLOR, TS_SCHEDULER_EVENTS.ACTUALSTART, TS_SCHEDULER_EV' +
        'ENTS.ACTUALFINISH, TS_SCHEDULER_EVENTS.SYNCIDFIELD FROM TS_SCHED' +
        'ULER_EVENTS'
      'WHERE'
      '  ID = :ID')
    SQLLock.Strings = (
      'SELECT NULL FROM TS_SCHEDULER_EVENTS'
      'WHERE'
      'ID = :Old_ID'
      'FOR UPDATE WITH LOCK')
    Connection = IBCConnection
    Transaction = TrSchedulerUpdate
    SQL.Strings = (
      'SELECT *'
      'FROM TS_SCHEDULER_EVENTS')
    MasterFields = 'RESOURCESID'
    DetailFields = 'RESOURCEID'
    MasterSource = IBCDataSourceSchedulerResources
    AfterPost = IBCQuerySchedulerEventsAfterPost
    AfterDelete = IBCQuerySchedulerEventsAfterPost
    Left = 936
    Top = 216
    ParamData = <
      item
        DataType = ftInteger
        Name = 'RESOURCESID'
        ParamType = ptInput
        Value = nil
      end>
  end
  object IBCQuerySchedulerResources: TIBCQuery
    KeyFields = 'RESOURCESID'
    SQLInsert.Strings = (
      'INSERT INTO TS_SCHEDULER_RESOURCES'
      '  (RESOURCESID, RESOURCECOLOR, RESOURCENAME, RESOURCEIMAGE)'
      'VALUES'
      '  (:RESOURCESID, :RESOURCECOLOR, :RESOURCENAME, :RESOURCEIMAGE)')
    SQLDelete.Strings = (
      'DELETE FROM TS_SCHEDULER_RESOURCES'
      'WHERE'
      '  RESOURCESID = :Old_RESOURCESID')
    SQLUpdate.Strings = (
      'UPDATE TS_SCHEDULER_RESOURCES'
      'SET'
      
        '  RESOURCESID = :RESOURCESID, RESOURCECOLOR = :RESOURCECOLOR, RE' +
        'SOURCENAME = :RESOURCENAME, RESOURCEIMAGE = :RESOURCEIMAGE'
      'WHERE'
      '  RESOURCESID = :Old_RESOURCESID')
    SQLRefresh.Strings = (
      
        'SELECT TS_SCHEDULER_RESOURCES.RESOURCESID, TS_SCHEDULER_RESOURCE' +
        'S.RESOURCECOLOR, TS_SCHEDULER_RESOURCES.RESOURCENAME, TS_SCHEDUL' +
        'ER_RESOURCES.RESOURCEIMAGE FROM TS_SCHEDULER_RESOURCES'
      'WHERE'
      '  RESOURCESID = :RESOURCESID')
    SQLLock.Strings = (
      'SELECT NULL FROM TS_SCHEDULER_RESOURCES'
      'WHERE'
      'RESOURCESID = :Old_RESOURCESID'
      'FOR UPDATE WITH LOCK')
    Connection = IBCConnection
    Transaction = IBCTrDefaultSelect
    UpdateTransaction = TrSchedulerUpdate
    SQL.Strings = (
      'SELECT '
      ' *'
      'FROM '
      ' TS_SCHEDULER_RESOURCES'
      'WHERE '
      ' (RESOURCESID = :UserID)')
    LockMode = lmLockImmediate
    Left = 936
    Top = 88
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'UserID'
        Value = nil
      end>
  end
  object IBCDataSourceSchedulerEvents: TIBCDataSource
    DataSet = IBCQuerySchedulerEvents
    Left = 936
    Top = 160
  end
  object IBCDataSourceSchedulerResources: TIBCDataSource
    DataSet = IBCQuerySchedulerResources
    Left = 936
    Top = 40
  end
  object IBCDataSourceDocs: TIBCDataSource
    DataSet = IBCQueryDocs
    Left = 304
    Top = 40
  end
  object IBCQueryFirms: TIBCQuery
    Connection = IBCConnection
    Transaction = IBCTrDefaultSelect
    SQL.Strings = (
      'SELECT'
      ' CUSTOMERID,'
      ' DISPLAYNAME'
      'FROM'
      ' GET_FIRMS_BY_USER2 '
      'ORDER BY '
      ' ORDERNO')
    Options.BooleanDomainFields = True
    Left = 72
    Top = 432
  end
  object IBCDataSourceFirms: TIBCDataSource
    AutoEdit = False
    DataSet = IBCQueryFirms
    Left = 72
    Top = 384
  end
  object IBCQueryCustomers: TIBCQuery
    Connection = IBCConnection
    Transaction = IBCTrDefaultSelect
    SQL.Strings = (
      'SELECT'
      '    CUSTOMERID,'
      '    DISPLAYNAME'
      'FROM'
      '    TS_CUSTOMER '
      'WHERE '
      '    (FLG_FOLDER=0) and (CUSTOMERID>=0)'
      'ORDER BY '
      '    DISPLAYNAME')
    Options.BooleanDomainFields = True
    Left = 200
    Top = 432
  end
  object IBCDataSourceCustomers: TIBCDataSource
    AutoEdit = False
    DataSet = IBCQueryCustomers
    Left = 200
    Top = 384
  end
  object IBCQueryCurrency: TIBCQuery
    Connection = IBCConnection
    Transaction = IBCTrDefaultSelect
    SQL.Strings = (
      'SELECT'
      '    CURRENCYID,'
      '    TITLE,'
      '    SHORTNAME,'
      '    EXCHANGE_RATE,'
      '    BNM_RATE,'
      '    TRANSFER_RATE'
      'FROM'
      '    TS_CURRENCY'
      'ORDER BY'
      '    CURRENCYID')
    Options.BooleanDomainFields = True
    Left = 336
    Top = 432
  end
  object IBCDataSourceCurrency: TIBCDataSource
    DataSet = IBCQueryCurrency
    Left = 336
    Top = 384
  end
  object IBCQueryAnalitica: TIBCQuery
    Connection = IBCConnection
    Transaction = IBCTrDefaultSelect
    SQL.Strings = (
      'SELECT SYSSID, TITLE FROM SP_GET_ANALITICS_DTSC')
    Left = 464
    Top = 432
  end
  object IBCDataSourceAnalitica: TIBCDataSource
    DataSet = IBCQueryAnalitica
    Left = 464
    Top = 384
  end
  object IBCQueryStocks: TIBCQuery
    KeyFields = 'STOCKID'
    Connection = IBCConnection
    Transaction = IBCTrDefaultSelect
    SQL.Strings = (
      'SELECT * FROM GET_QUICK_ACCESS_STOCK')
    Options.BooleanDomainFields = True
    Left = 584
    Top = 432
  end
  object IBCDataSourceStocks: TIBCDataSource
    AutoEdit = False
    DataSet = IBCQueryStocks
    Left = 584
    Top = 384
  end
  object IBCQueryJurnal: TIBCQuery
    KeyFields = 'DOCID;DTDEP;CTDEP;GOODSCOMPLECT_ID;GOODSID'
    SQLInsert.Strings = (
      'INSERT INTO VW_TDB_JURNAL'
      
        '  (DOCID, DTDEP, DTDEP_NAME, CTDEP, CTDEP_NAME, GOODSCOMPLECT_ID' +
        ', GOODSCOMPLECT_NAME, '
      '   GOODSID, GOODS_NAME, GOODS_TYPE_ID, '
      
        '   UMID, UM_NAME, QTY, PRICE, SUMA, SUMAVAT, WARRANTY, STOCK_QTY' +
        ', COST, '
      '   FLG_ACTIVE, FLG_ACNT, FLG_READY, FLG_DELETE)'
      'VALUES'
      
        '  (:DOCID, :DTDEP, :DTDEP_NAME, :CTDEP, :CTDEP_NAME, :GOODSCOMPL' +
        'ECT_ID, :GOODSCOMPLECT_NAME, '
      '   :GOODSID, :GOODS_NAME, :GOODS_TYPE_ID, '
      
        '   :UMID, :UM_NAME, :QTY, :PRICE, :SUMA, :SUMAVAT, :WARRANTY, :S' +
        'TOCK_QTY, :COST, '
      '   :FLG_ACTIVE, :FLG_ACNT, :FLG_READY, :FLG_DELETE)')
    SQLDelete.Strings = (
      'DELETE FROM VW_TDB_JURNAL'
      'WHERE'
      
        '  DOCID = :Old_DOCID AND DTDEP = :Old_DTDEP AND CTDEP = :Old_CTD' +
        'EP AND GOODSCOMPLECT_ID = :Old_GOODSCOMPLECT_ID AND GOODSID = :O' +
        'ld_GOODSID')
    SQLUpdate.Strings = (
      'UPDATE VW_TDB_JURNAL'
      'SET'
      
        ' DOCID = :DOCID, DTDEP = :DTDEP, DTDEP_NAME = :DTDEP_NAME, CTDEP' +
        ' = :CTDEP, CTDEP_NAME = :CTDEP_NAME, '
      
        ' GOODSCOMPLECT_ID = :GOODSCOMPLECT_ID, GOODSCOMPLECT_NAME = :GOO' +
        'DSCOMPLECT_NAME, '
      ' GOODSID = :GOODSID, GOODS_NAME = :GOODS_NAME, '
      
        ' GOODS_TYPE_ID = :GOODS_TYPE_ID, UMID = :UMID, UM_NAME = :UM_NAM' +
        'E, QTY = :QTY, '
      
        ' PRICE = :PRICE, SUMA = :SUMA, SUMAVAT = :SUMAVAT, WARRANTY = :W' +
        'ARRANTY, STOCK_QTY = :STOCK_QTY, '
      ' COST = :COST, '
      ''
      ' FLG_ACTIVE = :FLG_ACTIVE, '
      ' FLG_ACNT = :FLG_ACNT, '
      ' FLG_READY = :FLG_READY, '
      ' FLG_DELETE = :FLG_DELETE'
      ''
      'WHERE'
      
        '  DOCID = :Old_DOCID AND DTDEP = :Old_DTDEP AND CTDEP = :Old_CTD' +
        'EP AND GOODSCOMPLECT_ID = :Old_GOODSCOMPLECT_ID AND GOODSID = :O' +
        'ld_GOODSID')
    SQLRefresh.Strings = (
      'SELECT'
      ' VW_TDB_JURNAL.*,'
      
        ' IIF(ACNT_PRICE<PRICE_ACNT_LOW_BOUND OR ACNT_PRICE>PRICE_ACNT_HI' +
        'GH_BOUND,1,0) FLG_ACNT_PRICE_OUT_OF_BOUNDS'
      'FROM'
      ' VW_TDB_JURNAL'
      'WHERE'
      ' DOCID = :DOCID AND '
      ' DTDEP = :DTDEP AND'
      ' CTDEP = :CTDEP AND'
      ' GOODSCOMPLECT_ID = :GOODSCOMPLECT_ID AND'
      ' GOODSID = :GOODSID')
    SQLLock.Strings = (
      'SELECT NULL FROM TDB_JURNAL'
      'WHERE'
      
        'DOCID = :Old_DOCID AND DTDEP = :Old_DTDEP AND CTDEP = :Old_CTDEP' +
        ' AND GOODSCOMPLECT_ID = :Old_GOODSCOMPLECT_ID AND GOODSID = :Old' +
        '_GOODSID'
      'FOR UPDATE WITH LOCK')
    Connection = IBCConnection
    Transaction = IBCTrDefaultSelect
    UpdateTransaction = IBCTrDefaultUpdate
    SQL.Strings = (
      'SELECT'
      ' VW_TDB_JURNAL.*,'
      
        ' IIF(ACNT_PRICE<PRICE_ACNT_LOW_BOUND OR ACNT_PRICE>PRICE_ACNT_HI' +
        'GH_BOUND,1,0) FLG_ACNT_PRICE_OUT_OF_BOUNDS'
      'FROM'
      ' VW_TDB_JURNAL'
      'WHERE'
      ' GOODSCOMPLECT_ID=-1')
    MasterFields = 'DOCID'
    DetailFields = 'DOCID'
    MasterSource = IBCDataSourceDocs
    AutoCommit = False
    LockMode = lmLockImmediate
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Options.RequiredFields = False
    Options.DetailDelay = 50
    LocalConstraints = False
    AfterPost = IBCQueryJurnalAfterPost
    AfterDelete = IBCQueryJurnalAfterDelete
    Left = 416
    Top = 88
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DOCID'
        Value = nil
      end>
  end
  object IBCDataSourceJurnal: TIBCDataSource
    DataSet = IBCQueryJurnal
    Left = 416
    Top = 40
  end
  object TrSchedulerUpdate: TIBCTransaction
    DefaultConnection = IBCConnection
    DefaultCloseAction = taCommit
    Left = 936
    Top = 288
  end
  object IBCQueryAnalytics: TIBCQuery
    Connection = IBCConnection
    Transaction = IBCTrDefaultSelect
    SQL.Strings = (
      'SELECT '
      ' ANALITICAID, '
      ' TITLE,'
      ' PARENT_TITLE'
      'FROM '
      ' SP_GET_ANALYTICS_BY_DOCTYPE_R(:doctype)'
      'ORDER BY PARENT_TITLE, orderno, TITLE')
    Left = 552
    Top = 208
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'doctype'
        Value = nil
      end>
  end
  object IBCDataSourceAnalytics: TIBCDataSource
    DataSet = IBCQueryAnalytics
    Left = 552
    Top = 160
  end
  object IBCQueryDocComments: TIBCQuery
    Connection = IBCConnection
    Transaction = IBCTrDefaultSelect
    SQL.Strings = (
      'SELECT DOCID, COMMENTS FROM TDB_DOCS_PROPS')
    MasterFields = 'DOCID'
    DetailFields = 'DOCID'
    MasterSource = IBCDataSourceDocs
    Options.StreamedBlobs = True
    Options.DetailDelay = 50
    Left = 304
    Top = 216
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DOCID'
        Value = nil
      end>
  end
  object IBCDataSourceDocComments: TIBCDataSource
    DataSet = IBCQueryDocComments
    Left = 304
    Top = 160
  end
  object Timer1: TTimer
    Interval = 300000
    OnTimer = Timer1Timer
    Left = 936
    Top = 344
  end
  object IBCDataSourceIncidente: TIBCDataSource
    DataSet = IBCQueryIncidente
    Left = 792
    Top = 40
  end
  object IBCQueryIncidente: TIBCQuery
    KeyFields = 'INCIDENTID'
    SQLUpdate.Strings = (
      'UPDATE VW_SC_INCIDENTE'
      'SET'
      
        '  INCIDENTID = :INCIDENTID, DATA = :DATA, GOODS_DOCID = :GOODS_D' +
        'OCID, DOC_CUSTOMER = :DOC_CUSTOMER, CT = :CT, GOODSID = :GOODSID' +
        ', GOODS_TITLE = :GOODS_TITLE, GOODS_SN = :GOODS_SN, GOODS_MODEL ' +
        '= :GOODS_MODEL, VENDOR_ID = :VENDOR_ID, VENDOR_TITLE = :VENDOR_T' +
        'ITLE, DATA_EST_FINISH = :DATA_EST_FINISH, DATA_FINISHED = :DATA_' +
        'FINISHED, DATA_CLOSED = :DATA_CLOSED, PRIORITY_LEVEL_ID = :PRIOR' +
        'ITY_LEVEL_ID, PRIORITY_LEVEL_TITLE = :PRIORITY_LEVEL_TITLE, PRIO' +
        'RITY_LEVEL_VALUE = :PRIORITY_LEVEL_VALUE, TYPE_ID = :TYPE_ID, TY' +
        'PE_TITLE = :TYPE_TITLE, STATUS_ID = :STATUS_ID, STATUS_TITLE = :' +
        'STATUS_TITLE, CREATED_BY = :CREATED_BY, CREATED_FULL_NAME = :CRE' +
        'ATED_FULL_NAME, EXEC_PERSONAL_GROUP_ID = :EXEC_PERSONAL_GROUP_ID' +
        ', EXEC_PERSONAL_GROUP_TITLE = :EXEC_PERSONAL_GROUP_TITLE, FLG_TO' +
        'P_PRIORITY = :FLG_TOP_PRIORITY, FLG_CLOSED = :FLG_CLOSED, RASHOD' +
        '_DOCID = :RASHOD_DOCID, INBAZA_DOC_NAME = :INBAZA_DOC_NAME, INBA' +
        'ZA_DOCNO = :INBAZA_DOCNO, INBAZA_DATE = :INBAZA_DATE, PROFORMA_I' +
        'NVOICE_DOCID = :PROFORMA_INVOICE_DOCID, SOLVED_BY = :SOLVED_BY, ' +
        'SOLVED_BY_NAME = :SOLVED_BY_NAME, PAYERID = :PAYERID, PAYER_NAME' +
        ' = :PAYER_NAME, PAYER_RASHOD_DOCID = :PAYER_RASHOD_DOCID, DT = :' +
        'DT, DT_NAME = :DT_NAME'
      'WHERE'
      '  INCIDENTID = :Old_INCIDENTID')
    SQLRefresh.Strings = (
      'SELECT *'
      'FROM '
      ' vw_sc_incidente'
      'WHERE'
      ' INCIDENTID = :INCIDENTID')
    SQLLock.Strings = (
      'SELECT '
      ' NULL '
      'FROM '
      ' SC_INCIDENTE'
      'WHERE'
      ' INCIDENTID = :Old_INCIDENTID'
      'FOR UPDATE WITH LOCK')
    Connection = IBCConnection
    Transaction = IBCTrDefaultSelect
    UpdateTransaction = IBCTrDefaultUpdate
    SQL.Strings = (
      'SELECT'
      ' *'
      'FROM '
      'vw_sc_incidente'
      
        'order by CREATED_DATE, DATA, EXEC_PERSONAL_GROUP_TITLE desc , PR' +
        'IORITY_LEVEL_VALUE desc')
    AutoCommit = False
    Left = 792
    Top = 88
  end
  object IBCDS_INCIDENTE_BLOB: TIBCDataSource
    DataSet = IBC_INCIDENTE_BLOB
    Left = 792
    Top = 160
  end
  object IBC_INCIDENTE_BLOB: TIBCQuery
    KeyFields = 'INCIDENTID'
    SQLUpdate.Strings = (
      'UPDATE VW_SC_INCIDENTE_BLOB'
      'SET'
      
        '  INCIDENTID = :INCIDENTID, DEFECTE_DSC = :DEFECTE_DSC, ASPECT_V' +
        'ISUAL_DSC = :ASPECT_VISUAL_DSC, COMMENTS = :COMMENTS'
      'WHERE'
      '  INCIDENTID = :Old_INCIDENTID')
    SQLRefresh.Strings = (
      'SELECT '
      ' INCIDENTID, '
      ' DEFECTE_DSC, '
      ' ASPECT_VISUAL_DSC, '
      ' COMMENTS '
      'FROM '
      ' VW_SC_INCIDENTE_BLOB'
      'WHERE'
      ' INCIDENTID = :INCIDENTID')
    SQLLock.Strings = (
      'SELECT NULL '
      'FROM SC_INCIDENTE_BLOB'
      'WHERE'
      ' INCIDENTID = :Old_INCIDENTID'
      'FOR UPDATE WITH LOCK')
    Connection = IBCConnection
    Transaction = IBCTrDefaultSelect
    UpdateTransaction = IBCTrDefaultUpdate
    SQL.Strings = (
      'SELECT'
      ' *'
      'FROM '
      'VW_SC_INCIDENTE_BLOB')
    MasterFields = 'INCIDENTID'
    DetailFields = 'INCIDENTID'
    MasterSource = IBCDataSourceIncidente
    AutoCommit = False
    Options.DetailDelay = 100
    Left = 792
    Top = 208
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'INCIDENTID'
        Value = nil
      end>
  end
  object IBCDataSourceSchedulerDelivery: TIBCDataSource
    DataSet = IBCQuerySchedulerDelivery
    Left = 792
    Top = 284
  end
  object IBCQuerySchedulerDelivery: TIBCQuery
    KeyFields = 'ID'
    KeyGenerator = 'SQ_TS_SCHEDULER_DELIVERY_ID'
    SQLInsert.Strings = (
      'INSERT INTO TS_SCHEDULER_DELIVERY'
      
        '  (ID, PARENTID, "TYPE", "START", FINISH, OPTIONS, CAPTION, RECU' +
        'RRENCEINDEX, RECURRENCEINFO, LOCATION, REMINDERDATE, REMINDERMIN' +
        'UTES, STATE, LABELCOLOR, ACTUALSTART, ACTUALFINISH, SYNCIDFIELD,' +
        ' "MESSAGE", RESOURCEID)'
      'VALUES'
      
        '  (:ID, :PARENTID, :TYPE, :START, :FINISH, :OPTIONS, :CAPTION, :' +
        'RECURRENCEINDEX, :RECURRENCEINFO, :LOCATION, :REMINDERDATE, :REM' +
        'INDERMINUTES, :STATE, :LABELCOLOR, :ACTUALSTART, :ACTUALFINISH, ' +
        ':SYNCIDFIELD, :MESSAGE, :RESOURCEID)')
    SQLDelete.Strings = (
      'DELETE FROM TS_SCHEDULER_DELIVERY'
      'WHERE'
      '  ID = :Old_ID')
    SQLUpdate.Strings = (
      'UPDATE TS_SCHEDULER_DELIVERY'
      'SET'
      
        '  ID = :ID, PARENTID = :PARENTID, "TYPE" = :TYPE, "START" = :STA' +
        'RT, FINISH = :FINISH, OPTIONS = :OPTIONS, CAPTION = :CAPTION, RE' +
        'CURRENCEINDEX = :RECURRENCEINDEX, RECURRENCEINFO = :RECURRENCEIN' +
        'FO, LOCATION = :LOCATION, REMINDERDATE = :REMINDERDATE, REMINDER' +
        'MINUTES = :REMINDERMINUTES, STATE = :STATE, LABELCOLOR = :LABELC' +
        'OLOR, ACTUALSTART = :ACTUALSTART, ACTUALFINISH = :ACTUALFINISH, ' +
        'SYNCIDFIELD = :SYNCIDFIELD, "MESSAGE" = :MESSAGE, RESOURCEID = :' +
        'RESOURCEID'
      'WHERE'
      '  ID = :Old_ID')
    SQLRefresh.Strings = (
      
        'SELECT ID, PARENTID, "TYPE", "START", FINISH, OPTIONS, CAPTION, ' +
        'RECURRENCEINDEX, RECURRENCEINFO, LOCATION, REMINDERDATE, REMINDE' +
        'RMINUTES, STATE, LABELCOLOR, ACTUALSTART, ACTUALFINISH, SYNCIDFI' +
        'ELD, "MESSAGE", RESOURCEID '
      'FROM TS_SCHEDULER_DELIVERY'
      'WHERE'
      '  ID = :ID')
    SQLLock.Strings = (
      'SELECT NULL FROM TS_SCHEDULER_DELIVERY'
      'WHERE'
      'ID = :Old_ID'
      'FOR UPDATE WITH LOCK')
    Connection = IBCConnection
    Transaction = TrSchedulerDeliveryUpdate
    UpdateTransaction = TrSchedulerDeliveryUpdate
    SQL.Strings = (
      'SELECT *'
      'FROM TS_SCHEDULER_DELIVERY')
    LockMode = lmLockImmediate
    RefreshOptions = [roBeforeEdit]
    Options.StrictUpdate = False
    AfterPost = IBCQuerySchedulerDeliveryAfterPost
    AfterDelete = IBCQuerySchedulerDeliveryAfterPost
    Left = 792
    Top = 340
  end
  object TrSchedulerDeliveryUpdate: TIBCTransaction
    DefaultConnection = IBCConnection
    DefaultCloseAction = taCommit
    Left = 936
    Top = 428
  end
  object IBCSQLMonitor1: TIBCSQLMonitor
    Options = [moSQLMonitor, moDBMonitor]
    TraceFlags = [tfQExecute, tfTransact]
    Left = 96
    Top = 136
  end
  object IBCQuerySYSSList: TIBCQuery
    Connection = IBCConnection
    Transaction = IBCTrDefaultSelect
    SQL.Strings = (
      'SELECT SYSSID, TITLE FROM SP_GET_SYSS_LIST(:PARENTID)')
    Left = 688
    Top = 432
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PARENTID'
        Value = nil
      end>
  end
  object IBCDataSourceSYSSList: TIBCDataSource
    DataSet = IBCQuerySYSSList
    Left = 688
    Top = 384
  end
  object IBCQueryOportunitati: TIBCQuery
    KeyFields = 'ID'
    KeyGenerator = 'gen_tdb_oportunitati_id'
    SQLInsert.Strings = (
      'INSERT INTO VW_TDB_OPORTUNITATI'
      
        '  (ID, DT, DT_NAME, DATA, SUBIECT, CLIENT_POTENTIAL, DATA_ESTIMA' +
        'TA, VENIT_ESTIMAT, PROBABILITATE, EVALUARE, CREATED_BY, CREATED_' +
        'BY_NAME, RESPONSABIL, RESPONSABIL_USER, COMENTARIU, status_id, t' +
        'elefon)'
      'VALUES'
      
        '  (:ID, :DT, :DT_NAME, :DATA, :SUBIECT, :CLIENT_POTENTIAL, :DATA' +
        '_ESTIMATA, :VENIT_ESTIMAT, :PROBABILITATE, :EVALUARE, :CREATED_B' +
        'Y, :CREATED_BY_NAME, :RESPONSABIL, :RESPONSABIL_USER, :COMENTARI' +
        'U, :status_id, :telefon)')
    SQLDelete.Strings = (
      'DELETE FROM VW_TDB_OPORTUNITATI'
      'WHERE'
      '  ID = :Old_ID')
    SQLUpdate.Strings = (
      'UPDATE VW_TDB_OPORTUNITATI'
      'SET'
      
        '  ID = :ID, DT = :DT, DT_NAME = :DT_NAME, DATA = :DATA, SUBIECT ' +
        '= :SUBIECT, CLIENT_POTENTIAL = :CLIENT_POTENTIAL, DATA_ESTIMATA ' +
        '= :DATA_ESTIMATA, VENIT_ESTIMAT = :VENIT_ESTIMAT, PROBABILITATE ' +
        '= :PROBABILITATE, EVALUARE = :EVALUARE, CREATED_BY = :CREATED_BY' +
        ', CREATED_BY_NAME = :CREATED_BY_NAME, RESPONSABIL = :RESPONSABIL' +
        ', RESPONSABIL_USER = :RESPONSABIL_USER, COMENTARIU = :COMENTARIU' +
        ','
      '  status_id = :status_id, telefon = :telefon'
      'WHERE'
      '  ID = :Old_ID')
    SQLRefresh.Strings = (
      'SELECT * FROM VW_TDB_OPORTUNITATI'
      'WHERE'
      '  ID = :ID')
    SQLLock.Strings = (
      'SELECT NULL FROM TDB_OPORTUNITATI'
      'WHERE'
      'ID = :Old_ID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM VW_TDB_OPORTUNITATI'
      ''
      ') q')
    Connection = IBCConnection
    Transaction = IBCTrDefaultSelect
    UpdateTransaction = IBCTrDefaultUpdate
    SQL.Strings = (
      'select * from vw_tdb_oportunitati'
      'order by id')
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Options.DefaultValues = True
    Left = 553
    Top = 87
  end
  object IBCDataSourceOportunitati: TIBCDataSource
    DataSet = IBCQueryOportunitati
    Left = 552
    Top = 40
  end
  object NotificationCenter: TNotificationCenter
    Left = 550
    Top = 269
  end
  object IBCQueryDocTypeStates: TIBCQuery
    KeyFields = 'STATEID'
    Connection = IBCConnection
    SQL.Strings = (
      'select * from ts_doctypes_states'
      'where doctypeid = :doctypeid'
      'order by ts_doctypes_states.int_value desc, title')
    Left = 128
    Top = 312
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'doctypeid'
        Value = nil
      end>
  end
  object IBCDataSourceDocTypeStates: TIBCDataSource
    DataSet = IBCQueryDocTypeStates
    Left = 128
    Top = 264
  end
  object IBCQueryDocs: TIBCQuery
    KeyFields = 'DOCID'
    KeyGenerator = 'SQ_TDB_DOCS_DOCID'
    GeneratorMode = gmInsert
    SQLInsert.Strings = (
      'INSERT INTO VW_TDB_DOCS'
      
        '  (DOCID, DATA, DT, DT_NAME, CT, CT_NAME, DTDEP, DTDEP_NAME, CTD' +
        'EP, CTDEP_NAME, DTSC, DTSC_NAME, CTSC, CTSC_NAME, SC2, SC2_NAME,' +
        ' SUMA, VAT, CURRENCYID, CURRENCY_NAME, DISCOUNT, RATE, RATEUSD, ' +
        'FLG_SHIP, FLG_ACNT, FLG_DEL, FLG_PROTECTED, FLG_SEND, FLG_RECEIV' +
        'E, FLG_PAID, FLG_INVOICE, FLG_GOODS_ARRIVAL, FLG_READY, FLG_CLOS' +
        'ED, FLG_EXPORTED, FLG_CHILD, FLG_NEW_CEC, FLG_SALARY, FLG_UPDATE' +
        '_DATE, FLG_FURNITURE, FLG_CASHBACK, FLG_WEBSHOP_ORDER, CREATED_D' +
        'ATE, CREATED_BY, CREATED_BY_NAME, DELETED_DATE, DELETED_BY, DELE' +
        'TED_BY_NAME, PARENTDOCID, ACC$MASK, DOCTYPEID, DOCTYPE_NAME, CON' +
        'TRACTID, CONTRACT_CODE, CONTRACT_SIGN_DATE, CONTRACT_CURRENCYID,' +
        ' CONTRACT_TYPE_TITLE, CONTRACT_PRICECOLUMN, FLG_WITH_DELIVERY, P' +
        'HONELIST, STATEID, STATE_NAME, FLG_HAS_REZERVA, FLG_HAS_PROFORMA' +
        ', RESPONSIBLE_USERID)'
      'VALUES'
      
        '  (:DOCID, :DATA, :DT, :DT_NAME, :CT, :CT_NAME, :DTDEP, :DTDEP_N' +
        'AME, :CTDEP, :CTDEP_NAME, :DTSC, :DTSC_NAME, :CTSC, :CTSC_NAME, ' +
        ':SC2, :SC2_NAME, :SUMA, :VAT, :CURRENCYID, :CURRENCY_NAME, :DISC' +
        'OUNT, :RATE, :RATEUSD, :FLG_SHIP, :FLG_ACNT, :FLG_DEL, :FLG_PROT' +
        'ECTED, :FLG_SEND, :FLG_RECEIVE, :FLG_PAID, :FLG_INVOICE, :FLG_GO' +
        'ODS_ARRIVAL, :FLG_READY, :FLG_CLOSED, :FLG_EXPORTED, :FLG_CHILD,' +
        ' :FLG_NEW_CEC, :FLG_SALARY, :FLG_UPDATE_DATE, :FLG_FURNITURE, :F' +
        'LG_CASHBACK, :FLG_WEBSHOP_ORDER, :CREATED_DATE, :CREATED_BY, :CR' +
        'EATED_BY_NAME, :DELETED_DATE, :DELETED_BY, :DELETED_BY_NAME, :PA' +
        'RENTDOCID, :ACC$MASK, :DOCTYPEID, :DOCTYPE_NAME, :CONTRACTID, :C' +
        'ONTRACT_CODE, :CONTRACT_SIGN_DATE, :CONTRACT_CURRENCYID, :CONTRA' +
        'CT_TYPE_TITLE, :CONTRACT_PRICECOLUMN, :FLG_WITH_DELIVERY, :PHONE' +
        'LIST, :STATEID, :STATE_NAME, :FLG_HAS_REZERVA, :FLG_HAS_PROFORMA' +
        ', :RESPONSIBLE_USERID)')
    SQLDelete.Strings = (
      'DELETE FROM VW_TDB_DOCS'
      'WHERE'
      '  DOCID = :Old_DOCID')
    SQLUpdate.Strings = (
      'UPDATE VW_TDB_DOCS'
      'SET'
      
        '  DOCID = :DOCID, DATA = :DATA, DT = :DT, DT_NAME = :DT_NAME, CT' +
        ' = :CT, CT_NAME = :CT_NAME, DTDEP = :DTDEP, DTDEP_NAME = :DTDEP_' +
        'NAME, CTDEP = :CTDEP, CTDEP_NAME = :CTDEP_NAME, DTSC = :DTSC, DT' +
        'SC_NAME = :DTSC_NAME, CTSC = :CTSC, CTSC_NAME = :CTSC_NAME, SC2 ' +
        '= :SC2, SC2_NAME = :SC2_NAME, SUMA = :SUMA, VAT = :VAT, CURRENCY' +
        'ID = :CURRENCYID, CURRENCY_NAME = :CURRENCY_NAME, DISCOUNT = :DI' +
        'SCOUNT, RATE = :RATE, RATEUSD = :RATEUSD, FLG_SHIP = :FLG_SHIP, ' +
        'FLG_ACNT = :FLG_ACNT, FLG_DEL = :FLG_DEL, FLG_PROTECTED = :FLG_P' +
        'ROTECTED, FLG_SEND = :FLG_SEND, FLG_RECEIVE = :FLG_RECEIVE, FLG_' +
        'PAID = :FLG_PAID, FLG_INVOICE = :FLG_INVOICE, FLG_GOODS_ARRIVAL ' +
        '= :FLG_GOODS_ARRIVAL, FLG_READY = :FLG_READY, FLG_CLOSED = :FLG_' +
        'CLOSED, FLG_EXPORTED = :FLG_EXPORTED, FLG_CHILD = :FLG_CHILD, FL' +
        'G_NEW_CEC = :FLG_NEW_CEC, FLG_SALARY = :FLG_SALARY, FLG_UPDATE_D' +
        'ATE = :FLG_UPDATE_DATE, FLG_FURNITURE = :FLG_FURNITURE, FLG_CASH' +
        'BACK = :FLG_CASHBACK, FLG_WEBSHOP_ORDER = :FLG_WEBSHOP_ORDER, CR' +
        'EATED_DATE = :CREATED_DATE, CREATED_BY = :CREATED_BY, CREATED_BY' +
        '_NAME = :CREATED_BY_NAME, DELETED_DATE = :DELETED_DATE, DELETED_' +
        'BY = :DELETED_BY, DELETED_BY_NAME = :DELETED_BY_NAME, PARENTDOCI' +
        'D = :PARENTDOCID, ACC$MASK = :ACC$MASK, DOCTYPEID = :DOCTYPEID, ' +
        'DOCTYPE_NAME = :DOCTYPE_NAME, CONTRACTID = :CONTRACTID, CONTRACT' +
        '_CODE = :CONTRACT_CODE, CONTRACT_SIGN_DATE = :CONTRACT_SIGN_DATE' +
        ', CONTRACT_CURRENCYID = :CONTRACT_CURRENCYID, CONTRACT_TYPE_TITL' +
        'E = :CONTRACT_TYPE_TITLE, CONTRACT_PRICECOLUMN = :CONTRACT_PRICE' +
        'COLUMN, FLG_WITH_DELIVERY = :FLG_WITH_DELIVERY, PHONELIST = :PHO' +
        'NELIST, STATEID = :STATEID, STATE_NAME = :STATE_NAME, FLG_HAS_RE' +
        'ZERVA = :FLG_HAS_REZERVA, FLG_HAS_PROFORMA = :FLG_HAS_PROFORMA, ' +
        'RESPONSIBLE_USERID = :RESPONSIBLE_USERID'
      'WHERE'
      '  DOCID = :Old_DOCID')
    SQLRefresh.Strings = (
      
        'SELECT DOCID, DATA, DT, DT_NAME, CT, CT_NAME, DTDEP, DTDEP_NAME,' +
        ' CTDEP, CTDEP_NAME, DTSC, DTSC_NAME, CTSC, CTSC_NAME, SC2, SC2_N' +
        'AME, SUMA, VAT, CURRENCYID, CURRENCY_NAME, DISCOUNT, RATE, RATEU' +
        'SD, FLG_SHIP, FLG_ACNT, FLG_DEL, FLG_PROTECTED, FLG_SEND, FLG_RE' +
        'CEIVE, FLG_PAID, FLG_INVOICE, FLG_GOODS_ARRIVAL, FLG_READY, FLG_' +
        'CLOSED, FLG_EXPORTED, FLG_CHILD, FLG_NEW_CEC, FLG_SALARY, FLG_UP' +
        'DATE_DATE, FLG_FURNITURE, FLG_CASHBACK, FLG_WEBSHOP_ORDER, CREAT' +
        'ED_DATE, CREATED_BY, CREATED_BY_NAME, DELETED_DATE, DELETED_BY, ' +
        'DELETED_BY_NAME, PARENTDOCID, ACC$MASK, DOCTYPEID, DOCTYPE_NAME,' +
        ' CONTRACTID, CONTRACT_CODE, CONTRACT_SIGN_DATE, CONTRACT_CURRENC' +
        'YID, CONTRACT_TYPE_TITLE, CONTRACT_PRICECOLUMN, FLG_WITH_DELIVER' +
        'Y, PHONELIST, STATEID, STATE_NAME, FLG_HAS_REZERVA, FLG_HAS_PROF' +
        'ORMA, RESPONSIBLE_USERID FROM VW_TDB_DOCS'
      'WHERE'
      '  DOCID = :DOCID')
    SQLLock.Strings = (
      'SELECT NULL FROM TDB_DOCS'
      'WHERE'
      'DOCID = :Old_DOCID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM VW_TDB_DOCS'
      ''
      ') q')
    Connection = IBCConnection
    Transaction = IBCTrDefaultSelect
    UpdateTransaction = IBCTrDefaultUpdate
    SQL.Strings = (
      'SELECT'
      ' VW_TDB_DOCS.*,'
      ' IIF((CT=:DT),1,0) INCOMING_DOC,'
      
        ' IIF(EXISTS(SELECT GOODSID FROM TDB_JURNAL WHERE TDB_JURNAL.DOCI' +
        'D=VW_TDB_DOCS.DOCID),1,0) HAS_JURNAL_GOODS,'
      
        ' (SELECT CUSTOMER_TYPE_ID FROM TS_CUSTOMER WHERE TS_CUSTOMER.CUS' +
        'TOMERID=VW_TDB_DOCS.CT) CUSTOMER_TYPE_ID,'
      
        ' iif (exists(select docid from tdb_docs_attachments da where (da' +
        '.docid=VW_TDB_DOCS.docid)),1,0) HasDoc_Attached,'
      ' iif (doctypeid = 106,'
      
        '    iif (exists(select * from tdb_docs d where d.doctypeid = 109' +
        ' and d.parentdocid = vw_tdb_docs.docid), 1, 0), 0) flg_factura_f' +
        'iscala,'
      
        ' COALESCE((SELECT pricecolumn FROM ts_cust_info WHERE customerid' +
        ' = VW_TDB_DOCS.CT),1) CUSTOMER_PRICE_COLUMN,'
      ' B.BANKNAME,'
      ' CA.BANKACCOUNT,'
      ' CA.ACCOUNTNAME,'
      ' CA.ACCOUNTNUMBER,'
      ' dd.delivery_date'
      ''
      'FROM'
      ' VW_TDB_DOCS'
      
        'LEFT JOIN TS_CUST_ACCOUNTS CA ON CA.CUSTOMERID = VW_TDB_DOCS.DT ' +
        'AND CA.ACCOUNTNUMBER = (SELECT DR.DT_CD FROM TDB_DOCS_RECHIZITE ' +
        'DR WHERE DR.DOCID = VW_TDB_DOCS.DOCID)'
      'LEFT JOIN TS_BANKS B ON B.BANKACCOUNT = CA.BANKACCOUNT'
      'LEFT JOIN tdb_docs_delivery dd on dd.docid=vw_tdb_docs.docid'
      'where flg_del=0')
    AutoCommit = False
    LockMode = lmLockImmediate
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Options.DetailDelay = 750
    BeforeUpdateExecute = IBCQueryDocsBeforeUpdateExecute
    IndexFieldNames = 'DATA'
    AfterPost = IBCQueryDocsAfterPost
    Left = 302
    Top = 89
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DT'
        Value = nil
      end>
  end
  object IdHTTP1: TIdHTTP
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 552
    Top = 327
  end
  object cxSchedulerDBStorageDelivery: TcxSchedulerDBStorage
    UseActualTimeRange = True
    Reminders.DefaultMinutesBeforeStart = 30
    Resources.Items = <>
    Resources.DataSource = IBCDataSourceSchedulerDelivery
    Resources.ResourceID = 'RESOURCEID'
    SmartRefresh = True
    CustomFields = <>
    DataSource = IBCDataSourceSchedulerDelivery
    FieldNames.ActualFinish = 'ACTUALFINISH'
    FieldNames.ActualStart = 'ACTUALSTART'
    FieldNames.Caption = 'CAPTION'
    FieldNames.EventType = 'TYPE'
    FieldNames.Finish = 'FINISH'
    FieldNames.ID = 'ID'
    FieldNames.LabelColor = 'LABELCOLOR'
    FieldNames.Location = 'LOCATION'
    FieldNames.Message = 'MESSAGE'
    FieldNames.Options = 'OPTIONS'
    FieldNames.ParentID = 'PARENTID'
    FieldNames.ReminderDate = 'REMINDERDATE'
    FieldNames.ReminderMinutesBeforeStart = 'REMINDERMINUTES'
    FieldNames.ResourceID = 'RESOURCEID'
    FieldNames.Start = 'START'
    FieldNames.State = 'STATE'
    Left = 1073
    Top = 103
  end
  object cxSchedulerDBStorage: TcxSchedulerDBStorage
    UseActualTimeRange = True
    Reminders.ShowResourcesInReminderWindow = False
    Resources.Items = <>
    Resources.DataSource = IBCDataSourceSchedulerResources
    Resources.ResourceID = 'RESOURCESID'
    Resources.ResourceName = 'RESOURCENAME'
    SmartRefresh = True
    CustomFields = <>
    DataSource = IBCDataSourceSchedulerEvents
    FieldNames.ActualFinish = 'ACTUALFINISH'
    FieldNames.ActualStart = 'ACTUALSTART'
    FieldNames.Caption = 'CAPTION'
    FieldNames.EventType = 'TYPE'
    FieldNames.Finish = 'FINISH'
    FieldNames.ID = 'ID'
    FieldNames.LabelColor = 'LABELCOLOR'
    FieldNames.Location = 'LOCATION'
    FieldNames.Message = 'MESSAGE'
    FieldNames.Options = 'OPTIONS'
    FieldNames.ParentID = 'PARENTID'
    FieldNames.ReminderDate = 'REMINDERDATE'
    FieldNames.ReminderMinutesBeforeStart = 'REMINDERMINUTES'
    FieldNames.ResourceID = 'RESOURCEID'
    FieldNames.Start = 'START'
    FieldNames.State = 'STATE'
    Left = 1073
    Top = 54
  end
  object IBCQueryAchizitii: TIBCQuery
    Connection = IBCConnection
    SQL.Strings = (
      
        'select * from vw_tdb_jurnal_achizitii where docid = :docid and d' +
        'tdep=:dtdep and goodsid = goodsid')
    Active = True
    Left = 304
    Top = 320
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'docid'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'dtdep'
        Value = nil
      end>
  end
  object IBCDataSourceAchizitii: TIBCDataSource
    DataSet = IBCQueryAchizitii
    Left = 304
    Top = 272
  end
end
