object frmGoodsForeignCodeDlg: TfrmGoodsForeignCodeDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Produse coduri furnizori'
  ClientHeight = 631
  ClientWidth = 1487
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    1487
    631)
  TextHeight = 15
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 8
    Width = 1471
    Height = 593
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelOuter = bvNone
    TabOrder = 0
    object dxBarDockControl1: TdxBarDockControl
      Left = 0
      Top = 95
      Width = 1471
      Height = 30
      Align = dalTop
      BarManager = dxBarManagerGoods
      SunkenBorder = True
      UseOwnSunkenBorder = True
    end
    object cxGridForeign: TcxGrid
      Left = 0
      Top = 125
      Width = 1471
      Height = 235
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      LookAndFeel.Kind = lfFlat
      LookAndFeel.NativeStyle = False
      LookAndFeel.ScrollbarMode = sbmDefault
      object cxGridForeignDBBandedTableView1: TcxGridDBBandedTableView
        PopupMenu = dxBarPopupMenu1
        OnKeyDown = cxGridForeignDBBandedTableView1KeyDown
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
        Styles.OnGetContentStyle = cxGridForeignDBBandedTableView1StylesGetContentStyle
        Styles.BandHeader = dmAdditions.cxStyle_Bold
        Bands = <
          item
            Caption = 'Informatie produs'
            Width = 780
          end
          item
            Caption = 'Web'
            Width = 64
          end
          item
            Caption = 'Promo'
            Width = 64
          end
          item
            Caption = 'RRP'
            Width = 64
          end
          item
            Caption = 'Calc'
            Width = 64
          end
          item
            Caption = 'Discount'
            Width = 64
          end
          item
            Caption = 'Diler'
            Width = 64
          end
          item
            Caption = 'Indicativ'
            Width = 64
          end
          item
            Caption = 'Marje'
            Width = 300
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
          Visible = False
          Width = 64
          Position.BandIndex = 8
          Position.ColIndex = 0
          Position.RowIndex = 2
        end
        object TV1_CURRENCY1ID: TcxGridDBBandedColumn
          Caption = 'V1'
          DataBinding.FieldName = 'CURRENCY1NAME'
          HeaderAlignmentHorz = taCenter
          MinWidth = 64
          Options.HorzSizing = False
          Visible = False
          Width = 64
          Position.BandIndex = 8
          Position.ColIndex = 1
          Position.RowIndex = 2
        end
        object TV1_PRICE2: TcxGridDBBandedColumn
          Caption = 'Promo'
          DataBinding.FieldName = 'PRICE2_MDL'
          HeaderAlignmentHorz = taCenter
          MinWidth = 64
          Options.HorzSizing = False
          Visible = False
          Width = 64
          Position.BandIndex = 8
          Position.ColIndex = 2
          Position.RowIndex = 2
        end
        object TV1_CURRENCY2ID: TcxGridDBBandedColumn
          Caption = 'V2'
          DataBinding.FieldName = 'CURRENCY2NAME'
          HeaderAlignmentHorz = taCenter
          MinWidth = 64
          Options.HorzSizing = False
          Visible = False
          Width = 64
          Position.BandIndex = 8
          Position.ColIndex = 3
          Position.RowIndex = 2
        end
        object TV1_PRICE3: TcxGridDBBandedColumn
          Caption = 'RRP'
          DataBinding.FieldName = 'PRICE3_MDL'
          HeaderAlignmentHorz = taCenter
          MinWidth = 64
          Options.HorzSizing = False
          Visible = False
          Width = 64
          Position.BandIndex = 8
          Position.ColIndex = 4
          Position.RowIndex = 2
        end
        object TV1_CURRENCY3ID: TcxGridDBBandedColumn
          Caption = 'V3'
          DataBinding.FieldName = 'CURRENCY3NAME'
          HeaderAlignmentHorz = taCenter
          MinWidth = 64
          Options.HorzSizing = False
          Visible = False
          Width = 64
          Position.BandIndex = 8
          Position.ColIndex = 5
          Position.RowIndex = 2
        end
        object TV1_PRICE4: TcxGridDBBandedColumn
          Caption = 'V4'
          DataBinding.FieldName = 'CURRENCY4NAME'
          HeaderAlignmentHorz = taCenter
          MinWidth = 80
          Options.HorzSizing = False
          Visible = False
          Width = 80
          Position.BandIndex = 8
          Position.ColIndex = 6
          Position.RowIndex = 2
        end
        object TV1_PRICE5: TcxGridDBBandedColumn
          Caption = 'Discount'
          DataBinding.FieldName = 'PRICE5_LEI'
          HeaderAlignmentHorz = taCenter
          MinWidth = 80
          Options.HorzSizing = False
          Visible = False
          Width = 80
          Position.BandIndex = 8
          Position.ColIndex = 7
          Position.RowIndex = 2
        end
        object TV1_MARGIN5: TcxGridDBBandedColumn
          Caption = 'M5'
          DataBinding.FieldName = 'DIFF57'
          HeaderAlignmentHorz = taCenter
          MinWidth = 40
          Options.HorzSizing = False
          Width = 40
          Position.BandIndex = 8
          Position.ColIndex = 0
          Position.RowIndex = 1
        end
        object TV1_CURRENCY5ID: TcxGridDBBandedColumn
          Caption = 'V5'
          DataBinding.FieldName = 'CURRENCY5NAME'
          HeaderAlignmentHorz = taCenter
          MinWidth = 40
          Options.HorzSizing = False
          Visible = False
          Width = 40
          Position.BandIndex = 8
          Position.ColIndex = 8
          Position.RowIndex = 2
        end
        object TV1_PRICE6: TcxGridDBBandedColumn
          Caption = 'Diler'
          DataBinding.FieldName = 'PRICE6_LEI'
          HeaderAlignmentHorz = taCenter
          MinWidth = 80
          Options.HorzSizing = False
          Visible = False
          Width = 80
          Position.BandIndex = 8
          Position.ColIndex = 9
          Position.RowIndex = 2
        end
        object TV_MARGIN6: TcxGridDBBandedColumn
          Caption = 'M6'
          DataBinding.FieldName = 'DIFF67'
          HeaderAlignmentHorz = taCenter
          MinWidth = 40
          Options.HorzSizing = False
          Width = 40
          Position.BandIndex = 8
          Position.ColIndex = 1
          Position.RowIndex = 1
        end
        object TV1_CURRENCY6ID: TcxGridDBBandedColumn
          Caption = 'V6'
          DataBinding.FieldName = 'CURRENCY6NAME'
          HeaderAlignmentHorz = taCenter
          MinWidth = 40
          Options.HorzSizing = False
          Visible = False
          Width = 40
          Position.BandIndex = 8
          Position.ColIndex = 10
          Position.RowIndex = 2
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
          Visible = False
          Width = 64
          Position.BandIndex = 8
          Position.ColIndex = 11
          Position.RowIndex = 2
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
          Visible = False
          Width = 64
          Position.BandIndex = 8
          Position.ColIndex = 12
          Position.RowIndex = 2
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
          Position.BandIndex = 8
          Position.ColIndex = 0
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
          Position.BandIndex = 8
          Position.ColIndex = 2
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
          Position.BandIndex = 8
          Position.ColIndex = 3
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
          Visible = False
          Width = 120
          Position.BandIndex = 8
          Position.ColIndex = 13
          Position.RowIndex = 2
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
          Position.BandIndex = 8
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object cxGridForeignDBBandedTableView1Column2: TcxGridDBBandedColumn
          Caption = 'OV7'
          DataBinding.FieldName = 'ORD_CURRENCY7ID'
          Width = 80
          Position.BandIndex = 8
          Position.ColIndex = 4
          Position.RowIndex = 1
        end
        object TV1_DIF01: TcxGridDBBandedColumn
          Caption = 'D01'
          DataBinding.FieldName = 'DIFF01'
          Styles.Content = cxStyleBold
          Width = 48
          Position.BandIndex = 0
          Position.ColIndex = 2
          Position.RowIndex = 1
        end
        object TV1_PRICE_CREDIT0: TcxGridDBBandedColumn
          AlternateCaption = 'Pret rate 6 luni 0%, calculat = max(Web, Indicativ MDL + 16%)'
          Caption = 'Rate 0%'
          DataBinding.FieldName = 'PRICE_CREDIT0'
          HeaderAlignmentHorz = taCenter
          MinWidth = 64
          Options.Editing = False
          Options.HorzSizing = False
          Width = 64
          Position.BandIndex = 8
          Position.ColIndex = 2
          Position.RowIndex = 0
        end
        object TV1_P1_MDL: TcxGridDBBandedColumn
          AlternateCaption = 'Web, pret MDL'
          Caption = 'Pret MDL'
          DataBinding.FieldName = 'P1_MDL'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.Alignment.Horz = taRightJustify
          Properties.DisplayFormat = ',0.00;-,0.00'
          HeaderAlignmentHorz = taCenter
          MinWidth = 64
          Options.HorzSizing = False
          Styles.Content = cxStyleBold
          Width = 64
          Position.BandIndex = 1
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object TV1_P1_USD: TcxGridDBBandedColumn
          AlternateCaption = 'Web, pret USD'
          Caption = 'Pret USD'
          DataBinding.FieldName = 'P1_USD'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.Alignment.Horz = taRightJustify
          Properties.DisplayFormat = ',0.00;-,0.00'
          HeaderAlignmentHorz = taCenter
          MinWidth = 64
          Options.HorzSizing = False
          Width = 64
          Position.BandIndex = 1
          Position.ColIndex = 0
          Position.RowIndex = 1
        end
        object TV1_P2_MDL: TcxGridDBBandedColumn
          AlternateCaption = 'Promo, pret MDL'
          Caption = 'Pret MDL'
          DataBinding.FieldName = 'P2_MDL'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.Alignment.Horz = taRightJustify
          Properties.DisplayFormat = ',0.00;-,0.00'
          HeaderAlignmentHorz = taCenter
          MinWidth = 64
          Options.HorzSizing = False
          Styles.Content = cxStyleBold
          Width = 64
          Position.BandIndex = 2
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object TV1_P2_USD: TcxGridDBBandedColumn
          AlternateCaption = 'Promo, pret USD'
          Caption = 'Pret USD'
          DataBinding.FieldName = 'P2_USD'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.Alignment.Horz = taRightJustify
          Properties.DisplayFormat = ',0.00;-,0.00'
          HeaderAlignmentHorz = taCenter
          MinWidth = 64
          Options.HorzSizing = False
          Width = 64
          Position.BandIndex = 2
          Position.ColIndex = 0
          Position.RowIndex = 1
        end
        object TV1_P3_MDL: TcxGridDBBandedColumn
          AlternateCaption = 'RRP, pret MDL'
          Caption = 'Pret MDL'
          DataBinding.FieldName = 'P3_MDL'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.Alignment.Horz = taRightJustify
          Properties.DisplayFormat = ',0.00;-,0.00'
          HeaderAlignmentHorz = taCenter
          MinWidth = 64
          Options.HorzSizing = False
          Styles.Content = cxStyleBold
          Width = 64
          Position.BandIndex = 3
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object TV1_P3_USD: TcxGridDBBandedColumn
          AlternateCaption = 'RRP, pret USD'
          Caption = 'Pret USD'
          DataBinding.FieldName = 'P3_USD'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.Alignment.Horz = taRightJustify
          Properties.DisplayFormat = ',0.00;-,0.00'
          HeaderAlignmentHorz = taCenter
          MinWidth = 64
          Options.HorzSizing = False
          Width = 64
          Position.BandIndex = 3
          Position.ColIndex = 0
          Position.RowIndex = 1
        end
        object TV1_P4_MDL: TcxGridDBBandedColumn
          AlternateCaption = 'Calc, pret MDL'
          Caption = 'Pret MDL'
          DataBinding.FieldName = 'P4_MDL'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.Alignment.Horz = taRightJustify
          Properties.DisplayFormat = ',0.00;-,0.00'
          HeaderAlignmentHorz = taCenter
          MinWidth = 64
          Options.HorzSizing = False
          Styles.Content = cxStyleBold
          Width = 64
          Position.BandIndex = 4
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object TV1_P4_USD: TcxGridDBBandedColumn
          AlternateCaption = 'Calc, pret USD'
          Caption = 'Pret USD'
          DataBinding.FieldName = 'P4_USD'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.Alignment.Horz = taRightJustify
          Properties.DisplayFormat = ',0.00;-,0.00'
          HeaderAlignmentHorz = taCenter
          MinWidth = 64
          Options.HorzSizing = False
          Width = 64
          Position.BandIndex = 4
          Position.ColIndex = 0
          Position.RowIndex = 1
        end
        object TV1_P5_MDL: TcxGridDBBandedColumn
          AlternateCaption = 'Discount, pret MDL'
          Caption = 'Pret MDL'
          DataBinding.FieldName = 'P5_MDL'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.Alignment.Horz = taRightJustify
          Properties.DisplayFormat = ',0.00;-,0.00'
          HeaderAlignmentHorz = taCenter
          MinWidth = 64
          Options.HorzSizing = False
          Styles.Content = cxStyleBold
          Width = 64
          Position.BandIndex = 5
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object TV1_P5_USD: TcxGridDBBandedColumn
          AlternateCaption = 'Discount, pret USD'
          Caption = 'Pret USD'
          DataBinding.FieldName = 'P5_USD'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.Alignment.Horz = taRightJustify
          Properties.DisplayFormat = ',0.00;-,0.00'
          HeaderAlignmentHorz = taCenter
          MinWidth = 64
          Options.HorzSizing = False
          Width = 64
          Position.BandIndex = 5
          Position.ColIndex = 0
          Position.RowIndex = 1
        end
        object TV1_P6_MDL: TcxGridDBBandedColumn
          AlternateCaption = 'Diler, pret MDL'
          Caption = 'Pret MDL'
          DataBinding.FieldName = 'P6_MDL'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.Alignment.Horz = taRightJustify
          Properties.DisplayFormat = ',0.00;-,0.00'
          OnCustomDrawCell = TV1_CURRENCY7IDCustomDrawCell
          HeaderAlignmentHorz = taCenter
          MinWidth = 64
          Options.HorzSizing = False
          Styles.Content = cxStyleBold
          Width = 64
          Position.BandIndex = 6
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object TV1_P6_USD: TcxGridDBBandedColumn
          AlternateCaption = 'Diler, pret USD'
          Caption = 'Pret USD'
          DataBinding.FieldName = 'P6_USD'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.Alignment.Horz = taRightJustify
          Properties.DisplayFormat = ',0.00;-,0.00'
          HeaderAlignmentHorz = taCenter
          MinWidth = 64
          Options.HorzSizing = False
          Width = 64
          Position.BandIndex = 6
          Position.ColIndex = 0
          Position.RowIndex = 1
        end
        object TV1_P7_MDL: TcxGridDBBandedColumn
          AlternateCaption = 'Indicativ, pret MDL'
          Caption = 'Pret MDL'
          DataBinding.FieldName = 'P7_MDL'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.Alignment.Horz = taRightJustify
          Properties.DisplayFormat = ',0.00;-,0.00'
          OnCustomDrawCell = TV1_CURRENCY7IDCustomDrawCell
          HeaderAlignmentHorz = taCenter
          MinWidth = 64
          Options.HorzSizing = False
          Styles.Content = cxStyleBold
          Width = 64
          Position.BandIndex = 7
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object TV1_P7_USD: TcxGridDBBandedColumn
          AlternateCaption = 'Indicativ, pret USD'
          Caption = 'Pret USD'
          DataBinding.FieldName = 'P7_USD'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.Alignment.Horz = taRightJustify
          Properties.DisplayFormat = ',0.00;-,0.00'
          HeaderAlignmentHorz = taCenter
          MinWidth = 64
          Options.HorzSizing = False
          Width = 64
          Position.BandIndex = 7
          Position.ColIndex = 0
          Position.RowIndex = 1
        end
      end
      object cxGridForeignLevel1: TcxGridLevel
        GridView = cxGridForeignDBBandedTableView1
      end
    end
    object pnGoods: TPanel
      AlignWithMargins = True
      Left = 0
      Top = 0
      Width = 1471
      Height = 81
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 14
      Align = alTop
      BevelKind = bkFlat
      BevelOuter = bvNone
      Color = clWindow
      ParentBackground = False
      TabOrder = 0
      DesignSize = (
        1467
        77)
      object mmGoods: TcxMemo
        Left = 5
        Top = 9
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        ParentFont = False
        Properties.ReadOnly = True
        TabOrder = 0
        Height = 65
        Width = 1446
      end
    end
    object cxPageControl1: TcxPageControl
      AlignWithMargins = True
      Left = 3
      Top = 363
      Width = 1465
      Height = 227
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      Properties.ActivePage = cxTabSheet1
      Properties.CustomButtons.Buttons = <>
      ClientRectBottom = 223
      ClientRectLeft = 4
      ClientRectRight = 1461
      ClientRectTop = 26
      object cxTabSheet1: TcxTabSheet
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = 'Generale'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindow
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ImageIndex = 0
        ParentFont = False
        object ShapeQty: TShape
          Left = 1141
          Top = 18
          Width = 39
          Height = 15
          Brush.Color = clRed
          Pen.Color = clRed
          Pen.Width = 3
          Shape = stRoundRect
        end
        object cxLabel1: TcxLabel
          Left = 5
          Top = 5
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Caption = 'Lista actiunilor cu acest produs'
          ParentFont = False
          Style.Font.Charset = DEFAULT_CHARSET
          Style.Font.Color = clWindowText
          Style.Font.Height = -12
          Style.Font.Name = 'Segoe UI'
          Style.Font.Style = []
          Style.IsFontAssigned = True
          TabOrder = 0
          Transparent = True
        end
        object cxDBVerticalGrid1: TcxDBVerticalGrid
          Left = 5
          Top = 34
          Width = 524
          Height = 148
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          LookAndFeel.Kind = lfUltraFlat
          LookAndFeel.NativeStyle = True
          OptionsView.RowHeaderMinWidth = 42
          OptionsView.RowHeaderWidth = 278
          OptionsView.ValueWidth = 175
          OptionsView.ValueMinWidth = 70
          OptionsView.NavigatorOffset = 88
          OptionsData.CancelOnExit = False
          OptionsData.Appending = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Inserting = False
          ScrollbarAnnotations.CustomAnnotations = <>
          TabOrder = 5
          DataController.DataSource = IBCDataSourcePromos
          Version = 1
          object cxDBVerticalGrid1DBEditorRow2: TcxDBEditorRow
            Properties.Caption = 'Promo ID'
            Properties.EditPropertiesClassName = 'TcxButtonEditProperties'
            Properties.EditProperties.Buttons = <
              item
                Default = True
                Kind = bkEllipsis
              end>
            Properties.EditProperties.OnButtonClick = cxDBVerticalGrid1DBEditorRow2EditPropertiesButtonClick
            Properties.DataBinding.FieldName = 'PROMOACTIONID'
            Properties.Options.Filtering = False
            Properties.Options.FilteringWithFindPanel = False
            Properties.Options.IgnoreTimeForFiltering = False
            Properties.Options.IncSearch = False
            ID = 0
            ParentID = -1
            Index = 0
            Version = 1
          end
          object cxDBVerticalGrid1DBEditorRow1: TcxDBEditorRow
            Properties.Caption = 'Promotie activa'
            Properties.EditPropertiesClassName = 'TcxCheckBoxProperties'
            Properties.EditProperties.Alignment = taRightJustify
            Properties.EditProperties.NullStyle = nssUnchecked
            Properties.EditProperties.ValueChecked = '1'
            Properties.EditProperties.ValueGrayed = 0
            Properties.EditProperties.ValueUnchecked = '0'
            Properties.DataBinding.FieldName = 'FLG_PROMO_ACTIVE'
            Properties.Options.Editing = False
            ID = 1
            ParentID = -1
            Index = 1
            Version = 1
          end
          object cxDBVerticalGrid1DBMultiEditorRow1: TcxDBMultiEditorRow
            Properties.Editors = <
              item
                Caption = 'Start'
                Width = 88
                DataBinding.FieldName = 'START_DATE'
                Options.Editing = False
              end
              item
                Caption = 'End'
                Width = 88
                DataBinding.FieldName = 'END_DATE'
                Options.Editing = False
              end>
            ID = 2
            ParentID = -1
            Index = 2
            Version = 1
          end
          object cxDBVerticalGrid1DBEditorRow5: TcxDBEditorRow
            Properties.Caption = 'Denumire'
            Properties.DataBinding.FieldName = 'TITLE'
            Properties.Options.Editing = False
            ID = 3
            ParentID = -1
            Index = 3
            Version = 1
          end
          object cxDBVerticalGrid1DBMultiEditorRow2: TcxDBMultiEditorRow
            Properties.Editors = <
              item
                Caption = 'Pret 4'
                Width = 88
                DataBinding.FieldName = 'PRICE4'
                Options.Editing = False
              end
              item
                Caption = 'Pret4, MDL'
                Width = 88
                DataBinding.FieldName = 'PRICE4_MDL'
                Options.Editing = False
              end
              item
                Caption = 'Pret vechi'
                Width = 70
                DataBinding.FieldName = 'OLD_PRICE4'
                Options.Editing = False
              end>
            ID = 4
            ParentID = -1
            Index = 4
            Version = 1
          end
          object cxDBVerticalGrid1DBEditorRow3: TcxDBEditorRow
            Properties.Caption = 'Furnizor'
            Properties.DataBinding.FieldName = 'SUPPLIER_NAME'
            Properties.Options.Editing = False
            Styles.Content = dmAdditions.cxStyle_Bold
            ID = 5
            ParentID = -1
            Index = 5
            Version = 1
          end
        end
        object lbQty: TcxLabel
          Left = 1143
          Top = 17
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          AutoSize = False
          Caption = '1'
          ParentColor = False
          ParentFont = False
          Style.Color = clGreen
          Style.Font.Charset = RUSSIAN_CHARSET
          Style.Font.Color = clWindowText
          Style.Font.Height = -11
          Style.Font.Name = 'Segoe UI'
          Style.Font.Style = [fsBold]
          Style.Shadow = False
          Style.TextColor = clWhite
          Style.TransparentBorder = True
          Style.IsFontAssigned = True
          Properties.Alignment.Horz = taCenter
          TabOrder = 1
          Transparent = True
          Height = 21
          Width = 31
          AnchorX = 1159
        end
        object cxLabel2: TcxLabel
          Left = 552
          Top = 20
          Caption = 'Furnizor'
          ParentFont = False
          Style.TextColor = clWindowText
          TabOrder = 2
        end
        object cxLabel3: TcxLabel
          Left = 1080
          Top = 16
          Caption = 'Cantitate'
          ParentFont = False
          Style.TextColor = clWindowText
          TabOrder = 3
        end
        object lblSupplier: TcxLabel
          Left = 610
          Top = 18
          AutoSize = False
          Caption = 'Nu este disponibil'
          ParentFont = False
          Style.TextColor = clWindowText
          Style.TextStyle = []
          Properties.Alignment.Vert = taVCenter
          Properties.LabelStyle = cxlsLowered
          Properties.ShowEndEllipsis = True
          TabOrder = 4
          Height = 25
          Width = 431
          AnchorY = 31
        end
        object cxLabel4: TcxLabel
          Left = 552
          Top = 52
          Caption = 'Calea'
          ParentFont = False
          Style.TextColor = clWindowText
          TabOrder = 6
        end
        object lbPath: TcxLabel
          Left = 610
          Top = 49
          AutoSize = False
          Caption = '..'
          ParentFont = False
          Style.TextColor = clWindowText
          Style.TextStyle = [fsBold]
          Properties.Alignment.Vert = taVCenter
          Properties.LabelStyle = cxlsLowered
          Properties.ShowEndEllipsis = True
          TabOrder = 7
          Height = 26
          Width = 572
          AnchorY = 62
        end
        object cxLabel5: TcxLabel
          Left = 552
          Top = 90
          Caption = 'WebSite'
          ParentFont = False
          Style.TextColor = clWindowText
          TabOrder = 8
        end
        object lbURL: TcxDBLabel
          Left = 610
          Top = 88
          DataBinding.DataField = 'WEBPAGE'
          DataBinding.DataSource = IBCDataSourceCustomerInfo
          ParentColor = False
          ParentFont = False
          Style.Color = clBtnFace
          Style.Font.Charset = DEFAULT_CHARSET
          Style.Font.Color = clNavy
          Style.Font.Height = -12
          Style.Font.Name = 'Segoe UI'
          Style.Font.Style = []
          Style.IsFontAssigned = True
          TabOrder = 9
          Height = 21
          Width = 572
        end
      end
    end
  end
  object btnOk: TcxButton
    Left = 731
    Top = 594
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancel: TcxButton
    Left = 843
    Top = 594
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 2
  end
  object dxBarManagerGoods: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Default'
      'Grid')
    Categories.ItemsVisibles = (
      2
      2)
    Categories.Visibles = (
      True
      True)
    ImageOptions.Images = dmAdditions.cxImageList_SWN
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 689
    Top = 272
    PixelsPerInch = 96
    object dxBarManagerGoodsBar2: TdxBar
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
      FloatLeft = 623
      FloatTop = 8
      FloatClientWidth = 82
      FloatClientHeight = 77
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbForeignNew'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbForeignModify'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbForeignDelete'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'btnRefresh'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbInstrumente'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbSupllierApi'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbCall'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbCopyToPartner'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = True
    end
    object bbForeignNew: TdxBarButton
      Caption = 'Nou'
      Category = 0
      Hint = 'Nou'
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 45
      OnClick = bbForeignNewClick
    end
    object bbForeignModify: TdxBarButton
      Caption = 'Modifica'
      Category = 0
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 115
      OnClick = bbForeignModifyClick
    end
    object bbForeignDelete: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      ShortCut = 16430
      OnClick = bbForeignDeleteClick
    end
    object bbCall: TdxBarButton
      Caption = 'Apel'
      Category = 0
      Hint = 'Apel'
      Visible = ivAlways
      ImageIndex = 70
      ShortCut = 32836
      OnClick = bbCallClick
    end
    object dxBarSubItem1: TdxBarSubItem
      Caption = 'Actiuni'
      Category = 0
      Visible = ivAlways
      ItemLinks = <>
    end
    object bbInstrumente: TdxBarSubItem
      Caption = 'Instrumente'
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbGoodsMoves'
        end
        item
          Visible = True
          ItemName = 'bbGoodsPriceHistory'
        end
        item
          Visible = True
          ItemName = 'bbDebts'
        end
        item
          Visible = True
          ItemName = 'dxBarButton1'
        end
        item
          Visible = True
          ItemName = 'bbPricePolicy'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbAVAILABLE_QTY'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbSetForcesFlag'
        end
        item
          Visible = True
          ItemName = 'bbRemoveForcedFlag'
        end>
    end
    object bbGoodsMoves: TdxBarButton
      Caption = 'Miscarea produsului'
      Category = 0
      Hint = 'Miscarea produsului'
      Visible = ivAlways
      ShortCut = 16463
      OnClick = bbGoodsMovesClick
    end
    object bbGoodsPriceHistory: TdxBarButton
      Caption = 'Istoria modificarii preturilor'
      Category = 0
      Hint = 'Istoria modificarii preturilor'
      Visible = ivAlways
      ShortCut = 16456
      OnClick = bbGoodsPriceHistoryClick
    end
    object bbSupllierApi: TdxBarButton
      Caption = 'Stoc disponibil'
      Category = 0
      Hint = 'Stoc disponibil'
      Visible = ivAlways
      ShortCut = 16467
      OnClick = bbSupllierApiClick
    end
    object bbDebts: TdxBarButton
      Caption = 'Creante'
      Category = 0
      Hint = 'Creante'
      Visible = ivAlways
      ShortCut = 16452
      OnClick = bbDebtsClick
    end
    object dxBarButton1: TdxBarButton
      Caption = 'Rezeteaza preturile si valuta'
      Category = 0
      Hint = 'Rezeteaza preturile si valuta'
      Visible = ivAlways
      OnClick = dxBarButton1Click
    end
    object btnRefresh: TdxBarButton
      Caption = 'Refresh'
      Category = 0
      Hint = 'Refresh'
      Visible = ivAlways
      ImageIndex = 36
      ShortCut = 116
      OnClick = btnRefreshClick
    end
    object bbPricePolicy: TdxBarButton
      Caption = 'Politica de preturi'
      Category = 0
      Hint = 'Politica de preturi'
      Visible = ivAlways
      ShortCut = 32848
      OnClick = bbPricePolicyClick
    end
    object bbCopyToPartner: TdxBarButton
      Caption = 'Copy partener'
      Category = 0
      Hint = 'Copy partener'
      Visible = ivAlways
      ShortCut = 32835
      OnClick = bbCopyToPartnerClick
    end
    object bbRemoveForcedFlag: TdxBarButton
      Caption = 'Sterge "view forced"'
      Category = 1
      Hint = 'Sterge "view forced"'
      Visible = ivAlways
      ImageIndex = 100
      ShortCut = 41030
      OnClick = bbRemoveForcedFlagClick
    end
    object bbSetForcesFlag: TdxBarButton
      Caption = 'Seteaza "view forced"'
      Category = 1
      Hint = 'Seteaza "view forced"'
      Visible = ivAlways
      ImageIndex = 101
      ShortCut = 32838
      OnClick = bbSetForcesFlagClick
    end
    object bbAVAILABLE_QTY: TdxBarButton
      Caption = 'Cantinate suficienta'
      Category = 1
      Hint = 'Cantinate suficienta'
      Visible = ivAlways
      Glyph.SourceDPI = 96
      Glyph.Data = {
        89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
        61000000017352474200AECE1CE90000000467414D410000B18F0BFC61050000
        00097048597300000EC300000EC301C76FA864000000B549444154384F63F84F
        214031E0DC9B1BFF57DDDDFD7FC38303FFCFBFB9F9FFEBEFEF5019DC006EC0C5
        B7B7FF33CC3446C14CB34CFE2B2FF7FF1FB4ABF47FCE91CEFF71FBEBFE87EE2E
        87EA8000B801475E5CC030001B965AE201D50101A3066031801118F25C73AD31
        34C2305E03FA2E2DFDFFFBDF1F30FFF3EF6FFF773C3EF6BFF6F4F4FFE17B2AFF
        BB6CC9FC6FB729E57FD28146B03C0CA01830E3DA5A288F78306A009201DFFEFC
        F8FFFEE767288F58F0FF3F003EEF51769F6866C50000000049454E44AE426082}
      ShortCut = 16433
      OnClick = bbAVAILABLE_QTYClick
    end
    object bbSelectCreditOption: TdxBarButton
      Caption = 'Selecteaza tipul creditului'
      Category = 1
      Hint = 'Selecteaza tipul creditului'
      Visible = ivAlways
      OnClick = bbSelectCreditOptionClick
    end
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
      '  , round(CONVERT_AMOUNT(V.PRICE1, V.CURRENCY1ID, 498), 2) P1_MDL'
      '  , round(CONVERT_AMOUNT(V.PRICE1, V.CURRENCY1ID, 840), 2) P1_USD'
      '  , iif(V.PRICE1 is null, null, ''MDL'') C1_MDL'
      '  , iif(V.PRICE1 is null, null, ''USD'') C1_USD'
      '  , round(CONVERT_AMOUNT(V.PRICE2, V.CURRENCY2ID, 498), 2) P2_MDL'
      '  , round(CONVERT_AMOUNT(V.PRICE2, V.CURRENCY2ID, 840), 2) P2_USD'
      '  , iif(V.PRICE2 is null, null, ''MDL'') C2_MDL'
      '  , iif(V.PRICE2 is null, null, ''USD'') C2_USD'
      '  , round(CONVERT_AMOUNT(V.PRICE3, V.CURRENCY3ID, 498), 2) P3_MDL'
      '  , round(CONVERT_AMOUNT(V.PRICE3, V.CURRENCY3ID, 840), 2) P3_USD'
      '  , iif(V.PRICE3 is null, null, ''MDL'') C3_MDL'
      '  , iif(V.PRICE3 is null, null, ''USD'') C3_USD'
      '  , round(CONVERT_AMOUNT(V.PRICE4, V.CURRENCY4ID, 498), 2) P4_MDL'
      '  , round(CONVERT_AMOUNT(V.PRICE4, V.CURRENCY4ID, 840), 2) P4_USD'
      '  , iif(V.PRICE4 is null, null, ''MDL'') C4_MDL'
      '  , iif(V.PRICE4 is null, null, ''USD'') C4_USD'
      '  , round(CONVERT_AMOUNT(V.PRICE5, V.CURRENCY5ID, 498), 2) P5_MDL'
      '  , round(CONVERT_AMOUNT(V.PRICE5, V.CURRENCY5ID, 840), 2) P5_USD'
      '  , iif(V.PRICE5 is null, null, ''MDL'') C5_MDL'
      '  , iif(V.PRICE5 is null, null, ''USD'') C5_USD'
      '  , round(CONVERT_AMOUNT(V.PRICE6, V.CURRENCY6ID, 498), 2) P6_MDL'
      '  , round(CONVERT_AMOUNT(V.PRICE6, V.CURRENCY6ID, 840), 2) P6_USD'
      '  , iif(V.PRICE6 is null, null, ''MDL'') C6_MDL'
      '  , iif(V.PRICE6 is null, null, ''USD'') C6_USD'
      '  , round(CONVERT_AMOUNT(V.PRICE7, V.CURRENCY7ID, 498), 2) P7_MDL'
      '  , round(CONVERT_AMOUNT(V.PRICE7, V.CURRENCY7ID, 840), 2) P7_USD'
      '  , iif(V.PRICE7 is null, null, ''MDL'') C7_MDL'
      '  , iif(V.PRICE7 is null, null, ''USD'') C7_USD'
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
    UpdateTransaction = IBCTrUpdate
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
      '  , round(CONVERT_AMOUNT(V.PRICE1, V.CURRENCY1ID, 498), 2) P1_MDL'
      '  , round(CONVERT_AMOUNT(V.PRICE1, V.CURRENCY1ID, 840), 2) P1_USD'
      '  , iif(V.PRICE1 is null, null, ''MDL'') C1_MDL'
      '  , iif(V.PRICE1 is null, null, ''USD'') C1_USD'
      '  , round(CONVERT_AMOUNT(V.PRICE2, V.CURRENCY2ID, 498), 2) P2_MDL'
      '  , round(CONVERT_AMOUNT(V.PRICE2, V.CURRENCY2ID, 840), 2) P2_USD'
      '  , iif(V.PRICE2 is null, null, ''MDL'') C2_MDL'
      '  , iif(V.PRICE2 is null, null, ''USD'') C2_USD'
      '  , round(CONVERT_AMOUNT(V.PRICE3, V.CURRENCY3ID, 498), 2) P3_MDL'
      '  , round(CONVERT_AMOUNT(V.PRICE3, V.CURRENCY3ID, 840), 2) P3_USD'
      '  , iif(V.PRICE3 is null, null, ''MDL'') C3_MDL'
      '  , iif(V.PRICE3 is null, null, ''USD'') C3_USD'
      '  , round(CONVERT_AMOUNT(V.PRICE4, V.CURRENCY4ID, 498), 2) P4_MDL'
      '  , round(CONVERT_AMOUNT(V.PRICE4, V.CURRENCY4ID, 840), 2) P4_USD'
      '  , iif(V.PRICE4 is null, null, ''MDL'') C4_MDL'
      '  , iif(V.PRICE4 is null, null, ''USD'') C4_USD'
      '  , round(CONVERT_AMOUNT(V.PRICE5, V.CURRENCY5ID, 498), 2) P5_MDL'
      '  , round(CONVERT_AMOUNT(V.PRICE5, V.CURRENCY5ID, 840), 2) P5_USD'
      '  , iif(V.PRICE5 is null, null, ''MDL'') C5_MDL'
      '  , iif(V.PRICE5 is null, null, ''USD'') C5_USD'
      '  , round(CONVERT_AMOUNT(V.PRICE6, V.CURRENCY6ID, 498), 2) P6_MDL'
      '  , round(CONVERT_AMOUNT(V.PRICE6, V.CURRENCY6ID, 840), 2) P6_USD'
      '  , iif(V.PRICE6 is null, null, ''MDL'') C6_MDL'
      '  , iif(V.PRICE6 is null, null, ''USD'') C6_USD'
      '  , round(CONVERT_AMOUNT(V.PRICE7, V.CURRENCY7ID, 498), 2) P7_MDL'
      '  , round(CONVERT_AMOUNT(V.PRICE7, V.CURRENCY7ID, 840), 2) P7_USD'
      '  , iif(V.PRICE7 is null, null, ''MDL'') C7_MDL'
      '  , iif(V.PRICE7 is null, null, ''USD'') C7_USD'
      'from GET_GOODS_FOREIGN(:GOODSID) V'
      'order by FLG_IN_PRICE desc, PRICE0, PRICE7_LEI')
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Left = 139
    Top = 328
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'goodsID'
        Value = nil
      end>
  end
  object IBCDataSourceForeign: TIBCDataSource
    DataSet = IBCQueryForeign
    Left = 148
    Top = 272
  end
  object IBCTrUpdate: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 52
    Top = 272
  end
  object dxBarPopupMenu1: TdxBarPopupMenu
    BarManager = dxBarManagerGoods
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbSetForcesFlag'
      end
      item
        Visible = True
        ItemName = 'bbRemoveForcedFlag'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbAVAILABLE_QTY'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbSelectCreditOption'
      end>
    UseOwnFont = False
    Left = 496
    Top = 272
    PixelsPerInch = 96
  end
  object IBCQueryPromos: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      
        'select GET_FLG_VALUE(P.FLAGS, 0) FLG_PROMO_ACTIVE, P.PROMOACTION' +
        'ID, P.TITLE, P.START_DATE, P.END_DATE, PAG.GOODSID, PAG.PRICE4,'
      
        '       round(PAG.PRICE4 * GET_CURRENCYRATE(CURRENCYID)) PRICE4_M' +
        'DL, OLD_PRICE4,'
      '       (select DISPLAYNAME'
      '        from TS_CUSTOMER'
      '        where CUSTOMERID = PAG.SUPPLIERID) SUPPLIER_NAME'
      'from TWEB_PA_GOODS PAG'
      'join TWEB_PROMOS P on P.PROMOACTIONID = PAG.PROMOACTIONID and'
      '      GET_FLG_VALUE(P.FLAGS, 0) = 1 and'
      '      --get_flg_value(p.flags,  5) = 0 and'
      '      current_date between P.START_DATE and P.END_DATE'
      'join TS_GOODS_FOREIGN GF on GF.GOODSID = PAG.GOODSID and'
      '      GF.CUSTOMERID = PAG.SUPPLIERID and'
      '      GET_FLG_VALUE(GF.FLAGS, 3) = 1'
      'where PAG.GOODSID = :GOODSID'
      'order by price4_mdl')
    Left = 256
    Top = 328
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'GOODSID'
        Value = nil
      end>
  end
  object IBCDataSourcePromos: TIBCDataSource
    DataSet = IBCQueryPromos
    Left = 256
    Top = 272
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 626
    Top = 88
    PixelsPerInch = 96
    object cxStyleBKGreen: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = 5287936
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clDefault
      Font.Height = -12
      Font.Name = 'Segoe UI Semibold'
      Font.Style = [fsBold]
      TextColor = clWindow
    end
    object cxStyleGray: TcxStyle
      AssignedValues = [svFont, svTextColor]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clDefault
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsStrikeOut]
      TextColor = clGray
    end
    object cxStyleHidden: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      TextColor = clWhite
    end
    object cxStyleNormal: TcxStyle
      AssignedValues = [svFont, svTextColor]
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      TextColor = clHotLight
    end
    object cxStylePreOrder: TcxStyle
      AssignedValues = [svFont]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsItalic]
    end
    object cxStyleBold: TcxStyle
      AssignedValues = [svFont]
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clHotLight
      Font.Height = -12
      Font.Name = 'Segoe UI Semibold'
      Font.Style = [fsBold]
    end
    object cxStyleNoCurrency: TcxStyle
      AssignedValues = [svColor, svFont]
      Color = clRed
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
    end
  end
  object IBCQueryCatalog: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'select * from GET_GOODS_PATH(:goodsid)')
    Left = 360
    Top = 328
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'goodsid'
        Value = nil
      end>
  end
  object IBCDataSourceCatalog: TIBCDataSource
    DataSet = IBCQueryCatalog
    Left = 360
    Top = 272
  end
  object IBCQueryCustomerInfo: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'select * from ts_cust_info where customerid = :customerid')
    MasterFields = 'CUSTOMERID'
    DetailFields = 'CUSTOMERID'
    MasterSource = IBCDataSourceForeign
    Left = 376
    Top = 432
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'customerid'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'CUSTOMERID'
        Value = nil
      end>
  end
  object IBCDataSourceCustomerInfo: TIBCDataSource
    DataSet = IBCQueryCustomerInfo
    Left = 531
    Top = 434
  end
end
