inherited frame125NexDistribution: Tframe125NexDistribution
  Width = 1223
  Height = 772
  Font.Height = -15
  ExplicitWidth = 1223
  ExplicitHeight = 772
  PixelsPerInch = 120
  object cxGrid1: TcxGrid
    Left = 16
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
  object cxImage1: TcxImage
    Left = 928
    Top = 16
    Properties.GraphicClassName = 'TdxSmartImage'
    TabOrder = 2
    Height = 401
    Width = 281
  end
  object Memo1: TcxMemo
    Left = 16
    Top = 454
    Lines.Strings = (
      'cxMemo1')
    Properties.ScrollBars = ssBoth
    TabOrder = 3
    Height = 307
    Width = 1193
  end
  object cxProgressBar2: TcxProgressBar
    Left = 143
    Top = 423
    Style.LookAndFeel.NativeStyle = True
    StyleDisabled.LookAndFeel.NativeStyle = True
    StyleFocused.LookAndFeel.NativeStyle = True
    StyleHot.LookAndFeel.NativeStyle = True
    TabOrder = 4
    Width = 258
  end
  object IBCQuerySupplierGoods: TIBCQuery
    ParamCheck = False
    SQL.Strings = (
      'select * from TPARSE_SUPPLIER_GOODS gg'
      
        'join ts_goods_foreign gf on (gf.goods_code = gg.goods_code and g' +
        'f.customerid = gg.supplierid)'
      'where gg.supplierid = 275640 and'
      
        '      not exists(select * from ts_goods_image ii where ii.goodsi' +
        'd = gf.goodsid)'
      '')
    Left = 304
    Top = 224
  end
  object IBCDataSourceSupplierGoods: TIBCDataSource
    DataSet = IBCQuerySupplierGoods
    Left = 304
    Top = 176
  end
  object NetHTTPClient1: TNetHTTPClient
    UserAgent = 
      'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like ' +
      'Gecko) Chrome/51.0.2704.103 Safari/537.36'
    Left = 456
    Top = 56
  end
  object IBCSQL1: TIBCSQL
    Connection = dmDB.IBCConnection
    Transaction = IBCtrLocalUpdate
    SQL.Strings = (
      'insert into ts_goods_image (goodsid, image)'
      'values(:goodsid, :image)')
    Left = 176
    Top = 224
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'goodsid'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'image'
        Value = nil
      end>
  end
  object IBCtrLocalUpdate: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 480
    Top = 224
  end
  object IBCQuery1: TIBCQuery
    Left = 128
    Top = 344
  end
end
