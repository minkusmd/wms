object frmUMEditorDlg: TfrmUMEditorDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1045#1076#1080#1085#1080#1094#1099' '#1080#1079#1084#1077#1088#1077#1085#1080#1103
  ClientHeight = 266
  ClientWidth = 392
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  DesignSize = (
    392
    266)
  PixelsPerInch = 96
  TextHeight = 13
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 392
    Height = 64
    Title = #1045#1076#1080#1085#1080#1094#1099' '#1080#1079#1084#1077#1088#1077#1085#1080#1103
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
    ImageIndex = 11
  end
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 376
    Height = 146
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
    object lbName: TLabel
      Left = 20
      Top = 27
      Width = 73
      Height = 13
      Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
    end
    object Label3: TLabel
      Left = 20
      Top = 56
      Width = 62
      Height = 13
      Caption = #1050#1086#1101#1092#1080#1094#1080#1077#1085#1090
    end
    object Label4: TLabel
      Left = 20
      Top = 85
      Width = 57
      Height = 13
      Caption = #1053#1072#1079#1074#1072#1085#1080#1077' 2'
    end
    object cxDBTextEdit1: TcxDBTextEdit
      Left = 116
      Top = 24
      DataBinding.DataField = 'TITLE'
      TabOrder = 0
      Width = 185
    end
    object cxDBTextEdit2: TcxDBTextEdit
      Left = 116
      Top = 53
      DataBinding.DataField = 'K_UM'
      TabOrder = 1
      Width = 97
    end
    object cxDBTextEdit3: TcxDBTextEdit
      Left = 116
      Top = 80
      DataBinding.DataField = 'TITLE2'
      TabOrder = 2
      Width = 185
    end
  end
  object btnOk: TButton
    Left = 178
    Top = 229
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = '&Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 286
    Top = 229
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
end
