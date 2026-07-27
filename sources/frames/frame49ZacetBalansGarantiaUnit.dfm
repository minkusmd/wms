inherited frame49ZacetBalansGarantia: Tframe49ZacetBalansGarantia
  Width = 1100
  Height = 601
  Font.Height = -15
  ExplicitWidth = 1100
  ExplicitHeight = 601
  PixelsPerInch = 120
  object cxGridSK: TcxGrid
    Left = 0
    Top = 0
    Width = 1100
    Height = 431
    Align = alClient
    TabOrder = 0
    LookAndFeel.NativeStyle = True
    LookAndFeel.SkinName = ''
    object cxGridSKTable: TcxGridDBTableView
      OnKeyDown = cxGridSKTableKeyDown
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
      OnCellDblClick = cxGridSKTableCellDblClick
      OnCustomDrawCell = cxGridSKTableCustomDrawCell
      DataController.DataSource = dmDB.IBCDataSourceDocs
      DataController.KeyFieldNames = 'DOCID'
      FilterRow.SeparatorWidth = 8
      FixedDataRows.SeparatorWidth = 8
      NewItemRow.SeparatorWidth = 8
      OptionsBehavior.IncSearch = True
      OptionsBehavior.ImmediateEditor = False
      OptionsCustomize.ColumnsQuickCustomization = True
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.InvertSelect = False
      OptionsView.NavigatorOffset = 63
      OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
      OptionsView.ScrollBars = ssVertical
      OptionsView.ColumnAutoWidth = True
      OptionsView.FixedColumnSeparatorWidth = 3
      OptionsView.GridLineColor = 13750737
      OptionsView.GroupRowStyle = grsOffice11
      Preview.LeftIndent = 25
      Preview.RightIndent = 6
      RowLayout.MinValueWidth = 100
      Styles.GroupByBox = dmAdditions.cxStyle_GridGroup
      Styles.Header = dmAdditions.cxStyle_GridHeader
      Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
      object cxGridSK_FLG_CLOSED: TcxGridDBColumn
        Caption = 'Inchis'
        DataBinding.FieldName = 'FLG_CLOSED'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        HeaderAlignmentHorz = taCenter
        MinWidth = 50
        Options.HorzSizing = False
        Width = 50
      end
      object cxGridSK_DOCID: TcxGridDBColumn
        Caption = 'Cod'
        DataBinding.FieldName = 'DOCID'
        HeaderAlignmentHorz = taCenter
        MinWidth = 60
        Options.HorzSizing = False
        Width = 60
      end
      object cxGridSK_DATA: TcxGridDBColumn
        Caption = 'Data'
        DataBinding.FieldName = 'DATA'
        OnGetDisplayText = cxGridSK_DATAGetDisplayText
        HeaderAlignmentHorz = taCenter
        MinWidth = 100
        Options.HorzSizing = False
        Width = 100
      end
      object cxGridSK_CT_NAME: TcxGridDBColumn
        Caption = 'Client'
        DataBinding.FieldName = 'CT_NAME'
        Styles.Content = dmAdditions.cxStyle_Bold
        Width = 200
      end
      object cxGridSK_SUMA: TcxGridDBColumn
        Caption = 'Suma'
        DataBinding.FieldName = 'SUMA'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 80
        Options.HorzSizing = False
        Width = 80
      end
      object cxGridSK_CURRENCY_NAME: TcxGridDBColumn
        Caption = 'Valuta'
        DataBinding.FieldName = 'CURRENCY_NAME'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        MinWidth = 70
        Options.HorzSizing = False
        Width = 70
      end
      object cxGridSK_VAT: TcxGridDBColumn
        Caption = 'TVA'
        DataBinding.FieldName = 'VAT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 70
        Options.HorzSizing = False
        Width = 70
      end
      object cxGridSK_RATE: TcxGridDBColumn
        AlternateCaption = #1050#1091#1088#1089' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
        Caption = 'Rata'
        DataBinding.FieldName = 'RATE'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 70
        Options.HorzSizing = False
        Width = 70
      end
      object cxGridSK_RATEUSD: TcxGridDBColumn
        Caption = 'Rata USD'
        DataBinding.FieldName = 'RATEUSD'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 70
        Options.HorzSizing = False
        Width = 70
      end
      object cxGridSK_FLG_ACNT: TcxGridDBColumn
        Caption = 'Cntb'
        DataBinding.FieldName = 'FLG_ACNT'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        HeaderAlignmentHorz = taCenter
        MinWidth = 40
        Options.HorzSizing = False
        Width = 40
      end
      object cxGridSK_CREATED_BY_NAME: TcxGridDBColumn
        Caption = 'Operator'
        DataBinding.FieldName = 'CREATED_BY_NAME'
        MinWidth = 120
        Options.HorzSizing = False
        Width = 120
      end
    end
    object cxGridSKLevel: TcxGridLevel
      GridView = cxGridSKTable
    end
  end
  object cxSplitter: TcxSplitter
    Left = 0
    Top = 431
    Width = 1100
    Height = 10
    HotZoneClassName = 'TcxMediaPlayer9Style'
    AlignSplitter = salBottom
    MinSize = 100
    Control = pnBottom
  end
  object pnBottom: TPanel
    Left = 0
    Top = 441
    Width = 1100
    Height = 160
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object cxGridFiles: TcxGrid
      Left = 0
      Top = 34
      Width = 1100
      Height = 126
      Align = alClient
      TabOrder = 1
      object cxGridFilesTable: TcxGridDBTableView
        OnFocusedRecordChanged = cxGridFilesTableFocusedRecordChanged
        DataController.DataSource = IBCDataSourceFiles
        DataController.KeyFieldNames = 'ATTID'
        FilterRow.SeparatorWidth = 8
        FixedDataRows.SeparatorWidth = 8
        NewItemRow.SeparatorWidth = 8
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
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
        Styles.Header = dmAdditions.cxStyle_GridHeader
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        object cxGridFiles_FILENAME: TcxGridDBColumn
          Caption = 'Fisier'
          DataBinding.FieldName = 'FILENAME'
        end
        object cxGridFiles_FILESIZE: TcxGridDBColumn
          Caption = 'Marimea'
          DataBinding.FieldName = 'FILESIZE'
          MinWidth = 100
          Options.HorzSizing = False
          Width = 100
        end
      end
      object cxGridFilesLevel: TcxGridLevel
        GridView = cxGridFilesTable
      end
    end
    object dxBarDockControl1: TdxBarDockControl
      Left = 0
      Top = 0
      Width = 1100
      Height = 34
      Align = dalTop
      BarManager = dxBarManagerSK
      SunkenBorder = True
      UseOwnSunkenBorder = True
    end
  end
  object cxGridPopupMenu: TcxGridPopupMenu
    Grid = cxGridSK
    PopupMenus = <
      item
        GridView = cxGridSKTable
        HitTypes = [gvhtCell, gvhtRecord]
        Index = 0
        PopupMenu = dxBarPopupMenu
      end>
    Left = 276
    Top = 136
  end
  object dxBarPopupMenu: TdxBarPopupMenu
    BarManager = dxBarManagerSK
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbCloseDoc'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbOpenDoc'
      end>
    UseOwnFont = False
    OnPopup = dxBarPopupMenuPopup
    Left = 420
    Top = 132
    PixelsPerInch = 120
  end
  object dxBarManagerSK: TdxBarManager
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
    Left = 516
    Top = 80
    PixelsPerInch = 120
    object dxBarManagerSKBar1: TdxBar
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
      FloatLeft = 1328
      FloatTop = 0
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbAddNewFile'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbDeleteFile'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbSaveFileAs'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object bbCloseDoc: TdxBarButton
      Caption = #1047#1072#1082#1088#1099#1090#1100' '#1076#1086#1082#1091#1084#1077#1085#1090'...'
      Category = 0
      Hint = #1047#1072#1082#1088#1099#1090#1100' '#1076#1086#1082#1091#1084#1077#1085#1090
      Visible = ivAlways
      OnClick = bbCloseDocClick
    end
    object bbOpenDoc: TdxBarButton
      Caption = #1054#1090#1082#1088#1099#1090#1100' '#1076#1086#1082#1091#1084#1077#1085#1090'...'
      Category = 0
      Hint = #1054#1090#1082#1088#1099#1090#1100' '#1076#1086#1082#1091#1084#1077#1085#1090
      Visible = ivAlways
      OnClick = bbOpenDocClick
    end
    object bbAddNewFile: TdxBarButton
      Caption = 'Fisier nou'
      Category = 0
      Hint = 'Fisier nou'
      Visible = ivAlways
      ImageIndex = 40
      OnClick = bbAddNewFileClick
    end
    object bbDeleteFile: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      OnClick = bbDeleteFileClick
    end
    object bbSaveFileAs: TdxBarButton
      Caption = 'Salveaza'
      Category = 0
      Hint = 'Salveaza'
      Visible = ivAlways
      ImageIndex = 32
      OnClick = bbSaveFileAsClick
    end
  end
  object IBCQueryFiles: TIBCQuery
    KeyFields = 'ATTID'
    KeyGenerator = 'SQ_TDB_DOCS_ATTACHMENTS_ID'
    GeneratorMode = gmInsert
    SQLInsert.Strings = (
      'INSERT INTO TDB_DOCS_ATTACHMENTS'
      '  (ATTID, DOCID, FILENAME, FILESIZE)'
      'VALUES'
      '  (:ATTID, :DOCID, :FILENAME, :FILESIZE)')
    SQLDelete.Strings = (
      'DELETE FROM TDB_DOCS_ATTACHMENTS'
      'WHERE'
      '  ATTID = :Old_ATTID')
    SQLUpdate.Strings = (
      'UPDATE TDB_DOCS_ATTACHMENTS'
      'SET'
      '  ATTID = :ATTID, '
      '  DOCID = :DOCID, '
      '  FILENAME = :FILENAME, '
      '  FILESIZE = :FILESIZE'
      'WHERE'
      '  ATTID = :Old_ATTID')
    SQLRefresh.Strings = (
      'SELECT '
      '*'
      'FROM VW_TDB_DOCS_ATTACHMENTS'
      'WHERE'
      '  ATTID = :ATTID')
    SQLLock.Strings = (
      'SELECT NULL FROM TDB_DOCS_ATTACHMENTS'
      'WHERE'
      'ATTID = :Old_ATTID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'SELECT '
      '*'
      'FROM VW_TDB_DOCS_ATTACHMENTS')
    MasterFields = 'DOCID'
    DetailFields = 'DOCID'
    MasterSource = dmDB.IBCDataSourceDocs
    AutoCommit = False
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Options.DetailDelay = 500
    Left = 56
    Top = 296
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DOCID'
        Value = nil
      end>
  end
  object IBCDataSourceFiles: TIBCDataSource
    DataSet = IBCQueryFiles
    Left = 56
    Top = 348
  end
end
