object frmCustomerNotifyDebtsDlg: TfrmCustomerNotifyDebtsDlg
  Left = 0
  Top = 0
  ActiveControl = deCHECK_DATE
  BorderStyle = bsDialog
  Caption = #1053#1072#1087#1086#1084#1080#1085#1072#1085#1080#1077' '#1086' '#1076#1086#1083#1075#1072#1093
  ClientHeight = 325
  ClientWidth = 491
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    491
    325)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 491
    Height = 64
    Title = #1053#1072#1087#1086#1084#1080#1085#1072#1085#1080#1077' '#1086' '#1076#1086#1083#1075#1072#1093
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
    ImageIndex = 2
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 475
    Height = 198
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    object Label1: TLabel
      Left = 24
      Top = 24
      Width = 62
      Height = 15
      Caption = #1050#1086#1085#1090#1088#1072#1075#1077#1085#1090
    end
    object Label2: TLabel
      Left = 24
      Top = 53
      Width = 78
      Height = 15
      Caption = #1058#1077#1082#1091#1097#1080#1081' '#1076#1086#1083#1075
    end
    object Label3: TLabel
      Left = 24
      Top = 95
      Width = 231
      Height = 15
      Caption = #1044#1072#1090#1072', '#1082#1086#1075#1076#1072' '#1087#1088#1086#1074#1077#1088#1080#1090#1100' '#1077#1089#1083#1080' '#1076#1086#1083#1075' '#1087#1086#1075#1072#1096#1077#1085
    end
    object Label4: TLabel
      Left = 24
      Top = 131
      Width = 229
      Height = 15
      Caption = #1055#1091#1089#1090#1100' '#1101#1090#1086#1090' '#1076#1086#1083#1075' '#1087#1088#1086#1074#1077#1088#1080#1090' '#1080' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
    end
    object edCUSTOMER: TcxTextEdit
      Left = 112
      Top = 21
      TabStop = False
      Properties.ReadOnly = True
      TabOrder = 0
      Width = 333
    end
    object edDEBTS: TcxTextEdit
      Left = 112
      Top = 50
      TabStop = False
      Properties.ReadOnly = True
      TabOrder = 1
      Width = 333
    end
    object deCHECK_DATE: TcxDBDateEdit
      Left = 261
      Top = 92
      DataBinding.DataField = 'CHECK_DATE'
      DataBinding.DataSource = IBCDataSourceNotify
      TabOrder = 2
      Width = 184
    end
    object lcbSECONDARY_USERID: TcxDBLookupComboBox
      Left = 259
      Top = 128
      DataBinding.DataField = 'SECONDARY_USERID'
      DataBinding.DataSource = IBCDataSourceNotify
      Properties.ClearKey = 16430
      Properties.DropDownListStyle = lsFixedList
      Properties.KeyFieldNames = 'USERID'
      Properties.ListColumns = <
        item
          FieldName = 'USER_FULLNAME'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = IBCDataSourceUsers
      TabOrder = 3
      Width = 186
    end
  end
  object btnOk: TButton
    Left = 273
    Top = 281
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 377
    Top = 281
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
  object IBCQueryNotify: TIBCQuery
    SQLInsert.Strings = (
      'INSERT INTO TNOT_CUSTOMER_DEBTS'
      '  (CUSTOMERID, CREATED_DATE, CHECK_DATE, SECONDARY_USERID)'
      'VALUES'
      '  (:CUSTOMERID, :CREATED_DATE, :CHECK_DATE, :SECONDARY_USERID)')
    SQLDelete.Strings = (
      'DELETE FROM TNOT_CUSTOMER_DEBTS'
      'WHERE'
      '  CUSTOMERID = :Old_CUSTOMERID')
    SQLUpdate.Strings = (
      'UPDATE TNOT_CUSTOMER_DEBTS'
      'SET'
      '  CUSTOMERID = :CUSTOMERID, '
      '  CREATED_DATE = :CREATED_DATE, '
      '  CHECK_DATE = :CHECK_DATE, '
      '  SECONDARY_USERID = :SECONDARY_USERID'
      'WHERE'
      '  CUSTOMERID = :Old_CUSTOMERID')
    SQLLock.Strings = (
      'SELECT NULL FROM TNOT_CUSTOMER_DEBTS'
      'WHERE'
      'CUSTOMERID = :Old_CUSTOMERID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = IBCTrUpdate
    SQL.Strings = (
      'SELECT'
      ' CUSTOMERID,'
      ' CREATED_DATE,'
      ' CHECK_DATE,'
      ' USERID,'
      ' SECONDARY_USERID'
      'FROM '
      ' TNOT_CUSTOMER_DEBTS'
      'WHERE '
      ' CUSTOMERID=:ID')
    Options.RequiredFields = False
    LocalConstraints = False
    Left = 44
    Top = 276
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
        Value = nil
      end>
  end
  object IBCDataSourceNotify: TIBCDataSource
    DataSet = IBCQueryNotify
    Left = 44
    Top = 232
  end
  object IBCDataSourceUsers: TIBCDataSource
    DataSet = IBCQueryUsers
    Left = 152
    Top = 232
  end
  object IBCQueryUsers: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT'
      ' USERID,'
      ' USER_FULLNAME'
      'FROM GET_USERS_BY_USER2')
    Left = 152
    Top = 276
  end
  object IBCTrUpdate: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 276
    Top = 12
  end
end
