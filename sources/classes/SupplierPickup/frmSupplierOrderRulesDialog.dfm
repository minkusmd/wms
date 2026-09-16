object frmSupplierOrderRulesDlg: TfrmSupplierOrderRulesDlg
  Left = 0
  Top = 0
  Caption = 'Reguli comanda prin intermediar'
  ClientHeight = 480
  ClientWidth = 960
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  DesignSize = (
    960
    480)
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 960
    Height = 64
    Title = 'Reguli comanda prin intermediar'
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
    Width = 960
    Height = 36
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object lbHint: TLabel
      Left = 8
      Top = 10
      Width = 700
      Height = 15
      Caption =
        'O regula per furnizor cu stoc. Valorile sunt doar implicite la c' +
        'onfirmarea ridicarii. Modificarile se salveaza la OK.'
    end
  end
  object cxGridRules: TcxGrid
    Left = 8
    Top = 108
    Width = 944
    Height = 316
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 1
    object cxGridRulesTable: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = IBCDataSourceRules
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.Inserting = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      object colRULEID: TcxGridDBColumn
        DataBinding.FieldName = 'RULEID'
        Visible = False
      end
      object colSTOCK_SUPPLIER_NAME: TcxGridDBColumn
        Caption = 'Furnizorul cu stoc'
        DataBinding.FieldName = 'STOCK_SUPPLIER_NAME'
        Options.Editing = False
        Width = 220
      end
      object colORDER_SUPPLIER_NAME: TcxGridDBColumn
        Caption = 'Comandam prin'
        DataBinding.FieldName = 'ORDER_SUPPLIER_NAME'
        Options.Editing = False
        Width = 220
      end
      object colPICKUP_FROM: TcxGridDBColumn
        Caption = 'Soferul ridica de la'
        DataBinding.FieldName = 'PICKUP_FROM'
        PropertiesClassName = 'TcxImageComboBoxProperties'
        Properties.Items = <
          item
            Description = 'Furnizorul cu stoc'
            ImageIndex = -1
            Value = 0
          end
          item
            Description = 'Intermediar'
            ImageIndex = -1
            Value = 1
          end>
        Width = 150
      end
      object colFLG_ACTIVE: TcxGridDBColumn
        Caption = 'Activa'
        DataBinding.FieldName = 'FLG_ACTIVE'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueGrayed = 0
        Properties.ValueUnchecked = 0
        Width = 50
      end
      object colNOTE: TcxGridDBColumn
        Caption = 'Nota'
        DataBinding.FieldName = 'NOTE'
        Width = 200
      end
      object colUPDATED_AT: TcxGridDBColumn
        Caption = 'Modificat la'
        DataBinding.FieldName = 'UPDATED_AT'
        Options.Editing = False
        Width = 120
      end
      object colUPDATED_BY: TcxGridDBColumn
        Caption = 'Modificat de'
        DataBinding.FieldName = 'UPDATED_BY'
        Options.Editing = False
        Width = 110
      end
    end
    object cxGridRulesLevel: TcxGridLevel
      GridView = cxGridRulesTable
    end
  end
  object btnAdd: TcxButton
    Left = 8
    Top = 436
    Width = 100
    Height = 31
    Anchors = [akLeft, akBottom]
    Caption = 'Adauga'
    TabOrder = 2
    OnClick = btnAddClick
  end
  object btnChangeStock: TcxButton
    Left = 114
    Top = 436
    Width = 170
    Height = 31
    Anchors = [akLeft, akBottom]
    Caption = 'Schimba furnizorul cu stoc'
    TabOrder = 3
    OnClick = btnChangeStockClick
  end
  object btnChangeOrder: TcxButton
    Left = 290
    Top = 436
    Width = 150
    Height = 31
    Anchors = [akLeft, akBottom]
    Caption = 'Schimba intermediarul'
    TabOrder = 4
    OnClick = btnChangeOrderClick
  end
  object btnDelete: TcxButton
    Left = 446
    Top = 436
    Width = 90
    Height = 31
    Anchors = [akLeft, akBottom]
    Caption = 'Sterge'
    TabOrder = 5
    OnClick = btnDeleteClick
  end
  object btnOk: TcxButton
    Left = 726
    Top = 436
    Width = 110
    Height = 31
    Anchors = [akRight, akBottom]
    Caption = 'Salveaza'
    Default = True
    ModalResult = 1
    TabOrder = 6
  end
  object btnCancel: TcxButton
    Left = 842
    Top = 436
    Width = 110
    Height = 31
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 7
  end
  object IBCQueryRules: TIBCQuery
    KeyFields = 'RULEID'
    KeyGenerator = 'SQ_TS_SUPPLIER_ORDER_RULE_ID'
    GeneratorMode = gmInsert
    SQLInsert.Strings = (
      'INSERT INTO TS_SUPPLIER_ORDER_RULE'
      '  (RULEID, STOCK_SUPPLIERID, ORDER_SUPPLIERID, PICKUP_FROM,'
      '   FLG_ACTIVE, NOTE, UPDATED_BY)'
      'VALUES'
      '  (:RULEID, :STOCK_SUPPLIERID, :ORDER_SUPPLIERID, :PICKUP_FROM,'
      '   :FLG_ACTIVE, :NOTE, :UPDATED_BY)')
    SQLDelete.Strings = (
      'DELETE FROM TS_SUPPLIER_ORDER_RULE'
      'WHERE'
      '  RULEID = :Old_RULEID')
    SQLUpdate.Strings = (
      'UPDATE TS_SUPPLIER_ORDER_RULE'
      'SET'
      '  STOCK_SUPPLIERID = :STOCK_SUPPLIERID, ORDER_SUPPLIERID = :ORDER_SUPPLIERID,'
      '  PICKUP_FROM = :PICKUP_FROM, FLG_ACTIVE = :FLG_ACTIVE, NOTE = :NOTE,'
      '  UPDATED_BY = :UPDATED_BY'
      'WHERE'
      '  RULEID = :Old_RULEID')
    SQLRefresh.Strings = (
      'SELECT R.RULEID, R.STOCK_SUPPLIERID, CS.NAME AS STOCK_SUPPLIER_NAME,'
      '       R.ORDER_SUPPLIERID, CO.NAME AS ORDER_SUPPLIER_NAME,'
      '       R.PICKUP_FROM, R.FLG_ACTIVE, R.NOTE, R.UPDATED_AT, R.UPDATED_BY'
      'FROM TS_SUPPLIER_ORDER_RULE R'
      'LEFT JOIN TS_CUSTOMER CS ON CS.CUSTOMERID = R.STOCK_SUPPLIERID'
      'LEFT JOIN TS_CUSTOMER CO ON CO.CUSTOMERID = R.ORDER_SUPPLIERID'
      'WHERE R.RULEID = :RULEID')
    BeforePost = IBCQueryRulesBeforePost
    OnNewRecord = IBCQueryRulesNewRecord
    SQL.Strings = (
      'SELECT R.RULEID, R.STOCK_SUPPLIERID, CS.NAME AS STOCK_SUPPLIER_NAME,'
      '       R.ORDER_SUPPLIERID, CO.NAME AS ORDER_SUPPLIER_NAME,'
      '       R.PICKUP_FROM, R.FLG_ACTIVE, R.NOTE, R.UPDATED_AT, R.UPDATED_BY'
      'FROM TS_SUPPLIER_ORDER_RULE R'
      'LEFT JOIN TS_CUSTOMER CS ON CS.CUSTOMERID = R.STOCK_SUPPLIERID'
      'LEFT JOIN TS_CUSTOMER CO ON CO.CUSTOMERID = R.ORDER_SUPPLIERID'
      'ORDER BY CS.NAME')
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    AutoCommit = False
    Left = 48
    Top = 180
  end
  object IBCDataSourceRules: TIBCDataSource
    DataSet = IBCQueryRules
    Left = 128
    Top = 180
  end
  object IBCTransactionUpdate: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 208
    Top = 180
  end
end
