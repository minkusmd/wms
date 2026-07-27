object frmWebBigBannersDlg: TfrmWebBigBannersDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1041#1086#1083#1100#1096#1080#1077' '#1073#1072#1085#1085#1077#1088#1099' '#1085#1072' '#1075#1083#1072#1074#1085#1086#1081' '#1089#1090#1088#1072#1085#1080#1094#1099
  ClientHeight = 514
  ClientWidth = 724
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
    Width = 724
    Height = 64
    Title = #1041#1086#1083#1100#1096#1080#1077' '#1073#1072#1085#1085#1077#1088#1099' '#1085#1072' '#1075#1083#1072#1074#1085#1086#1081' '#1089#1090#1088#1072#1085#1080#1094#1099
    Text = #1040#1076#1084#1080#1085#1080#1089#1090#1088#1080#1088#1086#1074#1072#1085#1080#1077' '#1073#1072#1085#1085#1077#1088#1086#1074' '#1085#1072' '#1075#1083#1072#1074#1085#1086#1081' '#1089#1090#1088#1072#1085#1080#1094#1099' '#1089#1072#1081#1090#1072
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
    ImageIndex = 30
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 708
    Height = 389
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object dxBarDockControl1: TdxBarDockControl
      Left = 0
      Top = 0
      Width = 708
      Height = 30
      Align = dalTop
      BarManager = dxBarManager
      SunkenBorder = True
      UseOwnSunkenBorder = True
    end
    object cxGrid: TcxGrid
      Left = 0
      Top = 30
      Width = 708
      Height = 359
      Align = alClient
      TabOrder = 1
      object cxGridTable: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        OnCellDblClick = cxGridTableCellDblClick
        OnCustomDrawCell = cxGridTableCustomDrawCell
        OnFocusedRecordChanged = cxGridTableFocusedRecordChanged
        DataController.DataSource = IBCDataSourceBanner
        DataController.KeyFieldNames = 'BANNERID'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsCustomize.ColumnFiltering = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsView.CellEndEllipsis = True
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1073#1072#1085#1085#1077#1088#1086#1074'>'
        OptionsView.ScrollBars = ssVertical
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        Styles.Header = dmAdditions.cxStyle_GridHeader
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        object cxGrid_BANNERID: TcxGridDBColumn
          Caption = #1050#1086#1076
          DataBinding.FieldName = 'BANNERID'
          HeaderAlignmentHorz = taCenter
          MinWidth = 50
          Options.HorzSizing = False
          SortIndex = 0
          SortOrder = soDescending
          Width = 50
        end
        object cxGrid_TITLE: TcxGridDBColumn
          Caption = #1053#1072#1079#1074#1072#1085#1080#1077
          DataBinding.FieldName = 'TITLE'
          Width = 100
        end
        object cxGrid_START_DATE: TcxGridDBColumn
          Caption = #1053#1072#1095#1072#1083#1086' '#1087#1086#1082#1072#1079#1072
          DataBinding.FieldName = 'START_DATE'
          HeaderAlignmentHorz = taCenter
          MinWidth = 90
          Options.HorzSizing = False
          Width = 90
        end
        object cxGrid_END_DATE: TcxGridDBColumn
          Caption = #1050#1086#1085#1077#1094' '#1087#1086#1082#1072#1079#1072
          DataBinding.FieldName = 'END_DATE'
          HeaderAlignmentHorz = taCenter
          MinWidth = 90
          Options.HorzSizing = False
          Width = 90
        end
        object cxGrid_FLG_VISIBLE: TcxGridDBColumn
          DataBinding.FieldName = 'FLG_VISIBLE'
          Visible = False
          VisibleForCustomization = False
        end
        object cxGrid_NAV_URL: TcxGridDBColumn
          Caption = #1040#1076#1088#1077#1089' '#1087#1077#1088#1077#1093#1086#1076#1072
          DataBinding.FieldName = 'NAV_URL'
          Width = 100
        end
      end
      object cxGridLevel: TcxGridLevel
        GridView = cxGridTable
      end
    end
  end
  object btnClose: TButton
    Left = 612
    Top = 472
    Width = 90
    Height = 29
    Cancel = True
    Caption = #1047#1072#1082#1088#1099#1090#1100
    ModalResult = 2
    TabOrder = 2
  end
  object dxBarManager: TdxBarManager
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
    ImageOptions.Images = dmAdditions.cxImageList_SWN
    ImageOptions.StretchGlyphs = False
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 504
    Top = 116
    PixelsPerInch = 96
    object dxBarManagerBar1: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Custom 1'
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 748
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbNew'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbEdit'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbDelete'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object bbNew: TdxBarButton
      Caption = #1053#1086#1074#1099#1081
      Category = 0
      Hint = #1053#1086#1074#1099#1081
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 45
      OnClick = bbNewClick
    end
    object bbEdit: TdxBarButton
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      Category = 0
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 113
      OnClick = bbEditClick
    end
    object bbDelete: TdxBarButton
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Category = 0
      Hint = #1059#1076#1072#1083#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 42
      ShortCut = 46
      OnClick = bbDeleteClick
    end
  end
  object IBCQueryBanner: TIBCQuery
    KeyFields = 'BANNERID'
    KeyGenerator = 'SQ_TWEB_BIGBANNERS_ID'
    GeneratorMode = gmInsert
    SQLInsert.Strings = (
      'INSERT INTO TWEB_BIGBANNERS'
      
        '  (BANNERID, TITLE, START_DATE, END_DATE, NAV_URL, FLG_IMAGES_UR' +
        'L, IMAGES_URL)'
      'VALUES'
      
        '  (:BANNERID, :TITLE, :START_DATE, :END_DATE, :NAV_URL, :FLG_IMA' +
        'GES_URL, :IMAGES_URL)')
    SQLDelete.Strings = (
      'DELETE FROM TWEB_BIGBANNERS'
      'WHERE'
      '  BANNERID = :Old_BANNERID')
    SQLUpdate.Strings = (
      'UPDATE TWEB_BIGBANNERS'
      'SET'
      '  BANNERID = :BANNERID, '
      '  TITLE = :TITLE, '
      '  START_DATE = :START_DATE, '
      '  END_DATE = :END_DATE,'
      '  NAV_URL = :NAV_URL,'
      '  FLG_IMAGES_URL = :FLG_IMAGES_URL,'
      '  IMAGES_URL = :IMAGES_URL'
      'WHERE'
      '  BANNERID = :Old_BANNERID')
    SQLRefresh.Strings = (
      'SELECT '
      ' BANNERID, '
      ' TITLE, '
      ' START_DATE, '
      ' END_DATE,'
      ' NAV_URL,'
      
        ' IIF((CURRENT_DATE>=START_DATE AND CURRENT_DATE<=END_DATE),1,0) ' +
        'FLG_VISIBLE,'
      ' FLG_IMAGES_URL,'
      ' IMAGES_URL'
      'FROM '
      ' TWEB_BIGBANNERS'
      'WHERE'
      ' BANNERID = :BANNERID')
    SQLLock.Strings = (
      'SELECT NULL FROM TWEB_BIGBANNERS'
      'WHERE'
      'BANNERID = :Old_BANNERID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = IBCTrUpdate
    SQL.Strings = (
      'SELECT '
      ' BANNERID, '
      ' TITLE, '
      ' START_DATE, '
      ' END_DATE,'
      ' NAV_URL,'
      
        ' IIF((CURRENT_DATE>=START_DATE AND CURRENT_DATE<=END_DATE),1,0) ' +
        'FLG_VISIBLE,'
      ' FLG_IMAGES_URL,'
      ' IMAGES_URL'
      'FROM '
      ' TWEB_BIGBANNERS'
      'ORDER BY 1 DESC')
    AutoCommit = False
    LockMode = lmLockImmediate
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Left = 80
    Top = 144
  end
  object IBCDataSourceBanner: TIBCDataSource
    DataSet = IBCQueryBanner
    Left = 80
    Top = 212
  end
  object IBCTrUpdate: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 168
    Top = 180
  end
end
