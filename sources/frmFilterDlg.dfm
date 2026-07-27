object frmFilterDialog: TfrmFilterDialog
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Filtru'
  ClientHeight = 526
  ClientWidth = 479
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poOwnerFormCenter
  OnKeyUp = FormKeyUp
  TextHeight = 15
  object pnButtons: TPanel
    Left = 0
    Top = 467
    Width = 479
    Height = 59
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object btnCancel: TcxButton
      Left = 361
      Top = 12
      Width = 90
      Height = 29
      Cancel = True
      Caption = 'Renunta'
      ModalResult = 2
      TabOrder = 2
    end
    object btnOk: TcxButton
      Left = 257
      Top = 12
      Width = 90
      Height = 29
      Caption = 'OK'
      Default = True
      TabOrder = 1
      OnClick = btnOkClick
    end
    object btnClearFilter: TcxButton
      Left = 15
      Top = 12
      Width = 114
      Height = 29
      Caption = 'Fara filtru (F2)'
      ModalResult = 3
      TabOrder = 0
    end
  end
  object cxPageControl: TcxPageControl
    AlignWithMargins = True
    Left = 8
    Top = 8
    Width = 463
    Height = 455
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 4
    Align = alClient
    TabOrder = 0
    Properties.ActivePage = tbsDate
    Properties.CloseButtonMode = cbmEveryTab
    Properties.CustomButtons.Buttons = <>
    Properties.ImageBorder = 2
    Properties.Images = dmAdditions.cxImageList_SWN
    OnCanCloseEx = cxPageControlCanCloseEx
    ExplicitTop = 72
    ExplicitHeight = 391
    ClientRectBottom = 451
    ClientRectLeft = 4
    ClientRectRight = 459
    ClientRectTop = 31
    object tbsDate: TcxTabSheet
      Caption = 'Perioada'
      ExplicitHeight = 356
      object deDateStart: TcxDateEdit
        Left = 100
        Top = 109
        Properties.ClearKey = 16430
        Properties.DateButtons = [btnNow, btnToday]
        Properties.ImmediatePost = True
        Properties.InputKind = ikRegExpr
        Properties.PostPopupValueOnTab = True
        Properties.ReadOnly = False
        Properties.SaveTime = False
        Properties.ShowTime = False
        Properties.WeekNumbers = True
        TabOrder = 11
        Width = 174
      end
      object deDateEnd: TcxDateEdit
        Left = 99
        Top = 138
        Properties.ClearKey = 16430
        Properties.PostPopupValueOnTab = True
        Properties.SaveTime = False
        Properties.ShowTime = False
        Properties.WeekNumbers = True
        TabOrder = 13
        Width = 175
      end
      object cmbQuickDate: TcxComboBox
        Left = 288
        Top = 138
        Properties.DropDownListStyle = lsFixedList
        Properties.DropDownRows = 16
        Properties.OnEditValueChanged = cmbQuickDatePropertiesEditValueChanged
        TabOrder = 15
        Width = 137
      end
      object cxLabel1: TcxLabel
        Left = 288
        Top = 119
        Caption = 'perioade pre setate'
        TabOrder = 14
        Transparent = True
      end
      object rbQuarter: TcxRadioButton
        Left = 16
        Top = 25
        Width = 78
        Height = 18
        Caption = 'Trimestru'
        TabOrder = 3
        OnClick = rbQuarterClick
      end
      object rbMonth: TcxRadioButton
        Left = 16
        Top = 54
        Width = 78
        Height = 18
        Caption = #1052#1077#1089#1103#1094
        TabOrder = 7
        OnClick = rbQuarterClick
      end
      object rbDay: TcxRadioButton
        Left = 16
        Top = 83
        Width = 78
        Height = 18
        Caption = #1044#1077#1085#1100
        TabOrder = 10
        OnClick = rbQuarterClick
      end
      object rbDateRange: TcxRadioButton
        Left = 16
        Top = 112
        Width = 78
        Height = 18
        Caption = #1048#1085#1090#1077#1088#1074#1072#1083
        TabOrder = 12
        OnClick = rbQuarterClick
      end
      object cbQuarterYearStart: TcxCheckBox
        Left = 288
        Top = 22
        Caption = 'de la inceputul anului'
        TabOrder = 2
      end
      object cbMonthQuarterStart: TcxCheckBox
        Left = 288
        Top = 51
        Caption = 'de la inceputul trimestrului'
        TabOrder = 6
      end
      object cbDayMonthStart: TcxCheckBox
        Left = 288
        Top = 80
        Caption = 'de la inceputul lunii'
        TabOrder = 9
      end
      object cmbQuarter: TcxComboBox
        Left = 100
        Top = 22
        Properties.DropDownListStyle = lsFixedList
        Properties.Items.Strings = (
          'I Trimestru'
          'II Trimestru'
          'III Trimestru'
          'IV Trimestru')
        TabOrder = 0
        Text = 'I Trimestru'
        Width = 113
      end
      object cmbMonth: TcxComboBox
        Left = 100
        Top = 51
        Properties.DropDownListStyle = lsFixedList
        Properties.DropDownRows = 16
        Properties.Items.Strings = (
          'Ianuarie'
          'Februarie'
          'Martie'
          'Aprilie'
          'Mai'
          'Iunie'
          'Iulie'
          'August'
          'Septembrie'
          'Octombrie'
          'Noiembrie'
          'Decembrie')
        TabOrder = 4
        Text = 'Ianuarie'
        Width = 113
      end
      object seQuarterYear: TcxSpinEdit
        Left = 219
        Top = 22
        Properties.Alignment.Horz = taCenter
        Properties.CanEdit = False
        Properties.ImmediatePost = True
        Properties.LargeIncrement = 1.000000000000000000
        Properties.ReadOnly = False
        Properties.SpinButtons.Position = sbpHorzLeftRight
        TabOrder = 1
        Value = 2009
        Width = 55
      end
      object seMonthYear: TcxSpinEdit
        Left = 219
        Top = 51
        Properties.Alignment.Horz = taCenter
        Properties.CanEdit = False
        Properties.ImmediatePost = True
        Properties.LargeIncrement = 1.000000000000000000
        Properties.ReadOnly = False
        Properties.SpinButtons.Position = sbpHorzLeftRight
        TabOrder = 5
        Value = 2009
        Width = 55
      end
      object deDateByDay: TcxDateEdit
        Left = 100
        Top = 80
        Properties.ClearKey = 16430
        Properties.DateButtons = [btnNow, btnToday]
        Properties.ImmediatePost = True
        Properties.InputKind = ikRegExpr
        Properties.PostPopupValueOnTab = True
        Properties.ReadOnly = False
        Properties.SaveTime = False
        Properties.ShowTime = False
        Properties.WeekNumbers = True
        TabOrder = 8
        Width = 174
      end
      object rbNoDateFilter: TcxRadioButton
        Left = 16
        Top = 141
        Width = 41
        Height = 18
        Caption = #1053#1077#1090
        Checked = True
        TabOrder = 16
        TabStop = True
        OnClick = rbQuarterClick
      end
    end
    object tbsClient: TcxTabSheet
      Caption = 'Client'
      ExplicitHeight = 356
      object cxLabel4: TcxLabel
        Left = 16
        Top = 16
        Caption = 'Client'
        TabOrder = 0
        Transparent = True
      end
      object lcbCustomer: TcxButtonEdit
        Left = 16
        Top = 37
        Properties.Buttons = <
          item
            Default = True
            Glyph.SourceDPI = 96
            Glyph.Data = {
              424D360400000000000036000000280000001000000010000000010020000000
              000000000000C40E0000C40E00000000000000000000FF00FF00FF00FF00FF00
              FF00FF00FF00B8C698FFA6AE7AFF948F55FFFF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0086B558FF8DB4
              61FF92B266FF99B56DFF9EB975FF91884AFF718043FF757C43FF8F8C4DFF9284
              49FFA58D5EFFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF0086B558FFA4BD
              7EFFA4BD7EFFA4C17EFFA4C17EFF91884AFF96A67CFF98AA7FFFB5CD98FFB5CD
              98FFB1C58DFFA88559FFFF00FF00FF00FF00FF00FF00FF00FF0086B558FFA4B9
              7DFFA4BD7EFFA4BD7EFFA4BD7EFF928449FF96A67CFF98AA7FFFB5CD98FFB5CD
              98FFB5CD98FF9C7240FFFF00FF00FF00FF00FF00FF00FF00FF0086B558FFA4B9
              7DFFA6AE7AFFA4B97DFFA4BD7EFF928449FF96A67CFF98AA7FFFB5CD98FFB5CD
              98FFB5CD98FF9C7240FFFF00FF00FF00FF00FF00FF00FF00FF0086B558FFA9AA
              78FFA4B97DFFA6AE7AFFA4B97DFF928449FF96A67CFF98A57DFFB5CD98FFB5CD
              98FFB5CD98FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B558FFA9AA
              78FFA9AA78FFA6AE7AFFA4B97DFF967D46FF96A67CFF98A57DFFB6C596FFB6C5
              96FFB5CD98FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B558FFABA5
              76FFA9AA78FFA9AA78FFA4B97DFF967D46FF979E7AFF98A57DFFB6C596FFB6C5
              96FFB6C997FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B558FFADA1
              74FFABA576FFA9AA78FFB6B188FF967D46FF979E7AFF98A57DFFB6C596FFB6C5
              96FFB6C596FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B057FFADA1
              74FFADA174FFABA576FFBAB991FF967D46FF979E7AFF9A9D7BFFB6C596FFB6C5
              96FFB6C596FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B057FFB296
              6FFFB09A70FFADA174FFBAB991FF9C7240FF979E7AFF9A9D7BFFB8BE94FFB8C0
              95FFB6C596FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B057FFB296
              6FFFB2966FFFB09A70FFC5B395FF967D46FF9A9777FF9A9D7BFFB8BE94FFB8BE
              94FFB8C095FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B057FFB78E
              6BFFB2966FFFB2966FFFC5B395FF9C7240FF9A9D7BFF9A9D7BFFB8BE94FFB8BE
              94FFB8BE94FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B057FFB78E
              6BFFB78E6BFFC1AC8CFFB9A882FF9C7240FF9A9D7BFFB1AE8AFFBAB991FFB8BE
              94FFB8BE94FF9E6E3EFFFF00FF00FF00FF00FF00FF00FF00FF0086B057FF9F98
              5FFFA6AB76FF979357FFAA986AFFA49573FFBCB18DFFBCB18DFFBAB991FFBAB9
              91FFBCB18DFFAB7F56FFFF00FF00FF00FF00FF00FF00FF00FF0090B063FF90B0
              63FF88AA56FF87A755FF89A054FF8A9A52FF8C934FFF91884AFF928449FF9C72
              40FFA88559FFFF00FF00FF00FF00FF00FF00FF00FF00}
            Kind = bkGlyph
          end>
        Properties.CharCase = ecUpperCase
        Properties.ClearKey = 16430
        Properties.ClickKey = 115
        Properties.OnButtonClick = lcbCustomerPropertiesButtonClick
        Properties.OnEditValueChanged = lcbCustomerPropertiesEditValueChanged
        TabOrder = 1
        OnKeyPress = lcbCustomerKeyPress
        Width = 421
      end
      object cxLabel7: TcxLabel
        Left = 16
        Top = 84
        Caption = 'Tip client'
        TabOrder = 2
        Transparent = True
      end
      object lcbCustomerType: TcxLookupComboBox
        Left = 16
        Top = 105
        Properties.ClearKey = 16430
        Properties.DropDownAutoSize = True
        Properties.DropDownListStyle = lsFixedList
        Properties.DropDownRows = 16
        Properties.KeyFieldNames = 'CUSTOMERTYPEID'
        Properties.ListColumns = <
          item
            FieldName = 'TITLE'
          end>
        Properties.ListOptions.ShowHeader = False
        Properties.ListSource = IBCDataSourceCustTypes
        EditValue = 0
        TabOrder = 3
        Width = 417
      end
    end
    object tbsGoods: TcxTabSheet
      Caption = 'Marfuri'
      ExplicitHeight = 356
      object cxLabel5: TcxLabel
        Left = 16
        Top = 16
        Caption = 'Produs'
        TabOrder = 0
        Transparent = True
      end
      object lcbGoods: TcxButtonEdit
        Left = 16
        Top = 37
        Properties.Buttons = <
          item
            Default = True
            Glyph.SourceDPI = 96
            Glyph.Data = {
              424D360400000000000036000000280000001000000010000000010020000000
              000000000000C40E0000C40E00000000000000000000FF00FF00FF00FF00FF00
              FF00FF00FF00B8C698FFA6AE7AFF948F55FFFF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0086B558FF8DB4
              61FF92B266FF99B56DFF9EB975FF91884AFF718043FF757C43FF8F8C4DFF9284
              49FFA58D5EFFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF0086B558FFA4BD
              7EFFA4BD7EFFA4C17EFFA4C17EFF91884AFF96A67CFF98AA7FFFB5CD98FFB5CD
              98FFB1C58DFFA88559FFFF00FF00FF00FF00FF00FF00FF00FF0086B558FFA4B9
              7DFFA4BD7EFFA4BD7EFFA4BD7EFF928449FF96A67CFF98AA7FFFB5CD98FFB5CD
              98FFB5CD98FF9C7240FFFF00FF00FF00FF00FF00FF00FF00FF0086B558FFA4B9
              7DFFA6AE7AFFA4B97DFFA4BD7EFF928449FF96A67CFF98AA7FFFB5CD98FFB5CD
              98FFB5CD98FF9C7240FFFF00FF00FF00FF00FF00FF00FF00FF0086B558FFA9AA
              78FFA4B97DFFA6AE7AFFA4B97DFF928449FF96A67CFF98A57DFFB5CD98FFB5CD
              98FFB5CD98FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B558FFA9AA
              78FFA9AA78FFA6AE7AFFA4B97DFF967D46FF96A67CFF98A57DFFB6C596FFB6C5
              96FFB5CD98FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B558FFABA5
              76FFA9AA78FFA9AA78FFA4B97DFF967D46FF979E7AFF98A57DFFB6C596FFB6C5
              96FFB6C997FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B558FFADA1
              74FFABA576FFA9AA78FFB6B188FF967D46FF979E7AFF98A57DFFB6C596FFB6C5
              96FFB6C596FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B057FFADA1
              74FFADA174FFABA576FFBAB991FF967D46FF979E7AFF9A9D7BFFB6C596FFB6C5
              96FFB6C596FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B057FFB296
              6FFFB09A70FFADA174FFBAB991FF9C7240FF979E7AFF9A9D7BFFB8BE94FFB8C0
              95FFB6C596FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B057FFB296
              6FFFB2966FFFB09A70FFC5B395FF967D46FF9A9777FF9A9D7BFFB8BE94FFB8BE
              94FFB8C095FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B057FFB78E
              6BFFB2966FFFB2966FFFC5B395FF9C7240FF9A9D7BFF9A9D7BFFB8BE94FFB8BE
              94FFB8BE94FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B057FFB78E
              6BFFB78E6BFFC1AC8CFFB9A882FF9C7240FF9A9D7BFFB1AE8AFFBAB991FFB8BE
              94FFB8BE94FF9E6E3EFFFF00FF00FF00FF00FF00FF00FF00FF0086B057FF9F98
              5FFFA6AB76FF979357FFAA986AFFA49573FFBCB18DFFBCB18DFFBAB991FFBAB9
              91FFBCB18DFFAB7F56FFFF00FF00FF00FF00FF00FF00FF00FF0090B063FF90B0
              63FF88AA56FF87A755FF89A054FF8A9A52FF8C934FFF91884AFF928449FF9C72
              40FFA88559FFFF00FF00FF00FF00FF00FF00FF00FF00}
            Kind = bkGlyph
          end>
        Properties.CharCase = ecUpperCase
        Properties.ClearKey = 16430
        Properties.ClickKey = 115
        Properties.OnButtonClick = lcbGoodsPropertiesButtonClick
        Properties.OnEditValueChanged = lcbGoodsPropertiesEditValueChanged
        TabOrder = 1
        OnKeyPress = lcbGoodsKeyPress
        Width = 421
      end
      object cxLabel2: TcxLabel
        AlignWithMargins = True
        Left = 16
        Top = 141
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 2
        Caption = 'Grupa de produse'
        TabOrder = 2
        Transparent = True
      end
      object pcGoodsGroups: TPageControl
        Left = 16
        Top = 165
        Width = 421
        Height = 180
        ActivePage = tbsGoodsFolders
        Images = dmAdditions.cxImageList_SWN
        TabOrder = 5
        object tbsGoodsByAcnt: TTabSheet
          Caption = 'din contabilitate'
          ImageIndex = -1
          object dxBarDockControl2: TdxBarDockControl
            Left = 0
            Top = 0
            Width = 413
            Height = 30
            Align = dalTop
            BarManager = dxBarManager
            SunkenBorder = True
            UseOwnSunkenBorder = True
          end
          object cxGridAcnt: TcxGrid
            Left = 0
            Top = 30
            Width = 413
            Height = 119
            Align = alClient
            TabOrder = 1
            object cxGridAcntTable: TcxGridTableView
              Navigator.Buttons.CustomButtons = <>
              ScrollbarAnnotations.CustomAnnotations = <>
              OnFocusedItemChanged = cxGridAcntTableFocusedItemChanged
              OnFocusedRecordChanged = cxGridAcntTableFocusedRecordChanged
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              OptionsCustomize.ColumnFiltering = False
              OptionsCustomize.ColumnSorting = False
              OptionsData.Deleting = False
              OptionsData.Editing = False
              OptionsData.Inserting = False
              OptionsSelection.CellSelect = False
              OptionsSelection.MultiSelect = True
              OptionsSelection.InvertSelect = False
              OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1090#1086#1074#1072#1088#1086#1074'>'
              OptionsView.ScrollBars = ssVertical
              OptionsView.ColumnAutoWidth = True
              OptionsView.GridLineColor = 13750737
              OptionsView.GroupByBox = False
              Styles.Header = dmAdditions.cxStyle_GridHeader
              object cxGridAcntTable_ACNTID: TcxGridColumn
                Caption = 'Cod'
                DataBinding.ValueType = 'Integer'
                HeaderAlignmentHorz = taCenter
                MinWidth = 60
                Options.HorzSizing = False
                Width = 60
              end
              object cxGridAcntTable_TITLE: TcxGridColumn
                Caption = 'denumire din facturi'
              end
            end
            object cxGridAcntLevel: TcxGridLevel
              GridView = cxGridAcntTable
            end
          end
        end
        object tbsGoodsFolders: TTabSheet
          Caption = 'din nomenclator'
          ImageIndex = -1
          object dxBarDockControl1: TdxBarDockControl
            Left = 0
            Top = 0
            Width = 413
            Height = 30
            Align = dalTop
            BarManager = dxBarManager
            SunkenBorder = True
            UseOwnSunkenBorder = True
          end
          object cxGridGoods: TcxGrid
            Left = 0
            Top = 30
            Width = 413
            Height = 119
            Align = alClient
            TabOrder = 1
            object cxGridGoodsTable: TcxGridTableView
              Navigator.Buttons.CustomButtons = <>
              ScrollbarAnnotations.CustomAnnotations = <>
              OnFocusedItemChanged = cxGridGoodsTableFocusedItemChanged
              OnFocusedRecordChanged = cxGridGoodsTableFocusedRecordChanged
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              OptionsCustomize.ColumnFiltering = False
              OptionsCustomize.ColumnSorting = False
              OptionsData.Deleting = False
              OptionsData.DeletingConfirmation = False
              OptionsData.Editing = False
              OptionsData.Inserting = False
              OptionsSelection.CellSelect = False
              OptionsSelection.MultiSelect = True
              OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1075#1088#1091#1087#1087' '#1090#1086#1074#1072#1088#1086#1074'>'
              OptionsView.ScrollBars = ssVertical
              OptionsView.ColumnAutoWidth = True
              OptionsView.GridLineColor = 13750737
              OptionsView.GroupByBox = False
              Styles.Header = dmAdditions.cxStyle_GridHeader
              object cxGrid_GOODSID: TcxGridColumn
                Caption = 'Cod'
                DataBinding.ValueType = 'Integer'
                HeaderAlignmentHorz = taCenter
                MinWidth = 60
                Options.HorzSizing = False
                Width = 60
              end
              object cxGrid_TITLE: TcxGridColumn
                Caption = 'Mapa produse'
                Width = 100
              end
            end
            object cxGridGoodsLevel: TcxGridLevel
              GridView = cxGridGoodsTable
            end
          end
        end
      end
      object cxLabel3: TcxLabel
        Left = 16
        Top = 77
        Caption = 'Numarul de serie'
        TabOrder = 4
        Transparent = True
      end
      object txtGoodsSN: TcxTextEdit
        Left = 16
        Top = 98
        TabOrder = 3
        Width = 421
      end
    end
    object tbsStock: TcxTabSheet
      Caption = 'Depozite'
      ExplicitHeight = 356
      object cxLabel6: TcxLabel
        Left = 16
        Top = 16
        Caption = 'Depozit'
        TabOrder = 0
        Transparent = True
      end
      object lcbStock: TcxLookupComboBox
        Left = 16
        Top = 37
        Properties.ClearKey = 16430
        Properties.DropDownAutoSize = True
        Properties.DropDownListStyle = lsFixedList
        Properties.DropDownRows = 16
        Properties.KeyFieldNames = 'STOCKID'
        Properties.ListColumns = <
          item
            Fixed = True
            MinWidth = 30
            Width = 30
            FieldName = 'STOCKID'
          end
          item
            Width = 200
            FieldName = 'TITLE'
          end
          item
            Width = 150
            FieldName = 'PARENT_TITLE'
          end>
        Properties.ListFieldIndex = 1
        Properties.ListOptions.ShowHeader = False
        Properties.ListSource = dmDB.IBCDataSourceStocks
        EditValue = 0
        TabOrder = 1
        Width = 421
      end
    end
  end
  object dxBarManager: TdxBarManager
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
    Left = 340
    Top = 12
    PixelsPerInch = 96
    object dxBarManagerBar1: TdxBar
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
      FloatLeft = 497
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbGoodsAdd'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbGoodsRemove'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbGoodsClear'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBar2: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Custom 2'
      CaptionButtons = <>
      DockControl = dxBarDockControl2
      DockedDockControl = dxBarDockControl2
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 495
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbAcntFolderAdd'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbAcntFolderDelete'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbAcntFoldersClear'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object bbGoodsAdd: TdxBarButton
      Caption = 'Adauga'
      Category = 0
      Hint = 'Adauga'
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 45
      OnClick = bbGoodsAddClick
    end
    object bbGoodsRemove: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      ShortCut = 46
      OnClick = bbGoodsRemoveClick
    end
    object bbGoodsClear: TdxBarButton
      Caption = 'Sterge tot'
      Category = 0
      Hint = 'Sterge tot'
      Visible = ivAlways
      ImageIndex = 35
      ShortCut = 16430
      OnClick = bbGoodsClearClick
    end
    object bbAcntFolderAdd: TdxBarButton
      Caption = 'Adauga'
      Category = 0
      Hint = 'Adauga'
      Visible = ivAlways
      ImageIndex = 40
      OnClick = bbAcntFolderAddClick
    end
    object bbAcntFolderDelete: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      OnClick = bbAcntFolderDeleteClick
    end
    object bbAcntFoldersClear: TdxBarButton
      Caption = 'Sterge tot'
      Category = 0
      Hint = 'Sterge tot'
      Visible = ivAlways
      ImageIndex = 35
      OnClick = bbAcntFoldersClearClick
    end
  end
  object IBCQueryCustTypes: TIBCQuery
    SQL.Strings = (
      'SELECT CUSTOMERTYPEID,TITLE'
      'FROM GET_CUSTOMER_TYPES'
      'ORDER BY TITLE')
    Options.BooleanDomainFields = True
    Left = 216
    Top = 368
  end
  object IBCDataSourceCustTypes: TIBCDataSource
    AutoEdit = False
    DataSet = IBCQueryCustTypes
    Left = 216
    Top = 312
  end
end
