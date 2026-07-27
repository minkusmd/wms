object frmCustomerCurrentDebtsContractDlg: TfrmCustomerCurrentDebtsContractDlg
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Registru documentelor contragentului conform contractului'
  ClientHeight = 613
  ClientWidth = 1135
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
    Width = 1135
    Height = 64
    Title = 'Registrul documentelor dupa contract'
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
    ImageIndex = 4
  end
  object cxGridHistoryCash: TcxGrid
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 1119
    Height = 405
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alClient
    TabOrder = 1
    object cxGridHistoryCashTable: TcxGridDBTableView
      PopupMenu = dxBarPopupMenu1
      OnKeyDown = cxGridHistoryCashTableKeyDown
      Navigator.Buttons.CustomButtons = <>
      Navigator.Buttons.First.Visible = False
      Navigator.Buttons.PriorPage.Visible = False
      Navigator.Buttons.Prior.Visible = False
      Navigator.Buttons.Next.Visible = False
      Navigator.Buttons.NextPage.Visible = False
      Navigator.Buttons.Last.Visible = False
      Navigator.Buttons.Insert.Visible = False
      Navigator.Buttons.Delete.Visible = False
      Navigator.Buttons.Edit.Visible = False
      Navigator.Buttons.Post.Visible = False
      Navigator.Buttons.Cancel.Visible = False
      Navigator.Buttons.SaveBookmark.Visible = False
      Navigator.Buttons.GotoBookmark.Visible = False
      Navigator.Buttons.Filter.Visible = False
      Navigator.InfoPanel.DisplayMask = '[RecordIndex] din [RecordCount]'
      Navigator.InfoPanel.Visible = True
      Navigator.Visible = True
      ScrollbarAnnotations.CustomAnnotations = <>
      OnCustomDrawCell = cxGridHistoryCashTableCustomDrawCell
      DataController.DataSource = IBCDataSourceContractsDocuments
      DataController.KeyFieldNames = 'DOCID'
      DataController.Summary.DefaultGroupSummaryItems = <
        item
          Kind = skSum
          Column = cxGridHistoryCash_SUMA
        end
        item
          Kind = skSum
          FieldName = 'SUMA_OUT'
          Column = cxGridHistoryCash_SUMA_OUT
        end>
      DataController.Summary.FooterSummaryItems = <
        item
          Format = '0.00'
          Kind = skSum
          FieldName = 'SUMA_IN'
          Column = cxGridHistoryCash_SUMA_IN
        end
        item
          Format = '0.00'
          Kind = skSum
          Column = cxGridHistoryCash_SUMA_OUT
        end>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.IncSearch = True
      OptionsBehavior.ImmediateEditor = False
      OptionsCustomize.ColumnsQuickCustomization = True
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.MultiSelect = True
      OptionsSelection.HideFocusRectOnExit = False
      OptionsSelection.InvertSelect = False
      OptionsSelection.UnselectFocusedRecordOnExit = False
      OptionsView.CellEndEllipsis = True
      OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
      OptionsView.ScrollBars = ssVertical
      OptionsView.ColumnAutoWidth = True
      OptionsView.Footer = True
      OptionsView.GridLineColor = 13750737
      OptionsView.Indicator = True
      Styles.OnGetContentStyle = cxGridHistoryCashTableStylesGetContentStyle
      object cxGridHistoryCash_DOCID: TcxGridDBColumn
        Caption = 'Nr. doc'
        DataBinding.FieldName = 'DOCID'
        DataBinding.IsNullValueType = True
        HeaderAlignmentHorz = taCenter
        MinWidth = 50
        Options.Filtering = False
        Options.HorzSizing = False
        Width = 50
      end
      object cxGridHistoryCash_DATA: TcxGridDBColumn
        Caption = 'Data'
        DataBinding.FieldName = 'DATA'
        DataBinding.IsNullValueType = True
        OnGetDisplayText = cxGridHistoryCash_DATAGetDisplayText
        HeaderAlignmentHorz = taCenter
        MinWidth = 60
        Options.Grouping = False
        Width = 78
      end
      object cxGridHistoryCash_DT_NAME: TcxGridDBColumn
        Caption = 'Subdiviziune'
        DataBinding.FieldName = 'DT_NAME'
        DataBinding.IsNullValueType = True
        HeaderAlignmentHorz = taCenter
        MinWidth = 50
        Width = 130
      end
      object cxGridHistoryCash_DOCTYPE_NAME: TcxGridDBColumn
        Caption = 'Tip document'
        DataBinding.FieldName = 'DOCTYPE_NAME'
        DataBinding.IsNullValueType = True
        HeaderAlignmentHorz = taCenter
        MinWidth = 50
        Width = 203
      end
      object cxGridHistoryCash_SUMA_IN: TcxGridDBColumn
        Caption = 'Suma In'
        DataBinding.FieldName = 'SUMA_IN'
        DataBinding.IsNullValueType = True
        HeaderAlignmentHorz = taCenter
        MinWidth = 70
        Options.HorzSizing = False
        Width = 70
      end
      object cxGridHistoryCash_SUMA_OUT: TcxGridDBColumn
        Caption = 'Suma Out'
        DataBinding.FieldName = 'SUMA_OUT'
        DataBinding.IsNullValueType = True
        HeaderAlignmentHorz = taCenter
        MinWidth = 70
        Options.HorzSizing = False
        Width = 70
      end
      object cxGridHistoryCash_SUMA: TcxGridDBColumn
        Caption = 'Suma'
        DataBinding.FieldName = 'SUMA_UPR'
        DataBinding.IsNullValueType = True
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        Visible = False
        HeaderAlignmentHorz = taCenter
        MinWidth = 70
        Options.Grouping = False
        Options.HorzSizing = False
        VisibleForCustomization = False
        Width = 70
      end
      object cxGridHistoryCash_SUMA_BALANCE: TcxGridDBColumn
        Caption = 'Bilanta'
        DataBinding.FieldName = 'BALANCE_NEW'
        DataBinding.IsNullValueType = True
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 80
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 80
      end
      object cxGridHistoryCash_CURRENCY_NAME: TcxGridDBColumn
        Caption = 'Valuta'
        DataBinding.FieldName = 'CURRENCY_NAME'
        DataBinding.IsNullValueType = True
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        MinWidth = 60
        Options.HorzSizing = False
        Width = 60
      end
      object cxGridHistoryCash_RATE: TcxGridDBColumn
        Caption = 'Rata'
        DataBinding.FieldName = 'RATE'
        DataBinding.IsNullValueType = True
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.0000'
        HeaderAlignmentHorz = taCenter
        MinWidth = 50
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 50
      end
      object cxGridHistoryCash_CURRENT_USD_RATE: TcxGridDBColumn
        Caption = 'Rata USD'
        DataBinding.FieldName = 'CURRENT_USD_RATE'
        DataBinding.IsNullValueType = True
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.0000'
        HeaderAlignmentHorz = taCenter
        MinWidth = 60
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 60
      end
      object cxGridHistoryCash_CREATED_BY: TcxGridDBColumn
        Caption = 'Utilizator'
        DataBinding.FieldName = 'CREATED_BY'
        DataBinding.IsNullValueType = True
        HeaderAlignmentHorz = taCenter
        MinWidth = 40
        Width = 122
      end
      object cxGridHistoryCash_DOCTYPESIGN: TcxGridDBColumn
        DataBinding.FieldName = 'DOCTYPESIGN'
        DataBinding.IsNullValueType = True
        Visible = False
        HeaderAlignmentHorz = taCenter
        VisibleForCustomization = False
      end
      object cxGridHistoryCashTable_Upr_MDL: TcxGridDBColumn
        Caption = 'Upr MDL'
        DataBinding.FieldName = 'SUMA_UPR_MDL'
        DataBinding.IsNullValueType = True
        Visible = False
        HeaderAlignmentHorz = taCenter
      end
      object cxGridHistoryCashTable_BUH_USD: TcxGridDBColumn
        Caption = 'Buh USD'
        DataBinding.FieldName = 'SUMA_BUH_USD'
        DataBinding.IsNullValueType = True
        Visible = False
        HeaderAlignmentHorz = taCenter
      end
      object cxGridHistoryCashTable_SC2_NAME: TcxGridDBColumn
        Caption = 'Analitica'
        DataBinding.FieldName = 'SC2_NAME'
        DataBinding.IsNullValueType = True
        HeaderAlignmentHorz = taCenter
        Width = 122
      end
    end
    object cxGridHistoryCashLevel: TcxGridLevel
      GridView = cxGridHistoryCashTable
    end
  end
  object pnBottom: TPanel
    Left = 0
    Top = 568
    Width = 1135
    Height = 45
    Align = alBottom
    BevelOuter = bvNone
    Color = clWindow
    Padding.Left = 8
    Padding.Top = 4
    Padding.Right = 24
    Padding.Bottom = 12
    ParentBackground = False
    ShowCaption = False
    TabOrder = 2
    object btnClose: TButton
      Left = 1021
      Top = 4
      Width = 90
      Height = 29
      Align = alRight
      Cancel = True
      Caption = 'Inchide'
      Default = True
      ModalResult = 2
      TabOrder = 0
    end
  end
  object cxGrid2: TcxGrid
    AlignWithMargins = True
    Left = 8
    Top = 488
    Width = 1119
    Height = 72
    Margins.Left = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alBottom
    TabOrder = 3
    object cxGrid2DBTableView1: TcxGridDBTableView
      OnKeyDown = cxGrid2DBTableView1KeyDown
      Navigator.Buttons.CustomButtons = <>
      ScrollbarAnnotations.CustomAnnotations = <>
      DataController.DataSource = IBCDataSourceInvoices
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.ImmediateEditor = False
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.GroupByBox = False
      object cxGrid2DBTableView1FACTURANO: TcxGridDBColumn
        Caption = 'Factura Nr'
        DataBinding.FieldName = 'FACTURANO'
        DataBinding.IsNullValueType = True
        Width = 200
      end
      object cxGrid2DBTableView1DATA_ELIBERARII: TcxGridDBColumn
        Caption = 'Data'
        DataBinding.FieldName = 'DATA_ELIBERARII'
        DataBinding.IsNullValueType = True
      end
      object cxGrid2DBTableView1TIP_FACTURA: TcxGridDBColumn
        Caption = 'Tip factura'
        DataBinding.FieldName = 'TIP_FACTURA'
        DataBinding.IsNullValueType = True
        Width = 150
      end
      object cxGrid2DBTableView1FLG_CANCELED: TcxGridDBColumn
        Caption = 'Anulat'
        DataBinding.FieldName = 'FLG_CANCELED'
        DataBinding.IsNullValueType = True
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.Alignment = taRightJustify
        Properties.NullStyle = nssUnchecked
        Properties.ValueChecked = '1'
        Properties.ValueUnchecked = '0'
      end
      object cxGrid2DBTableView1REDIRIJARI: TcxGridDBColumn
        Caption = 'Redirijari'
        DataBinding.FieldName = 'REDIRIJARI'
        DataBinding.IsNullValueType = True
        Width = 201
      end
      object cxGrid2DBTableView1PUNCT_INCARCARE: TcxGridDBColumn
        Caption = 'Punct de incarcare'
        DataBinding.FieldName = 'PUNCT_INCARCARE'
        DataBinding.IsNullValueType = True
        Width = 142
      end
      object cxGrid2DBTableView1PUNCT_DESCARCARE: TcxGridDBColumn
        Caption = 'Punct de descarcare'
        DataBinding.FieldName = 'PUNCT_DESCARCARE'
        DataBinding.IsNullValueType = True
        Width = 112
      end
      object cxGrid2DBTableView1Column1: TcxGridDBColumn
        DataBinding.IsNullValueType = True
      end
    end
    object cxGrid2Level1: TcxGridLevel
      GridView = cxGrid2DBTableView1
    end
  end
  object IBCDataSourceContractsDocuments: TIBCDataSource
    DataSet = IBCQueryContractsDocuments
    Left = 132
    Top = 164
  end
  object IBCQueryContractsDocuments: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      
        'SELECT z.*, c.*, sum(suma_in+suma_out) over (order by data) bala' +
        'nce_new '
      
        'FROM SP_CUSTOMER_DEBTS_CONTRACT_V3(:CustomerID, :ContractID, NUL' +
        'L, :FLG_UPR, :FLG_BUH) z'
      'inner join ts_cust_1c c on c.customerid=z.dt and c.dt=:ORGID'
      'ORDER BY DATA DESC'
      '')
    Options.DetailDelay = 350
    Left = 132
    Top = 224
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CUSTOMERID'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'ContractID'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'FLG_UPR'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'FLG_BUH'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'ORGID'
        Value = nil
      end>
  end
  object dxBarManager1: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Default')
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 624
    Top = 168
    PixelsPerInch = 96
    object dxBarButton1: TdxBarButton
      Caption = 'Modifica rata de schimb'
      Category = 0
      Hint = 'Modifica rata de schimb'
      Visible = ivAlways
      OnClick = dxBarButton1Click
    end
    object bbChangeContract: TdxBarButton
      Caption = 'Modifica contractul'
      Category = 0
      Hint = 'Modifica contractul'
      Visible = ivAlways
      OnClick = bbChangeContractClick
    end
    object dxBarButton2: TdxBarButton
      Caption = 'Extrage facturile'
      Category = 0
      Hint = 'Extrage facturile'
      Visible = ivAlways
      OnClick = dxBarButton2Click
    end
    object dxBarButton3: TdxBarButton
      Caption = 'View document'
      Category = 0
      Hint = 'View document'
      Visible = ivAlways
      ShortCut = 123
      OnClick = dxBarButton3Click
    end
  end
  object dxBarPopupMenu1: TdxBarPopupMenu
    BarManager = dxBarManager1
    ItemLinks = <
      item
        Visible = True
        ItemName = 'dxBarButton1'
      end
      item
        Visible = True
        ItemName = 'bbChangeContract'
      end
      item
        Visible = True
        ItemName = 'dxBarButton2'
      end
      item
        Visible = True
        ItemName = 'dxBarButton3'
      end>
    UseOwnFont = False
    Left = 367
    Top = 304
    PixelsPerInch = 96
  end
  object IBCTrLocalWrite: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 368
    Top = 360
  end
  object IBCQueryInvoices: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      'select * from tdb_invoices where docid = :docid')
    MasterFields = 'DOCID'
    DetailFields = 'DOCID'
    MasterSource = IBCDataSourceContractsDocuments
    Left = 496
    Top = 312
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'docid'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'DOCID'
        Value = nil
      end>
  end
  object IBCDataSourceInvoices: TIBCDataSource
    DataSet = IBCQueryInvoices
    Left = 496
    Top = 256
  end
end
