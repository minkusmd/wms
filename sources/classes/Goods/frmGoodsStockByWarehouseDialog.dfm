object frmGoodsStockByWarehouseDlg: TfrmGoodsStockByWarehouseDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1054#1089#1090#1072#1090#1082#1080' '#1087#1086' '#1089#1082#1083#1072#1076#1072#1084
  ClientHeight = 516
  ClientWidth = 498
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    498
    516)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 498
    Height = 64
    Title = #1054#1089#1090#1072#1090#1082#1080' '#1087#1086' '#1089#1082#1083#1072#1076#1072#1084
    Text = #1054#1089#1090#1072#1090#1082#1080' '#1090#1086#1074#1072#1088#1072' '#1087#1086' '#1074#1089#1077#1084' '#1089#1082#1083#1072#1076#1072#1084
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
    ImageIndex = 15
  end
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 482
    Height = 389
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 0
    Align = alTop
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    object Label1: TLabel
      Left = 8
      Top = 12
      Width = 20
      Height = 15
      Caption = #1050#1086#1076
    end
    object Label2: TLabel
      Left = 63
      Top = 12
      Width = 32
      Height = 15
      Caption = #1058#1086#1074#1072#1088
    end
    object Bevel1: TBevel
      Left = 0
      Top = 0
      Width = 478
      Height = 81
      Align = alTop
      Shape = bsSpacer
    end
    object edGOODSID: TcxDBTextEdit
      Left = 8
      Top = 28
      TabStop = False
      DataBinding.DataField = 'GOODSID'
      Properties.ReadOnly = True
      TabOrder = 0
      Width = 49
    end
    object mmTITLE: TcxDBMemo
      Left = 63
      Top = 28
      TabStop = False
      DataBinding.DataField = 'TITLE'
      Properties.ReadOnly = True
      Properties.ScrollBars = ssVertical
      Properties.VisibleLineCount = 2
      TabOrder = 1
      Width = 407
    end
    inline frameGoodsStock: TframeGoodsStock
      AlignWithMargins = True
      Left = 8
      Top = 81
      Width = 462
      Height = 264
      Margins.Left = 8
      Margins.Top = 0
      Margins.Right = 8
      Margins.Bottom = 8
      Align = alTop
      TabOrder = 2
      ExplicitLeft = 8
      ExplicitTop = 81
      ExplicitWidth = 462
      ExplicitHeight = 264
      inherited cxTree: TcxTreeList
        Width = 462
        Height = 264
        OptionsView.ScrollBars = ssVertical
        TabStop = False
        ExplicitWidth = 462
        ExplicitHeight = 264
      end
    end
    object cbShowExistingOnly: TCheckBox
      Left = 8
      Top = 356
      Width = 462
      Height = 17
      Caption = #1055#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1090#1086#1083#1100#1082#1086' '#1089#1082#1083#1072#1076#1099' '#1075#1076#1077' '#1089#1091#1097#1077#1089#1090#1074#1091#1077#1090' '#1090#1086#1074#1072#1088
      TabOrder = 3
    end
  end
  object btnClose: TcxButton
    Left = 388
    Top = 473
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1047#1072#1082#1088#1099#1090#1100
    ModalResult = 2
    TabOrder = 2
  end
end
