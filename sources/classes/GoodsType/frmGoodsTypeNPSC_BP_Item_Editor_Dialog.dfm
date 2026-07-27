object frmGoodsTypeNPSC_BP_Item_Editor_Dlg: TfrmGoodsTypeNPSC_BP_Item_Editor_Dlg
  Left = 0
  Top = 0
  ActiveControl = edPARAM_NAME_RUS
  BorderStyle = bsDialog
  Caption = #1050#1086#1084#1087#1086#1085#1077#1085#1090' '#1080#1079' '#1073#1072#1079#1086#1074#1086#1075#1086' '#1087#1072#1088#1072#1084#1077#1090#1088#1072
  ClientHeight = 265
  ClientWidth = 480
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
    Width = 480
    Height = 64
    Title = #1050#1086#1084#1087#1086#1085#1077#1085#1090' '#1080#1079' '#1073#1072#1079#1086#1074#1086#1075#1086' '#1087#1072#1088#1072#1084#1077#1090#1088#1072
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
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 464
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
    object Label1: TLabel
      Left = 20
      Top = 24
      Width = 118
      Height = 15
      Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1085#1072' '#1088#1091#1089#1089#1082#1086#1084
    end
    object Label2: TLabel
      Left = 20
      Top = 53
      Width = 137
      Height = 15
      Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1085#1072' '#1088#1091#1084#1099#1085#1089#1082#1086#1084
    end
    object Label3: TLabel
      Left = 20
      Top = 82
      Width = 67
      Height = 15
      Caption = #1047#1085#1072#1095#1077#1085#1080#1077'('#1103')'
    end
    object edPARAM_NAME_RUS: TcxDBTextEdit
      Left = 168
      Top = 21
      DataBinding.DataField = 'PARAM_NAME_RUS'
      TabOrder = 0
      Width = 269
    end
    object edPARAM_NAME_ROM: TcxDBTextEdit
      Left = 168
      Top = 50
      DataBinding.DataField = 'PARAM_NAME_ROM'
      TabOrder = 1
      Width = 269
    end
    object edPARAM_VALUE: TcxDBTextEdit
      Left = 168
      Top = 79
      DataBinding.DataField = 'PARAM_VALUE'
      TabOrder = 2
      Width = 269
    end
  end
  object btnOk: TButton
    Left = 270
    Top = 220
    Width = 90
    Height = 29
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 366
    Top = 220
    Width = 90
    Height = 29
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
end
