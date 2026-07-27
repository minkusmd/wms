object frmWebCatalogCopyItemDlg: TfrmWebCatalogCopyItemDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1085#1080#1077' '#1101#1083#1077#1084#1077#1085#1090#1072' '#1082#1072#1090#1072#1083#1086#1075#1072
  ClientHeight = 371
  ClientWidth = 466
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
    Width = 466
    Height = 64
    Title = #1050#1086#1087#1080#1088#1086#1074#1072#1085#1080#1077' '#1101#1083#1077#1084#1077#1085#1090#1072' '#1082#1072#1090#1072#1083#1086#1075#1072
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
    ImageIndex = 7
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 450
    Height = 241
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
      Left = 16
      Top = 16
      Width = 135
      Height = 15
      Caption = #1056#1072#1079#1076#1077#1083' '#1076#1083#1103' '#1082#1086#1087#1080#1088#1086#1074#1072#1085#1080#1103
    end
    object Label2: TLabel
      Left = 16
      Top = 68
      Width = 159
      Height = 15
      Caption = #1050#1091#1076#1072' '#1073#1091#1076#1077#1090' '#1074#1089#1090#1072#1074#1083#1077#1085#1085#1072' '#1082#1086#1087#1080#1103
    end
    object cbCopyGoods: TCheckBox
      Left = 16
      Top = 124
      Width = 141
      Height = 17
      Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1090#1086#1074#1072#1088#1099
      Checked = True
      State = cbChecked
      TabOrder = 0
    end
    object edSourceItem: TEdit
      Left = 16
      Top = 33
      Width = 409
      Height = 23
      TabStop = False
      ReadOnly = True
      TabOrder = 1
    end
    object edTargetParent: TEdit
      Left = 16
      Top = 85
      Width = 409
      Height = 23
      TabStop = False
      ReadOnly = True
      TabOrder = 2
    end
    object cbCopyFilters: TCheckBox
      Left = 16
      Top = 147
      Width = 141
      Height = 17
      Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1092#1080#1083#1100#1090#1088#1099
      Checked = True
      State = cbChecked
      TabOrder = 3
    end
    object cbCopyBanners: TCheckBox
      Left = 16
      Top = 170
      Width = 141
      Height = 17
      Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1073#1072#1085#1085#1077#1088#1099
      Checked = True
      State = cbChecked
      TabOrder = 4
    end
    object cbCopyAlsoBuy: TCheckBox
      Left = 16
      Top = 193
      Width = 277
      Height = 17
      Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100' "'#1057' '#1101#1090#1080#1084' '#1090#1086#1074#1072#1088#1086#1084' '#1090#1072#1082#1078#1077' '#1087#1086#1082#1091#1087#1072#1102#1090'"'
      Checked = True
      State = cbChecked
      TabOrder = 5
    end
  end
  object btnOk: TButton
    Left = 245
    Top = 324
    Width = 90
    Height = 29
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 345
    Top = 324
    Width = 90
    Height = 29
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
end
