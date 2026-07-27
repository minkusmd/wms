inherited frame74PriceList: Tframe74PriceList
  object cxGrid1: TcxGrid
    Left = 0
    Top = 0
    Width = 451
    Height = 200
    Align = alTop
    TabOrder = 0
    object cxGrid1DB_DOCS: TcxGridDBTableView
      OnKeyDown = cxGrid1DB_DOCSKeyDown
      Navigator.Buttons.CustomButtons = <>
      ScrollbarAnnotations.CustomAnnotations = <>
      DataController.DataSource = dmDB.IBCDataSourceDocs
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.ImmediateEditor = False
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.Indicator = True
      object cxGrid1DB_DOCS_DOCID: TcxGridDBColumn
        Caption = 'cod'
        DataBinding.FieldName = 'DOCID'
        Width = 79
      end
      object cxGrid1DB_DOCS_DATE: TcxGridDBColumn
        Caption = 'data'
        DataBinding.FieldName = 'DATA'
        Width = 107
      end
      object cxGrid1DB_DOCS_CT_NAME: TcxGridDBColumn
        Caption = 'concurent'
        DataBinding.FieldName = 'CT_NAME'
        Width = 577
      end
      object cxGrid1DB_DOCS_CREATEDBY_NAME: TcxGridDBColumn
        Caption = 'utilizator'
        DataBinding.FieldName = 'CREATED_BY_NAME'
        Width = 360
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DB_DOCS
    end
  end
  object cxSplitter1: TcxSplitter
    Left = 0
    Top = 200
    Width = 451
    Height = 8
    AlignSplitter = salTop
  end
  object cxGrid2: TcxGrid
    Left = 0
    Top = 236
    Width = 451
    Height = 69
    Align = alClient
    TabOrder = 3
    object cxGrid2DB_ConcurentsURL: TcxGridDBTableView
      OnKeyDown = cxGrid2DB_ConcurentsURLKeyDown
      Navigator.Buttons.CustomButtons = <>
      ScrollbarAnnotations.CustomAnnotations = <>
      DataController.DataSource = IBCDataSourceGoods
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <
        item
          Format = 'Total Records: (0)'
          Kind = skCount
          Column = cxGrid2DB_Concurents_MODEL
        end>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.AlwaysShowEditor = True
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.Footer = True
      OptionsView.GroupByBox = False
      OptionsView.Indicator = True
      object cxGrid2DB_Concurents_GOODSID: TcxGridDBColumn
        Caption = 'cod'
        DataBinding.FieldName = 'GOODSID'
        Options.Editing = False
      end
      object cxGrid2DB_Concurents_MODEL: TcxGridDBColumn
        Caption = 'model'
        DataBinding.FieldName = 'MODEL'
        Width = 150
      end
      object cxGrid2DB_Concurents_GOODS_NAME: TcxGridDBColumn
        Caption = 'produs'
        DataBinding.FieldName = 'GOODS_NAME'
        Options.Editing = False
        Width = 461
      end
      object cxGrid2DB_Concurents_URL: TcxGridDBColumn
        Caption = 'url'
        DataBinding.FieldName = 'URL'
        PropertiesClassName = 'TcxTextEditProperties'
        Width = 400
      end
      object cxGrid2DB_Concurents_PRICE4: TcxGridDBColumn
        Caption = 'pret 4'
        DataBinding.FieldName = 'PRICE4LEI'
        Options.Editing = False
      end
      object cxGrid2DB_Concurents_PRICE7: TcxGridDBColumn
        Caption = 'pret 7'
        DataBinding.FieldName = 'PRICE7'
        Options.Editing = False
      end
      object cxGrid2DB_Concurents_Diff: TcxGridDBColumn
        Caption = 'diff'
        DataBinding.FieldName = 'DIFF_PRICE'
        Options.Editing = False
        Styles.OnGetContentStyle = cxGrid2DB_ConcurentsURLColumn1StylesGetContentStyle
      end
      object cxGrid2DB_Concurents_PRICE_CONCURENT: TcxGridDBColumn
        Caption = 'pret conc'
        DataBinding.FieldName = 'PRICE_CONCURENT'
        Options.Editing = False
      end
      object cxGrid2DB_ConcurentsURLColumn2: TcxGridDBColumn
        Caption = 'price_c $'
        DataBinding.FieldName = 'PRICE_CONCURENT_USD'
        PropertiesClassName = 'TcxCalcEditProperties'
        Properties.DisplayFormat = '0.00'
        Options.Editing = False
      end
    end
    object cxGrid2Level1: TcxGridLevel
      GridView = cxGrid2DB_ConcurentsURL
    end
  end
  object dxBarDockControl1: TdxBarDockControl
    Left = 0
    Top = 208
    Width = 451
    Height = 28
    Align = dalTop
    BarManager = dxBarManager1
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
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 552
    Top = 312
    PixelsPerInch = 96
    object dxBarManager1Bar1: TdxBar
      Caption = 'Custom 1'
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1135
      FloatTop = 0
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarSubItem1'
        end
        item
          Visible = True
          ItemName = 'dxBarButton2'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbDeleteAll'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarSubItem1: TdxBarSubItem
      Caption = 'Instrumente'
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbImportFromExcel'
        end
        item
          Visible = True
          ItemName = 'bbImportFromCatalog'
        end>
    end
    object bbImportFromExcel: TdxBarButton
      Caption = 'Importa din Excel'
      Category = 0
      Hint = 'Importa din Excel'
      Visible = ivAlways
      OnClick = bbImportFromExcelClick
    end
    object bbImportFromCatalog: TdxBarButton
      Caption = 'Importa din nomeclator'
      Category = 0
      Hint = 'Importa din nomeclator'
      Visible = ivAlways
      OnClick = bbImportFromCatalogClick
    end
    object bbDeleteAll: TdxBarButton
      Caption = 'Sterge tot'
      Category = 0
      Hint = 'Sterge tot'
      Visible = ivAlways
      OnClick = bbDeleteAllClick
    end
    object dxBarButton2: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      OnClick = dxBarButton2Click
    end
  end
  object IBCQueryGoods: TIBCQuery
    SQLInsert.Strings = (
      'INSERT INTO VW_TDB_DOCS_GOODS_CONCURENTS'
      
        '  (DOCID, GOODSID, GOODS_NAME, URL, PRICE4LEI, PRICE7, PRICE_CON' +
        'CURENT)'
      'VALUES'
      
        '  (:DOCID, :GOODSID, :GOODS_NAME, :URL, :PRICE4LEI, :PRICE7, :PR' +
        'ICE_CONCURENT)')
    SQLDelete.Strings = (
      'DELETE FROM VW_TDB_DOCS_GOODS_CONCURENTS'
      'WHERE'
      '  DOCID = :Old_DOCID AND GOODSID = :Old_GOODSID')
    SQLUpdate.Strings = (
      'UPDATE VW_TDB_DOCS_GOODS_CONCURENTS'
      'SET'
      
        '  DOCID = :DOCID, GOODSID = :GOODSID, GOODS_NAME = :GOODS_NAME, ' +
        'URL = :URL, PRICE4LEI = :PRICE4LEI, PRICE7 = :PRICE7, PRICE_CONC' +
        'URENT = :PRICE_CONCURENT'
      'WHERE'
      '  DOCID = :Old_DOCID AND GOODSID = :Old_GOODSID')
    SQLRefresh.Strings = (
      
        'SELECT DOCID, GOODSID, GOODS_NAME, URL, PRICE4LEI, PRICE7, PRICE' +
        '_CONCURENT FROM VW_TDB_DOCS_GOODS_CONCURENTS'
      'WHERE'
      '  DOCID = :DOCID AND GOODSID = :GOODSID')
    SQLLock.Strings = (
      'SELECT NULL FROM TDB_DOCS_GOODS_CONCURENTS'
      'WHERE'
      'DOCID = :Old_DOCID AND GOODSID = :Old_GOODSID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM VW_TDB_DOCS_GOODS_CONCURENTS'
      ''
      ') q')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'select * from VW_TDB_DOCS_GOODS_CONCURENTS where docid = :docid')
    MasterFields = 'DOCID'
    DetailFields = 'DOCID'
    MasterSource = dmDB.IBCDataSourceDocs
    Left = 368
    Top = 312
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'docid'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'DOCID'
        Value = nil
      end>
  end
  object IBCDataSourceGoods: TIBCDataSource
    DataSet = IBCQueryGoods
    Left = 248
    Top = 312
  end
end
