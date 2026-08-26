inherited frame124HiTech: Tframe124HiTech
  Width = 1283
  Height = 788
  Font.Height = -12
  ExplicitWidth = 1283
  ExplicitHeight = 788
  object cxGrid1: TcxGrid
    Left = 0
    Top = 16
    Width = 906
    Height = 401
    TabOrder = 0
    object cxGrid1DBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      Navigator.InfoPanel.Visible = True
      Navigator.Visible = True
      ScrollbarAnnotations.CustomAnnotations = <>
      DataController.DataSource = IBCDataSourceSupplierGoods
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      OptionsView.Indicator = True
      object cxGrid1DBTableView1GOODS_CODE: TcxGridDBColumn
        DataBinding.FieldName = 'GOODS_CODE'
        DataBinding.IsNullValueType = True
        HeaderAlignmentHorz = taCenter
        Width = 142
      end
      object cxGrid1DBTableView1GOODSID: TcxGridDBColumn
        DataBinding.FieldName = 'GOODSID'
        DataBinding.IsNullValueType = True
        HeaderAlignmentHorz = taCenter
        Width = 72
      end
      object cxGrid1DBTableView1GOODS_TITLE: TcxGridDBColumn
        DataBinding.FieldName = 'GOODS_TITLE'
        DataBinding.IsNullValueType = True
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
