object frmDiscountDefaultValueDlg: TfrmDiscountDefaultValueDlg
  Left = 0
  Top = 0
  ActiveControl = edValue
  BorderStyle = bsDialog
  Caption = #1057#1082#1080#1076#1082#1072' '#1085#1072' '#1074#1089#1077' '#1090#1086#1074#1072#1088#1099
  ClientHeight = 228
  ClientWidth = 411
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
    Width = 411
    Height = 64
    Title = #1057#1082#1080#1076#1082#1072' '#1085#1072' '#1074#1089#1077' '#1090#1086#1074#1072#1088#1099
    Text = #1059#1082#1072#1078#1080#1090#1077' '#1082#1072#1082#1072#1103' '#1089#1082#1080#1076#1082#1072' '#1073#1091#1076#1077#1090' '#1085#1072' '#1074#1089#1077' '#1076#1086#1073#1072#1074#1083#1077#1085#1085#1099#1077' '#1090#1086#1074#1072#1088#1086#1074
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
    ExplicitLeft = 232
    ExplicitTop = 100
    ExplicitWidth = 0
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 395
    Height = 101
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
    object lbDiscountText: TLabel
      Left = 20
      Top = 20
      Width = 39
      Height = 15
      Caption = #1057#1082#1080#1076#1082#1072
    end
    object edValue: TEdit
      Left = 20
      Top = 37
      Width = 121
      Height = 23
      TabOrder = 0
      Text = 'edValue'
    end
  end
  object btnOk: TButton
    Left = 196
    Top = 184
    Width = 90
    Height = 29
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 300
    Top = 184
    Width = 90
    Height = 29
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
end
