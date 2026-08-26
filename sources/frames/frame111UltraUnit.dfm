inherited frame111UltraMD: Tframe111UltraMD
  Width = 996
  Height = 530
  Margins.Left = 4
  Margins.Top = 4
  Margins.Right = 4
  Margins.Bottom = 4
  Font.Height = -12
  ExplicitWidth = 996
  ExplicitHeight = 530
  object cxGridVolta: TcxGrid
    Left = 0
    Top = 0
    Width = 519
    Height = 530
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alLeft
    TabOrder = 0
    LookAndFeel.NativeStyle = True
    LookAndFeel.SkinName = ''
    object cxGridVoltaDBTableView1: TcxGridDBTableView
      OnKeyDown = cxGridVoltaDBTableView1KeyDown
      FindPanel.DisplayMode = fpdmAlways
      DataController.DataSource = IBCDataSourceAPI
      DataController.KeyFieldNames = 'GOODSID'
      DataController.Summary.FooterSummaryItems = <
        item
          Kind = skCount
          Column = cxGridVoltaDBTableView1GOODS_CODE
        end>
      OptionsBehavior.IncSearch = True
      OptionsBehavior.ImmediateEditor = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.Footer = True
      OptionsView.GroupByBox = False
      OptionsView.Indicator = True
      object cxGridVoltaDBTableView1GOODSID: TcxGridDBColumn
        Caption = 'Cod produs'
        DataBinding.FieldName = 'GOODSID'
        HeaderAlignmentHorz = taCenter
        MinWidth = 16
        Width = 51
      end
      object cxGridVoltaDBTableView1GOODS_CODE: TcxGridDBColumn
        Caption = 'CPF'
        DataBinding.FieldName = 'CODE'
        HeaderAlignmentHorz = taCenter
        MinWidth = 16
        Width = 64
      end
      object cxGridVoltaDBTableView1_GOODS_TITLE: TcxGridDBColumn
        Caption = 'Produs'
        DataBinding.FieldName = 'TITLE'
        HeaderAlignmentHorz = taCenter
        MinWidth = 16
        Width = 322
      end
      object cxGridVoltaDBTableView1_FLG_IN_PRICE: TcxGridDBColumn
        Caption = 'PF'
        DataBinding.FieldName = 'FLG_IN_PRICE'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.NullStyle = nssUnchecked
        Properties.ValueChecked = '1'
        Properties.ValueUnchecked = '0'
        HeaderAlignmentHorz = taCenter
        MinWidth = 21
        Options.Editing = False
        Options.AutoWidthSizable = False
        Options.HorzSizing = False
        Width = 21
      end
    end
    object cxGridVoltaLevel1: TcxGridLevel
      GridView = cxGridVoltaDBTableView1
    end
  end
  object Panel1: TPanel
    Left = 519
    Top = 0
    Width = 477
    Height = 530
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    object Label1: TLabel
      Left = 3
      Top = 5
      Width = 20
      Height = 15
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Log'
    end
    object Memo1: TMemo
      AlignWithMargins = True
      Left = 2
      Top = 80
      Width = 469
      Height = 425
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alClient
      ScrollBars = ssBoth
      TabOrder = 0
    end
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 473
      Height = 78
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alTop
      BevelKind = bkFlat
      BevelOuter = bvNone
      Color = clWindow
      ParentBackground = False
      TabOrder = 1
      DesignSize = (
        469
        74)
      object cxButton2: TcxButton
        Left = 90
        Top = 44
        Width = 72
        Height = 23
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Refresh'
        OptionsImage.Spacing = 3
        TabOrder = 0
      end
      object Button1: TButton
        Left = 12
        Top = 44
        Width = 72
        Height = 23
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Start'
        TabOrder = 1
        OnClick = Button1Click
      end
      object ProgressBar1: TProgressBar
        Left = 13
        Top = 15
        Width = 441
        Height = 14
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 2
      end
    end
    object sbGoodsImages: TStatusBar
      Left = 0
      Top = 507
      Width = 473
      Height = 19
      Panels = <>
    end
  end
  object IBCDataSourceAPI: TIBCDataSource
    DataSet = IBCQueryAPI
    Left = 216
    Top = 96
  end
  object NetHTTPClient1: TNetHTTPClient
    AcceptCharSet = 'UTF-8'
    ContentType = 'application/json; charset=utf-8'
    UserAgent = 'Embarcadero URI Client/1.0'
    Left = 384
    Top = 96
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
    Left = 296
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
    Left = 56
    Top = 192
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
    Left = 48
    Top = 288
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'goodsid'
        Value = nil
      end>
  end
  object IBCQueryAPI: TIBCQuery
    KeyFields = 'CODE'
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      
        'select distinct n.uuid, n.code, n.mainimage, gf.goodsid, g.titl' +
        'e, get_flg_in_price(gf.goodsid) flg_in_price from tapi_ultra_no' +
        'menclature  n'
      
        'join ts_goods_foreign gf on gf.goods_code=n.code and gf.customer' +
        'id = 202294 '
      
        '                           and not exists(select first 1 * from ' +
        'ts_goods_image gi where gi.goodsid = gf.goodsid)'
      
        '                           and get_flg_value(flags, 3) = 1 /* do' +
        'ar cele care sunt in price*/'
      'join ts_goods g on g.goodsid = gf.goodsid')
    FetchAll = True
    Left = 216
    Top = 192
  end
  object IBCQueryImages: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'select * from tapi_ultra_images i where i.goods_uuid=:uuid')
    MasterSource = IBCDataSourceAPI
    Left = 392
    Top = 192
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'uuid'
        Value = nil
      end>
  end
end
