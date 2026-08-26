object frmVouchereCadouEditorDialog: TfrmVouchereCadouEditorDialog
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Editor Vouchere Cadou'
  ClientHeight = 301
  ClientWidth = 634
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 15
  object Panel1: TPanel
    Left = 8
    Top = 24
    Width = 619
    Height = 217
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 0
    object cxLabel1: TcxLabel
      Left = 16
      Top = 25
      Caption = 'Perioada'
      ParentFont = False
    end
    object deData1: TcxDBDateEdit
      Left = 120
      Top = 24
      DataBinding.DataField = 'DATA1'
      ParentFont = False
      TabOrder = 0
      Width = 89
    end
    object deData2: TcxDBDateEdit
      Left = 232
      Top = 24
      DataBinding.DataField = 'DATA2'
      ParentFont = False
      TabOrder = 1
      Width = 97
    end
    object cxLabel2: TcxLabel
      Left = 16
      Top = 60
      Caption = 'Identificator'
      ParentFont = False
    end
    object teCODE: TcxDBTextEdit
      Left = 120
      Top = 59
      DataBinding.DataField = 'CODE'
      ParentFont = False
      TabOrder = 5
      Width = 321
    end
    object cbUsed: TcxDBCheckBox
      Left = 512
      Top = 164
      Caption = 'Este utilizat'
      DataBinding.DataField = 'FLG_USED'
      ParentFont = False
      Properties.ImmediatePost = True
      Properties.ValueChecked = '1'
      Properties.ValueUnchecked = '0'
      Style.TransparentBorder = False
      TabOrder = 15
    end
    object cxLabel3: TcxLabel
      Left = 16
      Top = 100
      Caption = 'Valoarea'
      ParentFont = False
    end
    object ceAmount: TcxDBCalcEdit
      Left = 120
      Top = 99
      DataBinding.DataField = 'AMOUNT'
      ParentFont = False
      TabOrder = 7
      Width = 121
    end
    object teWebDocID: TcxDBTextEdit
      Left = 120
      Top = 164
      DataBinding.DataField = 'USED_IN_WEBDOCID'
      ParentFont = False
      TabOrder = 12
      Width = 97
    end
    object cxLabel4: TcxLabel
      Left = 18
      Top = 168
      Caption = 'Documente'
      ParentFont = False
    end
    object cxLabel5: TcxLabel
      Left = 120
      Top = 139
      Caption = 'Web Order'
      ParentFont = False
    end
    object cxLabel6: TcxLabel
      Left = 232
      Top = 139
      Caption = 'Rezerva'
      ParentFont = False
    end
    object teRezervDocID: TcxDBTextEdit
      Left = 232
      Top = 164
      DataBinding.DataField = 'USED_IN_DOCID'
      ParentFont = False
      TabOrder = 13
      Width = 97
    end
    object cxLabel7: TcxLabel
      Left = 344
      Top = 139
      Caption = 'Balance'
      ParentFont = False
    end
    object teBalanceDocID: TcxDBTextEdit
      Left = 344
      Top = 164
      DataBinding.DataField = 'BALANCE_DOCID'
      ParentFont = False
      TabOrder = 14
      Width = 97
    end
    object cxButton3: TcxButton
      Left = 447
      Top = 58
      Width = 75
      Height = 25
      Caption = 'Genereaza'
      TabOrder = 4
      OnClick = cxButton3Click
    end
    object cbFLG_ACTIVE: TcxDBCheckBox
      Left = 512
      Top = 24
      Caption = 'Activ'
      DataBinding.DataField = 'FLG_ACTIVE'
      ParentFont = False
      Properties.ImmediatePost = True
      Properties.ValueChecked = '1'
      Properties.ValueUnchecked = '0'
      Style.TransparentBorder = False
      TabOrder = 2
    end
  end
  object cxButton1: TcxButton
    Left = 232
    Top = 258
    Width = 90
    Height = 29
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object cxButton2: TcxButton
    Left = 336
    Top = 258
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 2
  end
end
