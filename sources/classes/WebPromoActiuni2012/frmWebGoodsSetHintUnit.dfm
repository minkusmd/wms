object frmWebGoodsSetHintDlg: TfrmWebGoodsSetHintDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Text imagine produs'
  ClientHeight = 324
  ClientWidth = 452
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object Label1: TLabel
    Left = 8
    Top = 64
    Width = 59
    Height = 15
    Caption = 'Caption Ro'
  end
  object Label2: TLabel
    Left = 8
    Top = 181
    Width = 14
    Height = 15
    Caption = 'Ru'
  end
  object Label3: TLabel
    Left = 8
    Top = 114
    Width = 32
    Height = 15
    Caption = 'Url Ro'
  end
  object Label4: TLabel
    Left = 8
    Top = 228
    Width = 32
    Height = 15
    Caption = 'Url Ru'
  end
  object cxButton1: TcxButton
    Left = 136
    Top = 292
    Width = 90
    Height = 29
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object cxButton2: TcxButton
    Left = 232
    Top = 292
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 4
  end
  object teHintRo: TcxTextEdit
    Left = 8
    Top = 85
    TabOrder = 0
    Width = 436
  end
  object teHintRu: TcxTextEdit
    Left = 8
    Top = 199
    ParentFont = False
    TabOrder = 1
    Width = 436
  end
  object DialogTitle1: TDialogTitle
    Left = 0
    Top = 0
    Width = 452
    Height = 64
    Title = 'Text imagine produs'
    Text = ''
    FontTitle.Charset = DEFAULT_CHARSET
    FontTitle.Color = clWindowText
    FontTitle.Height = -15
    FontTitle.Name = 'Segoe UI'
    FontTitle.Style = [fsBold]
    FontText.Charset = DEFAULT_CHARSET
    FontText.Color = clWindowText
    FontText.Height = -12
    FontText.Name = 'Segoe UI'
    FontText.Style = []
    ImageList = dmAdditions.cxImageList_DialogIcons
    ImageIndex = 30
  end
  object teHintRoUrl: TcxTextEdit
    Left = 8
    Top = 128
    TabOrder = 5
    Text = 'teHintRoUrl'
    Width = 436
  end
  object teHintRuUrl: TcxTextEdit
    Left = 8
    Top = 240
    TabOrder = 6
    Text = 'teHintRoUrl'
    Width = 436
  end
end
