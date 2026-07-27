object frmGoodsImageEditorDlg: TfrmGoodsImageEditorDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1050#1072#1088#1090#1080#1085#1082#1072' '#1090#1086#1074#1072#1088#1072
  ClientHeight = 513
  ClientWidth = 634
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    634
    513)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 634
    Height = 64
    Title = #1050#1072#1088#1090#1080#1085#1082#1072' '#1090#1086#1074#1072#1088#1072
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
  end
  object cxPageControl1: TcxPageControl
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 618
    Height = 381
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    TabOrder = 1
    Properties.ActivePage = cxTabSheet1
    Properties.CustomButtons.Buttons = <>
    ClientRectBottom = 377
    ClientRectLeft = 4
    ClientRectRight = 614
    ClientRectTop = 26
    object cxTabSheet1: TcxTabSheet
      Caption = #1050#1072#1088#1090#1080#1085#1082#1072
      ImageIndex = 0
      object dxBarDockControl1: TdxBarDockControl
        Left = 0
        Top = 0
        Width = 610
        Height = 30
        Margins.Left = 8
        Margins.Top = 8
        Margins.Right = 8
        Margins.Bottom = 1
        Align = dalTop
        AllowDocking = False
        BarManager = dxBarManager
        SunkenBorder = True
        UseOwnSunkenBorder = True
      end
      object sbScrollBox: TScrollBox
        Left = 0
        Top = 30
        Width = 610
        Height = 298
        HorzScrollBar.Margin = 12
        HorzScrollBar.Smooth = True
        VertScrollBar.Margin = 12
        VertScrollBar.Smooth = True
        Align = alClient
        BevelKind = bkFlat
        BorderStyle = bsNone
        TabOrder = 1
        object imgIMAGE: TcxImage
          Left = 10
          Top = 10
          AutoSize = True
          Properties.GraphicClassName = 'TdxPNGImage'
          Properties.ImmediatePost = True
          Properties.PopupMenuLayout.MenuItems = [pmiCopy, pmiPaste, pmiSave]
          Properties.ShowFocusRect = False
          Properties.OnChange = imgIMAGEPropertiesChange
          TabOrder = 0
          Height = 100
          Width = 140
        end
      end
      object Panel1: TPanel
        Left = 0
        Top = 328
        Width = 610
        Height = 23
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 2
        object lbImageSize: TLabel
          Left = 0
          Top = 0
          Width = 610
          Height = 23
          Align = alClient
          Caption = 'lbImageSize'
          Layout = tlCenter
          ExplicitWidth = 63
          ExplicitHeight = 15
        end
      end
    end
  end
  object btnCancel: TcxButton
    Left = 524
    Top = 468
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
  object btnOk: TcxButton
    Left = 420
    Top = 468
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'Ok'
    ModalResult = 1
    TabOrder = 2
  end
  object dxBarManager: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Default'
      'Tools'
      'Effects')
    Categories.ItemsVisibles = (
      2
      2
      2)
    Categories.Visibles = (
      True
      True
      True)
    ImageOptions.Images = dmAdditions.cxImageList_SWN
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 344
    Top = 20
    PixelsPerInch = 96
    object dxBarManagerBar1: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Image'
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 515
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbOpenImage'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'dxBarButton2'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarSubItem2'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = True
    end
    object bbOpenImage: TdxBarButton
      Caption = #1054#1090#1082#1088#1099#1090#1100
      Category = 0
      Hint = #1054#1090#1082#1088#1099#1090#1100' '#1080#1079' '#1092#1072#1081#1083#1072
      Visible = ivAlways
      ImageIndex = 13
      OnClick = bbOpenImageClick
    end
    object dxBarButton2: TdxBarButton
      Caption = #1042#1089#1090#1072#1074#1080#1090#1100
      Category = 0
      Hint = #1042#1089#1090#1072#1074#1080#1090#1100' '#1080#1079' '#1073#1091#1092#1077#1088#1072
      Visible = ivAlways
      ImageIndex = 24
    end
    object dxBarSubItem2: TdxBarSubItem
      Caption = #1048#1085#1089#1090#1088#1091#1084#1077#1085#1090#1099
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbResizeThumbnail'
        end
        item
          Visible = True
          ItemName = 'bbResizeGallery'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbContrast'
        end>
    end
    object bbResizeThumbnail: TdxBarButton
      Caption = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1088#1072#1079#1084#1077#1088' '#1076#1083#1103' '#1086#1087#1080#1089#1072#1085#1080#1103
      Category = 1
      Hint = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1088#1072#1079#1084#1077#1088' '#1076#1083#1103' '#1086#1087#1080#1089#1072#1085#1080#1103
      Visible = ivAlways
    end
    object bbResizeGallery: TdxBarButton
      Caption = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1088#1072#1079#1084#1077#1088' '#1076#1083#1103' '#1075#1072#1083#1077#1088#1077#1080
      Category = 1
      Hint = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1088#1072#1079#1084#1077#1088' '#1076#1083#1103' '#1075#1072#1083#1077#1088#1077#1080
      Visible = ivAlways
    end
    object bbContrast: TdxBarButton
      Caption = #1059#1074#1077#1083#1080#1095#1080#1090#1100' '#1095#1077#1090#1082#1086#1089#1090#1100
      Category = 1
      Hint = #1059#1074#1077#1083#1080#1095#1080#1090#1100' '#1095#1077#1090#1082#1086#1089#1090#1100
      Visible = ivAlways
    end
  end
end
