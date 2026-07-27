object frmServiceRefRepairAimsDlg: TfrmServiceRefRepairAimsDlg
  Left = 0
  Top = 0
  ActiveControl = cxGrid
  BorderIcons = [biSystemMenu]
  Caption = #1062#1077#1083#1080' '#1088#1077#1084#1086#1085#1090#1072
  ClientHeight = 608
  ClientWidth = 601
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    601
    608)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 601
    Height = 64
    Title = #1062#1077#1083#1080' '#1088#1077#1084#1086#1085#1090#1072
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
    Width = 585
    Height = 483
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 1
    object dxBarDockControl1: TdxBarDockControl
      Left = 0
      Top = 0
      Width = 585
      Height = 30
      Align = dalTop
      BarManager = dxBarManager
      SunkenBorder = True
      UseOwnSunkenBorder = True
    end
    object cxGrid: TcxGrid
      Left = 0
      Top = 30
      Width = 585
      Height = 453
      Align = alClient
      TabOrder = 1
      object cxGridTable: TcxGridDBTableView
        OnKeyDown = cxGridTableKeyDown
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        OnCellDblClick = cxGridTableCellDblClick
        OnFocusedRecordChanged = cxGridTableFocusedRecordChanged
        DataController.DataSource = IBCDataSourceScop
        DataController.KeyFieldNames = 'SCOPID'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnMoving = False
        OptionsCustomize.ColumnSorting = False
        OptionsCustomize.ColumnsQuickCustomization = True
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsView.CellEndEllipsis = True
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
        OptionsView.ScrollBars = ssVertical
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        Styles.Header = dmAdditions.cxStyle_GridHeader
        object cxGridTable_ANALITICAID: TcxGridDBColumn
          Caption = #1050#1086#1076
          DataBinding.FieldName = 'SCOPID'
          HeaderAlignmentHorz = taCenter
          MinWidth = 50
          Options.HorzSizing = False
          Width = 50
        end
        object cxGridTable_FLG_FOLDER: TcxGridDBColumn
          DataBinding.FieldName = 'FLG_FOLDER'
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.Images = dmAdditions.cxImageList_SWN
          Properties.Items = <
            item
              ImageIndex = 58
              Value = 0
            end
            item
              ImageIndex = 13
              Value = 1
            end>
          Properties.ReadOnly = True
          MinWidth = 24
          Options.ShowEditButtons = isebNever
          Options.HorzSizing = False
          Options.ShowCaption = False
          VisibleForCustomization = False
          Width = 24
          IsCaptionAssigned = True
        end
        object cxGridTable_TITLE: TcxGridDBColumn
          Caption = #1053#1072#1079#1074#1072#1085#1080#1077
          DataBinding.FieldName = 'TITLE'
          Width = 100
        end
        object cxGridTable_DESCRIPTION: TcxGridDBColumn
          Caption = #1054#1087#1080#1089#1072#1085#1080#1077
          DataBinding.FieldName = 'DESCRIPTION'
          Width = 100
        end
        object cxGridTable_ESTIMATED_HOURS: TcxGridDBColumn
          Caption = #1042#1089#1077#1075#1086' '#1095#1072#1089#1086#1074
          DataBinding.FieldName = 'ESTIMATED_HOURS'
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taRightJustify
          OnGetDisplayText = cxGridTable_ESTIMATED_HOURSGetDisplayText
          HeaderAlignmentHorz = taCenter
          MinWidth = 100
          Options.HorzSizing = False
          Width = 100
        end
        object cxGridTable_ORDERNO: TcxGridDBColumn
          DataBinding.FieldName = 'ORDERNO'
          Visible = False
          SortIndex = 0
          SortOrder = soAscending
          VisibleForCustomization = False
        end
        object cxGridTable_FLG_ENABLED: TcxGridDBColumn
          DataBinding.FieldName = 'FLG_ENABLED'
          Visible = False
          VisibleForCustomization = False
        end
        object cxGridTable_CREATED_BY_TITLE: TcxGridDBColumn
          Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
          DataBinding.FieldName = 'CREATED_BY_TITLE'
          Visible = False
          Width = 70
        end
      end
      object cxGridLevel: TcxGridLevel
        GridView = cxGridTable
      end
    end
  end
  object btnOk: TcxButton
    AlignWithMargins = True
    Left = 490
    Top = 567
    Width = 90
    Height = 29
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 16
    Margins.Bottom = 12
    Anchors = [akRight, akBottom]
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
    Left = 400
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
      FloatLeft = 635
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          Visible = True
          ItemName = 'bbNavHome'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          Visible = True
          ItemName = 'bbNavPrev'
        end
        item
          UserDefine = [udPaintStyle]
          Visible = True
          ItemName = 'bbNavNext'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbNew'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbModifyItem'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbDeleteItem'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarSubItem1'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object bbNew: TdxBarSubItem
      Caption = #1053#1086#1074#1072#1103
      Category = 0
      Visible = ivAlways
      ImageIndex = 40
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbNewFolder'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbNewAim'
        end>
    end
    object bbNewAim: TdxBarButton
      Caption = #1053#1086#1074#1072#1103' '#1094#1077#1083#1100'...'
      Category = 0
      Hint = #1053#1086#1074#1072#1103' '#1094#1077#1083#1100
      Visible = ivAlways
      ShortCut = 45
      OnClick = bbNewAimClick
    end
    object bbNewFolder: TdxBarButton
      Caption = #1053#1086#1074#1072#1103' '#1075#1088#1091#1087#1087#1072'...'
      Category = 0
      Hint = #1053#1086#1074#1072#1103' '#1075#1088#1091#1087#1087#1072
      Visible = ivAlways
      OnClick = bbNewFolderClick
    end
    object bbModifyItem: TdxBarButton
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      Category = 0
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 115
      OnClick = bbModifyItemClick
    end
    object bbDeleteItem: TdxBarButton
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Category = 0
      Hint = #1059#1076#1072#1083#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 42
      ShortCut = 46
      OnClick = bbDeleteItemClick
    end
    object bbNavPrev: TdxBarButton
      Caption = #1053#1072#1079#1072#1076
      Category = 0
      Hint = #1053#1072#1079#1072#1076
      Visible = ivAlways
      ImageIndex = 6
      OnClick = bbNavPrevClick
    end
    object bbNavNext: TdxBarButton
      Caption = #1042#1087#1077#1088#1077#1076
      Category = 0
      Hint = #1042#1087#1077#1088#1077#1076
      Visible = ivAlways
      ImageIndex = 7
      OnClick = bbNavNextClick
    end
    object bbNavHome: TdxBarButton
      Caption = #1042' '#1085#1072#1095#1072#1083#1086
      Category = 0
      Hint = #1042' '#1085#1072#1095#1072#1083#1086
      Visible = ivAlways
      ImageIndex = 5
      ShortCut = 36
      OnClick = bbNavHomeClick
    end
    object dxBarSubItem1: TdxBarSubItem
      Caption = #1048#1085#1089#1090#1088#1091#1084#1077#1085#1090#1099
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbSortItems'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbAimTaskTypes'
        end>
    end
    object bbSortItems: TdxBarButton
      Caption = #1059#1087#1086#1088#1103#1076#1086#1095#1080#1090#1100' '#1101#1083#1077#1084#1077#1085#1090#1099'...'
      Category = 0
      Hint = #1059#1087#1086#1088#1103#1076#1086#1095#1080#1090#1100' '#1101#1083#1077#1084#1077#1085#1090#1099
      Visible = ivAlways
      ImageIndex = 38
      OnClick = bbSortItemsClick
    end
    object bbAimTaskTypes: TdxBarButton
      Caption = #1058#1080#1087#1099' '#1079#1072#1076#1072#1095#1100'...'
      Category = 0
      Hint = #1058#1080#1087#1099' '#1079#1072#1076#1072#1095#1100
      Visible = ivAlways
      ImageIndex = 25
      OnClick = bbAimTaskTypesClick
    end
  end
  object IBCQueryScop: TIBCQuery
    KeyFields = 'SCOPID'
    KeyGenerator = 'SQ_SC_REF_INCIDENT_SCOP_ID'
    GeneratorMode = gmInsert
    SQLInsert.Strings = (
      'INSERT INTO VW_SC_REF_INCIDENT_SCOP'
      
        '  (SCOPID, PARENTID, FLG_FOLDER, TITLE, DESCRIPTION, ESTIMATED_H' +
        'OURS, FLG_ENABLED, FLG_DEFAULT_GARANT, FLG_DEFAULT_REPAIR)'
      'VALUES'
      
        '  (:SCOPID, :PARENTID, :FLG_FOLDER, :TITLE, :DESCRIPTION, :ESTIM' +
        'ATED_HOURS, :FLG_ENABLED, :FLG_DEFAULT_GARANT, :FLG_DEFAULT_REPA' +
        'IR)')
    SQLDelete.Strings = (
      'DELETE FROM SC_REF_INCIDENT_SCOP'
      'WHERE'
      '  SCOPID = :Old_SCOPID')
    SQLUpdate.Strings = (
      'UPDATE VW_SC_REF_INCIDENT_SCOP'
      'SET'
      ' SCOPID = :SCOPID, '
      ' PARENTID = :PARENTID, '
      ' FLG_FOLDER = :FLG_FOLDER, '
      ' TITLE = :TITLE, '
      ' DESCRIPTION = :DESCRIPTION, '
      ' ESTIMATED_HOURS = :ESTIMATED_HOURS, '
      ' FLG_ENABLED = :FLG_ENABLED,'
      ' FLG_DEFAULT_GARANT = :FLG_DEFAULT_GARANT,'
      ' FLG_DEFAULT_REPAIR = :FLG_DEFAULT_REPAIR'
      ''
      'WHERE'
      '  SCOPID = :Old_SCOPID')
    SQLRefresh.Strings = (
      'SELECT '
      ' SCOPID, '
      ' PARENTID, '
      ' FLG_FOLDER,'
      ' TITLE, '
      ' DESCRIPTION, '
      ' ESTIMATED_HOURS, '
      ' FLG_ENABLED,'
      ' FLG_DEFAULT_GARANT,'
      ' FLG_DEFAULT_REPAIR,'
      ' ORDERNO,'
      ' CREATED_BY_TITLE '
      'FROM '
      ' VW_SC_REF_INCIDENT_SCOP'
      'WHERE'
      ' SCOPID = :SCOPID')
    SQLLock.Strings = (
      'SELECT NULL FROM SC_REF_INCIDENT_SCOP'
      'WHERE'
      'SCOPID = :Old_SCOPID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = IBCTrUpdate
    SQL.Strings = (
      'SELECT'
      ' SCOPID, '
      ' PARENTID,'
      ' FLG_FOLDER, '
      ' TITLE, '
      ' DESCRIPTION, '
      ' ESTIMATED_HOURS, '
      ' FLG_ENABLED,'
      ' FLG_DEFAULT_GARANT,'
      ' FLG_DEFAULT_REPAIR,'
      ' ORDERNO,'
      ' CREATED_BY_TITLE'
      'FROM '
      ' VW_SC_REF_INCIDENT_SCOP '
      'WHERE '
      ' PARENTID=:ParentID '
      'ORDER BY'
      ' ORDERNO')
    AutoCommit = False
    LockMode = lmLockImmediate
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Options.RequiredFields = False
    LocalConstraints = False
    Left = 84
    Top = 264
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ParentID'
        Value = nil
      end>
  end
  object IBCDataSourceScop: TIBCDataSource
    DataSet = IBCQueryScop
    Left = 84
    Top = 320
  end
  object IBCTrUpdate: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 84
    Top = 380
  end
end
