inherited frame15TovarBezHaracteristic: Tframe15TovarBezHaracteristic
  Width = 1251
  Height = 646
  Margins.Left = 4
  Margins.Top = 4
  Margins.Right = 4
  Margins.Bottom = 4
  Font.Height = -12
  ExplicitWidth = 1251
  ExplicitHeight = 646
  object cxPageControl2: TcxPageControl
    Left = 0
    Top = 0
    Width = 1251
    Height = 646
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    TabOrder = 0
    Properties.ActivePage = tbPackages
    Properties.CustomButtons.Buttons = <>
    ClientRectBottom = 642
    ClientRectLeft = 4
    ClientRectRight = 1247
    ClientRectTop = 26
    object tbGoodsNoProperties: TcxTabSheet
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Produse fara caracteristici si imagini'
      ImageIndex = 0
      object Panel1: TPanel
        Left = 0
        Top = 30
        Width = 225
        Height = 586
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alLeft
        BevelKind = bkFlat
        BevelOuter = bvNone
        Color = clWindow
        ParentBackground = False
        TabOrder = 0
        ExplicitHeight = 414
        object cxTree: TcxTreeList
          Left = 0
          Top = 0
          Width = 221
          Height = 582
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          BorderStyle = cxcbsNone
          Align = alClient
          Bands = <
            item
              MinWidth = 16
            end>
          Images = dmAdditions.cxImageList_SWN
          LookAndFeel.NativeStyle = True
          OptionsBehavior.ChangeDelay = 1000
          OptionsData.Editing = False
          OptionsData.Deleting = False
          OptionsSelection.InvertSelect = False
          OptionsView.ScrollBars = ssVertical
          OptionsView.ColumnAutoWidth = True
          OptionsView.IndicatorWidth = 10
          OptionsView.NavigatorOffset = 40
          Preview.LeftIndent = 4
          Preview.RightIndent = 4
          ScrollbarAnnotations.CustomAnnotations = <>
          Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
          Styles.OnGetContentStyle = cxTreeStylesGetContentStyle
          Styles.ColumnHeader = dmAdditions.cxStyle_GridHeader
          TabOrder = 0
          OnExpanding = cxTreeExpanding
          OnFocusedNodeChanged = cxTreeFocusedNodeChanged
          ExplicitHeight = 410
          object cxTree_TITLE: TcxTreeListColumn
            Caption.Text = 'Mape'
            MinWidth = 16
            Width = 80
            Position.ColIndex = 0
            Position.RowIndex = 0
            Position.BandIndex = 0
          end
          object cxTree_GOODSID: TcxTreeListColumn
            Visible = False
            MinWidth = 16
            Width = 80
            Position.ColIndex = 1
            Position.RowIndex = 0
            Position.BandIndex = 0
          end
          object cxTree_SPECIAL: TcxTreeListColumn
            Visible = False
            MinWidth = 16
            Width = 80
            Position.ColIndex = 2
            Position.RowIndex = 0
            Position.BandIndex = 0
          end
          object cxTree_SCANNED: TcxTreeListColumn
            Visible = False
            DataBinding.ValueType = 'Boolean'
            MinWidth = 16
            Width = 80
            Position.ColIndex = 3
            Position.RowIndex = 0
            Position.BandIndex = 0
          end
        end
      end
      object Panel3: TPanel
        Left = 225
        Top = 30
        Width = 1018
        Height = 586
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alClient
        BevelKind = bkFlat
        BevelOuter = bvNone
        Color = clWindow
        ParentBackground = False
        TabOrder = 2
        object cxGridGoods: TcxGrid
          AlignWithMargins = True
          Left = 2
          Top = 0
          Width = 1012
          Height = 575
          Margins.Left = 2
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alClient
          TabOrder = 0
          LookAndFeel.NativeStyle = True
          LookAndFeel.SkinName = ''
          object cxGridGoodsTable: TcxGridDBTableView
            PopupMenu = dxBarPopupMenu
            OnKeyDown = cxGridGoodsTableKeyDown
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
            FindPanel.DisplayMode = fpdmAlways
            OnCellDblClick = cxGridGoodsTableCellDblClick
            OnFocusedRecordChanged = cxGridGoodsTableFocusedRecordChanged
            DataController.DataSource = IBCDataSourceMissGoods
            DataController.KeyFieldNames = 'GOODSID'
            DataController.Summary.FooterSummaryItems = <
              item
                Format = '0.00'
                Kind = skCount
                Column = cxGridGoods_GOODS_NAME
              end>
            OptionsBehavior.IncSearch = True
            OptionsBehavior.ImmediateEditor = False
            OptionsData.CancelOnExit = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsSelection.MultiSelect = True
            OptionsSelection.HideFocusRectOnExit = False
            OptionsSelection.InvertSelect = False
            OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
            OptionsView.ScrollBars = ssVertical
            OptionsView.ColumnAutoWidth = True
            OptionsView.Footer = True
            OptionsView.GridLineColor = 13750737
            Styles.ContentEven = dmAdditions.cxStyle_GridContentEven
            Styles.GroupByBox = dmAdditions.cxStyle_GridGroup
            Styles.Header = dmAdditions.cxStyle_GridHeader
            Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
            object cxGridGoods_GOODSTYPE: TcxGridDBColumn
              Caption = 'Tip produs'
              DataBinding.FieldName = 'GOODS_TYPE_NAME'
              MinWidth = 16
              Width = 73
            end
            object cxGridGoods_BRAND: TcxGridDBColumn
              Caption = 'Brand'
              DataBinding.FieldName = 'VENDOR_NAME'
              HeaderAlignmentHorz = taCenter
              MinWidth = 16
              Width = 101
            end
            object cxGridGoods_GOODSID: TcxGridDBColumn
              Caption = 'Cod'
              DataBinding.FieldName = 'GOODSID'
              HeaderAlignmentHorz = taCenter
              MinWidth = 48
              Options.Grouping = False
              Options.HorzSizing = False
              Width = 48
            end
            object cxGridGoods_GOODS_NAME: TcxGridDBColumn
              Caption = 'Produs'
              DataBinding.FieldName = 'TITLE'
              HeaderAlignmentHorz = taCenter
              MinWidth = 16
              Width = 266
            end
            object cxGridGoods_MISSINFO: TcxGridDBColumn
              Caption = 'Ce lipseste'
              DataBinding.FieldName = 'MISSING_PARTS'
              PropertiesClassName = 'TcxLabelProperties'
              Properties.Alignment.Horz = taLeftJustify
              OnGetDisplayText = cxGridGoods_MISSINFOGetDisplayText
              HeaderAlignmentHorz = taCenter
              MinWidth = 160
              Options.HorzSizing = False
              Width = 160
            end
            object cxGridGoods_DATA: TcxGridDBColumn
              Caption = 'Data adaugarii'
              DataBinding.FieldName = 'DATA'
              HeaderAlignmentHorz = taCenter
              MinWidth = 72
              Options.HorzSizing = False
              Width = 72
            end
            object cxGridGoodsTableColumn1: TcxGridDBColumn
              Caption = 'F'
              DataBinding.FieldName = 'FLG_FORCED'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.Alignment = taRightJustify
              Properties.DisplayChecked = '1'
              Properties.DisplayUnchecked = '0'
              Properties.ValueChecked = '1'
              Properties.ValueUnchecked = '0'
              HeaderAlignmentHorz = taCenter
              MinWidth = 21
              Width = 65
            end
          end
          object cxGridGoodsLevel: TcxGridLevel
            GridView = cxGridGoodsTable
          end
        end
        object cxSplitter1: TcxSplitter
          Left = 0
          Top = 575
          Width = 1014
          Height = 7
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          AlignSplitter = salBottom
          DragThreshold = 2
          PositionAfterOpen = 24
          MinSize = 24
          ExplicitTop = 403
          ExplicitWidth = 785
        end
      end
      object dxBarDockControl1: TdxBarDockControl
        Left = 0
        Top = 0
        Width = 1243
        Height = 30
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = dalTop
        BarManager = dxBarManager
        SunkenBorder = True
        UseOwnSunkenBorder = True
      end
    end
    object tbPackages: TcxTabSheet
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Pachete de produse pentru descriere'
      ImageIndex = 1
      object cxGridPacheteWeb: TcxGrid
        Left = 0
        Top = 28
        Width = 1243
        Height = 140
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alTop
        TabOrder = 1
        object tvPacheteWebDB: TcxGridDBTableView
          PopupMenu = dxBarPopupMenuPackage
          OnCustomDrawCell = tvPacheteWebDBCustomDrawCell
          DataController.DataSource = IBCDataSourcePackages
          DataController.KeyFieldNames = 'ID'
          OptionsBehavior.IncSearch = True
          OptionsBehavior.ImmediateEditor = False
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.InvertSelect = False
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          object tvPacheteWebDB_FLG_CLOSED: TcxGridDBColumn
            Caption = '...'
            DataBinding.FieldName = 'FLG_CLOSED'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ValueChecked = '1'
            Properties.ValueUnchecked = '0'
            HeaderAlignmentHorz = taCenter
            MinWidth = 16
            Width = 20
          end
          object tvPacheteWebDB_FLG_CAN_VERITY: TcxGridDBColumn
            Caption = 'Verif'
            DataBinding.FieldName = 'FLG_READY_FOR_VERIFICATION'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ValueChecked = '1'
            Properties.ValueUnchecked = '0'
            HeaderAlignmentHorz = taCenter
            MinWidth = 26
            Options.HorzSizing = False
            Width = 26
          end
          object tvPacheteWebDBFLG_NO_SALARY: TcxGridDBColumn
            Caption = 'Neplatit'
            DataBinding.FieldName = 'FLG_NO_SALARY'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.NullStyle = nssUnchecked
            Properties.ValueChecked = 1
            Properties.ValueUnchecked = 0
            MinWidth = 16
            Width = 40
          end
          object tvPacheteWebDB_PACHETNO: TcxGridDBColumn
            Caption = 'Nr. pachet'
            DataBinding.FieldName = 'ID'
            HeaderAlignmentHorz = taCenter
            MinWidth = 16
            Width = 51
          end
          object tvPacheteWebDB_PRICE: TcxGridDBColumn
            Caption = 'Pret'
            DataBinding.FieldName = 'PRICE'
            HeaderAlignmentHorz = taCenter
            MinWidth = 16
            Width = 50
          end
          object tvPacheteWebDB_DATASTART: TcxGridDBColumn
            Caption = 'Data crearii'
            DataBinding.FieldName = 'DATA_START'
            HeaderAlignmentHorz = taCenter
            MinWidth = 16
            Width = 64
          end
          object tvPacheteWebDB_DATA_ESTIMATIVA: TcxGridDBColumn
            Caption = 'Data estimativa'
            DataBinding.FieldName = 'DATA_ESTIMATE'
            HeaderAlignmentHorz = taCenter
            MinWidth = 16
            Width = 74
          end
          object tvPacheteWebDB_DATAEND: TcxGridDBColumn
            Caption = 'Data finisarii'
            DataBinding.FieldName = 'DATA_END'
            HeaderAlignmentHorz = taCenter
            MinWidth = 16
            Width = 77
          end
          object tvPacheteWebDB_RESPONSABLE_USERID: TcxGridDBColumn
            Caption = 'Operator'
            DataBinding.FieldName = 'RESPONSABLE_USERNAME'
            HeaderAlignmentHorz = taCenter
            MinWidth = 16
            Width = 168
          end
          object tvPacheteWebDB_VERIFIED_BY: TcxGridDBColumn
            Caption = 'Verificat de'
            DataBinding.FieldName = 'APPROVED_USERNAME'
            HeaderAlignmentHorz = taCenter
            MinWidth = 16
            Width = 160
          end
          object tvPacheteWebDB_DESCRIPTION: TcxGridDBColumn
            Caption = 'Mentiuni'
            DataBinding.FieldName = 'COMMENT'
            HeaderAlignmentHorz = taCenter
            MinWidth = 16
            Width = 274
          end
        end
        object cxGridPacheteWebLevel1: TcxGridLevel
          GridView = tvPacheteWebDB
        end
      end
      object dxBarDockControl2: TdxBarDockControl
        Left = 0
        Top = 0
        Width = 1243
        Height = 28
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = dalTop
        BarManager = dxBarManager
      end
      object dxBarDockControl3: TdxBarDockControl
        Left = 0
        Top = 168
        Width = 1243
        Height = 28
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = dalTop
        BarManager = dxBarManager
      end
      object Panel2: TPanel
        Left = 0
        Top = 196
        Width = 1243
        Height = 420
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alClient
        BevelKind = bkFlat
        BevelOuter = bvNone
        Color = clWindow
        ParentBackground = False
        TabOrder = 3
        object cxGrid1: TcxGrid
          Left = 1039
          Top = 0
          Width = 200
          Height = 416
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alRight
          TabOrder = 1
          object cxGrid1DBTableView1: TcxGridDBTableView
            DataController.DataSource = IBCDataSourceGoodsForeign
            OptionsBehavior.IncSearch = True
            OptionsBehavior.ImmediateEditor = False
            OptionsData.CancelOnExit = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsView.GroupByBox = False
            object cxGrid1DBTableView1Column1: TcxGridDBColumn
              Caption = 'CPF'
              DataBinding.FieldName = 'GOODS_CODE'
              MinWidth = 16
              Width = 92
            end
            object cxGrid1DBTableView1Column2: TcxGridDBColumn
              Caption = 'Barcode'
              DataBinding.FieldName = 'BARCODE'
              MinWidth = 16
              Width = 91
            end
          end
          object cxGrid1Level1: TcxGridLevel
            GridView = cxGrid1DBTableView1
          end
        end
        object cxGridGoodsDesc: TcxGrid
          Left = 0
          Top = 0
          Width = 1039
          Height = 416
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alClient
          TabOrder = 0
          object tvGoodsDescDB: TcxGridDBTableView
            PopupMenu = dxBarPopupMenuPackageGoods
            OnDblClick = tvGoodsDescDBDblClick
            OnKeyDown = tvGoodsDescDBKeyDown
            OnCustomDrawCell = tvGoodsDescDBCustomDrawCell
            DataController.DataSource = IBCDataSourcePackageGoods
            DataController.Summary.FooterSummaryItems = <
              item
                Kind = skCount
                Column = tvGoodsDesc_GOODSID
              end>
            OptionsBehavior.IncSearch = True
            OptionsBehavior.ImmediateEditor = False
            OptionsData.CancelOnExit = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsSelection.InvertSelect = False
            OptionsView.ColumnAutoWidth = True
            OptionsView.Footer = True
            OptionsView.GroupByBox = False
            OptionsView.Indicator = True
            object tvGoodsDesc_GOODSTYPE_NAME: TcxGridDBColumn
              Caption = 'tip produs'
              DataBinding.FieldName = 'WEBGOODSTYPE_NAME'
              HeaderAlignmentHorz = taCenter
              MinWidth = 16
              Width = 77
            end
            object tvGoodsDesc_VENDOR_NAME: TcxGridDBColumn
              Caption = 'producator'
              DataBinding.FieldName = 'VENDOR_NAME'
              HeaderAlignmentHorz = taCenter
              HeaderGlyphAlignmentHorz = taCenter
              MinWidth = 16
              Width = 78
            end
            object tvGoodsDesc_GOODSID: TcxGridDBColumn
              Caption = 'cod'
              DataBinding.FieldName = 'GOODSID'
              HeaderAlignmentHorz = taCenter
              MinWidth = 16
              Width = 30
            end
            object tvGoodsDesc_GOODSNAME: TcxGridDBColumn
              Caption = 'produs'
              DataBinding.FieldName = 'TITLE'
              HeaderAlignmentHorz = taCenter
              MinWidth = 16
              Width = 268
            end
            object tvGoodsDesc_IMAGE_CNT: TcxGridDBColumn
              Caption = 'imagini'
              DataBinding.FieldName = 'IMAGES_QTY'
              HeaderAlignmentHorz = taCenter
              MinWidth = 16
              Width = 46
            end
            object tvGoodsDesc_DESC_CNT: TcxGridDBColumn
              Caption = 'caracteristici'
              DataBinding.FieldName = 'PROPERTIES_QTY'
              HeaderAlignmentHorz = taCenter
              MinWidth = 16
              Width = 45
            end
            object tvGoodsDesc_MODEL_RO: TcxGridDBColumn
              Caption = 'model'
              DataBinding.FieldName = 'CODE'
              HeaderAlignmentHorz = taCenter
              MinWidth = 16
              Width = 75
            end
            object tvGoodsDesc_PARAM_RO: TcxGridDBColumn
              Caption = 'parametri'
              DataBinding.FieldName = 'BASE_PARAM'
              HeaderAlignmentHorz = taCenter
              MinWidth = 16
              Width = 80
            end
            object tvGoodsDesc_AUX: TcxGridDBColumn
              Caption = 'detalii'
              DataBinding.FieldName = 'DETAILS'
              HeaderAlignmentHorz = taCenter
              MinWidth = 16
              Width = 89
            end
            object tvGoodsDesc_TRY_CNT: TcxGridDBColumn
              Caption = 'nr. incercari'
              DataBinding.FieldName = 'RETRY_COUNT'
              Visible = False
              HeaderAlignmentHorz = taCenter
              MinWidth = 16
              VisibleForCustomization = False
              Width = 55
            end
            object tvGoodsDescDB_BAD_DESCRIPTION: TcxGridDBColumn
              Caption = 'err'
              DataBinding.FieldName = 'FLG_BAD_DESCRIPTION'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.ValueChecked = '1'
              Properties.ValueUnchecked = '0'
              Visible = False
              HeaderAlignmentHorz = taCenter
              MinWidth = 19
              Options.HorzSizing = False
              Width = 19
            end
            object tvGoodsDesc_FLG_READY: TcxGridDBColumn
              AlternateCaption = 'Produsul este descris'
              Caption = 'G'
              DataBinding.FieldName = 'FLG_READY'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.ValueChecked = '1'
              Properties.ValueUnchecked = '0'
              MinWidth = 16
              Options.HorzSizing = False
              Width = 16
            end
            object tvGoodsDesc_FLG_IN_PRICE: TcxGridDBColumn
              Caption = 'PF'
              DataBinding.FieldName = 'FLG_IN_PRICE'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.ValueChecked = '1'
              Properties.ValueUnchecked = '0'
              HeaderAlignmentHorz = taCenter
              MinWidth = 19
              Options.HorzSizing = False
              Width = 19
            end
          end
          object cxGridGoodsDescLevel1: TcxGridLevel
            GridView = tvGoodsDescDB
          end
        end
      end
    end
    object tsWebCatalog: TcxTabSheet
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Web Catalog'
      ImageIndex = 2
      OnHide = tsWebCatalogHide
      OnShow = tsWebCatalogShow
      object cxDBTreeList: TcxDBTreeList
        Left = 0
        Top = 28
        Width = 1243
        Height = 420
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alTop
        Bands = <
          item
            MinWidth = 16
          end>
        DataController.DataSource = dsWebCatalogImages
        DataController.ImageIndexField = 'IMAGEINDEX'
        DataController.ParentField = 'PARENTID'
        DataController.KeyField = 'CATALOGID'
        FindPanel.ApplyInputDelay = 500
        FindPanel.DisplayMode = fpdmAlways
        FindPanel.Layout = fplCompact
        FindPanel.UseExtendedSyntax = True
        Images = dmAdditions.cxImageList_SWN
        LookAndFeel.Kind = lfUltraFlat
        LookAndFeel.NativeStyle = True
        OptionsBehavior.ChangeDelay = 1000
        OptionsCustomizing.ColumnCustomizing = False
        OptionsCustomizing.ColumnHorzSizing = False
        OptionsData.Editing = False
        OptionsSelection.CellSelect = False
        OptionsView.ScrollBars = ssVertical
        OptionsView.ColumnAutoWidth = True
        OptionsView.Indicator = True
        OptionsView.IndicatorWidth = 10
        OptionsView.NavigatorOffset = 40
        Preview.LeftIndent = 4
        Preview.RightIndent = 4
        RootValue = 0
        ScrollbarAnnotations.CustomAnnotations = <>
        Styles.ColumnHeader = dmAdditions.cxStyle_GridHeader
        TabOrder = 0
        object cxDBTreeList_TITLE: TcxDBTreeListColumn
          Caption.Text = 'Denumirea'
          DataBinding.FieldName = 'TITLE'
          MinWidth = 16
          Width = 56
          Position.ColIndex = 0
          Position.RowIndex = 0
          Position.BandIndex = 0
        end
        object cxDBTreeList_TITLE_RUS: TcxDBTreeListColumn
          Caption.Text = #1053#1072#1079#1074#1072#1085#1080#1077
          DataBinding.FieldName = 'TITLE_RUS'
          MinWidth = 16
          Width = 40
          Position.ColIndex = 1
          Position.RowIndex = 0
          Position.BandIndex = 0
        end
        object cxDBTreeListcx_URL_RO: TcxDBTreeListColumn
          Caption.Text = 'Url'
          DataBinding.FieldName = 'REWRITE_URL_RUS'
          MinWidth = 16
          Width = 48
          Position.ColIndex = 2
          Position.RowIndex = 0
          Position.BandIndex = 0
        end
        object cxDBTreeList_CATALOGID: TcxDBTreeListColumn
          Caption.AlignHorz = taCenter
          Caption.Text = 'ID'
          DataBinding.FieldName = 'CATALOGID'
          MinWidth = 16
          Options.Sizing = False
          Options.Focusing = False
          Width = 48
          Position.ColIndex = 3
          Position.RowIndex = 0
          Position.BandIndex = 0
        end
        object cxDBTreeListcx_FLG_HAS_IMAGE: TcxDBTreeListColumn
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = '1'
          Properties.ValueUnchecked = '0'
          Caption.AlignHorz = taCenter
          Caption.Text = 'Img'
          DataBinding.FieldName = 'FLG_HAS_BIG_IMAGE'
          MinWidth = 16
          Options.Sizing = False
          Width = 29
          Position.ColIndex = 4
          Position.RowIndex = 0
          Position.BandIndex = 0
        end
      end
      object dxBarDockControl4: TdxBarDockControl
        Left = 0
        Top = 0
        Width = 1243
        Height = 28
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = dalTop
        BarManager = dxBarManager
      end
    end
  end
  object IBCQueryMissGoods: TIBCQuery
    KeyFields = 'GOODSID'
    SQLInsert.Strings = (
      'INSERT INTO VW_TS_GOODS'
      
        '  (GOODSID, PARENTID, FLG_FOLDER, BASE_PARAM, BASE_PARAM_RU, COD' +
        'E, CODE_RU, TITLE, DETAILS, FLG_SOCIAL, FLG_OLD, FLG_REQUIRE_CER' +
        'TIFICAT, FLG_PRICE_NBM, FLG_SUPPLIER_PROMO, WARRANTY, GOODS_ACNT' +
        '_ID, GOODS_TYPE_ID, GOODS_TYPE_NAME, WEBGOODSTYPE_ID, WEBGOODSTY' +
        'PE_TITLE, WEBGOODSTYPE_TITLE_RU, VENDOR_ID, USERID, UMID, SERIAL' +
        '_TYPE_ID, ORDERNO, USER_FULLNAME, CREATE_DATE, NAMEACNT, PRICE1,' +
        ' PRICE2, PRICE3, PRICE4, PRICE5, PRICE6, PRICE7, PRICE1_LEI, PRI' +
        'CE2_LEI, PRICE3_LEI, PRICE4_LEI, PRICE5_LEI, PRICE6_LEI, PRICE7_' +
        'LEI, PRICEC1_LEI, PRICEC2_LEI, PRICEC3_LEI, PRICEC4_LEI, PRICEC5' +
        '_LEI, PRICEC6_LEI, PRICEC7_LEI, PRICE1_USD, PRICE2_USD, PRICE3_U' +
        'SD, PRICE4_USD, PRICE5_USD, PRICE6_USD, PRICE7_USD, CURRENCYID, ' +
        'CURRENCY_TITLE, VENDOR, UM_TITLE, QTY_ACCOUNT, MINQTY, DELIVERY_' +
        'TYPEID, DELIVERY_TYPENAME, VAT, CASHBACK_PERCENT)'
      'VALUES'
      
        '  (:GOODSID, :PARENTID, :FLG_FOLDER, :BASE_PARAM, :BASE_PARAM_RU' +
        ', :CODE, :CODE_RU, :TITLE, :DETAILS, :FLG_SOCIAL, :FLG_OLD, :FLG' +
        '_REQUIRE_CERTIFICAT, :FLG_PRICE_NBM, :FLG_SUPPLIER_PROMO, :WARRA' +
        'NTY, :GOODS_ACNT_ID, :GOODS_TYPE_ID, :GOODS_TYPE_NAME, :WEBGOODS' +
        'TYPE_ID, :WEBGOODSTYPE_TITLE, :WEBGOODSTYPE_TITLE_RU, :VENDOR_ID' +
        ', :USERID, :UMID, :SERIAL_TYPE_ID, :ORDERNO, :USER_FULLNAME, :CR' +
        'EATE_DATE, :NAMEACNT, :PRICE1, :PRICE2, :PRICE3, :PRICE4, :PRICE' +
        '5, :PRICE6, :PRICE7, :PRICE1_LEI, :PRICE2_LEI, :PRICE3_LEI, :PRI' +
        'CE4_LEI, :PRICE5_LEI, :PRICE6_LEI, :PRICE7_LEI, :PRICEC1_LEI, :P' +
        'RICEC2_LEI, :PRICEC3_LEI, :PRICEC4_LEI, :PRICEC5_LEI, :PRICEC6_L' +
        'EI, :PRICEC7_LEI, :PRICE1_USD, :PRICE2_USD, :PRICE3_USD, :PRICE4' +
        '_USD, :PRICE5_USD, :PRICE6_USD, :PRICE7_USD, :CURRENCYID, :CURRE' +
        'NCY_TITLE, :VENDOR, :UM_TITLE, :QTY_ACCOUNT, :MINQTY, :DELIVERY_' +
        'TYPEID, :DELIVERY_TYPENAME, :VAT, :CASHBACK_PERCENT)')
    SQLDelete.Strings = (
      'DELETE FROM VW_TS_GOODS'
      'WHERE'
      '  GOODSID = :Old_GOODSID')
    SQLUpdate.Strings = (
      'UPDATE VW_TS_GOODS'
      'SET'
      
        '  GOODSID = :GOODSID, PARENTID = :PARENTID, FLG_FOLDER = :FLG_FO' +
        'LDER, BASE_PARAM = :BASE_PARAM, BASE_PARAM_RU = :BASE_PARAM_RU, ' +
        'CODE = :CODE, CODE_RU = :CODE_RU, TITLE = :TITLE, DETAILS = :DET' +
        'AILS, FLG_SOCIAL = :FLG_SOCIAL, FLG_OLD = :FLG_OLD, FLG_REQUIRE_' +
        'CERTIFICAT = :FLG_REQUIRE_CERTIFICAT, FLG_PRICE_NBM = :FLG_PRICE' +
        '_NBM, FLG_SUPPLIER_PROMO = :FLG_SUPPLIER_PROMO, WARRANTY = :WARR' +
        'ANTY, GOODS_ACNT_ID = :GOODS_ACNT_ID, GOODS_TYPE_ID = :GOODS_TYP' +
        'E_ID, GOODS_TYPE_NAME = :GOODS_TYPE_NAME, WEBGOODSTYPE_ID = :WEB' +
        'GOODSTYPE_ID, WEBGOODSTYPE_TITLE = :WEBGOODSTYPE_TITLE, WEBGOODS' +
        'TYPE_TITLE_RU = :WEBGOODSTYPE_TITLE_RU, VENDOR_ID = :VENDOR_ID, ' +
        'USERID = :USERID, UMID = :UMID, SERIAL_TYPE_ID = :SERIAL_TYPE_ID' +
        ', ORDERNO = :ORDERNO, USER_FULLNAME = :USER_FULLNAME, CREATE_DAT' +
        'E = :CREATE_DATE, NAMEACNT = :NAMEACNT, PRICE1 = :PRICE1, PRICE2' +
        ' = :PRICE2, PRICE3 = :PRICE3, PRICE4 = :PRICE4, PRICE5 = :PRICE5' +
        ', PRICE6 = :PRICE6, PRICE7 = :PRICE7, PRICE1_LEI = :PRICE1_LEI, ' +
        'PRICE2_LEI = :PRICE2_LEI, PRICE3_LEI = :PRICE3_LEI, PRICE4_LEI =' +
        ' :PRICE4_LEI, PRICE5_LEI = :PRICE5_LEI, PRICE6_LEI = :PRICE6_LEI' +
        ', PRICE7_LEI = :PRICE7_LEI, PRICEC1_LEI = :PRICEC1_LEI, PRICEC2_' +
        'LEI = :PRICEC2_LEI, PRICEC3_LEI = :PRICEC3_LEI, PRICEC4_LEI = :P' +
        'RICEC4_LEI, PRICEC5_LEI = :PRICEC5_LEI, PRICEC6_LEI = :PRICEC6_L' +
        'EI, PRICEC7_LEI = :PRICEC7_LEI, PRICE1_USD = :PRICE1_USD, PRICE2' +
        '_USD = :PRICE2_USD, PRICE3_USD = :PRICE3_USD, PRICE4_USD = :PRIC' +
        'E4_USD, PRICE5_USD = :PRICE5_USD, PRICE6_USD = :PRICE6_USD, PRIC' +
        'E7_USD = :PRICE7_USD, CURRENCYID = :CURRENCYID, CURRENCY_TITLE =' +
        ' :CURRENCY_TITLE, VENDOR = :VENDOR, UM_TITLE = :UM_TITLE, QTY_AC' +
        'COUNT = :QTY_ACCOUNT, MINQTY = :MINQTY, DELIVERY_TYPEID = :DELIV' +
        'ERY_TYPEID, DELIVERY_TYPENAME = :DELIVERY_TYPENAME, VAT = :VAT, ' +
        'CASHBACK_PERCENT = :CASHBACK_PERCENT'
      'WHERE'
      '  GOODSID = :Old_GOODSID')
    SQLRefresh.Strings = (
      
        'SELECT GOODSID, PARENTID, FLG_FOLDER, BASE_PARAM, BASE_PARAM_RU,' +
        ' CODE, CODE_RU, TITLE, DETAILS, FLG_SOCIAL, FLG_OLD, FLG_REQUIRE' +
        '_CERTIFICAT, FLG_PRICE_NBM, FLG_SUPPLIER_PROMO, WARRANTY, GOODS_' +
        'ACNT_ID, GOODS_TYPE_ID, GOODS_TYPE_NAME, WEBGOODSTYPE_ID, WEBGOO' +
        'DSTYPE_TITLE, WEBGOODSTYPE_TITLE_RU, VENDOR_ID, USERID, UMID, SE' +
        'RIAL_TYPE_ID, ORDERNO, USER_FULLNAME, CREATE_DATE, NAMEACNT, PRI' +
        'CE1, PRICE2, PRICE3, PRICE4, PRICE5, PRICE6, PRICE7, PRICE1_LEI,' +
        ' PRICE2_LEI, PRICE3_LEI, PRICE4_LEI, PRICE5_LEI, PRICE6_LEI, PRI' +
        'CE7_LEI, PRICEC1_LEI, PRICEC2_LEI, PRICEC3_LEI, PRICEC4_LEI, PRI' +
        'CEC5_LEI, PRICEC6_LEI, PRICEC7_LEI, PRICE1_USD, PRICE2_USD, PRIC' +
        'E3_USD, PRICE4_USD, PRICE5_USD, PRICE6_USD, PRICE7_USD, CURRENCY' +
        'ID, CURRENCY_TITLE, VENDOR, UM_TITLE, QTY_ACCOUNT, MINQTY, DELIV' +
        'ERY_TYPEID, DELIVERY_TYPENAME, VAT, CASHBACK_PERCENT FROM VW_TS_' +
        'GOODS'
      'WHERE'
      '  GOODSID = :GOODSID')
    SQLLock.Strings = (
      'SELECT NULL FROM VW_TS_GOODS'
      'WHERE'
      'GOODSID = :Old_GOODSID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM VW_TS_GOODS'
      ''
      ') q')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'SELECT G.*,  Z.*, S.TITLE VENDOR_NAME, gt.TITLE GOODS_TYPE_NAME'
      'FROM SELECT_MISSING_GOODS_RECURSIVE2(:PARENTID) Z'
      'INNER JOIN TS_GOODS G ON G.GOODSID = Z.GOODSID'
      'JOIN TS_SYSS S ON S.SYSSID=G.VENDOR_ID'
      'join ts_goods_type gt on gt.goodstypeid = g.webgoodstype_id'
      'WHERE Z.MISSING_PARTS > 0 AND'
      '      NOT EXISTS(SELECT GOODSID FROM TCONTENT_PACKAGE_GOODS PG'
      
        '                   INNER JOIN TCONTENT_PACKAGE CP ON PG.PACKAGEI' +
        'D = CP.ID and get_flg_value(CP.flags,1)=0'
      '                    WHERE PG.GOODSID = G.GOODSID)'
      '')
    Left = 314
    Top = 345
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PARENTID'
        Value = nil
      end>
  end
  object IBCDataSourceMissGoods: TIBCDataSource
    DataSet = IBCQueryMissGoods
    Left = 314
    Top = 279
  end
  object IBCQueryTree: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      'SELECT '
      ' GOODSID,'
      ' TITLE,'
      ' DATA,'
      
        ' (SELECT COUNT(GOODSID) FROM TS_GOODS B WHERE (B.PARENTID=A.GOOD' +
        'SID) AND (B.FLG_FOLDER=1)) CHILD_COUNT'
      'FROM '
      ' TS_GOODS A'
      'WHERE'
      ' (FLG_FOLDER=1) AND (PARENTID=:PARENTID)'
      'ORDER BY ORDERNO')
    Left = 45
    Top = 87
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PARENTID'
        Value = nil
      end>
  end
  object dxBarPopupMenu: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbGoodsQuickInfo'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'dxBarButton1'
      end
      item
        Visible = True
        ItemName = 'bbGoodsDescriptions'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbGotoGoods'
      end>
    UseOwnFont = False
    Left = 919
    Top = 274
    PixelsPerInch = 96
  end
  object dxBarManager: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Default'
      'pachet'
      'Produse pachet'
      'Web Catalog')
    Categories.ItemsVisibles = (
      2
      2
      2
      2)
    Categories.Visibles = (
      True
      True
      True
      True)
    ImageOptions.Images = dmAdditions.cxImageList_SWN
    ImageOptions.StretchGlyphs = False
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 314
    Top = 161
    PixelsPerInch = 96
    object dxBarManagerBar2: TdxBar
      Caption = 'Package'
      CaptionButtons = <>
      DockControl = dxBarDockControl2
      DockedDockControl = dxBarDockControl2
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1156
      FloatTop = 0
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarSubItem2'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbModifyPackage'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbDeletePackage'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBar3: TdxBar
      Caption = 'Package Goods'
      CaptionButtons = <>
      DockControl = dxBarDockControl3
      DockedDockControl = dxBarDockControl3
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1479
      FloatTop = 0
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
          ItemName = 'bbDeleteGoods'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbDescription'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'dxBarButton4'
        end
        item
          Visible = True
          ItemName = 'dxBarButton6'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBar1: TdxBar
      Caption = 'General'
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1198
      FloatTop = 0
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarSubItem1'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBar4: TdxBar
      Caption = 'Web Catalog'
      CaptionButtons = <>
      DockControl = dxBarDockControl4
      DockedDockControl = dxBarDockControl4
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1287
      FloatTop = 0
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbModify'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object bbGoodsDescriptions: TdxBarButton
      Caption = 'Descrierea produsului...'
      Category = 0
      Hint = 'Descrierea produsului'
      Visible = ivAlways
      ImageIndex = 22
      ShortCut = 16496
      OnClick = bbGoodsDescriptionsClick
    end
    object bbGotoGoods: TdxBarButton
      Caption = 'Treci la produs in nomenclator'
      Category = 0
      Hint = 'Treci la produs in nomenclator'
      Visible = ivAlways
      OnClick = bbGotoGoodsClick
    end
    object bbGoodsQuickInfo: TdxBarButton
      Caption = 'Informatie despre produs'
      Category = 0
      Hint = 'Informatie despre produs'
      Visible = ivAlways
      ShortCut = 112
      OnClick = bbGoodsQuickInfoClick
    end
    object dxBarSubItem1: TdxBarSubItem
      Align = iaRight
      Caption = 'Filtre'
      Category = 0
      Visible = ivAlways
      ImageIndex = 26
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbCheckDesc'
        end
        item
          Visible = True
          ItemName = 'bbCheckImage'
        end
        item
          Visible = True
          ItemName = 'bbCheckPrice'
        end>
    end
    object bbCheckDesc: TdxBarButton
      Tag = 1
      Caption = 'Caracteristici'
      Category = 0
      Hint = 'Caracteristici'
      Visible = ivAlways
      ButtonStyle = bsChecked
      Down = True
      OnClick = bbCheckDescClick
    end
    object bbCheckPrice: TdxBarButton
      Tag = 4
      Caption = 'Preturi'
      Category = 0
      Hint = 'Preturi'
      Visible = ivAlways
      ButtonStyle = bsChecked
      Down = True
      OnClick = bbCheckDescClick
    end
    object bbCheckImage: TdxBarButton
      Tag = 2
      Caption = 'Imagini'
      Category = 0
      Hint = 'Imagini'
      Visible = ivAlways
      ButtonStyle = bsChecked
      Down = True
      OnClick = bbCheckDescClick
    end
    object dxBarButton1: TdxBarButton
      Caption = 'Creare pachet pentru content...'
      Category = 0
      Hint = 'Creare pachet pentru content'
      Visible = ivAlways
      OnClick = dxBarButton1Click
    end
    object dxBarButton2: TdxBarButton
      Caption = 'Calcula Produsele'
      Category = 0
      Hint = 'Calcula Produsele'
      Visible = ivAlways
    end
    object bbModifyPackage: TdxBarButton
      Caption = 'Modifica'
      Category = 0
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 115
      OnClick = bbModifyPackageClick
    end
    object dxBarButton6: TdxBarButton
      Caption = 'New Button'
      Category = 0
      Hint = 'New Button'
      Visible = ivAlways
    end
    object bbSarcinaOperatorilor: TdxBarButton
      Caption = 'Sarcina operatorilor'
      Category = 0
      Hint = 'Sarcina operatorilor'
      Visible = ivAlways
      OnClick = bbSarcinaOperatorilorClick
    end
    object bbNotAprooved: TdxBarButton
      Caption = 'Pachet neverificat'
      Category = 0
      Hint = 'Pachet neverificat'
      Visible = ivAlways
      OnClick = bbNotAproovedClick
    end
    object bbNewPachet: TdxBarButton
      Caption = 'Nou'
      Category = 1
      Hint = 'Nou'
      Visible = ivAlways
      ImageIndex = 40
    end
    object bbEditPachet: TdxBarButton
      Caption = 'Modifica'
      Category = 1
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 41
    end
    object bbDeletePackage: TdxBarButton
      Caption = 'Sterge'
      Category = 1
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      OnClick = bbDeletePackageClick
    end
    object bbReady: TdxBarButton
      Caption = 'Pachetul este gata pentru verificare'
      Category = 1
      Hint = 'Pachetul este gata pentru verificare'
      Visible = ivAlways
      ShortCut = 118
      OnClick = bbReadyClick
    end
    object bbDescription: TdxBarButton
      Caption = 'Descriere'
      Category = 1
      Hint = 'Descriere'
      Visible = ivAlways
      ImageIndex = 14
      ShortCut = 113
      OnClick = bbDescriptionClick
    end
    object dxBarSubItem2: TdxBarSubItem
      Caption = 'Instrumente'
      Category = 1
      Visible = ivAlways
      ImageIndex = 58
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbRefreshGoodsInfo'
        end
        item
          Visible = True
          ItemName = 'bbSarcinaOperatorilor'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbReady'
        end
        item
          Visible = True
          ItemName = 'bbApproved'
        end>
    end
    object bbApproved: TdxBarButton
      Caption = 'Pachet verificat'
      Category = 1
      Hint = 'Pachet verificat'
      Visible = ivAlways
      ShortCut = 120
      OnClick = bbApprovedClick
    end
    object bbRefreshGoodsInfo: TdxBarButton
      Caption = 'Reinoieste informatia despre pachet'
      Category = 2
      Hint = 'Reinoieste informatia despre pachet'
      Visible = ivAlways
      OnClick = bbRefreshGoodsInfoClick
    end
    object bbBadDescription: TdxBarButton
      Caption = 'Descriere gresita'
      Category = 2
      Hint = 'Descriere gresita'
      Visible = ivAlways
      ImageIndex = 35
      OnClick = bbBadDescriptionClick
    end
    object bbNewGoods: TdxBarButton
      Caption = 'Nou'
      Category = 2
      Hint = 'Nou'
      Visible = ivAlways
      ImageIndex = 40
      OnClick = bbNewGoodsClick
    end
    object bbEditGoods: TdxBarButton
      Caption = 'Modifica'
      Category = 2
      Hint = 'Modifica'
      Visible = ivAlways
    end
    object bbDeleteGoods: TdxBarButton
      Caption = 'Sterge'
      Category = 2
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      OnClick = bbDeleteGoodsClick
    end
    object bbCorrectDescription: TdxBarButton
      Caption = 'Corectat descrierea'
      Category = 2
      Hint = 'Corectat descrierea'
      Visible = ivAlways
      ImageIndex = 43
      OnClick = bbCorrectDescriptionClick
    end
    object dxBarButton4: TdxBarButton
      Caption = 'Mentiuni'
      Category = 2
      Hint = 'Mentiuni'
      Visible = ivAlways
      ImageIndex = 23
      ShortCut = 16397
      OnClick = dxBarButton4Click
    end
    object dxBarButton5: TdxBarButton
      Caption = 'Descriere'
      Category = 2
      Hint = 'Descriere'
      Visible = ivAlways
      ImageIndex = 14
      ShortCut = 113
    end
    object bbClosePackage: TdxBarButton
      Caption = 'Descrierea este finisata'
      Category = 2
      Hint = 'Descrierea este finisata'
      Visible = ivAlways
      ImageIndex = 140
      ShortCut = 120
      OnClick = bbClosePackageClick
    end
    object bbModify: TdxBarButton
      Caption = 'Modifica'
      Category = 3
      Hint = 'Modifica'
      Visible = ivAlways
      ShortCut = 115
      OnClick = bbModifyClick
    end
  end
  object IBCQuerySalariu: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'select * from SP_CONTENT_REVENUE(:userid, :data1, :data2)')
    Left = 143
    Top = 283
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'userid'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'data1'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'data2'
        Value = nil
      end>
  end
  object IBCDataSourceSalariu: TIBCDataSource
    DataSet = IBCQuerySalariu
    Left = 140
    Top = 158
  end
  object IBCDataSourcePackages: TIBCDataSource
    DataSet = IBCQueryPackages
    Left = 567
    Top = 161
  end
  object IBCDataSourcePackageGoods: TIBCDataSource
    DataSet = IBCQueryPackageGoods
    Left = 568
    Top = 280
  end
  object dxBarPopupMenuPackage: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbReady'
      end
      item
        Visible = True
        ItemName = 'bbApproved'
      end
      item
        Visible = True
        ItemName = 'bbNotAprooved'
      end>
    UseOwnFont = False
    Left = 766
    Top = 270
    PixelsPerInch = 96
  end
  object dxBarPopupMenuPackageGoods: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbBadDescription'
      end
      item
        Visible = True
        ItemName = 'bbCorrectDescription'
      end
      item
        Visible = True
        ItemName = 'bbClosePackage'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbRefreshGoodsInfo'
      end>
    UseOwnFont = False
    Left = 767
    Top = 338
    PixelsPerInch = 96
  end
  object IBCQueryPackages: TIBCQuery
    KeyFields = 'ID'
    KeyGenerator = 'GEN_TCONTENT_PACKAGE_ID'
    SQLInsert.Strings = (
      'INSERT INTO VW_TCONTENT_PACKAGE'
      
        '  (ID, DATA_START, DATA_END, DATA_ESTIMATE, FLAGS, FLG_CLOSED, F' +
        'LG_READY_FOR_VERIFICATION, FLG_NO_SALARY, RESPONSABLE_USERID, RE' +
        'SPONSABLE_USERNAME, APPROVED_USERID, APPROVED_USERNAME, DATA_APP' +
        'ROVE, COMMENT, PRICE)'
      'VALUES'
      
        '  (:ID, :DATA_START, :DATA_END, :DATA_ESTIMATE, :FLAGS, :FLG_CLO' +
        'SED, :FLG_READY_FOR_VERIFICATION, :FLG_NO_SALARY, :RESPONSABLE_U' +
        'SERID, :RESPONSABLE_USERNAME, :APPROVED_USERID, :APPROVED_USERNA' +
        'ME, :DATA_APPROVE, :COMMENT, :PRICE)')
    SQLDelete.Strings = (
      'DELETE FROM VW_TCONTENT_PACKAGE'
      'WHERE'
      '  ID = :Old_ID')
    SQLUpdate.Strings = (
      'UPDATE VW_TCONTENT_PACKAGE'
      'SET'
      
        '  ID = :ID, DATA_START = :DATA_START, DATA_END = :DATA_END, DATA' +
        '_ESTIMATE = :DATA_ESTIMATE, FLAGS = :FLAGS, FLG_CLOSED = :FLG_CL' +
        'OSED, FLG_READY_FOR_VERIFICATION = :FLG_READY_FOR_VERIFICATION, ' +
        'FLG_NO_SALARY = :FLG_NO_SALARY, RESPONSABLE_USERID = :RESPONSABL' +
        'E_USERID, RESPONSABLE_USERNAME = :RESPONSABLE_USERNAME, APPROVED' +
        '_USERID = :APPROVED_USERID, APPROVED_USERNAME = :APPROVED_USERNA' +
        'ME, DATA_APPROVE = :DATA_APPROVE, COMMENT = :COMMENT, PRICE = :P' +
        'RICE'
      'WHERE'
      '  ID = :Old_ID')
    SQLRefresh.Strings = (
      
        'SELECT ID, DATA_START, DATA_END, DATA_ESTIMATE, FLAGS, FLG_CLOSE' +
        'D, FLG_READY_FOR_VERIFICATION, FLG_NO_SALARY, RESPONSABLE_USERID' +
        ', RESPONSABLE_USERNAME, APPROVED_USERID, APPROVED_USERNAME, DATA' +
        '_APPROVE, COMMENT, PRICE FROM VW_TCONTENT_PACKAGE'
      'WHERE'
      '  ID = :ID')
    SQLLock.Strings = (
      'SELECT NULL FROM TCONTENT_PACKAGE'
      'WHERE'
      'ID = :Old_ID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM VW_TCONTENT_PACKAGE'
      ''
      ') q')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'select * from VW_TCONTENT_PACKAGE'
      '--where (data_end + 30) >=current_date or (data_end is null)'
      '&CurrentUser'
      'order by id desc')
    LockMode = lmLockImmediate
    Left = 568
    Top = 216
    MacroData = <
      item
        Name = 'CurrentUser'
      end>
  end
  object IBCQueryPackageGoods: TIBCQuery
    KeyFields = 'GOODSID'
    SQLInsert.Strings = (
      'INSERT INTO VW_TCONTENT_PACKAGE_GOODS'
      
        '  (PACKAGEID, GOODSID, TITLE, WEBGOODSTYPE_ID, WEBGOODSTYPE_NAME' +
        ', CODE, BASE_PARAM, CODE_RU, BASE_PARAM_RU, DETAILS, VENDOR_ID, ' +
        'IMAGES_QTY, PROPERTIES_QTY, RETRY_COUNT, FLG_VERIFIED, FLG_BAD_D' +
        'ESCRIPTION, FLG_READY, FLAGS)'
      'VALUES'
      
        '  (:PACKAGEID, :GOODSID, :TITLE, :WEBGOODSTYPE_ID, :WEBGOODSTYPE' +
        '_NAME, :CODE, :BASE_PARAM, :CODE_RU, :BASE_PARAM_RU, :DETAILS, :' +
        'VENDOR_ID, :IMAGES_QTY, :PROPERTIES_QTY, :RETRY_COUNT, :FLG_VERI' +
        'FIED, :FLG_BAD_DESCRIPTION, :FLG_READY, :FLAGS)')
    SQLDelete.Strings = (
      'DELETE FROM VW_TCONTENT_PACKAGE_GOODS'
      'WHERE'
      '  GOODSID = :Old_GOODSID AND PACKAGEID = :Old_PACKAGEID')
    SQLUpdate.Strings = (
      'UPDATE VW_TCONTENT_PACKAGE_GOODS'
      'SET'
      
        '  PACKAGEID = :PACKAGEID, GOODSID = :GOODSID, TITLE = :TITLE, WE' +
        'BGOODSTYPE_ID = :WEBGOODSTYPE_ID, WEBGOODSTYPE_NAME = :WEBGOODST' +
        'YPE_NAME, CODE = :CODE, BASE_PARAM = :BASE_PARAM, CODE_RU = :COD' +
        'E_RU, BASE_PARAM_RU = :BASE_PARAM_RU, DETAILS = :DETAILS, VENDOR' +
        '_ID = :VENDOR_ID, IMAGES_QTY = :IMAGES_QTY, PROPERTIES_QTY = :PR' +
        'OPERTIES_QTY, RETRY_COUNT = :RETRY_COUNT, FLG_VERIFIED = :FLG_VE' +
        'RIFIED, FLG_BAD_DESCRIPTION = :FLG_BAD_DESCRIPTION, FLG_READY = ' +
        ':FLG_READY, FLAGS = :FLAGS'
      'WHERE'
      '  GOODSID = :Old_GOODSID AND PACKAGEID = :Old_PACKAGEID')
    SQLRefresh.Strings = (
      
        'SELECT PACKAGEID, GOODSID, TITLE, WEBGOODSTYPE_ID, WEBGOODSTYPE_' +
        'NAME, CODE, BASE_PARAM, CODE_RU, BASE_PARAM_RU, DETAILS, VENDOR_' +
        'ID, IMAGES_QTY, PROPERTIES_QTY, RETRY_COUNT, FLG_VERIFIED, FLG_B' +
        'AD_DESCRIPTION, FLG_READY, FLAGS FROM VW_TCONTENT_PACKAGE_GOODS'
      'WHERE'
      '  GOODSID = :GOODSID AND PACKAGEID = :PACKAGEID')
    SQLLock.Strings = (
      'SELECT NULL FROM TCONTENT_PACKAGE_GOODS'
      'WHERE'
      'GOODSID = :Old_GOODSID AND PACKAGEID = :Old_PACKAGEID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM VW_TCONTENT_PACKAGE_GOODS'
      ''
      ') q')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      
        'select pg.*, gc.comments, GET_FLG_IN_PRICE(pg.goodsid) flg_in_pr' +
        'ice, g.flg_social'
      'from VW_TCONTENT_PACKAGE_GOODS pg'
      
        'left outer join ts_package_goods_comments gc on gc.goodsid=pg.go' +
        'odsid and gc.packageid = pg.packageid'
      'left outer join vw_ts_goods g on g.goodsid = pg.goodsid')
    MasterFields = 'ID'
    DetailFields = 'PG.PACKAGEID'
    MasterSource = IBCDataSourcePackages
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Left = 567
    Top = 336
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
        Value = nil
      end>
  end
  object IBCQueryGoodsForeign: TIBCQuery
    KeyFields = 'goods_code'
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'select goodsid, goods_code, barcode from ts_goods_foreign')
    MasterFields = 'GOODSID'
    DetailFields = 'GOODSID'
    MasterSource = IBCDataSourcePackageGoods
    Options.DetailDelay = 300
    Left = 1149
    Top = 420
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'GOODSID'
        Value = nil
      end>
  end
  object IBCDataSourceGoodsForeign: TIBCDataSource
    DataSet = IBCQueryGoodsForeign
    Left = 1150
    Top = 353
  end
  object qWebCatalogImages: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      
        'select c.*, iif(tweb_catalog_image.big_image is null, 0, 1) flg_' +
        'has_BIG_image'
      'from tweb_catalog c'
      
        'left outer join tweb_catalog_image on tweb_catalog_image.catalog' +
        'id = c.catalogid')
    Left = 1200
    Top = 88
  end
  object dsWebCatalogImages: TIBCDataSource
    DataSet = qWebCatalogImages
    Left = 1072
    Top = 88
  end
  object IBCDataSourceImage: TIBCDataSource
    DataSet = IBCQueryImage
    Left = 1072
    Top = 154
  end
  object IBCQueryImage: TIBCQuery
    KeyFields = 'CATALOGID'
    SQLInsert.Strings = (
      'INSERT INTO TWEB_CATALOG_IMAGE'
      '  (CATALOGID, IMAGE, BIG_IMAGE)'
      'VALUES'
      '  (:CATALOGID, :IMAGE, :BIG_IMAGE)')
    SQLDelete.Strings = (
      'DELETE FROM TWEB_CATALOG_IMAGE'
      'WHERE'
      '  CATALOGID = :Old_CATALOGID')
    SQLUpdate.Strings = (
      'UPDATE TWEB_CATALOG_IMAGE'
      'SET'
      '  CATALOGID = :CATALOGID, IMAGE = :IMAGE, BIG_IMAGE = :BIG_IMAGE'
      'WHERE'
      '  CATALOGID = :Old_CATALOGID')
    SQLRefresh.Strings = (
      'SELECT * FROM TWEB_CATALOG_IMAGE'
      'WHERE'
      '  CATALOGID = :CATALOGID')
    SQLLock.Strings = (
      'SELECT NULL FROM TWEB_CATALOG_IMAGE'
      'WHERE'
      'CATALOGID = :Old_CATALOGID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM TWEB_CATALOG_IMAGE'
      ''
      ') q')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'SELECT'
      '      I.CATALOGID,'
      '      I.IMAGE,'
      '      C.TITLE,'
      '      C.TITLE_RUS,'
      '      I.BIG_IMAGE'
      'FROM TWEB_CATALOG_IMAGE I'
      'INNER JOIN TWEB_CATALOG C ON C.CATALOGID = I.CATALOGID')
    MasterFields = 'CATALOGID'
    DetailFields = 'I.CATALOGID'
    MasterSource = dsWebCatalogImages
    AutoCommit = False
    Options.DetailDelay = 500
    Left = 1200
    Top = 154
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CATALOGID'
        Value = nil
      end>
  end
end
