object frmPromoCodesEditorDlg: TfrmPromoCodesEditorDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Promo coduri'
  ClientHeight = 602
  ClientWidth = 797
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  DesignSize = (
    797
    602)
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 797
    Height = 64
    Title = 'Promo coduri'
    Text = 'Gestiunea promo codurilor'
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
    ImageIndex = 49
  end
  object pcPageControl: TcxPageControl
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 781
    Height = 481
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    TabOrder = 1
    Properties.ActivePage = tbsGeneral
    Properties.CustomButtons.Buttons = <>
    ClientRectBottom = 477
    ClientRectLeft = 4
    ClientRectRight = 777
    ClientRectTop = 26
    object tbsGeneral: TcxTabSheet
      Caption = 'Promotie'
      ImageIndex = 0
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label1: TLabel
        Left = 16
        Top = 36
        Width = 52
        Height = 15
        Caption = 'Denumire'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object Label3: TLabel
        Left = 514
        Top = 96
        Width = 50
        Height = 15
        Caption = 'Inceputul'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object Label21: TLabel
        Left = 16
        Top = 96
        Width = 156
        Height = 15
        Caption = 'Lista produselor din promotie'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object Label22: TLabel
        Left = 15
        Top = 146
        Width = 447
        Height = 13
        Caption = 
          #1045#1089#1083#1080' '#1085#1077' '#1091#1082#1072#1079#1072#1085#1085#1072' '#1090#1086#1074#1072#1088#1085#1072#1103' '#1075#1088#1091#1087#1087#1072' '#1072#1082#1094#1080#1080', '#1090#1086' '#1072#1082#1094#1080#1103' '#1088#1072#1089#1087#1088#1086#1089#1090#1072#1085#1103#1077#1090#1089#1103 +
          ' '#1085#1072' '#1074#1089#1077' '#1090#1086#1074#1072#1088#1099'.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clHighlight
        Font.Height = -11
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object Label2: TLabel
        Left = 15
        Top = 180
        Width = 129
        Height = 15
        Caption = 'Valoarea reducerii (MDL)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object Label4: TLabel
        Left = 175
        Top = 178
        Width = 62
        Height = 15
        Caption = '%, reducerii'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object Label5: TLabel
        Left = 399
        Top = 99
        Width = 59
        Height = 15
        Caption = 'Promo cod'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object Label6: TLabel
        Left = 16
        Top = 243
        Width = 94
        Height = 15
        Caption = 'Baner (720x360px)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object Label7: TLabel
        Left = 242
        Top = 178
        Width = 50
        Height = 15
        Caption = '(prioritar)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGray
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object Label8: TLabel
        Left = 624
        Top = 99
        Width = 94
        Height = 15
        Caption = 'Sfirsitul promotiei'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object Label9: TLabel
        Left = 399
        Top = 35
        Width = 52
        Height = 15
        Caption = #1053#1072#1079#1074#1072#1085#1080#1077
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object Label10: TLabel
        Left = 399
        Top = 180
        Width = 91
        Height = 15
        Caption = 'Tipul promo-cod'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object deSTART_DATE: TcxDBDateEdit
        Left = 514
        Top = 117
        DataBinding.DataField = 'DATA1'
        ParentFont = False
        Properties.DateButtons = [btnToday]
        Properties.SaveTime = False
        Properties.ShowTime = False
        Properties.WeekNumbers = True
        TabOrder = 4
        Width = 91
      end
      object edTitleRo: TcxDBTextEdit
        Left = 16
        Top = 54
        DataBinding.DataField = 'TITLE_RO'
        ParentFont = False
        TabOrder = 0
        Width = 359
      end
      object deEND_DATE: TcxDBDateEdit
        Left = 624
        Top = 117
        DataBinding.DataField = 'DATA2'
        ParentFont = False
        Properties.DateButtons = [btnToday]
        Properties.SaveTime = False
        Properties.ShowTime = False
        Properties.WeekNumbers = True
        TabOrder = 5
        Width = 90
      end
      object bePROMO_GOODS_GROUP_ID: TcxButtonEdit
        Left = 15
        Top = 114
        ParentFont = False
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
        TabOrder = 2
        Width = 360
      end
      object ceDiscountValue: TcxDBCalcEdit
        Left = 16
        Top = 198
        DataBinding.DataField = 'DISCOUNT_VALUE'
        ParentFont = False
        TabOrder = 6
        Width = 137
      end
      object ceDiscountPercent: TcxDBCalcEdit
        Left = 176
        Top = 198
        DataBinding.DataField = 'DISCOUNT_PERCENT'
        ParentFont = False
        TabOrder = 7
        Width = 137
      end
      object edTicketCode: TcxDBTextEdit
        Left = 399
        Top = 117
        DataBinding.DataField = 'TICKET_CODE'
        ParentFont = False
        TabOrder = 3
        Width = 99
      end
      object imgBanerRo: TcxDBImage
        Left = 16
        Top = 261
        DataBinding.DataField = 'IMAGE_RO'
        Properties.Caption = 'Baner Extra-reducere pe site'
        Properties.GraphicClassName = 'TdxSmartImage'
        Properties.ImmediatePost = True
        TabOrder = 9
        Transparent = True
        Height = 180
        Width = 360
      end
      object imgBanerRu: TcxDBImage
        Left = 399
        Top = 261
        DataBinding.DataField = 'IMAGE_RU'
        Properties.Caption = #1041#1072#1085#1085#1077#1088' '#1089' '#1087#1088#1086#1084#1086' '#1082#1086#1076#1072#1084
        Properties.GraphicClassName = 'TdxSmartImage'
        Properties.ImmediatePost = True
        TabOrder = 10
        Transparent = True
        Height = 180
        Width = 360
      end
      object edTitleRu: TcxDBTextEdit
        Left = 399
        Top = 53
        DataBinding.DataField = 'TITLE_RU'
        ParentFont = False
        TabOrder = 1
        Width = 360
      end
      object lcbTICKET_TYPE: TcxDBLookupComboBox
        Left = 399
        Top = 198
        DataBinding.DataField = 'TICKET_TYPEID'
        ParentFont = False
        Properties.ImmediatePost = True
        Properties.KeyFieldNames = 'SYSSID'
        Properties.ListColumns = <
          item
            FieldName = 'TITLE'
          end>
        Properties.ListOptions.ShowHeader = False
        Properties.ListSource = IBCDataSourceTicketType
        TabOrder = 8
        Width = 360
      end
      object cbFLG_Active: TcxDBCheckBox
        Left = 648
        Top = 3
        Caption = 'Promocod activ'
        DataBinding.DataField = 'FLG_ENABLED'
        Properties.ImmediatePost = True
        Properties.NullStyle = nssUnchecked
        Properties.ValueChecked = '1'
        Properties.ValueUnchecked = '0'
        Style.TransparentBorder = False
        TabOrder = 11
      end
    end
  end
  object btnOk: TButton
    Left = 577
    Top = 565
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object Button2: TButton
    Left = 681
    Top = 565
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
  object dxBarManager1: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Default'
      #1054#1090#1076#1077#1083#1100#1085#1072#1103' '#1089#1082#1080#1076#1082#1072' '#1085#1072' '#1082#1072#1078#1076#1099#1081' '#1090#1086#1074#1072#1088
      'Generare multipla')
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
    Left = 288
    Top = 312
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
    object dxBarManager1Bar3: TdxBar
      Caption = 'Generare'
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 0
      DockedTop = 0
      DockingStyle = dsTop
      FloatLeft = 895
      FloatTop = 2
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udWidth]
          UserWidth = 53
          Visible = True
          ItemName = 'bbGenQty'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbGenerate'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbClearAll'
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
    object beTemplatePromoCode: TcxBarEditItem
      Caption = 'New Item'
      Category = 0
      Hint = 'New Item'
      Visible = ivAlways
      PropertiesClassName = 'TcxTextEditProperties'
    end
    object bbClearAll: TdxBarButton
      Caption = 'Sterge tot'
      Category = 0
      Hint = 'Sterge tot'
      Visible = ivAlways
      ImageIndex = 35
      OnClick = bbClearAllClick
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
    object bbGenerate: TdxBarButton
      Caption = 'Genereaza'
      Category = 2
      Hint = 'Genereaza'
      Visible = ivAlways
      ImageIndex = 71
      OnClick = bbGenerateClick
    end
    object bbGenQty: TdxBarSpinEdit
      Caption = 'Cant'
      Category = 2
      Hint = 'Cant'
      Visible = ivAlways
      ShowCaption = True
      Increment = 10.000000000000000000
      MaxValue = 999.000000000000000000
      MinValue = 1.000000000000000000
      Value = 1.000000000000000000
    end
  end
  object IBCQueryTicketType: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'select * from sp_get_syss_list(57)')
    Left = 440
    Top = 328
  end
  object IBCDataSourceTicketType: TIBCDataSource
    DataSet = IBCQueryTicketType
    Left = 368
    Top = 328
  end
end
