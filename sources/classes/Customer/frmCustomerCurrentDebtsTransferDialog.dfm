object frmCustomerCurrentDebtsTransferDlg: TfrmCustomerCurrentDebtsTransferDlg
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Datorii, detalii contabilitate'
  ClientHeight = 613
  ClientWidth = 1003
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poOwnerFormCenter
  TextHeight = 13
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 1003
    Height = 64
    Title = 'Detalii pe contabilitlate'
    Text = ''
    FontTitle.Charset = RUSSIAN_CHARSET
    FontTitle.Color = clWindowText
    FontTitle.Height = -12
    FontTitle.Name = 'Tahoma'
    FontTitle.Style = [fsBold]
    FontText.Charset = RUSSIAN_CHARSET
    FontText.Color = clWindowText
    FontText.Height = -11
    FontText.Name = 'Tahoma'
    FontText.Style = []
    ImageList = dmAdditions.cxImageList_DialogIcons
    ImageIndex = 4
  end
  object cxGridHistoryCash: TcxGrid
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 987
    Height = 488
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alClient
    TabOrder = 1
    ExplicitLeft = 3
    ExplicitTop = 73
    object cxGridHistoryCashTable: TcxGridDBTableView
      PopupMenu = dxBarPopupMenu1
      OnKeyDown = cxGridHistoryCashTableKeyDown
      Navigator.Buttons.CustomButtons = <>
      ScrollbarAnnotations.CustomAnnotations = <>
      OnCustomDrawCell = cxGridHistoryCashTableCustomDrawCell
      DataController.DataSource = IBCDataSourceHistoryCash
      DataController.KeyFieldNames = 'DOCID'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <
        item
          Format = '0.00'
          Kind = skSum
          FieldName = 'SUMA'
          Column = cxGridHistoryCash_SUMA
        end>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.InvertSelect = False
      OptionsView.CellEndEllipsis = True
      OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
      OptionsView.ScrollBars = ssVertical
      OptionsView.ColumnAutoWidth = True
      OptionsView.Footer = True
      OptionsView.GridLineColor = 13750737
      OptionsView.Indicator = True
      Styles.OnGetContentStyle = cxGridHistoryCashTableStylesGetContentStyle
      Styles.Group = dmAdditions.cxStyle_Bold
      Styles.GroupByBox = dmAdditions.cxStyle_GridGroup
      Styles.Header = dmAdditions.cxStyle_GridHeader
      Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
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
        MinWidth = 60
        Options.Grouping = False
        Width = 60
      end
      object cxGridHistoryCash_DT_NAME: TcxGridDBColumn
        Caption = 'Subdiviziune'
        DataBinding.FieldName = 'DT_NAME'
        DataBinding.IsNullValueType = True
        MinWidth = 50
        Width = 100
      end
      object cxGridHistoryCash_DOCTYPE_NAME: TcxGridDBColumn
        Caption = 'Tip document'
        DataBinding.FieldName = 'DOCTYPE_NAME'
        DataBinding.IsNullValueType = True
        MinWidth = 50
        Width = 200
      end
      object cxGridHistoryCash_SUMA: TcxGridDBColumn
        Caption = 'Suma'
        DataBinding.FieldName = 'SUMA'
        DataBinding.IsNullValueType = True
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 70
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 70
      end
      object cxGridHistoryCash_SUMADT: TcxGridDBColumn
        Caption = 'Ceante'
        DataBinding.FieldName = 'SUMA_BUH_DT'
        DataBinding.IsNullValueType = True
        HeaderAlignmentHorz = taCenter
      end
      object cxGridHistoryCash_SUMACT: TcxGridDBColumn
        Caption = 'Datorii'
        DataBinding.FieldName = 'SUMA_BUH_CT'
        DataBinding.IsNullValueType = True
        HeaderAlignmentHorz = taCenter
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
      object cxGridHistoryCash_SUMA_USD: TcxGridDBColumn
        Caption = 'Suma USD'
        DataBinding.FieldName = 'SUMA_USD'
        DataBinding.IsNullValueType = True
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 70
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 70
      end
      object cxGridHistoryCash_CURRENT_USD_RATE: TcxGridDBColumn
        Caption = 'Rata USD'
        DataBinding.FieldName = 'CURRENT_USD_RATE'
        DataBinding.IsNullValueType = True
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.0000'
        HeaderAlignmentHorz = taCenter
        MinWidth = 50
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 50
      end
      object cxGridHistoryCash_SUMA_BALANCE: TcxGridDBColumn
        Caption = 'Bilanta'
        DataBinding.FieldName = 'SUMA_BALANCE'
        DataBinding.IsNullValueType = True
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 80
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 80
      end
      object cxGridHistoryCash_CREATED_BY: TcxGridDBColumn
        Caption = 'Utilizator'
        DataBinding.FieldName = 'CREATED_BY'
        DataBinding.IsNullValueType = True
        MinWidth = 40
        Width = 70
      end
      object cxGridHistoryCash_DOCTYPESIGN: TcxGridDBColumn
        DataBinding.FieldName = 'DOCTYPESIGN'
        DataBinding.IsNullValueType = True
        Visible = False
        VisibleForCustomization = False
      end
    end
    object cxGridHistoryCashLevel: TcxGridLevel
      GridView = cxGridHistoryCashTable
    end
  end
  object pnBottom: TPanel
    Left = 0
    Top = 568
    Width = 1003
    Height = 45
    Align = alBottom
    BevelOuter = bvNone
    Padding.Left = 8
    Padding.Top = 4
    Padding.Right = 24
    Padding.Bottom = 12
    ShowCaption = False
    TabOrder = 2
    object btnClose: TButton
      Left = 889
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
  object IBCDataSourceHistoryCash: TIBCDataSource
    DataSet = IBCQueryHistoryCash
    Left = 132
    Top = 236
  end
  object IBCQueryHistoryCash: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT * FROM SP_CUSTOMER_DEBTS_JOURNAL_ACNT(:CustomerID,NULL)')
    Left = 132
    Top = 176
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CUSTOMERID'
        Value = nil
      end>
  end
  object dxBarPopupMenu1: TdxBarPopupMenu
    BarManager = dxBarManager1
    ItemLinks = <
      item
        Visible = True
        ItemName = 'dxBarButton1'
      end>
    UseOwnFont = False
    Left = 504
    Top = 256
    PixelsPerInch = 96
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
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1082#1091#1088#1089
      Category = 0
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100' '#1082#1091#1088#1089
      Visible = ivAlways
      OnClick = dxBarButton1Click
    end
  end
end
