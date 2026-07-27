object frmSelectBannerDlg: TfrmSelectBannerDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1041#1072#1085#1085#1077#1088' '#1076#1083#1103' '#1088#1072#1089#1089#1099#1083#1082#1080
  ClientHeight = 628
  ClientWidth = 1052
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    1052
    628)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 1052
    Height = 64
    Title = #1041#1072#1085#1085#1077#1088' '#1076#1083#1103' '#1088#1072#1089#1089#1099#1083#1082#1080
    Text = #1042#1099#1073#1077#1088#1080#1090#1077' '#1073#1072#1085#1085#1077#1088' '#1076#1083#1103' '#1088#1072#1089#1089#1099#1083#1082#1080
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
    ImageIndex = 0
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 1036
    Height = 501
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelOuter = bvNone
    TabOrder = 1
    object cxGridActiuni: TcxGrid
      Left = 0
      Top = 0
      Width = 285
      Height = 501
      Align = alLeft
      TabOrder = 0
      object cxGridActiuniTable: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = IBCDataSourceActiuni
        DataController.KeyFieldNames = 'PROMOACTIONID'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnSorting = False
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsSelection.InvertSelect = False
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1087#1088#1086#1084#1086'-'#1072#1082#1094#1080#1081'>'
        OptionsView.ScrollBars = ssVertical
        OptionsView.CellAutoHeight = True
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        Styles.Header = dmAdditions.cxStyle_GridHeader
        object cxGridActiuniTableColumn1: TcxGridDBColumn
          Caption = #1040#1082#1094#1080#1103
          DataBinding.FieldName = 'TITLE'
        end
      end
      object cxGridActiuniLevel: TcxGridLevel
        GridView = cxGridActiuniTable
      end
    end
    object cxGridImages: TcxGrid
      AlignWithMargins = True
      Left = 287
      Top = 0
      Width = 749
      Height = 501
      Margins.Left = 2
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alClient
      TabOrder = 1
      object cxGridImagesTable: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = IBCDataSourceBlocks
        DataController.KeyFieldNames = 'PAIMAGEBRICKID'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnSorting = False
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.InvertSelect = False
        OptionsSelection.MultiSelect = True
        OptionsSelection.CellMultiSelect = True
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1073#1072#1085#1085#1077#1088#1086#1074'>'
        OptionsView.ScrollBars = ssVertical
        OptionsView.CellAutoHeight = True
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        Styles.Header = dmAdditions.cxStyle_GridHeader
        object cxGridImagesTableColumn1: TcxGridDBColumn
          Caption = #1041#1072#1085#1085#1077#1088
          DataBinding.FieldName = 'IMAGE'
          PropertiesClassName = 'TcxImageProperties'
          Properties.GraphicClassName = 'TdxSmartImage'
          Properties.ReadOnly = True
          Properties.ShowFocusRect = False
        end
        object colPAIMAGEBRICKID: TcxGridDBColumn
          DataBinding.FieldName = 'PAIMAGEBRICKID'
          Visible = False
          VisibleForCustomization = False
        end
      end
      object cxGridImagesLevel: TcxGridLevel
        GridView = cxGridImagesTable
      end
    end
  end
  object btnOk: TButton
    Left = 840
    Top = 584
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 940
    Top = 584
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
  object IBCQueryActiuni: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
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
      'WHERE'
      ' FLG_SHOW_BRICKS=1'
      'ORDER BY'
      ' FLG_ENABLED DESC, PROMOACTIONID DESC')
    AutoCommit = False
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Left = 108
    Top = 132
  end
  object IBCDataSourceActiuni: TIBCDataSource
    AutoEdit = False
    DataSet = IBCQueryActiuni
    Left = 108
    Top = 192
  end
  object IBCQueryBlocks: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      'SELECT '
      ' PAIMAGEBRICKID, '
      ' PROMOACTIONID, '
      ' IMAGE, '
      ' ORDERNO,'
      ' IMAGE_WIDTH,'
      ' IMAGE_HEIGHT'
      'FROM '
      ' VW_TWEB_PA_IMAGEBRICKS'
      'ORDER BY ORDERNO')
    MasterFields = 'PROMOACTIONID'
    DetailFields = 'PROMOACTIONID'
    MasterSource = IBCDataSourceActiuni
    AutoCommit = False
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Options.DetailDelay = 500
    Left = 520
    Top = 148
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PROMOACTIONID'
        Value = nil
      end>
  end
  object IBCDataSourceBlocks: TIBCDataSource
    DataSet = IBCQueryBlocks
    Left = 520
    Top = 212
  end
end
