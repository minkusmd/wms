inherited frame123Dehome: Tframe123Dehome
  Width = 1026
  Height = 630
  Margins.Left = 4
  Margins.Top = 4
  Margins.Right = 4
  Margins.Bottom = 4
  Font.Height = -12
  ExplicitWidth = 1026
  ExplicitHeight = 630
  object cxGrid1: TcxGrid
    Left = 13
    Top = 13
    Width = 725
    Height = 321
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    TabOrder = 0
    object cxGrid1DBTableView1: TcxGridDBTableView
      Navigator.InfoPanel.Visible = True
      Navigator.Visible = True
      DataController.DataSource = IBCDataSourceSupplierGoods
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      OptionsView.Indicator = True
      object cxGrid1DBTableView1GOODS_CODE: TcxGridDBColumn
        Caption = 'CPF'
        DataBinding.FieldName = 'GOODS_CODE'
        HeaderAlignmentHorz = taCenter
        MinWidth = 16
        Width = 114
      end
      object cxGrid1DBTableView1GOODSID: TcxGridDBColumn
        Caption = 'Cod'
        DataBinding.FieldName = 'GOODSID'
        HeaderAlignmentHorz = taCenter
        MinWidth = 16
        Width = 58
      end
      object cxGrid1DBTableView1GOODS_TITLE: TcxGridDBColumn
        Caption = 'Denumire'
        DataBinding.FieldName = 'GOODS_TITLE'
        MinWidth = 16
        Width = 542
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
    end
  end
  object cxButton1: TcxButton
    Left = 13
    Top = 338
    Width = 97
    Height = 24
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
    Left = 750
    Top = 13
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    ParentFont = False
    Properties.GraphicClassName = 'TdxSmartImage'
    Style.Font.Charset = DEFAULT_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -12
    Style.Font.Name = 'Segoe UI'
    Style.Font.Style = []
    Style.IsFontAssigned = True
    TabOrder = 2
    Height = 321
    Width = 224
  end
  object cxMemo1: TcxMemo
    Left = 13
    Top = 363
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Lines.Strings = (
      'cxMemo1')
    ParentFont = False
    Properties.ScrollBars = ssBoth
    Style.Font.Charset = DEFAULT_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -12
    Style.Font.Name = 'Segoe UI'
    Style.Font.Style = []
    Style.IsFontAssigned = True
    TabOrder = 3
    Height = 246
    Width = 941
  end
  object IBCQuerySupplierGoods: TIBCQuery
    ParamCheck = False
    SQL.Strings = (
      'select GF.GOODS_CODE, GF.GOODSID, GF.GOODS_TITLE'
      'from TS_GOODS_FOREIGN GF'
      'where CUSTOMERID = 261523 and'
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
