object frmGoodsFolderEditorDialog: TfrmGoodsFolderEditorDialog
  Left = 0
  Top = 0
  ActiveControl = edTITLE
  BorderStyle = bsDialog
  Caption = 'Map'#259' produse'
  ClientHeight = 565
  ClientWidth = 720
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  DesignSize = (
    720
    565)
  TextHeight = 15
  object cxLabel3: TLabel
    Left = 8
    Top = 312
    Width = 137
    Height = 15
    Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1087#1072#1087#1082#1080' '#1076#1083#1103' WEB'
    Transparent = True
    Visible = False
  end
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 720
    Height = 64
    Title = 'Map'#259
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
  object pcPageControl: TPageControl
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 704
    Height = 434
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    ActivePage = cxTabSheet1
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 1
    object cxTabSheet1: TTabSheet
      Caption = 'Generale'
      object cxLabel1: TLabel
        Left = 14
        Top = 0
        Width = 85
        Height = 15
        Caption = 'Denumire map'#259
        Transparent = True
      end
      object cxLabel2: TLabel
        Left = 430
        Top = 43
        Width = 109
        Height = 15
        Caption = 'Tip produse in map'#259
        Transparent = True
      end
      object Label1: TLabel
        Left = 14
        Top = 46
        Width = 130
        Height = 15
        Caption = 'Tipul produselor implicit'
        Transparent = True
      end
      object sbCustomWebGoodsType: TSpeedButton
        Left = 229
        Top = 62
        Width = 26
        Height = 27
        Glyph.Data = {
          32020000424D3202000000000000320100002800000010000000100000000100
          08000000000000010000120B0000120B00003F0000003F00000000000000FFFF
          FF00FF00FF00B78E6B00AB7F56009E6E3E009D703F009C724000A8855900B296
          6F00C1AC8C00C5B39500A58D5E00B09A7000967D4600B9A88200A4957300AA98
          6A00BCB18D0092844900ADA1740091884A009F985F00ABA57600B6B18800948F
          55009A977700B1AE8A00979357008F8C4D00BAB99100A9AA78009A9D7B008C93
          4F00A6AB7600757C4300A6AE7A00B8BE9400B8C09500979E7A008A9A52007180
          430089A05400B8C6980098A57D00B6C59600A4B97D00B1C58D0087A7550099B5
          6D009EB97500A4BD7E0096A67C00B6C9970088AA560090B0630092B2660098AA
          7F00A4C17E00B5CD980086B057008DB4610086B55800020202022B2419020202
          020202020202023E3D3831321529231D130C02020202023E33333A3A1534393B
          3B2F08020202023E2E3333331334393B3B3B07020202023E2E242E331334393B
          3B3B07020202023E1F2E242E13342C3B3B3B06020202023E1F1F242E0E342C2D
          2D3B06020202023E171F1F2E0E272C2D2D3506020202023E14171F180E272C2D
          2D2D06020202023C1414171E0E27202D2D2D06020202023C090D141E07272025
          262D06020202023C09090D0B0E1A2025252606020202023C0309090B07202025
          252506020202023C03030A0F07201B1E252505020202023C16221C111012121E
          1E120402020202373736302A28211513070802020202}
        OnClick = sbCustomWebGoodsTypeClick
      end
      object cxLabel21: TLabel
        Left = 278
        Top = 43
        Width = 88
        Height = 15
        Caption = 'Evident'#259' implicit'
        Transparent = True
      end
      object Label3: TLabel
        Left = 273
        Top = 94
        Width = 92
        Height = 15
        Caption = 'Tip livrare produs'
        Transparent = True
      end
      object lbVAT: TLabel
        Left = 587
        Top = 43
        Width = 21
        Height = 15
        Caption = 'TVA'
        Transparent = True
      end
      object Label2: TLabel
        Left = 648
        Top = 67
        Width = 10
        Height = 15
        Caption = '%'
        Transparent = True
      end
      object Label4: TLabel
        Left = 387
        Top = 94
        Width = 67
        Height = 15
        Caption = 'Cashback, %'
        Transparent = True
      end
      object Label5: TLabel
        Left = 14
        Top = 94
        Width = 124
        Height = 15
        Caption = 'Sablon pentru descriere'
      end
      object Label6: TLabel
        Left = 486
        Top = 94
        Width = 158
        Height = 15
        Caption = 'Cheie pentru produse inrudite'
      end
      object SpeedButton1: TSpeedButton
        Left = 229
        Top = 111
        Width = 26
        Height = 27
        Glyph.Data = {
          32020000424D3202000000000000320100002800000010000000100000000100
          08000000000000010000120B0000120B00003F0000003F00000000000000FFFF
          FF00FF00FF00B78E6B00AB7F56009E6E3E009D703F009C724000A8855900B296
          6F00C1AC8C00C5B39500A58D5E00B09A7000967D4600B9A88200A4957300AA98
          6A00BCB18D0092844900ADA1740091884A009F985F00ABA57600B6B18800948F
          55009A977700B1AE8A00979357008F8C4D00BAB99100A9AA78009A9D7B008C93
          4F00A6AB7600757C4300A6AE7A00B8BE9400B8C09500979E7A008A9A52007180
          430089A05400B8C6980098A57D00B6C59600A4B97D00B1C58D0087A7550099B5
          6D009EB97500A4BD7E0096A67C00B6C9970088AA560090B0630092B2660098AA
          7F00A4C17E00B5CD980086B057008DB4610086B55800020202022B2419020202
          020202020202023E3D3831321529231D130C02020202023E33333A3A1534393B
          3B2F08020202023E2E3333331334393B3B3B07020202023E2E242E331334393B
          3B3B07020202023E1F2E242E13342C3B3B3B06020202023E1F1F242E0E342C2D
          2D3B06020202023E171F1F2E0E272C2D2D3506020202023E14171F180E272C2D
          2D2D06020202023C1414171E0E27202D2D2D06020202023C090D141E07272025
          262D06020202023C09090D0B0E1A2025252606020202023C0309090B07202025
          252506020202023C03030A0F07201B1E252505020202023C16221C111012121E
          1E120402020202373736302A28211513070802020202}
        OnClick = SpeedButton1Click
      end
      object cmbGoodsType: TcxDBLookupComboBox
        Left = 430
        Top = 64
        DataBinding.DataField = 'GOODS_TYPE_ID'
        ParentFont = False
        Properties.DropDownRows = 16
        Properties.IncrementalFilteringOptions = [ifoHighlightSearchText, ifoUseContainsOperator]
        Properties.KeyFieldNames = 'GOODSTYPEID'
        Properties.ListColumns = <
          item
            FieldName = 'TITLE'
          end>
        Properties.ListOptions.GridLines = glHorizontal
        Properties.ListOptions.ShowHeader = False
        Properties.ListSource = IBCDataSourceGoodsType
        TabOrder = 3
        Width = 133
      end
      object edTITLE: TcxDBTextEdit
        Left = 14
        Top = 17
        DataBinding.DataField = 'TITLE'
        ParentFont = False
        TabOrder = 0
        Width = 669
      end
      object cmbWEBGOODSTYPE_ID: TcxDBLookupComboBox
        Left = 12
        Top = 64
        DataBinding.DataField = 'WEBGOODSTYPE_ID'
        ParentFont = False
        Properties.DropDownListStyle = lsFixedList
        Properties.DropDownRows = 16
        Properties.KeyFieldNames = 'GOODSTYPEID'
        Properties.ListColumns = <
          item
            FieldName = 'TITLE'
          end>
        Properties.ListOptions.ShowHeader = False
        Properties.ListSource = IBCDataSourceWebGoodsType
        TabOrder = 1
        Width = 216
      end
      object cbFLG_REQUIRE_CERTIFICAT: TcxDBCheckBox
        Left = 14
        Top = 152
        Caption = 'Produsele necesita certificare'
        DataBinding.DataField = 'FLG_REQUIRE_CERTIFICAT'
        ParentFont = False
        Properties.Alignment = taLeftJustify
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        TabOrder = 9
      end
      object lcbSerialNumber: TcxDBLookupComboBox
        Left = 278
        Top = 64
        DataBinding.DataField = 'SERIAL_TYPE_ID'
        ParentFont = False
        Properties.DropDownListStyle = lsFixedList
        Properties.DropDownRows = 16
        Properties.ImmediatePost = True
        Properties.KeyFieldNames = 'GOODSSERIALTYPEID'
        Properties.ListColumns = <
          item
            Caption = #1050#1086#1076
            Fixed = True
            Width = 50
            FieldName = 'GOODSSERIALTYPEID'
          end
          item
            FieldName = 'TITLE'
          end>
        Properties.ListFieldIndex = 1
        Properties.ListOptions.ShowHeader = False
        Properties.ListOptions.SyncMode = True
        Properties.ListSource = IBCDataSourceGST
        TabOrder = 2
        Width = 130
      end
      object lcbTypeGoodsForDelivery: TcxDBLookupComboBox
        Left = 278
        Top = 115
        DataBinding.DataField = 'DELIVERY_TYPEID'
        ParentFont = False
        Properties.DropDownRows = 5
        Properties.DropDownWidth = 300
        Properties.ImmediatePost = True
        Properties.IncrementalFilteringOptions = [ifoHighlightSearchText, ifoUseContainsOperator]
        Properties.KeyFieldNames = 'SYSSID'
        Properties.ListColumns = <
          item
            Caption = 'Denumire'
            Fixed = True
            MinWidth = 64
            FieldName = 'TITLE'
          end
          item
            Caption = 'Descriere'
            MinWidth = 200
            Width = 200
            FieldName = 'VALUE_STR'
          end>
        Properties.ListOptions.RowSelect = False
        Properties.ListSource = IBCDataSourceTypeGoodsDelivery
        TabOrder = 6
        Width = 86
      end
      object cmbVAT: TcxDBComboBox
        Left = 585
        Top = 64
        DataBinding.DataField = 'VAT'
        ParentFont = False
        Properties.DropDownListStyle = lsFixedList
        Properties.ImmediateUpdateText = True
        Properties.Items.Strings = (
          '20'
          '8'
          '0')
        TabOrder = 4
        Width = 57
      end
      object ceCashback: TcxDBCalcEdit
        Left = 385
        Top = 115
        DataBinding.DataField = 'CASHBACK_PERCENT'
        ParentFont = False
        TabOrder = 7
        Width = 88
      end
      object cbFLG_BEST_PRICE: TcxDBCheckBox
        Left = 278
        Top = 156
        Caption = 'Cel mai bun pret'
        DataBinding.DataField = 'FLG_BEST_PRICE'
        ParentFont = False
        Properties.Alignment = taLeftJustify
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        Style.TransparentBorder = False
        TabOrder = 10
      end
      object lcbTemplate: TcxDBLookupComboBox
        Left = 14
        Top = 115
        DataBinding.DataField = 'TEMPLATEID'
        Properties.DropDownAutoSize = True
        Properties.DropDownSizeable = True
        Properties.ImmediatePost = True
        Properties.IncrementalFilteringOptions = [ifoHighlightSearchText, ifoUseContainsOperator]
        Properties.KeyFieldNames = 'TEMPLATEID'
        Properties.ListColumns = <
          item
            Caption = 'Cod'
            FieldName = 'TEMPLATEID'
          end
          item
            Caption = 'Denumire'
            Width = 200
            FieldName = 'TITLE_ROM'
          end
          item
            Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
            Width = 200
            FieldName = 'TITLE_RUS'
          end>
        Properties.ListFieldIndex = 1
        Properties.ListOptions.ShowHeader = False
        Properties.ListOptions.SyncMode = True
        Properties.ListSource = IBCDataSourceTemplate
        TabOrder = 5
        Width = 214
      end
      object lcbRelatedKeys: TcxDBLookupComboBox
        Left = 486
        Top = 115
        DataBinding.DataField = 'RELATED_KEY'
        ParentFont = False
        Properties.IncrementalFilteringOptions = [ifoHighlightSearchText, ifoUseContainsOperator]
        Properties.KeyFieldNames = 'RELATED_KEY'
        Properties.ListColumns = <
          item
            FieldName = 'RELATED_KEY'
          end>
        Properties.ListOptions.ShowHeader = False
        Properties.ListOptions.SyncMode = True
        Properties.ListSource = IBCDataSourceRelatedKeys
        TabOrder = 8
        Width = 195
      end
      object cxPageControl1: TcxPageControl
        Left = 14
        Top = 181
        Width = 667
        Height = 212
        TabOrder = 11
        Properties.ActivePage = tbsCommonFilters
        Properties.CustomButtons.Buttons = <>
        ClientRectBottom = 208
        ClientRectLeft = 4
        ClientRectRight = 663
        ClientRectTop = 26
        object tbsCommonFilters: TcxTabSheet
          Caption = 'Filtre comune'
          ImageIndex = 0
          object cxGrid1: TcxGrid
            Left = 0
            Top = 28
            Width = 659
            Height = 154
            Align = alClient
            TabOrder = 1
            object cxGrid1DBTableView1: TcxGridDBTableView
              Navigator.Buttons.CustomButtons = <>
              ScrollbarAnnotations.CustomAnnotations = <>
              DataController.DataSource = IBCDataSourceFiltersParams
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              OptionsView.ColumnAutoWidth = True
              OptionsView.GroupByBox = False
              OptionsView.Indicator = True
              object cxGrid1DBTableView1_FilterID: TcxGridDBColumn
                Caption = 'FID'
                DataBinding.FieldName = 'FILTERID'
                Width = 77
              end
              object cxGrid1DBTableView1_FilterName: TcxGridDBColumn
                Caption = 'Filtru'
                DataBinding.FieldName = 'FILTERNAME'
                Width = 349
              end
              object cxGrid1DBTableView1_ParamID: TcxGridDBColumn
                Caption = 'FPID'
                DataBinding.FieldName = 'FILTERPARAMID'
                Width = 70
              end
              object cxGrid1DBTableView1_ParamName: TcxGridDBColumn
                Caption = 'Valoare'
                DataBinding.FieldName = 'PARAMVALUE'
                Width = 149
              end
            end
            object cxGrid1Level1: TcxGridLevel
              GridView = cxGrid1DBTableView1
            end
          end
          object dxBarDockControl2: TdxBarDockControl
            Left = 0
            Top = 0
            Width = 659
            Height = 28
            Align = dalTop
            BarManager = dxBarManager
          end
        end
        object cxTabSheet3: TcxTabSheet
          Caption = 'Categorii de produse'
          ImageIndex = 1
          object dxBarDockControl3: TdxBarDockControl
            Left = 0
            Top = 0
            Width = 659
            Height = 28
            Align = dalTop
            BarManager = dxBarManager
          end
          object cxGrid2: TcxGrid
            Left = 0
            Top = 28
            Width = 659
            Height = 154
            Align = alClient
            TabOrder = 1
            object cxGrid2DBTableView1: TcxGridDBTableView
              Navigator.Buttons.CustomButtons = <>
              ScrollbarAnnotations.CustomAnnotations = <>
              DataController.DataSource = IBCDataSourceGoodsCategories
              DataController.KeyFieldNames = 'FOLDER_GOODSID;goods_categoryid'
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              OptionsData.CancelOnExit = False
              OptionsData.Deleting = False
              OptionsData.DeletingConfirmation = False
              OptionsData.Editing = False
              OptionsData.Inserting = False
              OptionsView.ColumnAutoWidth = True
              OptionsView.GroupByBox = False
              OptionsView.Indicator = True
              object cxGrid2DBTableView1Column1: TcxGridDBColumn
                Caption = 'Cod'
                DataBinding.FieldName = 'GOODS_CATEGORYID'
                Width = 67
              end
              object cxGrid2DBTableView1Column2: TcxGridDBColumn
                Caption = 'Denumire'
                DataBinding.FieldName = 'GOODS_CATEGORY_NAME'
                Width = 590
              end
            end
            object cxGrid2Level1: TcxGridLevel
              GridView = cxGrid2DBTableView1
            end
          end
        end
      end
    end
    object cxTabSheet2: TTabSheet
      Caption = 'Men'#539'iuni'
      ImageIndex = 1
      object dxBarDockControl1: TdxBarDockControl
        Left = 0
        Top = 0
        Width = 696
        Height = 30
        Align = dalTop
        BarManager = dxBarManager
        SunkenBorder = True
        UseOwnSunkenBorder = True
      end
      object mmCOMMENTS: TcxDBMemo
        AlignWithMargins = True
        Left = 0
        Top = 32
        Margins.Left = 0
        Margins.Top = 2
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alClient
        DataBinding.DataField = 'DESCRIPTION'
        DataBinding.DataSource = IBCDataSourceGoodsDSC
        ParentFont = False
        Properties.ScrollBars = ssVertical
        Properties.WantReturns = False
        TabOrder = 1
        Height = 372
        Width = 696
      end
    end
  end
  object btnOk: TcxButton
    Left = 506
    Top = 520
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TcxButton
    Left = 610
    Top = 520
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renun'#539#259
    ModalResult = 2
    TabOrder = 3
  end
  object dxBarManager: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Default'
      'Common Filters'
      'Categorii produse')
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
    Left = 129
    Top = 8
    PixelsPerInch = 96
    object dxBarManagerBar1: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Comments'
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 389
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'dxBarButton1'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'dxBarButton2'
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
      Caption = 'Common Filters'
      CaptionButtons = <>
      DockControl = dxBarDockControl2
      DockedDockControl = dxBarDockControl2
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 748
      FloatTop = 2
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbNewFilter'
        end
        item
          Visible = True
          ItemName = 'bbDeleteFilter'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBar3: TdxBar
      Caption = 'Categorii produse'
      CaptionButtons = <>
      DockControl = dxBarDockControl3
      DockedDockControl = dxBarDockControl3
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 748
      FloatTop = 2
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbNewGoodsCategory'
        end
        item
          Visible = True
          ItemName = 'bbModifyGoodsCategory'
        end
        item
          Visible = True
          ItemName = 'bbDeleteGoodsCategory'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarButton1: TdxBarButton
      Caption = #536'terge'
      Category = 0
      Hint = #536'terge'
      Visible = ivAlways
      ImageIndex = 35
      OnClick = dxBarButton1Click
    end
    object dxBarButton2: TdxBarButton
      Caption = 'Paste'
      Category = 0
      Hint = 'Paste'
      Visible = ivAlways
      ImageIndex = 24
      OnClick = dxBarButton2Click
    end
    object bbNewFilter: TdxBarButton
      Caption = 'Adauga filtru'
      Category = 1
      Hint = 'Adauga filtru'
      Visible = ivAlways
      ImageIndex = 40
      OnClick = bbNewFilterClick
    end
    object bbDeleteFilter: TdxBarButton
      Caption = 'Sterge filtru'
      Category = 1
      Visible = ivAlways
      ImageIndex = 42
      OnClick = bbDeleteFilterClick
    end
    object bbNewGoodsCategory: TdxBarButton
      Caption = 'Nou'
      Category = 2
      Hint = 'Nou'
      Visible = ivAlways
      OnClick = bbNewGoodsCategoryClick
    end
    object bbModifyGoodsCategory: TdxBarButton
      Caption = 'Modifica'
      Category = 2
      Hint = 'Modifica'
      Visible = ivAlways
      OnClick = bbModifyGoodsCategoryClick
    end
    object bbDeleteGoodsCategory: TdxBarButton
      Caption = 'Sterge'
      Category = 2
      Hint = 'Sterge'
      Visible = ivAlways
    end
  end
  object IBCDataSourceGoodsType: TIBCDataSource
    DataSet = IBCQueryGoodsType
    Left = 244
    Top = 8
  end
  object IBCQueryGoodsType: TIBCQuery
    SQL.Strings = (
      'SELECT'
      ' GOODSTYPEID, '
      ' TITLE,'
      ' DESCRIPTION'
      'FROM'
      ' GET_GOODS_TYPES')
    Options.BooleanDomainFields = True
    Left = 248
    Top = 56
  end
  object IBCQueryGoodsDSC: TIBCQuery
    UpdatingTable = 'TS_GOODS_DSC'
    KeyFields = 'GOODSID'
    SQLInsert.Strings = (
      'INSERT INTO TS_GOODS_DSC'
      '  (GOODSID, DESCRIPTION)'
      'VALUES'
      '  (:GOODSID, :DESCRIPTION)')
    SQLDelete.Strings = (
      'DELETE FROM TS_GOODS_DSC'
      'WHERE'
      '  GOODSID = :Old_GOODSID')
    SQLUpdate.Strings = (
      'UPDATE TS_GOODS_DSC'
      'SET'
      '  GOODSID = :GOODSID, DESCRIPTION = :DESCRIPTION'
      'WHERE'
      '  GOODSID = :Old_GOODSID')
    SQLRefresh.Strings = (
      
        'SELECT TS_GOODS_DSC.GOODSID, TS_GOODS_DSC.DESCRIPTION FROM TS_GO' +
        'ODS_DSC'
      'WHERE'
      '  GOODSID = :GOODSID')
    SQLLock.Strings = (
      'SELECT NULL FROM TS_GOODS_DSC'
      'WHERE'
      'GOODSID = :Old_GOODSID'
      'FOR UPDATE WITH LOCK')
    SQL.Strings = (
      'SELECT'
      ' GOODSID,DESCRIPTION'
      'FROM'
      ' TS_GOODS_DSC')
    MasterFields = 'GOODSID'
    DetailFields = 'GOODSID'
    AutoCommit = False
    LockMode = lmLockImmediate
    Left = 380
    Top = 60
  end
  object IBCDataSourceGoodsDSC: TIBCDataSource
    DataSet = IBCQueryGoodsDSC
    Left = 380
    Top = 12
  end
  object IBCDataSourceWebGoodsType: TIBCDataSource
    DataSet = IBCQueryWebGoodsType
    Left = 368
    Top = 304
  end
  object IBCQueryWebGoodsType: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT'
      ' GOODSTYPEID,'
      ' TITLE'
      'FROM'
      ' TS_GOODS_TYPE'
      'WHERE'
      ' GOODSTYPEID<>-1'
      'ORDER BY'
      ' TITLE')
    Left = 368
    Top = 248
  end
  object IBCDataSourceGST: TIBCDataSource
    DataSet = IBCQueryGST
    Left = 560
    Top = 10
  end
  object IBCQueryGST: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT'
      '    goodsserialtypeid,'
      '    TITLE'
      'FROM'
      '    GET_GOODS_SERIAL_TYPES')
    Left = 557
    Top = 65
  end
  object IBCDataSourceTypeGoodsDelivery: TIBCDataSource
    DataSet = IBCQueryTypeGoodsDelivery
    Left = 616
    Top = 241
  end
  object IBCQueryTypeGoodsDelivery: TIBCQuery
    KeyFields = 'SYSSID'
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      'select * from ts_syss where parentid=45')
    Left = 616
    Top = 305
  end
  object IBCQueryTemplate: TIBCQuery
    SQL.Strings = (
      'select * from ts_description_templates a'
      'where a.flg_folder=0'
      'order by title_rom')
    Left = 256
    Top = 248
  end
  object IBCDataSourceTemplate: TIBCDataSource
    DataSet = IBCQueryTemplate
    Left = 257
    Top = 200
  end
  object IBCQueryRelatedKeys: TIBCQuery
    SQL.Strings = (
      
        'select distinct related_key from ts_related_keys where flg_folde' +
        'r=1')
    Left = 480
    Top = 296
  end
  object IBCDataSourceRelatedKeys: TIBCDataSource
    DataSet = IBCQueryRelatedKeys
    Left = 480
    Top = 248
  end
  object IBCQueryFiltersParams: TIBCQuery
    SQLInsert.Strings = (
      'INSERT INTO VW_TS_GOODS_COMMON_FILTERS'
      
        '  (GOODSFOLDERID, FILTERID, FILTERNAME, FILTERPARAMID, PARAMVALU' +
        'E)'
      'VALUES'
      
        '  (:GOODSFOLDERID, :FILTERID, :FILTERNAME, :FILTERPARAMID, :PARA' +
        'MVALUE)')
    SQLDelete.Strings = (
      'DELETE FROM VW_TS_GOODS_COMMON_FILTERS'
      'WHERE'
      
        '  GOODSFOLDERID = :Old_GOODSFOLDERID AND FILTERID = :Old_FILTERI' +
        'D AND FILTERPARAMID = :Old_FILTERPARAMID')
    SQLUpdate.Strings = (
      'UPDATE VW_TS_GOODS_COMMON_FILTERS'
      'SET'
      
        '  GOODSFOLDERID = :GOODSFOLDERID, FILTERID = :FILTERID, FILTERNA' +
        'ME = :FILTERNAME, FILTERPARAMID = :FILTERPARAMID, PARAMVALUE = :' +
        'PARAMVALUE'
      'WHERE'
      
        '  GOODSFOLDERID = :Old_GOODSFOLDERID AND FILTERID = :Old_FILTERI' +
        'D AND FILTERPARAMID = :Old_FILTERPARAMID')
    SQLRefresh.Strings = (
      
        'SELECT GOODSFOLDERID, FILTERID, FILTERNAME, FILTERPARAMID, PARAM' +
        'VALUE FROM VW_TS_GOODS_COMMON_FILTERS'
      'WHERE'
      
        '  GOODSFOLDERID = :GOODSFOLDERID AND FILTERID = :FILTERID AND FI' +
        'LTERPARAMID = :FILTERPARAMID')
    SQLLock.Strings = (
      'SELECT NULL FROM TS_GOODS_COMMON_FILTERS'
      'WHERE'
      
        'GOODSFOLDERID = :Old_GOODSFOLDERID AND FILTERID = :Old_FILTERID ' +
        'AND FILTERPARAMID = :Old_FILTERPARAMID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM VW_TS_GOODS_COMMON_FILTERS'
      ''
      ') q')
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'select *'
      'from vw_ts_goods_common_filters cf'
      'where cf.goodsfolderid = :goodsid')
    AutoCommit = False
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Left = 158
    Top = 298
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'goodsid'
        Value = nil
      end>
  end
  object IBCDataSourceFiltersParams: TIBCDataSource
    DataSet = IBCQueryFiltersParams
    Left = 158
    Top = 242
  end
  object IBCQueryGoodsCategories: TIBCQuery
    KeyFields = 'folder_goodsid;goods_categoryid'
    SQLInsert.Strings = (
      'INSERT INTO VW_TS_GOODS_CATEGORIES'
      '  (FOLDER_GOODSID, GOODS_CATEGORYID, GOODS_CATEGORY_NAME)'
      'VALUES'
      '  (:FOLDER_GOODSID, :GOODS_CATEGORYID, :GOODS_CATEGORY_NAME)')
    SQLDelete.Strings = (
      'DELETE FROM VW_TS_GOODS_CATEGORIES'
      'WHERE'
      
        '  FOLDER_GOODSID = :Old_FOLDER_GOODSID AND GOODS_CATEGORYID = :O' +
        'ld_GOODS_CATEGORYID')
    SQLUpdate.Strings = (
      'UPDATE VW_TS_GOODS_CATEGORIES'
      'SET'
      
        '  FOLDER_GOODSID = :FOLDER_GOODSID, GOODS_CATEGORYID = :GOODS_CA' +
        'TEGORYID, GOODS_CATEGORY_NAME = :GOODS_CATEGORY_NAME'
      'WHERE'
      
        '  FOLDER_GOODSID = :Old_FOLDER_GOODSID AND GOODS_CATEGORYID = :O' +
        'ld_GOODS_CATEGORYID')
    SQLRefresh.Strings = (
      
        'SELECT FOLDER_GOODSID, GOODS_CATEGORYID, GOODS_CATEGORY_NAME FRO' +
        'M VW_TS_GOODS_CATEGORIES'
      'WHERE'
      
        '  FOLDER_GOODSID = :FOLDER_GOODSID AND GOODS_CATEGORYID = :GOODS' +
        '_CATEGORYID')
    SQLLock.Strings = (
      'SELECT NULL FROM TS_GOODS_CATEGORIES'
      'WHERE'
      
        'FOLDER_GOODSID = :Old_FOLDER_GOODSID AND GOODS_CATEGORYID = :Old' +
        '_GOODS_CATEGORYID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM VW_TS_GOODS_CATEGORIES'
      ''
      ') q')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'select * from vw_ts_goods_categories'
      'where folder_goodsid = :FolderID ')
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Left = 116
    Top = 423
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'FolderID'
        Value = nil
      end>
  end
  object IBCDataSourceGoodsCategories: TIBCDataSource
    DataSet = IBCQueryGoodsCategories
    Left = 117
    Top = 369
  end
end
