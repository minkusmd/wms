object frmServiceEnginerTaskCommentsDlg: TfrmServiceEnginerTaskCommentsDlg
  Left = 0
  Top = 0
  ActiveControl = mmCOMMENTS
  BorderStyle = bsDialog
  Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1081' '#1082' '#1079#1072#1076#1072#1095#1077
  ClientHeight = 376
  ClientWidth = 481
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
    Width = 481
    Height = 64
    Title = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1081' '#1082' '#1079#1072#1076#1072#1095#1077
    Text = #1042#1085#1077#1089#1080#1090#1077' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1102' '#1080' '#1076#1077#1081#1089#1090#1074#1080#1103' '#1087#1086' '#1079#1072#1076#1072#1095#1077
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
    ImageIndex = 32
    ExplicitLeft = 172
    ExplicitTop = 116
    ExplicitWidth = 0
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 465
    Height = 249
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    ShowCaption = False
    TabOrder = 1
    object Label1: TLabel
      Left = 20
      Top = 20
      Width = 38
      Height = 15
      Caption = #1047#1072#1076#1072#1095#1072
    end
    object Label2: TLabel
      Left = 20
      Top = 73
      Width = 77
      Height = 15
      Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1081
    end
    object edTASKTYPE_TITLE: TcxDBTextEdit
      Left = 20
      Top = 37
      TabStop = False
      DataBinding.DataField = 'TASKTYPE_TITLE'
      Properties.ReadOnly = True
      TabOrder = 0
      Width = 417
    end
    object mmCOMMENTS: TcxDBMemo
      Left = 20
      Top = 90
      DataBinding.DataField = 'COMMENTS'
      DataBinding.DataSource = IBCDataSourceComm
      ParentFont = False
      Properties.ScrollBars = ssVertical
      Properties.VisibleLineCount = 8
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -13
      Style.Font.Name = 'Verdana'
      Style.Font.Style = []
      Style.IsFontAssigned = True
      TabOrder = 1
      Width = 417
    end
  end
  object btnOk: TButton
    Left = 260
    Top = 332
    Width = 90
    Height = 29
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 368
    Top = 332
    Width = 90
    Height = 29
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
  object IBCQueryComm: TIBCQuery
    SQLUpdate.Strings = (
      'UPDATE SC_TASK'
      'SET'
      '  COMMENTS = :COMMENTS'
      'WHERE'
      '  TASKID = :Old_TASKID')
    SQLLock.Strings = (
      'SELECT NULL FROM SC_TASK'
      'WHERE'
      'TASKID = :Old_TASKID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultUpdate
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'SELECT'
      ' TASKID,'
      ' COMMENTS'
      'FROM SC_TASK')
    MasterFields = 'TASKID'
    DetailFields = 'TASKID'
    AutoCommit = False
    Left = 224
    Top = 128
  end
  object IBCDataSourceComm: TIBCDataSource
    DataSet = IBCQueryComm
    Left = 224
    Top = 184
  end
end
