object frmExchangeRateEditorDlg: TfrmExchangeRateEditorDlg
  Left = 0
  Top = 0
  ActiveControl = edRate
  BorderStyle = bsDialog
  Caption = #1055#1077#1088#1077#1089#1095#1077#1090' '#1089#1091#1084#1084#1099
  ClientHeight = 309
  ClientWidth = 360
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  DesignSize = (
    360
    309)
  PixelsPerInch = 96
  TextHeight = 15
  object DialogTitle1: TDialogTitle
    Left = 0
    Top = 0
    Width = 360
    Height = 64
    Title = #1055#1077#1088#1077#1089#1095#1077#1090' '#1089#1091#1084#1084#1099
    Text = #1055#1077#1088#1077#1089#1095#1077#1090' '#1089#1091#1084#1084#1099' '#1080#1079' '#1086#1076#1085#1086#1081' '#1074#1072#1083#1102#1090#1099' '#1074' '#1076#1088#1091#1075#1091#1102
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
    ImageIndex = 4
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 344
    Height = 181
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
    object cxLabel1: TLabel
      Left = 180
      Top = 64
      Width = 127
      Height = 15
      Caption = #1050#1091#1088#1089' '#1087#1077#1088#1077#1089#1095#1077#1090#1072' '#1089#1091#1084#1084#1099
    end
    object Label3: TLabel
      Left = 16
      Top = 64
      Width = 26
      Height = 15
      Caption = #1050#1091#1088#1089
    end
    object Label4: TLabel
      Left = 16
      Top = 112
      Width = 38
      Height = 15
      Caption = #1057#1091#1084#1084#1072
    end
    object Label1: TLabel
      Left = 16
      Top = 16
      Width = 103
      Height = 15
      Caption = #1053#1072#1095#1072#1083#1100#1085#1072#1103' '#1074#1072#1083#1102#1090#1072
    end
    object Label2: TLabel
      Left = 180
      Top = 16
      Width = 104
      Height = 15
      Caption = #1060#1080#1085#1072#1083#1100#1085#1072#1103' '#1074#1072#1083#1102#1090#1072
    end
    object edRate: TEdit
      Left = 180
      Top = 81
      Width = 140
      Height = 23
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
    end
    object edSourceRate: TEdit
      Left = 16
      Top = 81
      Width = 140
      Height = 23
      TabStop = False
      ReadOnly = True
      TabOrder = 2
    end
    object edSourceSuma: TEdit
      Left = 16
      Top = 129
      Width = 140
      Height = 23
      TabStop = False
      ReadOnly = True
      TabOrder = 4
    end
    object edSourceCurrency: TEdit
      Left = 16
      Top = 33
      Width = 140
      Height = 23
      TabStop = False
      ReadOnly = True
      TabOrder = 0
    end
    object edTargetCurrency: TEdit
      Left = 180
      Top = 33
      Width = 140
      Height = 23
      TabStop = False
      ReadOnly = True
      TabOrder = 1
    end
  end
  object btnCancel: TcxButton
    Left = 250
    Top = 264
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 3
  end
  object btnOk: TcxButton
    Left = 146
    Top = 264
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
end
