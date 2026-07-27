object frmWebDescriptionTemplateDlg: TfrmWebDescriptionTemplateDlg
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = #536'abloane de descriere a produsului'
  ClientHeight = 768
  ClientWidth = 1216
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  TextHeight = 15
  object DialogTitle1: TDialogTitle
    Left = 0
    Top = 0
    Width = 1216
    Height = 64
    Title = #536'abloane de descriere a produsului'
    Text = 'Gestionarea '#537'abloanelor de descriere a produselor'
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
  object pnDetail: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 1200
    Height = 647
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 0
    Align = alClient
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 1
    object Panel1: TPanel
      Left = 0
      Top = 0
      Width = 1200
      Height = 647
      Align = alClient
      Caption = 'Panel1'
      TabOrder = 0
      object pnTop: TPanel
        Left = 1
        Top = 1
        Width = 1198
        Height = 304
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object cxGridTemplate: TcxGrid
          Left = 0
          Top = 30
          Width = 1198
          Height = 274
          Align = alClient
          DragMode = dmAutomatic
          TabOrder = 1
          object cxGridTemplateTable: TcxGridDBTableView
            DragMode = dmAutomatic
            FindPanel.Behavior = fcbFilter
            FindPanel.DisplayMode = fpdmAlways
            FindPanel.Layout = fplCompact
            FindPanel.UseExtendedSyntax = True
            OnFocusedRecordChanged = cxGridTemplateTableFocusedRecordChanged
            DataController.DataSource = IBCDataSourceTemplates
            DataController.KeyFieldNames = 'TEMPLATEID'
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
            Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
            object cxGridTemplate_TEMPLATEID: TcxGridDBColumn
              Caption = 'Cod'
              DataBinding.FieldName = 'TEMPLATEID'
              MinWidth = 50
              Options.HorzSizing = False
              Width = 50
            end
            object cxGridTemplate_TITLE_ROM: TcxGridDBColumn
              Caption = 'Denumirea'
              DataBinding.FieldName = 'TITLE_ROM'
              Width = 100
            end
            object cxGridTemplate_TITLE_RUS: TcxGridDBColumn
              Caption = #1053#1072#1079#1074#1072#1085#1080#1077
              DataBinding.FieldName = 'TITLE_RUS'
              VisibleForExpressionEditor = bFalse
              VisibleForCustomization = False
              VisibleForEditForm = bFalse
              Width = 100
            end
            object cxGridTemplate_GOODSTYPE_TITLE: TcxGridDBColumn
              Caption = #1058#1080#1087' '#1090#1086#1074#1072#1088#1072
              DataBinding.FieldName = 'GOODSTYPE_TITLE'
              Visible = False
              Width = 50
            end
          end
          object cxGridTemplateLevel: TcxGridLevel
            GridView = cxGridTemplateTable
          end
        end
        object dxBarDockControl1: TdxBarDockControl
          Left = 0
          Top = 0
          Width = 1198
          Height = 30
          Align = dalTop
          BarManager = dxBarManager1
          SunkenBorder = True
          UseOwnSunkenBorder = True
        end
      end
      object pnDesc: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 305
        Width = 1196
        Height = 341
        Margins.Left = 2
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 1
        object cxGridDesc: TcxGrid
          Left = 0
          Top = 30
          Width = 1196
          Height = 311
          Align = alClient
          TabOrder = 1
          object cxGridDescTable: TcxGridDBTableView
            OnCellDblClick = cxGridDescTableCellDblClick
            OnFocusedRecordChanged = cxGridDescTableFocusedRecordChanged
            DataController.DataSource = IBCDataSourceDesc
            DataController.KeyFieldNames = 'TEMPLATEID;STRUCTID'
            OptionsBehavior.IncSearch = True
            OptionsCustomize.ColumnFiltering = False
            OptionsCustomize.ColumnSorting = False
            OptionsCustomize.ColumnsQuickCustomization = True
            OptionsData.Deleting = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsSelection.MultiSelect = True
            OptionsSelection.InvertSelect = False
            OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1093#1072#1088#1072#1082#1090#1077#1088#1080#1089#1090#1080#1082'>'
            OptionsView.ScrollBars = ssVertical
            OptionsView.ColumnAutoWidth = True
            OptionsView.GridLineColor = 13750737
            OptionsView.GroupByBox = False
            OptionsView.Indicator = True
            Styles.Header = dmAdditions.cxStyle_GridHeader
            Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
            object cxGridDesc_IMG: TcxGridDBColumn
              PropertiesClassName = 'TcxImageComboBoxProperties'
              Properties.DefaultImageIndex = 26
              Properties.Images = dmAdditions.cxImageList_SWN
              Properties.Items = <>
              MinWidth = 24
              Options.HorzSizing = False
              Width = 24
            end
            object cxGridDesc_STRUCTID: TcxGridDBColumn
              Caption = 'Cod'
              DataBinding.FieldName = 'FILTERID'
              HeaderAlignmentHorz = taCenter
              MinWidth = 50
              Options.HorzSizing = False
              Width = 50
            end
            object cxGridDesc_FILTERNAME_ROM: TcxGridDBColumn
              Caption = 'Caracteristica'
              DataBinding.FieldName = 'FILTERNAME_ROM'
              Width = 100
            end
            object cxGridDesc_PARAM_VALUE_ROM: TcxGridDBColumn
              Caption = 'Valoarea'
              DataBinding.FieldName = 'PARAM_VALUE_ROM'
              Width = 60
            end
            object cxGridDesc_FILTERNAME_RUS: TcxGridDBColumn
              Caption = #1061#1072#1088#1072#1082#1090#1077#1088#1080#1089#1090#1080#1082#1072
              DataBinding.FieldName = 'FILTERNAME_RUS'
              Width = 100
            end
            object cxGridDesc_PARAM_VALUE_RUS: TcxGridDBColumn
              Caption = #1047#1085#1072#1095#1077#1085#1080#1077
              DataBinding.FieldName = 'PARAM_VALUE_RUS'
              Width = 60
            end
            object cxGridDesc_FLG_VISIBLE: TcxGridDBColumn
              AlternateCaption = #1055#1086#1082#1072#1079#1099#1074#1072#1090#1100
              Caption = 'Show'
              DataBinding.FieldName = 'FLG_VISIBLE'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.ValueChecked = 1
              Properties.ValueUnchecked = 0
              HeaderAlignmentHorz = taCenter
              MinWidth = 36
              Options.HorzSizing = False
              Width = 36
            end
            object cxGridDesc_FLG_COMPATIBILITY: TcxGridDBColumn
              AlternateCaption = #1057#1086#1074#1084#1077#1089#1090#1080#1084#1099#1077
              Caption = #8776
              DataBinding.FieldName = 'FLG_COMPATIBILITY'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.ValueChecked = 1
              Properties.ValueUnchecked = 0
              HeaderAlignmentHorz = taCenter
              MinWidth = 36
              Options.HorzSizing = False
              Width = 36
            end
            object cxGridDesc_FLG_COMPARE: TcxGridDBColumn
              AlternateCaption = #1057#1088#1072#1074#1085#1080#1090#1100
              Caption = '='
              DataBinding.FieldName = 'FLG_COMPARE'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.ValueChecked = 1
              Properties.ValueUnchecked = 0
              HeaderAlignmentHorz = taCenter
              MinWidth = 36
              Options.HorzSizing = False
              Width = 36
            end
            object cxGridDesc_FLG_GROUP: TcxGridDBColumn
              DataBinding.FieldName = 'FLG_GROUP'
              Visible = False
              VisibleForCustomization = False
            end
            object cxGridDesc_ORDERNO: TcxGridDBColumn
              DataBinding.FieldName = 'ORDERNO'
              Visible = False
              SortIndex = 0
              SortOrder = soAscending
              VisibleForCustomization = False
            end
            object cxGridDesc_FLG_GOODS_LINK: TcxGridDBColumn
              AlternateCaption = #1057#1089#1099#1083#1082#1072
              Caption = 'Link'
              DataBinding.FieldName = 'FLG_GOODS_LINK'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.ValueChecked = 1
              Properties.ValueUnchecked = 0
              HeaderAlignmentHorz = taCenter
              MinWidth = 36
              Options.HorzSizing = False
              Width = 36
            end
          end
          object cxGridDescLevel: TcxGridLevel
            GridView = cxGridDescTable
          end
        end
        object dxBarDockControl2: TdxBarDockControl
          Left = 0
          Top = 0
          Width = 1196
          Height = 30
          Align = dalTop
          BarManager = dxBarManager1
          SunkenBorder = True
          UseOwnSunkenBorder = True
        end
      end
    end
  end
  object pnBottom: TPanel
    Left = 0
    Top = 719
    Width = 1216
    Height = 49
    Align = alBottom
    BevelOuter = bvNone
    Padding.Top = 8
    Padding.Right = 24
    Padding.Bottom = 12
    ShowCaption = False
    TabOrder = 2
    object btnOk: TcxButton
      AlignWithMargins = True
      Left = 1004
      Top = 8
      Width = 90
      Height = 29
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 8
      Margins.Bottom = 0
      Align = alRight
      Caption = 'OK'
      ModalResult = 1
      TabOrder = 0
    end
    object btnCancel: TcxButton
      Left = 1102
      Top = 8
      Width = 90
      Height = 29
      Align = alRight
      Caption = 'Renunta'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object dxBarManager1: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Default'
      'Tree')
    Categories.ItemsVisibles = (
      2
      2)
    Categories.Visibles = (
      True
      True)
    ImageOptions.Images = dmAdditions.cxImageList_SWN
    ImageOptions.StretchGlyphs = False
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 532
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
      FloatLeft = 1023
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbTemplateNew'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbTemplateEdit'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbTemplateRemove'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbGoodsTypes'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          Visible = True
          ItemName = 'bbTemplateCopy'
        end
        item
          Visible = True
          ItemName = 'bbSortTemplates'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar2: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Custom 2'
      CaptionButtons = <>
      DockControl = dxBarDockControl2
      DockedDockControl = dxBarDockControl2
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1023
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbDescAdd'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbDescEdit'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbDescRemove'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          Visible = True
          ItemName = 'bbDescSort'
        end
        item
          UserDefine = [udPaintStyle]
          Visible = True
          ItemName = 'bbDescButtons'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbImportFromGoods'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton2'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar3: TdxBar
      Caption = 'Custom 3'
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 0
      DockedTop = 0
      DockingStyle = dsTop
      FloatLeft = 1250
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          Visible = True
          ItemName = 'bbNewGroup'
        end
        item
          UserDefine = [udPaintStyle]
          Visible = True
          ItemName = 'bbModifyGroup'
        end
        item
          UserDefine = [udPaintStyle]
          Visible = True
          ItemName = 'bbDeleteGroup'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton1'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = False
      WholeRow = False
    end
    object bbTemplateNew: TdxBarButton
      Caption = 'Nou'
      Category = 0
      Hint = 'Nou'
      Visible = ivAlways
      ImageIndex = 40
      OnClick = bbTemplateNewClick
    end
    object bbTemplateEdit: TdxBarButton
      Caption = 'Modifica'
      Category = 0
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 113
      OnClick = bbTemplateEditClick
    end
    object bbTemplateRemove: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      OnClick = bbTemplateRemoveClick
    end
    object bbDescAdd: TdxBarButton
      Caption = 'Nou'
      Category = 0
      Hint = 'Nou'
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 45
      OnClick = bbDescAddClick
    end
    object bbDescEdit: TdxBarButton
      Caption = 'Modifica'
      Category = 0
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 115
      OnClick = bbDescEditClick
    end
    object bbDescRemove: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      ShortCut = 46
      OnClick = bbDescRemoveClick
    end
    object bbDescSort: TdxBarButton
      Caption = #1059#1087#1086#1088#1103#1076#1086#1095#1080#1090#1100
      Category = 0
      Hint = #1059#1087#1086#1088#1103#1076#1086#1095#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 38
      OnClick = bbDescSortClick
    end
    object bbTemplateCopy: TdxBarButton
      Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100
      Category = 0
      Hint = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100
      Visible = ivAlways
      ImageIndex = 29
      OnClick = bbTemplateCopyClick
    end
    object bbSortTemplates: TdxBarButton
      Caption = #1057#1086#1088#1090#1080#1088#1086#1074#1072#1090#1100
      Category = 0
      Hint = #1057#1086#1088#1090#1080#1088#1086#1074#1072#1090#1100
      Visible = ivAlways
      ImageIndex = 38
      OnClick = bbSortTemplatesClick
    end
    object bbDescButtons: TdxBarButton
      Caption = #1050#1085#1086#1087#1082#1080' '#1087#1077#1088#1077#1093#1086#1076#1072
      Category = 0
      Hint = #1050#1085#1086#1087#1082#1080' '#1087#1077#1088#1077#1093#1086#1076#1072
      Visible = ivAlways
      ImageIndex = 3
      OnClick = bbDescButtonsClick
    end
    object bbGoodsTypes: TdxBarButton
      Caption = #1058#1080#1087#1099' '#1090#1086#1074#1072#1088#1086#1074
      Category = 0
      Hint = #1058#1080#1087#1099' '#1090#1086#1074#1072#1088#1086#1074
      Visible = ivAlways
      ImageIndex = 25
      ShortCut = 120
      OnClick = bbGoodsTypesClick
    end
    object dxBarButton1: TdxBarButton
      Caption = 'Modifica parinte'
      Category = 0
      Hint = 'Modifica parinte'
      Visible = ivAlways
    end
    object bbImportFromGoods: TdxBarButton
      Caption = 'Importa din produs'
      Category = 0
      Hint = 'Importa din produs'
      Visible = ivAlways
      ImageIndex = 12
      ShortCut = 16457
      OnClick = bbImportFromGoodsClick
    end
    object dxBarButton2: TdxBarButton
      Caption = 'Visibil'
      Category = 0
      Hint = 'Visibil'
      Visible = ivAlways
      ShortCut = 32854
      OnClick = dxBarButton2Click
    end
    object bbNewGroup: TdxBarButton
      Caption = 'Nou'
      Category = 1
      Hint = 'Nou'
      Visible = ivAlways
      ImageIndex = 40
    end
    object bbModifyGroup: TdxBarButton
      Caption = 'Modifica'
      Category = 1
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 41
      OnClick = bbModifyGroupClick
    end
    object bbDeleteGroup: TdxBarButton
      Caption = 'Starge'
      Category = 1
      Hint = 'Starge'
      Visible = ivAlways
      ImageIndex = 42
    end
  end
  object IBCQueryTemplates: TIBCQuery
    KeyFields = 'TEMPLATEID'
    KeyGenerator = 'SQ_TS_DESCRIPTION_TEMPLATES_ID'
    GeneratorMode = gmInsert
    SQLInsert.Strings = (
      'INSERT INTO TS_DESCRIPTION_TEMPLATES'
      '  (TEMPLATEID, PARENTID, TITLE_ROM, TITLE_RUS, ORDERNO)'
      'VALUES'
      '  (:TEMPLATEID, :PARENTID, :TITLE_ROM, :TITLE_RUS, :ORDERNO)')
    SQLDelete.Strings = (
      'DELETE FROM TS_DESCRIPTION_TEMPLATES'
      'WHERE'
      '  TEMPLATEID = :Old_TEMPLATEID')
    SQLUpdate.Strings = (
      'UPDATE TS_DESCRIPTION_TEMPLATES'
      'SET'
      
        '  TEMPLATEID = :TEMPLATEID, PARENTID = :PARENTID, TITLE_ROM = :T' +
        'ITLE_ROM, TITLE_RUS = :TITLE_RUS, ORDERNO = :ORDERNO'
      'WHERE'
      '  TEMPLATEID = :Old_TEMPLATEID')
    SQLRefresh.Strings = (
      
        'SELECT TEMPLATEID, PARENTID, TITLE_ROM, TITLE_RUS, ORDERNO FROM ' +
        'TS_DESCRIPTION_TEMPLATES'
      'WHERE'
      '  TEMPLATEID = :TEMPLATEID')
    SQLLock.Strings = (
      'SELECT NULL FROM TS_DESCRIPTION_TEMPLATES'
      'WHERE'
      'TEMPLATEID = :Old_TEMPLATEID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM TS_DESCRIPTION_TEMPLATES'
      ''
      ') q')
    Connection = dmDB.IBCConnection
    Transaction = IBCTransactionUpdate
    UpdateTransaction = IBCTransactionUpdate
    SQL.Strings = (
      'SELECT'
      ' T.PARENTID, '
      ' T.TEMPLATEID,'
      ' T.TITLE_ROM,'
      ' T.TITLE_RUS,'
      ' T.ORDERNO'
      'FROM TS_DESCRIPTION_TEMPLATES T'
      'WHERE t.flg_folder = 0'
      'ORDER BY title_rom')
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Options.RequiredFields = False
    LocalConstraints = False
    Left = 623
    Top = 211
  end
  object IBCDataSourceTemplates: TIBCDataSource
    DataSet = IBCQueryTemplates
    Left = 624
    Top = 160
  end
  object IBCDataSourceDesc: TIBCDataSource
    DataSet = IBCQueryDesc
    Left = 636
    Top = 404
  end
  object IBCQueryDesc: TIBCQuery
    KeyFields = 'STRUCTID'
    KeyGenerator = 'SQ_TS_DESCRIPTION_TEMPL_INFO_ID'
    GeneratorMode = gmInsert
    SQLInsert.Strings = (
      'INSERT INTO VW_TS_DESCRIPTION_TEMPLATE_INFO'
      
        '  (TEMPLATEID, STRUCTID, FILTERID, FILTERPARAMID, FLG_VISIBLE, F' +
        'LG_COMPATIBILITY, FLG_COMPARE, FLG_GROUP)'
      'VALUES'
      
        '  (:TEMPLATEID, :STRUCTID, :FILTERID, :FILTERPARAMID, :FLG_VISIB' +
        'LE, :FLG_COMPATIBILITY, :FLG_COMPARE, :FLG_GROUP)')
    SQLDelete.Strings = (
      'DELETE FROM '
      '  VW_TS_DESCRIPTION_TEMPLATE_INFO'
      'WHERE'
      '  STRUCTID = :Old_STRUCTID '
      '  AND '
      '  TEMPLATEID = :Old_TEMPLATEID')
    SQLUpdate.Strings = (
      'UPDATE VW_TS_DESCRIPTION_TEMPLATE_INFO'
      'SET'
      '  TEMPLATEID = :TEMPLATEID, '
      '  STRUCTID = :STRUCTID, '
      '  FILTERID = :FILTERID, '
      '  FILTERPARAMID = :FILTERPARAMID, '
      '  FLG_VISIBLE = :FLG_VISIBLE, '
      '  FLG_COMPATIBILITY = :FLG_COMPATIBILITY, '
      '  FLG_COMPARE = :FLG_COMPARE,'
      '  FLG_GROUP = :FLG_GROUP'
      'WHERE'
      '  STRUCTID = :Old_STRUCTID '
      '  AND '
      '  TEMPLATEID = :Old_TEMPLATEID')
    SQLRefresh.Strings = (
      'SELECT'
      ' TEMPLATEID,'
      ' STRUCTID,'
      ' FILTERID,'
      ' FILTERNAME_ROM,'
      ' FILTERNAME_RUS,'
      ' FILTERPARAMID,'
      ' PARAM_VALUE_ROM,'
      ' PARAM_VALUE_RUS,'
      ' FLG_VISIBLE,'
      ' FLG_COMPATIBILITY,'
      ' FLG_COMPARE,'
      ' FLG_GOODS_LINK,'
      ' ORDERNO,'
      ' FLG_GROUP'
      'FROM'
      ' VW_TS_DESCRIPTION_TEMPLATE_INFO'
      'WHERE'
      ' STRUCTID = :STRUCTID '
      ' AND '
      ' TEMPLATEID = :TEMPLATEID')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = IBCTransactionUpdate
    SQL.Strings = (
      'SELECT'
      ' TEMPLATEID,'
      ' STRUCTID,'
      ' FILTERID,'
      ' FILTERNAME_ROM,'
      ' FILTERNAME_RUS,'
      ' FILTERPARAMID,'
      ' PARAM_VALUE_ROM,'
      ' PARAM_VALUE_RUS,'
      ' FLG_VISIBLE,'
      ' FLG_COMPATIBILITY,'
      ' FLG_COMPARE,'
      ' FLG_GOODS_LINK,'
      ' ORDERNO,'
      ' FLG_GROUP'
      'FROM'
      ' VW_TS_DESCRIPTION_TEMPLATE_INFO')
    MasterFields = 'TEMPLATEID'
    DetailFields = 'TEMPLATEID'
    MasterSource = IBCDataSourceTemplates
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Options.DetailDelay = 500
    Left = 636
    Top = 456
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TEMPLATEID'
        Value = nil
      end>
  end
  object IBCTransactionUpdate: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 264
    Top = 152
  end
end
