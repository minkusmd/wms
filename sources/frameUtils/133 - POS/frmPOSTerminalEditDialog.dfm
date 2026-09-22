object frmPOSTerminalEditDlg: TfrmPOSTerminalEditDlg
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Casa'
  ClientHeight = 500
  ClientWidth = 560
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 17
  object lblTitle: TLabel
    Left = 20
    Top = 16
    Width = 94
    Height = 17
    Caption = 'Denumirea casei'
  end
  object lblFirma: TLabel
    Left = 20
    Top = 70
    Width = 34
    Height = 17
    Caption = 'Firma'
  end
  object lblStock: TLabel
    Left = 290
    Top = 70
    Width = 173
    Height = 17
    Caption = 'Depozitul din care se vinde'
  end
  object lblWS: TLabel
    Left = 20
    Top = 124
    Width = 210
    Height = 17
    Caption = 'Statia de lucru (calculatorul casei)'
  end
  object lblWSHint: TLabel
    Left = 20
    Top = 172
    Width = 250
    Height = 17
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGrayText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object lblFP: TLabel
    Left = 290
    Top = 124
    Width = 116
    Height = 17
    Caption = 'Aparatul fiscal (MCC)'
  end
  object lblCustomer: TLabel
    Left = 20
    Top = 204
    Width = 443
    Height = 17
    Caption = 'Clientul pus implicit pe bonuri (cautati dupa denumire sau cod, apoi alegeti)'
  end
  object lblPriceColumn: TLabel
    Left = 20
    Top = 308
    Width = 98
    Height = 17
    Caption = 'Coloana de pret'
  end
  object lblMaxDiscount: TLabel
    Left = 290
    Top = 308
    Width = 219
    Height = 17
    Caption = 'Reducerea maxima a casierului, %'
  end
  object edTitle: TEdit
    Left = 20
    Top = 36
    Width = 520
    Height = 25
    MaxLength = 128
    TabOrder = 0
  end
  object cmbFirma: TComboBox
    Left = 20
    Top = 90
    Width = 250
    Height = 25
    Style = csDropDownList
    DropDownCount = 16
    TabOrder = 1
    OnChange = cmbFirmaChange
  end
  object cmbStock: TComboBox
    Left = 290
    Top = 90
    Width = 250
    Height = 25
    Style = csDropDownList
    DropDownCount = 20
    TabOrder = 2
  end
  object cmbWS: TComboBox
    Left = 20
    Top = 144
    Width = 250
    Height = 25
    Style = csDropDownList
    DropDownCount = 16
    TabOrder = 3
  end
  object cmbFP: TComboBox
    Left = 290
    Top = 144
    Width = 250
    Height = 25
    Style = csDropDownList
    DropDownCount = 16
    TabOrder = 4
  end
  object edCustomerSearch: TEdit
    Left = 20
    Top = 224
    Width = 400
    Height = 25
    TabOrder = 5
    TextHint = 'denumire sau cod client'
    OnKeyDown = edCustomerSearchKeyDown
  end
  object btnCustomerFind: TButton
    Left = 430
    Top = 223
    Width = 110
    Height = 27
    Caption = 'Cauta'
    TabOrder = 6
    OnClick = btnCustomerFindClick
  end
  object cmbCustomer: TComboBox
    Left = 20
    Top = 258
    Width = 520
    Height = 25
    Style = csDropDownList
    DropDownCount = 20
    TabOrder = 7
  end
  object cmbPriceColumn: TComboBox
    Left = 20
    Top = 328
    Width = 250
    Height = 25
    Style = csDropDownList
    TabOrder = 8
  end
  object edMaxDiscount: TEdit
    Left = 290
    Top = 328
    Width = 100
    Height = 25
    MaxLength = 3
    NumbersOnly = True
    TabOrder = 9
  end
  object cbEnabled: TCheckBox
    Left = 20
    Top = 376
    Width = 300
    Height = 21
    Caption = 'Casa este activa'
    TabOrder = 10
  end
  object btnOK: TButton
    Left = 20
    Top = 444
    Width = 250
    Height = 38
    Caption = 'Salveaza'
    Default = True
    ModalResult = 1
    TabOrder = 11
  end
  object btnCancel: TButton
    Left = 290
    Top = 444
    Width = 250
    Height = 38
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 12
  end
end
