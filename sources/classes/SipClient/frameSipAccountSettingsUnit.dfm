object frameSipAccountSettings: TframeSipAccountSettings
  Left = 0
  Top = 0
  Width = 336
  Height = 254
  TabOrder = 0
  OnEnter = FrameEnter
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 50
    Height = 13
    Caption = 'SIP server'
  end
  object Label2: TLabel
    Left = 16
    Top = 48
    Width = 22
    Height = 13
    Caption = 'User'
  end
  object Label3: TLabel
    Left = 16
    Top = 80
    Width = 46
    Height = 13
    Caption = 'Password'
  end
  object Label4: TLabel
    Left = 16
    Top = 112
    Width = 28
    Height = 13
    Caption = 'Proxy'
  end
  object btnSave: TButton
    Left = 158
    Top = 216
    Width = 75
    Height = 25
    Caption = 'Salveaza'
    Default = True
    ModalResult = 1
    TabOrder = 0
    OnClick = btnSaveClick
    OnExit = btnSaveExit
  end
  object StunBox: TCheckBox
    Left = 8
    Top = 144
    Width = 73
    Height = 17
    Caption = 'use STUN'
    TabOrder = 5
  end
  object btnCancel: TButton
    Left = 246
    Top = 216
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 6
  end
  object ServerEdit: TcxDBTextEdit
    Left = 88
    Top = 16
    DataBinding.DataField = 'SIP_SRV_ADRESS'
    DataBinding.DataSource = IBCDataSourceUsers
    TabOrder = 1
    Width = 233
  end
  object UserEdit: TcxDBTextEdit
    Left = 88
    Top = 48
    DataBinding.DataField = 'SIP_USERID'
    DataBinding.DataSource = IBCDataSourceUsers
    TabOrder = 2
    Width = 233
  end
  object PasswordEdit: TcxDBTextEdit
    Left = 88
    Top = 80
    DataBinding.DataField = 'SIP_USER_PSWD'
    DataBinding.DataSource = IBCDataSourceUsers
    TabOrder = 3
    Width = 233
  end
  object STUNEdit: TcxDBTextEdit
    Left = 88
    Top = 144
    DataBinding.DataField = 'SIP_STUN'
    DataBinding.DataSource = IBCDataSourceUsers
    Enabled = False
    TabOrder = 4
    Width = 233
  end
  object ProxyEdit: TcxDBTextEdit
    Left = 88
    Top = 112
    DataBinding.DataField = 'SIP_PROXY'
    DataBinding.DataSource = IBCDataSourceUsers
    TabOrder = 7
    Width = 233
  end
  object IBCQueryUsers: TIBCQuery
    KeyFields = 'USERID'
    SQLInsert.Strings = (
      'INSERT INTO TS_USERS'
      
        '  (USERID, LOGIN_NAME, ACC$FIRM, FIRST_NAME, LAST_NAME, DESCRIPT' +
        'ION, TELEFON, EMAIL, ADDRESS, BIRTHDAY, PASSWORD_HASH, CITY_ID, ' +
        'LAST_PASSWORD_CHANGE, CUSTOMERID, FLAGS, FULL_NAME, DEFAULT_DT, ' +
        'FUNCTIA_DETINUTA, REGISTER_DATE, USERTYPE_ID, SIP_SRV_ADRESS, SI' +
        'P_USERID, SIP_USER_PSWD, SIP_STUN, SIP_PROXY)'
      'VALUES'
      
        '  (:USERID, :LOGIN_NAME, :ACC$FIRM, :FIRST_NAME, :LAST_NAME, :DE' +
        'SCRIPTION, :TELEFON, :EMAIL, :ADDRESS, :BIRTHDAY, :PASSWORD_HASH' +
        ', :CITY_ID, :LAST_PASSWORD_CHANGE, :CUSTOMERID, :FLAGS, :FULL_NA' +
        'ME, :DEFAULT_DT, :FUNCTIA_DETINUTA, :REGISTER_DATE, :USERTYPE_ID' +
        ', :SIP_SRV_ADRESS, :SIP_USERID, :SIP_USER_PSWD, :SIP_STUN, :SIP_' +
        'PROXY)')
    SQLDelete.Strings = (
      'DELETE FROM TS_USERS'
      'WHERE'
      '  USERID = :Old_USERID')
    SQLUpdate.Strings = (
      'UPDATE TS_USERS'
      'SET'
      
        '  USERID = :USERID, LOGIN_NAME = :LOGIN_NAME, ACC$FIRM = :ACC$FI' +
        'RM, FIRST_NAME = :FIRST_NAME, LAST_NAME = :LAST_NAME, DESCRIPTIO' +
        'N = :DESCRIPTION, TELEFON = :TELEFON, EMAIL = :EMAIL, ADDRESS = ' +
        ':ADDRESS, BIRTHDAY = :BIRTHDAY, PASSWORD_HASH = :PASSWORD_HASH, ' +
        'CITY_ID = :CITY_ID, LAST_PASSWORD_CHANGE = :LAST_PASSWORD_CHANGE' +
        ', CUSTOMERID = :CUSTOMERID, FLAGS = :FLAGS, FULL_NAME = :FULL_NA' +
        'ME, DEFAULT_DT = :DEFAULT_DT, FUNCTIA_DETINUTA = :FUNCTIA_DETINU' +
        'TA, REGISTER_DATE = :REGISTER_DATE, USERTYPE_ID = :USERTYPE_ID, ' +
        'SIP_SRV_ADRESS = :SIP_SRV_ADRESS, SIP_USERID = :SIP_USERID, SIP_' +
        'USER_PSWD = :SIP_USER_PSWD, SIP_STUN = :SIP_STUN, SIP_PROXY = :S' +
        'IP_PROXY'
      'WHERE'
      '  USERID = :Old_USERID')
    SQLRefresh.Strings = (
      
        'SELECT USERID, LOGIN_NAME, ACC$FIRM, FIRST_NAME, LAST_NAME, DESC' +
        'RIPTION, TELEFON, EMAIL, ADDRESS, BIRTHDAY, PASSWORD_HASH, CITY_' +
        'ID, LAST_PASSWORD_CHANGE, CUSTOMERID, FLAGS, FULL_NAME, DEFAULT_' +
        'DT, FUNCTIA_DETINUTA, REGISTER_DATE, USERTYPE_ID, SIP_SRV_ADRESS' +
        ', SIP_USERID, SIP_USER_PSWD, SIP_STUN, SIP_PROXY FROM TS_USERS'
      'WHERE'
      '  USERID = :USERID')
    SQLLock.Strings = (
      'SELECT NULL FROM TS_USERS'
      'WHERE'
      'USERID = :Old_USERID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM TS_USERS'
      ''
      ') q')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'select * from ts_users where userid=:userid')
    Left = 176
    Top = 88
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'userid'
        Value = nil
      end>
  end
  object IBCDataSourceUsers: TIBCDataSource
    DataSet = IBCQueryUsers
    Left = 88
    Top = 88
  end
end
