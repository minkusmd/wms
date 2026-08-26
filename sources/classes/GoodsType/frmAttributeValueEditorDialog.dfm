object frmAttributeValueEditorDlg: TfrmAttributeValueEditorDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Valoare atribut'
  ClientHeight = 258
  ClientWidth = 494
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    494
    258)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 494
    Height = 64
    Title = 'Valoare atribut'
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
    Height = 130
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    object Label1: TLabel
      Left = 16
      Top = 16
      Width = 55
      Height = 15
      Caption = 'Valoare RO'
    end
    object Label2: TLabel
      Left = 16
      Top = 68
      Width = 55
      Height = 15
      Caption = 'Valoare RU'
    end
    object edVALUE_RO: TcxDBTextEdit
      Left = 16
      Top = 33
      DataBinding.DataField = 'VALUE_RO'
      Properties.MaxLength = 1024
      Properties.ValidateOnEnter = True
      TabOrder = 0
      OnExit = edVALUE_ROExit
      Width = 437
    end
    object edVALUE_RU: TcxDBTextEdit
      Left = 16
      Top = 85
      DataBinding.DataField = 'VALUE_RU'
      Properties.MaxLength = 1024
      Properties.ValidateOnEnter = True
      TabOrder = 1
      Width = 437
    end
  end
  object btnOk: TcxButton
    Left = 280
    Top = 213
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TcxButton
    Left = 376
    Top = 213
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
end
