object frmSelectFilterDlg: TfrmSelectFilterDlg
  Left = 0
  Top = 0
  Caption = 'Alegeti filtrul'
  ClientHeight = 520
  ClientWidth = 760
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
    Width = 760
    Height = 64
    Title = 'Alegeti filtrul'
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
  object pnTop: TPanel
    Left = 0
    Top = 64
    Width = 760
    Height = 40
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object lbSearch: TLabel
      Left = 8
      Top = 12
      Width = 62
      Height = 15
      Caption = 'Denumire:'
    end
    object edSearch: TcxTextEdit
      Left = 80
      Top = 8
      TabOrder = 0
      Width = 400
      OnKeyDown = edSearchKeyDown
    end
    object btnSearch: TcxButton
      Left = 492
      Top = 7
      Width = 90
      Height = 27
      Caption = 'Cauta'
      TabOrder = 1
      OnClick = btnSearchClick
    end
  end
  object cxGridFlt: TcxGrid
    Left = 0
    Top = 104
    Width = 760
    Height = 368
    Align = alClient
    TabOrder = 1
    object cxGridFltTable: TcxGridDBTableView
      OnDblClick = cxGridFltTableDblClick
      DataController.DataSource = IBCDataSourceFilters
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsView.GroupByBox = False
      object cxGridFlt_FILTERID: TcxGridDBColumn
        Caption = 'ID'
        DataBinding.FieldName = 'FILTERID'
        Width = 60
      end
      object cxGridFlt_FILTERNAME: TcxGridDBColumn
        Caption = 'Denumire RO'
        DataBinding.FieldName = 'FILTERNAME'
        Width = 280
      end
      object cxGridFlt_FILTERNAME_RUS: TcxGridDBColumn
        Caption = 'Denumire RU'
        DataBinding.FieldName = 'FILTERNAME_RUS'
        Width = 240
      end
      object cxGridFlt_PRODUSE_TIP: TcxGridDBColumn
        Caption = 'Produse tip'
        DataBinding.FieldName = 'PRODUSE_TIP'
        Width = 90
      end
    end
    object cxGridFltLevel: TcxGridLevel
      GridView = cxGridFltTable
    end
  end
  object pnBottom: TPanel
    Left = 0
    Top = 472
    Width = 760
    Height = 48
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    DesignSize = (
      760
      48)
    object btnOk: TcxButton
      Left = 546
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
      Left = 642
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
  object IBCTransactionSelect: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 40
    Top = 152
  end
  object IBCQueryFilters: TIBCQuery
    KeyFields = 'FILTERID'
    Connection = dmDB.IBCConnection
    Transaction = IBCTransactionSelect
    SQL.Strings = (
      'SELECT f.FILTERID, f.FILTERNAME, f.FILTERNAME_RUS,'
      '       (SELECT COUNT(DISTINCT gf.GOODSID)'
      '          FROM TS_GOODS_FILTERS gf'
      '          JOIN TS_GOODS g ON g.GOODSID = gf.GOODSID'
      '         WHERE gf.FILTERID = f.FILTERID'
      '           AND g.WEBGOODSTYPE_ID = :gtid) AS PRODUSE_TIP'
      '  FROM TS_FILTERS f'
      ' WHERE COALESCE(f.FLG_FOLDER, 0) = 0'
      '   AND UPPER(f.FILTERNAME) LIKE :flt'
      ' ORDER BY 4 DESC, f.FILTERNAME')
    Left = 120
    Top = 152
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'gtid'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'flt'
        Value = nil
      end>
  end
  object IBCDataSourceFilters: TIBCDataSource
    DataSet = IBCQueryFilters
    Left = 200
    Top = 152
  end
end
