object frmEditCecDlg: TfrmEditCecDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1050#1072#1089#1089#1086#1074#1099#1077' '#1076#1086#1082#1091#1084#1077#1085#1090#1099
  ClientHeight = 121
  ClientWidth = 291
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object bntOK: TcxButton
    Left = 119
    Top = 88
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object cxLabel1: TcxLabel
    Left = 8
    Top = 28
    Caption = #1050#1086#1076' '#1087#1088#1080#1093#1086#1076#1085#1086#1075#1086' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
  end
  object cxDBCecEdit: TcxDBCalcEdit
    Left = 154
    Top = 27
    TabOrder = 0
    Width = 121
  end
  object cxButton1: TcxButton
    Left = 200
    Top = 88
    Width = 75
    Height = 25
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 3
  end
end
