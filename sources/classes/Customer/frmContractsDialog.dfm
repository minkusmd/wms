object frmContractsDlg: TfrmContractsDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1050#1086#1085#1090#1088#1072#1082#1090#1099
  ClientHeight = 443
  ClientWidth = 1026
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
    Width = 1026
    Height = 64
    Title = #1050#1086#1085#1090#1088#1072#1082#1090#1099
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
    ExplicitLeft = 504
    ExplicitTop = 140
    ExplicitWidth = 0
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 1010
    Height = 317
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 1
    object dxBarDockControl1: TdxBarDockControl
      Left = 0
      Top = 0
      Width = 1010
      Height = 30
      Align = dalTop
      BarManager = dxBarManager1
      SunkenBorder = True
      UseOwnSunkenBorder = True
    end
    object cxGridC: TcxGrid
      Left = 0
      Top = 30
      Width = 1010
      Height = 287
      Align = alClient
      TabOrder = 1
      ExplicitLeft = 568
      ExplicitTop = 112
      ExplicitWidth = 250
      ExplicitHeight = 200
      object cxGridCTable: TcxGridDBTableView
        OnFocusedRecordChanged = cxGridCTableFocusedRecordChanged
        DataController.DataSource = IBCDataSourceC
        DataController.KeyFieldNames = 'CONTRACTID'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsCustomize.ColumnsQuickCustomization = True
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
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        Styles.Header = dmAdditions.cxStyle_GridHeader
        object cxGridC_CONTRACTID: TcxGridDBColumn
          Caption = 'ID'
          DataBinding.FieldName = 'CONTRACTID'
          Visible = False
          HeaderAlignmentHorz = taCenter
          MinWidth = 50
          Options.Filtering = False
          Options.HorzSizing = False
          Width = 50
        end
        object cxGridC_CODE: TcxGridDBColumn
          Caption = #1053#1086#1084#1077#1088
          DataBinding.FieldName = 'CODE'
          HeaderAlignmentHorz = taCenter
          MinWidth = 50
          Options.HorzSizing = False
          Width = 50
        end
        object cxGridC_DT_NAME: TcxGridDBColumn
          Caption = #1060#1080#1088#1084#1072
          DataBinding.FieldName = 'DT_NAME'
          Width = 200
        end
        object cxGridC_CT_NAME: TcxGridDBColumn
          Caption = #1050#1086#1085#1090#1088#1072#1075#1077#1085#1090
          DataBinding.FieldName = 'CT_NAME'
          Width = 200
        end
        object cxGridC_CONTRACT_TYPE_TITLE: TcxGridDBColumn
          Caption = #1058#1080#1087' '#1082#1086#1085#1090#1088#1072#1082#1090#1072
          DataBinding.FieldName = 'CONTRACT_TYPE_TITLE'
          Width = 100
        end
        object cxGridC_SIGN_DATE: TcxGridDBColumn
          Caption = #1044#1072#1090#1072' '#1087#1086#1076#1087'.'
          DataBinding.FieldName = 'SIGN_DATE'
          HeaderAlignmentHorz = taCenter
          MinWidth = 100
          Options.Filtering = False
          Options.HorzSizing = False
          Width = 100
        end
        object cxGridC_EXPIRE_DATE: TcxGridDBColumn
          Caption = #1044#1072#1090#1072' '#1080#1089#1090#1077#1082'.'
          DataBinding.FieldName = 'EXPIRE_DATE'
          HeaderAlignmentHorz = taCenter
          MinWidth = 100
          Options.Filtering = False
          Options.HorzSizing = False
          Width = 100
        end
        object cxGridC_CURRENCY_TITLE: TcxGridDBColumn
          Caption = #1042#1072#1083#1102#1090#1072
          DataBinding.FieldName = 'CURRENCY_TITLE'
          HeaderAlignmentHorz = taCenter
          MinWidth = 60
          Options.HorzSizing = False
          Width = 60
        end
        object cxGridC_CREATED_BY_NAME: TcxGridDBColumn
          Caption = #1057#1086#1079#1076#1072#1083
          DataBinding.FieldName = 'CREATED_BY_NAME'
          Visible = False
          HeaderAlignmentHorz = taCenter
          Width = 100
        end
      end
      object cxGridCLevel: TcxGridLevel
        GridView = cxGridCTable
      end
    end
  end
  object btnCancel: TButton
    Left = 916
    Top = 400
    Width = 90
    Height = 29
    Cancel = True
    Caption = #1047#1072#1082#1088#1099#1090#1100
    ModalResult = 2
    TabOrder = 6
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
    ImageOptions.Images = dmAdditions.cxImageList_SWN
    ImageOptions.StretchGlyphs = False
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 636
    Top = 16
    DockControlHeights = (
      0
      0
      0
      0)
    object dxBarManager1Bar1: TdxBar
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
      FloatLeft = 1050
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
      ShortCut = 115
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
  object IBCQueryC: TIBCQuery
    KeyFields = 'CONTRACTID'
    KeyGenerator = 'SQ_TDB_CONTRACTS_ID'
    GeneratorMode = gmInsert
    SQLInsert.Strings = (
      'INSERT INTO TDB_CONTRACTS'
      
        '  (CONTRACTID, CODE, DT, CT, DT_RESPONSABILE_PERSON, CT_RESPONSA' +
        'BILE_PERSON, SIGN_DATE, EXPIRE_DATE, CONTRACT_BODY, PRICE_COLUMN' +
        ', CURRENCYID)'
      'VALUES'
      
        '  (:CONTRACTID, :CODE, :DT, :CT, :DT_RESPONSABILE_PERSON, :CT_RE' +
        'SPONSABILE_PERSON, :SIGN_DATE, :EXPIRE_DATE, :CONTRACT_BODY, :PR' +
        'ICE_COLUMN, :CURRENCYID)')
    SQLDelete.Strings = (
      'DELETE FROM TDB_CONTRACTS'
      'WHERE'
      '  CONTRACTID = :Old_CONTRACTID')
    SQLUpdate.Strings = (
      'UPDATE TDB_CONTRACTS'
      'SET'
      
        '  CODE = :CODE, DT = :DT, CT = :CT, DT_RESPONSABILE_PERSON = :DT' +
        '_RESPONSABILE_PERSON, CT_RESPONSABILE_PERSON = :CT_RESPONSABILE_' +
        'PERSON, SIGN_DATE = :SIGN_DATE, EXPIRE_DATE = :EXPIRE_DATE, CONT' +
        'RACT_BODY = :CONTRACT_BODY, PRICE_COLUMN = :PRICE_COLUMN, CURREN' +
        'CYID = :CURRENCYID'
      'WHERE'
      '  CONTRACTID = :Old_CONTRACTID')
    SQLRefresh.Strings = (
      'SELECT '
      '*'
      'FROM VW_TDB_CONTRACTS'
      'WHERE'
      '  CONTRACTID = :CONTRACTID')
    SQLLock.Strings = (
      'SELECT NULL FROM TDB_CONTRACTS'
      'WHERE'
      'CONTRACTID = :Old_CONTRACTID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = IBCTrUpdate
    SQL.Strings = (
      'SELECT'
      '*'
      'FROM VW_TDB_CONTRACTS'
      'WHERE CT=:CT')
    AutoCommit = False
    LockMode = lmLockImmediate
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Options.RequiredFields = False
    LocalConstraints = False
    Left = 68
    Top = 136
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CT'
      end>
  end
  object IBCDataSourceC: TIBCDataSource
    DataSet = IBCQueryC
    Left = 68
    Top = 228
  end
  object IBCTrUpdate: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 68
    Top = 292
  end
end
