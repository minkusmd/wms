object frmGoodsTypeServicesDlg: TfrmGoodsTypeServicesDlg
  Left = 0
  Top = 0
  Caption = 'Servicii adiacente'
  ClientHeight = 540
  ClientWidth = 980
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  TextHeight = 15
  object DialogTitle1: TDialogTitle
    Left = 0
    Top = 0
    Width = 980
    Height = 64
    Title = 'Servicii adiacente'
    Text = ''
    FontTitle.Charset = DEFAULT_CHARSET
    FontTitle.Color = clWindowText
    FontTitle.Height = -13
    FontTitle.Name = 'Segoe UI'
    FontTitle.Style = [fsBold]
    FontText.Charset = DEFAULT_CHARSET
    FontText.Color = clWindowText
    FontText.Height = -12
    FontText.Name = 'Segoe UI'
    FontText.Style = []
    ImageList = dmAdditions.cxImageList_DialogIcons
    ImageIndex = 16
  end
  object pnButtons: TPanel
    Left = 0
    Top = 64
    Width = 980
    Height = 64
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object lbInfo: TLabel
      Left = 8
      Top = 40
      Width = 960
      Height = 18
      AutoSize = False
      Caption =
        'Serviciile de aici se propun la toate produsele acestui tip. Pret' +
        ' gol = pretul serviciului din nomenclator. Pentru preturi diferit' +
        'e pe produse folositi "Preturi pe produse".'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGrayText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object btnNew: TcxButton
      Left = 8
      Top = 6
      Width = 90
      Height = 27
      Caption = 'Adauga'
      TabOrder = 0
      OnClick = btnNewClick
    end
    object btnEdit: TcxButton
      Left = 104
      Top = 6
      Width = 90
      Height = 27
      Caption = 'Modifica'
      TabOrder = 1
      OnClick = btnEditClick
    end
    object btnDelete: TcxButton
      Left = 200
      Top = 6
      Width = 90
      Height = 27
      Caption = 'Sterge'
      TabOrder = 2
      OnClick = btnDeleteClick
    end
    object btnProductPrices: TcxButton
      Left = 312
      Top = 6
      Width = 160
      Height = 27
      Caption = 'Preturi pe produse...'
      TabOrder = 3
      OnClick = btnProductPricesClick
    end
  end
  object cxGridServices: TcxGrid
    Left = 0
    Top = 128
    Width = 980
    Height = 364
    Align = alClient
    TabOrder = 1
    object cxGridServicesTable: TcxGridDBTableView
      OnCellDblClick = cxGridServicesTableCellDblClick
      DataController.DataSource = IBCDataSourceServices
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      object colTitle: TcxGridDBColumn
        Caption = 'Serviciu'
        DataBinding.FieldName = 'SERVICE_TITLE'
        Width = 300
      end
      object colStdPrice: TcxGridDBColumn
        Caption = 'Pret nomenclator'
        DataBinding.FieldName = 'STD_PRICE'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        Width = 100
      end
      object colPrice: TcxGridDBColumn
        Caption = 'Pret regula'
        DataBinding.FieldName = 'PRICE'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        Width = 90
      end
      object colCurrency: TcxGridDBColumn
        Caption = 'Valuta'
        DataBinding.FieldName = 'CURRENCY_TITLE'
        HeaderAlignmentHorz = taCenter
        Width = 60
      end
      object colPercent: TcxGridDBColumn
        Caption = '+ %'
        DataBinding.FieldName = 'PRICE_PERCENT'
        HeaderAlignmentHorz = taCenter
        Width = 60
      end
      object colDefault: TcxGridDBColumn
        Caption = 'Implicit'
        DataBinding.FieldName = 'FLG_DEFAULT'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.NullStyle = nssUnchecked
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        HeaderAlignmentHorz = taCenter
        Width = 60
      end
      object colRequired: TcxGridDBColumn
        Caption = 'Obligatoriu'
        DataBinding.FieldName = 'FLG_REQUIRED'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.NullStyle = nssUnchecked
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        HeaderAlignmentHorz = taCenter
        Width = 70
      end
      object colOrderNo: TcxGridDBColumn
        Caption = 'Ordine'
        DataBinding.FieldName = 'ORDERNO'
        HeaderAlignmentHorz = taCenter
        Width = 50
      end
      object colOverrides: TcxGridDBColumn
        Caption = 'Preturi pe produse'
        DataBinding.FieldName = 'N_OVERRIDES'
        HeaderAlignmentHorz = taCenter
        Width = 110
      end
      object colNote: TcxGridDBColumn
        Caption = 'Nota'
        DataBinding.FieldName = 'NOTE'
        Width = 150
      end
    end
    object cxGridServicesLevel: TcxGridLevel
      GridView = cxGridServicesTable
    end
  end
  object pnBottom: TPanel
    Left = 0
    Top = 492
    Width = 980
    Height = 48
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    DesignSize = (
      980
      48)
    object btnOk: TcxButton
      Left = 778
      Top = 9
      Width = 90
      Height = 29
      Anchors = [akRight, akBottom]
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
    object btnCancel: TcxButton
      Left = 874
      Top = 9
      Width = 90
      Height = 29
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = 'Renunta'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object IBCTransactionUpdate: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 40
    Top = 200
  end
  object IBCQueryServices: TIBCQuery
    KeyFields = 'GSID'
    KeyGenerator = 'SQ_TS_GOODS_SERVICE_ID'
    UpdatingTable = 'TS_GOODS_SERVICE'
    SQLInsert.Strings = (
      'INSERT INTO TS_GOODS_SERVICE'
      '  (GSID, GOODSTYPEID, GOODSID, SERVICE_GOODSID, PRICE, CURRENCYID,'
      '   PRICE_PERCENT, FLG_DEFAULT, FLG_REQUIRED, FLG_DISABLED, ORDERNO, NOTE)'
      'VALUES'
      '  (:GSID, :GOODSTYPEID, :GOODSID, :SERVICE_GOODSID, :PRICE, :CURRENCYID,'
      '   :PRICE_PERCENT, :FLG_DEFAULT, :FLG_REQUIRED, :FLG_DISABLED, :ORDERNO, :NOTE)')
    SQLDelete.Strings = (
      'DELETE FROM TS_GOODS_SERVICE WHERE GSID = :Old_GSID')
    SQLUpdate.Strings = (
      'UPDATE TS_GOODS_SERVICE SET'
      '  SERVICE_GOODSID = :SERVICE_GOODSID, PRICE = :PRICE, CURRENCYID = :CURRENCYID,'
      '  PRICE_PERCENT = :PRICE_PERCENT, FLG_DEFAULT = :FLG_DEFAULT,'
      '  FLG_REQUIRED = :FLG_REQUIRED, FLG_DISABLED = :FLG_DISABLED,'
      '  ORDERNO = :ORDERNO, NOTE = :NOTE'
      'WHERE GSID = :Old_GSID')
    Connection = dmDB.IBCConnection
    Transaction = IBCTransactionUpdate
    UpdateTransaction = IBCTransactionUpdate
    SQL.Strings = (
      'SELECT s.GSID, s.GOODSTYPEID, s.GOODSID, s.SERVICE_GOODSID, s.PRICE,'
      '       s.CURRENCYID, s.PRICE_PERCENT, s.FLG_DEFAULT, s.FLG_REQUIRED,'
      '       s.FLG_DISABLED, s.ORDERNO, s.NOTE,'
      '       g.TITLE AS SERVICE_TITLE,'
      '       gp.PRICE1 AS STD_PRICE,'
      '       c.TITLE AS CURRENCY_TITLE,'
      '       (SELECT COUNT(*) FROM TS_GOODS_SERVICE p'
      '          JOIN TS_GOODS pg ON pg.GOODSID = p.GOODSID'
      '         WHERE p.SERVICE_GOODSID = s.SERVICE_GOODSID'
      '           AND pg.WEBGOODSTYPE_ID = s.GOODSTYPEID) AS N_OVERRIDES'
      '  FROM TS_GOODS_SERVICE s'
      '  JOIN TS_GOODS g ON g.GOODSID = s.SERVICE_GOODSID'
      '  LEFT JOIN TS_GOODS_PRICE gp ON gp.GOODSID = s.SERVICE_GOODSID'
      '  LEFT JOIN TS_CURRENCY c ON c.CURRENCYID = s.CURRENCYID'
      ' WHERE s.GOODSTYPEID = :gtid'
      ' ORDER BY s.ORDERNO, g.TITLE')
    AutoCommit = False
    Left = 40
    Top = 256
    ParamData = <
      item
        DataType = ftInteger
        Name = 'gtid'
        Value = nil
      end>
  end
  object IBCDataSourceServices: TIBCDataSource
    DataSet = IBCQueryServices
    Left = 144
    Top = 256
  end
end
