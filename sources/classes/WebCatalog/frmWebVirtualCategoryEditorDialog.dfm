object frmWebVirtualCategoryEditorDlg: TfrmWebVirtualCategoryEditorDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Categorie virtuala'
  ClientHeight = 468
  ClientWidth = 494
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  DesignSize = (
    494
    468)
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 494
    Height = 64
    Title = 'Categorie virtuala'
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
    ImageIndex = 16
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 478
    Height = 340
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 12
      Width = 71
      Height = 15
      Caption = 'Denumire RO'
    end
    object Label2: TLabel
      Left = 16
      Top = 60
      Width = 70
      Height = 15
      Caption = 'Denumire RU'
    end
    object Label3: TLabel
      Left = 16
      Top = 108
      Width = 175
      Height = 15
      Caption = 'Imagine (click dreapta = optiuni)'
    end
    object edNAME_RO: TcxDBTextEdit
      Left = 16
      Top = 29
      DataBinding.DataField = 'NAME_RO'
      Properties.MaxLength = 255
      Properties.ValidateOnEnter = True
      TabOrder = 0
      OnExit = edNAME_ROExit
      Width = 437
    end
    object edNAME_RU: TcxDBTextEdit
      Left = 16
      Top = 77
      DataBinding.DataField = 'NAME_RU'
      Properties.MaxLength = 255
      Properties.ValidateOnEnter = True
      TabOrder = 1
      Width = 437
    end
    object imgIMAGE: TcxDBImage
      Left = 16
      Top = 125
      DataBinding.DataField = 'IMAGE'
      Properties.GraphicClassName = 'TdxSmartImage'
      Properties.ShowFocusRect = False
      TabOrder = 2
      Height = 195
      Width = 437
    end
  end
  object btnOk: TcxButton
    Left = 280
    Top = 427
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancel: TcxButton
    Left = 376
    Top = 427
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 2
  end
end
