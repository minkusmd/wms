object frmLoanEditorDlg: TfrmLoanEditorDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Editarea creditelor'
  ClientHeight = 329
  ClientWidth = 586
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 15
  object Label21: TLabel
    Left = 9
    Top = 88
    Width = 165
    Height = 15
    Caption = 'Grupa de produse pentru credit'
  end
  object teTitle: TcxDBTextEdit
    Left = 77
    Top = 27
    TabOrder = 0
    Width = 500
  end
  object ceMonths: TcxDBCalcEdit
    Left = 77
    Top = 56
    TabOrder = 1
    Width = 44
  end
  object cxLabel1: TcxLabel
    Left = 9
    Top = 24
    Caption = 'Denumirea'
  end
  object cxLabel2: TcxLabel
    Left = 8
    Top = 49
    Caption = 'Nr de luni'
  end
  object cxGroupBox1: TcxGroupBox
    Left = 8
    Top = 145
    Caption = 'Platile cumparatorului'
    TabOrder = 4
    Height = 128
    Width = 297
    object cxLabel3: TcxLabel
      Left = 19
      Top = 23
      Caption = 'Suma achitata'
    end
    object ceSuma: TcxDBCalcEdit
      Left = 171
      Top = 22
      TabOrder = 1
      Width = 94
    end
    object ceAvansSuma: TcxDBCalcEdit
      Left = 171
      Top = 49
      TabOrder = 2
      Width = 94
    end
    object cxLabel4: TcxLabel
      Left = 19
      Top = 46
      Caption = 'Avansul obligatoriu, (suma)'
    end
    object cxLabel5: TcxLabel
      Left = 19
      Top = 69
      Caption = 'Avansul obligatoriu, (%)'
    end
    object ceAvansProcent: TcxDBCalcEdit
      Left = 171
      Top = 72
      TabOrder = 5
      Width = 94
    end
    object cxLabel6: TcxLabel
      Left = 19
      Top = 96
      Caption = 'Comisonul lunar (%)'
    end
    object ceComsion: TcxDBCalcEdit
      Left = 171
      Top = 99
      TabOrder = 7
      Width = 94
    end
  end
  object cxGroupBox2: TcxGroupBox
    Left = 311
    Top = 145
    Caption = 'Platile companiei'
    TabOrder = 5
    Height = 128
    Width = 266
    object cxLabel7: TcxLabel
      Left = 10
      Top = 22
      Caption = 'Avansul obligatoriu, (%)'
    end
    object ceAvantCompanieProcent: TcxDBCalcEdit
      Left = 147
      Top = 21
      TabOrder = 1
      Width = 62
    end
    object cxLabel8: TcxLabel
      Left = 11
      Top = 62
      Caption = 'Iconita peste produs'
    end
    object IconImage: TcxDBImage
      Left = 144
      Top = 50
      TabOrder = 3
      Height = 67
      Width = 97
    end
    object cxLabel9: TcxLabel
      Left = 27
      Top = 77
      Caption = '(64x64) px'
    end
  end
  object cxButton1: TcxButton
    Left = 396
    Top = 296
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 6
  end
  object cxButton2: TcxButton
    Left = 477
    Top = 296
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 7
  end
  object bePROMO_GOODS_GROUP_ID: TcxButtonEdit
    Left = 9
    Top = 105
    Properties.Buttons = <
      item
        Default = True
        ImageIndex = 13
        Kind = bkGlyph
      end
      item
        ImageIndex = 35
        Kind = bkGlyph
      end>
    Properties.ClickKey = 115
    Properties.Images = dmAdditions.cxImageList_SWN
    Properties.ViewStyle = vsHideCursor
    Properties.OnButtonClick = bePROMO_GOODS_GROUP_IDPropertiesButtonClick
    Style.TextColor = clNavy
    TabOrder = 8
    Width = 489
  end
end
