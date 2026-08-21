object frmWebVirtualCategoriesDlg: TfrmWebVirtualCategoriesDlg
  Left = 0
  Top = 0
  BorderStyle = bsSizeable
  Caption = 'Categorii virtuale'
  ClientHeight = 480
  ClientWidth = 640
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
    Width = 640
    Height = 64
    Align = alTop
    Title = 'Categorii virtuale'
    Text = 'Categoriile virtuale ale meniului web'
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
  object cxGridCat: TcxGrid
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 624
    Height = 356
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 0
    Align = alClient
    TabOrder = 0
    object cxGridCatTable: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      OnCellDblClick = cxGridCatTableCellDblClick
      DataController.DataSource = IBCDataSourceCategories
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      object cxGridCat_NAME_RO: TcxGridDBColumn
        Caption = 'Denumire RO'
        DataBinding.FieldName = 'NAME_RO'
        Width = 300
      end
      object cxGridCat_NAME_RU: TcxGridDBColumn
        Caption = 'Denumire RU'
        DataBinding.FieldName = 'NAME_RU'
        Width = 300
      end
    end
    object cxGridCatLevel: TcxGridLevel
      GridView = cxGridCatTable
    end
  end
  object pnButtons: TPanel
    Left = 0
    Top = 436
    Width = 640
    Height = 44
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object btnNew: TcxButton
      Left = 8
      Top = 8
      Width = 90
      Height = 29
      Caption = 'Adauga'
      TabOrder = 0
      OnClick = btnNewClick
    end
    object btnEdit: TcxButton
      Left = 104
      Top = 8
      Width = 90
      Height = 29
      Caption = 'Modifica'
      TabOrder = 1
      OnClick = btnEditClick
    end
    object btnDelete: TcxButton
      Left = 200
      Top = 8
      Width = 90
      Height = 29
      Caption = 'Sterge'
      TabOrder = 2
      OnClick = btnDeleteClick
    end
    object btnOk: TcxButton
      Left = 446
      Top = 8
      Width = 90
      Height = 29
      Anchors = [akTop, akRight]
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 3
    end
    object btnCancel: TcxButton
      Left = 542
      Top = 8
      Width = 90
      Height = 29
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Renunta'
      ModalResult = 2
      TabOrder = 4
    end
  end
  object IBCQueryCategories: TIBCQuery
    KeyFields = 'VCATEGORYID'
    KeyGenerator = 'GEN_TWEB_VIRTUAL_CATEGORIES_ID'
    Connection = dmDB.IBCConnection
    Transaction = IBCTransactionUpdate
    UpdateTransaction = IBCTransactionUpdate
    SQL.Strings = (
      'SELECT * FROM TWEB_VIRTUAL_CATEGORIES'
      'ORDER BY NAME_RO')
    Left = 48
    Top = 112
  end
  object IBCDataSourceCategories: TIBCDataSource
    DataSet = IBCQueryCategories
    Left = 128
    Top = 112
  end
  object IBCTransactionUpdate: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 208
    Top = 112
  end
end
