inherited frame57ActDeficiente: Tframe57ActDeficiente
  Font.Height = -15
  PixelsPerInch = 120
  object cxGridDocs: TcxGrid
    Left = 0
    Top = 0
    Width = 986
    Height = 429
    Align = alClient
    TabOrder = 0
    LookAndFeel.NativeStyle = True
    LookAndFeel.SkinName = ''
    object cxGridDocsTable: TcxGridDBTableView
      OnKeyDown = cxGridDocsTableKeyDown
      Navigator.Buttons.First.Visible = True
      Navigator.Buttons.PriorPage.Visible = True
      Navigator.Buttons.Prior.Visible = True
      Navigator.Buttons.Next.Visible = True
      Navigator.Buttons.NextPage.Visible = True
      Navigator.Buttons.Last.Visible = True
      Navigator.Buttons.Insert.Visible = True
      Navigator.Buttons.Append.Visible = False
      Navigator.Buttons.Delete.Visible = True
      Navigator.Buttons.Edit.Visible = True
      Navigator.Buttons.Post.Visible = True
      Navigator.Buttons.Cancel.Visible = True
      Navigator.Buttons.Refresh.Visible = True
      Navigator.Buttons.SaveBookmark.Visible = True
      Navigator.Buttons.GotoBookmark.Visible = True
      Navigator.Buttons.Filter.Visible = True
      OnCellDblClick = cxGridDocsTableCellDblClick
      OnCustomDrawCell = cxGridDocsTableCustomDrawCell
      DataController.KeyFieldNames = 'DOCID'
      FilterRow.SeparatorWidth = 8
      FixedDataRows.SeparatorWidth = 8
      NewItemRow.SeparatorWidth = 8
      OptionsBehavior.IncSearch = True
      OptionsBehavior.ColumnHeaderHints = False
      OptionsBehavior.ImmediateEditor = False
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.InvertSelect = False
      OptionsView.NavigatorOffset = 63
      OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
      OptionsView.ColumnAutoWidth = True
      OptionsView.FixedColumnSeparatorWidth = 3
      OptionsView.GridLineColor = 13750737
      OptionsView.GroupRowStyle = grsOffice11
      OptionsView.Indicator = True
      Preview.LeftIndent = 25
      Preview.RightIndent = 6
      RowLayout.MinValueWidth = 100
      Styles.GroupByBox = dmAdditions.cxStyle_GridGroup
      Styles.Header = dmAdditions.cxStyle_GridHeader
      Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
      object cxGridDocs_FLG_CLOSED: TcxGridDBColumn
        Caption = #1047#1072#1082#1088#1099#1090
        DataBinding.FieldName = 'FLG_CLOSED'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        HeaderAlignmentHorz = taCenter
        MinWidth = 50
        Options.HorzSizing = False
        Width = 50
      end
      object cxGridDocs_DOCID: TcxGridDBColumn
        Caption = #1050#1086#1076
        DataBinding.FieldName = 'DOCID'
        HeaderAlignmentHorz = taCenter
        MinWidth = 60
        Options.HorzSizing = False
        Width = 60
      end
      object cxGridDocs_DATA: TcxGridDBColumn
        Caption = #1044#1072#1090#1072
        DataBinding.FieldName = 'DATA'
        OnGetDisplayText = cxGridDocs_DATAGetDisplayText
        HeaderAlignmentHorz = taCenter
        MinWidth = 100
        Options.HorzSizing = False
        Width = 100
      end
      object cxGridDocs_CT_NAME: TcxGridDBColumn
        Caption = #1050#1086#1085#1090#1088#1072#1075#1077#1085#1090
        DataBinding.FieldName = 'CT_NAME'
        Styles.Content = dmAdditions.cxStyle_Bold
        Width = 200
      end
      object cxGridDocsTableSuma: TcxGridDBColumn
        Caption = #1057#1091#1084#1084#1072
        DataBinding.FieldName = 'SUMA'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        Visible = False
        HeaderAlignmentHorz = taCenter
        MinWidth = 80
        Options.HorzSizing = False
        VisibleForCustomization = False
        Width = 80
      end
      object cxGridDocsTableCurrencyName: TcxGridDBColumn
        Caption = #1042#1072#1083#1102#1090#1072
        DataBinding.FieldName = 'CURRENCY_NAME'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taCenter
        Visible = False
        HeaderAlignmentHorz = taCenter
        MinWidth = 70
        Options.HorzSizing = False
        VisibleForCustomization = False
        Width = 70
      end
      object cxGridDocsTableVAT: TcxGridDBColumn
        Caption = #1053#1044#1057
        DataBinding.FieldName = 'VAT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        Visible = False
        HeaderAlignmentHorz = taCenter
        MinWidth = 70
        Options.HorzSizing = False
        VisibleForCustomization = False
        Width = 70
      end
      object cxGridDocsTableRate: TcxGridDBColumn
        Caption = #1050#1091#1088#1089' '#1044#1086#1082'.'
        DataBinding.FieldName = 'RATE'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        Visible = False
        HeaderAlignmentHorz = taCenter
        MinWidth = 70
        Options.HorzSizing = False
        VisibleForCustomization = False
        Width = 70
      end
      object cxGridCasaPKO_RATEUSD: TcxGridDBColumn
        Caption = #1050#1091#1088#1089' USD'
        DataBinding.FieldName = 'RATEUSD'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        Visible = False
        HeaderAlignmentHorz = taCenter
        MinWidth = 70
        Options.HorzSizing = False
        VisibleForCustomization = False
        Width = 70
      end
      object cxGridDocs_PARENTDOCID: TcxGridDBColumn
        Caption = #1050#1086#1076' '#1088#1086#1076'.'
        DataBinding.FieldName = 'PARENTDOCID'
        HeaderAlignmentHorz = taCenter
        MinWidth = 80
        Options.HorzSizing = False
        Width = 80
      end
      object cxGridCasaPKO_FLG_ACNT: TcxGridDBColumn
        Caption = #1041#1091#1093#1075
        DataBinding.FieldName = 'FLG_ACNT'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.Alignment = taCenter
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        Visible = False
        HeaderAlignmentHorz = taCenter
        MinWidth = 40
        Options.HorzSizing = False
        VisibleForCustomization = False
        Width = 40
      end
      object cxGridDocs_CREATED_BY_NAME: TcxGridDBColumn
        Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
        DataBinding.FieldName = 'CREATED_BY_NAME'
        MinWidth = 200
        Options.HorzSizing = False
        Width = 200
      end
      object cxGridCasaPKO_CT: TcxGridDBColumn
        DataBinding.FieldName = 'CT'
        Visible = False
        VisibleForCustomization = False
      end
      object cxGridCasaPKODB_SC2_NAME: TcxGridDBColumn
        Caption = #1040#1085#1072#1083#1080#1090#1080#1082#1072
        DataBinding.FieldName = 'SC2_NAME'
        Visible = False
        VisibleForCustomization = False
        Width = 50
      end
    end
    object cxGridDocsLevel: TcxGridLevel
      GridView = cxGridDocsTable
    end
  end
  object pnBottom: TPanel
    Left = 0
    Top = 439
    Width = 986
    Height = 229
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object dxBarDockControl1: TdxBarDockControl
      Left = 0
      Top = 0
      Width = 986
      Height = 34
      Align = dalTop
      BarManager = dxBarManagerPKO
      SunkenBorder = True
      UseOwnSunkenBorder = True
    end
    object cxGrid1: TcxGrid
      Left = 0
      Top = 34
      Width = 986
      Height = 195
      Align = alClient
      TabOrder = 1
      object cxGrid1DBTableView1: TcxGridDBTableView
        PopupMenu = dxBarPopupMenuGrid2
        OnCustomDrawCell = cxGrid1DBTableView1CustomDrawCell
        OnFocusedRecordChanged = cxGrid1DBTableView1FocusedRecordChanged
        DataController.DataSource = IBCDS_ACTC
        FilterRow.SeparatorWidth = 8
        FixedDataRows.SeparatorWidth = 8
        NewItemRow.SeparatorWidth = 8
        OptionsBehavior.IncSearch = True
        OptionsBehavior.ImmediateEditor = False
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.InvertSelect = False
        OptionsView.NavigatorOffset = 63
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
        OptionsView.ScrollBars = ssVertical
        OptionsView.ColumnAutoWidth = True
        OptionsView.FixedColumnSeparatorWidth = 3
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        Preview.LeftIndent = 25
        Preview.RightIndent = 6
        RowLayout.MinValueWidth = 100
        Styles.Footer = dmAdditions.cxStyle_GridHeader
        Styles.Header = dmAdditions.cxStyle_GridHeader
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        object cxGrid1DBTableView1INCIDENTID: TcxGridDBColumn
          Caption = #1048#1085#1094#1080#1076#1077#1085#1090
          DataBinding.FieldName = 'INCIDENTID'
          HeaderAlignmentHorz = taCenter
          MinWidth = 80
          Options.HorzSizing = False
          Width = 80
        end
        object cxGrid1DBTableView1ACTNO: TcxGridDBColumn
          Caption = #8470' '#1072#1082#1090#1072
          DataBinding.FieldName = 'ACTNO'
          HeaderAlignmentHorz = taCenter
          MinWidth = 120
          Options.HorzSizing = False
          Width = 120
        end
        object cxGrid1DBTableView1CREATED_DATE: TcxGridDBColumn
          Caption = #1057#1086#1079#1076#1072#1085
          DataBinding.FieldName = 'CREATED_DATE'
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taCenter
          OnGetDisplayText = cxGrid1DBTableView1CREATED_DATEGetDisplayText
          HeaderAlignmentHorz = taCenter
          MinWidth = 100
          Options.HorzSizing = False
          Width = 100
        end
        object cxGrid1DBTableView1CREATED_BY_NAME: TcxGridDBColumn
          Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
          DataBinding.FieldName = 'CREATED_BY_NAME'
          Width = 100
        end
        object cxGrid1DBTableView1ACCEPTED_DATE: TcxGridDBColumn
          Caption = #1044#1072#1090#1072' '#1091#1090#1074#1077#1088#1078#1076#1077#1085#1080#1103
          DataBinding.FieldName = 'ACCEPTED_DATE'
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taCenter
          OnGetDisplayText = cxGrid1DBTableView1ACCEPTED_DATEGetDisplayText
          HeaderAlignmentHorz = taCenter
          MinWidth = 110
          Options.HorzSizing = False
          Width = 110
        end
        object cxGrid1DBTableView1ACCEPTED_BY_NAME: TcxGridDBColumn
          Caption = #1059#1090#1074#1077#1088#1078#1076#1077#1085
          DataBinding.FieldName = 'ACCEPTED_BY_NAME'
          Width = 100
        end
      end
      object cxGrid1Level1: TcxGridLevel
        GridView = cxGrid1DBTableView1
      end
    end
  end
  object cxSplitter: TcxSplitter
    Left = 0
    Top = 429
    Width = 986
    Height = 10
    HotZoneClassName = 'TcxMediaPlayer9Style'
    AlignSplitter = salBottom
    MinSize = 200
    Control = pnBottom
  end
  object dxBarManagerPKO: TdxBarManager
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
    Left = 528
    Top = 92
    PixelsPerInch = 120
    object dxBarManagerPKOBar1: TdxBar
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
      FloatLeft = 1149
      FloatTop = 0
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbIncidentDescription'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbFileEdit'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbFileDelete'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbAprove'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object bbGotoParentDoc: TdxBarButton
      Caption = #1055#1077#1088#1077#1081#1090#1080' '#1082' '#1085#1072#1095#1072#1083#1100#1085#1086#1084#1091' '#1076#1086#1082#1091#1084#1077#1085#1090#1091
      Category = 0
      Hint = #1055#1077#1088#1077#1081#1090#1080' '#1082' '#1085#1072#1095#1072#1083#1100#1085#1086#1084#1091' '#1076#1086#1082#1091#1084#1077#1085#1090#1091
      Visible = ivAlways
      OnClick = bbGotoParentDocClick
    end
    object bbDocComments: TdxBarButton
      Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080'...'
      Category = 0
      Hint = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080
      Visible = ivAlways
      OnClick = bbDocCommentsClick
    end
    object bbCloseDoc: TdxBarButton
      Caption = #1047#1072#1082#1088#1099#1090#1100' '#1076#1086#1082#1091#1084#1077#1085#1090'...'
      Category = 0
      Hint = #1047#1072#1082#1088#1099#1090#1100' '#1076#1086#1082#1091#1084#1077#1085#1090
      Visible = ivAlways
      ShortCut = 120
      OnClick = bbCloseDocClick
    end
    object bbOpenDoc: TdxBarButton
      Caption = #1054#1090#1082#1088#1099#1090#1100' '#1076#1086#1082#1091#1084#1077#1085#1090'...'
      Category = 0
      Hint = #1054#1090#1082#1088#1099#1090#1100' '#1076#1086#1082#1091#1084#1077#1085#1090
      Visible = ivAlways
      OnClick = bbOpenDocClick
    end
    object bbFileNew: TdxBarButton
      Caption = #1053#1086#1074#1099#1081
      Category = 0
      Hint = #1053#1086#1074#1099#1081
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 45
    end
    object bbFileEdit: TdxBarButton
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      Category = 0
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 115
      OnClick = bbFileEditClick
    end
    object bbFileDelete: TdxBarButton
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Category = 0
      Hint = #1059#1076#1072#1083#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 42
      ShortCut = 16430
      OnClick = bbFileDeleteClick
    end
    object bbFileSave: TdxBarButton
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      Category = 0
      Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 32
      OnClick = bbFileSaveClick
    end
    object bbAprove: TdxBarButton
      Caption = #1059#1090#1074#1077#1088#1076#1080#1090#1100' '#1072#1082#1090
      Category = 0
      Hint = #1059#1090#1074#1077#1088#1076#1080#1090#1100' '#1072#1082#1090
      Visible = ivAlways
      ImageIndex = 43
      PaintStyle = psCaptionGlyph
      OnClick = bbAproveClick
    end
    object dxBarButton1: TdxBarButton
      Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086#1073' '#1080#1085#1094#1080#1076#1077#1085#1090#1077
      Category = 0
      Hint = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086#1073' '#1080#1085#1094#1080#1076#1077#1085#1090#1077
      Visible = ivAlways
    end
    object bbIncidentDescription: TdxBarButton
      Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086#1073' '#1080#1085#1094#1080#1076#1077#1085#1090#1077
      Category = 0
      Hint = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086#1073' '#1080#1085#1094#1080#1076#1077#1085#1090#1077
      Visible = ivAlways
      ImageIndex = 51
      PaintStyle = psCaptionGlyph
      OnClick = bbIncidentDescriptionClick
    end
  end
  object dxBarPopupMenuPKO: TdxBarPopupMenu
    BarManager = dxBarManagerPKO
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbCloseDoc'
      end
      item
        Visible = True
        ItemName = 'bbOpenDoc'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbGotoParentDoc'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbDocComments'
      end>
    UseOwnFont = False
    Left = 488
    Top = 184
    PixelsPerInch = 120
  end
  object cxGridPopupMenuDoc: TcxGridPopupMenu
    Grid = cxGridDocs
    PopupMenus = <
      item
        GridView = cxGridDocsTable
        HitTypes = [gvhtCell, gvhtRecord]
        Index = 0
        PopupMenu = dxBarPopupMenuPKO
      end>
    Left = 384
    Top = 144
  end
  object IBC_ACTC: TIBCQuery
    KeyFields = 'actno'
    KeyGenerator = 'GEN_SC_INCIDENT_ACT_ID'
    GeneratorMode = gmInsert
    SQLInsert.Strings = (
      'INSERT INTO VW_SC_INCIDENT_ACT'
      
        '  (ACTNO, DOCID, INCIDENTID, DEFICIENTA, REZOLUTIA, NOTA, DATE_A' +
        'DITIONALE, DATE_ADITIONALE2, CREATED_BY, CREATED_BY_NAME, CREATE' +
        'D_DATE, ACCEPTED_BY, ACCEPTED_BY_NAME, ACCEPTED_DATE)'
      'VALUES'
      
        '  (:ACTNO, :DOCID, :INCIDENTID, :DEFICIENTA, :REZOLUTIA, :NOTA, ' +
        ':DATE_ADITIONALE, :DATE_ADITIONALE2, :CREATED_BY, :CREATED_BY_NA' +
        'ME, :CREATED_DATE, :ACCEPTED_BY, :ACCEPTED_BY_NAME, :ACCEPTED_DA' +
        'TE)')
    SQLDelete.Strings = (
      'DELETE FROM VW_SC_INCIDENT_ACT'
      'WHERE'
      '  ACTNO = :Old_ACTNO')
    SQLUpdate.Strings = (
      'UPDATE VW_SC_INCIDENT_ACT'
      'SET'
      
        '  ACTNO = :ACTNO, DOCID = :DOCID, INCIDENTID = :INCIDENTID, DEFI' +
        'CIENTA = :DEFICIENTA, REZOLUTIA = :REZOLUTIA, NOTA = :NOTA, DATE' +
        '_ADITIONALE = :DATE_ADITIONALE, DATE_ADITIONALE2 = :DATE_ADITION' +
        'ALE2, CREATED_BY = :CREATED_BY, CREATED_BY_NAME = :CREATED_BY_NA' +
        'ME, CREATED_DATE = :CREATED_DATE, ACCEPTED_BY = :ACCEPTED_BY, AC' +
        'CEPTED_BY_NAME = :ACCEPTED_BY_NAME, ACCEPTED_DATE = :ACCEPTED_DA' +
        'TE'
      'WHERE'
      '  ACTNO = :Old_ACTNO')
    SQLRefresh.Strings = (
      
        'SELECT ACTNO, DOCID, INCIDENTID, DEFICIENTA, REZOLUTIA, NOTA, DA' +
        'TE_ADITIONALE, DATE_ADITIONALE2, CREATED_BY, CREATED_BY_NAME, CR' +
        'EATED_DATE, ACCEPTED_BY, ACCEPTED_BY_NAME, ACCEPTED_DATE FROM VW' +
        '_SC_INCIDENT_ACT'
      'WHERE'
      '  ACTNO = :ACTNO')
    SQLLock.Strings = (
      'SELECT NULL FROM SC_INCIDENT_ACT'
      'WHERE'
      'ACTNO = :Old_ACTNO'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'SELECT '
      '*'
      'FROM VW_SC_INCIDENT_ACT')
    MasterFields = 'DOCID'
    DetailFields = 'DOCID'
    MasterSource = dmDB.IBCDataSourceDocs
    AutoCommit = False
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Left = 376
    Top = 332
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DOCID'
        Value = nil
      end>
  end
  object IBCDS_ACTC: TIBCDataSource
    DataSet = IBC_ACTC
    OnDataChange = IBCDS_ACTCDataChange
    Left = 376
    Top = 384
  end
  object dxBarPopupMenuGrid2: TdxBarPopupMenu
    BarManager = dxBarManagerPKO
    ItemLinks = <>
    UseOwnFont = False
    Left = 520
    Top = 328
    PixelsPerInch = 120
  end
  object IBCDataSourceIncidente: TIBCDataSource
    DataSet = IBCQueryIncidente
    Left = 68
    Top = 208
  end
  object IBCQueryIncidente: TIBCQuery
    KeyFields = 'INCIDENTID'
    SQLUpdate.Strings = (
      'UPDATE VW_SC_INCIDENTE'
      'SET'
      ' INCIDENTID = :INCIDENTID, '
      ' GOODS_MODEL = :GOODS_MODEL, '
      ' VENDOR_ID = :VENDOR_ID, '
      ' DEFECTE_DSC = :DEFECTE_DSC, '
      ' ASPECT_VISUAL_DSC = :ASPECT_VISUAL_DSC, '
      ' DATA_EST_FINISH = :DATA_EST_FINISH, '
      ' PRIORITY_LEVEL_ID = :PRIORITY_LEVEL_ID, '
      ' TYPE_ID = :TYPE_ID,'
      ' COMMENTS = :COMMENTS,'
      ' INBAZA_DOC_NAME = :INBAZA_DOC_NAME,'
      ' INBAZA_DOCNO = :INBAZA_DOCNO,'
      ' INBAZA_DATE = :INBAZA_DATE,'
      ' PROFORMA_INVOICE_DOCID = :PROFORMA_INVOICE_DOCID,'
      ' SOLVED_BY = :SOLVED_BY, '
      ' PAYERID = :PAYERID'
      ''
      'WHERE'
      ' INCIDENTID = :Old_INCIDENTID')
    SQLRefresh.Strings = (
      'SELECT '
      ' *'
      'FROM '
      ' VW_SC_INCIDENTE'
      'WHERE'
      ' INCIDENTID = :INCIDENTID')
    SQLLock.Strings = (
      'SELECT NULL FROM SC_INCIDENTE'
      'WHERE'
      'INCIDENTID = :Old_INCIDENTID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'SELECT * FROM vw_sc_incidente WHERE INCIDENTID=:ID')
    AutoCommit = False
    LocalConstraints = False
    Left = 64
    Top = 260
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
        Value = nil
      end>
  end
end
