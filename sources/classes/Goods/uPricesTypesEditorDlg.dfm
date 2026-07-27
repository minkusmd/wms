object frmPricesTypesEditorDlg: TfrmPricesTypesEditorDlg
  Left = 0
  Top = 0
  Margins.Left = 4
  Margins.Top = 4
  Margins.Right = 4
  Margins.Bottom = 4
  BorderStyle = bsDialog
  Caption = 'Tip de preturi'
  ClientHeight = 445
  ClientWidth = 740
  Color = clBtnFace
  DefaultMonitor = dmMainForm
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  PixelsPerInch = 120
  TextHeight = 20
  object cxLabel1: TcxLabel
    Left = 10
    Top = 26
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Cod'
    TabOrder = 0
  end
  object teID: TcxDBTextEdit
    Left = 133
    Top = 25
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    DataBinding.DataField = 'ID'
    TabOrder = 1
    Width = 106
  end
  object cxLabel2: TcxLabel
    Left = 256
    Top = 26
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Denumire'
    TabOrder = 2
  end
  object teName: TcxDBTextEdit
    Left = 334
    Top = 25
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    DataBinding.DataField = 'Name'
    TabOrder = 3
    Width = 364
  end
  object cxLabel3: TcxLabel
    Left = 10
    Top = 86
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Valuta'
    TabOrder = 4
  end
  object cbCurrency: TcxDBLookupComboBox
    Left = 133
    Top = 85
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    DataBinding.DataField = 'CURRENCYID'
    Properties.KeyFieldNames = 'CurrencyID'
    Properties.ListColumns = <>
    TabOrder = 5
    Width = 125
  end
  object cxLabel4: TcxLabel
    Left = 289
    Top = 86
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'TVA'
    TabOrder = 6
  end
  object cbVAT: TcxDBLookupComboBox
    Left = 328
    Top = 85
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    DataBinding.DataField = 'VAT'
    Properties.KeyFieldNames = 'CurrencyID'
    Properties.ListColumns = <>
    TabOrder = 7
    Width = 125
  end
  object cxLabel5: TcxLabel
    Left = 10
    Top = 146
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Tip de preturi'
    TabOrder = 8
  end
  object cbPricesTypes: TcxDBLookupComboBox
    Left = 133
    Top = 145
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    DataBinding.DataField = 'PRICE_TYPE'
    Properties.KeyFieldNames = 'CurrencyID'
    Properties.ListColumns = <>
    TabOrder = 9
    Width = 317
  end
  object cxLabel6: TcxLabel
    Left = 10
    Top = 188
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    AutoSize = False
    Caption = 'Modalitatea de calcul a preturilor'
    Properties.WordWrap = True
    TabOrder = 10
    Height = 58
    Width = 121
  end
  object cbCalcMethod: TcxDBLookupComboBox
    Left = 133
    Top = 195
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    DataBinding.DataField = 'PRICEING_METHOD'
    Properties.KeyFieldNames = 'CurrencyID'
    Properties.ListColumns = <>
    TabOrder = 11
    Width = 317
  end
  object cxLabel7: TcxLabel
    Left = 10
    Top = 246
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Preturile de baza'
    TabOrder = 12
  end
  object cbBasicPricesType: TcxDBLookupComboBox
    Left = 133
    Top = 245
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    DataBinding.DataField = 'BASIC_PRICE_TYPE'
    Properties.KeyFieldNames = 'CurrencyID'
    Properties.ListColumns = <>
    TabOrder = 13
    Width = 317
  end
  object cxLabel8: TcxLabel
    Left = 516
    Top = 246
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    AutoSize = False
    Caption = 'Margine in %'
    Properties.Alignment.Horz = taRightJustify
    TabOrder = 14
    Height = 24
    Width = 93
    AnchorX = 609
  end
  object ceMargin: TcxDBCalcEdit
    Left = 616
    Top = 245
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    DataBinding.DataField = 'MARGIN'
    TabOrder = 15
    Width = 82
  end
  object cxLabel9: TcxLabel
    Left = 10
    Top = 316
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Metoda rotungirii'
    TabOrder = 16
  end
  object cbRoundingMethod: TcxDBLookupComboBox
    Left = 133
    Top = 315
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    DataBinding.DataField = 'ROUNDING_METHOD'
    Properties.KeyFieldNames = 'CurrencyID'
    Properties.ListColumns = <>
    TabOrder = 17
    Width = 317
  end
  object cxLabel10: TcxLabel
    Left = 481
    Top = 316
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    AutoSize = False
    Caption = 'Rotungeste pina la'
    Properties.Alignment.Horz = taRightJustify
    TabOrder = 18
    Height = 24
    Width = 128
    AnchorX = 609
  end
  object ceRound: TcxDBCalcEdit
    Left = 616
    Top = 315
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    DataBinding.DataField = 'ROUNDING'
    TabOrder = 19
    Width = 82
  end
  object btnOK: TcxButton
    Left = 503
    Top = 400
    Width = 93
    Height = 31
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'OK'
    Default = True
    ModalResult = 1
    OptionsImage.Spacing = 5
    TabOrder = 20
  end
  object btnCancel: TcxButton
    Left = 604
    Top = 400
    Width = 94
    Height = 31
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    OptionsImage.Spacing = 5
    TabOrder = 21
  end
end
