object frmGoodsBrowser: TfrmGoodsBrowser
  Left = 0
  Top = 0
  ActiveControl = cxGridGoods
  BorderIcons = [biSystemMenu]
  Caption = 'Nomeclator produse'
  ClientHeight = 628
  ClientWidth = 1466
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poOwnerFormCenter
  TextHeight = 13
  object dxBarDockControl1: TdxBarDockControl
    Left = 0
    Top = 0
    Width = 1466
    Height = 30
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 1
    Align = dalTop
    BarManager = dxBarManager
    SunkenBorder = True
    UseOwnSunkenBorder = True
  end
  object cxGridGoods: TcxGrid
    Left = 0
    Top = 61
    Width = 1466
    Height = 475
    Margins.Left = 8
    Margins.Top = 0
    Margins.Right = 8
    Margins.Bottom = 0
    Align = alClient
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    LookAndFeel.NativeStyle = True
    LookAndFeel.SkinName = ''
    object cxGridGoods_Table: TcxGridDBTableView
      PopupMenu = dxBarPopupMenu
      OnKeyDown = cxGridGoods_TableKeyDown
      Navigator.Buttons.First.Visible = True
      Navigator.Buttons.PriorPage.Visible = True
      Navigator.Buttons.Prior.Visible = True
      Navigator.Buttons.Next.Visible = True
      Navigator.Buttons.NextPage.Visible = True
      Navigator.Buttons.Last.Visible = True
      Navigator.Buttons.Insert.Visible = True
      Navigator.Buttons.Append.Visible = False
      Navigator.Buttons.Delete.Visible = True
      Navigator.Buttons.Edit.Visible = True
      Navigator.Buttons.Post.Visible = True
      Navigator.Buttons.Cancel.Visible = True
      Navigator.Buttons.Refresh.Visible = True
      Navigator.Buttons.SaveBookmark.Visible = True
      Navigator.Buttons.GotoBookmark.Visible = True
      Navigator.Buttons.Filter.Visible = True
      FilterBox.CustomizeDialog = False
      FindPanel.Behavior = fcbFilter
      FindPanel.DisplayMode = fpdmAlways
      FindPanel.FocusViewOnApplyFilter = True
      FindPanel.UseExtendedSyntax = True
      OnCellDblClick = cxGridGoods_TableCellDblClick
      OnFocusedRecordChanged = cxGridGoods_TableFocusedRecordChanged
      OnSelectionChanged = cxGridGoods_TableSelectionChanged
      DataController.DataModeController.GridModeBufferCount = 40
      DataController.DataSource = IBCDataSourceGoods
      DataController.KeyFieldNames = 'GOODSID'
      EditForm.DefaultColumnCount = 1
      OptionsBehavior.CopyCaptionsToClipboard = False
      OptionsBehavior.DragHighlighting = False
      OptionsBehavior.DragOpening = False
      OptionsBehavior.DragScrolling = False
      OptionsBehavior.IncSearch = True
      OptionsBehavior.CopyPreviewToClipboard = False
      OptionsBehavior.ImmediateEditor = False
      OptionsBehavior.PullFocusing = True
      OptionsCustomize.ColumnsQuickCustomization = True
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.MultiSelect = True
      OptionsSelection.CellMultiSelect = True
      OptionsSelection.HideFocusRectOnExit = False
      OptionsSelection.InvertSelect = False
      OptionsSelection.UnselectFocusedRecordOnExit = False
      OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
      OptionsView.ColumnAutoWidth = True
      OptionsView.GridLineColor = 13750737
      OptionsView.GroupByBox = False
      OptionsView.Indicator = True
      Preview.Column = cxGridGoods_TableColumn1
      Styles.OnGetContentStyle = cxGridGoods_TableStylesGetContentStyle
      object cxGridGoods_IMG: TcxGridDBColumn
        DataBinding.FieldName = 'GOODS_IMAGE_INDEX'
        PropertiesClassName = 'TcxImageComboBoxProperties'
        Properties.Items = <>
        HeaderAlignmentHorz = taCenter
        MinWidth = 24
        Options.Filtering = False
        Options.Focusing = False
        Options.FilteringPopup = False
        Options.Grouping = False
        Options.HorzSizing = False
        Options.ShowCaption = False
        Options.Sorting = False
        VisibleForCustomization = False
        Width = 24
      end
      object cxGridGoods_GOODSID: TcxGridDBColumn
        AlternateCaption = 'Cod produs'
        Caption = 'Cod'
        DataBinding.FieldName = 'GOODSID'
        HeaderAlignmentHorz = taCenter
        MinWidth = 50
        Options.HorzSizing = False
        Width = 50
      end
      object cxGridGoods_WEBGOODSTYPE_TITLE: TcxGridDBColumn
        Caption = 'Categoria produse'
        DataBinding.FieldName = 'WEBGOODSTYPE_TITLE'
        HeaderAlignmentHorz = taCenter
        Width = 103
      end
      object cxGridGoods_VENDOR: TcxGridDBColumn
        AlternateCaption = 'Producator'
        Caption = 'Producator'
        DataBinding.FieldName = 'VENDOR'
        HeaderAlignmentHorz = taCenter
        Width = 83
      end
      object cxGridGoods_CODE: TcxGridDBColumn
        AlternateCaption = 'Model'
        Caption = 'Model'
        DataBinding.FieldName = 'CODE'
        HeaderAlignmentHorz = taCenter
        Width = 100
      end
      object cxGridGoods_BASE_PARAM: TcxGridDBColumn
        AlternateCaption = 'Parametru de baza'
        Caption = 'Parametru'
        DataBinding.FieldName = 'BASE_PARAM'
        HeaderAlignmentHorz = taCenter
        Width = 84
      end
      object cxGridGoods_FLG_SUPPLIER_PROMO: TcxGridDBColumn
        Caption = 'P'
        DataBinding.FieldName = 'FLG_SUPPLIER_PROMO'
        PropertiesClassName = 'TcxImageComboBoxProperties'
        Properties.Images = cxImageList1
        Properties.Items = <
          item
            Description = 'Promotie furnizor'
            ImageIndex = 4
            Value = '1'
          end>
        Visible = False
        HeaderAlignmentHorz = taCenter
        Options.Focusing = False
        Options.HorzSizing = False
        Width = 20
      end
      object cxGridGoods_TITLE: TcxGridDBColumn
        Caption = 'Produs'
        DataBinding.FieldName = 'TITLE'
        HeaderAlignmentHorz = taCenter
        MinWidth = 100
        Styles.OnGetContentStyle = cxGridGoods_TITLEStylesGetContentStyle
        VisibleForCustomization = False
        Width = 561
      end
      object cxGridGoods_UMID: TcxGridDBColumn
        DataBinding.FieldName = 'UMID'
        Visible = False
        HeaderAlignmentHorz = taCenter
        VisibleForCustomization = False
      end
      object cxGridGoods_UM_TITLE: TcxGridDBColumn
        AlternateCaption = 'Unitate metrica'
        Caption = 'UM'
        DataBinding.FieldName = 'UM_TITLE'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        MinWidth = 40
        Options.HorzSizing = False
        Width = 40
      end
      object cxGridGoods_PRICEC1_LEI: TcxGridDBColumn
        AlternateCaption = #1062#1077#1085#1072' 1'
        Caption = 'Credit, LEI'
        DataBinding.FieldName = 'PRICEC1_LEI'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        Visible = False
        HeaderAlignmentHorz = taCenter
        MinWidth = 80
        Options.HorzSizing = False
        Styles.OnGetContentStyle = cxGridGoods_PRICEC1_LEIStylesGetContentStyle
        VisibleForCustomization = False
        Width = 80
      end
      object cxGridGoods_PRICE4_LEI: TcxGridDBColumn
        AlternateCaption = 'Pret vinzare, lei'
        Caption = 'Online, LEI'
        DataBinding.FieldName = 'PRICE4_LEI'
        HeaderAlignmentHorz = taCenter
        MinWidth = 64
        Options.HorzSizing = False
        Width = 64
      end
      object cxGridGoods_PRICE5: TcxGridDBColumn
        Caption = 'intern, lei'
        DataBinding.FieldName = 'PRICE5_LEI'
        Visible = False
        HeaderAlignmentHorz = taCenter
      end
      object cxGridGoods_PRICE4: TcxGridDBColumn
        Caption = 'Pret 4'
        DataBinding.FieldName = 'PRICE4'
        Visible = False
        HeaderAlignmentHorz = taCenter
        MinWidth = 64
        Options.HorzSizing = False
        VisibleForCustomization = False
        Width = 64
      end
      object cxGridGoods_PRICE7: TcxGridDBColumn
        Caption = 'Pret 7'
        DataBinding.FieldName = 'PRICE7'
        HeaderAlignmentHorz = taCenter
        MinWidth = 64
        Options.HorzSizing = False
        Width = 64
      end
      object cxGridGoods_VAT: TcxGridDBColumn
        Caption = 'TVA, %'
        DataBinding.FieldName = 'VAT'
        HeaderAlignmentHorz = taCenter
        MinWidth = 48
        Options.HorzSizing = False
        Width = 48
      end
      object cxGridGoods_FLG_HAS_META: TcxGridDBColumn
        Caption = 'M'
        DataBinding.FieldName = 'FLG_HAS_META'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = '1'
        Properties.ValueUnchecked = '0'
        Visible = False
        HeaderAlignmentHorz = taCenter
        Options.HorzSizing = False
        Width = 20
      end
      object cxGridGoods_QTY_AVAILABLE: TcxGridDBColumn
        AlternateCaption = 'Cantitatea disponibila'
        Caption = 'Sold'
        DataBinding.FieldName = 'QTY_AVAILABLE'
        PropertiesClassName = 'TcxCalcEditProperties'
        Properties.Nullstring = ' '
        OnGetDisplayText = cxGridGoods_QTY_AVAILABLEGetDisplayText
        HeaderAlignmentHorz = taCenter
        MinWidth = 36
        Options.HorzSizing = False
        Styles.OnGetContentStyle = cxGridGoods_QTY_AVAILABLEStylesGetContentStyle
        VisibleForCustomization = False
        Width = 36
      end
      object cxGridGoods_QTY_FILIALE: TcxGridDBColumn
        AlternateCaption = 'Cantitate disponibila in alte subdiviziuni'
        Caption = 'SF'
        DataBinding.FieldName = 'QTY_FILIALE'
        PropertiesClassName = 'TcxCalcEditProperties'
        Properties.Nullstring = ' '
        Visible = False
        OnGetDisplayText = cxGridGoods_QTY_AVAILABLEGetDisplayText
        HeaderAlignmentHorz = taCenter
        MinWidth = 36
        Options.HorzSizing = False
        Width = 36
      end
      object cxGridGoods_QTY_FRANCIZE: TcxGridDBColumn
        AlternateCaption = #1054#1089#1090#1072#1090#1086#1082' '#1087#1086' '#1092#1088#1072#1085#1095#1080#1079#1072#1084
        Caption = #1060#1088#1095'.'
        DataBinding.FieldName = 'QTY_FRANCIZE'
        PropertiesClassName = 'TcxCalcEditProperties'
        Visible = False
        OnGetDisplayText = cxGridGoods_QTY_AVAILABLEGetDisplayText
        HeaderAlignmentHorz = taCenter
        MinWidth = 30
        VisibleForCustomization = False
        Width = 53
      end
      object cxGridGoods_QTY_INTERNAL: TcxGridDBColumn
        AlternateCaption = 'Cant, Uz Intern'
        Caption = 'Adm'
        DataBinding.FieldName = 'QTY_INTERNAL'
        PropertiesClassName = 'TcxCalcEditProperties'
        Visible = False
        OnGetDisplayText = cxGridGoods_QTY_AVAILABLEGetDisplayText
        HeaderAlignmentHorz = taCenter
        MinWidth = 30
        Width = 53
      end
      object cxGridGoods_QTY_RMA: TcxGridDBColumn
        AlternateCaption = 'Cant, RMA'
        Caption = 'RMA'
        DataBinding.FieldName = 'QTY_RMA'
        PropertiesClassName = 'TcxCalcEditProperties'
        Visible = False
        OnGetDisplayText = cxGridGoods_QTY_AVAILABLEGetDisplayText
        HeaderAlignmentHorz = taCenter
        MinWidth = 30
        VisibleForCustomization = False
        Width = 53
      end
      object cxGridGoods_QTY_ACCOUNT: TcxGridDBColumn
        AlternateCaption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1087#1086' '#1073#1091#1093#1075#1072#1083#1090#1077#1088#1080#1080
        Caption = #1041#1091#1093
        DataBinding.FieldName = 'QTY_ACCOUNT'
        Visible = False
        HeaderAlignmentHorz = taCenter
        MinWidth = 30
        Options.Filtering = False
        Options.HorzSizing = False
        VisibleForCustomization = False
        Width = 30
      end
      object cxGridGoods_QTY_TRANSIT: TcxGridDBColumn
        AlternateCaption = #1058#1086#1074#1072#1088#1086#1074' '#1074' '#1087#1077#1088#1077#1084#1077#1097#1077#1085#1080#1103#1093
        Caption = #1058#1088#1072#1085#1079
        DataBinding.FieldName = 'QTY_TRANSIT'
        PropertiesClassName = 'TcxCalcEditProperties'
        Visible = False
        OnGetDisplayText = cxGridGoods_QTY_AVAILABLEGetDisplayText
        HeaderAlignmentHorz = taCenter
        MinWidth = 30
        VisibleForCustomization = False
        Width = 53
      end
      object cxGridGoods_WARRANTY: TcxGridDBColumn
        AlternateCaption = 'Garantie'
        Caption = 'Garantie'
        DataBinding.FieldName = 'WARRANTY'
        HeaderAlignmentHorz = taCenter
        MinWidth = 36
        Options.IncSearch = False
        Options.Grouping = False
        Options.HorzSizing = False
        Options.Sorting = False
        Width = 36
      end
      object cxGridGoods_FLG_NEW: TcxGridDBColumn
        AlternateCaption = 'FLG_NEW'
        Caption = 'NEW'
        DataBinding.FieldName = 'FLG_NEW'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        Visible = False
        HeaderAlignmentHorz = taCenter
        MinWidth = 36
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 36
      end
      object cxGridGoods_FLG_PRICE_FORCED: TcxGridDBColumn
        AlternateCaption = 'INSTOCK'
        Caption = 'PF'
        DataBinding.FieldName = 'FLG_PRICE_FORCED'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        HeaderAlignmentHorz = taCenter
        MinWidth = 30
        Options.Editing = False
        Options.Focusing = False
        Options.Grouping = False
        Options.HorzSizing = False
        Options.Sorting = False
        Width = 30
      end
      object cxGridGoods_FLG_PREODRDER: TcxGridDBColumn
        AlternateCaption = 'Pre Order'
        Caption = 'Pre'
        DataBinding.FieldName = 'FLG_PREORDER'
        Width = 41
      end
      object cxGridGoods_FLG_SOCIAL: TcxGridDBColumn
        AlternateCaption = 'Produs social'
        Caption = 'IS'
        DataBinding.FieldName = 'FLG_SOCIAL'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = '1'
        Properties.ValueUnchecked = '0'
        HeaderAlignmentHorz = taCenter
        MinWidth = 24
        Options.HorzSizing = False
        Width = 24
      end
      object cxGridGoods_FLG_DISCOUNT: TcxGridDBColumn
        AlternateCaption = 'FLG_DISCOUNT'
        Caption = 'DISC'
        DataBinding.FieldName = 'FLG_DISCOUNT'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        Visible = False
        HeaderAlignmentHorz = taCenter
        MinWidth = 36
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 36
      end
      object cxGridGoods_FLG_OLD: TcxGridDBColumn
        AlternateCaption = 'FLG_OLD'
        Caption = 'OLD'
        DataBinding.FieldName = 'FLG_OLD'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        Visible = False
        HeaderAlignmentHorz = taCenter
        MinWidth = 30
        Options.Grouping = False
        Options.HorzSizing = False
        VisibleForCustomization = False
        Width = 30
      end
      object cxGridGoods_FLG_ATTRS_INCOMPLETE: TcxGridDBColumn
        AlternateCaption = 'Attrs incomplete'
        Caption = #1053#1077#1087#1086#1083#1085'.'
        DataBinding.FieldName = 'FLG_ATTRS_INCOMPLETE'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ReadOnly = True
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        HeaderAlignmentHorz = taCenter
        MinWidth = 40
        Options.Editing = False
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 40
      end
      object cxGridGoods_FLG_FORCED_ADDON: TcxGridDBColumn
        AlternateCaption = 'Forced Addon'
        Caption = 'FA'
        DataBinding.FieldName = 'FLG_FORCED_ADDON'
        PropertiesClassName = 'TcxImageComboBoxProperties'
        Properties.ClearKey = 119
        Properties.Images = dmAdditions.ilFlags
        Properties.Items = <
          item
            Description = #1084#1085#1086#1075#1086
            ImageIndex = 1
            Value = 1
          end>
        Visible = False
        VisibleForExpressionEditor = bTrue
        HeaderAlignmentHorz = taCenter
        MinWidth = 24
        Options.Focusing = False
        Options.HorzSizing = False
        VisibleForCustomization = False
        Width = 24
      end
      object cxGridGoods_FLG_REQUIRE_CERTIFICAT: TcxGridDBColumn
        AlternateCaption = 'FLG_REQUIRE_CERTIFICAT (RC)'
        Caption = 'RC'
        DataBinding.FieldName = 'FLG_REQUIRE_CERTIFICAT'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        Visible = False
        HeaderAlignmentHorz = taCenter
        MinWidth = 36
        Options.Editing = False
        Options.Grouping = False
        Options.HorzSizing = False
        Options.Sorting = False
        VisibleForCustomization = False
        Width = 36
      end
      object cxGridGoods_FLG_FOLDER: TcxGridDBColumn
        DataBinding.FieldName = 'FLG_FOLDER'
        Visible = False
        HeaderAlignmentHorz = taCenter
        VisibleForCustomization = False
      end
      object cxGridGoods_GOODS_TYPE_NAME: TcxGridDBColumn
        Caption = #1090#1080#1087' '#1091#1095#1077#1090#1072
        DataBinding.FieldName = 'GOODS_TYPE_NAME'
        Visible = False
        HeaderAlignmentHorz = taCenter
      end
      object cxGridGoods_MINQTY: TcxGridDBColumn
        Caption = 'Min Qty'
        DataBinding.FieldName = 'MINQTY'
        Visible = False
        HeaderAlignmentHorz = taCenter
        VisibleForCustomization = False
        VisibleForEditForm = bFalse
      end
      object cxGridGoods_DELIVERY_TYPEID: TcxGridDBColumn
        Caption = 'tip livrare'
        DataBinding.FieldName = 'DELIVERY_TYPEID'
        Visible = False
        HeaderAlignmentHorz = taCenter
        VisibleForCustomization = False
      end
      object cxGridGoods_FLG_PROMO: TcxGridDBColumn
        AlternateCaption = 'Promotie furnizor'
        Caption = 'FP'
        DataBinding.FieldName = 'FLG_PROMO'
        PropertiesClassName = 'TcxImageComboBoxProperties'
        Properties.Images = cxImageList1
        Properties.Items = <
          item
            ImageIndex = 6
            Tag = 1
            Value = 1
          end>
        HeaderAlignmentHorz = taCenter
        MinWidth = 24
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 24
      end
      object cxGridGoods_DELIVERY_TYPENAME: TcxGridDBColumn
        AlternateCaption = 'Livrare'
        Caption = 'L'
        DataBinding.FieldName = 'DELIVERY_TYPENAME'
        Visible = False
        HeaderAlignmentHorz = taCenter
        Options.Focusing = False
        Width = 41
      end
      object cxGridGoods_MARGIN17: TcxGridDBColumn
        Caption = '%'
        DataBinding.FieldName = 'MARGIN17'
        PropertiesClassName = 'TcxCalcEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 32
        Options.HorzSizing = False
        Width = 32
      end
      object cxGridGoods_FLG_HAS_KEYS: TcxGridDBColumn
        Caption = 'K'
        DataBinding.FieldName = 'FLG_HAS_KEYS'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = '1'
        Properties.ValueGrayed = 0
        Properties.ValueUnchecked = '0'
        Visible = False
        HeaderAlignmentHorz = taCenter
        MinWidth = 24
        Options.HorzSizing = False
        VisibleForCustomization = False
        Width = 24
      end
      object cxGridGoods_TableColumn1: TcxGridDBColumn
        Caption = 'Web title'
        DataBinding.FieldName = 'TITLE_WEB'
      end
    end
    object cxGridGoodsLevel: TcxGridLevel
      GridView = cxGridGoods_Table
    end
  end
  object cxPageControlAddons: TcxPageControl
    Left = 0
    Top = 536
    Width = 1466
    Height = 72
    Align = alBottom
    Focusable = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    Visible = False
    Properties.ActivePage = tbsGeneralInfo
    Properties.CustomButtons.Buttons = <>
    Properties.TabPosition = tpBottom
    OnChange = cxPageControlAddonsChange
    ClientRectBottom = 46
    ClientRectLeft = 4
    ClientRectRight = 1462
    ClientRectTop = 4
    object tbsGeneralInfo: TcxTabSheet
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'Informatie generala (&1)'
      ImageIndex = 12
    end
    object tbsStocks: TcxTabSheet
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'Disponibilitate (&2)'
      ImageIndex = 27
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object cxGridStockFirma: TcxGrid
        Left = 0
        Top = 0
        Width = 744
        Height = 42
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Align = alLeft
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        TabStop = False
        object cxGridStockFirmaTable: TcxGridDBTableView
          OnFocusedRecordChanged = cxGridStockFirmaTableFocusedRecordChanged
          DataController.DataSource = IBCDataSourceStockFirms
          DataController.KeyFieldNames = 'DT'
          FilterRow.SeparatorWidth = 11
          FixedDataRows.SeparatorWidth = 11
          NewItemRow.SeparatorWidth = 11
          OptionsCustomize.ColumnFiltering = False
          OptionsCustomize.ColumnsQuickCustomization = True
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsSelection.HideSelection = True
          OptionsView.NavigatorOffset = 88
          OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1074' '#1085#1072#1083#1080#1095#1080#1077'>'
          OptionsView.ScrollBars = ssVertical
          OptionsView.ColumnAutoWidth = True
          OptionsView.GridLineColor = 13750737
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          OptionsView.IndicatorWidth = 21
          Preview.LeftIndent = 35
          Preview.RightIndent = 9
          RowLayout.MinValueWidth = 140
          Styles.OnGetContentStyle = cxGridStockFirmaTableStylesGetContentStyle
          object cxGridStockFirma_CUSTOMERID: TcxGridDBColumn
            Caption = #1050#1086#1076
            DataBinding.FieldName = 'CUSTOMERID'
            Visible = False
            HeaderAlignmentHorz = taCenter
            MinWidth = 88
            Options.HorzSizing = False
            Width = 88
          end
          object cxGridStockFirmaTable_IMG: TcxGridDBColumn
            PropertiesClassName = 'TcxImageComboBoxProperties'
            Properties.DefaultImageIndex = 11
            Properties.Items = <>
            HeaderAlignmentHorz = taCenter
            MinWidth = 42
            Options.ShowEditButtons = isebNever
            Options.HorzSizing = False
            Options.Sorting = False
            Width = 42
          end
          object cxGridStockFirmaTable_FIRMA: TcxGridDBColumn
            Caption = 'Subdiviziune'
            DataBinding.FieldName = 'NAME'
            HeaderAlignmentHorz = taCenter
            MinWidth = 35
            Options.Sorting = False
          end
          object cxGridStockFirmaTable_QTY: TcxGridDBColumn
            Caption = 'Stock'
            DataBinding.FieldName = 'QTY'
            PropertiesClassName = 'TcxCalcEditProperties'
            HeaderAlignmentHorz = taCenter
            MinWidth = 140
            Options.HorzSizing = False
            Width = 140
          end
          object cxGridStockFirmaTable_TRANSIT_QTY: TcxGridDBColumn
            Caption = 'In transferuri'
            DataBinding.FieldName = 'TRANSFER_QTY'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00'
            HeaderAlignmentHorz = taCenter
            MinWidth = 193
            Options.HorzSizing = False
            Styles.OnGetContentStyle = cxGridStockFirmaTable_TRANSIT_QTYStylesGetContentStyle
            Width = 193
          end
        end
        object cxGridStockFirmaLevel: TcxGridLevel
          GridView = cxGridStockFirmaTable
        end
      end
      object cxGridStocks: TcxGrid
        AlignWithMargins = True
        Left = 748
        Top = 0
        Width = 1892
        Height = 42
        Margins.Left = 4
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alLeft
        Anchors = [akLeft, akTop, akRight, akBottom]
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        object cxGridStocksTable: TcxGridDBTableView
          DataController.DataSource = IBCDataSourceStockWarehouse
          DataController.KeyFieldNames = 'STOCKID'
          FilterRow.SeparatorWidth = 11
          FixedDataRows.SeparatorWidth = 11
          NewItemRow.SeparatorWidth = 11
          OptionsCustomize.ColumnFiltering = False
          OptionsCustomize.ColumnsQuickCustomization = True
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsSelection.InvertSelect = False
          OptionsView.NavigatorOffset = 88
          OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1074' '#1085#1072#1083#1080#1095#1080#1077' '#1074' '#1090#1077#1082#1091#1097#1077#1081' '#1060#1080#1088#1084#1077'>'
          OptionsView.ScrollBars = ssVertical
          OptionsView.ColumnAutoWidth = True
          OptionsView.GridLineColor = 13750737
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          OptionsView.IndicatorWidth = 21
          Preview.LeftIndent = 35
          Preview.RightIndent = 9
          RowLayout.MinValueWidth = 140
          object cxGridStocksTableColumn1: TcxGridDBColumn
            Caption = #1050#1086#1076
            DataBinding.FieldName = 'STOCKID'
            Visible = False
            HeaderAlignmentHorz = taCenter
            MinWidth = 70
            Options.HorzSizing = False
            Width = 70
          end
          object cxGridStocks_IMAGE: TcxGridDBColumn
            PropertiesClassName = 'TcxImageComboBoxProperties'
            Properties.DefaultImageIndex = 27
            Properties.Items = <>
            HeaderAlignmentHorz = taCenter
            MinWidth = 42
            Options.HorzSizing = False
            Width = 42
          end
          object cxGridStocksTableColumn2: TcxGridDBColumn
            Caption = 'Depozit'
            DataBinding.FieldName = 'TITLE'
            HeaderAlignmentHorz = taCenter
            MinWidth = 35
            Width = 866
          end
          object cxGridStocksTableColumn3: TcxGridDBColumn
            Caption = 'Sold'
            DataBinding.FieldName = 'QTY'
            PropertiesClassName = 'TcxCalcEditProperties'
            HeaderAlignmentHorz = taCenter
            MinWidth = 140
            Options.HorzSizing = False
            Width = 140
          end
        end
        object cxGridStocksLevel: TcxGridLevel
          GridView = cxGridStocksTable
        end
      end
    end
  end
  object Panel5: TPanel
    Left = 0
    Top = 30
    Width = 1466
    Height = 31
    Align = alTop
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clGray
    ParentBackground = False
    TabOrder = 1
    DesignSize = (
      1462
      27)
    object lbPath: TLabel
      Left = 15
      Top = 6
      Width = 1426
      Height = 18
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Caption = '..'
      Font.Charset = ANSI_CHARSET
      Font.Color = clCream
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      ExplicitWidth = 1427
    end
    object Shape1: TShape
      Left = 1733
      Top = 2
      Width = 89
      Height = 44
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Anchors = [akTop, akRight]
      Pen.Color = clGray
      Pen.Width = 2
      Shape = stRoundRect
      ExplicitLeft = 1734
    end
    object lbRecCount: TcxLabel
      Left = 1615
      Top = 2
      Anchors = [akTop, akRight]
      AutoSize = False
      Caption = '0'
      ParentColor = False
      ParentFont = False
      Style.Color = clBlack
      Style.TextColor = clMenuHighlight
      Style.TextStyle = [fsBold]
      Properties.Alignment.Horz = taRightJustify
      TabOrder = 0
      Transparent = True
      Height = 17
      Width = 43
      AnchorX = 1658
    end
  end
  object dxStatusBar1: TdxStatusBar
    Left = 0
    Top = 608
    Width = 1466
    Height = 20
    Panels = <
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Width = 64
      end>
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object dxBarManager: TdxBarManager
    AllowReset = False
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    CanCustomize = False
    Categories.Strings = (
      'Default'
      'Navigation'
      'Goods'
      'Search'
      'More'
      #1040#1085#1072#1083#1080#1079' '#1094#1077#1085
      'Close')
    Categories.ItemsVisibles = (
      2
      2
      2
      2
      2
      2
      2)
    Categories.Visibles = (
      True
      True
      True
      True
      True
      True
      True)
    ImageOptions.Images = dmAdditions.cxImageList_SWN
    ImageOptions.StretchGlyphs = False
    ImageOptions.UseLeftBottomPixelAsTransparent = False
    LookAndFeel.SkinName = ''
    NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
    PopupMenuLinks = <>
    SunkenBorder = True
    UseSystemFont = False
    Left = 376
    Top = 144
    PixelsPerInch = 96
    object dxBarManagerBar1: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Goods'
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 848
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbOK'
        end
        item
          Visible = True
          ItemName = 'bbCancel'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbHome'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbBack'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbForward'
        end
        item
          Visible = True
          ItemName = 'bbRefresh'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarGoodsSubItems'
        end
        item
          Visible = True
          ItemName = 'dxAddonsSubItems'
        end
        item
          Visible = True
          ItemName = 'bbTools'
        end
        item
          Visible = True
          ItemName = 'bsiWeb'
        end
        item
          Visible = True
          ItemName = 'dxBarSubItemVIEW'
        end
        item
          Visible = True
          ItemName = 'bbBurstMode'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'miMultiSelect'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbSearch'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbPrint'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object dxBarSubItemVIEW: TdxBarSubItem
      Caption = 'View'
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbShowAvailableGoods'
        end
        item
          Visible = True
          ItemName = 'bbPriceMargins'
        end
        item
          Visible = True
          ItemName = 'bbWebCatalogPath'
        end
        item
          Visible = True
          ItemName = 'bbFastMode'
        end
        item
          Visible = True
          ItemName = 'dxBarButton12'
        end
        item
          Visible = True
          ItemName = 'dxBarButton13'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbGoodsImages'
        end>
      OnPopup = dxBarSubItemVIEWPopup
    end
    object bbShowAvailableGoods: TdxBarButton
      Caption = 'Disponibilitatea'
      Category = 0
      Hint = 'Disponibilitatea'
      Visible = ivAlways
      ShortCut = 16456
      OnClick = bbShowAvailableGoodsClick
    end
    object bbQuickGoodsInfo: TdxBarButton
      Caption = 'Informatie despre produs'
      Category = 0
      Hint = 'Informatie despre produs'
      Visible = ivAlways
      ShortCut = 112
      OnClick = bbQuickGoodsInfoClick
    end
    object bbCloneGoods: TdxBarButton
      Caption = 'Clonare produs'
      Category = 0
      Hint = 'Clonare produs'
      Visible = ivAlways
      ImageIndex = 29
      ShortCut = 49220
      OnClick = bbCloneGoodsClick
    end
    object miMultiSelect: TdxBarButton
      Caption = 'Selectare multipla'
      Category = 0
      Hint = 'Selectare multipla'
      Visible = ivAlways
      ButtonStyle = bsChecked
      Down = True
      ImageIndex = 29
      ShortCut = 49229
      OnClick = miMultiSelectClick
    end
    object bbGoodsPrice: TdxBarButton
      Caption = 'Modificare preturi produs'
      Category = 0
      Hint = 'Modificare preturi produs'
      Visible = ivAlways
      OnClick = bbGoodsPriceClick
    end
    object bbForeignCodes: TdxBarButton
      Caption = 'Produse cu codurile furnizorilor'
      Category = 0
      Hint = 'Produse cu codurile furnizorilor'
      Visible = ivAlways
      ShortCut = 16474
      OnClick = bbForeignCodesClick
    end
    object bbSet_FLG_OLD: TdxBarButton
      Caption = 'Modifica FLG_OLD'
      Category = 0
      Hint = 'Modifica FLG_OLD'
      Visible = ivAlways
      ShortCut = 16469
      OnClick = bbSet_FLG_OLDClick
    end
    object bbMergeGoods: TdxBarButton
      Caption = 'Fuzioneaza 2 produse'
      Category = 0
      Hint = 'Fuzioneaza 2 produse'
      Visible = ivAlways
      ShortCut = 32838
      OnClick = bbMergeGoodsClick
    end
    object bbTools: TdxBarSubItem
      Caption = 'Instrumente'
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbMergeGoods'
        end
        item
          Visible = True
          ItemName = 'bbChangeSupplierToAnother'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbSetupPropsToSelection'
        end
        item
          Visible = True
          ItemName = 'bbUpdateTitle'
        end
        item
          Visible = True
          ItemName = 'bbChangeFiltersValue'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbSet_FLG_OLD'
        end
        item
          Visible = True
          ItemName = 'bsubFlgNewGoods'
        end
        item
          Visible = True
          ItemName = 'bsubFlgPromoGoods'
        end
        item
          Visible = True
          ItemName = 'bbSubWebFLG_DISCOUNT'
        end
        item
          Visible = True
          ItemName = 'bbAddToWebCatalog'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbForcedAnalize'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbReCalcGoodsStock'
        end
        item
          Visible = True
          ItemName = 'bbRecalcComplectPrice'
        end
        item
          Visible = True
          ItemName = 'bbConvertGIF2PNG'
        end
        item
          Visible = True
          ItemName = 'bbConvertJPEG2PNG'
        end
        item
          Visible = True
          ItemName = 'dxBarButton9'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbGoodsTitle'
        end
        item
          Visible = True
          ItemName = 'bbAnalizer'
        end
        item
          Visible = True
          ItemName = 'bbMoveToArchive'
        end
        item
          Visible = True
          ItemName = 'bbAddToPromo'
        end
        item
          Visible = True
          ItemName = 'bbModifyFiltersParams'
        end>
    end
    object bbFollowGoods: TdxBarButton
      Caption = 'Treci in mapa produsului'
      Category = 0
      Hint = 'Treci in mapa produsului'
      Visible = ivAlways
      ShortCut = 32
      OnClick = bbFollowGoodsClick
    end
    object bbSetupPropsToSelection: TdxBarButton
      Caption = 'Setarea proprietatilor pentru produsele selectate'
      Category = 0
      Hint = 'Setarea proprietatilor pentru produsele selectate'
      Visible = ivAlways
      ShortCut = 32851
      OnClick = bbSetupPropsToSelectionClick
    end
    object bbReCalcGoodsStock: TdxBarButton
      Caption = 'Recalcula sold produs'
      Category = 0
      Hint = 'Recalcula sold produs'
      Visible = ivAlways
      OnClick = bbReCalcGoodsStockClick
    end
    object bbGoodsInfoCard: TdxBarButton
      Caption = 'Miscarea produsului...'
      Category = 0
      Hint = 'Miscarea produsului'
      Visible = ivAlways
      ShortCut = 16463
      OnClick = bbGoodsInfoCardClick
    end
    object bsubFlgNewGoods: TdxBarSubItem
      Caption = 'Web flg - Produs Nou'
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarButton1'
        end
        item
          Visible = True
          ItemName = 'dxBarButton2'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton7'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton3'
        end>
    end
    object dxBarButton1: TdxBarButton
      Tag = 60
      Caption = 'pentru urmatoarele 60 zile'
      Category = 0
      Hint = 'pentru urmatoarele 60 zile'
      Visible = ivAlways
      OnClick = dxBarButton1Click
    end
    object dxBarButton2: TdxBarButton
      Tag = 30
      Caption = 'pentru urmatoarele 30 zile'
      Category = 0
      Hint = 'pentru urmatoarele 30 zile'
      Visible = ivAlways
      OnClick = dxBarButton1Click
    end
    object dxBarButton3: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 35
      OnClick = dxBarButton1Click
    end
    object bsubFlgPromoGoods: TdxBarSubItem
      Caption = 'Web flg - Produs Promo'
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarButton4'
        end
        item
          Visible = True
          ItemName = 'dxBarButton6'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton8'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton5'
        end>
    end
    object dxBarButton4: TdxBarButton
      Tag = 60
      Caption = 'pentru urmatoarele 60 zile'
      Category = 0
      Hint = 'pentru urmatoarele 60 zile'
      Visible = ivAlways
      OnClick = dxBarButton4Click
    end
    object dxBarButton5: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 35
      OnClick = dxBarButton4Click
    end
    object dxBarButton6: TdxBarButton
      Tag = 30
      Caption = 'pentru urmatoarele 30 zile'
      Category = 0
      Hint = 'pentru urmatoarele 30 zile'
      Visible = ivAlways
      OnClick = dxBarButton4Click
    end
    object bbSubWebFLG_DISCOUNT: TdxBarSubItem
      Caption = 'Web flg - Produs cu reducere'
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbWEB_FLG_DISCOUNT_Edit'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbWEB_FLG_DISCOUNT_Delete'
        end>
    end
    object bbWEB_FLG_DISCOUNT_Edit: TdxBarButton
      Caption = 'Modifica'
      Category = 0
      Hint = 'Modifica'
      Visible = ivAlways
      OnClick = bbWEB_FLG_DISCOUNT_EditClick
    end
    object bbWEB_FLG_DISCOUNT_Delete: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 35
      OnClick = bbWEB_FLG_DISCOUNT_DeleteClick
    end
    object bbPriceMargins: TdxBarButton
      Caption = 'Rentabilitatea'
      Category = 0
      Hint = 'Rentabilitatea'
      Visible = ivAlways
      ButtonStyle = bsChecked
      ShortCut = 16466
    end
    object bbPrint: TdxBarButton
      Caption = 'Tipar'
      Category = 0
      Hint = 'Tipar'
      Visible = ivAlways
      ImageIndex = 28
      ShortCut = 16464
      OnClick = bbPrintClick
    end
    object bbBalansPoPartiam: TdxBarButton
      Caption = 'Bilanta pe partide'
      Category = 0
      Hint = 'Bilanta pe partide'
      Visible = ivAlways
      ImageIndex = 31
      ShortCut = 49232
      OnClick = bbBalansPoPartiamClick
    end
    object bbAviableSnPartsNumbers: TdxBarButton
      Caption = 'Seriile disponibile'
      Category = 0
      Hint = 'Seriile disponibile'
      Visible = ivAlways
      ImageIndex = 31
      ShortCut = 49230
      OnClick = bbAviableSnPartsNumbersClick
    end
    object dxBarButton7: TdxBarButton
      Caption = 'Seteaza perioada'
      Category = 0
      Hint = 'Seteaza perioada'
      Visible = ivAlways
      ImageIndex = 37
      OnClick = dxBarButton7Click
    end
    object dxBarButton8: TdxBarButton
      Caption = 'Seteaza perioada manual...'
      Category = 0
      Hint = 'Seteaza perioada manual'
      Visible = ivAlways
      ImageIndex = 37
      OnClick = dxBarButton8Click
    end
    object bbSendToNPSC: TdxBarButton
      Caption = 'NPSC - Trimite pentru descriere...'
      Category = 0
      Hint = 'NPSC - Trimite pentru descriere'
      Visible = ivAlways
      OnClick = bbSendToNPSCClick
    end
    object bbConvertGIF2PNG: TdxBarButton
      Caption = 'Converteaza GIF in PNG imaginea'
      Category = 0
      Hint = 'Converteaza GIF in PNG imaginea'
      Visible = ivAlways
      OnClick = bbConvertGIF2PNGClick
    end
    object bbAnalizer: TdxBarButton
      Caption = 'Analiza produs'
      Category = 0
      Hint = 'Analiza produs'
      Visible = ivAlways
      OnClick = bbAnalizerClick
    end
    object bbRecalcComplectPrice: TdxBarButton
      Caption = 'Recalcula pret complect'
      Category = 0
      Hint = 'Recalcula pret complect'
      Visible = ivAlways
      OnClick = bbRecalcComplectPriceClick
    end
    object dxBarButton10: TdxBarButton
      Caption = 'Descriere pentru website'
      Category = 0
      Hint = 'Descriere pentru website'
      Visible = ivAlways
      ImageIndex = 69
      OnClick = dxBarButton10Click
    end
    object bbLoanOffer: TdxBarButton
      Caption = 'Oferta pe Credit'
      Category = 0
      Hint = 'Oferta pe Credit'
      Visible = ivAlways
      ShortCut = 49228
      OnClick = bbLoanOfferClick
    end
    object bbConvertJPEG2PNG: TdxBarButton
      Caption = 'Converteaza JPEG in PNG imaginea'
      Category = 0
      Hint = 'Converteaza JPEG in PNG imaginea'
      Visible = ivAlways
      OnClick = bbConvertJPEG2PNGClick
    end
    object bbGoodsPricePolicy: TdxBarButton
      Caption = 'Politica de preturi'
      Category = 0
      Hint = 'Politica de preturi'
      Visible = ivAlways
      ShortCut = 32848
      OnClick = bbGoodsPricePolicyClick
    end
    object bbForcedAnalize: TdxBarButton
      Caption = 'Analiza flag forced...'
      Category = 0
      Hint = 'Analiza flag forced'
      Visible = ivAlways
      OnClick = bbForcedAnalizeClick
    end
    object bbMoveToArchive: TdxBarButton
      Caption = 'Transfera produsele vechi in archiva'
      Category = 0
      Hint = 'Transfera produsele vechi in archiva'
      Visible = ivAlways
      OnClick = bbMoveToArchiveClick
    end
    object bbSendToArchive: TdxBarButton
      Caption = 'Trimite in arhiva...'
      Category = 0
      Hint = 'Trimite in arhiva'
      Visible = ivAlways
      ShortCut = 24622
      OnClick = bbSendToArchiveClick
    end
    object bbGoodsImages: TdxBarButton
      Caption = 'Imaginea produsului'
      Category = 0
      Hint = 'Imaginea produsului'
      Visible = ivAlways
      ShortCut = 16457
      OnClick = bbGoodsImagesClick
    end
    object bbWebCatalogPath: TdxBarButton
      Caption = 'Web catalog path'
      Category = 0
      Hint = 'Web catalog path'
      Visible = ivAlways
      ShortCut = 32855
      OnClick = bbWebCatalogPathClick
    end
    object bbGoodsTitle: TdxBarButton
      Caption = 'Denumirea produsului'
      Category = 0
      Hint = 'Denumirea produsului'
      Visible = ivAlways
      OnClick = bbGoodsTitleClick
    end
    object bbGoodsAttributes: TdxBarButton
      Caption = 'Atribute web'
      Category = 0
      Hint = 'Atribute web'
      Visible = ivAlways
      ShortCut = 32833
      OnClick = bbGoodsAttributesClick
    end
    object bbAddToPromo: TdxBarButton
      Caption = 'Aduga produsul in promotie...'
      Category = 0
      Hint = 'Aduga produsul in promotie'
      Visible = ivAlways
      OnClick = bbAddToPromoClick
    end
    object dxBarButton9: TdxBarButton
      Caption = 'Convert to WebP'
      Category = 0
      Hint = 'Convert to WebP'
      Visible = ivAlways
      OnClick = dxBarButton9Click
    end
    object bbUpdateTitle: TdxBarButton
      Caption = 'Ajusteaza denumireade sistema produsului'
      Category = 0
      Hint = 'Ajusteaza denumireade sistema produsului'
      Visible = ivAlways
      ShortCut = 41043
      OnClick = bbUpdateTitleClick
    end
    object bbRelatedProducts: TdxBarButton
      Caption = 'Produse inrudite'
      Category = 0
      Hint = 'Produse inrudite'
      Visible = ivAlways
      ShortCut = 114
      OnClick = bbRelatedProductsClick
    end
    object bbChangeSupplierToAnother: TdxBarButton
      Caption = 'Schimba furnizorul produselor pe altul'
      Category = 0
      Hint = 'Schimba furnizorul produselor pe altul'
      Visible = ivAlways
      OnClick = bbChangeSupplierToAnotherClick
    end
    object bbModifyFiltersParams: TdxBarButton
      Caption = 'Modifica valorile filtrelor in caracteristicile produselor'
      Category = 0
      Hint = 'Modifica valorile filtrelor in caracteristicile produselor'
      Visible = ivAlways
      OnClick = bbModifyFiltersParamsClick
    end
    object dxBarButton11: TdxBarButton
      Caption = 'Importa cheile din alt produs'
      Category = 0
      Hint = 'Importa cheile din alt produs'
      Visible = ivAlways
      ShortCut = 32882
      OnClick = dxBarButton11Click
    end
    object bbBurstMode: TdxBarButton
      Caption = 'Adaugare rapida'
      Category = 0
      Hint = 'Adaugare rapida'
      Visible = ivAlways
      ImageIndex = 71
    end
    object cxBarEditItem1: TcxBarEditItem
      Caption = 'New Item'
      Category = 0
      Hint = 'New Item'
      Visible = ivAlways
      PropertiesClassName = 'TdxOfficeSearchBoxProperties'
      Properties.BarManager = dxBarManager
    end
    object bbAddToWebCatalog: TdxBarButton
      Caption = 'Adauga la WebCatalog'
      Category = 0
      Hint = 'Adauga la WebCatalog'
      Visible = ivAlways
      ShortCut = 16471
      OnClick = bbAddToWebCatalogClick
    end
    object bbFastMode: TdxBarButton
      Caption = 'Fast mode'
      Category = 0
      Hint = 'Fast mode'
      Visible = ivNever
      ButtonStyle = bsChecked
      DropDownMenu = dxBarPopupMenu
    end
    object bbRefresh: TdxBarButton
      Caption = 'Refresh'
      Category = 0
      Hint = 'Refresh'
      Visible = ivAlways
      ImageIndex = 36
      ShortCut = 116
      OnClick = bbRefreshClick
    end
    object bbChangeFiltersValue: TdxBarButton
      Caption = 'Modifica filtre si valori...'
      Category = 0
      Hint = 'Modifica filtre si valori'
      Visible = ivAlways
      ShortCut = 41030
      OnClick = bbChangeFiltersValueClick
    end
    object bsiWeb: TdxBarSubItem
      Caption = 'Web'
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbShowGoodsTypeFolders'
        end>
    end
    object bbShowGoodsTypeFolders: TdxBarButton
      Caption = 'Arata mapele cu acest tip de produs'
      Category = 0
      Hint = 'Arata mapele cu acest tip de produs'
      Visible = ivAlways
      ShortCut = 24653
      OnClick = bbShowGoodsTypeFoldersClick
    end
    object dxBarButton12: TdxBarButton
      Caption = 'Preview'
      Category = 0
      Hint = 'Preview'
      Visible = ivAlways
      OnClick = dxBarButton12Click
    end
    object dxBarButton13: TdxBarButton
      Caption = 'Produse grupate dupa categorie in mapa'
      Category = 0
      Hint = 'Produse grupate dupa categorie in mapa'
      Visible = ivAlways
      OnClick = dxBarButton13Click
    end
    object bbAcntGoods: TdxBarButton
      Caption = 'Produse in contabilitate'
      Category = 0
      Hint = 'Produse in contabilitate'
      Visible = ivAlways
      OnClick = bbAcntGoodsClick
    end
    object bbHome: TdxBarButton
      Caption = 'Inceput'
      Category = 1
      Hint = 'Inceput'
      Visible = ivAlways
      ImageIndex = 27
      OnClick = bbHomeClick
    end
    object bbBack: TdxBarButton
      Caption = 'Inapoi'
      Category = 1
      Hint = 'Inapoi'
      Visible = ivAlways
      ImageIndex = 6
      OnClick = bbBackClick
    end
    object bbForward: TdxBarButton
      Caption = 'Inainte'
      Category = 1
      Hint = 'Inainte'
      Visible = ivAlways
      ImageIndex = 7
      OnClick = bbForwardClick
    end
    object dxBarGoodsSubItems: TdxBarSubItem
      Caption = 'Produs'
      Category = 2
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbQuickGoodsInfo'
        end
        item
          Visible = True
          ItemName = 'bbGoodsDescriptions'
        end
        item
          Visible = True
          ItemName = 'bbFollowGoods'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbNewFolder'
        end
        item
          Visible = True
          ItemName = 'bbNewGoods'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbModify'
        end
        item
          Visible = True
          ItemName = 'bbCloneGoods'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbRemove'
        end
        item
          Visible = True
          ItemName = 'bbSendToArchive'
        end>
    end
    object bbNewGoods: TdxBarButton
      Caption = 'Produs nou...'
      Category = 2
      Hint = 'Produs nou'
      Visible = ivAlways
      ImageIndex = 12
      ShortCut = 45
      OnClick = bbNewGoodsClick
    end
    object bbModify: TdxBarButton
      Caption = 'Modifica'
      Category = 2
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 115
      OnClick = bbModifyClick
    end
    object bbRemove: TdxBarButton
      Caption = 'Sterge'
      Category = 2
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      ShortCut = 16430
      OnClick = bbRemoveClick
    end
    object bbNewFolder: TdxBarButton
      Caption = 'Mapa noua...'
      Category = 2
      Hint = 'Mapa noua'
      Visible = ivAlways
      ImageIndex = 13
      ShortCut = 16429
      OnClick = bbNewFolderClick
    end
    object bbSearch: TdxBarButton
      Caption = 'Cauta'
      Category = 3
      Hint = 'Cauta'
      Visible = ivAlways
      ImageIndex = 4
      ShortCut = 16454
      OnClick = bbSearchClick
    end
    object dxAddonsSubItems: TdxBarSubItem
      Caption = 'Suplimentar'
      Category = 4
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarButton10'
        end
        item
          Visible = True
          ItemName = 'bbSendToNPSC'
        end
        item
          Visible = True
          ItemName = 'bbGoodsAttributes'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbGoodsKit'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbCompatibleGoods'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbRelatedProducts'
        end
        item
          Visible = True
          ItemName = 'dxBarButton11'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbGoodsInfoCard'
        end
        item
          Visible = True
          ItemName = 'bbLoanOffer'
        end
        item
          Visible = True
          ItemName = 'bbBalansPoPartiam'
        end
        item
          Visible = True
          ItemName = 'bbAviableSnPartsNumbers'
        end
        item
          Visible = True
          ItemName = 'bbGoodsPricePolicy'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbChangeParent'
        end
        item
          Visible = True
          ItemName = 'bbAcntGoods'
        end
        item
          Visible = True
          ItemName = 'bbArrangeFolders'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbGoodsPrice'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbQtyByStocks'
        end
        item
          Visible = True
          ItemName = 'bbQtyByFirms'
        end
        item
          Visible = True
          ItemName = 'bbForeignCodes'
        end>
    end
    object bbGoodsDescriptions: TdxBarButton
      Caption = 'Descriere produs content...'
      Category = 4
      Hint = 'Descriere produs content'
      Visible = ivAlways
      ImageIndex = 22
      ShortCut = 113
      OnClick = bbGoodsDescriptionsClick
    end
    object bbGoodsKit: TdxBarButton
      Caption = 'Complectare'
      Category = 4
      Hint = 'Complectare'
      Visible = ivAlways
      ImageIndex = 25
      ShortCut = 16459
      OnClick = bbGoodsKitClick
    end
    object bbArrangeFolders: TdxBarButton
      Caption = 'Sortrea mapelor'
      Category = 4
      Hint = 'Sortrea mapelor'
      Visible = ivAlways
      ImageIndex = 38
      OnClick = bbArrangeFoldersClick
    end
    object bbChangeParent: TdxBarButton
      Caption = 'Modifcarea mapei parinte'
      Category = 4
      Hint = 'Modifcarea mapei parinte'
      Visible = ivAlways
      ShortCut = 16461
      OnClick = bbChangeParentClick
    end
    object bbCompatibleGoods: TdxBarButton
      Caption = 'Compatibilitatea produselor'
      Category = 4
      Hint = 'Compatibilitatea produselor'
      Visible = ivAlways
      OnClick = bbCompatibleGoodsClick
    end
    object bbQtyByStocks: TdxBarButton
      Caption = 'Solduri pe depozite'
      Category = 4
      Hint = 'Solduri pe depozite'
      Visible = ivAlways
      ImageIndex = 27
      ShortCut = 16467
      OnClick = bbQtyByStocksClick
    end
    object bbQtyByFirms: TdxBarButton
      Caption = 'Solduri pe subdiviziuni'
      Category = 4
      Hint = 'Solduri pe subdiviziuni'
      Visible = ivAlways
      ImageIndex = 11
      ShortCut = 16468
      OnClick = bbQtyByFirmsClick
    end
    object bbRecalcPrice: TdxBarButton
      Caption = #1055#1077#1088#1077#1089#1095#1080#1090#1072#1090#1100' '#1094#1077#1085#1091'...'
      Category = 4
      Hint = #1055#1077#1088#1077#1089#1095#1080#1090#1072#1090#1100' '#1094#1077#1085#1091
      Visible = ivAlways
      OnClick = bbRecalcPriceClick
    end
    object bbPriceAnalize: TdxBarButton
      Caption = #1055#1077#1088#1077#1076#1072#1090#1100' '#1074' '#1072#1085#1072#1083#1080#1079' '#1094#1077#1085
      Category = 5
      Hint = #1055#1077#1088#1077#1076#1072#1090#1100' '#1074' '#1072#1085#1072#1083#1080#1079' '#1094#1077#1085
      Visible = ivAlways
      OnClick = bbPriceAnalizeClick
    end
    object bbOK: TdxBarButton
      Caption = 'OK'
      Category = 6
      Hint = 'OK'
      Visible = ivAlways
      ImageIndex = 43
      OnClick = bbOKClick
    end
    object bbCancel: TdxBarButton
      Caption = 'Renunta'
      Category = 6
      Hint = 'Renunta'
      Visible = ivAlways
      ImageIndex = 35
      ShortCut = 27
      OnClick = bbCancelClick
    end
  end
  object IBCDataSourceGoods: TIBCDataSource
    DataSet = IBCQueryGoods
    Left = 39
    Top = 111
  end
  object IBCQueryGoods: TIBCQuery
    KeyFields = 'GOODSID'
    KeyGenerator = 'SQ_TS_GOODS_GOODSID'
    GeneratorMode = gmInsert
    SQLInsert.Strings = (
      'INSERT INTO VW_TS_GOODS'
      
        '  (GOODSID, PARENTID, FLG_FOLDER, BASE_PARAM, BASE_PARAM_RU, COD' +
        'E, CODE_RU, TITLE, DETAILS, '
      
        '   FLG_SOCIAL, FLG_OLD, FLG_REQUIRE_CERTIFICAT, FLG_BEST_PRICE, ' +
        'FLG_PRICE_NBM, FLG_WEB_HIDE_COMPLECT_ITEMS,'
      '   WARRANTY, '
      
        '   GOODS_ACNT_ID, GOODS_TYPE_ID, WEBGOODSTYPE_ID, VENDOR_ID, USE' +
        'RID, UMID, '
      '   SERIAL_TYPE_ID, ORDERNO, '
      '   PRICE1, PRICE2, PRICE3, PRICE4, PRICE5, '
      
        '   DELIVERY_TYPEID, vat, cashback_percent, colorid, templateid, ' +
        'attributes, related_key'
      '  )'
      'VALUES'
      
        '  (:GOODSID, :PARENTID, :FLG_FOLDER, :BASE_PARAM, :BASE_PARAM_RU' +
        ', :CODE, :CODE_RU, '
      
        '  :TITLE, :DETAILS, :FLG_SOCIAL, :FLG_OLD, :FLG_REQUIRE_CERTIFIC' +
        'AT, :FLG_BEST_PRICE, :FLG_PRICE_NBM, :FLG_WEB_HIDE_COMPLECT_ITEM' +
        'S,'
      
        '   :WARRANTY, :GOODS_ACNT_ID, :GOODS_TYPE_ID, :WEBGOODSTYPE_ID, ' +
        ':VENDOR_ID, :USERID, :UMID, '
      
        '   :SERIAL_TYPE_ID, :ORDERNO, :PRICE1, :PRICE2, :PRICE3, :PRICE4' +
        ', :PRICE5, '
      
        '   :DELIVERY_TYPEID, :vat, :cashback_percent, :colorid, :templat' +
        'eid ,:attributes, :related_key'
      '  )')
    SQLDelete.Strings = (
      'DELETE FROM VW_TS_GOODS'
      'WHERE'
      '  GOODSID = :Old_GOODSID')
    SQLUpdate.Strings = (
      'UPDATE VW_TS_GOODS'
      'SET'
      
        '  GOODSID = :GOODSID, PARENTID = :PARENTID, FLG_FOLDER = :FLG_FO' +
        'LDER, '
      '  BASE_PARAM = :BASE_PARAM, BASE_PARAM_RU = :BASE_PARAM_RU,  '
      '  CODE = :CODE, CODE_RU = :CODE_RU, '
      '  TITLE = :TITLE, '
      '  DETAILS = :DETAILS, '
      '  FLG_SOCIAL = :FLG_SOCIAL, FLG_OLD = :FLG_OLD, '
      '  FLG_REQUIRE_CERTIFICAT = :FLG_REQUIRE_CERTIFICAT,'
      '  FLG_BEST_PRICE = :FLG_BEST_PRICE, '
      '  FLG_PRICE_NBM = :FLG_PRICE_NBM, '
      '  FLG_WEB_HIDE_COMPLECT_ITEMS = :FLG_WEB_HIDE_COMPLECT_ITEMS,'
      
        '  WARRANTY = :WARRANTY, GOODS_ACNT_ID = :GOODS_ACNT_ID, GOODS_TY' +
        'PE_ID = :GOODS_TYPE_ID, '
      '  WEBGOODSTYPE_ID = :WEBGOODSTYPE_ID,'
      
        '  VENDOR_ID = :VENDOR_ID, USERID = :USERID, UMID = :UMID, SERIAL' +
        '_TYPE_ID = :SERIAL_TYPE_ID, '
      '  ORDERNO = :ORDERNO,'
      
        '  PRICE1 = :PRICE1, PRICE2 = :PRICE2, PRICE3 = :PRICE3, PRICE4 =' +
        ' :PRICE4, PRICE5 = :PRICE5, PRICE6 = :PRICE6,'
      
        '   DELIVERY_TYPEID = :DELIVERY_TYPEID, vat = :vat, cashback_perc' +
        'ent =:cashback_percent,'
      
        '   colorid = :colorid, templateid = :templateid, attributes = :a' +
        'ttributes, related_key = :related_key'
      'WHERE'
      '  GOODSID = :Old_GOODSID')
    SQLRefresh.Strings = (
      'SELECT '
      ' A.*,'
      
        ' IIF(FLG_FOLDER=1, DETAILS, WEBGOODSTYPE_TITLE || '#39' '#39' || BASE_PA' +
        'RAM || '#39' '#39' || VENDOR || '#39' '#39' || CODE || '#39' '#39' || DETAILS) TITLE_WEB' +
        ','
      
        ' iif(exists(select * from tweb_goods where goodsid = a.goodsid),' +
        ' 1, 0) FLG_HAS_META,'
      
        ' iif(exists(select * from ts_related_goods where goodsid = a.goo' +
        'dsid), 1, 0) FLG_HAS_KEYS'
      
        ' , iif((a.flg_folder = 0) and exists(select 1 from ts_goods g jo' +
        'in ts_attribute att on att.goods_type_id = g.webgoodstype_id whe' +
        're g.goodsid = a.goodsid and att.flg_recommended = 1 and not exi' +
        'sts(select 1 from ts_goods_attribute ga where ga.attrid = att.at' +
        'trid and ga.goodsid = a.goodsid)), 1, 0) FLG_ATTRS_INCOMPLETE'
      'FROM '
      ' SP_GET_TS_GOODS_M0(:DT,:GOODSID) A')
    SQLLock.Strings = (
      'SELECT NULL FROM TS_GOODS'
      'WHERE'
      'GOODSID = :Old_GOODSID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = IBCTrUpdateGoods
    SQL.Strings = (
      'SELECT '
      ' A.*,'
      
        ' IIF(FLG_FOLDER=1, DETAILS, GET_GOODS_NAME (A.webgoodstype_title' +
        ', a.vendor, a.code, a.base_param, a.details, '
      ' (select title from ts_syss where syssid = colorid))) TITLE_WEB,'
      
        ' iif(exists(select * from tweb_goods where goodsid = a.goodsid),' +
        ' 1, 0) FLG_HAS_META,'
      
        ' iif(exists(select * from ts_related_goods where goodsid = a.goo' +
        'dsid), 1, 0) FLG_HAS_KEYS'
      
        ' , iif((a.flg_folder = 0) and exists(select 1 from ts_goods g jo' +
        'in ts_attribute att on att.goods_type_id = g.webgoodstype_id whe' +
        're g.goodsid = a.goodsid and att.flg_recommended = 1 and not exi' +
        'sts(select 1 from ts_goods_attribute ga where ga.attrid = att.at' +
        'trid and ga.goodsid = a.goodsid)), 1, 0) FLG_ATTRS_INCOMPLETE'
      ' '
      'FROM '
      
        ' SP_GET_TS_GOODS(:MODE,:DT,:PARENTID,:SEARCH, :FLG_ONLY_IN_PRICE' +
        ') A'
      '&orderby'
      '')
    FetchRows = 50
    AutoCommit = False
    LockMode = lmLockImmediate
    RefreshOptions = [roAfterInsert, roAfterUpdate, roBeforeEdit]
    AfterOpen = IBCQueryGoodsAfterOpen
    Left = 35
    Top = 163
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'MODE'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'DT'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'PARENTID'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'SEARCH'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'FLG_ONLY_IN_PRICE'
        Value = nil
      end>
    MacroData = <
      item
        Name = 'orderby'
      end>
  end
  object dxBarPopupMenu: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbFollowGoods'
      end
      item
        Visible = True
        ItemName = 'bbQuickGoodsInfo'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbNewFolder'
      end
      item
        Visible = True
        ItemName = 'bbNewGoods'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbModify'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbGoodsDescriptions'
      end
      item
        Visible = True
        ItemName = 'dxBarButton10'
      end
      item
        Visible = True
        ItemName = 'bbSendToNPSC'
      end
      item
        Visible = True
        ItemName = 'bbPriceAnalize'
      end
      item
        Visible = True
        ItemName = 'bbAddToWebCatalog'
      end
      item
        Visible = True
        ItemName = 'bbAddToPromo'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbGoodsKit'
      end
      item
        Visible = True
        ItemName = 'bbCompatibleGoods'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbUpdateTitle'
      end
      item
        Visible = True
        ItemName = 'bbSetupPropsToSelection'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bsubFlgNewGoods'
      end
      item
        Visible = True
        ItemName = 'bsubFlgPromoGoods'
      end
      item
        Visible = True
        ItemName = 'bbSubWebFLG_DISCOUNT'
      end
      item
        Visible = True
        ItemName = 'bbSet_FLG_OLD'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbChangeParent'
      end
      item
        Visible = True
        ItemName = 'bbArrangeFolders'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbRecalcPrice'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbQtyByStocks'
      end
      item
        Visible = True
        ItemName = 'bbQtyByFirms'
      end>
    UseOwnFont = False
    Left = 536
    Top = 104
    PixelsPerInch = 96
  end
  object IBCTrUpdateGoods: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 276
    Top = 144
  end
  object cxGridPopupMenuGoods: TcxGridPopupMenu
    PopupMenus = <>
    Left = 656
    Top = 144
  end
  object IBCQueryStockFirms: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      
        'select distinct DT, C.NAME, sum(QTY) QTY, sum(S.TRANSIT_QTY) TRA' +
        'NSFER_QTY'
      'from TS_GOODS_STOCK S'
      'join TS_CUSTOMER C on C.CUSTOMERID = DT and'
      '      C.CUSTOMER_TYPE_ID = 4002'
      'inner join TS_STOCKS S2 on (S2.STOCKID = S.DTDEP and'
      '      GET_FLG_VALUE(S2.FLAGS, 0) = 1)'
      'where (GOODSID = :GOODSID)'
      'group by DT, C.NAME')
    Left = 412
    Top = 356
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'GOODSID'
        Value = nil
      end>
  end
  object IBCDataSourceStockFirms: TIBCDataSource
    DataSet = IBCQueryStockFirms
    Left = 412
    Top = 308
  end
  object IBCQueryStockWarehouse: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT '
      ' STOCKID,'
      ' PARENTID,'
      ' FLG_FOLDER,'
      ' TITLE,'
      ' QTY'
      'FROM'
      ' GET_GOODS_QTY_BY_STOCK(:GOODSID,:DT)'
      'WHERE (FLG_FOLDER=0) and (QTY<>0)'
      'ORDER BY QTY DESC')
    Left = 568
    Top = 360
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'GOODSID'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'DT'
        Value = nil
      end>
  end
  object IBCDataSourceStockWarehouse: TIBCDataSource
    DataSet = IBCQueryStockWarehouse
    Left = 568
    Top = 309
  end
  object IBC_GOODS_Recomendation: TIBCQuery
    KeyFields = 'CUSTOMERID;GOODSID'
    SQLInsert.Strings = (
      'INSERT INTO TS_GOODS_WEB_RECOMENDATION'
      '  (CUSTOMERID, GOODSID, RECOMENDATION, STARS)'
      'VALUES'
      '  (:CUSTOMERID, :GOODSID, :RECOMENDATION, :STARS)')
    SQLDelete.Strings = (
      'DELETE FROM TS_GOODS_WEB_RECOMENDATION'
      'WHERE'
      '  CUSTOMERID = :Old_CUSTOMERID AND GOODSID = :Old_GOODSID')
    SQLUpdate.Strings = (
      'UPDATE TS_GOODS_WEB_RECOMENDATION'
      'SET'
      
        '  CUSTOMERID = :CUSTOMERID, GOODSID = :GOODSID, RECOMENDATION = ' +
        ':RECOMENDATION, STARS = :STARS'
      'WHERE'
      '  CUSTOMERID = :Old_CUSTOMERID AND GOODSID = :Old_GOODSID')
    SQLRefresh.Strings = (
      
        'SELECT CUSTOMERID, GOODSID, RECOMENDATION, STARS FROM TS_GOODS_W' +
        'EB_RECOMENDATION'
      'WHERE'
      '  CUSTOMERID = :CUSTOMERID AND GOODSID = :P_1_GOODSID')
    SQLLock.Strings = (
      'SELECT NULL FROM TS_GOODS_WEB_RECOMENDATION'
      'WHERE'
      'CUSTOMERID = :Old_CUSTOMERID AND GOODSID = :Old_GOODSID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = IBCTrUpdateGoods
    SQL.Strings = (
      'SELECT * FROM TS_GOODS_WEB_RECOMENDATION')
    MasterFields = 'GOODSID'
    DetailFields = 'GOODSID'
    MasterSource = IBCDataSourceGoods
    RefreshOptions = [roAfterUpdate, roBeforeEdit]
    AfterInsert = IBC_GOODS_RecomendationAfterInsert
    Left = 160
    Top = 288
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'GOODSID'
        Value = nil
      end>
  end
  object IBCDS_GOODS_Recomendation: TIBCDataSource
    DataSet = IBC_GOODS_Recomendation
    Left = 160
    Top = 240
  end
  object IBCQueryBalansParts: TIBCQuery
    Connection = dmDB.IBCConnection
    MasterSource = IBCDataSourceGoods
    Options.DetailDelay = 500
    Left = 784
    Top = 372
  end
  object IBCDataSourceBalansParts: TIBCDataSource
    DataSet = IBCQueryBalansParts
    Left = 784
    Top = 308
  end
  object cxImageList1: TcxImageList
    SourceDPI = 96
    FormatVersion = 1
    Left = 409
    Top = 192
    Bitmap = {
      494C010107000900040010001000FFFFFFFF2110FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000002000000001002000000000000020
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000001000000050000000C010409520B204ACD103278FF0A1F
      49CD010309520000000D00000005000000010000000000000000000000000000
      000B000000000000000000000000000000000000000000000000000000000000
      00000000000C0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000002000000070000000B0000
      000C0000000C0000001101050B570D2550CF265CA0FF4CA4E0FFC1E6F9FF265C
      A3FF184289FF0B204BCD01040950000000050000000000000000000000000C65
      90C0042536760000000B00000000000000000000000000000000000000090322
      31710C6C9BC70000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000001E8902EF229C
      02FF229C02FF229C02FF229C02FF229C02FF229C02FF229C02FF229C02FF229C
      02FF229C02FF1F8C02F2000000000000000000000006211B5ABE3E31A9FF3D31
      A9FF3C30A8FF392CA0FF1E4F95FF5AAFE6FF6ECBFFFF6DCCFFFFCDECFAFF2E6C
      B2FF2F6CB3FF2963AAFF153D84FF0000000A000000000000000000000000094B
      6DA714B1FFFF1191D1E703202E6D0000000700000006031D2A68108CCAE314B1
      FFFF0A557BB10000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000229C02FF229C
      02FF229C02FF229C02FF229C02FF229C02FF229C02FF229C02FF229C02FF229C
      02FF229C02FF229C02FF0000000000000000000000094338ADFF6272DEFF5465
      DAFF5363D9FF4D5ED0FF235A9EFF7DD2FFFF7DD4FFFF7DD4FFFFDAF0FBFF3171
      B6FF3071B5FF3071B6FF18448AFF0000000C0000000000000000000000000428
      3A7A14B1FFFF14B1FFFF14B1FFFF0F89C6E10F85BFDD14B1FFFF14B1FFFF14B1
      FFFF052E43830000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000229C02FF229C
      02FF229C02FF229C02FF229C02FF229C02FF229C02FF229C02FF229C02FF229C
      02FF229C02FF229C02FF000000000000000000000009473EB1FF6C7CE1FF5869
      DBFF5768DBFF5263D2FF2862A7FF8EDBFFFF8EDBFFFF8EDBFFFFE5F5FCFF3375
      B8FF3374B8FF3275B8FF1C4C91FF0000000B000000000000000000000000010F
      164C14B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1
      FFFF02131C560000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000229C02FF229C
      02FF229C02FF229C02FF0825007D0825007D229C02FF229C02FF229C02FF229C
      02FF229C02FF229C02FF0000000000000000000000084C43B5FF7687E3FF5D6E
      DDFF5B6DDCFF5767D4FF2B6BAEFF9DE1FFFF9DE1FFFF9CE1FFFFF0F9FEFF3477
      BAFF3477BAFF3477BAFF205499FF0000000A0000000000000000000000000002
      031F14B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1
      FFFF000406290000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000229C02FF229C
      02FF229C02FF0825007D00000000000000000825007D229C02FF229C02FF229C
      02FF229C02FF229C02FF0000000000000000000000075048B8FF8192E6FF6173
      DEFF6072DEFF5B6CD6FF2E72B4FFABE6FFFFC6EFFFFFF0FBFFFFFFFFFFFFE9F4
      FBFF81AFD7FF3477BAFF235B9FFF00000009000000000000000000000000010A
      0E3D14B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1
      FFFF010D13470000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000229C02FF229C
      02FF0825007D000000000928008209280082000000000825007D229C02FF229C
      02FF229C02FF229C02FF000000000000000000000007554EBDFF8C9BE9FF6578
      E0FF6477DFFF6171D9FF2F73B6FFC2DAEDFFF2FCFFFFD6F3FDFFC7EFFCFFD1F1
      FDFFF0FAFEFFBBD4EAFF2761A5FF000000060000000000000000010B114213A3
      EBF514B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1
      FFFF13A7F1F8010E144900000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000229C02FF229C
      02FF0928008209280082229C02FF229C02FF09280082000000000825007D229C
      02FF229C02FF229C02FF0000000000000000000000065953C0FF95A3ECFF6A7D
      E1FF6E81E3FF6D81E1FF5D7BD2FF3D74BDFF5391C7FFA2D1EBFFC6EFFCFF9FCF
      EBFF5190C6FF1B436BC702060A440000000200000000010D134713A3EBF514B1
      FFFF14B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1
      FFFF14B1FFFF13A7F1F80110174E000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000229C02FF229C
      02FF229C02FF229C02FF229C02FF229C02FF229C02FF09280082000000000825
      007D229C02FF229C02FF0000000000000000000000055E59C4FFA0AFEFFF788D
      E5FF798EE6FF778BE5FF768AE3FF7288E1FF6180D4FF3E76BEFF2F73B6FF4178
      BEFF4854B4FF0000000D0000000200000000010E144913A7F1F814B1FFFF14B1
      FFFF14B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1
      FFFF14B1FFFF14B1FFFF14A9F5FA021119510000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000229C02FF229C
      02FF229C02FF229C02FF229C02FF229C02FF229C02FF229C02FF092800820928
      0082229C02FF229C02FF0000000000000000000000056460C8FFB0BEF2FF8196
      E8FF8095E8FF7E93E8FF7C92E7FF7C91E8FF7A8FE5FF778DE3FF758CE2FF8EA0
      E8FF5A54C0FF000000070000000000000000010A0F3F031E2C6B0637508F0A59
      80B50F80B8D914AAF5FA14B1FFFF14B1FFFF14B1FFFF14B1FFFF14ABF7FB0F82
      BCDB0A5A82B606395291031F2D6C010B11420000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000229C02FF229C
      02FF229C02FF229C02FF229C02FF229C02FF229C02FF229C02FF229C02FF229C
      02FF229C02FF229C02FF0000000000000000000000046C6ACFFFB8C7F4FF879C
      EAFF869BEAFF859AE9FF8399E9FF8398E9FF8297E9FF8195E8FF8094E8FF97AA
      EDFF625FC6FF0000000700000000000000000000000000000000000000000000
      00000000000001080B3714B1FFFF14B1FFFF14B1FFFF14B1FFFF010C12450000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000229C02FF229C
      02FF229C02FF229C02FF229C02FF229C02FF229C02FF229C02FF229C02FF229C
      02FF229C02FF229C02FF0000000000000000000000047170D1FFBFCCF5FFBECC
      F6FFBCCBF5FFBCCBF5FFBBCAF5FFBACAF5FFBAC8F5FFB9C8F4FFB8C6F4FFB7C5
      F4FF6965CBFF0000000600000000000000000000000000000000000000000000
      000000000000000000000A5982B614B1FFFF14B1FFFF0C6896C4000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000001D8702ED229C
      02FF229C02FF229C02FF229C02FF229C02FF229C02FF229C02FF229C02FF229C
      02FF229C02FF1E8902EF0000000000000000000000037676D6FF7475D7FF7373
      D5FF7070D4FF6E6DD2FF6C6BD0FF6A67CEFF6865CCFF6562CAFF625FC8FF605C
      C7FF6E6BCEFF0000000500000000000000000000000000000000000000000000
      0000000000000000000001080B3714B1FFFF14B1FFFF010C1245000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000028282DBFFC5C5EFFFFEFE
      FEFFFDFCFCFFFCFAF9FFFAF8F6FFF8F5F3FFF7F2F0FFF6F0ECFFF4EDE9FFF2EC
      E7FF7878D4FF0000000400000000000000000000000000000000000000000000
      00000000000000000000000000000A5982B60C6896C400000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000001494A7CBF8587E0FF8486
      DFFF8485DFFF8385DDFF8284DEFF8284DCFF8283DCFF8083DCFF8082DCFF8081
      DBFF46477AC00000000300000000000000000000000000000000000000000000
      000000000000000000000000000001080B37010C124400000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFFFFFFFFFFFCF8F6FFF9F3
      EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFFFFFFFFFFF6F6FFFFEFEF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6FDFFFFEFFB
      FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE8D0C4FFD6AD
      98FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD77610FFD77610FFD77610FF0000
      0000D77610FFD77610FFD77610FF00000000D77610FFD77610FFD77610FF0000
      0000D77610FFD77610FFD77610FF00000000FFFFFFFFFFFFFFFFC4C4FFFF9898
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC4EFF9FF98E3
      F5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE8D0C4FFD6AD
      98FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD77610FFD77610FFD77610FF0000
      0000D77610FFD77610FFD77610FF00000000D77610FFD77610FFD77610FF0000
      0000D77610FFD77610FFD77610FF00000000FFFFFFFFFFFFFFFFC4C4FFFF9898
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC4EFF9FF98E3
      F5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE8D0C4FFD6AD
      98FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD77610FFD77610FFD77610FF0000
      0000D77610FFD77610FFD77610FF00000000D77610FFD77610FFD77610FF0000
      0000D77610FFD77610FFD77610FF00000000FFFFFFFFFFFFFFFFC4C4FFFF9898
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC4EFF9FF98E3
      F5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE8D0C4FFD6AD
      98FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD77610FFD77610FFD77610FF0000
      0000D77610FFD77610FFD77610FF00000000D77610FFD77610FFD77610FF0000
      0000D77610FFD77610FFD77610FF00000000FFFFFFFFFFFFFFFFC4C4FFFF9898
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC4EFF9FF98E3
      F5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE8D0C4FFD6AD
      98FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD77610FFD77610FFD77610FF0000
      0000D77610FFD77610FFD77610FF00000000D77610FFD77610FFD77610FF0000
      0000D77610FFD77610FFD77610FF00000000FFFFFFFFFFFFFFFFC4C4FFFF9898
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC4EFF9FF98E3
      F5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE8D0C4FFD2A5
      8EFFFEFCFBFFFFFFFFFFFBF6F3FFE3C6B8FFCB977CFFBC7856FFB46843FFB263
      3DFFC08161FFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000
      0000D77610FFD77610FFD77610FF00000000D77610FFD77610FFD77610FF0000
      0000D77610FFD77610FFD77610FF00000000FFFFFFFFFFFFFFFFC4C4FFFF8E8E
      FFFFFBFBFFFFFFFFFFFFF3F3FFFFB8B8FFFF7C7CFFFF5656FFFF4343FFFF3D3D
      FFFF6161FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC4EFF9FF8EE0
      F4FFFBFEFFFFFFFFFFFFF3FCFEFFB8ECF8FF7CDCF2FF56D1EEFF43CCECFF3DCA
      ECFF61D4EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE8D0C4FF9932
      00FF9A3300FF9D3A09FF993200FF993200FF993200FF993200FF993200FF9932
      00FFA44719FFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000
      0000D77610FFD77610FFD77610FF00000000D77610FFD77610FFD77610FF0000
      0000D77610FFD77610FFD77610FF00000000FFFFFFFFFFFFFFFFC4C4FFFF0000
      FFFF0000FFFF0909FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000
      FFFF1919FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC4EFF9FF00B9
      E5FF00BAE6FF09BCE6FF00B9E5FF00B9E5FF00B9E5FF00B9E5FF00B9E5FF00B9
      E5FF19C0E8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE8D0C4FF9932
      00FF993200FF993200FF993200FF993200FF993200FF993200FF993200FF9932
      00FFA44719FFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000
      0000D77610FFD77610FFD77610FF00000000D77610FFD77610FFD77610FF0000
      0000D77610FFD77610FFD77610FF00000000FFFFFFFFFFFFFFFFC4C4FFFF0000
      FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000
      FFFF1919FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC4EFF9FF00B9
      E5FF00B9E5FF00B9E5FF00B9E5FF00B9E5FF00B9E5FF00B9E5FF00B9E5FF00B9
      E5FF19C0E8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE8D0C4FF9932
      00FF993200FF993200FF993200FF993200FF993200FF993200FF993200FF9932
      00FFA44719FFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000
      000000000000000000000000000000000000D77610FFD77610FFD77610FF0000
      0000D77610FFD77610FFD77610FF00000000FFFFFFFFFFFFFFFFC4C4FFFF0000
      FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000
      FFFF1919FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC4EFF9FF00B9
      E5FF00B9E5FF00B9E5FF00B9E5FF00B9E5FF00B9E5FF00B9E5FF00B9E5FF00B9
      E5FF19C0E8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE8D0C4FF9932
      00FF993200FF993200FF993200FF993200FF993200FF993200FF993200FF9932
      00FFA44719FFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000
      000000000000000000000000000000000000D77610FFD77610FFD77610FF0000
      0000D77610FFD77610FFD77610FF00000000FFFFFFFFFFFFFFFFC4C4FFFF0000
      FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000
      FFFF1919FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC4EFF9FF00B9
      E5FF00B9E5FF00B9E5FF00B9E5FF00B9E5FF00B9E5FF00B9E5FF00B9E5FF00B9
      E5FF19C0E8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE8D0C4FF9932
      00FF993200FF993200FF993200FF993200FF993200FF993200FF993200FF9932
      00FFA44719FFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000
      000000000000000000000000000000000000D77610FFD77610FFD77610FF0000
      0000D77610FFD77610FFD77610FF00000000FFFFFFFFFFFFFFFFC4C4FFFF0000
      FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000
      FFFF1919FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC4EFF9FF00B9
      E5FF00B9E5FF00B9E5FF00B9E5FF00B9E5FF00B9E5FF00B9E5FF00B9E5FF00B9
      E5FF19C0E8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE8D0C4FF9932
      00FF993200FF993200FF993200FF993200FF993200FF993200FF993200FF9932
      00FFA44719FFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000D77610FFD77610FFD77610FF00000000FFFFFFFFFFFFFFFFC4C4FFFF0000
      FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000
      FFFF1919FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC4EFF9FF00B9
      E5FF00B9E5FF00B9E5FF00B9E5FF00B9E5FF00B9E5FF00B9E5FF00B9E5FF00B9
      E5FF19C0E8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEDDBD1FF9932
      00FF993200FF993200FF993200FF9A3301FFA74E22FFBA7451FFC4896BFFBF7D
      5DFFBB7654FFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000D77610FFD77610FFD77610FF00000000FFFFFFFFFFFFFFFFD1D1FFFF0000
      FFFF0000FFFF0000FFFF0000FFFF0101FFFF2222FFFF5151FFFF6B6BFFFF5D5D
      FFFF5454FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD1F3FBFF00B9
      E5FF00B9E5FF00B9E5FF00B9E5FF01BAE6FF22C3E9FF51D0EEFF6BD7F0FF5DD3
      EFFF54D1EEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFECD8
      CEFFDDBBAAFFE0C0B0FFECD9CFFFFBF7F5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000D77610FFD77610FFD77610FF00000000FFFFFFFFFFFFFFFFFFFFFFFFCECE
      FFFFAAAAFFFFB0B0FFFFCFCFFFFFF5F5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCEF2
      FAFFAAE8F7FFB0EAF7FFCFF2FBFFF5FDFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF424D3E000000000000003E000000
      2800000040000000200000000100010000000000000100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000}
    DesignInfo = 12583321
    ImageInfo = <
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FFFFFFFFFFFF
          FFFFFCF8F6FFF9F3EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFE8D0C4FFD6AD98FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFE8D0C4FFD6AD98FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFE8D0C4FFD6AD98FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFE8D0C4FFD6AD98FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFE8D0C4FFD6AD98FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFE8D0C4FFD2A58EFFFEFCFBFFFFFFFFFFFBF6F3FFE3C6B8FFCB977DFFBC79
          57FFB46944FFB2643EFFC08162FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFE8D0C4FF993300FF9A3401FF9D3B0AFF993300FF993300FF993300FF9933
          00FF993300FF993300FFA4481AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFE8D0C4FF993300FF993300FF993300FF993300FF993300FF993300FF9933
          00FF993300FF993300FFA4481AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFE8D0C4FF993300FF993300FF993300FF993300FF993300FF993300FF9933
          00FF993300FF993300FFA4481AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFE8D0C4FF993300FF993300FF993300FF993300FF993300FF993300FF9933
          00FF993300FF993300FFA4481AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFE8D0C4FF993300FF993300FF993300FF993300FF993300FF993300FF9933
          00FF993300FF993300FFA4481AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFE8D0C4FF993300FF993300FF993300FF993300FF993300FF993300FF9933
          00FF993300FF993300FFA4481AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFEDDBD1FF993300FF993300FF993300FF993300FF9A3402FFA74F23FFBA75
          52FFC4896CFFBF7E5EFFBB7755FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFECD8CEFFDDBBAAFFE0C0B0FFECD9CFFFFBF7F5FFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D225554
          462D38223F3E0D0A3C7376672076657273696F6E3D22312E31222069643D224C
          617965725F312220786D6C6E733D22687474703A2F2F7777772E77332E6F7267
          2F323030302F7376672220786D6C6E733A786C696E6B3D22687474703A2F2F77
          77772E77332E6F72672F313939392F786C696E6B2220783D223070782220793D
          22307078222076696577426F783D2230203020333220333222207374796C653D
          22656E61626C652D6261636B67726F756E643A6E657720302030203332203332
          3B2220786D6C3A73706163653D227072657365727665223E262331333B262331
          303B3C7374796C6520747970653D22746578742F6373732220786D6C3A737061
          63653D227072657365727665223E2E426C61636B7B66696C6C3A233732373237
          323B7D262331333B262331303B2623393B2E59656C6C6F777B66696C6C3A2346
          46423131353B7D262331333B262331303B2623393B2E426C75657B66696C6C3A
          233131373744373B7D262331333B262331303B2623393B2E5265647B66696C6C
          3A234431314331433B7D262331333B262331303B2623393B2E57686974657B66
          696C6C3A234646464646463B7D262331333B262331303B2623393B2E47726565
          6E7B66696C6C3A233033394332333B7D262331333B262331303B2623393B2E73
          74307B66696C6C3A233732373237323B7D262331333B262331303B2623393B2E
          7374317B6F7061636974793A302E353B7D262331333B262331303B2623393B2E
          7374327B6F7061636974793A302E37353B7D3C2F7374796C653E0D0A3C672069
          643D22486967685072696F72697479223E0D0A09093C7061746820636C617373
          3D22426C75652220643D224D362C3330483056323068365633307A204D31342C
          3134483876313668365631347A204D32322C38682D36763232683656387A204D
          33302C32682D36763238683656327A222F3E0D0A093C2F673E0D0A3C2F737667
          3E0D0A}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FFFFFFFFFFFF
          FFFFF6F6FFFFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFC4C4FFFF9898FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFC4C4FFFF9898FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFC4C4FFFF9898FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFC4C4FFFF9898FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFC4C4FFFF9898FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFC4C4FFFF8E8EFFFFFBFBFFFFFFFFFFFFF3F3FFFFB8B8FFFF7D7DFFFF5757
          FFFF4444FFFF3E3EFFFF6262FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFC4C4FFFF0000FFFF0101FFFF0A0AFFFF0000FFFF0000FFFF0000FFFF0000
          FFFF0000FFFF0000FFFF1A1AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFC4C4FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000
          FFFF0000FFFF0000FFFF1A1AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFC4C4FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000
          FFFF0000FFFF0000FFFF1A1AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFC4C4FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000
          FFFF0000FFFF0000FFFF1A1AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFC4C4FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000
          FFFF0000FFFF0000FFFF1A1AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFC4C4FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000
          FFFF0000FFFF0000FFFF1A1AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFD1D1FFFF0000FFFF0000FFFF0000FFFF0000FFFF0202FFFF2323FFFF5252
          FFFF6C6CFFFF5E5EFFFF5555FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFCECEFFFFAAAAFFFFB0B0FFFFCFCFFFFFF5F5FFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FFFFFFFFFFFF
          FFFFF6FDFFFFEFFBFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFC4EFF9FF98E3F5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFC4EFF9FF98E3F5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFC4EFF9FF98E3F5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFC4EFF9FF98E3F5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFC4EFF9FF98E3F5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFC4EFF9FF8EE0F4FFFBFEFFFFFFFFFFFFF3FCFEFFB8ECF8FF7DDCF2FF57D1
          EEFF44CCECFF3ECAECFF62D4EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFC4EFF9FF00B9E5FF01BAE6FF0ABCE6FF00B9E5FF00B9E5FF00B9E5FF00B9
          E5FF00B9E5FF00B9E5FF1AC0E8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFC4EFF9FF00B9E5FF00B9E5FF00B9E5FF00B9E5FF00B9E5FF00B9E5FF00B9
          E5FF00B9E5FF00B9E5FF1AC0E8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFC4EFF9FF00B9E5FF00B9E5FF00B9E5FF00B9E5FF00B9E5FF00B9E5FF00B9
          E5FF00B9E5FF00B9E5FF1AC0E8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFC4EFF9FF00B9E5FF00B9E5FF00B9E5FF00B9E5FF00B9E5FF00B9E5FF00B9
          E5FF00B9E5FF00B9E5FF1AC0E8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFC4EFF9FF00B9E5FF00B9E5FF00B9E5FF00B9E5FF00B9E5FF00B9E5FF00B9
          E5FF00B9E5FF00B9E5FF1AC0E8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFC4EFF9FF00B9E5FF00B9E5FF00B9E5FF00B9E5FF00B9E5FF00B9E5FF00B9
          E5FF00B9E5FF00B9E5FF1AC0E8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFD1F3FBFF00B9E5FF00B9E5FF00B9E5FF00B9E5FF02BAE6FF23C3E9FF52D0
          EEFF6CD7F0FF5ED3EFFF55D1EEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFCEF2FAFFAAE8F7FFB0EAF7FFCFF2FBFFF5FDFEFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D225554
          462D38223F3E0D0A3C7376672076657273696F6E3D22312E31222069643D224C
          617965725F312220786D6C6E733D22687474703A2F2F7777772E77332E6F7267
          2F323030302F7376672220786D6C6E733A786C696E6B3D22687474703A2F2F77
          77772E77332E6F72672F313939392F786C696E6B2220783D223070782220793D
          22307078222076696577426F783D2230203020333220333222207374796C653D
          22656E61626C652D6261636B67726F756E643A6E657720302030203332203332
          3B2220786D6C3A73706163653D227072657365727665223E262331333B262331
          303B2623393B2623393B2623393B2623393B2623393B2623393B2623393B2623
          393B3C7374796C6520747970653D22746578742F6373732220786D6C3A737061
          63653D227072657365727665223E2E426C61636B7B66696C6C3A233732373237
          323B7D262331333B262331303B2623393B2E59656C6C6F777B66696C6C3A2346
          46423131353B7D262331333B262331303B2623393B2E426C75657B66696C6C3A
          233131373744373B7D262331333B262331303B2623393B2E477265656E7B6669
          6C6C3A233033394332333B7D262331333B262331303B2623393B2E5265647B66
          696C6C3A234431314331433B7D262331333B262331303B2623393B2E57686974
          657B66696C6C3A234646464646463B7D262331333B262331303B2623393B2E73
          74307B6F7061636974793A302E37353B7D262331333B262331303B2623393B2E
          7374317B6F7061636974793A302E353B7D262331333B262331303B2623393B2E
          7374327B6F7061636974793A302E32353B7D3C2F7374796C653E0D0A3C672069
          643D22436865636B426F78223E0D0A09093C7061746820636C6173733D224772
          65656E2220643D224D32372C34483543342E352C342C342C342E352C342C3576
          323263302C302E352C302E352C312C312C3168323263302E352C302C312D302E
          352C312D3156354332382C342E352C32372E352C342C32372C347A204D31342C
          32326C2D362D366C322D326C342C3420202623393B2623393B6C382D386C322C
          324C31342C32327A222F3E0D0A093C2F673E0D0A3C2F7376673E0D0A}
      end
      item
        ImageClass = 'TdxPNGImage'
        Image.Data = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          610000001E744558745469746C650046756E6374696F6E73437562653B46756E
          6374696F6E733B153A9D2D0000028C49444154785E65924F48965914C67FEFE7
          A746C834F3118E35D162460493867053AD320423A88530348B8219189036EDA3
          689335C24045ED6A55D0660846876A93A013339B080C66D4C851102C4B2BFABE
          4FDF7FF7CF39D97DD1165E7838F72E9EDF7DCEE1948168EED7C1B186A8D4A3AA
          A02028912A02A00012AA2A38EF1F775E1CEC55550F1000E2B4A7D2DBC3B68307
          11517C90E0FD27294E34DC4585F757860E0111C006C0C6316FFE1C61717818F5
          1EF1828820AEA8E27D907AA179DB176C06184BFBC9E34428AA0250E4458BF4A1
          163D3CBF737F13003116B539F1D4B3602C66119CC5BB30D3D8FA35D6E49B13E4
          4986A46B322618902249A4845988F8F02649317106C0BDD35D1B005C6EF0B52A
          3ECD88A2080D0353441C2BD90796D339325F63CBFB0A09CD004D276E4EDBDF07
          3A252470C6E257635CAD4EA9A18CA0D46C95B7F93C5B77B5B2B7FF17BEDADDCE
          87F917FCFFF83E23DF7CFF68E14D72E1C75BCFC702C05B87CF52D45A9C3118E3
          7959FA97FD0337A87CBB0F495FA2AEB676EFE640573FEF669E1E18BD7A661468
          2E035863F1698C5807AA786B9126A5D2B2042B93945AF640B913172F33FBF03A
          0B4F1E608C0368F89C204E50EB50950032EAC1D60BD5A7D1B61F18BF748CF563
          720F100580B3164912C45A50459C25B71E4C6DC3202E4644418148C932B701C0
          19874F12D439543480526721AD420900D4C68813142502F2CF007C9AE7E34FC7
          670F43B14499F3A4DF595ECFCDB163D7F6F0A3BA159CF54444A4A9596F41CA80
          3B35F1F7D1F5A5A2388D3FF365DFABDF1E9DED68AFECEB39D2C18E9DABD4AA19
          8B8B75DE55B389B7891B046C595505C80BC1D0E136CEFDB514DDFEAFFA07F0F0
          A76ADE3739B57CBEF1DA3FDDC6EBC452E22EDF9D591D0532C07D040C59D1BEAC
          B42E550000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D225554
          462D38223F3E0D0A3C7376672076657273696F6E3D22312E31222069643D224C
          617965725F312220786D6C6E733D22687474703A2F2F7777772E77332E6F7267
          2F323030302F7376672220786D6C6E733A786C696E6B3D22687474703A2F2F77
          77772E77332E6F72672F313939392F786C696E6B2220783D223070782220793D
          22307078222076696577426F783D2230203020313820313822207374796C653D
          22656E61626C652D6261636B67726F756E643A6E657720302030203138203138
          3B2220786D6C3A73706163653D227072657365727665223E262331333B262331
          303B3C7374796C6520747970653D22746578742F637373223E2E616C7459656C
          6C6F777B66696C6C3A234646423131353B7D3C2F7374796C653E0D0A3C706F6C
          79676F6E20636C6173733D22616C7459656C6C6F772220706F696E74733D2239
          2C302031312E382C352E362031382C362E352031332E352C31302E392031342E
          362C31372E3120392C31342E3220332E342C31372E3120342E352C31302E3920
          302C362E3520362E322C352E3620222F3E0D0A3C2F7376673E0D0A}
      end>
  end
  object IBCQueryCatalog: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'select * from GET_GOODS_PATH(:goodsid)')
    Options.DetailDelay = 500
    Left = 896
    Top = 368
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'goodsid'
        Value = nil
      end>
  end
  object IBCDataSourceCatalog: TIBCDataSource
    DataSet = IBCQueryCatalog
    Left = 896
    Top = 304
  end
  object SwnNotificationCenter: TNotificationCenter
    Left = 720
    Top = 312
  end
end
