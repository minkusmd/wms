object frmPriceRulesEditorDlg: TfrmPriceRulesEditorDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Politica de creare a preturilor'
  ClientHeight = 394
  ClientWidth = 509
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  PixelsPerInch = 96
  TextHeight = 15
  object DialogTitle1: TDialogTitle
    Left = 0
    Top = 0
    Width = 509
    Height = 64
    Title = 'Politica de recalcul a preturilor'
    Text = ''
    FontTitle.Charset = DEFAULT_CHARSET
    FontTitle.Color = clWindowText
    FontTitle.Height = -13
    FontTitle.Name = 'Segoe UI'
    FontTitle.Style = [fsBold]
    FontText.Charset = DEFAULT_CHARSET
    FontText.Color = clWindowText
    FontText.Height = -12
    FontText.Name = 'Segoe UI'
    FontText.Style = []
    ImageList = dmAdditions.cxImageList_DialogIcons
    ImageIndex = 4
  end
  object cxButton1: TcxButton
    Left = 152
    Top = 355
    Width = 90
    Height = 29
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object cxButton2: TcxButton
    Left = 264
    Top = 355
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
  object Panel1: TPanel
    Left = 8
    Top = 70
    Width = 493
    Height = 267
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    object cxLabel1: TcxLabel
      Left = 9
      Top = 16
      Caption = 'Grila de pret'
      ParentFont = False
    end
    object seGrilaPret: TcxDBSpinEdit
      Left = 118
      Top = 12
      ParentFont = False
      TabOrder = 0
      Width = 92
    end
    object cxLabel2: TcxLabel
      Left = 9
      Top = 56
      Caption = 'Valoarea minima'
      ParentFont = False
    end
    object ceMinValue: TcxDBCalcEdit
      Left = 118
      Top = 52
      ParentFont = False
      TabOrder = 2
      Width = 92
    end
    object ceMaxValue: TcxDBCalcEdit
      Left = 374
      Top = 52
      ParentFont = False
      TabOrder = 4
      Width = 92
    end
    object cxLabel3: TcxLabel
      Left = 265
      Top = 52
      Caption = 'Valoarea maxima'
      ParentFont = False
    end
    object cxLabel4: TcxLabel
      Left = 9
      Top = 89
      Caption = 'Formula'
      ParentFont = False
    end
    object cxLabel5: TcxLabel
      Left = 9
      Top = 145
      Caption = 'Adaosul minim'
      ParentFont = False
    end
    object ceMinMargin: TcxDBCalcEdit
      Left = 118
      Top = 144
      DataBinding.DataField = 'MIN_MARGIN'
      ParentFont = False
      TabOrder = 9
      Width = 92
    end
    object cxLabel6: TcxLabel
      Left = 9
      Top = 184
      Caption = 'Rotungeste pina la'
      ParentFont = False
    end
    object ceRoundUp: TcxDBCalcEdit
      Left = 118
      Top = 184
      ParentFont = False
      TabOrder = 11
      Width = 92
    end
    object cxLabel7: TcxLabel
      Left = 9
      Top = 224
      Caption = 'Ajustare'
      ParentFont = False
    end
    object ceAdjust: TcxDBCalcEdit
      Left = 118
      Top = 224
      DataBinding.DataField = 'ADJUST'
      ParentFont = False
      TabOrder = 13
      Width = 92
    end
    object teFormula: TcxDBMemo
      Left = 118
      Top = 88
      ParentFont = False
      Properties.VisibleLineCount = 2
      TabOrder = 6
      Width = 347
    end
    object ceMinMarginPercent: TcxDBCalcEdit
      Left = 366
      Top = 144
      DataBinding.DataField = 'MIN_MARGIN_PERCENT'
      ParentFont = False
      TabOrder = 14
      Width = 92
    end
    object cxLabel8: TcxLabel
      Left = 257
      Top = 145
      Caption = 'Adaosul minim %'
      ParentFont = False
    end
  end
end
