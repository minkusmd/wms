object frmCustomerCurrentDebtsNalDlg: TfrmCustomerCurrentDebtsNalDlg
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = #1058#1077#1082#1091#1097#1080#1077' '#1076#1086#1083#1075#1080' '#1082#1086#1085#1090#1088#1072#1075#1077#1085#1090#1072' - '#1048#1089#1090#1086#1088#1080#1103' '#1085#1072#1083#1080#1095#1085#1099#1077
  ClientHeight = 564
  ClientWidth = 1003
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 1003
    Height = 64
    Title = #1058#1077#1082#1091#1097#1080#1077' '#1076#1086#1083#1075#1080' '#1082#1086#1085#1090#1088#1072#1075#1077#1085#1090#1072' - '#1048#1089#1090#1086#1088#1080#1103' '#1085#1072#1083#1080#1095#1085#1099#1077
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
    Width = 987
    Height = 439
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
      ScrollbarAnnotations.CustomAnnotations = <>
      OnCustomDrawCell = cxGridHistoryCashTableCustomDrawCell
      DataController.DataSource = IBCDataSourceHistoryCash
      DataController.KeyFieldNames = 'DOCID'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
      OptionsView.ScrollBars = ssVertical
      OptionsView.ColumnAutoWidth = True
      OptionsView.GridLineColor = clBtnShadow
      OptionsView.Indicator = True
      Styles.OnGetContentStyle = cxGridHistoryCashTableStylesGetContentStyle
      object cxGridHistoryCash_DOCID: TcxGridDBColumn
        Caption = 'DocID'
        DataBinding.FieldName = 'DOCID'
        HeaderAlignmentHorz = taCenter
        MinWidth = 50
        Options.Filtering = False
        Options.HorzSizing = False
        Width = 50
      end
      object cxGridHistoryCash_DATA: TcxGridDBColumn
        Caption = #1044#1072#1090#1072
        DataBinding.FieldName = 'DATA'
        OnGetDisplayText = cxGridHistoryCash_DATAGetDisplayText
        MinWidth = 60
        Options.Grouping = False
        Width = 60
      end
      object cxGridHistoryCash_DT_NAME: TcxGridDBColumn
        Caption = #1060#1080#1088#1084#1072
        DataBinding.FieldName = 'DT_NAME'
        MinWidth = 50
        Width = 100
      end
      object cxGridHistoryCash_DOCTYPE_NAME: TcxGridDBColumn
        Caption = #1044#1086#1082#1091#1084#1077#1085#1090
        DataBinding.FieldName = 'DOCTYPE_NAME'
        MinWidth = 50
        Width = 200
      end
      object cxGridHistoryCash_SUMA: TcxGridDBColumn
        Caption = #1057#1091#1084#1084#1072
        DataBinding.FieldName = 'SUMA'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 70
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 70
      end
      object cxGridHistoryCash_CURRENCY_NAME: TcxGridDBColumn
        Caption = #1042#1072#1083#1102#1090#1072
        DataBinding.FieldName = 'CURRENCY_NAME'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        MinWidth = 60
        Options.HorzSizing = False
        Width = 60
      end
      object cxGridHistoryCash_RATE: TcxGridDBColumn
        Caption = #1050#1091#1088#1089
        DataBinding.FieldName = 'RATE'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.0000'
        HeaderAlignmentHorz = taCenter
        MinWidth = 50
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 50
      end
      object cxGridHistoryCash_SUMA_USD: TcxGridDBColumn
        Caption = #1057#1091#1084#1084#1072' $'
        DataBinding.FieldName = 'SUMA_USD'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 70
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 70
      end
      object cxGridHistoryCash_CURRENT_USD_RATE: TcxGridDBColumn
        Caption = #1050#1091#1088#1089' $'
        DataBinding.FieldName = 'CURRENT_USD_RATE'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.0000'
        HeaderAlignmentHorz = taCenter
        MinWidth = 50
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 50
      end
      object cxGridHistoryCash_SUMA_BALANCE: TcxGridDBColumn
        Caption = #1041#1072#1083#1083#1072#1085#1089
        DataBinding.FieldName = 'SUMA_BALANCE'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 80
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 80
      end
      object cxGridHistoryCash_CREATED_BY: TcxGridDBColumn
        Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
        DataBinding.FieldName = 'CREATED_BY'
        MinWidth = 40
        Width = 70
      end
      object cxGridHistoryCash_DOCTYPESIGN: TcxGridDBColumn
        DataBinding.FieldName = 'DOCTYPESIGN'
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
    Top = 519
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
      Caption = #1047#1072#1082#1088#1099#1090#1100
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
      'SELECT * FROM SP_CUSTOMER_DEBTS_JOURNAL(:CustomerID,NULL)')
    Left = 132
    Top = 176
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CUSTOMERID'
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
    Left = 496
    Top = 288
    PixelsPerInch = 96
    object dxBarButton1: TdxBarButton
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1082#1091#1088#1089
      Category = 0
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100' '#1082#1091#1088#1089
      Visible = ivAlways
      OnClick = dxBarButton1Click
    end
  end
  object dxBarPopupMenu1: TdxBarPopupMenu
    BarManager = dxBarManager1
    ItemLinks = <
      item
        Visible = True
        ItemName = 'dxBarButton1'
      end>
    UseOwnFont = False
    Left = 376
    Top = 288
    PixelsPerInch = 96
  end
end
