object frmCategorySuppliersDlg: TfrmCategorySuppliersDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Furnizori din categoria de produse'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object RzDialogButtons1: TRzDialogButtons
    Left = 0
    Top = 405
    Width = 624
    TabOrder = 6
    ExplicitLeft = 232
    ExplicitTop = 224
    ExplicitWidth = 185
  end
  object cxGrid1: TcxGrid
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 618
    Height = 246
    Align = alTop
    TabOrder = 0
    object cxGrid1DBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      ScrollbarAnnotations.CustomAnnotations = <>
      DataController.DataSource = IBCDataSourceSupplierCategory
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
      OptionsView.GroupByBox = False
      object cxGrid1DBTableView1CUSTOMERID: TcxGridDBColumn
        Caption = 'ID'
        DataBinding.FieldName = 'CUSTOMERID'
        DataBinding.IsNullValueType = True
      end
      object cxGrid1DBTableView1CUSTOMER_NAME: TcxGridDBColumn
        Caption = 'Nume'
        DataBinding.FieldName = 'displayname'
        DataBinding.IsNullValueType = True
        Width = 536
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
    end
  end
  object cxGrid2: TcxGrid
    Left = 0
    Top = 280
    Width = 624
    Height = 125
    Align = alClient
    TabOrder = 4
    ExplicitLeft = 192
    ExplicitTop = 144
    ExplicitWidth = 250
    ExplicitHeight = 200
    object cxGrid2DBTableView1: TcxGridDBTableView
      OnKeyDown = cxGrid2DBTableView1KeyDown
      Navigator.Buttons.CustomButtons = <>
      ScrollbarAnnotations.CustomAnnotations = <>
      DataController.DataSource = IBCDataSourceSupplierGoods
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
      OptionsView.GroupByBox = False
      object cxGrid2DBTableView1GOODSID: TcxGridDBColumn
        Caption = 'Cod'
        DataBinding.FieldName = 'GOODSID'
      end
      object cxGrid2DBTableView1TITLE: TcxGridDBColumn
        Caption = 'Denumire'
        DataBinding.FieldName = 'TITLE'
        Width = 424
      end
      object cxGrid2DBTableView1PRICE: TcxGridDBColumn
        Caption = 'Pret'
        DataBinding.FieldName = 'PRICE'
        Width = 90
      end
      object cxGrid2DBTableView1FLG_IN_PRICE: TcxGridDBColumn
        Caption = 'F'
        DataBinding.FieldName = 'FLG_IN_PRICE'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.Alignment = taRightJustify
        Properties.NullStyle = nssUnchecked
        Properties.ValueChecked = '1'
        Width = 24
      end
    end
    object cxGrid2Level1: TcxGridLevel
      GridView = cxGrid2DBTableView1
    end
  end
  object dxBarDockControl1: TdxBarDockControl
    Left = 0
    Top = 252
    Width = 624
    Height = 28
    Align = dalTop
    BarManager = dxBarManager1
  end
  object IBCQuerySupplierCategory: TIBCQuery
    SQL.Strings = (
      'select distinct gf.customerid, c.displayname from ts_goods g'
      'join ts_goods_foreign gf on gf.goodsid = g.goodsid'
      'join ts_customer c on c.customerid = gf.customerid'
      'where g.webgoodstype_id=:webgoodstypeid')
    Left = 64
    Top = 112
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'webgoodstypeid'
        Value = nil
      end>
  end
  object IBCDataSourceSupplierCategory: TIBCDataSource
    DataSet = IBCQuerySupplierCategory
    Left = 64
    Top = 48
  end
  object IBCQuerySupplierGoods: TIBCQuery
    SQL.Strings = (
      
        'select gf.goodsid, g.title, convert_amount(gp.price1, gp.currenc' +
        'y1id, 498) price, get_flg_in_price(gp.goodsid) flg_in_price from' +
        ' ts_goods_foreign gf'
      'join ts_goods_price gp on gp.goodsid = gf.goodsid'
      
        'join ts_goods g on g.goodsid = gf.goodsid and gf.customerid = :C' +
        'USTOMERID and g.webgoodstype_id = :WEBGOODSTYPEID')
    Active = True
    Left = 72
    Top = 352
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CUSTOMERID'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'WEBGOODSTYPEID'
        Value = nil
      end>
  end
  object IBCDataSourceSupplierGoods: TIBCDataSource
    DataSet = IBCQuerySupplierGoods
    Left = 72
    Top = 296
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
    Left = 320
    Top = 136
    PixelsPerInch = 96
    object dxBarManager1Bar1: TdxBar
      Caption = 'Custom 1'
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 652
      FloatTop = 2
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbRefresh'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object bbRefresh: TdxBarButton
      Caption = 'Actualizeaza'
      Category = 0
      Hint = 'Actualizeaza'
      Visible = ivAlways
      ImageIndex = 36
      ShortCut = 116
      OnClick = bbRefreshClick
    end
  end
end
