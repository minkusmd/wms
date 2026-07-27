object frmPriceTypesHistoryDlg: TfrmPriceTypesHistoryDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Istoricul modificarii politicii de preturi'
  ClientHeight = 433
  ClientWidth = 868
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  PixelsPerInch = 96
  TextHeight = 13
  object cxGrid1: TcxGrid
    Left = 8
    Top = 8
    Width = 852
    Height = 377
    TabOrder = 0
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
      object cxGrid1DBTableView1DATA: TcxGridDBColumn
        DataBinding.FieldName = 'DATA'
        Width = 110
      end
      object cxGrid1DBTableView1USERNAME: TcxGridDBColumn
        DataBinding.FieldName = 'USERNAME'
        Width = 148
      end
      object cxGrid1DBTableView1PRICECOLUMN: TcxGridDBColumn
        DataBinding.FieldName = 'PRICECOLUMN'
        Width = 28
      end
      object cxGrid1DBTableView1MIN_VALUE: TcxGridDBColumn
        DataBinding.FieldName = 'MIN_VALUE'
        Width = 63
      end
      object cxGrid1DBTableView1MAX_VALUE: TcxGridDBColumn
        DataBinding.FieldName = 'MAX_VALUE'
        Width = 63
      end
      object cxGrid1DBTableView1FORMULA: TcxGridDBColumn
        DataBinding.FieldName = 'FORMULA'
        Width = 105
      end
      object cxGrid1DBTableView1FORMULA_NEW: TcxGridDBColumn
        DataBinding.FieldName = 'NEW_FORMULA'
        Width = 110
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
    end
  end
  object btnClose: TcxButton
    Left = 400
    Top = 403
    Width = 90
    Height = 30
    Cancel = True
    Caption = 'Inchide'
    ModalResult = 2
    TabOrder = 1
  end
  object IBCQuery: TIBCQuery
    SQL.Strings = (
      'select * from VW_TPRICE_GOODSTYPE_HISTORY '
      'WHERE PGT_ID=:PGT_ID'
      'order by data desc')
    Active = True
    Left = 200
    Top = 128
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PGT_ID'
        Value = nil
      end>
  end
  object IBCDataSource: TIBCDataSource
    DataSet = IBCQuery
    Left = 128
    Top = 128
  end
end
