object frmServiceNewIncidentVVTDlg: TfrmServiceNewIncidentVVTDlg
  Left = 0
  Top = 0
  ActiveControl = cxGrid
  BorderIcons = [biSystemMenu]
  Caption = 'Aspectul exterior al produsului'
  ClientHeight = 474
  ClientWidth = 580
  Color = clBtnFace
  Constraints.MinHeight = 400
  Constraints.MinWidth = 400
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
    Width = 580
    Height = 64
    Title = 'Aspectul exterior al produsului'
    Text = 'Alegeti descrierea aspectului exterior al produsului'
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
    ImageIndex = 10
  end
  object pnBottom: TPanel
    Left = 0
    Top = 429
    Width = 580
    Height = 45
    Align = alBottom
    BevelOuter = bvNone
    Padding.Left = 8
    Padding.Top = 4
    Padding.Right = 24
    Padding.Bottom = 12
    TabOrder = 2
    object btnOk: TButton
      Left = 364
      Top = 4
      Width = 90
      Height = 29
      Align = alRight
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
    object btnCancel: TButton
      AlignWithMargins = True
      Left = 466
      Top = 4
      Width = 90
      Height = 29
      Margins.Left = 12
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alRight
      Cancel = True
      Caption = 'Renunta'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object cxGrid: TcxGrid
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 564
    Height = 349
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alClient
    TabOrder = 1
    object cxGridDBTable: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      OnCellDblClick = cxGridDBTableCellDblClick
      DataController.DataSource = IBCDataSourceAspect
      DataController.KeyFieldNames = 'SYSSID'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.CopyCaptionsToClipboard = False
      OptionsBehavior.IncSearch = True
      OptionsBehavior.CopyPreviewToClipboard = False
      OptionsCustomize.ColumnFiltering = False
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
      Styles.Header = dmAdditions.cxStyle_GridHeader
      object cxGridDBTable_SYSSID: TcxGridDBColumn
        DataBinding.FieldName = 'SYSSID'
        Visible = False
        VisibleForCustomization = False
      end
      object cxGridDBTable_TITLE: TcxGridDBColumn
        Caption = 'Denumire'
        DataBinding.FieldName = 'TITLE'
        PropertiesClassName = 'TcxTextEditProperties'
        Width = 200
      end
    end
    object cxGridLevel: TcxGridLevel
      GridView = cxGridDBTable
    end
  end
  object IBCQueryAspect: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      'SELECT SYSSID, TITLE FROM TS_SYSS WHERE PARENTID=32')
    Constraints = <>
    Left = 56
    Top = 172
  end
  object IBCDataSourceAspect: TIBCDataSource
    DataSet = IBCQueryAspect
    Left = 52
    Top = 240
  end
end
