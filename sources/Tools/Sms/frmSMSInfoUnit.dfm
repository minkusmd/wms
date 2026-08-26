object frmSMSInfoDlg: TfrmSMSInfoDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'SMS info'
  ClientHeight = 182
  ClientWidth = 487
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object cxLabel1: TcxLabel
    Left = 8
    Top = 16
    Caption = 'Numar de telefon'
    TabOrder = 0
  end
  object tePhoneNumber: TcxTextEdit
    Left = 111
    Top = 15
    TabOrder = 1
    Width = 121
  end
  object cxLabel2: TcxLabel
    Left = 8
    Top = 56
    Caption = 'Mesaj'
    TabOrder = 2
  end
  object meMessage: TcxMemo
    Left = 113
    Top = 44
    TabOrder = 3
    Height = 89
    Width = 366
  end
  object RzDialogButtons1: TRzDialogButtons
    Left = 0
    Top = 141
    Width = 487
    Height = 41
    TabOrder = 4
  end
end
