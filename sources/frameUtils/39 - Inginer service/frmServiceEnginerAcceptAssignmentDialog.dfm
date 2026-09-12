object frmServiceEnginerAcceptAssignmentDlg: TfrmServiceEnginerAcceptAssignmentDlg
  Left = 0
  Top = 0
  ActiveControl = btnOk
  BorderStyle = bsDialog
  Caption = #1055#1088#1080#1085#1103#1090#1100' '#1079#1072#1087#1088#1086#1089
  ClientHeight = 500
  ClientWidth = 500
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
  object DialogTitle1: TDialogTitle
    Left = 0
    Top = 0
    Width = 500
    Height = 64
    Title = #1055#1088#1080#1085#1103#1090#1100' '#1079#1072#1087#1088#1086#1089
    Text = #1055#1086#1076#1090#1074#1077#1088#1076#1080#1090#1077' '#1087#1088#1080#1085#1103#1090#1080#1077' '#1079#1072#1087#1088#1086#1089#1072' '#1085#1072' '#1091#1089#1083#1091#1075#1091' '#1080#1083#1080' '#1088#1077#1084#1086#1085#1090
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
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 484
    Height = 373
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
      Width = 40
      Height = 15
      Caption = #1047#1072#1087#1088#1086#1089
    end
    object Label2: TLabel
      Left = 20
      Top = 76
      Width = 77
      Height = 15
      Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1081
    end
    object Label3: TLabel
      Left = 20
      Top = 196
      Width = 144
      Height = 15
      Caption = #1057#1077#1088#1080#1081#1085#1099#1081' '#1085#1086#1084#1077#1088' '#1080#1079#1076#1077#1083#1080#1103
    end
    object Label4: TLabel
      Left = 249
      Top = 196
      Width = 192
      Height = 15
      Caption = #1058#1088#1077#1073#1091#1077#1084#1072#1103' '#1076#1072#1090#1072' '#1086#1082#1086#1085#1095#1072#1085#1080#1103' '#1088#1072#1073#1086#1090#1099
    end
    object Label5: TLabel
      Left = 20
      Top = 328
      Width = 256
      Height = 15
      Caption = #1044#1083#1103' '#1087#1086#1076#1090#1074#1077#1088#1078#1076#1077#1085#1080#1103' '#1087#1086#1085#1072#1076#1086#1073#1080#1090#1089#1103' '#1042#1072#1096' '#1087#1072#1088#1086#1083#1100'!'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 20
      Top = 260
      Width = 77
      Height = 15
      Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
    end
    object edTITLE: TcxDBTextEdit
      Left = 20
      Top = 37
      TabStop = False
      DataBinding.DataField = 'TITLE'
      ParentFont = False
      Properties.ReadOnly = True
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -13
      Style.Font.Name = 'Verdana'
      Style.Font.Style = []
      Style.IsFontAssigned = True
      TabOrder = 0
      Width = 437
    end
    object mmCOMMENTS: TcxDBMemo
      Left = 20
      Top = 93
      TabStop = False
      DataBinding.DataField = 'COMMENTS'
      ParentFont = False
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -13
      Style.Font.Name = 'Verdana'
      Style.Font.Style = []
      Style.IsFontAssigned = True
      TabOrder = 1
      Height = 84
      Width = 437
    end
    object edSN: TcxDBTextEdit
      Left = 20
      Top = 213
      TabStop = False
      DataBinding.DataField = 'SN'
      ParentFont = False
      Properties.ReadOnly = True
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -13
      Style.Font.Name = 'Verdana'
      Style.Font.Style = []
      Style.IsFontAssigned = True
      TabOrder = 2
      Width = 157
    end
    object dteEND_ESTIMATED_TIME: TcxDBDateEdit
      Left = 249
      Top = 213
      TabStop = False
      DataBinding.DataField = 'END_ESTIMATED_TIME'
      ParentFont = False
      Properties.Kind = ckDateTime
      Properties.ReadOnly = True
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -13
      Style.Font.Name = 'Verdana'
      Style.Font.Style = []
      Style.IsFontAssigned = True
      TabOrder = 3
      Width = 208
    end
    object edCREATED_FULL_NAME: TcxDBTextEdit
      Left = 20
      Top = 277
      TabStop = False
      DataBinding.DataField = 'CREATED_FULL_NAME'
      Properties.ReadOnly = True
      TabOrder = 4
      Width = 437
    end
  end
  object btnOk: TButton
    Left = 284
    Top = 456
    Width = 90
    Height = 29
    Caption = #1055#1088#1080#1085#1103#1090#1100
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 389
    Top = 456
    Width = 90
    Height = 29
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
end
