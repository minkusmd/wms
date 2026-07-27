object frmSqlRepositoryWin: TfrmSqlRepositoryWin
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Sortare'
  ClientHeight = 625
  ClientWidth = 939
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
    Width = 939
    Height = 64
    Title = 'SQL Repository'
    Text = 'Cele mai des intrebuintate SQL query'
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
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 923
    Height = 545
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object pnList: TPanel
      Left = 0
      Top = 0
      Width = 400
      Height = 545
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 0
      object dxBarDockControl1: TdxBarDockControl
        Left = 0
        Top = 0
        Width = 400
        Height = 30
        Align = dalTop
        BarManager = dxBarManager1
        SunkenBorder = True
        UseOwnSunkenBorder = True
      end
      object cxGrid: TcxGrid
        Left = 0
        Top = 30
        Width = 400
        Height = 515
        Align = alClient
        TabOrder = 1
        object cxGridTable: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          ScrollbarAnnotations.CustomAnnotations = <>
          OnFocusedRecordChanged = cxGridTableFocusedRecordChanged
          DataController.DataSource = IBCDataSourceRep
          DataController.KeyFieldNames = 'ID'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.IncSearch = True
          OptionsCustomize.ColumnFiltering = False
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.InvertSelect = False
          OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
          OptionsView.ScrollBars = ssVertical
          OptionsView.CellAutoHeight = True
          OptionsView.ColumnAutoWidth = True
          OptionsView.GridLineColor = 13750737
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          Styles.Header = dmAdditions.cxStyle_GridHeader
          Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
          object cxGridTable_ORDERNO: TcxGridDBColumn
            DataBinding.FieldName = 'ORDERNO'
            PropertiesClassName = 'TcxImageComboBoxProperties'
            Properties.DefaultImageIndex = 50
            Properties.Images = dmAdditions.cxImageList_SWN
            Properties.Items = <>
            MinWidth = 24
            Options.Focusing = False
            Options.HorzSizing = False
            SortIndex = 0
            SortOrder = soAscending
            VisibleForCustomization = False
            Width = 24
            IsCaptionAssigned = True
          end
          object cxGridTable_TITLE: TcxGridDBColumn
            Caption = #1053#1072#1079#1074#1072#1085#1080#1077
            DataBinding.FieldName = 'TITLE'
          end
        end
        object cxGridLevel: TcxGridLevel
          GridView = cxGridTable
        end
      end
    end
    object pnContent: TPanel
      Left = 408
      Top = 0
      Width = 515
      Height = 545
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 2
      object dxBarDockControl2: TdxBarDockControl
        Left = 0
        Top = 0
        Width = 515
        Height = 30
        Align = dalTop
        BarManager = dxBarManager1
        SunkenBorder = True
        UseOwnSunkenBorder = True
      end
      object pcPageControl: TcxPageControl
        Left = 0
        Top = 30
        Width = 515
        Height = 515
        Align = alClient
        TabOrder = 1
        Properties.ActivePage = tbsResults
        Properties.CustomButtons.Buttons = <>
        Properties.TabPosition = tpBottom
        ClientRectBottom = 489
        ClientRectLeft = 4
        ClientRectRight = 511
        ClientRectTop = 4
        object tbsSQLText: TcxTabSheet
          Caption = 'SQL'
          ImageIndex = 0
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object mmSQL_TEXT: TcxDBMemo
            Left = 0
            Top = 0
            Align = alClient
            DataBinding.DataField = 'SQL_TEXT'
            DataBinding.DataSource = IBCDataSourceRep
            ParentFont = False
            Properties.ReadOnly = True
            Properties.ScrollBars = ssVertical
            Style.Font.Charset = DEFAULT_CHARSET
            Style.Font.Color = clWindowText
            Style.Font.Height = -13
            Style.Font.Name = 'Hack'
            Style.Font.Style = []
            Style.IsFontAssigned = True
            TabOrder = 0
            Height = 485
            Width = 507
          end
        end
        object tbsResults: TcxTabSheet
          Caption = 'Rezultate'
          ImageIndex = 1
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object cxGridExec: TcxGrid
            Left = 0
            Top = 0
            Width = 507
            Height = 485
            Align = alClient
            TabOrder = 0
            object cxGridExecTable: TcxGridDBTableView
              Navigator.Buttons.CustomButtons = <>
              ScrollbarAnnotations.CustomAnnotations = <>
              DataController.DataSource = IBCDataSourceExec
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              OptionsBehavior.CopyCaptionsToClipboard = False
              OptionsCustomize.ColumnFiltering = False
              OptionsData.CancelOnExit = False
              OptionsData.Deleting = False
              OptionsData.Editing = False
              OptionsData.Inserting = False
              OptionsSelection.InvertSelect = False
              OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
              OptionsView.CellAutoHeight = True
              OptionsView.ColumnAutoWidth = True
              OptionsView.GridLineColor = 13750737
              OptionsView.GroupByBox = False
              OptionsView.Indicator = True
              Styles.Header = dmAdditions.cxStyle_GridHeader
              Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
              object cxGridExecTableColumn1: TcxGridDBColumn
              end
            end
            object cxGridExecLevel: TcxGridLevel
              GridView = cxGridExecTable
            end
          end
        end
      end
    end
    object cxSplitter1: TcxSplitter
      Left = 400
      Top = 0
      Width = 8
      Height = 545
      HotZoneClassName = 'TcxMediaPlayer9Style'
      MinSize = 400
      Control = pnList
    end
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
    Left = 592
    Top = 16
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
      FloatLeft = 877
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
          BeginGroup = True
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
      FloatLeft = 877
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      IsMainMenu = True
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbCopySql'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbExecute'
        end>
      MultiLine = True
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = True
    end
    object bbNew: TdxBarButton
      Caption = 'Nou'
      Category = 0
      Hint = 'Nou'
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 45
      OnClick = bbNewClick
    end
    object bbEdit: TdxBarButton
      Caption = 'Modifica'
      Category = 0
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 115
      OnClick = bbEditClick
    end
    object bbDelete: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      ShortCut = 46
      OnClick = bbDeleteClick
    end
    object bbCopySql: TdxBarButton
      Caption = 'Copie SQL'
      Category = 0
      Hint = 'Copie SQL'
      Visible = ivAlways
      ImageIndex = 29
      ShortCut = 16451
      OnClick = bbCopySqlClick
    end
    object bbSort: TdxBarButton
      Caption = #1057#1086#1088#1090#1080#1088#1086#1074#1072#1090#1100
      Category = 0
      Hint = #1057#1086#1088#1090#1080#1088#1086#1074#1072#1090#1100
      Visible = ivAlways
      ImageIndex = 38
      OnClick = bbSortClick
    end
    object bbExecute: TdxBarButton
      Caption = 'Executa'
      Category = 0
      Hint = 'Executa'
      Visible = ivAlways
      ImageIndex = 7
      ShortCut = 120
      OnClick = bbExecuteClick
    end
  end
  object IBCQueryRep: TIBCQuery
    KeyFields = 'ID'
    KeyGenerator = 'SQ_TDB_SQL_REPOSITORY_ID'
    GeneratorMode = gmInsert
    SQLInsert.Strings = (
      'INSERT INTO TDB_SQL_REPOSITORY'
      '  (ID, TITLE, SQL_TEXT)'
      'VALUES'
      '  (:ID, :TITLE, :SQL_TEXT)')
    SQLDelete.Strings = (
      'DELETE FROM TDB_SQL_REPOSITORY'
      'WHERE'
      '  ID = :Old_ID')
    SQLUpdate.Strings = (
      'UPDATE TDB_SQL_REPOSITORY'
      'SET'
      '  ID = :ID, TITLE = :TITLE, SQL_TEXT = :SQL_TEXT'
      'WHERE'
      '  ID = :Old_ID')
    SQLRefresh.Strings = (
      'SELECT ID, TITLE, SQL_TEXT, ORDERNO '
      'FROM TDB_SQL_REPOSITORY'
      'WHERE ID = :ID')
    SQLLock.Strings = (
      'SELECT NULL FROM TDB_SQL_REPOSITORY'
      'WHERE'
      'ID = :Old_ID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'SELECT ID, TITLE, SQL_TEXT, ORDERNO '
      'FROM TDB_SQL_REPOSITORY'
      'ORDER BY ORDERNO')
    AutoCommit = False
    LockMode = lmLockImmediate
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Options.RequiredFields = False
    LocalConstraints = False
    Left = 92
    Top = 224
  end
  object IBCDataSourceRep: TIBCDataSource
    DataSet = IBCQueryRep
    Left = 92
    Top = 172
  end
  object IBCExecuteTransaction: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    IsolationLevel = iblReadOnlyReadCommitted
    Left = 600
    Top = 212
  end
  object IBCQueryExec: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = IBCExecuteTransaction
    ReadOnly = True
    Left = 540
    Top = 160
  end
  object IBCDataSourceExec: TIBCDataSource
    AutoEdit = False
    DataSet = IBCQueryExec
    Left = 640
    Top = 156
  end
end
