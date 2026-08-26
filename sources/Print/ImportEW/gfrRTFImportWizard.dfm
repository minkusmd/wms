object RTFImportForm: TRTFImportForm
  Left = 432
  Top = 225
  Caption = #1048#1084#1087#1086#1088#1090' '#1092#1086#1088#1084#1099' '#1086#1090#1095#1077#1090#1072' '#1080#1079' RTF'
  ClientHeight = 75
  ClientWidth = 323
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object StBar: TStatusBar
    Left = 0
    Top = 67
    Width = 330
    Height = 19
    Align = alNone
    Panels = <
      item
        Width = 330
      end>
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 0
    Width = 233
    Height = 65
    Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1080#1084#1087#1086#1088#1090#1072':'
    TabOrder = 1
    object CheckBoxNoFcom: TCheckBox
      Left = 16
      Top = 16
      Width = 204
      Height = 17
      Caption = #1048#1075#1085#1086#1088#1080#1088#1086#1074#1072#1090#1100' '#1086#1087#1077#1088#1072#1090#1086#1088#1099' FCOM'
      TabOrder = 0
    end
    object CheckBoxNoPicture: TCheckBox
      Left = 16
      Top = 40
      Width = 204
      Height = 17
      Caption = #1048#1075#1085#1086#1088#1080#1088#1086#1074#1072#1090#1100' '#1082#1072#1088#1090#1080#1085#1082#1080
      TabOrder = 1
    end
  end
  object ButtonImp: TButton
    Left = 248
    Top = 6
    Width = 75
    Height = 25
    Caption = #1048#1084#1087#1086#1088#1090
    Default = True
    TabOrder = 0
    OnClick = ButtonImpClick
  end
  object OpenDialog: TOpenDialog
    Ctl3D = False
    Left = 208
    Top = 8
  end
end
