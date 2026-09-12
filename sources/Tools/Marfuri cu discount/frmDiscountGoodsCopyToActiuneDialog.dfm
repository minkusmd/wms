object frmDiscountGoodsCopyToActiuneDlg: TfrmDiscountGoodsCopyToActiuneDlg
  Left = 0
  Top = 0
  ActiveControl = cxGridActiuni
  BorderStyle = bsDialog
  Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1085#1080#1077' '#1090#1086#1074#1072#1088#1086#1074' '#1074' '#1040#1082#1094#1080#1102
  ClientHeight = 471
  ClientWidth = 496
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
    Width = 496
    Height = 64
    Title = #1050#1086#1087#1080#1088#1086#1074#1072#1085#1080#1077' '#1090#1086#1074#1072#1088#1086#1074' '#1074' '#1040#1082#1094#1080#1102
    Text = #1042#1099#1073#1077#1088#1080#1090#1077' '#1040#1082#1094#1080#1102', '#1074' '#1082#1086#1090#1086#1088#1091#1102' '#1073#1091#1076#1091#1090' '#1089#1082#1086#1087#1080#1088#1086#1074#1072#1085#1085#1099' '#1090#1086#1074#1072#1088#1099
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
  object cxGridActiuni: TcxGrid
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 480
    Height = 317
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    TabOrder = 1
    object cxGridATable: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      ScrollbarAnnotations.CustomAnnotations = <>
      OnFocusedRecordChanged = cxGridATableFocusedRecordChanged
      DataController.DataSource = IBCDataSourceActiuni
      DataController.KeyFieldNames = 'ACTIUNEID'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsCustomize.ColumnFiltering = False
      OptionsCustomize.ColumnSorting = False
      OptionsCustomize.ColumnsQuickCustomization = True
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
      OptionsView.ScrollBars = ssVertical
      OptionsView.ColumnAutoWidth = True
      OptionsView.GridLineColor = 13750737
      OptionsView.GroupByBox = False
      OptionsView.Indicator = True
      Styles.Header = dmAdditions.cxStyle_GridHeader
      Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
      object cxGridA_ACTIUNEID: TcxGridDBColumn
        Caption = 'ID'
        DataBinding.FieldName = 'ACTIUNEID'
        DataBinding.IsNullValueType = True
        Visible = False
        HeaderAlignmentHorz = taCenter
        MinWidth = 40
        Options.HorzSizing = False
        Width = 40
      end
      object cxGridA_TITLE_RUS: TcxGridDBColumn
        Caption = #1040#1082#1094#1080#1103
        DataBinding.FieldName = 'TITLE'
        DataBinding.IsNullValueType = True
      end
      object cxGridA_START_DATE: TcxGridDBColumn
        Caption = #1053#1072#1095#1072#1083#1086
        DataBinding.FieldName = 'START_DATE'
        DataBinding.IsNullValueType = True
        HeaderAlignmentHorz = taCenter
        MinWidth = 70
        Options.HorzSizing = False
        Width = 70
      end
      object cxGridA_END_DATE: TcxGridDBColumn
        Caption = #1050#1086#1085#1077#1094
        DataBinding.FieldName = 'END_DATE'
        DataBinding.IsNullValueType = True
        HeaderAlignmentHorz = taCenter
        MinWidth = 70
        Options.HorzSizing = False
        Width = 70
      end
      object cxGridA_FLG_ENDED: TcxGridDBColumn
        DataBinding.FieldName = 'FLG_ENDED'
        DataBinding.IsNullValueType = True
        Visible = False
        VisibleForCustomization = False
      end
    end
    object cxGridALevel: TcxGridLevel
      GridView = cxGridATable
    end
  end
  object btnCopy: TButton
    Left = 284
    Top = 427
    Width = 90
    Height = 29
    Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 388
    Top = 427
    Width = 90
    Height = 29
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
  object cbCopySelectedOnly: TCheckBox
    Left = 16
    Top = 400
    Width = 245
    Height = 17
    Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1090#1086#1083#1100#1082#1086' '#1074#1099#1076#1077#1083#1077#1085#1085#1099#1077' '#1090#1086#1074#1072#1088#1099
    TabOrder = 4
  end
  object IBCQueryActiuni: TIBCQuery
    GeneratorMode = gmInsert
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT '
      ' PROMOACTIONID, '
      ' TITLE, '
      ' START_DATE, '
      ' END_DATE, '
      ' FLG_ENABLED,'
      ' FLG_SHOW_BANNER, '
      ' FLG_SHOW_GOODS, '
      ' FLG_SHOW_BRICKS,'
      ' IIF(FLG_ENABLED=1,'
      '     IIF(DATEDIFF(DAY, CURRENT_DATE, END_DATE)<0,NULL,'
      
        '         IIF(DATEDIFF(DAY, CURRENT_DATE, END_DATE)>0,DATEDIFF(DA' +
        'Y, CURRENT_DATE, END_DATE),'#39#1089#1077#1075#1086#1076#1085#1103#39')'
      '        ),NULL'
      '    ) DAYS_REMAIN'
      'FROM '
      ' VW_TWEB_PROMOS'
      'ORDER BY'
      ' FLG_ENABLED DESC, PROMOACTIONID DESC')
    AutoCommit = False
    LockMode = lmLockImmediate
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Options.RequiredFields = False
    LocalConstraints = False
    Left = 64
    Top = 200
  end
  object IBCDataSourceActiuni: TIBCDataSource
    DataSet = IBCQueryActiuni
    Left = 64
    Top = 156
  end
end
