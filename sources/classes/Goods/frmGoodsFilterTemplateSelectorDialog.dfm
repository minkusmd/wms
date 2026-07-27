object frmGoodsFilterTemplateSelectorDlg: TfrmGoodsFilterTemplateSelectorDlg
  Left = 0
  Top = 0
  ActiveControl = cxGrid
  BorderStyle = bsDialog
  Caption = #1042#1099#1073#1086#1088' '#1096#1072#1073#1083#1086#1085#1072' '#1086#1087#1080#1089#1072#1085#1080#1081
  ClientHeight = 650
  ClientWidth = 535
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    535
    650)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 535
    Height = 64
    Title = #1042#1099#1073#1086#1088' '#1096#1072#1073#1083#1086#1085#1072' '#1086#1087#1080#1089#1072#1085#1080#1081
    Text = #1042#1099#1073#1077#1088#1080#1090#1077' '#1087#1086#1076#1093#1086#1076#1103#1097#1080#1081' '#1096#1072#1073#1083#1086#1085' '#1086#1087#1080#1089#1072#1085#1080#1081
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
  object cxGrid: TcxGrid
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 519
    Height = 524
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 1
    object cxGridTable: TcxGridDBTableView
      OnDblClick = cxGridTableDblClick
      Navigator.Buttons.CustomButtons = <>
      FindPanel.DisplayMode = fpdmAlways
      ScrollbarAnnotations.CustomAnnotations = <>
      OnFocusedRecordChanged = cxGridTableFocusedRecordChanged
      DataController.DataSource = IBCDataSourceTemplates
      DataController.KeyFieldNames = 'TEMPLATEID'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.IncSearch = True
      OptionsCustomize.ColumnFiltering = False
      OptionsCustomize.ColumnsQuickCustomization = True
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.InvertSelect = False
      OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1096#1072#1073#1083#1086#1085#1086#1074'>'
      OptionsView.ScrollBars = ssVertical
      OptionsView.ColumnAutoWidth = True
      OptionsView.GridLineColor = 13750737
      OptionsView.GroupByBox = False
      OptionsView.Indicator = True
      Styles.Header = dmAdditions.cxStyle_GridHeader
      object cxGridTable_TEMPLATEID: TcxGridDBColumn
        Caption = #1050#1086#1076
        DataBinding.FieldName = 'TEMPLATEID'
        Visible = False
        MinWidth = 50
        Options.HorzSizing = False
        Width = 50
      end
      object cxGridTable_TITLE_ROM: TcxGridDBColumn
        Caption = #536'ablon'
        DataBinding.FieldName = 'TITLE_ROM'
        SortIndex = 0
        SortOrder = soAscending
        Width = 100
      end
      object cxGridTable_TITLE_RUS: TcxGridDBColumn
        Caption = #1064#1072#1073#1083#1086#1085
        DataBinding.FieldName = 'TITLE_RUS'
        Width = 100
      end
    end
    object cxGridLevel: TcxGridLevel
      GridView = cxGridTable
    end
  end
  object btnOk: TcxButton
    Left = 324
    Top = 610
    Width = 90
    Height = 30
    Anchors = [akLeft, akBottom]
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TcxButton
    Left = 424
    Top = 610
    Width = 90
    Height = 30
    Anchors = [akLeft, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
  object IBCQueryTemplates: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      'SELECT '
      '  TEMPLATEID, '
      '  TITLE_ROM, '
      '  TITLE_RUS'
      'FROM '
      '  TS_DESCRIPTION_TEMPLATES')
    Left = 136
    Top = 204
  end
  object IBCDataSourceTemplates: TIBCDataSource
    DataSet = IBCQueryTemplates
    Left = 136
    Top = 148
  end
end
