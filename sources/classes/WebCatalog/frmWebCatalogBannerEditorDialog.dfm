object frmWebCatalogBannerEditorDlg: TfrmWebCatalogBannerEditorDlg
  Left = 0
  Top = 0
  ActiveControl = edTITLE
  BorderStyle = bsDialog
  Caption = 'Baner'
  ClientHeight = 562
  ClientWidth = 495
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    495
    562)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 495
    Height = 64
    Title = 'Baner'
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
    ImageIndex = 30
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 479
    Height = 433
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
    object Label1: TLabel
      Left = 20
      Top = 24
      Width = 52
      Height = 15
      Caption = 'Denumire'
    end
    object Label2: TLabel
      Left = 20
      Top = 53
      Width = 34
      Height = 15
      Caption = 'Period'
    end
    object Label4: TLabel
      Left = 20
      Top = 154
      Width = 108
      Height = 15
      Caption = 'Baner RO (1000x160)'
    end
    object Label3: TLabel
      Left = 20
      Top = 228
      Width = 107
      Height = 15
      Caption = 'Baner RU (1000x160)'
    end
    object Label5: TLabel
      Left = 20
      Top = 301
      Width = 41
      Height = 15
      Caption = 'Link RO'
    end
    object Label6: TLabel
      Left = 20
      Top = 351
      Width = 40
      Height = 15
      Caption = 'Link RU'
    end
    object edTITLE: TcxDBTextEdit
      Left = 88
      Top = 21
      DataBinding.DataField = 'TITLE'
      TabOrder = 0
      Width = 377
    end
    object deSTART_DATE: TcxDBDateEdit
      Left = 88
      Top = 50
      DataBinding.DataField = 'START_DATE'
      TabOrder = 1
      Width = 121
    end
    object deEND_DATE: TcxDBDateEdit
      Left = 215
      Top = 50
      DataBinding.DataField = 'END_DATE'
      TabOrder = 2
      Width = 121
    end
    object edBACK_COLOR: TcxDBTextEdit
      Left = 131
      Top = 125
      DataBinding.DataField = 'BACK_COLOR'
      TabOrder = 5
      Width = 62
    end
    object cbFLG_HAS_BACKGROUND: TcxDBCheckBox
      Left = 20
      Top = 96
      Caption = 'Background'
      DataBinding.DataField = 'FLG_HAS_BACKGROUND'
      Properties.Alignment = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ValueChecked = 1
      Properties.ValueUnchecked = 0
      TabOrder = 3
    end
    object cbFLG_BACK_COLOR: TcxDBCheckBox
      Left = 20
      Top = 125
      Caption = 'Doar pretul'
      DataBinding.DataField = 'FLG_BACK_COLOR'
      Properties.Alignment = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ValueChecked = 1
      Properties.ValueUnchecked = 0
      TabOrder = 4
    end
    object imgBACK_IMAGE: TcxDBImage
      Left = 20
      Top = 175
      DataBinding.DataField = 'BACK_IMAGE'
      Properties.GraphicClassName = 'TdxSmartImage'
      Properties.ShowFocusRect = False
      TabOrder = 6
      Height = 46
      Width = 445
    end
    object imgFRONT_IMAGE: TcxDBImage
      Left = 20
      Top = 249
      DataBinding.DataField = 'FRONT_IMAGE'
      Properties.GraphicClassName = 'TdxSmartImage'
      Properties.ShowFocusRect = False
      TabOrder = 7
      Height = 46
      Width = 445
    end
    object edURL: TcxDBTextEdit
      Left = 20
      Top = 322
      DataBinding.DataField = 'URL'
      TabOrder = 8
      Width = 445
    end
    object edURL_RU: TcxDBTextEdit
      Left = 20
      Top = 372
      DataBinding.DataField = 'URL_RU'
      TabOrder = 9
      Width = 445
    end
  end
  object btnOk: TButton
    Left = 286
    Top = 525
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 388
    Top = 525
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
end
