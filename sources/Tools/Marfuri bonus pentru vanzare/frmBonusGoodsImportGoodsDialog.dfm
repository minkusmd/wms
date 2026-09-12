object frmBonusGoodsImportGoodsDlg: TfrmBonusGoodsImportGoodsDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Import produselor cu bonus'
  ClientHeight = 548
  ClientWidth = 966
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 966
    Height = 64
    Title = 'Import produselor cu bonus'
    Text = 'Importul produselor cu bonus din clipboard.'
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
    ImageIndex = 21
  end
  object pcPageControl: TcxPageControl
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 950
    Height = 419
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 0
    Align = alClient
    TabOrder = 1
    Properties.ActivePage = tbsGoods
    Properties.CustomButtons.Buttons = <>
    ClientRectBottom = 415
    ClientRectLeft = 4
    ClientRectRight = 946
    ClientRectTop = 26
    object tbsGoods: TcxTabSheet
      Caption = '&1. '#1058#1086#1074#1072#1088#1099
      ImageIndex = 0
      object dxBarDockControl1: TdxBarDockControl
        Left = 0
        Top = 0
        Width = 942
        Height = 30
        Align = dalTop
        BarManager = dxBarManager1
        SunkenBorder = True
        UseOwnSunkenBorder = True
      end
      object cxGrid: TcxGrid
        Left = 0
        Top = 30
        Width = 942
        Height = 359
        Align = alClient
        TabOrder = 1
        object cxGridTable: TcxGridTableView
          Navigator.Buttons.CustomButtons = <>
          ScrollbarAnnotations.CustomAnnotations = <>
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <
            item
              Kind = skCount
              Column = cxGridTable_VCODE
            end
            item
              Kind = skCount
              Column = cxGridTable_NCODE
            end>
          DataController.Summary.SummaryGroups = <>
          OptionsCustomize.ColumnFiltering = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsSelection.InvertSelect = False
          OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
          OptionsView.ScrollBars = ssVertical
          OptionsView.ColumnAutoWidth = True
          OptionsView.Footer = True
          OptionsView.GridLineColor = 13750737
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          Styles.Footer = dmAdditions.cxStyle_GridHeader
          Styles.Header = dmAdditions.cxStyle_GridHeader
          Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
          object cxGridTable_IMG: TcxGridColumn
            PropertiesClassName = 'TcxImageComboBoxProperties'
            Properties.DefaultImageIndex = 12
            Properties.Images = dmAdditions.cxImageList_SWN
            Properties.Items = <>
            MinWidth = 24
            Options.HorzSizing = False
            VisibleForCustomization = False
            Width = 24
          end
          object cxGridTable_VCODE: TcxGridColumn
            Caption = 'Cod produs furnizor'
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            MinWidth = 100
            Options.HorzSizing = False
            Width = 100
          end
          object cxGridTable_NCODE: TcxGridColumn
            Caption = 'Cod intern'
            DataBinding.ValueType = 'Integer'
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            MinWidth = 100
            Options.HorzSizing = False
            Width = 100
          end
          object cxGridTable_TITLE: TcxGridColumn
            Caption = 'Denumire'
            Width = 200
          end
          object cxGridTable_STATUS: TcxGridColumn
            Caption = 'Status'
            HeaderAlignmentHorz = taCenter
            MinWidth = 120
            Options.HorzSizing = False
            Width = 120
          end
          object cxGridTable_STATUSCODE: TcxGridColumn
            DataBinding.ValueType = 'Integer'
            Visible = False
            VisibleForCustomization = False
          end
        end
        object cxGridLevel: TcxGridLevel
          GridView = cxGridTable
        end
      end
    end
    object tbsDefaults: TcxTabSheet
      Caption = '&2. '#1057#1074#1086#1081#1089#1090#1074#1072' '#1080#1084#1087#1086#1088#1090#1072
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label2: TLabel
        Left = 36
        Top = 41
        Width = 42
        Height = 15
        Caption = #1053#1072#1095#1072#1083#1086
      end
      object Label3: TLabel
        Left = 221
        Top = 41
        Width = 34
        Height = 15
        Caption = #1050#1086#1085#1077#1094
      end
      object Label5: TLabel
        Left = 342
        Top = 211
        Width = 10
        Height = 15
        Caption = '%'
      end
      object Label1: TLabel
        Left = 20
        Top = 20
        Width = 153
        Height = 15
        Caption = #1055#1077#1088#1080#1086#1076' '#1076#1077#1081#1089#1090#1074#1080#1103' '#1073#1086#1085#1091#1089#1086#1074
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label6: TLabel
        Left = 20
        Top = 112
        Width = 34
        Height = 15
        Caption = #1041#1086#1085#1091#1089
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label4: TLabel
        Left = 137
        Top = 171
        Width = 41
        Height = 15
        Caption = #1042#1072#1083#1102#1090#1072
      end
      object rbFixedSum: TRadioButton
        Left = 36
        Top = 141
        Width = 153
        Height = 17
        Caption = #1060#1080#1082#1089#1080#1088#1086#1074#1072#1085#1085#1072#1103' '#1089#1091#1084#1084#1072
        TabOrder = 0
      end
      object rbPercent: TRadioButton
        Left = 36
        Top = 208
        Width = 153
        Height = 17
        Caption = #1055#1088#1086#1094#1077#1085#1090' '#1086#1090' '#1087#1088#1086#1076#1072#1078
        TabOrder = 1
      end
      object lcbCurrency: TcxLookupComboBox
        Left = 195
        Top = 167
        Properties.DropDownListStyle = lsFixedList
        Properties.ImmediatePost = True
        Properties.KeyFieldNames = 'CURRENCYID'
        Properties.ListColumns = <
          item
            FieldName = 'TITLE'
          end>
        Properties.ListOptions.ShowHeader = False
        Properties.ListSource = dmDB.IBCDataSourceCurrency
        EditValue = 840
        TabOrder = 2
        Width = 145
      end
      object deDATA1: TcxDateEdit
        Left = 36
        Top = 58
        EditValue = 0d
        Properties.DateButtons = [btnNow, btnToday]
        Properties.SaveTime = False
        Properties.ShowTime = False
        Properties.WeekNumbers = True
        TabOrder = 3
        Width = 160
      end
      object deDATA2: TcxDateEdit
        Left = 221
        Top = 58
        EditValue = 0d
        Properties.DateButtons = [btnNow, btnToday]
        Properties.SaveTime = False
        Properties.ShowTime = False
        Properties.WeekNumbers = True
        TabOrder = 4
        Width = 160
      end
      object edSUMA_BONUS: TcxCalcEdit
        Left = 195
        Top = 138
        EditValue = 0.000000000000000000
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 5
        Width = 145
      end
      object edPERCENT_BONUS: TcxCalcEdit
        Left = 195
        Top = 208
        EditValue = 0.000000000000000000
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 6
        Width = 145
      end
      object cbDeletePreviousGoods: TCheckBox
        Left = 20
        Top = 344
        Width = 189
        Height = 17
        Caption = #1059#1076#1072#1083#1080#1090#1100' '#1087#1088#1077#1076#1099#1076#1091#1097#1080#1077' '#1090#1086#1074#1072#1088#1099
        TabOrder = 7
      end
    end
  end
  object pnBottom: TPanel
    Left = 0
    Top = 491
    Width = 966
    Height = 57
    Align = alBottom
    BevelOuter = bvNone
    Padding.Top = 12
    Padding.Right = 24
    Padding.Bottom = 16
    ShowCaption = False
    TabOrder = 2
    object Label7: TLabel
      Left = 12
      Top = 12
      Width = 225
      Height = 15
      Caption = 'Cod produs -> Paste->Valideaza->Importa'
    end
    object btnOk: TButton
      AlignWithMargins = True
      Left = 724
      Top = 12
      Width = 116
      Height = 29
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 12
      Margins.Bottom = 0
      Align = alRight
      Caption = 'Importa'
      ModalResult = 1
      TabOrder = 0
    end
    object btnCancel: TButton
      Left = 852
      Top = 12
      Width = 90
      Height = 29
      Align = alRight
      Cancel = True
      Caption = 'Renunta'
      ModalResult = 2
      TabOrder = 1
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
    Left = 648
    Top = 20
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
      FloatLeft = 990
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarSubItem1'
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
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbImport'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbVerify'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object dxBarSubItem1: TdxBarSubItem
      Caption = 'Tip cod produs'
      Category = 0
      Visible = ivAlways
      ImageIndex = 11
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbVendorCode'
        end
        item
          Visible = True
          ItemName = 'bbNeuronCode'
        end>
    end
    object bbVendorCode: TdxBarButton
      Caption = 'de la Furnizor'
      Category = 0
      Hint = 'de la Furnizor'
      Visible = ivAlways
      ButtonStyle = bsChecked
      GroupIndex = 1
      Down = True
      OnClick = bbVendorCodeClick
    end
    object bbNeuronCode: TdxBarButton
      Caption = 'intern de sistema'
      Category = 0
      Hint = 'intern de sistema'
      Visible = ivAlways
      ButtonStyle = bsChecked
      GroupIndex = 1
      OnClick = bbVendorCodeClick
    end
    object bbImport: TdxBarButton
      Caption = 'Paste'
      Category = 0
      Hint = 'Paste'
      Visible = ivAlways
      ImageIndex = 24
      OnClick = bbImportClick
    end
    object bbVerify: TdxBarButton
      Caption = 'Valideaza'
      Category = 0
      Hint = 'Valideaza'
      Visible = ivAlways
      ImageIndex = 25
      OnClick = bbVerifyClick
    end
    object bbClearAll: TdxBarButton
      Caption = 'Sterge tot'
      Category = 0
      Hint = 'Sterge tot'
      Visible = ivAlways
      ImageIndex = 35
      OnClick = bbClearAllClick
    end
  end
end
