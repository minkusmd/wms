object frmStockFolderEditorDlg: TfrmStockFolderEditorDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1055#1072#1087#1082#1072
  ClientHeight = 307
  ClientWidth = 379
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    379
    307)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 379
    Height = 64
    Title = #1055#1072#1087#1082#1072
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
    Width = 363
    Height = 174
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
    object cxLabel1: TLabel
      Left = 12
      Top = 16
      Width = 88
      Height = 15
      Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1087#1072#1087#1082#1080
    end
    object edTITLE: TcxDBTextEdit
      Left = 12
      Top = 33
      DataBinding.DataField = 'TITLE'
      Properties.MaxLength = 255
      Properties.ValidateOnEnter = True
      TabOrder = 0
      Width = 329
    end
    object cbFLG_VISISIBLE_FOR_SALE: TcxDBCheckBox
      Left = 12
      Top = 72
      Caption = #1057#1082#1083#1072#1076#1099' '#1074#1080#1076#1085#1099' '#1076#1083#1103' '#1087#1088#1086#1076#1072#1078
      DataBinding.DataField = 'FLG_VISISIBLE_FOR_SALE'
      Properties.Alignment = taLeftJustify
      Properties.ValueChecked = 1
      Properties.ValueUnchecked = 0
      TabOrder = 1
    end
    object cbFLG_ADMINISTRATIA: TcxDBCheckBox
      Left = 12
      Top = 101
      Caption = #1057#1082#1083#1072#1076#1099' '#1074#1080#1076#1085#1099' '#1076#1083#1103' '#1072#1076#1084#1080#1085#1080#1089#1090#1088#1072#1094#1080#1080
      DataBinding.DataField = 'FLG_ADMINISTRATIA'
      Properties.Alignment = taLeftJustify
      Properties.ValueChecked = 1
      Properties.ValueUnchecked = 0
      TabOrder = 2
    end
    object cbFLG_RMA: TcxDBCheckBox
      Left = 12
      Top = 130
      Caption = #1057#1082#1083#1072#1076#1099' '#1074#1080#1076#1085#1099' '#1076#1083#1103' '#1088#1077#1084#1086#1085#1090#1072
      DataBinding.DataField = 'FLG_RMA'
      Properties.Alignment = taLeftJustify
      Properties.ValueChecked = 1
      Properties.ValueUnchecked = 0
      TabOrder = 3
    end
  end
  object btnOk: TcxButton
    Left = 167
    Top = 261
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = '&Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TcxButton
    Left = 271
    Top = 261
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
end
