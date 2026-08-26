object frmGoodsFromSupplierDlg: TfrmGoodsFromSupplierDlg
  Left = 0
  Top = 0
  Caption = 'Produsele clientului'
  ClientHeight = 622
  ClientWidth = 1034
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnClose = FormClose
  OnShow = FormShow
  TextHeight = 15
  object RzDialogButtons1: TRzDialogButtons
    Left = 0
    Top = 586
    Width = 1034
    CaptionOk = 'Inchide'
    ShowCancelButton = False
    TabOrder = 1
    ExplicitLeft = -3
    ExplicitTop = 408
    ExplicitWidth = 820
  end
  object cxGrid1: TcxGrid
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 1028
    Height = 580
    Align = alClient
    TabOrder = 0
    ExplicitLeft = 8
    ExplicitTop = 0
    object cxGrid1DBTableView1: TcxGridDBTableView
      OnKeyDown = cxGrid1DBTableView1KeyDown
      Navigator.Buttons.CustomButtons = <>
      FindPanel.DisplayMode = fpdmAlways
      FindPanel.UseExtendedSyntax = True
      ScrollbarAnnotations.CustomAnnotations = <>
      DataController.DataModeController.GridModeBufferCount = 100
      DataController.DataSource = dsSupplierGoods
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
        Width = 42
      end
      object cxGrid1DBTableView1Column2: TcxGridDBColumn
        Caption = 'Categorie produs'
        DataBinding.FieldName = 'WEBGOODSTYPE_TITLE'
        Width = 194
      end
      object cxGrid1DBTableView1TITLE: TcxGridDBColumn
        Caption = 'Produs'
        DataBinding.FieldName = 'TITLE'
        Width = 644
      end
      object cxGrid1DBTableView1PRICE1_LEI: TcxGridDBColumn
        Caption = 'Pret, MDL'
        DataBinding.FieldName = 'PRICE1_LEI'
        Width = 105
      end
      object cxGrid1DBTableView1Column1: TcxGridDBColumn
        Caption = 'P'
        DataBinding.FieldName = 'FLG_IN_PRICE'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.NullStyle = nssUnchecked
        Properties.ValueChecked = '1'
        Properties.ValueUnchecked = '0'
        HeaderAlignmentHorz = taCenter
        Width = 41
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
    end
  end
  object qSupplierGoods: TIBCQuery
    KeyFields = 'goodsid'
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'select g.* from vw_ts_goods g'
      
        'join ts_goods_foreign gf on gf.customerid = :supplierid and g.go' +
        'odsid = gf.goodsid'
      'order by g.flg_in_price desc, g.webgoodstype_title, g.title')
    Left = 225
    Top = 168
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'supplierid'
        Value = nil
      end>
  end
  object dsSupplierGoods: TIBCDataSource
    DataSet = qSupplierGoods
    Left = 221
    Top = 99
  end
end
