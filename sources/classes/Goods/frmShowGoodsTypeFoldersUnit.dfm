object frmShowGoodsTypeFoldersDlg: TfrmShowGoodsTypeFoldersDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Mapele unde se afla produse cu acelas tip de produse'
  ClientHeight = 593
  ClientWidth = 826
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnShow = FormShow
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 552
    Width = 826
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitLeft = 232
    ExplicitTop = 224
    ExplicitWidth = 185
    object Button1: TButton
      Left = 360
      Top = 11
      Width = 90
      Height = 29
      Cancel = True
      Caption = 'Inchide'
      ModalResult = 8
      TabOrder = 0
    end
  end
  object cxGrid1: TcxGrid
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 820
    Height = 214
    Align = alTop
    TabOrder = 1
    ExplicitWidth = 618
    object cxGrid1DBTableView1: TcxGridDBTableView
      OnKeyDown = cxGrid1DBTableView1KeyDown
      Navigator.Buttons.CustomButtons = <>
      ScrollbarAnnotations.CustomAnnotations = <>
      DataController.DataModeController.GridMode = True
      DataController.DataModeController.GridModeBufferCount = 30
      DataController.DataSource = IBCDataSource1
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
      object cxGrid1DBTableView1GOODSID: TcxGridDBColumn
        Caption = 'Cod'
        DataBinding.FieldName = 'GOODSID'
      end
      object cxGrid1DBTableView1TITLE: TcxGridDBColumn
        Caption = 'Mapa'
        DataBinding.FieldName = 'TITLE'
        Width = 664
      end
      object cxGrid1DBTableView1CNT_IN_PRICE: TcxGridDBColumn
        Caption = 'Cant'
        DataBinding.FieldName = 'CNT_IN_PRICE'
        Width = 47
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
    end
  end
  object cxGrid2: TcxGrid
    Left = -2
    Top = 223
    Width = 820
    Height = 323
    TabOrder = 2
    object cxGrid2DBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      ScrollbarAnnotations.CustomAnnotations = <>
      DataController.DataModeController.GridMode = True
      DataController.DataModeController.GridModeBufferCount = 30
      DataController.DataSource = IBCDataSource2
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.IncSearch = True
      OptionsBehavior.ImmediateEditor = False
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.Inserting = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      object cxGrid2DBTableView1Column1: TcxGridDBColumn
        Caption = 'Cod'
        DataBinding.FieldName = 'GOODSID'
      end
      object cxGrid2DBTableView1Column2: TcxGridDBColumn
        Caption = 'Produs'
        DataBinding.FieldName = 'TITLE'
        Width = 621
      end
      object cxGrid2DBTableView1Column3: TcxGridDBColumn
        Caption = 'Pret'
        DataBinding.FieldName = 'PRICE1'
        Width = 90
      end
      object cxGrid2DBTableView1Column4: TcxGridDBColumn
        Caption = 'P'
        DataBinding.FieldName = 'FLG_IN_PRICE'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.Alignment = taRightJustify
        Properties.NullStyle = nssUnchecked
        Properties.ValueChecked = '1'
        Properties.ValueUnchecked = '0'
        Width = 24
      end
    end
    object cxGrid2Level1: TcxGridLevel
      GridView = cxGrid2DBTableView1
    end
  end
  object IBCQuery1: TIBCQuery
    SQL.Strings = (
      'select goodsid, title, (select count(*)'
      '                 from ts_goods gg'
      '                 where gg.parentid = z.goodsid and'
      
        '                       get_flg_in_price(gg.goodsid) = 1) cnt_in_' +
        'price'
      ' from ('
      'select distinct gp.goodsid, gp.title,'
      '                (select z.breadcrumb'
      '                 from get_goods_path(gp.goodsid) z) path'
      'from ts_goods g'
      'join ts_goods gp on gp.goodsid = g.parentid'
      'where g.webgoodstype_id = :webgoodstype_id) z'
      'order by 3 desc')
    Options.DetailDelay = 500
    Left = 312
    Top = 128
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'webgoodstype_id'
        Value = nil
      end>
  end
  object IBCDataSource1: TIBCDataSource
    DataSet = IBCQuery1
    Left = 312
    Top = 64
  end
  object IBCQueryGoods: TIBCQuery
    SQL.Strings = (
      'SELECT * FROM VW_TS_GOODS')
    MasterFields = 'GOODSID'
    DetailFields = 'PARENTID'
    MasterSource = IBCDataSource1
    Active = True
    Left = 392
    Top = 392
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'GOODSID'
        Value = nil
      end>
  end
  object IBCDataSource2: TIBCDataSource
    DataSet = IBCQueryGoods
    Left = 392
    Top = 328
  end
end
