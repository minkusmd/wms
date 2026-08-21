object frmGoodsInFilterDialog: TfrmGoodsInFilterDialog
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Produse ce corespund filtrului'
  ClientHeight = 691
  ClientWidth = 725
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object cxGrid1: TcxGrid
    Left = 0
    Top = 64
    Width = 721
    Height = 577
    TabOrder = 0
    object cxGrid1DBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      ScrollbarAnnotations.CustomAnnotations = <>
      DataController.DataSource = IBCDataSource1
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
      object cxGrid1DBTableView1FILTERID: TcxGridDBColumn
        DataBinding.FieldName = 'FILTERID'
        DataBinding.IsNullValueType = True
        HeaderAlignmentHorz = taCenter
      end
      object cxGrid1DBTableView1FILTERNAME: TcxGridDBColumn
        DataBinding.FieldName = 'FILTERNAME'
        DataBinding.IsNullValueType = True
        HeaderAlignmentHorz = taCenter
        Width = 200
      end
      object cxGrid1DBTableView1GOODSID: TcxGridDBColumn
        DataBinding.FieldName = 'GOODSID'
        DataBinding.IsNullValueType = True
        HeaderAlignmentHorz = taCenter
      end
      object cxGrid1DBTableView1TITLE: TcxGridDBColumn
        DataBinding.FieldName = 'TITLE'
        DataBinding.IsNullValueType = True
        HeaderAlignmentHorz = taCenter
        Width = 350
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
    end
  end
  object cxButton1: TcxButton
    Left = 312
    Top = 656
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Inchide'
    Default = True
    ModalResult = 8
    TabOrder = 2
  end
  object DialogTitle1: TDialogTitle
    Left = 0
    Top = 0
    Width = 725
    Height = 64
    Title = 'Produse in filtru'
    Text = 'Lista produselor ce corespund filtrului'
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
    ImageList = dmAdditions.cxImageList_DialogIcons
    ImageIndex = 5
  end
  object IBCQuery: TIBCQuery
    SQL.Strings = (
      
        'select gd.filterid, f.filtername, gd.goodsid, g.title from ts_go' +
        'ods_descriptions gd'
      'join ts_goods g on g.goodsid=gd.goodsid'
      'join ts_filters f on f.filterid = gd.filterid'
      'where gd.filterid=:filterid')
    Left = 368
    Top = 120
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'filterid'
        Value = nil
      end>
  end
  object IBCDataSource1: TIBCDataSource
    DataSet = IBCQuery
    Left = 272
    Top = 136
  end
end
