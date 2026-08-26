object frmNewGoodsCatalogDlg: TfrmNewGoodsCatalogDlg
  Left = 0
  Top = 0
  Caption = 'frmNewGoodsCatalogDlg'
  ClientHeight = 441
  ClientWidth = 1090
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object cxDBTreeList1: TcxDBTreeList
    Left = 0
    Top = 0
    Width = 354
    Height = 405
    Align = alLeft
    Bands = <
      item
      end>
    DataController.DataSource = IBCDataSourceGoodsFolders
    DataController.ParentField = 'PARENTID'
    DataController.KeyField = 'GOODSID'
    Navigator.Buttons.CustomButtons = <>
    OptionsBehavior.ImmediateEditor = False
    OptionsBehavior.CopyCaptionsToClipboard = False
    OptionsBehavior.IncSearch = True
    OptionsData.CancelOnExit = False
    OptionsData.Editing = False
    OptionsData.Deleting = False
    OptionsView.ColumnAutoWidth = True
    OptionsView.Headers = False
    RootValue = -1
    ScrollbarAnnotations.CustomAnnotations = <>
    TabOrder = 0
    object cxDBTreeList1cxDBTreeListColumn1: TcxDBTreeListColumn
      DataBinding.FieldName = 'TITLE'
      Width = 335
      Position.ColIndex = 0
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
    end
  end
  object RzDialogButtons1: TRzDialogButtons
    Left = 0
    Top = 405
    Width = 1090
    TabOrder = 2
  end
  object Panel1: TPanel
    Left = 354
    Top = 0
    Width = 736
    Height = 405
    Align = alClient
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    object cxGrid1: TcxGrid
      Left = 0
      Top = 0
      Width = 732
      Height = 401
      Align = alClient
      TabOrder = 0
      object cxGrid1DBTableView1: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        DataController.DataSource = IBCDataSourceGoods
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        object cxGrid1DBTableView1GOODSID: TcxGridDBColumn
          DataBinding.FieldName = 'GOODSID'
          DataBinding.IsNullValueType = True
        end
        object cxGrid1DBTableView1TITLE: TcxGridDBColumn
          DataBinding.FieldName = 'TITLE'
          DataBinding.IsNullValueType = True
          Width = 637
        end
      end
      object cxGrid1Level1: TcxGridLevel
        GridView = cxGrid1DBTableView1
      end
    end
  end
  object IBCQueryGoodsFolders: TIBCQuery
    KeyFields = 'goodsid'
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'select * from ts_goods where flg_folder=1'
      'order by orderno')
    Left = 401
    Top = 209
  end
  object IBCDataSourceGoodsFolders: TIBCDataSource
    DataSet = IBCQueryGoodsFolders
    Left = 397
    Top = 105
  end
  object IBCQueryGoods: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'select * from ts_goods g')
    MasterFields = 'WEBGOODSTYPE_ID'
    DetailFields = 'WEBGOODSTYPE_ID'
    MasterSource = IBCDataSourceGoodsFolders
    Left = 787
    Top = 101
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'WEBGOODSTYPE_ID'
        Value = nil
      end>
  end
  object IBCDataSourceGoods: TIBCDataSource
    DataSet = IBCQueryGoods
    Left = 785
    Top = 30
  end
end
