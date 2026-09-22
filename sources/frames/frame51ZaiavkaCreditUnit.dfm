inherited frame51ZaiavkaCredit: Tframe51ZaiavkaCredit
  Width = 1165
  Height = 563
  Font.Height = -15
  ExplicitWidth = 1165
  ExplicitHeight = 563
  PixelsPerInch = 120
  object cxGridWZ: TcxGrid
    Left = 0
    Top = 0
    Width = 1165
    Height = 281
    Align = alClient
    TabOrder = 0
    LookAndFeel.NativeStyle = True
    LookAndFeel.SkinName = ''
    object cxGridWZTable: TcxGridDBTableView
      OnKeyDown = cxGridWZTableKeyDown
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
      OnCellDblClick = cxGridWZTableCellDblClick
      OnCustomDrawCell = cxGridWZTableCustomDrawCell
      DataController.KeyFieldNames = 'DOCID'
      FilterRow.SeparatorWidth = 8
      FixedDataRows.SeparatorWidth = 8
      NewItemRow.SeparatorWidth = 8
      OptionsBehavior.IncSearch = True
      OptionsBehavior.ImmediateEditor = False
      OptionsCustomize.ColumnsQuickCustomization = True
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.InvertSelect = False
      OptionsView.NavigatorOffset = 63
      OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
      OptionsView.ScrollBars = ssVertical
      OptionsView.ColumnAutoWidth = True
      OptionsView.FixedColumnSeparatorWidth = 3
      OptionsView.GridLineColor = 13750737
      OptionsView.GroupRowStyle = grsOffice11
      Preview.LeftIndent = 25
      Preview.RightIndent = 6
      RowLayout.MinValueWidth = 100
      Styles.GroupByBox = dmAdditions.cxStyle_GridGroup
      Styles.Header = dmAdditions.cxStyle_GridHeader
      Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
      object cxGridWZ_FLG_CLOSED: TcxGridDBColumn
        Caption = 'Inchis'
        DataBinding.FieldName = 'FLG_CLOSED'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        HeaderAlignmentHorz = taCenter
        MinWidth = 46
        Options.HorzSizing = False
        Width = 46
      end
      object cxGridWZ_DOCID: TcxGridDBColumn
        Caption = 'Cod'
        DataBinding.FieldName = 'DOCID'
        HeaderAlignmentHorz = taCenter
        MinWidth = 60
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 60
      end
      object cxGridWZ_DATA: TcxGridDBColumn
        Caption = 'Data'
        DataBinding.FieldName = 'DATA'
        OnGetDisplayText = cxGridWZ_DATAGetDisplayText
        HeaderAlignmentHorz = taCenter
        MinWidth = 100
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 100
      end
      object cxGridWZ_DTDEP_NAME: TcxGridDBColumn
        Caption = #1057#1082#1083#1072#1076
        DataBinding.FieldName = 'DTDEP_NAME'
        Visible = False
        Width = 100
      end
      object cxGridWZ_CREATED_DATE: TcxGridDBColumn
        Caption = 'Data crearii'
        DataBinding.FieldName = 'CREATED_DATE'
        Width = 117
      end
      object cxGridWZ_CT_NAME: TcxGridDBColumn
        Caption = 'Client'
        DataBinding.FieldName = 'CT_NAME'
        Styles.Content = dmAdditions.cxStyle_GridColumnBOLD
        Width = 462
      end
      object cxGridWZ_SUMA: TcxGridDBColumn
        Caption = 'Suma'
        DataBinding.FieldName = 'SUMA'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 80
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 80
      end
      object cxGridWZ_CURRENCY_NAME: TcxGridDBColumn
        Caption = 'Valuta'
        DataBinding.FieldName = 'CURRENCY_NAME'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        MinWidth = 70
        Options.HorzSizing = False
        Width = 70
      end
      object cxGridWZ_VAT: TcxGridDBColumn
        Caption = 'TVA'
        DataBinding.FieldName = 'VAT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 70
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 70
      end
      object cxGridWZ_RATE: TcxGridDBColumn
        Caption = #1050#1091#1088#1089' '#1044#1086#1082'.'
        DataBinding.FieldName = 'RATE'
        Visible = False
        HeaderAlignmentHorz = taCenter
        MinWidth = 80
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 80
      end
      object cxGridWZ_PARENTDOCID: TcxGridDBColumn
        Caption = #1050#1086#1076' '#1088#1086#1076'.'
        DataBinding.FieldName = 'PARENTDOCID'
        Visible = False
        HeaderAlignmentHorz = taCenter
        MinWidth = 70
        Options.HorzSizing = False
        Width = 70
      end
      object cxGridWZ_FLG_ACNT: TcxGridDBColumn
        Caption = 'Cntb'
        DataBinding.FieldName = 'FLG_ACNT'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        HeaderAlignmentHorz = taCenter
        MinWidth = 40
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 40
      end
      object cxGridWZ_RESPONSIBLE_USERNAME: TcxGridDBColumn
        Caption = 'Responsabil'
        DataBinding.FieldName = 'RESPONSIBLE_USERNAME'
        MinWidth = 100
        Options.HorzSizing = False
        Width = 100
      end
      object cxGridWZ_CREATED_BY_NAME: TcxGridDBColumn
        Caption = 'Utilizator'
        DataBinding.FieldName = 'CREATED_BY_NAME'
        Width = 117
      end
      object cxGridWZ_CT: TcxGridDBColumn
        DataBinding.FieldName = 'CT'
        Visible = False
      end
      object cxGridWZ_DTSC: TcxGridDBColumn
        Caption = 'Analitica'
        DataBinding.FieldName = 'DTSC_NAME'
        Width = 111
      end
    end
    object cxGridWZLevel: TcxGridLevel
      GridView = cxGridWZTable
    end
  end
  object cxSplitter1: TcxSplitter
    Left = 0
    Top = 281
    Width = 1165
    Height = 10
    HotZoneClassName = 'TcxMediaPlayer9Style'
    AlignSplitter = salBottom
    MinSize = 300
    Control = cxPageControl
  end
  object cxPageControl: TcxPageControl
    Left = 0
    Top = 291
    Width = 1165
    Height = 272
    Align = alBottom
    TabOrder = 2
    Properties.ActivePage = tbsGoods
    Properties.CustomButtons.Buttons = <>
    Properties.TabPosition = tpBottom
    ClientRectBottom = 240
    ClientRectLeft = 4
    ClientRectRight = 1161
    ClientRectTop = 4
    object tbsGoods: TcxTabSheet
      Caption = 'Produse (&1)'
      ImageIndex = 0
      ExplicitHeight = 239
      object cxGridComponents: TcxGrid
        Left = 0
        Top = 0
        Width = 1157
        Height = 236
        Align = alClient
        TabOrder = 0
        LookAndFeel.NativeStyle = True
        LookAndFeel.SkinName = ''
        ExplicitHeight = 239
        object cxGridComponentsTable: TcxGridDBTableView
          OnKeyDown = cxGridComponentsTableKeyDown
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
          OnCustomDrawCell = cxGridComponentsTableCustomDrawCell
          DataController.KeyFieldNames = 'DOCID;DTDEP;CTDEP;GOODSCOMPLECT_ID;GOODSID'
          DataController.Summary.FooterSummaryItems = <
            item
              Kind = skSum
              FieldName = 'QTY'
              Column = cxGridDBCol_QTY
            end
            item
              Kind = skSum
              FieldName = 'SUMA'
              Column = cxGridDBCol_SUMA
            end
            item
              Kind = skSum
              FieldName = 'SUMAVAT'
              Column = cxGridDBCol_SUMAVAT
            end
            item
              Kind = skCount
              Column = cxGridDBCol_GOODSID
            end>
          FilterRow.SeparatorWidth = 8
          FixedDataRows.SeparatorWidth = 8
          NewItemRow.SeparatorWidth = 8
          OptionsBehavior.IncSearch = True
          OptionsBehavior.ImmediateEditor = False
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.InvertSelect = False
          OptionsView.NavigatorOffset = 63
          OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
          OptionsView.ScrollBars = ssVertical
          OptionsView.ColumnAutoWidth = True
          OptionsView.FixedColumnSeparatorWidth = 3
          OptionsView.Footer = True
          OptionsView.GridLineColor = 13750737
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          Preview.LeftIndent = 25
          Preview.RightIndent = 6
          RowLayout.MinValueWidth = 100
          Styles.Footer = dmAdditions.cxStyle_GridHeader
          Styles.Header = dmAdditions.cxStyle_GridHeader
          Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
          object cxGridDBCol_DTDEP_NAME: TcxGridDBColumn
            Caption = 'Depozit'
            DataBinding.FieldName = 'DTDEP_NAME'
            MinWidth = 140
            Options.HorzSizing = False
            Width = 140
          end
          object cxGridDBCol_GOODSID: TcxGridDBColumn
            Caption = 'Cod'
            DataBinding.FieldName = 'GOODSID'
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            MinWidth = 70
            Options.HorzSizing = False
            Width = 70
          end
          object cxGridDBCol_IMG: TcxGridDBColumn
            DataBinding.FieldName = 'GOODS_TYPE_ID'
            PropertiesClassName = 'TcxImageComboBoxProperties'
            Properties.DefaultImageIndex = 12
            Properties.Images = dmAdditions.cxImageList_SWN
            Properties.Items = <
              item
                ImageIndex = 12
              end
              item
                ImageIndex = 44
                Value = 4203
              end>
            MinWidth = 24
            Options.Focusing = False
            Options.IncSearch = False
            Options.HorzSizing = False
            Options.Moving = False
            Options.ShowCaption = False
            Options.Sorting = False
            VisibleForCustomization = False
            Width = 24
            IsCaptionAssigned = True
          end
          object cxGridDBCol_GOODS_NAME: TcxGridDBColumn
            Caption = 'Produs'
            DataBinding.FieldName = 'GOODS_NAME'
            HeaderAlignmentHorz = taCenter
            Width = 200
          end
          object cxGridDBCol_QTY: TcxGridDBColumn
            Caption = 'Cant'
            DataBinding.FieldName = 'QTY'
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            MinWidth = 50
            Options.Focusing = False
            Options.HorzSizing = False
            Width = 50
          end
          object cxGridDBCol_UM_NAME: TcxGridDBColumn
            Caption = 'UM'
            DataBinding.FieldName = 'UM_NAME'
            PropertiesClassName = 'TcxLabelProperties'
            Properties.Alignment.Horz = taCenter
            HeaderAlignmentHorz = taCenter
            MinWidth = 40
            Options.HorzSizing = False
            Options.Sorting = False
            Width = 40
          end
          object cxGridDBCol_PRICE: TcxGridDBColumn
            Caption = 'Pret'
            DataBinding.FieldName = 'PRICE'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00'
            HeaderAlignmentHorz = taCenter
            MinWidth = 70
            Options.HorzSizing = False
            Width = 70
          end
          object cxGridDBCol_SUMA: TcxGridDBColumn
            Caption = 'Suma'
            DataBinding.FieldName = 'SUMA'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00'
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            MinWidth = 70
            Options.HorzSizing = False
            Styles.Footer = dmAdditions.cxStyle_MoneyCounter_Total
            Width = 70
          end
          object cxGridDBCol_SUMAVAT: TcxGridDBColumn
            Caption = 'TVA'
            DataBinding.FieldName = 'SUMAVAT'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00'
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            MinWidth = 70
            Options.HorzSizing = False
            Width = 70
          end
          object cxGridDBCol_STOCK_QTY: TcxGridDBColumn
            Caption = 'Stock'
            DataBinding.FieldName = 'STOCK_QTY'
            HeaderAlignmentHorz = taCenter
            MinWidth = 50
            Options.HorzSizing = False
            Width = 50
          end
          object cxGridDBCol_GOODS_TYPE_ID: TcxGridDBColumn
            DataBinding.FieldName = 'GOODS_TYPE_ID'
            Visible = False
            VisibleForCustomization = False
          end
          object cxGridDBCol_FLG_READY: TcxGridDBColumn
            Caption = #1043#1086#1090#1086#1074
            DataBinding.FieldName = 'FLG_READY'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ValueChecked = 1
            Properties.ValueUnchecked = 0
            Visible = False
            HeaderAlignmentHorz = taCenter
            MinWidth = 40
            Options.Filtering = False
            Options.FilteringWithFindPanel = False
            Options.Focusing = False
            Options.FilteringAddValueItems = False
            Options.FilteringFilteredItemsList = False
            Options.FilteringMRUItemsList = False
            Options.FilteringPopup = False
            Options.FilteringPopupMultiSelect = False
            Options.GroupFooters = False
            Options.Grouping = False
            Options.HorzSizing = False
            Options.Moving = False
            Options.Sorting = False
            Width = 40
          end
          object cxGridComponentsTable_FLG_FORCED_ADDON: TcxGridDBColumn
            Caption = '...'
            DataBinding.FieldName = 'FLG_FORCED_ADDON'
            PropertiesClassName = 'TcxImageComboBoxProperties'
            Properties.Images = cxImageList1
            Properties.Items = <
              item
                ImageIndex = 0
                Value = 2
              end
              item
                ImageIndex = 1
                Value = 1
              end
              item
                ImageIndex = 2
                Value = 4
              end
              item
                ImageIndex = 3
                Value = 3
              end>
            HeaderAlignmentHorz = taCenter
            MinWidth = 26
            Options.Editing = False
            Options.Filtering = False
            Options.FilteringWithFindPanel = False
            Options.Focusing = False
            Options.IncSearch = False
            Options.FilteringAddValueItems = False
            Options.FilteringFilteredItemsList = False
            Options.FilteringMRUItemsList = False
            Options.FilteringPopup = False
            Options.FilteringPopupMultiSelect = False
            Options.GroupFooters = False
            Options.Grouping = False
            Options.HorzSizing = False
            Options.Moving = False
            Options.Sorting = False
            Width = 26
          end
        end
        object cxGridLevel: TcxGridLevel
          GridView = cxGridComponentsTable
        end
      end
    end
    object tbsClientInfo: TcxTabSheet
      Caption = 'Cerere de finantare (&2)'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object ScrollBox1: TScrollBox
        Left = 0
        Top = 0
        Width = 1157
        Height = 242
        HorzScrollBar.Smooth = True
        Align = alClient
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        TabOrder = 0
        object pnInfoPerson: TPanel
          Left = 0
          Top = 0
          Width = 333
          Height = 242
          Align = alLeft
          BevelOuter = bvNone
          TabOrder = 0
          object Label2: TLabel
            Left = 0
            Top = 0
            Width = 289
            Height = 20
            Align = alTop
            Caption = '1. Persoana care depune cerere de creditare'
          end
          object cxDBVerticalGrid1: TcxDBVerticalGrid
            Left = 0
            Top = 15
            Width = 333
            Height = 227
            Align = alClient
            OptionsView.RowHeaderWidth = 160
            OptionsBehavior.ImmediateEditor = False
            OptionsBehavior.AllowChangeRecord = False
            OptionsData.Editing = False
            OptionsData.Appending = False
            OptionsData.Deleting = False
            OptionsData.Inserting = False
            ScrollbarAnnotations.CustomAnnotations = <>
            Styles.Header = dmAdditions.cxStyle_Goods_GeneralHeader
            TabOrder = 0
            DataController.DataSource = IBCDataSourceInfo
            Version = 1
            object cxDBEditorRow1: TcxDBEditorRow
              Properties.DataBinding.FieldName = 'NPP'
              ID = 0
              ParentID = -1
              Index = 0
              Version = 1
            end
            object cxDBEditorRow2: TcxDBEditorRow
              Properties.Caption = 'Numar de indentificare'
              Properties.DataBinding.FieldName = 'IDEN'
              ID = 1
              ParentID = -1
              Index = 1
              Version = 1
            end
            object cxDBEditorRow3: TcxDBEditorRow
              Properties.Caption = 'Data nasterii'
              Properties.DataBinding.FieldName = 'DATA_NASTERII'
              ID = 2
              ParentID = -1
              Index = 2
              Version = 1
            end
            object cxDBEditorRow4: TcxDBEditorRow
              Properties.Caption = 'Numar de contact'
              Properties.DataBinding.FieldName = 'CONTACT_TELEFON'
              ID = 3
              ParentID = -1
              Index = 3
              Version = 1
            end
          end
        end
        object pnInfoScan: TPanel
          AlignWithMargins = True
          Left = 335
          Top = 0
          Width = 250
          Height = 242
          Margins.Left = 2
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alLeft
          BevelOuter = bvNone
          TabOrder = 1
          object Label5: TLabel
            Left = 0
            Top = 0
            Width = 179
            Height = 20
            Align = alTop
            Caption = 'Date buletin de indentitate'
          end
          object cxDBVerticalGrid5: TcxDBVerticalGrid
            Left = 0
            Top = 15
            Width = 250
            Height = 227
            Align = alClient
            OptionsView.RowHeaderWidth = 193
            OptionsBehavior.ImmediateEditor = False
            OptionsBehavior.AllowChangeRecord = False
            OptionsData.Editing = False
            OptionsData.Appending = False
            OptionsData.Deleting = False
            OptionsData.Inserting = False
            ScrollbarAnnotations.CustomAnnotations = <>
            Styles.Header = dmAdditions.cxStyle_Goods_GeneralHeader
            TabOrder = 0
            DataController.DataSource = IBCDataSourceInfo
            Version = 1
            object cxDBEditorRow21: TcxDBEditorRow
              Properties.Caption = 'Copia buletinului prin fax'
              Properties.EditPropertiesClassName = 'TcxCheckBoxProperties'
              Properties.EditProperties.ValueChecked = 1
              Properties.EditProperties.ValueUnchecked = 0
              Properties.DataBinding.FieldName = 'FLG_COPY_BY_FAX'
              ID = 0
              ParentID = -1
              Index = 0
              Version = 1
            end
            object cxDBVerticalGrid5DBEditorRow1: TcxDBEditorRow
              Properties.Caption = 'Scan buletin din fata'
              Properties.EditPropertiesClassName = 'TcxCheckBoxProperties'
              Properties.EditProperties.ValueChecked = 1
              Properties.EditProperties.ValueUnchecked = 0
              Properties.DataBinding.FieldName = 'FLG_HAS_SCAN1'
              ID = 1
              ParentID = -1
              Index = 1
              Version = 1
            end
            object cxDBVerticalGrid5DBEditorRow2: TcxDBEditorRow
              Properties.Caption = 'Scan buletin din spate'
              Properties.EditPropertiesClassName = 'TcxCheckBoxProperties'
              Properties.EditProperties.ValueChecked = 1
              Properties.EditProperties.ValueUnchecked = 0
              Properties.DataBinding.FieldName = 'FLG_HAS_SCAN2'
              ID = 2
              ParentID = -1
              Index = 2
              Version = 1
            end
          end
        end
        object cxDBImage1: TcxDBImage
          Left = 600
          Top = 16
          DataBinding.DataField = 'SCAN1'
          DataBinding.DataSource = IBCDataSourceInfo
          Properties.GraphicClassName = 'TdxSmartImage'
          TabOrder = 2
          Height = 225
          Width = 209
        end
        object cxDBImage2: TcxDBImage
          Left = 824
          Top = 17
          DataBinding.DataField = 'SCAN2'
          DataBinding.DataSource = IBCDataSourceInfo
          Properties.GraphicClassName = 'TdxSmartImage'
          TabOrder = 4
          Height = 225
          Width = 217
        end
        object cxButton1: TcxButton
          Left = 1064
          Top = 48
          Width = 75
          Height = 25
          Caption = 'Save'
          TabOrder = 5
          OnClick = cxButton1Click
        end
        object cxButton2: TcxButton
          Left = 1064
          Top = 16
          Width = 75
          Height = 25
          Caption = 'Edit'
          TabOrder = 3
          OnClick = cxButton2Click
        end
      end
    end
  end
  object dxBarManager: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Popup Goods'
      'Default')
    Categories.ItemsVisibles = (
      2
      2)
    Categories.Visibles = (
      True
      True)
    ImageOptions.Images = dmAdditions.cxImageList_SWN
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 528
    Top = 160
    PixelsPerInch = 120
    object bbDocClose: TdxBarButton
      Caption = 'Inchide documentul'
      Category = 1
      Hint = 'Inchide documentul'
      Visible = ivAlways
      ShortCut = 120
      OnClick = bbDocCloseClick
    end
    object bbCreateConfigurator: TdxBarButton
      Caption = 'Creaza o configuratie'
      Category = 1
      Hint = 'Creaza o configuratie'
      Visible = ivAlways
      OnClick = bbCreateConfiguratorClick
    end
    object bbDocComments: TdxBarButton
      Caption = 'Mentiuni...'
      Category = 1
      Hint = 'Mentiuni'
      Visible = ivAlways
      OnClick = bbDocCommentsClick
    end
  end
  object dxBarPopupMenu: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbCreateConfigurator'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbDocClose'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbDocComments'
      end>
    UseOwnFont = False
    OnPopup = dxBarPopupMenuPopup
    Left = 288
    Top = 156
    PixelsPerInch = 120
  end
  object cxGridPopupMenu1: TcxGridPopupMenu
    Grid = cxGridWZ
    PopupMenus = <
      item
        GridView = cxGridWZTable
        HitTypes = [gvhtCell, gvhtRecord]
        Index = 0
        PopupMenu = dxBarPopupMenu
      end>
    Left = 400
    Top = 104
  end
  object IBCQueryInfo: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'SELECT'
      
        ' DOCID, CREDIT_SUMA, CREDIT_PERIOADA, NPP, IDEN, DATA_NASTERII, ' +
        'CONTACT_TELEFON, FLG_COPY_BY_FAX,'
      
        ' IIF(SCAN1 IS NOT NULL AND OCTET_LENGTH(SCAN1)>0,1,0) FLG_HAS_SC' +
        'AN1,'
      
        ' IIF(SCAN2 IS NOT NULL AND OCTET_LENGTH(SCAN2)>0,1,0) FLG_HAS_SC' +
        'AN2,'
      ' scan1, scan2'
      'FROM TWEB_CERERE_FINANTARE')
    MasterFields = 'DOCID'
    DetailFields = 'DOCID'
    MasterSource = dmDB.IBCDataSourceDocs
    Options.DetailDelay = 100
    Left = 184
    Top = 184
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DOCID'
        Value = nil
      end>
  end
  object IBCDataSourceInfo: TIBCDataSource
    DataSet = IBCQueryInfo
    Left = 184
    Top = 328
  end
  object cxImageList1: TcxImageList
    SourceDPI = 96
    FormatVersion = 1
    DesignInfo = 14680592
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
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FFFFFFFFFFFF
          FFFFF8FCF6FFF3F9EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFD0E8C4FFADD698FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFD0E8C4FFADD698FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFD0E8C4FFADD698FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFD0E8C4FFADD698FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFD0E8C4FFADD698FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFD0E8C4FFA5D28EFFFCFEFBFFFFFFFFFFF6FBF3FFC6E3B8FF97CB7DFF79BC
          57FF69B444FF64B23EFF81C062FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFD0E8C4FF339900FF349A01FF3B9D0AFF339900FF339900FF339900FF3399
          00FF339900FF339900FF48A41AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFD0E8C4FF339900FF339900FF339900FF339900FF339900FF339900FF3399
          00FF339900FF339900FF48A41AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFD0E8C4FF339900FF339900FF339900FF339900FF339900FF339900FF3399
          00FF339900FF339900FF48A41AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFD0E8C4FF339900FF339900FF339900FF339900FF339900FF339900FF3399
          00FF339900FF339900FF48A41AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFD0E8C4FF339900FF339900FF339900FF339900FF339900FF339900FF3399
          00FF339900FF339900FF48A41AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFD0E8C4FF339900FF339900FF339900FF339900FF339900FF339900FF3399
          00FF339900FF339900FF48A41AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFDBEDD1FF339900FF339900FF339900FF339900FF349A02FF4FA723FF75BA
          52FF89C46CFF7EBF5EFF77BB55FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFD8ECCEFFBBDDAAFFC0E0B0FFD9ECCFFFF7FBF5FFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
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
      end>
  end
end
