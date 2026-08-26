object frmChooseDeliveryTypeDlg: TfrmChooseDeliveryTypeDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Tipul livrarii'
  ClientHeight = 173
  ClientWidth = 211
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object cxGroupBox1: TcxGroupBox
    Left = 8
    Top = 8
    Caption = 'Livrare'
    TabOrder = 0
    Height = 97
    Width = 193
    object cxRadioButton1: TcxRadioButton
      Left = 16
      Top = 24
      Width = 145
      Height = 17
      Caption = 'or. Chisinau'
      TabOrder = 0
    end
    object cxRadioButton2: TcxRadioButton
      Left = 16
      Top = 47
      Width = 145
      Height = 17
      Caption = 'Suburbii'
      TabOrder = 1
    end
    object cxRadioButton3: TcxRadioButton
      Left = 16
      Top = 70
      Width = 145
      Height = 17
      Caption = 'Regiuni'
      TabOrder = 2
    end
  end
  object RzDialogButtons1: TRzDialogButtons
    Left = 0
    Top = 132
    Width = 211
    Height = 41
    TabOrder = 1
    ExplicitTop = 400
    ExplicitWidth = 624
  end
end
