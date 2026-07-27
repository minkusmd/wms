object frmGoodsTypeNPSCDlg: TfrmGoodsTypeNPSCDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1058#1080#1087#1080#1079#1072#1094#1080#1103' '#1082#1086#1084#1087#1086#1085#1077#1085#1090' '#1074' '#1085#1072#1079#1074#1072#1085#1080#1080' '#1090#1086#1074#1072#1088#1072
  ClientHeight = 439
  ClientWidth = 423
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    423
    439)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 423
    Height = 64
    Title = #1058#1080#1087#1080#1079#1072#1094#1080#1103' '#1082#1086#1084#1087#1086#1085#1077#1085#1090' '#1074' '#1085#1072#1079#1074#1072#1085#1080#1080' '#1090#1086#1074#1072#1088#1072
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
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 407
    Height = 313
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
      Left = 16
      Top = 19
      Width = 60
      Height = 15
      Caption = #1058#1080#1087' '#1090#1086#1074#1072#1088#1072
    end
    object Label2: TLabel
      Left = 16
      Top = 161
      Width = 122
      Height = 15
      Caption = '1. '#1041#1072#1079#1086#1074#1099#1081' '#1087#1072#1088#1072#1084#1077#1090#1088
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 16
      Top = 223
      Width = 212
      Height = 15
      Caption = '2. '#1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1099#1077' '#1093#1072#1088#1072#1082#1090#1077#1088#1080#1089#1090#1080#1082#1080
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 16
      Top = 185
      Width = 68
      Height = 15
      Caption = #1056#1072#1079#1076#1077#1083#1080#1090#1077#1083#1100
    end
    object Label5: TLabel
      Left = 16
      Top = 248
      Width = 68
      Height = 15
      Caption = #1056#1072#1079#1076#1077#1083#1080#1090#1077#1083#1100
    end
    object sbEditBaseParam_Params: TSpeedButton
      Left = 308
      Top = 182
      Width = 73
      Height = 23
      Caption = #1080#1079#1084#1077#1085#1080#1090#1100'...'
      OnClick = sbEditBaseParam_ParamsClick
    end
    object sbEditAddParams_Params: TSpeedButton
      Left = 308
      Top = 244
      Width = 73
      Height = 23
      Caption = #1080#1079#1084#1077#1085#1080#1090#1100'...'
      OnClick = sbEditAddParams_ParamsClick
    end
    object Label6: TLabel
      Left = 16
      Top = 111
      Width = 317
      Height = 30
      Caption = 
        #1053#1072#1079#1085#1072#1095#1090#1077' '#1088#1072#1079#1076#1077#1083#1080#1090#1077#1083#1100' '#1080' '#1089#1086#1089#1090#1086#1074#1083#1103#1102#1097#1080#1077' '#1082#1086#1084#1087#1086#1085#1077#1085#1090#1099' '#1076#1083#1103' '#1089#1083#1077#1076#1091#1102#1096#1080#1093' '#1087#1072#1088 +
        #1072#1084#1077#1090#1088#1086#1074':'
      WordWrap = True
    end
    object Label7: TLabel
      Left = 186
      Top = 185
      Width = 116
      Height = 15
      Caption = #1050#1086#1084#1087#1086#1085#1077#1085#1090#1099' '#1089#1086#1089#1090#1072#1074#1072
    end
    object Label8: TLabel
      Left = 186
      Top = 248
      Width = 116
      Height = 15
      Caption = #1050#1086#1084#1087#1086#1085#1077#1085#1090#1099' '#1089#1086#1089#1090#1072#1074#1072
    end
    object edTITLE: TcxDBTextEdit
      Left = 16
      Top = 36
      TabStop = False
      DataBinding.DataField = 'TITLE'
      Properties.ReadOnly = True
      TabOrder = 0
      Width = 365
    end
    object edTITLE_RUS: TcxDBTextEdit
      Left = 16
      Top = 65
      TabStop = False
      DataBinding.DataField = 'TITLE_RUS'
      Properties.ReadOnly = True
      TabOrder = 1
      Width = 365
    end
    object cmbSEPARATOR1: TcxDBComboBox
      Left = 96
      Top = 182
      DataBinding.DataField = 'SEPARATOR'
      DataBinding.DataSource = IBCDataSourceBP
      Properties.DropDownListStyle = lsFixedList
      Properties.Items.Strings = (
        '/'
        ' ')
      TabOrder = 2
      Width = 65
    end
    object cmbSEPARATOR2: TcxDBComboBox
      Left = 96
      Top = 244
      DataBinding.DataField = 'SEPARATOR'
      DataBinding.DataSource = IBCDataSourceAdd
      Properties.DropDownListStyle = lsFixedList
      Properties.Items.Strings = (
        '/'
        ' ')
      TabOrder = 3
      Width = 65
    end
  end
  object btnOk: TButton
    Left = 212
    Top = 396
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 313
    Top = 396
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
  object IBCQueryBP: TIBCQuery
    SQLInsert.Strings = (
      'INSERT INTO NGS_NAMING_BASE_PARAM'
      '  (GOODSTYPEID, SEPARATOR)'
      'VALUES'
      '  (:GOODSTYPEID, :SEPARATOR)')
    SQLUpdate.Strings = (
      'UPDATE NGS_NAMING_BASE_PARAM'
      'SET'
      '  GOODSTYPEID = :GOODSTYPEID, SEPARATOR = :SEPARATOR'
      'WHERE'
      '  GOODSTYPEID = :Old_GOODSTYPEID')
    SQLRefresh.Strings = (
      'SELECT GOODSTYPEID, SEPARATOR FROM NGS_NAMING_BASE_PARAM'
      'WHERE'
      '  GOODSTYPEID = :GOODSTYPEID')
    SQLLock.Strings = (
      'SELECT NULL FROM NGS_NAMING_BASE_PARAM'
      'WHERE'
      'GOODSTYPEID = :Old_GOODSTYPEID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT GOODSTYPEID, SEPARATOR FROM NGS_NAMING_BASE_PARAM')
    MasterFields = 'GOODSTYPEID'
    DetailFields = 'GOODSTYPEID'
    AutoCommit = False
    LockMode = lmLockImmediate
    Left = 36
    Top = 392
  end
  object IBCDataSourceBP: TIBCDataSource
    DataSet = IBCQueryBP
    Left = 36
    Top = 344
  end
  object IBCQueryAdd: TIBCQuery
    SQLInsert.Strings = (
      'INSERT INTO NGS_NAMING_ADD_PARAMS'
      '  (GOODSTYPEID, SEPARATOR)'
      'VALUES'
      '  (:GOODSTYPEID, :SEPARATOR)')
    SQLUpdate.Strings = (
      'UPDATE NGS_NAMING_ADD_PARAMS'
      'SET'
      '  GOODSTYPEID = :GOODSTYPEID, SEPARATOR = :SEPARATOR'
      'WHERE'
      '  GOODSTYPEID = :Old_GOODSTYPEID')
    SQLRefresh.Strings = (
      'SELECT GOODSTYPEID, SEPARATOR FROM NGS_NAMING_ADD_PARAMS'
      'WHERE'
      '  GOODSTYPEID = :GOODSTYPEID')
    SQLLock.Strings = (
      'SELECT NULL FROM NGS_NAMING_ADD_PARAMS'
      'WHERE'
      'GOODSTYPEID = :Old_GOODSTYPEID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT GOODSTYPEID, SEPARATOR FROM NGS_NAMING_ADD_PARAMS')
    MasterFields = 'GOODSTYPEID'
    DetailFields = 'GOODSTYPEID'
    AutoCommit = False
    LockMode = lmLockImmediate
    Left = 136
    Top = 392
  end
  object IBCDataSourceAdd: TIBCDataSource
    DataSet = IBCQueryAdd
    Left = 136
    Top = 344
  end
end
