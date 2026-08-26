object frmWebSelectGoodsSupplierDlg: TfrmWebSelectGoodsSupplierDlg
  Left = 0
  Top = 0
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
      TabOrder = 3
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
      TabOrder = 0
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
      TabOrder = 1
      Width = 194
    end
    object cePrice: TcxCalcEdit
      Left = 363
      Top = 101
      EditValue = 0.000000000000000000
      TabOrder = 2
      Width = 78
    end
    object teGoods: TcxTextEdit
      Left = 88
      Top = 13
      TabOrder = 4
      Width = 306
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
      'select goods_code, price1, currency1id from ts_goods_foreign gf '
      'where '
      '  gf.customerid = :customerid and'
      '  gf.goodsid = :goodsid')
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
    Left = 256
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
