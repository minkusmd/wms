object frmSetupConnectionDlg: TfrmSetupConnectionDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1089#1077#1088#1074#1080#1089#1072
  ClientHeight = 361
  ClientWidth = 643
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnShow = FormShow
  DesignSize = (
    643
    361)
  PixelsPerInch = 96
  TextHeight = 15
  object DialogTitle1: TDialogTitle
    Left = 0
    Top = 0
    Width = 643
    Height = 64
    Title = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1089#1077#1088#1074#1080#1089#1072
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
    ExplicitLeft = 276
    ExplicitTop = 176
    ExplicitWidth = 0
  end
  object pnMain: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 627
    Height = 230
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
    ShowCaption = False
    TabOrder = 1
    ExplicitLeft = 13
    ExplicitTop = 75
    ExplicitHeight = 184
    object Label1: TLabel
      Left = 16
      Top = 70
      Width = 40
      Height = 15
      Caption = #1057#1077#1088#1074#1077#1088
    end
    object Label4: TLabel
      Left = 16
      Top = 99
      Width = 28
      Height = 15
      Caption = #1055#1086#1088#1090
    end
    object Label5: TLabel
      Left = 16
      Top = 128
      Width = 67
      Height = 15
      Caption = #1041#1072#1079#1072' '#1076#1072#1085#1085#1099#1093
    end
    object Label2: TLabel
      Left = 348
      Top = 70
      Width = 77
      Height = 15
      Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
    end
    object Label3: TLabel
      Left = 348
      Top = 99
      Width = 42
      Height = 15
      Caption = #1055#1072#1088#1086#1083#1100
    end
    object Label6: TLabel
      Left = 16
      Top = 19
      Width = 150
      Height = 15
      Caption = #1056#1072#1073#1086#1095#1072#1103' '#1087#1072#1087#1082#1072' '#1076#1083#1103' '#1089#1077#1088#1074#1080#1089#1072
    end
    object sbBrowse: TSpeedButton
      Left = 531
      Top = 16
      Width = 70
      Height = 23
      Caption = #1074#1099#1073#1088#1072#1090#1100'...'
      OnClick = sbBrowseClick
    end
    object SpeedButton1: TSpeedButton
      Left = 512
      Top = 126
      Width = 89
      Height = 22
      Caption = 'Test connect'
      OnClick = SpeedButton1Click
    end
    object Label7: TLabel
      Left = 16
      Top = 172
      Width = 122
      Height = 15
      Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100' '#1080#1079' '#1073#1072#1079#1099
    end
    object sbSelectDBUser: TSpeedButton
      Left = 351
      Top = 169
      Width = 70
      Height = 23
      Caption = #1074#1099#1073#1088#1072#1090#1100'...'
      OnClick = sbSelectDBUserClick
    end
    object edServer: TEdit
      Left = 89
      Top = 67
      Width = 185
      Height = 23
      TabOrder = 1
    end
    object edPort: TEdit
      Left = 89
      Top = 96
      Width = 85
      Height = 23
      TabOrder = 2
    end
    object edDBName: TEdit
      Left = 89
      Top = 125
      Width = 185
      Height = 23
      TabOrder = 3
    end
    object edUserName: TEdit
      Left = 431
      Top = 67
      Width = 170
      Height = 23
      TabOrder = 4
    end
    object edUserPass: TEdit
      Left = 431
      Top = 96
      Width = 170
      Height = 23
      PasswordChar = '*'
      TabOrder = 5
    end
    object edAppPath: TEdit
      Left = 172
      Top = 16
      Width = 353
      Height = 23
      TabStop = False
      ReadOnly = True
      TabOrder = 0
    end
    object edDBUserName: TEdit
      Left = 144
      Top = 169
      Width = 201
      Height = 23
      TabStop = False
      ReadOnly = True
      TabOrder = 6
    end
  end
  object btnOk: TButton
    Left = 431
    Top = 317
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'Ok'
    Default = True
    TabOrder = 2
    OnClick = btnOkClick
    ExplicitLeft = 449
    ExplicitTop = 220
  end
  object btnCancel: TButton
    Left = 535
    Top = 317
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
    ExplicitLeft = 553
    ExplicitTop = 220
  end
end
