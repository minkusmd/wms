object frmSelectGoodsSupplierDlg: TfrmSelectGoodsSupplierDlg
  Left = 0
  Top = 0
  Caption = 'Alege furnizorul'
  ClientHeight = 258
  ClientWidth = 620
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object cxGrid1: TcxGrid
    Left = 0
    Top = 0
    Width = 620
    Height = 217
    Align = alClient
    TabOrder = 0
    ExplicitLeft = 8
    ExplicitTop = 8
    ExplicitWidth = 608
    ExplicitHeight = 200
    object cxGrid1DBTableView1: TcxGridDBTableView
      DataController.DataSource = IBCDataSource1
      OptionsView.GroupByBox = False
      object cxGrid1DBTableView1CUSTOMERID: TcxGridDBColumn
        DataBinding.FieldName = 'CUSTOMERID'
      end
      object cxGrid1DBTableView1GOODS_CODE: TcxGridDBColumn
        DataBinding.FieldName = 'GOODS_CODE'
        Width = 150
      end
      object cxGrid1DBTableView1GOODS_TITLE: TcxGridDBColumn
        DataBinding.FieldName = 'GOODS_TITLE'
        Width = 200
      end
      object cxGrid1DBTableView1PRICE0: TcxGridDBColumn
        DataBinding.FieldName = 'PRICE0'
      end
      object cxGrid1DBTableView1PRICE7: TcxGridDBColumn
        DataBinding.FieldName = 'PRICE7'
      end
      object cxGrid1DBTableView1PRICE1: TcxGridDBColumn
        DataBinding.FieldName = 'PRICE1'
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
    end
  end
  object RzDialogButtons1: TRzDialogButtons
    Left = 0
    Top = 217
    Width = 620
    Height = 41
    TabOrder = 1
    ExplicitTop = 400
    ExplicitWidth = 624
  end
  object IBCQuery1: TIBCQuery
    SQL.Strings = (
      
        'select gf.customerid, c.name customer_name, goods_code, goods_ti' +
        'tle, price0, price7, price1 '
      'from ts_goods_foreign  gf'
      'join ts_customer c on c.customerid = gf.customerid'
      'where gf.goodsid = :goodsid and get_flg_value(gf.flags,3)=1')
    Left = 288
    Top = 84
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'goodsid'
        Value = nil
      end>
  end
  object IBCDataSource1: TIBCDataSource
    DataSet = IBCQuery1
    Left = 220
    Top = 84
  end
end
