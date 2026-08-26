object frmWebSelectGoodsDlg: TfrmWebSelectGoodsDlg
  Left = 0
  Top = 0
  ActiveControl = beGoods
  BorderStyle = bsDialog
  Caption = 'Produse in promotii'
  ClientHeight = 293
  ClientWidth = 682
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object DialogTitle1: TDialogTitle
    Left = 0
    Top = 0
    Width = 682
    Height = 64
    Title = 'Produse in promotii'
    Text = 'Gestinarea produselor din promotii'
    FontTitle.Charset = DEFAULT_CHARSET
    FontTitle.Color = clWindowText
    FontTitle.Height = -15
    FontTitle.Name = 'Segoe UI'
    FontTitle.Style = [fsBold]
    FontText.Charset = DEFAULT_CHARSET
    FontText.Color = clWindowText
    FontText.Height = -12
    FontText.Name = 'Segoe UI'
    FontText.Style = []
    ImageList = dmAdditions.cxImageList_DialogIcons
    ImageIndex = 88
  end
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 5
    Top = 69
    Width = 672
    Height = 178
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alClient
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    object Label1: TLabel
      Left = 16
      Top = 58
      Width = 43
      Height = 15
      Caption = 'Furnizor'
    end
    object Label2: TLabel
      Left = 16
      Top = 16
      Width = 37
      Height = 15
      Caption = 'Produs'
    end
    object Label3: TLabel
      Left = 16
      Top = 138
      Width = 32
      Height = 15
      Caption = 'Valuta'
    end
    object Label4: TLabel
      Left = 16
      Top = 104
      Width = 21
      Height = 15
      Caption = 'CPF'
    end
    object Label5: TLabel
      Left = 328
      Top = 104
      Width = 21
      Height = 15
      Caption = 'Pret'
    end
    object beGoods: TcxButtonEdit
      Left = 96
      Top = 13
      ParentFont = False
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end
        item
          Action = actFindByGoodsID
          Glyph.SourceDPI = 96
          Glyph.Data = {
            89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
            61000000097048597300000EC200000EC20115284A8000000012744558745469
            746C650046696E643B5365617263683BAD078F620000016A49444154785EA591
            CD4A02611486BD8A46A789F1278568DFD65DB408341A1DB5C69F748CB983C84D
            942EEC565A0981E6FC383FB60964EA0A0A6951B619086C33703A332048F6CDC6
            17DE8FB3799F73CE774200B096FD67A16DD14CC71B660FFD1EAB1B9E7BD19A99
            0EAD6A159014CD56B26941EA7C0C471D1BB2373624C43144AB06B015BD1504F0
            3B27450B326D1BA65F3FB090571F5E4D802D8F80A98C0E8800EC64ED4A8F7EE0
            AF5E3FE6906A18C008EA3D11106F584EF1F60548CA759E8139D1666440DD740A
            5D32806BDB0850C880E89961ED4816BC7DCEFF5D2151D7812E05ACE09D8AAD99
            AEF761D3D9D22762BD7FF9049B25052225B51D7846B632BAC07341ACAA43F67A
            0219342B6818D6BC30448AAA4BF3324F02F862CACADE96A0F79953CDA105348E
            4D17D52E861180531414974208014056981F4A1886302F4398935D8A93791280
            0CE18612951F009597813AEE7F1300C1DAC83D34A97CDFD9E00677CB8075BC3E
            E0171A811CE8F7E0E9CD0000000049454E44AE426082}
          Kind = bkGlyph
        end>
      Properties.ClickKey = 115
      Properties.OnButtonClick = beGoodsPropertiesButtonClick
      TabOrder = 0
      Text = 'Goods'
      Width = 545
    end
    object cbCurrency: TcxLookupComboBox
      Left = 96
      Top = 135
      ParentFont = False
      Properties.ImmediatePost = True
      Properties.KeyFieldNames = 'CURRENCYID'
      Properties.ListColumns = <
        item
          FieldName = 'TITLE'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListOptions.SyncMode = True
      Properties.ListSource = IBCDataSourceCurrency
      EditValue = 0
      TabOrder = 4
      Width = 73
    end
    object lcbGoodsSuppliers: TcxLookupComboBox
      Left = 96
      Top = 55
      ParentFont = False
      Properties.KeyFieldNames = 'CUSTOMERID'
      Properties.ListColumns = <
        item
          Width = 200
          FieldName = 'CUSTOMER_NAME'
        end
        item
          Width = 100
          FieldName = 'PRICE'
        end
        item
          Width = 42
          FieldName = 'FLG_IN_PRICE'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListOptions.SyncMode = True
      Properties.ListSource = IBCDataSourceGoodsSuppliers
      Properties.OnCloseUp = lcbGoodsSuppliersPropertiesCloseUp
      Properties.OnInitPopup = lcbGoodsSuppliersPropertiesInitPopup
      Style.Color = clWindow
      TabOrder = 1
      Width = 545
    end
    object lcbSupplierGoodsCode: TcxLookupComboBox
      Left = 96
      Top = 101
      ParentFont = False
      Properties.KeyFieldNames = 'GOODS_CODE'
      Properties.ListColumns = <
        item
          FieldName = 'GOODS_CODE'
        end>
      Properties.ListOptions.RowSelect = False
      Properties.ListOptions.ShowHeader = False
      Properties.ListOptions.SyncMode = True
      Properties.ListSource = IBCDataSourceGoodsForeign
      Properties.OnInitPopup = lcbSupplierGoodsCodePropertiesInitPopup
      TabOrder = 2
      Width = 194
    end
    object cePrice: TcxCalcEdit
      Left = 363
      Top = 101
      EditValue = 0.000000000000000000
      TabOrder = 3
      Width = 78
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 252
    Width = 682
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object Button1: TButton
      Left = 449
      Top = 3
      Width = 90
      Height = 29
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
    object Button2: TButton
      Left = 545
      Top = 3
      Width = 90
      Height = 29
      Cancel = True
      Caption = 'Renunta'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object IBCQueryCurrency: TIBCQuery
    SQL.Strings = (
      'select * from ts_currency')
    Left = 440
    Top = 200
  end
  object IBCDataSourceCurrency: TIBCDataSource
    DataSet = IBCQueryCurrency
    Left = 440
    Top = 144
  end
  object IBCQueryGoodsForeign: TIBCQuery
    SQL.Strings = (
      'select goods_code from ts_goods_foreign '
      'where '
      '  customerid = :customerid and'
      '  goodsid = :goodsid')
    Left = 440
    Top = 72
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'customerid'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'goodsid'
        Value = nil
      end>
  end
  object IBCDataSourceGoodsForeign: TIBCDataSource
    DataSet = IBCQueryGoodsForeign
    Left = 440
    Top = 16
  end
  object IBCQueryGoodsSuppliers: TIBCQuery
    SQL.Strings = (
      'select '
      '  a.customerid, '
      
        '  (select name from ts_customer where customerid = a.customerid)' +
        ' customer_name, '
      '  get_flg_value(a.flags, 3) flg_in_price,'
      '  (select price_mdl from GET_GOODS_PRICE7(goodsid, 498)) price'
      'from ts_goods_foreign a'
      'where a.goodsid = :goodsid'
      'order by 3 desc, 4')
    Left = 264
    Top = 64
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'goodsid'
        Value = nil
      end>
  end
  object IBCDataSourceGoodsSuppliers: TIBCDataSource
    DataSet = IBCQueryGoodsSuppliers
    Left = 264
    Top = 8
  end
  object ActionList1: TActionList
    Left = 328
    Top = 152
    object actFindByGoodsID: TAction
      Caption = 'Cauta dupa cod produs'
      ShortCut = 16416
      OnExecute = actFindByGoodsIDExecute
    end
  end
end
