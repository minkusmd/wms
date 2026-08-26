object frmSupplierPromoEditorDlg: TfrmSupplierPromoEditorDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Promotii furnizori'
  ClientHeight = 441
  ClientWidth = 560
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    560
    441)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 560
    Height = 64
    Title = 'Promotii furnizori'
    Text = 'Gestiunea promotiilor de la furnizori'
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
    ImageIndex = 28
  end
  object pcPageControl: TcxPageControl
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 544
    Height = 305
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    TabOrder = 1
    Properties.ActivePage = tbsGeneral
    Properties.CustomButtons.Buttons = <>
    ClientRectBottom = 301
    ClientRectLeft = 4
    ClientRectRight = 540
    ClientRectTop = 26
    object tbsGeneral: TcxTabSheet
      Caption = 'Promotie'
      ImageIndex = 0
      ExplicitHeight = 243
      object Label1: TLabel
        Left = 24
        Top = 84
        Width = 56
        Height = 15
        Caption = 'Denumire'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label3: TLabel
        Left = 24
        Top = 14
        Width = 91
        Height = 15
        Caption = 'Perioada actiunii'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label21: TLabel
        Left = 23
        Top = 140
        Width = 163
        Height = 15
        Caption = 'Lista produselor din promotie'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label22: TLabel
        Left = 23
        Top = 193
        Width = 243
        Height = 13
        Caption = 'Selectatii o grupa de produse afiliate promotiei'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGrayText
        Font.Height = -11
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object Label2: TLabel
        Left = 23
        Top = 212
        Width = 46
        Height = 15
        Caption = 'Furnizor'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object deSTART_DATE: TcxDBDateEdit
        Left = 24
        Top = 35
        DataBinding.DataField = 'DATA1'
        Properties.DateButtons = [btnToday]
        Properties.SaveTime = False
        Properties.ShowTime = False
        Properties.WeekNumbers = True
        TabOrder = 0
        Width = 121
      end
      object edTITLE: TcxDBTextEdit
        Left = 24
        Top = 101
        DataBinding.DataField = 'TITLE'
        TabOrder = 2
        Width = 489
      end
      object deEND_DATE: TcxDBDateEdit
        Left = 168
        Top = 35
        DataBinding.DataField = 'DATA2'
        Properties.DateButtons = [btnToday]
        Properties.SaveTime = False
        Properties.ShowTime = False
        Properties.WeekNumbers = True
        TabOrder = 1
        Width = 121
      end
      object bePROMO_GOODS_GROUP_ID: TcxButtonEdit
        Left = 23
        Top = 161
        Properties.Buttons = <
          item
            Default = True
            ImageIndex = 13
            Kind = bkGlyph
          end
          item
            ImageIndex = 35
            Kind = bkGlyph
          end>
        Properties.ClickKey = 115
        Properties.Images = dmAdditions.cxImageList_SWN
        Properties.ViewStyle = vsHideCursor
        Properties.OnButtonClick = bePROMO_GOODS_GROUP_IDPropertiesButtonClick
        Style.TextColor = clNavy
        TabOrder = 3
        Width = 489
      end
      object beCT: TcxButtonEdit
        Left = 23
        Top = 233
        Properties.Buttons = <
          item
            Default = True
            ImageIndex = 13
            Kind = bkGlyph
          end
          item
            ImageIndex = 35
            Kind = bkGlyph
          end>
        Properties.ClickKey = 115
        Properties.Images = dmAdditions.cxImageList_SWN
        Properties.ViewStyle = vsHideCursor
        Properties.OnButtonClick = cxButtonEdit1PropertiesButtonClick
        Style.TextColor = clNavy
        TabOrder = 4
        Width = 489
      end
    end
  end
  object btnOk: TButton
    Left = 179
    Top = 401
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 5
    ExplicitTop = 361
  end
  object Button2: TButton
    Left = 283
    Top = 401
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 6
    ExplicitTop = 361
  end
  object dxBarManager1: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Default'
      #1054#1090#1076#1077#1083#1100#1085#1072#1103' '#1089#1082#1080#1076#1082#1072' '#1085#1072' '#1082#1072#1078#1076#1099#1081' '#1090#1086#1074#1072#1088)
    Categories.ItemsVisibles = (
      2
      2)
    Categories.Visibles = (
      True
      True)
    ImageOptions.Images = dmAdditions.cxImageList_SWN
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 216
    Top = 16
    PixelsPerInch = 96
    object dxBarManager1Bar1: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      BorderStyle = bbsNone
      Caption = 'Custom 1'
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 0
      DockedTop = 0
      DockingStyle = dsTop
      FloatLeft = 1221
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbNewDiscountRange'
        end
        item
          Visible = True
          ItemName = 'bbDeleteDiscountRange'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = False
      WholeRow = False
    end
    object dxBarManager1Bar2: TdxBar
      Caption = 'Reduceri'
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 0
      DockedTop = 0
      DockingStyle = dsTop
      FloatLeft = 1221
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbNewGoods'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbDelete'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = False
      WholeRow = False
    end
    object bbNewGoods: TdxBarButton
      Caption = 'Adauga produs'
      Category = 0
      Hint = 'Adauga produs'
      Visible = ivAlways
      ImageIndex = 40
    end
    object bbDelete: TdxBarButton
      Caption = 'Sterge produs'
      Category = 0
      Hint = 'Sterge produs'
      Visible = ivAlways
      ImageIndex = 42
    end
    object bbNewDiscountRange: TdxBarButton
      Caption = 'Adauga'
      Category = 1
      Hint = 'Adauga'
      Visible = ivAlways
      ImageIndex = 40
    end
    object bbDeleteDiscountRange: TdxBarButton
      Caption = 'Sterge'
      Category = 1
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
    end
  end
end
