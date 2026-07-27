object frmDocTypesActionEditorDlg: TfrmDocTypesActionEditorDlg
  Left = 0
  Top = 0
  ActiveControl = edTITLE
  BorderStyle = bsDialog
  Caption = #1044#1077#1081#1089#1090#1074#1080#1077
  ClientHeight = 279
  ClientWidth = 363
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    363
    279)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 363
    Height = 64
    Title = #1044#1077#1081#1089#1090#1074#1080#1077
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
    ImageIndex = 25
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 347
    Height = 152
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
      Left = 16
      Top = 12
      Width = 52
      Height = 15
      Caption = #1053#1072#1079#1074#1072#1085#1080#1077
    end
    object edTITLE: TcxTextEdit
      Left = 16
      Top = 29
      TabOrder = 0
      Text = #1053#1086#1074#1086#1077' '#1076#1077#1081#1089#1090#1074#1080#1077
      Width = 309
    end
    object cbAccessVisible: TcxCheckBox
      Left = 16
      Top = 101
      Caption = #1055#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1074' '#1076#1077#1088#1077#1074#1077' '#1087#1088#1072#1074
      Properties.Alignment = taLeftJustify
      TabOrder = 1
    end
  end
  object btnOk: TcxButton
    Left = 149
    Top = 235
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = '&Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TcxButton
    Left = 253
    Top = 235
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 3
  end
end
