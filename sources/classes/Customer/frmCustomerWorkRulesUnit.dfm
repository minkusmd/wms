object frmCustomerWorkRules: TfrmCustomerWorkRules
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Conditiile de lucru'
  ClientHeight = 495
  ClientWidth = 633
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object Label1: TLabel
    Left = 8
    Top = 13
    Width = 106
    Height = 15
    Caption = #1050#1072#1082' '#1079#1072#1074#1086#1076#1080#1090#1100' '#1087#1088#1072#1081#1089
  end
  object Label2: TLabel
    Left = 8
    Top = 248
    Width = 90
    Height = 15
    Caption = #1059#1089#1083#1086#1074#1080#1103' '#1086#1087#1083#1072#1090#1099
  end
  object cxDBMemo1: TcxDBMemo
    Left = 8
    Top = 31
    DataBinding.DataField = 'WORK_RULES'
    DataBinding.DataSource = IBCDataSourceCustomerWorkRules
    ParentFont = False
    Style.Font.Charset = RUSSIAN_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -12
    Style.Font.Name = 'Consolas'
    Style.Font.Style = []
    Style.IsFontAssigned = True
    TabOrder = 0
    Height = 185
    Width = 616
  end
  object cxButton1: TcxButton
    Left = 208
    Top = 465
    Width = 90
    Height = 30
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object cxButton2: TcxButton
    Left = 304
    Top = 465
    Width = 90
    Height = 30
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 2
  end
  object cxDBMemo2: TcxDBMemo
    Left = 8
    Top = 266
    DataBinding.DataField = 'PAY_RULES'
    DataBinding.DataSource = IBCDataSourceCustomerWorkRules
    ParentFont = False
    Style.Font.Charset = RUSSIAN_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -12
    Style.Font.Name = 'Consolas'
    Style.Font.Style = []
    Style.IsFontAssigned = True
    TabOrder = 3
    Height = 185
    Width = 616
  end
  object IBCQueryCustomerWorkRules: TIBCQuery
    KeyFields = 'customerid'
    SQLInsert.Strings = (
      'INSERT INTO TS_CUST_COMMENTS'
      '  (CUSTOMERID, WORK_RULES, PAY_RULES)'
      'VALUES'
      '  (:CUSTOMERID, :WORK_RULES, :PAY_RULES)')
    SQLDelete.Strings = (
      'DELETE FROM TS_CUST_COMMENTS'
      'WHERE'
      '  CUSTOMERID = :Old_CUSTOMERID AND WORK_RULES = :Old_WORK_RULES')
    SQLUpdate.Strings = (
      'UPDATE TS_CUST_COMMENTS'
      'SET'
      
        '  CUSTOMERID = :CUSTOMERID, WORK_RULES = :WORK_RULES, PAY_RULES ' +
        '= :PAY_RULES'
      'WHERE'
      '  CUSTOMERID = :Old_CUSTOMERID AND WORK_RULES = :Old_WORK_RULES')
    SQLRefresh.Strings = (
      'SELECT CUSTOMERID, WORK_RULES, PAY_RULES FROM TS_CUST_COMMENTS'
      'WHERE'
      '  CUSTOMERID = :CUSTOMERID ')
    SQLLock.Strings = (
      'SELECT NULL FROM TS_CUST_COMMENTS'
      'WHERE'
      'CUSTOMERID = :Old_CUSTOMERID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM TS_CUST_COMMENTS'
      ''
      ') q')
    Transaction = IBCTrUpdate
    SQL.Strings = (
      
        'select customerid, work_rules, pay_rules from ts_cust_comments w' +
        'here Customerid = :customerid')
    Left = 192
    Top = 264
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'customerid'
        Value = nil
      end>
  end
  object IBCDataSourceCustomerWorkRules: TIBCDataSource
    DataSet = IBCQueryCustomerWorkRules
    Left = 192
    Top = 184
  end
  object IBCTrUpdate: TIBCTransaction
    Left = 304
    Top = 224
  end
end
