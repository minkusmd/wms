object frmGoodsInfoCardDlg: TfrmGoodsInfoCardDlg
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Miscarea produsului'
  ClientHeight = 569
  ClientWidth = 1134
  Color = clBtnFace
  Constraints.MinHeight = 400
  Constraints.MinWidth = 500
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 1134
    Height = 64
    Title = 'Miscarea produsului'
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
    ImageIndex = 1
  end
  object cxGrid: TcxGrid
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 1118
    Height = 444
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alClient
    TabOrder = 1
    object cxGridDBTable: TcxGridDBTableView
      OnKeyDown = cxGridDBTableKeyDown
      Navigator.Buttons.CustomButtons = <>
      ScrollbarAnnotations.CustomAnnotations = <>
      OnCustomDrawCell = cxGridDBTableCustomDrawCell
      DataController.DataSource = IBCDataSourceInfo
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <
        item
          Kind = skCount
          Column = cxGridDBTableDOCID
        end
        item
          Format = '0.00'
          Kind = skSum
          Column = cxGridDBTable_QTY_IN
        end
        item
          Format = '0.00'
          Kind = skSum
          Column = cxGridDBTable_QTY_OUT
        end>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.IncSearch = True
      OptionsBehavior.ImmediateEditor = False
      OptionsCustomize.ColumnsQuickCustomization = True
      OptionsSelection.InvertSelect = False
      OptionsView.CellEndEllipsis = True
      OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
      OptionsView.ColumnAutoWidth = True
      OptionsView.Footer = True
      OptionsView.GridLineColor = 13750737
      OptionsView.Indicator = True
      Styles.Footer = dmAdditions.cxStyle_GridHeader
      Styles.GroupByBox = dmAdditions.cxStyle_GridGroup
      Styles.Header = dmAdditions.cxStyle_GridHeader
      Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
      object cxGridDB_FLG_CLOSED: TcxGridDBColumn
        AlternateCaption = 'Inchis'
        Caption = 'Inchis'
        DataBinding.FieldName = 'FLG_CLOSED'
        DataBinding.IsNullValueType = True
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        HeaderAlignmentHorz = taCenter
        MinWidth = 28
        Options.HorzSizing = False
        Width = 28
      end
      object cxGridDBTableDOCTYPE_NAME: TcxGridDBColumn
        Caption = 'Tip document'
        DataBinding.FieldName = 'DOCTYPE_NAME'
        DataBinding.IsNullValueType = True
        Styles.OnGetContentStyle = cxGridDBTableDOCTYPE_NAMEStylesGetContentStyle
        Width = 133
      end
      object cxGridDBTable_VALUTA: TcxGridDBColumn
        Caption = 'Valuta'
        DataBinding.FieldName = 'CURRENCY_NAME'
        DataBinding.IsNullValueType = True
        HeaderAlignmentHorz = taCenter
        MinWidth = 50
        Options.HorzSizing = False
        Width = 50
      end
      object cxGridDB_FLG_ACNT: TcxGridDBColumn
        AlternateCaption = #1055#1086' '#1073#1091#1093#1075#1072#1083#1090#1077#1088#1080#1080
        Caption = 'Cntb'
        DataBinding.FieldName = 'FLG_ACNT'
        DataBinding.IsNullValueType = True
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        HeaderAlignmentHorz = taCenter
        MinWidth = 30
        Options.HorzSizing = False
        Width = 30
      end
      object cxGridDBTableDOCID: TcxGridDBColumn
        AlternateCaption = #1050#1086#1076' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
        Caption = 'Cod doc'
        DataBinding.FieldName = 'DOCID'
        DataBinding.IsNullValueType = True
        FooterAlignmentHorz = taRightJustify
        HeaderAlignmentHorz = taCenter
        MinWidth = 60
        Options.Filtering = False
        Options.HorzSizing = False
        Width = 60
      end
      object cxGridDBTable_CREATED_DATE: TcxGridDBColumn
        Caption = 'Data creare'
        DataBinding.FieldName = 'CREATED_DATE'
        DataBinding.IsNullValueType = True
        OnGetDisplayText = cxGridDBTable_CREATED_DATEGetDisplayText
        MinWidth = 50
        Options.Filtering = False
        Width = 67
      end
      object cxGridDBTable_DATA: TcxGridDBColumn
        AlternateCaption = 'Data document'
        Caption = 'Data'
        DataBinding.FieldName = 'DATA'
        DataBinding.IsNullValueType = True
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taCenter
        OnGetDisplayText = cxGridDBTable_DATAGetDisplayText
        HeaderAlignmentHorz = taCenter
        MinWidth = 100
        Options.Filtering = False
        Options.HorzSizing = False
        SortIndex = 0
        SortOrder = soAscending
        Width = 100
      end
      object cxGridDBTable_DT: TcxGridDBColumn
        DataBinding.FieldName = 'DT'
        DataBinding.IsNullValueType = True
        Visible = False
        VisibleForCustomization = False
      end
      object cxGridDBTable_DTNAME: TcxGridDBColumn
        Caption = 'Subdiviziune'
        DataBinding.FieldName = 'DTNAME'
        DataBinding.IsNullValueType = True
        Width = 111
      end
      object cxGridDBTable_CT: TcxGridDBColumn
        DataBinding.FieldName = 'CT'
        DataBinding.IsNullValueType = True
        Visible = False
        VisibleForCustomization = False
      end
      object cxGridDBTable_DTDEP_NAME: TcxGridDBColumn
        Caption = 'Depozit'
        DataBinding.FieldName = 'DTDEP_NAME'
        DataBinding.IsNullValueType = True
        Width = 94
      end
      object cxGridDBTable_CTNAME: TcxGridDBColumn
        Caption = 'Client'
        DataBinding.FieldName = 'CT_NAME2'
        DataBinding.IsNullValueType = True
        OnGetDisplayText = cxGridDBTable_CTNAMEGetDisplayText
        Width = 124
      end
      object cxGridDBTable_DOCTYPEID: TcxGridDBColumn
        DataBinding.FieldName = 'DOCTYPEID'
        DataBinding.IsNullValueType = True
        Visible = False
        VisibleForCustomization = False
      end
      object cxGridDBTable_CREATED_BY: TcxGridDBColumn
        DataBinding.FieldName = 'CREATED_BY'
        DataBinding.IsNullValueType = True
        Visible = False
        VisibleForCustomization = False
      end
      object cxGridDBTable_GOODSID: TcxGridDBColumn
        DataBinding.FieldName = 'GOODSID'
        DataBinding.IsNullValueType = True
        Visible = False
        VisibleForCustomization = False
      end
      object cxGridDBTable_CTDEP_NAME: TcxGridDBColumn
        Caption = 'Depozit client'
        DataBinding.FieldName = 'CTDEP_NAME'
        DataBinding.IsNullValueType = True
        OnGetDisplayText = cxGridDBTable_CTDEP_NAMEGetDisplayText
        Width = 96
      end
      object cxGridDBTable_QTY_IN: TcxGridDBColumn
        Caption = 'Intrari'
        DataBinding.FieldName = 'qty_in'
        DataBinding.IsNullValueType = True
        HeaderAlignmentHorz = taCenter
        MinWidth = 40
        Options.HorzSizing = False
        Width = 40
      end
      object cxGridDBTable_QTY_OUT: TcxGridDBColumn
        Caption = 'Iesiri'
        DataBinding.FieldName = 'QTY_OUT'
        DataBinding.IsNullValueType = True
        HeaderAlignmentHorz = taCenter
        MinWidth = 40
        Options.HorzSizing = False
        Width = 40
      end
      object cxGridDBTable_QTY: TcxGridDBColumn
        AlternateCaption = 'Cantitate'
        Caption = 'Cant'
        DataBinding.FieldName = 'QTY'
        DataBinding.IsNullValueType = True
        PropertiesClassName = 'TcxCalcEditProperties'
        Properties.Precision = 2
        HeaderAlignmentHorz = taCenter
        MinWidth = 40
        Options.HorzSizing = False
        Width = 40
      end
      object cxGridDBTable_PRICE: TcxGridDBColumn
        Caption = #1062#1077#1085#1072' $'
        DataBinding.FieldName = 'PRICE$'
        DataBinding.IsNullValueType = True
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        Visible = False
        HeaderAlignmentHorz = taCenter
        MinWidth = 70
        Options.Filtering = False
        Options.HorzSizing = False
        Width = 70
      end
      object cxGridDBTable_SUMA: TcxGridDBColumn
        Caption = #1057#1091#1084#1084#1072' $'
        DataBinding.FieldName = 'SUMA$'
        DataBinding.IsNullValueType = True
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        Visible = False
        HeaderAlignmentHorz = taCenter
        MinWidth = 80
        Options.Filtering = False
        Options.HorzSizing = False
        Width = 80
      end
      object cxGridDBTable_SEMN: TcxGridDBColumn
        Caption = 'Semn'
        DataBinding.FieldName = 'SEMN'
        DataBinding.IsNullValueType = True
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taCenter
        Properties.Alignment.Vert = taVCenter
        OnGetDisplayText = cxGridDBTable_SEMNGetDisplayText
        HeaderAlignmentHorz = taCenter
        MinWidth = 40
        Options.HorzSizing = False
        Styles.Content = dmAdditions.cxStyle_Bold
        Styles.OnGetContentStyle = cxGridDBTable_SEMNStylesGetContentStyle
        Width = 40
      end
      object cxGridDBTable_BALANCE_QTY: TcxGridDBColumn
        Caption = 'Balance'
        DataBinding.FieldName = 'BALANCE_QTY'
        DataBinding.IsNullValueType = True
        HeaderAlignmentHorz = taCenter
        MinWidth = 60
        Options.Filtering = False
        Options.HorzSizing = False
        Width = 60
      end
      object cxGridDBTable_Пользователь: TcxGridDBColumn
        Caption = 'Utilizator'
        DataBinding.FieldName = 'CREATED_BY_NAME'
        DataBinding.IsNullValueType = True
        Width = 124
      end
      object cxGridDBTable_DOC_SUMA: TcxGridDBColumn
        AlternateCaption = #1057#1091#1084#1084#1072' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
        Caption = #1057#1091#1084#1084#1072' '#1076#1086#1082'.'
        DataBinding.FieldName = 'DOC_SUMA'
        DataBinding.IsNullValueType = True
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        Visible = False
        HeaderAlignmentHorz = taCenter
        Width = 70
      end
      object cxGridDBTable_DOC_RATEUSD: TcxGridDBColumn
        Caption = #1050#1091#1088#1089' '#1076#1086#1082'.'
        DataBinding.FieldName = 'DOC_RATEUSD'
        DataBinding.IsNullValueType = True
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.0000'
        Visible = False
        HeaderAlignmentHorz = taCenter
        Width = 60
      end
      object cxGridDBTable_DTDEP: TcxGridDBColumn
        DataBinding.FieldName = 'DTDEP'
        DataBinding.IsNullValueType = True
        Visible = False
        VisibleForCustomization = False
      end
      object cxGridDBTable_CTDEP: TcxGridDBColumn
        DataBinding.FieldName = 'CTDEP'
        DataBinding.IsNullValueType = True
        Visible = False
        VisibleForCustomization = False
      end
    end
    object cxGridDBTableView1: TcxGridDBTableView
      OnKeyDown = cxGridDBTableView1KeyDown
      Navigator.Buttons.CustomButtons = <>
      ScrollbarAnnotations.CustomAnnotations = <>
      OnCustomDrawCell = cxGridDBTableView1CustomDrawCell
      DataController.DataSource = IBCDataSourceJurnal
      DataController.DetailKeyFieldNames = 'DOCID'
      DataController.MasterKeyFieldNames = 'DOCID'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.IncSearch = True
      OptionsBehavior.ImmediateEditor = False
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.InvertSelect = False
      OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
      OptionsView.ScrollBars = ssVertical
      OptionsView.ColumnAutoWidth = True
      OptionsView.GridLineColor = 13750737
      OptionsView.GroupByBox = False
      OptionsView.Indicator = True
      Styles.OnGetContentStyle = cxGridDBTableView1StylesGetContentStyle
      Styles.Header = dmAdditions.cxStyle_GridHeader
      Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
      object cxGridDBTableView1_IMG: TcxGridDBColumn
        DataBinding.IsNullValueType = True
        PropertiesClassName = 'TcxImageComboBoxProperties'
        Properties.DefaultImageIndex = 12
        Properties.Images = dmAdditions.cxImageList_SWN
        Properties.Items = <>
        MinWidth = 24
        Options.Focusing = False
        Options.HorzSizing = False
        VisibleForCustomization = False
        Width = 24
      end
      object cxGridDBTableView1_DTDEP_NAME: TcxGridDBColumn
        Caption = 'Depozit'
        DataBinding.FieldName = 'DTDEP_NAME'
        DataBinding.IsNullValueType = True
        MinWidth = 120
        Options.HorzSizing = False
        Width = 120
      end
      object cxGridDBTableView1_GOODSID: TcxGridDBColumn
        Caption = 'Cod'
        DataBinding.FieldName = 'GOODSID'
        DataBinding.IsNullValueType = True
        MinWidth = 50
        Options.HorzSizing = False
        Width = 50
      end
      object cxGridDBTableView1_GOODS_NAME: TcxGridDBColumn
        Caption = 'Produs'
        DataBinding.FieldName = 'GOODS_NAME'
        DataBinding.IsNullValueType = True
      end
      object cxGridDBTableView1_QTY: TcxGridDBColumn
        Caption = 'Cant'
        DataBinding.FieldName = 'QTY'
        DataBinding.IsNullValueType = True
        PropertiesClassName = 'TcxCalcEditProperties'
        Properties.DisplayFormat = '0.00'
        Properties.Precision = 15
        MinWidth = 60
        Options.HorzSizing = False
        Width = 60
      end
      object cxGridDBTableView1_PRICE: TcxGridDBColumn
        Caption = 'Pret'
        DataBinding.FieldName = 'PRICE'
        DataBinding.IsNullValueType = True
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        MinWidth = 80
        Options.HorzSizing = False
        Width = 80
      end
      object cxGridDBTableView1_PRICE_USD: TcxGridDBColumn
        Caption = 'Pret, $'
        DataBinding.FieldName = 'PRICE_USD'
        DataBinding.IsNullValueType = True
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;-,0.00'
        MinWidth = 64
        Options.HorzSizing = False
      end
      object cxGridDBTableView1_SUMA: TcxGridDBColumn
        Caption = 'Suma'
        DataBinding.FieldName = 'SUMA'
        DataBinding.IsNullValueType = True
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        MinWidth = 80
        Options.HorzSizing = False
        Width = 80
      end
      object cxGridDBTableView1_SUMA_USD: TcxGridDBColumn
        Caption = 'Suma, $'
        DataBinding.FieldName = 'SUMA_USD'
        DataBinding.IsNullValueType = True
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;-,0.00'
        MinWidth = 64
        Options.HorzSizing = False
      end
    end
    object cxGridLevel: TcxGridLevel
      GridView = cxGridDBTable
      object cxGridLevel1: TcxGridLevel
        GridView = cxGridDBTableView1
      end
    end
  end
  object pnBottom: TPanel
    Left = 0
    Top = 524
    Width = 1134
    Height = 45
    Align = alBottom
    BevelOuter = bvNone
    Padding.Left = 8
    Padding.Top = 4
    Padding.Right = 20
    Padding.Bottom = 12
    TabOrder = 2
    object btnClose: TcxButton
      Left = 1024
      Top = 4
      Width = 90
      Height = 29
      Align = alRight
      Cancel = True
      Caption = 'Inchide'
      ModalResult = 2
      TabOrder = 0
    end
  end
  object IBCQueryInfo: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT'
      '*'
      'FROM VW_TDB_DOCS'
      'WHERE DOCID = 1'
      'order by data desc')
    Left = 252
    Top = 224
  end
  object IBCDataSourceInfo: TIBCDataSource
    DataSet = IBCQueryInfo
    Left = 252
    Top = 172
  end
  object IBCQueryJurnal: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      'SELECT'
      '*'
      'FROM VW_TDB_JURNAL')
    MasterFields = 'DOCID'
    DetailFields = 'DOCID'
    MasterSource = IBCDataSourceInfo
    Left = 376
    Top = 228
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DOCID'
        Value = nil
      end>
  end
  object IBCDataSourceJurnal: TIBCDataSource
    DataSet = IBCQueryJurnal
    Left = 372
    Top = 172
  end
end
