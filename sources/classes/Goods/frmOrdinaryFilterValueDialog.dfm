object frmOrdinaryFilterValueDlg: TfrmOrdinaryFilterValueDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'frmOrdinaryFilterValueDlg'
  ClientHeight = 134
  ClientWidth = 392
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    392
    134)
  PixelsPerInch = 96
  TextHeight = 13
  object Label8: TLabel
    Left = 221
    Top = 26
    Width = 48
    Height = 13
    Caption = #1047#1085#1072#1095#1077#1085#1080#1077
  end
  object Label4: TLabel
    Left = 21
    Top = 26
    Width = 36
    Height = 13
    Caption = 'Valoare'
  end
  object edtSimpleFilterValueRo: TcxDBTextEdit
    Left = 21
    Top = 42
    DataBinding.DataField = 'property_value_ro'
    TabOrder = 0
    Width = 168
  end
  object edtSimpleFilterValueRu: TcxDBTextEdit
    Left = 195
    Top = 44
    DataBinding.DataField = 'property_value_ru'
    TabOrder = 1
    Width = 168
  end
  object btnOk: TcxButton
    Left = 166
    Top = 97
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
    ExplicitLeft = 156
    ExplicitTop = 150
  end
  object btnCancel: TcxButton
    Left = 262
    Top = 97
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
    ExplicitLeft = 252
    ExplicitTop = 150
  end
end
