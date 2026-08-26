object frmGoodsEditorDialog: TfrmGoodsEditorDialog
  Left = 0
  Top = 0
  HelpType = htKeyword
  HelpKeyword = #1099
  ActiveControl = mmTITLE
  BorderStyle = bsDialog
  Caption = 'Adauga / modifica produs'
  ClientHeight = 714
  ClientWidth = 970
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poDefault
  DesignSize = (
    970
    714)
  TextHeight = 15
  object lbCREATED_BY: TLabel
    Left = 16
    Top = 453
    Width = 78
    Height = 15
    Anchors = [akLeft, akBottom]
    Caption = 'lbCREATED_BY'
  end
  object lbLastModify: TLabel
    Left = 16
    Top = 474
    Width = 69
    Height = 15
    Anchors = [akLeft, akBottom]
    Caption = 'lbLastModify'
    ExplicitTop = 326
  end
  object Label6: TLabel
    Left = 472
    Top = 336
    Width = 34
    Height = 15
    Caption = 'Label6'
  end
  object cxPageControl: TPageControl
    AlignWithMargins = True
    Left = 8
    Top = 240
    Width = 954
    Height = 439
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    ActivePage = tbsGeneral
    Align = alTop
    TabOrder = 2
    TabStop = False
    OnChange = cxPageControlChange
    ExplicitTop = 209
    object tbsGeneral: TTabSheet
      Caption = '(&1) Date generale'
      Highlighted = True
      object Label8: TLabel
        Left = 611
        Top = 349
        Width = 10
        Height = 15
        Caption = '%'
        Transparent = True
      end
      object lbVAT: TLabel
        Left = 412
        Top = 350
        Width = 21
        Height = 15
        Caption = 'TVA'
        Transparent = True
      end
      object cxLabel20: TLabel
        Left = 412
        Top = 320
        Width = 44
        Height = 15
        Caption = 'Garantie'
        Transparent = True
      end
      object cxLabel19: TLabel
        Left = 412
        Top = 289
        Width = 81
        Height = 15
        Caption = 'Unitate metrica'
        Transparent = True
      end
      object cxLabel16: TLabel
        Left = 25
        Top = 289
        Width = 57
        Height = 15
        Caption = 'Tip produs'
        Transparent = True
      end
      object cxLabel21: TLabel
        Left = 25
        Top = 318
        Width = 78
        Height = 15
        Caption = 'Tipul evidentei'
        Transparent = True
      end
      object lcbGoodsType1: TcxDBLookupComboBox
        Left = 132
        Top = 285
        DataBinding.DataField = 'GOODS_TYPE_ID'
        ParentFont = False
        Properties.DropDownRows = 16
        Properties.IncrementalFilteringOptions = [ifoHighlightSearchText, ifoUseContainsOperator]
        Properties.KeyFieldNames = 'SYSSID'
        Properties.ListColumns = <
          item
            Caption = 'Cod'
            Fixed = True
            Width = 80
            FieldName = 'SYSSID'
          end
          item
            Caption = 'Denumire'
            Width = 250
            FieldName = 'TITLE'
          end>
        Properties.ListFieldIndex = 1
        Properties.ListOptions.ShowHeader = False
        Properties.ListOptions.SyncMode = True
        Properties.ListSource = IBCDataSourceGoodsType
        TabOrder = 0
        Width = 257
      end
      object cmbVAT: TcxDBComboBox
        Left = 519
        Top = 344
        DataBinding.DataField = 'VAT'
        ParentFont = False
        Properties.DropDownListStyle = lsFixedList
        Properties.ImmediateUpdateText = True
        Properties.Items.Strings = (
          '20'
          '10'
          '8'
          '6'
          '5'
          '0'
          '')
        TabOrder = 10
        Width = 86
      end
      object cbFLG_SOCIAL: TcxDBCheckBox
        Left = 804
        Top = 292
        Caption = 'Social important'
        DataBinding.DataField = 'FLG_SOCIAL'
        ParentFont = False
        Properties.Alignment = taLeftJustify
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        Style.TransparentBorder = False
        TabOrder = 3
        Transparent = True
      end
      object cbFLG_PROMO: TcxDBCheckBox
        Left = 804
        Top = 342
        Caption = 'Promo'
        DataBinding.DataField = 'FLG_PROMO'
        ParentFont = False
        Properties.Alignment = taLeftJustify
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        Style.TransparentBorder = False
        TabOrder = 9
        Transparent = True
      end
      object cbFLG_NEW: TcxDBCheckBox
        Left = 804
        Top = 317
        Caption = 'Nou'
        DataBinding.DataField = 'FLG_NEW'
        ParentFont = False
        Properties.Alignment = taLeftJustify
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        Style.TransparentBorder = False
        TabOrder = 7
        Transparent = True
      end
      object cbFLG_REQUIRE_CERTIFICAT: TcxDBCheckBox
        Left = 636
        Top = 315
        Caption = 'Necesita certificat'
        DataBinding.DataField = 'FLG_REQUIRE_CERTIFICAT'
        ParentFont = False
        Properties.Alignment = taLeftJustify
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        TabOrder = 6
        Transparent = True
      end
      object cbFLG_OLD: TcxDBCheckBox
        Left = 636
        Top = 288
        Caption = 'Produs invechit'
        DataBinding.DataField = 'FLG_OLD'
        ParentFont = False
        Properties.Alignment = taLeftJustify
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        TabOrder = 2
        Transparent = True
      end
      object cmbWarranty: TcxDBComboBox
        Left = 519
        Top = 315
        DataBinding.DataField = 'WARRANTY'
        ParentFont = False
        Properties.DropDownListStyle = lsFixedList
        Properties.DropDownRows = 16
        Properties.Items.Strings = (
          '0'
          '1'
          '3'
          '6'
          '9'
          '12'
          '18'
          '24'
          '30'
          '36'
          '60')
        TabOrder = 5
        Width = 86
      end
      object lcbSerialNumber: TcxDBLookupComboBox
        Left = 132
        Top = 314
        DataBinding.DataField = 'SERIAL_TYPE_ID'
        ParentFont = False
        Properties.DropDownListStyle = lsFixedList
        Properties.DropDownRows = 16
        Properties.KeyFieldNames = 'goodsserialtypeid'
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
        Properties.ListSource = IBCDataSourceGST
        TabOrder = 4
        Width = 257
      end
      object lcbUM: TcxDBLookupComboBox
        Left = 519
        Top = 285
        DataBinding.DataField = 'UMID'
        ParentFont = False
        Properties.DropDownListStyle = lsFixedList
        Properties.DropDownRows = 16
        Properties.KeyFieldNames = 'UMID'
        Properties.ListColumns = <
          item
            Caption = #1050#1086#1076
            Fixed = True
            Width = 50
            FieldName = 'UMID'
          end
          item
            FieldName = 'TITLE'
          end>
        Properties.ListFieldIndex = 1
        Properties.ListOptions.ShowHeader = False
        Properties.ListSource = IBCDataSourceUM
        TabOrder = 1
        Width = 86
      end
      object cbFLG_WEB_HIDE_COMPLECT_ITEMS: TcxDBCheckBox
        Left = 638
        Top = 342
        Caption = 'Nu arata complect pe web'
        DataBinding.DataField = 'FLG_WEB_HIDE_COMPLECT_ITEMS'
        ParentFont = False
        Properties.Alignment = taLeftJustify
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        Style.TransparentBorder = False
        TabOrder = 8
        Transparent = True
      end
      object dxBarDockControl1: TdxBarDockControl
        Left = 0
        Top = 0
        Width = 946
        Height = 28
        Align = dalTop
        BarManager = dxBarManagerGoods
      end
      inline frameGoodsEditDescription1: TframeGoodsEditDescription
        Left = 3
        Top = 34
        Width = 926
        Height = 232
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 12
        ExplicitLeft = 3
        ExplicitTop = 34
        inherited cxLabel2: TLabel
          StyleElements = [seFont, seClient, seBorder]
        end
        inherited cxLabel17: TLabel
          StyleElements = [seFont, seClient, seBorder]
        end
        inherited Label1: TLabel
          StyleElements = [seFont, seClient, seBorder]
        end
        inherited Label2: TLabel
          StyleElements = [seFont, seClient, seBorder]
        end
        inherited Label3: TLabel
          StyleElements = [seFont, seClient, seBorder]
        end
        inherited Label4: TLabel
          StyleElements = [seFont, seClient, seBorder]
        end
        inherited lcbVENDOR_ID: TcxDBLookupComboBox
          ExplicitHeight = 23
        end
        inherited cmbWEBGOODSTYPE_ID: TcxDBLookupComboBox
          ExplicitHeight = 23
        end
        inherited edCODE: TcxDBTextEdit
          ExplicitHeight = 23
        end
        inherited edBASE_PARAM: TcxDBTextEdit
          ExplicitHeight = 23
        end
        inherited edDETAILS: TcxDBTextEdit
          ExplicitHeight = 23
        end
        inherited edCODE_RU: TcxDBTextEdit
          ExplicitHeight = 23
        end
        inherited edBASE_PARAM_RU: TcxDBTextEdit
          ExplicitHeight = 23
        end
        inherited cmbColors: TcxDBLookupComboBox
          ExplicitHeight = 23
        end
        inherited cxDBLookupComboBox1: TcxDBLookupComboBox
          ExplicitHeight = 23
        end
        inherited Panel1: TPanel
          StyleElements = [seFont, seClient, seBorder]
          inherited lbWebNameRo: TLabel
            StyleElements = [seFont, seClient, seBorder]
          end
        end
      end
    end
    object tbsPriceHistory: TTabSheet
      Caption = '(&2) Istoria schimbarii preturilor'
      ImageIndex = 4
      object dxBarDockControl3: TdxBarDockControl
        Left = 0
        Top = 0
        Width = 946
        Height = 30
        Align = dalTop
        BarManager = dxBarManagerGoods
        SunkenBorder = True
        UseOwnSunkenBorder = True
      end
      object cxPageControlPH: TPageControl
        AlignWithMargins = True
        Left = 0
        Top = 32
        Width = 946
        Height = 377
        Margins.Left = 0
        Margins.Top = 2
        Margins.Right = 0
        Margins.Bottom = 0
        ActivePage = tbsPH_Grid
        Align = alClient
        MultiLine = True
        TabOrder = 1
        object tbsPH_Grid: TTabSheet
          Caption = 'Tabela'
          object rid: TcxGrid
            Left = 0
            Top = 0
            Width = 938
            Height = 347
            Align = alClient
            TabOrder = 0
            object ridTable: TcxGridDBTableView
              DataController.DataSource = IBCDataSourcePriceHistory
              OptionsBehavior.ImmediateEditor = False
              OptionsCustomize.ColumnFiltering = False
              OptionsCustomize.ColumnSorting = False
              OptionsCustomize.ColumnsQuickCustomization = True
              OptionsData.Deleting = False
              OptionsData.Editing = False
              OptionsData.Inserting = False
              OptionsSelection.InvertSelect = False
              OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
              OptionsView.GridLineColor = 13750737
              OptionsView.GroupByBox = False
              OptionsView.Indicator = True
              Styles.Header = dmAdditions.cxStyle_GridHeader
              Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
              object cxGridPriceHistory_DATA: TcxGridDBColumn
                Caption = 'Data'
                DataBinding.FieldName = 'DATA'
                MinWidth = 110
                Options.HorzSizing = False
                Styles.Content = dmAdditions.cxStyle_GirdContentInactive
                Width = 110
              end
              object cxGridPriceHistory_CURRENCY_NAME: TcxGridDBColumn
                Caption = 'Valuta'
                DataBinding.FieldName = 'CURRENCY_NAME'
                PropertiesClassName = 'TcxLabelProperties'
                Properties.Alignment.Horz = taCenter
                HeaderAlignmentHorz = taCenter
                MinWidth = 46
                Options.HorzSizing = False
                Styles.Content = dmAdditions.cxStyle_Bold
                Width = 46
              end
              object cxGridPriceHistory_PRICE0: TcxGridDBColumn
                Caption = 'Pret 0'
                DataBinding.FieldName = 'PRICE0'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00'
                HeaderAlignmentHorz = taCenter
                MinWidth = 46
                Options.HorzSizing = False
                Width = 46
              end
              object cxGridPriceHistory_PRICE1: TcxGridDBColumn
                Caption = 'Pret 1'
                DataBinding.FieldName = 'PRICE1'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00'
                HeaderAlignmentHorz = taCenter
                MinWidth = 46
                Options.HorzSizing = False
                Width = 46
              end
              object cxGridPriceHistory_PRICE2: TcxGridDBColumn
                Caption = 'Pret 2'
                DataBinding.FieldName = 'PRICE2'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00'
                HeaderAlignmentHorz = taCenter
                MinWidth = 46
                Options.HorzSizing = False
                Width = 46
              end
              object cxGridPriceHistory_PRICE3: TcxGridDBColumn
                Caption = 'Pret 3'
                DataBinding.FieldName = 'PRICE3'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00'
                HeaderAlignmentHorz = taCenter
                MinWidth = 46
                Options.HorzSizing = False
                Width = 46
              end
              object cxGridPriceHistory_PRICE4: TcxGridDBColumn
                Caption = 'Pret 4'
                DataBinding.FieldName = 'PRICE4'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00'
                HeaderAlignmentHorz = taCenter
                MinWidth = 46
                Options.HorzSizing = False
                Width = 46
              end
              object cxGridPriceHistory_PRICE5: TcxGridDBColumn
                Caption = 'Pret 5'
                DataBinding.FieldName = 'PRICE5'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00'
                HeaderAlignmentHorz = taCenter
                MinWidth = 46
                Options.HorzSizing = False
                Width = 46
              end
              object cxGridPriceHistory_PRICE6: TcxGridDBColumn
                Caption = 'Pret 6'
                DataBinding.FieldName = 'PRICE6'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00'
                MinWidth = 46
                Options.HorzSizing = False
                Width = 46
              end
              object cxGridPriceHistory_PRICE7: TcxGridDBColumn
                Caption = 'Pret 7'
                DataBinding.FieldName = 'PRICE7'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00'
                MinWidth = 46
                Options.HorzSizing = False
                Width = 46
              end
              object cxGridPriceHistory_MODIFIED_BY_NAME: TcxGridDBColumn
                Caption = 'Modificat de'
                DataBinding.FieldName = 'MODIFIED_BY_NAME'
                MinWidth = 50
                Width = 100
              end
            end
            object ridLevel: TcxGridLevel
              GridView = ridTable
            end
          end
        end
        object tbsPH_Chart: TTabSheet
          Caption = 'Grafic'
          ImageIndex = 1
          object cxGridChart: TcxGrid
            Left = 0
            Top = 0
            Width = 938
            Height = 347
            Align = alClient
            TabOrder = 0
            object cxGridChartDB: TcxGridDBChartView
              Categories.DataBinding.FieldName = 'Data'
              Categories.OnGetValueDisplayText = cxGridChartDBCategoriesGetValueDisplayText
              DataController.DataSource = IBCDataSourcePriceHistory
              DataController.KeyFieldNames = 'DATA'
              DiagramLine.Active = True
              DiagramLine.Legend.Alignment = cpaStart
              DiagramLine.AxisCategory.ValueAxisBetweenCategories = True
              DiagramLine.AxisValue.GridLines = False
              DiagramLine.AxisValue.MinMaxValues = mmvAuto
              DiagramLine.Values.MarkerStyle = cmsSquare
              Legend.KeyBorder = lbSingle
              OnGetValueHint = cxGridChartDBGetValueHint
              OnValueClick = cxGridChartDBValueClick
              object cxGridChartDBSeries_Price4: TcxGridDBChartSeries
                DataBinding.FieldName = 'PRICE4'
                DisplayText = #1062#1077#1085#1072' 4'
                GroupSummaryKind = skMax
              end
              object cxGridChartDBSeries_Price7: TcxGridDBChartSeries
                DataBinding.FieldName = 'PRICE7'
                DisplayText = #1062#1077#1085#1072' 7'
                GroupSummaryKind = skMax
              end
            end
            object cxGridChartLevel: TcxGridLevel
              GridView = cxGridChartDB
            end
          end
        end
      end
    end
    object TabSheet1: TTabSheet
      Caption = '(&3) Chei produse inrudite'
      ImageIndex = 2
      OnShow = TabSheet1Show
      object cxGrid1: TcxGrid
        Left = 0
        Top = 0
        Width = 946
        Height = 409
        Align = alClient
        TabOrder = 0
        object cxGrid1DBTableView1: TcxGridDBTableView
          DataController.DataSource = IBCDataSourceRelatedGoods
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
          object cxGrid1DBTableView1_GOODSID: TcxGridDBColumn
            Caption = 'Cod'
            DataBinding.FieldName = 'RELATEDGOODSID'
            HeaderAlignmentHorz = taCenter
            MinWidth = 64
            Options.HorzSizing = False
          end
          object cxGrid1DBTableView1_WEBGOODSTYPE: TcxGridDBColumn
            Caption = 'Tip produs'
            DataBinding.FieldName = 'WEBGOODSTYPE_TITLE'
            MinWidth = 201
            Options.HorzSizing = False
            Width = 201
          end
          object cxGrid1DBTableView1_GOODS_NAME: TcxGridDBColumn
            Caption = 'Produs'
            DataBinding.FieldName = 'TITLE'
            HeaderAlignmentHorz = taCenter
            Width = 547
          end
          object cxGrid1DBTableView1_PRICE_MDL: TcxGridDBColumn
            Caption = 'Pret'
            DataBinding.FieldName = 'PRICE1_LEI'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            Properties.UseThousandSeparator = True
            HeaderAlignmentHorz = taCenter
            MinWidth = 79
            Options.HorzSizing = False
            Width = 79
          end
          object cxGrid1DBTableView1_FLG_IN_PRICE: TcxGridDBColumn
            Caption = 'P'
            DataBinding.FieldName = 'FLG_IN_PRICE'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ValueChecked = '1'
            Properties.ValueGrayed = 0
            Properties.ValueUnchecked = '0'
            HeaderAlignmentHorz = taCenter
            MinWidth = 24
            Options.HorzSizing = False
            Width = 24
          end
        end
        object cxGrid1Level1: TcxGridLevel
          GridView = cxGrid1DBTableView1
        end
      end
    end
    object tsSearchkeys: TTabSheet
      Caption = '(&4) Cuvinte cheie'
      ImageIndex = 3
      object cxDBMemo1: TcxDBMemo
        AlignWithMargins = True
        Left = 3
        Top = 31
        Align = alClient
        DataBinding.DataField = 'SEARCHKEYS'
        DataBinding.DataSource = IBCDataSourceSearchkeys
        ParentFont = False
        Properties.ScrollBars = ssBoth
        TabOrder = 1
        Height = 375
        Width = 940
      end
      object dxBarDockSearchKeys: TdxBarDockControl
        Left = 0
        Top = 0
        Width = 946
        Height = 28
        Align = dalTop
        BarManager = dxBarManagerGoods
      end
    end
    object tbsDictionary: TTabSheet
      Caption = '(&5) Dictionar'
      ImageIndex = 4
      object btnUpdateDict: TcxButton
        Left = 800
        Top = 303
        Width = 108
        Height = 25
        Caption = 'Update'
        TabOrder = 1
        OnClick = btnUpdateDictClick
      end
      object cxGrid2: TcxGrid
        Left = 11
        Top = 3
        Width = 918
        Height = 286
        TabOrder = 0
        object cxGridDBTableViewDictionary: TcxGridDBTableView
          DataController.DataSource = IBCDataSourceGoodsDictionary
          OptionsBehavior.IncSearch = True
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.GroupByBox = False
          object cxGridDBTableViewDictionary_WORD: TcxGridDBColumn
            DataBinding.FieldName = 'WORD'
            Width = 842
          end
          object cxGridDBTableViewDictionary_PRIORITY: TcxGridDBColumn
            DataBinding.FieldName = 'PRIORITY'
          end
        end
        object cxGrid2Level1: TcxGridLevel
          GridView = cxGridDBTableViewDictionary
        end
      end
    end
  end
  object pnTitles: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 954
    Height = 160
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 0
    Align = alTop
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 0
    ExplicitLeft = 13
    object Label4: TLabel
      Left = 13
      Top = 103
      Width = 127
      Height = 15
      Caption = 'Denumire pentru facturi'
      Transparent = True
    end
    object mmTITLE: TcxDBMemo
      Left = 13
      Top = 13
      DataBinding.DataField = 'TITLE'
      ParentFont = False
      Properties.ScrollBars = ssVertical
      Properties.VisibleLineCount = 4
      Properties.WantReturns = False
      TabOrder = 0
      Width = 926
    end
    object beGoodsACNT: TcxButtonEdit
      Left = 156
      Top = 95
      TabStop = False
      ParentFont = False
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
        end
        item
          ImageIndex = 116
          Kind = bkGlyph
        end>
      Properties.ClickKey = 16450
      Properties.Images = dmAdditions.cxImageList_SWN
      Properties.ViewStyle = vsHideCursor
      Properties.OnButtonClick = beGoodsACNTPropertiesButtonClick
      TabOrder = 1
      Width = 783
    end
    object lcbGoodsAcnt: TcxDBLookupComboBox
      Left = 156
      Top = 127
      DataBinding.DataField = 'GOODS_ACNT_ID'
      Properties.KeyFieldNames = 'GOODS_ACNT_ID'
      Properties.ListColumns = <
        item
          FieldName = 'GOODS_ACNT_ID'
        end
        item
          FieldName = 'NAMEACNT'
        end
        item
          FieldName = 'PRICE_ACNT'
        end>
      Properties.ListFieldIndex = 1
      Properties.ListSource = IBCDataSourceGOODS_ACNT
      TabOrder = 2
      Width = 783
    end
  end
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 970
    Height = 64
    Title = 'Produse'
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
    ImageIndex = 1
  end
  object btnOk: TcxButton
    Left = 749
    Top = 659
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 3
  end
  object btnCancel: TcxButton
    Left = 845
    Top = 659
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 4
  end
  object dxStatusBar1: TdxStatusBar
    Left = 0
    Top = 694
    Width = 970
    Height = 20
    Images = dmAdditions.cxImageList_SWN
    Panels = <
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        PanelStyle.ImageIndex = 10
        Width = 200
      end
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        PanelStyle.ImageIndex = 37
        Width = 150
      end>
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object dxBarManagerGoods: TdxBarManager
    Scaled = False
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Categories.Strings = (
      'Default'
      'Concurents URL'
      'Search Keys')
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
    UseSystemFont = False
    Left = 303
    Top = 9
    PixelsPerInch = 96
    object dxBarManagerGoodsBar1: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'PriceDynamic'
      CaptionButtons = <>
      DockControl = dxBarDockControl3
      DockedDockControl = dxBarDockControl3
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 99
      FloatTop = 278
      FloatClientWidth = 51
      FloatClientHeight = 24
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bePH_StartDate'
        end
        item
          Visible = True
          ItemName = 'bePH_EndDate'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbPH_Refresh'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object dxBarManagerGoodsBar3: TdxBar
      Caption = 'Search Keys'
      CaptionButtons = <>
      DockControl = dxBarDockSearchKeys
      DockedDockControl = dxBarDockSearchKeys
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 682
      FloatTop = 447
      FloatClientWidth = 51
      FloatClientHeight = 24
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbSaveSearchKeys'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManagerGoodsBar2: TdxBar
      Caption = 'Titles toolbar'
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 998
      FloatTop = 2
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbGoodsTitleModify'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object bbPH_Refresh: TdxBarButton
      Caption = 'Refresh'
      Category = 0
      Hint = 'Refresh'
      Visible = ivAlways
      ImageIndex = 36
      OnClick = bbPH_RefreshClick
    end
    object bePH_StartDate: TcxBarEditItem
      Caption = 'Inceputul perioadei'
      Category = 0
      Hint = 'Inceputul perioadei'
      Visible = ivAlways
      ShowCaption = True
      PropertiesClassName = 'TcxDateEditProperties'
      Properties.DateButtons = [btnClear, btnNow, btnToday]
      Properties.SaveTime = False
      Properties.ShowTime = False
      Properties.WeekNumbers = True
      InternalEditValue = 0d
    end
    object bePH_EndDate: TcxBarEditItem
      Caption = 'Sfirsitul perioadei'
      Category = 0
      Hint = 'Sfirsitul perioadei'
      Visible = ivAlways
      ShowCaption = True
      PropertiesClassName = 'TcxDateEditProperties'
      Properties.DateButtons = [btnClear, btnNow, btnToday]
      Properties.SaveTime = False
      Properties.ShowTime = False
      Properties.WeekNumbers = True
      InternalEditValue = 0d
    end
    object bbGoodsTitleModify: TdxBarButton
      Caption = 'Modifica denumirea'
      Category = 0
      Hint = 'Modifica denumirea'
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 115
      OnClick = bbGoodsTitleModifyClick
    end
    object bbNewURL: TdxBarButton
      Caption = 'Nou'
      Category = 1
      Hint = 'Nou'
      Visible = ivAlways
      ShortCut = 45
    end
    object bbURLDelete: TdxBarButton
      Caption = 'Sterge'
      Category = 1
      Hint = 'Sterge'
      Visible = ivAlways
      ShortCut = 16430
    end
    object bbSaveSearchKeys: TdxBarButton
      Action = actSaveSearchKeys
      Category = 2
    end
  end
  object IBCDataSourceUM: TIBCDataSource
    DataSet = IBCQueryUM
    Left = 768
    Top = 204
  end
  object IBCQueryUM: TIBCQuery
    SQL.Strings = (
      'SELECT'
      '    UMID,'
      '    TITLE'
      'FROM'
      '    TS_UM'
      'WHERE'
      ' UMID<>-1')
    Left = 436
    Top = 76
  end
  object IBCDataSourceCurrency: TIBCDataSource
    DataSet = IBCQueryCurrency
    Left = 192
    Top = 72
  end
  object IBCQueryCurrency: TIBCQuery
    SQL.Strings = (
      'SELECT'
      '    CURRENCYID,'
      '    TITLE'
      'FROM'
      '    TS_CURRENCY')
    Left = 192
    Top = 120
  end
  object IBCDataSourceGoodsType: TIBCDataSource
    DataSet = IBCQueryGoodsType
    Left = 53
    Top = 88
  end
  object IBCDataSourceGST: TIBCDataSource
    DataSet = IBCQueryGST
    Left = 638
    Top = 80
  end
  object IBCQueryGST: TIBCQuery
    SQL.Strings = (
      'SELECT'
      '    goodsserialtypeid,'
      '    TITLE'
      'FROM'
      '    GET_GOODS_SERIAL_TYPES')
    Left = 639
    Top = 132
  end
  object IBCQueryPriceHistory: TIBCQuery
    SQL.Strings = (
      'SELECT'
      ' GOODSID,'
      ' DATA,'
      
        ' (SELECT FULL_NAME FROM TS_USERS WHERE USERID=MODIFIED_BY) MODIF' +
        'IED_BY_NAME,'
      ' PRICE0,'
      ' PRICE1,'
      ' PRICE2,'
      ' PRICE3,'
      ' PRICE4,'
      ' PRICE5,'
      ' PRICE6,'
      ' PRICE7,'
      
        ' (SELECT SHORTNAME FROM TS_CURRENCY WHERE TS_CURRENCY.CURRENCYID' +
        '=TS_GOODS_PRICE_HISTORY.CURRENCYID) CURRENCY_NAME'
      'FROM'
      ' TS_GOODS_PRICE_HISTORY'
      'ORDER BY'
      ' DATA')
    MasterFields = 'GOODSID'
    DetailFields = 'GOODSID'
    Left = 277
    Top = 157
  end
  object IBCDataSourcePriceHistory: TIBCDataSource
    DataSet = IBCQueryPriceHistory
    Left = 440
    Top = 132
  end
  object IBCQueryTypeGoodsDelivery: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'select * from ts_syss where parentid=45')
    Left = 611
    Top = 214
  end
  object IBCDataSourceTypeGoodsDelivery: TIBCDataSource
    DataSet = IBCQueryTypeGoodsDelivery
    Left = 794
    Top = 113
  end
  object IBCQueryGoodsType: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'select * from ts_syss where parentid=6')
    Left = 55
    Top = 136
  end
  object IBCQueryGoodsRelatedGoods: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      
        'select distinct g.goodsid relatedgoodsid, g.webgoodstype_id, g.w' +
        'ebgoodstype_title, g.title, g.price1_lei, g.flg_in_price from vw' +
        '_ts_goods g'
      'join ts_related_goods rg on g.goodsid = rg.goodsid'
      
        'join ts_related_goods z on z.goodsid = :goodsid and z.related_ke' +
        'y = rg.related_key'
      'order by  g.flg_in_price desc, g.webgoodstype_title, g.title')
    Left = 184
    Top = 360
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'goodsid'
        Value = nil
      end>
  end
  object IBCDataSourceRelatedGoods: TIBCDataSource
    DataSet = IBCQueryGoodsRelatedGoods
    Left = 96
    Top = 360
  end
  object IBCQuerySearchkeys: TIBCQuery
    KeyFields = 'GOODSID'
    SQLInsert.Strings = (
      'INSERT INTO TS_GOODS_SEARCHKEYS'
      '  (GOODSID, SEARCHKEYS)'
      'VALUES'
      '  (:GOODSID, :SEARCHKEYS)')
    SQLDelete.Strings = (
      'DELETE FROM TS_GOODS_SEARCHKEYS'
      'WHERE'
      '  GOODSID = :Old_GOODSID')
    SQLUpdate.Strings = (
      'UPDATE TS_GOODS_SEARCHKEYS'
      'SET'
      '  GOODSID = :GOODSID, SEARCHKEYS = :SEARCHKEYS'
      'WHERE'
      '  GOODSID = :Old_GOODSID')
    SQLRefresh.Strings = (
      'SELECT GOODSID, SEARCHKEYS FROM TS_GOODS_SEARCHKEYS'
      'WHERE'
      '  GOODSID = :GOODSID')
    SQLLock.Strings = (
      'SELECT NULL FROM TS_GOODS_SEARCHKEYS'
      'WHERE'
      'GOODSID = :Old_GOODSID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM TS_GOODS_SEARCHKEYS'
      ''
      ') q')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      'select * from ts_goods_searchkeys')
    MasterFields = 'GOODSID'
    DetailFields = 'GOODSID'
    AutoCommit = False
    BeforePost = IBCQuerySearchkeysBeforePost
    Left = 472
    Top = 344
  end
  object IBCDataSourceSearchkeys: TIBCDataSource
    DataSet = IBCQuerySearchkeys
    Left = 476
    Top = 295
  end
  object ActionList1: TActionList
    Left = 248
    Top = 320
    object actSaveSearchKeys: TAction
      Caption = 'Salveaza'
      OnExecute = actSaveSearchKeysExecute
      OnUpdate = actSaveSearchKeysUpdate
    end
  end
  object IBCQueryGoodsDictionary: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'select * from tsearch_goods_dictionary where goodsid = :goodsid')
    Left = 656
    Top = 344
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'goodsid'
        Value = nil
      end>
  end
  object IBCDataSourceGoodsDictionary: TIBCDataSource
    DataSet = IBCQueryGoodsDictionary
    Left = 656
    Top = 280
  end
  object IBCQueryGOODS_ACNT: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'select * from TS_goods_acnt'
      'where goods_TYPEID = :GOODS_TYPEID and flg_FOLDER=0')
    Left = 52
    Top = 488
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'GOODS_TYPEID'
        Value = nil
      end>
  end
  object IBCDataSourceGOODS_ACNT: TIBCDataSource
    DataSet = IBCQueryGOODS_ACNT
    Left = 52
    Top = 428
  end
end
