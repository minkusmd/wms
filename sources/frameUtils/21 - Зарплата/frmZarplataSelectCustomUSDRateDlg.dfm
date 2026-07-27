object frmZarplataSelectCustomUsdRateDialog: TfrmZarplataSelectCustomUsdRateDialog
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'frmZarplataSelectCustomUsdRateDialog'
  ClientHeight = 519
  ClientWidth = 522
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
  object DialogTitle1: TDialogTitle
    Left = 0
    Top = 0
    Width = 522
    Height = 64
    Title = #1042#1099#1073#1086#1088' '#1082#1091#1088#1089#1072' USD '#1080#1079' '#1076#1086#1082#1091#1084#1077#1085#1090#1072' "'#1053#1072#1095#1080#1089#1083#1077#1085#1080#1077' '#1079#1072#1088#1087#1083#1072#1090#1099'"'
    Text = #1042#1099#1073#1077#1088#1080#1090#1077' '#1090#1088#1077#1073#1091#1077#1084#1099#1081' '#1076#1086#1082#1091#1084#1077#1085#1090
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
  end
  object cxGrid: TcxGrid
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 506
    Height = 385
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    TabOrder = 1
    object cxGridTable: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = IBCDataSourceZP
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.ImmediateEditor = False
      OptionsBehavior.IncSearch = True
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.InvertSelect = False
      OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
      OptionsView.ScrollBars = ssVertical
      OptionsView.ColumnAutoWidth = True
      OptionsView.GridLineColor = 13750737
      OptionsView.GroupByBox = False
      OptionsView.GroupRowStyle = grsOffice11
      OptionsView.Indicator = True
      Styles.Group = dmAdditions.cxStyle_Bold
      Styles.GroupByBox = dmAdditions.cxStyle_GridGroup
      Styles.Header = dmAdditions.cxStyle_GridHeader
      object cxGrid_DOCID: TcxGridDBColumn
        Caption = #1050#1086#1076' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
        DataBinding.FieldName = 'DOCID'
        HeaderAlignmentHorz = taCenter
        MinWidth = 100
        Options.Filtering = False
        Options.IncSearch = False
        Options.HorzSizing = False
        Width = 100
      end
      object cxGrid_DATA: TcxGridDBColumn
        Caption = #1044#1072#1090#1072
        DataBinding.FieldName = 'DATA'
        HeaderAlignmentHorz = taCenter
        MinWidth = 120
        Options.Filtering = False
        Options.IncSearch = False
        Options.HorzSizing = False
        Width = 120
      end
      object cxGrid_RATEUSD: TcxGridDBColumn
        Caption = #1050#1091#1088#1089' USD'
        DataBinding.FieldName = 'RATEUSD'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 100
        Options.Filtering = False
        Options.IncSearch = False
        Options.HorzSizing = False
        Width = 100
      end
      object cxGrid_CREATED_BY_NAME: TcxGridDBColumn
        Caption = #1057#1086#1079#1076#1072#1083
        DataBinding.FieldName = 'CREATED_BY_NAME'
        HeaderAlignmentHorz = taCenter
      end
    end
    object cxGridLevel: TcxGridLevel
      GridView = cxGridTable
    end
  end
  object btnOk: TButton
    Left = 308
    Top = 472
    Width = 90
    Height = 29
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 412
    Top = 472
    Width = 90
    Height = 29
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
  object IBCQueryZP: TIBCQuery
    SQL.Strings = (
      'SELECT'
      
        ' DOCID, DATA, DT, RATEUSD, CREATED_BY, CREATED_BY_NAME, CAST(DAT' +
        'A AS DATE) DATE_ONLY'
      'FROM'
      ' VW_TDB_DOCS'
      'WHERE'
      ' DOCTYPEID=1514 AND DT=:currFirma'
      'ORDER BY DATA DESC')
    Left = 72
    Top = 284
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'currFirma'
        Value = nil
      end>
  end
  object IBCDataSourceZP: TIBCDataSource
    DataSet = IBCQueryZP
    Left = 72
    Top = 228
  end
end
