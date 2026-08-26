inherited frame120ATehno: Tframe120ATehno
  Width = 1026
  Height = 554
  Margins.Left = 4
  Margins.Top = 4
  Margins.Right = 4
  Margins.Bottom = 4
  Font.Height = -12
  ExplicitWidth = 1026
  ExplicitHeight = 554
  object cxGrid1: TcxGrid
    Left = 13
    Top = 13
    Width = 360
    Height = 436
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    TabOrder = 0
    object cxGrid1DBTableView1: TcxGridDBTableView
      Navigator.InfoPanel.Visible = True
      Navigator.Visible = True
      DataController.DataSource = IBCDataSourceATehnoGoods
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      OptionsView.Indicator = True
      object cxGrid1DBTableView1GOODS_CODE: TcxGridDBColumn
        DataBinding.FieldName = 'GOODS_CODE'
        HeaderAlignmentHorz = taCenter
        MinWidth = 16
        Width = 145
      end
      object cxGrid1DBTableView1GOODSID: TcxGridDBColumn
        DataBinding.FieldName = 'GOODSID'
        HeaderAlignmentHorz = taCenter
        MinWidth = 16
        Width = 58
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
    end
  end
  object cxButton1: TcxButton
    Left = 13
    Top = 466
    Width = 360
    Height = 29
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = 'Start'
    OptionsImage.Spacing = 3
    TabOrder = 1
    OnClick = cxButton1Click
  end
  object cxImage1: TcxImage
    Left = 378
    Top = 13
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Properties.GraphicClassName = 'TdxSmartImage'
    TabOrder = 2
    Height = 212
    Width = 255
  end
  object Button1: TButton
    Left = 13
    Top = 499
    Width = 360
    Height = 39
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = 'Curata denumirea produselor de cod'
    TabOrder = 3
    OnClick = Button1Click
  end
  object IBCQueryATehnoGoods: TIBCQuery
    SQL.Strings = (
      'select goods_code, goodsid from '
      'ts_goods_foreign gf '
      'where customerid = 292109 and '
      '      get_flg_value(flags, 3) = 1 and '
      
        '      not exists(select goodsid from ts_goods_image gi where gi.' +
        'goodsid = gf.goodsid)')
    Left = 304
    Top = 224
  end
  object IBCDataSourceATehnoGoods: TIBCDataSource
    DataSet = IBCQueryATehnoGoods
    Left = 304
    Top = 176
  end
  object NetHTTPClient1: TNetHTTPClient
    UserAgent = 'Embarcadero URI Client/1.0'
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
