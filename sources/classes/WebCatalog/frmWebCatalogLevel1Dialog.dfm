object frmWebCatalogLevel1Dlg: TfrmWebCatalogLevel1Dlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Web Catalog - Nivelul 1'
  ClientHeight = 528
  ClientWidth = 548
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnShow = FormShow
  DesignSize = (
    548
    528)
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 548
    Height = 64
    Title = 'Web Catalog - Nivelul 1'
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
    ImageIndex = 23
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 532
    Height = 400
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    ShowCaption = False
    TabOrder = 1
    OnDblClick = pnClientDblClick
    object Label1: TLabel
      Left = 16
      Top = 48
      Width = 94
      Height = 15
      Caption = 'Denumirea mapei'
    end
    object Label2: TLabel
      Left = 16
      Top = 69
      Width = 88
      Height = 15
      Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1087#1072#1087#1082#1080
    end
    object Label3: TLabel
      Left = 16
      Top = 103
      Width = 88
      Height = 34
      AutoSize = False
      Caption = 'Menu icon (25x20)px'
      WordWrap = True
    end
    object Label4: TLabel
      Left = 16
      Top = 285
      Width = 42
      Height = 15
      Caption = 'URL_RO'
    end
    object Label5: TLabel
      Left = 14
      Top = 314
      Width = 41
      Height = 15
      Caption = 'URL_RU'
    end
    object Label6: TLabel
      Left = 17
      Top = 354
      Width = 47
      Height = 15
      Caption = 'Order no'
    end
    object edTITLE: TcxDBTextEdit
      Left = 116
      Top = 45
      DataBinding.DataField = 'TITLE'
      ParentFont = False
      TabOrder = 4
      Width = 392
    end
    object edTITLE_RUS: TcxDBTextEdit
      Left = 116
      Top = 74
      DataBinding.DataField = 'TITLE_RUS'
      ParentFont = False
      TabOrder = 5
      Width = 392
    end
    object cbFLG_ENABLED: TcxDBCheckBox
      Left = 412
      Top = 8
      Caption = 'Categorie activa'
      DataBinding.DataField = 'FLG_ENABLED'
      ParentFont = False
      Properties.Alignment = taLeftJustify
      Properties.NullStyle = nssInactive
      Properties.ValueChecked = 1
      Properties.ValueUnchecked = 0
      TabOrder = 3
    end
    object ImgCatalog: TcxDBImage
      Left = 116
      Top = 103
      DataBinding.DataField = 'IMAGE'
      Properties.GraphicClassName = 'TdxSmartImage'
      TabOrder = 6
      Height = 57
      Width = 73
    end
    object cbFLG_PROMO: TcxDBCheckBox
      Left = 16
      Top = 8
      Caption = 'Promo'
      DataBinding.DataField = 'FLG_PROMO'
      ParentFont = False
      Properties.Alignment = taLeftJustify
      Properties.NullStyle = nssInactive
      Properties.ValueChecked = 1
      Properties.ValueUnchecked = 0
      TabOrder = 0
    end
    object cbFLG_NEW: TcxDBCheckBox
      Left = 152
      Top = 8
      AutoSize = False
      Caption = 'New'
      DataBinding.DataField = 'FLG_NEW'
      ParentFont = False
      Properties.Alignment = taLeftJustify
      Properties.NullStyle = nssInactive
      Properties.ValueChecked = 1
      Properties.ValueUnchecked = 0
      Style.HotTrack = True
      TabOrder = 1
      Height = 23
      Width = 46
    end
    object cbFLG_POPULAR: TcxDBCheckBox
      Left = 275
      Top = 8
      AutoSize = False
      Caption = 'Popular'
      DataBinding.DataField = 'FLG_POPULAR'
      ParentFont = False
      Properties.Alignment = taLeftJustify
      Properties.NullStyle = nssInactive
      Properties.ValueChecked = 1
      Properties.ValueUnchecked = 0
      Style.HotTrack = True
      Style.TransparentBorder = False
      TabOrder = 2
      Height = 23
      Width = 59
    end
    object teURL_RO: TcxDBTextEdit
      Left = 116
      Top = 282
      DataBinding.DataField = 'URL_RO'
      ParentFont = False
      TabOrder = 8
      Width = 392
    end
    object teURL_RU: TcxDBTextEdit
      Left = 116
      Top = 311
      DataBinding.DataField = 'URL_RU'
      ParentFont = False
      TabOrder = 9
      Width = 392
    end
    object BigImage: TcxDBImage
      Left = 195
      Top = 103
      DataBinding.DataField = 'BIG_IMAGE'
      Properties.GraphicClassName = 'TdxPNGImage'
      TabOrder = 7
      Height = 173
      Width = 313
    end
    object ceOrderNo: TcxDBCalcEdit
      Left = 116
      Top = 352
      DataBinding.DataField = 'ORDERNO'
      TabOrder = 10
      Width = 93
    end
  end
  object btnOk: TButton
    Left = 339
    Top = 483
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 439
    Top = 483
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
end
