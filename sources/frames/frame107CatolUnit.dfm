inherited frame107Catol: Tframe107Catol
  Width = 1245
  Height = 662
  Font.Height = -15
  ExplicitWidth = 1245
  ExplicitHeight = 662
  PixelsPerInch = 120
  object cxGridSupplierGoods: TcxGrid
    Left = 0
    Top = 0
    Width = 649
    Height = 662
    Align = alLeft
    TabOrder = 0
    LookAndFeel.NativeStyle = True
    LookAndFeel.SkinName = ''
    object cxGridSupplierGoodsDBTableView1: TcxGridDBTableView
      OnKeyDown = cxGridSupplierGoodsDBTableView1KeyDown
      FindPanel.DisplayMode = fpdmAlways
      DataController.DataSource = IBCDataSource1
      DataController.KeyFieldNames = 'GOODSID'
      DataController.Summary.FooterSummaryItems = <
        item
          Kind = skCount
          Column = cxGridSupplierGoodsDBTableView1GOODS_CODE
        end>
      FilterRow.SeparatorWidth = 8
      FixedDataRows.SeparatorWidth = 8
      NewItemRow.SeparatorWidth = 8
      OptionsBehavior.IncSearch = True
      OptionsBehavior.ImmediateEditor = False
      OptionsView.NavigatorOffset = 63
      OptionsView.ColumnAutoWidth = True
      OptionsView.FixedColumnSeparatorWidth = 3
      OptionsView.Footer = True
      OptionsView.GroupByBox = False
      OptionsView.Indicator = True
      Preview.LeftIndent = 25
      Preview.RightIndent = 6
      RowLayout.MinValueWidth = 100
      object cxGridSupplierGoodsDBTableView1GOODSID: TcxGridDBColumn
        Caption = 'Cod produs'
        DataBinding.FieldName = 'GOODSID'
        HeaderAlignmentHorz = taCenter
        Width = 58
      end
      object cxGridSupplierGoodsDBTableView1GOODS_CODE: TcxGridDBColumn
        Caption = 'CPF'
        DataBinding.FieldName = 'GOODS_CODE'
        HeaderAlignmentHorz = taCenter
        Width = 91
      end
      object cxGridSupplierGoodsDBTableView1_GOODS_TITLE: TcxGridDBColumn
        Caption = 'Produs'
        DataBinding.FieldName = 'GOODS_TITLE'
        HeaderAlignmentHorz = taCenter
        Width = 458
      end
      object cxGridSupplierGoodsDBTableView1_FLG_IN_PRICE: TcxGridDBColumn
        Caption = 'P'
        DataBinding.FieldName = 'FLG_IN_PRICE'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.NullStyle = nssUnchecked
        Properties.ValueChecked = '1'
        Properties.ValueUnchecked = '0'
        HeaderAlignmentHorz = taCenter
        Width = 28
      end
    end
    object cxGridSupplierGoodsLevel1: TcxGridLevel
      GridView = cxGridSupplierGoodsDBTableView1
    end
  end
  object Panel1: TPanel
    Left = 649
    Top = 0
    Width = 596
    Height = 662
    Align = alClient
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    object Label1: TLabel
      Left = 4
      Top = 6
      Width = 25
      Height = 20
      Caption = 'Log'
    end
    object Memo1: TMemo
      AlignWithMargins = True
      Left = 3
      Top = 116
      Width = 586
      Height = 539
      Align = alClient
      TabOrder = 0
    end
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 592
      Height = 113
      Align = alTop
      BevelKind = bkFlat
      BevelOuter = bvNone
      Color = clWindow
      ParentBackground = False
      TabOrder = 1
      object cxButton1: TcxButton
        Left = 206
        Top = 47
        Width = 83
        Height = 29
        Caption = 'Start'
        Default = True
        TabOrder = 0
        OnClick = cxButton1Click
      end
      object cbFlgNoImage: TCheckBox
        Left = 16
        Top = 12
        Width = 161
        Height = 17
        Caption = 'Produsele fara imagini'
        TabOrder = 1
      end
      object cbFlgInPRICE: TCheckBox
        Left = 216
        Top = 12
        Width = 97
        Height = 17
        Caption = 'In pricelist'
        TabOrder = 2
      end
      object cbUpdateAllImages: TCheckBox
        Left = 319
        Top = 12
        Width = 178
        Height = 17
        Caption = 'Sincronizeaza toate imaginile'
        TabOrder = 3
      end
      object cxButton2: TcxButton
        Left = 14
        Top = 47
        Width = 139
        Height = 29
        Caption = 'Refresh'
        TabOrder = 4
        OnClick = cxButton2Click
      end
      object ProgressBar1: TProgressBar
        AlignWithMargins = True
        Left = 3
        Top = 89
        Width = 582
        Height = 17
        Align = alBottom
        TabOrder = 5
      end
      object btnStop: TButton
        Left = 312
        Top = 43
        Width = 75
        Height = 25
        Caption = 'Stop'
        Enabled = False
        TabOrder = 6
        OnClick = btnStopClick
      end
    end
  end
  object IBCQuery1: TIBCQuery
    SQL.Strings = (
      'select GF.GOODSID, GF.GOODS_CODE, gf.goods_title,'
      'get_flg_in_price(gf.goodsid) FLG_IN_PRICE'
      'from TS_GOODS_FOREIGN GF'
      'where GF.CUSTOMERID = :SupplierID'
      '&FlgNoImage'
      '&FlgInPrice')
    Left = 216
    Top = 152
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'SupplierID'
        Value = nil
      end>
    MacroData = <
      item
        Name = 'FlgNoImage'
      end
      item
        Name = 'FlgInPrice'
      end>
  end
  object IBCDataSource1: TIBCDataSource
    DataSet = IBCQuery1
    Left = 216
    Top = 96
  end
  object NetHTTPClient1: TNetHTTPClient
    UserAgent = 'Embarcadero URI Client/1.0'
    Left = 536
    Top = 16
  end
  object IBCSQL1: TIBCSQL
    Connection = dmDB.IBCConnection
    Transaction = IBCtrLocalUpdate
    SQL.Strings = (
      'insert into ts_goods_image (goodsid, image)'
      'values(:goodsid, :image)')
    Left = 64
    Top = 104
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
    Left = 360
    Top = 96
  end
  object IBCSQLGoods: TIBCSQL
    Connection = dmDB.IBCConnection
    Transaction = IBCtrLocalUpdate
    SQL.Strings = (
      
        ' update or insert into TS_GOODS_DSC (GOODSID, DESCRIPTION, DESCR' +
        'IPTION_RO)'
      ' values (:GOODSID, :DESCRIPTION_RU, :DESCRIPTION_RO)'
      ' matching (GOODSID)')
    Left = 64
    Top = 160
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'GOODSID'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'DESCRIPTION_RU'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'DESCRIPTION_RO'
        Value = nil
      end>
  end
  object IBCSQLDelete: TIBCSQL
    Connection = dmDB.IBCConnection
    Transaction = IBCtrLocalUpdate
    SQL.Strings = (
      'delete from ts_goods_image where goodsid = :goodsid')
    Left = 64
    Top = 216
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'goodsid'
        Value = nil
      end>
  end
end
