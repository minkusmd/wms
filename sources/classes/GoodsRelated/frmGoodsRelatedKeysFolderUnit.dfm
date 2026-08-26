object frmGoodsRelatedKeysFolderDlg: TfrmGoodsRelatedKeysFolderDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Mapa'
  ClientHeight = 260
  ClientWidth = 489
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 489
    Height = 64
    Title = 'Mapa'
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
    ImageIndex = 0
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 473
    Height = 140
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    object cxLabel1: TLabel
      Left = 12
      Top = 72
      Width = 85
      Height = 15
      Caption = 'Denumire mapa'
    end
    object Label1: TLabel
      Left = 12
      Top = 16
      Width = 11
      Height = 15
      Caption = 'ID'
    end
    object edTITLE: TcxDBTextEdit
      Left = 12
      Top = 90
      DataBinding.DataField = 'TITLE'
      Properties.MaxLength = 255
      TabOrder = 1
      Width = 444
    end
    object edKey: TcxDBTextEdit
      Left = 12
      Top = 34
      DataBinding.DataField = 'RELATED_KEY'
      Properties.MaxLength = 255
      TabOrder = 0
      Width = 444
    end
  end
  object btnOk: TcxButton
    Left = 272
    Top = 223
    Width = 90
    Height = 29
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TcxButton
    Left = 376
    Top = 223
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
end
