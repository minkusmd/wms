object frameGoodsServices: TframeGoodsServices
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
    Height = 60
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object lbInfo: TLabel
      Left = 8
      Top = 38
      Width = 3
      Height = 15
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGrayText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object btnAdd: TcxButton
      Left = 8
      Top = 6
      Width = 130
      Height = 27
      Caption = 'Adauga serviciu'
      TabOrder = 0
      OnClick = btnAddClick
    end
    object btnEdit: TcxButton
      Left = 144
      Top = 6
      Width = 130
      Height = 27
      Caption = 'Modifica / Pret propriu'
      TabOrder = 1
      OnClick = btnEditClick
    end
    object btnDelete: TcxButton
      Left = 280
      Top = 6
      Width = 170
      Height = 27
      Caption = 'Sterge / Ascunde'
      TabOrder = 2
      OnClick = btnDeleteClick
    end
  end
  object cxGridSvc: TcxGrid
    Left = 0
    Top = 60
    Width = 926
    Height = 340
    Align = alClient
    TabOrder = 1
    object cxGridSvcTable: TcxGridDBTableView
      OnCellDblClick = cxGridSvcTableCellDblClick
      DataController.DataSource = IBCDataSourceView
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      object colTitle: TcxGridDBColumn
        Caption = 'Serviciu'
        DataBinding.FieldName = 'SERVICE_TITLE'
        Width = 260
      end
      object colSource: TcxGridDBColumn
        Caption = 'Sursa'
        DataBinding.FieldName = 'SOURCE_TEXT'
        Width = 110
      end
      object colPrice: TcxGridDBColumn
        Caption = 'Pret regula'
        DataBinding.FieldName = 'PRICE'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        Width = 80
      end
      object colCurrency: TcxGridDBColumn
        Caption = 'Valuta'
        DataBinding.FieldName = 'CURRENCY_TITLE'
        HeaderAlignmentHorz = taCenter
        Width = 50
      end
      object colPercent: TcxGridDBColumn
        Caption = '+ %'
        DataBinding.FieldName = 'PRICE_PERCENT'
        HeaderAlignmentHorz = taCenter
        Width = 50
      end
      object colFinalPrice: TcxGridDBColumn
        Caption = 'Pret final, MDL'
        DataBinding.FieldName = 'FINAL_PRICE'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        Width = 90
      end
      object colDefault: TcxGridDBColumn
        Caption = 'Implicit'
        DataBinding.FieldName = 'FLG_DEFAULT'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.NullStyle = nssUnchecked
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        HeaderAlignmentHorz = taCenter
        Width = 55
      end
      object colRequired: TcxGridDBColumn
        Caption = 'Obligatoriu'
        DataBinding.FieldName = 'FLG_REQUIRED'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.NullStyle = nssUnchecked
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        HeaderAlignmentHorz = taCenter
        Width = 65
      end
      object colOrderNo: TcxGridDBColumn
        Caption = 'Ordine'
        DataBinding.FieldName = 'ORDERNO'
        HeaderAlignmentHorz = taCenter
        Width = 45
      end
      object colNote: TcxGridDBColumn
        Caption = 'Nota'
        DataBinding.FieldName = 'NOTE'
        Width = 120
      end
    end
    object cxGridSvcLevel: TcxGridLevel
      GridView = cxGridSvcTable
    end
  end
  object IBCQueryView: TIBCQuery
    ReadOnly = True
    AutoCommit = False
    Left = 344
    Top = 136
  end
  object IBCDataSourceView: TIBCDataSource
    DataSet = IBCQueryView
    OnDataChange = IBCDataSourceViewDataChange
    Left = 440
    Top = 136
  end
  object IBCQueryRules: TIBCQuery
    AutoCommit = False
    Left = 344
    Top = 200
  end
  object IBCDataSourceRules: TIBCDataSource
    DataSet = IBCQueryRules
    Left = 440
    Top = 200
  end
end
