object frmPriceTypesEditorDlg: TfrmPriceTypesEditorDlg
  Left = 0
  Top = 0
  ActiveControl = teTitle
  BorderStyle = bsDialog
  Caption = 'Modificarea tipului de pret'
  ClientHeight = 211
  ClientWidth = 443
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 15
  object DialogTitle1: TDialogTitle
    Left = 0
    Top = 0
    Width = 443
    Height = 64
    Title = 'Modificarea tipului de pret'
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
    ImageIndex = 28
    ExplicitLeft = 328
    ExplicitTop = 136
    ExplicitWidth = 0
  end
  object cxLabel1: TcxLabel
    Left = 8
    Top = 80
    Caption = 'Cod'
  end
  object tePGT_ID: TcxDBTextEdit
    Left = 80
    Top = 79
    TabOrder = 1
    Width = 73
  end
  object cxLabel2: TcxLabel
    Left = 8
    Top = 117
    Caption = 'Denumire'
  end
  object teTitle: TcxDBTextEdit
    Left = 80
    Top = 116
    TabOrder = 3
    Width = 353
  end
  object cxButton1: TcxButton
    Left = 128
    Top = 172
    Width = 90
    Height = 29
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 5
  end
  object cxButton2: TcxButton
    Left = 240
    Top = 172
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 6
  end
end
