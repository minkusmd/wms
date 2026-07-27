object frmEditDateExchangeDlg: TfrmEditDateExchangeDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077' '#1076#1072#1090#1099
  ClientHeight = 143
  ClientWidth = 211
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
  object cxButton1: TcxButton
    Left = 24
    Top = 94
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object cxButton2: TcxButton
    Left = 110
    Top = 94
    Width = 75
    Height = 25
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 1
  end
  object cxDateEdit1: TcxDateEdit
    Left = 24
    Top = 40
    Properties.OnChange = cxDateEdit1PropertiesChange
    TabOrder = 2
    Width = 161
  end
  object cxLabel1: TcxLabel
    Left = 24
    Top = 17
    Caption = #1044#1072#1090#1072
  end
end
