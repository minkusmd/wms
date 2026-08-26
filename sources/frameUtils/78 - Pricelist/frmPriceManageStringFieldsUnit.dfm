object frmPriceManageStringFieldsDlg: TfrmPriceManageStringFieldsDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'frmPriceManageStringFieldsDlg'
  ClientHeight = 162
  ClientWidth = 500
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object Label1: TLabel
    Left = 8
    Top = 37
    Width = 148
    Height = 15
    Caption = 'Textul care trebuie de exclus'
  end
  object teExcludeString: TcxTextEdit
    Left = 8
    Top = 56
    Enabled = False
    TabOrder = 0
    Width = 337
  end
  object cbExcludeString: TcxCheckBox
    Left = 367
    Top = 60
    Caption = 'Exclude din cimp'
    Properties.OnChange = cxCheckBox1PropertiesChange
    Style.TransparentBorder = False
    TabOrder = 1
  end
  object cmbFieldName: TcxComboBox
    Left = 8
    Top = 8
    Enabled = False
    Properties.DropDownListStyle = lsFixedList
    Properties.Items.Strings = (
      'MODEL'
      'DENUMIRE')
    TabOrder = 2
    Text = 'MODEL'
    Width = 225
  end
  object cxButton1: TcxButton
    Left = 152
    Top = 125
    Width = 90
    Height = 29
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 3
  end
  object cxButton2: TcxButton
    Left = 248
    Top = 125
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 4
  end
end
