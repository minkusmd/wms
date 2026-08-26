object frmRelatedProductsDlg: TfrmRelatedProductsDlg
  Left = 0
  Top = 0
  Caption = 'Produse inrudite / '#1089#1086#1087#1091#1090#1089#1090#1074#1091#1102#1097#1080#1077' '#1090#1086#1074#1072#1088#1099
  ClientHeight = 587
  ClientWidth = 1344
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  PixelsPerInch = 96
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 546
    Width = 1344
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 5
    ExplicitTop = 265
    ExplicitWidth = 654
    DesignSize = (
      1344
      41)
    object cxButton1: TcxButton
      Left = 1143
      Top = 6
      Width = 90
      Height = 29
      Anchors = [akRight, akBottom]
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
      ExplicitLeft = 453
    end
    object cxButton2: TcxButton
      Left = 1239
      Top = 6
      Width = 90
      Height = 29
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = 'Renunta'
      ModalResult = 2
      TabOrder = 1
      ExplicitLeft = 549
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 1344
    Height = 546
    Align = alClient
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    ExplicitTop = 28
    ExplicitWidth = 654
    ExplicitHeight = 237
    object cxGrid1: TcxGrid
      Left = 0
      Top = 64
      Width = 593
      Height = 482
      Align = alLeft
      TabOrder = 0
      ExplicitTop = 58
      object cxGrid1DBTableView1: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        DataController.DataSource = IBCDataSourceRelatedGoods
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
        object cxGrid1DBTableView1RELATED_GOODSID: TcxGridDBColumn
          Caption = 'Cod'
          DataBinding.FieldName = 'RELATED_GOODSID'
        end
        object cxGrid1DBTableView1RELATED_GOODS_NAME: TcxGridDBColumn
          Caption = 'Produs'
          DataBinding.FieldName = 'RELATED_GOODS_NAME'
          Width = 700
        end
        object cxGrid1DBTableView1FLG_IN_PRICE: TcxGridDBColumn
          Caption = 'F'
          DataBinding.FieldName = 'FLG_IN_PRICE'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.Alignment = taRightJustify
          Properties.NullStyle = nssUnchecked
          Properties.ValueChecked = '1'
          Properties.ValueUnchecked = '0'
          HeaderAlignmentHorz = taCenter
          MinWidth = 24
          Options.HorzSizing = False
          Width = 24
        end
        object cxGrid1DBTableView1PRICE_MDL: TcxGridDBColumn
          Caption = 'Pret'
          DataBinding.FieldName = 'PRICE_MDL'
          HeaderAlignmentHorz = taCenter
          MinWidth = 80
          Options.HorzSizing = False
          Width = 80
        end
      end
      object cxGrid1Level1: TcxGridLevel
        GridView = cxGrid1DBTableView1
      end
    end
    object DialogTitle1: TDialogTitle
      Left = 0
      Top = 0
      Width = 1344
      Height = 64
      Text = ''
      FontTitle.Charset = DEFAULT_CHARSET
      FontTitle.Color = clWindowText
      FontTitle.Height = -15
      FontTitle.Name = 'Segoe UI'
      FontTitle.Style = [fsBold]
      FontText.Charset = DEFAULT_CHARSET
      FontText.Color = clWindowText
      FontText.Height = -12
      FontText.Name = 'Segoe UI'
      FontText.Style = []
      ExplicitLeft = 328
      ExplicitTop = 104
      ExplicitWidth = 0
    end
    object cxGrid2: TcxGrid
      Left = 593
      Top = 64
      Width = 751
      Height = 482
      Align = alClient
      TabOrder = 2
      ExplicitLeft = 6
      ExplicitTop = 33
      ExplicitWidth = 644
      ExplicitHeight = 460
      object cxGridDBTableView1: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        DataController.DataSource = IBCDataSourceGoods
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
        object cxGridDBTableView1_GOODSID: TcxGridDBColumn
          Caption = 'Cod'
          DataBinding.FieldName = 'GOODSID'
          Width = 57
        end
        object cxGridDBTableView1_TITLE: TcxGridDBColumn
          Caption = 'Denumire'
          DataBinding.FieldName = 'TITLE'
          Width = 503
        end
        object cxGridDBTableView1_PRICE: TcxGridDBColumn
          Caption = 'Pret'
          DataBinding.FieldName = 'PRICE4'
          Width = 68
        end
        object cxGridDBTableView1_FLG_IN_PRICE: TcxGridDBColumn
          Caption = '...'
          DataBinding.FieldName = 'FLG_IN_PRICE'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = '1'
          Properties.ValueGrayed = 0
          Properties.ValueUnchecked = '0'
          MinWidth = 24
          Options.HorzSizing = False
          Width = 24
        end
      end
      object cxGridLevel1: TcxGridLevel
        GridView = cxGridDBTableView1
      end
    end
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
    Left = 296
    Top = 176
    PixelsPerInch = 96
    object bbNew: TdxBarButton
      Caption = 'Nou'
      Category = 0
      Hint = 'Nou'
      Visible = ivAlways
      ImageIndex = 90
      ShortCut = 45
    end
    object bbDelete: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 92
      ShortCut = 16430
    end
  end
  object IBCQueryRelatedGoods: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      
        'select distinct g.goodsid relatedgoodsid, g.webgoodstype_id, g.w' +
        'ebgoodstype_title, g.title, g.price1_lei, g.flg_in_price from vw' +
        '_ts_goods g'
      'join ts_related_goods rg on g.goodsid = rg.goodsid'
      
        'join ts_related_goods z on z.goodsid = :goodsid and z.related_ke' +
        'y = rg.related_key'
      'order by  g.flg_in_price desc, g.webgoodstype_title, g.title')
    Left = 88
    Top = 142
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'goodsid'
        Value = nil
      end>
  end
  object IBCDataSourceRelatedGoods: TIBCDataSource
    DataSet = IBCQueryRelatedGoods
    Left = 88
    Top = 86
  end
  object IBCQueryGoods: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'select * from ('
      'select '
      '  rg.related_key f1,'
      '  g.goodsid, '
      '  g.title,'
      '  get_flg_in_price(g.goodsid) flg_in_price,'
      
        '  (select price_mdl from get_goods_price(g.goodsid, 4, 498)) pri' +
        'ce4'
      'from ts_goods g'
      'join ts_related_goods rg on rg.goodsid=g.goodsid'
      ')')
    MasterFields = 'RELATED_KEY'
    DetailFields = 'F1'
    Left = 976
    Top = 248
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'RELATED_KEY'
        Value = nil
      end>
  end
  object IBCDataSourceGoods: TIBCDataSource
    DataSet = IBCQueryGoods
    Left = 980
    Top = 200
  end
end
