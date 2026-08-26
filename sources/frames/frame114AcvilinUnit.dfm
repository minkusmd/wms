inherited frame114AcvilinParse: Tframe114AcvilinParse
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
      DataController.DataSource = IBCDataSource1
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
        Width = 46
      end
      object cxGridVoltaDBTableView1GOODS_CODE: TcxGridDBColumn
        Caption = 'CPF'
        DataBinding.FieldName = 'GOODS_CODE'
        HeaderAlignmentHorz = taCenter
        MinWidth = 16
        Width = 73
      end
      object cxGridVoltaDBTableView1_GOODS_TITLE: TcxGridDBColumn
        Caption = 'Produs'
        DataBinding.FieldName = 'GOODS_TITLE'
        HeaderAlignmentHorz = taCenter
        MinWidth = 16
        Width = 366
      end
      object cxGridVoltaDBTableView1_FLG_IN_PRICE: TcxGridDBColumn
        Caption = 'P'
        DataBinding.FieldName = 'FLG_IN_PRICE'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.NullStyle = nssUnchecked
        Properties.ValueChecked = '1'
        Properties.ValueUnchecked = '0'
        HeaderAlignmentHorz = taCenter
        MinWidth = 16
        Width = 22
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
      Top = 67
      Width = 469
      Height = 457
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alClient
      TabOrder = 0
    end
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 473
      Height = 65
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
      object cxButton1: TcxButton
        Left = 165
        Top = 38
        Width = 66
        Height = 23
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Start'
        Default = True
        OptionsImage.Spacing = 3
        TabOrder = 0
        OnClick = cxButton1Click
      end
      object cbFlgNoImage: TCheckBox
        Left = 13
        Top = 10
        Width = 129
        Height = 13
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Produsele fara imagini'
        TabOrder = 1
      end
      object cbFlgInPRICE: TCheckBox
        Left = 173
        Top = 10
        Width = 77
        Height = 13
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'In pricelist'
        TabOrder = 2
      end
      object cbUpdateAllImages: TCheckBox
        Left = 255
        Top = 10
        Width = 143
        Height = 13
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Sincronizeaza toate imaginile'
        TabOrder = 3
      end
      object cxButton2: TcxButton
        Left = 11
        Top = 38
        Width = 111
        Height = 23
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Refresh'
        OptionsImage.Spacing = 3
        TabOrder = 4
        OnClick = cxButton2Click
      end
      object teExtension: TcxTextEdit
        Left = 256
        Top = 42
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        TabOrder = 5
        Text = 'jpg'
        Width = 65
      end
      object cxLabel1: TcxLabel
        Left = 255
        Top = 25
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Extension'
        TabOrder = 6
      end
    end
  end
  object IBCQuery1: TIBCQuery
    SQL.Strings = (
      'select GF.GOODSID, GF.GOODS_CODE, gf.goods_title,'
      'get_flg_in_price(gf.goodsid) FLG_IN_PRICE'
      'from TS_GOODS_FOREIGN GF'
      'where GF.CUSTOMERID = 8348  -- acvilin grup '
      '&FlgNoImage'
      '&FlgInPrice')
    Left = 216
    Top = 192
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
end
