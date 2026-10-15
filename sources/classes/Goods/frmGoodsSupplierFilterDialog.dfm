object frmGoodsSupplierFilterDlg: TfrmGoodsSupplierFilterDlg
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Filtru dupa furnizor'
  ClientHeight = 520
  ClientWidth = 560
  Color = clBtnFace
  Constraints.MinHeight = 300
  Constraints.MinWidth = 420
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnShow = FormShow
  TextHeight = 15
  object lblInfo: TcxLabel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Align = alTop
    Caption = 'Furnizorii produselor din lista curenta'
  end
  object cxGridSuppliers: TcxGrid
    AlignWithMargins = True
    Left = 3
    Top = 30
    Width = 554
    Height = 446
    Align = alClient
    TabOrder = 1
    object cxGridSuppliersTable: TcxGridDBTableView
      OnCellDblClick = cxGridSuppliersTableCellDblClick
      Navigator.Buttons.CustomButtons = <>
      FindPanel.DisplayMode = fpdmAlways
      FindPanel.ShowCloseButton = False
      ScrollbarAnnotations.CustomAnnotations = <>
      DataController.DataSource = IBCDataSourceSuppliers
      DataController.KeyFieldNames = 'CUSTOMERID'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.IncSearch = True
      OptionsBehavior.ImmediateEditor = False
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      object cxGridSuppliersTable_NAME: TcxGridDBColumn
        Caption = 'Furnizor'
        DataBinding.FieldName = 'NAME'
        Width = 380
      end
      object cxGridSuppliersTable_CNT: TcxGridDBColumn
        Caption = 'Produse'
        DataBinding.FieldName = 'CNT'
        Width = 80
      end
      object cxGridSuppliersTable_CUSTOMERID: TcxGridDBColumn
        Caption = 'Cod'
        DataBinding.FieldName = 'CUSTOMERID'
        Width = 80
      end
    end
    object cxGridSuppliersLevel: TcxGridLevel
      GridView = cxGridSuppliersTable
    end
  end
  object PanelBottom: TPanel
    Left = 0
    Top = 479
    Width = 560
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object btnApply: TButton
      Left = 150
      Top = 7
      Width = 90
      Height = 29
      Caption = 'Aplica'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
    object btnClearFilter: TButton
      Left = 246
      Top = 7
      Width = 120
      Height = 29
      Caption = 'Anuleaza filtrul'
      ModalResult = 7
      TabOrder = 1
    end
    object btnClose: TButton
      Left = 372
      Top = 7
      Width = 90
      Height = 29
      Cancel = True
      Caption = 'Inchide'
      ModalResult = 2
      TabOrder = 2
    end
  end
  object IBCQuerySuppliers: TIBCQuery
    ReadOnly = True
    Left = 272
    Top = 200
  end
  object IBCDataSourceSuppliers: TIBCDataSource
    DataSet = IBCQuerySuppliers
    Left = 272
    Top = 256
  end
end
