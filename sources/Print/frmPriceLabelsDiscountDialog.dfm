object frmPriceLabelsDiscountDlg: TfrmPriceLabelsDiscountDlg
  Left = 0
  Top = 0
  ActiveControl = edDiscount
  BorderStyle = bsDialog
  Caption = #1057#1082#1080#1076#1082#1072' '#1085#1072' '#1090#1086#1074#1072#1088#1099
  ClientHeight = 233
  ClientWidth = 406
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    406
    233)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 406
    Height = 64
    Title = #1057#1082#1080#1076#1082#1072' '#1085#1072' '#1090#1086#1074#1072#1088#1099
    Text = #1059#1082#1072#1078#1080#1090#1077' '#1078#1077#1083#1072#1077#1084#1091#1102' '#1089#1082#1080#1076#1082#1091' '#1085#1072' '#1074#1099#1073#1088#1072#1085#1085#1099#1077' '#1090#1086#1074#1072#1088#1099
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
    ExplicitTop = -3
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 390
    Height = 107
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
    ShowCaption = False
    TabOrder = 1
    ExplicitLeft = 13
    ExplicitWidth = 360
    ExplicitHeight = 85
    object Label1: TLabel
      Left = 20
      Top = 28
      Width = 39
      Height = 15
      Caption = #1057#1082#1080#1076#1082#1072
    end
    object Label2: TLabel
      Left = 192
      Top = 28
      Width = 10
      Height = 15
      Caption = '%'
    end
    object edDiscount: TEdit
      Left = 65
      Top = 25
      Width = 121
      Height = 23
      TabOrder = 0
    end
    object cbApplyToAll: TCheckBox
      Left = 20
      Top = 64
      Width = 173
      Height = 17
      Caption = #1055#1088#1080#1084#1077#1085#1080#1090#1100' '#1082' '#1074#1089#1077#1084' '#1090#1086#1074#1072#1088#1072#1084
      TabOrder = 1
    end
  end
  object btnOk: TButton
    Left = 190
    Top = 190
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
    ExplicitLeft = 212
    ExplicitTop = 244
  end
  object btnCancel: TButton
    Left = 291
    Top = 190
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
    ExplicitLeft = 313
    ExplicitTop = 244
  end
end
