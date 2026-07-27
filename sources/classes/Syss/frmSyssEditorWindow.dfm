object frmSelectSyssEditorWin: TfrmSelectSyssEditorWin
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Nomenclatoare'
  ClientHeight = 718
  ClientWidth = 1037
  Color = clBtnFace
  Constraints.MinHeight = 555
  Constraints.MinWidth = 720
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 1037
    Height = 64
    Title = 'Nomenclatoare'
    Text = 'Alegerea informatiei din nomenclatorul de sistem'
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
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 1021
    Height = 589
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 0
    Align = alClient
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 1
    object pnFolders: TPanel
      Left = 0
      Top = 0
      Width = 281
      Height = 589
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 0
      object dxBarDockControl1: TdxBarDockControl
        Left = 0
        Top = 0
        Width = 281
        Height = 30
        Margins.Left = 8
        Margins.Top = 8
        Margins.Right = 8
        Margins.Bottom = 1
        Align = dalTop
        BarManager = dxBarManager
        SunkenBorder = True
        UseOwnSunkenBorder = True
      end
      object cxGridGroups: TcxGrid
        Left = 0
        Top = 30
        Width = 281
        Height = 559
        Align = alClient
        TabOrder = 1
        object cxGridGroupsTable: TcxGridDBTableView
          PopupMenu = dxBarPopupMenuGroups
          OnKeyDown = cxGridGroupsTableKeyDown
          Navigator.Buttons.CustomButtons = <>
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
          ScrollbarAnnotations.CustomAnnotations = <>
          OnCellDblClick = cxGridGroupsTableCellDblClick
          OnFocusedRecordChanged = cxGridGroupsTableFocusedRecordChanged
          DataController.DataSource = IBCDataSourceSYSS
          DataController.KeyFieldNames = 'SYSSID'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsCustomize.ColumnsQuickCustomization = True
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
          OptionsView.ScrollBars = ssVertical
          OptionsView.ShowEditButtons = gsebForFocusedRecord
          OptionsView.ColumnAutoWidth = True
          OptionsView.GridLineColor = 13750737
          OptionsView.GroupByBox = False
          Styles.Header = dmAdditions.cxStyle_GridHeader
          object cxGridGroupsCol_ID: TcxGridDBColumn
            AlternateCaption = #1050#1086#1076' '#1075#1088#1091#1087#1087#1099
            Caption = 'Cod'
            DataBinding.FieldName = 'SYSSID'
            DataBinding.IsNullValueType = True
            HeaderAlignmentHorz = taCenter
            MinWidth = 50
            Options.Filtering = False
            Options.Focusing = False
            Options.HorzSizing = False
            Options.Moving = False
            SortIndex = 0
            SortOrder = soAscending
            Width = 50
          end
          object cxGridGroupsCol_TITLE: TcxGridDBColumn
            Caption = 'Mapa'
            DataBinding.FieldName = 'TITLE'
            DataBinding.IsNullValueType = True
            Options.Moving = False
            Styles.Content = dmAdditions.cxStyle_Bold
            VisibleForCustomization = False
          end
        end
        object cxGridGroupsLevel: TcxGridLevel
          GridView = cxGridGroupsTable
        end
      end
    end
    object pnData: TPanel
      AlignWithMargins = True
      Left = 291
      Top = 0
      Width = 730
      Height = 589
      Margins.Left = 2
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 2
      object dxBarDockControl2: TdxBarDockControl
        Left = 0
        Top = 0
        Width = 730
        Height = 30
        Margins.Left = 8
        Margins.Top = 8
        Margins.Right = 8
        Margins.Bottom = 1
        Align = dalTop
        BarManager = dxBarManager
        SunkenBorder = True
        UseOwnSunkenBorder = True
      end
      object cxGridData: TcxGrid
        Left = 0
        Top = 30
        Width = 730
        Height = 559
        Align = alClient
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Consolas'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        object cxGridDataTable: TcxGridDBTableView
          PopupMenu = dxBarPopupMenuData
          OnKeyDown = cxGridDataTableKeyDown
          Navigator.Buttons.CustomButtons = <>
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
          ScrollbarAnnotations.CustomAnnotations = <>
          OnCellDblClick = cxGridDataTableCellDblClick
          OnFocusedRecordChanged = cxGridDataTableFocusedRecordChanged
          DataController.DataSource = IBCDataSourceSYSSData
          DataController.KeyFieldNames = 'SYSSID'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.IncSearch = True
          OptionsCustomize.ColumnsQuickCustomization = True
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.InvertSelect = False
          OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
          OptionsView.ScrollBars = ssVertical
          OptionsView.ShowEditButtons = gsebForFocusedRecord
          OptionsView.ColumnAutoWidth = True
          OptionsView.GridLineColor = 13750737
          OptionsView.GroupByBox = False
          Styles.Header = dmAdditions.cxStyle_GridHeader
          object cxGridDataCol_IMG: TcxGridDBColumn
            DataBinding.IsNullValueType = True
            PropertiesClassName = 'TcxImageComboBoxProperties'
            Properties.DefaultImageIndex = 50
            Properties.Images = dmAdditions.cxImageList_SWN
            Properties.Items = <>
            MinWidth = 24
            Options.Filtering = False
            Options.ShowEditButtons = isebNever
            Options.HorzSizing = False
            Options.Moving = False
            Options.Sorting = False
            VisibleForCustomization = False
            Width = 24
          end
          object cxGridDataCol_ID: TcxGridDBColumn
            AlternateCaption = #1050#1086#1076' '#1079#1072#1087#1080#1089#1080
            Caption = 'Cod'
            DataBinding.FieldName = 'SYSSID'
            DataBinding.IsNullValueType = True
            MinWidth = 50
            Options.Filtering = False
            Options.Focusing = False
            Options.HorzSizing = False
            Options.Moving = False
            Width = 50
          end
          object cxGridDataCol_TITLE: TcxGridDBColumn
            Caption = 'Valoare'
            DataBinding.FieldName = 'TITLE'
            DataBinding.IsNullValueType = True
            Options.Moving = False
            VisibleForCustomization = False
            Width = 288
          end
          object cxGridDataCol_VALUE_INT2: TcxGridDBColumn
            DataBinding.FieldName = 'VALUE_INT'
            DataBinding.IsNullValueType = True
            PropertiesClassName = 'TcxLookupComboBoxProperties'
            Properties.KeyFieldNames = 'SYSSID'
            Properties.ListColumns = <
              item
                FieldName = 'TITLE'
              end>
            Properties.ListOptions.ShowHeader = False
            Properties.ListSource = IBCDataSourceSYSSLookup
            Options.ShowEditButtons = isebNever
            Options.Moving = False
            VisibleForCustomization = False
            Width = 127
            IsCaptionAssigned = True
          end
          object cxGridDataCol_ValueSTR: TcxGridDBColumn
            DataBinding.FieldName = 'VALUE_STR'
            DataBinding.IsNullValueType = True
            Options.Moving = False
            VisibleForCustomization = False
            Width = 127
            IsCaptionAssigned = True
          end
          object cxGridDataCol_VALUE_INT1: TcxGridDBColumn
            DataBinding.FieldName = 'VALUE_INT'
            DataBinding.IsNullValueType = True
            MinWidth = 100
            Options.HorzSizing = False
            Options.Moving = False
            VisibleForCustomization = False
            Width = 100
            IsCaptionAssigned = True
          end
        end
        object cxGridLevel: TcxGridLevel
          GridView = cxGridDataTable
        end
      end
    end
    object cxSplitter: TcxSplitter
      Left = 281
      Top = 0
      Width = 8
      Height = 589
      HotZoneClassName = 'TcxMediaPlayer9Style'
      MinSize = 270
      Control = pnFolders
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 661
    Width = 1037
    Height = 57
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    DesignSize = (
      1037
      57)
    object btnOk: TcxButton
      Left = 816
      Top = 12
      Width = 90
      Height = 29
      Anchors = [akTop, akRight]
      Caption = 'Alege'
      Default = True
      TabOrder = 0
      OnClick = btnOkClick
    end
    object btnCancel: TcxButton
      Left = 924
      Top = 12
      Width = 90
      Height = 29
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Renunta'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object dxBarManager: TdxBarManager
    AllowReset = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    CanCustomize = False
    Categories.Strings = (
      'Default'
      'Groups'
      'Data')
    Categories.ItemsVisibles = (
      2
      2
      2)
    Categories.Visibles = (
      True
      True
      True)
    ImageOptions.Images = dmAdditions.cxImageList_SWN
    NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
    PopupMenuLinks = <>
    SunkenBorder = True
    UseSystemFont = True
    Left = 648
    Top = 172
    PixelsPerInch = 96
    object dxBarManagerBar1: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'SystemItems'
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 45
      FloatTop = 183
      FloatClientWidth = 51
      FloatClientHeight = 77
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbNewGroup'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbModifyGroup'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBar2: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'DataItems'
      CaptionButtons = <>
      DockControl = dxBarDockControl2
      DockedDockControl = dxBarDockControl2
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 756
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbNewItem'
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
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbPrint'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbBrandImages'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarSubItem1'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object bbPrint: TdxBarButton
      Caption = 'Tipar'
      Category = 0
      Hint = 'Tipar'
      Visible = ivAlways
      ImageIndex = 28
      OnClick = bbPrintClick
    end
    object bbBrandImages: TdxBarButton
      Action = actBrandImage
      Caption = 'Logo'
      Category = 0
      ImageIndex = 19
      PaintStyle = psCaptionGlyph
      ShortCut = 117
    end
    object dxBarSubItem1: TdxBarSubItem
      Caption = 'Instrumente'
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarButton1'
        end>
    end
    object dxBarButton1: TdxBarButton
      Caption = 'Uneste 2 elemente'
      Category = 0
      Hint = 'Uneste 2 elemente'
      Visible = ivAlways
      OnClick = dxBarButton1Click
    end
    object bbNewGroup: TdxBarButton
      Caption = 'Mapa noua'
      Category = 1
      Hint = 'Mapa noua'
      Visible = ivAlways
      ImageIndex = 40
      OnClick = bbNewGroupClick
    end
    object bbModifyGroup: TdxBarButton
      Caption = 'Modifica'
      Category = 1
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 41
      OnClick = bbModifyGroupClick
    end
    object bbNewItem: TdxBarButton
      Caption = 'Element nou'
      Category = 2
      Hint = 'Element nou'
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 45
      OnClick = bbNewItemClick
    end
    object bbModifyItem: TdxBarButton
      Caption = 'Modifica'
      Category = 2
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 115
      OnClick = bbModifyItemClick
    end
    object bbDeleteItem: TdxBarButton
      Caption = 'Sterge'
      Category = 2
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      ShortCut = 16430
      OnClick = bbDeleteItemClick
    end
  end
  object IBCQuerySYSS: TIBCQuery
    KeyFields = 'SYSSID'
    KeyGenerator = 'SQ_TS_SYSS_SYSSID'
    GeneratorMode = gmInsert
    SQLInsert.Strings = (
      'INSERT INTO TS_SYSS'
      
        '  (SYSSID, PARENTID, TITLE, VALUE_STR, VALUE_INT, VALUE_INT_TYPE' +
        ')'
      'VALUES'
      
        '  (:SYSSID, :PARENTID, :TITLE, :VALUE_STR, :VALUE_INT, :VALUE_IN' +
        'T_TYPE)')
    SQLDelete.Strings = (
      'DELETE FROM TS_SYSS'
      'WHERE'
      '  SYSSID = :Old_SYSSID')
    SQLUpdate.Strings = (
      'UPDATE TS_SYSS'
      'SET'
      ' SYSSID = :SYSSID, '
      ' PARENTID = :PARENTID, '
      ' TITLE = :TITLE, '
      ' VALUE_STR = :VALUE_STR, '
      ' VALUE_INT = :VALUE_INT,'
      ' VALUE_INT_TYPE = :VALUE_INT_TYPE'
      'WHERE'
      ' SYSSID = :Old_SYSSID')
    SQLRefresh.Strings = (
      'SELECT '
      ' SYSSID, '
      ' PARENTID, '
      ' TITLE, '
      ' VALUE_STR, '
      ' VALUE_INT, '
      ' VALUE_INT_TYPE,'
      
        ' IIF(VALUE_INT_TYPE=1,'#39#1062#1077#1083#1086#1077' '#1079#1085#1072#1095#1077#1085#1080#1077#39',IIF(VALUE_INT_TYPE=2,(SEL' +
        'ECT TITLE FROM TS_SYSS s2 WHERE s2.SYSSID=ss.VALUE_INT),NULL)) A' +
        'S TITLE_INT'
      'FROM '
      ' TS_SYSS ss'
      'WHERE'
      ' SYSSID = :SYSSID')
    SQLLock.Strings = (
      'SELECT NULL FROM TS_SYSS'
      'WHERE'
      ' SYSSID = :Old_SYSSID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = IBCTrUpdateSYSS
    SQL.Strings = (
      'SELECT'
      ' SYSSID,'
      ' PARENTID,'
      ' TITLE,'
      ' VALUE_INT,'
      ' VALUE_STR,'
      ' VALUE_INT_TYPE,'
      
        ' IIF(VALUE_INT_TYPE=1,'#39#1062#1077#1083#1086#1077' '#1079#1085#1072#1095#1077#1085#1080#1077#39',IIF(VALUE_INT_TYPE=2,(SEL' +
        'ECT TITLE FROM TS_SYSS s2 WHERE s2.SYSSID=ss.VALUE_INT),NULL)) A' +
        'S TITLE_INT'
      'FROM '
      ' TS_SYSS ss'
      'WHERE'
      ' (PARENTID = 0)')
    AutoCommit = False
    LockMode = lmLockImmediate
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Options.RequiredFields = False
    LocalConstraints = False
    Left = 120
    Top = 196
  end
  object IBCTrUpdateSYSS: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 164
    Top = 248
  end
  object IBCDataSourceSYSS: TIBCDataSource
    DataSet = IBCQuerySYSS
    Left = 120
    Top = 140
  end
  object IBCDataSourceSYSSData: TIBCDataSource
    DataSet = IBCQuerySYSSData
    Left = 324
    Top = 164
  end
  object IBCQuerySYSSData: TIBCQuery
    UpdatingTable = 'TS_SYSS'
    KeyFields = 'SYSSID'
    KeyGenerator = 'SQ_TS_SYSS_SYSSID'
    GeneratorMode = gmInsert
    SQLInsert.Strings = (
      'INSERT INTO TS_SYSS'
      '  (SYSSID,'
      '   PARENTID, '
      '   TITLE, '
      '   VALUE_STR, '
      '   VALUE_INT,'
      '   VALUE_INT_TYPE)'
      'VALUES'
      ' ('
      '  :SYSSID, '
      '  :PARENTID,'
      '  :TITLE,'
      '  :VALUE_STR,'
      '  :VALUE_INT,'
      '  :VALUE_INT_TYPE'
      ' )')
    SQLDelete.Strings = (
      'DELETE FROM TS_SYSS'
      'WHERE'
      '  SYSSID = :Old_SYSSID')
    SQLUpdate.Strings = (
      'UPDATE '
      ' TS_SYSS'
      'SET'
      ' SYSSID = :SYSSID, '
      ' PARENTID = :PARENTID,'
      ' TITLE = :TITLE,'
      ' VALUE_STR = :VALUE_STR,'
      ' VALUE_INT = :VALUE_INT,'
      ' VALUE_INT_TYPE = :VALUE_INT_TYPE'
      'WHERE'
      '  SYSSID = :Old_SYSSID')
    SQLRefresh.Strings = (
      'SELECT'
      ' SYSSID,'
      ' PARENTID,'
      ' TITLE,'
      ' VALUE_INT,'
      ' VALUE_STR,'
      ' VALUE_INT_TYPE,'
      
        '(SELECT TITLE FROM TS_SYSS s2 WHERE s2.SYSSID=SS.VALUE_INT) TITL' +
        'E2'
      'FROM '
      ' TS_SYSS SS'
      'WHERE'
      '  SYSSID = :SYSSID')
    SQLLock.Strings = (
      'SELECT NULL FROM TS_SYSS'
      'WHERE'
      'SYSSID = :Old_SYSSID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = IBCTrUpdateSYSS
    SQL.Strings = (
      'SELECT'
      ' SYSSID,'
      ' PARENTID,'
      ' TITLE,'
      ' VALUE_INT,'
      ' VALUE_STR,'
      ' VALUE_INT_TYPE,'
      
        '(SELECT TITLE FROM TS_SYSS s2 WHERE s2.SYSSID=SS.VALUE_INT) TITL' +
        'E2'
      'FROM '
      ' TS_SYSS SS'
      'WHERE'
      ' (PARENTID>0)'
      'order by upper(title)')
    MasterFields = 'SYSSID'
    DetailFields = 'PARENTID'
    MasterSource = IBCDataSourceSYSS
    Options.StrictUpdate = False
    Options.UpdateAllFields = True
    Left = 324
    Top = 220
    ParamData = <
      item
        DataType = ftInteger
        Name = 'SYSSID'
        ParamType = ptInput
        Value = 1
      end>
  end
  object IBCQuerySYSSLookup: TIBCQuery
    KeyFields = 'SYSSID'
    GeneratorMode = gmInsert
    SQLInsert.Strings = (
      'INSERT INTO TS_SYSS'
      '  (SYSSID, '
      '   STYPE, '
      '   SNO, '
      '   TITLE, '
      '   VALUE_STR, '
      '   VALUE_INT)'
      'VALUES'
      ' ('
      '  :SYSSID, '
      '  :STYPE, '
      '  :SNO,'
      '  :TITLE,'
      '  :VALUE_STR,'
      '  :VALUE_INT'
      ' )')
    SQLDelete.Strings = (
      'DELETE FROM TS_SYSS'
      'WHERE'
      '  SYSSID = :Old_SYSSID')
    SQLUpdate.Strings = (
      'UPDATE '
      ' TS_SYSS'
      'SET'
      ' SYSSID = :SYSSID, '
      ' STYPE = :STYPE,'
      ' SNO = :SNO,'
      ' TITLE = :TITLE,'
      ' VALUE_STR = :VALUE_STR,'
      ' VALUE_INT = :VALUE_INT'
      'WHERE'
      '  SYSSID = :Old_SYSSID')
    SQLRefresh.Strings = (
      'SELECT '
      
        ' TS_SYSS.SYSSID, TS_SYSS.STYPE, TS_SYSS.SNO, TS_SYSS.TITLE, TS_S' +
        'YSS.VALUE_STR, TS_SYSS.VALUE_INT '
      'FROM '
      ' TS_SYSS'
      'WHERE'
      '  SYSSID = :SYSSID')
    SQLLock.Strings = (
      'SELECT NULL FROM TS_SYSS'
      'WHERE'
      'SYSSID = :Old_SYSSID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT'
      ' SYSSID,'
      ' PARENTID,'
      ' TITLE'
      'FROM '
      ' TS_SYSS')
    MasterFields = 'VALUE_INT'
    DetailFields = 'PARENTID'
    MasterSource = IBCDataSourceSYSS
    AutoCommit = False
    Options.RequiredFields = False
    LocalConstraints = False
    Left = 480
    Top = 244
    ParamData = <
      item
        DataType = ftInteger
        Name = 'VALUE_INT'
        ParamType = ptInput
        Value = nil
      end>
  end
  object IBCDataSourceSYSSLookup: TIBCDataSource
    DataSet = IBCQuerySYSSLookup
    Left = 480
    Top = 188
  end
  object dxBarPopupMenuData: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbNewItem'
      end
      item
        Visible = True
        ItemName = 'bbModifyItem'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbDeleteItem'
      end>
    UseOwnFont = False
    Left = 324
    Top = 312
    PixelsPerInch = 96
  end
  object dxBarPopupMenuGroups: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbNewGroup'
      end
      item
        Visible = True
        ItemName = 'bbModifyGroup'
      end>
    UseOwnFont = False
    Left = 60
    Top = 284
    PixelsPerInch = 96
  end
  object dxComponentPrinter: TdxComponentPrinter
    CurrentLink = dxComponentPrinterLink1
    PreviewOptions.EnableOptions = [peoCanChangeMargins, peoPageSetup, peoPreferences, peoPrint]
    PreviewOptions.VisibleOptions = [pvoPageSetup, pvoPreferences, pvoPrint, pvoPageMargins]
    PreviewOptions.WindowState = wsMaximized
    PrintTitle = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082#1080
    Version = 0
    Left = 724
    Top = 108
    PixelsPerInch = 96
    object dxComponentPrinterLink1: TdxGridReportLink
      Active = True
      Component = cxGridData
      PrinterPage.DMPaper = 9
      PrinterPage.Footer = 6350
      PrinterPage.GrayShading = True
      PrinterPage.Header = 6350
      PrinterPage.Margins.Bottom = 12700
      PrinterPage.Margins.Left = 12700
      PrinterPage.Margins.Right = 12700
      PrinterPage.Margins.Top = 12700
      PrinterPage.Orientation = poLandscape
      PrinterPage.PageSize.X = 210000
      PrinterPage.PageSize.Y = 297000
      PrinterPage._dxMeasurementUnits_ = 0
      PrinterPage._dxLastMU_ = 2
      ReportDocument.CreationDate = 45629.463814814820000000
      ReportDocument.Creator = 'SWN'
      ReportDocument.IsCaptionAssigned = True
      ReportTitle.Font.Charset = RUSSIAN_CHARSET
      ReportTitle.Font.Color = clBlack
      ReportTitle.Font.Height = -16
      ReportTitle.Font.Name = 'Calibri'
      ReportTitle.Font.Style = [fsBold]
      ReportTitle.Mode = tmOnFirstPage
      ReportTitle.TextAlignX = taLeft
      OptionsFormatting.ConsumeSelectionStyle = True
      OptionsLevels.Unwrap = True
      OptionsOnEveryPage.Footers = False
      OptionsOnEveryPage.Caption = False
      OptionsOnEveryPage.FilterBar = False
      OptionsRefinements.TransparentGraphics = True
      OptionsSize.AutoWidth = True
      OptionsView.Footers = False
      OptionsView.Caption = False
      OptionsView.ExpandButtons = False
      OptionsView.FilterBar = False
      OptionsView.GroupFooters = False
      StyleRepository = dmAdditions.cxMainStyleRepository
      PixelsPerInch = 96
      BuiltInReportLink = True
    end
  end
  object SysSActionList: TActionList
    Left = 432
    Top = 136
    object actBrandImage: TAction
      Caption = 'Logo brand...'
      OnExecute = actBrandImageExecute
      OnUpdate = actBrandImageUpdate
    end
  end
end
