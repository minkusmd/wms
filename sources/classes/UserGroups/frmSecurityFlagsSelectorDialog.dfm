object frmSecurityFlagsSelectorDlg: TfrmSecurityFlagsSelectorDlg
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #1060#1083#1072#1075#1080' '#1076#1086#1089#1090#1091#1087#1072
  ClientHeight = 627
  ClientWidth = 455
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    455
    627)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 455
    Height = 64
    Title = #1060#1083#1072#1075#1080' '#1076#1086#1089#1090#1091#1087#1072
    Text = #1042#1099#1073#1077#1088#1080#1090#1077' '#1086#1073#1097#1080#1077' '#1092#1083#1072#1075#1080' '#1076#1086#1089#1090#1091#1087#1072' '#1076#1083#1103' '#1074#1089#1077#1093' '#1075#1088#1091#1087#1087' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1077#1081
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
    ImageIndex = 12
  end
  object btnCancel: TButton
    Left = 345
    Top = 582
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 3
  end
  object btnOk: TButton
    Left = 243
    Top = 582
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = '&OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 439
    Height = 499
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    ShowCaption = False
    TabOrder = 1
    object Label1: TLabel
      Left = 16
      Top = 12
      Width = 36
      Height = 15
      Caption = #1071' '#1093#1086#1095#1091
    end
    object Tree: TRzCheckTree
      AlignWithMargins = True
      Left = 8
      Top = 72
      Width = 419
      Height = 415
      Margins.Left = 8
      Margins.Top = 8
      Margins.Right = 8
      Margins.Bottom = 8
      Images = dmAdditions.cxImageList_SWN
      Align = alBottom
      HideSelection = False
      Indent = 21
      PopupMenu = pmAccess
      SelectionPen.Color = clBtnShadow
      StateImages = Tree.CheckImages
      TabOrder = 2
    end
    object rbSetValue: TRadioButton
      Left = 70
      Top = 12
      Width = 355
      Height = 17
      Caption = #1091#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1074#1099#1073#1088#1072#1085#1085#1099#1077' '#1092#1083#1072#1075#1080' '#1076#1083#1103' '#1074#1089#1077#1093' '#1075#1088#1091#1087#1087' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1077#1081
      TabOrder = 0
    end
    object rbClearValue: TRadioButton
      Left = 70
      Top = 35
      Width = 171
      Height = 17
      Caption = #1091#1076#1072#1083#1080#1090#1100' '#1074#1099#1073#1088#1072#1085#1085#1099#1077' '#1092#1083#1072#1075#1080
      TabOrder = 1
    end
  end
  object pmAccess: TPopupMenu
    Images = dmAdditions.cxImageList_SWN
    Left = 524
    Top = 216
    object miSetSelected: TMenuItem
      Caption = #1042#1099#1073#1088#1072#1090#1100
    end
    object miClearSelected: TMenuItem
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100
      ImageIndex = 35
      OnClick = miClearSelectedClick
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object miSelectAll: TMenuItem
      Caption = #1042#1099#1073#1088#1072#1090#1100' '#1074#1089#1077
      ImageIndex = 25
    end
    object miClearAll: TMenuItem
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100' '#1074#1089#1077
      ImageIndex = 35
    end
  end
end
