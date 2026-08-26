inherited frame113EuroTerm: Tframe113EuroTerm
  Width = 1418
  Height = 662
  Font.Height = -13
  ExplicitWidth = 1418
  ExplicitHeight = 662
  PixelsPerInch = 120
  object cxGridVolta: TcxGrid
    Left = 0
    Top = 0
    Width = 649
    Height = 662
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
      object cxGridVoltaDBTableView1GOODSID: TcxGridDBColumn
        Caption = 'Cod produs'
        DataBinding.FieldName = 'GOODSID'
        HeaderAlignmentHorz = taCenter
        Width = 84
      end
      object cxGridVoltaDBTableView1GOODS_CODE: TcxGridDBColumn
        Caption = 'CPF'
        DataBinding.FieldName = 'GOODS_CODE'
        HeaderAlignmentHorz = taCenter
        Width = 86
      end
      object cxGridVoltaDBTableView1_GOODS_TITLE: TcxGridDBColumn
        Caption = 'Produs'
        DataBinding.FieldName = 'GOODS_TITLE'
        HeaderAlignmentHorz = taCenter
        Width = 436
      end
      object cxGridVoltaDBTableView1_FLG_IN_PRICE: TcxGridDBColumn
        Caption = 'P'
        DataBinding.FieldName = 'FLG_IN_PRICE'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.NullStyle = nssUnchecked
        Properties.ValueChecked = '1'
        Properties.ValueUnchecked = '0'
        HeaderAlignmentHorz = taCenter
        Width = 26
      end
    end
    object cxGridVoltaLevel1: TcxGridLevel
      GridView = cxGridVoltaDBTableView1
    end
  end
  object Panel1: TPanel
    Left = 649
    Top = 0
    Width = 769
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
      Width = 22
      Height = 17
      Caption = 'Log'
    end
    object Memo1: TMemo
      AlignWithMargins = True
      Left = 3
      Top = 84
      Width = 759
      Height = 571
      Align = alClient
      TabOrder = 0
    end
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 765
      Height = 81
      Align = alTop
      BevelKind = bkFlat
      BevelOuter = bvNone
      Color = clWindow
      ParentBackground = False
      TabOrder = 1
      DesignSize = (
        761
        77)
      object cxButton1: TcxButton
        Left = 182
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
      object teExtension: TcxTextEdit
        Left = 380
        Top = 32
        TabOrder = 5
        Text = 'jpg'
        Width = 81
      end
      object cxLabel1: TcxLabel
        Left = 319
        Top = 32
        Caption = 'Extension'
        TabOrder = 6
      end
      object cxButton3: TcxButton
        Left = 271
        Top = 51
        Width = 75
        Height = 25
        Caption = 'cxButton3'
        TabOrder = 7
        OnClick = cxButton3Click
      end
      object cxLabel2: TcxLabel
        Left = 352
        Top = 52
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Caption = 'image path'
        TabOrder = 8
        Height = 19
        Width = 401
      end
    end
  end
  object IBCQuery1: TIBCQuery
    SQL.Strings = (
      'select GF.GOODSID, GF.GOODS_CODE, gf.goods_title,'
      'get_flg_in_price(gf.goodsid) FLG_IN_PRICE'
      'from TS_GOODS_FOREIGN GF'
      'where GF.CUSTOMERID = 162399 -- EuroTerm Grup'
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
