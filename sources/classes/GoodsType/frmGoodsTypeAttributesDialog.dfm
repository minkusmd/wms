object frmGoodsTypeAttributesDlg: TfrmGoodsTypeAttributesDlg
  Left = 0
  Top = 0
  Caption = 'Atribute si template-uri'
  ClientHeight = 640
  ClientWidth = 1000
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  TextHeight = 15
  object Splitter1: TSplitter
    Left = 460
    Top = 64
    Height = 328
  end
  object DialogTitle1: TDialogTitle
    Left = 0
    Top = 0
    Width = 1000
    Height = 64
    Title = 'Atribute si template-uri'
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
    Top = 592
    Width = 1000
    Height = 48
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      1000
      48)
    object btnOk: TcxButton
      Left = 786
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
      Left = 882
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
  object pnTmpl: TPanel
    Left = 0
    Top = 392
    Width = 1000
    Height = 200
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object lbTmpl: TLabel
      Left = 0
      Top = 0
      Width = 1000
      Height = 15
      Align = alTop
      Caption = '  Template-uri denumire'
      Layout = tlCenter
      ExplicitWidth = 128
    end
    object cxGridTmpl: TcxGrid
      Left = 0
      Top = 15
      Width = 815
      Height = 145
      Align = alClient
      TabOrder = 0
      ExplicitWidth = 1000
      object cxGridTmplTable: TcxGridDBTableView
        DataController.DataSource = IBCDataSourceTemplates
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsView.GroupByBox = False
        object cxGridTmpl_CONTEXT: TcxGridDBColumn
          Caption = 'Context'
          DataBinding.FieldName = 'CONTEXT'
          Width = 120
        end
        object cxGridTmpl_TEMPLATE_RO: TcxGridDBColumn
          Caption = 'Template RO'
          DataBinding.FieldName = 'TEMPLATE_RO'
          Width = 400
        end
        object cxGridTmpl_TEMPLATE_RU: TcxGridDBColumn
          Caption = 'Template RU'
          DataBinding.FieldName = 'TEMPLATE_RU'
          Width = 400
        end
      end
      object cxGridTmplLevel: TcxGridLevel
        GridView = cxGridTmplTable
      end
    end
    object pnTmplButtons: TPanel
      Left = 0
      Top = 160
      Width = 1000
      Height = 40
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      object btnTmplNew: TcxButton
        Left = 8
        Top = 6
        Width = 90
        Height = 27
        Caption = 'Adauga'
        TabOrder = 0
        OnClick = btnTmplNewClick
      end
      object btnTmplEdit: TcxButton
        Left = 104
        Top = 6
        Width = 90
        Height = 27
        Caption = 'Modifica'
        TabOrder = 1
        OnClick = btnTmplEditClick
      end
      object btnTmplDelete: TcxButton
        Left = 200
        Top = 6
        Width = 90
        Height = 27
        Caption = 'Sterge'
        TabOrder = 2
        OnClick = btnTmplDeleteClick
      end
    end
    object cxMemo1: TcxMemo
      Left = 815
      Top = 15
      Align = alRight
      Lines.Strings = (
        '{goods_type_name}'
        '{brand_name}'
        '{code}'
        '{base_param}')
      TabOrder = 2
      ExplicitLeft = 778
      ExplicitTop = 3
      Height = 145
      Width = 185
    end
  end
  object pnLeft: TPanel
    Left = 0
    Top = 64
    Width = 460
    Height = 328
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 2
    object lbAttr: TLabel
      Left = 0
      Top = 0
      Width = 460
      Height = 15
      Align = alTop
      Caption = '  Atribute'
      Layout = tlCenter
      ExplicitWidth = 49
    end
    object cxGridAttr: TcxGrid
      Left = 0
      Top = 15
      Width = 460
      Height = 273
      Align = alClient
      TabOrder = 0
      object cxGridAttrTable: TcxGridDBTableView
        DataController.DataSource = IBCDataSourceAttributes
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsView.GroupByBox = False
        object cxGridAttr_NAME_RO: TcxGridDBColumn
          Caption = 'Denumire RO'
          DataBinding.FieldName = 'NAME_RO'
          Width = 160
        end
        object cxGridAttr_NAME_RU: TcxGridDBColumn
          Caption = 'Denumire RU'
          DataBinding.FieldName = 'NAME_RU'
          Width = 160
        end
        object cxGridAttr_FLG_FILTERABLE: TcxGridDBColumn
          Caption = 'Filtru'
          DataBinding.FieldName = 'FLG_FILTERABLE'
          Width = 50
        end
        object cxGridAttr_FLG_VARIATION: TcxGridDBColumn
          Caption = 'Var.'
          DataBinding.FieldName = 'FLG_VARIATION'
          Width = 50
        end
        object cxGridAttr_FLG_IN_NAME: TcxGridDBColumn
          Caption = 'Nume'
          DataBinding.FieldName = 'FLG_IN_NAME'
          Width = 50
        end
        object cxGridAttr_FLG_RECOMMENDED: TcxGridDBColumn
          Caption = 'Recom.'
          DataBinding.FieldName = 'FLG_RECOMMENDED'
          Width = 50
        end
        object cxGridAttr_FLG_MULTI: TcxGridDBColumn
          Caption = 'Multi'
          DataBinding.FieldName = 'FLG_MULTI'
          Width = 50
        end
        object cxGridAttr_FLG_FREE_VALUE: TcxGridDBColumn
          Caption = 'Val. libera'
          DataBinding.FieldName = 'FLG_FREE_VALUE'
          Width = 70
        end
        object cxGridAttr_UOM_RO: TcxGridDBColumn
          Caption = 'UM'
          DataBinding.FieldName = 'UOM_RO'
          Width = 50
        end
      end
      object cxGridAttrLevel: TcxGridLevel
        GridView = cxGridAttrTable
      end
    end
    object pnAttrButtons: TPanel
      Left = 0
      Top = 288
      Width = 460
      Height = 40
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      object btnAttrNew: TcxButton
        Left = 8
        Top = 6
        Width = 90
        Height = 27
        Caption = 'Adauga'
        TabOrder = 0
        OnClick = btnAttrNewClick
      end
      object btnAttrEdit: TcxButton
        Left = 104
        Top = 6
        Width = 90
        Height = 27
        Caption = 'Modifica'
        TabOrder = 1
        OnClick = btnAttrEditClick
      end
      object btnAttrDelete: TcxButton
        Left = 200
        Top = 6
        Width = 90
        Height = 27
        Caption = 'Sterge'
        TabOrder = 2
        OnClick = btnAttrDeleteClick
      end
    end
  end
  object pnRight: TPanel
    Left = 463
    Top = 64
    Width = 537
    Height = 328
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 3
    object lbVal: TLabel
      Left = 0
      Top = 0
      Width = 537
      Height = 15
      Align = alTop
      Caption = '  Valori (pentru atributul selectat)'
      Layout = tlCenter
      ExplicitWidth = 172
    end
    object cxGridVal: TcxGrid
      Left = 0
      Top = 15
      Width = 537
      Height = 273
      Align = alClient
      TabOrder = 0
      object cxGridValTable: TcxGridDBTableView
        DataController.DataSource = IBCDataSourceValues
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsView.GroupByBox = False
        object cxGridVal_VALUE_RO: TcxGridDBColumn
          Caption = 'Valoare RO'
          DataBinding.FieldName = 'VALUE_RO'
          Width = 250
        end
        object cxGridVal_VALUE_RU: TcxGridDBColumn
          Caption = 'Valoare RU'
          DataBinding.FieldName = 'VALUE_RU'
          Width = 250
        end
      end
      object cxGridValLevel: TcxGridLevel
        GridView = cxGridValTable
      end
    end
    object pnValButtons: TPanel
      Left = 0
      Top = 288
      Width = 537
      Height = 40
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      object btnValNew: TcxButton
        Left = 8
        Top = 6
        Width = 90
        Height = 27
        Caption = 'Adauga'
        TabOrder = 0
        OnClick = btnValNewClick
      end
      object btnValEdit: TcxButton
        Left = 104
        Top = 6
        Width = 90
        Height = 27
        Caption = 'Modifica'
        TabOrder = 1
        OnClick = btnValEditClick
      end
      object btnValDelete: TcxButton
        Left = 200
        Top = 6
        Width = 90
        Height = 27
        Caption = 'Sterge'
        TabOrder = 2
        OnClick = btnValDeleteClick
      end
    end
  end
  object IBCTransactionUpdate: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 40
    Top = 96
  end
  object IBCQueryAttributes: TIBCQuery
    KeyFields = 'ATTRID'
    KeyGenerator = 'SQ_TS_ATTRIBUTE_ID'
    Connection = dmDB.IBCConnection
    Transaction = IBCTransactionUpdate
    UpdateTransaction = IBCTransactionUpdate
    SQL.Strings = (
      'SELECT * FROM TS_ATTRIBUTE'
      'WHERE GOODS_TYPE_ID = :gtid'
      'ORDER BY ORDERNO')
    Left = 40
    Top = 152
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'gtid'
        Value = nil
      end>
  end
  object IBCDataSourceAttributes: TIBCDataSource
    DataSet = IBCQueryAttributes
    Left = 120
    Top = 152
  end
  object IBCQueryValues: TIBCQuery
    KeyFields = 'VALUEID'
    KeyGenerator = 'SQ_TS_ATTRIBUTE_VALUE_ID'
    Connection = dmDB.IBCConnection
    Transaction = IBCTransactionUpdate
    UpdateTransaction = IBCTransactionUpdate
    SQL.Strings = (
      'SELECT * FROM TS_ATTRIBUTE_VALUE'
      'WHERE ATTRID = :ATTRID'
      'ORDER BY ORDERNO')
    MasterSource = IBCDataSourceAttributes
    Left = 520
    Top = 152
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ATTRID'
        Value = nil
      end>
  end
  object IBCDataSourceValues: TIBCDataSource
    DataSet = IBCQueryValues
    Left = 600
    Top = 152
  end
  object IBCQueryTemplates: TIBCQuery
    KeyFields = 'TEMPLATEID'
    KeyGenerator = 'SQ_TS_GOODS_NAME_TEMPLATE_ID'
    Connection = dmDB.IBCConnection
    Transaction = IBCTransactionUpdate
    UpdateTransaction = IBCTransactionUpdate
    SQL.Strings = (
      'SELECT * FROM TS_GOODS_NAME_TEMPLATE'
      'WHERE GOODS_TYPE_ID = :gtid'
      'ORDER BY CONTEXT')
    Left = 40
    Top = 432
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'gtid'
        Value = nil
      end>
  end
  object IBCDataSourceTemplates: TIBCDataSource
    DataSet = IBCQueryTemplates
    Left = 120
    Top = 432
  end
end
