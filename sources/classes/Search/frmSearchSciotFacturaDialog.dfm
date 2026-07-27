object frmSearchSciotFacturaDlg: TfrmSearchSciotFacturaDlg
  Left = 0
  Top = 0
  ActiveControl = edSeachText
  BorderStyle = bsDialog
  Caption = 'Cauta Factura fiscala'
  ClientHeight = 493
  ClientWidth = 951
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
    Width = 951
    Height = 64
    Title = 'Cauta Factura fiscala'
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
    ImageIndex = 9
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 935
    Height = 369
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    object pnSearch: TPanel
      AlignWithMargins = True
      Left = 12
      Top = 16
      Width = 907
      Height = 30
      Margins.Left = 12
      Margins.Top = 16
      Margins.Right = 12
      Margins.Bottom = 8
      Align = alTop
      BevelOuter = bvNone
      Color = clWindow
      ParentBackground = False
      TabOrder = 0
      object Label1: TLabel
        Left = 0
        Top = 3
        Width = 127
        Height = 15
        Caption = 'Numarul Facturii Fiscale'
      end
      object edSeachText: TEdit
        Left = 177
        Top = 0
        Width = 127
        Height = 23
        TabOrder = 0
      end
      object btnSearch: TcxButton
        Left = 310
        Top = 0
        Width = 75
        Height = 25
        Caption = 'Cauta'
        Default = True
        TabOrder = 1
        OnClick = btnSearchClick
      end
    end
    object cxGrid: TcxGrid
      AlignWithMargins = True
      Left = 12
      Top = 54
      Width = 907
      Height = 299
      Margins.Left = 12
      Margins.Top = 0
      Margins.Right = 12
      Margins.Bottom = 12
      Align = alClient
      TabOrder = 1
      object cxGridTable: TcxGridDBTableView
        OnKeyDown = cxGridTableKeyDown
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        OnCellDblClick = cxGridTableCellDblClick
        OnCustomDrawCell = cxGridTableCustomDrawCell
        DataController.DataSource = IBCDataSourceSearch
        DataController.KeyFieldNames = 'DOCID;INVOICEID'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnSorting = False
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.InvertSelect = False
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        Styles.OnGetContentStyle = cxGridTableStylesGetContentStyle
        Styles.Header = dmAdditions.cxStyle_GridHeader
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        object cxGridTable_FLG_CLOSED: TcxGridDBColumn
          Caption = 'Inchis'
          DataBinding.FieldName = 'FLG_CLOSED'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          HeaderAlignmentHorz = taCenter
          MinWidth = 50
          Options.HorzSizing = False
          Width = 50
        end
        object cxGridTable_FACTURANO: TcxGridDBColumn
          Caption = 'Factura fiscala'
          DataBinding.FieldName = 'FACTURANO'
          MinWidth = 130
          Options.HorzSizing = False
          Width = 130
        end
        object cxGridTable_DOCID: TcxGridDBColumn
          Caption = 'Cod doc'
          DataBinding.FieldName = 'DOCID'
          HeaderAlignmentHorz = taCenter
          MinWidth = 60
          Options.HorzSizing = False
          Width = 60
        end
        object cxGridTable_DATA_ELIBERARII: TcxGridDBColumn
          Caption = 'Data'
          DataBinding.FieldName = 'DATA_ELIBERARII'
          OnGetDisplayText = cxGridTable_DATA_ELIBERARIIGetDisplayText
          HeaderAlignmentHorz = taCenter
          MinWidth = 100
          Options.HorzSizing = False
          Width = 100
        end
        object cxGridTable_DT_NAME: TcxGridDBColumn
          Caption = 'Organizatia'
          DataBinding.FieldName = 'DT_NAME'
          MinWidth = 80
          Styles.Content = dmAdditions.cxStyle_Bold
          Width = 160
        end
        object cxGridTable_CT_NAME: TcxGridDBColumn
          Caption = 'Client'
          DataBinding.FieldName = 'CT_NAME'
          MinWidth = 80
          Styles.Content = dmAdditions.cxStyle_Bold
          Width = 160
        end
        object cxGridTable_SUMA: TcxGridDBColumn
          Caption = 'Suma'
          DataBinding.FieldName = 'SUMA'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          HeaderAlignmentHorz = taCenter
          MinWidth = 40
          Width = 80
        end
        object cxGridTable_CURRENCY_NAME: TcxGridDBColumn
          Caption = 'Valuta'
          DataBinding.FieldName = 'CURRENCY_NAME'
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taCenter
          HeaderAlignmentHorz = taCenter
          MinWidth = 50
          Options.HorzSizing = False
          Width = 50
        end
        object cxGridTable_VAT: TcxGridDBColumn
          Caption = 'TVA'
          DataBinding.FieldName = 'VAT'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          HeaderAlignmentHorz = taCenter
          MinWidth = 60
          Options.HorzSizing = False
          Width = 60
        end
        object cxGridTable_RATE: TcxGridDBColumn
          Caption = 'Rata'
          DataBinding.FieldName = 'RATE'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          HeaderAlignmentHorz = taCenter
          MinWidth = 50
          Options.HorzSizing = False
          Width = 50
        end
        object cxGridTable_FLG_ACNT: TcxGridDBColumn
          Caption = #1041#1091#1093#1075
          DataBinding.FieldName = 'FLG_ACNT'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          HeaderAlignmentHorz = taCenter
          MinWidth = 30
          Options.HorzSizing = False
          Width = 30
        end
        object cxGridTable_USER_NAME: TcxGridDBColumn
          Caption = #1042#1099#1076#1072#1083
          DataBinding.FieldName = 'USER_NAME'
          MinWidth = 60
          Width = 140
        end
        object cxGridTable_PROCURA_NO: TcxGridDBColumn
          Caption = #1053#1086#1084#1077#1088' '#1076#1086#1074#1077#1088#1077#1085#1086#1089#1090#1080
          DataBinding.FieldName = 'PROCURA_NO'
          HeaderAlignmentHorz = taCenter
          MinWidth = 120
          Options.HorzSizing = False
          Width = 120
        end
        object cxGridTable_DELEGAT: TcxGridDBColumn
          Caption = #1044#1077#1083#1077#1075#1072#1090
          DataBinding.FieldName = 'DELEGAT'
          MinWidth = 80
          Width = 140
        end
        object cxGridTable_DATA_START: TcxGridDBColumn
          Caption = #1040#1082#1090#1080#1074#1085#1072', '#1089
          DataBinding.FieldName = 'DATA_START'
          Width = 80
        end
        object cxGridTable_DATA_END: TcxGridDBColumn
          Caption = #1040#1082#1090#1080#1074#1085#1072', '#1087#1086
          DataBinding.FieldName = 'DATA_END'
          Width = 80
        end
        object cxGridTable_TRANSPORTATOR_NAME: TcxGridDBColumn
          Caption = #1055#1077#1088#1077#1074#1086#1079#1095#1080#1082
          DataBinding.FieldName = 'TRANSPORTATOR_NAME'
          MinWidth = 80
          Styles.Content = dmAdditions.cxStyle_Bold
          Width = 140
        end
        object cxGridTable_NRMATRICULARE: TcxGridDBColumn
          Caption = #8470' '#1090#1088#1072#1085#1089#1087#1086#1088#1090#1072
          DataBinding.FieldName = 'NRMATRICULARE'
          MinWidth = 40
          Width = 100
        end
        object cxGridTable_NRFOAIEDEPARCURS: TcxGridDBColumn
          Caption = #8470' '#1087#1091#1090'.'#1083#1080#1089#1090#1072
          DataBinding.FieldName = 'NRFOAIEDEPARCURS'
          MinWidth = 80
          Width = 100
        end
        object cxGridTable_FLG_CANCELED: TcxGridDBColumn
          Caption = #1040#1085#1085#1091#1083#1080#1088#1086#1074#1072#1085#1085#1072#1103
          DataBinding.FieldName = 'FLG_CANCELED'
          Visible = False
        end
      end
      object cxGridLevel: TcxGridLevel
        GridView = cxGridTable
      end
    end
  end
  object btnCancel: TcxButton
    Left = 839
    Top = 452
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Inchide'
    ModalResult = 2
    TabOrder = 2
  end
  object IBCDataSourceSearch: TIBCDataSource
    DataSet = IBCQuerySearch
    Left = 128
    Top = 220
  end
  object IBCQuerySearch: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT '
      ' *'
      'FROM'
      ' VW_SEARCH_INVOICE'
      'WHERE'
      ' FACTURANO like :FACTURANO')
    AutoCommit = False
    Left = 128
    Top = 276
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'FACTURANO'
        Value = nil
      end>
  end
end
