object frmDescriptionLinkButtonsDlg: TfrmDescriptionLinkButtonsDlg
  Left = 0
  Top = 0
  ActiveControl = cxGrid
  BorderStyle = bsDialog
  Caption = #1050#1085#1086#1087#1082#1080' '#1087#1077#1088#1077#1093#1086#1076#1072' '#1076#1083#1103' '#1093#1072#1088#1072#1082#1090#1077#1088#1080#1089#1090#1080#1082#1080
  ClientHeight = 383
  ClientWidth = 436
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
    Width = 436
    Height = 64
    Title = #1050#1085#1086#1087#1082#1080' '#1087#1077#1088#1077#1093#1086#1076#1072' '#1076#1083#1103' '#1093#1072#1088#1072#1082#1090#1077#1088#1080#1089#1090#1080#1082#1080
    Text = #1040#1076#1084#1080#1085#1080#1089#1090#1088#1080#1088#1086#1074#1072#1085#1080#1077
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
    ImageIndex = 7
  end
  object pnClient: TPanel
    Left = 0
    Top = 64
    Width = 436
    Height = 265
    Align = alTop
    BevelOuter = bvNone
    Padding.Left = 8
    Padding.Top = 8
    Padding.Right = 8
    ShowCaption = False
    TabOrder = 1
    object dxBarDockControl1: TdxBarDockControl
      Left = 8
      Top = 8
      Width = 420
      Height = 30
      Align = dalTop
      BarManager = dxBarManager
      SunkenBorder = True
      UseOwnSunkenBorder = True
    end
    object cxGrid: TcxGrid
      Left = 8
      Top = 38
      Width = 420
      Height = 227
      Align = alClient
      TabOrder = 1
      object cxGridTable: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        OnFocusedRecordChanged = cxGridTableFocusedRecordChanged
        DataController.DataSource = IBCDataSourceButtons
        DataController.KeyFieldNames = 'TEMPLATEID;STRUCTID;FILTER_BUTTON_ID'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsCustomize.ColumnFiltering = False
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsSelection.InvertSelect = False
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1082#1085#1086#1087#1086#1082'>'
        OptionsView.ScrollBars = ssVertical
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        Styles.Header = dmAdditions.cxStyle_GridHeader
        object cxGrid_FILTER_BUTTON_ID: TcxGridDBColumn
          Caption = #1050#1086#1076
          DataBinding.FieldName = 'FILTER_BUTTON_ID'
          DataBinding.IsNullValueType = True
          HeaderAlignmentHorz = taCenter
          MinWidth = 40
          Options.HorzSizing = False
          Width = 40
        end
        object cxGrid_FILTER_BUTON_TITLE: TcxGridDBColumn
          Caption = #1050#1085#1086#1087#1082#1072
          DataBinding.FieldName = 'FILTER_BUTTON_TITLE'
          DataBinding.IsNullValueType = True
        end
        object cxGridTableColumn3: TcxGridDBColumn
          Caption = #1040#1082#1090
          DataBinding.FieldName = 'FILTER_BUTTON_FLG_ACTIVE'
          DataBinding.IsNullValueType = True
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          HeaderAlignmentHorz = taCenter
          MinWidth = 36
          Options.HorzSizing = False
          Width = 36
        end
        object cxGrid_ORDERNO: TcxGridDBColumn
          DataBinding.FieldName = 'ORDERNO'
          DataBinding.IsNullValueType = True
          Visible = False
          SortIndex = 0
          SortOrder = soAscending
          VisibleForCustomization = False
          IsCaptionAssigned = True
        end
      end
      object cxGridLevel: TcxGridLevel
        GridView = cxGridTable
      end
    end
  end
  object btnClose: TButton
    Left = 328
    Top = 340
    Width = 90
    Height = 29
    Cancel = True
    Caption = #1047#1072#1082#1088#1099#1090#1100
    Default = True
    ModalResult = 1
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
    Left = 284
    Top = 8
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
      FloatLeft = 460
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbAdd'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbModify'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbRemove'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object bbAdd: TdxBarButton
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      Category = 0
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 45
      OnClick = bbAddClick
    end
    object bbRemove: TdxBarButton
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Category = 0
      Hint = #1059#1076#1072#1083#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 42
      ShortCut = 46
      OnClick = bbRemoveClick
    end
    object bbModify: TdxBarButton
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      Category = 0
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 41
      OnClick = bbModifyClick
    end
  end
  object IBCQueryButtons: TIBCQuery
    SQLInsert.Strings = (
      'INSERT INTO TS_DESC_TEMPL_STRUCT_BUTTONS'
      '  (TEMPLATEID, STRUCTID, FILTER_BUTTON_ID)'
      'VALUES'
      '  (:TEMPLATEID, :STRUCTID, :FILTER_BUTTON_ID)')
    SQLDelete.Strings = (
      'DELETE FROM TS_DESC_TEMPL_STRUCT_BUTTONS'
      'WHERE'
      '  TEMPLATEID = :Old_TEMPLATEID '
      '  AND '
      '  STRUCTID = :Old_STRUCTID '
      '  AND '
      '  FILTER_BUTTON_ID = :Old_FILTER_BUTTON_ID')
    SQLUpdate.Strings = (
      'UPDATE TS_DESC_TEMPL_STRUCT_BUTTONS'
      'SET'
      '  TEMPLATEID = :TEMPLATEID,'
      '  STRUCTID = :STRUCTID,'
      '  FILTER_BUTTON_ID = :FILTER_BUTTON_ID'
      'WHERE'
      '  TEMPLATEID = :Old_TEMPLATEID '
      '  AND '
      '  STRUCTID = :Old_STRUCTID '
      '  AND '
      '  FILTER_BUTTON_ID = :Old_FILTER_BUTTON_ID')
    SQLRefresh.Strings = (
      'SELECT'
      ' TEMPLATEID,'
      ' STRUCTID,'
      ' FILTER_BUTTON_ID,'
      ' FILTER_BUTTON_TITLE,'
      ' FILTER_BUTTON_FLG_ACTIVE,'
      ' ORDERNO '
      'FROM '
      ' VW_TS_DESC_TEMPL_STRUCT_BUTTONS'
      'WHERE'
      ' TEMPLATEID = :TEMPLATEID '
      ' AND '
      ' STRUCTID = :STRUCTID '
      ' AND '
      ' FILTER_BUTTON_ID = :FILTER_BUTTON_ID')
    SQLLock.Strings = (
      'SELECT '
      ' NULL '
      'FROM'
      ' TS_DESC_TEMPL_STRUCT_BUTTONS'
      'WHERE'
      '  TEMPLATEID = :Old_TEMPLATEID '
      '  AND '
      '  STRUCTID = :Old_STRUCTID '
      '  AND '
      '  FILTER_BUTTON_ID = :Old_FILTER_BUTTON_ID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT'
      ' TEMPLATEID,'
      ' STRUCTID,'
      ' FILTER_BUTTON_ID,'
      ' FILTER_BUTTON_TITLE,'
      ' FILTER_BUTTON_FLG_ACTIVE,'
      ' ORDERNO '
      'FROM '
      ' VW_TS_DESC_TEMPL_STRUCT_BUTTONS'
      'WHERE'
      ' TEMPLATEID = :T_ID'
      ' AND'
      ' STRUCTID = :S_ID')
    AutoCommit = False
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Options.RequiredFields = False
    LocalConstraints = False
    Left = 76
    Top = 236
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'T_ID'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'S_ID'
        Value = nil
      end>
  end
  object IBCDataSourceButtons: TIBCDataSource
    DataSet = IBCQueryButtons
    Left = 76
    Top = 180
  end
end
