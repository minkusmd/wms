inherited frame124HiTech: Tframe124HiTech
  Width = 1283
  Height = 788
  Font.Height = -15
  ExplicitWidth = 1283
  ExplicitHeight = 788
  PixelsPerInch = 120
  object cxGrid1: TcxGrid
    Left = 0
    Top = 16
    Width = 906
    Height = 401
    TabOrder = 0
    object cxGrid1DBTableView1: TcxGridDBTableView
      Navigator.InfoPanel.Visible = True
      Navigator.Visible = True
      DataController.DataSource = IBCDataSourceSupplierGoods
      FilterRow.SeparatorWidth = 8
      FixedDataRows.SeparatorWidth = 8
      NewItemRow.SeparatorWidth = 8
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.NavigatorOffset = 63
      OptionsView.ColumnAutoWidth = True
      OptionsView.FixedColumnSeparatorWidth = 3
      OptionsView.GroupByBox = False
      OptionsView.Indicator = True
      Preview.LeftIndent = 25
      Preview.RightIndent = 6
      RowLayout.MinValueWidth = 100
      object cxGrid1DBTableView1GOODS_CODE: TcxGridDBColumn
        DataBinding.FieldName = 'GOODS_CODE'
        HeaderAlignmentHorz = taCenter
        Width = 142
      end
      object cxGrid1DBTableView1GOODSID: TcxGridDBColumn
        DataBinding.FieldName = 'GOODSID'
        HeaderAlignmentHorz = taCenter
        Width = 72
      end
      object cxGrid1DBTableView1GOODS_TITLE: TcxGridDBColumn
        DataBinding.FieldName = 'GOODS_TITLE'
        Width = 678
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
    end
  end
  object cxButton1: TcxButton
    Left = 16
    Top = 423
    Width = 121
    Height = 25
    Caption = 'Start'
    TabOrder = 1
    OnClick = cxButton1Click
  end
  object btnSyncPrices: TcxButton
    Left = 152
    Top = 423
    Width = 260
    Height = 25
    Caption = 'Verifica preturile pe h-t.md'
    TabOrder = 4
    OnClick = btnSyncPricesClick
  end
  object cxImage1: TcxImage
    Left = 912
    Top = 16
    Properties.GraphicClassName = 'TdxSmartImage'
    TabOrder = 2
    Height = 401
    Width = 281
  end
  object cxMemo1: TcxMemo
    Left = 16
    Top = 454
    Lines.Strings = (
      'cxMemo1')
    Properties.ScrollBars = ssBoth
    TabOrder = 3
    Height = 307
    Width = 1177
  end
  object IBCQuerySupplierGoods: TIBCQuery
    ParamCheck = False
    SQL.Strings = (
      'select GF.GOODS_CODE, GF.GOODSID, GF.GOODS_TITLE'
      'from TS_GOODS_FOREIGN GF'
      'where CUSTOMERID = 262735 and'
      '      not exists(select GOODSID'
      '                 from TS_GOODS_IMAGE GI'
      '                 where GI.GOODSID = GF.GOODSID)')
    Left = 304
    Top = 224
  end
  object IBCDataSourceSupplierGoods: TIBCDataSource
    DataSet = IBCQuerySupplierGoods
    Left = 304
    Top = 176
  end
end
