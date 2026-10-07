object frmSelectCatalogFilterValueDlg: TfrmSelectCatalogFilterValueDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Alege atributul si valoarea'
  ClientHeight = 463
  ClientWidth = 895
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  DesignSize = (
    895
    463)
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 895
    Height = 64
    Title = 'Alege atributul si valoarea'
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
  object cxGridFilters: TcxGrid
    Left = 8
    Top = 100
    Width = 422
    Height = 313
    Anchors = [akLeft, akTop, akBottom]
    TabOrder = 0
    object cxGridFiltersTable: TcxGridDBTableView
      FindPanel.DisplayMode = fpdmAlways
      FindPanel.UseExtendedSyntax = True
      DataController.DataSource = IBCDataSourceFilters
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      object cxGridFilters_FILTERID: TcxGridDBColumn
        Caption = 'Cod'
        DataBinding.FieldName = 'FILTERID'
      end
      object cxGridFilters_FILTERNAME: TcxGridDBColumn
        Caption = 'Atribut RO'
        DataBinding.FieldName = 'FILTERNAME'
        Width = 160
      end
      object cxGridFilters_FILTERNAME_RUS: TcxGridDBColumn
        Caption = 'Atribut RU'
        DataBinding.FieldName = 'FILTERNAME_RUS'
        Width = 160
      end
    end
    object cxGridFiltersLevel: TcxGridLevel
      GridView = cxGridFiltersTable
    end
  end
  object cxGridParams: TcxGrid
    Left = 436
    Top = 70
    Width = 451
    Height = 315
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 1
    object cxGridParamsTable: TcxGridDBTableView
      FindPanel.DisplayMode = fpdmAlways
      FindPanel.UseExtendedSyntax = True
      OnCellDblClick = cxGridParamsTableCellDblClick
      DataController.DataSource = IBCDataSourceParams
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      object cxGridParams_FILTERPARAMID: TcxGridDBColumn
        Caption = 'Cod'
        DataBinding.FieldName = 'FILTERPARAMID'
      end
      object cxGridParams_PARAM_VALUE: TcxGridDBColumn
        Caption = 'Valoare RO'
        DataBinding.FieldName = 'PARAM_VALUE'
        Width = 160
      end
      object cxGridParams_PARAM_VALUE_RUS: TcxGridDBColumn
        Caption = 'Valoare RU'
        DataBinding.FieldName = 'PARAM_VALUE_RUS'
        Width = 160
      end
    end
    object cxGridParamsLevel: TcxGridLevel
      GridView = cxGridParamsTable
    end
  end
  object btnOk: TcxButton
    Left = 701
    Top = 424
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TcxButton
    Left = 797
    Top = 424
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
  object cxButtonEdit1: TcxButtonEdit
    Left = 440
    Top = 388
    Properties.Buttons = <
      item
        Default = True
        Kind = bkEllipsis
      end>
    Properties.OnButtonClick = cxButtonEdit1PropertiesButtonClick
    TabOrder = 5
    Text = 'cxButtonEdit1'
    Width = 451
  end
  object lbGoodsType: TLabel
    Left = 8
    Top = 72
    Width = 54
    Height = 15
    Caption = 'Categorie:'
  end
  object cxLookupGoodsType: TcxExtLookupComboBox
    Left = 72
    Top = 68
    Properties.ClearKey = 46
    Properties.DropDownHeight = 420
    Properties.DropDownListStyle = lsFixedList
    Properties.DropDownSizeable = True
    Properties.DropDownWidth = 640
    Properties.FocusPopup = True
    Properties.ImmediatePost = True
    Properties.View = cxGridGoodsTypeView
    Properties.KeyFieldNames = 'GOODSTYPEID'
    Properties.ListFieldItem = cxGridGoodsType_TITLE
    Properties.OnEditValueChanged = cxLookupGoodsTypePropertiesEditValueChanged
    TabOrder = 6
    Width = 358
  end
  object IBCQueryFilters: TIBCQuery
    SQL.Strings = (
      'WITH P AS ('
      '  SELECT CAST(:GOODSTYPEID AS INTEGER) AS GTID'
      '  FROM RDB$DATABASE)'
      'SELECT f.FILTERID, f.FILTERNAME, f.FILTERNAME_RUS'
      'FROM P'
      'CROSS JOIN TS_FILTERS f'
      'LEFT JOIN TS_GOODS_TYPE_FILTERS t'
      '       ON t.FILTERID = f.FILTERID'
      '      AND t.GOODSTYPEID = P.GTID'
      'WHERE COALESCE(f.FLG_FOLDER, 0) = 0'

      '  AND (P.GTID IS NULL OR t.FILTERID IS NOT NULL)'
      'ORDER BY t.ORDERNO NULLS LAST, f.FILTERNAME')
    AutoCommit = False
    Left = 48
    Top = 120
    ParamData = <
      item
        DataType = ftInteger
        Name = 'GOODSTYPEID'
        Value = nil
      end>
  end
  object IBCDataSourceFilters: TIBCDataSource
    DataSet = IBCQueryFilters
    Left = 128
    Top = 120
  end
  object IBCQueryParams: TIBCQuery
    SQL.Strings = (
      'SELECT FILTERPARAMID, FILTERID, PARAM_VALUE, PARAM_VALUE_RUS'
      'FROM TS_FILTER_PARAMS'
      'WHERE FILTERID = :FILTERID'
      'ORDER BY PARAM_VALUE')
    MasterSource = IBCDataSourceFilters
    AutoCommit = False
    Left = 400
    Top = 120
    ParamData = <
      item
        DataType = ftInteger
        Name = 'FILTERID'
        Value = nil
      end>
  end
  object IBCDataSourceParams: TIBCDataSource
    DataSet = IBCQueryParams
    Left = 480
    Top = 120
  end
  object IBCQueryGoodsType: TIBCQuery
    SQL.Strings = (
      'SELECT g.GOODSTYPEID, g.TITLE, g.TITLE_RUS,'
      '       (SELECT COUNT(*) FROM TS_GOODS_TYPE_FILTERS t'
      '         WHERE t.GOODSTYPEID = g.GOODSTYPEID) AS FILTERS_CNT'
      'FROM TS_GOODS_TYPE g'
      'ORDER BY g.TITLE')
    AutoCommit = False
    Left = 48
    Top = 200
  end
  object IBCDataSourceGoodsType: TIBCDataSource
    DataSet = IBCQueryGoodsType
    Left = 128
    Top = 200
  end
  object cxGridViewRepository: TcxGridViewRepository
    Left = 224
    Top = 200
    object cxGridGoodsTypeView: TcxGridDBTableView
      FindPanel.DisplayMode = fpdmAlways
      FindPanel.UseExtendedSyntax = True
      DataController.DataSource = IBCDataSourceGoodsType
      DataController.KeyFieldNames = 'GOODSTYPEID'
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      object cxGridGoodsType_GOODSTYPEID: TcxGridDBColumn
        Caption = 'Cod'
        DataBinding.FieldName = 'GOODSTYPEID'
        Width = 60
      end
      object cxGridGoodsType_TITLE: TcxGridDBColumn
        Caption = 'Categorie RO'
        DataBinding.FieldName = 'TITLE'
        Width = 250
      end
      object cxGridGoodsType_TITLE_RUS: TcxGridDBColumn
        Caption = 'Categorie RU'
        DataBinding.FieldName = 'TITLE_RUS'
        Width = 250
      end
      object cxGridGoodsType_FILTERS_CNT: TcxGridDBColumn
        Caption = 'Filtre'
        DataBinding.FieldName = 'FILTERS_CNT'
        Width = 50
      end
    end
  end
end
