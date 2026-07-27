object frmGoodsTypeNPSC_APList_Editor_Dlg: TfrmGoodsTypeNPSC_APList_Editor_Dlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1050#1086#1084#1087#1086#1085#1077#1085#1090#1099' '#1076#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1099#1093' '#1093#1072#1088#1072#1082#1090#1077#1088#1080#1089#1090#1080#1082
  ClientHeight = 405
  ClientWidth = 645
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
    Width = 645
    Height = 64
    Title = #1050#1086#1084#1087#1086#1085#1077#1085#1090#1099' '#1076#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1099#1093' '#1093#1072#1088#1072#1082#1090#1077#1088#1080#1089#1090#1080#1082
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
    ImageIndex = 11
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 629
    Height = 281
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
      Width = 629
      Height = 30
      Align = dalTop
      BarManager = dxBarManager1
      SunkenBorder = True
      UseOwnSunkenBorder = True
    end
    object cxGrid: TcxGrid
      AlignWithMargins = True
      Left = 0
      Top = 32
      Width = 629
      Height = 249
      Margins.Left = 0
      Margins.Top = 2
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alClient
      TabOrder = 1
      object cxGridTable: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        OnFocusedRecordChanged = cxGridTableFocusedRecordChanged
        DataController.DataSource = IBCDataSourceParams
        DataController.KeyFieldNames = 'ID'
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
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
        OptionsView.ScrollBars = ssVertical
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        Styles.Header = dmAdditions.cxStyle_GridHeader
        object cxGridTableColumn5: TcxGridDBColumn
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.DefaultImageIndex = 50
          Properties.Images = dmAdditions.cxImageList_SWN
          Properties.Items = <>
          MinWidth = 24
          Options.HorzSizing = False
          Width = 24
        end
        object cxGridTableColumn1: TcxGridDBColumn
          Caption = #1053#1072#1079#1074#1072#1085#1080#1077
          DataBinding.FieldName = 'PARAM_NAME_RUS'
        end
        object cxGridTableColumn2: TcxGridDBColumn
          Caption = #1053#1072#1079#1074#1072#1085#1080#1077', Rom'
          DataBinding.FieldName = 'PARAM_NAME_ROM'
        end
        object cxGridTableColumn3: TcxGridDBColumn
          Caption = #1047#1085#1072#1095#1077#1085#1080#1103
          DataBinding.FieldName = 'PARAM_VALUE'
        end
        object cxGridTableColumn4: TcxGridDBColumn
          DataBinding.FieldName = 'ORDERNO'
          Visible = False
          SortIndex = 0
          SortOrder = soAscending
          VisibleForCustomization = False
        end
        object cxGridTableColumn6: TcxGridDBColumn
          Caption = #1054#1087#1094'.'
          DataBinding.FieldName = 'FLG_OPTIONAL'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          HeaderAlignmentHorz = taCenter
          MinWidth = 34
          Options.HorzSizing = False
          Width = 34
        end
      end
      object cxGridLevel: TcxGridLevel
        GridView = cxGridTable
      end
    end
  end
  object btnClose: TButton
    Left = 532
    Top = 364
    Width = 90
    Height = 29
    Cancel = True
    Caption = #1047#1072#1082#1088#1099#1090#1100
    Default = True
    ModalResult = 1
    TabOrder = 2
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
    Left = 336
    Top = 4
    PixelsPerInch = 96
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
      FloatLeft = 669
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
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbSort'
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
    object bbSort: TdxBarButton
      Align = iaRight
      Caption = #1057#1086#1088#1090#1080#1088#1086#1074#1072#1090#1100
      Category = 0
      Hint = #1057#1086#1088#1090#1080#1088#1086#1074#1072#1090#1100
      Visible = ivAlways
      ImageIndex = 38
      OnClick = bbSortClick
    end
  end
  object IBCQueryParams: TIBCQuery
    KeyFields = 'ID'
    KeyGenerator = 'SQ_NGS_NAM2_PARAMS_ID'
    GeneratorMode = gmInsert
    SQLInsert.Strings = (
      'INSERT INTO NGS_NAM2_PARAMS'
      
        '  (ID, GOODSTYPEID, PARAM_NAME_ROM, PARAM_NAME_RUS, PARAM_VALUE,' +
        ' FLG_OPTIONAL, FLG_VALUE_IS_COMMENT)'
      'VALUES'
      
        '  (:ID, :GOODSTYPEID, :PARAM_NAME_ROM, :PARAM_NAME_RUS, :PARAM_V' +
        'ALUE, :FLG_OPTIONAL, :FLG_VALUE_IS_COMMENT)')
    SQLDelete.Strings = (
      'DELETE FROM NGS_NAM2_PARAMS'
      'WHERE'
      '  ID = :Old_ID')
    SQLUpdate.Strings = (
      'UPDATE NGS_NAM2_PARAMS'
      'SET'
      '  ID = :ID, GOODSTYPEID = :GOODSTYPEID, '
      '  PARAM_NAME_ROM = :PARAM_NAME_ROM, '
      '  PARAM_NAME_RUS = :PARAM_NAME_RUS, '
      '  PARAM_VALUE = :PARAM_VALUE,'
      '  FLG_OPTIONAL = :FLG_OPTIONAL,'
      '  FLG_VALUE_IS_COMMENT = :FLG_VALUE_IS_COMMENT'
      'WHERE'
      '  ID = :Old_ID')
    SQLRefresh.Strings = (
      'SELECT '
      
        ' ID, GOODSTYPEID, PARAM_NAME_ROM, PARAM_NAME_RUS, PARAM_VALUE, O' +
        'RDERNO, FLG_OPTIONAL, FLG_VALUE_IS_COMMENT '
      'FROM '
      ' NGS_NAM2_PARAMS'
      'WHERE'
      ' ID = :ID')
    SQLLock.Strings = (
      'SELECT NULL FROM NGS_NAM2_PARAMS'
      'WHERE'
      'ID = :Old_ID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT '
      
        ' ID, GOODSTYPEID, PARAM_NAME_ROM, PARAM_NAME_RUS, PARAM_VALUE, O' +
        'RDERNO, FLG_OPTIONAL, FLG_VALUE_IS_COMMENT '
      'FROM '
      ' NGS_NAM2_PARAMS')
    MasterFields = 'GOODSTYPEID'
    DetailFields = 'GOODSTYPEID'
    AutoCommit = False
    LockMode = lmLockImmediate
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Options.RequiredFields = False
    LocalConstraints = False
    Left = 140
    Top = 224
  end
  object IBCDataSourceParams: TIBCDataSource
    DataSet = IBCQueryParams
    Left = 144
    Top = 176
  end
end
