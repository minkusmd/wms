object frmZTKImportGoodsDlg: TfrmZTKImportGoodsDlg
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = #1047#1072#1082#1088#1099#1090#1080#1077' '#1090#1086#1074#1072#1088#1072' '#1074' '#1082#1086#1084#1080#1089#1080#1102'. '#1048#1084#1087#1086#1088#1090' '#1090#1086#1074#1072#1088#1086#1074' '#1080#1079' '#1092#1072#1081#1083#1072
  ClientHeight = 659
  ClientWidth = 1039
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 15
  object DialogTitle1: TDialogTitle
    Left = 0
    Top = 0
    Width = 1039
    Height = 64
    Title = #1047#1072#1082#1088#1099#1090#1080#1077' '#1090#1086#1074#1072#1088#1072' '#1074' '#1082#1086#1084#1080#1089#1080#1102'. '#1048#1084#1087#1086#1088#1090' '#1090#1086#1074#1072#1088#1086#1074' '#1080#1079' '#1092#1072#1081#1083#1072
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
    Left = 0
    Top = 64
    Width = 1039
    Height = 526
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 8
    Align = alClient
    BevelOuter = bvNone
    Caption = 'pnClient'
    TabOrder = 3
    object dxBarDockControl1: TdxBarDockControl
      Left = 0
      Top = 0
      Width = 1039
      Height = 32
      Align = dalTop
      BarManager = dxBarManager1
      SunkenBorder = True
      UseOwnSunkenBorder = True
    end
    object cxSpreadSheet: TdxSpreadSheet
      Left = 0
      Top = 32
      Width = 1039
      Height = 494
      Align = alClient
      Data = {
        A802000044585353763242460D00000042465320000000000000000001000101
        010100000000000001004246532000000000424653200200000001000000200B
        00000007000000430061006C0069006200720069000000000000002000000020
        00000000200000000020000000002000000000200007000000470045004E0045
        00520041004C0000000000000200000000000000000101000000200B00000007
        000000430061006C006900620072006900000000000000200000002000000000
        200000000020000000002000000000200007000000470045004E004500520041
        004C000000000000020000000000000000014246532001000000424653201700
        0000540064007800530070007200650061006400530068006500650074005400
        610062006C006500560069006500770006000000530068006500650074003100
        01FFFFFFFFFFFFFFFF6400000002000000020000000200000055000000140000
        0002000000020000000002000000020000000000000100000000000101000042
        4653205500000000000000424653200000000042465320140000000000000042
        4653200000000000000000000000000100000000000000000000000000000000
        0000004246532000000000020200000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000640000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000200020200
        0200000000000000000000000000000000000200000000000000000000000000
        0000000000000000000000000000000000000000000002020000000000000000
        424653200000000000000000}
    end
  end
  object pnButtons: TPanel
    Left = 0
    Top = 598
    Width = 1039
    Height = 61
    Align = alBottom
    BevelOuter = bvNone
    Padding.Top = 16
    Padding.Bottom = 16
    ShowCaption = False
    TabOrder = 5
    object btnCancel: TcxButton
      AlignWithMargins = True
      Left = 929
      Top = 16
      Width = 90
      Height = 29
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 20
      Margins.Bottom = 0
      Align = alRight
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100
      ModalResult = 2
      TabOrder = 0
    end
    object btnImport: TcxButton
      AlignWithMargins = True
      Left = 802
      Top = 16
      Width = 111
      Height = 29
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 16
      Margins.Bottom = 0
      Align = alRight
      Caption = #1048#1084#1087#1086#1088#1090#1080#1088#1086#1074#1072#1090#1100
      TabOrder = 1
      OnClick = btnImportClick
    end
  end
  object dxBarManager1: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Default')
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    ImageOptions.Images = dmAdditions.cxImageList_SWN
    ImageOptions.StretchGlyphs = False
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 588
    Top = 16
    PixelsPerInch = 96
    object dxBarManager1Bar1: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Custom 1'
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1007
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbOpenFile'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbClearAll'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarSubItem1'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarSubItem2'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbCheckGoods'
        end
        item
          BeginGroup = True
          UserDefine = [udWidth]
          UserWidth = 325
          Visible = True
          ItemName = 'beVENDOR'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object bbOpenFile: TdxBarButton
      Caption = #1054#1090#1082#1088#1099#1090#1100' '#1092#1072#1081#1083
      Category = 0
      Hint = #1054#1090#1082#1088#1099#1090#1100' '#1092#1072#1081#1083
      Visible = ivAlways
      ImageIndex = 13
      OnClick = bbOpenFileClick
    end
    object bbClearAll: TdxBarButton
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100
      Category = 0
      Hint = #1054#1095#1080#1089#1090#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 35
      OnClick = bbClearAllClick
    end
    object dxBarSubItem2: TdxBarSubItem
      Caption = #1058#1080#1087' '#1082#1086#1076#1072' '#1090#1086#1074#1072#1088#1072
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbCodeNeuron'
        end
        item
          Visible = True
          ItemName = 'bbCodeVendor'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbGridHeader'
        end>
    end
    object bbCodeNeuron: TdxBarButton
      Caption = #1050#1086#1076' '#1090#1086#1074#1072#1088#1072' '#1080#1079' '#1053#1077#1091#1088#1086#1085#1072
      Category = 0
      Hint = #1050#1086#1076' '#1090#1086#1074#1072#1088#1072' '#1080#1079' '#1053#1077#1091#1088#1086#1085#1072
      Visible = ivAlways
      ButtonStyle = bsChecked
      GroupIndex = 1
    end
    object bbCodeVendor: TdxBarButton
      Caption = #1050#1086#1076' '#1090#1086#1074#1072#1088#1072' '#1087#1086#1089#1090#1072#1074#1097#1080#1082#1072
      Category = 0
      Hint = #1050#1086#1076' '#1090#1086#1074#1072#1088#1072' '#1087#1086#1089#1090#1072#1074#1097#1080#1082#1072
      Visible = ivAlways
      ButtonStyle = bsChecked
      GroupIndex = 1
      Down = True
    end
    object bbCheckGoods: TdxBarButton
      Caption = #1055#1088#1086#1074#1077#1088#1080#1090#1100' '#1090#1086#1074#1072#1088#1099
      Category = 0
      Hint = #1055#1088#1086#1074#1077#1088#1080#1090#1100' '#1090#1086#1074#1072#1088#1099
      Visible = ivAlways
      OnClick = bbCheckGoodsClick
    end
    object bbGridHeader: TdxBarButton
      Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1082#1086#1083#1086#1085#1086#1082
      Category = 0
      Hint = #1053#1072#1079#1074#1072#1085#1080#1077' '#1082#1086#1083#1086#1085#1086#1082
      Visible = ivAlways
      ButtonStyle = bsChecked
      Down = True
    end
    object dxBarSubItem1: TdxBarSubItem
      Caption = #1042#1080#1076
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbShowFormulas'
        end>
    end
    object bbShowFormulas: TdxBarButton
      Caption = #1055#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1092#1086#1088#1084#1091#1083#1099
      Category = 0
      Hint = #1055#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1092#1086#1088#1084#1091#1083#1099
      Visible = ivAlways
      ButtonStyle = bsChecked
      OnClick = bbShowFormulasClick
    end
    object beVENDOR: TcxBarEditItem
      Caption = #1055#1086#1089#1090#1072#1074#1097#1080#1082
      Category = 0
      Hint = #1055#1086#1089#1090#1072#1074#1097#1080#1082
      Visible = ivAlways
      ShowCaption = True
      PropertiesClassName = 'TcxButtonEditProperties'
      Properties.Buttons = <
        item
          ImageIndex = 35
          Hint = #1059#1076#1072#1083#1080#1090#1100' '#1087#1086#1089#1090#1072#1074#1097#1080#1082#1072
          Kind = bkGlyph
        end
        item
          Default = True
          ImageIndex = 13
          Hint = #1042#1099#1073#1088#1072#1090#1100' '#1087#1086#1089#1090#1072#1074#1097#1080#1082#1072
          Kind = bkGlyph
        end>
      Properties.ClickKey = 0
      Properties.Images = dmAdditions.cxImageList_SWN
      Properties.ReadOnly = True
      Properties.ViewStyle = vsHideCursor
      Properties.OnButtonClick = beVENDORPropertiesButtonClick
      InternalEditValue = nil
    end
  end
  object IBCQuery: TIBCQuery
    Connection = dmDB.IBCConnection
    Left = 326
    Top = 214
  end
end
