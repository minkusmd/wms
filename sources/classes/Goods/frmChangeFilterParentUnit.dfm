object frmChangeFilterParentDialog: TfrmChangeFilterParentDialog
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Schimba Filtru parinte'
  ClientHeight = 132
  ClientWidth = 242
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 36
    Width = 66
    Height = 13
    Caption = 'Codul filtrului:'
  end
  object teFilterID: TcxTextEdit
    Left = 96
    Top = 32
    TabOrder = 0
    Text = '0000'
    Width = 113
  end
  object cxButton1: TcxButton
    Left = 32
    Top = 96
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object cxButton2: TcxButton
    Left = 120
    Top = 96
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Anulare'
    ModalResult = 2
    TabOrder = 2
  end
end
