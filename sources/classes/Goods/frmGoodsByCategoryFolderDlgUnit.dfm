object frmGoodsByCategoryFolderDlg: TfrmGoodsByCategoryFolderDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Categorii produse in mapa'
  ClientHeight = 333
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
    Top = 297
    Width = 624
    TabOrder = 1
    ExplicitLeft = 228
    ExplicitTop = 222
    ExplicitWidth = 185
  end
  object cxGrid1: TcxGrid
    Left = 0
    Top = 0
    Width = 624
    Height = 297
    Align = alClient
    TabOrder = 0
    ExplicitTop = -6
    ExplicitHeight = 405
    object cxGrid1DBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      ScrollbarAnnotations.CustomAnnotations = <>
      DataController.DataSource = IBCDataSource
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
      object cxGrid1DBTableView1WEBGOODSTYPE_ID: TcxGridDBColumn
        Caption = 'ID'
        DataBinding.FieldName = 'WEBGOODSTYPE_ID'
      end
      object cxGrid1DBTableView1TITLE: TcxGridDBColumn
        Caption = 'Categorie'
        DataBinding.FieldName = 'TITLE'
        Width = 400
      end
      object cxGrid1DBTableView1CNT: TcxGridDBColumn
        Caption = 'Cantitate'
        DataBinding.FieldName = 'CNT'
        Width = 64
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
    end
  end
  object IBCQuery: TIBCQuery
    SQL.Strings = (
      
        'select g.webgoodstype_id, gt.title, count(goodsid) cnt from ts_g' +
        'oods g'
      'join ts_goods_type gt on gt.goodstypeid=g.webgoodstype_id'
      'where g.parentid = :parentid'
      'group by 1,2'
      'order by 3 desc')
    Active = True
    Left = 344
    Top = 124
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'parentid'
        Value = nil
      end>
  end
  object IBCDataSource: TIBCDataSource
    DataSet = IBCQuery
    Left = 341
    Top = 64
  end
end
