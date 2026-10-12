object frmDispatchCouriersDlg: TfrmDispatchCouriersDlg
  Left = 0
  Top = 0
  Caption = 'Curieri'
  ClientHeight = 560
  ClientWidth = 1100
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 1100
    Height = 64
    Title = 'Curieri'
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
    ImageIndex = 16
  end
  object pnSettings: TPanel
    Left = 0
    Top = 64
    Width = 1100
    Height = 40
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object lbBaseStock: TLabel
      Left = 8
      Top = 12
      Width = 200
      Height = 15
      AutoSize = False
      Caption = 'Depozitul de baza:'
    end
    object lbWebUser: TLabel
      Left = 520
      Top = 12
      Width = 230
      Height = 15
      Caption = 'Utilizatorul WMS pentru documentele aplicatiei:'
    end
    object lcbBaseStock: TcxLookupComboBox
      Left = 212
      Top = 8
      Properties.DropDownListStyle = lsFixedList
      Properties.IncrementalFilteringOptions = [ifoHighlightSearchText, ifoUseContainsOperator]
      Properties.KeyFieldNames = 'STOCKID'
      Properties.ListColumns = <
        item
          FieldName = 'TITLE'
        end>
      Properties.ListSource = IBCDataSourceStocks
      TabOrder = 0
      Width = 280
    end
    object lcbWebUser: TcxLookupComboBox
      Left = 778
      Top = 8
      Properties.DropDownListStyle = lsFixedList
      Properties.IncrementalFilteringOptions = [ifoHighlightSearchText, ifoUseContainsOperator]
      Properties.KeyFieldNames = 'USERID'
      Properties.ListColumns = <
        item
          FieldName = 'FULL_NAME'
        end>
      Properties.ListSource = IBCDataSourceUsers
      TabOrder = 1
      Width = 310
    end
  end
  object cxGridCouriers: TcxGrid
    Left = 8
    Top = 108
    Width = 1084
    Height = 396
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 1
    object cxGridCouriersTable: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = IBCDataSourceCouriers
      DataController.KeyFieldNames = 'CUSTOMERID'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.Inserting = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      object colCUSTOMERID: TcxGridDBColumn
        DataBinding.FieldName = 'CUSTOMERID'
        Visible = False
      end
      object colNAME: TcxGridDBColumn
        Caption = 'Curier'
        DataBinding.FieldName = 'NAME'
        Options.Editing = False
        Width = 200
      end
      object colFLG_ACTIVE: TcxGridDBColumn
        Caption = 'Activ'
        DataBinding.FieldName = 'FLG_ACTIVE'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueGrayed = 0
        Properties.ValueUnchecked = 0
        Width = 45
      end
      object colFLG_CAN_PICKUP: TcxGridDBColumn
        Caption = 'Ridica'
        DataBinding.FieldName = 'FLG_CAN_PICKUP'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueGrayed = 0
        Properties.ValueUnchecked = 0
        Width = 45
      end
      object colFLG_CAN_DELIVER: TcxGridDBColumn
        Caption = 'Livreaza'
        DataBinding.FieldName = 'FLG_CAN_DELIVER'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueGrayed = 0
        Properties.ValueUnchecked = 0
        Width = 55
      end
      object colSTOCKID: TcxGridDBColumn
        Caption = 'Depozitul masinii'
        DataBinding.FieldName = 'STOCKID'
        PropertiesClassName = 'TcxLookupComboBoxProperties'
        Properties.DropDownListStyle = lsFixedList
        Properties.KeyFieldNames = 'STOCKID'
        Properties.ListColumns = <
          item
            FieldName = 'TITLE'
          end>
        Properties.ListSource = IBCDataSourceStocks
        Width = 160
      end
      object colPHONE: TcxGridDBColumn
        Caption = 'Telefon'
        DataBinding.FieldName = 'PHONE'
        Width = 100
      end
      object colWEB_LOGIN: TcxGridDBColumn
        Caption = 'Login aplicatie'
        DataBinding.FieldName = 'WEB_LOGIN'
        Width = 100
      end
      object colHAS_WEB_PASSWORD: TcxGridDBColumn
        Caption = 'Are parola'
        DataBinding.FieldName = 'HAS_WEB_PASSWORD'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueGrayed = 0
        Properties.ValueUnchecked = 0
        Options.Editing = False
        Width = 60
      end
      object colWEB_ACTIVATION_EXPIRES: TcxGridDBColumn
        Caption = 'Cod valabil pana la'
        DataBinding.FieldName = 'WEB_ACTIVATION_EXPIRES'
        Options.Editing = False
        Width = 110
      end
      object colWEB_LAST_LOGIN_AT: TcxGridDBColumn
        Caption = 'Ultima intrare'
        DataBinding.FieldName = 'WEB_LAST_LOGIN_AT'
        Options.Editing = False
        Visible = False
        Width = 110
      end
      object colNOTE: TcxGridDBColumn
        Caption = 'Nota'
        DataBinding.FieldName = 'NOTE'
        Width = 160
      end
    end
    object cxGridCouriersLevel: TcxGridLevel
      GridView = cxGridCouriersTable
    end
  end
  object btnAdd: TcxButton
    Left = 8
    Top = 516
    Width = 120
    Height = 31
    Anchors = [akLeft, akBottom]
    Caption = 'Adauga curier'
    TabOrder = 2
    OnClick = btnAddClick
  end
  object btnActivation: TcxButton
    Left = 134
    Top = 516
    Width = 150
    Height = 31
    Anchors = [akLeft, akBottom]
    Caption = 'Cod de activare...'
    TabOrder = 3
    OnClick = btnActivationClick
  end
  object btnCreateStock: TcxButton
    Left = 290
    Top = 516
    Width = 190
    Height = 31
    Anchors = [akLeft, akBottom]
    Caption = 'Creeaza depozitul masinii...'
    TabOrder = 6
    OnClick = btnCreateStockClick
  end
  object btnOk: TcxButton
    Left = 866
    Top = 516
    Width = 110
    Height = 31
    Anchors = [akRight, akBottom]
    Caption = 'Salveaza'
    Default = True
    ModalResult = 1
    TabOrder = 4
  end
  object btnCancel: TcxButton
    Left = 982
    Top = 516
    Width = 110
    Height = 31
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 5
  end
  object IBCQueryCouriers: TIBCQuery
    KeyFields = 'CUSTOMERID'
    SQLInsert.Strings = (
      'INSERT INTO TS_COURIER'
      '  (CUSTOMERID, FLG_ACTIVE, FLG_CAN_PICKUP, FLG_CAN_DELIVER, STOCKID,'
      '   PHONE, WEB_LOGIN, NOTE)'
      'VALUES'
      '  (:CUSTOMERID, :FLG_ACTIVE, :FLG_CAN_PICKUP, :FLG_CAN_DELIVER, :STOCKID,'
      '   :PHONE, :WEB_LOGIN, :NOTE)')
    SQLUpdate.Strings = (
      'UPDATE TS_COURIER'
      'SET'
      '  FLG_ACTIVE = :FLG_ACTIVE, FLG_CAN_PICKUP = :FLG_CAN_PICKUP,'
      '  FLG_CAN_DELIVER = :FLG_CAN_DELIVER, STOCKID = :STOCKID,'
      '  PHONE = :PHONE, WEB_LOGIN = :WEB_LOGIN, NOTE = :NOTE'
      'WHERE'
      '  CUSTOMERID = :Old_CUSTOMERID')
    SQLRefresh.Strings = (
      'SELECT K.CUSTOMERID, C.NAME, K.FLG_ACTIVE, K.FLG_CAN_PICKUP, K.FLG_CAN_DELIVER,'
      '       K.STOCKID, K.PHONE, K.WEB_LOGIN, K.NOTE,'
      '       IIF(K.WEB_PASSWORD_HASH IS NULL, 0, 1) AS HAS_WEB_PASSWORD,'
      '       K.WEB_ACTIVATION_EXPIRES, K.WEB_LAST_LOGIN_AT'
      'FROM TS_COURIER K'
      'JOIN TS_CUSTOMER C ON C.CUSTOMERID = K.CUSTOMERID'
      'WHERE K.CUSTOMERID = :CUSTOMERID')
    BeforePost = IBCQueryCouriersBeforePost
    OnNewRecord = IBCQueryCouriersNewRecord
    SQL.Strings = (
      'SELECT K.CUSTOMERID, C.NAME, K.FLG_ACTIVE, K.FLG_CAN_PICKUP, K.FLG_CAN_DELIVER,'
      '       K.STOCKID, K.PHONE, K.WEB_LOGIN, K.NOTE,'
      '       IIF(K.WEB_PASSWORD_HASH IS NULL, 0, 1) AS HAS_WEB_PASSWORD,'
      '       K.WEB_ACTIVATION_EXPIRES, K.WEB_LAST_LOGIN_AT'
      'FROM TS_COURIER K'
      'JOIN TS_CUSTOMER C ON C.CUSTOMERID = K.CUSTOMERID'
      'ORDER BY K.FLG_ACTIVE DESC, C.NAME')
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    AutoCommit = False
    Left = 48
    Top = 200
  end
  object IBCDataSourceCouriers: TIBCDataSource
    DataSet = IBCQueryCouriers
    Left = 136
    Top = 200
  end
  object IBCQueryStocks: TIBCQuery
    SQL.Strings = (
      'SELECT STOCKID, TITLE FROM TS_STOCKS'
      'WHERE COALESCE(FLG_FOLDER, 0) = 0'
      'ORDER BY TITLE')
    ReadOnly = True
    Left = 48
    Top = 256
  end
  object IBCDataSourceStocks: TIBCDataSource
    DataSet = IBCQueryStocks
    Left = 136
    Top = 256
  end
  object IBCQueryUsers: TIBCQuery
    SQL.Strings = (
      'SELECT USERID, FULL_NAME FROM TS_USERS'
      'ORDER BY FULL_NAME')
    ReadOnly = True
    Left = 48
    Top = 312
  end
  object IBCDataSourceUsers: TIBCDataSource
    DataSet = IBCQueryUsers
    Left = 136
    Top = 312
  end
  object IBCTransactionUpdate: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 232
    Top = 200
  end
end
