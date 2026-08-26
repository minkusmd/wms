object frmHistoryGoodsFiltersDlg: TfrmHistoryGoodsFiltersDlg
  Left = 0
  Top = 0
  Caption = 'Istoria modificarii filtelor'
  ClientHeight = 347
  ClientWidth = 728
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object cxGrid1: TcxGrid
    Left = 8
    Top = 8
    Width = 713
    Height = 281
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
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      object cxGrid1DBTableView1UID: TcxGridDBColumn
        DataBinding.FieldName = 'UID'
        Visible = False
      end
      object cxGrid1DBTableView1OPERATION: TcxGridDBColumn
        DataBinding.FieldName = 'OPERATION'
        Width = 76
      end
      object cxGrid1DBTableView1GOODSID: TcxGridDBColumn
        DataBinding.FieldName = 'GOODSID'
        Visible = False
        Width = 149
      end
      object cxGrid1DBTableView1DESCRIPTIONID: TcxGridDBColumn
        DataBinding.FieldName = 'DESCRIPTIONID'
        Visible = False
        Width = 145
      end
      object cxGrid1DBTableView1FLG_GROUP: TcxGridDBColumn
        DataBinding.FieldName = 'FLG_GROUP'
        Visible = False
      end
      object cxGrid1DBTableView1FILTERID: TcxGridDBColumn
        DataBinding.FieldName = 'FILTERID'
      end
      object cxGrid1DBTableView1FILTERPARAMID: TcxGridDBColumn
        DataBinding.FieldName = 'FILTERPARAMID'
      end
      object cxGrid1DBTableView1FLAGS: TcxGridDBColumn
        DataBinding.FieldName = 'FLAGS'
      end
      object cxGrid1DBTableView1ORDERNO: TcxGridDBColumn
        DataBinding.FieldName = 'ORDERNO'
      end
      object cxGrid1DBTableView1FILTER_VALUE: TcxGridDBColumn
        DataBinding.FieldName = 'FILTER_VALUE'
        Width = 77
      end
      object cxGrid1DBTableView1MODIFIED_DATE: TcxGridDBColumn
        DataBinding.FieldName = 'MODIFIED_DATE'
        Width = 88
      end
      object cxGrid1DBTableView1MODIFIED_BY: TcxGridDBColumn
        DataBinding.FieldName = 'MODIFIED_BY'
        Width = 92
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
    end
  end
  object btnClose: TcxButton
    Left = 312
    Top = 312
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Inchide'
    ModalResult = 8
    TabOrder = 1
  end
  object IBCQuery1: TIBCQuery
    SQL.Strings = (
      'select * from TLOG_GOODS_DESCRIPTIONS where goodsid = :goodsid ')
    Left = 360
    Top = 176
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'goodsid'
        Value = nil
      end>
  end
  object IBCDataSource1: TIBCDataSource
    DataSet = IBCQuery1
    Left = 248
    Top = 184
  end
end
