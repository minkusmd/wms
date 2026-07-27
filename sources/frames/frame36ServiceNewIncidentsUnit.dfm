inherited frame36ServiceNewIncidents: Tframe36ServiceNewIncidents
  Width = 1150
  Height = 742
  Font.Height = -15
  ExplicitWidth = 1150
  ExplicitHeight = 742
  PixelsPerInch = 120
  object pnClient: TPanel
    Left = 0
    Top = 0
    Width = 1150
    Height = 742
    Align = alClient
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 0
    object cxGridIncidente: TcxGrid
      Left = 0
      Top = 0
      Width = 1150
      Height = 742
      Align = alClient
      TabOrder = 0
      object cxGridIncidenteTable: TcxGridDBTableView
        OnKeyDown = cxGridIncidenteTableKeyDown
        OnCellDblClick = cxGridIncidenteTableCellDblClick
        OnCustomDrawCell = cxGridIncidenteTableCustomDrawCell
        OnFocusedRecordChanged = cxGridIncidenteTableFocusedRecordChanged
        DataController.DataModeController.GridModeBufferCount = 40
        DataController.KeyFieldNames = 'INCIDENTID'
        FilterRow.SeparatorWidth = 8
        FixedDataRows.SeparatorWidth = 8
        NewItemRow.SeparatorWidth = 8
        OptionsBehavior.IncSearch = True
        OptionsCustomize.ColumnsQuickCustomization = True
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.InvertSelect = False
        OptionsView.CellEndEllipsis = True
        OptionsView.NavigatorOffset = 63
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
        OptionsView.ColumnAutoWidth = True
        OptionsView.FixedColumnSeparatorWidth = 3
        OptionsView.GridLineColor = 13750737
        OptionsView.Indicator = True
        Preview.LeftIndent = 25
        Preview.RightIndent = 6
        RowLayout.MinValueWidth = 100
        Styles.GroupByBox = dmAdditions.cxStyle_GridGroup
        Styles.Header = dmAdditions.cxStyle_GridHeader
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        object cxGridIncidente_INCIDENTID: TcxGridDBColumn
          Caption = #1050#1086#1076
          DataBinding.FieldName = 'INCIDENTID'
          HeaderAlignmentHorz = taCenter
          MinWidth = 70
          Options.HorzSizing = False
          Width = 70
        end
        object cxGridIncidente_CREATED_DATE: TcxGridDBColumn
          Caption = #1057#1086#1079#1076#1072#1085
          DataBinding.FieldName = 'CREATED_DATE'
          OnGetDisplayText = cxGridIncidente_CREATED_DATEGetDisplayText
          HeaderAlignmentHorz = taCenter
          MinWidth = 100
          Options.HorzSizing = False
          Width = 100
        end
        object cxGridIncidente_DATA: TcxGridDBColumn
          Caption = #1044#1072#1090#1072
          DataBinding.FieldName = 'DATA'
          OnGetDisplayText = cxGridIncidente_DATAGetDisplayText
          HeaderAlignmentHorz = taCenter
          MinWidth = 100
          Options.HorzSizing = False
          Width = 100
        end
        object cxGridIncidente_EXEC_PERSONAL_GROUP_TITLE: TcxGridDBColumn
          Caption = #1050#1072#1090#1077#1075#1086#1088#1080#1103
          DataBinding.FieldName = 'EXEC_PERSONAL_GROUP_TITLE'
          MinWidth = 150
          Options.HorzSizing = False
          Width = 150
        end
        object cxGridIncidente_DT_NAME: TcxGridDBColumn
          Caption = #1054#1088#1075#1072#1085#1080#1079#1072#1094#1080#1103
          DataBinding.FieldName = 'DT_NAME'
          MinWidth = 80
          Width = 80
        end
        object cxGridIncidenteTable_GOODS_DOCID: TcxGridDBColumn
          Caption = #1042#1086#1079#1074#1088'. '#8470
          DataBinding.FieldName = 'GOODS_DOCID'
          HeaderAlignmentHorz = taCenter
          MinWidth = 60
          Options.HorzSizing = False
          Width = 60
        end
        object cxGridIncidente_PRIORITY_LEVEL: TcxGridDBColumn
          Caption = #1055#1088#1080#1086#1088#1080#1090#1077#1090
          DataBinding.FieldName = 'PRIORITY_LEVEL_TITLE'
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taCenter
          HeaderAlignmentHorz = taCenter
          MinWidth = 70
          Options.HorzSizing = False
          Width = 70
        end
        object cxGridIncidente_TYPE_TITLE: TcxGridDBColumn
          Caption = #1048#1085#1094#1080#1076#1077#1085#1090
          DataBinding.FieldName = 'TYPE_TITLE'
          HeaderAlignmentHorz = taCenter
          Width = 80
        end
        object cxGridIncidente_DOC_CUSTOMER: TcxGridDBColumn
          Caption = #1050#1086#1085#1090#1088#1072#1075#1077#1085#1090
          DataBinding.FieldName = 'DOC_CUSTOMER'
          HeaderAlignmentHorz = taCenter
          MinWidth = 80
          Width = 80
        end
        object cxGridIncidentePlatitor: TcxGridDBColumn
          Caption = #1055#1083#1072#1090#1077#1083#1100#1097#1080#1082
          DataBinding.FieldName = 'PAYER_NAME'
          MinWidth = 80
          Width = 80
        end
        object cxGridIncidente_GOODS_TITLE: TcxGridDBColumn
          Caption = #1058#1086#1074#1072#1088
          DataBinding.FieldName = 'GOODS_TITLE'
          HeaderAlignmentHorz = taCenter
          MinWidth = 80
          Width = 80
        end
        object cxGridIncidente_GOODS_MODEL: TcxGridDBColumn
          Caption = #1052#1086#1076#1077#1083#1100
          DataBinding.FieldName = 'GOODS_MODEL'
          HeaderAlignmentHorz = taCenter
          MinWidth = 60
          Width = 60
        end
        object cxGridIncidente_GOODS_SN: TcxGridDBColumn
          Caption = #1057#1077#1088#1080#1081#1085#1099#1081' '#1085#1086#1084#1077#1088
          DataBinding.FieldName = 'GOODS_SN'
          HeaderAlignmentHorz = taCenter
          MinWidth = 80
          Width = 100
        end
        object cxGridIncidente_CREATED_FULL_NAME: TcxGridDBColumn
          Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
          DataBinding.FieldName = 'CREATED_FULL_NAME'
          HeaderAlignmentHorz = taCenter
          MinWidth = 80
          Width = 80
        end
        object cxGridIncidente_CT: TcxGridDBColumn
          DataBinding.FieldName = 'CT'
          Visible = False
          VisibleForCustomization = False
        end
      end
      object cxGridIncidenteLevel: TcxGridLevel
        GridView = cxGridIncidenteTable
      end
    end
  end
  object dxBarManager: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
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
    Top = 184
    PixelsPerInch = 120
    object bbCreateIncidentTask: TdxBarButton
      Caption = #1047#1072#1087#1091#1089#1090#1080#1090#1100' '#1080#1085#1094#1080#1076#1077#1085#1090' '#1074' '#1087#1077#1088#1077#1088#1072#1073#1086#1090#1082#1091'...'
      Category = 0
      Hint = #1047#1072#1087#1091#1089#1090#1080#1090#1100' '#1080#1085#1094#1080#1076#1077#1085#1090' '#1074' '#1087#1077#1088#1077#1088#1072#1073#1086#1090#1082#1091
      Visible = ivAlways
      ImageIndex = 45
      ShortCut = 120
      OnClick = bbCreateIncidentTaskClick
    end
    object bbGotoParentDoc: TdxBarButton
      Caption = #1055#1077#1088#1077#1081#1090#1080' '#1082' '#1085#1072#1095#1072#1083#1100#1085#1086#1084#1091' '#1076#1086#1082#1091#1084#1077#1085#1090#1091'...'
      Category = 0
      Hint = #1055#1077#1088#1077#1081#1090#1080' '#1082' '#1085#1072#1095#1072#1083#1100#1085#1086#1084#1091' '#1076#1086#1082#1091#1084#1077#1085#1090#1091
      Visible = ivAlways
      OnClick = bbGotoParentDocClick
    end
  end
  object cxGridPopupMenu1: TcxGridPopupMenu
    Grid = cxGridIncidente
    PopupMenus = <
      item
        GridView = cxGridIncidenteTable
        HitTypes = [gvhtCell, gvhtRecord]
        Index = 0
        PopupMenu = pmGrid
      end>
    UseBuiltInPopupMenus = False
    Left = 276
    Top = 104
  end
  object pmGrid: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbCreateIncidentTask'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbGotoParentDoc'
      end>
    UseOwnFont = False
    Left = 252
    Top = 204
    PixelsPerInch = 120
  end
end
