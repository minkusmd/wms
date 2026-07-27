object frmWebMailingsSelectTestEmailsDlg: TfrmWebMailingsSelectTestEmailsDlg
  Left = 0
  Top = 0
  ActiveControl = mmEMails
  BorderStyle = bsDialog
  Caption = #1045'-'#1052#1101#1081#1083#1099' '#1076#1083#1103' '#1090#1077#1089#1090#1086#1074#1086#1081' '#1088#1072#1089#1089#1099#1083#1082#1077
  ClientHeight = 358
  ClientWidth = 428
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
    Width = 428
    Height = 64
    Title = #1045'-'#1052#1101#1081#1083#1099' '#1076#1083#1103' '#1090#1077#1089#1090#1086#1074#1086#1081' '#1088#1072#1089#1089#1099#1083#1082#1077
    Text = #1059#1082#1072#1078#1080#1090#1077' '#1085#1072' '#1082#1072#1082#1080#1077' '#1077'-'#1084#1101#1081#1083#1099' '#1086#1090#1087#1088#1072#1074#1080#1090#1100' '#1088#1072#1089#1089#1099#1083#1082#1091
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
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 412
    Height = 233
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    object Label1: TLabel
      Left = 16
      Top = 16
      Width = 100
      Height = 15
      Caption = #1057#1087#1080#1089#1086#1082' '#1077'-'#1084#1101#1081#1083#1086#1074':'
    end
    object mmEMails: TMemo
      Left = 16
      Top = 34
      Width = 373
      Height = 172
      Lines.Strings = (
        'sergiu@fantastic.md'
        'sergiu.minchevici@gmail.com'
        'minkus@outlook.com'
        'simion_iurii@yahoo.com')
      TabOrder = 0
    end
  end
  object btnOk: TButton
    Left = 220
    Top = 316
    Width = 90
    Height = 29
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 320
    Top = 316
    Width = 90
    Height = 29
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
end
