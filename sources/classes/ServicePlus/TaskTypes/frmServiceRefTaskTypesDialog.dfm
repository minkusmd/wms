object frmServiceRefTaskTypesDlg: TfrmServiceRefTaskTypesDlg
  Left = 0
  Top = 0
  ActiveControl = cxGrid
  BorderIcons = [biSystemMenu]
  Caption = #1058#1080#1087#1099' '#1079#1072#1076#1072#1095
  ClientHeight = 561
  ClientWidth = 632
  Color = clBtnFace
  Constraints.MaxHeight = 800
  Constraints.MaxWidth = 800
  Constraints.MinHeight = 400
  Constraints.MinWidth = 500
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
    Width = 632
    Height = 64
    Title = #1058#1080#1087#1099' '#1079#1072#1076#1072#1095
    Text = #1040#1076#1084#1080#1085#1080#1089#1090#1088#1080#1088#1086#1074#1072#1085#1080#1077' '#1089#1087#1088#1072#1074#1086#1095#1085#1080#1082#1072
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
    ImageIndex = 32
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 616
    Height = 428
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object dxBarDockControl1: TdxBarDockControl
      Left = 0
      Top = 0
      Width = 616
      Height = 30
      Align = dalTop
      BarManager = dxBarManager
      SunkenBorder = True
      UseOwnSunkenBorder = True
    end
    object cxGrid: TcxGrid
      Left = 0
      Top = 30
      Width = 616
      Height = 398
      Align = alClient
      TabOrder = 1
      object cxGridTable: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        OnFocusedRecordChanged = cxGridTableFocusedRecordChanged
        DataController.DataSource = IBCDataSourceTT
        DataController.KeyFieldNames = 'TASKTYPEID'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.CopyCaptionsToClipboard = False
        OptionsBehavior.IncSearch = True
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnSorting = False
        OptionsCustomize.ColumnsQuickCustomization = True
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.InvertSelect = False
        OptionsView.CellEndEllipsis = True
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
        OptionsView.ScrollBars = ssVertical
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        Styles.Header = dmAdditions.cxStyle_GridHeader
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        object cxGridTable_TASKTYPEID: TcxGridDBColumn
          Caption = #1050#1086#1076
          DataBinding.FieldName = 'TASKTYPEID'
          Visible = False
          HeaderAlignmentHorz = taCenter
          MinWidth = 50
          Options.HorzSizing = False
          Width = 50
        end
        object cxGridTable_DefImage: TcxGridDBColumn
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.DefaultImageIndex = 45
          Properties.Images = dmAdditions.cxImageList_SWN
          Properties.Items = <>
          MinWidth = 24
          Options.Focusing = False
          Options.HorzSizing = False
          Width = 24
        end
        object cxGridTable_TITLE: TcxGridDBColumn
          Caption = #1053#1072#1079#1074#1072#1085#1080#1077
          DataBinding.FieldName = 'TITLE'
          SortIndex = 3
          SortOrder = soAscending
          Width = 100
        end
        object cxGridTable_DESCRIPTION: TcxGridDBColumn
          Caption = #1054#1087#1080#1089#1072#1085#1080#1077
          DataBinding.FieldName = 'DESCRIPTION'
          Visible = False
          Width = 200
        end
        object cxGridTable_FLG_START_STATE: TcxGridDBColumn
          Caption = #1053
          DataBinding.FieldName = 'FLG_START_STATE'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          HeaderAlignmentHorz = taCenter
          MinWidth = 40
          Options.HorzSizing = False
          SortIndex = 0
          SortOrder = soDescending
          Width = 40
        end
        object cxGridTable_FLG_END_STATE: TcxGridDBColumn
          Caption = #1056
          DataBinding.FieldName = 'FLG_END_STATE'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          HeaderAlignmentHorz = taCenter
          MinWidth = 40
          Options.HorzSizing = False
          SortIndex = 1
          SortOrder = soDescending
          Width = 40
        end
        object cxGridTable_FLG_CODE_STATE: TcxGridDBColumn
          Caption = #1050
          DataBinding.FieldName = 'FLG_CODE_STATE'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          HeaderAlignmentHorz = taCenter
          MinWidth = 40
          Options.HorzSizing = False
          SortIndex = 2
          SortOrder = soDescending
          Width = 40
        end
        object cxGridTable_VALUE_INT: TcxGridDBColumn
          Caption = #1056#1077#1079'.'
          DataBinding.FieldName = 'VALUE_INT'
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.Alignment.Horz = taCenter
          Properties.ImageAlign = iaRight
          Properties.Images = dmAdditions.cxImageList_SWN
          Properties.Items = <
            item
              ImageIndex = 60
              Value = -1
            end
            item
              ImageIndex = 59
              Value = 1
            end>
          HeaderAlignmentHorz = taCenter
          MinWidth = 30
          Options.HorzSizing = False
          Width = 30
        end
      end
      object cxGridLevel: TcxGridLevel
        GridView = cxGridTable
      end
    end
  end
  object pnButtons: TPanel
    Left = 0
    Top = 508
    Width = 632
    Height = 53
    Align = alBottom
    BevelOuter = bvNone
    Padding.Left = 8
    Padding.Top = 8
    Padding.Right = 20
    Padding.Bottom = 16
    TabOrder = 2
    object btnClose: TButton
      Left = 522
      Top = 8
      Width = 90
      Height = 29
      Align = alRight
      Cancel = True
      Caption = #1047#1072#1082#1088#1099#1090#1100
      ModalResult = 2
      TabOrder = 0
    end
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
    Left = 404
    Top = 12
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
      FloatLeft = 688
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
      Caption = #1053#1086#1074#1072#1103
      Category = 0
      Hint = #1053#1086#1074#1072#1103
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
  object IBCQueryTT: TIBCQuery
    KeyFields = 'TASKTYPEID'
    KeyGenerator = 'SQ_SC_REF_TASK_TYPE_ID'
    GeneratorMode = gmInsert
    SQLInsert.Strings = (
      'INSERT INTO VW_SC_REF_TASK_TYPE'
      
        '  (TASKTYPEID, TITLE, DESCRIPTION, FLG_ENABLED, FLG_START_STATE,' +
        ' FLG_END_STATE, FLG_CODE_STATE, FLG_OTHER_EXECUTANT, VALUE_INT, ' +
        'USER_GROUP_ID)'
      'VALUES'
      
        '  (:TASKTYPEID, :TITLE, :DESCRIPTION, :FLG_ENABLED, :FLG_START_S' +
        'TATE, :FLG_END_STATE, :FLG_CODE_STATE, :FLG_OTHER_EXECUTANT, :VA' +
        'LUE_INT, :USER_GROUP_ID)')
    SQLDelete.Strings = (
      'DELETE FROM SC_REF_TASK_TYPE'
      'WHERE'
      '  TASKTYPEID = :Old_TASKTYPEID')
    SQLUpdate.Strings = (
      'UPDATE VW_SC_REF_TASK_TYPE'
      'SET'
      ' TITLE = :TITLE, '
      ' DESCRIPTION = :DESCRIPTION, '
      ' FLG_ENABLED = :FLG_ENABLED, '
      ' FLG_START_STATE = :FLG_START_STATE, '
      ' FLG_END_STATE = :FLG_END_STATE, '
      ' FLG_CODE_STATE = :FLG_CODE_STATE, '
      ' FLG_OTHER_EXECUTANT = :FLG_OTHER_EXECUTANT,'
      ' VALUE_INT = :VALUE_INT,'
      ' USER_GROUP_ID = :USER_GROUP_ID'
      'WHERE'
      '  TASKTYPEID = :Old_TASKTYPEID')
    SQLRefresh.Strings = (
      'SELECT '
      ' TASKTYPEID, '
      ' TITLE, '
      ' DESCRIPTION, '
      ' FLG_ENABLED, '
      ' FLG_START_STATE, '
      ' FLG_END_STATE, '
      ' FLG_CODE_STATE,'
      ' FLG_OTHER_EXECUTANT, '
      ' VALUE_INT,'
      ' USER_GROUP_ID '
      'FROM '
      ' VW_SC_REF_TASK_TYPE'
      'WHERE'
      ' TASKTYPEID = :TASKTYPEID')
    SQLLock.Strings = (
      'SELECT NULL FROM SC_REF_TASK_TYPE'
      'WHERE'
      'TASKTYPEID = :Old_TASKTYPEID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'SELECT '
      ' TASKTYPEID, '
      ' TITLE, '
      ' DESCRIPTION, '
      ' FLG_ENABLED, '
      ' FLG_START_STATE, '
      ' FLG_END_STATE, '
      ' FLG_CODE_STATE,'
      ' FLG_OTHER_EXECUTANT, '
      ' VALUE_INT,'
      ' USER_GROUP_ID'
      'FROM '
      ' VW_SC_REF_TASK_TYPE')
    AutoCommit = False
    LockMode = lmLockImmediate
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Options.RequiredFields = False
    LocalConstraints = False
    Left = 68
    Top = 228
  end
  object IBCDataSourceTT: TIBCDataSource
    DataSet = IBCQueryTT
    Left = 68
    Top = 276
  end
end
