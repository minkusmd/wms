object frmGoodsPricePolicyDlg: TfrmGoodsPricePolicyDlg
  Left = 0
  Top = 0
  Caption = 'Formarea preturilor pentru produs'
  ClientHeight = 430
  ClientWidth = 371
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 353
    Height = 13
    AutoSize = False
    Caption = 'Label1'
  end
  object cxGrid1: TcxGrid
    Left = 8
    Top = 27
    Width = 353
    Height = 342
    TabOrder = 0
    object cxGrid1DBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      ScrollbarAnnotations.CustomAnnotations = <>
      DataController.DataSource = IBCDataSource
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      object cxGrid1DBTableView1PRICECOLUMN: TcxGridDBColumn
        Caption = 'G'
        DataBinding.FieldName = 'PRICECOLUMN'
        HeaderAlignmentHorz = taCenter
        Width = 31
      end
      object cxGrid1DBTableView1MIN_VALUE: TcxGridDBColumn
        Caption = 'Min'
        DataBinding.FieldName = 'MIN_VALUE'
        HeaderAlignmentHorz = taCenter
        Width = 53
      end
      object cxGrid1DBTableView1MAX_VALUE: TcxGridDBColumn
        Caption = 'Max'
        DataBinding.FieldName = 'MAX_VALUE'
        HeaderAlignmentHorz = taCenter
        Width = 59
      end
      object cxGrid1DBTableView1FORMULA: TcxGridDBColumn
        Caption = 'Formula'
        DataBinding.FieldName = 'FORMULA'
        HeaderAlignmentHorz = taCenter
        Width = 208
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
    end
  end
  object Button1: TButton
    Left = 136
    Top = 393
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Inchide'
    ModalResult = 8
    TabOrder = 1
    OnClick = Button1Click
  end
  object IBCQuery: TIBCQuery
    SQLInsert.Strings = (
      'INSERT INTO TPRICE_GOODSTYPE'
      '  (PGT_ID, PRICECOLUMN, MIN_VALUE, MAX_VALUE, FORMULA)'
      'VALUES'
      '  (:PGT_ID, :PRICECOLUMN, :MIN_VALUE, :MAX_VALUE, :FORMULA)')
    SQLDelete.Strings = (
      'DELETE FROM TPRICE_GOODSTYPE'
      'WHERE'
      
        '  PGT_ID = :Old_PGT_ID AND PRICECOLUMN = :Old_PRICECOLUMN AND MI' +
        'N_VALUE = :Old_MIN_VALUE')
    SQLUpdate.Strings = (
      'UPDATE TPRICE_GOODSTYPE'
      'SET'
      
        '  PGT_ID = :PGT_ID, PRICECOLUMN = :PRICECOLUMN, MIN_VALUE = :MIN' +
        '_VALUE, MAX_VALUE = :MAX_VALUE, FORMULA = :FORMULA'
      'WHERE'
      
        '  PGT_ID = :Old_PGT_ID AND PRICECOLUMN = :Old_PRICECOLUMN AND MI' +
        'N_VALUE = :Old_MIN_VALUE')
    SQLRefresh.Strings = (
      
        'SELECT PGT_ID, PRICECOLUMN, MIN_VALUE, MAX_VALUE, FORMULA FROM T' +
        'PRICE_GOODSTYPE'
      'WHERE'
      
        '  PGT_ID = :PGT_ID AND PRICECOLUMN = :PRICECOLUMN AND MIN_VALUE ' +
        '= :MIN_VALUE')
    SQLLock.Strings = (
      'SELECT NULL FROM TPRICE_GOODSTYPE'
      'WHERE'
      
        'PGT_ID = :Old_PGT_ID AND PRICECOLUMN = :Old_PRICECOLUMN AND MIN_' +
        'VALUE = :Old_MIN_VALUE'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM TPRICE_GOODSTYPE'
      ''
      ') q')
    SQL.Strings = (
      
        'select distinct TP.PGT_ID, TP.PRICECOLUMN, TP.MIN_VALUE, TP.MAX_' +
        'VALUE, TP.FORMULA'
      'from TPRICE_GOODSTYPE TP'
      'inner join TWEB_CATALOG C on C.PGT_ID = TP.PGT_ID and'
      '      C.DT = 5213'
      'inner join TWEB_CATALOG_ITEMS I on I.CATALOGID = C.CATALOGID and'
      '      C.PGT_ID = TP.PGT_ID'
      'inner join TS_GOODS G on G.PARENTID = I.GOODSPARENTID and'
      '      G.GOODSID = :goodsid'
      'order by TP.PRICECOLUMN, TP.MIN_VALUE  ')
    Left = 224
    Top = 136
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'goodsid'
        Value = nil
      end>
  end
  object IBCDataSource: TIBCDataSource
    DataSet = IBCQuery
    Left = 104
    Top = 128
  end
  object IBCQueryPGT: TIBCQuery
    SQL.Strings = (
      'select * From TPRICE'
      'WHERE PGT_ID=:PGT_ID')
    Left = 40
    Top = 368
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PGT_ID'
        Value = nil
      end>
  end
end
