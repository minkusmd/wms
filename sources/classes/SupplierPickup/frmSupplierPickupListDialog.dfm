object frmSupplierPickupListDlg: TfrmSupplierPickupListDlg
  Left = 0
  Top = 0
  Caption = 'Ridicari de la furnizori'
  ClientHeight = 600
  ClientWidth = 1200
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 1200
    Height = 64
    Title = 'Ridicari de la furnizori'
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
    Width = 1200
    Height = 40
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object chkOnlyActive: TcxCheckBox
      Left = 8
      Top = 8
      Caption = 'Doar de ridicat (noi si atribuite)'
      Properties.OnChange = chkOnlyActivePropertiesChange
      State = cbsChecked
      TabOrder = 0
      Transparent = True
      Width = 240
    end
    object btnRefresh: TcxButton
      Left = 256
      Top = 5
      Width = 100
      Height = 29
      Caption = 'Actualizeaza'
      TabOrder = 1
      OnClick = btnRefreshClick
    end
    object btnRules: TcxButton
      Left = 364
      Top = 5
      Width = 200
      Height = 29
      Caption = 'Reguli comanda prin intermediar'
      TabOrder = 2
      OnClick = btnRulesClick
    end
    object btnNewPickup: TcxButton
      Left = 572
      Top = 5
      Width = 130
      Height = 29
      Caption = 'Ridicare noua'
      TabOrder = 3
      Visible = False
      OnClick = btnNewPickupClick
    end
  end
  object cxGridPickups: TcxGrid
    Left = 0
    Top = 104
    Width = 1200
    Height = 450
    Align = alClient
    TabOrder = 1
    object cxGridPickupsTable: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = IBCDataSourcePickups
      DataController.KeyFieldNames = 'PICKUPID'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OnCellDblClick = cxGridPickupsTableCellDblClick
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsSelection.MultiSelect = True
      OptionsView.ColumnAutoWidth = True
      OptionsView.Indicator = True
      object colPICKUPID: TcxGridDBColumn
        Caption = 'Nr.'
        DataBinding.FieldName = 'PICKUPID'
        Width = 50
      end
      object colPLAN_DATE: TcxGridDBColumn
        Caption = 'Data ridicarii'
        DataBinding.FieldName = 'PLAN_DATE'
        Width = 80
      end
      object colSTATE_NAME: TcxGridDBColumn
        Caption = 'Stare'
        DataBinding.FieldName = 'STATE_NAME'
        Width = 70
      end
      object colDRIVER_NAME: TcxGridDBColumn
        Caption = 'Sofer'
        DataBinding.FieldName = 'DRIVER_NAME'
        Width = 120
      end
      object colPICKUP_SUPPLIER_NAME: TcxGridDBColumn
        Caption = 'Ridicare de la'
        DataBinding.FieldName = 'PICKUP_SUPPLIER_NAME'
        Width = 140
      end
      object colGOODS_TITLE: TcxGridDBColumn
        Caption = 'Produs'
        DataBinding.FieldName = 'GOODS_TITLE'
        Width = 240
      end
      object colGOODS_CODE: TcxGridDBColumn
        Caption = 'Cod furnizor'
        DataBinding.FieldName = 'GOODS_CODE'
        Width = 90
      end
      object colQTY: TcxGridDBColumn
        Caption = 'Cant.'
        DataBinding.FieldName = 'QTY'
        Width = 45
      end
      object colSTOCK_SUPPLIER_NAME: TcxGridDBColumn
        Caption = 'Stoc la'
        DataBinding.FieldName = 'STOCK_SUPPLIER_NAME'
        Width = 110
      end
      object colORDER_SUPPLIER_NAME: TcxGridDBColumn
        Caption = 'Comandat prin'
        DataBinding.FieldName = 'ORDER_SUPPLIER_NAME'
        Width = 110
      end
      object colDOCID: TcxGridDBColumn
        Caption = 'Comanda'
        DataBinding.FieldName = 'DOCID'
        Width = 65
      end
      object colDOC_DATA: TcxGridDBColumn
        Caption = 'Data comenzii'
        DataBinding.FieldName = 'DOC_DATA'
        Width = 80
      end
      object colCLIENT_NAME: TcxGridDBColumn
        Caption = 'Client'
        DataBinding.FieldName = 'CLIENT_NAME'
        Width = 130
      end
      object colNOTE: TcxGridDBColumn
        Caption = 'Nota'
        DataBinding.FieldName = 'NOTE'
        Width = 120
      end
      object colPICKED_AT: TcxGridDBColumn
        Caption = 'Ridicat la'
        DataBinding.FieldName = 'PICKED_AT'
        Visible = False
        Width = 110
      end
      object colCREATED_BY_NAME: TcxGridDBColumn
        Caption = 'Creat de'
        DataBinding.FieldName = 'CREATED_BY_NAME'
        Visible = False
        Width = 100
      end
      object colCREATED_AT: TcxGridDBColumn
        Caption = 'Creat la'
        DataBinding.FieldName = 'CREATED_AT'
        Visible = False
        Width = 110
      end
    end
    object cxGridPickupsLevel: TcxGridLevel
      GridView = cxGridPickupsTable
    end
  end
  object pnBottom: TPanel
    Left = 0
    Top = 554
    Width = 1200
    Height = 46
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    DesignSize = (
      1200
      46)
    object btnModify: TcxButton
      Left = 8
      Top = 8
      Width = 110
      Height = 31
      Caption = 'Modifica'
      TabOrder = 0
      OnClick = btnModifyClick
    end
    object btnAssignDriver: TcxButton
      Left = 124
      Top = 8
      Width = 130
      Height = 31
      Caption = 'Atribuie soferul'
      TabOrder = 1
      OnClick = btnAssignDriverClick
    end
    object btnClearDriver: TcxButton
      Left = 260
      Top = 8
      Width = 120
      Height = 31
      Caption = 'Scoate soferul'
      TabOrder = 2
      OnClick = btnClearDriverClick
    end
    object btnPicked: TcxButton
      Left = 396
      Top = 8
      Width = 110
      Height = 31
      Caption = 'Ridicata'
      TabOrder = 3
      OnClick = btnPickedClick
    end
    object btnCancelPickup: TcxButton
      Left = 512
      Top = 8
      Width = 100
      Height = 31
      Caption = 'Anuleaza'
      TabOrder = 4
      OnClick = btnCancelPickupClick
    end
    object btnReopen: TcxButton
      Left = 618
      Top = 8
      Width = 100
      Height = 31
      Caption = 'Redeschide'
      TabOrder = 5
      OnClick = btnReopenClick
    end
    object btnClose: TcxButton
      Left = 1082
      Top = 8
      Width = 110
      Height = 31
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Inchide'
      ModalResult = 2
      TabOrder = 6
    end
  end
  object IBCQueryPickups: TIBCQuery
    SQL.Strings = (
      'SELECT * FROM VW_TDB_SUPPLIER_PICKUP'
      'WHERE STATEID IN (0, 1)'
      'ORDER BY PLAN_DATE, PICKUP_SUPPLIER_NAME, PICKUPID')
    ReadOnly = True
    Left = 48
    Top = 200
  end
  object IBCDataSourcePickups: TIBCDataSource
    DataSet = IBCQueryPickups
    Left = 128
    Top = 200
  end
end
