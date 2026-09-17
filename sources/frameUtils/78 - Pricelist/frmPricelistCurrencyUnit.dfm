object frmPricelistCurrencyDlg: TfrmPricelistCurrencyDlg
  Left = 0
  Top = 0
  ActiveControl = lcbRRP
  BorderStyle = bsDialog
  Caption = 'Valutele pricelistului'
  ClientHeight = 252
  ClientWidth = 400
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  TextHeight = 15
  object lbInfo: TLabel
    Left = 16
    Top = 12
    Width = 368
    Height = 30
    AutoSize = False
    Caption =
      'Valutele se completeaza in coloanele "Val. Vinz." si "Val. 7" si' +
      ' se memoreaza pentru furnizor.'
    WordWrap = True
  end
  object lbRRP: TLabel
    Left = 16
    Top = 54
    Width = 196
    Height = 15
    Caption = 'Valuta RRP (pret de vinzare, Pret 3)'
  end
  object lbPurchase: TLabel
    Left = 16
    Top = 110
    Width = 200
    Height = 15
    Caption = 'Valuta pretului de intrare (Pret 0, 7)'
  end
  object lcbRRP: TcxLookupComboBox
    Left = 16
    Top = 73
    Properties.DropDownListStyle = lsFixedList
    Properties.KeyFieldNames = 'CURRENCYID'
    Properties.ListColumns = <
      item
        FieldName = 'TITLE'
      end>
    Properties.ListOptions.ShowHeader = False
    Properties.ListSource = IBCDataSourceCurrency
    TabOrder = 0
    Width = 368
  end
  object lcbPurchase: TcxLookupComboBox
    Left = 16
    Top = 129
    Properties.DropDownListStyle = lsFixedList
    Properties.KeyFieldNames = 'CURRENCYID'
    Properties.ListColumns = <
      item
        FieldName = 'TITLE'
      end>
    Properties.ListOptions.ShowHeader = False
    Properties.ListSource = IBCDataSourceCurrency
    TabOrder = 1
    Width = 368
  end
  object cbOverwrite: TcxCheckBox
    Left = 16
    Top = 166
    Caption = 'Inlocuieste si valutele deja completate in tabel'
    State = cbsChecked
    TabOrder = 2
    Transparent = True
    Width = 368
  end
  object btnOk: TcxButton
    Left = 198
    Top = 210
    Width = 90
    Height = 29
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 3
  end
  object btnCancel: TcxButton
    Left = 294
    Top = 210
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 4
  end
  object IBCQueryCurrency: TIBCQuery
    SQL.Strings = (
      'SELECT CURRENCYID, TITLE'
      'FROM TS_CURRENCY'
      'ORDER BY CURRENCYID')
    ReadOnly = True
    Left = 72
    Top = 200
  end
  object IBCDataSourceCurrency: TIBCDataSource
    DataSet = IBCQueryCurrency
    Left = 128
    Top = 200
  end
end
