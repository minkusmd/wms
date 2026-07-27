object frmDocTypeAnalyticsDlg: TfrmDocTypeAnalyticsDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1040#1085#1072#1083#1080#1090#1080#1082#1080' '#1076#1083#1103' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
  ClientHeight = 532
  ClientWidth = 602
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
    Width = 602
    Height = 64
    Title = #1040#1085#1072#1083#1080#1090#1080#1082#1080' '#1076#1083#1103' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
    Text = #1042#1099#1073#1077#1088#1080#1090#1077' '#1076#1086#1089#1090#1091#1087#1085#1099#1077' '#1072#1085#1072#1083#1080#1090#1080#1082#1080' '#1076#1083#1103' '#1076#1072#1085#1085#1086#1075#1086' '#1090#1080#1087#1072' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
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
    ImageIndex = 11
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 586
    Height = 405
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
    object Label1: TLabel
      Left = 16
      Top = 16
      Width = 81
      Height = 15
      Caption = #1058#1080#1087' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
    end
    object Label2: TLabel
      Left = 16
      Top = 72
      Width = 126
      Height = 15
      Caption = #1042#1099#1073#1088#1072#1085#1085#1099#1077' '#1072#1085#1072#1083#1080#1090#1080#1082#1080
    end
    object Label3: TLabel
      Left = 312
      Top = 72
      Width = 122
      Height = 15
      Caption = #1044#1086#1089#1090#1091#1087#1085#1099#1077' '#1072#1085#1072#1083#1080#1090#1080#1082#1080
    end
    object sbRemoveAnalytics: TSpeedButton
      Left = 266
      Top = 148
      Width = 34
      Height = 34
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1075#1088#1091#1087#1087#1091' '#1072#1085#1072#1083#1080#1090#1080#1082
      Caption = '>'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = sbRemoveAnalyticsClick
    end
    object sbAddAnalytics: TSpeedButton
      Left = 266
      Top = 108
      Width = 34
      Height = 34
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1075#1088#1091#1087#1087#1091' '#1072#1085#1072#1083#1080#1090#1080#1082
      Caption = '<'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = sbAddAnalyticsClick
    end
    object edDOCTYPE: TEdit
      Left = 16
      Top = 37
      Width = 546
      Height = 23
      TabStop = False
      ReadOnly = True
      TabOrder = 0
      Text = 'edDOCTYPE'
    end
    object cxGridSel: TcxGrid
      Left = 16
      Top = 89
      Width = 237
      Height = 292
      TabOrder = 1
      object cxGridSelTable: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        OnFocusedRecordChanged = cxGridSelTableFocusedRecordChanged
        DataController.DataSource = IBCDataSourceSel
        DataController.KeyFieldNames = 'ANALITICAID'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.ImmediateEditor = False
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnGrouping = False
        OptionsCustomize.ColumnHorzSizing = False
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.InvertSelect = False
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
        OptionsView.ScrollBars = ssVertical
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GridLines = glNone
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        Styles.Header = dmAdditions.cxStyle_GridHeader
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        object cxGridSel_IMG: TcxGridDBColumn
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.DefaultImageIndex = 13
          Properties.Images = dmAdditions.cxImageList_SWN
          Properties.Items = <>
          MinWidth = 24
          Options.Focusing = False
          Options.HorzSizing = False
          VisibleForCustomization = False
          Width = 24
        end
        object cxGridSel_TITLE: TcxGridDBColumn
          Caption = #1043#1088#1091#1087#1087#1072' '#1072#1085#1072#1083#1080#1090#1080#1082
          DataBinding.FieldName = 'TITLE'
        end
        object cxGridSel_ANALITICAID: TcxGridDBColumn
          DataBinding.FieldName = 'ANALITICAID'
          Visible = False
          VisibleForCustomization = False
        end
      end
      object cxGridSelLevel: TcxGridLevel
        GridView = cxGridSelTable
      end
    end
    object cxDBTreeListAV: TcxDBTreeList
      Left = 312
      Top = 89
      Width = 250
      Height = 292
      Bands = <
        item
        end>
      DataController.DataSource = IBCDataSourceAv
      DataController.ImageIndexField = 'IMAGEINDEX'
      DataController.ParentField = 'PARENTID'
      DataController.KeyField = 'ANALITICAID'
      Images = dmAdditions.cxImageList_SWN
      Navigator.Buttons.CustomButtons = <>
      OptionsBehavior.ChangeDelay = 1000
      OptionsBehavior.Sorting = False
      OptionsData.Editing = False
      OptionsSelection.InvertSelect = False
      OptionsView.ScrollBars = ssVertical
      OptionsView.ColumnAutoWidth = True
      OptionsView.GridLineColor = 13750737
      OptionsView.Indicator = True
      RootValue = 0
      ScrollbarAnnotations.CustomAnnotations = <>
      Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
      Styles.ColumnHeader = dmAdditions.cxStyle_GridHeader
      TabOrder = 2
      OnFocusedNodeChanged = cxDBTreeListAVFocusedNodeChanged
      object cxDBTreeList1cxDBTreeListColumn1: TcxDBTreeListColumn
        Visible = False
        DataBinding.FieldName = 'ANALITICAID'
        Width = 100
        Position.ColIndex = 0
        Position.RowIndex = 0
        Position.BandIndex = 0
        Summary.FooterSummaryItems = <>
        Summary.GroupFooterSummaryItems = <>
      end
      object cxDBTreeList1cxDBTreeListColumn2: TcxDBTreeListColumn
        Visible = False
        DataBinding.FieldName = 'PARENTID'
        Width = 100
        Position.ColIndex = 1
        Position.RowIndex = 0
        Position.BandIndex = 0
        Summary.FooterSummaryItems = <>
        Summary.GroupFooterSummaryItems = <>
      end
      object cxDBTreeList1cxDBTreeListColumn3: TcxDBTreeListColumn
        Caption.Text = #1043#1088#1091#1087#1087#1072' '#1072#1085#1072#1083#1080#1090#1080#1082
        DataBinding.FieldName = 'TITLE'
        Width = 100
        Position.ColIndex = 2
        Position.RowIndex = 0
        Position.BandIndex = 0
        Summary.FooterSummaryItems = <>
        Summary.GroupFooterSummaryItems = <>
      end
    end
  end
  object btnOk: TcxButton
    Left = 384
    Top = 488
    Width = 90
    Height = 29
    Caption = 'Ok'
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TcxButton
    Left = 488
    Top = 488
    Width = 90
    Height = 29
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
  object IBCQueryAv: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = IBCTrUpdate
    SQL.Strings = (
      'SELECT '
      ' ANALITICAID, '
      ' PARENTID, '
      ' TITLE,'
      ' 13 IMAGEINDEX'
      'FROM '
      ' TS_ANALYTICS '
      'WHERE '
      ' FLG_FOLDER=1'
      
        ' AND EXISTS(SELECT FLG_EXISTS FROM SP_CHECK_IF_ANALYTICS_EXISTS_' +
        'IN(:id,TS_ANALYTICS.ANALITICAID) WHERE FLG_EXISTS=0)'
      'ORDER BY TITLE')
    AutoCommit = False
    Left = 392
    Top = 312
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        Value = nil
      end>
  end
  object IBCDataSourceAv: TIBCDataSource
    DataSet = IBCQueryAv
    Left = 472
    Top = 312
  end
  object IBCQuerySel: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = IBCTrUpdate
    SQL.Strings = (
      'SELECT '
      ' ANALITICAID, '
      
        ' (SELECT TITLE FROM TS_ANALYTICS WHERE TS_ANALYTICS.ANALITICAID ' +
        '= TS_DOCS_ANALYTICS.ANALITICAID)'
      'FROM '
      ' TS_DOCS_ANALYTICS '
      'WHERE '
      ' DOCTYPEID=:id'
      'ORDER BY 2')
    AutoCommit = False
    Left = 88
    Top = 248
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        Value = nil
      end>
  end
  object IBCDataSourceSel: TIBCDataSource
    DataSet = IBCQuerySel
    Left = 88
    Top = 204
  end
  object IBCTrUpdate: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 280
    Top = 288
  end
end
