object frmGoodsAttributesDlg: TfrmGoodsAttributesDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Gestionarea atributelor web a produsului'
  ClientHeight = 277
  ClientWidth = 330
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
    Left = 79
    Top = 240
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object cxButton2: TcxButton
    Left = 168
    Top = 240
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 1
  end
  object clbAttributes: TcxDBCheckListBox
    Left = 8
    Top = 8
    Width = 314
    Height = 217
    DataBinding.DataField = 'Attributes'
    Items = <>
    ParentColor = False
    ParentFont = False
    Style.Font.Charset = RUSSIAN_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -13
    Style.Font.Name = 'Segoe UI'
    Style.Font.Style = []
    Style.IsFontAssigned = True
    TabOrder = 2
  end
end
