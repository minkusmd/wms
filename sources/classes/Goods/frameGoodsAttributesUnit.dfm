object frameGoodsAttributes: TframeGoodsAttributes
  Left = 0
  Top = 0
  Width = 926
  Height = 400
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object pnTop: TPanel
    Left = 0
    Top = 0
    Width = 926
    Height = 40
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object btnSetValue: TcxButton
      Left = 8
      Top = 6
      Width = 130
      Height = 27
      Caption = 'Alege valoarea'
      TabOrder = 0
      OnClick = btnSetValueClick
    end
    object btnClearValue: TcxButton
      Left = 144
      Top = 6
      Width = 130
      Height = 27
      Caption = 'Sterge valoarea'
      TabOrder = 1
      OnClick = btnClearValueClick
    end
    object btnManualValue: TcxButton
      Left = 280
      Top = 6
      Width = 130
      Height = 27
      Caption = 'Valoare manuala'
      TabOrder = 2
      OnClick = btnManualValueClick
    end
  end
  object cxGridAttrs: TcxGrid
    Left = 0
    Top = 40
    Width = 926
    Height = 288
    Align = alClient
    TabOrder = 1
    object cxGridAttrsTable: TcxGridDBTableView
      OnCellDblClick = cxGridAttrsTableCellDblClick
      DataController.DataSource = IBCDataSourceAttrs
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      object cxGridAttrs_FILTERID: TcxGridDBColumn
        Caption = 'Cod'
        DataBinding.FieldName = 'FILTERID'
        HeaderAlignmentHorz = taCenter
        MinWidth = 50
        Options.HorzSizing = False
        Width = 50
      end
      object cxGridAttrs_NAME_RO: TcxGridDBColumn
        Caption = 'Atribut'
        DataBinding.FieldName = 'FILTERNAME'
        Width = 200
      end
      object cxGridAttrs_VALUE_RO: TcxGridDBColumn
        Caption = 'Valoare RO'
        DataBinding.FieldName = 'VALUE_RO_DISP'
        Width = 220
      end
      object cxGridAttrs_VALUE_RU: TcxGridDBColumn
        Caption = 'Valoare RU'
        DataBinding.FieldName = 'VALUE_RU_DISP'
        Width = 220
      end
      object cxGridAttrs_FLG_VARIATION: TcxGridDBColumn
        Caption = 'Variatie'
        DataBinding.FieldName = 'FLG_VARIATION'
        Width = 60
      end
      object cxGridAttrs_FLG_RECOMMENDED: TcxGridDBColumn
        Caption = 'Recomandat'
        DataBinding.FieldName = 'FLG_RECOMMENDED'
        Width = 80
      end
    end
    object cxGridAttrsLevel: TcxGridLevel
      GridView = cxGridAttrsTable
    end
  end
  object pnPreview: TPanel
    Left = 0
    Top = 328
    Width = 926
    Height = 72
    Align = alBottom
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 2
    object lbPreviewRo: TLabel
      Left = 8
      Top = 10
      Width = 3
      Height = 15
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbPreviewRu: TLabel
      Left = 8
      Top = 38
      Width = 3
      Height = 15
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object IBCQueryAttrs: TIBCQuery
    SQL.Strings = (
      'SELECT t.FILTERID, f.FILTERNAME, f.FILTERNAME_RUS,'
      '       f.FLG_VARIATION, t.FLG_RECOMMENDED, f.FLG_MULTI,'
      '       COALESCE(f.FLG_FREE_VALUE, 0) AS FLG_FREE_VALUE,'
      '       t.ORDERNO, gf.ORDERNO AS VAL_ORDERNO,'
      '       gf.FILTERPARAMID, p.PARAM_VALUE, p.PARAM_VALUE_RUS,'
      
        '       TRIM(p.PARAM_VALUE || '#39' '#39' || COALESCE(f.UOM_RO, '#39#39')) AS V' +
        'ALUE_RO_DISP,'
      
        '       TRIM(p.PARAM_VALUE_RUS || '#39' '#39' || COALESCE(f.UOM_RU, '#39#39')) ' +
        'AS VALUE_RU_DISP'
      '  FROM TS_GOODS_TYPE_FILTERS t'
      '  JOIN TS_FILTERS f ON f.FILTERID = t.FILTERID'
      '  LEFT JOIN TS_GOODS_FILTERS gf'
      '         ON gf.FILTERID = t.FILTERID AND gf.GOODSID = :gid'
      
        '  LEFT JOIN TS_FILTER_PARAMS p ON p.FILTERPARAMID = gf.FILTERPAR' +
        'AMID'
      ' WHERE t.GOODSTYPEID = :gtid'
      ' ORDER BY t.ORDERNO, gf.ORDERNO')
    ReadOnly = True
    AutoCommit = False
    Left = 344
    Top = 96
    ParamData = <
      item
        DataType = ftInteger
        Name = 'gid'
        Value = nil
      end
      item
        DataType = ftInteger
        Name = 'gtid'
        Value = nil
      end>
  end
  object IBCDataSourceAttrs: TIBCDataSource
    DataSet = IBCQueryAttrs
    Left = 432
    Top = 96
  end
end
