object frmSelectCatalogFilterValueDlg: TfrmSelectCatalogFilterValueDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Alege atributul si valoarea'
  ClientHeight = 460
  ClientWidth = 700
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  DesignSize = (
    700
    460)
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 700
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
    Top = 72
    Width = 336
    Height = 340
    Anchors = [akLeft, akTop, akBottom]
    TabOrder = 0
    object cxGridFiltersTable: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = IBCDataSourceFilters
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
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
    Left = 352
    Top = 72
    Width = 340
    Height = 340
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 1
    object cxGridParamsTable: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      OnCellDblClick = cxGridParamsTableCellDblClick
      DataController.DataSource = IBCDataSourceParams
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
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
    Left = 506
    Top = 421
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TcxButton
    Left = 602
    Top = 421
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
  object IBCQueryFilters: TIBCQuery
    SQL.Strings = (
      'SELECT FILTERID, FILTERNAME, FILTERNAME_RUS'
      'FROM TS_FILTERS'
      'WHERE COALESCE(FLG_FOLDER, 0) = 0'
      'ORDER BY FILTERNAME')
    AutoCommit = False
    Left = 48
    Top = 120
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
end
