object frmCredit01Dlg: TfrmCredit01Dlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Calcula oferta in credit'
  ClientHeight = 119
  ClientWidth = 287
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object RzDialogButtons1: TRzDialogButtons
    Left = 0
    Top = 83
    Width = 287
    TabOrder = 2
  end
  object cxLabel1: TcxLabel
    Left = 25
    Top = 36
    Caption = 'Selectati numarul de luni'
    TabOrder = 1
  end
  object cbmMonthQty: TcxComboBox
    Left = 177
    Top = 35
    Properties.DropDownListStyle = lsFixedList
    Properties.Items.Strings = (
      '3'
      '4'
      '5'
      '7'
      '11'
      '13')
    TabOrder = 0
    Text = '3'
    Width = 54
  end
end
