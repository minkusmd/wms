object frmAddNewGoodsDlg: TfrmAddNewGoodsDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Alege mapa pentru adaugarea produselor'
  ClientHeight = 672
  ClientWidth = 1020
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 139
    Height = 15
    Caption = 'Selectati manual o mapa...'
  end
  object Label2: TLabel
    Left = 599
    Top = 243
    Width = 175
    Height = 15
    Caption = 'Lista produselor din Web Catalog'
  end
  object Label3: TLabel
    Left = 8
    Top = 323
    Width = 137
    Height = 15
    Caption = 'Lista produselor din Mapa'
  end
  object Label4: TLabel
    Left = 599
    Top = 67
    Width = 63
    Height = 15
    Caption = 'Webcatalog'
  end
  object Label5: TLabel
    Left = 8
    Top = 67
    Width = 116
    Height = 15
    Caption = 'Nomenclator produse'
  end
  object cxGrid1: TcxGrid
    AlignWithMargins = True
    Left = 8
    Top = 88
    Width = 577
    Height = 229
    TabOrder = 1
    object cxGrid_Folders: TcxGridDBTableView
      OnKeyDown = cxGrid_FoldersKeyDown
      Navigator.Buttons.CustomButtons = <>
      FindPanel.DisplayMode = fpdmAlways
      ScrollbarAnnotations.CustomAnnotations = <>
      DataController.DataSource = IBCDataSourceGoodsFolders
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.IncSearch = True
      OptionsBehavior.ImmediateEditor = False
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      object cxGrid_FoldersColumn1: TcxGridDBColumn
        Caption = 'ID'
        DataBinding.FieldName = 'PARENTID'
        DataBinding.IsNullValueType = True
        HeaderAlignmentHorz = taCenter
        Width = 65
      end
      object cxGrid_FoldersColumn2: TcxGridDBColumn
        Caption = 'Folder Name'
        DataBinding.FieldName = 'TITLE'
        DataBinding.IsNullValueType = True
        HeaderAlignmentHorz = taCenter
        Width = 394
      end
      object cxGrid_FoldersColumn3: TcxGridDBColumn
        Caption = 'Cnt'
        DataBinding.FieldName = 'GOODS_CNT'
        DataBinding.IsNullValueType = True
        HeaderAlignmentHorz = taCenter
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid_Folders
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 631
    Width = 1020
    Height = 41
    Align = alBottom
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    ShowCaption = False
    TabOrder = 5
    object cxButton1: TcxButton
      Left = 712
      Top = 9
      Width = 90
      Height = 29
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
    object cxButton2: TcxButton
      Left = 808
      Top = 9
      Width = 90
      Height = 29
      Cancel = True
      Caption = 'Renunta'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object cxWebCatalogTree: TcxDBTreeList
    Left = 599
    Top = 88
    Width = 413
    Height = 153
    Bands = <
      item
      end>
    DataController.DataSource = IBCDataSourceWebCatalog
    DataController.ParentField = 'PARENTID'
    DataController.KeyField = 'CATALOGID'
    Navigator.Buttons.CustomButtons = <>
    OptionsData.CancelOnExit = False
    OptionsData.Editing = False
    OptionsData.Deleting = False
    OptionsView.ColumnAutoWidth = True
    OptionsView.Indicator = True
    RootValue = -1
    ScrollbarAnnotations.CustomAnnotations = <>
    TabOrder = 2
    OnFocusedNodeChanged = cxWebCatalogTreeFocusedNodeChanged
    object cxWebCatalogTreecxDBTreeListColumn1: TcxDBTreeListColumn
      Caption.AlignHorz = taCenter
      Caption.Text = 'WCID'
      DataBinding.FieldName = 'CATALOGID'
      Width = 55
      Position.ColIndex = 1
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
    end
    object cxWebCatalogTreecxDBTreeListColumn2: TcxDBTreeListColumn
      Caption.AlignHorz = taCenter
      Caption.Text = 'Denumirea web catalog'
      DataBinding.FieldName = 'TITLE'
      Width = 454
      Position.ColIndex = 0
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
    end
  end
  object cxGrid2: TcxGrid
    Left = 8
    Top = 344
    Width = 577
    Height = 252
    TabOrder = 3
    object cxGridGoods: TcxGridDBTableView
      OnKeyDown = cxGridGoodsKeyDown
      Navigator.Buttons.CustomButtons = <>
      ScrollbarAnnotations.CustomAnnotations = <>
      DataController.DataModeController.GridModeBufferCount = 50
      DataController.DataSource = IBCDataSourceGoods
      DataController.KeyFieldNames = 'GOODSID'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.IncSearch = True
      OptionsBehavior.ImmediateEditor = False
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      object cxGridGoodsColumn1: TcxGridDBColumn
        Caption = 'Cod'
        DataBinding.FieldName = 'GOODSID'
        DataBinding.IsNullValueType = True
        HeaderAlignmentHorz = taCenter
        Width = 59
      end
      object cxGridGoodsWEBTOODSTITLE: TcxGridDBColumn
        Caption = 'Category'
        DataBinding.FieldName = 'WEBGOODSTYPE_TITLE'
        DataBinding.IsNullValueType = True
        HeaderAlignmentHorz = taCenter
        Width = 100
      end
      object cxGridGoodsColumn2: TcxGridDBColumn
        Caption = 'Produs'
        DataBinding.FieldName = 'TITLE'
        DataBinding.IsNullValueType = True
        HeaderAlignmentHorz = taCenter
        Width = 373
      end
      object cxGridGoodsColumn3: TcxGridDBColumn
        Caption = 'Pret'
        DataBinding.FieldName = 'PRICE1_LEI'
        DataBinding.IsNullValueType = True
        HeaderAlignmentHorz = taCenter
        Width = 60
      end
      object cxGridGoodsColumn4: TcxGridDBColumn
        Caption = 'FP'
        DataBinding.FieldName = 'FLG_IN_PRICE'
        DataBinding.IsNullValueType = True
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.NullStyle = nssInactive
        Properties.ValueChecked = '1'
        Properties.ValueUnchecked = '0'
        HeaderAlignmentHorz = taCenter
        Width = 29
      end
      object cxGridGoodsWEBGOODSTITLERU: TcxGridDBColumn
        Caption = 'Category Ru'
        DataBinding.FieldName = 'WEBGOODSTYPE_TITLE_RU'
        DataBinding.IsNullValueType = True
        HeaderAlignmentHorz = taCenter
        Width = 100
      end
    end
    object cxGrid2Level1: TcxGridLevel
      GridView = cxGridGoods
    end
  end
  object beGoodsFolder: TcxButtonEdit
    Left = 8
    Top = 29
    Properties.Buttons = <
      item
        Default = True
        Kind = bkEllipsis
      end>
    Properties.OnButtonClick = SWNButtonEdit1PropertiesButtonClick
    TabOrder = 0
    Text = 'beGoodsFolder'
    Width = 577
  end
  object cxGrid3: TcxGrid
    Left = 599
    Top = 264
    Width = 413
    Height = 332
    TabOrder = 4
    object cxGridDBTableView1: TcxGridDBTableView
      OnKeyDown = cxGridDBTableView1KeyDown
      Navigator.Buttons.CustomButtons = <>
      ScrollbarAnnotations.CustomAnnotations = <>
      DataController.DataModeController.GridModeBufferCount = 50
      DataController.DataSource = IBCDataSourceWebCatalogGoods
      DataController.KeyFieldNames = 'GOODSID'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.IncSearch = True
      OptionsBehavior.ImmediateEditor = False
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      object cxGridDBColumn1: TcxGridDBColumn
        Caption = 'Cod'
        DataBinding.FieldName = 'GOODSID'
        DataBinding.IsNullValueType = True
        HeaderAlignmentHorz = taCenter
      end
      object cxGridDBColumn2: TcxGridDBColumn
        Caption = 'Produs'
        DataBinding.FieldName = 'TITLE'
        DataBinding.IsNullValueType = True
        HeaderAlignmentHorz = taCenter
        Width = 314
      end
      object cxGridDBColumn3: TcxGridDBColumn
        Caption = 'Pret'
        DataBinding.FieldName = 'PRICE1_LEI'
        DataBinding.IsNullValueType = True
        HeaderAlignmentHorz = taCenter
      end
      object cxGridDBColumn4: TcxGridDBColumn
        Caption = 'FP'
        DataBinding.FieldName = 'FLG_IN_PRICE'
        DataBinding.IsNullValueType = True
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.NullStyle = nssInactive
        Properties.ValueChecked = '1'
        Properties.ValueUnchecked = '0'
        HeaderAlignmentHorz = taCenter
      end
    end
    object cxGridLevel1: TcxGridLevel
      GridView = cxGridDBTableView1
    end
  end
  object IBCQueryGoodsFolders: TIBCQuery
    SQL.Strings = (
      
        'select goodstypeid, parentid, pparentid, title, (select count(*)' +
        ' from ts_goods gp where gp.parentid = z.parentid and get_flg_in_' +
        'price(gp.goodsid) = 1) goods_cnt from'
      '(select'
      
        '    distinct gt.goodstypeid, g.parentid, gg.parentid pparentid, ' +
        'gg.title'
      'from ts_goods g'
      
        'join ts_goods gg on (gg.goodsid = g.parentid) and (g.flg_folder ' +
        '= 0)'
      
        'join TS_GOODS_TYPE gt on gt.goodstypeid = g.webgoodstype_id &m_w' +
        'ebgoodstypeid) z'
      'group by 1,2,3,4'
      'order by 5 desc')
    Options.DetailDelay = 500
    Left = 95
    Top = 165
    MacroData = <
      item
        Name = 'm_webgoodstypeid'
      end>
  end
  object IBCDataSourceGoodsFolders: TIBCDataSource
    DataSet = IBCQueryGoodsFolders
    OnDataChange = IBCDataSourceGoodsFoldersDataChange
    Left = 95
    Top = 106
  end
  object IBCQueryWebCatalog: TIBCQuery
    SQL.Strings = (
      'select distinct * from GET_CATALOG_PATH(:FOLDERID)'
      '')
    Options.DetailDelay = 700
    Left = 770
    Top = 155
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'FOLDERID'
        Value = nil
      end>
  end
  object IBCDataSourceWebCatalog: TIBCDataSource
    DataSet = IBCQueryWebCatalog
    OnDataChange = IBCDataSourceWebCatalogDataChange
    Left = 773
    Top = 101
  end
  object IBCQueryGoods: TIBCQuery
    KeyFields = 'goodsid'
    SQL.Strings = (
      
        'select goodsid, title, g.webgoodstype_title, g.webgoodstype_titl' +
        'e_ru,'
      '       (select price_mdl'
      
        '        from get_goods_price(goodsid, 1, 498)) price1_lei, get_f' +
        'lg_in_price(goodsid) flg_in_price'
      'from vw_ts_goods g'
      'where parentid = :parentid'
      'order by flg_in_price desc, title  ')
    MasterSource = IBCDataSourceGoodsFolders
    Left = 134
    Top = 411
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'parentid'
        Value = nil
      end>
  end
  object IBCDataSourceGoods: TIBCDataSource
    DataSet = IBCQueryGoods
    Left = 132
    Top = 352
  end
  object IBCQueryWebCatalogGoods: TIBCQuery
    KeyFields = 'GOODSID'
    SQL.Strings = (
      
        'select g.webgoodstype_id, gt.title web_goodstype_name, g.goodsid' +
        ', g.title,'
      
        '(select price_mdl from get_goods_price(g.goodsid, 1, 498)) price' +
        '_lei,'
      'get_flg_in_price(g.goodsid) flg_in_price,'
      'ci.catalogid'
      'from tweb_catalog_items ci'
      
        'join tweb_catalog c on c.catalogid = ci.catalogid --and ci.catal' +
        'ogid = :CATALOGID'
      'join ts_goods g on g.parentid = ci.goodsparentid'
      'join ts_goods_type gt on gt.goodstypeid = g.webgoodstype_id'
      'order by flg_in_price desc,  price_lei')
    MasterFields = 'CATALOGID'
    DetailFields = 'CATALOGID'
    MasterSource = IBCDataSourceWebCatalog
    Left = 738
    Top = 408
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CATALOGID'
        Value = nil
      end>
  end
  object IBCDataSourceWebCatalogGoods: TIBCDataSource
    DataSet = IBCQueryWebCatalogGoods
    Left = 737
    Top = 340
  end
end
