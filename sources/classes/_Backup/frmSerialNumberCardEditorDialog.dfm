object frmSerialNumberCardEditorDlg: TfrmSerialNumberCardEditorDlg
  Left = 0
  Top = 0
  ActiveControl = edSN
  BorderStyle = bsDialog
  Caption = #1057#1077#1088#1080#1081#1085#1099#1081' '#1085#1086#1084#1077#1088' '#1082#1072#1088#1090#1086#1095#1082#1080
  ClientHeight = 266
  ClientWidth = 361
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 361
    Height = 64
    Title = #1057#1077#1088#1080#1081#1085#1099#1081' '#1085#1086#1084#1077#1088' '#1082#1072#1088#1090#1086#1095#1082#1080
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
    ImageIndex = 17
  end
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 345
    Height = 137
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
      Top = 19
      Width = 151
      Height = 15
      Caption = #1057#1077#1088#1080#1081#1085#1099#1081' '#1085#1086#1084#1077#1088' '#1082#1072#1088#1090#1086#1095#1082#1080
      Transparent = True
    end
    object cxLabel2: TLabel
      Left = 12
      Top = 61
      Width = 70
      Height = 15
      Caption = #1050#1086#1083#1086#1085#1082#1072' '#1094#1077#1085
      Transparent = True
    end
    object cxLabel3: TLabel
      Left = 12
      Top = 89
      Width = 102
      Height = 15
      Caption = #1057#1082#1080#1076#1082#1072' '#1089#1077#1088#1074#1080#1089#1072', %'
      Transparent = True
    end
    object edSERVICEDISCOUNT: TcxDBMaskEdit
      Left = 173
      Top = 86
      DataBinding.DataField = 'SERVICEDISCOUNT'
      Properties.Alignment.Horz = taLeftJustify
      Properties.MaskKind = emkRegExpr
      Properties.EditMask = '\d+'
      Properties.MaxLength = 0
      TabOrder = 2
      Width = 91
    end
    object edSN: TcxDBMaskEdit
      Left = 173
      Top = 16
      DataBinding.DataField = 'SN'
      Properties.CharCase = ecUpperCase
      TabOrder = 0
      Width = 152
    end
    object cbPRICECOLUMN: TcxDBComboBox
      Left = 173
      Top = 57
      DataBinding.DataField = 'PRICECOLUMN'
      Properties.Alignment.Horz = taLeftJustify
      Properties.DropDownListStyle = lsFixedList
      TabOrder = 1
      Width = 91
    end
  end
  object btnOk: TButton
    Left = 149
    Top = 223
    Width = 90
    Height = 29
    Caption = '&Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 253
    Top = 223
    Width = 90
    Height = 29
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
end
