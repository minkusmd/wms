object frmSMSHistoryDlg: TfrmSMSHistoryDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Istoria SMS'
  ClientHeight = 269
  ClientWidth = 633
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 15
  object cxButton1: TcxButton
    Left = 216
    Top = 231
    Width = 90
    Height = 29
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object cxButton2: TcxButton
    Left = 320
    Top = 231
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 1
  end
  inline frameSMSHistory1: TframeSMSHistory
    Left = 0
    Top = 0
    Width = 633
    Height = 205
    TabOrder = 2
  end
end
