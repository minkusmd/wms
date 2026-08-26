object frmGoodsTypeFiltersDlg: TfrmGoodsTypeFiltersDlg
  Left = 0
  Top = 0
  Caption = 'Sablon de filtre'
  ClientHeight = 800
  ClientWidth = 1040
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  TextHeight = 15
  object Splitter1: TSplitter
    Left = 660
    Top = 64
    Height = 488
  end
  object DialogTitle1: TDialogTitle
    Left = 0
    Top = 0
    Width = 1040
    Height = 64
    Title = 'Sablon de filtre'
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
  object pnBottom: TPanel
    Left = 0
    Top = 752
    Width = 1040
    Height = 48
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      1040
      48)
    object btnOk: TcxButton
      Left = 826
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
      Left = 922
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
  object pnLeft: TPanel
    Left = 0
    Top = 64
    Width = 660
    Height = 488
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 1
    object lbTmpl: TLabel
      Left = 0
      Top = 0
      Width = 660
      Height = 15
      Align = alTop
      Caption = '  Filtrele tipului (sablon)'
      Layout = tlCenter
    end
    object cxGridTmpl: TcxGrid
      Left = 0
      Top = 15
      Width = 660
      Height = 433
      Align = alClient
      TabOrder = 0
      object cxGridTmplTable: TcxGridDBTableView
        DataController.DataSource = IBCDataSourceTemplate
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsView.GroupByBox = False
        object cxGridTmpl_FILTERNAME: TcxGridDBColumn
          Caption = 'Filtru RO'
          DataBinding.FieldName = 'FILTERNAME'
          Width = 220
        end
        object cxGridTmpl_FILTERNAME_RUS: TcxGridDBColumn
          Caption = 'Filtru RU'
          DataBinding.FieldName = 'FILTERNAME_RUS'
          Width = 180
        end
        object cxGridTmpl_FLG_RECOMMENDED: TcxGridDBColumn
          Caption = 'Recom.'
          DataBinding.FieldName = 'FLG_RECOMMENDED'
          Width = 60
        end
        object cxGridTmpl_COVERAGE_PCT: TcxGridDBColumn
          Caption = 'Acoperire %'
          DataBinding.FieldName = 'COVERAGE_PCT'
          Width = 80
        end
        object cxGridTmpl_FLG_AUTO: TcxGridDBColumn
          Caption = 'Auto'
          DataBinding.FieldName = 'FLG_AUTO'
          Width = 45
        end
        object cxGridTmpl_FLG_MULTI: TcxGridDBColumn
          Caption = 'Multi'
          DataBinding.FieldName = 'FLG_MULTI'
          Width = 45
        end
        object cxGridTmpl_UOM_RO: TcxGridDBColumn
          Caption = 'UM'
          DataBinding.FieldName = 'UOM_RO'
          Width = 50
        end
      end
      object cxGridTmplLevel: TcxGridLevel
        GridView = cxGridTmplTable
      end
    end
    object pnTmplButtons: TPanel
      Left = 0
      Top = 448
      Width = 660
      Height = 40
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      object btnTmplAdd: TcxButton
        Left = 4
        Top = 6
        Width = 100
        Height = 27
        Caption = 'Adauga filtru'
        TabOrder = 0
        OnClick = btnTmplAddClick
      end
      object btnTmplRemove: TcxButton
        Left = 110
        Top = 6
        Width = 90
        Height = 27
        Caption = 'Scoate'
        TabOrder = 1
        OnClick = btnTmplRemoveClick
      end
      object btnTmplRecommend: TcxButton
        Left = 206
        Top = 6
        Width = 100
        Height = 27
        Caption = 'Recomandat'
        TabOrder = 2
        OnClick = btnTmplRecommendClick
      end
      object btnTmplUp: TcxButton
        Left = 312
        Top = 6
        Width = 45
        Height = 27
        Caption = 'Sus'
        TabOrder = 3
        OnClick = btnTmplUpClick
      end
      object btnTmplDown: TcxButton
        Left = 363
        Top = 6
        Width = 45
        Height = 27
        Caption = 'Jos'
        TabOrder = 4
        OnClick = btnTmplDownClick
      end
      object btnTmplGenerate: TcxButton
        Left = 420
        Top = 6
        Width = 150
        Height = 27
        Caption = 'Genereaza din produse'
        TabOrder = 5
        OnClick = btnTmplGenerateClick
      end
    end
  end
  object pnRight: TPanel
    Left = 663
    Top = 64
    Width = 377
    Height = 488
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object lbVal: TLabel
      Left = 0
      Top = 0
      Width = 377
      Height = 15
      Align = alTop
      Caption = '  Valorile filtrului selectat'
      Layout = tlCenter
    end
    object cxGridVal: TcxGrid
      Left = 0
      Top = 15
      Width = 377
      Height = 433
      Align = alClient
      TabOrder = 0
      object cxGridValTable: TcxGridDBTableView
        DataController.DataSource = IBCDataSourceParams
        OptionsData.Deleting = False
        OptionsData.Inserting = False
        OptionsView.GroupByBox = False
        object cxGridVal_PARAM_VALUE: TcxGridDBColumn
          Caption = 'Valoare RO'
          DataBinding.FieldName = 'PARAM_VALUE'
          Width = 180
        end
        object cxGridVal_PARAM_VALUE_RUS: TcxGridDBColumn
          Caption = 'Valoare RU'
          DataBinding.FieldName = 'PARAM_VALUE_RUS'
          Width = 180
        end
      end
      object cxGridValLevel: TcxGridLevel
        GridView = cxGridValTable
      end
    end
    object pnValButtons: TPanel
      Left = 0
      Top = 448
      Width = 377
      Height = 40
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      object btnValNew: TcxButton
        Left = 4
        Top = 6
        Width = 110
        Height = 27
        Caption = 'Valoare noua'
        TabOrder = 0
        OnClick = btnValNewClick
      end
      object btnValDelete: TcxButton
        Left = 120
        Top = 6
        Width = 90
        Height = 27
        Caption = 'Sterge'
        TabOrder = 1
        OnClick = btnValDeleteClick
      end
    end
  end
  object pnName: TPanel
    Left = 0
    Top = 552
    Width = 1040
    Height = 200
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    object lbName: TLabel
      Left = 0
      Top = 0
      Width = 1040
      Height = 15
      Align = alTop
      Caption = '  Template-uri de denumire (compun denumirea produsului din filtre)'
      Layout = tlCenter
    end
    object cxGridName: TcxGrid
      Left = 0
      Top = 15
      Width = 800
      Height = 145
      TabOrder = 0
      object cxGridNameTable: TcxGridDBTableView
        DataController.DataSource = IBCDataSourceNameTmpl
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsView.GroupByBox = False
        object cxGridName_CONTEXT: TcxGridDBColumn
          Caption = 'Context'
          DataBinding.FieldName = 'CONTEXT'
          Width = 80
        end
        object cxGridName_TEMPLATE_RO: TcxGridDBColumn
          Caption = 'Template RO'
          DataBinding.FieldName = 'TEMPLATE_RO'
          Width = 360
        end
        object cxGridName_TEMPLATE_RU: TcxGridDBColumn
          Caption = 'Template RU'
          DataBinding.FieldName = 'TEMPLATE_RU'
          Width = 340
        end
      end
      object cxGridNameLevel: TcxGridLevel
        GridView = cxGridNameTable
      end
    end
    object cxMemoPlaceholders: TcxMemo
      Left = 800
      Top = 15
      Align = alRight
      Lines.Strings = (
        '{goods_type_name}'
        '{brand_name}'
        '{code}'
        '{base_param}'
        '{attr:Denumire filtru}')
      TabOrder = 1
      Height = 145
      Width = 240
    end
    object pnNameButtons: TPanel
      Left = 0
      Top = 160
      Width = 1040
      Height = 40
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 2
      object btnNameNew: TcxButton
        Left = 4
        Top = 6
        Width = 90
        Height = 27
        Caption = 'Nou'
        TabOrder = 0
        OnClick = btnNameNewClick
      end
      object btnNameEdit: TcxButton
        Left = 100
        Top = 6
        Width = 90
        Height = 27
        Caption = 'Modifica'
        TabOrder = 1
        OnClick = btnNameEditClick
      end
      object btnNameDelete: TcxButton
        Left = 196
        Top = 6
        Width = 90
        Height = 27
        Caption = 'Sterge'
        TabOrder = 2
        OnClick = btnNameDeleteClick
      end
    end
  end
  object IBCQueryNameTmpl: TIBCQuery
    KeyFields = 'TEMPLATEID'
    KeyGenerator = 'SQ_TS_GOODS_NAME_TEMPLATE_ID'
    Connection = dmDB.IBCConnection
    Transaction = IBCTransactionUpdate
    UpdateTransaction = IBCTransactionUpdate
    SQL.Strings = (
      'SELECT * FROM TS_GOODS_NAME_TEMPLATE'
      'WHERE GOODS_TYPE_ID = :gtid'
      'ORDER BY CONTEXT')
    Left = 560
    Top = 120
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'gtid'
        Value = nil
      end>
  end
  object IBCDataSourceNameTmpl: TIBCDataSource
    DataSet = IBCQueryNameTmpl
    Left = 640
    Top = 120
  end
  object IBCTransactionUpdate: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 40
    Top = 120
  end
  object IBCQueryTemplate: TIBCQuery
    KeyFields = 'GOODSTYPEID;FILTERID'
    Connection = dmDB.IBCConnection
    Transaction = IBCTransactionUpdate
    UpdateTransaction = IBCTransactionUpdate
    SQL.Strings = (
      'SELECT t.GOODSTYPEID, t.FILTERID, t.ORDERNO, t.FLG_RECOMMENDED,'
      '       t.FLG_AUTO, t.COVERAGE_PCT,'
      '       f.FILTERNAME, f.FILTERNAME_RUS, f.FLG_MULTI, f.FLG_IN_NAME,'
      '       f.FLG_VARIATION, f.FLG_FILTERABLE, f.FLG_FREE_VALUE, f.UOM_RO'
      '  FROM TS_GOODS_TYPE_FILTERS t'
      '  JOIN TS_FILTERS f ON f.FILTERID = t.FILTERID'
      ' WHERE t.GOODSTYPEID = :gtid'
      ' ORDER BY t.ORDERNO')
    ReadOnly = True
    Left = 120
    Top = 120
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'gtid'
        Value = nil
      end>
  end
  object IBCDataSourceTemplate: TIBCDataSource
    DataSet = IBCQueryTemplate
    Left = 200
    Top = 120
  end
  object IBCQueryParams: TIBCQuery
    KeyFields = 'FILTERPARAMID'
    KeyGenerator = 'SQ_TS_FILTER_PARAMS_ID'
    Connection = dmDB.IBCConnection
    Transaction = IBCTransactionUpdate
    UpdateTransaction = IBCTransactionUpdate
    SQL.Strings = (
      'SELECT * FROM TS_FILTER_PARAMS'
      'WHERE FILTERID = :FILTERID'
      'ORDER BY ORDERNO')
    MasterSource = IBCDataSourceTemplate
    AfterInsert = IBCQueryParamsNewRecord
    Left = 320
    Top = 120
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'FILTERID'
        Value = nil
      end>
  end
  object IBCDataSourceParams: TIBCDataSource
    DataSet = IBCQueryParams
    Left = 400
    Top = 120
  end
  object IBCSQLExec: TIBCSQL
    Connection = dmDB.IBCConnection
    Transaction = IBCTransactionUpdate
    Left = 480
    Top = 120
  end
end
