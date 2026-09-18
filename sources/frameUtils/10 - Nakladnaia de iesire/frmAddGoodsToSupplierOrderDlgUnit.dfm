object frmAddGoodsToSupplierOrderDlg: TfrmAddGoodsToSupplierOrderDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Adauga produsul in achizitie'
  ClientHeight = 442
  ClientWidth = 1058
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object RzDialogButtons1: TRzDialogButtons
    Left = 0
    Top = 401
    Width = 1058
    Height = 41
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1058
    Height = 401
    Align = alClient
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    object cxLookupComboBox1: TcxLookupComboBox
      Left = 564
      Top = 360
      Properties.GridMode = True
      Properties.IncrementalFilteringOptions = [ifoHighlightSearchText, ifoUseContainsOperator]
      Properties.KeyFieldNames = 'CUSTOMERID'
      Properties.ListColumns = <
        item
          Caption = 'Cod'
          Width = 80
          FieldName = 'CUSTOMERID'
        end
        item
          Caption = 'Denumire'
          Width = 250
          FieldName = 'NAME'
        end>
      Properties.ListFieldIndex = 1
      Properties.ListOptions.ShowHeader = False
      Properties.ListOptions.SyncMode = True
      Properties.ListSource = IBCDataSourceSuppliers
      TabOrder = 0
      Width = 402
    end
    object cxLabel1: TcxLabel
      Left = 564
      Top = 343
      Caption = 'Furnizor'
      TabOrder = 1
    end
    object cxGrid1: TcxGrid
      Left = 4
      Top = 245
      Width = 513
      Height = 139
      TabOrder = 2
      object cxGrid1DBTableView1: TcxGridDBTableView
        DataController.DataSource = IBCDataSourceDocs
        OptionsView.GroupByBox = False
        object cxGrid1DBTableView1DOCID: TcxGridDBColumn
          DataBinding.FieldName = 'DOCID'
          HeaderAlignmentHorz = taCenter
        end
        object cxGrid1DBTableView1DATA: TcxGridDBColumn
          DataBinding.FieldName = 'DATA'
          HeaderAlignmentHorz = taCenter
        end
        object cxGrid1DBTableView1CT: TcxGridDBColumn
          DataBinding.FieldName = 'CT'
          HeaderAlignmentHorz = taCenter
        end
        object cxGrid1DBTableView1CT_NAME: TcxGridDBColumn
          DataBinding.FieldName = 'CT_NAME'
          HeaderAlignmentHorz = taCenter
          Width = 150
        end
        object cxGrid1DBTableView1SUMA: TcxGridDBColumn
          DataBinding.FieldName = 'SUMA'
          HeaderAlignmentHorz = taCenter
        end
        object cxGrid1DBTableView1CURRENCY_NAME: TcxGridDBColumn
          DataBinding.FieldName = 'CURRENCY_NAME'
          HeaderAlignmentHorz = taCenter
        end
        object cxGrid1DBTableView1RATE: TcxGridDBColumn
          DataBinding.FieldName = 'RATE'
          HeaderAlignmentHorz = taCenter
        end
        object cxGrid1DBTableView1RATEUSD: TcxGridDBColumn
          DataBinding.FieldName = 'RATEUSD'
          HeaderAlignmentHorz = taCenter
        end
        object cxGrid1DBTableView1FLG_CLOSED: TcxGridDBColumn
          DataBinding.FieldName = 'FLG_CLOSED'
          HeaderAlignmentHorz = taCenter
        end
        object cxGrid1DBTableView1CREATED_DATE: TcxGridDBColumn
          DataBinding.FieldName = 'CREATED_DATE'
          HeaderAlignmentHorz = taCenter
        end
        object cxGrid1DBTableView1CREATED_BY_NAME: TcxGridDBColumn
          DataBinding.FieldName = 'CREATED_BY_NAME'
          HeaderAlignmentHorz = taCenter
        end
        object cxGrid1DBTableView1DOCTYPEID: TcxGridDBColumn
          DataBinding.FieldName = 'DOCTYPEID'
          Visible = False
          HeaderAlignmentHorz = taCenter
        end
        object cxGrid1DBTableView1DOCTYPE_NAME: TcxGridDBColumn
          DataBinding.FieldName = 'DOCTYPE_NAME'
          Visible = False
          HeaderAlignmentHorz = taCenter
        end
        object cxGrid1DBTableView1CONTRACTID: TcxGridDBColumn
          DataBinding.FieldName = 'CONTRACTID'
          Visible = False
          HeaderAlignmentHorz = taCenter
        end
        object cxGrid1DBTableView1CONTRACT_CODE: TcxGridDBColumn
          DataBinding.FieldName = 'CONTRACT_CODE'
          Visible = False
          HeaderAlignmentHorz = taCenter
        end
        object cxGrid1DBTableView1CONTRACT_SIGN_DATE: TcxGridDBColumn
          DataBinding.FieldName = 'CONTRACT_SIGN_DATE'
          Visible = False
          HeaderAlignmentHorz = taCenter
        end
        object cxGrid1DBTableView1CONTRACT_CURRENCYID: TcxGridDBColumn
          DataBinding.FieldName = 'CONTRACT_CURRENCYID'
          Visible = False
          HeaderAlignmentHorz = taCenter
        end
        object cxGrid1DBTableView1CONTRACT_TYPE_TITLE: TcxGridDBColumn
          DataBinding.FieldName = 'CONTRACT_TYPE_TITLE'
          Visible = False
          HeaderAlignmentHorz = taCenter
        end
        object cxGrid1DBTableView1CONTRACT_PRICECOLUMN: TcxGridDBColumn
          DataBinding.FieldName = 'CONTRACT_PRICECOLUMN'
          Visible = False
          HeaderAlignmentHorz = taCenter
        end
        object cxGrid1DBTableView1FLG_WITH_DELIVERY: TcxGridDBColumn
          DataBinding.FieldName = 'FLG_WITH_DELIVERY'
          Visible = False
          HeaderAlignmentHorz = taCenter
        end
      end
      object cxGrid1Level1: TcxGridLevel
        GridView = cxGrid1DBTableView1
      end
    end
    object btnRefresh: TcxButton
      Left = 972
      Top = 359
      Width = 75
      Height = 25
      Caption = 'Refresh'
      TabOrder = 3
      OnClick = btnRefreshClick
    end
    object cxGridForeign: TcxGrid
      Left = 4
      Top = 4
      Width = 1043
      Height = 234
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      LookAndFeel.Kind = lfFlat
      LookAndFeel.NativeStyle = False
      LookAndFeel.ScrollbarMode = sbmDefault
      object cxGridForeignDBBandedTableView1: TcxGridDBBandedTableView
        DataController.DataSource = IBCDataSourceForeign
        OptionsBehavior.HotTrackSelection = False
        OptionsBehavior.ImmediateEditor = False
        OptionsBehavior.RecordScrollMode = rsmByRecord
        OptionsCustomize.ColumnGrouping = False
        OptionsCustomize.ColumnsQuickCustomization = True
        OptionsCustomize.ColumnsQuickCustomizationShowCommands = False
        OptionsCustomize.BandMoving = False
        OptionsCustomize.BandsQuickCustomization = True
        OptionsCustomize.BandsQuickCustomizationShowCommands = False
        OptionsCustomize.ColumnVertSizing = False
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.HideFocusRectOnExit = False
        OptionsSelection.UnselectFocusedRecordOnExit = False
        OptionsView.ColumnAutoWidth = True
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        Styles.BandHeader = dmAdditions.cxStyle_Bold
        Bands = <
          item
            Caption = 'Informatie produs'
            Width = 780
          end
          item
            Caption = 'Preturi si valuta'
            Width = 673
          end>
        object TV1_GOODS_CODE: TcxGridDBBandedColumn
          AlternateCaption = 'Cod produs furnizor'
          Caption = 'Cod produs f.'
          DataBinding.FieldName = 'GOODS_CODE'
          MinWidth = 100
          Width = 288
          Position.BandIndex = 0
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object TV1_GOODSID: TcxGridDBBandedColumn
          Caption = 'Cod intern'
          DataBinding.FieldName = 'GOODSID'
          Visible = False
          Width = 105
          Position.BandIndex = 0
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object TV1_CUSTOMER_NAME: TcxGridDBBandedColumn
          Caption = 'Furnizor'
          DataBinding.FieldName = 'CUSTOMER_NAME'
          Width = 111
          Position.BandIndex = 0
          Position.ColIndex = 3
          Position.RowIndex = 0
        end
        object TV1_BARCODE: TcxGridDBBandedColumn
          Caption = 'BarCode'
          DataBinding.FieldName = 'BARCODE'
          Visible = False
          Width = 178
          Position.BandIndex = 0
          Position.ColIndex = 2
          Position.RowIndex = 0
        end
        object TV1_FLG_PREORDER: TcxGridDBBandedColumn
          Caption = 'Pre'
          DataBinding.FieldName = 'FLG_PREORDER'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = '1'
          Properties.ValueUnchecked = '0'
          HeaderAlignmentHorz = taCenter
          MinWidth = 34
          Options.HorzSizing = False
          Width = 34
          Position.BandIndex = 0
          Position.ColIndex = 6
          Position.RowIndex = 0
        end
        object TV1_FLG_IN_PRICE: TcxGridDBBandedColumn
          Caption = 'Stoc'
          DataBinding.FieldName = 'FLG_IN_PRICE'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = '1'
          Properties.ValueUnchecked = '0'
          HeaderAlignmentHorz = taCenter
          MinWidth = 37
          Options.HorzSizing = False
          Width = 37
          Position.BandIndex = 0
          Position.ColIndex = 5
          Position.RowIndex = 0
        end
        object TV1_FLG_SUPPLIER_PROMO: TcxGridDBBandedColumn
          AlternateCaption = 'Promotie Furnizor'
          Caption = 'Prm'
          DataBinding.FieldName = 'FLG_SUPPLIER_PROMO'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = '1'
          Properties.ValueUnchecked = '0'
          HeaderAlignmentHorz = taCenter
          MinWidth = 36
          Options.HorzSizing = False
          Width = 36
          Position.BandIndex = 0
          Position.ColIndex = 7
          Position.RowIndex = 0
        end
        object TV1_FLG_SUPPLIER_PRIORITY: TcxGridDBBandedColumn
          AlternateCaption = 'Furnizor Prioritar'
          Caption = 'Pr F.'
          DataBinding.FieldName = 'FLG_SUPPLIER_PRIORITY'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = '1'
          Properties.ValueUnchecked = '0'
          HeaderAlignmentHorz = taCenter
          MinWidth = 35
          Options.HorzSizing = False
          Width = 35
          Position.BandIndex = 0
          Position.ColIndex = 8
          Position.RowIndex = 0
        end
        object TV1_PRICE1: TcxGridDBBandedColumn
          Caption = 'Web'
          DataBinding.FieldName = 'PRICE1'
          HeaderAlignmentHorz = taCenter
          MinWidth = 64
          Options.HorzSizing = False
          Width = 64
          Position.BandIndex = 1
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object TV1_CURRENCY1ID: TcxGridDBBandedColumn
          Caption = 'V1'
          DataBinding.FieldName = 'CURRENCY1NAME'
          HeaderAlignmentHorz = taCenter
          MinWidth = 64
          Options.HorzSizing = False
          Width = 64
          Position.BandIndex = 1
          Position.ColIndex = 0
          Position.RowIndex = 1
        end
        object TV1_PRICE2: TcxGridDBBandedColumn
          Caption = 'Promo'
          DataBinding.FieldName = 'PRICE2_MDL'
          HeaderAlignmentHorz = taCenter
          MinWidth = 64
          Options.HorzSizing = False
          Width = 64
          Position.BandIndex = 1
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object TV1_CURRENCY2ID: TcxGridDBBandedColumn
          Caption = 'V2'
          DataBinding.FieldName = 'CURRENCY2NAME'
          HeaderAlignmentHorz = taCenter
          MinWidth = 64
          Options.HorzSizing = False
          Width = 64
          Position.BandIndex = 1
          Position.ColIndex = 1
          Position.RowIndex = 1
        end
        object TV1_PRICE3: TcxGridDBBandedColumn
          Caption = 'RRP'
          DataBinding.FieldName = 'PRICE3_MDL'
          HeaderAlignmentHorz = taCenter
          MinWidth = 64
          Options.HorzSizing = False
          Width = 64
          Position.BandIndex = 1
          Position.ColIndex = 2
          Position.RowIndex = 0
        end
        object TV1_CURRENCY3ID: TcxGridDBBandedColumn
          Caption = 'V3'
          DataBinding.FieldName = 'CURRENCY3NAME'
          HeaderAlignmentHorz = taCenter
          MinWidth = 64
          Options.HorzSizing = False
          Width = 64
          Position.BandIndex = 1
          Position.ColIndex = 2
          Position.RowIndex = 1
        end
        object TV1_PRICE4: TcxGridDBBandedColumn
          Caption = 'V4'
          DataBinding.FieldName = 'CURRENCY4NAME'
          HeaderAlignmentHorz = taCenter
          MinWidth = 80
          Options.HorzSizing = False
          Width = 80
          Position.BandIndex = 1
          Position.ColIndex = 3
          Position.RowIndex = 1
        end
        object TV1_PRICE5: TcxGridDBBandedColumn
          Caption = 'Discount'
          DataBinding.FieldName = 'PRICE5_LEI'
          HeaderAlignmentHorz = taCenter
          MinWidth = 80
          Options.HorzSizing = False
          Width = 80
          Position.BandIndex = 1
          Position.ColIndex = 4
          Position.RowIndex = 0
        end
        object TV1_MARGIN5: TcxGridDBBandedColumn
          Caption = 'M5'
          DataBinding.FieldName = 'DIFF57'
          HeaderAlignmentHorz = taCenter
          MinWidth = 40
          Options.HorzSizing = False
          Width = 40
          Position.BandIndex = 1
          Position.ColIndex = 4
          Position.RowIndex = 1
        end
        object TV1_CURRENCY5ID: TcxGridDBBandedColumn
          Caption = 'V5'
          DataBinding.FieldName = 'CURRENCY5NAME'
          HeaderAlignmentHorz = taCenter
          MinWidth = 40
          Options.HorzSizing = False
          Width = 40
          Position.BandIndex = 1
          Position.ColIndex = 5
          Position.RowIndex = 1
        end
        object TV1_PRICE6: TcxGridDBBandedColumn
          Caption = 'Diler'
          DataBinding.FieldName = 'PRICE6_LEI'
          HeaderAlignmentHorz = taCenter
          MinWidth = 80
          Options.HorzSizing = False
          Width = 80
          Position.BandIndex = 1
          Position.ColIndex = 5
          Position.RowIndex = 0
        end
        object TV_MARGIN6: TcxGridDBBandedColumn
          Caption = 'M6'
          DataBinding.FieldName = 'DIFF67'
          HeaderAlignmentHorz = taCenter
          MinWidth = 40
          Options.HorzSizing = False
          Width = 40
          Position.BandIndex = 1
          Position.ColIndex = 6
          Position.RowIndex = 1
        end
        object TV1_CURRENCY6ID: TcxGridDBBandedColumn
          Caption = 'V6'
          DataBinding.FieldName = 'CURRENCY6NAME'
          HeaderAlignmentHorz = taCenter
          MinWidth = 40
          Options.HorzSizing = False
          Width = 40
          Position.BandIndex = 1
          Position.ColIndex = 7
          Position.RowIndex = 1
        end
        object TV1_PRICE7: TcxGridDBBandedColumn
          Caption = 'Indicativ'
          DataBinding.FieldName = 'PRICE7'
          VisibleForExpressionEditor = bFalse
          HeaderAlignmentHorz = taCenter
          MinWidth = 64
          Options.HorzSizing = False
          VisibleForCustomization = False
          VisibleForEditForm = bFalse
          Width = 64
          Position.BandIndex = 1
          Position.ColIndex = 7
          Position.RowIndex = 0
        end
        object TV1_CURRENCY7ID: TcxGridDBBandedColumn
          Caption = 'V7'
          DataBinding.FieldName = 'CURRENCY7NAME'
          VisibleForExpressionEditor = bFalse
          HeaderAlignmentHorz = taCenter
          MinWidth = 64
          Options.HorzSizing = False
          VisibleForCustomization = False
          VisibleForEditForm = bFalse
          Width = 64
          Position.BandIndex = 1
          Position.ColIndex = 10
          Position.RowIndex = 1
        end
        object TV1_flg_min_purchaise_price: TcxGridDBBandedColumn
          Caption = '..'
          DataBinding.FieldName = 'flg_min_purchaise_price'
          MinWidth = 24
          Options.HorzSizing = False
          VisibleForCustomization = False
          Width = 24
          Position.BandIndex = 0
          Position.ColIndex = 9
          Position.RowIndex = 0
        end
        object TV1_PRICE4MDL: TcxGridDBBandedColumn
          Caption = 'Calc, MDL'
          DataBinding.FieldName = 'PRICE4MDL'
          HeaderAlignmentHorz = taCenter
          MinWidth = 80
          Options.HorzSizing = False
          Width = 80
          Position.BandIndex = 1
          Position.ColIndex = 3
          Position.RowIndex = 0
        end
        object TV1_DIFF47: TcxGridDBBandedColumn
          Caption = 'M'
          DataBinding.FieldName = 'DIFF47'
          VisibleForExpressionEditor = bFalse
          HeaderAlignmentHorz = taCenter
          MinWidth = 60
          Options.HorzSizing = False
          VisibleForCustomization = False
          VisibleForEditForm = bFalse
          Width = 60
          Position.BandIndex = 1
          Position.ColIndex = 8
          Position.RowIndex = 1
        end
        object TV1_PERCENT47: TcxGridDBBandedColumn
          Caption = '%'
          DataBinding.FieldName = 'MARGIN17'
          VisibleForExpressionEditor = bFalse
          HeaderAlignmentHorz = taCenter
          MinWidth = 60
          Options.HorzSizing = False
          VisibleForCustomization = False
          VisibleForEditForm = bFalse
          Width = 60
          Position.BandIndex = 1
          Position.ColIndex = 9
          Position.RowIndex = 1
        end
        object TV1_PRICE7_LEI: TcxGridDBBandedColumn
          Caption = 'Indicativ, MDL'
          DataBinding.FieldName = 'PRICE7_LEI'
          VisibleForExpressionEditor = bTrue
          HeaderAlignmentHorz = taCenter
          MinWidth = 120
          Options.HorzSizing = False
          VisibleForCustomization = False
          VisibleForEditForm = bFalse
          Width = 120
          Position.BandIndex = 1
          Position.ColIndex = 6
          Position.RowIndex = 0
        end
        object TV1_FLG_RRP: TcxGridDBBandedColumn
          Caption = 'RRP'
          DataBinding.FieldName = 'FLG_RRP'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = '1'
          Properties.ValueUnchecked = '0'
          HeaderAlignmentHorz = taCenter
          MinWidth = 35
          Options.HorzSizing = False
          Width = 35
          Position.BandIndex = 0
          Position.ColIndex = 10
          Position.RowIndex = 0
        end
        object tv1_PriceIndicativ: TcxGridDBBandedColumn
          Caption = 'P0, calc'
          DataBinding.ValueType = 'Float'
          PropertiesClassName = 'TcxCalcEditProperties'
          HeaderAlignmentHorz = taCenter
          MinWidth = 60
          Options.HorzSizing = False
          SortIndex = 0
          SortOrder = soAscending
          Width = 60
          Position.BandIndex = 0
          Position.ColIndex = 3
          Position.RowIndex = 1
        end
        object TV1_CUSTOMERID: TcxGridDBBandedColumn
          Caption = 'Cod Furnizor'
          DataBinding.FieldName = 'CUSTOMERID'
          Visible = False
          Width = 69
          Position.BandIndex = 0
          Position.ColIndex = 4
          Position.RowIndex = 0
        end
        object TV1_MODIFY: TcxGridDBBandedColumn
          Caption = 'Modificat P1'
          DataBinding.FieldName = 'LAST_PRICE_DATE'
          MinWidth = 80
          Options.HorzSizing = False
          Width = 80
          Position.BandIndex = 0
          Position.ColIndex = 13
          Position.RowIndex = 0
        end
        object TV1_GOODS_TITLE: TcxGridDBBandedColumn
          Caption = 'Denumire'
          DataBinding.FieldName = 'GOODS_TITLE'
          Width = 564
          Position.BandIndex = 0
          Position.ColIndex = 0
          Position.RowIndex = 1
        end
        object tb1_ModifyPrice7: TcxGridDBBandedColumn
          Caption = 'Modificat P7'
          DataBinding.FieldName = 'LAST_PRICE7_DATE'
          MinWidth = 80
          Options.HorzSizing = False
          Width = 80
          Position.BandIndex = 0
          Position.ColIndex = 4
          Position.RowIndex = 1
        end
        object TV1_PRICE0_LEI: TcxGridDBBandedColumn
          Caption = 'P0, real'
          DataBinding.FieldName = 'PRICE0_LEI'
          MinWidth = 60
          Options.HorzSizing = False
          Styles.Content = dmAdditions.cxStyle_CalcProfitYellow
          Width = 60
          Position.BandIndex = 0
          Position.ColIndex = 12
          Position.RowIndex = 0
        end
        object TV1_FLG_DRP: TcxGridDBBandedColumn
          Caption = 'DRP'
          DataBinding.FieldName = 'FLG_DRP'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.NullStyle = nssUnchecked
          Properties.ValueChecked = '1'
          Properties.ValueUnchecked = '0'
          MinWidth = 28
          Options.HorzSizing = False
          Width = 28
          Position.BandIndex = 0
          Position.ColIndex = 1
          Position.RowIndex = 1
        end
        object TV1_MARGIN01: TcxGridDBBandedColumn
          Caption = 'M01'
          DataBinding.FieldName = 'MARGIN01'
          MinWidth = 40
          Options.HorzSizing = False
          Width = 40
          Position.BandIndex = 0
          Position.ColIndex = 11
          Position.RowIndex = 0
        end
        object cxGridForeignDBBandedTableView1Column1: TcxGridDBBandedColumn
          Caption = 'OP7'
          DataBinding.FieldName = 'ORD_PRICE7'
          Width = 45
          Position.BandIndex = 1
          Position.ColIndex = 8
          Position.RowIndex = 0
        end
        object cxGridForeignDBBandedTableView1Column2: TcxGridDBBandedColumn
          Caption = 'OV7'
          DataBinding.FieldName = 'ORD_CURRENCY7ID'
          Width = 80
          Position.BandIndex = 1
          Position.ColIndex = 11
          Position.RowIndex = 1
        end
        object TV1_DIF01: TcxGridDBBandedColumn
          Caption = 'D01'
          DataBinding.FieldName = 'DIFF01'
          Width = 48
          Position.BandIndex = 0
          Position.ColIndex = 2
          Position.RowIndex = 1
        end
      end
      object cxGridForeignLevel1: TcxGridLevel
        GridView = cxGridForeignDBBandedTableView1
      end
    end
  end
  object IBCQuerySuppliers: TIBCQuery
    SQL.Strings = (
      'select * from ts_customer WHERE PARENTID = 227869'
      'ORDER BY NAME')
    Left = 593
    Top = 87
  end
  object IBCDataSourceSuppliers: TIBCDataSource
    DataSet = IBCQuerySuppliers
    Left = 584
    Top = 24
  end
  object IBCQueryDocs: TIBCQuery
    SQL.Strings = (
      
        'select * from vw_tdb_docs where cast(data as date) between curre' +
        'nt_date-2 and current_date and ct = :supplierid and dt = :dt'
      'order by docid')
    MasterSource = IBCDataSourceSuppliers
    Active = True
    Left = 152
    Top = 216
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'supplierid'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'dt'
        Value = nil
      end>
  end
  object IBCDataSourceDocs: TIBCDataSource
    DataSet = IBCQueryDocs
    Left = 152
    Top = 152
  end
  object IBCQueryForeign: TIBCQuery
    KeyFields = 'GOODSID;CUSTOMERID;GOODS_CODE'
    SQLInsert.Strings = (
      'INSERT INTO VW_TS_GOODS_FOREIGN'
      
        '  (GOODSID, CUSTOMERID, DISPLAYNAME, GOODS_CODE, BARCODE, GOODS_' +
        'TITLE, URL, '
      
        '  FLG_SUPPLIER_PROMO, FLG_IN_PROMO, FLG_AVAILABLE_QTY, FLG_SUPPL' +
        'IER_PRIORITY, '
      '  FLG_IN_PRICE, FLG_EPP, FLG_PREORDER, '
      '  FLG_DRP,'
      '  PRICE0, CURRENCY0ID, CURRENCY0_NAME, '
      '  PRICE1,'
      '  currency1id,'
      '  PRICE2,'
      '  currency2id,'
      '  PRICE3,'
      '  currency3id,'
      '  PRICE4, PRICE4MDL, CURRENCY4ID, CURRENCY4_NAME, '
      '  PRICE5,currency5id, '
      '  PRICE6, currency6id, '
      '  PRICE7, CURRENCY7ID, CURRENCY7_NAME, '
      '  ORD_PRICE7, ORD_CURRENCY7ID,'
      '  LAST_PRICE_DATE,'
      '  margin5, '
      '  margin6)'
      'VALUES'
      
        '  (:GOODSID, :CUSTOMERID, :CUSTOMER_NAME, :GOODS_CODE, :BARCODE,' +
        ' :GOODS_TITLE, :URL, '
      
        '  :FLG_SUPPLIER_PROMO, :FLG_IN_PROMO, :FLG_AVAILABLE_QTY, :FLG_S' +
        'UPPLIER_PRIORITY, '
      '  :FLG_IN_PRICE, :FLG_RRP, :FLG_PREORDER, '
      '  :FLG_DRP,'
      '  :PRICE0, :CURRENCY0ID, :CURRENCY0_NAME, '
      '  :PRICE1,'
      '  :currency1id,'
      '  :PRICE2,'
      '  :currency2id,'
      '  :PRICE3,'
      '  :currency3id,'
      '  :PRICE4, :PRICE4MDL, :CURRENCY4ID, :CURRENCY4_NAME, '
      '  :PRICE5, :Currency5ID, '
      '  :PRICE6, :CURRENCY6ID, '
      '  :PRICE7, :CURRENCY7ID, :CURRENCY7_NAME, '
      '  :ORD_PRICE7, :ORD_CURRENCY7ID, '
      '  :LAST_PRICE_DATE,'
      '  :margin5,'
      '  :margin6)')
    SQLDelete.Strings = (
      'DELETE FROM TS_GOODS_FOREIGN'
      'WHERE'
      
        '  GOODSID = :Old_GOODSID AND CUSTOMERID = :Old_CUSTOMERID AND GO' +
        'ODS_CODE = :Old_GOODS_CODE')
    SQLUpdate.Strings = (
      'UPDATE VW_TS_GOODS_FOREIGN'
      'SET'
      
        '  GOODSID = :GOODSID, CUSTOMERID = :CUSTOMERID, DISPLAYNAME = :C' +
        'USTOMER_NAME, '
      '  GOODS_CODE = :GOODS_CODE, '
      '  BARCODE = :BARCODE, GOODS_TITLE = :GOODS_TITLE, URL = :URL, '
      '  FLG_SUPPLIER_PROMO = :FLG_SUPPLIER_PROMO, '
      '  FLG_IN_PROMO = :FLG_IN_PROMO, '
      '  FLG_AVAILABLE_QTY = :FLG_AVAILABLE_QTY, '
      '  FLG_SUPPLIER_PRIORITY = :FLG_SUPPLIER_PRIORITY, '
      '  FLG_IN_PRICE = :FLG_IN_PRICE, '
      '  FLG_EPP = :FLG_RRP, '
      '  FLG_PREORDER = :FLG_PREORDER, '
      '  FLG_DRP = :FLG_DRP,  '
      '  PRICE0 = :PRICE0, '
      '  CURRENCY0ID = :CURRENCY0ID, '
      '  CURRENCY0_NAME = :CURRENCY0_NAME, '
      ''
      '  PRICE1 = :PRICE1,'
      '  currency1id = :CURRENCY1ID,'
      '  PRICE2 = :PRICE2,'
      '  currency2id = :CURRENCY2ID,'
      '  PRICE3 = :PRICE3,'
      '  currency3id = :CURRENCY3ID,'
      ''
      '  PRICE4 = :PRICE4, PRICE4MDL = :PRICE4MDL, '
      '  CURRENCY4ID = :CURRENCY4ID, CURRENCY4_NAME = :CURRENCY4_NAME, '
      '  PRICE5 = :PRICE5, '
      '  CURRENCY5ID = :CURRENCY5ID,'
      '  PRICE6 = :PRICE6, '
      '  CURRENCY6ID = :CURRENCY6ID,'
      '  PRICE7 = :PRICE7, '
      '  CURRENCY7ID = :CURRENCY7ID, '
      '  CURRENCY7_NAME = :CURRENCY7_NAME,'
      ''
      '  ORD_PRICE7 = :ORD_PRICE7, '
      '  ORD_CURRENCY7ID = :ORD_CURRENCY7ID, '
      ''
      '  LAST_PRICE_DATE = :LAST_PRICE_DATE, '
      '  PERCENT47 = :PERCENT47, DIFF47 = :DIFF47,'
      '  margin5 = :margin5,'
      '  margin6 = :margin6'
      'WHERE'
      
        '  GOODSID = :Old_GOODSID AND CUSTOMERID = :Old_CUSTOMERID AND GO' +
        'ODS_CODE = :Old_GOODS_CODE')
    SQLRefresh.Strings = (
      'select v.*, '
      
        '  iif(v.price7_lei<>0, abs(round((1- v.PRICE1 / v.PRICE7_LEI) *1' +
        '00,2)), 0) margin17,'
      
        '  iif(v.price7_lei<>0, round(v.PRICE1 - v.PRICE7_LEI, 2), 0) dif' +
        'f17,'
      
        '  iif(v.price7_lei<>0, abs(round((1- convert_amount(v.PRICE3, v.' +
        'currency3id, 498)  / v.PRICE7_LEI) *100,2)), 0) margin37,'
      
        '  iif(v.price7_lei<>0, round(convert_amount(v.PRICE3, v.currency' +
        '3id, 498)  -  v.PRICE7_LEI, 2), 0) diff37,'
      
        '  iif(v.price7_lei<>0, abs(round((1- convert_amount(v.PRICE4, v.' +
        'currency4id, 498)  / v.PRICE7_LEI) *100,2)), 0) margin47,'
      
        '--  iif(v.price7_lei<>0, round(convert_amount(v.PRICE4, v.curren' +
        'cy4id, 498)  -  v.PRICE7_LEI, 2), 0) diff47,'
      
        '  iif(v.price7_lei<>0, abs(round((1- convert_amount(v.PRICE5, v.' +
        'currency5id, 498)  / v.PRICE7_LEI) *100,2)), 0) margin57,'
      
        '  iif(v.price7_lei<>0, round(convert_amount(v.PRICE5, v.currency' +
        '5id, 498)  -  v.PRICE7_LEI, 2), 0) diff57,'
      
        '  iif(v.price7_lei<>0, abs(round((1- convert_amount(v.PRICE6, v.' +
        'currency6id, 498)  / v.PRICE7_LEI) *100,2)), 0) margin67,'
      
        '  iif(v.price7_lei<>0, round(convert_amount(v.PRICE6, v.currency' +
        '6id, 498)  -  v.PRICE7_LEI, 2), 0) diff67,'
      
        '  (select title from ts_currency where currencyid = currency1id)' +
        ' currency1Name,'
      
        '  (select title from ts_currency where currencyid = currency2id)' +
        ' currency2Name,'
      
        '  (select title from ts_currency where currencyid = currency3id)' +
        ' currency3Name,'
      
        '  (select title from ts_currency where currencyid = currency4id)' +
        ' currency4Name,'
      
        '  (select title from ts_currency where currencyid = currency5id)' +
        ' currency5Name,'
      
        '  (select title from ts_currency where currencyid = currency6id)' +
        ' currency6Name,'
      
        '  (select title from ts_currency where currencyid = currency7id)' +
        ' currency7Name'
      'from GET_GOODS_FOREIGN(:GOODSID) v'
      'WHERE'
      '  CUSTOMERID = :CUSTOMERID AND GOODS_CODE = :GOODS_CODE'
      'order by flg_in_price desc, PRICE7_LEI desc ')
    SQLLock.Strings = (
      'SELECT NULL FROM TS_GOODS_FOREIGN'
      'WHERE'
      
        'GOODSID = :Old_GOODSID AND CUSTOMERID = :Old_CUSTOMERID AND GOOD' +
        'S_CODE = :Old_GOODS_CODE'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM VW_TS_GOODS_FOREIGN'
      ''
      ') q')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      
        'select V.*, iif(V.PRICE7_LEI <> 0, round((V.PRICE1 / V.PRICE7_LE' +
        'I - 1) * 100, 2), 0) MARGIN17,'
      
        '       iif(V.PRICE7_LEI <> 0, round(V.PRICE1 - V.PRICE7_LEI, 2),' +
        ' 0) DIFF17,'
      
        '       iif(V.PRICE7_LEI <> 0, round((CONVERT_AMOUNT(V.PRICE3, V.' +
        'CURRENCY3ID, 498) / V.PRICE7_LEI - 1) * 100, 2), 0) MARGIN37,'
      
        '       iif(V.PRICE7_LEI <> 0, round(CONVERT_AMOUNT(V.PRICE3, V.C' +
        'URRENCY3ID, 498) - V.PRICE7_LEI, 2), 0) DIFF37,'
      
        '       iif(V.PRICE7_LEI <> 0, round((CONVERT_AMOUNT(V.PRICE4, V.' +
        'CURRENCY4ID, 498) / V.PRICE7_LEI - 1) * 100, 2), 0) MARGIN47,'
      
        '       iif(V.PRICE7_LEI <> 0, round((CONVERT_AMOUNT(V.PRICE5, V.' +
        'CURRENCY5ID, 498) / V.PRICE7_LEI - 1) * 100, 2), 0) MARGIN57,'
      
        '       iif(V.PRICE7_LEI <> 0, round(CONVERT_AMOUNT(V.PRICE5, V.C' +
        'URRENCY5ID, 498) - V.PRICE7_LEI, 2), 0) DIFF57,'
      
        '       iif(V.PRICE7_LEI <> 0, round((CONVERT_AMOUNT(V.PRICE6, V.' +
        'CURRENCY6ID, 498) / V.PRICE7_LEI - 1) * 100, 2), 0) MARGIN67,'
      
        '       iif(V.PRICE7_LEI <> 0, round(CONVERT_AMOUNT(V.PRICE6, V.C' +
        'URRENCY6ID, 498) - V.PRICE7_LEI, 2), 0) DIFF67,'
      ''
      '       iif(V.PRICE0 <> 0,'
      
        '           V.price1 - round(CONVERT_AMOUNT(V.PRICE0, V.CURRENCY7' +
        'ID, 498) , 2),'
      
        '           V.price1 - round(CONVERT_AMOUNT(V.PRICE7, V.CURRENCY7' +
        'ID, 498) , 2)'
      '       ) DIFF01,'
      ''
      '       iif(CONVERT_AMOUNT(V.PRICE0, V.CURRENCY7ID, 498) <> 0,'
      
        '        round(((V.PRICE1 / CONVERT_AMOUNT(V.PRICE0, V.CURRENCY7I' +
        'D, 498)) - 1) * 100, 2), iif(V.PRICE7_LEI <> 0, round((V.PRICE1 ' +
        '/ V.PRICE7_LEI - 1) * 100, 2), 0)) MARGIN01,'
      ''
      
        '       (select TITLE from TS_CURRENCY where CURRENCYID = CURRENC' +
        'Y1ID) CURRENCY1NAME,'
      
        '       (select TITLE from TS_CURRENCY where CURRENCYID = CURRENC' +
        'Y2ID) CURRENCY2NAME,'
      
        '       (select TITLE from TS_CURRENCY where CURRENCYID = CURRENC' +
        'Y3ID) CURRENCY3NAME,'
      
        '       (select TITLE from TS_CURRENCY where CURRENCYID = CURRENC' +
        'Y4ID) CURRENCY4NAME,'
      
        '       (select TITLE from TS_CURRENCY where CURRENCYID = CURRENC' +
        'Y5ID) CURRENCY5NAME,'
      
        '       (select TITLE from TS_CURRENCY where CURRENCYID = CURRENC' +
        'Y6ID) CURRENCY6NAME,'
      
        '       (select TITLE from TS_CURRENCY where CURRENCYID = CURRENC' +
        'Y7ID) CURRENCY7NAME, CONVERT_AMOUNT(PRICE0, CURRENCY0ID, 498) PR' +
        'ICE0_LEI'
      'from GET_GOODS_FOREIGN(:GOODSID) V'
      'order by FLG_IN_PRICE desc, PRICE0, PRICE7_LEI')
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Left = 849
    Top = 103
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'goodsID'
        Value = nil
      end>
  end
  object IBCDataSourceForeign: TIBCDataSource
    DataSet = IBCQueryForeign
    Left = 858
    Top = 47
  end
end
