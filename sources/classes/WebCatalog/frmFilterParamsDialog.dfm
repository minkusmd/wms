object frmFilterParamsDlg: TfrmFilterParamsDlg
  Left = 0
  Top = 0
  Caption = 'Gestionarea parametrilor filtrului'
  ClientHeight = 343
  ClientWidth = 645
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object DialogTitle1: TDialogTitle
    Left = 0
    Top = 0
    Width = 645
    Height = 64
    Title = 'Gestionarea parametrilor filtrului'
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
    ImageIndex = 5
  end
  object Panel2: TPanel
    Left = 0
    Top = 64
    Width = 645
    Height = 279
    Align = alClient
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    object cxGridGoods: TcxGrid
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 639
      Height = 237
      Align = alClient
      TabOrder = 0
      object tvGoods: TcxGridDBTableView
        OnKeyDown = tvGoodsKeyDown
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        DataController.DataSource = IBCDataSourceGoods
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
        object tvGoods_GOODSID: TcxGridDBColumn
          Caption = 'Cod'
          DataBinding.FieldName = 'GOODSID'
          DataBinding.IsNullValueType = True
          Width = 68
        end
        object tvGoods_GOODSNAME: TcxGridDBColumn
          Caption = 'Denumire'
          DataBinding.FieldName = 'TITLE'
          DataBinding.IsNullValueType = True
          Width = 384
        end
        object tvGoods_FLG_IN_PRICE: TcxGridDBColumn
          Caption = 'F'
          DataBinding.FieldName = 'FLG_IN_PRICE'
          DataBinding.IsNullValueType = True
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = '1'
          Properties.ValueUnchecked = '0'
          HeaderAlignmentHorz = taCenter
          Width = 24
        end
      end
      object cxGridGoodsLevel1: TcxGridLevel
        GridView = tvGoods
      end
    end
    object RzDialogButtons1: TRzDialogButtons
      Left = 0
      Top = 243
      Width = 645
      TabOrder = 1
    end
  end
  object IBCQueryFilterParams: TIBCQuery
    SQL.Strings = (
      'select * from ts_filter_params'
      'where filterid = :filterid')
    Left = 216
    Top = 112
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'filterid'
        Value = nil
      end>
  end
  object IBCDataSourceFilterParams: TIBCDataSource
    DataSet = IBCQueryFilterParams
    Left = 216
    Top = 64
  end
  object IBCQueryGoods: TIBCQuery
    SQL.Strings = (
      
        '/* select gd.goodsid, g.title goodsname, gd.filterparamid, g.FLG' +
        '_PRICE_FORCED from ts_goods_descriptions gd'
      'join SP_GET_TS_GOODS_M0(:dt, gd.goodsid) g on 1=1'
      'where'
      'filterid = :filterID */'
      ''
      
        'select G.goodsid,  G.title, GET_FLG_IN_PRICE(G.GOODSID) FLG_IN_P' +
        'RICE from ts_goods_descriptions gd'
      'JOIN TS_GOODS G ON G.GOODSID = GD.GOODSID'
      'join tweb_catalog c on c.catalogid = :CATALOGID'
      
        'JOIN tweb_catalog_items on tweb_catalog_items.catalogid = c.cata' +
        'logid AND tweb_catalog_items.goodsparentid = G.PARENTID'
      'where filterid = :FILTERID'
      'ORDER BY FLG_IN_PRICE DESC')
    MasterFields = 'FILTERPARAMID'
    DetailFields = 'FILTERPARAMID'
    Left = 824
    Top = 144
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CATALOGID'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'filterID'
        Value = nil
      end>
  end
  object IBCDataSourceGoods: TIBCDataSource
    DataSet = IBCQueryGoods
    Left = 824
    Top = 96
  end
end
