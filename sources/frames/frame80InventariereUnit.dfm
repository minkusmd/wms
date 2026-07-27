inherited frame80Inventariere: Tframe80Inventariere
  Font.Height = -15
  PixelsPerInch = 120
  object cxGridDocs: TcxGrid
    Left = 0
    Top = 0
    Width = 986
    Height = 258
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
      OnCustomDrawCell = cxGridDocsTableCustomDrawCell
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
      OptionsView.CellEndEllipsis = True
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
      object cxGrid_FLG_CLOSED: TcxGridDBColumn
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
      object cxGrid_DOCID: TcxGridDBColumn
        Caption = 'Cod'
        DataBinding.FieldName = 'DOCID'
        HeaderAlignmentHorz = taCenter
        MinWidth = 60
        Options.HorzSizing = False
        Width = 60
      end
      object cxGrid_DATA: TcxGridDBColumn
        Caption = 'Data'
        DataBinding.FieldName = 'DATA'
        HeaderAlignmentHorz = taCenter
        MinWidth = 110
        Options.HorzSizing = False
        Width = 110
      end
      object cxGrid_DT_NAME: TcxGridDBColumn
        Caption = 'Subdiviziune'
        DataBinding.FieldName = 'DT_NAME'
        HeaderAlignmentHorz = taCenter
        Width = 200
      end
      object cxGrid_DTDEP_NAME: TcxGridDBColumn
        Caption = 'Depozit'
        DataBinding.FieldName = 'DTDEP_NAME'
        HeaderAlignmentHorz = taCenter
        Width = 100
      end
      object cxGrid_SUMA: TcxGridDBColumn
        Caption = #1057#1091#1084#1084#1072
        DataBinding.FieldName = 'SUMA'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        Visible = False
        HeaderAlignmentHorz = taCenter
        MinWidth = 70
        Options.HorzSizing = False
        VisibleForCustomization = False
        Width = 70
      end
      object cxGrid_CURRENCY_NAME: TcxGridDBColumn
        Caption = 'Valuta'
        DataBinding.FieldName = 'CURRENCY_NAME'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        MinWidth = 70
        Options.HorzSizing = False
        Width = 70
      end
      object cxGrid_VAT: TcxGridDBColumn
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
      object cxGrid_RATE: TcxGridDBColumn
        Caption = 'Curs Doc'
        DataBinding.FieldName = 'RATE'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 80
        Options.HorzSizing = False
        Width = 80
      end
      object cxGrid_CREATED_BY_NAME: TcxGridDBColumn
        Caption = 'Utilizator'
        DataBinding.FieldName = 'CREATED_BY_NAME'
        Width = 80
      end
    end
    object cxGridDocsLevel: TcxGridLevel
      GridView = cxGridDocsTable
    end
  end
  object pnBottom: TPanel
    Left = 0
    Top = 268
    Width = 986
    Height = 400
    Align = alBottom
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 2
    object dxBarDockControl1: TdxBarDockControl
      Left = 0
      Top = 0
      Width = 986
      Height = 34
      Align = dalTop
      BarManager = dxBarManager1
      SunkenBorder = True
      UseOwnSunkenBorder = True
    end
    object cxGridInvent: TcxGrid
      Left = 0
      Top = 34
      Width = 986
      Height = 366
      Align = alClient
      TabOrder = 1
      object cxGridInventDBTableView: TcxGridDBTableView
        DataController.DataSource = IBCDataSourceInvent
        DataController.KeyFieldNames = 'DOCID;GOODSID'
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
        OptionsView.NavigatorOffset = 63
        OptionsView.ColumnAutoWidth = True
        OptionsView.FixedColumnSeparatorWidth = 3
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        Preview.LeftIndent = 25
        Preview.RightIndent = 6
        RowLayout.MinValueWidth = 100
        object cxGridInventDBTableViewGOODSID: TcxGridDBColumn
          Caption = 'Cod'
          DataBinding.FieldName = 'GOODSID'
          HeaderAlignmentHorz = taCenter
        end
        object cxGridInventDBTableViewIMAGE_INDEX: TcxGridDBColumn
          Caption = '...'
          DataBinding.FieldName = 'IMAGE_INDEX'
          Width = 20
        end
        object cxGridInventDBTableViewGOODSNAME: TcxGridDBColumn
          Caption = 'Produs'
          DataBinding.FieldName = 'GOODSNAME'
          HeaderAlignmentHorz = taCenter
          Width = 476
        end
        object cxGridInventDBTableViewBALANCE_QTY: TcxGridDBColumn
          Caption = 'Calculat'
          DataBinding.FieldName = 'BALANCE_QTY'
          HeaderAlignmentHorz = taCenter
          Width = 64
        end
        object cxGridInventDBTableViewREZERV_QTY: TcxGridDBColumn
          Caption = 'Rezerva'
          DataBinding.FieldName = 'REZERV_QTY'
          HeaderAlignmentHorz = taCenter
          Width = 64
        end
        object cxGridInventDBTableViewREAL_QTY: TcxGridDBColumn
          Caption = 'Real'
          DataBinding.FieldName = 'REAL_QTY'
          HeaderAlignmentHorz = taCenter
          Width = 64
        end
        object cxGridInventDBTableViewCOMMENT: TcxGridDBColumn
          Caption = 'Descriere'
          DataBinding.FieldName = 'COMMENT'
          HeaderAlignmentHorz = taCenter
          Width = 150
        end
        object cxGridInventDBTableViewCREATED_BY: TcxGridDBColumn
          DataBinding.FieldName = 'CREATED_BY'
          Visible = False
        end
        object cxGridInventDBTableViewCREATE_BY_NAME: TcxGridDBColumn
          Caption = 'Creat de'
          DataBinding.FieldName = 'CREATE_BY_NAME'
          Visible = False
          HeaderAlignmentHorz = taCenter
          Width = 100
        end
        object cxGridInventDBTableViewMODIFIED_BY: TcxGridDBColumn
          DataBinding.FieldName = 'MODIFIED_BY'
          Visible = False
        end
        object cxGridInventDBTableViewMODIFIED_BY_NAME: TcxGridDBColumn
          Caption = 'Modificat de'
          DataBinding.FieldName = 'MODIFIED_BY_NAME'
          Visible = False
          HeaderAlignmentHorz = taCenter
          Width = 100
        end
      end
      object cxGridInventLevel1: TcxGridLevel
        GridView = cxGridInventDBTableView
      end
    end
  end
  object cxSplitter: TcxSplitter
    Left = 0
    Top = 258
    Width = 986
    Height = 10
    HotZoneClassName = 'TcxMediaPlayer9Style'
    AlignSplitter = salBottom
    MinSize = 300
    Control = pnBottom
  end
  object cxGridDocsPopupMenu: TcxGridPopupMenu
    Grid = cxGridDocs
    PopupMenus = <
      item
        GridView = cxGridDocsTable
        HitTypes = [gvhtCell, gvhtRecord]
        Index = 0
        PopupMenu = pmDocs
      end>
    Left = 412
    Top = 108
  end
  object dxBarManager1: TdxBarManager
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
    ImageOptions.LargeImages = cxImageList1
    ImageOptions.StretchGlyphs = False
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 520
    Top = 104
    PixelsPerInch = 120
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
      FloatLeft = 1094
      FloatTop = 0
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'dxBarButton3'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'dxBarButton5'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'dxBarButton1'
        end
        item
          Visible = True
          ItemName = 'dxBarButton2'
        end
        item
          BeginGroup = True
          UserDefine = [udWidth]
          UserWidth = 259
          Visible = True
          ItemName = 'dxBarCombo1'
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
    object dxBarButton1: TdxBarButton
      Caption = 'Completeaza din depozitul ales'
      Category = 0
      Hint = 'Completeaza din depozitul ales'
      Visible = ivAlways
      ImageIndex = 58
    end
    object dxBarCombo1: TdxBarCombo
      Caption = 'Filtre'
      Category = 0
      Hint = 'Filtre'
      Visible = ivAlways
      OnChange = dxBarCombo1Change
      ImageIndex = 26
      ShowCaption = True
      Width = 125
      Text = 'Toate produsele din document'
      Items.Strings = (
        'Toate produsele din document'
        'Surplus de marfa'
        'Lipsuri de marfa'
        'Produse in stoc')
      ItemIndex = 0
    end
    object dxBarButton2: TdxBarButton
      Caption = 'Importa din nomenclator...'
      Category = 0
      Hint = 'Importa din nomenclator'
      Visible = ivAlways
      OnClick = dxBarButton2Click
    end
    object dxBarButton3: TdxBarButton
      Caption = 'Produs nou'
      Category = 0
      Hint = 'Produs nou'
      Visible = ivAlways
      ImageIndex = 40
      OnClick = dxBarButton3Click
    end
    object dxBarButton5: TdxBarButton
      Caption = 'Sterge produs'
      Category = 0
      Hint = 'Sterge produs'
      Visible = ivAlways
      ImageIndex = 42
      OnClick = dxBarButton5Click
    end
  end
  object pmDocs: TdxBarPopupMenu
    BarManager = dxBarManager1
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbCloseDoc'
      end
      item
        Visible = True
        ItemName = 'bbOpenDoc'
      end>
    UseOwnFont = False
    Left = 412
    Top = 244
    PixelsPerInch = 120
  end
  object IBCDataSourceInvent: TIBCDataSource
    DataSet = IBCQueryInvent
    Left = 696
    Top = 96
  end
  object IBCQueryInvent: TIBCQuery
    SQLInsert.Strings = (
      'INSERT INTO VW_TDB_DOCS_INVENT'
      
        '  (DOCID, GOODSID, GOODSNAME, IMAGE_INDEX, BALANCE_QTY, REZERV_Q' +
        'TY, REAL_QTY, COMMENT)'
      'VALUES'
      
        '  (:DOCID, :GOODSID, :GOODSNAME, :IMAGE_INDEX, :BALANCE_QTY, :RE' +
        'ZERV_QTY, :REAL_QTY, :COMMENT)')
    SQLDelete.Strings = (
      'DELETE FROM VW_TDB_DOCS_INVENT'
      'WHERE'
      '  DOCID = :Old_DOCID AND GOODSID = :Old_GOODSID')
    SQLUpdate.Strings = (
      'UPDATE VW_TDB_DOCS_INVENT'
      'SET'
      
        '  DOCID = :DOCID, GOODSID = :GOODSID, GOODSNAME = :GOODSNAME, IM' +
        'AGE_INDEX = :IMAGE_INDEX, BALANCE_QTY = :BALANCE_QTY, REZERV_QTY' +
        ' = :REZERV_QTY, REAL_QTY = :REAL_QTY, COMMENT = :COMMENT'
      'WHERE'
      '  DOCID = :Old_DOCID AND GOODSID = :Old_GOODSID')
    SQLRefresh.Strings = (
      
        'SELECT DOCID, GOODSID, GOODSNAME, IMAGE_INDEX, BALANCE_QTY, REZE' +
        'RV_QTY, REAL_QTY, COMMENT FROM VW_TDB_DOCS_INVENT'
      'WHERE'
      '  DOCID = :DOCID AND GOODSID = :GOODSID')
    SQLLock.Strings = (
      'SELECT NULL FROM TDB_DOCS_INVENT'
      'WHERE'
      'DOCID = :Old_DOCID AND GOODSID = :Old_GOODSID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM VW_TDB_DOCS_INVENT'
      ''
      ') q')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'select * from vw_tdb_docs_invent')
    MasterFields = 'DOCID'
    DetailFields = 'DOCID'
    MasterSource = dmDB.IBCDataSourceDocs
    RefreshOptions = [roAfterUpdate]
    Left = 800
    Top = 96
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DOCID'
        Value = nil
      end>
  end
  object ActionList1: TActionList
    Images = dmAdditions.cxImageList_SWN
    Left = 150
    Top = 150
    object dxSpreadSheetNewDocument: TdxSpreadSheetNewDocument
      Category = 'DevExpress ExpressSpreadSheet.File.Common'
    end
    object dxSpreadSheetOpenDocument: TdxSpreadSheetOpenDocument
      Category = 'DevExpress ExpressSpreadSheet.File.Common'
    end
    object dxSpreadSheetSaveDocumentAs: TdxSpreadSheetSaveDocumentAs
      Category = 'DevExpress ExpressSpreadSheet.File.Common'
    end
    object dxSpreadSheetShowPrintForm: TdxSpreadSheetShowPrintForm
      Category = 'DevExpress ExpressSpreadSheet.File.Print'
    end
    object dxSpreadSheetShowPrintPreviewForm: TdxSpreadSheetShowPrintPreviewForm
      Category = 'DevExpress ExpressSpreadSheet.File.Print'
    end
    object dxSpreadSheetShowPageSetupForm: TdxSpreadSheetShowPageSetupForm
      Category = 'DevExpress ExpressSpreadSheet.File.Print'
    end
    object dxSpreadSheetPasteSelection: TdxSpreadSheetPasteSelection
      Category = 'DevExpress ExpressSpreadSheet.Home.Clipboard'
    end
    object dxSpreadSheetCutSelection: TdxSpreadSheetCutSelection
      Category = 'DevExpress ExpressSpreadSheet.Home.Clipboard'
    end
    object dxSpreadSheetCopySelection: TdxSpreadSheetCopySelection
      Category = 'DevExpress ExpressSpreadSheet.Home.Clipboard'
    end
    object dxSpreadSheetChangeFontName: TdxSpreadSheetChangeFontName
      Category = 'DevExpress ExpressSpreadSheet.Home.Font'
    end
    object dxSpreadSheetChangeFontSize: TdxSpreadSheetChangeFontSize
      Category = 'DevExpress ExpressSpreadSheet.Home.Font'
    end
    object dxSpreadSheetIncreaseFontSize: TdxSpreadSheetIncreaseFontSize
      Category = 'DevExpress ExpressSpreadSheet.Home.Font'
    end
    object dxSpreadSheetDecreaseFontSize: TdxSpreadSheetDecreaseFontSize
      Category = 'DevExpress ExpressSpreadSheet.Home.Font'
    end
    object dxSpreadSheetToggleFontBold: TdxSpreadSheetToggleFontBold
      Category = 'DevExpress ExpressSpreadSheet.Home.Font'
    end
    object dxSpreadSheetToggleFontItalic: TdxSpreadSheetToggleFontItalic
      Category = 'DevExpress ExpressSpreadSheet.Home.Font'
    end
    object dxSpreadSheetToggleFontUnderline: TdxSpreadSheetToggleFontUnderline
      Category = 'DevExpress ExpressSpreadSheet.Home.Font'
    end
    object dxSpreadSheetToggleFontStrikeout: TdxSpreadSheetToggleFontStrikeout
      Category = 'DevExpress ExpressSpreadSheet.Home.Font'
    end
    object dxSpreadSheetBordersBottom: TdxSpreadSheetBordersBottom
      Category = 'DevExpress ExpressSpreadSheet.Home.Font'
    end
    object dxSpreadSheetBordersTop: TdxSpreadSheetBordersTop
      Category = 'DevExpress ExpressSpreadSheet.Home.Font'
    end
    object dxSpreadSheetBordersLeft: TdxSpreadSheetBordersLeft
      Category = 'DevExpress ExpressSpreadSheet.Home.Font'
    end
    object dxSpreadSheetBordersRight: TdxSpreadSheetBordersRight
      Category = 'DevExpress ExpressSpreadSheet.Home.Font'
    end
    object dxSpreadSheetBordersNone: TdxSpreadSheetBordersNone
      Category = 'DevExpress ExpressSpreadSheet.Home.Font'
    end
    object dxSpreadSheetBordersAll: TdxSpreadSheetBordersAll
      Category = 'DevExpress ExpressSpreadSheet.Home.Font'
    end
    object dxSpreadSheetBordersOutside: TdxSpreadSheetBordersOutside
      Category = 'DevExpress ExpressSpreadSheet.Home.Font'
    end
    object dxSpreadSheetBordersOutsideThick: TdxSpreadSheetBordersOutsideThick
      Category = 'DevExpress ExpressSpreadSheet.Home.Font'
    end
    object dxSpreadSheetBordersBottomDouble: TdxSpreadSheetBordersBottomDouble
      Category = 'DevExpress ExpressSpreadSheet.Home.Font'
    end
    object dxSpreadSheetBordersBottomThick: TdxSpreadSheetBordersBottomThick
      Category = 'DevExpress ExpressSpreadSheet.Home.Font'
    end
    object dxSpreadSheetBordersTopAndBottom: TdxSpreadSheetBordersTopAndBottom
      Category = 'DevExpress ExpressSpreadSheet.Home.Font'
    end
    object dxSpreadSheetBordersTopAndBottomThick: TdxSpreadSheetBordersTopAndBottomThick
      Category = 'DevExpress ExpressSpreadSheet.Home.Font'
    end
    object dxSpreadSheetBordersTopAndBottomDouble: TdxSpreadSheetBordersTopAndBottomDouble
      Category = 'DevExpress ExpressSpreadSheet.Home.Font'
    end
    object dxSpreadSheetBordersMore: TdxSpreadSheetBordersMore
      Category = 'DevExpress ExpressSpreadSheet.Home.Font'
    end
    object dxSpreadSheetChangeFillColor: TdxSpreadSheetChangeFillColor
      Category = 'DevExpress ExpressSpreadSheet.Home.Font'
    end
    object dxSpreadSheetChangeFontColor: TdxSpreadSheetChangeFontColor
      Category = 'DevExpress ExpressSpreadSheet.Home.Font'
    end
    object dxSpreadSheetAlignVerticalTop: TdxSpreadSheetAlignVerticalTop
      Category = 'DevExpress ExpressSpreadSheet.Home.Alignment'
    end
    object dxSpreadSheetAlignVerticalCenter: TdxSpreadSheetAlignVerticalCenter
      Category = 'DevExpress ExpressSpreadSheet.Home.Alignment'
    end
    object dxSpreadSheetAlignVerticalBottom: TdxSpreadSheetAlignVerticalBottom
      Category = 'DevExpress ExpressSpreadSheet.Home.Alignment'
    end
    object dxSpreadSheetAlignHorizontalLeft: TdxSpreadSheetAlignHorizontalLeft
      Category = 'DevExpress ExpressSpreadSheet.Home.Alignment'
    end
    object dxSpreadSheetAlignHorizontalCenter: TdxSpreadSheetAlignHorizontalCenter
      Category = 'DevExpress ExpressSpreadSheet.Home.Alignment'
    end
    object dxSpreadSheetAlignHorizontalRight: TdxSpreadSheetAlignHorizontalRight
      Category = 'DevExpress ExpressSpreadSheet.Home.Alignment'
    end
    object dxSpreadSheetTextIndentDecrease: TdxSpreadSheetTextIndentDecrease
      Category = 'DevExpress ExpressSpreadSheet.Home.Alignment'
    end
    object dxSpreadSheetTextIndentIncrease: TdxSpreadSheetTextIndentIncrease
      Category = 'DevExpress ExpressSpreadSheet.Home.Alignment'
    end
    object dxSpreadSheetTextWrap: TdxSpreadSheetTextWrap
      Category = 'DevExpress ExpressSpreadSheet.Home.Alignment'
    end
    object dxSpreadSheetMergeCellsAndCenter: TdxSpreadSheetMergeCellsAndCenter
      Category = 'DevExpress ExpressSpreadSheet.Home.Alignment'
    end
    object dxSpreadSheetMergeCellsAcross: TdxSpreadSheetMergeCellsAcross
      Category = 'DevExpress ExpressSpreadSheet.Home.Alignment'
    end
    object dxSpreadSheetMergeCells: TdxSpreadSheetMergeCells
      Category = 'DevExpress ExpressSpreadSheet.Home.Alignment'
    end
    object dxSpreadSheetUnmergeCells: TdxSpreadSheetUnmergeCells
      Category = 'DevExpress ExpressSpreadSheet.Home.Alignment'
    end
    object dxSpreadSheetInsertRows: TdxSpreadSheetInsertRows
      Category = 'DevExpress ExpressSpreadSheet.Home.Cells'
    end
    object dxSpreadSheetInsertColumns: TdxSpreadSheetInsertColumns
      Category = 'DevExpress ExpressSpreadSheet.Home.Cells'
    end
    object dxSpreadSheetInsertSheet: TdxSpreadSheetInsertSheet
      Category = 'DevExpress ExpressSpreadSheet.Home.Cells'
    end
    object dxSpreadSheetDeleteRows: TdxSpreadSheetDeleteRows
      Category = 'DevExpress ExpressSpreadSheet.Home.Cells'
    end
    object dxSpreadSheetDeleteColumns: TdxSpreadSheetDeleteColumns
      Category = 'DevExpress ExpressSpreadSheet.Home.Cells'
    end
    object dxSpreadSheetDeleteSheet: TdxSpreadSheetDeleteSheet
      Category = 'DevExpress ExpressSpreadSheet.Home.Cells'
    end
    object dxSpreadSheetAutoFitRowHeight: TdxSpreadSheetAutoFitRowHeight
      Category = 'DevExpress ExpressSpreadSheet.Home.Cells'
    end
    object dxSpreadSheetAutoFitColumnWidth: TdxSpreadSheetAutoFitColumnWidth
      Category = 'DevExpress ExpressSpreadSheet.Home.Cells'
    end
    object dxSpreadSheetHideRows: TdxSpreadSheetHideRows
      Category = 'DevExpress ExpressSpreadSheet.Home.Cells'
    end
    object dxSpreadSheetHideColumns: TdxSpreadSheetHideColumns
      Category = 'DevExpress ExpressSpreadSheet.Home.Cells'
    end
    object dxSpreadSheetHideSheet: TdxSpreadSheetHideSheet
      Category = 'DevExpress ExpressSpreadSheet.Home.Cells'
    end
    object dxSpreadSheetUnhideRows: TdxSpreadSheetUnhideRows
      Category = 'DevExpress ExpressSpreadSheet.Home.Cells'
    end
    object dxSpreadSheetUnhideColumns: TdxSpreadSheetUnhideColumns
      Category = 'DevExpress ExpressSpreadSheet.Home.Cells'
    end
    object dxSpreadSheetUnhideSheet: TdxSpreadSheetUnhideSheet
      Category = 'DevExpress ExpressSpreadSheet.Home.Cells'
    end
    object dxSpreadSheetClearAll: TdxSpreadSheetClearAll
      Category = 'DevExpress ExpressSpreadSheet.Home.Editing'
    end
    object dxSpreadSheetClearFormats: TdxSpreadSheetClearFormats
      Category = 'DevExpress ExpressSpreadSheet.Home.Editing'
    end
    object dxSpreadSheetClearContents: TdxSpreadSheetClearContents
      Category = 'DevExpress ExpressSpreadSheet.Home.Editing'
    end
    object dxSpreadSheetUndo: TdxSpreadSheetUndo
      Category = 'DevExpress ExpressSpreadSheet.Home.Editing'
    end
    object dxSpreadSheetRedo: TdxSpreadSheetRedo
      Category = 'DevExpress ExpressSpreadSheet.Home.Editing'
    end
    object dxSpreadSheetFindAndReplace: TdxSpreadSheetFindAndReplace
      Category = 'DevExpress ExpressSpreadSheet.Home.Editing'
    end
    object dxSpreadSheetInsertPicture: TdxSpreadSheetInsertPicture
      Category = 'DevExpress ExpressSpreadSheet.Insert.Illustrations'
    end
    object dxSpreadSheetShowHyperlinkEditor: TdxSpreadSheetShowHyperlinkEditor
      Category = 'DevExpress ExpressSpreadSheet.Insert.Links'
    end
    object dxSpreadSheetPageMarginsGallery: TdxSpreadSheetPageMarginsGallery
      Category = 'DevExpress ExpressSpreadSheet.Page Layout.Page Setup'
    end
    object dxSpreadSheetMorePageMargins: TdxSpreadSheetMorePageMargins
      Category = 'DevExpress ExpressSpreadSheet.Page Layout.Page Setup'
    end
    object dxSpreadSheetSetPortraitPageOrientation: TdxSpreadSheetSetPortraitPageOrientation
      Category = 'DevExpress ExpressSpreadSheet.Page Layout.Page Setup'
    end
    object dxSpreadSheetSetLandscapePageOrientation: TdxSpreadSheetSetLandscapePageOrientation
      Category = 'DevExpress ExpressSpreadSheet.Page Layout.Page Setup'
    end
    object dxSpreadSheetPaperSizeGallery: TdxSpreadSheetPaperSizeGallery
      Category = 'DevExpress ExpressSpreadSheet.Page Layout.Page Setup'
    end
    object dxSpreadSheetMorePaperSizes: TdxSpreadSheetMorePaperSizes
      Category = 'DevExpress ExpressSpreadSheet.Page Layout.Page Setup'
    end
    object dxSpreadSheetSetPrintArea: TdxSpreadSheetSetPrintArea
      Category = 'DevExpress ExpressSpreadSheet.Page Layout.Page Setup'
    end
    object dxSpreadSheetClearPrintArea: TdxSpreadSheetClearPrintArea
      Category = 'DevExpress ExpressSpreadSheet.Page Layout.Page Setup'
    end
    object dxSpreadSheetInsertPageBreak: TdxSpreadSheetInsertPageBreak
      Category = 'DevExpress ExpressSpreadSheet.Page Layout.Page Setup'
    end
    object dxSpreadSheetRemovePageBreak: TdxSpreadSheetRemovePageBreak
      Category = 'DevExpress ExpressSpreadSheet.Page Layout.Page Setup'
    end
    object dxSpreadSheetResetAllPageBreaks: TdxSpreadSheetResetAllPageBreaks
      Category = 'DevExpress ExpressSpreadSheet.Page Layout.Page Setup'
    end
    object dxSpreadSheetPrintTitles: TdxSpreadSheetPrintTitles
      Category = 'DevExpress ExpressSpreadSheet.Page Layout.Page Setup'
    end
    object dxSpreadSheetAutoSumGallery: TdxSpreadSheetAutoSumGallery
      Category = 'DevExpress ExpressSpreadSheet.Formulas.Function Library'
    end
    object dxSpreadSheetFinancialFormulasGallery: TdxSpreadSheetFinancialFormulasGallery
      Category = 'DevExpress ExpressSpreadSheet.Formulas.Function Library'
    end
    object dxSpreadSheetLogicalFormulasGallery: TdxSpreadSheetLogicalFormulasGallery
      Category = 'DevExpress ExpressSpreadSheet.Formulas.Function Library'
    end
    object dxSpreadSheetTextFormulasGallery: TdxSpreadSheetTextFormulasGallery
      Category = 'DevExpress ExpressSpreadSheet.Formulas.Function Library'
    end
    object dxSpreadSheetDateAndTimeFormulasGallery: TdxSpreadSheetDateAndTimeFormulasGallery
      Category = 'DevExpress ExpressSpreadSheet.Formulas.Function Library'
    end
    object dxSpreadSheetLookupAndReferenceFormulasGallery: TdxSpreadSheetLookupAndReferenceFormulasGallery
      Category = 'DevExpress ExpressSpreadSheet.Formulas.Function Library'
    end
    object dxSpreadSheetMathAndTrigFormulasGallery: TdxSpreadSheetMathAndTrigFormulasGallery
      Category = 'DevExpress ExpressSpreadSheet.Formulas.Function Library'
    end
    object dxSpreadSheetStatisticalFormulasGallery: TdxSpreadSheetStatisticalFormulasGallery
      Category = 'DevExpress ExpressSpreadSheet.Formulas.Function Library'
    end
    object dxSpreadSheetInformationFormulasGallery: TdxSpreadSheetInformationFormulasGallery
      Category = 'DevExpress ExpressSpreadSheet.Formulas.Function Library'
    end
    object dxSpreadSheetCompatibilityFormulasGallery: TdxSpreadSheetCompatibilityFormulasGallery
      Category = 'DevExpress ExpressSpreadSheet.Formulas.Function Library'
    end
    object dxSpreadSheetSortAscending: TdxSpreadSheetSortAscending
      Category = 'DevExpress ExpressSpreadSheet.Data.Sort Filter'
    end
    object dxSpreadSheetSortDescending: TdxSpreadSheetSortDescending
      Category = 'DevExpress ExpressSpreadSheet.Data.Sort Filter'
    end
    object dxSpreadSheetGroupColumns: TdxSpreadSheetGroupColumns
      Category = 'DevExpress ExpressSpreadSheet.Data.Grouping'
    end
    object dxSpreadSheetGroupRows: TdxSpreadSheetGroupRows
      Category = 'DevExpress ExpressSpreadSheet.Data.Grouping'
    end
    object dxSpreadSheetUngroupColumns: TdxSpreadSheetUngroupColumns
      Category = 'DevExpress ExpressSpreadSheet.Data.Grouping'
    end
    object dxSpreadSheetUngroupRows: TdxSpreadSheetUngroupRows
      Category = 'DevExpress ExpressSpreadSheet.Data.Grouping'
    end
    object dxSpreadSheetNewComment: TdxSpreadSheetNewComment
      Category = 'DevExpress ExpressSpreadSheet.Review.Comments'
    end
    object dxSpreadSheetEditComment: TdxSpreadSheetEditComment
      Category = 'DevExpress ExpressSpreadSheet.Review.Comments'
    end
    object dxSpreadSheetDeleteComments: TdxSpreadSheetDeleteComments
      Category = 'DevExpress ExpressSpreadSheet.Review.Comments'
    end
    object dxSpreadSheetPreviousComment: TdxSpreadSheetPreviousComment
      Category = 'DevExpress ExpressSpreadSheet.Review.Comments'
    end
    object dxSpreadSheetNextComment: TdxSpreadSheetNextComment
      Category = 'DevExpress ExpressSpreadSheet.Review.Comments'
    end
    object dxSpreadSheetShowHideComments: TdxSpreadSheetShowHideComments
      Category = 'DevExpress ExpressSpreadSheet.Review.Comments'
    end
    object dxSpreadSheetProtectSheet: TdxSpreadSheetProtectSheet
      Category = 'DevExpress ExpressSpreadSheet.Review.Changes'
    end
    object dxSpreadSheetProtectWorkbook: TdxSpreadSheetProtectWorkbook
      Category = 'DevExpress ExpressSpreadSheet.Review.Changes'
    end
    object dxSpreadSheetZoomOut: TdxSpreadSheetZoomOut
      Category = 'DevExpress ExpressSpreadSheet.View.Zoom'
    end
    object dxSpreadSheetZoomIn: TdxSpreadSheetZoomIn
      Category = 'DevExpress ExpressSpreadSheet.View.Zoom'
    end
    object dxSpreadSheetZoomDefault: TdxSpreadSheetZoomDefault
      Category = 'DevExpress ExpressSpreadSheet.View.Zoom'
    end
    object dxSpreadSheetFreezePanes: TdxSpreadSheetFreezePanes
      Category = 'DevExpress ExpressSpreadSheet.View.Freeze Panes'
    end
    object dxSpreadSheetUnfreezePanes: TdxSpreadSheetUnfreezePanes
      Category = 'DevExpress ExpressSpreadSheet.View.Freeze Panes'
    end
    object dxSpreadSheetFreezeTopRow: TdxSpreadSheetFreezeTopRow
      Category = 'DevExpress ExpressSpreadSheet.View.Freeze Panes'
    end
    object dxSpreadSheetFreezeFirstColumn: TdxSpreadSheetFreezeFirstColumn
      Category = 'DevExpress ExpressSpreadSheet.View.Freeze Panes'
    end
    object dxSpreadSheetConditionalFormattingTopBottomRulesGallery: TdxSpreadSheetConditionalFormattingTopBottomRulesGallery
      Category = 'DevExpress ExpressSpreadSheet.Home.Conditional Formatting'
    end
    object dxSpreadSheetConditionalFormattingMoreRules: TdxSpreadSheetConditionalFormattingMoreRules
      Category = 'DevExpress ExpressSpreadSheet.Home.Conditional Formatting'
    end
    object dxSpreadSheetConditionalFormattingDataBarsGallery: TdxSpreadSheetConditionalFormattingDataBarsGallery
      Category = 'DevExpress ExpressSpreadSheet.Home.Conditional Formatting'
    end
    object dxSpreadSheetConditionalFormattingColorScalesGallery: TdxSpreadSheetConditionalFormattingColorScalesGallery
      Category = 'DevExpress ExpressSpreadSheet.Home.Conditional Formatting'
    end
    object dxSpreadSheetConditionalFormattingIconSetsGallery: TdxSpreadSheetConditionalFormattingIconSetsGallery
      Category = 'DevExpress ExpressSpreadSheet.Home.Conditional Formatting'
    end
    object dxSpreadSheetConditionalFormattingNewRule: TdxSpreadSheetConditionalFormattingNewRule
      Category = 'DevExpress ExpressSpreadSheet.Home.Conditional Formatting'
    end
    object dxSpreadSheetConditionalFormattingClearRulesFromSelectedCells: TdxSpreadSheetConditionalFormattingClearRulesFromSelectedCells
      Category = 'DevExpress ExpressSpreadSheet.Home.Conditional Formatting'
    end
    object dxSpreadSheetConditionalFormattingClearRulesFromEntireSheet: TdxSpreadSheetConditionalFormattingClearRulesFromEntireSheet
      Category = 'DevExpress ExpressSpreadSheet.Home.Conditional Formatting'
    end
    object dxSpreadSheetShowConditionalFormattingRulesManager: TdxSpreadSheetShowConditionalFormattingRulesManager
      Category = 'DevExpress ExpressSpreadSheet.Home.Conditional Formatting'
    end
    object dxSpreadSheetReportDesignerSingleSheetReportMode: TdxSpreadSheetReportDesignerSingleSheetReportMode
      Category = 'DevExpress ExpressSpreadSheet.Report.Mode'
    end
    object dxSpreadSheetReportDesignerMultipleSheetsReportMode: TdxSpreadSheetReportDesignerMultipleSheetsReportMode
      Category = 'DevExpress ExpressSpreadSheet.Report.Mode'
    end
    object dxSpreadSheetReportDesignerMultipleDocumentsReportMode: TdxSpreadSheetReportDesignerMultipleDocumentsReportMode
      Category = 'DevExpress ExpressSpreadSheet.Report.Mode'
    end
    object dxSpreadSheetReportDesignerHorizontalOrientation: TdxSpreadSheetReportDesignerHorizontalOrientation
      Category = 'DevExpress ExpressSpreadSheet.Report.Mode'
    end
    object dxSpreadSheetReportDesignerVerticalOrientation: TdxSpreadSheetReportDesignerVerticalOrientation
      Category = 'DevExpress ExpressSpreadSheet.Report.Mode'
    end
    object dxSpreadSheetReportDesignerHeaderSection: TdxSpreadSheetReportDesignerHeaderSection
      Category = 'DevExpress ExpressSpreadSheet.Report.Template Sections'
    end
    object dxSpreadSheetReportDesignerFooterSection: TdxSpreadSheetReportDesignerFooterSection
      Category = 'DevExpress ExpressSpreadSheet.Report.Template Sections'
    end
    object dxSpreadSheetReportDesignerDetailSection: TdxSpreadSheetReportDesignerDetailSection
      Category = 'DevExpress ExpressSpreadSheet.Report.Template Sections'
    end
    object dxSpreadSheetReportDesignerDetailLevel: TdxSpreadSheetReportDesignerDetailLevel
      Category = 'DevExpress ExpressSpreadSheet.Report.Template Sections'
    end
    object dxSpreadSheetReportDesignerDataMember: TdxSpreadSheetReportDesignerDataMember
      Category = 'DevExpress ExpressSpreadSheet.Report.Template Sections'
    end
    object dxSpreadSheetReportDesignerResetSection: TdxSpreadSheetReportDesignerResetSection
      Category = 'DevExpress ExpressSpreadSheet.Report.Template Sections'
    end
    object dxSpreadSheetReportDesignerSortFields: TdxSpreadSheetReportDesignerSortFields
      Category = 'DevExpress ExpressSpreadSheet.Report.Sort & Group'
    end
    object dxSpreadSheetReportDesignerGroupHeaderSection: TdxSpreadSheetReportDesignerGroupHeaderSection
      Category = 'DevExpress ExpressSpreadSheet.Report.Sort & Group'
    end
    object dxSpreadSheetReportDesignerGroupFooterSection: TdxSpreadSheetReportDesignerGroupFooterSection
      Category = 'DevExpress ExpressSpreadSheet.Report.Sort & Group'
    end
    object dxSpreadSheetReportDesignerEditFilter: TdxSpreadSheetReportDesignerEditFilter
      Category = 'DevExpress ExpressSpreadSheet.Report.Filter'
    end
    object dxSpreadSheetReportDesignerResetFilter: TdxSpreadSheetReportDesignerResetFilter
      Category = 'DevExpress ExpressSpreadSheet.Report.Filter'
    end
    object dxSpreadSheetReportDesignerDesignView: TdxSpreadSheetReportDesignerDesignView
      Category = 'DevExpress ExpressSpreadSheet.Report.Design'
    end
    object dxSpreadSheetReportDesignerReportPreview: TdxSpreadSheetReportDesignerReportPreview
      Category = 'DevExpress ExpressSpreadSheet.Report.Design'
    end
  end
  object cxImageList1: TcxImageList
    SourceDPI = 96
    Height = 32
    Width = 32
    FormatVersion = 1
    DesignInfo = 9830550
    ImageInfo = <
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F40000003D744558745469746C65004E65773B506167653B426172733B526962
          626F6E3B5374616E646172643B4974656D3B426C616E6B3B44656661756C743B
          456D7074793B130452ED0000044B49444154785E8D96C18B1C5510C67FF57A67
          374ACCC1BB1004357A13518946C322A2070FC6631045C553401272301B2389EB
          12730988A82725E049443D8888205EC41C55FC030435F76020D99D99EE579F30
          FBE8A21FEBD875E937CD63EAFBEAFBAAAA4D12664609BBF2E52F3F5AB2750432
          308100240C43080106088140E52E1200376EDC7CF7F4EBEB9B80037AFFCA5521
          47C0A9579FA004925821C20033B3F5978F3DC89898CF3BDAEC746D66D676ECEC
          745CBFB1C3F6B47DFBBD8FBEB78D13CF6E02F9E42B8FF3E7B5EBFAE2BBDFA963
          856198CA216781F550C1403228CC01BC5C9619C2C812577FFD8B132F1E667BA7
          3D77FEF2B7F6CEE9E73681EEE05D77B2F5C10FFA5F0048E5A83E773C053D0848
          4D02849A444EBBE7D9BC05E0F04307C9EE6F9DB9F8B55D3AFBC202C4B9379E76
          4044906A005E320AC36548068109A1384BA49448C9B0C610C66CDA02D0348923
          0FDFCD91470E9D3D75FEF3F3C0A4E4B325120465490091DB29323094011620CC
          0CB998CEE600AC24C3481C7DEC5E3AF78DD999CFF8F8D24B9B404B31E79E12B8
          8850A41216B2F438034C32C33066B3163358698C948CA611CF1C3D84E7BC316F
          3FE593CBAF5D00B417000B0004D348022A254080A1FEE26EF2C95AC381FD6B9C
          BCF015AE6851104F1DB98FFB1FB86703D802F27F77813B83222B40800208EAE5
          74775263DCB66F95E3C71EE5E6F67461C6DC892E3B6D97690CFEF8FB1F806699
          0742FB017B3029DE116512600660AC4D1A9A03FBB863FF1A6D76729B1700BA2E
          930CFCB76B7DA501967AC045B094702210084505CA1D33589D34B8C4440D79B5
          212F0695B3D280E344F2251244E90384243008F2460FA3A81263C4768D98526F
          AF496378C75200C5840E3048283C5AB1EA08045E9E618F90275942C91760DC47
          54C07D20312A220FCB2254CF8E408B145A4990CC1626D558090034184AB115D5
          838855290D21A93A489052C2B3C69830920AAA320FD3C80BEFF049AC6A510112
          AE02202457ED818252833F2BA022025C0166544D5379C19018E7014903091C0B
          D695B60A6F20823A026430DC6364A78F25126404C8850C4CEA5985A8A09E2AF1
          CEB4C7500B49A5111EC859E554B718F56E08F68A0E88A6102A5AA848EA798C04
          1980582650758585D1E27789EAC3A5FA7E7069C420F21C43254C0510C9AABD10
          C0544DD00025969830BE8CEB360C2016BBB0EE84F043241C864A5789BD3D6066
          1693502892812C24B1C8AA600C103BA1DA9E04C8716D1815302455A50CA6A266
          1CFD1EDB23ECE0121AE381EC2A9A3951F8929C605BAFE5D2B3A8BA208A1925DC
          19B38C0A43EF6709523D86EB155D253651C8122A8D5B46C81DD0D0EDAA7B3F60
          E0258F14E464C844A02A1528E4960D222F26E4C0ED93FAC304C9064082750055
          4CCEC85FF4C7059001ED05C081763ADBFEE9CD8BDF3C6903F6EAF5AEAB11722B
          26A057E3B8C4747AEB676006780D40E5E5CE875BC79F07D680267AB68AEADD88
          3B2ACCA7C0AD72562D818039D0954B63128F8F20E92101FC0B32FB73B52588D6
          410000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F40000002B744558745469746C65004F70656E3B466F6C6465723B426172733B
          526962626F6E3B5374616E646172643B4C6F6164F1C3C4630000054249444154
          785EE597DF8B5D5715C73FFBCC9D4CDBA4650C6DD334516223452CD81A8B208A
          587D50109F2A2DD42789885450FF8116F441F4455A141F2CEA836FFAD23C444B
          25A4A5A57D504A29D8265183CEA493CCDCCECCFD79EEB9E7ECB5BE827B73CEE5
          1221948A0F5DB0D86B9F75EFFE7ED777AD7DE0F424F1FFB41EF03E2710420008
          DC9889F7C824B50A04A0C8BE6CA103C6B3EBBD6E41F1C2539FFBC2FAA1D51F15
          213C48362D0593B279EC33DF7DF1F780BDFECB2FE6B49002A0657D902020A42E
          7DEA3BE7AF4F60FDE0EA6F4F7EE97B470EDE797211BA8DE36CC485677FF2F453
          8F7FFCC5EFFFE28D9D07BE75CEDF8DEAEDBA4C40AE23878EDE07CD859457565C
          295EEDF5B8FBD4E7EFF8D4F0CC4F81D3C08D10084BE096DDF3BE9B0139204F8E
          72BCB8361C3E71827B1F7AF8D13FFF8C47176B51A7F9624BBA3A80687A6D6BAF
          7AE2911FFFE51CD02C13409E81644BC0DE7A50CDE10F1EE5F0E91F4071DBF55A
          F55F9F8DB72E9FE2773FFF0DF061202EB72078F4F4DC6D1918DC01CF246BA887
          600E18F294975BFEADA5D81773915B6EBE0BCCEF5CBC69218405029E41F341CB
          04945794C0526CC80C3CAF6A5A022D293324C3572AEA2A02AC6412CA9E099812
          B8C7EB82A2AE223C1D8A3528CE515323ABD37F2D91F14C4216913B856E66BC3F
          03B80970A0C9ABF500DC048AC82264095106CA7B99779567F0663AE2ED7F6C32
          D89D800B1072474A2BAE14EB22A8E4CCE3F75C13C2C534463DFBC833FFFC463B
          0356576836451EA1AB2AED2D1172F3F4CC1A46FD5D76B66B8E7DFA313E72F2C1
          4E55D18D3FDEC692B7FBE9DEB583CFFFF09B9F058ADC0227CE4A6C5AA27AC6B8
          BFC53B57AE32AF1AC8D54810DC900B97583FF1093EFAF0D759E941F3F69FD07C
          84A4A45248D57B3B478667F5280EB0F9E6DFA86A3F07A8552056639AD110ABA6
          6C5DDAE0635F7B92B55B6F2799B2D3DE1297A3D916CDD53720D6480958AEC539
          CAE4AD1BD05E60E7D26546657CAE2360A29E8CA98623A6BB3BACDE7637070EDE
          4A73E58F283659DADC53940E0270C7597C7F2801C9F16E9612E16880F0067636
          AE5567FF3A3E0F780F08D618F3F188D960C8E05A9F3B1EF8249AF5F17909A8AB
          4A8900EA6E89502296C01270CEE111CFABDC2114F4AF5CA52A9B97CEBE359A66
          05C01A518D87947B23C67B53EE3D7E029B6CA6EA9501255C960E4648DE0207AC
          AD58128A31C96FD65E6179030A6CFF7D834965CF03DEBD071AA31A0E18EFED53
          AC1EE0964337515D7E19B9137A6B84A28703215F31296670476E2813C30C57EE
          B5722ED678AC913514BD35B63776B9D49F3F07583B03B13166C301A3FE8023F7
          DD8F953BD8640F2124501021AC127A0740052A8A549D2717069600DD1A880D8A
          CD7F62E59B2002E3FD8AF1B0BAF8F4ABBBFF02D4295047CAFD01E5A4E4F0F163
          34C34D2CD6597A4086790972DCE97A1C423B071E230143DEB62CB90B700281FE
          C68849A5F3E4EA7FFDD5634981BA71CAC1008FF081BBD669FA17F07ADE1D2243
          2690B787E36DDC8228934142D9C96D0B2B05BBDB13F6CAF80AE080E4A2071475
          658CDFD965FDE8ED508F68867D641170DC32901C39045956458B37A1DD07D1CA
          EE0894DC63417FBB9A9FB9347E212B807B6A81628C54E309F7DCFF219AC1165E
          579D94D9C995AA93372B026028D584210A0997C84962E30C76E78C67F6EAEBDB
          D504D0335F3E2A941468E635AFADAE71EACD972FF2D64B179080E0B8070200BE
          F09A6F030864F901D42903D0C6C25D5473DB7F656BF62450035EAC14E421A4FC
          F61F361F02D68062F91B6179FF2E72CA92CF8119D0FCEA2BC71DD41288400954
          DCB8056EDC58FEAE387DF60A5247C05B96FF7B134BD6CB4CF4BEFD38FD379B7D
          158A0D532ADA0000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F400000012744558745469746C6500536176652041733B536176659559E8FB00
          0004CE49444154785EB5563DA85C5510FECEBD77133769552468DA0856428A28
          1606EDAC443B2B41B05141C49FA06291C2460CD80A29B5B037162952050988A0
          A41551448DC4F0F2765F76F7CC7C23CC19CE79D7FBD6F0500F9C3D67877D33DF
          FDBE6FE6BE646638EC4A29D56B3D7D4FD796B80120001BF0EF563AFFC9E5CB29
          E1AC67B592DAFCC33FE3EEE1729AC154AF9C7FEB99A70170684F74F8E24E0670
          F6DD579EC261D6FB1F5D7A1240E700B6D07537448C043D43C23B6BADECEE5735
          AE9585234302490480348C8BA38FC4E96E3A466C20194582DE042424A7DEAA2E
          A9498204D26ACE617FF1D7CE5FFC6098CDCEC1D01B80EBD7AE61E7E69F78F0E4
          433873E6512F40D213882A44B2C76040C02877A3A76C6C58602834283901E094
          F4C370EE89D38FF4A94BE8BB0E572F7D85E3C73798CFEFC1F32F3C17C68A24AA
          C87983CF3FBB5AEAB20A10A59BF3CCD2C88CA61540DACF4047654F037EFAF906
          72D6EA5A1AFD6C00CC59A0126A1CD1ED6765BEC48322582A77B52641377296AA
          A3DBDDDD8379E25258443CA36B4C03E9C09C05D22AD0FA94D18A2446DFC1F001
          792080442AC41446058C3591AA800E203619DBEFA1732B143B62112924FCA307
          0AA5A24E2BA5FDA1889662D6B692C89BECA779A1A90CFE10295586EA08549B78
          C00354854A01C15E019A6F15011980FCBB62BDB7C29D3B6B18E971561A006B29
          61360A840778601B265181840FE8E8CD4F910C11F527CE3957A6242B94569F2E
          CEC9204AAD138A4CBA550285A840DD035A440B132E769640757BD00E8264A3B8
          7A20456573EB7BB9E68B606B0A20A908D46550D7E9DE07EEC78DDF7E07BA15DE
          7EE31D1846467460274E3E0CE25998351FC021041355FB460BD93C3035615607
          B1DE649C7EFC3120E600C84288862CAAD8ACD6008EB5361C29DD24698C44A76C
          E9822459B0C98585C562D99292500392596D47754FAC309B0D1E9B1F1D70D0B2
          D147DA3F886CEA0191A05FEBD0292C12C6364CE8520836EB1556CB9B78E9D50B
          E336742FB076C4301B70FBD62DDC77E254786A7D054006C0310322909C1D44B4
          5C2B1AA3988893445EAD2179514CCBA6BFD5DF95EFF3F931FCF1EB0FF8F28B0F
          4F01B80D6009600DC0C66DA8EAEDA6C180480EFD8305A7BFDC5505E812BAD900
          B06FEF8AF0439700B07CEF8719BA6E0600BB016073E0BF64544196ECC9CB0414
          7C7AE14D18C7C632A43AAAB9BFFD5C1E2048C38B2FBF0724377BF4052436634F
          DB50B240C5552E5210108D29588BA1B55DD01CE062E0D04FAAA2EB7A9085BD71
          8318262674678B8014180B2316E9E302569D513567933B7EDBDE96095D35F541
          AB1B995005BA69EF0311ADBA8F8A18EAE8650B9638516550559788B4DAFBBE63
          4D24A008B26C6A17A848A51DCDD921C7B8CF0D114F118CC1664374531BBF9802
          08541A5DA074CA4282047AE9566C7C363960E3B8AA044BDB2598BE8CB2F8195D
          808B5FFF825BCB0D1803880434DA4B8912A7412DEE21D16C7EBC30E0F104DE05
          8095FAAA92A557558F882A86A3731CE1CC0BD3CC8BF7848FD3CE8BC7DD3B05ED
          F56C04A970D89ECF048046AD090002C8ABD5F2C2F5EFBF7BDD801E300CC3806F
          BFF9113BB757210F5D575542CA199215C7530D6489FB5A2EB058ECBA5B379BBD
          8FDB006A2B9919524A29C01C89DDBC3159878E3931317A5700F2B63920816E5D
          DBE5BF5B16B9B9D503558AFF774D9CF81707FC46B1C15D69F90000000049454E
          44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F40000001F744558745469746C65005072696E743B4469616C6F673B5072696E
          74204469616C6F6746B79BCF000007B749444154785E95970B8C545719C77FE7
          CECCBE59DE5B24B050581EBBBC8B840A0AB4A8A98F40494A2D16AB4D9A186C35
          1A69D3545B23A6AD561B6344B1C684567CB5B5B4349A34D5925A79540576C952
          601F2C2CB240CBCEEECE323B33F7DE73CEE7ECE13A4C26B0A1DFE4CB77E6CCB9
          E7FFFFFEE73BDFE42A11A1D89452DCA83DF1F22D5CCBB66D3CA280D28D24BF5E
          28B1F80DE028E07A40A56BBC47762EBAE3B13F2CBE17E52DF094CCB3A24E626D
          7BE8DBDFE7D7EF064C464ECA8D1050917BD720A24AE35D5B6F9E3C637EED6F27
          8E9BBC7269C35A264F68E0A631F5BC3F7076EE8564D7DCE6CEB7D73DFC3C2DBD
          3DFEDD556AEEA93C093B120107FCFCAB87FFEE296F8D2000B8A0A0F055042B42
          68527465B6B1BC71259F58F41906835364C3763AFAF693F0C63069D278BE38FD
          5BFCFBF83F16BF635F3BB8F97B0DB7E549BC374C6224053CB1ACD9B46E214209
          BE08B808C6189E7BE301562FBA83C686E974F6EF66F072863DAF1FE264DB0510
          689A3789B59F9EC3ECE9ABA928DB3CFEF5DCCE17EB9B6A96E54964465420D406
          23A0B52950B042C1AC08C74EEF25E327993E6D2C5D7D7BF194C71FFF7480B317
          7AB97DD5720EB6B4D07AE23CBDC9341BEFCD503FE156A6D6CD6A5CBDC9BF7FD7
          E39DBFF2B8BEA9303488B59861378236608D60CCF09CA043CDBF4EECE1A34DAB
          E8EEDB47687279CF924C65A8AAA960E99259888578598CE440166D02DA2EED65
          41C3526209751F101FB10803ADB1220E1C24925E21005882D070F6E249E62FAC
          256B32C46C0C94E2C9ADDF24114FB073F70B64B239CACBCAD9BC611D81398E36
          9AA0FC3CC6C802203EF211F81A6BC5658B0008EE2338B3C6D297EA65489F2354
          3E9E728FD135F80E562C6DED97A8A9AAE6F1AF6FA1CFB6D1331060B5A1D776E0
          FBBA62C69251D5F1111A8F0A428D119CE48814172322A08D25A6AA49A62E515E
          6D512A9677C8E92C58E1FE7BEEA4AAA29253837B4907FD686BF2AEC9A53304BE
          F5BB9A2F674B1550C50A047E8835C60129C01221A31011571B13AA67F0C107E7
          983855F044157648A735FB0EBDC9D889E5D4CF516857471A2B9AD4A538D921FD
          1E60E2A54D278A09A03C17860E243A020441B9681114168FC5B33ECB9BCD3FA2
          7652856BE34A1402B41D4D73E4C84544141B6E9A4C4595C238050CFFED14D2FD
          E1AB808E1301FFE0A72F4DADAB9BF26362B115475BF64F2E4F24D081C618A223
          0051804834769145B3D7B2BFE535DA5A8F72736355A1532D5ED0446BEB200DF5
          53A8AEB66482944BA4A7CBA7BB23D7D2FCD7FE1D4018C781FFB969CAD469FF6C
          6CA81B3D6FD6240E1C788BA6952B38D1DA5D504010B0A0002B5210CEF3126CFC
          E47778E6857B485F4ED1B0A802CF535455F5F2CBA7B6921CBAC8BECE57088DA5
          FBB8CF99633A7BA133FB5066400F469D10AFBA76C2B699F5E3467F64C228AA2B
          1304BEEFEE78D789777960CB411055C8B8D8442C222E12985B694FFE870BDDFD
          CCCC9390C949DE6ADBC5503AA0E79CCFE9569F6C7F65AEA723B5E9D4BBE96640
          033802C6CAEDB53515AED8ACC0407F3F037D496E5D731B4041D6524300148245
          4408FDCFD17DF16D3AF61DE650AEAB50D153EB1A59366D05B9090BED4F766DDE
          0784F9ECA540406B532B80B6E2E4556239DD7692783C8E178B134F241C8017F3
          48E4C74A79949AB54218FAD4A8462AC7CE2697CD32944EB1E3D987E979FF325A
          C39EBF1DAB024C713671DC7D37E8BC8771E30A6E615303875B3AF2C065454B05
          5C9583E08688140B14FD2E82A0F0832C4BE6CF64F4E831F40E18AC0D084313AD
          86555FF8D85502C3E07EDE63714DA82D9B37DDC9A1E6A7C966B453C1658C2AD6
          BD18F99A4A7868BE72DF5D6EBF20D46EFF8880DBECD04BFD4E554720D4DAF5F5
          78DC23D086BABA89FC7AFBF7D9BEE377B41E6B23D937001670594B2161C18200
          85EFC2F8716358B2700EDF78F0CBD48CAA25D4C6EDED08685DDAECE4AA028126
          364C20B0045A132FABE4D147B6108B299452A5F91772572545E98AD10ABEAFC9
          E442CA133172A12108345A5B4A1F7104AC1572817645960D42C7186028171603
          217C78B3E2C8B8FDADBD0E0163AD63E9C534B99CC6D7E66AC60EB924EBA23951
          A0228652B20E055172EE08AC8D6641952860090243CC1B56401368CB2F9EDB43
          7BE7B91BC8FCDAE539BB610A0F7D753DC6087E60F07D737D05ACB14EF6D8F011
          44728D1D3B8A15CB97F0D4A3EBF9F9814B5497C788298511410406B386C14C88
          05AC7552337839E0C9CF4FE199ED6F30944DD176E67D465557921C184245FFA0
          A5043C002B16AD8DBB014E2E3FE4EE0D1F77735670EA8446F04321D0422E1486
          7CE3406DD4BCC4396EAC8DE6536B6FC913F2B99CF1F183D0DD00B14269ED7A80
          35DA0C0C57ACD6D69D953696B317FBE94FA51071A0F8A1C537C6C56CE0AE16D6
          527013A96005B491FCF37DEE0689808822930DB1D6A40003D8E22308CF9F3BF5
          B54C36FB33444D44405B8D9FCB326D5ABDDBD881873E2A7A32E75B72812DDC7D
          71C00A1C1858637879D75F8827CA89C513CE3DA592037DDDDF0672C5045444A2
          0C288FC60A4800550F7EF7C5F66D5BD717CA4B2237B6A8FB0052D49B0578E2E9
          DDFCE6D92F2D03D24008E8083813450D48D40931D1645844CA03D2BE9FDDFFD8
          0F5F5949014F906260402CE054A040340C7207813311A08D9C82FC23BCE3952A
          9388DC2B5A531A4BC716080B999600462C0B098DF47AAE8A80D587787396C8AD
          8B91D4D7B3FF01913C05AB912E6EE70000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F400000013744558745469746C6500507265766965773B5072696E749891A1F3
          0000074449444154785EC5976B6C15C715C77FB3BBF7FA6D5EB671A88379C4BC
          C22B4069204D2A431B2729296D22429550A982A84DDB50A86823084930499354
          7CA84A94A6A05448212FA00F94B4411412028582102205EC1063A0768C014378
          F87D5F3B737A3BDA6BF94ABE76D52F1DE9E88C66577B7E9AFFFFCCEE2A11E1FF
          393CD2074AA99E69AFACE863645817C0D8DCCF1091BE01005E79E3F047A298A7
          0404C0080A852048406367022220764100686FED78A17AD503CFA7209EDFF8A1
          200601D6ADBCB74F92B400D8F8C6611968C46209E9EC8E496B5BB75CB9D62E8D
          176EC8B153CDF2D13FCECAEA9777BE0084000750A7EB5B1091BEEAF6BD038200
          E01B0123E0801895764D1B100183C288B2F7EE3F7A9E55CBEEA12B92786665F5
          1FD46FAA173D0FF893C6952219CCD627005A001093CA0002928200C775008324
          B3761C1486583C0140E5DC0AB4316BA36BDE529B5E5E622194527DFAC2E9CF20
          220A0448D547E8998BC1719C6480721506452C1207C0751DBEFED5F1C998F2F4
          D29F6D59D75B8EFF0AC0F49242821DB05982C0A4EEB3104A014688C42C009EA3
          F05C87AACADBB9B772FA9AC77EFCBBE7324064F08031A909160027C04A81F486
          151CA5101449635A18CF55388EC2758585555331DA5F93886F64C7EF5754A71E
          D13F800499543620D689C1AA42A7B6036593177618949FC50F57BF83313D2D0A
          08F7CF9BCCF809E3D600BF04F4802634BD08A4973006B10C223A90C3A0B54180
          AC90CBF716CDA12B122391F0311A12BEC1D71ACF6AD402E0020C0C90727F4A67
          11B4880533C670E94A1B57BFE8A4BD234A7B678C82BC2CF2F3420C1E94C3F061
          05080AA3052DE0FBDA4AA2B5E93955070608B437811E7E50B8A333C2F1931709
          873CA64C28A5B4B810CF73F07D43CB17EDD4D4B5D078E166F2DA70F2F373082B
          07A35D425E321300A41DF999DA50A734148C60E9DB93C58F1C6FE2B651C5CCBA
          63246FEFABE3A167FE4CE54FDFE1DB6BFFC4BBFBCFD8F5B1E5451C3AD6406B6B
          07460CCA7508855C8C0F19DA30B3040818A3D1DAE7F8C966664E2EA34B1B96FE
          6A17BEEBB1EE894A5E79EE61E656CEE2CC4D6DD7E3CA61CE1DA3D977A89EB86D
          4BC175947D4E0AE08317EFE3C086CAFE000C005A0BDA08CD175BC9CFCD666852
          DF17B71E66F5D2BB59B17816B7DE32849C90C35726963072E258A6CD9DC64B6F
          1EA1A46490F545EDE926446B500AE925C1C6E3B3E98ABAFD482006109BB5AF69
          4A028C1F53CCF603E7B86BD618A6550CA73B6E688F6A6E4634712D0830A47808
          E515B7B2F9BD7F32736A39276B1B89271238CA9AB2C7844614AFD5DED59F04BD
          5EECBEE65A6B372545F99C6AB8C643F754F42E9E0C9FAB1D3E399E8323307942
          1927CE5DA57070019F5FB846C2D7D60B467A00F870E77AE51B377317F8416F23
          90309A4824618DD4DA1527AA3C4815EFF6698B6ADA223EB9614538E450949747
          772C81E779744722C4A2098C91340FD840FA3B0905047C2308A0FD04F1B84F61
          6E983DB5D7995C3E085F0B573B7D5AA39A2C5791E54161968BC4E20CCDCFA6AD
          A39B583C4EC873C176126923DF8B660608685141BF6667BB5CB87493E9638A92
          325CA6533C04C8F6147961C7162F48120CC971A9F9B499C9B79570FEFC658A86
          E4927AA18AA41F44DF2DDECB1F077A191940E130A2A4808347CFF1C88299ECFD
          F55E4A6E2922BF300F5729C26187425BDCA1B3A393B3672FB2EC81E96CDDFA57
          A64C2CB3A7A020189D7E10F9BECE6C421DB81A40390E1515A53436B5505FDFCC
          EAC55FA6E6680D2D8D17C9963825B91E3AD6CDA94F9BD8B5F724DF9C338E9ADA
          739CA96FA0ADAD9DAC900291341302988419F820524AE1382ED9595954CDBB9D
          2D6F7FCCE564E15797CF67283E9F1CFD8CB7B6FD9D4307EBD05D11BE5F358DBA
          9A3AB6EFD8C3B225F3B9D0DCCECEF78FE02792A0C30AD25E467EC264F4809200
          40C44A40C80D33A274188BBE339B37DF3DC0BE032758B8600E0FDE390A706DAF
          D79D6964F3A61D347E7E915933C6E38673F8D10FBEC5E62DBB78EFFD8F199194
          0D708348683F33005A0C2282180010A5F0C221469797B26AF983EC3F58C3D66D
          7B38DF70C5520294970D65EAA43246966673E458035F1A5106783CBC7006EEBE
          D5D4FA77026407002A092099BB4007597A4B11221C56B8AE47D5376633EF6BD3
          F1FD045A1B9402F51FA9421EA190A2A0E0101FEC3E4CA1D7CAA6C7AE51BCE225
          F8ED7AD6558D5EB6FE6F0D1B80F8E3DB3F4B00D2178018D10830383F94F60926
          E2D9B936C6BADAD89D22051978C7B064F17C72C3507EB29AEB57C612FA643BF7
          FC641DF1E8B34F551BAE57EF6D780DD080C9D086B2FBC9A7B7DD270208D88401
          51885DB081A47D4103082262BF134694167176D0029CD3BB03C2EDCC7DFCE7D4
          9F58FE0BE075209A5182CD1B1EBD3FE3BFDFC0A182080379CFCD1FB532116B58
          1B8F6906DFE8C4D7A6835E23F3DF71E69F56B63C3A0911AB155B9A67D3EE6753
          E0469951D0C494DC4B3CB1F34C1AC49ABB472E2D2DF09ED242C7BF6E4457BD7A
          F4D29E6007CCFF04F0FA2313832EB15210488F2088CDF0E45FCEA62042405600
          23402C081F907F033E382BF0E60034FD0000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F400000036744558745469746C6500506167652053657475703B53657475703B
          437573746F6D697A3B44657369676E3B53657474696E673B50726F70657274EE
          3B616D0000072049444154785E9D970B8C15E515C77FDFCCBD7BEFBE78082801
          A9B622BBC20252845634C82E0848A8B44D2B4D2169435B14AAC1566301896EA1
          2D4DDB3452D3581B436D6991A8055A4C90D71679A9055B35B62A88115881C5E5
          B1AFFB9899EF3BBD39B9936D6EBBCBEAD9FDF67F367732E79FF3FF9F33738D88
          608CA118A6072C891E3F13C029F61222421C89D29BAE7BFAE06E3C536F0404C0
          090683E80F18D04C7F05C4A00940FBA58E358D0FCC591D9358BD6EB7200E011E
          BD7FE665D918C05FF7FB4372B9C8E743E9CCE4E5525B465A5ADBE5835317E4F0
          9BCDB2E7E03159BE76CB1A20097880F9F7D1B35AA3A4667CFEB7038200103901
          27E081380340FC997520020E8313A3D7EE7DF5380F7C6B2A5DD970D5FD8DCF99
          C71ABFBA1A88468F1A8A9432801E25002B0AE26204887BAD199EEF010E29A0F5
          3C0C8E7C1002503FE57AAC730FE756FCD1FC66ED4225618CE9D1175E690762B2
          220634455190EE5C1C9EE7150E18DF6827F2D90000DFF798716B4DE18C5DB9E8
          7BEB1FFD6F39FA44C029109B0E71A028C58303C081923006952A9B5702243C43
          C2F798553F8699F537AE58B0F489477A239128192B23CE0110BB57D07603DD44
          E270089E3108868231954CC237789EC1F78579B3C6E16CB4220CD6F1EC53CB1A
          E35BF4EA81B88010A30351270202AA78CCC4E849A67CFA57A7B97BF9469CEB1E
          5110EE68A8A3A676D40AE0478005E2BDF3FFA7C075334088C3E1D091D63CBEB9
          1633509E4AF2CDF9B7D099C91104213612C2C811594B428B9D05F0FB3205C6C5
          EE8F751651D4FFC561AD250A23650F82F17C8C405545B270CA9454145A42EB88
          22AB9258EB8825BE3C81A2F6719B6DF7F2C046961D4DAFD2D27A894C264F3A95
          64D0C06AC68FF90C570D19849F4C924C264896F99459878D9C1270C404E0F226
          B4B186AAB12246B9E0443872F80D2EB675F0E39F7C9F30B29C387186A6836F70
          CDB0214C9C504B797905C944427784600AB9C145F48980462C015AD0A2A98D09
          79DCB7F4EB3CFEC4467ED8F8384BEE5E40BFCA2AE67D611ABBF6BC42D34B4768
          B86D125220E1FB3E9E878EA47396BEEF81E2185A2B582704F9882008B4FD0648
          A7CB59F29DBB48A752ECD8BD5F1D7DF2D447DCFCB9F19C683EC77BEF9F220A03
          9C733AA2C6F3105CDF094871DC0A481884ACDFB0956D2F1EA033D349188678C6
          A3BC3CCDC2F9B379FDF577B86AE840757B3693A76EF475FCE3CD77C9E5950022
          E07B1ECE0AB1C47DE880A2EA1D8521C78E9F24930F7861C721DA3B3BC8877982
          D0E2F93E151515A42BD238071D991CD75E339C53CD2D4ADC39D17B088A3101C5
          5E4D18D9E2067442682DED1D9DCC9F3F8B0D1B5E60CBB69768983A116360DBF6
          FDD4374CD6568B53B9284FA70AD767086D8458877845F3BA8F258180802DBA3E
          954C92CB05CC9C3E85A1C3AEE44FCFEFE20F9B5E64D40D23993B771A674E9FD7
          FD6080AEAEAC1ACF5A8B15878680B568F4D184164D8A0F9B112386F2DA6B6F11
          59C784BA5A7EF0E02256AFBE8F3B66DFCA871FB672F2640B224E1FD117DADA75
          4975747490CDE7B41356BDD0F745143F8C1063F0BD049F9F3496CD7F6962D5CA
          7B38D9DC4ACB8576545BE7546751AD21930B183CA09A71636BD8BEE365E6CE99
          8A0C3254A67D9CEDDB182A436B0541438D56537B1DC3875EC193BFDDC415032A
          A82A2FC3C36871630CA9541227A23A9F3DDFCEE449E3195130E3D66D7FA3F5A3
          730559BA5422C0EBA30442FCC4F23C9FF2749AF95F994375659A9FFFE229DE7E
          FB28FD2ACBF8F4D543185895A6A3ED128307566B27C45A5A0A246EA81DC5D59F
          1ACEE6AD4D9C39D3C2E8EB0703247B93C0C42845022260F0487849FAF7EFCF97
          BF389BA3C78EB37BCFCB6CDEB293AE4C8EF2F23210F8ECC43A66CDAAE7CCB98B
          3811C5BAD135B8C8F2CCB33B183972244065914408484F1D50F78A6A1C5FE1E1
          27135457555237A6967B0AEBB7F191EFB276CD32562D5FCCB27B17D07CAA995D
          3BF73264403F5D3A22C2E9960B8CA9AB61C4B523F8FB917F924A570E07AA8ABE
          333DEE0167BB17511CC624F01386B4E7535696C249A516B1D6515D9DE31B0BBF
          C4EF9E7E9E3DCE52DF709B167748012F32BA403A0C2D531ABEF6B357F63EF7ED
          6CA63D0B583D250404704EAC2603AA9225AF6009CDE325259A19C2B0827E5529
          962CBE8B5F3FB991DDBB2C0DD3A7D17CF6BC1AB5F9F405C68D1F43369B9B10E4
          330F1DDCF3CC8340167080941208835C76DFBD2B374DD5C271411C8841881948
          11F4AFE2B89A2B9974D36476EE6C228C22A6CF68E0F4D9560495835B6E9EC8A1
          03876F072A001F08558292EF74B9F58F2DBA134801FE65BE239A923C01542592
          A961273E68F8A93877E38CDB6714489C07046B85C8D95C6F2FA55264658B2D32
          7CBC3040320AF3ADEFBEB577A9437E95E9CADD74E7BCD9FA8AF6E72DDB69BBD8
          B20DC800B62702F1B17CB20880200CB2E17BFFDAB73808B20FEDDF7768BA2051
          B6ABEDAFEFBF73E097407B9180C40F1F4AC318C3278F580ED5BA9FA2065D401B
          104F811482FF00D201421AE5B48ECA0000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F400000021744558745469746C650050617374653B426172733B526962626F6E
          3B5374616E646172643B259B079D0000064449444154785E85976D885C6715C7
          7FE7DE3B33BB33BBD96EB2D98D6E52562A7EA968DB101B59535F4A5F44285811
          151B69B596C6375A44C837DB6F7EAD504441ADB5AE2DE24B1015B41429D85243
          A2821F5AD0C686E6656D926E32C9EECEDCE7397F93DD87B95CDCDD39309C7B9F
          E7E19EFFF99FFF39F78E4902C0CCA80C6363B32F3FFAC4DCF43BAE7F32CF8ADB
          DF3A7FFECFE7CEFEE7D02F7EFCD809406C6AD59E543F565037AB7E00E4402379
          806272C7AEA7EEB96BEF81EB774FF2DAEB8B773CF36C7F01B807080080032B40
          4C81BD0E82AD011CFFD9C18F8CB61ADF31635F67EE2E9E7A31E7CA6A814C283A
          125C775D8737CE5E246B1490151FF8E2B77E741609C919C99D073E9A539E7C9E
          3CE3F89595FEE1DBBFF1AB1712106D05C0001B6D160BBBF77F6EA6BD7D0FDD95
          16E77EFD020F7EE1E3CCECDC467488EEBC7D69854B977B84E0DC7FDF1D8C8D36
          E887C8A9D3E778FA2747B8D2B889DDFBEFA3152FDCB278FC773F05F6003E9C01
          C8CCB4163C5EFE2779D8CE9D37459EFCDE73ECDC3DC7ECEC14EDCE28EDF60879
          9EB3BCBCCAEB27CF7271E9126F9C38CD5B674E72E0C68CDEF97FB3AC65266FD8
          0BEE33409612D4D0122846E4115FF92F992E70EBCDB38C8DBCC98BAF1CE7E8BF
          8C2B65C6CA6A4188804A1A59C96811989D32E66F1D636AB2608C53E4A5C8BC44
          EE35510F2B01EE0E0A28044C7D9AE1356EBC618C8991494EBDB9C4CA6A9F3246
          A2048222379AAD51461B4EA7D9BDEA97E98C148C8DE698AD3FA702F01866368C
          01813BF2003819A2E54BCC4D47C6F392A50B5DDC851CCC846546061485513432
          1A79C14833A33091C909C199D931DB1C7FE7BBE3AE89C558145F51B71B74ECD8
          0FB43180149C1810C25C80939BB36BEE66B64DAFD25B2E114232CC1C0C4C0990
          19990118B198A2BD7B1F133BCEB7C71A53857B2FF47A16DA6DEFEFDDFB50B806
          A20EA02A011E03489000E08E9781DFFF639A334B2308A181B204020964800400
          0AC03C07BF367F3AAD1043F9973FFE66E1EEF1F15107C58D45A8C8358F1C7347
          38D1B5B6767AA9C5E1431F669855E0EADA7FFCBB7F9A37AC198256E171FB3F00
          1E85428962097224211C45E11EF0945D1984502D9A44DDE4882C796835735CC2
          206FB532DBA40B2228400C7500417870E402AA60AAC4036420100ED4F73DDDC8
          1D97E5319606B001038E7C5D03264702C9D1DA7A1C0414C2A016B0F2C9241CAF
          18023C08C0B61E44B10F31E072D28CC7A3882120799D01BC9621B58C537B0072
          12264F00D890013C3A7840310543E0426BEB5509C05102F2CC91BFE32E5CC245
          EA2488EE3CF8997D156BA43DC83665C083A358220F24FE913BB89047A2940257
          EABBF7EEF7A605AB389118384F059370694B06CC63445EA2C11CA8BA20461F64
          E70C9A9E9FFF769D0139B847E4223AB8C4A183FB2BD500DA82014B6D08B19F00
          008A20A128D6F501D41880CF7EE2FDE94A55C669173754090697B62C011E031E
          4A88011072C71DA4F5EC5DCEC004423CFDCB63443972924F6C487CFDFE0FD518
          88615809828397691E3828511B1DA58783AA2E70E3F39FBC054958AA8A5481AB
          DA1124E11EB616618C0EB18418911C530A1885475F070628090BC40F9FFB2B42
          C885BB522090C4235FBA0D5159D49039E021E2A13FE8021F7402283A3E48BDA2
          F5814FEF83942118C853C6D4B421817BD2C02625D07A09FA981578EC41AABDDC
          D6BC4721C011A464BEBFF032526205E1EE9034F0CD873F46550950F42D19F032
          C4C5F3A7CECC8C77B6514848914C8220ACD9AEDA5024BB26B403D56B19434A57
          80AA830888DA9C0107FA2716971FF5E75F7A2293766A201C70199DF76CC37DAE
          DE05F5D18BEA6F4764E9DE954AB9B90604948F3CFBEA11E00F40511D6CDAF6ED
          D3ADED3BFF3673E7A7E68F5693502988D53481A503896D32100947DC7A0E4460
          15E857C13118B3A9A977B5C627A6DBC2ABAE160803D5A950A67A5D3DA94610E5
          6426F2BCB1210315909ABDCF2626F6647953FD9401E3A30D808AF23A2B40FD13
          4D325C8EBB10C45ECF550320A9025237CC50A7F3D5D8F3CBCB65BFF7F2C38717
          3E883408AE74ED9EC0E0780D8C00903BA1EC1F15BA5C14E6F0ED0460A819DDEE
          43A1DDCEBBAFBEF2D2BD666507B28632654206D4C66BDD6386616E809752A35B
          E4F9DBDD6E28C194000CB76B9FD0573FA57BE3E3C585108A8BFDD6156BC79114
          68F8DFFAE5E6AA9ABD8E1A0D8BDDAE95579FE700FF035802C08A010C91F50000
          000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F40000001F744558745469746C65004375743B426172733B526962626F6E3B53
          74616E646172643B9EE424DE000007E549444154785ECD5569505467167D4689
          5BC0C424B319C71A97188D32A06283CB18D4E0862B820AB8208A2C2D826C0A88
          4D03DDD2D0021284661751B0C1B02F238282A86C362A12356A2B101985882B13
          DB68CE7CDFAB7E5D5D3443D58C3F666ED5A9C7BB55E79D733FEE779A01F03FC5
          FF8781A4EC06269180565064197320A2944520FB2C610225254C4078310B7F8A
          4345CC7E0A7111B38F4521B34F54C8F811F8861568E01D4A1092CF901AD4076C
          690C2466B1E2835273AFE068C6450125044A88201566058B59416D513F4E34AC
          808008534156349FF1A20821106AC43FD823C815780A4E83FECDF6B40DC84ED6
          B3068E665E2E69B8D68198D4EA604A7ACFE3E5C407BB079D0A2E3BD78A9576A2
          52FAAE6320FE441D139F59C7488E964D3CFEFD95DEBAE63644C8CE0ADFC7847A
          D221FCC02C6169552B767925F47EB3D27B4ABF274026678E1EBFCC3A8E4A3E17
          50DDA0C4C5A6FB083B521A421DFF175353113DD7FD2742A8787AF63958580B0E
          D05EBF3B1047C48F1CAB659B365BBC471C4E3EAFEC7AF20A35F577111491174A
          27A1C4FF40FC43E77DC7434B2A6FA0F3510F2CED43957F9E686A4087E9D7C077
          C72E32D169B55C7FD081F0DC85A9F27ABCF9F51DCE5DFA11BE21F230CEFDC0E2
          ACC05027BF6361549C96D7C134CC5DE26EC1F1E72DF763740C44A7D632646AB6
          E91592471F4382A485F20B4D4AD64445CD4DB8076488E864546800F1614E3E69
          A2E2CA16D0AABCD002F335FEB9A43F9C9B7EEE526F1D0344BC9A912454B24DCF
          60D6C0A09D7BA2C68BE3CA9FDFEF7C0AD5AF6F5156D502272F999833D1477C08
          1571F44A11179F65C5D1DDF30A1B764A9F4F9BBDFE2B6E7AB3255E0C6FB1878E
          01225EC588E22AD826B9AF2CA863BE7FDADECCD3F5E8EC7E01D59BB7283AD38C
          CD2E31E1F498A9B096F8C8ED9E49878AD4E22F7B5588961563CE120F1FEDE9A9
          F82C73775D0362222E8C29679BEE41392C2861DC04C391FC808C56456B071E3E
          7ECE9AF8BEB401EBB74B247462F5641F3978248517555C07AD9E972ADCBCF310
          E6AB025A47E87F365A7B77669AF319E3F97C5D03C2E832E6A0B4986DEE26E2FC
          0372861F28674FC1DA2164812032FF5DDBA367E878F41CAF8989530597B0CC26
          504A08BFDBB23B3EA2502DDEF5EC35BA9EFE0227CFB877D3781BBFA526B5B284
          88BB31867377E91A0892D298CD679B6E44D82DE014E34AA05EB0A1B6CE51E939
          254D6827261E743EC1CB57FF444A66396C1CA58D9C78E7935E16792575305DEC
          9E4178067D6F8EE19C5DCC34DE0E5D03FEE27C92E5B96CD3D53F9B8867332EE4
          C9259AC9DF368C73F448E8BE71A71377DB1FE3C6ED36145528C8EDB8055A0F1E
          F5A2FDF14B28DB7BB0DCE660CF17E3795FD21B41B9DA06A699EE64A6CE76D435
          E01D729AF114B0474E84B318E7FD04FBB2B40346CF628DAF9B502A47CBED07C8
          2EB88C0B8D4AFC0640F9D30B283B5FE02E7906879F8491D936BA65FAFD85D714
          93EDCC5733B6EA1A18B8340133DA7C95CFD52329E5B840A25AD1D286F4531771
          F6E26DDC6A7F8A7AC55D9898EF6E2684DF130CD564FE0035A0012E56B98021F8
          C3DAAD227941F935FC46460F9616A0EE6A1B79E6E307650F1CDD63316DB62D0D
          913F12E87106B431B0015D513DF524FAF4A3560E92D8BCB26656FCEAED6E1C49
          AB829D731C8EA45622B7F012DC7CE3E1EA130743D32D0984F3A93AB0F4387059
          309001567C47F4D9892E890D0297E42BF52E49CDAAEDDF5D52D809F21A320B1A
          A152BD41FDCDC768BAD5A541CBAD7FC07ED761C4A69420A7B4117EA26C58BA1D
          6DD81C5ED66477A8E2B58DB0A8616D60AE70A153B42611FF9D810FEC0F154FDA
          115F279755DE47FDBD67E87AF516CD6D2F5074ED67945FEF466CFADFB16CA318
          4B6DC4B0582FC2E275A158B82698FEEF316B011F9EC24CA4D5B423B5A603676E
          74E3C79EB784D785D0AC2BB0D89B953BD34638955B4E8D01ED3CB78FAA0E8E3B
          730F55ADDDD82A398FAFED32B1415C8D826B4F9052D58E399B63E89219124C26
          F89A603A01FDE8048A6F1DA31589E7DA9154F5132C03CA317543222C03CB2123
          EFDEB25AF0B6C58771E1D4D7006D0CB51257369CF9A1079B24D598EE989138F6
          1BE75986DBD393578B6B71BCBE0BC68EE9D709EF4FEABD18A6C6876A8C5CEA7D
          529154FD108B7CCBF0D78DD2C4716676B38C3645262FF62B4774D97D186E8A6B
          E2AE687F06862F3950AAAAE9780323E71C8C99EF64427A9F8F99E7606AE49A87
          D8C65F30D93645C52D589F2D1F4CF90B7667A8C22A9EC2684B12C69A6E62F963
          675B9BCE704885A0FC0926AD89A6FC8FB98CE86B6004CF25A331AAFA11AC62AF
          83E79193327E91B399E99E9CB475E4DD36E50EBE581EA920C44FB80F18CE71A2
          5C0DDFD83EA6D136E12656865583E7244B193FDFDECCD449966629AAC1EAC8AB
          18B328543190816193D7878B5C9315702DF81936C94AAC3A7C1DD6C9F7609BD5
          8DF97B0BF189995F243D42EE4A71B9CEF1FFB23C4864233E8B0D494A58452BB0
          22E43CD6455D81B5EC1EE6F1E518CDF38AD0E6F75D42BDCF676F9B3E7E9D287F
          6140315624DC8357D973B89E50629E77214699FA158EF8D26A8656C673A5E17F
          6A6C377DDC0A41BE093F07CB22AEC23AA9034B0E35C3D8598E8F793E852327AD
          E5F83A4BA899E2A3296B8D0C4CDC2406663E8A5173FC55063CDF66FD197CE9F0
          89AB66D245EB2F50B4F9FA93571B19CC74938CE2792B4699ED277C9F667D6357
          E9F0092B75F8FD05D160ADF41B4DF0997AE94651737DC439EE7BF0078EE221DA
          31AAFBE3A2E1BE075FD780C6880E748BE3BE17FF5FAC57759B4588C1B9000000
          0049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F400000025744558745469746C6500436F70793B426172733B526962626F6E3B
          5374616E646172643B436C6F6E656D0EDF5B0000057B49444154785E9D966FA8
          1CE515C67FE79DB97BD3264B3F09458A16ADD70F516323681383F562488A4844
          2828164429A4B548A129A237B635BDDA8622041411691114C42F1614D18A70EB
          9F264255B4C44AD5226D28422842B4DA9BBB3B33EF797ADD7D9997C1DD4DE859
          06CE0ECB9C679EF99D67D62431A9FAFD3EA9C2C38F1F5EC16C11093040743A81
          0432C60DF09F4F57EFD97FDBD5CB8003FACDC32B428E803B6FDD452A4A669701
          86D9E2F7F66C6152555543139DA6890CEBC8DA5AC3894F4E32A89A9FFFF2D053
          76F7BEEB968178C70F77F2E737FFAE95573F00E80A303326D5A64D9B005A97A2
          3B9241EB01B800406608C3255E7BFB43F6DE70292707CDCF967EFD7B3BB8FFBB
          CB40F3AD4B16F8C57DCF08382D07ACAA2A2BCB32B83B92882EA0F51A01160C13
          94211083036258D7005C76F15944F7BBF61D78C20E1DB8712462F9F63D0E689A
          00836C7D8CD1CC2C7CEDAB7DDC7D74C8F3F39740886006065618C2A8063500A1
          086CDFFA75BC8EFBABA547EDC183372F0335898B8902EE7FF4D531702E0C4388
          BFBEFF11EFAC1FD380BB60E10CB6AD0F9284476730AC0028831109ECB8EC1B34
          EE4BC37DBFE57787F67644949380FBF14DDBA6025747A7A923C3BA1901F7D1C7
          AB7CFAD9803FBDFEC1BAE567836038AC3183B23042308A425CB563018F71A96A
          1EE2B1077E7400501690CB94A86ADC9177818B0E123886CB685CBCFCDA3FF8E9
          F7AFE0D917DFE5C87A7FE1E633E96FEC71C7AF9EC6A1750CC48E4BCF65E1BC73
          96807B813881814CBC3B193840E99982A3221043C07086550DC0E2F6F35839F2
          3EAFFFE518D77D670B83AAA16A228AD04451C74861F0AFE39F0114D320A4134C
          09326B7B278440908F80738CE15A0540510476EE389F175EFA1B6F1CFD27576E
          5B40A14451B86B9413C140FE610BF94407DCD36C07ACE50CE100388C44984570
          B19681C308EC5EDCCC732B6FF3E29177D9B57801A15720416C4ACA021CCFDB06
          7C0142A5B8541A47EA25DAF2B47AC2260277EDEE8B78EA0F6FF1FCCA51AED9F5
          4D2C046CCE982B0C6FC802263A20B576A390AC1060092AB50ECECD177CA5BF81
          1FDCF904EEEA00B7FBCACDBC77EC2475DDD09B9FC7828DC2CADD670AC0DB6C05
          703C275F2BDCDD0985F1E50D3D6EBEFE72FE7B724055D5C446D48DD3C44869B6
          9E1FFF267A83D4A308612442640133B70029C715F99C003300A3578E1DE86F9C
          27A67CA8D38BA92C6C74CE5D48421AB3E351A780300A1011A0BB0DD9010C5C98
          416FAEC025A482D82BE84527363E12E02401CA37E25227F22740A80C9D916FDE
          8D56461B0F46BADE18C41012C0C65C3906CE951D90382503E61E532B945A7594
          90604CBDA53E090F165070CA22E01E9184B291C4F4653603CA778C921872657B
          5AF2B3684130C3424038D145FAE4DFCE0E22471938D48AB0E43DB8BA92D46D90
          A048C0C91D8FE041EDDB726610354D8E20243C8F41DEFD47286534BB090E4AC0
          29392025F1D22C063234DEBD2202B23043E468508E0A7021AC052E0D24CD47A7
          82501E11A0AEB769887598686F3DB94AE83E8E18D3E0165265A766E7408ED4EC
          8081BA562868428A3A109293CE865EE04BBD403957220CF7BC431319F0D6AB2E
          601946E50DF134388583E4A031FD620CDCF37F7C8763C7570956804135583B0C
          0C019FB905DEEE8C65D07CDC39B9A4D68EFC12039480DB77EB9EAD65597E1242
          A881080C80B524405F142047AD0386486001DE12E94040780634CBEAA45ED334
          278013EB22EA10828038E95FB1E5E798C112C2276C8208A0CEC06EE5F8C5DDEB
          75113550F57ABD7C89295B204521A0BF712ED32EBAA104F9BC947BD4119480F3
          CFABAA2A0D8743C1F42876A05E1BACBEF293BB9FFCB6484E5B0A204BC3D4DD12
          29F748C83217F5B00B1CC034014AC7F09143B7EC01E68102303A75DADF13325D
          E0A60BC82232A9B3069D7E65E0A6D4FF00EBFB1275126F380F0000000049454E
          44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F40000001B744558745469746C6500466F6E743B53697A653B496E6372656173
          653B5570CFB133C4000007EF49444154785EC5576B6C1CD5153E775EBBB36BAF
          1F312921C66C5207A74913DAD0A08856519A56A4040C98D8C110C53CFA704504
          165510110251AAA2D0367D38282A6E9BA4340A4DDA6230158F264B280405541E
          4A0CE4299A2A26716227F5AE77ED999DB98FCEB97347AC2D6FA4F64FAFF4F9CE
          9E7BCE3DC7E73BE78C860821E0FFB98CFFD6801032E1E7A463F13F05D0B961DB
          0461CF93F75C85FBDAFBBB0FF91E03CFF3A077DB06797655E75638D4F36DA29C
          6B2541F00062FE3D3DC1CE4070110A190310A822A44CC8B330D413BB7F303103
          94F9B0F5679D36E7FC21B4DDB1B9EBBBCD6B7EE8787E11A215395FB2FED975BA
          15DF8C1731CE607C64E42FFDBFF9DEED1F6FEB14F3EEDC22905ACE0510012004
          0D20A4538E3BE72A404501A37E0006D4F78031B67667EF9B4B8A45173ADA9677
          E40BB91EAFE8C0A4A569A6D566183A108D80214C281AB11B2E5FFEFDDA817D4F
          5F38FCCC3ADEB4A65B088E3EA9748CCF5CFE513FA02480E2B8031EA5F0FBEE75
          F5A707CF77ECDBFF61C3D0F0107C6D715347EFF6475FFE7AF3BD03A5BC2FE8D8
          781901722D10A2D22AC088997672C6E75B01E0B7207D51490A9741202BA15E24
          E4A2A4060AE305F03C99E6FBB6EFCA3439AEA36B84C3A6EE1D4D3FF9D1BAAEFE
          03BB1F04D8254858815ABCE6B256209A8E64864D44C0B462A099893B00602B0A
          0415822BDED1215240804B5A4494852880B1D12C3CF7CC63D7BEFED6C11B3F3C
          7AB22E3006C334E1E0E14FA6F5BEB8F7863367CEF401C0FEA8F074D36AD50881
          30C59264D00C0D7433FED5866F76359ECA741F3BF1E7F56256CB46114628420A
          643A58282AAD813DBD9B6CC7711ED8F95C66F658360F0C2870C6C18EDBF0D496
          EDB3DA5ABE75DFE0E0E0FBC8D6FCB54F5E0144BF86521F70E93A5E11D210B32D
          B0AA2F5D03008FCB5C7316D61EC33898D4178C87FAA519C08B0DC3C8FDFAA75D
          EFBAAE4B1863042D11966589643299CF64324599FED4F416E651DDF79C5386AE
          1D2189CA154403498561591074463B00FC38003DD9F7086958F958982410AA0E
          18804CC4C400B8699ADF0900A9540AA65AAB57AFD664FA2DABA5E8BA303E3CF4
          BC659B47F498BD4287300B84C85A9875F975EB970DECD994918966E85D654084
          8E8540280A264FB8791D5B80470AAA6D8EFDF1013C2473DB1E4D83D096F863E3
          E0E4865FCD1EFFB83FBEF48E5F69712D1EDE27C04C26418FA5B0185F0FC038F7
          1908F9A43A868701F190020D262DC6D51463C14E79B0F1E848B3A7D5AFE29C81
          373E3632FCEEEEB787FBFF96F38BEE6B8C51BC10218B5737633725EBBF8CA924
          A7F76E24C2A7927B2EF04E065CEAB3A90310E8D8F781A1738E8A349AF98666C4
          6FF1DD2250A7F85A317BDAC378BD7CB68F51AC6C35DD0258896465D5ECA5CD8A
          6282D5CFB90782E24454C1323AF5CB88531E2A494B804F7A1F92ADD7D8FC609A
          107DB19B1F01EA645F4055C4D90FFEDA77C5B23B376BF1441C69433BCB4E8061
          55200DBB02F81C9D09AED21F80A196989A022E6848814F81531FA2DE4F4C4FB7
          61AABDF1829B3DF1C65E640BD5B3C7DF2AF8CE7886D1883A0EBA618066DB4BAB
          E65C578F9D3A74A09B088E3460FA43AA78590A7C2A81693BF9E223A424FD37FB
          8E0B6CDCD95F1878BF80AA0ADC1B1DE963CA0683C0228E272AF458EDEC764583
          261D332603E4180CA56502E0619B70CA2291366B45571A405FE4E5C7C077727B
          4B5EC53A2A9C7DAFF715EA3AAE742EF9E5602412A0C72A91060B752FBCD74342
          EE7D59E0C045B922A4809D83CACA919EB8247DBB460088A1339AFFF4EF00100B
          9050B00BA7FB39F3DD7D9CD268D603213A9876C59CAAB9372F568112BC3BCA10
          E3658B50487A07F63CF159FA2DFB268EDEAA6B74EBEA1BFFF1B945D70308A2DE
          03089C507A28E39FBD6A6315956026EB90867702F8F24C700877983A00C17D10
          0CA2A5352CBFB7891063A1931B05776404A24BB81AD5EA8D84FF6D1060356896
          297F0B29B341B72A6FD1AC8A87B95728663FDAC1ABBED02E400E24522E034C5A
          47C567D7A55B30B5F9B367D8C8D15716388387CEA9168C74222AADF4CAC77B12
          35D39B01F9525758C9546D45FA1B2B478FF7FD090068EEC82E485DD98AA7E532
          C061F0CD4D5191197ACC5EE5392E5027FF41E07C10001C15407409518879B9A1
          E7E395B5CDC430143D0056650A8C58EA3600C0D9510CC0547D952B422F12E8F5
          4B3BE70131E616F33960EE6806790C4011B55FBA9BD62EBC8BD62CB8CB57726F
          E47826E3BB6E110B2D8269C641B7AB96C56A9B2E8D26E345E700672292EBF169
          0D2DC897571807BF703E130D9FDA85770BC1C24EC1BD7ADE1A817267F858DE77
          F26F238D68271D81002B551BB36AAEBC4D758F56F8E70B0478993930F4CE539A
          8A34AE5B156D7272061C144EED3FACD24E847A61E10E01B28777127526BCFCF9
          973855D35408B9C712010DF6B476D5B6660032F6AF97C8540110D5B3F1F48A0D
          6D44D36763951BC9E405EE153465AC8D7CF407821940648F3E4B4AEC2C410BE7
          E4202BA141334CB02FA96FAA6ABA1583A8403D65432607209DCC59F5F33DB1EA
          994F13A24B9564DD8C9933973DFC46F5FCF6FB231E738163215869E056FAFA27
          5E4DCCF86237D18DB0DF85CA4200BBBA0E52E9AB7F51D9D8FA724445D94FB3D1
          C14FAF415B90F61C08306045B7917BB47162C78849762717853274AE58111291
          055037FF958B7D1BF200F4DC815FA622AE144015A0A7BA405434DE2A907FB504
          9EFDFBE0EF6AA2D95F624726DDEFA976E4F2500831F9A3339A0193E9110A7C8A
          0F5152C68E94B98345CFE5BE8EB9C4D44B5C44C614CAAEC936FF01BE66EB1703
          A553870000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F40000001D744558745469746C6500466F6E743B53697A653B44656372656173
          653B446F776E528A1DBB000005D449444154785EED566B6C5445149EB97BF7EE
          DDBBBB2D85ED035B6929685BAC2D1591E20F402A500C4540C40089F27C68A2E0
          AB89FC3186C44742822262F921600021B13134268244A3800682202089624321
          0AA4C50265DBDDBDCF99F1CCEC6C8D2D6D965FFCE12467E77566CE37DF3967F6
          62C618BA9BA2A0BB2CF700DC03700F807ABB498C71267B719F9609CD401863FD
          01342C5A8F8A4B8A7B17C7ADDD8318A5A933C51C8371CAC399AD4BB074EC0355
          A463CAB5725913652CE5040B6704F6F1652CE6CEEF7EF9FFB7483B94076D83F1
          684A2906455C618C4198AAAA177C3EDFAAB12F6EA7679B96735BB5F6F57D6D0C
          A3222769A364D7B5863FF7361E847932E685ADB08DF462177D019EA1D6BDAFF6
          67404A801092FDD686ED1362712BC86F4F6023F13CE4583DD6679BD7770483C1
          0038B738D89A955B2601B422D50F47180C59DD816530FF1D28E0F69870C8A8BC
          3D9340E8C0493863EE3AD3719C0FA74FA9BE685949E4BA0E721D07DDBCDE8966
          4D7BEC523C1EDF52B5629B29A9579480B140C15838F0292AF2F9B599C36B17E5
          F2B5F3BB5EC1947888120E005A8F807A88413B2000DB31916118C7C6D7941DC8
          1F66DC741CA035DE8D86467C5D53278D3F909797F73321E206385254A161C5FF
          3450299D50A40674DD28285F20F322E59070E7146C447F70000EDC7AEAACD52C
          91487CBC70DE13AD663C463BFFB94A572D9DD76A9AE6E68AE7B7B0DF77BE246E
          5F52B7728A6BBA799E69B7314A10011654CD8FB04F5F2CC3AA5C686EC41C0425
          04310ED2E53935080013002413DDA8B0B0F072E1F0BC5D55158557268E2BBF5A
          525CB4BBB4B4F46F815E66BE2F109E6F033BB12B7F347AB6ED720630528005AD
          66F8E3CBC7F4B2E08273CF45028808853BF03BE038493070D0989AE9ACA3A3E3
          F337D6AD98CCCF3879F2E4CEF2859BD8F92FD68AD20BE5976AC0FA6CD736AFB6
          B5BC77B46A79D3113F53EAB002007403F923F94BC0EE4D5002C0882843962A61
          345812BA96854C33816CDB44D5D5D5897038FC2EE8FBAB3F3D1DF75C0F49F115
          D7ADA9774D3BC7B3AC668EDB4DDC6AE69522F240D390A2EACFFAC3B93A3FFBAF
          036F4318288FBDCC07323003ADE77EF8DF4BF8E0828D67D3C831B469FA157F68
          AE15EB416EE2C6B730F6DA7FD9BFFFFEC94B3721ACE860C759C81DFAF033F5D7
          8E357DC559A004481035484033798AA51097F25F51BF975AD68BE41B563E3902
          A4D613DBBAD5F9EB97C739805B6DC7E3F74D58780863DF6C9E075AD080923478
          327E0DEA32E222819F32F04F33FE3312F52BB297FC477FB472FA9310AA219E95
          6C717BAE11C90AB2629D2D3C0C945170EE87640C4D0B8FA82DE00CB71FD98845
          09CA6AC8180085B813F180D0B49D0AF4CF87200331891F61AC831ABC6D3FB1F7
          2762BB31EE80F29234C27E3D5AF15CBA24C55B400588CC4340853143970F6D10
          F4678FAA8D209F3A53D775A41657EE882CFA84AFCBF79E899B0BC660D6AF8710
          80E500B891D37962338D3EBA86472073008232467B932FFAD0CC063769EAA613
          037054FAE66D0A849E3584BF03A22F4A3218AECC1A555FD3DD76F09828498F1B
          DE01038478C28904E0C7AA31CFECEA42E6F58B4B6F9EDBF70D4F40692A1882C7
          293CF2A9774EAB9A9E2D580867239F1EE5C9780AD4BD71661BCBA95AC6324F42
          60A0FDF00722F6396553A398B2299E95B012574E7C0F7371A93DA0DDBC25763C
          067A10800BE6B4401001A8B9108A90641A77FDB61D670CA0E3E8462CD7B5AC92
          897380769D7AEE29BBEB6212A5B874250B442AB5BB3B0F8B3F21517218E9D9B9
          39E19133E6CB84F5DDE93721D6A3A30323EA1A1BFCC6D0D7B03F80B470B696F5
          40C3237C4D6A5A94E8D8C5658A668C10254FE197B310C942E182B2C6F0C85973
          78546EB30FA9830108E656443CA2EDF1BA6EC8AF323C5E0D151C825E48026069
          5B2598FF916BB2098ED98E52C6A9062356A868D93B60D89CDED3F7936CA08F52
          2C516BB2554099A4DE96F4A737ABD22EC0FB7D98A5D2DE927B19970C1810E2F5
          1E20453AA5B265122891368E18F717266CE49E4C4390362403AD6760D77F4F1F
          F917E3A63EEA3F17919C0000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F40000001F744558745469746C6500426F6C643B426172733B526962626F6E3B
          5374616E64617264DFCD2ACA0000076749444154785EC5577B7013C719DF7B48
          3AD97AF825D9C6100C18074829A104C86342A3B129656270C769024CA169D2D0
          4E1B12D27A78662684C224664CFEE81432ED2493293464483243306368F38010
          1EC193D0623703136C4CC0069344E8614B3A9DA4DBDD7EBBBA3BD4985AFAAFAB
          5969EF76BFDDDFF7FA7D2B81528AFE9F4DFEEE842008A869F93AD4B9BF5DC823
          6BCEDF5683C69FFC8622929D25F0610F021B138A8E1F791D998ACBB7133EF4D6
          8E4EFCB7975C6C112124778A09FE2F6009587B9D0D24494A816C4F269339E9F1
          782E069A567330845206646C0B401330C6C28A5F3EFF80964A8F9EB780F06FFE
          6BB3497A79A95B63AF645122F553260C3F70EFDDF7CF9E356D652A953A313C3C
          BCE3D19F6F8C93AC027901F0565559114F2635391489B914450149D3D694DB5E
          4B69281E8B030082322951A684BA24D9012E24E844D7179E0F8E7F36E1CE4935
          A1CDEB9E92CBCA4AFCAF6CFFED9AE736EFCA20F2DF00C4DB29278AE2C557B6AF
          3DB0AB7DDDBF1E5D1AE84B269388F20FE1F218BEC2A19BA8EDC5A7FFF9DEBE9D
          27DF7C6DDBE996A687FA304E13B6A54DB62197CB8D2E5F0B963FBBAE6D6622A1
          CE80B6F4D4077F1528C17901A0258FB5FEDEE1703C450869BF7FFEF7437A4667
          C1C33B0CB81933E914AAAF9BA886C3E1C79D4EC78EC75A160E02D84BC9A40A20
          012826E01A1B0A8622EE37DF3E540DDB06A0234CF35B802F5AD4B29646A3D12E
          C56167E1C34DCDDD40291F534258C6D0DADADA0108B44E08B89DCD0FFFF09B22
          A723853100A659C08A528C3E3EDEE50365EE60F145889E1F0045183153C562B1
          140F34C201643543590BE830CE4D43AFD7FB3E00FAD657EE5171466796E27B08
          A2888686869C18674D4F302D0000BE957ED4885C420DF3E3ACF644B77C293CB8
          F0710E0264AE3A1D0E9DF0F584CBA4D21A521C366B31C8E6CF020CC2B9D18A09
          E1C8CD54C862C116279CFC708FB065CB16112C304DD352129317A8C0D7AAB111
          34B1C69F84C04E64F7CE14600142B9D61003FC0062FADDD40C3AF3736E6B6D6D
          5D0C39EFB97CE59A471245BE8796D4D0703482963435DE0070837C6B9C9707B8
          7606D3584167BAC478CF806064F85504A00138E0D903878E56A5755DB60932D2
          B4388A8682E8DE7933BF6D6E5A1802F94333E735012EBD0022E228490E20330B
          381BF029760844BE0069B80FE6AB0E1E3EE67FFBDDF727A701D448348C926A9C
          3EBC68C1F54DEB9FBE02E9F877A7D379FAAEB98B0B8B018692E45A80609ED75C
          738382DDA515E8E5F6D7A78A9234F5CBFEABDE5028AA3090BED2E2C4F47B7E10
          59F6D32537EAA6D4C6C1F7FBDBDADADE983E67116C8339F8FC41C835B6489F3F
          732B18CF261F9C3EDB53290AC07C7605C9924CEF9E3939C826264FAA550DCBC9
          00A06ECD9A3553B66EDDDA7BE7AC465A502DA084B06E553F36262611A16C8086
          82D7D1932B5BFA31A6E2C0B51B45E72F7E557AEE8B7E3F9339FBEFBECAD7F6BC
          87EA2655477EF5C432F7FC79B3E7C4E3F13697CBF551DDF702341F0023C7690E
          2FB0BC070002B70CEF9A1A47AB7ED6F2354C1F06DA9E178D0E57FEE92F6F4D3C
          73F6FC3859B6235BB18C068722A5BFDBF052C9EA271EE9FBC5AA659B82C1E080
          CFE7EB655B8E95865CDB0CC1B73800C63CF5082728634C58DDA75555553BBBBB
          BB57959595EEDFD4BAFAF2F4A977DCCCA4D3D9BA01EE71792B843FEEDE33F5F4
          99CF4BED76FB4A465C05C480CE4D0D542C5455731E808EAD3B00328808FCCB5F
          0402014632BB229148C5234B1B3C3D3DAF56088AD37021414A915778F5CF6F4C
          983F77F65C13C0D81630A2DE6CD46042FE6B74944344F5B31A383900E07766CF
          9A11E3CC4189C996487116A373DD3D2518E3E28E8E8E2206228F05AC74B14888
          130835DF718B58E4D4DB735430D8B077F7EEDD58B68918C0CA88AD6342D01389
          843432129300647E1798516F0132EA3BA77E230B30A6A3E4366CD8500E73A2A6
          6992CD5E9CBDFFF1B5E0521077B98AB1DBED2E200B3066C75875C1EAC84A4DCB
          BCB96DFCF8F1F75C1D1C52744C0489624B3E191F41E5E5DE34C40C696E6E4E16
          540BBEECFE5070BBB72A04D43623DF3A8F8F2D0002EB7BF7EE7502E5AE3871EA
          F31211898862C3F81843510BA28605F32300E01BB3C28F05801F0E03116E3B0D
          37BE0E4A5C7762109111178220F25A70E1C285FB4A4A4A8A20C59687C3914907
          3B8F8E87FCB4A87C643884045DC56B9FF9F53500D0C5F4CB7B2D87B2BA11FC38
          037A6DC7E18FFC50E9B216C8A90FC5EE0A74E41FC7CA172F0ABC3C303864EFFA
          EC9CF7E0E18F6BA2C3AAC2D29371410C0E576341FA872D1BFBEAEBEBC290A6FB
          461DF65D3FC26122446CE773EBB7CDB9D43FE0BE19893925C99E5B8A2DFBA553
          49CE19CCE43C6D01A88E3328A32590968C237F85477DF1858D971A1B1E8A80B5
          5EF0FBFD277D3577D1E0F5F363FE33E2939F7C72AA4C4D2461DE48254A723040
          E76FCDBB4196BEC78DAB54BD3E77A676C234B5B16141F8C73F6A88288AD2AFAA
          6A7B7575F5055FCD0C10CF5F8C2804133DFBE99133CCC718E35CD30BA3039698
          8CC86FC9D0AEC0300CEF2EEBBA7E0A2EABE79868051C6E30695E1798912D9A11
          8E0A6FB9114EAD3EBA8DE5024B18177AF868D9C2DB7F006F690130341E0B7700
          00000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F40000002D744558745469746C6500466F6E743B5374796C653B4974616C6963
          3B426172733B526962626F6E3B5374616E646172643B3D0F11FE000005314944
          4154785EC5565D6C1465143DDFEE76FBB3FDA102B5D296B6DBD256F929C600FA
          20D844E34F6224819437942778304612135E0C093151DE488C418D1105A3898D
          C4606223684234A05124620C02D2EEF607BAED9652A5DDEEECCC7CF758BFDD99
          362660993E78379BDD4CF6CE3DE7DC73BE594512FF6745709B524AE10EA5B0F0
          320C492E18805F4F6E7B09A4E4A709F1D5E76F35903CA6B55E8872864428141A
          DBF2CCAE1D77AD8029D15004A4C0C0719CA5C9C191D82BFB0F6F00149422488F
          64E13B016A0D473B282D51B9E31F1DFAE2CCC9630A38CABB062004E8DF38DF9F
          BE3159B4BCBA7C6AF2D6745928140D4379F2122244CECA429C9C5EBEB432BB6E
          4DEB4DFC4785EE0840C43087F914D3F0C886B5E7DE3EB4EFEC9B07F7FE64E76C
          0869005000DBB650551E9DFEF0DD033FBE7FF8C099BD2F3E7F12C0A94D8FED60
          A015901AA0028520044F6CDD73E1DBDE23BBC7C7C7DBC2E1D011428C4C2C78CD
          CA66D1FDDCE6917BAAAB2E2793C9973B3A3AA6376ED941502308007F30585002
          0A8F3EF5022B2A2A9A2E5E4A94D08014CFE6709C1CD6AD6EBBE5BAEEF19DBBF7
          4F6DDCBC1D141742060320A201704E6602674F1D55C03BF1BE816B3114AE8384
          169A9DB5B536CE388E73895A438C420A840403A02966FF202020D41C93F8C0E0
          680C409E1D05B66DA366D992997038ECF6F6F60E69D1203C7F040440AD0D3B16
          1C4EC207703D958EC10C1073DD756CAC68A99F0130D0DDDD2DEB1F7ED64F0785
          4101886168DA0B83FAFBFB2B492E4B8D4E940909956767F6DF545F9B01900060
          588BE959040023A347DB480AD4D6D6C66F4EFE15F9F3D65471241231CA28E623
          D8D2D290D15A0F00802B2E2084105044D01488192C502088F3678E2BA58EC5AF
          5C1D28A7886F4C11310A74B4B5FC03A03F8F57FCF591013D20DA851F35FA341A
          AFF60FC708423401108E7651521471EBEB6A73D3D3D389FB3B1FA79720D31734
          866E210180F82C48B60C0D8F95818030CFD2CE59B8AF766946293535BBA21BED
          9D5D00E9278412780586457E9710EF31DC7C2D3516F3CF09124E2E8BFABAC60C
          8064BE4D83BEFB0514060740DFC9403A9DAE21191B19B9514621A8CC3863C078
          73C30CC9C41C302918D0400F9802ADFD63F8F70BDFA8929292F8D0B554493667
          45C29122400A1EB02DB4B7C6332252005030A0379C8B882108FF280D85422D97
          AE2463E61A753E015AC3C9E5B0764D7BC675DD4453FB26D28BAF6F60047F1670
          1E0392F1FEE4704C2850DA086086572FA9B02A2B2BDCC46C9978FECBFDC16368
          6EE6DF48CD56F3E0702A46B220338CFCF1C69A1900A39D9D9DD986D68700A1DF
          4708C8C02674CD6C82E8E9E989906C181A1E8D5108510440D876162B1BEA3224
          9373C635AC177F0E88F6141074757535672D2B3A3E3E510A158210E69DB32DAC
          6A6D9A11917C04C5632CF0C5A32C2686C460DF39555454B4F6D7DF2EC71C57AB
          7018BE375C3B87073A5665B4D689F90A8084F742E0185263B8EFBC3A71E244B9
          526ADBCFBF5CAC22E7C50C80B82EE2CD8D562A95322B90F9AEA7808B8961DFC5
          EFB78AC8D3B66DAF9C9898ACFAF2E4772BBC7FBF1EB158653573B61DAAAFAF3F
          6859D604C9371A5BD70FB0105F054002C65089C8F6F73EE8D9F4F5E91FEE1D4B
          4F963A8E8E28E5CF0629881697AA5D7B5E7D30446BF5EBAFEDFBA335DE144A5F
          BFA296AD584590D06678D01490F8F8934FEBAE8F8C9582DED19B672F9833DA18
          50AC1DAB38120E735E84FDB90C0A201289F0F4A9CFCEB9AEABB4D6B7CDB352CA
          FC76D6A8CC66B3DA03EFCD0D6A4246A3D19D0094792FAC0400AA6BE2C47CE983
          79C06FE50201F86326D3092CB4FE066A0E0DDAE0BAF3C20000000049454E44AE
          426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F400000010744558745469746C6500556E6465726C696E653B679977E0000006
          C449444154785EC5576B6C55C5169EBDCFAB3D85D2960A2D503CB41ED22254A8
          702FA4505EB16DA0F26A10505001BD17F4020D01F58F981262407F9094044342
          4021A088E2A3228225042B0A8DB93C6E8112E8054B4B4F397D1C5ACB79EC3D6B
          9C35673FDA43BBA3F187733A9D7DD6CCACF5CDB7D69AB58FC418237F67B3C70A
          244912C39FD0C162559863EC3A73648CF50D8052BA834FFE1317F4C50E008851
          9665048BE385A285FF7913979EFC62570500E4F28E7B1F3984CD66637CFD95E9
          7356ADEF8F01DC3876E9EA77F2238A6AEFEFA0080C5420B20DD46307DFEBAEFA
          FA03292AAFC89DFFC29BD36564516244C7CF28231454127CD84D4E57EE21E74E
          1DE00B3E12B3725F9C668F1ED9969234F0A12CC9C4E974F1EE244E878B387847
          1955143230C1111C9793D916BBD79B99DEEA763B821C015FEF107E088582C4ED
          B405C78DC96CFD2331706ECBE695AD00F0F89163A7877FF9ED8F4FC8369BC601
          23A1488814CD7CFACEBF579636704A1BB8F86A41F16AA61154FDFED60D4D8AA2
          8CF8F0F0F191274E5FF03CECEE2605F9B98D9BD6BDF47FBBDDDEC4F5D7EBB6FA
          64A0A874C3BBFCC42F03C0AE67664EBC4F810A2AF59850C361523A6F763300EC
          73B95C2FCE7A76CD76B40EBCCF98FBEADB5CB682ABD95B3C7B720BA52A892821
          B2FCB9B94D5C76243E3E7E396765CBA4698B99450C009935EF35D6DCDC5C959E
          9EBE9E01AE05C39F402949494E543A3A3A2AA716AD62080A80E20CFE61C3BDDF
          A5A5A5BD82BE671448DAD0D4B0CFE73B8A7379F9A58C52DA3F030C50914AB2B2
          B2BAF48063101D0119204C644046464600C100553135080245F093673CCFBC5E
          6F5B5417259446917359FB84FC450C33041825160C5034D80B101AC70FC15105
          4C4513AC90A3521C49AFD445198062A424E360F1914BFB070068803023E799E6
          96A87E10C662C182581E05AAF94A42A302604F40C812A15C66910514586F4040
          79B7A139FDBB714AAA224023D90918E04C83949AEB8151DD9D160C984A74EA0D
          064422D2180618D3E34367C1D88B06A9709319C08247B06080698BCCEF4040C6
          EF517AA91940121A10CA1810FC100126267E048360BA545040AC8350CB274963
          0465060340991154A0B940FC3719308C81C682E912CC18D462E50230B3000D01
          3033EA99A6446B9469A726628F9129D80CF0B40728AA07B515002AC23A26D265
          AD86EA8C30F3447A86E007F0A1B72EE8E5323D53C0E222528150A06610229510
          A53EEA7310BDA2A2C22EE6B4AE1B4350624ED02FE4BD2F39B1C68201CAF0AE93
          7AA60563402594E9E843E1B05C58583878F7BEAFEF0991CE0A44B3262727272E
          1C8EC818D0922C31236640BF47AC0118F368DA66B751CA985DAF0788CDE7F33B
          87A50FF1D45DAA6AF68E9D8136715628AFBF562D793C7B5383C1908C4CDAED12
          DF8E4A1127D553BB5F171894E206499282F16E970A541554A202D96627D76FD4
          BB79C59C68463BC5F435E84E494919DF78AFC5A5AA0A89773955D483F2865B35
          92600BC01A806A56AB4072524210801A978AC3E922E76B2E27CBB23CEBCC9933
          09A88C529C07D191233E37F3978BB549A04678E51C14E6B2DF7062F8A8094C3B
          A0D5554C8D28E5C89B72BC9ECE5BF58DC95CAB2824B26C2735FFAD7DACB5AD7D
          485E5EDEA6154B666F2B2F2FD7114B7EBF7F8EAAAA4F55FF7C2935140C9231D9
          933A39201F322A0C6B1963598CCC9B985D2E292E985679E287118C121BD3AE27
          45951C5BB7EFF66E2FDF08656565296BD7AE3DDCD5D5E5E7D497F0158B0E7D5A
          9956577733912A61B66CC97C1F3FC8FF509F5EACC0AA1A32EDA2C9CA99CA82C1
          E0C9519E8CE58B4A0AEE1CFAEC5496D31927E66C9C8DDA6BB7535FDFB8CDB178
          6161D2947F8C9F98989848AFD4D6257C75FCECD093DF9F4DEFEE0A90D205858D
          A3BD59BF0502816FB462A4974E0B003D2E0BFE56E3E727DBF3AFD5CBCA644962
          073EFE6A940AB2CD6177E02B36B973D73768C7CEFD83540AA2D6AB4A84284A98
          2891205BBAB8E4D7B736AFBBCBE93FE8F1785AB400D32F34A33DF2CB28337B0A
          B97DE33CE6ADDEE5A6A6A6B97171716B5AEEFB933E395A39F4D2E5AB890D77EF
          25B4B7075C20F6337C03A643862487264DC8ED5830AFC89F3BEEC92E4AE97EFE
          5A775833095A27838765B3D6A6EB7D0390780B85423B2391489EA22812409411
          3E4A3CB80897E128BA568AF57DA2DBED76C6C1301CF9E9F51F308CA72DCA2F0E
          1830A06C70DA68D6DA7C23D6052606345EBC70D534031AC3AEDFF3FA45C20C39
          98BC9ACF661353DD0F3AC84FD5952890191105A27F003874760648D783075A75
          334F6AEA36AB9F10F561D8DC2B04868E76DF4D620500387D17CE557D4E38133A
          CD317A99D4D705D65F4337701700EF355A1C5802206EB7FB0DDC6706E25F6F46
          10C6B4DF01A41010C6A5EB50AE0000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F400000010744558745469746C6500537472696B656F75743B61159CEF000007
          4349444154785EC596095093671AC743A90E5539952857B1A0505021E1325CE1
          3C02011208817016410E45D47AA032B31E656A8F55EBEAECE0B6B6B4CA62A55D
          A9766ADB51C00862B6D652B57854EE53390C875C8EF0ECF37C6B9CCC0EABC9D2
          99FD66FEF341F27CDFFFF73EC7FB860500FF57FDD780175C3ACFF4CA0CD25193
          EAFAC30074464747B91313131BC6C7C7FF3636365681923F7EFC98117EF703DE
          8FE3BD189585722D2F2FD7FD43004646464C9F3C7972008DE555F27FDEF8E02F
          273A73DEFE605896F1A7C9C884AD204EDAFE746D7ED14866DE3BC3EF1FFAACFD
          BB1F2EDD440039C607CE1A80CC272727CF3436B52936EF3AAC1425ED80C8F8AD
          E01B960E5C5E0C387944838B9704F8820C88966D87E8A402F00E498392935FDD
          C18CBC45999B0D800EA6FCF0FDC656852C73F7A438751744A181877F2264E614
          3CF8E95AFDB5A1A1A1CB6D6D1D7527CB2A6E47C4AE9F2440BFF0B5B0B7E8A3D6
          E1E1E1825901E0CB97519D37161C528A5376414C5A210408B321397D531F19A3
          41617373B3B552A9F4C74C9DB958555B1F2C5A0F81C25CC8C92FECC1988FA839
          FF57001D3497FE74FDD6F5A8C4ED10935AC8C83330158E979CBA830045EA9DDF
          DDDDED804097D7ACDBAD0C458858D93A25C69C9E1500BE30BBF8D3F2A6E8C402
          A00C8850DEA16F41E997150DB8EACD046065EBC1B2B471679111C61F7AFFE027
          2D3E616B80E72B1ED71A4075D938F01980C1C1C19CFD073E698F921580287927
          507D434479B065E77B5D6856353030B082E22CDE7065E2B1E9522BAB6B7FF1E4
          8B461392727A31835F12C0620B4716DBDC51F5FA97032C75F07E0E70F0C8E72D
          9109DB203A71076029A8D3A9E3A77FBC20FF150DCF63269C29D6CC9AC342A837
          7162BE409093687E02FFDE4D606CF337598BCCEC3507B0B6F352AD28F9FC8F97
          6E848A3640946C1B239AFB08E9160812663EFDF6BB8B37B0F92A294E7D1754EF
          0D325EB4C48E65B264B9E60056CB573300B43AD4E5C8B8BC313215C6A3A46F23
          006933F845644CEFFFB0B8856210E24047478789BAF1C27F1BA396B14CD8CB34
          0650AD40572A95CEC546FAFB3F2ACEDFE405264F874B3641781C0AEF82D88D20
          906C44882C485CB355D970FBAE024B70EEE1C38794BE57FF43BAAAACBC0C8036
          9EA3B4B7D39CD3CAFAFAFA6A3A3B3B6BCBCABFBD2D90E44F85A171586C3E84C6
          6C8050713E6A030446E580AF20F549D9E96F1A7A7B7B6BE8196CD0E77AF4E8D1
          651A517A3779BC08E015320F8E5E0F41A4A875101849CAC1FF73D1943104EA89
          609C06464C6C2E42E4826F7806F884A5E3A8A2703BF62205A7022F2805CC6D5C
          8020281B2F0570F58E03176F0970495EB1CC9ECFE18981B35A0CCEAB45E0CE4F
          0057FC2E00C10223B32100E58FA27290788129B0C22D02EC39A1A810B0730E06
          736B8E46004C09B0B3E5947E4A1DA5505D94DE070F1ED4EE2B3AD8ECE4113145
          1B939F300BF8116B310399588A4C70F34B00892CABBFB1B1B1AEABABAB969EA1
          92E2683225D0B809A98166128248718FB870FEFB0BF53CBE788C1790043E024C
          3FA61E85E94F07075CFDD1BF7E7C177BE2309ACE41E992B9260038B7F624668C
          540F99B06D1938957065F6342177EFDEBB1A10163FEC81104CDD835141A9E0E2
          13074102C920C25E54996BBC0F2C5CBC9CC418DEBF7FDF9484868B5A5A5AF40C
          175AB34804A150280C10A2B8A9A9B9CE37488A9948A1FA3322204B1BCE144DC5
          D9B367F5B5023066DB3006B89596503FDCBE734FD1DBDB57830D1A42C6062656
          2C03134B26E6DCB973F3B0574A8F7DFCC51D376C4E32F6F04F02777F19B02D1C
          01E1EB4A4B4B0DB40230325DCA4C04AEEEF388B8DC51076E081C3E72EC1ED67D
          3F7DAE6F64C1D2373267E91B9A31103D3D3D7EADAD6D575C7D24D36E684C4DC8
          C1293135B39BA6CFB5067816ACDBDFDF7F4228C91A71C57A46C5A40DE025A71F
          2064BAC070096B3E8A62EBEAEA2CA8DBDDF971532EFC7870F19532A367EFE832
          861320DFB3678F9E560086C65674D3C5878F67E4163C74F79381ED4AFE7465E5
          A5EB98EE3F676767CF216335D0776B6AAFFEECC413E1DE210567DC3796583941
          56765E3BC697518CDE3C63CD0F234A2FA51A1BA8706FD1A11657DF787CA90884
          E234655B5BFB15342CC6DA72EBEBEB9722E43E5A7DD29A2D031C3476F68C016B
          7B4F30B7B29BBCF7FBEF57713FC92050BDD78C340758F00C00371C5969D9D7BF
          71BD24400D462B0C15260F9FFEEA9B9B743E90AAAA6B7E495BBBADCF9927C6DD
          4F08166FB88029FBF5A71515677F45F38AEAEAEA050430F73543CD01E61B2C56
          3597FBAD5B0D0AB6E50AC0231AEC9C82C0D1351C1CD168A57B142A121CB86160
          E3C807336B673058F83AB8B97B0F55555FFA191BF67BDA2B54E673F5B40098A7
          CF4699B2E87CA7B3A1A6E6CAB53D7BDF6D1444C4F6AFE27A3DB6B5E34C18185B
          81BEB125CC373283554E1E23B2A4B4EE53A74EDFA4B9C7951FC1EC58923919CF
          D13320690CA02E1D7A11D6391AEB5E84677D0966E56B3A0BF057F0739129EA38
          6A537B7BFB4AF5B35F4DDA03A82066381FE6A86BA61F1DA4D902BC006806A95D
          DA00FC0BDD8FA49F653D86260000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F400000018744558745469746C6500426F7264657273416C6C3B426F72646572
          3BE90A127D0000033A49444154785EC597416E15410C44CB11EB44096C218950
          064EC145380D17E0345C837D7E4480EC9328628F0B986EEBC9C3ECD3527EBAA7
          3DE572D9EDFE3F6CEB39C70B49FAF8F9AB25697C582CC6C4B6AC90ECB9C656CC
          6595492A15B27320D892424A2B27F8974F1F62255038CBF9B1546A4C678E41A4
          5E024CCD71B22E1B19960316BE3AFC78EC0A448CC86EEE7E4DDF20BA006B0D19
          5DBD39D1E1EE4972114521CFB91C4A65BDABE5F294205000C997D7C7934ED186
          39D158879F4FC320A5AB8B93103672A2864C0087EF8F050B01EC560C65480121
          314546298812B114C6DEEE84C1F18E02E55E56D8729541428F77CCE756A98134
          64C192FCCF7AEA049099BFC28861DCE49DCCA8FA921812D41F730C600F010CCA
          2B4537D7B1020736E55C1099149937E210350C7484E108DD9375AC8EA57096B4
          1D88F0D586A326FC73100C0421D019BAB1CFAA0EA712156932A922C3F9979595
          16D0E5CC819B3BC7103183E682376C60A7B494C2A91DAD1E9817056A6C4B00F9
          E12DB9A9DCF298EDA120D68B8F54B0DF15A88D0274E90C76CD3B135246C48883
          439E9122067DA0EAFBE6EEC9B45E4925F3361586D4F5DAE120E3C4916A1D30DB
          3D862969393F913264552F0DA53C15D26E6A96CBB37A04396353EA384C9FD14E
          1186D7FE4E23018CE8D50BEBDDE54B1D6E1F461F3509CB742B46098CE5ED2BF9
          7F05005F2E4EC39BDC95BC1089BFB23FCC54AD375CE02864B9EC5043D6F5B77B
          58750528229C2377B667C1EB2DAD9E7B06A376C352CE34C8BB0A74B92650E7BA
          69D5B69242AD28590B64C352E1601305C82D120258D22772A18053DE16A1B6F2
          634FE3A215737C28BA9D5B90CEC0D53A729E4EF628D2BAB214A498FED014C815
          4DF9BB1CA1643F4EBCEB4C0535A34C31B0A7C3484A27A70A02253B1E0C49A86C
          5A32310FFB08C94980E081C2DCDB224C22C78EE80C964B521B4FEC35C7B8E94A
          32508066D1591235F9646F1AB00E7A4AF43CC262AF153BF7AE4FDC7A43C6B15B
          ACE11C242C85C0438131C96D0AF8D2E1B5C395339C2070DD9636925FDFDE9B63
          8A928E7E8C15254DEC34A2B5B79FA94672862773C0CD5CEFE9EDEDB9B87C3807
          E06C53A07F572A00FC164405197079FB050662CE7679F5D49773C6B3FF3A3ED2
          338F3FBC70850938E77D2D0000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F400000013744558745469746C6500426F72646572426F74746F6D3B5F0C70B7
          000002F949444154785EC597B1AD5D371044CF0A0E9CB903872EC3C5B81297E1
          3EDC890001B643650A14A881394E080E78891BFF072C968FFCC3E10E7797EF8F
          CA477E46E5AFBF3FAB8E20320CAA03CB8BEA045C1893AEABF5CE881A475CF851
          1CD5E818FDF38FDF07E02780450ECB13066081004604668C88B371BA3C28FDAE
          00FBEF428E75801E00DCE4820308007BCE414444611159F235BF80CE9A8B0828
          18370EA802C8940D50D435A684742C826CF21E00346BB09C9E065B814F000CCA
          94A464CFA86B91A8C500B34144906084ADC4A100470EB036700F240AC81643A1
          72F7EE11A6CAA46A20BD8604803B0700854170130A3CE5BFE65C9B91EB1A2CF9
          C283247BF3BB0A40BCEEAE8435D05689C30695B4164BCE8079E480A2910894AC
          9150E29AA83280622088DEE40BBBC8AB7115A0552067B6D7A8956800B231A7E4
          D2C46C30770E80AA4C4CEB9E27797D6B1D8DC39AE724B9F11C0ACCA140EBFE05
          AC441986261DD3712DECA8973D1578E44054115FC9DBA362C88E76238B01D0B3
          F3458CE04B1F20CE9B6C1D9FBD398232479D97BC58A875BE0A54755197EF7765
          79B752E9BAA638D4280B8E208AF1DC1F3D0E70BF6A4E7447C8ACABC789808E71
          E3EA19165E3A2F74FFBB0AB85FB51E1FA4AD954B5E8539E4ED95DC4D8CE5E5EE
          8477A311A6E0FB496D441B5BF29B58EABD3AA16A41AEE5447C7F529B3B7D5090
          41BDCDA0BCBD864C01340A005A3EE6AEE767B58077F4B10713B8154085A3D238
          1B90E958585E370920EDFD29EE50F0B50A2829687DC911BA0618475E5AB50222
          73F61106F5CE81184444028DA2D7D196DB04D0DCE4EDFBE033180370FF22621E
          1BE5F99EB7CBF5AE8F127CCDFAC5582C9C0A00969C9B9C67943973E0AEF3A752
          4D685E7E0F4430DDA42088E9461ED1CC45CE839C05E0C09E9DF09FEF3F5781AB
          1C25115D9EBE6E21246240B33129069787EE1FE1E88420BFFDFA4B896547C402
          4837379C77AD24806B5D30A9525506942FFF7EE3D988F8EFEB0F14D28C6DD442
          0C0A44A224E9BA6EAC0906444C8820EE399456217CF87FC79FF8E0CFFFCE8330
          1D617139560000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F400000010744558745469746C6500426F72646572546F703B5C067DB5000003
          0249444154785EC55731AE15310C1C3F41CD0D6890B80447E00ADC098943D151
          52404947C9056690123BF3ECD5D66FA5289BEC1B8F3DB19DFF43125EF92C07BE
          7CFD2149908035D73B054120F71E732DEE4170EF119078303406CA19B07D0AF8
          FEED7300C01BAC47F8F8FE5D11EF81042640B071311D7D364A2C206B8F840007
          051C7B3F7FFDDDB4E58004FCFEF36FCD4C52C951AFFD8C1014B8F6E9EF526137
          313300329D57EE95EDE80E7CFAF0364A22C0D19773338A8A1E4CD21AA5940824
          8E90312CAC9FC79A0212A29314399AD4CD18251903200E2823E7224591DB198D
          2350200DE8BC6CA99B3269DCB9A2282711CE0B5A0D272D0012387C76E0281D10
          4EB41B3EE5BFECA98CB11D4361A6EC02798C47534080A3B5919E03D2AC9458EB
          C00199D4A338C9548A8896038B87F94393B5484CDC1C529DBBE8841BE4854D72
          6B6C05B61C8E0037518F1E71E43F982EB9E0C4ECC93D73403B168A901D19E49E
          CF8906242A4A3574922B1E4D81680A9401E8069C55110838E9107EF7201CF51E
          5381910354C67525F79C008AE089F6208D2972C1C7C13DA09B3E002AEE64F3BB
          15022AB910ADCE4D6E2CE0E1FD5105801290F3F31AB57F94E2F3771A87B54C3D
          AA2AB702DD3EA451868AF22C0983D289105147AFE00E2544755CE544E205EF0B
          B0FD6B1564842687DDDFB35BEB94772DD3E8E87EFD229BFDC455D015E8204423
          6B89D5224AEC24377606303BE17A0C2A81C8D6DBFB70EE5485244998B80DDAFE
          F53644180047E1C6E0721AF53CAB05E398AC4AF8375381C4A3551A7A0312FD2E
          00CE76B9D1C0BD9FC635056FAB00266D1E8DFEEE6F00448570D3AA552E45EF23
          6BAD6B0E5044C542380A5604ADE53A01C4496E67FDCDC12C80457615208621CE
          FBDC5DCE67DD4AF036EB8BD15858012B6FE357F219257B0E5CEB7C2AE584C6CD
          DF032C6298DC17106D482D9AB8906390230168D8AE00B91133E1C83A33CB0CB4
          FA165BF936998F53446F54D71C80429AB2CBC45663B46505205FCFB6DB5A7A31
          5A8C5905F4AD56B43C6BDF621CB7A311B37A6B3F8E66483C7AABC1CBFF3B7EE0
          C5CF7FB7F93A90C9588B5B0000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F400000011744558745469746C6500426F726465724C6566743B8839F7F80000
          02FE49444154785EC597CDAD153B1084CB5777FF3260F3249240221176444204
          64C6920D21104415524F693E797CF67750CBE6B8BBAB7FCA6DDD95441FF94D00
          DF7EFE8A14494B5FFE7F5F5A4A922575CDB5BA4A4962739E84356B8DBA33EB65
          BF125DE74E569CFCF8FE7549D29B3430FAFCE93F25D1FCF380AA4E35C68A06DC
          5183E37CD67173E93BB32ABAF51CCB415FFDDE476194BA8B34C7ED4CAAD0425C
          12A9C001BCBFD730AB3ACEED7FF6B593B408201E4317549752F70250EC072802
          7C44D571375D925D0A7EB7C055960B02D8336BC49193A0DB9C1A8567F1E8A9FA
          1115D85AA03AF7A8D45306402AB81A982837BD9F9CA88CA98622DA600FDAC901
          C70AA5860F7A96FFF82D75261F6D08E0B597227B760F0E584A37397A0720A202
          95D50B02038A38804FA5BC730045D38E1132D981D149FB3E49F8D6434C550B1E
          9ACA2D68DF020B0039C109A8E517C152728D3440CE4F0E402E8F50CA1D9C95BB
          AE30B422ED20A7BDA8C0C6019BE895D39872464B4B904E8B3D6291F525CF0A1C
          1CF0E1E4C8BC06AE6EED02472A05DF269F2F1118AF39E0139C7DF6D95C7F6BBB
          E780632B21F8DC2B60375ADF8061D6AB6BD47C65CE73D9A0E8D148A0D2F8453F
          2F6F817B0DAD022E275233BC1B3FBF5F6B81790DDBDBA2F6FF59E5027A2F27A1
          CF815347B3325A8FF2669C0B5B5AA2C3275C794E42FABF1969617C3CA964841D
          E02730099CB7A0E0488FED6DB623902BDDF34668A1B38909EAB8059E200A4816
          E1A9ECEFE77D7EDE161D6DAA9D163AC71C68746E606414DA63F69104DBC3A011
          B3DFD89D151C3402A0E7EE9AB002CE90A97D9C15BD1ED54DB5994B547DBD9A03
          262B4516599876C0150890F8094EB09C91CC18483B0760B771E4E77BCE94A3D7
          FB157CCD7A0628B60F0ED41972803FB3341C3880D1A3525108E39C84C6588E71
          C80384A36CD9AC039C60196654EC7C0D8B70667FCF016B236A812AD90698B732
          9394B6417572C0946A041D80A906CE2E3687EB8B5FC8070744317272E0F79FBF
          B8506273CB790D791D398974DCDE2A6ADD3553ED453CFC71FA91DF9B3EF8FB07
          4EE7347079981E180000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F400000012744558745469746C6500426F7264657252696768743BF6AAA52100
          00030449444154785EC557DDCD543B0C1CAFEEC37DA3031E6980CEA88606A880
          4E90101225206A98414A4619CBD179DEFD14F9C4C7DE89C73FD9AF24E19D9F92
          84AFDF7F48520910844261ED014B6D4940F61199F7929AAC5AE6D492DBBF24A8
          7EFDFD5FFE0A7CFBF2B900E0050006079614441564BD0461EB1738B5F4C74FB2
          0424EC3DB71EC2B1A3B80C3E7DFC80CEFA7FCB00D006F7A6B65C5BEB4CC45E02
          0CAC805B6F479575DC1A094702E3003E69F4524E290410FD79A13570351027CB
          FBBCE7F2A3714E0A508BBD80046C469D458192BA2D2AA172092E3B1C7B07C999
          02A95C1BD079580080C16D07846EE7DE3E1566D8D940D2605F70A6C001141C71
          F234E99FBAD32DE0950605DCFE14ED8B9B01C34157EE30E98F0EEE82C2710A68
          161D90E8B0C4D48023527214B04432806323E71D2240DB4D70FB46C7C900D205
          1BEE296A2F031DFA91C376CA8514A6DF3B559C6DB863A19862C1008FECBDAE0C
          2DEB0276FBA7436E06D2F7CFCED49ED3293A549EB3881635C22A19967A0D8072
          5C8FE0995114C113EDF18C8FC125241DF4B2EF358A41D5336D79EEB3999EFDBD
          CF19F07EA02CB3480D0604C80E967D0F4B1DA6D8DFD3D2865C16DEBAAF45FBD3
          ACCC4978DF6A2A4A80233C895FFA2D0D1C3F6C468CEABDCAB5603BBA0D4717CC
          5B2DC7DF32A375D2BBB6061BD3CFBA6E4FEA7912DE8346408D5CF6C2EA91DB77
          82C737079F45F80A03CDA95CF11CB3BDAF5E3B8EC659B3CD5C04B39F0CA06288
          4491C1307E5C58DEBF0780443B525210013A15F75D90DCB48814DAD89E014B65
          0E6C68B051CD7968DF86BC1950A181A20F9480379DB9A14A7818D5F29150F73C
          21EE1AA008F98F7D68241DC9612B00F1024F8A1816E1F6139E18A81105E77D9E
          29975C8F169C556F09607411C380A5028E1B1C334AA6060670ECC2543AE5690E
          0045030B01EF17105A9E1335EA02C70087727FC46EDC86EBCD5D700C5D292003
          79A9D785881EE101A323071F19504993767560EFE6585639B20388D1C26835C0
          A4647401DBAD66779EBDA5048EDB311EE9DEFE1E2873969CFCFCFD0768077DFB
          7FC72FBCF9F30F4D112781550C22880000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F400000011744558745469746C6500426F726465724E6F6E653BC08E36540000
          02D849444154785ECD96C1AD54310C458FBFA88B0228830EE880354B56744001
          34C19A827C588C65CB89DEFAFF91226792DCDCF826B65FA8BCE72F547EFDF9A7
          1A824810A80694F565132C8C9933AF8E3542D434C4C287E20BA761EAF7AF9F03
          E0134091435992002810408840842962344ECB8252FF1BD7EB925CF3007300B0
          C90503102883504220A250440E798D17D0A8B1140105D3C601A30012C306286A
          F51942A62F8234F91C0034AB5346778356E00D804089265964B7D7ED59AA8301
          A241A4208929B4124B01D61BA036B03B920A488BA13072CFDD23C42893A30632
          D79009C0FD06008540B009054EF9CFB18E16F2BA0687BCF02099BDF91D05205E
          77C72DBFA01325060D1AD269E99013601E6F40D1AC8543B63C59C4B34602504C
          48446FF2C216B9889E6118C078C0B3D74A1FA8E56FCC96BC33C172E67E03A02A
          91E6C43D8B7CDB89754D831A6793DC789602B11498B87F002BA904C13C3A62FA
          D392F6BADAA9C0F1065215F1911C84224EB2BD6DE460007467BE7C357CC803A4
          F124DBF4776EAEFD62C539C089856933BE15102C40D9F9AF94B595CA99D71C1C
          6A2A054710C574EF8FAE03DC55CD486D0F89BA7A8C14D030DDB85A4FE165C685
          5977470177559BE3834C6AE592572196BCEC0AB8D7977532E1C7F822FAF1FBAF
          CA2810404A2A7864B82CCB28276CA5CCB2DEAA288A3FBF7D993CA04413C82C06
          4068F23B9ECF68011FC863D678D7021556A4B11390397DA1AC36092092D298F4
          F45C1EA380219D13DDB2CF1C601AF290AA1510899D47883B0FA8A6898848C278
          D1D7B16B3E82AA79934FDE074F674C80FB8B883836CAB39E4F969BBB5E21388D
          1DB6C53858D80A000E393739A797B9DFC01DE7A752F3A079F81E48393F1C5701
          EA8D5CDEC445CE418E308A3D54C354EE3827B3EFACBD02D16EE60ADF25733B93
          4D2EA6F71B1063D5F3878F5238D3B20176799E553BA537A365AF28C8A96A163C
          FBBFBB1A0ABA668EE89D7988D68CC233E7E143D48237DEF9F71F58CFE748AB2D
          E2160000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F400000018744558745469746C6500426F7264657273416C6C3B426F72646572
          3BE90A127D0000033A49444154785EC597416E15410C44CB11EB44096C218950
          064EC145380D17E0345C837D7E4480EC9328628F0B986EEBC9C3ECD3527EBAA7
          3DE572D9EDFE3F6CEB39C70B49FAF8F9AB25697C582CC6C4B6AC90ECB9C656CC
          6595492A15B27320D892424A2B27F8974F1F62255038CBF9B1546A4C678E41A4
          5E024CCD71B22E1B19960316BE3AFC78EC0A448CC86EEE7E4DDF20BA006B0D19
          5DBD39D1E1EE4972114521CFB91C4A65BDABE5F294205000C997D7C7934ED186
          39D158879F4FC320A5AB8B93103672A2864C0087EF8F050B01EC560C65480121
          314546298812B114C6DEEE84C1F18E02E55E56D8729541428F77CCE756A98134
          64C192FCCF7AEA049099BFC28861DCE49DCCA8FA921812D41F730C600F010CCA
          2B4537D7B1020736E55C1099149937E210350C7484E108DD9375AC8EA57096B4
          1D88F0D586A326FC73100C0421D019BAB1CFAA0EA712156932A922C3F9979595
          16D0E5CC819B3BC7103183E682376C60A7B494C2A91DAD1E9817056A6C4B00F9
          E12DB9A9DCF298EDA120D68B8F54B0DF15A88D0274E90C76CD3B135246C48883
          439E9122067DA0EAFBE6EEC9B45E4925F3361586D4F5DAE120E3C4916A1D30DB
          3D862969393F913264552F0DA53C15D26E6A96CBB37A04396353EA384C9FD14E
          1186D7FE4E23018CE8D50BEBDDE54B1D6E1F461F3509CB742B46098CE5ED2BF9
          7F05005F2E4EC39BDC95BC1089BFB23FCC54AD375CE02864B9EC5043D6F5B77B
          58750528229C2377B667C1EB2DAD9E7B06A376C352CE34C8BB0A74B92650E7BA
          69D5B69242AD28590B64C352E1601305C82D120258D22772A18053DE16A1B6F2
          634FE3A215737C28BA9D5B90CEC0D53A729E4EF628D2BAB214A498FED014C815
          4DF9BB1CA1643F4EBCEB4C0535A34C31B0A7C3484A27A70A02253B1E0C49A86C
          5A32310FFB08C94980E081C2DCDB224C22C78EE80C964B521B4FEC35C7B8E94A
          32508066D1591235F9646F1AB00E7A4AF43CC262AF153BF7AE4FDC7A43C6B15B
          ACE11C242C85C0438131C96D0AF8D2E1B5C395339C2070DD9636925FDFDE9B63
          8A928E7E8C15254DEC34A2B5B79FA94672862773C0CD5CEFE9EDEDB9B87C3807
          E06C53A07F572A00FC164405197079FB050662CE7679F5D49773C6B3FF3A3ED2
          338F3FBC70850938E77D2D0000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200802000000FC18ED
          A30000001C744558745469746C6500426F72646572734F7574736964653B426F
          726465723BD66787E30000000674524E5300FF00FF00FF37581B7D0000025449
          444154785EB596BB8A53511486FF2DD682BE804C33BE80A0282A8E5A692536DE
          40108599560C2A12348418A6B0D3116FA8E38C2F6065BCC55BB4D072500BC517
          98C2DEF5CB62ADC362DBACA0E60FD9E7ACB0F93FD6659F1C70C25A0BE0E8D58F
          00A85FD2EF22208A2EA008C1D8E65B4941D1C57F2E100A357A7C792700059098
          DEB80E3463B56381799115DA0022162894EA1E5800167DF9BE0AC001A510E0D7
          1F3F511AC770A7057A21E95828221CA9641681D8CEE9A9F5468B0CAC2CCB6736
          E39F75A03D04235C6317A210B9E61F7D40A6262B068060B1CC33B50E6FC90184
          1015A0293152F597DF2397F7A901446239E1DC91ADB97DD3F40610835290A9F7
          F05D0E40514A954130135D38B60DA984FCB307C5D1A9BA8B6FC7EA0059F5200E
          54A68BC7B7E7001BFA5203C042E680CEBDD74845EA22AC7AF04B21B9DA2776E4
          FEA4987B75D048C659457F6904A0B7A833D37DA075EFDC7F03E0D2DD578AB9FD
          52CB75EB85B6FDE6731DDF1BCF00B4AE0D9440FF04F0D095D1F9A59583BD11FF
          87F6B406B30B9F66CE3EB15033F007BD485EA23B436412AA9D440FA22F48D539
          B90B896286EA934CE6FE5EF71CE07E01007DCDD43DB53BF787D955635A349204
          E033932AEA1D25126B4DAADEE9196412AB0F2B4021C67B5C2F3C452AF76200A2
          3A99FAB37B737FF7AE33D08548D5BA3EF8AB7F340A3816617E6E5F6E4F778CD7
          16415124B9BF3DF41C69B86605291A58AC11008FFC59A62BFD45102C400980ED
          DD34B5C19842C23E288D63F5F6E6F706F75DEE1C134A0600C4E76FAB7490EE8C
          148C640023074063C747F183EDE2843571C06FFBD26465F835BA250000000049
          454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F4000000097048597300000EC300000EC301C76FA86400000022744558745469
          746C6500426F72646572734F757473696465546869636B3B426F72646572733B
          030CD03B0000025A49444154785EC597CF6A54491487BFDFE9F8177C03F7F11D
          74E204B73AE84A37F31C2699A6094D9B641EC48528C8CC66C08DA2F812BAF50D
          844960FA9EDF2C527435D5ABBA24E483BB3875EBDE7BA8FA38F7946C73956C01
          E8E95FAF0190442648C214122C418242D865CC819B674060484344400A005B20
          48030A48FCCF8BC7AB04B0C4EDAD6F6402010464C2442201219020A92F84D53D
          138832B68498085B6499045A7D4788D3B36D809A80D290F0DFF20EEB0C8C4030
          2415B1424058605108004CC9F6F2215B070A68225802C0D2772FDE36FDA84E59
          CD1658783015FCF7B3E75C10FAEDFD9B1A45B0B90545904EB4FBE71EBDB85C85
          A040D28D3FBE3CA11721442BA1842C3AD1AFC707A32CF446020981E8C49FF68F
          E8C5D2A6036214DA3D9ED28B73D3815AE57A1DD85FD08B4284D44A2832E8453B
          AF668C21DB2D484330A1137FFE634E2F26A8944029968369D0C3E33D00ED1C1F
          94785AEC9F01E897C521801ECCE7E7F17C713E7F7E54E2135A64E1F5D0464FDE
          BDE5E6F5EF0C7983528A2FBC129652CC30DCE2F4DF6D7FF8FD5175C004C90807
          16737A918589464283A47E07A6FD12A6BCE90008A7E8A2EC792F6AFA813AD88F
          BFCCA6F4224466B3022908891EAAEDFDA82D44A45826FD0ECC0EE8C5D6662976
          688C84BA7F78C218D43AC030EE6FF8F5706FE4F2B73D61081250D3465D0206DC
          26E001F25AD3405E1609D116A2984471E0F2C9005457A06995452530A014446D
          A59DF5846383D07A0C801151E621611B494CB67E02906E1248E0F4ECDEEA9C87
          8542D8F5C348C85A2590165ABF87F050BBEB921C000654E6A459E7CA4FC7C115
          F33F92040460845C57D70000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F4000000097048597300000EC300000EC301C76FA86400000021744558745469
          746C6500426F72646572426F74746F6D446F75626C653B426F72646572733B30
          AA16590000012049444154785EED55414EC3400CDC5940FD4AD527A092C2B98F
          E017288AAAAAACD26ECB537AE6C64BF807022E5D63AFAD5639C22525DB519259
          D79364D6B51C1091EB135E0877EDAA0F169C51057E89BFDE37B00ADCEF9E0AAF
          C0C3AE2EBD0762537A0FC445E115A8D6CB4155C0F834E1308B75E62A36162F34
          1F971DFD34048D43ABFAB0B1789BF9F6F965A05FC3AA0D05CF01FBCF4B9F0361
          F3EF2B702D84F9FE3547E980638600BE482CCC8731083947A47941E2BC877794
          446EBFF179456016885E34386EFCED716A064C3D1ABD3B77834E8312131264A9
          2F64505273D0872A9F62869AF5A673D92C318919C5E7C7A453819CF8FA1EAB48
          02828357D744660AD0DD9B81441A67C00C1C34C73073B6168969929ABCF4C0A5
          07CE6812F68C1F0ACD042412D2D0E70000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F4000000097048597300000EC300000EC301C76FA86400000020744558745469
          746C6500426F72646572426F74746F6D546869636B3B426F72646572733B16C6
          8F150000013049444154785EED564B4E03310C8D335DC04D1047E033C0965370
          0A54555555A2D2508EC2923DF7E0204874D33CECBC692A96B09896096F9137AF
          76C7D673E45600B87DC21BC9F9FCA97F260EC8811FE2B7DF1B9803D7ABFBCA1D
          B8598D6BBF037152FB1D88D3CA1D681F67C37280BCDB707215C799DB38E9F494
          F138CB7CB99867BE08813A2C981F969DE6FBCE1E9E07FA6BD82E42CD7B8033AF
          7D0F84E59F77E0FF3FE1C8486E5F5E1D36CDB70844EC5061ACBA6381E418C0B8
          2169DC8B774896CECFECB181281B2CDF72B6F9C0DB5D5B1AD0E2CE1D1FBDB358
          8177509224F6C8820A2436277C2979A7156CD6332F370440C99A21D61FA7A508
          CF86DC1BA4084F4AAE572414312AF53FD727B4C904C489A7A5B49EB315481941
          0275C676041BC614653C0A8E9239A5F8E1EC813DE30BA2C0C60DE7B81FA80000
          000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F4000000097048597300000EC300000EC301C76FA86400000021744558745469
          746C6500426F72646572546F70416E64426F74746F6D3B426F72646572733B3F
          A52F5D000001AA49444154785EE5574D4E02510CFEFA40236E38865EC08DA2E2
          5A172EDD790B430821304107B8871B7726262EBC88F114E20624436B5EDBE465
          1237BA419926A4D3F6EBCF2B6F26F94844B04EA94745978FF76A1111984D0B5C
          181022D5140822EE930029E7440BD1C902841000264411210DB126443FE4F9EA
          C2078035D8ADBF692104FDE9732D16D7B204F8105E50B5C72008AAD55700A146
          8A610329CAFB286EBED82B6D00C482F7D901B61A33837A3346F96424B619519B
          D466B5A33300E2B9850FC9E60E1C4A7949B0F63B10A2A2E36C8C5F08B52737F8
          A978BF0DD9C0D9A453F10DB4F36ED5EF40DEABF8064E6EFB1BB501D7E90B47A7
          79C74E9A77DDEE593CEF1B7E3450DDCA32CF1F7D5BEF70384DF666DD815156E1
          B7C0FFF3AA7F07B2BB8A6FE06830AEF8065AC3E97FDF8033A3F38727F08A90C4
          D990244E20891B684CC4E370264401C2119E484BCD79034010C510EADB1F2896
          4D79B96EF9008E6EECBC2A3089532F26202436249C188E084C27DB302004C741
          8715A37030597E364B1BD0C07CB16FA06808390F4C8D4164A7F7C21C31296603
          ACBC29E0C3F9B3420CC3823FC68CD62C5F24E4F978D05074240000000049454E
          44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F4000000097048597300000EC300000EC301C76FA86400000026744558745469
          746C6500426F72646572546F70416E64426F74746F6D546869636B3B426F7264
          6572733B6EE9C8C6000001AA49444154785EE5973D6E14411085BF57B3017010
          907C047E1693220242424E812CCB5A99D1C2DADC83840C1222AE41C03DB02DB4
          5B8F604A2D75088117769E346A55D5EBAE9AD73523956CB34F2C00F4F2F34700
          249139ADA69060091214C22E9F03F77B0081210D110129006C81263F0A48FCF5
          D58B560096B8B7F8412610D39309834402425045B403A1C54C20CAB78518842D
          B248A0964788EB9B079D0228CDCF5FF7296A4B96F46F260B034660A14A620007
          25096CABC89CDC91D1F6552514F6DE0301A027EB73FE023ABE7CC39FA2F21D88
          02CF2E4F66AEC0F1E674EE3DB0399BB902CB77ABC352A0D6F687D3D3CD098096
          9BD3B2CFAAFB571DFFF1384EF6B89EF8E3FBB22F00F4F0ED87C63FB01E588F33
          FE0AEACE67AC4075FBCC1578747EF1DF2BB000D0F34F5FF06EE82296C0020406
          D72A0B4BD815A7E600054E40E503068B0440D810AA98ED6FAF97AD00BC83BB77
          BE03030D04069482005732D7A0A23A54A8B3018C88E221611B49241009575747
          5D0F104370AB107D0124B78A74DF0324707D73D4E63CAC9A039BF42021AB5D41
          7AB25B0CE15DC90EED7A000CA83895FC1F9A0BF68CDFA4ABF636338542F40000
          000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F4000000097048597300000EC300000EC301C76FA86400000027744558745469
          746C6500426F72646572546F70416E64426F74746F6D446F75626C653B426F72
          646572733B2F08BA700000019B49444154785EED574D4E02510C6E0B0BF5206A
          3C8241C5B52E5CBAF31686104274828E780F37EE4C4C5C7811E33954888156FA
          9392892BE3026578E44D5F7FDF37A5241F2822B0C8D55481270F77A6212230BB
          4C5C0C208826911044C2260452CD510DD4C802404400AC368D4573B125A81DE4
          E9F43801D8051BCD572B0464DBCE0D2DAE399A1D20B22040FA0448A5DB2600D4
          50A09EEB0FCC7BF4331A6F553A00C802EF9F9B10A1791943F5CD50BC33623A9A
          CEA6EB83F4E0B99300C96E26A6CC0B24106BE133402AB03D3CFF69E26FF396A4
          0387C34ECD3BD02EBB759F81B257F30EEC5FF597AA03DFE541D9F1372DBBA1F7
          62FAFB26F70617265B45E17A31F0F8E23AF41B93BB97B75977C9666050D4F857
          10DF798D3B10D3FEBF3B90ACF8E8FE11788A158F20EA23F9A0CC79A1F944C20F
          C18291409C4426616D3867B41A6231982FFE7CD60A0011BDBEF6E297E50ADACD
          A8C764C212341DBDA8CA8A0E413E29E2C0C08AD3F7A8FCF1B6931D48B4A3F176
          727C108CFF0079B11542C104C01A93BE0030759F2E0717670D89187690AB1958
          CDC01FE2030B5E5FA8FF336DE24456300000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F400000011744558745469746C650046696C6C3B436F6C6F723B9C37B6DE0000
          072049444154785EBD977D7054D519C67F77EFEE26D964138809664184D084AF
          90103E6D8AD8410C56A445CB5481827C3894E96881D28E14853F2CAD505A5BB1
          C24081B1D65AA5A53A2025840F050123201F09F9E02B10169240C86EF67BEFBD
          BB7B4FF9E30EBB635813CB4C9F9977CEDC73DE33CFF39EF3BE67DF95E83EEEE6
          2BE82684B8BBABA9BBE486AF19B018A36CCC49DC03CC18A8D9FA140281849418
          1825CFEF3001A63D6BCBC7E665A7FD43424A8FE9E24C47405D3F716965051003
          7440D46C9D2A122597CCDFD1FD63ADDEFC03EA8E5E2E40884DBAA0181D2D2644
          ED6DB25A73BAF5D2A8EF0E5B3370DA5B59E6D42CA2AA9FF6DA8F693EF9C1D1BA
          26CFC2396B8E5CC410228CB3AED93295E10B7676FF0A745D47D362159A1AFBAD
          A6468BDC7EB5CC178ABC256429306C54BF55031E5D90A5454DCC2BC967D3A2F9
          DCF4F5A474DE07E3BE5336FE44C5EAC766005640966E0340E8826F84931B9E64
          D3B4C2D67553BFE5308459FFB2E4DBA5D55B9E6E0B5EDE2E34E59A104217BF98
          54265E2CCA164B8AEF131BE73E2EDCD71AC58D331F8ACAD5E5BF026CC6B54A5D
          25A461F113103181AA443FD235FD69C0B269D143256306DFBFB760C2CC5C73DE
          0804204484D92B56A1EB909666A6BDB196F7977C9FB06263F4B415AB77AF9AB0
          1848016440FAA6A525BDFCB0A3B7DD22EF4D7BA0E7CF1F291BF0DEA0C767E598
          1D23C1640593094980D99CCDC625F370551FC69E9142568F14AC569931B39693
          9E9DC1D1ED7F78E199D70EFF0D508CBC105F5792A6C4327BED48AB4B4FB3AE37
          F9D55DF98FFC28911C110BA1872E100B37306BE52BDCCCCBE0504E8C1DB91A15
          0375DE3EFF3A7B5AFE49C6E8FE6F2C5F5032164805E4DD752FB0A76111C9604A
          A871EBDAB9C34BCB270D7975C2DCE72CEFFFE95D82DEE01D7294EBE8A133849A
          3763166E9E99F353DC26812ACB64DBB3E9573890AC5E69A40CE96B193AB370CF
          EFDE7BE259206572D17AF97B43DE94BA1260D9B070D4F8F1257D2A874E999B33
          70D20C262EFC19EBE6CDE1CB5D1FDE21D77CD5A8AD97F07EF926C3FAF761EB73
          2F33D9948372BE95AA5327F1E8971956584C79D95CCBC811C3B76CAE98BEB28B
          9C880B189497F1F6B0297332CD79A560B2D2BF74042F6EDDC4E9BD7BD8B07819
          CEDAC368379B89DC0A126EBDC2CD03BFC7A2B43175CA7466178CA5B8C5CAE707
          9A3877E31382A28EE2C252FA3F98BFEC8D7FFD707AF2CA882F988510B9164729
          AA124110C16205BB2DC8FC958F716CF77F58BFE2203D332DE4F74AA5D919A630
          DFCAE0F03672474E66E88449643B1EA0C7A9A3BCF3F74F58F87C2A01AB9B077B
          F7C3D9726575F9B48195FBFE7DA10D1086754A42BDA5E9D66957532329197622
          612F4D559534ECDFC68523FBE96553F8C9BC01940CCEE05CBD9F01E39FA2E69C
          4276C120E4E84D245703BD72339938EE61723C763EDABF8FA6F68BB8D45A7A66
          65F71A5BEE980D5800E96E57A003D1C61BC18D0D15DB4028D83314FA1709721C
          1E34573B17AADA39FEE92D9CE7C244A27064FB36868EC927BDF710CC588975B4
          A05EAF42711E233F1CA1A94EE55C733DF52DC751A416A26853920930030288BE
          BAD7B96B83EDB3EAC18F1E1A9EEDF013F1D7901275D127572677848DB01B9480
          8C6CCB24BB6028197D8A4009130B2944421DA87E2FAD4E2FDE56C9EB0EAB591E
          8F40D66514531B21451904581202165FBD8228103E74C9BBF8E0863F2BA1F653
          77124EF32984DD219480866CB392E97060B565A077B41275DD30C83DB4347B39
          EF3475ECAC712E8BA8025F8786CFABE2F27670FBBB47B2443401C250A56EAB75
          9F3D5DDFBAE2F3774E2625B7E5F6C58C15FD4EE41EAE5FF3527BD1E4DE79E2CA
          9C06BF521F8B82CF13C3EF8BE1F329A84A544E568A66E28801A1D7BF687B578E
          89BE42D11617E69BBB455EDD20BC15679B665534FACF0029C14024AC05E534BF
          1CC36A9550543DDA5543228C5103026B4FDC5AB338128DB86EA4FFB27474FAD7
          929FAC897A2B6BAFCFA8B81A3801A880EE6E556A3CAD690F698A4A2464C27DB5
          E32CA00122693FF0EB31F709C34105BCEBCE74FCF1709DF7A5CF0E06B4806AEF
          447ECDE9E18B539A7757B5F3C7B7C98F037E4001C2AEABEAD2B39F06AA2E1D8B
          72F9945AD578DAB3C8588B910C2B4B7BA046A289FD5F1A903BB177DA132F1567
          D5FF75FA6071FC37E3C4857565E2C0D22162CDC482E00447EA93402E90029812
          FA463B703FD0D718ED894998D80F4818585E9479A71B5C5DE74B6C42D380CC67
          FBD9A6E5A5CA336DB2541411A2EDBC2FBAFCE3E6F03E23F248FC95330288279D
          48EC1BBFDA9E49248794F84B09A41A6636CA36048413C9BBDBC22717D0B590C4
          363C312AF1BFFE2F9000E24796D8EB1BD6D9572410131766EC8D5B5C7CE7474F
          C5383DC301D94824926CEE2426898FA9F35AE76FC37C40C0C84C2C407AB7371B
          73F7381F03428902ECDDDD7C4F7E710B00929938B200E9FF684D80482C339B31
          CA49EF3F79D45D5F5D1CBA51C21D4030EE90500149EAB9FB735DBF073A100162
          FF058DF3807891F8DA230000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F400000016744558745469746C6500466F6E74436F6C6F723B436F6C6F723B31
          8354C20000052749444154785EC556CD8B5C4510AFEA7EF37ABEF6231B3D1902
          424010050FE22910880402C242401858082CE414D09317955C0C5EF5182F1EBC
          642520280BC29E848020F80F88074172D6757733336FE6BDEE2AABFAF5DB671C
          C33E144C0F3FAABBA9EAFA757555BD4166866739B2BF6FBC72EB330092098BE0
          28206E70BD186E6E40CFE5F765B9A3E467474787BE585C00A242759A0B51D2E7
          785088F6BF7CF3E1D90438245F69A14E50564400B667C15A3B90E5762FEF4567
          79DF6DF962B94D440FA2BBC631A983203252E81E01A2FAB60C24225D3E85C4DA
          3E00C25B6060CC44EA4708F4610E27B798E9C1A97EBC451B0D660224EA46408D
          393D413D51605C672E57951D04ACC9098CCD34325743891721548F88B8392885
          BF264F0C1D097886E6EAC92612C14C1CD96C23F8701DD18031D8B004371CD9F2
          F16C3704BA1BF5292402512545A27B046A2354CB64277BF970A093ED6AB11804
          EF0F9C7357D0D881AA64790E68ED4D2C17778929396DC83711E84A80526C4322
          032AB17622E12F677391F88539670A09CA0D3408C618C8FAEE52B528AE70A087
          4D16B2FE889B2874230021A8593AA336B2E2094D6FAB2AAB6BE5BC281079DF8D
          8610106F58CEA2BE1B8D607174BCCB1C1EAAF33A100D1104E81C81C0A7044880
          E0C1B8914C78E2174B4BBEFA8E2914D5B2DC07C4C2387D0686AC976B9E4CA084
          7789C2F4F419DA52FAC76156CA903D50109007660540CF394086C972360321B0
          C74450CEA60579DA0FDE47A62CC807C301234E6289526A0641E65EA40FDD08B0
          1A30C74840F031FCC6988B55E92F57CB2230D3813AA8E67320EF1F5008409100
          49A20E35D8BBF1B6C96924C304C4DC9100296B35AC6253B2B9361F7C3B944B1B
          CAF28043386421E6CB25C8331CF8D24F236106ED9290E5FDCB40FC12314562ED
          79A16B276C6BD8200A815C694D9011066BE7BEE5B6B8C1F67A852CF6C9871D34
          189FC28DD7607972B4CB143E4059373FA0AE8D8839B55102E30660ACBD048C6F
          E4E311F4FAEE5E08E1DEE94726DD1A0053C5A47CB1D94D28977748AFDD12EE48
          8042624CE27000883891E6034BA9FF502ED469FB5440900D46E0466BB14FC481
          567261F4822FE6D798C3415B0DD49D00508C3F989ED388EC14C7C752E3BFBF07
          0C9F72EA6C4D89E5DE4B09BA7B88781B8D051D6EB40EC5E1E12D4D582068F43B
          12F0B583CC8D008D79954278B99A3E56625FA5A8D75722D2B99623B8F5737BC6
          DADBA667A2ADCD9D90CFB6B1325B44E1105247ED500529545A526EA849B8E38B
          05F86AF923077EC481B434954CDDA6055455E0E7D3EF43E51F45529C4A72BC99
          03E34D88BAA47BDD08902A1A03D669F871B29C4F8183FF5A9D7104A56762A040
          71BD9C9DC83CECF9A62901403E1A6B32EE32C6A0742760B25CD86F89CCAE03F2
          8BC6580DE90FAC2745E7B149D5E52AB0A26F320788B8CFA18D8056875BDF7A2D
          77EB5701D5B6230137DE84FE78ED2340FCDC1803B924547FE3FCFB88B84B4D43
          61416A3EF9FA06F4D7CFBF03C67E82C6448220D00B0F36B6A0BFF5DC7D00FBF1
          D3BE862BFF8A2FBC79476FD1FE19485FB5F2E4F058C466D3886A15D6046C93BC
          31638A22A94A63FA4DCFC2E39FF6CE26F0FCEBB7453C99340D89A819F73982DB
          BF5FED5EAD24D2A86C59883CFEF9CB33083C03609B0B6015698E2D56060B2849
          4CFA8264DB029E38A3DDF382A5A01054512119BBA4B06ABC4A069FA263566D56
          D70927826996163DC1A8B371DAFB8FFB4130FF2B81B5AEC61DF4BA60AA328376
          6C08F07FC4AF026EDE2D170C93B42BB7EAF0141D9EAE1924980BFE10CC5A8594
          C54F4936F8177B7046155582F02790F9A66497B6FFEA0000000049454E44AE42
          6082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F400000034744558745469746C6500416C69676E546F7043656E7465723B416C
          69676E6D656E743B546F703B43656E7465723B546F7043656E7465723B29AE98
          500000033149444154785ED557CD6A546B10AC2FE64D7C0C8D442404933C880B
          17AE047F16826611BCC4CD7D850B6EC5C4185142D4BDE0CE9790808A4E325325
          7E749F9ACF9939830912EE21A1FB9C6E4E1755D5275F1625E13CAF4500E70FA0
          949285D2D3DBD4CED0A7FC35031EB010B14C0C9D9F97DE9A878F009C44D4E2F8
          F0ED679F5E97850BCB922001354A105023257435B2464A200451A000299E53B5
          87B5C7F5E1C9E0DDBF37975601300018EDAFE1B7362EE26F5D9FBF0CF0E0BF0F
          4BC1FCF18404B911DF8F47200A2001F547501048243335F13D0A404148F60042
          EE1570F46D0051B0D42D00683C4A712FACDF7F0F9418C488DDCB093229664441
          2476B75620954E1684AC397C9201CA009C61E7E165B0A64A52EC857886D41A11
          A3D16F2BB597EAF90E289BF3E515A8CCC4BDB7DD509290D268668323E1C5D60A
          A0123224B8342D6732002993A85BC37A3D7FB4D4C943157B80B92996470D7474
          80444D65A08C9B9008F34569FDDEA12917BD8E0CFD3BEDAD3F45BC7CBC66AFB4
          1294E9264C0AAC738D3B8FAE8051CB28C272D81F1D5046ADF58A67F44AA01644
          A50F02AEDF3D80427B526623F3887BFFAC593E1503A9C07BB680A24D28B7A5A6
          BB9BCBA9B599A8BDF604858829A36C6A33389F01D95C58BB73002A9C1F7A2BEE
          C9FCFC2A63C7CAFEF67A658F75808198011403303DDEF528EC6C5EF5BE7BCFAD
          39D0E8AF648D96552A733D50C66945490FD840ABB75FD55A323022013BBF5BC1
          FDED0D03B1494302F64B900491DE8C34C4DED68A8D24819D548DE39B0D410E77
          9C6FC2449C58BD0D61504C5F57091E547C6F5DCBBC357422FBA6D19A1E9CBB9E
          F466D60056B1B7D43250667C09ADBDF5F7339B744A6DBCAEE2C64CA57E06487A
          C0AC418C13901BCC96045A3328A4000DACCF03A0321344EB6B406A8D85D2AEA7
          E583F1652F22EBDD022590F60596C260C250CAA125FB4A826EFF1216B3305B02
          A99EDB8EBE0E0C2490D06B34716035683546F62A9A9DA8D3000C74343C1EBCD9
          7CFAF19A201FB37C98C8CF6FCDE94FEEE489D9317C63E98683EF877120E5EF00
          864F6E5CDA88670B3DE7FC9E38B7C618FE2372350C44C3C9BCFF6E5C3F550F73
          B8193008E17457F9C37ED90376FF592EFD6FFF3BFE09566B448A1D3C67C80000
          000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F40000003D744558745469746C6500416C69676E4D6964646C6543656E746572
          3B416C69676E6D656E743B4D6964646C653B43656E7465723B4D6964646C6543
          656E7465723B8CE012DB0000031D49444154785EED57CB6A5441103D35E64FFC
          0A95011FA02011A25FE1C2857BD18404C185E8C65F10DC18888F9D0A12C85670
          E74F8862C44C3239C7982EFA5061669C04241B1B26DDF7F6ED5B751ED5B71392
          709A6D80536E0B001011C81698DEEADCC99F937F99801762907D94A0F38D63E6
          9C83EF03D8CB5E0B80833FD9F8F22E06672E4A8204B45E10DA9812FA1C79D853
          022188020548799F82485000E5F9F1DE68F3D99DE13500CC048CE44FF0BB8B67
          F1AFDAD71F23AC3CFF344CE6778F4AD02B627B670C218044AB401F3319811AA2
          1C9A19642F243340AEC0F7ED1144C152D70420F7807C053908724E13836760C9
          8A474BA2BEC33EA90C504E0646831CB3042FA8ABB57B32657D2607B79A80A982
          726C947EB16936EA822E3A833290FE4E8A66A06E44669D5ED0D165A4F4430BE2
          404E8650F6807C13CC18A2263210DD8485C228DA2FAD6EA5046A6526667909CA
          EB7D111B6B97FB1A4106640962B2096B024989C7EBF7CF4390D15219225A2236
          A525CB3222BC9F1406A64B605A6FAD6C8160BB4736F4104816E4A2EF91C2EB47
          5721457A20E5E48C2AA008CB6D5BBE5C3ED791596FA644EA73F4BC3D544D0CCE
          C180DD5F5C1FB8B9BC09AAA164439C1E6061E3D5017227A2FA2ED56F444D80FD
          613311DECDD657864629753DA9528A49777406FC67B60782766EA17CE9C16643
          2C23CE8F0D9463CFBB32DE3EBE5E2BCAFBC06C09A42834ACAF0E3B3B4C416D54
          81AE1A5061C3D160E08DECEF2684D8CAAC3808B871EF0344DA0714A0769DA801
          126F0E90E7B22E058E5386B262D612C2C6DA25EB2F9431658D8DB467E1AFAB19
          88A93BA1DD6F1F88FDDAEC189B8BA7330710B51C73FDF443294927808AD26A74
          74AE7727ED39076FF83C3FFD63444B509270D2B53A64539A0BC86B23DD5F12E3
          54064C4F91C2DA3261242B0E5A5888BED6E00545FA69D67980D2E1B9EDDBCFDD
          D45D465B0D06C289B11CB6AB2FCC585836804EC0ACEF8F7747EF1FBEF87C4510
          489F64297ABFF769D89FE1A32766F7069266198F7E7DCC03298F26307E7AFBC2
          62DE1BCC73CE9FFB193766F09D1CAB309037F7BC6872F3FC899E61FE543C6015
          4FD402C76A8EF3FFBFE3DFDD6F30CB159D9E800000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F400000043744558745469746C6500416C69676E426F74746F6D43656E746572
          3B416C69676E3B416C69676E6D656E743B426F74746F6D43656E7465723B426F
          74746F6D3B43656E7465723BD6942C1B0000031A49444154785EED57CB6A1451
          10AD3BE64FFC09A38E0811039295C947B870E10738C1687CAC74E32F0832F191
          EC7521415D0AEEFC095154745E759CB973A8BA8FA65B07241B9B29AABAEB763D
          4ED5ADDB1300C8495E3D39E16B6DC14208C28B4245B56EF575306200A9831E79
          A88C75CBA14B47A7B3394DC8B1963A7F78F4E955E89DBA08400011004B92A5AC
          80984E35720544050285687C87CF15718DC635AE9F4E46C78FAFF73745442D00
          525838BFB1755AFED5F5F9DB486E3DF9D027F2E3B204B6237E8C662258E20225
          020201027954163A3144C4EE73DDD7EFE368CF4A5D042030818651740D608144
          996BA34DEA25FEA8773BE40C9ECE6B04680981CE3D036F5BD01121E21BD4170E
          EBF72DD82A0037933A27B7E81D25A587C21189722C611EB8421B1170C7A553DE
          B3FE66085478790A2A13618050342210BC09EB8C2168EE8D121DEA9979B4A482
          AC9C0AF7D780008C97257123A953B0E1A4B1F6146825B7DD5682486A4E4D2BDB
          B7DF273A15F1E1C441A371003DDFBBE06808F2E0B5651728940EE0CD269EC5C1
          E08C67AF34D8D888E55625FCB4DD8D00F2FBAB8BCC03E1D3742C6B2455470000
          EF67F262FF922502EE6D203F23F200D821EC1FCBE0D9607D999DDA5E77194D28
          2093DD797B0F04C2C3C5ACB5388C3B77DEDA41A48065AFAA02902BE4E5FE4612
          5C489C46943A4B90470AAFE1707036C91CC57E872865359D67EBE593EE268424
          F33C66FE8E8DC74C29EB82EC68569911016089D0E1BD4D413230F44FB7A146EE
          590C6FAEE719B35F20150A3E6C6C168424294780D43C09DD39399D6FEF1D5BAD
          CBBA33EB281FDEBFECCD2A6963A31D0155B57A01F5643BD83DEFCF725809753D
          78E89048B4F700A1AF0F959D79E6CA2C8D03A233B57E80181AD6A4470FAE445F
          C482BBAA651730DA6AC20D77FB4539501ECB8E4CB68DEB33808C542180F8DDF6
          654E7EA088C9DE7C412C17F878F56EB748BC84D473A9660170F96C3A1EBDBEFB
          F4E30604C978158E58F1A6A353365DFDC5ECDC836632D3D1CF37FC20D53280E9
          A36BE7B6F8ACD7F19DDFCCBB754AE7BF282343800F279DFF6EA85F718D9250F6
          0048AB5CE1EF96BB9FFFFF8E7F034A394DF88E965C560000000049454E44AE42
          6082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F400000011744558745469746C6500416C69676E3B4C6566743B70A6FEEB0000
          02BB49444154785EED97CD8A134110C7A7F24D486E790B0F9ACBE241DDA30751
          3C9A579045D0051FC397D08BA282E8C1CF6870159CD5180F1EBC88104F0137D3
          133CE4ABCBAAD04DF54C48CF1C563C98406D5776BAF9D556FDABA6B78488C1BF
          FC945CC036806D0000B05AECD7636200191A1FD9E8B33103309FCF6F2D97CBB6
          D61AC804E018226EFA3D6C4C75A98464FD4AA57283B76E2C01C32F5CD9DB258A
          4B143790E39A1C480484E4CB26361B701C1F05EF5FDC978CF8341047BFC82201
          3A0E5A909B556D3CF6DD5031992DC9A85F8487AF9FDC06CA849440D29E917281
          140A05D6141A6DD912847C2C2B80B28956A07E607A0F033900067E6E369BFB0C
          15F307C090F6C5CEB573762F0A5DA480F24C526D7C4398A8A3E0E0F93D76F5C9
          D3E73597E94BF82CB304C0A956CA684010EE0F31D464824DFA0251E328F72062
          42F8863440ED08A932E4D6030070FA83C562F19118C51FDF3E144CF43A970618
          60E05EA0470B60B4B0331A8DBAAC09EA7F2C97CBFD7ABD7EDDD786ACFCF6A5CE
          DE590724F54DA41AA52C491D98550B055913E3E05DF7A16F0E08305663B24820
          E92C589A000546E07557BB1BC05B020038EC920666B3D96A16A483CBF80E5603
          6616D879C0E9C762B118E6D6001978805E2D102830C041ABD5DA770598198068
          0099E8CC00B326739B9CFD28837A42257CFBEA01C3960C3F716A17BF0E7AF9EE
          03139E034A09D8325C385ABAACBEFBA58A55EE0B49F8F2F11D984EA75C029016
          CBAF05DB7634073E1986FEF97D9028834F842B0D0838BFF8DCE7F4070434CC76
          86C3619784881C50AD56EBD3BBC13F0728EAF6E5CED5334E0F275B4EFADED202
          2D7342FCD47CFD4DAD7DD07BE46B43B1388E48074A5E3A6B42B0C138C25C073B
          E7F3DF07B85FC3DED3BB2B0DC881EC7B8067EFAA2DABD5AAA63264CE016C341A
          37692DFC85CBA966CB0CC09816F0B119FADB705DDDF85FFC63B20DE00F71A430
          1B8F4F7BFE0000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F400000013744558745469746C6500416C69676E3B43656E7465723BAA4E5DA7
          0000030849444154785EED57CB8A134114EDEA3C09C92290BF1071E24266E1CC
          2C5D6436A2E063EF46B25141FD04378E1F21088A0E08E2F3011947191A8D1111
          77BA719BE94732906795F7B6F5A4E8EEC0202E4CC3A5AA43559DC3BDE79EEA10
          C698F32F1F17E2FF26B02490D75F0821F1205E0F0DA0CE114A6718F0D80404E8
          743ADD9ACFE74D4A2981B001FE9C90F47B22E97C3ECF20BAC562F1AA22641370
          10BC75BEBDE16820FA9C396A3B850931083198EB8B98241C45FBCE87570F5546
          6C022AA2A00F1148407DC204909E552AE171501B98992D3BA33601D481B7F3EC
          1E99CD6622A538E2661C3352AE405CD7C5B3183F5394C0C36D690458A954BA81
          7B7838C3E1700BC09BA980262904440208F8B956AB5D435011590430D8F1F533
          71FEBA3BDB2E3C2B9B17DA6B802EA5200ACD8C54F339471884FBCEEECB0738A5
          C7564F512CD317EF850449D740D8471099D230D644280054300A2161ADB97842
          3F48EE514C99ED032AA228BA059D71023421D7F2D1D6833A07D38F65F0EAF5FA
          4D2DF5D4F4019B00198D4677C00B9A021082700162D880B6160C11423818D0FF
          AC5028742B95CA156490684400DCDC3C77795D0352F53552CD54BF9B3AE02335
          5A7810FACEFBB7DBA93EA04C23F421020162A55DA269805AB73BF694EA0B486A
          1BE67239AFC37D006A4FB80790041FB0742034C0CB204A81E9C7B3B37D006A74
          1DF70A11FABE7F1BCB822434C0542D0090C3017B8D4643F8005DD8078EAEB6E6
          B8EEEBDED31CFAC0E98BED933136EAC1CCADE9FD4C19F5004AF8EECD23049B23
          F891950DF6ADD759CC078661DF780F03D044149A8565025D8D69DF97A1DC9F4D
          80FCFCBEE7F232A0163EBE7E7217AF69829AB080EC77D976B0F713C7A0BF7EF4
          8C3224F9800BDE1FFBC06432210922CCBC94841051803C18122A97CB5DB81BD0
          0768DA0749B375F6D29AD6C366CBC9BE5722A0CA27B4B9D9B507D0DABB9DC769
          6DA8228A021051A82E1D1CAD7319E724461B58ED5FFC7B00FBD5EB3CBF4FC6E3
          31D13664A63C656DDC9670CD532843B60F54ABD5D807FEC2C729C5C824A04CE3
          F0C0F6D9F6B3FC6FB824F01B5AEB5C21DA853B690000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F400000012744558745469746C6500416C69676E3B52696768743B72EC7BF600
          0002C449444154785EED57CD8A134110EE9AFC9110DC27118C270FEEFA00D98B
          28F873F7223979D0A7707D0441411116C51F5051A3D1289215C19317C1275827
          339B85FC765915A6DB1ADA49CF20E2C10C29BA2754E72BBEFAEA9B491911D5BF
          BCCAF2665DC0BA0000582E1462FDE3000AA374E4A02B930198CD663B8BC5A2A5
          B5068ADF022062D6F7904975B98C149FABD5EA154ECD6C0183B7CF774E290122
          F7B4B3C7356D205510D25E26A12D388E7FA80F2F762523D91A8887FB14430B28
          37688024ABDAC24B3EE893668B18F58B1000066F9FDE81F97C6E28E5950FF3EA
          A55C8298B3AC2DA21E832018F80AC05AAD768D5648428D46A31D026F150174B5
          8126AF92670CF1F8D619DCD838A25E3FBE19D0756CFB426793D0AD144CA33145
          B56890C831870E86A1EABFDAC55C3E1047FB0432B394464B4D4416C0066A0A0B
          EBECE9B4A9A19011C1B72F6F4C0B7814F7BA8F6EB126001157D10C59AD211659
          031A00F67C05C0783CBE415ED03280B40723400E3FA0AB87E43C507835C0EA6F
          6D9FBBBC2580447F25D528E75D506DF2756A840FA250BDEFDEF768C098461452
          0C0D8843BB45138062DA95BBD53201568E61A9541AF4121F205784648420C307
          72F902FD26B20FB0C770DACA021A8DC655D68D11611886D7B92D5C4411F1B939
          BC6035970F1C3DD15EB00FF49FDF2DB10F9CBED839C9D8CC35A6B995DE9FDC08
          7D986C5A0EE350BDEB3EC0CC16C818910F046A6EEF233291388ED28D45836E57
          B7250A4DD1C57CE0FBD78F816903D1FFE9E593DBC0E3C89AA084C25A0000ACD7
          EBC83EE0D34040DEBFF481E974CA80EC0B8E080B3E945884E6BEE26B013078FB
          ECA54D31C3E99113736FE8D7E97EBB96CD1AA0D1EEF71EE67C16C443328EC82A
          CC528C4E877FF5D80516E7F3BF0F60A55219F49EDD83C96402E2809FF2ECDC65
          0BE831AFC90BFC3ED06C36973EF0175E4E3587B78024B417B878A0670C1D75E3
          7FF1C7645DC04F8F6F50AEE427BBB20000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F400000016744558745469746C6500496E64656E743B44656372656173653BEC
          1600160000055349444154785EBD175B6C1455F4DCDDD9DD742941620A4A8D06
          21F621D216A3151FA5A1B12D5289580C263E494588E887060DF861FCD00858AA
          1FD50F3146D4208A35AD011B0423AD81F4A1881AE54F6324E547DA9DD96DBB8F
          99B99E737B67E7EECCB02936F1EE9EBD77F69E7BCEB9E73D8C730E8C31500683
          FF67709A3475C3B2AC2E146815828B25D7C5C0B6EDD971E49CE1E0A1500870FE
          2912893CAF0AC088F9FA8777AC9941066034CB07313902F102B2E2035C627B04
          76D099C4A3B5A18FC3D0C92F044F0D3C439FB88408BAA4E30820D8A864550EEE
          B3EF8CF3ACE2B81B5E13701C2383FD8748A5425D012ABC4233F8CF91BF85C361
          205E5E018861C4B1D51C1916DD938E2F78794D5077DF66D70754B5E1F0AD5514
          1B17AC803957AC231772DF30D007BEFD52EC686A08D2A69E103E2019A98E2556
          3E5B4B2774378462FC3E435F4F74319F0FA03023A78F1FA670647308C3A2E7E8
          C2188604C3414987796709AE1ED5E1C7996D42B3252D5B68607BF780A34821F8
          81E71A05817B9F7A2D5E5E55DF0D39FBF10F77B5102E7FE28DE39C303FDADD2A
          70B2D9EC7ED4D82A04BF8A8335C0290A344D3B1B8D465F1002987878D7F6BB84
          C8CB62319A42ED2F7F5C7DD5A2F223AD0DCB2AFABEFEDD31977970774B812688
          794BFBD30DC06D25F6B96F0D20F7110C7D0286077ADD4464E62C583EC39820FC
          D0AB3D8F2CB9A6ECDDF6B69B4BCA16CE839EBE5F092D467B444982E5086248C7
          75BD5F8D1E7FF6E46007DA3C5CD3BC657EC5EA0D5DB7ACB8FEC9754D1590B318
          8443007BF79F1018B6BCBB6D9B837D7B373593ECE9747A4F2E97BBDD344D4AE5
          1EF5079B00D50F08C3F178FC258DD44DCC1B3BBA2AAFBEEEC6C3CD4D55D5352B
          CA419FB661326DC3FC9230EC78B609E2A82072767D2A0BFBF61C6B9049CB92B3
          DFF6C1D141DE4F8272E79C1060ED331F3C7A6DF9E27736DCBFB26471D902181B
          372193B5C142BCD4B405DCE66011F35416E6C51998A6953F8B4CEAD6B56F451F
          70930F57ECCEF3D2B88BA49E80A1C1AF78DE072EFE79811107235509A9EC1458
          A47A8DCDA023C574C682A9B4256EC4421AFA8CA016724C984C8C834E050C3CDC
          B8A76071219AAF18F1F3FDAF1C9ABA63EB6FDD9DC6276BDBEA972FBDE9064825
          66C2AAB454038E8C238889130A92135123076ED9A383278E30F20159C48A2624
          4A44D807504FE0142321AEF9D7D0815F2696D434F64F4DBE5D7D6BF5A6DBD6D4
          42C664303D9D839E8327F3D2D3AF95CB0CD0193AEBD852322728DA8C28FE11CD
          6BC0092963ECE74B08DBB2E99DC3172FFCF3FAEAE6FA285F500A369AE7C74FB7
          5502400A2187909140A3B67563C73D10147AAA51B86B8254528791EF8FBA2D59
          55DB9BFCFCD117E9365904FEC7A9CEF7D3B59BCF1913FA7B2BEFAC5B4A872573
          5D0A60C9DB8BD04BEAE3083A70A54AF9CA95E20FFE62C4180AD18942EC04C900
          C6CE7D369AF8FB87E66CFAB17DF1858B36CA1BE70814EA64CF9133DFF532CC05
          CC1B7A9291B710510EE008C3B4CD028A475899A33203D2484B2154DD321FCC6E
          D88E16357503B3DA5B78933AF26899D9E8460C41482D6F50BCFC168F0002412B
          168B9DC54C58D81513F39607B650962BB419816347A6E67512D0D3762A4CD56E
          882B9D6A3269C0E8E963229768DE1713434F40D2D01DC69E8AA650E64A49F1DD
          5E151C5CBC8027CDA3A2D1C16F3E170E8565964CF05F9A4E76B9AE49BE9070EC
          0344F745E8DEA63442048AB6E4B36718F81F35233882BB622A2CEB1FECB83B6F
          5F0ED20C81425CD64CCA09F975FF25A293A90460F3298B91270CC9FE86912066
          45ECAB3A96CBA0E0C95B750AE8F1401FB029399C39D50B994C86051415369717
          54494F98007DC0C604E6F701EA50D4325B04E6FA3ACF9DCEF85F2E0E9DF3C89F
          93FB0000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F400000016744558745469746C6500496E64656E743B496E6372656173653B40
          33FB170000054B49444154785EBD576B685C45143EB37B37A9694044C15F05FF
          0956D0F6472BDA1A0BA2C162A0F18988913ED468A85AB4BFCCAFFA47492A8854
          A452A8D254B48D69B06D9A6D69B33631D9DAA4C61A6D4A69A06950B749EEDD57
          B27BF7CE71CE6476E73E364B68C0490ECCF39CEF9EF73244041A8C315083C1FF
          33A460C3BDE338CE5E445CAB404952F38AC4395F9A44442606864221FAE09148
          24F2BE1B0023E19B5F7EA78E16249715612A105804E4C184F20F50DDF6012E5E
          67EA1ECD93D60C0C9E3E22651A7E94D6ECB4B86095F8A0928C1EA9E896A0D781
          371AA23ED4077E13A018F1D8C90E52292D581915DE8E19F43BE56BE170184896
          1F00098C146DB54C8195CE8808484403D0B4E69997B40F78D4061098BBAF7040
          601EE1E8B28E9AA8F36452F8C0994E940004120F3ACB943EA004791D0B7D2E80
          DA09F581524CC0675083D35AF6F9800013EF3FF51D85235B6E1806DF691F1061
          4834144C3A7A1D72AD51D2E283290AEC57C2AC78F292063ED83F403BD8BEE351
          29F4BDAFCE3B533767BFB97935DED27F784F86F61A5BBB3197CD2B470238F9D9
          0B2C9FCFB70B8DAD15145471790D2045816118C3555555BB4A00DA48B0466E14
          6C079EAD7FF0B51361B6BEA679DF8BD12FDFFEB3734F8343BC7B6F58D8DED603
          3448F8D3CFBDF1382077C53E06E600EA1C2911CDC2505F972711857C64D802C0
          EA07EE85BBEF5979FFD16391C1FA9D075B7A3E6F3A040085A756DDC99F6CE928
          9925A91C577BBF3B7A82D9138107EC676C6FEB8D3216AE43BEC0800B7A6BFB63
          60A51D60C0E1F4993FE0E2C56B07AFC40E7D78E3F75316011104F3F3F39FD8B6
          BDAE50283044ACA07E6D02A17E1034545353B3DB5000C2B68D75CD3BD64BD05C
          1242CEE690C971097E43DD6AB8A3766513025B77D7AA875E1D3DF1E9980211F1
          179C0AD141DE4F4051BE2B0A17B4E2F9D6EE744BF31370CB72802BBB39CAD9B8
          8360A66D40CE219B4943ECF4E85C626A6A67BCE3DD6FD3E9746F7DE376E1033A
          F9A0B6BBD63CD7939465C260AC3B565B5BBBA9E403F9391B12C93C9829070C23
          2499D007E46C07B273052838084618E4DC4C4C3333F16F29FC52E60C5854C0C0
          270D7D050B25B4F2C52867DB909D77C0760A902BC8AF5EC88C190A2F0E559110
          8C5FBE0E03BD43D766277F6B9ABA74F8120581A00BB1E80F8C7C4015B18A0989
          1291E803A827F014239ECB66CF7EFD45CF2644ADC686573681602C6B792C1A87
          F191D1CEBF2F1FD995B9353E0D00790940D9520927AAD88CB8FCA3AA088013B3
          73FBB736004095A2DA475E3F7095230773C682FEE3E7F3FF4C5C699D8CEF3B00
          00592D5C86ECC3F55BB66D8472A1E7360A6A13A45316C47FFE49B7648AD91C31
          567B8C7384B1E171188CFE72DD9A1C7933F157F7AFEA8E4DFCEEABFB0827FA3E
          960E9DB266045980AE2A152857DA1F02C5081531578ECE1180BE63D11F136347
          77CF9B13090A7919768AAB104EF7C99EF181B35DCCB66D562EF410D15F882807
          A0A0213A66658A4A58996185DACF2B7282FD18B0002D6D70C54F172395D5F68A
          E2B296BE2697CB31553651215F62F9AD1C0144A481EAEAEA619109BD5DB110BC
          A67ECBD68DDA546A4254B423438F8D39F7B69DFAA1B71B4257A79A4A25E142FF
          71997F0C42E9EE8A929609A9A45514ECA9681ECEA84A8A5F28F88183BE576665
          F8547421D6FBBD7428EA8A10F1769A4EB658D7A47E90A0E80364F745D7FD4D69
          8418546CC9972EB0EC1E3523347457ECBDB06673E3B60D25FB22683304412C6A
          26D70BF5AF778969266D82683E69C9FCBF0BA4FD9349938455B4AF762C2DC0B3
          F2571D0F3F2CEB039C92C3C0B92EA0102C5354D8727EA02A7ED204C2073825B0
          800F508742A1B1C484B29C9FF358CCBAFF01F309CF6F8217D747000000004945
          4E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F40000003C744558745469746C6500416C69676E3B546578743B496D6167653B
          4C61796F75743B53686170653B577261703B43656E7465723B5371756172653B
          526967687429A582A30000049E49444154785E9D57DF6F1545183D535A4A5194
          AAD5342DA209FA20AD3F284843C0A410254A34346D83A02DA051147C30FAA07F
          80F1C557F4C197A2188350C010A2315122E80342292A921034585291172C06B8
          E55EBA3347B277BE999DDDDBDB8DDB2677E747F63BE73B67BF6FB69624945248
          5C0A4030911EE758230013FF56B948A2361D6870E8C477AA4675810015A0689F
          424241812068A312E545DABD207D783BA48F060287B6AC7F7C5532606D9AB952
          AA6B63F763F8BF172B71B6903FDE756C656A219B0141AC35BD102CDF93CA1274
          4CED7C1605ED822CCDACAB010D312D004F810123D2CE09088758503860C13A85
          15016DCCF4008C8D48280CEE1D113096BDA8EFF658AF79B6AA4256066E4A4A6B
          BAE00159009E3249F43CF950183280202042AF33499BA1116D026A2C6A4E9101
          3F18FAE6345282C8733340609C3A6E03EDE64D3D1D96548C6086ECA8F8169884
          E63DAB177AA6B2852EBC659B816283F93592F158D3C5D4537A80CE28C4EEAF4F
          655FADD013320CEA83EC9799CDBD1DE591A664604A1382F48C7B9F6E03289212
          F42131E7967ABF86CC6B27CC3D4002C698A0D256F58021B0FBE029C783296BBF
          D4D7819DFB4F66B2433063CAFEB58BAC4D1C005495409CDCFB4C5BC8269975AA
          98D1B2359DF1B8F1F876B4B437A3347E050DCD77E2C6A58B98D9D8880FBF9AE7
          E43111AA0110131A27C5AE83BF0AEBCC2BF7F2BA25D011F1EF24507FF137DC3A
          31816BE7C770757C147FED1941CBE27634B6DE0BAD5B9C6F8DC99101637C9075
          6B1E4ED51ECA3F682BDB850960E10F1FA1B9AB1DB3EFB90BC31FEC47537303CE
          1EF9055DAF3521D206246D16724A20443F3FF0B34F79D26E245E79BE13516470
          477409E36D7DF8FDFB7DB8BBB50E4D0FDE8733874F63C1D2F9F8FBA7F3D09106
          C5849A794CE87BC0FA671FF12E764DC603D2DA80780BC556A078F4326E5FB012
          D1B502BADF5D850B47C730777E03A27F7C25317400E497290F084A82243EFBF2
          A4BD97CAE68BCB960D9DD09141292AC5DA167805C33B86624A73E62DC5D81FA3
          183D03E8961EC9403E0F24EBC00BCF3D0A4285ED17700023A371B570399E2E3C
          550FA01EB3FE2CE1C4CE6F31BE7A2E8AF7CF823EEC25D50679BAA10601D0109F
          EE1B11F5450627CFEBFDCB307923C2D9436F03813F003EA0807304CE0180066D
          16C91C1ED09A4E9017BB17254903083DF0E6AB5DD9B2EC54B201E37A5196D4E8
          3C1268A984C4277B87833A8FCCE124EC94428C6430BF7560793C30648E4264B4
          6B96FDDD1D99C3055321839B10579011A28A09E5689E7E0D77EC390EA8C45B10
          4671BA33736A610062DBC6E5AE25673D608FC2BE124AF32106FA1687690DA50E
          6501C2C38A0321732A5F29F6195018FCE298900DCF814C46ADDC019100B475F3
          8A587FE6F18036B49A19BCB169856FC714E00CB4A74711C8E5F6DA3592300679
          9A91656ACF7852FC425D996AD10453D485AC4F8ECAD58C40633C4B0AFBA90F1B
          FE544E4F8E0A540C4C421242AE5A213262C2DB66D7A52A20C32FA3E0F902D49B
          95C975D1BF0C4057FA2E102E93C5D2C49177DE3FF0840AD84B4086D9487F7C8A
          0F4C78C694AB582CFC08A0646305006827AF6F7F6FC3DAB8AB0033C498D37D92
          E7D843CBBC08A090CCC27F001B771964228CC10000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F40000001974455874536F6674776172650041646F626520496D616765526561
          647971C9653C0000000C744558745469746C65004D657267653B7EAEA03C0000
          052B49444154785EC5575F6C944510FFEDDD71D002D7D2863F8582242A10356A
          E44FFA602031460C5648508951E303892F46A32F6202042452D1909826044D7C
          2C0F248AD840C00652820910456C8ADA8086D696B67AD55E7B85E38EBBDECE78
          4EF6BBF1DB23F14560D2CD7EBBBFD99DD9DFCCDE740D33E36E8AA9E86FBFB0F6
          80712DA20DB8CDCE10A02D0620D2FA59C713336624F644A2D1E5607551BEDD88
          593C923107133060561C2C9868C85F5947D758B23F4C8C8F6EDBF9CE0B9D0038
          06205AB0F1034FAE5E3677D1FC5AF872FEE210563DD2E87328CE7CD73D88558F
          2EC4ADE4DBAE01343D768F2E70D23F34B6FCC09717DA002C2A3300408C4FDC28
          8AB6D103E2B781512CBD6FAEB36C42BBF595B065F7CF03D8834C09BB9AC2034B
          E6FBF6B1B8B10E063C47EC3AE38689A19C3BE33032247698D21F88EACB261E45
          CC4ABD274C9A7F91B2BEBAEA1B53A7BCCCF46FB06EE419D601480EA55BC50098
          4C5D0B3E3EB617E9EB799967B09C881DB73D47F4A42161464FBB3A2C6B59473F
          7FA58BD8B5BAC45464EB6F42C4390022C69A879BA012CE36669F5F85C1EC7414
          F7317078FED0A96FC20C10911899C825A1E219F4128D0DC3B01A124C15BD2070
          99999AEA7960E230036C35EA9AC94A3343BFE550EEC4ACD9272CE9220A874C16
          05094EB096C30C3033080435A5C66094CA408E1DEF426FEF4859FFB98D4D6868
          A8D5939A70EC850F471F3181882012DCC52004028270ED7A16478E7E0F96850E
          0B1A1857AE24D1B2ED5DECDDB10BB3EAAAD079BA1B91685CF444835C0FC6F192
          B3D7333988E1C08632200E184BCE1011BABBFAD0D6761ABD7D494C8FD7839D51
          082E0DDBB7BC866C2185FED1B3488DDE90244E4C9D0B8238AB3D11FA4A4C1D3C
          780E3F5EBC0AA2A2AC27263831C12D10EF3A3B7F424FCF204CC4201A33F8B0B5
          0D34A96179E3CDA7313C3C867D87BF0EDD07729B32313ED97F02BEE4278B3873
          EE12C6C7B358B776768881988680F0CCDAC7B178C1083ACF9C453E5FC047DBDF
          038C06F3DACD61311E8B45B067DB0E716077EB1E61805DF8B66ED98C9AAAC6B2
          775BDEDF85F894389E5ABD062B973F044B3990770B0C59C8E2CCE418963E5887
          254B5F46C7C93325838348DD18A8A88A55D3A7209D1BC458094B8FDFC4CCDAB8
          CB15C268A61FA9520BAEDD927B1761E3BAF58857A384F5624A340E4BE11C10FA
          C86D902D4C20CFBF637DF32AE48B19A5D7B5575F5A27716CFDB40DFBF79D9058
          83189FB77794F5ACEB892D9A9B9B508CA6904C5F42AE90169C2DF90C1088AC18
          02031616E3D93FB44A400BCECC7AC6DBAF6FC68CF86CB0D18250A44269CD55F9
          313360908090B1EE0171CA72450EB0BBF724F3208692EE30231DA8984372E232
          80CB10C8B0571CA592004C6E87F0EF01C1C292C780B5044B56AE9DAA57563571
          CCB83956D4D7640E0E605CAF4C09DB161E030C9C3A7F11C9918CD678840B0CB3
          D1CD43258275A85830AB53CEEB050D0910857F07CC9CC24EEC7CB11999EC6445
          C93D74F4029E7F7605447CEC48095BBF422B9509CC1A7CD17E1E9B36AC74664C
          D991E955516CFDA01DC026BD05CCA144F3620A6F427B660AB10336F22DC43B47
          6034FE00042766AF16306BDC8C12CB466321BDD2291AA4750A70EB0C2A74D56F
          0F0BFE2BB66429F96BDF9FF31636D6C3C0687D67835935D58845231A67D11033
          A84DFC8319A8987228128969880AE6F87054FCD29B84B5C51100160E9DB6E195
          DD1B12B31AF619446607E757B6C3491638AF5045E229E68B5443FA2B9D1A7AEB
          E4E19676007903200A20EE5AEC7F781199FF78961501145CB3C67B9EDDA9B721
          497F471FA5B7760477FD79FE375298CF1A441A2A970000000049454E44AE4260
          82}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F40000001974455874536F6674776172650041646F626520496D616765526561
          647971C9653C0000000C744558745469746C65004D657267653B7EAEA03C0000
          052B49444154785EC5575F6C944510FFEDDD71D002D7D2863F8582242A10356A
          E44FFA602031460C5648508951E303892F46A32F6202042452D1909826044D7C
          2C0F248AD840C00652820910456C8ADA8086D696B67AD55E7B85E38EBBDECE78
          4EF6BBF1DB23F14560D2CD7EBBBFD99DD9DFCCDE740D33E36E8AA9E86FBFB0F6
          80712DA20DB8CDCE10A02D0620D2FA59C713336624F644A2D1E5607551BEDD88
          593C923107133060561C2C9868C85F5947D758B23F4C8C8F6EDBF9CE0B9D0038
          06205AB0F1034FAE5E3677D1FC5AF872FEE210563DD2E87328CE7CD73D88558F
          2EC4ADE4DBAE01343D768F2E70D23F34B6FCC09717DA002C2A3300408C4FDC28
          8AB6D103E2B781512CBD6FAEB36C42BBF595B065F7CF03D8834C09BB9AC2034B
          E6FBF6B1B8B10E063C47EC3AE38689A19C3BE33032247698D21F88EACB261E45
          CC4ABD274C9A7F91B2BEBAEA1B53A7BCCCF46FB06EE419D601480EA55BC50098
          4C5D0B3E3EB617E9EB799967B09C881DB73D47F4A42161464FBB3A2C6B59473F
          7FA58BD8B5BAC45464EB6F42C4390022C69A879BA012CE36669F5F85C1EC7414
          F7317078FED0A96FC20C10911899C825A1E219F4128D0DC3B01A124C15BD2070
          99999AEA7960E230036C35EA9AC94A3343BFE550EEC4ACD9272CE9220A874C16
          05094EB096C30C3033080435A5C66094CA408E1DEF426FEF4859FFB98D4D6868
          A8D5939A70EC850F471F3181882012DCC52004028270ED7A16478E7E0F96850E
          0B1A1857AE24D1B2ED5DECDDB10BB3EAAAD079BA1B91685CF444835C0FC6F192
          B3D7333988E1C08632200E184BCE1011BABBFAD0D6761ABD7D494C8FD7839D51
          082E0DDBB7BC866C2185FED1B3488DDE90244E4C9D0B8238AB3D11FA4A4C1D3C
          780E3F5EBC0AA2A2AC27263831C12D10EF3A3B7F424FCF204CC4201A33F8B0B5
          0D34A96179E3CDA7313C3C867D87BF0EDD07729B32313ED97F02BEE4278B3873
          EE12C6C7B358B776768881988680F0CCDAC7B178C1083ACF9C453E5FC047DBDF
          038C06F3DACD61311E8B45B067DB0E716077EB1E61805DF8B66ED98C9AAAC6B2
          775BDEDF85F894389E5ABD062B973F044B3990770B0C59C8E2CCE418963E5887
          254B5F46C7C93325838348DD18A8A88A55D3A7209D1BC458094B8FDFC4CCDAB8
          CB15C268A61FA9520BAEDD927B1761E3BAF58857A384F5624A340E4BE11C10FA
          C86D902D4C20CFBF637DF32AE48B19A5D7B5575F5A27716CFDB40DFBF79D9058
          83189FB77794F5ACEB892D9A9B9B508CA6904C5F42AE90169C2DF90C1088AC18
          02031616E3D93FB44A400BCECC7AC6DBAF6FC68CF86CB0D18250A44269CD55F9
          313360908090B1EE0171CA72450EB0BBF724F3208692EE30231DA8984372E232
          80CB10C8B0571CA592004C6E87F0EF01C1C292C780B5044B56AE9DAA57563571
          CCB83956D4D7640E0E605CAF4C09DB161E030C9C3A7F11C9918CD678840B0CB3
          D1CD43258275A85830AB53CEEB050D0910857F07CC9CC24EEC7CB11999EC6445
          C93D74F4029E7F7605447CEC48095BBF422B9509CC1A7CD17E1E9B36AC74664C
          D991E955516CFDA01DC026BD05CCA144F3620A6F427B660AB10336F22DC43B47
          6034FE00042766AF16306BDC8C12CB466321BDD2291AA4750A70EB0C2A74D56F
          0F0BFE2BB66429F96BDF9FF31636D6C3C0687D67835935D58845231A67D11033
          A84DFC8319A8987228128969880AE6F87054FCD29B84B5C51100160E9DB6E195
          DD1B12B31AF619446607E757B6C3491638AF5045E229E68B5443FA2B9D1A7AEB
          E4E19676007903200A20EE5AEC7F781199FF78961501145CB3C67B9EDDA9B721
          497F471FA5B7760477FD79FE375298CF1A441A2A970000000049454E44AE4260
          82}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F40000001974455874536F6674776172650041646F626520496D616765526561
          647971C9653C0000000C744558745469746C65004D657267653B7EAEA03C0000
          045949444154785EC5574F689C5510FFCD6EDDAE49DCB689B6699A46C15883C5
          3F9826F6620A221E241A102D1E3C7BF5640F4A09A2D58320423D79B447AB868A
          55100B2288862A2D5844A189D50492347FBA982626D937CFBCB733CCEE909BB6
          1D78FB7DEFCD7B6F7EF39BDFFBBEFD28C6885B69E4AFB8F1161BAF24AD600DB8
          C160B8B16D4B41DFFFF0AB27DADA2AEF148AC57E448398EFA517634694FB5107
          4088D1FCE9275F64936873740D02879FAA4BF3AF8FBEFAC23769240128AE87D2
          A92787FAF6F474ED84B7F18B53187CB8DB7398C1FC78E12F0C3EB21F5BD90F3F
          5FC1E147EFB605627F4C2DF69FFAE4FC47007AA00C00C8C1ABD76B7936598298
          BC328FFB7BF748646ADA6D62D3D7775F27109D8B80893F17F0C0812E1F1FF774
          B7831077E7B8F24391758A5227BB4480A3F88C7E359B9F377114C568D43B8B6C
          FA2B40E71B541FCC403965BA136C1B79A0D601E7A46CAB54025A6E3F81F7BE78
          17D7FE5E4BDDBC9C54809170E98C66AA66082E8D690C159CF57EF94C1719B6F6
          CA76AC74FC83640A00CC11471E3A0C6FB2A72ADDA7A3CA9639E6773EE9D8F8E9
          73DF3633C0CC39487575066A3EA0175A24614902659F4D744588CA0C76B474AA
          068C8118ACEAA664A3D992AB6F44927134F5094BBA88615B29132A704608B199
          81B498C186DA820164549A4B9A1C5903A06B2C7A5455097D1C19CCEC34202548
          4E59E5A2D990973FAB9F60C265E4CED9B3173034D487D6B6B2EAA80EC0331038
          216409262E0DAAFA1646CCD467805916E9299AB83C8BE9E9450C0EF4E2E083FB
          EAA563B64401D253009607C7C90FBE44A1580FCE1B11FFD5D6366AF8EEFB5FB1
          B8B482C7877AC130065C0912B280E3C75E46A5DC257499C8B055F6AEEFBBC7DE
          7C03A5DB4A786AE80806FA0FA2BA3A5D67C09D02E2803A3200F3CB93B87A7D32
          0724A3D8C2F9B0AA39116AA36E0FDCDB83E79E1EC1F616C6C2E69EABEB55DC51
          BE13813D0391738BB9C96AC9D13F60FC032A9ACFB420A086871F438DE6B1549D
          43E05AF6E518813D030CE69040684A7A6CA4C1325551A6A99A2A9C60F3712354
          57E7FC1EB9CC217A0638CAB9CFD8A5F89A9DF84863190864108DCCA82FCBBD51
          25060C01811D0321300207B4963A6CBA179AAA92B6D285BB8F9A009947D067B6
          03BC068073E3173133BBDCF48EB7FA6B497473C3D8A402F3E9A80D09EA7D7B2B
          606E7E0ED0EEF5518CBE388CE5950D7F9870FAF3F378FE9943D273BE339BBE67
          0FC11E851A96F0F1D8388E8E0C4818522068BDBD88D7DE1E0370346754B0AC4C
          686A96891FB0178BB0236ECAF7265FB2A3A99C44024B3C059006AC6E64C446B2
          5A9898B51BC18DEF29D2DCFD5CC30DE7D37FC58103CFFC3E31D7B9BFBB030452
          D5E78C76ED68C1B662C1EA0C02493E3B2BC94730232D052A95328AC9277C2815
          BF5D9E4108B55900417197475E7A6BA4B26BEF4942E12ECDDFD86E1299813761
          79E199CF5BFD8D7BF5DAC2D42B5F7F7A2209618D00140194A46551FE4F9F7BDE
          145D0DC0BAB440EEF3EC667D1BB25C4186FAE69A02B8E59FE7FF0223E9397C9E
          28A6C90000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F40000001974455874536F6674776172650041646F626520496D616765526561
          647971C9653C00000017744558745469746C65004D657267653B4D6572676543
          656C6C733BDFCE3B440000044D49444154785EC557CF6F9545143DD3F7822D52
          408D500956A356511712AB0D0B3106DDB8F0C702E2DFC1828531C19DEE8C3171
          A10B17124D34A8544C4A6220316C6A83228995F8830AB5512A54284D3152E61E
          CDCDDC9CCCBCB8139CE4CB37F3EECCBD67CE3DF7B65F173E90F4BEE6837A03DD
          12B44F0F708DC118A0A70BA0EFF5B70FED58B366EDAB7D9DCE2828883E2F2BD2
          11F99AF1031248D941B781C509B527CE205BFE6AF1C2F9975EDEB3EB30007601
          74AEE455FB9E7A7CCBC6E14DEBD18EA91373187B6873CBA183F9F29B5F30B6F5
          7668684C7E7D06DB1EBE4307CA383DF7C7E8BE8F8EBD0B6018C100000FBEB87C
          D577275D103F9F398FFBEED9581CA5CADBCC3FB62D2343001B5302666617F0C0
          BD9BDAF8B873F3CD48E0068F1B1AA049174A417214461DA72C3DFB53933A90A0
          E7AD574A34869BD48DFD6CA0B25EE872D020510D6D222A1375D0E88FEF120324
          268FCFE2F4EC8276831EE0E49F7BF0DDC14A9095E8A60F448C109C56DF7E22E4
          BA24815B84CD1920896D5B8771FFC86D25BE204F8F1B9EDFFE44EF35E530B225
          7B6303EBDFF71FF9A265408789E4F199E83BB21B89C5CB672BA1B99D0AC44271
          28B24E028319AC5B3D041A5B064CE903C194908A5366C268F01D244257F465B0
          A59A8F5E53F713864A3D56CEAC19300B87C501C59A9105A055F927832F080028
          5084F40716DFE53266BD1A383A750AB3BF5E500494034658538ED0DC6DD10752
          08D5A4A3E89CD1311D40CB00416C7FF46E5C5A5EF115C30EE2F807E5F634C56D
          8B95413C816086115440DC62E62000407DA0E9E1922E90ADD046E53A55AA17BD
          8186C5AE0A51A333F432009A1B211989565A3924D4DA1F3843A052BC14C85AA4
          CE405305299C873FF9852B964601E8ED90A23BE93CA9BD2157AF009AB3DAC3C0
          E7477FC06FF317C3B5AAC07396FD70DB5AA95B432F6990F099588992CFE14B22
          C4938F8D6069F96AF1AD744CBD433F6421ACB099A74814D70D1946F50459E197
          C9EC61A0F9A723152B92D365E60C9458020107D1A424BA030D54BA040C19D9AC
          D5006B1699CAEDD40549D537150C8A414D497158662152CB06CB68180061E1B5
          86EC9B691937AEBAA95446045548753F25304A214CBA106156F5013F818923D3
          38B7B0A4262811E2BDF149E5BAD47D05C1549265E94EDB5E211F2D03249EDEF1
          20962EAF045A01F8EC4DEC7CE6112162426CDA7FF018763E3BEACE7504DEA83E
          3C30855DCF8D21A5F80BEB6FACEEEFE2C5573E06F042AD01066529F29694EF8A
          16D578083341C59F4243DA1BC0D4385833E0B1E3494165D266F5C7E0CE03C044
          B08C4C3AABF6565709597D9898E57CF6C799DF8746EEDA10778F3C63FDDA010C
          F477C2995002583738E0942AD39A0C0EF663E0864E594AD4DF9F9A87E53C0F20
          C777C195999F4EEE7EEDAD4B6F24F4DD2ACA81984F1C3EA1F26ADAF0A162A30C
          B10E5B75C068E72E2ECCED06F0170073009FBEBF771CC0446802FF3ED27FF05D
          984BF09560C0F4C375FB38356940A9CBB89E23004891FFCFF81B4BB1A4A8AD75
          241C0000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F40000001974455874536F6674776172650041646F626520496D616765526561
          647971C9653C00000019744558745469746C6500556E6D6572676543656C6C73
          3B4D657267653B89BE77BD000004B349444154785EC557ED6B976514BECEF6C3
          6DB5E9C852135B51AD4CC1A495F8A18D9A130A7A819C0409D1BFE0073F4450DF
          EA5B4410D920A1AC40DD4C3398B24DD916617396EB955E5C6AA39A73F9B256CD
          ED3EA7F19CFBF95D3C77F42DEDC0C373EF3EF7B9AF73AE73DDF76F4F096EC2F7
          1537E31B2845D00A3EC0154E46013E250015AF741C6CADAD5DF852456565138C
          29FAD87C689E91F98C4F4060463FCC7DE681B0F21AC6040DC72F9E3FF7DC0BDB
          36F701B01280CACB61C1CEB696954B1B96D723B5A19131ACBB7B45C2A127F3C9
          899FB06EED4DA0D18E7E7A1AEBEFB99901D14E8DFDD6B4B36BF86D000D650600
          64E017A7E7B2D5C202F1E3E973B8F3F6A511590ABB8DCEFB56362E032C710930
          7A6612ABEE589EE2E39615D741604B1C376AC094BA600B24CB428DE1464FBA1E
          92B40E66DE0211A416F1048094CAEB7D9082112755A663148C8B3C9AF30C54F3
          07809001331CFDEC0C4ECDD3C6D596011CFF731B860F78855A466095C3FB00C0
          7D92098EE91F7B9F99B3480316731B67C00CEBD736E0AEC61B233E533EB65FF1
          4CEB43A071C777077AF0544B1B6739C23B477AB0E5818D499C7BDF3C74286580
          C106F17E8A8B51632F7F9F399BA60055C3D45F3E6F49BF54E1BE04BEAEEA7A98
          5ACA00C915184C24CBCA04B0603028CF3BE1A0EA3E6A8470C1CA318CCA44AD08
          C18A0CA87A6BCCA4283ACB19D00C28156A50E529E185E422540773B3BCB46CBD
          AAFE530383432771E6E7F3713D85A86A78ABAF1722E06D070AAD6BF0443662D2
          84EC1C18C9C5EC16C79632603034DF771B2E4DCFFA5F65BFE1E35D8A2D1BDB30
          3D33513C7619F8089E685E9317C84460E8EAFF1C9B5AD614AA070CB5558BD171
          A017D12467807738C123CDDE0235F6316743A38FAD2637701F0BCACCDBA20903
          3025A54211B808CB20CAF3AC9EAE06F6195A6CCD9C461F13772654A1C92910DF
          84750BD8CF103C01DFAC98A8E622B49C3F9A698C0163CC14C182279032D033F8
          1D7E19BF503CB7E6203BBA0F73AE2038C3EEBE118809E1F39161DEF705ABE7ED
          0A0D8A6814E186FB1B31353D47C9C490FE1D86A71F69C6D4CCA45F50B9CF803D
          47BE44FB83AB0BC9E5F17B7ABFC6A60DAB8024E96BABEAD1B177206520F9A743
          A217E222D440B18149A8F799D0D4A1FB34E485B3305304D55403BE82D44BFC7D
          8F01A6BC3C48714C209967EB781AE8770D04240CC0A0856B8E6AD4800CA466C1
          229E77338833C779EF0FD9C97C7564D5E971E19201294566D07DF82B4C4C4E39
          85C224822AB677F5176F40E382ED9D035EA5307F35DFF4F55D1F018CE19144CA
          80191E6E5D8DA93F66BD10EE0FFDF035B43F7A2F274C902FEA3C308CF6C79AB2
          CD19028800BBF70D61F3E3EB2092FFC2FAFB9AEA129E7D712F80278B1AB0FC2C
          8BF81B0EE4D491160A8DB760E6117748AE21AE4D8FB03F64C0B1F3C7F1D9535E
          CD5488C001283F8A980CC18D0AA046CC0A1F26AA21FCFAFDE8D9658DB72E89B5
          F3A7B97E610D6AAA2BCBD0CC1258545793514ADD725057578D9A2A8F338A1ADF
          9E1C8786300E20E4DF0597477FF866EBCB6F5C7A5550710329A772BBFB46CA7C
          12C4FD07A3CFE8884BE96300A0A6131726C7B6029801A059021FBCF7FC7E00DD
          FC54FB5793FFE0BB3044F0D99C01E5C455FB38556A80AD0BB87A46115291FF8F
          FD0DB35BC5FE0B9346110000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F40000001974455874536F6674776172650041646F626520496D616765526561
          647971C9653C00000023744558745469746C6500496E7365727443656C6C733B
          477269643B53707265616473686565743B2B54A69F0000059E49444154785EDD
          166B6C14457866F7AE0FEEFAA2D7EB95D252500B8269A585A2484231A648C4A6
          624C0CD61834263E904463344442482C8598981A525482A2D536A23F2801290F
          814224C668DB346DB1C8ABF679B5157AD6436CAFBBE337AFDDDBDDABCA1F639C
          ECECEE37DFCCF77CCC8711424AEDBE53ABE21366EC5414650921286A58000438
          2B4CF1F635626004CE0AEB9AD61ABE31BEF9F58D6B4F230029D6F5F69ED3C37D
          83D749ACD1D63544A61BAD9D8331113ACCEF3B06E9D79C3A9F3DFDD748F5AE13
          C3C0370E2676D117ECC8CC999506D273497194FE7D0363A870618001C4A23B16
          B82C38E7B4D4C010E0EECC02C84A737616F0017E002886009ACE378180DC84F2
          8058D305DEA0649AD981230063CCD661EAC60122B6A800023F83051340D77486
          858FC9D8B0012584B89698214C8D0891C4B885307B0925A4E01CCF973847E027
          05C0F49550F5CEF19B652B17A2FE60C850C53EE4BA7C13698A69764A0EC4B618
          F027A313CD5DE8CDD7D67A01FC83BB00242A2ECC468B16041CB17FACB91B3D58
          BA803324C4823F7EF6025ABD72BEF03BB6B03E7EE6022A031CB109E6561574EC
          540783A50B98AF80B6C59C4263B9CE5C803116AEE0C2109DE22475D3DFD2E332
          B6305FE63183615DB3C58066130047E7B30C42BA4AF198882FC5729CE9214647
          38490A47A4BC8C86A2101AD8160B107041F0D2D591AC9CD93385F6E2001CF4FB
          92E09022F75BBC9B919E845C2A36CF30C67CF8667A918B51B79EBDD23382283F
          8A9194DC95CFED5A9BE84D7B1F403FCF69A9BD69096795137F44C0F2EBF817B9
          44883C33121E1F7DF170C31B87013B8945417089A930A1FED9C062AAC619E759
          1CE37F0AE684981A8E4228D19BCF9F3FEFCBCFCFDF4801555557801B1EB01153
          366C6F2CF524A76FC78A5A6C1427E90EAB05E5C31642A3FD0FEDAFAE3C0950C4
          15953B1AC733A755C07CA66F6024754BF587777CF2EEE6AEDB8AD74F490F5F6E
          FD0C538B4D116FDD8A927999B302C98281E9AACEEE20BA4B9662B3B2A181E171
          F4E589DF3F02208F5AC3457D631B359AA615EEDE7B307BEFA787E74E44222A63
          DAD2D06CBAB80143EAE2A77636677A5266A0F6FE71EB3D4130BA3AF82B9AF27A
          45D13247766A22DDE2172E9F84976314CC2F796225CDAEB8B804149F988C0A4A
          5F28FD2D346AD46882095861FFD7349D26221A4FDFA842448CF2AD8B0225CB34
          A8ACE92C0D65ECC412A0E3C7EF1AF0EE7D4766D77DF155DEC4CD88DA79EEBD33
          D6DB8E60B0924280710426A1135BA25F5C466CB7A56F8850C1CCCB08BB6875B3
          117F1982EED14DCF966F78B86CE9E8D6B7EA6FA788DC4515AB24A181EE4354FA
          84C7B636F5FF3C3C9E9691E1E53110559386DC0AF225C501604DDB205CD39AAE
          85445490E9D20785C361BFC7E3D924C0E520E8FD022533C6BDFAF93DE5DEF4EC
          5A8C958C28250D8D49F4F54DCCCC08052F569EAD7BA591A62245CBA938F3D939
          6CFBDDA2B37139F0B1EB802EB2ED269D320D95AA9A43AB1212BD3B684F28A238
          3A7A2D392C2F459E3D3ABFC8A4AACEAA68C202D075AD2D3436BAA5A6EAE99332
          0895C98852BF7E5D41E6DCDC7487BADFB6F5A17B8A7251ACF14D4B2FBAB7D889
          2302B77CC91C479370A5F797A20FEACF7D0C00456A4C00D082328FD913F6F45D
          43258B7362F6843FF55F43CB40B8583D2134B968D9E2398E9E706EAE0F119DD5
          01F53FD3132AFF7E4FA83101E4CBF3EAB603E1F23577A3DE81EB52157B732739
          702CA696BAD59E90D3CD0EA4A08347DB506DF5E32980B861F484F72DCD43C505
          398E9EF0C09176B46E4D61CC9EB0F1683B7A0470B17AC2C6A6765401B8183D21
          D06C312B21BC6865FA8B9E90FCFF7B4288096DF8878BC1C0BCBC0C474F18C84C
          99B6270C64244FDB13FA7DC9317BC20B978288F2A37C25A5F88A27779427A5FA
          77D39A6EC96969050B6CA907E69A99A37694AD46E8A3E363C1979A3EDF7648DE
          052A4CB798AAA37E4F376E7D0F11538339093342FFFF0425C3422EC727DE1A00
          00000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F40000001974455874536F6674776172650041646F626520496D616765526561
          647971C9653C00000022744558745469746C6500496E73657274526F77733B47
          7269643B53707265616473686565743BA38493250000050D49444154785EDD56
          5D4C5C55109E73D92D547641FE76175B0AF862AD894801AD354DF5A5DA884D35
          3EF8A089BE1813B58989D198F6A1B1A698188C696A5263E24F5A1F7C29D5C652
          1A0135464D5B90D446894D0BDD0516A150BA40B72D7BCE710EE72F877B57C28B
          31DEECDCBD67BE333F67E6CEDC2100E052FECB8FAD7C2F573853C4C546EFE027
          DD8F1416DDF6AEE779CD9CFBF61BD29845115FCAE3065198BB6694F6CDCD67DE
          7AF395D61EE50484DA3FEA194F8E4EF3A0ABFFFC18CF77F5FD361A0830A433E7
          46C5BF2526692835C5F71F38350E00AB904848DC50225E734719702E3D25F6FC
          901CB90A0D1B12E01E56EC230AAB46397FA446C610BBBB1A57AECEB5D56520EC
          21E0190728939B987080BB49143CA670A3C986D987715C1322F98C3123C09558
          016268CF985874805186A80014572747893101732E41666C09A656262344166F
          EA10DA71894B96B488F6B40344DC8ADEF9A02BBB6DEB0648A567EC51DC4BF3CD
          9DDB50B864B96A87CB4CC44AE054EF79D8F7466B04811B3205944153C31AB867
          7DC2F7EE9FECFD031E7B78BD34C8B983777D3F088F6EBD4BE59D38A6BBBE1B84
          6D88F1258E850B3C38D97DCEF08403225742B70DA74DAAE18B141042542AA433
          9C094C6B37F9D61997722ACEBA6219413E5DF20E50D70181D87A362F2172054E
          B8FA17A8C46C86A41E9924ED1CD7FE8A27F03C94E1DC8900A794A52F5C9AA8AE
          595BAE4EAF045030561945212FA0D171A8AA8842A88058192026E495E511082D
          6A77652F0E4D80B02710AD29FCEC4B075A5747CA0E211E9335AD4F6F23E1EF72
          B613322E412DE93E1B692D333197997CF9F817BB8F237A8B88D2549158A59E89
          73D4E57BBC7BC4E565724837906E225161185E7CAF734B6151A40D63DD6C9A8C
          0EAB1B09F9B3A7B4FBC45A81E68FE93D5627A30BBFCE4E8FEF39F6FEF3DF6A07
          48F666E8C8A6CDB5F178555409DB723B7D66185A9AEB9C3418EC34622DB54EA8
          952D941B82FB5BEA9563B650FE9AC834F6F4E63EC5653D524E38E0213F5E5E56
          0C1727E6DD7ECF095CCB2E20FFBA6A3E6E5167101B9ACCCAA59B7098CDE660F8
          CA75D4E176A4444544F0623ADDB215232747992C436E7773D386996A34BADDDA
          EF0467CCED8ACA55C4ECB7855B7881325DBA443B207A737A247DAD1ADBA435AD
          04C6420462D142E77DD02537825DAD12312B63AB2385E5595E1C06F509314D6D
          746C0638A3E3DA2D81859F78ED706B51B4E21010125349745BAB3E0901C3775F
          4A493A381677CB52800CE8E4EC646AD70F9FEDFA4A54822EC3B0A2900E4DBE92
          5A41990661DC9621644D19BEDDDEB1A56875A4CDF30A9A0064BE09F89B898EA7
          2D3D6A9E15604BD48ABA1160B43F33736577FBBE17BA752BF672347CF8E9C71B
          E37535E5B0F4FAA53F099B36AE83A0EBE7BE243CD8E460C6E84F672FC3E6E65A
          DF78792939B5F1E3233F7E8E8000A92C43C6E2F5EB2A0247B2E1D4343C800E04
          8C64884D092C70244B8EA25C63AD6F24ABAB413B94CB32FCAF8C64DEBF3F9251
          E980BA15BFBEF7E8DC8EEDF7C1E59169731477B63216244A44A4563A9249BD6B
          12A570ACB31F0EEE7FA614817933923DD452074DF7D6F846B2A3DF0CC053DB1B
          0247B28ECE017812B1A091ACE3C400EC442C6024439D67DD4E4819FD87918CFF
          FF473246291DFFFDCF74E2CEBA2ADF48968897E61DC91255257947B2586549E0
          483678210DC29EB0AB3515EE7CAE6D47F4F6D8878478554E4DEB28386BB71F58
          9EAD51177289733699B99A7EF5C4977BBFF67F0B961FC92CAD7C0F5744916E21
          2D20D1BF01BF3C33EF5CF88FC80000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F40000001974455874536F6674776172650041646F626520496D616765526561
          647971C9653C00000025744558745469746C6500496E73657274436F6C756D6E
          733B477269643B53707265616473686565743B33F87A6E000004A94944415478
          5EC5575B6B5C5514FEF669A633499AC45AA793A6A6286D2DB54A5546A45021C1
          16A4685FC41FA10F8D7801059FFAD2FA5205237879F121ED830A8A2848BCA52A
          2AADB192603335696A269D3893FB24A4D3E9CC5ECBB0CFDEFBCC768E671EAA74
          C1E61C98EF7CEBF6ADB519817A130837FEEF312E4838C73576C86F1E63B14DB5
          E0D7DF1DEC8DC79B4F7A9E9756FCCC801020297F295D5B7DE585678F0CBDF8DE
          D99E784BFB0921BC3483C1CC3E73D5C7BCF14CEFD0F1539FF42412AD27C2786E
          944B2FBFFAFCD16F4D404D08CC8BC75B4E3F71685F6A7B678793CA4CBE983EF3
          F1F901007795AF7B03870F74A5B66F6D83D0690806A66757D39F7D9D51984462
          D3C0D34F3E98DAD1B5D9E1C9E696D26FBF7FF634803B01485D01A764A9AE75E7
          55492A68D61EB6A5DAC11029001E3152DB929BF0C77C09E5AAB49F265BE32040
          619891EAEEDA5CC7D3DD751B48F198D6B801D87292099B82CE3193F2C4C48AB4
          5C91B0C67E2B88D8C73045F048FC5B0082D8D50B0B01A1E19AD393C4D041B8CA
          E20013CDE308941D1182193F0F67F1D76C51611C1298EC18C313F318CFADE09F
          266D95085F7D378EE99945001E0223C383D01610331E7968072A150204AC7A9B
          36089CEC9F51E4448CFDBBB620DED65C93BFC096D6183ECCCEE94A321E7B7477
          28CF4BC7A79D1698F04C7FEB47DAEA826D00443A1706481DAD01E6863C921A54
          0070F09687C906A0C89800B60E841F88C6488AE4712B103A05011E064E608B21
          E820186008B0EF5C9D863C9A3D7C0A88F0C3B92B28CCAFD65F0E351518CECCE3
          CF82C6306C9FC962085F7C3386AB85228CD96CA35B001C7CF86E942B559599D0
          7DDE18F3303296B5E4FB77DF81E68E16EDD88FE1F6D6183E982C58113EDEBB37
          94E7D8E86484089DE1E65A1C9810889001D210FD85A301A6489E880A280206B1
          00847BB93193CD4EC2F458C3E04F0011691136E6D1C7D5801198B02213305A97
          1C6C4B960CD6E95B4DEBF1D48B288227BC02C25460E8C7CB585C5A83F667A367
          E9B393645CC81430B35083619F9C58DA71FE74F077CCCDAFD6F30463183E053D
          0776A27C83B4B859E5118F79F875E48AADD2FDF7A4D0B670CD59AA1D89264C8E
          E57C1E49387A785F28CFF90BE30A1FB90798D5BB292218EE2222B303EC1320F5
          D418A6463CE153601789A85D28F6DD56894D10D60B405A880D79DC3D203C1D8D
          BB8ADDF5A9F73CD916C8C0797017480E56B1A4101EE383A235F0E5F797B05C2C
          D560B4839AEC462E1550582AD91917027597D1479FFFA6C46C8B1CB4207A0F1C
          3AB807A572D509201E13EBE299D00100F7EEDA8AF6E5EB0E516BCC4366346BF7
          C053471EA8E3496CF4F0D3B9B188CB88E08C96E91DBBD732C815A0C25A0DE82C
          A378B489903D4080810A3319FE8B94E4B483355240046BB94A68C443147E1B32
          009252E63313F9CE3D3B3B1D0565C6F360A63C802AAD63A6B28B9DEDC9B600C1
          406E6609123E46CA6A7EF4E274E77D7BBB1D9ED18B574124F37A8BB30980F5A9
          4C4D5D3EF6DA9B8B6F09E125DDFD4073CB8BB9E70094F253E37D036756FA0191
          6466DB0A223977BDE863568AB37DA7DE19EC0FE3595B5BE80350317E8D1884D6
          434C9F0D704D02A8AAA7FF5BD34D602AEAE82ADCF2FF8602211646FE7F60EC66
          BB95F637D3DEE30DEC60042C0000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F40000001974455874536F6674776172650041646F626520496D616765526561
          647971C9653C00000023744558745469746C6500496E7365727453686565743B
          477269643B53707265616473686565743BD0461D44000005C349444154785EC5
          977D6C9E6515C67FF7FBD1BEEDFAC67DB18A8ED4B119858DC9744B2899B00EF9
          DA1F54A70467C288CEC4C404027F2C516041306A103413139D816982868F89D8
          8EB8AC61D2490C148A6E934D976D1D2C8369590B9BF4636FFB3CE7B23127F79D
          37CD6210CDAEE6C9737A9A73EEABD7B9DEF33C6F90C4B94481738C12EF036F3C
          7A0D00029090A0EDCBBB021000BDBE75B5042CD8F05CF07FD6061EEE10AEBAA4
          F747C04C08EF27E128BEFAE32BEEBDE4D6E7EFFBC886E7263CD7B86FF3CA4D9F
          B8FD8FDFB22C9F14809C400881FF16471FE940924B10F0A05C297367DF039797
          2FDBF8C23D002FDCDF7E6FA51C3602DFC9737302024D1FC17B6273E1577BA7D7
          40D172E3C2F6B51B7BEF9B2C815874F9E7EE18DAD30D50F8E82D0F7370EB5790
          EA4710FC2AC4F83F23A43B25A0EC7125CF8CD98BAF64D13BC7EF20949875F1A7
          19ECFF0DC08C62F522978A4960221EFCB3477B3B9A6754BF5728149683100EC1
          F430E5CF9BD3CCDCA12E2AC7B78340FEF3F1759BD0C46942C36C541BE66FDB7E
          5467D6D3A3930F767C7BDF379D00A5471EEF3B7EDDAA8B5ACF9F57250176F70D
          B0EAB285D4037A5F3C4247FB22408C8F9FE170F70354CBC3B45DB50E08D8D81B
          64A70E119C50A9BA80D0389781679FA47F47CF43EB9F38711730E6B253DEFAC4
          4B676EF9C20AC66B3926E1A067F701AE5DB5183953DC733DBD53F9D58B41502C
          40AD36C6A1AEEFD334FC3C0BDB2FA1D0D04C2857C040D918561BE5E0EE7EF6EC
          3DF1D3AF3D3DF80D60A47BFD872C7AC02484E2E112840066E917000581C0D218
          908499A8549B6829B6023993C3479044F0BE48B4CCA9F281D6AA603000CC993F
          93444069B631F4487579276286104560A236CE9BBB7FC24C1DA275E952B25347
          513611E7ED04387F612BA5A6195F7F5CCAD76D19B87BE577FF3AE223A071CBAF
          5E1C5BD0369BE1B747090205402E3C7E973C1F33CC9A59A1E5D8368A879F4A4B
          0971F18AF980C525B5FFA53791529FA191ECC11BB71CBD332A909BB1BA7D11A3
          6319227856ECD8B59F35572D81440380DF3DFB17D65CBD9402C2966DA436711B
          3263DF81D7A8ECBC99D03C8B5777EDA156CB58B6723E5996F3991F1E59029CF4
          8FE019202F79CF20974BEE340982C0AC6E0C3136BFE70A10CA942B25103435CD
          6032CF39FCF261DE9D773D121C39F07B2C33805160B8E7D605B94C88B409B1DC
          0F3208B852EE03C52108231090139BBE2F0890673943CD57F2C92FDD8524F63D
          56A070B28BA87666BEC24532A17C5E8005DCBD0133793E1D66044C421650706B
          2A2044B9DC40E3F29B69BBE6362ACD2D08F8D4FA4DF4FD1260F319F837C1A872
          9D0776FEE1206FBF338208847420DD3BF7029A3686AE9D7B9048FA487C705E0B
          79EB5A4EEEFF3BFF78EB5D102C6C9BC33FDB6E02364F00586E4E209014C8C5B5
          577C8CD1F18C88005D3BF6D279FDA5F52614FC76EAF0CEEB2EF5842B003CBDE3
          CFAC5DB30C089174A55CA4EF17C722FDCE9F9F402E7734A1994DDBF73230D5CD
          D963F7402C0878756C2CDCD1014C909B00C259DF88EADD9E1C6512240671292A
          120B75ECDC339168104ED898FEA485E481DC3094960FA91037A4A7911FE46C49
          88C412610252FC944D43F28089EE9EFD9C3A3DEA52A706BF7EE6155F604408D8
          F64C3FC45CB2EDB6EEFEE81749545B2A185101BF23EA09189D572F61643C4BC5
          88A7B6FF89CFDFB01C20A9133475C82BDC78C30A4004F0B9C093DD2F7353E70A
          CF0A040D0D457EB0A5271148486F40B94B1737A213CDD34B278A9309510D2F47
          B1DE2929794A26643A1B01AF3383B4F1121129551931E71700261C292F88BE51
          80D8FE2C1EB02CCB06075E7FABF5820FCF8DD347506D6EA45CF62E516AD13295
          6F2C17DC879E079A9A1B682815D20808BC766C887CAA3F90530FE2E3F88B1BEE
          FFECECF32E7828148A7341C98849DAE883140A625CBF2645825936343478ECF6
          ED8FDDD3058C03921707BF8A4003D0E8AA24B79E05EFE1CDD9800CA8E18F6027
          503782DCFF38190BFFB710607E4DF38048C8F8FF42D48373FEF5FC5F275785DD
          1F9FE0510000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F40000001974455874536F6674776172650041646F626520496D616765526561
          647971C9653C00000029744558745469746C6500477269643B53707265616473
          686565743B43656C6C733B44656C65746543656C6C733BE98258AB0000060E49
          444154785EED576B6C544514FEE6EEABA5DD16BA7DD1761711DA9ACAAB021111
          91828D4222A88468242A4842444302894629C4072418E21F8310E10711148D01
          E4551491D04203C5421FD052BAA52D2D146CA9690BB4BBD0EEDEB9DE997BEFDC
          DDB6960026FC71BAD37B7AE69E39DF9CF39D335BA2280A1EE590F08807F9717F
          39A0000B5F7D8A3C883DEE3D7888B7EF2E55162D98C415A15127215312F2C33A
          EE0F40064099DC17809539DEFA7D61CE9028E79792244D6280C5B2108438805E
          F9171DE14F39289775DDEECC5BB17476810E44580B00165BE4CE9CA9E949C313
          9D081DC7FF6CC08C29A3D077149EAE47CE33A3FB1DB3A0B81E33A786EB5BDA6E
          4F3C5C78F107001E007440008490A4E40427FC7765D090F0B47776A3FB4E503F
          0F37E5727B870F5DAA5E6C451410107468EF87B9881F160D4521890312DEC83B
          73AAFE08E706064AC51F9A9E305901ED1B7205DC9652268B448BC850AA085FE8
          33AC1A00338E8668B3128CC94C86C36EE96737262389AF07021C90B64AF4DCF3
          494C101C1815B60301804215149CAEE7A125CC86006355E7DF1CAE03944B8CB5
          7C72A04C568595F3804AEF5F0234219ABF4347ABC2A233343692BF2F4E315004
          644A31532595CF1F34CE83088784B6D6522C5EFC9C960EC50CFB8EED45487F3C
          11EE14979E1A4D9FFF47255ECE1DA747437BDF6123D8F673C9E000B4131A1B71
          59348C20051ADBFC4CC7031B136905151933CB8E7FC238646C42580A0605002A
          EB8614463EC54601754D961551EF41CA1937600F30C8CC53224A0702C02024A4
          26F309408C88A84F992A186297F45C2B080429A8B12EAA90688E6948F48CEA30
          0160500EFC7EC2CBEB58AB6805139E4C85DFDF836D5B8E42310189F07AEB5B51
          5E75CD64BD9623ECFBAD5CECC13E313191A0F2E029202C052F4ECF84EF4E502C
          D8ED167CB5EC593C919E0C08379A5053DF82D1235512A6B9422200EC559DBF36
          279B694482226C166CFAEEF83D0050DAAFDFDFED915156D50CB73B1EE18B0A4A
          2B9BE149D3F520A0217D43F507492208040159A78B2B2ECAF065E31684C81AC7
          15AD3D52412A18352F4805517E42CF9EBA5A3BB995390545647911DAD7E5E1EF
          82A390240A0B0124A26094270EF9AFCF5F5CF7FED2E6B3EFBEF319003B0022DA
          A32C5350AD8E42C8AA77B070C27199035644A7E38E3A7E3D8034BB0F696FCF43
          6FF949B41C390C76504A83B05E2CC3C469533678962D7479A64D5E73EAAD373F
          67B84352A0E0C0910BB879CBC73D994546B03BBF546B2C7DAEE65DF967052AD6
          35630B8E2169D11C042E9563E40B13E13D5884922B37E08C7562A4AF19AEE9E3
          11A82D45544A3CA288E53D006B01040407E6E58E316F3EDDFD9E8365983F7792
          7974F01AC5AE03A5583077B2B807EC36826B39B9A8FDE91046CF9A809E062F32
          673F8DDEBD27E04A4942D28C6CF4D494F33E53B5671F4ACB6A9973D92C4323A7
          FC49443792A1880EA868BEC1043D1A82D841194879690E4EA927F6FF5284ACDC
          09F07B2B91357B32231CFCE7CEA836141587CEA0E47CE347ABAF376D0510D001
          B035B30A88E654D4B6A81D2A522388CA36E77460BF240B629FCF85EC74A062DF
          7E8C9D9985AEB2D3229E15C7AA71B2B269D5FA8ED62DACC898D2004083C1E08D
          86A6B624776A7C586F770E71C06623C62521AEBC6855EFB049467170BD240116
          AB04AB43B571B9D07BAB0BF2AD6EF3564CF320AE3328A1A395F4FD7219F9C692
          0DAFC425B83712C9120F282611456ACC1210A25002A9C943919591007F71211E
          6BAE407AB61BBE9A6A8098AC8D1831020D556D283E5FB72AAFB6721300BFBA07
          257A14EC001C5C36CDC87D7C2BB67DECC958322B3BF3B38CF1C3E1AFAFE3C6E7
          CE5C06B1D9313E3B8D1B39925370C9DB8EE2EAA6BCB557BC5FAB00EE3087B29E
          9380707CFF23DA03EB4A8F3B1A5D55D59C1317AAAEE1D4D58E4F599FA63D812F
          C68E4B41F07223D212E29008CB2700BE05C00088A806F1E0E34E8BCFBFA3E674
          ED72778215B5175B50D27A73F5E660F7667EA2EB56AA825A9799998CAB8D57D0
          DCD5BD134040E4F221A7D151633F74A66E5C3F7444E772BB330F400CD31B6B1F
          440C5BA3AEDD5CE14C61F98F637A66FB9FFC734A8868EB113A9F7AF449018835
          7DF6B288019099EFFFFF3BFE07A65D80EA98CB7EB50000000049454E44AE4260
          82}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F40000001974455874536F6674776172650041646F626520496D616765526561
          647971C9653C00000025744558745469746C6500477269643B53707265616473
          686565743B526F773B44656C657465526F773B4EBB582B000005FE4944415478
          5EED976B6C54D711C77F73F765632F061B6363AF172809561006CC2349514481
          1429F021A44AF31051DAB491A23E148948ADDA385168894A956F559428A19F92
          36E9873C2040221A45B15B1420267E041B830DD8184C0A86DA066CAF637BEF99
          AEAC7BF76CBC400554CA97CEEA68CF9D33A399F99FFF9C73AFA82ADFA6387CCB
          226F7FD0040A8FFD60A9DC8C3FFF5D14E08D771BF4898796039089BAD88163E7
          B718383B011730804E4E200838DBFF52B7664A5EF48F8EE32C0745AD2B59D32C
          BD5E4327288A9B741B07AF0CD46C7E6A7D2DE05A4B6C028150EE5B6B56DE5E32
          6B66944CF9C7E79DACBE7B1E93A5EEE049D67CF7B6AC326B0F9C64EDCA6FEACF
          5DB8B26C6FDDD1BF0271C05C35011129292D8E92F8DAC55878E81B18626824E9
          D5032828D0D73FCCE048D2D6228A20F47BF69921664CCF4755665E8BF00E2046
          1545D3C1BD3F8CB10F002A0A286632E4CA84AF31A00A8AF553C018C5720C2623
          20B363858808A1808362AB8ACD2A2018CCF68B954C4DE90551011F1F61C23E14
          1440D209041C98139B7E5D36E76EDEFE79424973D4F3B573CB5CB1B4535F67D7
          5141C5834015554BC83F3FB32A0A8C00EEE42E902B9712FC70E36214416D689A
          5BCE525D1543FD88DE7A73EB59962C2CB789AA62045ADAFEC5A23BCA0030B600
          76EF394C36FCD8045C57E91D1C632091241389DEFE04C7CF0F7FD355E1E24082
          931713F8C58A87F8BF0746E8EE4BA008AA2028537343B8AEB966020E806B0CC6
          801AC023240A6AD1BCFAB3F7F3FC2CECB60A8C2AAE517BE85D1D013361949F13
          402CC129C80B13CD090264B29FA97911F2C2BEAD9568CA7E4A2498865E048C51
          8C31D72561F4E12D7FBF624927B6E1511021FBB0536B02961F7E4378BE765DD8
          F1870DD38121209945C24D2BCBD9B07601A3632ED6070E3576B362E91C1BC29B
          D4379FE2CEEAB99E823417EA9BBAB86BE977C89450D0616FED11765C8F841D9D
          BDDCB7FA0E46C72D54AAD0D5D3C7A2AAF8A4F295AE337DA92EF0F4083A1148C8
          9B12468D8BE3388C2715577D720EFBB1420022E2029A121CEC49E5114C51B504
          42FDE09EDEB78174DB0603E060C86DDA47DF8B355CACFD04C73104041C51E6C5
          0BD9F3C8833F39F18BA77ABEF8E98FB700611F50C727A1F1686EC9EA91C763B6
          6D792F61B5CC0F08F47FB48B587898D88F3632D6F419E73EDE8B888B31498247
          1B5976CFDD2FC57FFE5851FC9E15CFEF7F7CD3EF80609A03C628BB3E3EC2A5CB
          C3965C288AF0EE9E067BB25ACAF1CE9E2F7C43AA2A4B29A8FD94922736307EBC
          89B9DF5F46FBEE7DD49FEE255A1065EE700F45AB1633DED1405ED90CF224F033
          602B30EE2560D8B86EA1BDF9BCF0EFED6EE4C1FB97039049F1777635F0D0FD2B
          004580704838BB661D1D7FFB90DBEE5DC268673B95EBEF626CC73F292A2BA164
          7535A3C79A5003ADEFEDA4A1B1632BE0DA7340D5EE3F020220B87E3FA3A8DF5E
          2A160D0480A40B65F76D607FAAE2C4FBFB58B06E0989F61616AC5F818890F8F2
          10AA86E60F0F517FF8D4AF9FFBAA7B3B30EE27A06A4C66377B010455B5BD63EC
          D6F84415118C821A052740C1F7D6E1462334EFFC80AA545B0F361E4CE3D9FC69
          1B9FB5743FBBADFFFCEBC0D780FA09986432D9DBD97DA1A4A27C861F0214A253
          228442022A803DF4F353FA48C8C1DE5182E34020E8108CA47C8A8A18BB3C887B
          79085FA6C5E2140E241DFACF4BD675FCE8932F3D50585CF1B238811999A71CE9
          AD01EC73D69B6D79E93416CC2F2671A08E393DCDDC5E5DC1F0B13610CBDA9CD9
          B3E96CBDC081C3279EADE968790548A8AA110F853010F1E6BE9BDCC05B71E837
          F1F94FDE5B5DB965FEE259244E9E40802F0F7521A1308BAB6300444ACB38DEDE
          C781B6EE9AADA7DBFFA4AA2341C0F5F664DC06BE61C98F137C265E91CF606B1B
          6A9423AD67D97FA6FF0544C58C8EFFBE6A5119C9AE53C48A0B9949E0B7C06BC0
          44023E96496E5E46CE0D27DE3C76B0E3E98AE2201D47CF517FFED273AF26875E
          0590AF82468DBE585959CA9953A7E9191C7A2B5DB0AADEF2001CA0E057D1F297
          B74D9B3DF074385A034C051C7FED9739D39F4FAD5DDA1C2D7B0528041C55E57F
          F2712A227E12391E9F46BD6180F49A37C632DF0DFFFF75FC1F2EE96901DD0463
          D20000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F40000001974455874536F6674776172650041646F626520496D616765526561
          647971C9653C0000002B744558745469746C6500477269643B53707265616473
          686565743B436F6C756D6E3B44656C657465436F6C756D6E3B4C3C49F8000006
          3849444154785EED576B6C54451B7EE6ECAD65BBBDDF68BB0BD5424DA52D8512
          84204AB151880695188D44414988979060A2F93E0A118504C33F8310E587F106
          C644E57E1109451A5AD2DA0BB4946EA1F7A514AADD2DB4BBA5ED9E399E993D67
          CEB6A93580097F9CDDD99DF3CEE57DDEE77D666697288A820759243CE042F61D
          AC051460D50B73C8BDCCC73F174EF1D73F562B6B5E2AE48670D649589544FBFE
          1D8F072003A0AC3D1E809939DEF3ED992553EC8E4F24492A04143ECA99168BE3
          EE7E50457DA6BC8A36B3ADCC4F46D7F57E365AB8D18A6623FC5B0ECA3503B77D
          251BD62D2BD58088910280C912B977C9C2192953931D46880438DD5483678BB3
          018584F95070E457371E9F9F092D10D1575AD182A28559082F3DBDB7E79E3873
          F93B002E00744200849094D42407027764506D558B59427B773FBC8120BA7D77
          04E9E9B111E8E8F66168846274946A68151010787D83181C0A8E719118170545
          21C9130A5ECF3BA7168AEE5C44A6501AF6C09BA114A8D570C2ED7C6E68B848B4
          3E8D8F171A1B57CC2100068FA2C95E942DAC8B46A481DB15084FA11EA2D97825
          06080E8C42940900F0A84ACFB7A0CFEB676CF2943B536340158ACEAE7EB4F6DC
          0648C8FB706A3477545BDFA58AD027401312F277F454C31876626322F9FA2282
          8918902945D1822CF803413D1E582C04F458339CCE5898A323A0933035DAC629
          9D93EB42EE23190084465571D6E3B9E23C80087260B3107CF943A50030A10618
          C59C2DC29F0C7A35FAC35304704A79D3A80AF81A4243E283BDD9F8490180CADA
          44CA1E842F7DDF0B20FC4589DA166E0DB0DAF8F136600C00F237BB800AB153A2
          A3171345A4A042849C2E615788D821618173E6A80100936AE097B36EBE8F433B
          5A812B3D8EE368EBF2C1D33B28800492A2C0125055D78E768F57B36AAC10E0C0
          F15AB1067B47474782CA747211B2143CBD381BFEA1A0E8B05A257C76D80D9733
          0EB69829C29EE2B0F1480B674F47DE2C27B7118D8DFDAAF3179717308B389023
          2C26ECFAEAB7C90118541B859B84B80010A1055E8D0904949F9C04B3B253A1FA
          8324118C06015909A52121DEAEFBB2F01984C8E04B299A08A938B5C6381007A1
          325E9C7A3B14B999390545646D19FAB695E08FD25390240A130124A2E061573C
          8EBCBCF28DABEFACF3FCFEE6EA2D8C600044885096296828BC3162D5C569DC6E
          44B5F1B074B4AC7247DE63879061F523E3F51518A93D879E9327C002A53408F3
          E51ACC5DF4D80ED7DBAB125C8BE66D2E7FEDD58F3823460A141C3A7909FDB7FC
          42C10FB9E2B9DA3B3ABDB8DEE7875EFC89760EA2BCBA056D9D7F725BAE4A7D4C
          E969A4AC598ED12BB5C87C6A2EDC87CB50D979138E180732FD1E242CCEC76873
          35EC6989B013D35B00B60218151A58513C8BDF643A07568B849D87DC70BAE210
          196717124AB45B798A161466614EDE746D2CC1B525C568FEFE28B296CEC670AB
          1BD9CBE66364FF5924A4A520E5C9020C37D5F2801A7E3A80EA9A66E65C36B6A1
          A218F907D19CF1BD6D149D75088D8854056520ED99E52857230EFC5C869CE2D9
          08B8EB91B36C1E131C0217AAA028147547AB5079B1FD834DDD1D7B58F41A00D6
          47016347875DA954139C068C9BC28F5A4D0EEC433221E68962C80E1BEA0E1C44
          6E510E066ACE8B2D5977BA11E7EA3B366EF7DEF802C01D66D401D0603078B3B5
          A337C5999E08CD1D5736D5241F67B768FE08A8C680D9CC0449C455284980C92C
          C16CB3C1929080915B03906F0D1AB762860BF1BEA004EF0D32FEC765E42B6B77
          3C1F9FE4DC492453A2CE75FEA319D857E609A58572E241A971E9AC2ECA44DD25
          0F58494F8D45CECC24042ACE60BAA70E330A9CF0373502C4485FC4B469686DE8
          45C5C5AB1B4B9AEB770108A8EB50A2B1600560E36D631AB98B5FC596FFB966AE
          5D5A90BD6566FE54045AAEF20117AADA402C56E41784AE6D5B6A1AAEB8FB50D1
          D851B2B5D3FDA90A60883994B59C8C0AC7775FA25C30BFE7724661A0A1913376
          A9E11ACABBBC1F8228840E8F7E9C9B9786605B3B3292E2910CD3FF017C0E8003
          D0251DC4BD97A11E7FE09BA6F3CDEB9D4966345FEE41E58DFE4DBB8383BB7944
          DD66AA82DA969D9D8AAEF64E780606F78A80551AEEB7EA276ACCFB8EF49DDB63
          A7F9D65B1D2500A2995DEF7B37226EB3DAD7BFC191C6F21FCFEC6CEEBFF2E794
          1071AC47687A1AD62A0520FAB43AC218032033DFFFFD3BFE0B7A23C2C95FD428
          7B0000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F40000001974455874536F6674776172650041646F626520496D616765526561
          647971C9653C00000029744558745469746C6500477269643B53707265616473
          686565743B53686565743B44656C65746553686565743BDD853038000005B449
          444154785EED577B68144718FFCDDEED2531B924E66D5EB6F591127C2455B115
          11A3869A40B5F4414B4B9F82F4091684D628B555B0F85F11A5F847295829C55A
          638C46ADF57C608CC6BCCC43134D34BE885A4CD4E42E26B73BD39BD9E9EC9D4B
          52D082FF74B96166BFD9FB7EBFEFFB7E33B34B186378929786277C11C7F851FE
          3F7A630FF508CFBA9B03CBA6A9F1E3023B0998006818890802DAD66D478AC6C4
          7ABFD3346D26C0C2A83AC370DAD90836227AD330EBFBEFF795AD585EE2934498
          83804B8FD95E346752FAB8346F04BBA3A7BA30FFF9098E908ED474A2E885898E
          307D273BB1604EA4BDE7F6FD19FB8F9CFB1940AECC82930021243D23D58BC003
          1334AC3E77FA0630306858F14814C6EDBD7EF487ECCA15612020E895CF8743A4
          8C8D0363246D24C18BBA735006A6C065074AD58D65274CB0A00FA79C4110A7D4
          1AB330274CF8610ACBA90141C0CEA33DB41DD87662D92815F3841180F7728ADB
          201AB149086214235D6ECB2183AFA653A4960769F9B51C551D6E95DE19B72B32
          557FB67240754FAC47B0F7504B447612136284FFB0E89D193029C58290A8FC01
          43C423EB2A404A174E9199B03DEC3BD48CD2E2690A88C989CA3F9AF112B7133B
          73513AC18FBF9E1E9D00E3D1C9C8016B4C98AA9D72263B87945526223464B393
          2520238910D4944094DFD840CCAEAA149FECA99A55E0C20F73DA0084132023AC
          026A2B5FD69FC90C3026EF21E7412C204A6C728C581954CFCB4C711F36018CAA
          8103C7DAC53AB656B40D5871A0892338CAB0FB40A30053AA177503CAAB1A940F
          FE8B8F8F0135E9E81AE02578715E1EFC8346C46EBFBBAA094B4B0AA060E4A03C
          04BE7471016CBD0A38EC0A81BF525AC82D8A74B4EEC2E69F8E8E4E40A6285258
          54D65419E4BCD200A4818834EB6E8229791908E141D30882066032AB0CC949B1
          120BBA60428809A1592645A8D42EACBC2951D9855676DE4BB315B99B8382624C
          C371DC59BF1A7FF90E41D3285C04D008C384DC2454BEF1DA07173F597EEDCC87
          EFAD05E0014094084D93825AEB284CAC7207E360B6A89538255BDE0450DFBE0A
          6479FCC87E7709861B4EA0E7E07EF0402935E06AABC38CB9B337E67EFC7672EE
          DC596BAADF79EB1BCE3BAC040C15075B71F79E3F3CD522C2DF2AEBE4461879F2
          EDA83CA3584D0DA53EC1E743DAFB25085E68C0D38B66A07DCF719CBA720BF189
          F17826700DC9F3A623D85187D8CC14C412D74700D601082A0D2C2D9E629F7C12
          7EE79E7ABCBA64A6449533846147451D5E5F324B9D031E9DE07AD12274FCB217
          13171660A8AB1D7925B331BCEB189283E9489F5F88A1F30D42572D3BCB5157DF
          C1C14D7B193266D75F8040809990BB22EF05B65AF3112F468609642E2E4575F7
          2D047E3F8EFCE20204DA9B915F328B0B0E81A65A3046D1B8B716B5672FAF2CBB
          D1BD95472F09F0397B1510092AD7B6BD76A82A8D122A774EE50604CD8584F9C5
          30BD1E34965760EA827CF4D7D7A87C361E6EC389E6EE551B7A6F72F007C22809
          50C3306E7575DF4ECFC94A89D8DBBD63A2A0EB441E12F6911717B247E91A9862
          4DA06980CBADC1151D0D3D3919C3F7FA61DE1BB04FC5EC5C24F5191A7A6F9287
          5F2E63DE5CB6F1E5A4D49C4D4473A520EC88852A0D0075EF7CB3CDCA4844FEE4
          5404AA7D78EA7A132615E6C07FBE0D20B66AA3C78F4757CB6D9C3C7B71555947
          F3660001C61825320B1E0051724CFEF5CDD739A77F993369D9C2E79E5D3B79FA
          38043A2F0AECA6DA4B20BA07D30BB3010E9091890BED7770B2ADBB6CDD95F6EF
          1963831CD09435093EC6F7415C2ED1BFC8CD89437F4B9BD0446BCB75545FEDFD
          1A84113A14FC76EAB44C18972E233B350969707D05E007009C80CAAA8147BF06
          7BFC816DE76B3A3ECB4975A3E35C0F4EDFBCBB7A8B31B0454474C34D1965EBF3
          F23270F5F2155CEB1FD8AE02668C3D76933B6AC24A6FD6A60D89E3FB3EF778CB
          00C40BBB9CFB347AEC9AD0DCDD15DE4C5EFF246EE718FFC9C729216A5B8F967A
          1A928D025073B20DF38C013039F6FF5FC77F03998A6D057A9813210000000049
          454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F40000001974455874536F6674776172650041646F626520496D616765526561
          647971C9653C00000024744558745469746C6500477269643B53707265616473
          686565743B43656C6C3B4F7074696F6E733B89F1EC240000080549444154785E
          95570D5054D715FEEE7B6F59967F54C40824228268636A238D55C696906ACA30
          2626B6336A6AA3A94D8D9D4EB1D14E276935D1669C6A9D4CFD294D5BC79F4862
          47C508041014348C22F21385FA17B035810A5DC16577D9FFF7EEEDE3EEDD374B
          181979C399399C73DF9EEF9CEF9CF3DE2325A7DAF0CA4B4F138CFF7A947B1800
          1C3ADEC2D6FC282768606CD48F48428890F1071E1B8006800A7D1400E58323F5
          F951D1B13B2449CA01185818F651EA283B7B888D709FA66AAD4E87EDADA2D70B
          EA0410E3A4014036598E3EBB3033F9B1C9B1231CE72FDF41DE773246A554DFD8
          856717CC189566DDA52EE42F1C69EFB53AE655D5DFF810C0E3A20AA301104292
          A724C5C2EDD540C3F819B00D61C8A38A7C7814AE0F3C70C1A9DB8D5C080301C1
          03713E3CC4A4C418304626738A1F7249C3411998113C848152E31F2E8C308E82
          7E9D06060E9C52AE87883698A194EBD2C37A47E17E713AA49A148227674E8139
          421E75DF9359C9DC1F087040412F11DC0BFE0D101C18C55897C228435D63172F
          2D610023C01C3DF8DEAA4E807D01C618170E7458D7958D2F02EDB7EE19A009E1
          2E54D4768CA02021DEC2CF8F35398A4629F2F5A672B9D5503E88344BB0F6B560
          EDDA450020827315870F7D86CCE993913675A2A026682FAF69C7D2C54F896A04
          CF9B4D04078E358D0D8067283207B86E2C0C9502FFB1BAB98D8021CEA2807E6D
          1A99802D49002102ACF0320A4804086F4242C8480054330E1B7C86280CE83E4D
          63C6BCAB94779C115822048A4478F0E96909506406CA82FD613249BA9D217B06
          AF942C84BEB9F52F4CBF00D1FC0A65D4C89A1280842AC21834CA10152109AE19
          022A050DF945D6F7FB6D686ABD8E3B5FDE434F4F0F0A162F103D41517EE6126E
          7676E397BFDDBD7F68C8F1E783FBDEBDB2FBDD0DA0623436FE6E6FB007AA2FDC
          E2731C9C6886B9DF4881DBEDC381BFD6C2A048042684E156571FDA3ABA913625
          1E77BBEF62CEACC7B17CE92254D636A1B1B9033973B371B9F9264C26056FFD6A
          155AAFDD5E5172B2C60BA00580166249D3B42005CF7F77265C1ED5E0252242C6
          AE3772919D39C5E09B08E566572F32A6252135650264C2607758E1F7AB9C9E82
          C5F371B0A412D5E72EEB8D9A8A753F5E8A8046E1F6F8A005FC6E410393258902
          C01B9B763185523A6ADF7B7D1A5A87334C9B84914E865EAB1DD3D22642E2F562
          5064098376270823703A7D786D55211493CC7BC7EDF5F13E197438E10FF82900
          93C8850E4BF19F366B8AA063C4060308E73A2C30779914C06226A86BB882B898
          689D262FDAAF77E1D5950508A81A86E9B439DCBC5FC41F07B068FE5C745CEF5C
          FF93F55B3CB2242783106A1FECDF575AB2E79AA26914149CE4B071151B8C8921
          23004487DCBCDD85ACE9533160B373DBFAB5CB10A38319727939805060AE08C2
          A9A6E9E7962B35F54D9BD3A64EE69E83473F9100FC9C6C7BBF9A656624EB6574
          8DB89987E35D17C4264904D91913515D5B8FDFBFB906B2A2709FC71780C7E317
          3B3FF45C318A099FEEF7F903501482A4C43830464008C596F78ADD575B2ECE20
          EFECAE64BFD9B038FCC9C7C39F286BC50F5FC801C2A851648AD2B23A4C9C1087
          E7BEF70C069D1EEE0B2D9FFE011BFE79AC0CDD3DBD4849790C2F2FFF012CD131
          C1C404D5898931A8A96940DDF9C6FDC78FECDA2C69BCCC62CC0CDA0934C13BA7
          818430C8585698C7333AFC51052C911150A906AACB3095274E5462F6AC0CECF8
          C346CCCE4E4765C5391E5CD534A89422213E0A878F9C426555ED163DF8DB0054
          85854D011141B9C698D111108F5ABF5F030843EEFCA7B07DD701AC96C0BB9D37
          2C65181CB46351EED3A090B070C1B770A5ED06E2632CB00E387800932CE376E7
          BF517EBCF800001500555455FDDF9DBBD6E4B4143E724607C746996132118011
          03A04C0035A0E1CC8566CC993D03922C43D52807013064664EC7157D2B7E7BDE
          6CB45EBD819999E9506459AC730AE79007D959E978FEC5753F3B73FA1F7B0004
          C88A9FFE71E584A4B43D449227216C7C6050031002BEF37373A6E16AC7557DD3
          65A160492EEE3F7062D0E90EC2E385D470A9F1737CD5DD8BF42752919FF70C54
          8DA1AFDF6124969E9A84CAEA7A7C5A557FE8D2F9D22202200A80198002808CF1
          E62B2525A7C6172E5FD7B4737B515C2040F904B8DC3E0454AA4B909E84580B12
          E3A2F914D9065DB0DA1C50759F24015191117C3326C646E29DED7BDD6D4DE7B2
          42AFE5F21881B98873E6975615ED7CA1F0FBAFDBEC4EDE27F3E77D138AD90CB7
          0E86312ADE1F68A88CA06284A9A6A2B1B11571713130EBE74F9556949C2D3FB0
          4111F4AA8FF83D40FBADFFDD5F7ABAEABEDFE7738260C2BF6E7CF18BD5AFBC1C
          4D240501AA8907D7C84DE8F37871EC5899EFAB2FEFFC5D9695084956626D03BD
          FB00F8093FFC28D1094158B5142196E70A5FDDB46449FEE6BCBC5C0CE8258F89
          89844991E1F506E074BB111D198973672FA0E142C39E86B31FEF04E01109FB01
          04248CE35AB6F2D754DCEC03E01D16422429212E16E608132C91269C3C5E816D
          DBDEC727A72A613145C01708F0B2338089E02E217E00745C0034AAC13EE46682
          362A56BD45566478BC5E5CBCD88CCFDB5A8BAB4EEECF6A6B6DF95BFBB576F87D
          7E4E0321C40C401542FBFAED34BFF035362E0054D3F8CE7F60778540A8B601EB
          91A325270FBDB763EFD0D9DABAF2CF6A3EDA06A0BFA1F6E3AD6565D5E51F141F
          749D2EAB3C621BE8FB5064CDEEDD1F64C16F0906655C0028C58A359BF8720801
          686BFCF41A80A29427666DF5BA9D5E000EF11DE86DBE58BE363E2129B6B7A7D3
          2E285301B095AB8B8C87DE389B70B4598824F410352C641742C3EC2302FE1F32
          3E8A79031A2E050000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F400000025744558745469746C6500436C6561723B45726173653B52656D6F76
          653B426172733B526962626F6E3B87808373000007E749444154785EC5D70B4C
          54571EC7F183F216D757DDEAD26D57ABABA6A9D6C76A146A5BDD5657E3A64DD7
          D5ADB655A98A541414110145444045101110E5210F95878B22AF9187F882E125
          30C0C880E0F012D0560586D7C0607EFBE7CEBD939942D26CDA44924FCE9D33C9
          7CFFB9977B33C300BC516F7C80DFF34F8F8C22A379A3F83DF6ABBCD3E52C2A57
          CEAE170D97486A62035943F449D6107582E7CDA98F1CE2C5F8987E45D0E1AFEB
          C28E25579D7773FC97C57C636188BA8BEEACEE02097163D5BE0798C4E9FBE103
          34762847D4DFF6840DB6D668A9D626C40DA4C1877F6C4D0E47DF9342FC9C1D8B
          9AE023492BE7FED5943F1B7AAA262953D54BD880AC80491C378D30403B1F6D17
          08F1EAE15A64DAA7DCA0CCFF90ED33510C5E3F7F847E49265EB795A3A35084AA
          B34E372D674F1B43097DA2372013B3FECA072C69B6B9EE005E69749A5F0EB086
          574AD6D0AEA6A4B8765043376E58E277D0F6595A24452BA02CB80965FE0DCE60
          53313AF2925171C22E79C15FCCC70A43284BB359E2B4C9BA0378A6C859F9F341
          56FBA29FC95F52BCB54E135309E1A7551C9DB8CF3EDBB694708A9753F43A94E2
          4428F3FE8BBEDC6BE8BB9F00D513315EE524A0ECC8CEE40FA74CFA03A50C885E
          DAC62F7507F04896B3321A4042942DB5EA30C5883ADC4CC74D52213E9A181579
          DAEE694B0AC5EB16094529F82081A2F1240EBD7762D19B73955CC1EB9F64680D
          F140FCAC3FA54C37D41FC70F314A6780A337EB58699B8A0CB25EB99462A4F911
          B7721A2B75E2F94777ED6D4B0CC1E0D332F4DD8B43DF5D4D10BDB72FA3372B1A
          3D995174060AF193CF7E34DB6F42E5B6AF90F0D5DAD41933668E17CE84668023
          D7EB5849AB8A3D6C23B4F6D45532955C42E10A8E56DC38D779BB5D4BDC39A89A
          1EAA83D997D1931543D1288A46A2E7D625F48822D05F9D87E75E7B20B75A877A
          D218E80559752DE2FEF375EA7B86A38786D0D70CE19A58CB8A29AC8586286703
          35853AF11C9BF576CD51A7A1AA2FA49876301C3D6961E8490D45F78D20F44B73
          F0CC7337EAB6AEE5C87D0EA35EDE04F9F953B8F7F745089E3AFE24658D3597E2
          50422D2B6A19202ACD4AB4E326995BD6D8CB03DD30509B879E740A8AC2D09D72
          11DDC9E7D17D3D08DDD7CEA02BCE17FDA519683B6683DAEFD6A89D70415D5D3D
          6AFD3DB9BD8A0D2BE133C9AC84B2A69A019CE21FB382A7039C7C524043F0717D
          629AF1ED6A7BB99F3306A439E84A388BAE783FE28BAED8D3E8BAEA83AE2BA7A0
          B87C12CAA234B4BA59E3F1A6556A9E87505323478DAF076ABE19DA5B0DD1C2F7
          71668AD91E0A9868067088AD66E2A60126A6785EB36EDC3AE8DEBEAA0B3EE82F
          CFA0A02F14574F43C107153127A088F68222CA0B4A71129EBA6C876CC3176AEE
          075155550BD9A9A3906D54EFDD5E3607FE6F8FF1A7C0389D7FC47D57AAD88386
          7E769F68C5C7EC08C8D97F26F329B21B07F02C398AA243416F4E67A42714973C
          D019718CEE8404343B6DC5A3F52B5145A46E075021AD81D4FB08B74790B56416
          FC269B9EA5C0046224C43976318F588E5CA913DF7626DBC1E7563344F27E048B
          BB1124EEC2B3C4500A5234FC183AC3DCD011EAC6DD764D8EDFA1F2CB4F39152E
          FB209154A1C2DD59B397B168265D7793000A4CE4E3BACF01DBA84742DC80986D
          F1CD72F04E6F466AAD1201B95D38A7A5352E081D175CD111E2826E51041AF66D
          42F93A4B8EC4692F4A4BA5F4E473D4EC8916BC4F71E3A1F824217EF12D139DBE
          767CECE65319078EA734E2BAAC0FFEF715236A89F243F7CD0BA8DFBB0192354B
          51B666194A0EEC46E1C34A94B83AD0EBA59CF479D37062A2D1390ABC25DC76B4
          CF4226198D1CDFE89DEEE896D48878692F7CEF76AADDD3AC44013F5AA34B7B20
          73B042C9EA2578B86A098AF7DB20BFB00CC5CEF6DC5E09EDA5CC7D0F9E130C03
          B5E3B4CF1E92E009863A03E893B1EB3D520FBA2436205AD2039F3B1DF0C9E954
          BBC3E18F3B1051DC85EDE1527CE2928ECCB55FA0D0CE1A79E2521438EE45F1E7
          7F238B91FCC1BB383ECE60283E5988D37B4C6D313B374E5F6700532BFFECFD07
          AFD5239C3EDC3BAB83B4C33B7B6825B40AC7E7F315B00AADC472E774CEAEC01C
          DCCF2D46BE832D0A572CE4DC9CF30E3CC68E0EA2C01F857BBD68E54246EFB122
          DE5E13039D01C6D9C7C83A02F33AE199D98EE33CE1581090DB89AD172BF13185
          3F3E940EEBB3B7917DBF187B8272205AF5190A3E9D8F1BB3CDE16E363A98A26F
          0B71DA6782FC4F08AD36C6BA038CDF1C50DAE92E7A8163B75E72DC33B895D70E
          BFBBEDF8FE42052C294CB0C33F0B99770B601B980D0B6711E7CA9CE9383A4637
          9E6F398FE52FFF88A8577A4D3E62D6C6BA97C06C9D4BD201EB4B8FE1267A09B7
          F417E425EF054EDE6EC7B721E5B03894C6D97E260B19D962FC1890050BA734CE
          BC1F22F1EEE78E81149D223CE3C5167399D892580CB7F31703189289AB0FC6BB
          EE8C780CD7949F7138F5055CC9F18C57D87CBE5C13FAC12F13A2CC5CD870F154
          CE87DBC261BEC221888F0BCF773DADE0AF0E308A189149AB1DE35D370755A8F6
          C436D110CFF14DB0840B2FA3D36EE59B81948C0774EDB3B094F6E6DB5CC6CC7F
          FBBF36FFD4DE97825389E61B70DA8AE57C6C643B8C8401860F3171C64AEB558B
          B604672ED919A958B22B068BADA3F1D9EE08B87A9EC53FED2E62815504E66F0D
          537EB0C157F467CBADEBF85BCD44884F5D13C6A6FE2394ED3631663B8CF539DB
          C94E1EC5870DA0F3758B8C27E6643A9945668F600679874C20C642FC37FFB4E2
          E9F383989231BF60C6AFA67C585FFB27D8EF45EFFFC47E13006FD4FF007A2E37
          E95083992B0000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F400000025744558745469746C6500436C6561723B45726173653B52656D6F76
          653B426172733B526962626F6E3B87808373000007E749444154785EC5D70B4C
          54571EC7F183F216D757DDEAD26D57ABABA6A9D6C76A146A5BDD5657E3A64DD7
          D5ADB655A98A541414110145444045101110E5210F95878B22AF9187F882E125
          30C0C880E0F012D0560586D7C0607EFBE7CEBD939942D26CDA44924FCE9D33C9
          7CFFB9977B33C300BC516F7C80DFF34F8F8C22A379A3F83DF6ABBCD3E52C2A57
          CEAE170D97486A62035943F449D6107582E7CDA98F1CE2C5F8987E45D0E1AFEB
          C28E25579D7773FC97C57C636188BA8BEEACEE02097163D5BE0798C4E9FBE103
          34762847D4DFF6840DB6D668A9D626C40DA4C1877F6C4D0E47DF9342FC9C1D8B
          9AE023492BE7FED5943F1B7AAA262953D54BD880AC80491C378D30403B1F6D17
          08F1EAE15A64DAA7DCA0CCFF90ED33510C5E3F7F847E49265EB795A3A35084AA
          B34E372D674F1B43097DA2372013B3FECA072C69B6B9EE005E69749A5F0EB086
          574AD6D0AEA6A4B8765043376E58E277D0F6595A24452BA02CB80965FE0DCE60
          53313AF2925171C22E79C15FCCC70A43284BB359E2B4C9BA0378A6C859F9F341
          56FBA29FC95F52BCB54E135309E1A7551C9DB8CF3EDBB694708A9753F43A94E2
          4428F3FE8BBEDC6BE8BB9F00D513315EE524A0ECC8CEE40FA74CFA03A50C885E
          DAC62F7507F04896B3321A4042942DB5EA30C5883ADC4CC74D52213E9A181579
          DAEE694B0AC5EB16094529F82081A2F1240EBD7762D19B73955CC1EB9F64680D
          F140FCAC3FA54C37D41FC70F314A6780A337EB58699B8A0CB25EB99462A4F911
          B7721A2B75E2F94777ED6D4B0CC1E0D332F4DD8B43DF5D4D10BDB72FA3372B1A
          3D995174060AF193CF7E34DB6F42E5B6AF90F0D5DAD41933668E17CE84668023
          D7EB5849AB8A3D6C23B4F6D45532955C42E10A8E56DC38D779BB5D4BDC39A89A
          1EAA83D997D1931543D1288A46A2E7D625F48822D05F9D87E75E7B20B75A877A
          D218E80559752DE2FEF375EA7B86A38786D0D70CE19A58CB8A29AC8586286703
          35853AF11C9BF576CD51A7A1AA2FA49876301C3D6961E8490D45F78D20F44B73
          F0CC7337EAB6AEE5C87D0EA35EDE04F9F953B8F7F745089E3AFE24658D3597E2
          50422D2B6A19202ACD4AB4E326995BD6D8CB03DD30509B879E740A8AC2D09D72
          11DDC9E7D17D3D08DDD7CEA02BCE17FDA519683B6683DAEFD6A89D70415D5D3D
          6AFD3DB9BD8A0D2BE133C9AC84B2A69A019CE21FB382A7039C7C524043F0717D
          629AF1ED6A7BB99F3306A439E84A388BAE783FE28BAED8D3E8BAEA83AE2BA7A0
          B87C12CAA234B4BA59E3F1A6556A9E87505323478DAF076ABE19DA5B0DD1C2F7
          71668AD91E0A9868067088AD66E2A60126A6785EB36EDC3AE8DEBEAA0B3EE82F
          CFA0A02F14574F43C107153127A088F68222CA0B4A71129EBA6C876CC3176AEE
          075155550BD9A9A3906D54EFDD5E3607FE6F8FF1A7C0389D7FC47D57AAD88386
          7E769F68C5C7EC08C8D97F26F329B21B07F02C398AA243416F4E67A42714973C
          D019718CEE8404343B6DC5A3F52B5145A46E075021AD81D4FB08B74790B56416
          FC269B9EA5C0046224C43976318F588E5CA913DF7626DBC1E7563344F27E048B
          BB1124EEC2B3C4500A5234FC183AC3DCD011EAC6DD764D8EDFA1F2CB4F39152E
          FB209154A1C2DD59B397B168265D7793000A4CE4E3BACF01DBA84742DC80986D
          F1CD72F04E6F466AAD1201B95D38A7A5352E081D175CD111E2826E51041AF66D
          42F93A4B8EC4692F4A4BA5F4E473D4EC8916BC4F71E3A1F824217EF12D139DBE
          767CECE65319078EA734E2BAAC0FFEF715236A89F243F7CD0BA8DFBB0192354B
          51B666194A0EEC46E1C34A94B83AD0EBA59CF479D37062A2D1390ABC25DC76B4
          CF4226198D1CDFE89DEEE896D48878692F7CEF76AADDD3AC44013F5AA34B7B20
          73B042C9EA2578B86A098AF7DB20BFB00CC5CEF6DC5E09EDA5CC7D0F9E130C03
          B5E3B4CF1E92E009863A03E893B1EB3D520FBA2436205AD2039F3B1DF0C9E954
          BBC3E18F3B1051DC85EDE1527CE2928ECCB55FA0D0CE1A79E2521438EE45F1E7
          7F238B91FCC1BB383ECE60283E5988D37B4C6D313B374E5F6700532BFFECFD07
          AFD5239C3EDC3BAB83B4C33B7B6825B40AC7E7F315B00AADC472E774CEAEC01C
          DCCF2D46BE832D0A572CE4DC9CF30E3CC68E0EA2C01F857BBD68E54246EFB122
          DE5E13039D01C6D9C7C83A02F33AE199D98EE33CE1581090DB89AD172BF13185
          3F3E940EEBB3B7917DBF187B8272205AF5190A3E9D8F1BB3CDE16E363A98A26F
          0B71DA6782FC4F08AD36C6BA038CDF1C50DAE92E7A8163B75E72DC33B895D70E
          BFBBEDF8FE42052C294CB0C33F0B99770B601B980D0B6711E7CA9CE9383A4637
          9E6F398FE52FFF88A8577A4D3E62D6C6BA97C06C9D4BD201EB4B8FE1267A09B7
          F417E425EF054EDE6EC7B721E5B03894C6D97E260B19D962FC1890050BA734CE
          BC1F22F1EEE78E81149D223CE3C5167399D892580CB7F31703189289AB0FC6BB
          EE8C780CD7949F7138F5055CC9F18C57D87CBE5C13FAC12F13A2CC5CD870F154
          CE87DBC261BEC221888F0BCF773DADE0AF0E308A189149AB1DE35D370755A8F6
          C436D110CFF14DB0840B2FA3D36EE59B81948C0774EDB3B094F6E6DB5CC6CC7F
          FBBF36FFD4DE97825389E61B70DA8AE57C6C643B8C8401860F3171C64AEB558B
          B604672ED919A958B22B068BADA3F1D9EE08B87A9EC53FED2E62815504E66F0D
          537EB0C157F467CBADEBF85BCD44884F5D13C6A6FE2394ED3631663B8CF539DB
          C94E1EC5870DA0F3758B8C27E6643A9945668F600679874C20C642FC37FFB4E2
          E9F383989231BF60C6AFA67C585FFB27D8EF45EFFFC47E13006FD4FF007A2E37
          E95083992B0000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F400000030744558745469746C6500436C6561723B45726173653B52656D6F76
          653B426172733B526962626F6E3B466F726D617474696E673B9B846D96000008
          6D49444154785E9597095054471EC6BF1EDE20240A689968A27246045D8FB8A9
          AD1563A259D72B9A72154DE926AEE6D875A3D928B5A2683441638CC7463C2282
          AE571451341A1554D412046F41E4501490CB2CE57900336F86F75EF7F6BB18C6
          29AAF45FD5DDBC9E99FA7DDFFFDFDDAF210084D4F4A213C4E235182D82193D63
          2DE61803333E646A236AA7CFCBB292FDC9B837870190F4AF323C4F08002C0E4A
          064F19190180B8D00C2F14C9FBF2DF05E0054036F43FBF004AA906744A0A00B8
          0B20AE070602C29836C7984BAC55B0A819806A4673F1BC61FE40516833F4FEC3
          2758F47D32464E9C8D45CB36E1FE8327A066CA794701FD1954FF5B2F8B2980E0
          0543300530E88095EB52F0D69B9158B2E073EC399885EF7FDC81554B666AC6CC
          3CE415946279C2CFD8B37529408C35A0B80B2084BC980018026E57D7217EDEA7
          A08C60CCF028EC4CCBD4DD43775A58721B89DBD3F1CDBCCF74D1546F8AAB7C1E
          9928FA782C732D603E6A4DCF9E00008A2CAB700D1A191E82C3C7CF63FC07EFE0
          F0B173E8D92304140C84115C2BA9C0FACD07307BFA384446F079C5CC0920C9B2
          59522F43802982F5FEF92055C7BC49A339C41042551ED53320CB660928667E36
          16EB371DC0D6940CBCD5371CB3FE11AD392C2829E7F3FB11F3CF684D94223318
          78BD0452B300E1E287EFC775080DFD5AB579AFBC7CE9C07DC71603507EBFFB08
          BD143D92E96619984B800C6829210808F0E725F804160BA05086260E2A282EC7
          BA640EFF6202227B84425658F38E6580E6A46B673F00F0CE891E31A7F380A8B8
          8E5151DA87D6B3B90B4ECB321972F0E41200D21FF61DA58D6733D9D5E52B54C7
          860049316A4201AA8229C074C8B5A272ACE5F07FCF98805EAA7385EA0BD2DC9A
          940182055D3AB543C6983FC5768D8A8AF10B0986ADE08A06F00F0942A01435FF
          58934C466464A9229ADA0E1C464F8F1AC21865FA3694B43500BDB538F1AE1696
          2161631A626644F39A87E11EDF92CB566FC3C4A973B1EC3FDBD42DAB658A5205
          D6F347113168508C7F50109C776A409B24AD396B6BD03E3808215103E30E0D1D
          B408401B005E43324E6B5C57068C63D7F0C59D9761CDC6BD88FD7212AF791864
          85625DD25EF4EBDB0371B3A7E297F46C1CC9C8C2B4BFBE8FBA03BB114C1AE01F
          1802674DB566A0E5992D5657A1435037840D1C302F4D92C884EC0B6A269CC34F
          E62ABA0045CB80E99CC36F614DE25ECCF96A1222234335B81A5577EE626ECCC7
          5A89460FFB238E66E6E0EEFE5D6873F70E0282033590B99DE16ADAB35855854E
          3D238076FE73773649E4A3F3798B5511CFAC0168B1FAA754C47E3519BD22B973
          99C18CF0B040649CB88871A306A2BCB2169D6E5E81607172E7DD340027790A80
          2E40F0F303F16B0BA1EE3704F7E917BBE1A399F862C6B46FF58348568C6DA1C3
          F66C8987838B9264572AD5F8FBD40F9079EA3CF6FF7A0A5D2BF2104644B47FAD
          2B87DF36BF676870CF80979F3F7C7A84A332790B4489C0F79B0474DB95140B60
          A900403F465596D611348A92EEC4DC6B8699F6FEED3069FC7BB893BA0356A501
          01AF7781FD368783B52AC0CBDF806FDA0A51B6C03B6E05C4C495B03EAA030022
          A804D9C8808FB7E07A151A7066F4845228B284FC13B978ADB20C1D3A7586BDA2
          0206B905D87CE0F0001D5EB5653BEC0A87CF5F8EA6FFAE4655CE2994888E0400
          B24A69F7B77F6D3EE425780F361D30D67264E81EFA0A42BBB547C5631941DD83
          102ED8D071E78F3AD8BD339C030287FBF6EE899A94540E17609DBF02CAD6B5A8
          3C7312D7EC8EB509F7EE7F0BC046007803F0D146CFF7B997D17CC6C7ED8C19F5
          E7A8E9BD233BE3A928C356700D1147929F814377EEEF07DF3E1C9E9A06915961
          8D5BC5E10928E7F0AB36C7BA0D0F1F6A700012D1A126D80537E60400BE1317EE
          9B3FF49D7EB37A4574C2630E37C376B500BD0F6D74BBB20906BC7AEF0188F0E6
          70EE7CDB1A94659F44BE28AEDBF4E871BC016F02C04CA03E7AC25F8AFE3A6DE1
          7B83FACD8EECFE2A1EDA251046CCE5A18D627E3EFA1EDA00C048FBEF7AA066FF
          2188C407C2FC95DCF91ADCCACEC415BBB87E5B7DBD0A6F34E1CBBB74614455FD
          CC258218F097C7C5ED593498C3C3C35EC5035B9306252EB8D9C191978701B9BB
          E0D32B1C35BFA643B4F84298A73B2F3D7302976DF69F7635369A70A70A9FD6B6
          2D0B7BB92D04B88759923663E3F62E7C7B409FD941411D51FBD8A14D022DEE86
          60CDA3B57F7F9E9D4A48295BE0105E8257EC0F90B724E0FA994C5CB68B1B526D
          3637E737FE32867D77FC1414851A023C4578878506C7740DEC809A0776D78624
          00D18E0A028B3E03C16A81D3E6C4868637D02F7C38FA448FE6F0351AFC0287EF
          17ED2DE1F4FA98318CC9804CB56B5CAB02882C5154DFB7BBCD12C68CCC133006
          58395CB289C839730B564A113279124AD3D3E1CC3A8EB3A29878D8212E76838F
          1AC5C0A1502728854C3D32E0BA61151695AC171966760B7E45873F9B220EB7DB
          ECC8CDBA096FC230F6DD501CBF5C8BB355DE20C2EB1B6F388A55788351735A32
          6204631C6886CC9856028B271C1480F374E2A78B8B2FE52596DDAC83D3A9C0E1
          A47018A3C280C686069CCA2C04919A10FD76308E5EA846F6D962D4951526DDB8
          AFC1EB5BC2DD317A09146A0AF014218333CE6D9F115F72E9CAC6F25BBFC1294B
          BC29A01605E2D3A7C8CA2C822029F8704877A49FAB44CEB912DCBB5D9CF4F4E6
          D6784FB8672860A094790A183C23CDCC42138086BCD459F12517AF245594FE0F
          6AD81F3FC569EE5C50144C1E1A8EC3B9E51C5E8C075525C9F565DB4DE70E15BE
          3B3691A19550F48BA9E71A689228067C9EC2CE6F9A4C0D17F545BFCC8997A41F
          58D9F5DAE98C32B4F72518142E20E578212AEF4978545B9A64ABDCA5C29F98CE
          DF0888649B577D69A6D4BD7785A700599641158AFE5376B0FC1D534C114F4A0F
          CF5B00E03BE33724C7AD5C9A63BBB9DA4303225860FD2D28CDEFD4D6C3E3246C
          6D5BBAFEE16875E19A8DE105E2FFCDC2083B551F94D90000000049454E44AE42
          6082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F400000016744558745469746C6500556E646F3B4172726F773B456469743BCB
          5CF1270000068949444154785EED977B5094D719C637A0556BE265D2AA631AFF
          A8ADD6D414AD62D0D458711CC78A8E686C6284B5B54EB09A445D8922D4A8B008
          024A45968BBB2BA265918B06024120E07271777597E56AA254E42697BD2028B0
          DCF1E97B3EBEA52056DA6446FFE99979E6BC73BEC3FC9EF739DF65110078A9FA
          BF81FF75BCF2947EF8F04D2CE674E24A89C0F70AAB994AD86CD520D83D3C7DAA
          38A130549C58DC47001B764DCCA948204EB0AA98930FD53EF12436B3F578267E
          8DAFD9E0165A81676968C7B65FC4DCFCC8FF6A8931FF9E09DEF185606BEC1ADB
          F77D74FCB29EE3B3E279705B0FA9F2ADA3315A65ACEA3E1A3B7BF018C0B1D802
          B6612CC986EDFB3E46BE88D10D18384AC533C0361F884EBDE619ADF60B4E29EB
          B96D68050160EC7F82CA9E7E1CF9878E6D1CCF9B18C3A761C3F4DF9AF1BAA8E5
          F8AC1806268D1185676F3C16A3AB4E2FAD470B419B9F00155DFD28B3F4E21ECD
          9ED137E1794153EF7141537848AE4E7597E6FAEC0EBCB298E03FE20D8D9A8C47
          9486E30F03EFF455FCE2A05C952CFBE60E6ADBBAB8B86BBAFB51D2D68BE256A6
          1E9477F4A19A0CD55BBA516E6E47414D3352F4B508BA5A8CCF65AA07FBC2B2C5
          4E1F1F9FCED279DE7DE22E530D1AB09DBBD87102FDA1A7385667D1563D1C88BB
          F709CA08AC7FD443EA46414B3774BCB4CDDDD0D37C9B4CDDB5F4A18A4C1AC854
          35994ED6D5C0EBBCA665CFDFD30F2C5CF9FE246B224F1BD81F913F40DF1598EC
          288ACCBB73455385A69E3E2EEE3B0466905B0F0774B3A98B93C64C3275424D52
          916E183B91CF64E8446E6307BEA96947615337AA3B7AA1C8BB87FD61CAC2756E
          E2D9EC689EBE3F3E93E40E18F854928B8A660BD77555671F6E11486D2699BA78
          08C9C0201DC823482E534307721A2C50D65B70BDCE826B556D50943C4494DE8C
          A88226C41435414F868B1A1FC343A6327FE0217724D4B8A147B23BE4FA800167
          F72827D7E34995616965D09A3A58771C2487204A2B84944DA0AC07EDC8AA6DE7
          3ACDA86943D23F1F2186C0E77526C8B566C84852AD09E76E1A714E6344C2B7CD
          F8EE51277C15DAEECD0722563113D624DC4E6709AC63EC5C07E7D79D3E95FBED
          F4FBAA4B41479147C0CCEA76641224A3BA0D69F75B9152D18A6402C6DD6EC6A5
          6206654013A4B718D084488246A88D08571B10A63240A26A44E88D46C86E9951
          606C87282CC7B4729BD73CEB71EC08C8E0F1FC13401AEFB0D973C19A3DF26C51
          6816E2F506C49512A8C00C397548DD71B0E4EF5A90F46D0BAE929138EA3E96E2
          BEA83713C8485003CEE6372224AF1167F21A7026B701C12466329F9E963FF9A6
          16BFF9AB777EC29A1EFC96ACFDECE2E05B8F77F7EAB2AD7E7F5EBBE7BCC12746
          8784D281882335D49DC680C4B266B88AD3F0AE6B2836ECBF04E7CF15700B4A87
          4F5C21A2D40D9053120C7E4A598FA0EB7508CCAE4340561D14456648AEDD86F3
          810B9EC498C8F1D858BD2B6AC48B8834E18D5FAF7A63E9D6C0882D0763FB43D2
          CB114D49B0582F53C75B8FA5E04D3BA7C5F31C3F596DB7EEB070D126DFD34B3E
          3C7D77F9760984DEC93895760F92BC0602D7C22FF3014E64D4E244662D322B1F
          41284E7D3CFBB76B66B16639E6EF779E1BFA7C8E488320CBEDFF784AFFB17F2A
          226FD4239AD2D8F2B724B6F1A77C2713D83ED294D90E1F2D2433C1EFBA9C6DFD
          8BFFD708CAA824130FE09D5683E369D50856D6419A75174E7BA34258D21CE777
          DBC319788486A6419A327FADE7BEF784671F1F92A9E17CF82ADB3075C807C996
          AFC79326FD6CFE9A39F65BFCA357EC08EF1149D5F0A7EE8F7C55C544476AC6C6
          8309E657A7CE98C635B9745BE8689F631B6B1AD3E738CE79DBC95BB1C13D11D6
          0E86EF1D6EFAAD559F382D134ACCBB82AEC13BA50A87BFAC442025B25FA2C40A
          17DFCD04F8B1C0FEC333CF82FFA76319C7834923DF6EACB61AE113796DD682F5
          0B96BA8494FE35E06B1CE54CDC47507209D6EE3E17C1D2122CDA123C1C387A1A
          B64C56F8283F64C630B35366CEFBB9C3B6D0B20367B370E8CB0ABA49CBB16EEF
          45F631785DB07053D008D8A846788DB677A889590B37DA2F1346184FC6E9E19F
          5681F5A2D83A5A9F26B0DB18C0003F5CA39B983C6785DBA6F776CA7AA4395570
          12C5B5D1DA0CC1DB1B4E32C08B30318E75BCE8FD008557640E19486017660AE6
          AFF77B51066C4913A7FD72F96F960A659675A2780B9780C37699E01D21899BE5
          8225AC769553CD66B6C6AFB39AB46498A4FFAE5DA4027B9AED5D58CD66768DD6
          F89A37319634D5CEF964D01FF65EAE65B5E0050EEB53348E348934997F71095E
          8609DBC11FAF2F69BCC2EBE5FF73FA2F6249027F98C24C4D0000000049454E44
          AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F400000016744558745469746C65005265646F3B4172726F773B456469743BE8
          51AFAC0000072049444154785EE5577B70545719FFDD4776F3D8DD869860C32B
          044B880CA140998552C5CEA8B11432B595A10A8E800E4EDB111D30503B486DAD
          5247ED401DAAC632586C7804D2899420054348808454F25A36904D4A5E0BC992
          E7FBB18F7BCEF1EEB9776FAE3B9DB1D319CB1F9E9D33DFE4DEEF3BBFDFF7FBBE
          6F7356608CE17E2E11C0FF3701E17F74CE27AEAB0C00AF9DAC83101D05663EC9
          F4DEF0E4461080BD1B9609BF2CA80D124AF3FA3BDBF71ECC5D3F0480BD5A50C3
          040800637A980016752267FEEA891A7CE7D9A5F8342B43100500E22BC7AA95E5
          8FCC86CBDDD5333E3AB673DFD62F1700A0005833A31FAB48FEB11AAD0728A19F
          0A5807E7041442B1202305396B164E9FF785D4FC3D47AAFEF9E3036716029054
          3F91FB462D4298560285B04F0C6AD2CFBC6542995E1211AB1F4D47C643C98F57
          7E185BBB2BAF7C7F5D79D1EB25C70E8CA9F19A2294328D00E1C178E99D2A6CDD
          ECFC6FC046B6CFFFAE68719C3DF19BA2242F15057106037B50054EDDB6652546
          C7144E244616106315E06AF0A1DEE5F58E0E0EED38B8636D3100A23711CB3D54
          C138815D872AB1EDFB2B35888F07169F7A615FD2DC852BB6CB16CB96A424DBAC
          F4B424A42427203EC182F8380B12540BC630341C02B818DA4E88931008045151
          D586D696DEE26E6F63EE89DFBED0A613A11C7267DE153CB7EDB1FF0417B5E65A
          9EBD31DEF9E4F7B639EC8EBD59593312BF98F979D86C5650C2100A511002280A
          E565A414BCCB59644818E37D2E4B021C0912BC9D83A8AC6C99E8EB1BF8CDE9B7
          7E76C0D7EAF67302DBDF2AC78F9EFF92315D0B244904203DF3933767CECA78F8
          BDAC453396AD70CE556595E0F71304FC148432038C87852D9B226026E10F510C
          A8CA24C64B989E6C81BBA11375F51D4DC303DDDBE5483344836FFCF9BBAB66A4
          A517E6AC5D943C3DC58E894982E1E1809EA5016606363D1338417F8060745241
          304479DC444041CF701073D21EC4BCF494050585D51764804BC88333650E2E6F
          78F1F0AAF999F3CFE7AC5B6C5198845BB7474118609104C8B200519F03511278
          1C214CDD6155C0C1020A453040F83B8A29A2B131021C5611E5656ED4567BDA47
          06BA77680A28240C2E0090B2B7BE3637356D5EC1934F6459C6FC4057F71814A2
          6537A1896AA860D4D9AC82D107535614444C8B17D1DDD58BD3A5B5811E9FEF0F
          6DD5A7DFF0355F1D36CFB594FEF0E3F6AF6CC82DDDB469E5126B5C3C3A7C939A
          3A069000010C563513AB2C4216451E290B3026A8A32F30450A0C76AB04818450
          5E5A03CFCD96B2E17B4DBB1A2FE53502080220B28980BC34FB073FCC5A3C6789
          CD6E43CB9D310482CC384C9600479C04812AF07A7B7057DDDDDD8308290403FD
          23484E4DC1FA6F3D068568D2C7C8221CB132DCB54DB876D5D53DD2EFDB73E3EC
          AF0B010400280088F3DB6F3231927DE6AA6792E21D492FAD70CE4357AF1FE37E
          C20FA38CC11E2B02FE49947CF02FFCF98F67F0F7A2CB9EAA8A9AFDCD0DEECD4D
          75D7B25BAEBFEF240A436262783C8104AB88F1FE01E41F3E432F1497BEEDB99A
          EF54C18F039888645E766F9C114581AC138879C8F9D46EA733FD017F08E81D0A
          802814711609120DE172A90B8D37DB470393A38706EEBAFFD674F99D363D0BAA
          DF291296646FE66A58450597CED5E066BDA776ACF7F64F5BAF1DAE35654D2F76
          8E3175F16625847202A223654EAC6449D89899910A5F9F1FC120813D4E466B93
          1795575CA1C9F191A39D0D25FB3AEACFDE0310D2C199BE2500164521AAD4B770
          AEB87264A4CFF74AD3C5DF1F01E0D733A61F748C84C54420488DA9A0947002F2
          236BB7AF9E39735A0A15250C0EFBF9B8545CAA4393A7BD77A8D3B3C57D7E7F85
          390B00AC349C0980AFCEB4097C9209C5A9A3FF38D1D772E517BD1F95F9747FA2
          FB231022FAB408BCACE10FD51590E21CC95F9F3DFB73181A09214662B85C528B
          B6DBDE1B5DB72E7EB7ADFABDB6C86117EE8CD2ECD976E1BC778485677D4D9A23
          723B099CDBFFAC1DDA52CC440B3D832CF26DA81A6D843913CD0A001E58B7F3E8
          FB6BD6AD581D6B73A0BCA406B71B5B6F78CAFE923370C7D517691A00286E1B66
          4C0FA4BA7D7AFE34F37F4A444A73BCA19F0353A89B0A803E4D945150BD786FBC
          FC360F4ACAC93DE97A7AFDA3B35CEEBBB87EC5D5D3D578F189F6EBA79AF51AD2
          A28FC259C0008D26B1715172041C47EA7B98EE67C80D6AF8734261070AE04FBF
          3ACC0924E7EC2E6CFBDA3796D94EE69786FA3BEAD77B4A0F96E923430A6EF633
          3330D52DC040C24034EA1D7430AA13E50A70F21AB0E91BF3AF6A9FF2291021DA
          AE577930313A785205AFD03327EFD6F732BFDEB5D4C8C204A601EAEF30F59C42
          7F3EA51235C53232753595B5783AD1DC78079DEEB3AF03988CD47C22A8680114
          5A4680212307D3EF361414D0C07550C14C56DD9A5A30B2D788017A13E6E49E72
          7B5B5A8FBB8A5EDCA74BAF2CDF9467FAD5C67423701242F4A51DFC2E68F89AFB
          9145BC59F4659C195E56007600360016A3A33FC35F46A209901AD43FCB65647D
          1FD67DFF79FE6F503785D6BDA7B94C0000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F400000026744558745469746C650046696E643B426172733B526962626F6E3B
          5374616E646172643B536561726368BB659C080000091449444154785EED9769
          6C54D7D9C77FF7DC3B33F6CC803DF6D81E8FC160C2BE39EC84B00493D0900082
          AC4D42DA34A14A1AA52255525A2444521AB510B56F5E3590405AB54DDBF7059A
          D20022511262C0D040CA6AC050CA6E636CBCCD78B6BBCCDC3BB757C853228844
          A57CC8971EE9D1E81C3D3F3DFF799EBFEED1916CDBE6EB5C82AF7929394092A4
          5B0112F0C5767DA5FC5CE7955B17CDC575361737E7DEFC7B73FEAD479083C5D6
          4F0FCEDC567B74EB5F3E3AD8F4A7AD9F35BDB371E796D56F6FAE016440DC2874
          FD861D337FFB5EDDD65F6FDA7579FDFFD736ADF9C3275B56BF7563FEAD054880
          F4E1AEFA6581C2DEB5D5C3FACE9D75C7F0F0F409C3C243ABCAE7961417EDF8D9
          9B9B97E544E4F27FB369E7B27059B076D69411736B268F0C8783BEF0F081E1B9
          7DFA94EF58BD6E6B2E5FFA8F046CD8B677A6CBADACEC5B1EA4B8C08F696589C4
          93747444280BE4535A1278F599977F39A38717BFFADDF6E905BDFD2BA78C1948
          65B8988C6972B1F10AE7CE5F62CC88FE941417BCBA64C5DA9A2F13211CF3E1B4
          8AB38D6DE45A8FA4AC94254B58A6899005AAAA138B695CEDE8A4ADA39BAAFE21
          E1C9F7BD0A28802CBB3C2B43C10291540D00849070B9F2387BEE12ADED510654
          8684903DAFE604EC39F84F9E5DB606A73602C0486750B53480B46ACDA66AD3B2
          264B424116024721AA91211A8991482491858240C24CA747E74690CE64AA53BA
          46366B03E05264DC2E1799B44E67348695B5B02D73E2A3DF5D7E3B20A64F1822
          195A8F5800CD30A81EDA57028470791699195DC8B28CC72D639A26B1B84A3CA9
          924A254116685A9A4824EA0664408E75C73CC9A441C6CC00A0C8021B093B0B17
          2F34924869F42EF40B77BEFF094001244DD7AF0B507503401A32629C5B37328F
          9A19036F9E0B974BC1D9D39D48918CC74926356C01274F9DA6ABB3DD337AD282
          69772FFCDEB48693A73D5D9108E9B409802C0B10324832972F35E3748B926031
          59A48783A1BE7980F8F3FAE5524E003F7FF9710910B3E67D6B563A9D2ECFCBF3
          A308D911E176D4EB44A249DA3BA3A89AE618317ACD5C99B489D757F881DF5FF4
          51D6B689C51268FA750F085920141791EE285DB114592B8BB0AD50CDBC6FCFFA
          A21915809E8D6C096571C650491B3A4D97AF60A6539CBDD0CAE9732D5C6D6DC1
          D0359A9BAFD01D8D3902D2B83D5EF27C3E0C87D1540D5D37B0B2593ABB224E87
          3A5053D73AC7C963FFA0A0A890406180EEB8F234F0096001B6C839FFFEC75EA8
          926CE619BACAE0AA10778C1FCED8EA613CBC60268B1E9AC9843143496A3A2DCD
          ADC4E209321923F74D25EB144D693A9168CC19CF591459E29179D358F3FA4B6C
          FEBF3778F6A9B98C1E5A8910809D9D33B87AC66D392F488000DCCFFCF07FF778
          95EC841F2F7912BFDF4F524DA319696CC0E352F07B3D7447A32C5DFE066D6D5D
          C452297AF72A265C5981AE25292F2D627CF5101E7B7036665622A91968FA75DE
          E775A32553BCB2EA1D1A2FB71CA9DDF2560D90128098FDE0B303F2DCAE094BBF
          BF08D356A8FBFB2556AFDDCBD2D76A59BEAA8E35BF3FCCBEC34D58B879FDA73F
          C03433642D8B50284845791156D6261E4F306FCE743ABA7576EE3FC34FFEE703
          5E58BE89175FD9CCEBEB3E65F7E7E748A661C5D2C594854AC7560D9D34105004
          2087C2FD17F5091591C90ADEDBDEE0009FD3AC07F0F61B85A7CF089AB502DEDD
          7C8E1D7B1BD12DC1430B6753102864F4A8814C183D883C8F9B9AA9634968261B
          B61DE0B5B53B38AB1543BF49D87DC7734E2D62FDC6836CAF3D495CB3A82C2FA1
          A272F0E3805B008ACFE77B7C4ECD648E9EBCCAF6BA8BDC3B7F06AB9F1BC3CB0F
          5432A8D24FAF6090B26143D9DF10E1F48508F7CFA9A1A8B8882DEF7FB8FFDD8D
          DBF779BDF94C9C388643279A787FD7696AE6DFC75B4BEE64E5638319525588B7
          AC9CA25193A8AB6FE1C499ABDC336BAA63CAE023804B01644950E1C9CF675BED
          614A070CE4F93915D83664B1993CD8CF07F571672F11AEAA60DFD1766EEBDB0B
          BFD7CF91BF6D7A18B016BFF48B56C595C75F3FA9A7F78061FC687ED535DEB26D
          EE1A5EC8C6435D600BCA06DDC6EE831758FCC0385CB23B941B81645BB6924819
          B4455402E541E27A96886A114959C4F42CF9F912794E0443013A9306D1988624
          097237A12C64A2718D96AE1805A152BA758B8E94497B2A439766E2F54A789C08
          F629A53D96A43BAE635AA602C8022093CE24545545762B4E21C1F6866E5AE319
          DA55938BDDE96B6785050A6E0FD802543D4DC6CCA4E9599669A60DC3405164A7
          9060C3F10E9AE2062D6A863331837C9F4CA0D08DCB23C8CA9048A93840124000
          B6AAABCDD1688250B91F434FD0A69BEC6D4A703A6A8047C2E797290EB81D304E
          51A187AEAE28BAAA3602169075EE884B9D5DDD94870A30D5182D5A868F1B631C
          8B6AD80EEFEFA5102A76A326BA2809F88844BA3134B505B0046025E2B1DA0B8D
          5798561D26DAD682371FF2BC8AD37A9982024179A91BC595E562532B23AB7C5C
          BCD44C2A11DB096470229188D55E6ABAC2F4B1B791B8721E5F3E787D0A3EAF42
          51814CDF320F2E254BE3D9F38C1D54C6F9F3174925E375404600E6D986036FD7
          D79FD28ABC32D5FD7A517FF038A61E23D0CBC697076D5D11EAF69D6060D085DF
          6573ECD849FD4CC3FEF5800E18A78FEF5F77FCF829ADB4573EE3FA0769A8DB8B
          9DE8A4C407BD3D36EDAD6DECF9780F434B7DCE5EE1F0A1A37AE3F97A87C79000
          05C89F71DF77168D1C75FB5B774C194FCA923975354124950120E8F730B8D44B
          5ED660DF67073876E4E08B07F6BCF747200100F8A6CE5EB46864F5B837274E1C
          4B3C9DE558531B9D711549489414F8185111C46B67D9BDAB8EE3473E7FE9D4D1
          1DEF020909900017E09B7CD72373CBC255ABAAAB8787C3152182C1626CDBA6BD
          A393E6CBADD41F3971B5ADF5C28A23FBB66E01E24006A087F78F9FBA70414959
          BFD746578F0C85FB943B7CF01ADFD6DECEE5C666E79F1FBADA76E5C28A332776
          6F036240CEC848801BE85D161E3878FABD4FAF9D35FFF986D90F2CB1EF59B8C4
          9E39F7B99353EE7EF2EDE2B27EC38100E001440F07207ACE02C5A595C327DDF5
          CD7577DEF3D4A969DF586CDF39FB697BD25D4F9CBA7DF282770A02E5A3806220
          EF061E807F8FA3A748195001F401423DA00F70DD0C93BBD45C80B727370CF403
          FA031540F0CB78E9CB1F22881B8AD84016276E7C64DC8217D779AC9BF99B05DC
          E2FCE6C25F95FFEFEBF85FD0430BB08C3063360000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F400000033744558745469746C6500496D6167653B50686F746F3B5069637475
          72653B4469616772616D3B4669677572653B647261773B7061696E7415D5C670
          000006AC49444154785EC597DB6F5C5715C67FFB9C3337CFC58E1D8F1DDB716D
          C74D52DC84889287165582102101424848A815CFBC80F807F80B78E1111E2A81
          54554222484845D0A86A53B05A92D0509426938973B113C7C9F83E637BAEE7B6
          F702C947733432798804CD968EB4F63EDA677FEB5BDF5A7B1D25223CCF61F19C
          87BA70B1DC9D8800C48CBCF9DD9715FFC7F19B0B9F8903F0C677E614F0B4C39E
          05C4B300961FBFF155A300F5FBF76E7D04EA1BB1F7BD8C48642B04117ADF09C4
          3A8A6CA2F5885663A46B47DB084D38FF931FBD7A1EC0FAED1F3E932F7AFCFA9D
          2B02241C4019D947EC7A214A294000F57462A5CB55EC15AA6B472B3D2C749943
          286493682300CA0194EC4F402936FC80A725A611C10804A14BAAFC2B72C33304
          AD1ADADB237D788666E526F9F1D3341E7F4EEEC8096A8B1F934824705259B61E
          3FC67CFB2D5EECEB0701312602401C431121D0423A93E9F5564566E0623F9907
          3B852E9E25113CE2F0EC291A9B8F48170E934D9D26959F206377B01319181AE0
          D0C409B6964A582F7D9FE0DE4538F32602E818002A9A20024128D81A14BD9234
          40D0AA73A851A230720CB75EA5555D41390EF99109D6CA2536EEDCA4B5F188CC
          D0110AC57EA6CFCCB0B37287E6F61683AD0FD9AD3590FF00003011EB0E801841
          10880058610C40A9389661AA4865E07BF88FFEC8E1C9290AA3AF2324585B2871
          E7D2FB8CCF1DC5514574E871FD2FF3049D26132F0E32397792BDAD1D9EAC3650
          0222600E302020089D50505D00310B5A206C6EE2541768746CFC1B57B093498A
          B373DCBFFC2923C7C768AC5648F6393C293D60787C905B1FDFE6C8D4EB2CFEAB
          8468C14F1D210A3646C72224122102F8BE904882A177F81AFAAEFD92A3D32364
          664649E64EA02C0711436D6D1B3BD4F415522C7FBE442A69B172E70981CA914E
          1A664F4F8193831BF7BB35458B01A0CB40E42D5E6070B4200650B140B581CDE3
          3FA3B9F1097DCB65D2DE1AB663513C364D2A9BC3D064F9E632E994A2B2BC47BE
          90A34D9AE65E83D5C50DC240F3A89A664C008819E80A22821668173F4875735F
          44451B0C61DF20B5CC24FDB5AB1C9E9EA57F6C1CB75967FAD40457DEBD4A7F46
          B1F2649781C11C1B35C5D973A358041C3F33CECE76C09EBF8D208808466200CA
          1813BD00CFDF2011760088A489123068FC5A85A3A5B7E89F19636FADC25AB9CC
          D0F820C7E606D85D3DCADDEB157CCBA1438AD35F1BE4CBAF15595F6E72EBEF0F
          C9E51C1C1D87DAE89E104837045ADF2634791426F27E1FADD1216D7F9905BFCD
          C2F222DA0B796DA4C8F0F428959B0B9C7839CFCC89397205A151F3709286B5A5
          3D46272C3AF5012EAD7A78DA614E40A4A70E4429112108CD2D8CCE44B74F74B8
          31B89D164E3264E09B67F1DA2DB21F7CCAE8AB43DC9DBF467BAFC9C8D44916DE
          BFCD2BDF9AE5C1F5879C39F702B72FAF50AF16989EB5982C57B9FE95D1F8828A
          005880323ABABD103C7F113FB847681EE2070F70FD7BD4EB0B98708791A1229B
          ADBB2CFEF312E2795C7CFB03DE2BDF277B28C7FAC31AAD9687264DBDEEB25571
          C90FD8FC6EBEC49F2E2C934F1992EB15948044BAEB0941048C46670D52091030
          02BEA769EEC19766A658DCF8076EE0D31E49F2D1669552668FF3F611946D71E3
          CA7D5CA0D368B154A922B6C5D474065F0BEF3855667692BC70BA8828890A514F
          16E8AEE0B4F608CD7EA13021EC547D26864FF178F70E81F81865486513D48FE5
          C92C35512D9BD2E545E69D0693926263799315BFCD274B8BFC607B985084FC40
          927A3A81AB0D1239D653098D11A49B869A200C301A3A4D4DE867D9AEAFE3EA26
          8E6391CA24709236C984836DC3D0D75FE15AE96F84B6CDFDF5361FFEB9C4EA24
          34B0797B7B93B05F3194C93036D14F75CB2312411C82380D414411049A30B030
          5AA8563D7CB7C3766D1BDFD5682D0481A094A2DD0E10A5E82B3AF49F4C61ED42
          A7CFA23416E20409AC758FEC4C06D109F2D91409C762AD1A2010B170A0100982
          109AFDC7081C1A4E623488214AC5E8CA7635B51D9BAD75435D6F81ADC90E38D8
          49487414B54D1F13584C9F2CB0547631C6C273854E5B2300C4FDC081521C86B0
          B3EDA304340A4B4030080A88E2A7054453AF7628951709EC0E8107F5AACFCE66
          88DB10A65E2A10B8E0363509CB10BA1E6120A8A80AF688500C5D0DFCF4FC5550
          7183020A15E5CEFE34D68B520A2C05620100D2DBC408F0C3A8A428414421C4DF
          8A3480183120D09776000E76BE71BF07C46004407597F6C102F4B69520911344
          FD055D0D880368CF75FFFAF35FBC7B2ED2C17F6F2625D60928A4FB4E0EB4E91C
          6858E96DDB8130F0E681400189F8C10278E69F9467DF63001FF054B4D10222FB
          0B1B0690673EF07F0C529EFBEFF9BF014C9BC65F2C9755DE0000000049454E44
          AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F400000014744558745469746C650048797065726C696E6B3B5765623B06FEA0
          CE00000A4B49444154785E85970B705CE575C77FF7DEDDBB2FED4A5A49ABD5C3
          203F645B381618B0B171C018183B10BBC1A50E3899A9A7218509E92414B74D98
          240C493AD3364CDA420AC3D090762043932626813AD062929A463C4CA81F32C6
          36762C5B962D4B96A5D56A1FF7DEEFD5D563A76B7726FDDF39FBBFB37366CFEF
          9CF9BE9DEFB38C31005896C565B2E6C2061C200444812490987B57400E280201
          2000092840332B438DAAF5AAB2013EF6F008006BFF6D1D9F7A7D333585C34022
          73F35FDE94DDF0D4631D1BFE61E7F6AFFDF4378F3DB57BDF3FFF6CEFFBFFF893
          5FFF66CD1FFDB0AF6DCBAEE7339B5EF86AFD9A1DB712A7098803E19A26006A1A
          BD8C68D943E7A7BD4A67550B776E7EE1CE7977FDEBBF6CF8F20FF33B77FFDA5C
          CC8D1B557976BEF64BF3F3DD7B8CD09E3978ECB0D9F28D97CDBAC79E31CB1F7A
          BAD0B2F9073B1B6E7C641BD03A07E2009614E7998E6ACD6AD800C6A24A57ED3A
          D6B5ED8D1D1DF333CF6DDF3279EF138F2E4FDE7E4B0F75755130862D9F58CF58
          BEC091E3BF65F1822CF76D4A93A9BF82DE6B0F26567FE2DDDFCFF4B43F9DBEFD
          3B5F27FABF10A170D632467099E60034581501A1C6AB3F97E9FAEC9BDFE9BD4A
          3DB671FDFBD99B6E6B225798E0C55776F3BD9FEE62E7EB6FF04E7F3FE74D84FF
          1E18E3C8E973FC782F249257911FDA8AABA3DC70EB3B0D8BAE9DFC62D3CD7FFD
          DD48C78A05400C70C2EEBCFFBBD06A3C04C42B9D3FBE7245FE8FDB7BDEA47B61
          07ED8936A253093EEC2FD1904AB0B26701EF1E3AC578EA4A44284DA9A8094C8A
          424EE3975E469BC3241AC6D196E4E8FE760EBD9BFAD944DFD7FF1C9FF3401930
          D3AA9D8035E791AE7B773FD4B364EAF3B1A5AF90C8BAF84AE089326EA3CDBC36
          58BF6E21AD6D49EEDE780DD98820D1584FAAB59D48344E381C4604B7327E6E0B
          A70F2D234A84152B47587EADB92B7DC337BF0CD4036EB5E9CB01C295C5B636DB
          1E79C0EA7CC90A3738082DF0954F4196C88B29B24B1A9812931C3C72985D6FF5
          E3BB71C2766896DE063B14C28DA489C6BAF10B1F6762B889A1236D34245CABA1
          A9E79EFADE2FDC02C401DBAAD90AA16AF74E22BB2DDDFC519BD59927D0F5F85A
          E2A980A22C1115919962C6D78C94147E4B2FE154161184C0076300056063E350
          5717B0B8BBCCAB3F598D2E379370834CBEA1F3D3C03B401950B5004EDBC6677B
          1B9B139BBCE45E9C99C2024FFA788E4B497AD8DE2463C336C9C64E62D9852493
          693C19427B06A5345A5642815106A36D7C3FCBC8993612A9B32C59B59FA13311
          EC48F8766FE48ED58563AFBD060480AA0284DDF492752D2DA669327296A856F8
          2AC09B0B57FAC8C1467AAEDA4022D3864798B200210D5281141597A0B4414930
          C6C122C9A1FD2BD8FE076FD1928EC12AD87BA09C78EAC38EF5C01EA068599636
          158580901DA9BFB6A1413162CA98C0E08E450867FCD9B1E71DBA332B88346709
          2C175F1802DFE07B150F0C4280ACB80C404B50D260944109811DF3992883C190
          6E95D891F8B2EA960424D50998507C715D9D8F2CDA500E58117E80B00FA7BD57
          69B55693EC5E46D984919EC11395F06721CA653DE3810732D0485FA305152F93
          4C7FC468B18463833106E51A6289E87C5CE204D897AC016CB7C38DD9B88516E2
          132E899EF9A49A1A7126E2586E8030717419A43478C16CF1625113140D5EC5FD
          699032481FA4A711814FA26D88F3C52216603068630827EC46424409B8741758
          845276384667681D67E59B1C3BF136C9729A05D99B7023114A8183090C5281A8
          B857D678A5B9E285690083F06627A084414B41DEF3383395C7C142CF01E08623
          8408C3A500965262AAEC25EB3389DB18BAF01E7D4D7FCFAAD30F924941D48A40
          60A19542C8D92E03CFE07B1AAF301D86607A1AA53988C08084F1F130225FC0CC
          3CCC0004222E3000985A00A345793877D1D437A45AE8097F89A3434F73267690
          ECC81D3831895602DB89E258314460CF4168FC92212855BC601015179EC1F801
          96B1518534C3C56275FC508A1068954711D402D880D4FEE489C909815F767022
          57B234B2838459416E6C8AFFDAFF4DFEE38307D97FF89F183CF10117864E3339
          5EA094D394A72730A5678A07658D1602A3022C65132B5CCD54CE26E7F998634B
          A83B780F66387D14C514A02F0150C5E1FEDCB88F37A9F18A21141932660BB9DC
          14A7A67EC148681FFDEE93FCAAF059F68C6EE7F4C0BF93BB304869A2445052F8
          258DF605C6F7D1C203A388D04CC7B1ED341FBF93CEE2DDA013502A1EC0A7580B
          1002027F745F5FBEA567BC108FA623111BDBB13096E1E2E809240128301A084B
          7C0AF4EB4748E496D12EEF2365AFC1D6CE6CF7C2C3E8A0E201B66D93A49B64B0
          0842502E7E34E94F0EF455FF8A4DCDE9270234B5FEDEAEBFEDECECBDA73911C7
          382083098E8FFC29930D6FA3D2A0EBEC5908654080093475A357B3A0FC1784ED
          166C0D96B1406BD002CB02CBB1B1C336F9D219CE9C7C7DD7E8BE67FF0C189A83
          D0D30C16E000C9C635DFDED0B4E0934F64EB33D9B0EDA2658173934F7321FE2C
          2A65134E34707D68132DEA0AA2AA0E295525249E283356BC58C91544E5621AE3
          0BE968CD138D16B16D6F264FCDEC202102AFBCE7C2F0E0837DAF7CFF14A00053
          3D34BA40BAE5F6E776B476AC7EB8259AB48CD6944AA718905F2494F2D8BAE811
          B6AC5F43574786FA649CAA02213970F804DFFFF1CBBC5D7A996D4BBFC23D77AC
          62D195591A53894BF38E9CE49917764D1D3F71EC96BE9F3FDB0FA810B31240FE
          C21BF73DC5C6E7DB9C4CEF67D26E9C88DD44078FD296788FBB6FBD919E45F3B8
          902B70F1DC45A4D254956A4C734D4F0FD6F13AB67DF206962FB992C1F3139CAA
          4420155519C7E5633D0B9203A787BE056C0574C85434773EF081F1FCBEBF7BDC
          EAFD8225B3CBEFAD77A256CA5D486B2C477757DB4CF1EFFDE02506CF8E100A85
          684AA7D15AA394424A81168A6F3FF9E2CCBB1072E6FB445D622677EDCAE5AC5D
          B57C661252EB5B80102042001DF7BE6FCEFEE87A0594FC0BFB07467F79FFA3EA
          E37F335A6E5EBAAD3EDA90B18C241A71298EE519199DE0EDF6E7318E6163F17E
          BEFAB9CFD0D599B9FCA8CFA1A3033CFAF87385F1E1B1AF45ACF281FE64DD9BAB
          AF5B86E3384821124088EA87D1923BBF74C0BCFAE435122802FA62DF57BE2B97
          7F7EFF54C3E2BB7ADAA39F2A7B81A5B5E186CA8FD8071FC07142600C6ED8E1AD
          FD47992A7AD4AA582A63B0EA9A3B163C118FC5B8E3E6EB9898CCCF2E5E1194AA
          97166B9AB6636B1FA0C028CEEDBCAD7A4875813A20B5F9BE6FFDE84FB66FBE3E
          519F9C19675527068678E9177B28164B08295152A195461B4D3C16E5D69B5632
          BFAB832B3A5AC94D4E71FCE4194E0E0CF2AB3D7DAF1FFACF173F0D1467002E97
          5551ED69F9C63BFF70C5C225CB5EEDE9EE4A2A0311374C559E173078E61C1F7C
          78D4532A786661F7D2FBE7CFCBC67D3FC0755DEAEAE2B8E1104A6B4646C7D8FB
          DE81E2D9931F6C1E3CDCB717F06B017E1748F8BAF55BBB522D1D8F2B65562BA5
          5AA4142829A9B82F02EFADF1B3271E1EFEEDBEC1DEB59B3A5BE62DFD2B6D58A5
          946C9162364F28E1075EE9DDB1C1A33BCE9F3C701C2803B20AF0BB206A2F2E0E
          60CF4515CE001A5073E100E1B9FC504DAE0624E00301204D453500FF3F444D50
          E300A61A3539766D6E4D8EAABD1DFD0F421191AABA89B8690000000049454E44
          AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F400000012744558745469746C65004D617267696E3B506167653BE63071F200
          0003D349444154785E9596CB8B9D4510C57F751F4E0CE8FF1251702566914DDC
          F84017BA3004370177A26E226E4230195DC507889AE82ABE8266A1A0082282E0
          90F89FB81046EF646ED7C9108A3E4C8373BFD4A6FBEBB9557D4ED5A9EA094944
          046571F59B5BBFC42C4E2250400804201104420808400804AADF220194439D43
          FF6899BF9E7BE9F1534003248905B60022224EBEFCCC09CAB876E32FCE3C7B82
          A926410448F0C9573BBCF2C26350903FBEFEE793C00CC83A2C00B6506D5A1304
          48A2B5AC7D144133A52EB3C17231E3CE3AC984BDFD06C003CB194A5100BA8D00
          C2D1548C847A76051D4439A850E83030D997102068990071248094F8ECEB5BC5
          3300F1F98DDB480E5C680A98F5A03A1074A55CFD72A783016D040012679F7F94
          FD750270EDDBDB9C79EE113A515FE84C08BB035B8B197BEBC6A7D777387BA001
          051C5BCEF9E08B3FBAD68EC80036551AE56C98B99D4475880C62399F2189C5C1
          2A54C24C061BBAC0001CCC290505BD1684CBE1F604EE090F0952794F8C20E6B3
          194DDAAC01659A179029B34506827A2C5913F60494027FA1B61980833128B956
          0D93C6FCA3BE9D508307093273BA06B2D495299048066D3803E4300C84E78733
          06494E2B81C65E2650C9DFE4DD0BE1AA809712302EE71A80D820C274290232B3
          ABB716C4E1DBD2353310892C00FD7793065182593A033D2D6664939F27E46A64
          933585D0D41278C0A8322042E076AC38E10B0DC925C84C4C04B2698A0865A77A
          949CE6C3D728C14A08770CF43920B973D273A056346AA050AA074B75479B304B
          00051A5E470564CA229EAA01D7AC18679AB5377589B551DC9C3AD51CB02B2DE9
          7644091AAA29A6E875F3735C8B3A557C16C25631B0BF344103AD095708B7D2D8
          E3C8ECE50E70538826A10C5425CD36A5040DA8DA237A17C8912DB4FE5DE64C55
          096A1262329B0751360F152B19C0970DEF828109E4F34C831253079134380DFF
          F58C9D80F5E02C0CA358F2FE7F34109E84C58E5A532E49F856993180DF84BEF7
          102B90F79B8140126B07413253313276BF834840999E09129AA28196E2FCF60F
          805FB2773FFA7950BD2FAE738B0F75F00097AEFC0874D7298F91B8F0FA53FCFD
          CF0A45F0DE873FF1DAB953AEB9138E2C0EFF0D83BC7C70F91BAF9E46C0F1630B
          DEDEFE7E230054CFA11F23339651985552E3578EAD40215296AD2A16C0518328
          4B843C7C7C89CAF1A183BD078E81085C164F3BBF078207B716BD0B4801344006
          604B607FB5F7EF6F6F5EBCF944C841CF5FBA59178ED97024A43E0195747BEB9D
          EF2863B5DAFD1DD8037204A03AFCEFFD0B2F3E0D6C0173F7EC60C3D984DFA898
          AF80DDDACB000CE20EB00676275E3CDD4C325D02B80BCAD0D59D2396D69A0000
          000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F40000001B744558745469746C6500506167653B4F7269656E746174696F6E3B
          466C69707F1D18BB000005C849444154785E9D955F8C5D5515C67F6B9F7BA70C
          454DB0C6BE4162A0C1DA12691A4AB10869210D894C8B7F1AA055313106315588
          AD163A42E6364A28C138C6A83C902011D20844C13F04FB628C465F446882896F
          3E98E083D86267E69EB967AFCFC93DFB9C7D7233C1A12B3939FBE43CAC5FBEF5
          AD6FF7A82BFCE4E77F3D6D7093610821C0A03E092490511F80B7CF9D1F1CBEFB
          8639C001FDE0E93F0909015FF9EC7534258977AA5EEA6306371D9CB99AC95A5E
          AE1845A71A45CA51C5D252C5D9F3258B4BA3D9477F7CDA8E7E69CF1C10EF3DB4
          8337FEFEA6AEBAE2832B00ACB91A05AC21ADA2009206E0020099218C28F1EADF
          FEC5E7F65DBD02B17C7C30FFB2CD1EDE3B07541FBE722392041700D036A2D11A
          0484220042452086FA5C2E8F00B8F6A397115D0F1E3FF90B3B7164660C61660E
          E85D03404B801096CF84100872ACA855288735405104766EBB9C38F2078E0C9E
          B793B39F9C0346C01A21B207F02481B2CFF218600C6166C8C5B0AC017AC13002
          BB767C88CAE3B172F659E607774C40ACD903A939932019269861D818C00C7A85
          11825114E2E65D57E2EEC796BFF9343F7AE4D0C380DE15807BB36E06123F7DE9
          4C0B83E0AE4F6CC530FAEB0AD64FF779F0B19771E51505B1F39ACBF8C0860DC7
          801340BCA02D40428899DD9B20A701EE4E288CE98BA6B87DEF56CE2F0EC7668C
          95A8A233AA2285C1FB2F7D2F40412A335BAB0249680901CFBDF206B8B286CA7A
          1EB8753397AC9F1AE7431CC5314055450C115FFF670310B20FD66042C93BB317
          FB57147039122070A905341C33D12FC0801020985104D8B66523C0BA644400CF
          20FFC703A26EE4D1F9D9AFCFD4F209DC20081C402260F86A71EDA000DF7DF2F7
          6F02BCF5EFB7BE33383233483071307FBA8DEB6F7DF5E609000900B988316218
          5F3EB803E85A81545A35AE4739AEF9CFDB43CE9EDB786C3838154ECE1E1800E5
          ECE13D31C5F50AC0A409DD41A0A440B2C4D85CC2C0B20926D7D31DA283CB7037
          2A77FEF8977F70EFC1EB58B933BEB17CFC19FBDE893BC7102B715DE5B85E4D01
          4194B75DD48D67A995432D89D51EC028308A68006D5CDFB8F30AA2FBD1A5234F
          86274E7E61000CCDAC02BC6B42F3A8D68072918148A50C9220BAD76DB08042ED
          48896E5CB3FB639B8855FC7A39FC6178EAFBF70C8045600CD131A1232513BA83
          7B1EBF94632DCFA1D5421848F526D44786E57237AEB9E5C6CD5431DE3F2C1FB7
          534FDC3F001680D1C4089421949A4938B910D9FF80A7E66D591AC12A717DDB2D
          5BF118EF1B958FF2C253471F026203904780881EC9D7B321090C9E79F1359072
          0427687738B4FF1A000281A9A91EEF59BF8EAF3DFCFC645CB3FBFA4D6CDEB2E5
          BE17E0DBC0B0F140DE0217EE42EED00D28877D7BAE42791F491CEDD9115618D3
          EBFA1C98D9CEC24249391A11A3A82AA78A11434D3CF7016B14A01B44313A9252
          038344FFDC6FCE20E5B4A4352D084782CF7F6A3BFDA91EEF2B6CAC4215EBC6A3
          28625561A2F618145D0073792B5574E511486D04DCBEF72348E4546A61E0E2E9
          7E36AD41BF57A042F45510BDA08A22C68200A494095D00C5D4F192E91EB10CED
          08C811CCA95FBEDECE1C92424992BB3FB33D5B33818181D5AB880980C2C02B1A
          007A8003A3E1D2D2EF4ECCBFF2718F916D9B371015DB9134F5E95BB7E62D0004
          5D15C040DDA8505A51D265551885191E63170001C3471ED8771B701130055C3A
          37FFDBD79888FF675F7C1501F28E09E57953045FBCE3DA9AC040E45282088521
          9CC6FC0D4095D2A94CEE0CED08C82B74CFC11DD0F5402AE5586071582538657C
          65B5820562D48402F9F144E6DEA49F72AFA53276A54F3E580D46491143D90DB9
          89944D286591D37E0AC0A3404252F7E2C93773FE9E540A645DAF80C00DE8463D
          58A3C064095003363DD5CB3F10893743A5975096BA6BD09641AD72D121A9AD49
          00A5A75C5C3CFB87D9C77E757DD3411144232F48E458CED4D02AD602E7554EDF
          4B0BE7FE9C2E235F4D81082C3CFED09DFB818BBB5736C005BF7355C079E01C50
          AD06E0409940FE9B9BBF43ADFDBFD2131388FF0F2D68279291B09E7900000000
          49454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F400000020744558745469746C6500506167653B4F7269656E746174696F6E3B
          506F7274726169743B9A0AD4F80000046F49444154785E95964FA8546518C67F
          EF77EE784DEAB6CD56D1C2A48D44A55896488B208AFE2D2C8B0AFBB36951E222
          B540533137428B6A551906D14225A4459B3661ADBABA8916AD0C090A2232AEE3
          CC9DF9DE2719CE9C97EF34F772FA3633E7F032CFF33ECFF3BEDF9824CC8CFAD8
          C9D38BDF5AB21D086460020148188610020C100281EA5A2400AE5C593AB2F7D5
          1D870107F4FEC9EF851C017B763FC0F44802490D38903E3B73415DCF7038D252
          7FA8BFAFF4F5C79FFFE8D2E5BFB4F8D36F3AFFE325BDF7E13747801E9000FBF9
          97DF032B083047796C5A92B3C09A4A30900CA69D035E17CB0C6164891F2EFCCA
          EBCF6FA57F6DF4CEC1135FDBBB7B1F3D0C8CEFDC700B6A3380FF12A0A951831D
          9F828604A42A01425522A70488E1F20880AD77DF46767F7BDFB1B376FCC05313
          1266E6404122B509788D280C972119042784E2BB444A89940CAB0C610C072300
          AA2AB1EDDEDBD9B679E3813D07BF3C0861C76A0A80140181C0766A1B286D8009
          0933432E06C36500E6926124B6DFB781B1FBFEE1BE537C74FC85C3C0681ACE99
          16B888A3801216B6343C834C32C330AE07133398AB6CA24C558987B76FC473DE
          BF3CFA848F4FBC7C08D02C021604024001029A4A20C050533801A7375FB170E3
          3C6F1E3A832B4614C443F7DFC1FAF5B7EE078E0279C510CA9D42640509501041
          8D9DEE4EAA8C1BD6AE61D7935B58EA0F2661CC6331CECE689CA90C6E5E580750
          AD9A81F0BEC81E26C53B4226016600C67CAFA25A58CB4DD7551865278FF284C0
          789C49067EF172A334C0AA1970115D4A78C112844281BAC60CD6F42A5CA2A78A
          BCA62267673C72E62A709C005FC582903E4848028368DE6868D4AEC41A312641
          4CA98957AF327CCCCA0422840E50000AE7D3D38B33A723442AE4E1A5A7EF4140
          B284924FC8B87750C0BDB018D526EF7C6453238BA2240A094514EA2141329B84
          545D2D8826631D7F71EE62B905A3E1502A7C63F7CECD452329253CAB430803B4
          0079E6B14DADF089C6A5C849F071958E215C0A05EAB276066A962A7ECC253EFF
          EA02D6225540A81083579EDDD2AC4C614874CB80A4C202C710F0DCE3770548DD
          BDCC8A4016D23950DE636427CECA1664544B2803AB753E7576914099F53F4185
          2AAFEDDA8A2440C14B1D3290B30887C001046FBCB88D96E8940FE5637F384612
          C8506DA9E72E16640070951DF597C7D3710BAFE3393A2D9603C5E4B8D4611179
          6E065DE59209B0F25E0862850DA28C4519C2EE63288A719B35052A59A2195991
          84C48A19B0D884420106B2B0C40255D13140DC09ADDB9320F97F153024B5A48C
          4E45BBE39877101EC8C8C025D42503D955CBEFADFD1EC435EB5A968109B50A34
          0DA3843B1D1470012007594D41113C665ED12D6013D366C3A56E9711720754A6
          5DD10F226A21369E14CDC9908960355520C66925023E0DE1C2BA5EFB8F099215
          44A2EB203A5525A628A600174006348B8003A3C1B0FFDD5BC7CE3D6845F76AFC
          6EABA162D46AF91DE2754836185C3D0F0C012F09C4F571ED83A3BB9E00E6812A
          66B63CED771D6A54773E00AE860AA502029681715DD405B8FB89263D2C807F01
          84CCA1301FB5D67F0000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F400000021744558745469746C6500506167653B4F7269656E746174696F6E3B
          4C616E6473636170653B3E7604210000044049444154785EC5574D885C4510FE
          AA7B669728EAD578120F318A0822D1AC4662500888B028A260C4432407F162C8
          251B251B8D682E0B5EF4A444BC18C4F520F1E72288A81048A244F1E045250839
          88B8667FF2E6BDEED2D745F1F5B083824AB696C7AB9EEAA9FAEAABAAEE1D5155
          6CA4046CB0C865FA8EFE9333F9BB20FFDAC6E0D9DE939DC9F1F7CE7C2A22BB74
          920731172A80A879812A04022D7FBEC58C6A7B4D01B0B4B47CF4C0BE5D2F3A88
          578F7FA9D05CFCECDF7B8FF5C15B8B67F5BF4AD3B4BABCDAE8EF4BAB7AE1D73F
          F4C7F3BFE999EF7ED12F4EFFA4AFBCF6C9510043EB39C8F73F5C8037FF0014B4
          298F13A796992D490198A0E950E4A4E8FA270329F5BE12BE3AFB339E796206AB
          6BEDF3F30B27E585030FF64C74376FB9163D680720F40452EA811804503183ED
          329B9A1E02102088FD93CC65336ACB7BE6F6EB91727EEEE0CBEFCBB1430F1710
          22524A52283130AC63B620BE664CB5CF5405AA351B5AF6040908054928EBE692
          01883160C7B61BB0E38EAD87F6CF9F98AFCB31409DAD758FE975F686929F31B2
          730185B11344104DC5A56664750E0241C0CEBBB6A0CB79AE39F8365E3FF664CF
          445B4AA074E81A03996364508C18CE4CB63DB48B58099AB6A88328084110A362
          F7CEADC829CD8DDA37F1C6C25347AC07729D97673306C2287782C896591550DA
          1010303535C055574EE3D9238BC8CA52F6CA7D77DF88CD9BAF9B03F0D2C03270
          A7CA19E680C3F3D7EC04D4486056755D2151B0697A88C766B76165A541D3B648
          49D175195D4AA524D75C7D0500C4C240A62F40EB2CED79E7E4B9A23013DB9433
          81DB637A86E97B666F2B2C74C902B74991BA0EC31870EA9BF3F02614F3448A54
          05C259C4ECFD3719CD9C94EA5C206124C5000C07111A15438D4839967322A588
          E941404626805C8F2198BDAF163FFED6D6962DB3CE8507CF9C40B28DEBDE47EF
          B43A8A8D22C43C0E7B001D0840B33BADDB9C6DF0D0EE5B58229AABB7FABBBE3B
          68B369B1118D52C0E45C3190B4CEDC1DF9F809DEFDF01C6B0ED6DA0E2D38E9A6
          6732B4EFF11928286A2010A2404100D04299BD216288B34D84A8E291076EF5FE
          2003545832A11D103F51D7B116432877074BA0BA8E4E118ED8890FBE76800CA6
          B900E577D5D9F3907F31B0BDD4C23F119EE8051C9BB09E020F0C827A7ACF7652
          496172130D8295B5D6839B4F26859C274E81B7BA8C015A6D125D9B813A377244
          6142B32B8CE137BF0148EAADEB874C15AC6E6ED25B0752DE050C486159041CD9
          C925B08DCAC3D6D9B09A09A3AA65CC3568E6ED598B2767F69CEA1230B007B535
          D9E00534F9D072D8AEF3F6F48B8ABED63521C800ECCD3CB85261C049D7B20A2F
          766EE0CDAACEAA31E13107C57732EE364D0FC6EB2662442B268A12E3B870F068
          1382180EA3FBD43E627771F9E26787173EBAD758F25E509E76BE5BD9279C7FDA
          C6A780372785E56A476B9F03180980293E88C44BF95FD7FCA1D2005813FFE790
          EFCBF0738F20B210E186888652D38D13FC09839D25A3DBCB61B2000000004945
          4E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F400000016744558745469746C6500506167653B50617065723B53697A653BBD
          2F129E000004B949444154785EAD554BCB5C45103DD577E64B5083D9E91F48E2
          1BB73E501242820F882E826054348A82880FE2225F7C7DA890200AEA262A1248
          30221A485C882808BA11FC032E04F701174AA2996F666ED7D1D4ED9EC35C6622
          88355CBAA7AABBEB74D5A96A2389BD8F1D224080068076EAF891F4FEF11F330D
          B0CE02386130307E40AC44D936DB1A2B71EE8FF36FAC1DB8FB75000E80F7ED7B
          9146C69A3327DF411592180080919D1FD24E9D3862A102F0ECC3B7E0523299B4
          9866473BCD184F5B8C462D7EFBFD02CE9D1FBD72F0F0693BB27AFF4510F9CCC9
          B7F1F32F6779ED96AB60014032A848EAFD8A18CBBC75C6ED9100BA85AEDAB277
          9776189C166BBFFFE9571C78FC0EFC359ABEFCFCDA17F6EEDADE8B20DAEBB65E
          0D9284440010A176CC593363A0D711509A6286D4A488329B849C120C8EF1641A
          F6EDB76E41767F697DF513FBE0F04301C2CCBCDB2A49F57072CE64152C69D277
          79D29C8E94125202ACB188C478340973D324ECBC7DDB3FDF8D87F6BF70EC3500
          C3E2CF7A0014544A6F0E595840C6C8F2A15BE1408030EB883A1A770006C93068
          12766FBF1EBBB6DFBCBAEFE9A3AFF6418803A0BC7746A31708F4022E15770252
          C54124B3E0D1783C0D3083C69092A169883DBB6F82E776753A790F9F7FFCDC5A
          3DA200D069C220078ABE030C2616ADC1670B2DBEE18606576EDA88A70E7E0A77
          952840DCB5E3066CBB66EB2A803701E45E15A00895022190160E57BF9845D2DD
          911AC3651B57F0E803B7E1CF0BEB984CA6C82D316D1D6DCE18448ECE063D1696
          A1614ECC2BFB6B9EC918A58D8D318BB36158197411D874F906E4D21FA24FB439
          5292B3CF522C003DB229023E730E52315335280230C0194056860D9C04D920AF
          3458C98EDC7A00701400127180DD2812E69A43862A46D3E5E986198C9A15583D
          A223624A856D86E1C0E02D160360F9996CA829804A0ECC453587A446A9CCC3A4
          4B254B60F22849F7BC0400950671C00B9038455ED85BA94A28F67952938812B5
          888652B0848402C059B91174BD8AEA197A2A9DF390E45FF89A94E0998B496881
          B41F01081245C6A216303101A4A8A92808B88B637564007076206480B5D967CE
          B34EEBF5860AACEC2EDEA9561187B390D37D6915381CD64B018B736935617162
          E2047475543F697E6FCE90F43950F3A9146425D0D4521581A25428C0A4035449
          C1E2D21B9634A2CA5C891E239558FF6DA06EEF26A29494C28A4306FB63BD675F
          DE07FA8D28E74EC7824C7613D1BC3E4A1272160EF590A277F2D265C8056F8170
          D57AA9C4D2E30C4698C399082A582444C24BB5E2AF4F1F35A580DAAC72832FA8
          0406DB7C016029181F1673404196647AB7C9EB7F02E6E2826E1C4288C7DD9CBD
          132F19818A4E086B11B80C207553A27F63D5BBAC7A1FA29CCBDEE524D465DC99
          63B2F98A618CFDFECEDEB34C2A659A175085B02AAC3E804040ECDAF3A47FFBE5
          474300533AF1CCA1CF402ADF5DC84D25C8F94A1148575408D92C941300B99F02
          A3689000AC7FF8D6839B016C00D0F4FA775F6CF97F4971BA0EE04289021501C1
          AC30A665C3480EFE93187AA92D40D8E700AAECBCF7090624327FF7D5B184FF51
          EEDCFD88FFF0CD894555A0C2A614D871CF7E9F3D715E73A8405513C1DE5352ED
          362B4998F8B2F8310AB308666A7D7AF105B06A42A73B68ADB48143FDAE277F03
          1D77B24C56C78E360000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F40000001974455874536F6674776172650041646F626520496D616765526561
          647971C9653C00000018744558745469746C65005072696E74417265613B5072
          696E7465723B15F0EBCC000005FE49444154785EAD965DA85DD511C77F6B9F73
          6EEEB937F891BC24ADFD8814436892B61492078DD76092068C52A462420AD5D2
          561A695A0B7D2906853E081662C5121F0246F1A32A82FD80B692D43449A5C5D0
          2631166A5B0858A5366DD2C47BCEF1ECBDD79A290C6BAFBD7738E8453AB0587B
          669F3DF39FFFCC9A751C50AD2C2EC7FF4F04088002AAAA5C2ADDB8674FBCF8A7
          4359D6995314D4011A1728516D5A3499EA67D5A4E394E0C391AF6F5FBF19F024
          990CA0E35C36B763DB6A2A3974ECAF6CDA700D9345271275F0E81B6CBE7E6502
          70E08513730D56950952BD7497D2331CE575765A67A7D4BADAAA6D83518ED912
          435AC5E0831840B44DB7DAB2542274D7AA8526BB82807315280780738A040560
          21009C8A1A858398F9A9FFC089A75F4F016B700EA559EB08D401E2D05F9F32E3
          4CBF8744E40B01604E366D58694C38E0C433A7F9DCBA15ADB24B8DA266CDD58C
          9D7CF50CB76C5D6B4A9639F6FFE4F8821940441B8E4D4723A535EDA6A78CAD4C
          12EBED4054508D8A1AC00533E02C2044072002C10CD16E46489A6DB41A512475
          690217C52DA8041AA904CBC69AC808A8C0D1080A2DC00A04D1D4CCE022ABB030
          062A47B629C680080A2DBBE262507BAEC144CA55303D0344A495BD736E2200B3
          4A0089F5276613A4CE52A998D0140C550B12DF1242C08BE050028E20A1356B00
          7D9F63283190A0B1097D1000B41EB5066C510796F633A63245C441ACBF5EB518
          F125E0D00C3EF191CB00A68002104CD0490008AA3130B8D8035E1A134D416C09
          CB673B9C3BF316F9E0BDD870F56F9EFAD9C9041A94870E1CFDB72F8BDF7CEF1B
          9B6E02CA8900E2286ED75320D40CD49D1E04098EF973EFB26BE7B56D6FEDCB2A
          C9C38F1DB931C6F2A9142D00D1B1128F8E8360255000D2119560A0CA3290E71E
          51655C847454810623A6D09FEE31CE8B2A5627E18CAB7D1748235B51423056B8
          A2EF98ED4246862F857C9C938F4B03E023705781B0DD8126F00616E86342007C
          5CA175178892467150A50C8125D319332E70F1ED738C2F0ED120BCFA87437C72
          C5E731903E95A9392F9B6C18D81D77DDF7CF4FAFB90E09F2CE68F4EEB3BF78EE
          911FFCF9E4D1F9AC6640D2A762C8B1ECFA5DB8F0F659AEBA7C9A8DEBAEE66BB7
          AF67341C91E725A2B15422041B5C42102184F81CD418288AD2BEF9F657E7D832
          B76AD967D77CEA3B5B6FDD753FD06B3180282A009823EF05F525A30B0396AD5C
          8673CE9C17E331AF9F38C297BE7C84854AA7AB06ACD3C9F8E8F22BF96336B513
          D8D3BA8CA471E1587621507A47917B5495BCB426A4BF688AE9A54B9859BC9899
          D959007ABD29BABD2EAAE07D892F3DA08C8723068379C683F3C65651069C03EF
          C312C3554D29A97A4000048993508227F860C1013B199B36AEE3859FFE965EAF
          877319B53840D38673A80A659173EBCD7378F3E30147693B9D0603C2AF5E3E1D
          3BD66AC7DF5F7B93FEC7165114DE90AB421184EDB76D231F17BC74F015CE9DBF
          6081501A8135E94B975CC1CD5BAF65E7F65B18E642510A8A92171EC0D50050B6
          DEB09A321E2BF43536DFB08A221FB1FFD9E3144530C7A50F5C0C813BEFB88D6F
          7D73279DCCF13E62B40FDF2B383F3F0685C27B006BCC1600AD6640842E663066
          280B4FE16309BC8083B3FF1DF1AFF3A3943CDAAC8233B0498D3B40590AB6FBC4
          409CBE71DA75B30CEC7C74AD633330006519CC6FE1853B77EDE5C3C8817DDFB5
          A38D9A4F80AC62C0E7797EF8E1FD8737D68352F8CBDFDEE1E3CB67C88B224DBC
          323271D3173670F757AEE7D15325AA0AAD19EB903884EE5EDBE391C70F73F0E5
          DF9B0F6310C5C7A6EE0202140FDEFBC56D40AF31AF5D7C7FF91DF71C78A38CC8
          BD28FB1EDACD8B3F3F6E0EF3A0D000E0C5E844AB6126624DBCEF47BBADBF8C01
          874D5940AB12F80A08B5B80826BCF58F378F3DF5E4D90D69BC026B565F634772
          EC05119268BAB6D576EFAD87F8FE9EC75A97A42FC7C780DCD1964BF52CB2D207
          A623A02EB078F79EE74FDF73D7164893DF2570666B8C83BD8FBEC4BE07767C06
          18342EA23130EA36EB0768FBFF5B62C503C3465946C3C1FCEF7EF8E35F5E17FF
          1726E49A584A0AE3F1E815E06C0D205D39C1B501401B40AD4E6065B6C18AE352
          A9090831DB614C46A845FF07DB53B9A7908EAFDA0000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F40000001974455874536F6674776172650041646F626520496D616765526561
          647971C9653C00000018744558745469746C65005072696E74417265613B5072
          696E7465723B15F0EBCC000005FE49444154785EAD965DA85DD511C77F6B9F73
          6EEEB937F891BC24ADFD8814436892B61492078DD76092068C52A462420AD5D2
          561A695A0B7D2906853E081662C5121F0246F1A32A82FD80B692D43449A5C5D0
          2631166A5B0858A5366DD2C47BCEF1ECBDD79A290C6BAFBD7738E8453AB0587B
          669F3DF39FFFCC9A751C50AD2C2EC7FF4F04088002AAAA5C2ADDB8674FBCF8A7
          4359D6995314D4011A1728516D5A3499EA67D5A4E394E0C391AF6F5FBF19F024
          990CA0E35C36B763DB6A2A3974ECAF6CDA700D9345271275F0E81B6CBE7E6502
          70E08513730D56950952BD7497D2331CE575765A67A7D4BADAAA6D83518ED912
          435AC5E0831840B44DB7DAB2542274D7AA8526BB82807315280780738A040560
          21009C8A1A858398F9A9FFC089A75F4F016B700EA559EB08D401E2D05F9F32E3
          4CBF8744E40B01604E366D58694C38E0C433A7F9DCBA15ADB24B8DA266CDD58C
          9D7CF50CB76C5D6B4A9639F6FFE4F8821940441B8E4D4723A535EDA6A78CAD4C
          12EBED4054508D8A1AC00533E02C2044072002C10CD16E46489A6DB41A512475
          690217C52DA8041AA904CBC69AC808A8C0D1080A2DC00A04D1D4CCE022ABB030
          062A47B629C680080A2DBBE262507BAEC144CA55303D0344A495BD736E2200B3
          4A0089F5276613A4CE52A998D0140C550B12DF1242C08BE050028E20A1356B00
          7D9F63283190A0B1097D1000B41EB5066C510796F633A63245C441ACBF5EB518
          F125E0D00C3EF191CB00A68002104CD0490008AA3130B8D8035E1A134D416C09
          CB673B9C3BF316F9E0BDD870F56F9EFAD9C9041A94870E1CFDB72F8BDF7CEF1B
          9B6E02CA8900E2286ED75320D40CD49D1E04098EF973EFB26BE7B56D6FEDCB2A
          C9C38F1DB931C6F2A9142D00D1B1128F8E8360255000D2119560A0CA3290E71E
          51655C847454810623A6D09FEE31CE8B2A5627E18CAB7D1748235B51423056B8
          A2EF98ED4246862F857C9C938F4B03E023705781B0DD8126F00616E86342007C
          5CA175178892467150A50C8125D319332E70F1ED738C2F0ED120BCFA87437C72
          C5E731903E95A9392F9B6C18D81D77DDF7CF4FAFB90E09F2CE68F4EEB3BF78EE
          911FFCF9E4D1F9AC6640D2A762C8B1ECFA5DB8F0F659AEBA7C9A8DEBAEE66BB7
          AF67341C91E725A2B15422041B5C42102184F81CD418288AD2BEF9F657E7D832
          B76AD967D77CEA3B5B6FDD753FD06B3180282A009823EF05F525A30B0396AD5C
          8673CE9C17E331AF9F38C297BE7C84854AA7AB06ACD3C9F8E8F22BF96336B513
          D8D3BA8CA471E1587621507A47917B5495BCB426A4BF688AE9A54B9859BC9899
          D959007ABD29BABD2EAAE07D892F3DA08C8723068379C683F3C65651069C03EF
          C312C3554D29A97A4000048993508227F860C1013B199B36AEE3859FFE965EAF
          877319B53840D38673A80A659173EBCD7378F3E30147693B9D0603C2AF5E3E1D
          3BD66AC7DF5F7B93FEC7165114DE90AB421184EDB76D231F17BC74F015CE9DBF
          6081501A8135E94B975CC1CD5BAF65E7F65B18E642510A8A92171EC0D50050B6
          DEB09A321E2BF43536DFB08A221FB1FFD9E3144530C7A50F5C0C813BEFB88D6F
          7D73279DCCF13E62B40FDF2B383F3F0685C27B006BCC1600AD6640842E663066
          280B4FE16309BC8083B3FF1DF1AFF3A3943CDAAC8233B0498D3B40590AB6FBC4
          409CBE71DA75B30CEC7C74AD633330006519CC6FE1853B77EDE5C3C8817DDFB5
          A38D9A4F80AC62C0E7797EF8E1FD8737D68352F8CBDFDEE1E3CB67C88B224DBC
          323271D3173670F757AEE7D15325AA0AAD19EB903884EE5EDBE391C70F73F0E5
          DF9B0F6310C5C7A6EE0202140FDEFBC56D40AF31AF5D7C7FF91DF71C78A38CC8
          BD28FB1EDACD8B3F3F6E0EF3A0D000E0C5E844AB6126624DBCEF47BBADBF8C01
          874D5940AB12F80A08B5B80826BCF58F378F3DF5E4D90D69BC026B565F634772
          EC05119268BAB6D576EFAD87F8FE9EC75A97A42FC7C780DCD1964BF52CB2D207
          A623A02EB078F79EE74FDF73D7164893DF2570666B8C83BD8FBEC4BE07767C06
          18342EA23130EA36EB0768FBFF5B62C503C3465946C3C1FCEF7EF8E35F5E17FF
          1726E49A584A0AE3F1E815E06C0D205D39C1B501401B40AD4E6065B6C18AE352
          A9090831DB614C46A845FF07DB53B9A7908EAFDA0000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F400000018744558745469746C6500496E736572743B506167653B427265616B
          3BAF1562750000055949444154785EAD576D881655147ECE9D79D756DB40432A
          B23F81416244429A3F82C5C0922C2BE8937E0452422A929A891FA4BB25489A99
          20D207693F4444048B5297D4D22556ED8342322D4BD0B4CDCD5DD9DD77DEF9B8
          E7B4CD7B2FF70EACCC2B7879877BDE33C37D9EFB9C33F79C094504C30D228235
          DD7C5D870090B0E421325700403912A584A80C18400A801B21106EFAF4683CF7
          C5C988D3CC52AFF31136FF089CDF10832D70BA1A370B32165414B0715B1756CC
          6D6D069084281F8A99F325CDCF0C06E70EB2240C9878248B54024550014134C3
          A84A8D10A02C738B32002592CF05281143432020807D68B2C4102805168165DC
          10016DA26665D6C588423C05D88017022E453D98AF9180B0B60BB9DD90B77976
          71273F2A6E023CD532DD2001CB92B578BBE5BAA9ADCBA139958C4DD676E11011
          B04F80884A1560B1D20150E450A4986628BE09F59F930062FEB37352680D4B10
          C30C66362B09848DCC16DAA8699D2C454A52302C012E844079070E0390A7567E
          26BBDB1FF7146003E8CB6C830147CC650244ACE554B07AB14691C0FCCD87D3BF
          CEF7EC3CF3FDDE793FEDFFB06F085C17157071D5FE6A7E246089510E6CD1C54F
          4AAE1365F3A4251066A9C6CC19F73EB33708A68E193771F6A18F177402C8AC02
          A2EBA2368F08ADBCC55D8940885C4E88F3C3DA04081B9B8DD3D482204D33DC36
          6E2C5E787EEA1DFBF68FDA87391F6D38BE6BF5DB03FF9EAB01E028AE1D5CB5E1
          C0348159848CE464C00DA27804D8D8C8C9D97B9CBBD224390420850D4192680C
          C61A50153CF2E824357A4CCB2291B669DD678EBF7CF2C0E6DFDE593673968999
          6AA44296DC63039E00604320C3602D439230AA358DDBEF1C87E937DF745FE7C1
          51475AC68E5F746CC76B5BBD90C8752AC56C43A0E224C53F976B60965CBA3000
          FAFAAAB874B13BEBEDBED06F40DDD5D88EC59F87BD6743501D8811C51A228C4A
          48F8AEF3047E3CF2C3D1DE735DAF5EFA75EFEF2EA71D48A9ED76A9AF46DCE540
          9A21CB32D4AA113ABFFC962FFE71FAFD3F8FAC5F0B601040DAB6A9639F22D50A
          AA171A02416C09B2C7AC887BE58CAFEF72EF9AF7DA9E6BB7CDC7E2B7F608CC99
          B27EE593960090261A674F9DC5B1AFBA2EF49EFF797EF7899D8701544DA22825
          D4BA7CDE4357D5318933A49A91A53A6F5AA22843CFFF21ECB9B2AC166F555BD6
          BED406205DB76296FEE5F4DF72F7F85B86083805B2A1816FF6747C7EE9E49E25
          D59E5317014426E9C807BADC1F0F7B0869E6BCC2E94C234E34AA5182AF8F9EC1
          C2D90FE2CA40B2345AF0016DDBF84A3B8078C25DB76A1129E440D4B56DF66803
          161BB9B4874B62E575C08502434A410943020515304084384973FED35B2740B3
          7E238E37D18E2DF373124494F92761E201B299C56F4A99A558ECE09767CA9D01
          11A00801140482384A00009530C08C69F740A77A4912BF4BBB3F59D80EA06630
          39042025EF38B13BE93C6C3BBBB24C5020D2102D88E22467DF14A87C9EF9F024
          68D6AFC7F11AFA62FBB2364342421191B2EF0231D548BC8C07C8553B769DB110
          723B8E5310014D15421004A8848CA71FBB1FCCBC384D56A363D79BAB1A6DCB49
          B36D6C9C3B37594CDC6C3C188A14C226859651233067E97630FB8D890C856322
          A63C307971C72EAC011037D6139A0CF46B3E0F578E8500C5681ED184679F9882
          C16A8C24C9CC5BC2D0991EBA17A07F20BAB6B69C990D88E90788BD5C50753AA6
          4F05119AC200EAC61B30724805CE3432AD0D01C6C8E610CC7C4D5D3158A4308B
          285BDC3D2D9CCC20200C0304C29050A1C2610E9E32A3A5B95268D9C2C6F04D5D
          07E7E076C870DF064200D91E8140000205481820D4843054B625CB1AF9386500
          C9BAE5B35AD62D476893B2AC1895F86C3F1095BF05EE8C600FBC7C943FC7E692
          FF00CDA08F51CB8363FC0000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F40000000D744558745469746C65004865616465723B0A6E4DD90000049F4944
          4154785EA557DD8B5555145FE7AA4DF9D138592F3AE59D109B86CA848CD291A6
          C1A834194BB3E883A0989CB0248B1EF50F08C41A5FC642E8032A29282828280B
          6346A2895E0221B270B0845E1A4BCD9973CE5EBBB5F6598BB5EF1C2EE75EDAC3
          9AB5BFB8BFBDD6EFB7F6BE37F1DE83B62449206A36306B75DD17664D704A36BF
          C907B3D56C6C6BE6CB6B028A644EBC878AC619B0E805FCF5CF7E3956ABCD1BE0
          25CF7F1A0199CE15435F18167B324C60DFC3BD5DD49D214B5F79FB2744E72177
          088EECD0AEB52D65A09610F8F3F7F740BB6DFFD19FE1F017A7A677DDB76A3107
          72F6CFBF41DBE24597B74E81F2E5D83303127503C15E7BE638CABEEE25F0F29B
          939F1F185E77770C94E7D8860622C19CFB6033CC4E1DE734074384863E3AF239
          40D79603E0DC20DCD2D305B4B411DFF8E1AB83CFDE36F8F8ABE31C05D3C0349B
          188D82B200F5ACBC3725F0E54F1C0670194D90B9DC76A3CD6557DF0EF994872B
          172E809BEA4B397B036E6CF2EBD19175F74489433A84A7D61205263ECC61EAC8
          D31C7130EF0833446FFD6543AF81CB0702D2C28EF9D07B5D276C717E201D3DF1
          CDD89EF55BA53266C9323D44F303605CBF1090563EBA9F7C1AA23662794CE652
          48BB7B21FB55B5531CE286159DB0F5CE7AFFEA8F4F4EBFF460DF4A6654CA33AF
          C8006AD2E0B29E4DF0FBBBBB031DC8DC3BE3DEB1CF0B0D5C35742BD43BE6C1F0
          A1C9C03722D2BA0FE6C99E3938317564EF866B00E092DE19CD35A014D05FE7CE
          4F18DC28B18E385D4CE0390E71FA2FF8E7E2054A4E06599E434E369BA630F6E9
          C950E28251A50150C452E96965EA9C06E3131FD63A9776C112B230279BB21C61
          D98FA91EA0BA0C39D5CAFF47DF9D0D4828B71E0F108B3E397088420F8F913C14
          5ED23F7CEFEA00209F99541D40804D853BEE58AE196FA002F43A36B5CABEC436
          4659434B975150AD01CAC0893F00190CEDFE472FE2D288790EBD78348F00C39B
          7BB9FEC2D8C02B29283AEC1E5ABF42AF5DBD24F9BF65441A4AB816B5F6F5F0AD
          5350C328D71F4E9C61208D2A4093B3488D73369B175D8C3C7023839B065AAA02
          B432DCB1A19BBB5676713F3AA87650D76CAF8AD8AAA0150D28E8D1F13321428F
          AAF446AE9D44EE6DADA122760FF5A986DAD18091BBB3FFDA391550E65A052EB3
          52113CB62F34E8DB388047543078FFDBD3E1D14130656B94B1E25DC0C5622F79
          DDF3C2B69B550F953761A2DE79ABE14736D623AEA514F5F6B33B413AB2E6356A
          C9921C5A5A9506EC31E228DE3B7EDA2267EFD57BF3FAE898060A5040D8B36D4D
          9813FC5ADB1A78ECAEBAA9BEF400B14F4A994076C5D056EC224ADA3AC03BC77E
          53450BD7042F99E0A8B5422C23521122D017B7AF091E8DE64A0A6A1889F0C9C1
          EBEDABB8ED33F597EF08AB18BB25DB2C436F206F7D794AEBBF88DEA1D57B14B9
          D73134FE56D8BB7D2D20324D95556086519D3FB56995D63EFBF885B331C41DBB
          25ED4D609A6C57730A2493E80A0A6633144004CB8A89CCAAD3A4893ED172B507
          CA505D730A8CC699997FCF8F8F8C4EF4A347465191B1C5918949DAD1DE0290B5
          F8BD98B930FD3DB98B730F31F7D73173D441B688EC0AB20571E954F4CD97CB2D
          13F073649708D335A300E5BB7B4E763E065180FFF173DDC9E762BCF01F584354
          31935CA7FF0000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F40000001974455874536F6674776172650041646F626520496D616765526561
          647971C9653C0000001B744558745469746C650046756E6374696F6E3B4D6174
          68656D61746963733B3FE12FBA0000065049444154785EB5577D6C155516FFDD
          99BEBEF2A25B78650BDA5A0A2E2A448C8206E4AB9414504CC40F6A8458081809
          B0684848CC6EDC6477098BFB071A8CC134F21515FC8CA250EB57695960111404
          A26E7850DA22FDB2A596D26D5FDFCCDC7BF6DDB977C6A92FAF6D48F62627F7CC
          BD93FBFB9D73EE39738611111863D083F9F3C083E1FA060504123B2378A81653
          4A5A32435F63A9E0E0006C352B124102EEF39937967E691A4611815C864CD395
          3AC89BC93301105AD77BE42A08ACFB6BE8E98A1F99FBC2170BE46E0A01CDD830
          0C5634B1F445CD9FE90DF2F554A31400236820175D036B5D280247B6AE9BA531
          2D0599EA01437001F01ED86D1580618231037085C10002C448C2B86B42282072
          8104C01D909024B89C5D31B327C2B16C1723604DEA1D2021F42142D968905C74
          490830180620C80F8C328E94C52005061F9CD433576B8EE5F826A412D0272A02
          241530AE636C30490D2CFCFBA48C8209E687915C1E01970B4FE7DA100291D439
          78C2F170902E04C2B2F80F5DAD97EE8CB0104824A082CB6064E5A0F16C2DEA8E
          ED80700882F3E42C45289D8BA0EE0AC959A8D0C8B92FC16B00481694CE03FCD0
          E9A6D28EA6AD55D3CB9ECA0B1BAD60C2063106D1DB8A5B26DD8ECC1BA2F8AEEA
          40F9A2BF556D0290F0536AF0B4141ADC927A5A027FDA7EA27E434961094FECAE
          9AB5B22C2F6CB681240930A0BB1EA3C6E4E39EE28756EF17241EDE78F02F00FA
          340931C44224D278C02761BF54D5D06059CE3C3B49A278D5B29BB3CC7645C200
          9CFF3620B7B00077153FB8F613C1C5A24D872489B877B0DD75C6BB180071FF3E
          21291FAE5F81257B62080E234DA9B45E3DDC58FFD5C9DA7955DB7635F7393900
          4C10E72047C0B9568FD163B23169CE03EBF6FD79F63F000CD3C630080E258E4E
          41476785BA2300062480A35B167A24ECF2AF5BEABEF8F6E2FCCFB7EE68EEB346
          80C8D407F22489068C2E1C8EBBE62CF8E3FB1B666C061091244223A618000771
          4DC4B5DE7145703E3801E204BBF3B4172B7BE7A9B6BACF4ED53D50F9CACEE63E
          3B0A100309EE0ABF56879BC6FE0E934BE6AF7D77FD34DF13A1E854A6AA217785
          92220447B4207770025CBA991CD8BF9CF448586F9DEDB8F8E9B7F50B2B5EDED1
          124F8C0093241CDBF7C44D854912C5256BDF7976EA460021000691E37A4B2485
          7458041F3C047E2593165A578E7BE170DEFD4FE74F87BFBFBCBA7AF7471C917C
          0812E0B20ED80EECABF5C89F58889CECC873CB66164401B0706E1123E29EFBFD
          B2AC46FA42A459AA58658E9CCE34C98CD525E3C62C2E9EF0DA7D4FAC34C15B00
          AE6E3818C1C88AE25465358E1D8EBDFAE6D1E64E3FCDC8561AA98C107C28041C
          657D387796079EB966DEADE31F9F7DC7817B17AFC833F9CF703A2FC8B4541572
          5814DF1D3A8FCFDFAB2EFFE789B6BFEA42437D8D9504CF9B2481698804B80882
          87D7948C1BFFD8CCDB2AA69496E567F026385792E064810098C37270B22686CA
          B7ABCB5F3ADDA1EA812EB56EB6B8C050249094A11058B0F9B00FBE6A6EE16D8F
          CE187FE0DED265F921BB05D62F3110B7E1B24B827F7330868A24F82BDF5F95E0
          3D9EF5F14B1F4B73B5E53A1B048674077E059FE38257DCB7B82CCFB42FC3EAB8
          20C1555F90350227AA62D8BFB766C7B673D79E0F9463EAADFF50590FDD1B0882
          4607E73408010DFE4C514112FC0F15534B97E6998E028704076046A2F8BAEA3C
          F6EDA9D9F57A6D8F047782191519FB38D20FBF15A314021A3CB46ACE98F18FDC
          2FC197E465584D49F0F320EE004C82E7E0D897E7F1FE9B87F6BE7129FE77F9BE
          DF1E0D3EFCAF61F093ECB5E55E371CF960EDE4E345CB9F9E10661DB0DA6320E1
          8147D1DEDA8DE6582D48A716794DAAF0759050A2964937242A21E29673FCC9ED
          3F2E04D00DB94344BF6DC93243C084487604BD17FF0D380937E6100CBCBB1DB9
          37E721FFEE1960A11BBD0EC26F40FD9893FF0CE1EB2A1BF66FDA3A0D40585F58
          9EB629256181127105CEC8F7B27DB5117657A30248713CE9895C55F47B87101A
          9EEF6581395053AABE58C296EC55C74B4CCDFD6AB7474C5D7283A9192018121C
          047F933C9D438881B3805C3CA11ACBF0C871EE12230601CF1AEAFF3A915A7675
          6F5F3520FE3B02816E9990B623D21B766FC2F957E596F22242F040803C3022CD
          23CD9F923BB320298D4688DBE288EA23537B42D2D2B77CEFB945003283B1D2C2
          AEFBFF507B5717ACDE74BF6614F8718C0F0876FDC2070A010584E3FF3728F8F0
          3F53A759685284F9D20000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F40000001974455874536F6674776172650041646F626520496D616765526561
          647971C9653C00000022744558745469746C650046696E616E6369616C3B446F
          6C6C61723B4D6F6E65793B426F6F6B3B8243FE120000055F49444154785EB597
          5F6C1C6715C57F77766D6F69038D6D394D6A27C1A1F48F5A14D9210589874869
          A52224D4379E51FBC60354423C55A23CF48D778484A508784455115590A082B4
          0295B6226E9A546D9A36FFDCD86D891DAFD7F17A77BEEF1ED0A7D5AC67E555E6
          A19CD9D1A7D919CD39E7EED97B67EA9230339E79611E0C167EFE6F2301E38B87
          76AE92A8F74F898517CE1A9001B5B4561052F1BC000762DAFB22FA02167E91C8
          6B3FF8C9A3271BF7D45FCCCCE63112EE1D1F2B593009CC10C20432030D981488
          3E3CEA6C6BBDF3FCA917CFBD0A047AA80F28AD35EE19F96DE8C6A9E77EF82B8E
          CCCC511D208961B8B2BC3877EA8FCF9D020E03B15F81326A48535BB703EF7D78
          912CBB1F9461E6481972C710CA0C1C407861B8ECC4A3430638582DA3519FC6DD
          A77A9CDD611530C93974683F6FBCBB90761053D3192AB3140712600CA8101A38
          6E8C1C24042F78FA02CA307738F1ADA770CF919C3C8F1C3FF6204101248400A1
          52A0051212C0E03502C1CACD155E5AF998827C88005CA2DDD9E4F2D27B6022EF
          E4CC3E02C1732A433D9A7E2698DC3B09704701E651C410881E0023B8133DA6E3
          2144E5B508013B910C781405860990448881E88E64788C24013182095462DC35
          800062504017978A4B8686D05D040F891020464FEEA3E7BB1A55C5E617638E5C
          770C21EE22861C8FDE539ECA9F440DBBFDC26F4E03F0CCB3DF05ED5E8A90E544
          57850CB8E8866E2244E083199081896E2770F6EC259657D698999E00E0B533E7
          683446999B3F4296D54AF5E9860EF20A1970779AAD354288985911C8104351F3
          6E1E78E5E5B7B00C1A632384E008B1B6BC96B203E2E8DC578B9C08D8D85AC1BD
          541B0334B4021BAD75EEFED29E9485907E82BCC8DEB9C52BDC75579D5A2DB9E4
          7B27BFCFDEAF8CF3FA5B67F8F8EA476C6CE4A96A025C4E736B957A368ABB570B
          A1C748C803ADD60659564F22D20D25C0E86CA7A52039FDB7D33CFCD8011E3F36
          CF13DF7992ADEE2D966E9D4FA29BED75A4888DD451850C2017EE202C11B4DB1D
          5ADBEB9809B31A26989C18E75673B56882379B6BBCF2F20DFE32F60E73C70F73
          68769C76778B6EEC146C927051A5153BEE39202421411EBAB4F34D6A598D5A36
          C2EC91835CBD7A8576A7437231027B271B74B6037FFFEB05BEF1CDFDCC3E3C01
          58D10DD37DA30F0DA1F505285D282F8F78498418C96360D5AFF2E4132778FD9F
          FFE2931BCBA8984AE2DEF1513EBC7093D9872660E75490E355FF862E10C2E895
          AE986E8E0C7EF7EB37993BBEC253274FB0D58A2C5E38CF07172F15424647B3B4
          168352C233C79D0A218CE01E41E08531218904170F3CB08FF7CF2F43ED55BEFE
          D00C478F7E8D4B1F5D26CF0300D3D3F711112670A367C471A9CA34743CAA483C
          4044486008010767EEA7D9DAE0FCDB9FF2E66B9F808BFB66EEC680C6D818F3F3
          8FD08CD710A2F721CA71AFF03C205712217A84122044EF3BC1838F1EE0CB7BF6
          70EDFA124B376E20C1D4E404FBF64D716CFE31965B174B93CF106973AA744211
          DC918081101A8680FF6C2EB1FFF081FF95FFDB2C2CFC01014F3F7D92DBDD4D96
          9A1752DBCDACFC0C9E4C5509A124702F8D5415BB3004723EDBB8CEA7CDEBFCF8
          47CF62C0E2F53325D12E4AC82454751CBB3B483B1A88A735B91208302361F1DA
          991DEA8B59558223DC84EBCEC3485E28350448B6BB2BEF5B11023334F068AEBE
          B05206868550408841ABCDE6E6C4E8583D4D4033B0DE46114CC37A36251006EA
          3B97192630402684585DE91072AD0139E0BB097060BBB5DAFDE9657DFE4B3226
          0C10E24FBF0F0531142CC804A20C096185231026C3DD57D73FDBFE19D0DE4D80
          8008B43FF8C7AD97803F03234046C2E7D5DE07879FF79EF3AD42C09037A308DC
          067A0317FB82DF8A032040C332A01EA9F3FF83E883FF025D7EBF988552EA1200
          00000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F40000001974455874536F6674776172650041646F626520496D616765526561
          647971C9653C00000014744558745469746C65005175657374696F6E3B426F6F
          6B3B1638166A0000058C49444154785EB597DD8B5D5719C67F6BEF33E99C7332
          33B1D1890A2DD65A52DB62A231626B4825515AF0ABA9E08D175E8B562F948A20
          5E08DE8877FA0748A1A05E881F50B47A9516546826451AB09566200D7134C924
          F375669FBDDE0FE52CD65E1CC23007A92FACFDAEB3F7E23C0FCF7AD6BBD60AEE
          4E08812F7FFD47003CFFD3670329026F7F78C9E0EEF4C851C02BA04E791F22B3
          7F77C0004DAD90C80A64A0FAA9AF7CF76C7FB0F0C3505527124D38FEA9CF9019
          17FAE078CA50BE79EAA7319E7E032A7165E3FADAF77EF2AD2FFC0910C0A714C8
          04E6078BCFAD5DB9BAFC83EF7F95471EBE9FD92301EF156FDDD8F9C82FCFF333
          E07D8066057A4C470DBEACD2F0DAA537191E3A085E1182E15EE166041CAF0218
          80639EF59CD6DCD4A0020C425D31DFAB50D5E584494B8A3B14086EC6C9C73ECE
          CAA5CB9326223C74F67344B34E6ECA142438F7E2AEA9479E8AC05D41188D9A0E
          A710988E606E1C3BF6E004D0DD19C7C813A7DF4FB432C7396750EBD00D08180E
          49AB6EFCF55B2356AFDC2483EF45003767BB6978E3CDAB00B46DCB89D39FA02D
          04724CAB11C86E9CF4BD7B91D2D2C23C070ECCED4B20981922824601022A82BA
          A35A40A0AC80227661E1855E2757D48A0373056E4F026E864445D500D0A8A839
          624EC12CB9C81200CB224092BFF388568E752F604F139AEA8480A81000354504
          54B3A992E94484D7565EE5F2EB6FB0B17E9B50C13B0E1FE6E8871EE1FE873E48
          0801CF6C024475546D5F13E2EE44115404001145CD90EC018C666797DF3EFF73
          9AD188A5434B1C39B24C45204AE4E2CB7FE1D22B17397BEE29E607834E210D60
          EEB3784091718B8AE20E22115547B42CC3F37F78118BED7F81DFC5DC5C8FC74E
          9DE4AF7F5EC1DC585C5C20C6C8C597CEF3B14F3F91401D7AC131B5FD3DA0A26C
          6C6C225120240F883992EB8007AE5FBDC6C183435C7D52AC8EDC732FF2F205DA
          F1B853F1C6B535EEAA616B6CB8838AA1D62990B3577798D09D76DCB2757B93D8
          0AAA4A5443C48949091E78F028BDBAC7A1BB97387EF218B777226FADAED2340D
          1265D2FAF37DEA2A10C5D86984B12866B6BF0955151545DA966D117A55859811
          257BC0F9F0E38F73F7A0475DC376635C78E56F34BB638603236A4B5DF738F1E8
          49C651D9D915DCA126A06AB31422454D31371063A76DD91D2BAA9900DC12E3D6
          28769EF8FBAB17A8EB5433DEF99E65CE3C7906FA8BFC6B634C4CA044AD30B319
          4AB11A2A82ABE280992062EC4603A00A81108A641EE0DAE55516860B3CF0F051
          1E3DF3496EEC44D6AF8F10A32BC77530547D4F1306CA2A4045325BCC7CD2546D
          BA0C7BAA090E0C8643DE7BEF3D1C3F758A2BEB0D9BA398AB61390F6885A9CD56
          8A552C4D8183A51A809A97838727604863BEF8B56FB2D4AFB9B11D59DF2E5313
          709CD497E0E82C26744B2674B5046856EA40D986F1D4616DF51FFCE6855FE3C1
          F9E893E73872DF07CA8E49A98402A8ED5B88D2A0A886A5C1985BDA8C2CEF74D3
          C7B1977EF11C95C3FCFC9095177EC5679FF90E63B1E9F382251D4C6630A1AB62
          1A31B76EAE4D3BF970EB64C080FE6040AF9A235481FE70C8527F8E7FDE6EA6BD
          82E358F79FFB9762553C21250F68AA6249CD945338A79FFE1217FFF8E284C0D9
          739F47DD312B1B1765FC6C264C735EA6C0DD301CCB2634CF23C161F0EEFB78FA
          996FB038DF63735758DB18A366657BCE541574A6EDD81CB3AC4002D4446AFA40
          62298F5A65F5DF3BB843F67EEA5B5907A937D366E46E96CC625E56C184440628
          CFB21C8B2F3CA49CD5CB11029DAA7B99D001118D37779BD1E1AAAE511142E77A
          03CFFD021042C080029A07151CC7D95ADF22B6CD3A1001BB930018D06C6FDEFC
          36EE3F0EA13A9CD7F1EF7F77A154B5EC6C0F782779319A43EE4FBF53BDB9B5F6
          FAB3C06E2170E7D5AC07F453630EA8FEE7FBE0741810815122800056AE662514
          D8019A6CCAB7F9562C5990BD3C508EB7FFBF704AF01FB776530C22293ED00000
          000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F40000001974455874536F6674776172650041646F626520496D616765526561
          647971C9653C00000010744558745469746C6500546578743B426F6F6B3B0C3F
          E3B90000059949444154785EB5975DA85C5715C77FFB9C99B91F89977CDE36CD
          AD46B0A5624B6D4BF521AD111A91BE148A94F4B98F8AD087A054FA225A50AC28
          08F5419022ADB4DA168AA555486C8D1651935A35D850B1E9BD26E426CDFD4AEE
          9DB973CE5EEB2FCE399BC34086B90F75318B3FFB03D67FADF567ED392D498410
          38FEF8DD0838FCEDBF042A0B7CF8A60641122D80B438FCC4C90064405EE11822
          5B3F17E08055DE90480452F0FCD92FDF76DFCEEDED275A59B84B0814D879C3F6
          C4B2A60E0DA4B5D2AF591310028932EAAD4BABFDC71FFAEEA96340A4B6D63053
          F25DDBDA3F3BF7EEF2ECA1C79E66EFA73ECBD60D2431CA36CEBF7D272F1D7D1A
          380058538161CBFFFDDEE2ECEA8AF8D73FDF617DC7015046088E9421F72AA72C
          8003086FAA3194899B430638843C63B2B51F8B3E5BC72C465520988B1B6FD9C3
          F9E3DF1B38825BEFD89FCA8AA4A1684AFBDE6C28A1428541AC4E7D944C8114A7
          21306C410E9F3FF22588254258513277D7BD605D009033D46C09A8DCBD42F0CA
          D5DCBBB2789E853F5F4E04184500B953F6AEB2B6701A096251B2EFE67DA8DC68
          1487908000A10942BD45230525E4237B76130263090473B0D2B0C2218095421E
          419602254CC1860279D2BE20245A12B2885C241BDD02135E463C3A008A11990D
          3C90622B653C9CA9046A4EBC21873CE2AEA602A345086E05D122013073D06013
          079AAC206B4D1026F62412A8B882F7D7EA1B01241A0225328D15213261A5A3D2
          7120960666C8ADC92E59B68D93EFACF18D1FFD9D07EED9C9578EDC0C5A49F3A0
          1169085502AEF11A40C2FA7D2C1A92F05807B748322142681342CE2B6FAE90B7
          3ABC70FC2C8F3CF07126F24954ACD7FA504294955BD38019F4AE6E10CB482060
          A521AF1C25FE224CCCB0B0D8E5CC42973CCFE917392FBF31CF912FCC416F15C1
          904EBCDF1DAA408DBAC61C1071B3A0BBB64967BA438C0E72649E3A0B2187ACC3
          2F8FCDF3E0C1199E3BD6A33331C9F3BF9EE7A1FBE606678A3D40C8858A82D006
          D91644E82EDC8C5844BC8C28CBC02292A59CC8DADB58BD5A70E2D4057EFEADFD
          5C5A315EF943C1E26A8FDFBF75917B6F9BC1FBEBE08EC7022470C3DCC76A0093
          AAFE9B8840511478D907B35A5010F2297EFB769787EFBF85C94EE0FEBBB773FC
          D4157ADD0ECFBCFA3E9FBBFD4E30C7CB4DA4545A43AEF1A3186790791AAB3221
          8B78B109403E314319233F7DF11F5C5CDAE087CF74D83B7B3D5353DBE84C4E71
          FAEC3267DE5BE613B3D3A8DF25999BE1365A8421A1993073DC1DC40025217740
          D09AE6D5372F72E0FA495EFECE1DB526C589D35D9E7C6162A085677F738E6F3E
          72131672F008003234BE0504093C46E4423501DC40229FDA8193F18BD717F9EA
          83730365C7F58B034D1CFCE46E9EBB6E9AB345C11B7F5B61716993BDDB7760DD
          0FC04570DF9A08E51A2A970CE4A2357303D1339E3FD163A93BC94D735384561B
          E4B4A67721C4AD1F6B73E183FF55E13A7EFCAB4B7CFDE17D4CEDB8917279BE12
          A46D45840E5E8B902094C6A9E08B474F51944E51161C7EF43C277F720F480871
          E8D1BFE226CAB28F45E7DCFBE2B53FFE873F3DF519240739EE8C1721A29A822E
          847013B8909C63DFFF34C38F8F8357FEBB1FDC0E12432655EE0219EE3E7E123A
          42560B4FAA8938C5CA7C4D5B434F701014CB679B29A974271052058110C216DF
          82AA05E932AAB30F1A6E072120D414031194E67F001C790A27DC1DF95645D85C
          AEFBD7601AC7A80E182A4CC907D4104BA8BAB636BE0572C06243C01D54F75A21
          80841AC18037B10842A41738050F1004285595512254F5FC6B6975ADBB7BBA9D
          E1D634560470D5ABA6CFA074CA70D6C3FF1F2F9FBBC26661CB4009F8B50838B0
          79A16B47C3BB979FCC02BBA912267FEA7594329568A4004DAB54EFD52886F64D
          2CCDF7FC6B40EF5A040418D07B71A1F712F01AD0063200CEAC8FFB1E1C77EE75
          E6DD4460D49791011BC06612E587FC551C535F46692035DDF9FF99688CFF0299
          CD3E40AC2AE8A60000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F40000001974455874536F6674776172650041646F626520496D616765526561
          647971C9653C00000014744558745469746C65004461746554696D653B426F6F
          6B3B5E16776B0000066249444154785EB597DB6F5C5715C67F7B9FF125E9F896
          B12737EC90A8C469705015D4F21451088AD424CA03081108B415A8FC0528412A
          6F085582AA344025E0012844C11015AA3E340DB8BC50B59550502564923AA036
          494D92F18578C6733D7BAF8575CED9C28EE38C85CAD2ECD9B3D7EC33EB5BDF5A
          E7DB738CAA628C61E2F87150F8CC6FC60DA9193E78D3E5B3AA922333F170E85C
          12DC021160DB0259FFF70A08E0B3114004002138D199C3470F0E6CE8FE4E0EF3
          71321B1CDE0C6878ADC8277874C5DA802A1A422B3891BFDEAC54BEF5D9336727
          004766B93B904685AEAE5FDEB87AA378E0D96718DCFF20EBB540E95A56FFE795
          FDFCF847BF003E0CF83B190816B5AA95E242ABCE95C9292A9BB7825A8C11542D
          2A8241516B400014D140C6CA4CC40B5840C04496EE0DFD782FC52C666B2D068C
          2A8C7D741477E1256E2E0D80EDF7EF405182290A6A300A369440C1845DC11F50
          A1547A0BC4E2097156010820BC087B3EFD49881D8AE29B2D061FDA8336EBA800
          48C89EC4A18A6A162C9965D95A828FDA7C99EBB3B70200D602808AE0AB35162E
          5D02C0C52D7A877248A3167684D78A0C7599235BAC60A6ABBF80516D0BC0A828
          E21CE225D107150963751085159102B8AC96BAAC3CDA6AA57D01DC13808820CE
          A3E21105EF25F9ACCEA3680040E9BD12A56B251666CA5466CBF40CF6D037D8C7
          D0F010C591A10036B083F51E2F720F0642138AE09DC33BC9044AD2E0DE01D0AC
          B7987C7D92321BD9F285138C8CEEA1A350209E9BA3FACE652E8D8F337D659ABD
          9FD84D67570E0510455D8C7859D584963BCCAB22B1437C1842606571BEC21B2F
          FF05F3F0A7D8F7DC691E387288D1BDBBD8B37D13BB97E6070E1F62DFE91F601F
          7A84375FB948A3DA4C808BF8EC37653D3D20F8D82541550DDEBB04BDF7317FFB
          F3249BBFF415B61F3BC6F0600FC68002A24A4764E9D8D0C97DDD03E49E78828E
          4D9B7867E265C61EDE99963361C003D00600342B15BCF3804112FA855BEF96D0
          2D3B281E394AB17F631618D0D06A30F58F6B9C7EFE2CDFFFDE49E2C347997AE3
          754AFF2A53287421E54A00608030AB5DDD848A6BB6A857AA692F7841E29899EB
          73141F3D4C646D92ADAAA22248A60397A7DEE3B91F9EE1AB8F1D636EA6441459
          861E3D42E9FA2CD27248B80BDA35A1A84FB2F7B1A3EEAA186B51EFA9DCAEB17D
          DF18918596F3E4121030FEDBF3BC3AF126E29B7CFD6B9F67EBE601F23D3D545A
          4AFFD818377F5A41CD56D43BBCF7ED8548449380A20AA2B49A4D7CBD8E8B3DDD
          7D7D4C7EF938CD5A8346AD49ABD1E0C2FE833C75EA499E7EF605D4D7E85DDA13
          8B25B29EAEFEBE24992489B8897A6D2FC5AA9AD45D444195204C5DDD9DB8C50A
          0F8E9F63E6D64D226BE8EA8878FFDCAB7CFBBB3F636CEF081BEFCBE389503429
          556B7191CEEE2E10419DE0EFD184668512FA4CF9488508117A063652BB7C99FC
          81036CDBB62D0160B03CFED8E7F8E2892779FCC44186477662ADC99A89A5FD7F
          27BF298FFA5447A45D090203CE670C185034B970A09067F68F17D8FAC801AC31
          44C64204FDFDBD7C68642FA3BB3F42FF402F2AE0510CC2ECC41F286EE94F1BD0
          DD5D07ECEAE35853C4AA09081101517AF339F4C63566265E4B82DB0872C66023
          9BECB1D61261B196849D993F4DD071BB44DF4037AE5E47BC6F0B0000C9A458C2
          01940092E434DCB16B80E9B3BFE2FD975EC428695063FE0B20321855A67FFF62
          B26F78D710EEF66D7CBD0609ABBEAD141B09F7B76818A8A462641B35EEDF5DA0
          F2DA79DE3E7592B9B7DEC22D2CF0EB179EC69717985D5ABFFDCD532C4CBCC2E8
          C74630F545E24A39B9D6C71E71EB5042541306C29F0A1585948D541DDD3C5B86
          F234A4C9F59FFF84A9C5F416CD75446CC8773354EC253F38446B7E86B85C46D5
          A31EAC3AC46BFB2614017192D61E83A8646B0F02463CADF97F93EBEC645B314F
          B4B380EDC88180C44DDCE222D5E95B48A309806A38551559D771AC9A9D8000E9
          1C4A1074DF288938F97A15B484A2CBFE9018347C56323F28BAAEC3485553C190
          805C04F51EBC40F069F849050917425898503E02200163C25DC05A4AA8806BAA
          CED5EBB582B511E27C680B100921510D411435800F97673E35088A110504052A
          B598A673F3400CC8DD0008D0B85AAB7DC38A3E13195308B02E5E9CC684AC31E9
          FBF20C03CDC16F08E5828C0DAFCC4D55174E02F5BB01D02C8FFAF337AEFE0E38
          0F74049DE05D82F13F3E2F4A96792D0058EBC9C80355A0119AF2037E2A76A156
          6BF580664185FF9F29CBEC3F94BD8A08EBE2DD460000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F40000001974455874536F6674776172650041646F626520496D616765526561
          647971C9653C00000014744558745469746C65004C6F6F6B75703B5365617263
          683B70F2E8420000076949444154785EAD970D6C95D519C77FE7BD9F2D6DA154
          6E01DB21747CC814B08D9F2C658A06C9E27033195B48368DDB12B739B3497406
          75199B0B5B489645A7335BE6B6B805D88259984AC449646E330814D016A4C285
          16412CA5DFF7EB3DCF396BCFBBF7CD4D0B699C3BC9739FF39E7373FFFFE77FFE
          E7B97995B516A514EBBEFD3300FEF8D4438A6028FEFFC396E731EC38D188C03D
          20E6F224443EC2BE050C202ECA48840A8440B13BBFFAC8CA8ACAEA2794E7B504
          3461D9AD9F25644C441F2C36C8E57BD6CDC312836740B47F60A0E783479F7C70
          CDAB80066CB90211817465CD1F3EE83A9DD9F8F87D5CF5A9263EC270C0971ADD
          E7479AB7EDE177C015808475C4C701C4C066441778A7FD3853A65581F550CA60
          AD87350685C57A0A0C80C50498D871951831E0010654CC231DF710914C804989
          604C50408D815C7BD30D1C683FE1426BCDE29577E01B13C94DF911A002A9A3E5
          F28FF0281429A5C9E50A11CEC5080028630D4B972E7280D65A8ABECFAAD679F8
          263AE33047A026423780C26021D02AFA7E4F5F8E6C572F21F8A508608D65B850
          E0D8F1D300944A255A5A97531A4700C6A9A108DDE8E6365A08D2D4EA34C96462
          5202CA18E364175F030A199B5B8B481948286E388F9E55388BC043D6BE782413
          21DCA509380F685F103100C8D8DC58B4B1449894E5E0DE85D60B45402997238F
          886731D1025CD28446C411D0A2518018416B1009EB74FA928C41D253C415C4DC
          5200AE2D6803250379B1281428F0C522622635A1ABC8D7DA490FA0B520C6040A
          0416635A2A460CCB859E3E067A87C80DE5C98F144857A6A99892A2AAB692E999
          5A52098F81A2412C88225060720F08BA5842B43809B5F65DF55A0C1E303DED51
          181921DBDE4D4D4582EB9734D2306B2A89780C5F0BA7CF0EB0EF703747BA7A69
          983F8BAAEA4AFAF2500A7B4339985278E3098816060606D1BE464423BEB8EA7D
          11AA138C82E778EF50966B16CDE433CBE7B36DCF31EE7AF4056EFECE9FF8FC86
          EDFCE58D4EB7BE64413DC7DA8E33D4374855C2309CF711132910E68904ACB594
          8A2586FA07F14B1A11C1174302B05638D1D1CD8A6BE7A16331EEDDF412A97482
          8DDFBC85ED9BD7B2E12B9F46815B57A92437DF389FB7F71E259F2B1053062352
          4E80179FB87DA20945C4C9AF4B2586B526EE79AEFA2931C585B37D64A655503F
          731A0FFF78078FDCDBCAD59FCC38DF1863993FF732EA47F7978CAE6D7AFEDFFC
          FAA1D5CCA8A9A4ABB38BC60573DD319613F8C5FEEBF026362271CE37D660B466
          6478987C41E359A1F75C1F4B16CD62EBEBEF71DB8D4D11B8F3886F9C61F345CD
          9CCC54562C6DE4D9BFB6717DCB5C4E7676BBDF8A14080263D5454C2806D11A2B
          82058CD1686D28950CC3033966656A389C6DE77B6B9B5DD522C6EDFBBE6664A4
          44D1177C6DB86EF1E5FC7CDB5ED6DDB698DE9E7E447C44CC251B912ABB058E80
          31061C01EB428BA154F04926E3F48F02555524DD9AF68562515328F8F4F5E710
          B1CEDD359529F2459F4422416E7818D1E202F0266DC5A28D3B022C8E886FC69E
          2D25ED3BB09ACA24EDC7CED134A7CEED0F0D15E91FCC63C4029048C4E819CC51
          5B95666034FB5A632C88319377426B02A6560C16B063E0025A2C2AA138D9DDCB
          B27997F166FB198C8EBA1B61338EC53C127168CF9EE7AA518F741E3F437A4A0A
          2D3812E504AAE3F989261477E78D93DD1AEB94106B29689832B58ADDFF3CC217
          5B9B683BD1E3AA44053D428BB8792C063DFD393AB21F726BF35C76BDF616B3E6
          CC242F8219D78ABF3CE3D58926B4EE8BBE030608AE180C160D750D19F6EE7A8B
          8E8E533CBCF65A366DD94B73533D0B1A6AA9AB49D33754A0FD642FEF9EEE65CD
          F2851C7EBB9377DFCDD2B8F013A43C45666A8AB2E1FCE35DB4158B60AD71E13C
          612CFD05415482852DF379FAB99D74BF7792A7EE5F89F23C5E69EBE2973B0EB1
          FBD0FB181477AF5ACA91431D6CDDF60AF7ACBB8564C167DF3FF633B33615FACE
          E18A6F2EFE772CC111000424B058AB38332C5C3EBD8E6B56B4F0FB3FBFCEDF77
          1FE20B772EE78E1BAE0062947C9FA347B33CF3F4164E75BDCF752D5792AEACE2
          BE6F7C8E677FFB12A7FAFB002A4212A2AD4C306170ED020500E7030948392376
          0F407D26C3AA2FADE6685B3B4F3EF7377ACE9C8F5C5897A96566633D8D89060E
          1ECC327B7683C3BB6B4D33B1D7BE4FC3EDF3BEFEA39D273601A5BB9F7FC78C57
          C03AD76B03C646B7401C0900285ACBA93EA13A95A069D952AE6CBE1AD1BEBBA6
          0A85E72972BEA522E1D1F6C63E5EDCF92F6AE2FDFC6ADD79663CF01388FFF0BB
          4945EEB1974F6C06CA096001ADC5EFCD1772755E2C86688D52C18EC5B8ECE656
          3158807E6300101B7784510A94AB825AE2B4ACB88154DCB0FAC32DF49E6B2271
          602BADDFFA01A5C2631B366A3BF0F8AEEC33E5040C50181EEC5D8FB59B95F2EA
          C2B79B9D3BF683F341F416E448385228826780681FAC62765D9A3999D9BCD9BF
          1AAF631700A8ADDCF4B5F51C3B78FF43C06FE265D50B903F7E64CF76E0652011
          BA95BD2FFC2FEF836A7F9013407A7D6BE33D7E31FB40A9284CBB308C163374B1
          562CC00850084DC9C71B2A08129BF774FF346E1BCF9EEAEE5CAF6DE770F642E1
          41A014BD9C4E5EDDC72701A4828C058A63F11FE0E1BFBACB68F7350000000049
          454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F40000001974455874536F6674776172650041646F626520496D616765526561
          647971C9653C00000020744558745469746C650046756E6374696F6E3B4D6174
          68656D61746963733B547269673B44EE2D9C000005C449444154785EB5974F68
          5CD715C67FF7BD99912C5B4ADC2AA2925D47B65468E2E22A0EC6EDD26D217549
          D64D1BBA28DD64D14DC1ED2A904249562D5924902E0A2DA12585826B28B485A6
          24508C695D1B376A63599622D58E1D591E4933D2FC7DEFDE736AEEBBBC61341A
          0643FA89CBE571CFCCF9CE77BE7B46CFA82AC618BE7D6E8E4746F7F3E6CB170D
          190C9F3CB4B383AA522060A8540CC98980D8EF03883CC4B90202B8B072123981
          5FBE7AD900F10B3F78FAAB23A3A557A2C83C4DC0E3C70E76956054C11814C528
          A831A09D88BDE09C5EAD6E345FFAD90FDF7B07B0041476318D1F247FCB14D289
          179F7F9DE9A9391E06AA4A3FDC599F3F79FEDD977F054C03AE47818058E364A2
          566B737D6901D549D0086304D50815C1D71D19100045B4B76E03881388000113
          470C173E8313990839937E0A1815E5F0D42497E67FE117C0B1D983681F755501
          B35B7DDD15AF14A3296CE2F23C7B112010E0CCE9B338712860D384B9133358B5
          A01ABE3AEC7956CDCE1460778C824279EB3EEFDC5FCD4DDB8F004E8546BBCECA
          DDFF608034B11C9EB558491FEEB299204FC02363E3080C2460C429CEA5887300
          587138BF6CBF44DD7B6E02BA6025CD7C010C2020586B7D5200E73C01BF873BD7
          9351C9D16B879C408215C943FA9A5054716AB38480B359F54ED29E42AF5D5DE5
          1F7F5F6665E53EA01C3DFA18A74ECFF2D4C9E95D321154958126A49524A469EA
          136BAE80C5765A40D2B65C387F85F9F9DB7C71EE18AFBDF85DE2B8C86F2F5CE0
          8F7FBECACDA57B3CFBDC094A43859CAD8D52DA49DAA34044374CBDD1C2DAD4F7
          5E9C973EF7805FCEF1F66F2EB170E30E476726F8DE0BDF84E20EDBE94D9E3D7B
          9A898947B97DE7DE0382D710D7F95C62DB341B4D067BC00A959D4DEF83088375
          3EB1DF3170E383355656D739383EC253278E93980A95FA472882A1C9F49129FE
          BDB0CCDDB532ABCB350E4D975060BBF131D669AE40D8B547015548D336D5ED0A
          A9CD2AB6BE05A957E6CAE55BEC1B29111762668E1DA6D1DAC2BA04E7ACDF6767
          C769372D8562C4B57FFD172850DE59A36D1B8848FF16E49310C53AE7935777AA
          B49324B42123B251AE512C15505146470BD4D36A46D0A55EA5913168B72CA270
          BFBC453D69D0B62D9C0A2A3A7810A9808AA00AA242B35963A755C118C5989846
          33616C78D89FFFE4D5B7A86EB410EDDCCC0818FBD410224A2B6953307118948A
          288347B1A87A036A18BB2A90DA84665A238E6286474A003EC12B3FFE3EFB8687
          702280226AA935EABCF6C6DBFEFCC0C83006932517E93B88BA8CA18A974A5577
          8DFAAC358F8D1F60B352C318C3FBCBFFA4B0BF8A2010E2EFDD6952D968307670
          DF83D847BDF482A22A88E8E06BA80E6F28154041085F00A80A4F9C98204D9C27
          B9B4B04E14151095AC4A940FAFEF80C9AA3E7EFC08D6B54114F10460B009155C
          F080782500D5D012987CBCC4A1A9714461F1C61AB812464181A4E958B95EA158
          8C993D7A88CF4E8FB1936CE7E445079B105411975544F080232362505A698333
          67A7B9FCB77D2C2EDEE62F176E72EA6BE3BEC2BFFEFE36EDD472FAD4E779E699
          93545A1FD14EEA00592B64E0280E0AE40408AC152FB00F809ADDE4CB5F996266
          6692F9F757F8DDCF176934523EF7E4385FFFCE9778E2C9C3946BB7A834CAE172
          E4861E3C0951CFB623BD686E42931D23E2D8AAAF7160723FDF98F902CF7FEB0C
          C54289D4256C37CBDCDAF880C4D6BBFE65918173205720B4203846BB9662FC02
          059A498D565A63ADBA4CE0DB1751F0D1A09FE39C401EAB9ABB3CCA1E33590D40
          78CED9831ABF774150C428A23AB005AAE2250E0402EB00513A904E294A784F80
          AEF82E62DD1E307B5D4305ACB3BA51ADD689E31800C574FD4580518331F81562
          D0BC4FD9336A7C5C2048F9E31636D54D2005642F050468ED6CA6E73E5C5AFFA9
          89F4D3C193FCE1D78B9993D574EA5283FAD27A34CC08E491EA8988C846E55EEB
          4740732F020A38A0B970B1721EF81350EC28B4FEF0EF83DD9050792327D0E7CD
          C80175A04530E527FC566CF346F5B6203F3080F0FF83D201FF03696A1FB1945F
          FA0E0000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F40000001974455874536F6674776172650041646F626520496D616765526561
          647971C9653C0000001E744558745469746C65004D6F726546756E6374696F6E
          733B46756E6374696F6E733B28E6FB6E0000056249444154785EAD974F8B6557
          15C57FFBD51FD38931C64E95A2824D230E54143B601CA9D023413251F1238803
          C1488283E0C0413B33823873203113719269F00F1A471A4C148CC4685494A4DB
          5455ECD7555DF5EADD7BF65E967773DDD4E53D68D45DEFD539750EC55A7BADBD
          F77DCF9EFFF6A751C0A7AEFDCAC830FE7FA167BFF5497DE2919F03B0B7B7C734
          36259D813F67C00CD818D63B207207F701B433F000048815613B3B3B066C3CF5
          A50F5DBDEFEEED6B1BD8839840C6BDEF7C33199A2EB541E3AB7E61B488176ECE
          978F7FEEDA733F05DAFEFEFE4A029BC040E0AD17B6BFFFCF570F773FFC85EF70
          DFA5F7279054EBFA4068228D717AF0CA95F8F1D79E6CAD5D5E2E9702820CFDF2
          898FEB635FF945122063E36F7FBDB1BBCDDD1C1E1D333B59A000C9F116783806
          C4246BA6BAAAA8983DC062E1BB5DD7DDD3F7FD0CF0D19633F0D1168D0A9887D8
          7AFB05FEF0C34711102EDE7DF922B70F6E12CB0E91B6DC9FB614D87A5B30E027
          5FBFF2FA684BEFF1C2FEADE5E39FF9C6AF075B4A0130023EFAF067C13B3C826E
          79CA2B3F7B861B2F1FF0D023DF65E7030F7187B1D23633E3F8D5DF5CE1E9479F
          042E019E0A64A008DAF288DBD77F8F87581C9FF2D2EFFEC4992DCCE7876CDC3A
          0219664232246108998D59A315B61820E56676CF7BF1A6DDEC36EC9C02EE10EE
          7817B884F7C243BC69F72E7EFBD4974779F9E047DE4501EA1C9AC6F360625392
          E62D9758768D6A758A8024A26FC8038508EF51C0D5CF3F8C5A0F88E87ADEF1E0
          55F09351364094EFCA151131EE23DF128737AEF3E28FFE5CE2541B6211A0C1FF
          1EB9F01669CBE290C3BFBF8804DE75ECBCEF3DA83F264325BD81A9C8A8E4CF40
          DCFBC0DBC6039B2A803CF03ED07F2C703C185489CEC1186C5134904FDA510586
          C810015812CCFB68C857133024A27578737C20E3C845F4390B80612FCFB73162
          6B328A5405A1BA09C1CC1BBE8E803732EBBE114D78970A78EB706F982022D2F7
          F0CC6E8456655A244A1D61A0544F11AB0928C4F2F611D10B57E011550B7D1040
          EB03DC51786537ED80FA039B2A3310D0BA2214DEF59CFE7B146F6F0E7223117D
          9724068B5A827B2B6084A9F619CA9751FE4BA9DC1A0BF00120883EE8964B168B
          863B03A9D6370C882E50940218D505024C098451F68CB484BC9F12B073A338BA
          4684B2FD7A47214E6F1DE17D00D05AD6803C32F3D2A1C6EF540D8D6BE0A72784
          AFA981E622DC89083C844710215AD758CC176C5FD8C49BC01B92178880693708
          A8164CE95BCF6C6B563530259016B5F43A9473217D1FAC591C75F840B2817B02
          5A0280B0C23D37AAE50D7912564429302D420DA05924398A8100EF530910AD0B
          D42F897E992ECFAC044005EC4263CB961558A4C5AB8B30C86C5D48814278D902
          6258332B4FC066557880D503A86CA933A420D64F42080FE4A30529AF5AF6AE92
          00848382C40A2AC1F2DF5039516D9A1DB48E800894FD5E24223D4FD6A0013BE5
          3D1F021598266722B7A4822B0908272D08A12C183CB2F5D404B351EAB1B705B2
          0445804D27215215A7015683882AC2BC7777EDCD6F1EEF6ECD0C1BAF05CA7940
          15A64A7A13A8402B778A04651104B1E25910C0E2B5453C162FFDE3099B71D15D
          9CB420C82294345A83082455C1A9604CD50D1865C1F8514E8E829504963FF8CB
          C9D3C03392B6DD7DABEBBAFBBF7879E379B5B10D41993DA6B223C1AC80EBF990
          4431201278964A4295C58C8C069C00F38838E8FB7EFF8CC0EBCDB5BF3F5F60E3
          8FE5BFD4B3CEC8433019CA2D9677988D67060607AFCD691E7B402B05CAA600E2
          F4F4D4CE083477B7EB0B7F4C2FCFBF399B715189CAEC7BCF42F95CABA02E46C5
          AA0B0C68AE37FEF8C6F2AB992C0E60AB3EBF0396E4B80BB8006CD5F884FFF24B
          AB801E58140162937551B62CFF07E08AF2DD6B0FFF02612724EFF7AC425A0000
          000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F40000001974455874536F6674776172650041646F626520496D616765526561
          647971C9653C00000017744558745469746C6500537461746973746963616C3B
          426F6F6B3B85C21BF30000059949444154785EC5574D685DD513FF9DFBDE4B93
          34A9362D5D2852AB0B45856A6344FAC72EACA0207E800B177E14EA0708D2D6B4
          96F64FDB85D0524AD58A228862255591EA4229820B574A5D585217DA8D50C5B4
          8B7E24FD7CC97B79F7CC8C77CE5C0E875CC3A36E1C98CCCC7DE7BEDF9CDF9999
          F3E200E09957F7E1B3F7B6AA9F01A8056BE2308F5CC3E702800150A9A25A4802
          60B6F6E4BAED6BFBFA0777BB2C1B16D8D2BB1F7A14B037CC8640AD984D3F13F3
          C5028B15D5E7C72F9F3FB3E3DDCD4F7C0FC0A709D4D3047AFB178D9D9938BDEC
          8D5DAFE0AE3B6FC5B58802CF27A726A7571DFE019F00B83961214D0030EA6519
          F9367E3B71120BAF1F002483730C29AC30C3412099334221E01253E670CEC476
          880CB85A86DE7A06225A56E275605261C029C8C8EAFB71FCC41F41BDF7B863ED
          63C89923DD488F00CEA88E8FD33F52BA0E0B9CC7CC4C3BE2541330712C8C952B
          6F57C040E96C9EE3E135B714713CE3684B171CD13924C40A6B5CC5F5E72FCEE0
          CF892944F0791280B0A0D96EE3F793A743DCE97430BCE67FE8240998CC61C3C5
          DA0EBEC40766AE1BEC454F4FA36B028E9903ED947B0D41EA8B80280129C98D7E
          8C0D34E99548574E197A1A116AFE044413C809440C15529F05BED004335A0B8C
          7218F9161AFDB1462813707C00CC5B844C1412F0E4C3036282F70051B9CFF20B
          23B669527066CDB55821735216B96B1142942EA5BD5015EF95013606ACF102D5
          B669311F5202A767143D63C0C118E85E03043FDB01790A20DEE761F79ED23694
          74E7412D118648B51DD5D69D8089BBD780025FBE7C055E8BD0590DF850036502
          0AE4CA4CD284E248A84E4575C933881306CC4AB50845D02918B87AE90A7A17F6
          8388909376463CE3C841E99636398224B659C2E8A9393073F722544065C1773A
          687A8F7A9685DDE75EAAED17A9D74022332206CFC2C8730E710DCE8AB0FB2022
          105378199E315D24D29A251049095A19C795B1CC9050F5CC128F22A7CC18E83A
          8A89430708510062F6F09ED1CA192A9973700E18E8C970C3A23AFA1A2E82707A
          41CDA9815A062C1EB949AFC31E000B029873B91452573FED024DA0CC16CC1294
          285019E5B6A50D1C3F7A02972E4C270CC07C27D6A15265EBFF7B8F4C4818709D
          1FF7ED7C6AAD925319C5E4D98E40002E6700B1418804046422B834D5C4AED71E
          C1BF911DFBBE7DA0643F9F731D5B110AB10132C73990EE84F4B908EAB50C332D
          02323B0293907CE4354386FEBE5A58E78531D8DF488712322442AC05C4564085
          B21810312C91E04BFC5C85A504170367C9C028540CBE99FF85F50717078BB235
          C1FF9C80132230E50AAC1A1633C51D834A9F95A158E5B6164E30D0D70896A1B1
          C37401BAF5CB614C9DF5D876F85EB4FD04209897011BC544106155AB01B229E6
          49424C6AC554C5B31A059BC0BA0F86D02A6CC62ED82D5F0CE3EC198FFDCF1DC3
          B9B339B616B1628BC496AC5EC76447A0B12581927220A1DDD81123B5003B85CD
          9FAEC2E4648ED143C378EBD9718C16F154111F58FF0B86162EC79BCF1FC3A68F
          2D0116C3AB4C426B3B630025205952E90F126381ADD55A741AA363F714601E07
          5E1CC7A68FEEC3A6B111050FF1D0C072050C766CC305B0C4FAA93020CA002BA7
          71C7463F3122BAD8C252818D0787716192F0CECBE3583AB0026FBFF033367E38
          82032F596C1B61EB9400A25A4D40ECFACFA75AED992559AD1606928BF70B97C8
          A561895F3475AE53801FC3D2826661606870050E8D9E834A1C680032D6980AAD
          832B09D89A76F3CAD41688EC772E5B22C609BE3B32AE8E01C2406F7C7085750A
          039FBF3E192C43D59C2C8EE6105A6C156347106B20BD9F2D99BE521BE1BD8AC4
          B5831B767DF5EBEE6D8F5B814A7AC3C744E1E02C7143893FD176EEFD06EFEF79
          7A48442EA6354000A69589CAAD5595E6CCF4D59FB6EFF97A7589183BC242171F
          0A4CD215B3ADE65100392A2031EE2A3500BDB0DB2DBB86FFA0A5D459002D1121
          A754FD97F2375648B4FECE9C5CEA0000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F40000001974455874536F6674776172650041646F626520496D616765526561
          647971C9653C00000017744558745469746C6500496E666F726D6174696F6E3B
          426F6F6B3BAC8D1D31000006BD49444154785EA5976D8C945715C77FF799D9DD
          01965D58D8852D0517B6BB80402A50A4556AA16D4220C8075A5B950F462389F2
          454D1A93466A8C2989B59AF6437D89A14D25B16A34C40F80D4D6A0A508DA7629
          5A901717585E775984591666679EE7DE736CEE4DE7662064219EE4E43C739F3B
          F33FE7DCDFC9CD188037BF731F8F6E7ED7000990F33198E1167607EF1510C005
          470155D5281022B95F6D5CF0C8C4C6BACDF9C42C5614D430F1AE46BCA9A23E42
          0C505DD4F8189E0CE13794CC6ACFC56265D3E79E7BEF4DC0C604200F31819671
          755BCF1EBBDCF6D0D3AFD23A6F297762AACAADECFAB9F717B1EDA957818ED885
          6079A2E57A4FF4B715AF28C70FFF9B6B133A40138C1154135424D49418100045
          6ABA112B1127900002269750C84FC359690B7AA444ABE98071A24C9F3399737F
          7EDE3B0AF3174EABB655556BD4F4A375890B0A21AA09D128C5313348D454756A
          1388665460F9938F81CD50149766DCBDF8417025BCA95073D8AA407091104182
          6BDC77B5FF1CA7FF712932778B045011B29161864E7F802AD834A3BDBB1DCDAE
          47E2D0A06BC04411C2124414B41AC74F9E84318C9A8071022E73B854C080CB14
          150BEA62D52146B1288440E044C140750AD459542229B73E02A74866112B00A8
          B5A873DEBD2054DB1E51D00884C6371293F3458868ECC0AD21047129D6590CE0
          9C80FA45048855C54A6312910D25001813C850A7A342E837B94CD04C10C0660E
          9C43C5C5EA6E9C80F801137744488D0905888ECE00AAB84A05671DAA8AD8208E
          B35118C5687C8E62A08678FEAAD5A849767B0C380723C3D7B199C5603C902AC1
          AB98A3B1BB46BD00985AE86AD3432AA55A0642D49B2114C596534A4365EAC7D6
          636D60409D84CA6BC10BE2377643635754144D534C1DA8BB0D084514710E9B5A
          3F0D9A24E02CAA2E8A285188DA0B2A82A92082D834EC1387131995019C6A387F
          A758204D5324AB7810035051C0DC7C235613549BA122A856E71B95D1A7C020F8
          CA03B1EA13516791B41C3698044D4C00CC0018D0208453DF29931F47AEB90B53
          68C1D43703A0B644F3CC02F0F7AAF8CF7E73006342022642A87EF64504141F3D
          C52204F8A40A5E6432C2968CEF449BE672E8621383FD0D5C2E17009858A85068
          1A47E7EC3D4DBD47DF2F027CFDF30B7969EB3B3740A820D606784202200E5408
          5A42642D9EBF3186FCD4FBE92FB7B3E7E064A6DDDDCEDCF92D4C6D6D04A07FF0
          1ABDA72FB3E11B2FBCDE7FAE77C38B9BBFFA17638CFBF196BD5A03A106089140
          2CEAB54307A2DD702728242D0B383134953D27A7B26AF96C264D6EA2E744916D
          07FA4095FBBA2671FF9299DC33A3A563E7EEBA5DDFFEFE6B4FFEF0BB5FFC439A
          66AE1642010910C619AFCEB6829A201AEF3EA86F66A47E266FBC379EF5EBE671
          6A185ED97E82D606E5CB0F77327E6C3DCFFDFE10BB0E0EB266F1541E5F3D2FF7
          CA6F4B5B9EF8D2A6FD4F6F5C7E3E219A41F153103A111C7F1CE22348802E9C8F
          77336E3A3D2712BA67B5734DEBD879609091918CAEF6661A0BF5F41C19E452B1
          4C9A3AB6ED3B4F314D58307BCA84F6E9733600B91A06C493EF05828BA278C108
          5C1C7C8C8236B472F42C3CB66E1A7FFCD7252AE50C11E5776FF7F1F2CE239E8F
          A6A6B114340746D9F1EE004F7C721A6FFDEDF067811FDC3C86B67A711060144F
          673C0EC098782BE6C670B128B44E6AA46F60804AC53252CEF8C4C726B06CC11C
          BAEE9AC8969D87397866885C2EC7A9F3C3B4B6CCC05AD70124374328E28523F5
          C448EC84AFDE8404D34AEA13BC70FE2AA92AE284F1339B99F5A1B8059FD0B5E1
          14142AF99CDF5BA96400264F3415C0D99880481047043526C018810948D8110A
          B9840B0345A63437F0C1C921AC75ECD87392B59FBE078072D97275A8EC3BD031
          B3D1EF2D954A67014D08A6E1FAD7FF16874A24B90430DEAB754BA81AEF8A8A01
          052D0DD0DD6E3F3CD323AC58D886CD9C07B9A12EC13ABC17EAF364A9C566C2A3
          8BA7F8BDC3C54B3B009B279800E50B25F7943976E947896112A160723FDD4D38
          81201C51088C14269C64CAB2C779EDAF3D3CB3B49B45DDCDECFDE700EB57DD8B
          0370B0F2814E76EDEBE381796D74B526FCF2173D43FF39BAFF65C09AC8007960
          4C70EA8064F4FF83F1BB8B3EB57EEDDCF94B9FFFD6C635C9E92B86ED7BCF70FC
          CC1510E89CDEC49A651D74B4282FFC64BBF49D3AF695B7DF78E9D7401613889E
          8BCFB76D0668B877E91756B44EE97E71F5CA2533563C388FAECE76008EF75E60
          F79E43ECFCD33B7D972F9EFC66CFBEADAF03E595EB9E55334A75DC6112756DED
          1F9F3C6BCEC35FCBE7C72CC9D7372C00C5A6E961978DECEF3DBAFBE7172F1C1A
          043255D547D67E0FA3AAFC3FF6D0EA6740E3C25BBB9E4D80BAE0E408E6800CC8
          3EB36A9310243106FE07A712A6ED900E36D80000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F40000001974455874536F6674776172650041646F626520496D616765526561
          647971C9653C00000019744558745469746C6500436F6D7061746962696C6974
          793B426F6F6B3B274B845D0000062749444154785EC5976F885D4719C67F73EE
          DD9BCD6EB7BB989AB5DD6DD298B2246D93D884DA62FF42A5824592821F842AE2
          C756095235B52855443FB48815F4830A2D4548852CF8072B2D28466BC112D344
          4C6B4A6D9A75B34DD3A46BDCBDFBE7DE73E67D1F49F69C7BF664B3EC7EF38539
          F3CE0CF7CE33EFF3CC733801E0C12F3DC9FE1FEF0B4002D4F21E20B05CAC7E5D
          80039637019254D92000B53D9F7FECDEB53D7DDF0B49B24B00828F7CFC7E008A
          1F14F342794FB9A6855CF940F9BAC5ECC8D4B933DFFCD15776FF01888B01D417
          03E8EEB9F2E767C627D67FE7F187B8E9C6CDAC3E4012CBC5A9F767771E788967
          81EBCA2A5001005003ADB7D8E2B5D74FD03B7005282104474A903B01A1248003
          081700A8CA096E0E09E0106A09DDF504335B9FEF975246A50241EEDCF2B1DB38
          F2FADB175B8C911BEEFD14997BA7DC2CA6800052675E9587F234B02644E6E65A
          9D7DAA00CA082E67C78E2D64EE48A29D657CE2AE0F9379C971D1E7295E247220
          E03930210A56CE9D9FE3E4F8640180E500201733AD166F9E9800204D5376DD75
          3B69150040B51A85D62514409D0940D0DFD74DA3D1B52280E0EEC418B12C0201
          BB904B9841F53F55E6804A14A80A0F24324B6874955B2D0B40EEC4CC307300EC
          42EE22BA2A1A5055FE85F45031444874346289F0CE042C2B4237BB08205A2400
          E6468C60569C33547810A0B22655411668026426CC7C451122892C462C460062
          34CC9D5868000785FCD05AC851BE7195775122B1002EAD4603466CA758342488
          31C34C447350F5B4450E0510475A7A1D11D48370F3953560D1989A9A266611C2
          8206A28B58F880020A025105545AC2125794C0A263AE4BAD5F4B452891B6539A
          FF9DA6BBB70733233327C6926300A18A27404901E538F712A7510BB8FBCA2234
          332C1A314D9989917A9210DDC9A2965EBF4EE901A953190984703959E6485023
          60E6AB3122C3DC70394467364D996F1B6615C6AB765CB5651C91997057878ACC
          12DC7D15566C8EC588CC10E01E89D199CF1C80240442A02431805C0830139230
          89BE46C2507F0D9778673A92C6E210651C7B6213DB1E3D491D088B6F81C558A0
          C55D179B99576D5839C700155A209133921E66E8E5C770026BAFFF36FFACDF8A
          5729C02C5CDE8A2D3A2E0781E71E60F929A59277B8CCD57431DC0BEBDE7E86EB
          BEF0475060FEC0C35C3DB21333AB0050BCECEB784184324780DC4B1F2879AF8A
          B1A49FB575B1A1F97B866EDE03B189CF4F307CE376CE8CBF4816872B005C4B35
          80B9C8CCF17CD5E5988479A1F44BC507251031DC6F5CF5C6287DF73CC3FD0F3C
          0C9EF2FC73FBB8FAE853A8F5696AB55ADDF2DA5BC6520A64865B86CB3B5CBB09
          F37CEC25E7BED84D243ED01D189C38C086BBBF8CDAEF333E710E009F3DC3C6DB
          EEE1F6937FE1E0957DBDCDE64C8831127D392B36437220D78039E64282501A10
          203CAF7D12C4B58D193E94BE4AF7E067B0C9C36C1F590780E6CFD23330C87D9B
          5EE6E0D6ABB6FEF9984D349BCD365AE6756C2505488E23DC4B9101D0311D4180
          0DFD7506C69F63F8EEBD68FE349A7D87EDD70F2080F6143E3DC6A68FDEC283C7
          4FEDFDC744FB6F2184D918D11211BA0BF7B202726139A882FF828A227ABB021F
          F477B9B6EB348DFEF5C4B37F85D862C7C800788AA6C770CF68AC1D64E7CD2377
          7EF2CDEC8EDF1C89BF7663FE520A24773C3AB8CA5BE0B9081195A70292D8D8DF
          60E0F8D30CEFDE8B37C7D0EC6988336C1B6A43AB8932C0C1FEF306C337DD90DC
          F7DAD8D7FF74A2FDCAE746E7FE7DEA07780140408C964DCEB7E6D625B51A1623
          A1A37A07E5798996C1BE3A7D53C7D834D447E293D8F8EFD0DC2404E7A127FE05
          82D16F6C0604AD8CDA9AF3ECD8B575DBEEB7FEFEC0FE43733F03660A000EB466
          A627BF8AF4FD10927585BA5FFCEDAB8050F9158414687425ECB96303BDEF3ECD
          E0671FC1CEBD82CD9D25B89044572DE4744590A825C2A7C6B866F39670EBC6DA
          17F71F62B40020C080F913C75FFA25F002D00524001CFAD5B2DF83879FEDE97B
          E16B9B47D53EBF857496E48A619003E217DFBD8624180870477212C066CE9204
          5F0324976AC08059A055889215A25EAF4F1D7D6BEA87CDA7BEF5138F42B989B9
          09BF98FB42EE207764422E8E36F553606A3100E52D00CEEA237DF260DC1FC2E4
          F3407EAA252D14FD85C80FF81ED0040892F87FC6FF00D726C05DF3F90F110000
          000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F40000000F744558745469746C6500536F72743B4173633B1714349B0000079E
          49444154785E95570B5055C719DE73CFB96F5020628C40A98F2A4629448508DA
          A01614C2C48E6D1EA66D123B19756C8699B4D3D6B1AD139B36A1758C8D4E2671
          92B4433B89D34EDA525BABA39854447C81228A8FA4542344BD11795CB817EE3D
          F7EC6EFF7FDDF59CAB45DB1DBED9BBAFFFFBFEC79E73D038E7C4D9344D23FF4F
          C3F3F3AA7FF95FD78EED5E7FCBD8C355AFDA441CFF3839B6E7C7C4B80781765B
          CF9DDC80BB112B60433256BCF415A016E4EAF45D05B8149C0224689208CE6F97
          A5ADA8F943ADA6E93FA28C92AE8B97BA8FEE5E3FF9F8DE9FD0A28A9F2B117715
          A021F1AB1F2CD8AF1B5A994B8709C96399AC71FD13CD1530B49C6920D2ECF1BD
          3F15672965D58C5262B80DEAF5F872F2177CAFF0CCA15FB7B5346C6073CA3702
          FFBD05E89A8B94AD5EFA5A92736FFCBDA60CD74414142DE3CE2868954F6FFEA2
          1937679AB1F88D406AB0D317F4CD73F57BAB61AD1DC0386578EA9E2910051A35
          AF90AEE821519CE3030540A604DA8DE324A075FF46E1BD37905E3D121D2623D1
          48ABE126E77D5EFF3C976654C2DA2600658C7125D88586111BEA4AC80D20EA89
          1CB205C03E46980831E30C217EAB020B0D7D28CE3246014CCDEB40B6221A8990
          68A4EF6874A8F7B0CBE5226E8FB728FB4B5599C879AAF1171ADA425E97ED0591
          04EC96004631509450240070661146ED087039C0909EFCE865216AEEC2B59960
          AB68241A2543FDD79AFED5BEA705C451AF3FA0A7A64FAA94E903E7048F2D808A
          A8500145C01807A0E7288211CA29CED9EB52ACF41EA1DF37617A25A54C0FA6A4
          0E745DF8EBC7DD9D4D66C28C75F87C7E08B70705B86F0AA0760DA8421261B1D3
          AB5982D422945241C9384640159B18CBE839C2AF7BAB304D63D3D3D32A9EDCF2
          1997B7C330001EDF228F2FDD67C6FAE31D47368B4A9402A4B71C891C4568E13C
          08906A29B3922240E5E3E07453AD28BED4B46C9FA6198B077AFB407402798906
          F91F9B962E6ADEEB0BA6654DA95A72E9EC8E7A3C9E14014A310596B2ADD222BC
          B49885D3D027601F71A4C8248EA6E797AC2CA5164D0BF75D277DD7CF2CB9D2B9
          07AF1DCF995A96FDE0DC15AD20C065B8838FC2DC2E400240550D6068D1534128
          9B462D26BC1600660B7B8BDBEB30763EB8FCFE8CA5B1D8084998239F03791BCC
          4510DD9D8D5D0933DEE6F17888E10E2C42C795134E01488EA1B3092811A41645
          A0F726A1CE1440449C6D7070B07CB0AF17F71D86610C604AC46E7CDEBD2BDCDF
          8B541373A62D9F017D72115A40C6C02097E408F016C38C02702808A9650BB06C
          011C872DFB37163B9E927100936BE6E9E6D73643BF0DC7521C4B12C02823164F
          90BCFBBFAD3953A0228093092064B6006DD603CF632F2624E9888C2A97507BA9
          8A88636FD22DD0B6AF3B0510E4089CD729E5C24B4BE61AD383736ADDF65EC26E
          AE515EE94C927301550CD2985B11CBDE6F592000F34EE52DA07180E009C87396
          349A50DE5DFAD6D74C4EB898C59E73D9534A7A2E7593F9AD1D5E790ED6B82DE0
          990DF947749D14E0C80510CF784B4440845EE398024BCCADFCD9AC4F91030D70
          86B5C0DB77BC72AE14BD1BBA7E4385058D10FFD83142612C3C44E28C5E53D151
          30D4DE4FCFF5ADCE2BCC6A5CF9F4E33E8FDB0D934C6C08C7427805650A4CF2CC
          371F231E3D28DE0DF1789C6CFF6D7DECC2C9D05AC9C9BEDCD08C1EEA92C8D85C
          5490B7E4FE714DE181B03B34927849F129688E14F82A9ECB5DF550F1A42DF9C5
          F79181E190B0A169761A4518644853BC19E4686337696DFE6CDD899D3DDB6175
          5855B6C3A6B7E5D1C57F3107C2E57DE1A1638F9DFDA41C83A1EA40A580CB09B3
          E17797EB0C8FFED50913C7540732FD2496884A628D68482B85780D3FE9BE3844
          4EB75EDD0DE4BF49BA727673FD6D61493584A9BC7F30423B22D175AA66EAA74F
          E1CB3FFE7752B572B9183B77A4F7C58307CE870C36464C524645115AA2A722EF
          34E626071A3E095D3C31F87D79F51200BE7BE63425402F1D97913A5ED76BFBFB
          C264206EBEB7FEF29593928327281BFD330C9052543DE1EBCFBD5440DF395CC5
          7FD530876F12982DFAED8796F06FFC702A9DB130FD71204A553769E78CA94E1B
          C18647E66DFBA87836FFE3B4C9D79EC848C7452FC0B563722E797FD217EC6F49
          D52AD74C5106DC80B4054F65BDFE83374BF9B6038FF0DABD858002BEF59F5FE1
          2FBC5EC8672F1BB7154832001E55207F9A365945D4573B33AFE8E0FC87CD3F43
          A837E54C7C019D52421175B9D9770A58BA4A18D094115F8AF1C0A267734ED6D6
          2FBA19857D73F8CB1F94F292A726B479027A1610F99D9FEC4EF10D25733FDC35
          2B8FBF9D9BDD0AE3F180A0146BA8334A80CBF94152DFBE5A3DA112B18835D875
          76E8BB4DFB2E473C705E273E72B0A13B7AF54264AD394CC3F2C1C3EB8E2EE74E
          016FE73FB8CCCDC8627CB7B58CC46B51A84CD55829C46DDF3E5B3DA9F8CE24B2
          A6A64C94F293B3EBD4E338F85055E6B3338B33B76221761CEF7DF1CCBEDEDFCB
          D7ACF56EF332AE114A9E9FFF8F5BB9DF3BA7B01D7EE472F5A50E3F1880033AAF
          F7909A50280D66A300CAA119CE7F2EDEDC7640F4CE974BDB9E9EF73D41BD9471
          4680FC3DBCEF728DBCB5A5D9B99F2306060673394176C12005C86BC65892D372
          306AD31C79F5C839535D39C4287B03B2D76FE360F2FCB0ECB98CC0A88D3B482D
          6544AD8DB217C5456C4177ECE177BE0DEFDEF828C4A3EE5562FF47BBE43FB68D
          6FBE514051710000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F400000010744558745469746C6500536F72743B446573633BD715AB4E000007
          B149444154785EAD570D7054D5153EF7BDFDCD0F0692604B6010508C684CA8A4
          8508C6417E9246B1DA32F2232D1D5B2A6353DA4E8BA52552154DDB91F0335498
          161CDBB1564587D2561C8C1DA031244E02040960310442082C4936BB9B64B37F
          EFDED33D9777F31E9B9982333D3367EEDC7BF7BEF39DEF3BF7BC7D0CFEFF76C3
          67367DED5E2CFEE45340C41BFE98A58C0896218C34CD7496725699483A37CF22
          0170FC8FE09AF21400E45CCD53C06AE7973F9A4040198A464473E41C7ACE77C2
          FDCDAD6E0030CCB316800D7F2E01A603E81A40D5D223F2612FEF99FD91EE60A5
          9A2E11C88719717178DDE2FAF9F49017DF2A01C111B800786145830431D0DD6B
          21630CBCB78C92694743031013FC8A4C48991D00A1AC7CB4464EAA6016C5D399
          06A5AB166EBA8EF3EDFFA82CA53D62E1E98A6AE42860CB3B3F1FA6F8DEDA7A37
          ED9B811CAF1417E62FB835A72E140C397D91C406856D040021A912C02CC91869
          148E77C1C5F0C7C01883B1698580C2D255986A20A0C22794440A44696EF6C681
          BEA0B33F1CFB64D999B6BFAA1AB074B610988F141600413321AB55A0904EA054
          912105175267656873EDEF0FCEAA80586C5EA07F90B70E869F35B5177BEF9C82
          232540C2703D03820350102E38C909280C10DC620005070E42824F31BD24674C
          E6585DAF0EF40521188BBFB1AEA3EB982ABE04172325E032134E712D8A890141
          991312061C39AD59FBA4071AF6F8CC64D5F5FCB4A955430343B705C243BE7DFE
          E0460088D39137274FC404E73042021416CDA6314308E06800E7C402052206AC
          6834E720142805C0597D77FE3437C7A703A1107444A21BF7F4057C4AFB65ED1D
          2C21521950D922B7B70D8606AD1B520232026167400A205951C165E179668CCA
          F84D7F28E4F4476347D7765EDEA36A42855AD9710946F401CE490243B1AB6491
          591AC290CB864800B167491427C6242B2AFB3F144C5BE41430770841344562D5
          00E0358373538668D2138A788B018E3253A6590C704350D6E4349540B881D6BE
          6484C3B6352D4A7BE74497EB05C33020CDEDD116E7E5BDBB78DC381048C921B4
          75F740A5CF9745604C073B00992D705B000E32A8C10D93A53870BB04C408F2EB
          AE6030D83F1101E58C238D68F6186250A8B3236BC0E044690250159364008966
          1300BB16D0B000902402841D40EC8973ED638809B31EEC01854D826B4818B333
          20C0C004E4DFFA24B34BA018A0C50405B400B07BBEFC143B7E693B7EEFA502DC
          F5AB93606A3BA8F6EDD9A674494C2D42B6F3D996A4CBE0CC5CD73947CA32E94A
          022A42F39C99E1F4F13FC494366CDC000099D5096DD7C7A9029BA3D730100CD2
          9D9BB780C7922ECFA6D139D55ACDCC63B6ECD892CAB75E664C5F4B857DB1FD7C
          67E3FE759369BF78FE8BA85E7ECDB5CF590056541534E83A14D24C63521FA29B
          1890D43324090CB9B6F2F97B2E5018440414540B78E2CD974ECF2230AA1B722E
          2A04E7E0703AB8DBE5995030FB2745273FDE7CBCA9B64ADC37EFD7C32F1087A2
          E3C2E9BE55F9457987572EFD96C7E5740EBF9442519FEC84EA16AC58F608B8F4
          7479FD62B118EC7C6D6FF4B363BED5765ACB96BE725B3C16BF3B1E8DF5A665A6
          B779D23D33B580BB02004E1048E44A0DAB0678DD7B5DA73D198E5FEE3BB0BFA6
          E0ABD9101CF25122C09855C897826701F0ACA42FC33D061A0F77C285B6DE0DA7
          0E064E99729069EEB4D11591F01044C283CD0E279CF1B8BD3335E6280380DF51
          2C21AC57A866ABCC78ED9F3A5E3FD972F1FD9E4B0970EA5EE0E60D900D888A91
          7330040787E686CEF601F8B4F9F2FEA3FB7A769BFA0B256732D892F0E0208407
          FB1AC303FE239AA681D3E52E1E7F47792EC56C39BC910914C300C056BDD1D30D
          FE1FFFFBD0199F438C928B54449C40C8914BDD79D409876ACFFADA8FF6FF1400
          22B6D60A331E5C9D8B08C5917018060257EA3E3FF141931082BBBD697AE6E849
          65669133147600168878476BC8D7D536F04CDDBFCE890C771605562024235E67
          261C3CD026AEB40F555E3D17B94C676CF75ACFFED29D659C0B3D3D233378F1B3
          BFFDA7B3AD2E9E88475B3D1E2F68CC45009CD70070B8CECA7E3045894D3FC89A
          FD44DE969FBD5A82DB0E3D80D5078A925E885B0FCEC167B614E15716E56C0500
          EA782E3A53BC384725E32D5FBEE3BD87BFF31A3EFCEDDDD22B5690EFC2F2E57F
          C4C239BF08B83CA373148811FF074CE32445F3FB577F7BB4B1F37838A083A6E9
          A03307847A391C6BF0B5B47E14A0628AA8C26BDAD32BAF5E66D6780F638EB941
          7F1FF87BBAC1DFDD0D017F2F7559299DDB939E9537A57C81EA3FD2952D786A12
          EC3DB1CAFE5E4F9F725FD6CCAFAF9E3CB0B9F601DCF4E1FD386FD584C1898519
          3301204369F97AE363EA8CBBA47C7DC5C2253BB1A0642DE6DD5E3E1F00C6263D
          77C2EDA5D3172ED9C1E73C528377147DFF0D00186581306DFE7727C1BBC756C2
          3B49B74B31BD3CF7474F6E98864BD74FC58205D96B0060B4A27057FD22D85D5F
          314CFF438FD76C2BFDC666CC9F51497798A84E33FF0F64CF7D7C4BF343DFDC8E
          7715AFE922F9940C960488F0EAB643B063EB41BB1491E31FF4FCE5F3537D6FB7
          9D09BE7DF2433FA11F32F760474D3DFC7E530328EBEFEF9FD7DFE7A78675C47C
          EBC54D8FF65EEDFC6728E0A763E3264C7DEC2EB809636666EEA4679AEE4EF954
          53A61823696EA1D19C6B297B634C06BD4AC29BFD38554C0945582A8014479B2B
          D3529E438EEC0B7E72E317F82CC79BD9FF2FAD9579A3A208465D000000004945
          4E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F40000001974455874536F6674776172650041646F626520496D616765526561
          647971C9653C00000012744558745469746C650053707265616473686565743B
          98672309000004EB49444154785EA5575D88555514FED6FD99C6293063D0221D
          33829E7A8889D2A29909FA7D90ACB42104097AC8E8A9281F26A32290B4603242
          147C31AA317262B287620C462C43222328E8A15E8A7EC6401912E7FEECBDD72A
          16FBECB5EFB970736CC1619FB3CFDA6B7DEB5B3FE75E12112C558808512AF122
          BD96260C807B027860F30E01895A2EAB7D36FD46054075F781B96315A23180A0
          B654192602886E90AE7103CC7C7CE2E9BBEFA9A1A7A8327518883E62C415028D
          3DFBC408962A7BF61F1F0350E909A0931D2EC04328012016010B109841F1BDE1
          CB1821A4F3B52A818555A937032210A3D46E3A70A507D595E88C44943130C523
          0212538CC151CD0AAA5BEE7DE819CC7E34891EA20CA87929221575C05695719B
          B25A003802AF657A5D48248458E9253152C1CCB64180406900E912558DB40422
          02A00240551D95C01C3BFAD60080CBBA9D835360A28E62BA2C07C2E6DAB6E3AA
          EA9C18A84D4E6F9CA52A468BDC48963329DA28DD03DEF18989AD9FDE0FA0C2C2
          989A396D559649EA4A4A68537C2C480C54CF9D6D8C6E1FDF9910C7B5B862341C
          73CDD87FF8F511051F03796CD3309CE714A10227EB24B27CE87E5FB58257F7CE
          2606AADE31581CCE5DF8091C9D4E4DCFE0975F7FC7DA35D7E2D187374248A707
          AE1AB801DEA5DA60E18231AB7846CE776255851890AAD68ED540088CC00E4EDA
          10E5469FB1EFA56FB1EBE07D70A119A317386EC0FB0440580A66F259A7D04094
          CD126BC6984EEB828AF301EDD084F34D20F66F7001FDF51ABC670520607DE743
          0BC14B1A44C2926A03BA5A936830940A00226409CEDBD0FB00CF2DBC37F5C9BF
          B4CFABC2DAA155108146BB7BCF3B6A74F5EA9578F2F16BE09C47EC1C8EED9468
          26507A8E37111C8132782CD68615EF05E71B7F2070C0C15D3F40C0C9C88BDB3F
          07B80206E3E5B7C7F077731E21B03160F3D912D03D3C559323A0627E18032E60
          B1BD80C1C1E5D8B977249999DC7112136F8E262B57AF5A81863B9FD7003830DE
          9DFE3AFA4A83DFFAC9B210FB98623A9031A045D8C6F06DD7A15EBB51958F1CFE
          12C2A2D16E1EDFA0C6DAAE01EF5BF0590D3033B63E722B5AEDD019354500B697
          A4BFAF8A175E3B6A0C041FE0B885B3177E4B45E83DC7A113F0E7C2CF9038F256
          2E5F8760235A8B109AB4F2EF062B4A3228F1091D0C9032101C02FB543C6BD65D
          89E726D763E8FA15EA5020B10B9CB252088B7D8804994356AA7523BB05D05D03
          127C40DBB73178C5506AB775770EA2565D061716B1D03893E66A60871024111D
          015B54560B463B13C46642D71C68B71AE1C4FB874E8EA0DC4299D13CA3BEC55F
          00682B01AA50320ECA3F0D657A5484AD0D9B33FB7EDC14BF7A555301F27BB384
          109D3701D459A331DB620E2D21E9D9743967008007B088920CDF3EDE3CFDD507
          FD2520925D7511C1A10F4FD997AFF41DD0276BBB8C5963802DB26E5180DD42E9
          5BC0826D5BD663B1E9514E96A91A008260A0BF8EE75F390265402471D525C377
          8CE3E60D5B24B5572CA4EF4EE961646D684EE3ACB196E42C39140B346FC31E22
          B155B8B0CC65A496CB3C053696A9406D9D41D471AE37003D988B94119088D11B
          17A3DC9ADFDE17362F0E80D59C557949A5DC86B956DE1D91A2B42FB80800E08C
          DB6EE73980CB97D5EDA758398AB21860F9CF14A40196D5EA4DB73C88EFBFF9B8
          06C09F99FF6B6EDB5307EEC21225043707C0FD9F7FC71419EC0350CFFE3F504F
          5291EADA0168D770E922007C34D6BAC4F3FC0F95FAB06FAA13140A0000000049
          454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F40000001974455874536F6674776172650041646F626520496D616765526561
          647971C9653C00000012744558745469746C650053707265616473686565743B
          98672309000004EB49444154785EA5575D88555514FED6FD99C6293063D0221D
          33829E7A8889D2A29909FA7D90ACB42104097AC8E8A9281F26A32290B4603242
          147C31AA317262B287620C462C43222328E8A15E8A7EC6401912E7FEECBDD72A
          16FBECB5EFB970736CC1619FB3CFDA6B7DEB5B3FE75E12112C558808512AF122
          BD96260C807B027860F30E01895A2EAB7D36FD46054075F781B96315A23180A0
          B654192602886E90AE7103CC7C7CE2E9BBEFA9A1A7A8327518883E62C415028D
          3DFBC408962A7BF61F1F0350E909A0931D2EC04328012016010B109841F1BDE1
          CB1821A4F3B52A818555A937032210A3D46E3A70A507D595E88C44943130C523
          0212538CC151CD0AAA5BEE7DE819CC7E34891EA20CA87929221575C05695719B
          B25A003802AF657A5D48248458E9253152C1CCB64180406900E912558DB40422
          02A00240551D95C01C3BFAD60080CBBA9D835360A28E62BA2C07C2E6DAB6E3AA
          EA9C18A84D4E6F9CA52A468BDC48963329DA28DD03DEF18989AD9FDE0FA0C2C2
          989A396D559649EA4A4A68537C2C480C54CF9D6D8C6E1FDF9910C7B5B862341C
          73CDD87FF8F511051F03796CD3309CE714A10227EB24B27CE87E5FB58257F7CE
          2606AADE31581CCE5DF8091C9D4E4DCFE0975F7FC7DA35D7E2D187374248A707
          AE1AB801DEA5DA60E18231AB7846CE776255851890AAD68ED540088CC00E4EDA
          10E5469FB1EFA56FB1EBE07D70A119A317386EC0FB0440580A66F259A7D04094
          CD126BC6984EEB828AF301EDD084F34D20F66F7001FDF51ABC670520607DE743
          0BC14B1A44C2926A03BA5A936830940A00226409CEDBD0FB00CF2DBC37F5C9BF
          B4CFABC2DAA155108146BB7BCF3B6A74F5EA9578F2F16BE09C47EC1C8EED9468
          26507A8E37111C8132782CD68615EF05E71B7F2070C0C15D3F40C0C9C88BDB3F
          07B80206E3E5B7C7F077731E21B03160F3D912D03D3C559323A0627E18032E60
          B1BD80C1C1E5D8B977249999DC7112136F8E262B57AF5A81863B9FD7003830DE
          9DFE3AFA4A83DFFAC9B210FB98623A9031A045D8C6F06DD7A15EBB51958F1CFE
          12C2A2D16E1EDFA0C6DAAE01EF5BF0590D3033B63E722B5AEDD019354500B697
          A4BFAF8A175E3B6A0C041FE0B885B3177E4B45E83DC7A113F0E7C2CF9038F256
          2E5F8760235A8B109AB4F2EF062B4A3228F1091D0C9032101C02FB543C6BD65D
          89E726D763E8FA15EA5020B10B9CB252088B7D8804994356AA7523BB05D05D03
          127C40DBB73178C5506AB775770EA2565D061716B1D03893E66A60871024111D
          015B54560B463B13C46642D71C68B71AE1C4FB874E8EA0DC4299D13CA3BEC55F
          00682B01AA50320ECA3F0D657A5484AD0D9B33FB7EDC14BF7A555301F27BB384
          109D3701D459A331DB620E2D21E9D9743967008007B088920CDF3EDE3CFDD507
          FD2520925D7511C1A10F4FD997AFF41DD0276BBB8C5963802DB26E5180DD42E9
          5BC0826D5BD663B1E9514E96A91A008260A0BF8EE75F390265402471D525C377
          8CE3E60D5B24B5572CA4EF4EE961646D684EE3ACB196E42C39140B346FC31E22
          B155B8B0CC65A496CB3C053696A9406D9D41D471AE37003D988B94119088D11B
          17A3DC9ADFDE17362F0E80D59C557949A5DC86B956DE1D91A2B42FB80800E08C
          DB6EE73980CB97D5EDA758398AB21860F9CF14A40196D5EA4DB73C88EFBFF9B8
          06C09F99FF6B6EDB5307EEC21225043707C0FD9F7FC71419EC0350CFFE3F504F
          5291EADA0168D770E922007C34D6BAC4F3FC0F95FAB06FAA13140A0000000049
          454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F40000001974455874536F6674776172650041646F626520496D616765526561
          647971C9653C00000012744558745469746C650053707265616473686565743B
          98672309000004EB49444154785EA5575D88555514FED6FD99C6293063D0221D
          33829E7A8889D2A29909FA7D90ACB42104097AC8E8A9281F26A32290B4603242
          147C31AA317262B287620C462C43222328E8A15E8A7EC6401912E7FEECBDD72A
          16FBECB5EFB970736CC1619FB3CFDA6B7DEB5B3FE75E12112C558808512AF122
          BD96260C807B027860F30E01895A2EAB7D36FD46054075F781B96315A23180A0
          B654192602886E90AE7103CC7C7CE2E9BBEFA9A1A7A8327518883E62C415028D
          3DFBC408962A7BF61F1F0350E909A0931D2EC04328012016010B109841F1BDE1
          CB1821A4F3B52A818555A937032210A3D46E3A70A507D595E88C44943130C523
          0212538CC151CD0AAA5BEE7DE819CC7E34891EA20CA87929221575C05695719B
          B25A003802AF657A5D48248458E9253152C1CCB64180406900E912558DB40422
          02A00240551D95C01C3BFAD60080CBBA9D835360A28E62BA2C07C2E6DAB6E3AA
          EA9C18A84D4E6F9CA52A468BDC48963329DA28DD03DEF18989AD9FDE0FA0C2C2
          989A396D559649EA4A4A68537C2C480C54CF9D6D8C6E1FDF9910C7B5B862341C
          73CDD87FF8F511051F03796CD3309CE714A10227EB24B27CE87E5FB58257F7CE
          2606AADE31581CCE5DF8091C9D4E4DCFE0975F7FC7DA35D7E2D187374248A707
          AE1AB801DEA5DA60E18231AB7846CE776255851890AAD68ED540088CC00E4EDA
          10E5469FB1EFA56FB1EBE07D70A119A317386EC0FB0440580A66F259A7D04094
          CD126BC6984EEB828AF301EDD084F34D20F66F7001FDF51ABC670520607DE743
          0BC14B1A44C2926A03BA5A936830940A00226409CEDBD0FB00CF2DBC37F5C9BF
          B4CFABC2DAA155108146BB7BCF3B6A74F5EA9578F2F16BE09C47EC1C8EED9468
          26507A8E37111C8132782CD68615EF05E71B7F2070C0C15D3F40C0C9C88BDB3F
          07B80206E3E5B7C7F077731E21B03160F3D912D03D3C559323A0627E18032E60
          B1BD80C1C1E5D8B977249999DC7112136F8E262B57AF5A81863B9FD7003830DE
          9DFE3AFA4A83DFFAC9B210FB98623A9031A045D8C6F06DD7A15EBB51958F1CFE
          12C2A2D16E1EDFA0C6DAAE01EF5BF0590D3033B63E722B5AEDD019354500B697
          A4BFAF8A175E3B6A0C041FE0B885B3177E4B45E83DC7A113F0E7C2CF9038F256
          2E5F8760235A8B109AB4F2EF062B4A3228F1091D0C9032101C02FB543C6BD65D
          89E726D763E8FA15EA5020B10B9CB252088B7D8804994356AA7523BB05D05D03
          127C40DBB73178C5506AB775770EA2565D061716B1D03893E66A60871024111D
          015B54560B463B13C46642D71C68B71AE1C4FB874E8EA0DC4299D13CA3BEC55F
          00682B01AA50320ECA3F0D657A5484AD0D9B33FB7EDC14BF7A555301F27BB384
          109D3701D459A331DB620E2D21E9D9743967008007B088920CDF3EDE3CFDD507
          FD2520925D7511C1A10F4FD997AFF41DD0276BBB8C5963802DB26E5180DD42E9
          5BC0826D5BD663B1E9514E96A91A008260A0BF8EE75F390265402471D525C377
          8CE3E60D5B24B5572CA4EF4EE961646D684EE3ACB196E42C39140B346FC31E22
          B155B8B0CC65A496CB3C053696A9406D9D41D471AE37003D988B94119088D11B
          17A3DC9ADFDE17362F0E80D59C557949A5DC86B956DE1D91A2B42FB80800E08C
          DB6EE73980CB97D5EDA758398AB21860F9CF14A40196D5EA4DB73C88EFBFF9B8
          06C09F99FF6B6EDB5307EEC21225043707C0FD9F7FC71419EC0350CFFE3F504F
          5291EADA0168D770E922007C34D6BAC4F3FC0F95FAB06FAA13140A0000000049
          454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F40000001974455874536F6674776172650041646F626520496D616765526561
          647971C9653C0000001A744558745469746C650053707265616473686565743B
          556E67726F75703B8F582F1B0000056D49444154785EA5576D6C1545177ECEBD
          B7A57CF6252F14D008582A888280A84191521315881F503E428C0911FEA9BF6A
          A226FA474342C4A02231A9A41AA3311A050C90680C10281595101B209580E547
          0D886D69497F48EFDDBB1FE778F77666CFDDA5B97C7892CD6467E7CC79CE33E7
          99992511C1CD1A11C158CA3C649E9B310E9FB20056AC7D4D400202901CF6E39E
          6D61E0F4D69D470EA6881A008288606830D40490620785ADED0033B7BEF1F2E3
          4F6450C68C37C52630314CC6290235346DAA578F58744513791930DB76B63684
          FE6501C4D9610B1E42110062190A193083CC770DC88A8124F2CFA4011606002A
          CF80082446A9D8468DF545C82C15015404260053C40C890E34C951460BEA5A7B
          B2B10907BEFB0065ACC800201029CD94C049D285B41600B0019EB1E3B4559320
          B0959E34B17ECCAC1D14B643349065031223CD80B000C80248AB9C14CCC1FD3B
          460118314C708E121340C42E97AE81B086D66E559308470C643ADE7AFD403A9D
          5A6A1DA2369290594FF3EEF941DB839BB72F0F41B330BEDEDB0ED59F5AA44A52
          B4363F16440CA4BDFEECD2191B9FC68DDAE9E6DDF521709BC873AB16C2F3D964
          68CB409544960203A6329DC2E60F0F440CA43D270FAF6F00FD67CEE27CEB29FC
          BF760A6A17CD8998E83A7E063D9D1731B37E3E6AEE9B0D77D0B1B5C1C29623AD
          7886F26D37A8287706241DD50E15D7DDCD3A087239F4745CC4BC8F3E4666C112
          9C3D74029CCDA2F3703B52F31EC582E6165C3AF92782C12CF20A8058585510B6
          76D1582C03AA100B448AFDBA97BB4E1E5C0030BAE67FC89EF91DD356376254C3
          53F8F5DBC318B16439A6AF598D5C4707C6D65417C7798E635543C2B65680D282
          8482002C3821B07E53197A8E8BDCF94E4C9E3E11177ED80B21C2D4679EC5B8D9
          F7A2BAAE16578EFD8CFEFDBB307DEE5464CF9D4338DE2887593335C4536C17D5
          AC09A492B440A8C84008C0EBEBC7405B1B6AAA1927DFDD0AB7E76F8C9F595B68
          BBD1BE650B268F4F61A0F528DCDECB21006540F7678828E5CABA32C00A0CCCAC
          0CB88E0BF67C049E878ED6D3B8FD85975039790A9CEECB185168EFD8B009A73E
          DD81BA495548FBBE05108207078C2FF79CB08A2FDDA3F4F0228BC1C88304A232
          44CACFE721818FAEEE2CC6AEDB88DA35ABD07DE8303ADF7B1F7735BD52786F84
          FBCF559CFFAA05B3C754C373950166C6F36B1E42DE0DE247061900DA17595565
          1A6FBEB31FCA40DE45E0FB181C04E62C5B864BFBBE47EF172D9873CF0474356F
          47BE107CDA8AE5B8D4F2098403F8792F5281B0187A87B93788C112834256102A
          433FEF423C1FB57513716CF55AF47ED68C69B78D44EEAF0B983AA50A7D85F7B6
          958DA89B3501F03CF8AE0F6BAC320B5BDD451910D3C9D0EFC3D580F8791FEC07
          1837A60A8B57CC4790CBC2EDBF828AB163208E8319774FC2ACFBEF2CF4F5C1CF
          7A087C2F22DA4CA859692D28ED4C10B2C12D1895A17BD5CDB71D3DDA558FA850
          9227D905ED8720C7FC53E83744802464670024EF1112AB4F889E86709A7AFE58
          654EBD74E258A6614EC2C004770054B0526F636AC0C4550ED0B15CCA00001F40
          16095BF8C87AA7FD976FAA1240441F5488083EDF755C4FBEE439008022D9A989
          2803AC990D6B2EAE35322A1066C186758B9075FCB2175311D5C0A8AA0ABCFAF6
          EE2106A474B1930C2C5E8F050FAF93485EA6904E1D1F7286CA50839ABD4625C9
          BA382023569561F95BB1910ADB99398154D732BE047AFFB3A855194431BFEB5E
          CB25DE934440224AAF6994728A8F97D8E1744300AC9BE693ACA5840CE3A34AD5
          6129D24DE9060080A1DC5E1BBC14C0E891157A158B432CF7D323D75D02B26345
          499EFBC04A74FCB62FF4F57B7B2E1FD9F0E2CEC770931604DE1100DE7FF93B26
          C36025800AFD7F00952555FF8C3D006E06B76E02C03793E56FD19FFF05E2E5AA
          05902803EC0000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F40000001974455874536F6674776172650041646F626520496D616765526561
          647971C9653C0000001A744558745469746C650053707265616473686565743B
          556E67726F75703B8F582F1B0000056D49444154785EA5576D6C1545177ECEBD
          B7A57CF6252F14D008582A888280A84191521315881F503E428C0911FEA9BF6A
          A226FA474342C4A02231A9A41AA3311A050C90680C10281595101B209580E547
          0D886D69497F48EFDDBB1FE778F77666CFDDA5B97C7892CD6467E7CC79CE33E7
          99992511C1CD1A11C158CA3C649E9B310E9FB20056AC7D4D400202901CF6E39E
          6D61E0F4D69D470EA6881A008288606830D40490620785ADED0033B7BEF1F2E3
          4F6450C68C37C52630314CC6290235346DAA578F58744513791930DB76B63684
          FE6501C4D9610B1E42110062190A193083CC770DC88A8124F2CFA4011606002A
          CF80082446A9D8468DF545C82C15015404260053C40C890E34C951460BEA5A7B
          B2B10907BEFB0065ACC800201029CD94C049D285B41600B0019EB1E3B4559320
          B0959E34B17ECCAC1D14B643349065031223CD80B000C80248AB9C14CCC1FD3B
          460118314C708E121340C42E97AE81B086D66E559308470C643ADE7AFD403A9D
          5A6A1DA2369290594FF3EEF941DB839BB72F0F41B330BEDEDB0ED59F5AA44A52
          B4363F16440CA4BDFEECD2191B9FC68DDAE9E6DDF521709BC873AB16C2F3D964
          68CB409544960203A6329DC2E60F0F440CA43D270FAF6F00FD67CEE27CEB29FC
          BF760A6A17CD8998E83A7E063D9D1731B37E3E6AEE9B0D77D0B1B5C1C29623AD
          7886F26D37A8287706241DD50E15D7DDCD3A087239F4745CC4BC8F3E4666C112
          9C3D74029CCDA2F3703B52F31EC582E6165C3AF92782C12CF20A8058585510B6
          76D1582C03AA100B448AFDBA97BB4E1E5C0030BAE67FC89EF91DD356376254C3
          53F8F5DBC318B16439A6AF598D5C4707C6D65417C7798E635543C2B65680D282
          8482002C3821B07E53197A8E8BDCF94E4C9E3E11177ED80B21C2D4679EC5B8D9
          F7A2BAAE16578EFD8CFEFDBB307DEE5464CF9D4338DE2887593335C4536C17D5
          AC09A492B440A8C84008C0EBEBC7405B1B6AAA1927DFDD0AB7E76F8C9F595B68
          BBD1BE650B268F4F61A0F528DCDECB21006540F7678828E5CABA32C00A0CCCAC
          0CB88E0BF67C049E878ED6D3B8FD85975039790A9CEECB185168EFD8B009A73E
          DD81BA495548FBBE05108207078C2FF79CB08A2FDDA3F4F0228BC1C88304A232
          44CACFE721818FAEEE2CC6AEDB88DA35ABD07DE8303ADF7B1F7735BD52786F84
          FBCF559CFFAA05B3C754C373950166C6F36B1E42DE0DE247061900DA17595565
          1A6FBEB31FCA40DE45E0FB181C04E62C5B864BFBBE47EF172D9873CF0474356F
          47BE107CDA8AE5B8D4F2098403F8792F5281B0187A87B93788C112834256102A
          433FEF423C1FB57513716CF55AF47ED68C69B78D44EEAF0B983AA50A7D85F7B6
          958DA89B3501F03CF8AE0F6BAC320B5BDD451910D3C9D0EFC3D580F8791FEC07
          1837A60A8B57CC4790CBC2EDBF828AB163208E8319774FC2ACFBEF2CF4F5C1CF
          7A087C2F22DA4CA859692D28ED4C10B2C12D1895A17BD5CDB71D3DDA558FA850
          9227D905ED8720C7FC53E83744802464670024EF1112AB4F889E86709A7AFE58
          654EBD74E258A6614EC2C004770054B0526F636AC0C4550ED0B15CCA00001F40
          16095BF8C87AA7FD976FAA1240441F5488083EDF755C4FBEE439008022D9A989
          2803AC990D6B2EAE35322A1066C186758B9075FCB2175311D5C0A8AA0ABCFAF6
          EE2106A474B1930C2C5E8F050FAF93485EA6904E1D1F7286CA50839ABD4625C9
          BA382023569561F95BB1910ADB99398154D732BE047AFFB3A855194431BFEB5E
          CB25DE934440224AAF6994728A8F97D8E1744300AC9BE693ACA5840CE3A34AD5
          6129D24DE9060080A1DC5E1BBC14C0E891157A158B432CF7D323D75D02B26345
          499EFBC04A74FCB62FF4F57B7B2E1FD9F0E2CEC770931604DE1100DE7FF93B26
          C36025800AFD7F00952555FF8C3D006E06B76E02C03793E56FD19FFF05E2E5AA
          05902803EC0000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F40000001974455874536F6674776172650041646F626520496D616765526561
          647971C9653C0000001A744558745469746C650053707265616473686565743B
          556E67726F75703B8F582F1B0000056D49444154785EA5576D6C1545177ECEBD
          B7A57CF6252F14D008582A888280A84191521315881F503E428C0911FEA9BF6A
          A226FA474342C4A02231A9A41AA3311A050C90680C10281595101B209580E547
          0D886D69497F48EFDDBB1FE778F77666CFDDA5B97C7892CD6467E7CC79CE33E7
          99992511C1CD1A11C158CA3C649E9B310E9FB20056AC7D4D400202901CF6E39E
          6D61E0F4D69D470EA6881A008288606830D40490620785ADED0033B7BEF1F2E3
          4F6450C68C37C52630314CC6290235346DAA578F58744513791930DB76B63684
          FE6501C4D9610B1E42110062190A193083CC770DC88A8124F2CFA4011606002A
          CF80082446A9D8468DF545C82C15015404260053C40C890E34C951460BEA5A7B
          B2B10907BEFB0065ACC800201029CD94C049D285B41600B0019EB1E3B4559320
          B0959E34B17ECCAC1D14B643349065031223CD80B000C80248AB9C14CCC1FD3B
          460118314C708E121340C42E97AE81B086D66E559308470C643ADE7AFD403A9D
          5A6A1DA2369290594FF3EEF941DB839BB72F0F41B330BEDEDB0ED59F5AA44A52
          B4363F16440CA4BDFEECD2191B9FC68DDAE9E6DDF521709BC873AB16C2F3D964
          68CB409544960203A6329DC2E60F0F440CA43D270FAF6F00FD67CEE27CEB29FC
          BF760A6A17CD8998E83A7E063D9D1731B37E3E6AEE9B0D77D0B1B5C1C29623AD
          7886F26D37A8287706241DD50E15D7DDCD3A087239F4745CC4BC8F3E4666C112
          9C3D74029CCDA2F3703B52F31EC582E6165C3AF92782C12CF20A8058585510B6
          76D1582C03AA100B448AFDBA97BB4E1E5C0030BAE67FC89EF91DD356376254C3
          53F8F5DBC318B16439A6AF598D5C4707C6D65417C7798E635543C2B65680D282
          8482002C3821B07E53197A8E8BDCF94E4C9E3E11177ED80B21C2D4679EC5B8D9
          F7A2BAAE16578EFD8CFEFDBB307DEE5464CF9D4338DE2887593335C4536C17D5
          AC09A492B440A8C84008C0EBEBC7405B1B6AAA1927DFDD0AB7E76F8C9F595B68
          BBD1BE650B268F4F61A0F528DCDECB21006540F7678828E5CABA32C00A0CCCAC
          0CB88E0BF67C049E878ED6D3B8FD85975039790A9CEECB185168EFD8B009A73E
          DD81BA495548FBBE05108207078C2FF79CB08A2FDDA3F4F0228BC1C88304A232
          44CACFE721818FAEEE2CC6AEDB88DA35ABD07DE8303ADF7B1F7735BD52786F84
          FBCF559CFFAA05B3C754C373950166C6F36B1E42DE0DE247061900DA17595565
          1A6FBEB31FCA40DE45E0FB181C04E62C5B864BFBBE47EF172D9873CF0474356F
          47BE107CDA8AE5B8D4F2098403F8792F5281B0187A87B93788C112834256102A
          433FEF423C1FB57513716CF55AF47ED68C69B78D44EEAF0B983AA50A7D85F7B6
          958DA89B3501F03CF8AE0F6BAC320B5BDD451910D3C9D0EFC3D580F8791FEC07
          1837A60A8B57CC4790CBC2EDBF828AB163208E8319774FC2ACFBEF2CF4F5C1CF
          7A087C2F22DA4CA859692D28ED4C10B2C12D1895A17BD5CDB71D3DDA558FA850
          9227D905ED8720C7FC53E83744802464670024EF1112AB4F889E86709A7AFE58
          654EBD74E258A6614EC2C004770054B0526F636AC0C4550ED0B15CCA00001F40
          16095BF8C87AA7FD976FAA1240441F5488083EDF755C4FBEE439008022D9A989
          2803AC990D6B2EAE35322A1066C186758B9075FCB2175311D5C0A8AA0ABCFAF6
          EE2106A474B1930C2C5E8F050FAF93485EA6904E1D1F7286CA50839ABD4625C9
          BA382023569561F95BB1910ADB99398154D732BE047AFFB3A855194431BFEB5E
          CB25DE934440224AAF6994728A8F97D8E1744300AC9BE693ACA5840CE3A34AD5
          6129D24DE9060080A1DC5E1BBC14C0E891157A158B432CF7D323D75D02B26345
          499EFBC04A74FCB62FF4F57B7B2E1FD9F0E2CEC770931604DE1100DE7FF93B26
          C36025800AFD7F00952555FF8C3D006E06B76E02C03793E56FD19FFF05E2E5AA
          05902803EC0000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F40000001974455874536F6674776172650041646F626520496D616765526561
          647971C9653C0000001C744558745469746C6500496E73657274436F6D6D656E
          743B436F6D6D656E743BC72A3AF20000058B49444154785EC5976D885DD51985
          9F7DEEDCF94C4C664C4C14A392286AD414158B8A5A6CF447BF34D02F440A6DA9
          3FD496DAFE288562929914A5148AE950FAA34D29524A2B88869018C940B54547
          9BC4243A49B499C90CD198A493D899A46672EFD9FB5D4E2EFBDCCD09030EA125
          6B78B9670FFBDEB5CE5AFB7D39C749E242A285F30787FE783F42488004505CAF
          06FA24008140D26A411F12C5BFAF79F4555A9C739C2F0EFEFE5E2481001C204C
          02A9171C92FA22FF6AA4DEC61A505369D901973E6787A5DFFB1B33E1BDDFDC45
          F76756F58EBFF5A203B1F0E607D71EDFB5916BBFB30110EF6EF82E5239020764
          A9662B62E67DC11B3D377C8EDA7FDE5F8B6BA17BF9DD1CDBFE3C95B9D7657E62
          97791F9A0EB8827CC7738FAD9CD7D5FE545671B7BAC2554006A09431E0242410
          A273C1D5848F3EE0D481BF8340F1EFBA879E44F5495C6B0FAA9D60FF73EB9BD6
          4B34E2B9E5A73BD6140E54BABBDA9E5D7CCBD71775F42C8984242439A5150897
          B543D6C698E6615347B872E54380C34E7F803F3986631421AEFFC60F716D0B18
          D9F657465F1DE8135A5344E0804A3833B5A87DFE25F8C937204C252A1CC828C1
          048E6463DB62AEB8E70B1CDCF66786FEF01396DD7113596B27AEDA8E0CE44F9F
          8D83775FD9CE91917FAF734E6B24471200AE76EA142847FEE3E480008492F734
          174A625C0820A3E3A24EDC258B80407E6218493809C508E75C3C979E33354B9D
          97BA005FCF91CF5108297C1C38810970A82076D61490B55FDA70E0C33736E24F
          8E72D98A15F88983C8D753DE51C0A5CB16D1D2D1B5E6E8BF464DA2AFD4056601
          0B75AC3E85AB5453D24AF9238764C9095C43F0E1C11738FCDA8B087178F74E40
          2CBFED72C09A436AE8CDC34845A4EA3509A0AF1080BC8179ECCC69C832B26A1B
          1456251B8948F184C0659FFDCA747D9902AFFFE2DBB8CE6EDE19D845ADE6B9F9
          AECBF13E70DFAF86E701A7B73DB1CC9F1B810B2614726CBAF010F21A594B952C
          AB2247CC32B5240E3011FE3BDAA8A888D60577E243E0C03F0FD075CD4ABA04C3
          7BFF81792BDA9EFB9F19715B1FBF4AE508BC070B28F898B3309F6312AE52C1B9
          0C1AE5CE5E27471490A9F95D9B5723F840B6F0366EFCE2D70078674B151BDF54
          1A5C2158A90B9019581D424052941549CC63A9F54A1144B54886033063C9ED5F
          62E9DD0F924F8E808C15AB1E66776D1218A3808540D9816098E5D1812440A5B6
          1392704D5AA258E11012E413C32CB96939F9C4814639A0D27131D5393D69F202
          16EC5C0121DA9843E9C74144C8D21C42581CCBB8749D7FF45E1464383904F8C9
          831C1FDE598AE0810D1F9604605E6039980748FD4B3A80F12E9B0E80210003A2
          E01828B2E41C218760CC84E480791472B090FA15413AFD6902CF3023A464154E
          895CA0E00921140E24941D3014EA71128A347B04317767421450ACB44CA2CA22
          CD72649AD901A2493E84A3C7C78617CFEF5E1CC9853FF93E055CDB1CB2D6B928
          8AC140CED25CC045BE10334D1D72E2D0117C1E8E011ED04C02F2FD23E34F1C3B
          F497FE0C160A78E007DF846008914D93BB4A07832FEFE1E8BEBDA0643B90D6A4
          DC0DC80003CC183F9EDB8F801C88AA293F9000AD40073077E3F76F1DFBFC23DF
          A276640F59EBD93BEF6270601F5B37BFDDBF7EFBD8D3E94E66F594A4B8BF1E2B
          00925472C0E20601554928E4B896F6460D6E1B9A261FFAF5FA1D63BDC014109A
          FE7E3A9438D04C11903610009319F89CACA583C181BDBCB4795F7FFFCE06F9C7
          D146317B3031F8A45E797613AB7EBB7B76EF053243AAF3FAC07EB66ED9DFDFFF
          D6D8DA827CE2CD9F5BD19EE543104AB2248B7B403E699E8D009389D75EDA5390
          F736C907D71AC1034258F45F918C5896C8D284FAF437A3E71FB9515FFDDD9080
          5C122F6FDAF5CC34F9BA82FC67775C6DBFFCF19FB861A9E37CD07951E7AC4EAC
          03AAB12314F3F680F13F46EA82995B26947CFC3FE282BF1D675C607C02932CB4
          0A9486C8DC0000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F40000001974455874536F6674776172650041646F626520496D616765526561
          647971C9653C0000001A744558745469746C650045646974436F6D6D656E743B
          436F6D6D656E743BCB728ECC0000078649444154785EC5970970556715C77FF7
          2D5948D28424245442C0183028EBD25007956AD5A9DAA162DB11ED68AD22C3D4
          62716D2DAD6D43A756D662EC62A90E20150C9B480BA1A12282444A0A252B2540
          02B421C1174A9297F7F2EEF21DDF2477C9239DE97446A767E6CC7D73EF7CDFEF
          9CFF39DF99F70544840FD3027CC816D0340DDB34F7F9FF31B11D0047F98007C5
          E7F80708427BFFEF08A000CB7EAA04051C784DC5BD3767A6A53CE9F36B3334F1
          4215052020E2A6A189200282A021CE27B0DFA104F15E6098D6F1CEAEE8D29B16
          6E782D51094F01FFF0B4E48D23A7DF999F9A3DDA5DE899243C65E87BDBF11E82
          9B7C247461BABFBA620330D65642AE55C06FF545F353B2F230BBFE0D56D443A1
          393278A604343C553C6900B9262E2125BD08AB2F9237B4BC5E005AACA707C440
          CC5E6F13019044809008511E4D8648609B1923168E30186E37BF5B024CDD40CC
          B85B96577C34D0C486688803D694C3F1600230B0465CB80201CB88C65DC749F6
          DCCF160E99039A5216CAD2517A14CD1F1C9A0902A221A23C25D0DC0695C1598B
          F296983A3E5F84E1E3E600BBFD80AF68E50B3E409A167F575C05C454A04C545F
          047C3E7CC1641890C90648A2AC5E29BC20FA0513401025283D86582681EC4272
          267C920377CD7B303329E90143A46CD6FA8A6513CAD72B57014B096219A8B863
          8265C4F00582F87C417763C183A1014A869C907EB0A9C7DD4413857FF8141836
          968E5D158C1A37F681A2453FA479D5F25F557DFD2BBE2FEED853E695C0344159
          8865BA0DA74C032582E6F7A3693EE877ADFFB7AB8858FD506FAD35F05A8440CE
          54B4CC8954EF3ACC88D6168AEE5F4277E54E0ABEFA2542CF6D7C78FBCD7334E7
          14204A81D2C1B2BC26D26C8832518947CF931EBB4145D91B090A8DA49C699039
          99AD95CDB4F7E671F72F56D0B5EB19C28D4D24F932C8983C89BA97B62DF514B0
          144A1976165E0092586B4404CDC56207EB4D441108E44E433227517DF010E742
          A35870CF673971EA1D32FB32292C18C7A195E57447752E4722CB070560D9321A
          90B03908DE5CF6E690A0B09B4E1394FDC19F3B13B2A6D0F6C64EC6A79E61CEA2
          5F5359739E2B57C3F8267F8E2D4F3EC2B0EE0867BABB57AEB9D2E9F600CA1450
          0628D33BDA08E036A093A5AB0028F7F88B807FC474246B326D353B49B69A29BC
          E57162E7CAC98DE4E1BBEE1636FCF9EFB4274DC0EC6B587DE84ACBE380EE29A0
          CC81EC95D30389671C04E5C213678488C4E133519953693BB68394387CCC97CB
          E86B7A16BDEB1413F267B26AF37ACEB768BCD550BBA6B3BDAE1F0E5883145088
          A5DB9350F0668F805D774DB96840ECA084405E2956D634DE797D2729C6293E7A
          EB32622DDB8985EAB0B266D2B0BD824FEB8AD7DB834F779EEF87F7016669D678
          15B069966959EDA1D63323B3868F74B333BB2FE298969C8E2F29C36D42145862
          11CC9E84993E81B78F6E27255A4FD16D4FD073722D46E729B4DC1BA8DFB69570
          5878EB5C786DD5F14B650E1C90FAE0189C008CA6B3FF59D271614BB90F460830
          77F137C05208822F0ED7FCA954EF3B497B63835D19A170F65C0A66E5103ABC81
          ECC0598AE7C5E135AB313B9B90FC599CDCBA8D9EDE38BCA5B7FCC1AA8E32200A
          1880DCFDD3F5B275E39FBC007E5C71FA6F401590B1EBBE19ADFED46CCCAB17F1
          25A5E30BC4E1AFD651F94A6DF9DA63AD4F0116E0A76275DA8B0BF6FEE4C6D28F
          2D2ABE6D195D475761861A91EB6FE4E45F76108EC0A996F0EF96FE23F43810B1
          EB2E871F2A917F062E70434E9B1B80723E02419181B1AC0552FABDBAAA3E0EAF
          FFEDDA9A5647421F90B67E41C98FA64F1BB368FCBC47B97A6405B18E26FCA34B
          39B1F9AFF4F4094DAD91671E3BD45936187EF0E7E3C4322C66EB1B09E65C2100
          70EDFF36510A4C6320F3FD0DEC7DA5B1BCFC8D56672380617FBCA7E4A1A91347
          DF37FEF647E93CB402BDA391606129C7B6BC4CB8171A5B23CF3D71F4DD3220EC
          C00F2C2912A57BC7DC301401861AA214223A47F63751B9A7A9BCFC78EB63365C
          80B4F2F99F7AA478CAD4C525777E932B077E837EB989E0D8528E6EA9A43722D4
          9F8F3CFF544DD760B87AEDDE3171B88520680299E96019F29E012851C2BFF69E
          74E04EFD2C2079C9E7C7CF1E999BBDF833F73F4BDBA6B9E86D8D048A6750BD79
          1FE1A846FD85E8EF579EE82E03BA8118A05E5D58209669B9133D2B1D3252C0B4
          3C05D8FE838972FBBA7A010C1161DFEE134FC7E1CB805EC004FC406A717EFEB7
          0B66DCC4E5D327889CAF2379DC34AA5F3A4038067517A32FACA9ED4980577EEF
          23A20C6F62666508D72583A983B23C0588C3B1B3ECBBE3C5FA0CE774D8708060
          4EFE98BCB7FDA36EBDEB0B5FA3A7A59A4BD9F3693DDC4CB714D0DCDABC6E6D43
          B80CE8B21B55EDF9CEF571B8B835CF4A1732921596019A02250C2981D8406F1C
          82D8D92717164FBF239CFB89D4E8A55ACEBE59CBE963C7E9BA1CE2DCE5CE75CF
          0FC0AF3AF097BF952FCA54EE2E59698ACC2401032C6F84BF770FE058E2AD2929
          29396DBE3FBD90EF3FBC19DA9BFA4A92C2FBCFBCDBBB69F7D9D041A0C7917DF7
          FC3C11252E3C330ECF082A4CC396C233DEF7766CDF1D05B0DE0D75946CFAC3F2
          662316DE110987B6EDD52397805E3B6B0350BF2C4993236FF6FECF6FC70A889C
          AEADCAB7D7E876B6BA77E7431EFCF830F9A0D7FDFF02A9D996082D4B94AE0000
          000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F40000001974455874536F6674776172650041646F626520496D616765526561
          647971C9653C0000001C744558745469746C650044656C657465436F6D6D656E
          743B436F6D6D656E743B69DE5518000005EA49444154785EED576B6C54451B7E
          E6EC6EBBBD4159ED855228285AEC5784B6918BA2218246FC612289F10789C688
          44D1464C8C3180052C81107F182844FD276A0821F01109220A48D4D602BDD91B
          DB16694B81000AB4A5ED6E77CF5C9C9D9DD3617751C20FC21FDFE4C94CE7E4BC
          CF33CF3BF36E0F1142E05E86857B1C24766EC6BB00A1A0C371DE6D486139B803
          11B7134B342997606A5430E176C8EBF7AC5C343ECDBBC9729132228C54C1B578
          21A1B31121D49F0202046A1E0DBD062E20CC026CCA1AAF0D06D72C5CB1F358AC
          13C601D784B4E4AF724B5FCA49F14DD684F1EE995124AE6BC00CC259E7085CED
          2B75D5EED90960AA7642C43BE062A3C11C6F6636E8E00980050D158863830117
          008171C558A326B1BA04BCE90F808D06B213CB6B0490D0D010206C083AA29398
          CC310402B124DCB089040B74D01042C301C490C79500341C219760CC141F4491
          2A9268B5B5101E5B22E1088ABE637A0B57EBCC0E4A8495008D0401847306CEC2
          E0E12088CB93B813451E49CE8D13207ADD714938E2CD2B340CCB0A8051FEEF0E
          08CA014EC147038065C1F224034489D50422D656530A23421916AD9DE0023C1C
          8260142489CA91C3C42D1C605C40301B5C021460760896DB23B578C6120B1832
          1055FF841BA28869588282384E449C652CBED989D812500A70A6143B078E531B
          5C0810970B8458800289CC8D23822952F3AE1C630FAF5A67FC9F4B40A2CA39C0
          C30063E610114DC22978DCD5D3D935A2678338E522C438263884BA5DB7290167
          1C9CDBDA012340C4D65A8973FC53A3AE39B15C70E72C80959A0F1EB880F0A55F
          016E4735338689739602F829098047821342848C9B05306DA30D98E466B37A37
          A60F0970A72D47C8273E8B1B277B11AC3B0AF7FC52F8CA16C33E77185C70787C
          73E0E9E842D7CA15FEEB81D1CFE77DF9552580908470048053A114CB89B9DA9A
          5ADBE9F47D7382C0D5E8C97E12FDD567E0A50CF9AFBE88EE7D87110A85903BF7
          39704ED1DFD487943FAFE1BEB796F9C6D7B5AEAE61D47AE2EB5D15006CE300A7
          6AF7CA052112EF3884E9C0F13D22752206ABBFC7FDAF3C0FBBAB11D31697A1E3
          40357A83A3484D4F83E7E215643F350B76673DD2F2EE471A71BD09E06325C038
          C0215858774273D0843E8844A9D4D40AC2F870A307AEC74BD0B9EB20A62F9A8D
          D0D90E142E998BD6FFFF2C097390B3B004217FA3AA60EBDEFDA86BE8ACD43F4A
          706B364619BB7CB5F78FDCCC09B963BBA337CEC309929C0E2B29431F42DD6509
          8F3A33701A93162C447798A265DF2F287A6636021D2D285AF218082108FC7E4A
          DD92A683A770A2B9FB83B517CF7D01C0BE5980ED3FFBD7AA2B7DBBAB2C204B00
          78A1FC65807165B725C9892B05B53F34E3F2E976981B61CC20AE3DF8DFD27204
          1F7E044DFB6B30F3E9220C35D48E95B2E9583B8E37F7547CD27F25421ED4BC46
          C07B7BBA0E00382291F1ED3B65BDAE141FE8C079B96BB973B724FFB11587BF6B
          A9DA5AD7BB190055B4B141B0BBDCBBB1B8E4F545738BD7850787C00687E14466
          FE14645DB705FAAFC08411C025C27AEE1122DA9689DBAB507BA44D92B76DDB5A
          DFBB41AB671222AEB5A66C9931EBB579B30BD71514E562C4DF6E9E0A60726101
          E68459E5A6904D5777B66C071090E01600C4FFDFA6BA22B5A33B3FDA8E4307DB
          AA34F988BEBFB676C1D6C0C66945CB4B0AA76C2978601C061AEA410341D41F6F
          4743F519351FF677604ABE17A50FE66DAE2898510E20593B901811014284F1DB
          513F0E1FF2575535F6AED7E4F6C0C98D5C5F4F0565EFFC759E090C1F4D999C8E
          A1D676082ED0D67A01357DD72B4004E1217BC3CC47F340BB7B909FE543365C1F
          02F84C22982840392050F37DB343BE618CBC763D07A3BA137010D327E9A591C0
          4E7F6D67F9E42C373A4F5FC2C9CB036B76D0E11DAA3E17DD919C958585B9E8EB
          3987F343C3DF68E74CEC7BA3D87164DCDEE5C5E2DDB2A99F02F069ABAC35F3A7
          23825DCB1E4A80FEC019FF7EC6A46D9B320BFACB93325647F2A875FDEC6DEF84
          B5F2D9C0AA8CBCED3AAF75ABAF32229124912E91A6E7D61D7C65A54A644AA428
          E2C4673E9DDB25617A4A6222D3EE2538EE4238BBFFEFE3F49E0BF81B5DD298D6
          D9BF642C0000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F40000001974455874536F6674776172650041646F626520496D616765526561
          647971C9653C0000001E744558745469746C650050726576696F7573436F6D6D
          656E743B436F6D6D656E743B71D173C7000006E549444154785EC5960B8C54E5
          15C77FDFBD33BBB36F06E5212C6C1FB0B0E0A602152AA422484AAA0DB6056BB4
          C1541A5A846E238592884F02D6A48D11BB566A6804A9515BDDD8167953228A2C
          526A0161D7B2802B6B617116F6FD98B9F7FB4E27937B275FBAB4DD94363DC9C9
          B95FE6CBFDFFE77FFEE7CC2811E1FF190E57111FB63ECBC79DAFD1D4F5062A1D
          DF7F6ACCC8559B263CFAE8AB13DF5EF37AE5A93535951F3DF6DAC443AB7F3DF1
          89A5EBCB2B94526E3AD5275D3534B43F0F4084AB88A89387A31C46177DD3A97A
          B67C55F1A082C7268DBD2936624819434A46E3BA0E89F6A6CF9CBFF4F1B463A7
          0FAC5CFEFCB8E7766DBEF8E0A8A205C98F3AB6C855137054847BBEB32C7AFFFA
          F2CDE56513EE993B7D3E12ED40EB76761FFA0D18C5EC1953B9365E41C5E82939
          BBDF7BFD81390BA9281C1459F0D9E27BBB45168ABADA162E7AB27CF58471E56B
          E7CDBE9D4FFB8E82E3D17629C986E78E2246A8FAE114E2F17C9493CB35B937B0
          63FF9B1CAFFF60E3C61F372C1311CF5640597540F1B565A3CAF262B107674FBF
          85A6CE03388E0346B1E5A55A16DFF134AEEBB2E9C52AAAAA66624C1F4DC9FDCC
          9A3693B39F9C5D347F45D9AF80C3110BD40973A0246205D1FB2AC757E6B77927
          F14D1217977D7F6CA072F47C6E9E3A07D7517C70F62EB6EFDEC357E68CC33786
          96E471BE5871A39B68DEB7244320043FF2DBA5B79614C47EE2B86A8A12100040
          0C808008C1134A0411D858F70ED75D574897771185A1F95C178D0D31D62D5945
          2C270A4AB1F0B695ACDEF02E673E7F9191A525A4483178E8080466D92674E305
          B95B864FBE7358DEE05101205648B6DAA7F613077162DD24BD6EB4AFD8FA6603
          2BE6D7101F5484368252505252C4F7E63DC5D36F7C8BBBBF3D8E48545118EB41
          8C8C02081570755FEFB0D8A0A1F8ED8740F75A502A90C10A23A0A02FD9457BF2
          5322518FDD3BCF72E7971F66FAA4C944222EEDDD49004A0A72F8D21726B320F1
          103B77AD63EE6D6368EBB980E78BB109A86467278887F8DD590532898405B2BD
          C95406E797D0DAD64A49DCA5E9FC655E4EACE095DA9528256C5A914029B8FDE1
          628C2FF81AC48394574A7B6B27DA3309BB05F8290FF1D3A9B5D57C054AC008A0
          909098322030E6DA913435FE9568A1A26AC95C72DC1C508A5F6CDE8A36065028
          0796DF7F072282313E7FEB38457313247BE4B04D4019A3313A8549F5A2DC68B6
          D388D57F518898AC12B78CBF9EB5DB8E32726C2E4D6D7599AD1871231905860F
          CE074029D29FD5A38D87D61A8C4B435D2F1D97BD5FDA0410DF80F1317D3DE038
          38D15C502A4B42AC4908F98C8C1733ADB482A307EAB8616604511A237E7A32E2
          7CE389628C81D21171925E2F60008763077B686D49FDEE9D572EBCCDCB9602DA
          08A23D4C3AF1417B499C4814C789222A183DAC9154E08AE1EE69D3F8E9F616DE
          DFDF4CE58C089108CC9C5146D41D8F027AFD5EDA7A13F4F51A4ED6A6683EA7EB
          CF1CE9580A24C16E81EF83D188F6B38633BE871141B92E4A39904995790E15C9
          7361C5EC5B79B1B696B76ACE5036DEA175C4798AAF71500ADA2F09972F088D75
          86AE367F4FC3E1F6EF9E3BD199D8DF749F3D0520C6804981D64828B50A64373E
          C60828CB13D9D110F2142C9A3A89598932F6359CE6C353095A7A7A1084782C8F
          B1434BF9AAEA64C90B87EF052E031A006C05B4C1182F50204B000981822A22A8
          702A21380B3157183F2C9ECE1B4376D9BB91E2520ED7FC81407601B8B9F4857F
          24A083167860BDDCDE7C88B1F6906082B58CCA3E23A200416150A210C8BC536B
          D3EF87CE2680F1058C07C60FD883201080643741D809000C9229404858054A19
          4B39ED8136F40F5B01E3679862020F843096FBB336E8BF2310B1A452C1212CDA
          476BFDEF1430884E059B50ACDD2310F452992C74D680F6D1266593CC78CBC83F
          554000ED6BDDDCD2787AF8A0F8F0504FFC8E26C250B9853839455963614094C9
          AA042AC0D3844609AD7AE9DC057C4F5F047C40AE44C0AB3F9378E0E2B957AB1D
          1822C0BCAABB401B04C149832B378FDA5DC768AE3B694D842506F6A20AF75EA6
          620C8916CF2C073CC0D82454900E9003E40145BFFFC194C6D98B1792BC700C27
          A7309D05D4EEAD63E7B6E3D5CFFCA9F149EB9BF48FFE7D96E07E2A480D483A6C
          0530C10501A22299B58C8AC43259BBE7441AFCC4CF9F39D2B806E80D5F32C0BF
          6E6261C8955A80754103468C01DFC389A465DF7B921DDBEAAAABFF9C01EF0E64
          14061EB4D53E226F6DD9CAD7371CBD9209FB871883488A837BEBD9B9BDBEBAFA
          FDC6C743F0B6F7D699ACF16C13A06D5A8898E00E886F711E000123467877C7B1
          107C4D16BCF67183F603C399D0F7011841DA1E33F668FE6B02358BAF97F91B4F
          08E08908BBB6FE657D1A7C6D08FED04D63CCCF7EF412133FA7F84F22BF387F40
          8E554014C809C73370B0E1BF1CD6145C7164B4AD23FFC3F83BB921E5EF40B211
          6D0000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F40000001974455874536F6674776172650041646F626520496D616765526561
          647971C9653C0000001A744558745469746C65004E657874436F6D6D656E743B
          436F6D6D656E743BEF137F15000006E549444154785EC5940D70545719869F73
          EF6EB221213F94F09784940E8424C00C2D9658746C016B513B9D1670AA9D8111
          6AB580EDB4D6D6FE282D8358AD8AD4F40706AD48FDA952AC5A29D0620728128A
          B4250809162829A9664352B2F9CFEEBDE77CEE64EFDDB9EB449B111DDF996FCE
          B93367F67DF7FDDEEF5322C2FF13161781931D4FF06EF7369A7B5E4025F1A5EF
          4F2EB9EF27D5AB573F376DFF9AE767BCBD66FB8CB30F6F9B76E8C167A7AD5BB9
          A1A24A2965AB24DEEBD9CEA9CE4D0084B80884AD1C2C653171E442EB8E272AEE
          CB2FCC7DF8F2295745261497535C3011DBB668EB6CBEF4EFEFBF5B537FFAC057
          EFDE34F5A9DD5B5A1F281BB9387EB66BAB5CB4004B85B8E5F3ABC22B36546CA9
          28AFBEE5BA398B9070175A77D22BF52851E417E433BAA88AAA89B3B25E7EFDF9
          BB3EBE84AABCC2D0E249F94B7B459688E2E2602D7FB4E2C1EAA9156B6F98F769
          CE0F1C05CBE1C75BF673FA6C14443175CA78BEB0642ECACAE692EC99ECDCF707
          8E35FE65F3E67B4FAD121127E8804A9FC3C4F5ABCACA73229107E6CDB986E6EE
          0358968585C5D9E6284FDED988A560556D255A12B8EE00CDF17DCCADB99A77DE
          7B67F9A27BCA7F041C0E05482DBF862B22921B5E36A372C688987302D7C4B1B1
          416C6C1B265F360EDB52D86145C2B86034AE31B4C78FF1A1AA2BEDB6E8ABB7A7
          0478E4477EBD727E416EE45B96AD6629012105310002227837940822B0B9E135
          C68FCFA3C76965FD0FF660D96059820A01226803CA16D67EE70544836B84FBEF
          BD8E5163262030371842BB28377BEBB82B3E333667549947481A0139195F9DC7
          0F62457A893BBD948F2FE1A3157732ABF27A00B4119482F5B7362222BC717227
          7B1BD69370FAC88BF42146CA007C076C3DD03F36523806B7F310E8FE00950231
          64C008281888F7D0193F4F28EC70D3A2E93CF5E43AAE9DB380FCBC92410100E5
          65638875FF8D6DFBD7B162C587899B0BC4FA5A705C3141012ADEDD0DE2206EAF
          EF40AA10FF80746F52E7A8110574C43A2828B2D1D2C6C285D3F9FAC6A53C7DFF
          1FE98FA71C8864C1EA4DCBB8F1A66A06388FE3B8747674A31DD3166C016EC241
          DC64691D68BE4A911A0114E20B530604268F2EA1B9E9AF84F314B64E5050AC18
          77690FCFEEFC36375FFB3544E0E7BB1EA3B82C46E1583B29AA0FC738449B21DE
          2787830294311AA31398443FCA0EA73B8D04FA2F0A119376E29ACAE9ACDD7194
          9229D9E8B0434CC7B962F625FC66DB266657CFC7B66D5E7E6B238B3F3B95CEFE
          76B4D6606C4E35F4D375C1D9181480B8068C8B19E803CBC20A67835269111298
          045F4F49513E35A5551C3DD0C0CCAB4388D274F4B7F2890593F8DEAFBE88D1C2
          824F4DA2A32F0A18C0A2FE601F1DED89DFBEF6CB96FDFC22E08036826807932C
          5CD04E1C2B14C6B2C288F2468FC0482AB0C5F0B99A1A1E7BA99D37F74599F191
          10A11058E10EA6CD0C232238C9BB3186817EC389BA04D173BAF1CC91AE95403C
          B3056E6A598876D38133AE831141D9364A5930586AF0EE3B9263C33DF3E6F3D3
          BA3AF66E3F4379A5C5E8092E634AB3B094221AEDE3428BD0D460E889B9AF9C3A
          DC79EBB9E3DD6DFB9A97654C01620C9804688D88007EEA25D51A23A00299488F
          8690A360F9ECCB99DB56CEABA74E73F2ED360EF5C51084A2480E53C694F249D5
          CDEDCF1C5E0A5C003440A603DA608C93722020407C22EF1411943F95E07D0B11
          5BA81C5B94AC2B7D75E9B7A1FC520E6FFF3D9EED02F0B1D267FE5980F65AE040
          E0C7839B0F31813D24186F2DA3D2774452F21406250A01443B686D0014010405
          605C01E380713DF520087824E94DE077020083A40EF0052BCF2913704E3BA00D
          4320B807DC41A5182F033E4D20FDE9180CB12344025629EFC33FB48BD6FA831C
          30884E789B5002BB47C0EBA532696A20C818B88A40A6C854B68CFC4B0704D0AE
          D6D1F6A6D3E30A8BC6F97EE27635E34365E761658D4C070B03A24CDA25501E9F
          C60F8A1FD5F7CFB5E03ABA157001194A80D378A6EDAED673CFD55A502CC00D77
          DC0CDA200856925CD939D4EDAE27DA702230110133082E2A7FEFA54E63686B77
          CCDD800398A008E59505640139C0C8DF7D7956D3BCDB96106FA9C7CACA4B562E
          757B1AD8B5E358EDE37F6E7A34FD4F86862213E2BD4F78A5014922C301E33D10
          202C925ACB2A1419ACBA578E27C98FFFF0F1234D6B807E40A7FDFD6048804386
          6A0181071A30620CB80E562869FB9E13ECDCD1505BFBC62079AF67A3307C10AB
          FB86ECDDFA22373E7D7488100E013106910407F734B2EBA5C6DADA379B1EF1C9
          63AF7FD3F8C1CB0C81CE1C0A31DE1B1037AD7958028C18E14F3BEB7DF23569F2
          BA470CDAF50267FCDC7B647815CC98098EE6BF17B0FDB6E9B268F371011C1161
          F78B6F6D4892AFF5C91FBA6AB2F9EE577EC6B4CB14FF0946E48F185662151006
          B2FCF1F4126CF82F233005438E8CCEF0F17F887F003D91F3FE794ECD1F000000
          0049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F40000001974455874536F6674776172650041646F626520496D616765526561
          647971C9653C0000001E744558745469746C650053686F7748696465436F6D6D
          656E743B436F6D6D656E743B5E8804A0000007E649444154785EB5976B6C54C7
          19869F3967AFDEF5AE6D6C2036606304011208984B0B8140203F1205429AB449
          1A9426511B9AA6492B55AA94B67F5AB56A943F6D5AA017293F925E084A559128
          0D0D0D11A1244069C021DC0DC68B8DD980CDE2F5656F67CE4C8FBD477BE4835A
          921F1DE9D3371AED99F79DF7BBEC8C00003CFFFF19DA3500B4AE4C09B8A08667
          3726F119C90A175401B6EB15BE11008C8F5E7F666D3216F9B9618A45427B54B5
          72C9BB8C3520B4466BD06804E53900EE1A4AA3BD052C691FB99ACDFF68F5A657
          DFAB28E12360D6C6C27F98DCF69549D1BAA92EA05F3DCFEBEBD75DC3739ACAE1
          73FDDD6DE681D75F055A5C25AE276017F29322351391D98360E73D2804689F6A
          4A83C053C59306D03E5E9A48BC15BB909BE80BEFF81C280E0D81B6D072C4DDC4
          DB791C80663C88F2D0B44F82CA90458AC3393CF0EB09204BA3E08ED9B6177C04
          08ED8208B40B8C50E345D4EE3AE56FBC0C57A0C1B6F28E9500C47F5540291B65
          9750A53CC20CFA4FE2AA22D05A794A202A09AA5D222E79EF1359C23072D852FD
          6F05B454A024AA9003C3C0088641080017408F97D50B854742942B04345A6954
          A988B62522241DEFCB23BF02B6D268DB42398604DB2A6204821846B0B2B1C603
          43004AFB2BA40C2C4B8E4984AB04A3CADAB6BFD9E9F1219012943DCAB892704A
          5A28AD11A68910068C99189D7B8A687B0CD4FBD6F1BEE475D6B1D58D42A014A8
          12D8B69744C2055112E52B3D7777D7CAB921C00D85F014D30A3D565D370881B2
          154A59AE021E01ED8BB5D61A5181C525EBEB88657D2ABFC59628658FAB022184
          9F80EDCA68C1B8CDC1DB57797D088D02F7A4DE5C295C42AA5C35428CE5846DDF
          20044A6A501628E995361A2A20544EE92A50963D3A1111AAC30825C18C621881
          B17534E5BD641E113488D64EF513F0F701593EBD7273C05FE3685425F93546D5
          4D98C919281161A43F4DB1B7076B284B299FA3941B4649095A10882789373653
          73F30A605B083001FB95F5D3B5928A2777A630CA0A28B45D42BBA1404937211D
          53E50A11B6749CC69C301F6AE672ED529A4B87F620339749D4C468BA750E3397
          2D65DEDAD5CC5DB59CD605B349C40499631F90DAB58D17EF6E7E180803E6136F
          7519202AE1AE7EE707B777CCB9F3AEC935B5C14AF391833DB803231C47841208
          0758EA2AD2877613090AEA66CCE4E8F9613E68EFA6A3F30A57FAB264068B4C6A
          A861B263D3A7245936BB9A99C93CE73FFA987327536FFFB1BDEFEBEF5F18CC00
          F6438F3FAF0410F9E543B336D405C566031A3470DF730F63672FA1D165F0609C
          8E7326DA8C63F51EA665CE0C3EFA34CA5FF65CC0D221862D13691B044361C2D1
          28F97C8EFCF0305A59344EAC231E92DC33CF6416290EBD7764EF6F0EA51F3CFC
          696E1090C28D4B088802D56F3EBB28B5E6A9C728A68F628446C1631CDEDF436A
          A0EECD70DFBEBED94B967E6347673D56A08E850BE7B2FF589A491313CC5F3893
          ABFD43F45FCA502C5A64B259BA2FF492C90CF0C8863B38D7D98D99EB616DF438
          270F1EDBF2DDF72E3E0F140C400125200714B42EB76511888CD981DDC7693F95
          FB53FB873B7E3DA1AEFEC9D7CE4EA16DD91A1EDBF8250ABA0AA9346BEE5AC294
          9626E62FBB85BDFBFEC9C9E39FD0DA7C130B6E9B4DAC3A4E674F1FEBEFBD9399
          0B57F1C6E062120DF5DFFA765BFD3C2010F0DFDBB452202D8C40D4013FC1CEBF
          9DDCB2E548EA85971F6BFBD9EEC212F3FE47D6D3D2DC44341A26BDEF04F16888
          5C4E52735394BD7B0E90E9CFF069E112F9FC08EBEE5BCFF4E9D338D37981C71F
          BE87AAF951EA26D4B06B47CE6C4EBEB109FABF13C037B452685D62FFEE53BCB3
          F3D46607FCA7803A6BCC7970E9EA35DC3CAB85502842C0140C6487898483A42F
          5CE6172F6E656060006959485B72AEE32CA17088447515D9C11CE148080C8369
          5347955AC989FED483D0F93D03FF854B693EFCFBD131F0CD47523F0146EA26B6
          8A74EDBAC4AA154BCACD4694FB41C03028144A944A92DA6435C57C8152B18055
          2AD2D838D9F192A1E11C897814CBD680C0080659BCF0364E19AB12B16463C800
          F8EB53B76A400396D69A5D6FB5BFE480FF181806ACCC95F3F97CBEF0E783872F
          52282907D0724C31635A0357AF0D726D20CBAAD52B699EDA88E51098E2806F78
          E07EAE3A8AA4523DDC367726D2B22916A5435272F04837B9DCC8F691ECA5A2F0
          DDE3834008970C20DD796876DBBAC62FDEB171EFD35F5B36B57E428C60C0A468
          495ED8BC9D702448EBB426EA9249671EA050945CCB6639D3D14577572F3FF9E1
          26020167BD60D19F19E1B7AF7C70F1937F6D5B7B39B5BFDBF4A7800B6AF91F12
          FDE98E8208C4FE91CEC6BEDC501BAF8A384000D31AEBD9FBE1C75CBEDCCFD048
          8E9191025DA98B1C3BDE416F6F9A4D4F3C4022514D2E5FE27CEA2ADB77B4F79F
          3EBAEBFE8B67DF3D0F943ECF2BC804C20B966F9C35E396352F2F9ADFD2B66441
          13D5F130C3C379DEDF7F989367BA483B44EAEB92CC9A3E9595B72FA6AA2A4236
          9BE3C0E11EFEFD71AABDE7F4BBDF4C9DDA791A28005278B758BF79FFDB8F3EF7
          1ADB367FB5D2B462D5F58915777FFFE958CDE4675AA7D536CC68AE25591D2116
          0F110A98E40B16D9C13C99813C1D5DFD7476F5F50D5E4BFFEEE8BEADBF2FE607
          B2401190CBD7BFA43F1B81675F4369CDF6AD8F0AC0000240A4B6617A62DE1736
          DE1B8D37AC1366A855188126A175C256F6A0B44ABD9655E8CA0D5E79FBCC91D7
          DF1E1AE8C90205DCF0AED8F02BED0C3E1301FF32E01181A06B01C0F43D4AA50B
          5872E7CAF73EF4087C5E131E3BC323E4BFF5A23C32A0AF07E33FDEBB95214874
          B9310000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F40000001974455874536F6674776172650041646F626520496D616765526561
          647971C9653C00000029744558745469746C650050726F74656374696F6E3B41
          63636573733B477269643B53707265616473686565743B190E0BF4000005B449
          444154785EC5576D6C5445177EE6EE6ECB162AD09616C40A42891856240A0A24
          1AC09002897CC4606288E82F7E12498C12628CC144A2D198E80F354A22A009F1
          237CBD6F010B94048422852A458CD05A3E84D256B7B4B0BBDD9D3B73DC9D99DB
          B9773742437F70363773EEB973CFC733CF39BBCB8808F7521CDC636100F0CDCE
          D3DA40C0AA158FB3BBF2736751507FF55D13BDB272A63610210C23AB96ABC0CC
          A0A2F421072E4C4064834BA35B075EE0CFB736CC2F195EBAC9719C99008102B9
          07D5423BFD878DA955B8E2D4CDBE9E0DAFAE597C088000401A012B4E2812FD7A
          FEDC2955E32A4BE197C38D6D98377B32F2A5E1782BE6CFA92928F3D0B1562C98
          1BB47774F53DB1B7E1DC36000F02184021EC4780315635764C2992FD02D2D71D
          FFF4DCC2AD94ABEB315128678F277033E5DAAA19818121AEF707D0A8183D0244
          AC3248FCE00D93440A2E2FB85920A5BD5176462A0B990F3941BD2BA5D6C9E784
          941F82E598967030018BA355AD036B67DA26A57ACE8801206D65E61D8D974D42
          252661A5300190241C3ADEAAA0650468BFDA51DDC1B3C63B19BB0E5177E0AC0E
          68EE99DE82FFD5B704D0193532AAFCFBAA2F444048890559522592AE570FC048
          0559F26CCC20613DFCBFFE0C962C9C3E1088CC833D3F9EC173393BB3C8154718
          366F3F114880311620A11ACBE4550EAD33F2CECE3AF31619A4804582C85CF605
          920E8410B7450052789BE13B4F80F24E5582A9552756382FA2D10842219D04C8
          B2A666421900840C11050A49282DF3998244514B4A538D0DA692505D23198891
          678413021E7A6034DADA3B71BCA93DD7FFEAD1B8CAFB30A67CB88A693BC1806D
          B22AF9F08B86BE9A8995AA8F5547175447DE12E08397DCF092224CCC066F3977
          056D97E27872560D2AB3812119AE77DD40E3C9567477FCF5DED64FD7BE032005
          8082080842ED330F2391727D566067DD2F58B678860D6A941DFB9AB16CD10C65
          5063950117FEEC40DB951E2CAA9D81BAFD8D38DB72018C399816AB41EDC25938
          7090BDB6E2A58D47766C7BAB1E000F90D0F4699058121A6AE4CD08C301AD9A7D
          8EC0FEC3E7F068AC1A3BF7FC844CF226D6AF5DAE7AF3873D3F636F7D13A6C726
          85AE77FEFD26800600AE0F817CB66B1DFAAC8DD1D71DA66AF24D400881AB9DBD
          9834B51A972F5DC7DBAF2F4779D92855DD9AD5F3B0E9937A88E90E2439D33C2E
          04E7809090AA1C7FB79B096608E999C9B4A79741C421A4D319B8AEC08DDE1486
          454BC0B3BA105CEDCF64388A8A8A11EF4D40481902500C20CD7CED58BAF1A37D
          F12993ABB20E127EA8352155D93E60E07B2E251E7B642CA2BF7E8061B72E7853
          6660266809A2DBCFE9D8531B8ED606492825962D8CD96F3E13FEFBDDA7F0FCD2
          99B6748504E1DB5D4D58B974168470E1C80CBA8E9CC7D4D5EB6DC002B1F696CD
          EFCE051009905078671A809B4178E79E5B756CE414229B939002C27521539D10
          F133B89D84CA62705D57A9260113D776810E46D01A919D9FD2073D052FCE5D50
          7F1C7E89BDD8A89EFDB67D0E3C11896EB55793D0B24D66B3EA6CBBD855553DBE
          2230DB4B4B8A1189303BB7740B6044D65E1C71D4C8E28220321CBCA71DBCFB3C
          2223ABC08AA228AFB81F32F7492740E924F88D0E842B26C1E55C790ADBBA90BE
          D8767EDD675B521F332754A119644973B2B9DD12D037174E9C6E555D326FF604
          54E71070FB21937DE84FF6AACA5E5E1C53FB53EDCD065A82C3537033AE49C0B2
          856FDFFCC62E00FB4C57B041FCF265E60A7F098C3CB06E6A8BCCA4406EC6EB4E
          34355F54215E98C80149FA7B23BB876738F2E78000D00F80DF31706112110070
          15024948977BD0E18F6B9A1F9267948D010A25975B04F27BC6BDCB3F25AE9BE1
          A01C02C226B0FFFDF16A4DFE7E75805792FB1220A2C2261DBC8031159F348905
          C84D235236D6740903EFBE0C8244A4BCCAFE40E16908DD86328CA18A2571E65A
          57F8C8EE2D979EC62024C9871D05901EDABF638B8003A00840D45CA1020ED97B
          F2F12D397404ACD38C719C1C0481C9A026FE05C1CE7CD4BBB01CA00000000049
          454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F40000001974455874536F6674776172650041646F626520496D616765526561
          647971C9653C00000029744558745469746C650050726F74656374696F6E3B41
          63636573733B477269643B53707265616473686565743B190E0BF4000006AF49
          444154785EAD977F6C556719C73FEFE96D6F0B63D0DE4A110683D2CDB91506C2
          8C0C516101069976F107D98C51FF31268B599C89B81913A359345BF40FA3DB34
          D32C4AA3A66B02A55A4ADA750C0B745BA1FC28EBF8E1F8910D281DA5A5DC7BDB
          7BCEFB3EDE9CF3E6BC39B971A1C99EE4E4BEE7C9F39EEF739FEFF79BF71CF58F
          DD0320F078D34AC5F4E356F608C0DFDB06E49B4D2BA384887B80BBF0DCFA6300
          4E36A00163D7250D94BDDCBC6FFD8C99B37EED79DE6AA619F27FB30A10B4D687
          276E5CFFE913DFDDD403E8E41648015ED5CC59CDEB1FBCABAEAEF6B6C4880E1C
          3ECFDA558B4B000EF49F63EDEA254948117A8BF9CF27F30C7F38B1AAE7E0E91D
          C0620B6E9E7BB1477EF2C406D78052AA6E6EE6367293012841D9066A66A7C94F
          1610C70B12E62B8BB58544B30AC8C47917D5B757F2E9A5757381B4DDEE17C163
          3A1450D9BCF3707EDB23F7335908181999E0E83B97181DCB8308624144B004DA
          B548F2DED525F6B9BD4210F847B213E3CF3CFBCCB6988E14A08C654589D0D23E
          C0371E59C99245195CC0BEBEFFF2A5CF2D2519F0FAA1B3AC5FD350A2809E8367
          D9F06032FFDEC56B9F79E59F8776008B00631B003142EFDBEF91995345365760
          F1C20CB9498D716AE5DAF59BDCCC078E0E3B916BA35926F281939612148A515B
          8F10C7C24F56232273ADE3C02E94362614D59D0B6A4250416270FB8331EE0640
          94008281048808E15E6348D066CB305A625C2B4294E5C902BB39BAA57B80CBAB
          28670C82A04401126595DD8300CA3521823686A40D6D57718D31F41C3A1B8E56
          0988B29B5174BC36689F2E360F0274740F22487CAFA212FED5752241C19CD955
          8831AE7B370113AB36D0860D455165730162EB5012826C7DA8112061CB7F771D
          67EBC6E53190D82DBBF71EE3CBC53CCA4D2E5DAEE8DE3F54DA8016E1F58367A8
          9D9376B65100D15A091893A0C1711ADF3ABA1414F5349B9467B584A03C85128F
          DB6755522242A3A568B106EA17D562B4B1DC02C6018963D5890FB18D59E18AC1
          03CA94706322C78ED63E7EF35217BF7DA99B1DAFF671E6DC15562F9B0F500678
          3105C6380A8A6BA77C15F283A0422011274900838A5C6354E48AB0DEF05AEFBB
          BC79E4029F7DA081FB57D683515CB93A46F3CE23CCCB54C5B8804A811DAFB54F
          60349D6FBC1BFA3872B4036CEB3C0A48090DBB3A07C20697DE59C3F5B109DE3A
          F63E0F6F5E41C7DE3E064F9C41298FFB1A1BD8BCF101BA7B8EB3E5EBDBD7ED69
          7D7E0FE04713D00641A2096861F3173E45361F1087825D1D4769DAB222294281
          9D45F0A6875784E32F5386175FD9C7B2C685EC6A3F402137C1D34F3E0A0A5ADB
          DF624F573FCB1BEBB97CB9613BD005A8A801113AF70D31AF268DD1BAE4981543
          34EA3801E2341009D7081ACD07C3E3D4DFB3908B17AEF08BED8F92C9CC01517C
          EF5BEB79EE852EF4720FC1BBD7D2E0C51AD854FCD7B99BB950034EED16D2726D
          519D3B943B9452658AA9499F20D08C8DE7A9AC9A811F6882C007A0E017A8A848
          333A9E451BF1804A201BDB10018321D0068380240EE1A8312B489B46AC3DC508
          A202C6BB7ECE0FE79F844BF0C5BB1574B7306E155D81F0D41D2023B07989CC78
          F2D9B5AD6B7E7660530A10B11EB71AA06DEF2063E3D9C4A805C5ABEDFDA06C6F
          8E0D5ADADF66D9DD9FA06678907BBFFDB4E3A9245CFEC45F7EB506A848012608
          82E1F3EF5FABABAD4E638CA66963A33BF92C7CEBEEC37CED2BAB01DC7494D0D2
          D6CF57B7AE029DE7EAFE00931F468F1EE7A3A2ACA6912266B8F480A95343279F
          7AB979FF87BD6F9E4697BE84000A8D7BD9909819E55E4E44F0FD00991CC50534
          3EDEC77D8F1D4AE4747624ACB522C46FFED38FDB80EEDF43F563DFFFE3296735
          0B8A0A0114360C8E1AB19731E8828F7FFD1CFEC869CA67D7A12AAAC8D4CEC760
          305359642A873F7699546D3D81EF636D8806A62C26BA48C7F1772ED6DD73D71D
          31FB08CC9A91A6BC5CC5A78DB50033AB2A48977B4C69A209049398DC0D2673E3
          28E03B5B1A4184FCB901FBAF04CFCF131482B801B15701C86627AEFEE8853FF7
          FC4E9579B5A0503833BCD13B8444D80987EC3F789287D6D6B3A0E0630A792428
          581AA17FE03C206C5BEC43E81681628D5FF0230AC2D12A652C4CA1A3E597BB80
          3DD873E2163E443C20F5B73F50DDF983866312E430811F1F9BA72E451419BF00
          020AC22905910648910C0D4C023EC034BE92CA0182828F14F288760DEC7D7E01
          20E4863E882935BE6DC05240A97109A6FF7D881F041A09A628AF996705AAF047
          2E2218CA3375F1698A3F858E6C685258CBB940980EBA5260857CE96AEA3FBBFF
          7A611DB71039BFB21798520EDCC5F41BC0032A802A7B9595D2E754EBA82697E2
          E308E7220DE400750BF506D0FF038C53405493FCA2E80000000049454E44AE42
          6082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F400000013744558745469746C65005A6F6F6D206F75743B5A6F6F6D75612DE6
          0000090349444154785EAD96097055D519C77FF7BEF7F2923CB2872418421642
          488000216C0691680CC2B02A8BB69DDA6AA76AAD38552953970A16A72E0547A7
          058A6BA12C82DA225025618909C1C42064819040123081A8D91F49DE72DF7BF7
          9E3EAFEF499475A6FD66BEF9CEB9E7CEFDFFCEFDBEF3CD91B871BBDEBBE29A8B
          E2CACBC66B2D4A5EF30FAFE06280B0867F7205A5759B4AB89AC9C0B5C4E5152B
          3784FDEDDD838BDFD87664EB9BDBCB2ADED856F6D5C6AD65DD1B369756ACDB54
          FCE19A0D9FFCFCB1156B63011320FBA1079A4755E13ABF47F7D9BFDA06A00BE7
          CD5A6A5EBFB964D93B3B2BDA4A2A9A44736BB770385DC26F76874B7F5654D620
          366E29EDFDCBFA8F57CE5EF0CB483F0820F9BFBB76E3013D5EC90702E0177FEA
          4F6FC7FE7D4B69497179A3B0D9BF1375BB3561F702F4DA1461ED738A8BFD8A77
          CDED7DAEEA60074AEBC59A8D85B50F3FF14A06103010E2E575FBAE0670590AA4
          3FFE795374526AC6E119378F987EEB94E1988C32A79A3A59B7A59CDFBDB08FA5
          CBDEE7674FFE9BE75E2F66CB9E5ACEB65EC4E9D2983E2995D9B96346A58DCC2A
          FECD936B3300A3BF70D56BA4401E98F3DCFC45A69821493BA64F4C19919E1283
          43F1B06577358F3DBF9743B5766C414349183F95F83193E833C5F1D9693BABD7
          9751F4790B36C54DC2D02866E68E1A3C243E75FBDC450F47FB6BC2EDF65C1BC0
          5F70F3173FF4E0E81143723346C4D2DBA7B0FCC58FD9B6AF81471F98C96BCB72
          78F6DE912C9C14497888094B58286171F1840D1BC1DED25636BE578353514988
          8F262B3331634CD6AD2BFCF5E0F1A8D73DDBD2838FBD183E36EBE6FA5F2C991A
          63321978F98D123EAFB3F2EECA39186409C5ADE1740BEC2E8D5EBB46E1C95E6C
          4E152F3BB204B6F60B64A586322F2F190312EBDFDDEFAEFAA264EC875BD73601
          9EABF5097F9EA4E4D4CC852387C7C45882CD54D57FC381CF5A58F9C43C9FB8D0
          C51D2E4D1F6B08D2E2CCD4B63A917DA72E213991F2AA3A72B286101E6A66CCC8
          78537B47FAFDC02A40FD7465EE55010024817467F2B068149787C2D246221212
          488FB7F8C4351C5E777A841E156F0C0D36E8056A90247406596248622C9F9F6C
          63D6B4448627C751F499310F580D48A9A30DF8ADB156BDAC08254D13E36E8A0D
          C7E952A9AAFB06CBE028149FA07DA0B8AAE152052E4D1010206134E38D201B21
          362E9CFA2FADC8B24478D82084467A64747CC0B5DAB8F1D221E0A6A040137D76
          3B9DFD7612420671BACD494244008B1F7807213C685E47D34052119A40481A9A
          A6F1E8B30F21CB106231E3ED0F3A80906424B0A4A4650FEAEE6CED1DBAF4A074
          61679EB82A80DBE54608F0681AB2D1A08B949CEB634E70189AEC227D5C1ADE77
          50DC1E3DBADC5E77B9BCD143FAB0209A3B5D18026454838610121E55E0F6A820
          49C61BF903DF76B31E9B5D095535888B0941F5B8B02A26F6D45DE49917EE23E3
          A660DC2A3855953E4520C96094F5FCE30D582C324E4521222C1055D37038151C
          76BBBBE154F945403CFF5A8138D1574966C87EAA829732DEBEF3878DC8E5566A
          CFB776E91FCC1E1D8FC366D5F11C689CE8B0B1ABB69BFD8D56CA5AFA39D3EDE0
          9C55E15C8F42B3D5454BAF8B508B91F62E2B192951FAEEDBDAAD288AD270B1A7
          CD8DCF2AFAB238D1978FD5388C9A41F70C0440389D8EC293A7CF6332C8CCC84E
          C265ED44482AC8020C2019D181649340360A7D2E994036437888016495B3CDED
          4C1D3504B7C743FD992FB1DBFA8B00151003210034C10F019AEA8FBF5776F4B4
          5D682A111633F99393B07D7D1EA349D28584013008304A08A30E843150227C90
          81A040998ACA267232E308B704D06375505E714AFDFA42E3B61F0300043BCE32
          DEB6C30F8000B4C2DD1BBB7B7AACAF1C28AEC4E351599C3B8A9448335D679B08
          4025C024810CC80293771CEC158DB218F1B8158A4AEB08354BCC9F3A9CDE7E85
          4F4B8ED1D1DE565C51B2B5C1272E846FCB93075533D9FDAF2B5E48B4EAA3857F
          DD5F547DAAB9F92BACBD761E5F3295F913133957534F5F5B3B16C9455C98D92B
          6CC2657770AAFE3C878A6A99911EC7B27913F49D575637525AFA059AA665658C
          9F930A9800C3AA27664913838F93195A8029C88231D0EB660B123A9EF0DF808C
          79731F494D484A2FFDC9D2DB23870D8B272A32987EA78B43D5CDD4B574D2D2D1
          A7378DC49870462546919B994044B099B62E1B35279BD8B2E53FCC9F359ED4D4
          1436BC53D0D9507774FEB123EF9D009C80FA6D2F387B2600214020F003F8BB91
          0C1873E73C92113978E8CEE939E3D2A6E564111E164C44581081662346830CE8
          FD0297A2EA8DA7B3AB8FC203E51C2E3D86E6515872F76CEEFF692EC76ABEE4D5
          75BBED3DE78AEED87F68F7F7108756DD29043AC16500FE0BA77154567E4452DA
          9495212121F74F189F11989A9A404AF2502483040240D0D87481FAFA7354549C
          A0BBAB731FB2694AF6C44911AD5F7DC39C3B2662B1981817D74ECBAEB55D7BBF
          B8B0E0F5C2A61A1F84A7E0E93C81F8D19DF0A272E95A061881A0B19317A6DD36
          EFC9D5772CFC43E99D8B9E71E4DFF5B4B87DC15322CFEBB97396574CCBFFED9A
          5113E64D01A2878F993D2D7FD19F3A1E5FF58198B564B5282BDC2E84D22EACE5
          2F894F7E3FADF391DCA45B8010C004487B97CFC09F82ABDE8A7D6E18E092CF01
          3440F5B9004C6963E765C627671FF8759E393827E00031B72C2468C43DF41C7F
          9BC33B3EEADA73B4F5AEB78E9CAF021C802A01CC5EF29C0EA16A0209BC51F315
          261CDCF5A2045CF2CB4DF840F00106668FBB2573C594DE3D53F233A344472BB1
          D3EF2628ED5E7A2ADFE2D0A65D5D05273BE6BE79F89C9E0E891B346FF55EE76A
          AF91704F91E487B86F42ECB8BCD1911FDD3A373B4AEB6861C88CC53AC4D98235
          147FB0FFF0039B2B17007D32FF27932499F3DB6F13800A38371F6FABD97BBC7D
          61C1FBE55D52F450DA8FECC1D1B083E499CB91546DAC3F9DFF1B80F4A3A94106
          F81EE2FDDAAEEA8F2B3BEEDAF5CF235D1D9E107ACE54D178F01FF4DBDD35FEBA
          B9E114BCB978240881D04000FA585C3A416D9D36DF18DD5FA86893002310382B
          3164744684F9A584C1C1394EB776F858A76BF98727DBEB01E58601D6CF1D8E90
          7441D07CC2F8E6022EB4F523D001407F04AFD674F96B22003003067F8A0017A0
          DD30C0EB3393D0848001A2FE1D2304CD3AC025717C7F66FD995E69406F91069C
          1AB1F6F624F15FA62BBBA407EAC6F30000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F400000012744558745469746C65005A6F6F6D20496E3B5A6F6F6D540FEDDE00
          00091A49444154785EAD96097014551AC77FDD7325999C049260C84912482042
          089741241283509C4740D7AB144B5671B554108FDD15145C45C1927201C16317
          16413C560416251C11082606391239C2914002017391906366BA67BADFCECECE
          60165390DADDAFEA5FEF4DF754FF7FEF7B5F7FFD24BA1E37FBAFE0BF08238010
          A2734777F8A69D487430D6AF5174F2B0156BF7F1BB8747D159C8C08DCCE5F90B
          5685FCF92FBBF3D66C38F0C9071B8B4AD66C28BAB4FA93A22BABD61596AC58BB
          F7CBA5ABBE79F0E9F9CB22011320FBA03BCAA569DC3084101E8D7B740380C738
          67EC4CCBCA75FB9EFAF8B392DA7D2515A2AAE68AB03B54E10B9B5DF55C2B283A
          2356AF2F6C797BE5F605E3263FDCCD070248BEE72E5BBDAB6B003EF3975EFB28
          F2FDF585FBF6169F15EDB67F9B3A9DBAB0B9015ADA15D1DCEA1057DB14F73DA7
          FBBAE601DB55582E96AECE3FFEF8736FA502E68E104B567C0BD0A52D90FEF8A7
          B5DDE39352F78FBA2D79E41DC37A6332CA9CA86860C5FA629E59FC2D339FFA9C
          FBE77EC52BCBF7B27EEB712A6BAEE25075460E49625C76FFB4943E197B9F98BB
          2C1530FA0A57D3B49B0348EEC8CE9D6E8AE819BF69E4E0C4E4BE8911D81517EB
          B794F2F4ABDBD873DC46BB7F2F62060E27BAFF105A4D517C7FCAC6A2954514FC
          504DBBE224A6573863B2D37AF48C4EDA3861FAE3DD7D35E174BA6E0CE02BB849
          79BF9DDD2FB967766A72242DAD0AF3DED8CEBAEDA799362D9BD7670FE7ED5969
          3C3A3A82A1C9410486061312154D486C32DB0A6B58FD69190E452326BA3B19E9
          71A9FD33EE98EFAB0797AB0B1998FDF41BC166B3F90F4306C6A2A82EDE5D7B80
          53979D2C7F6122F78D8CA647B011A74B1066353034D1CA98F4602C460808F0A3
          477C6F6A9A34B61654A2B85C640D49C16AB5CE997EFFDC38405EF4C234E9467D
          4002A484A4F4297D7A474458032C1C2DFF995DDF57337BD65862C3CD282EDD2D
          81C33D4ECD5B879054D67CF830C9517E54373A01884988A3F8E849B2327A121A
          6CA17F9F68535D7DDF47808580F6DD826C71A30C4802E9EE84D8EE9ED5E7179E
          252C2686DB52427E3177BA47A74097555207241116622422C484D9286331C920
          CBF48C8BE48763B5489244EF842824D99803180029A99F01AF3A07D07531E096
          C8501CAAC6D1933F63ED118E9F59C2E15DB9A209B77434D989A2AB6802640318
          2D6036836C84C8A850CACF3723CB12A12181089DBEDDBA479B01E92635E081BE
          C5DFCF84EAD46868B3E11714E81E354F06263EF811790FADE1DE59EF23641776
          5DE5C997BFE29967DE63CD923518CC925B101464C1DD1F3C00429291C09A9892
          1908D06BE6EE4E218C3E00A7EA440870E93AB2D1009246E9A57606F40A409314
          D232FBA03A55145573CB3D0A17C1B744A1385DF48DF5A7AA417543C868061D21
          245C9AC0E9D240928C5DC9C0BFBA5953BB4D41D3212A2208CDA572F0623B17AE
          AA7CBCEA315E7F3E87375F1C87A23B70E82AEF2CCE63F1A27B59BAE4010C2609
          AB55C6E154080BF143D375EC0E05BBCDE63C73A2F82A205E7D7787F8A9351780
          A301337F0580EA548E5FA869449220B35F34F6F6665CB260E7B916CAEA6C9CAC
          B573BEC941CDF94A14A17255D339D7A450D5AC52DDA2126C3552D7D84C6A62B8
          67F5B575CD288A72E66A53AD136F94B466E086A0D9184B59E03DFF990187C39E
          7FECD4054C06995199F1A8CD0D0849734B70BE55A1B4C1C6D1063BBAC189EA72
          21C9209940B640689001648DCAAA3A86A7F5C4E972517EFA3CB6F6B602400344
          4708005D5CB70515E5873F2D3A78CA26748D30AB85DCA1F1B45FBE80D124798C
          840130089E58F8244B5E7F008C60F493080D34E0EF275372A482ACF42842AD66
          9A9AED14979CD02E5F3CBBE17A0080007B2503DB37F90010809EBF65F595A6A6
          E6B776ED3D82CBA591979D4662370B8D951598D1309B2490015970BEC5C1E576
          9570AB119753A1A0F024C1168949C37BD3D2A6F0DDBE43D4D7D5EE2DD9F7C919
          AFB910DE250F0D2C65A8F3EF9D7E0DF5D283F9EFED2C283D51557589E6161BCF
          CE18CEA4C1719C2B2BA7B5B60EABA4121562711B9B506D764E945F604FC17146
          F58DE2A989833C2B3F527A96C2C21FD1753D2375E0F824C00418163E37561A1C
          7098F4E01D98FCAD18FDDCB25891F0E009DF07C99833614E524C7CDFC2DFCC1C
          DD2D36369AF06E01B43954F6945671B2BA81EAFA564FD3888B08252D2E9CECF4
          18C2022CD436B65376AC82F5EBFFC1A4B103494A4A64D5C73B1ACE9C3C38E9D0
          814F7F021C8076F1B31C5179DA8C102010D7007CDD48068CD9E3E7A476EBD1EB
          B391590352466465101A124058883F7E162346830C78FA05AAA2791A4F43632B
          F9BB8AD95F7808DDA53063DA381EB92F9B4365E77967C5165BD3B982BB76EED9
          720D62CFC2BB85C043F02B00DF81D39896911B169F326C415050D0238306A6FA
          2525C59098D00BC9208100109CADB84879F9394A4A7EE24A63C3B7C8A6619983
          8784D55CFA99F1770DC66A353120AA8EEACDCB1AB7FD7871F2F2FC8A322F846B
          C7CB390271DD91ECAAF2CBB10C3002FEB70E9D9272E7C4B98BEE9AF262E1DDD3
          7F6FCF9DFAB2183DF92591E356F6F8792523729F5C9A3668E230A07BEFFEE346
          E44E7FADFED9855F88B1331689A2FC8D422875A2B9F84DF1CDF3231AE664C7DF
          0E04012640DA366F54C70C747E2AF6CAD0419257003AA079250053CAAD13D3A3
          1332773D966309C832EF22E2F629F827DF43D3E18FD8BFE9EBC6AD076BA67E78
          E0C251C00E6812C0B819AF7820345D20817BD4BD8509BB37BF21011D757D082F
          085E40BFCC01B7A7CF1FD6B275586E7AB8A8AF2172E434FC53EEA5E9C887EC59
          BBB971C7B1FA091FEC3FE7D90E892E86BB7A6F72B2D689B9A740F2413C342872
          404EBF6E5FDF3121335CAFAFA6E7A83C0F44E58EA5ECFD62E7FE59EB8E4C065A
          65FE4F2149321736DE29000D70AC3B5C5BB6ED70DD941D9F17374ADD7B517760
          2BF6339B4818330F49D36FF56DE7FF06205D07619001AE417C7EBCB174FB91FA
          A99BFF76A0B1DE1544D3E9A39CDDFD57DA6CCE325FDD74790B3EC8EB03422074
          1080672E7E79836A1BDABD733C5A5C522B0146C06F6C5C50BFD430CB9B313D02
          B21C4E7DFFA10675DE97C7EACA01A5CB002B27F446481E43D0BDC6787F0BB858
          DB86C003000204F04E59A3AF26CC800530F8B203A880DE6580E563E2D185800E
          A6BE152304551E004074CC9060E5E916A9436F913ABC3562D9E878F14F334089
          E672B7CC7B0000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F40000000B744558745469746C65005A6F6F6D3BCF09FEBC0000090549444154
          785E9D97097055E519869FFF6E5949C084848490C41045CA2218946249596417
          EAD21146EBA8AD12D41904C18E5ADC1D2D4C31C1290815980107E950962A0565
          0D4459652986452040D8824312207073739773CFFFF5F4AEC10C9DA9DF9D6FCE
          7FBE39F3BFEFBCEF7B96AB44846829A50088CDE27305A80F2AFE91DD312B77BC
          B2D9C758A35C503DB5D63F682D978246605343FDC5BFBFFBEA9397000144E21B
          F1D72555BCF4FBC1B4291189769BD9E8679703A8871E9BE85AB06CC75B4B57ED
          6FDEB9BF56CE5FBA266E8F2F04E06EF6C9F9BA6BB2E3BB33B270F9EE968F1757
          CE7C64C28B29801D50D1BD2A166D03F8FF0800B657DE9C9FB960D9AE6D9BBE39
          2E1E6F40A265185A5A7C01B9E1F14B93DB27D79BFD72B5C92B5F571E95F2855B
          F74D797D6EE7D62466FF6D336D0B1C3F95396E05AAA4FF505751718F557D7AE4
          0EEADFA7008013671A59FACF439CB48E4D6E3F1D3352E95EDC91474774A77376
          1AFDFB752521C1D12F68185F0E1E3161C8F64D2B3C4A2966CEDD20B7201006FF
          78E9CEAD0A354400A7DD46EFBBB2B85C7F83D494042C708CA066E9EA837CFED5
          31D273F2492DEC454162221806271B9B786FFE1E7E33B88891A5B7D3BB4717AE
          34794A1E18FDBB0F2C02D30133180CCAF6B7DB66C0160D184A0D99FCD4005EB2
          7AD2E3F7D2F3CE6C9AAEB7707FBFDB01285FBC83651B6A18F1E020DE7FF65ECA
          9F2EA66C4816DDF2D368DFA9139DBAF564EB817A566E388116185052842BC135
          E985E915C5807A63EA5855DCC34EA4E304620E987293FFA7CF3650D82583D4E4
          040E1CA963EDB6930C1FD69FC9233A93DBC149D0143AA63918D3279DAE598938
          1D76F2EE286677F5654E5F68C2E174726751B62B2D3D6B7C0C275E6D09440D0A
          0635A6D6D4D436D0B5200311F862CB7132F28B79EC579DF007357E43F059ED0D
          84D7DD722D02F6B0904577E4B3F3401D22427E5E26CA667F381AC6FF4D40220A
          005A0BD72CF9336F4BC51F0872A4A69E761D33699F6C8F806BBC56FB82123ABA
          1C0A97CB86DD6E2327278353679B427BA4A525639AD2250A7ED83DFC9604D002
          00A2C316347BBC242638F1054CDC9E004E2B8C754D4608B0250E8EDFD45CF799
          389DCA4ABF2229C5418B61840824BA9C98A69911C151DFB9FBC6481C4A1E0F80
          A3AD0220020EBB0DAFCF206098B4BF2D09D1065B8EDF60748F740B3C4CC002B7
          1AEADC011C0990E2B2039A648B8409F8BC7EFCFE80BBB5FC1609009A1CF954A7
          4E08330B13D0844B102025C949C3153741ADE9DD3D07BFA789D3D77C7C7DA289
          BA1B46C88606AFC989AB7E9A4D8DDD65A37DBA832B579BACF0652026D437DEC0
          1FF45F205CF253125A5A65C0D420841B84BCDC0E7C7FF41CA686E1F7DFC18D1F
          2F0026172CF0AAB36EB6D6BA39D6E8C76306B13B1519E94EEC0EA1FAD85906F6
          ED8216CDC95375B4B8AF57C5C1E395EC3D431FCF0A6C10F71E011150CAC6DDBF
          C8E3E0E15A7C3E3F05D9693CD0BF886B174E919828B8124139C1950049C976B2
          335C96FFB0EFE009EEEB914D56FB649A5BFCEC3F789CDA9A432B01896100F7A5
          7ECF7DC69A9B33A023168852606ADAB54BA247B75C2AAB0E3362585F1E1FD58B
          F6BB4FB27ECFF714772F2423AB83257912019F8F1F2F5DE3F80FE778E09EC250
          377B7C6CA9DCCF95C62B343634EA088E7A67DA28B5FED33F4BAFB42D9C4B4A41
          5A5BA063B781A095026563D8AF7BD2D078956F771DC5DBE267CCFDDD786FE260
          D2B48FEA7D8759FB4515FB765583A799579F18C0B0FF8237FBD8B1A39AC3474E
          F0F4134329E93F6A75BFD227BB034EC0F660D9EB0AC00CEA503BE22114C23F15
          51C26649ECE2E909A52C5A56C995C6EB0C1D5A425A6A1265E34A70B9ECD86C36
          B4D6A16785DBEDA3DEBAE6EB8D7BD8BBF710A5037A3372703F32333233CAE7D9
          2B3BA5F807ADDBB0F22810C81BBF5557BE33520469AB80880604346813D2D3DA
          F1C233C3494950CC5FB086F51BF772E0DF359CBBD048DDA5AB9C3DDF68796D59
          B361371F952F67AF65516E5E217B0ED6B26CD52ECE5F6CE0FD495D93A796D47F
          35635CB79E800BB00D7D67A30A06CCD6044C101014A215100EA3A9B18297C463
          8F0C64F2C451243B856DDBF732EB2F9FF1E6BB0BF970D612366FDE8D830093CB
          46F1DACBBFE5F2E506BAE417B062CD76BA24D672E7DDBFA4DFB8D11D07DE95F9
          D51F4776ED052400F6911F6E55D110A24D4122495542788DA09442C46A25E4E6
          64F1D0984CC6EA2048FCD34DD914A010144A84D75F1AC79B3357F354A9839C33
          8BF0E63692DEF70FF417C90C185FAE0F18E6D88F2BCF1E06FCB10C800662EA83
          4874020A44EC08825680CD1502D7222808032B058046C8CFEFC4CC190F737271
          19941672F99BD5648BD0E19E672955926904BE5867B33B47566CAE3916BB0D83
          410101538453A76A299FB3804FE6CE02811AEBFCA38A4F1081E92FBF40D7E222
          4ED79C0ECD00A64D7B91E2AE45A0C321D6E2A0A0209F2325D3D8BEF68DAB83C6
          96DCF663D52A72800E7D9FA36F7D53A6BB794B3930EEA6B7A140A86757CC0711
          4440102B5CF358B2A882A58B2B985D3E1741AC6BE659E77358BA680E1FCD9E17
          152FAC84D5CAEEC0969AC3F25D979EDCB4726FA3CACCA37EE7BFF0D6ACE0F611
          AF8069F601EC8E9B428800B0646139CF3C3715412223C1E3334040019860039A
          AD191A5082A905D0D1175F28C0FBAA2FB2E9F4F5E389F0688B77D79A81A3EFC9
          749E3C84E79C9716AF7108D03102A6164408758B2F085A2302005AA26B09AF11
          428435682172AD06B1114F8E1D8FD70030D69EBE7E449B32E662DD37B33A774C
          1EE83736561DBE664C0302B1106A2D0810B542C72C00D1126A50A0051DB9CE14
          802838717021B6076002FE75676F1C5907D1AF231308008603A0F5EB5804CA26
          4DC1AE1413CBA6F0E98239CC786D0A65CF4F4110DE9E310D04FEF4DA549E9F34
          1980B7DE988E102E91F8519B44CB048211500548B46F7E0E88201A3E5F120F95
          DB6B90975FC8B2A5E1C47B7C414CD3B466057CFED97C243433AC591C590041A2
          8A28803868BC5A1390A8E4E9A9CE98DF02A4273B631B22909A6847B083C4ED4A
          763910A48D0261DBD06DFF2BC6CB0168C0F07B5BAA5E7E7BE5A018D548BA4583
          521130690D120F6D840DA240A2980201BFF7DB88EC9A5B94026C112289D16734
          D05A3A7EE6B909F8002F109068C8DA2A804402D202F86E41F2E79619B3E016F5
          1F971C217F98922E8F0000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F40000001974455874536F6674776172650041646F626520496D616765526561
          647971C9653C00000022744558745469746C6500477269643B53707265616473
          686565743B526F773B436F6C756D6E3B69896E61000004F649444154785EC557
          4D4C5D5510FEE63DE0F1232205C45015534D5D59F931ADDD355DD8542B04AB0B
          4D5CBB64618C8B7667AA71A76E8C4B7F628C2D2DD822DA86264D238D96BF6A83
          14AC10ABB1B550691A020FDE9D23F7CD993BE722890B235E723873CECCDC6FCE
          3773E60239E7F07F3E74E8D3711C79A98574BD09980E00BA3FB8E0DE7D6537C8
          83668281FF38180E47490CDAFDFEE0DEF2CA9AB732D96C7B9C92F8073E339221
          27735167E7902D35141BF575B6E76D648FA3C2C8E2C2FCA10F0F770D02707100
          D9F2AA7B3E3EB0FBA1C6ADF555DE8C92202EFD7C0B8F6FDB021752E3C31F9B9E
          43EB23F5462C29303072E526DAB63780BC4AFDAFDDB8D3DE73F6C78F003C9830
          E01C1A9BEA2A313473DB80BC3439358F452AF13BCA0015439C58D32D654B2D2A
          184B133FCD219F2B933511C8B3B0B3F96E30D3BD926EF945CCE2C402EAA9548A
          D9030B9D6429B17DF561950951C4709A32167B16D758A721CBD1986363CDAB70
          A9A995E05497AE0B8E220D19647AD1B14BF940C11DC016004A9481E1C9394CCC
          CC8993932A60073C3BF932DC65C86998FCEC102BEF77C059FA4481247816B92C
          034CFE704D0F62ACDEDEA20C4003289EA4F5D13AE473A5207D91970A97184FBE
          F6BA56B50CC87CEE8DB7F16AD7632065A84883F89D3CFD3D3A9EDA01074258A5
          95E519CC8C4EA6198838A4CC7995D8AC2E47E0C20AB24B777C2E597310EB5416
          20E3DBF2EF87DD2C0203EB196035D603E82FAC2C3378250F2C2F850C1401A27C
          E4C1C81346B06230EE1D89485AB8CCEB18881C386C180ED03856F311787505C8
          2F03499392B19267B155504250BC26C30593E1A419181AFF0D97676E25E0EC69
          DC938F70FAD03B45D9D8177AE3F5175F8FA70E8CA01EFA06629D0BF680A6C61A
          0D2C6480B16B47134A6AABBD65A2C7107D86C32FB679462885D4F7D5183AF7B5
          60A3A777600C1DFB5BCCC3B35A519EC5B9A16935A30C0044CC72DF955DE890E2
          341659E4C480828273818C541F202B41FB361803D299D8D9050C51A228CC2F81
          C8EA83C1D077197164249106E54350BFA006329A0206DBC9CCC06E48AA059B6C
          685AA0FA0A11CCCF992D070C28C8E0D02CA67EF9D3DB1B17B92CE1C4C028C4C3
          6253D0E3FD6349821DAB91CC3DA74645740E0ADF585F6D7D20BC867B7635A3EE
          817A89D6E070F19B2974ED6F151AC981824FF5892F47F1DCD36DC6005192BE9E
          FE111C7CA6FD6F8DA82297C5F96FA71500528451040EAE97550BC00586D1E2C1
          1592535F44AB4E153520881D9949BA063872F29512A555723138DFC94823338A
          390C4687D5808DC006A2DB80812870F0A192B3EB043F59239485116C8F81280B
          F60207C150B7A411F50F5EC1ECEF0B509DE63997CDE0D8A961C3A274211E3D39
          1C02A6EC8EF65DB42D2FD5D654E93AE803ECB06FEF764CFFB128EC06B93E7F66
          02070F3C81543F25998FAD813FDFD12EFDC15B68EA3FEFFD0E2F74EE0491649F
          9CCCB9D20C2E8C5C5D5F039CA29AC9BA1F335B62959D844AFF3182D50825549B
          ADAD8DA59001570C40EF6A0002728898D5D6D81518B08218823164690E81C356
          EC34005E2D14AE4FCFCEDDB7ADB9CE6F5BDB6CA8AD42592925844972645D535D
          11539A2A454D537575F99A5F46FF2A4E6ECED4D5EBE028BA0120F2E1A2A2A5EB
          CDCECADAADEF11320D4A2F82F9E1BB0A4A8B8119ADC6D886EBB4033BBEB930FF
          6BF799E3477A01E409401640991F25FFF02F19E1DF3DCE9F3C0F60259609808E
          CC26FE73CA321B2061931F0DE02FB0C0DCB4162AEF180000000049454E44AE42
          6082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F40000001974455874536F6674776172650041646F626520496D616765526561
          647971C9653C00000022744558745469746C6500477269643B53707265616473
          686565743B526F773B436F6C756D6E3B69896E61000004F649444154785EC557
          4D4C5D5510FEE63DE0F1232205C45015534D5D59F931ADDD355DD8542B04AB0B
          4D5CBB64618C8B7667AA71A76E8C4B7F628C2D2DD822DA86264D238D96BF6A83
          14AC10ABB1B550691A020FDE9D23F7CD993BE722890B235E723873CECCDC6FCE
          3773E60239E7F07F3E74E8D3711C79A98574BD09980E00BA3FB8E0DE7D6537C8
          83668281FF38180E47490CDAFDFEE0DEF2CA9AB732D96C7B9C92F8073E339221
          27735167E7902D35141BF575B6E76D648FA3C2C8E2C2FCA10F0F770D02707100
          D9F2AA7B3E3EB0FBA1C6ADF555DE8C92202EFD7C0B8F6FDB021752E3C31F9B9E
          43EB23F5462C29303072E526DAB63780BC4AFDAFDDB8D3DE73F6C78F003C9830
          E01C1A9BEA2A313473DB80BC3439358F452AF13BCA0015439C58D32D654B2D2A
          184B133FCD219F2B933511C8B3B0B3F96E30D3BD926EF945CCE2C402EAA9548A
          D9030B9D6429B17DF561950951C4709A32167B16D758A721CBD1986363CDAB70
          A9A995E05497AE0B8E220D19647AD1B14BF940C11DC016004A9481E1C9394CCC
          CC8993932A60073C3BF932DC65C86998FCEC102BEF77C059FA4481247816B92C
          034CFE704D0F62ACDEDEA20C4003289EA4F5D13AE473A5207D91970A97184FBE
          F6BA56B50CC87CEE8DB7F16AD7632065A84883F89D3CFD3D3A9EDA01074258A5
          95E519CC8C4EA6198838A4CC7995D8AC2E47E0C20AB24B777C2E597310EB5416
          20E3DBF2EF87DD2C0203EB196035D603E82FAC2C3378250F2C2F850C1401A27C
          E4C1C81346B06230EE1D89485AB8CCEB18881C386C180ED03856F311787505C8
          2F03499392B19267B155504250BC26C30593E1A419181AFF0D97676E25E0EC69
          DC938F70FAD03B45D9D8177AE3F5175F8FA70E8CA01EFA06629D0BF680A6C61A
          0D2C6480B16B47134A6AABBD65A2C7107D86C32FB679462885D4F7D5183AF7B5
          60A3A777600C1DFB5BCCC3B35A519EC5B9A16935A30C0044CC72DF955DE890E2
          341659E4C480828273818C541F202B41FB361803D299D8D9050C51A228CC2F81
          C8EA83C1D077197164249106E54350BFA006329A0206DBC9CCC06E48AA059B6C
          685AA0FA0A11CCCF992D070C28C8E0D02CA67EF9D3DB1B17B92CE1C4C028C4C3
          6253D0E3FD6349821DAB91CC3DA74645740E0ADF585F6D7D20BC867B7635A3EE
          817A89D6E070F19B2974ED6F151AC981824FF5892F47F1DCD36DC6005192BE9E
          FE111C7CA6FD6F8DA82297C5F96FA71500528451040EAE97550BC00586D1E2C1
          1592535F44AB4E153520881D9949BA063872F29512A555723138DFC94823338A
          390C4687D5808DC006A2DB80812870F0A192B3EB043F59239485116C8F81280B
          F60207C150B7A411F50F5EC1ECEF0B509DE63997CDE0D8A961C3A274211E3D39
          1C02A6EC8EF65DB42D2FD5D654E93AE803ECB06FEF764CFFB128EC06B93E7F66
          02070F3C81543F25998FAD813FDFD12EFDC15B68EA3FEFFD0E2F74EE0491649F
          9CCCB9D20C2E8C5C5D5F039CA29AC9BA1F335B62959D844AFF3182D50825549B
          ADAD8DA59001570C40EF6A0002728898D5D6D81518B08218823164690E81C356
          EC34005E2D14AE4FCFCEDDB7ADB9CE6F5BDB6CA8AD42592925844972645D535D
          11539A2A454D537575F99A5F46FF2A4E6ECED4D5EBE028BA0120F2E1A2A2A5EB
          CDCECADAADEF11320D4A2F82F9E1BB0A4A8B8119ADC6D886EBB4033BBEB930FF
          6BF799E3477A01E409401640991F25FFF02F19E1DF3DCE9F3C0F60259609808E
          CC26FE73CA321B2061931F0DE02FB0C0DCB4162AEF180000000049454E44AE42
          6082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F40000001974455874536F6674776172650041646F626520496D616765526561
          647971C9653C00000022744558745469746C6500477269643B53707265616473
          686565743B526F773B436F6C756D6E3B69896E610000060F49444154785EE597
          6D6C956719C77FD7734E5F80BEB096F574A514C9644D3A1954684433D16D36DB
          58A6C4C56834CC4D13E34BF860646174662818952C268B8E38FDC4029A38756C
          0361132119F222505A2814DA3168796D616D19B6E7749CF3DCF765F3E4BEF3E4
          C9D2902D24FBE095DC79CEB9EE93EB7F5DFFFFFFCEFD1C51553ECE0880FFEF06
          E4E94D1DF8F8F5F24FCB47A9C1CD43019EDAD8AECF3DB108002F7D5A15D63F1E
          010B10B8A7DC12E064036602DC029A28E281576CD87D5FE994B25F11048B7CD3
          0AA01E47FD234A89FA4C5CCF0D95F82E28C69A23E3A3D7DAFEF8934776030650
          F50C782F9494966D7E70F19C4C5DF554D4C109B0BFFB0A9FBB3B936CDBE53F3B
          9107DF89A0C08189FCE2BB6B12335E1E1A5DB87DEF994D4003906021ED19304A
          A6A2BC94AEC12C61A8A8000A178673745C1C2311A25C1CCA72F4D2981B5B3C67
          5C1ACE726C220F31733565C5A8A526697A120C883596502D05A38E5F4151ACD1
          04D5E264B1C61949DD9E6BD89838E7C70C8D46F9D8637CB001632D20A855202E
          6AACC6340BA873B0B136218B0735BEE158460C604203C0640C6042CBE113835C
          1ECE397041151EEAFC061C8EA7B5367A52ABB0CBFC8584159D6E274E5E8E3DAB
          90A99A823106402695C018C3A2A60CEF0C8D271C6D0F294BDA7EE358F0D6B6EC
          5CB392D5CB9A6220577AEB3FBB78B4F51E90589D740A360E0D4DDA8000121A8B
          5575C07E2A212C58D48698EB3DBE09A4B81253484AA06ECF1DAF641D15ACB593
          3380D3C8EB4BEC36C282414D182D0F1004794CDE248CE63F4443B8BC680CE91B
          98DC84A1C57EB020615E51534082A911B860B1A6407454ADA0A200883B356A3D
          8BB16281BA062633A197E0ADFF9C6360289BA0B6B560D8B66A1502581BD3ACC0
          AB6F74C65423511E812DDB3B500471B254544CC11A7B33135A3EDF329BBEE1F1
          D8D72AEC08FFC4FA275B7CC62BC39609F0650FCE7709CF00BC3201FED5A5CD80
          788948A784175FDA7313138606EBA7F355516C6813B2A8CFDB9867102C509416
          3ED5584B510A8240288460A29A4275D5348F5704202206D02036A13B0580C660
          E4AD853819BBDCFF1671534280654AC71E86D7B5F1EEEE9D0481252510887267
          43155BBFFED893A77FF8BD0B87BFF3ED3540312001B10428609D731C5E74DC70
          C753C181C77E20DAD00868E41FAF515F9CA5FEF1AF90EFD8CBC09B3B88065543
          FAE41116DEBB787DC30FBE55DD706FCB4FF72DFFE6CF80746CC2D0F0FACE1EAE
          0E672141B9F2D7ADED20A09AD8E2E5AD87C1E5E635D652B97B179927965278BB
          83395F5A48CFEB7B3878EE0AE595E5CCC95EA07AC97C0ABDED4CAB9BC134497D
          1F589BB88C1EB9BF91F3D7C65D065078F38D133CF6E8A27874044479F9B576BE
          F6E516270214170917EF6BA5F7CFDBF8E4030BB871A687C6873F43FE95B7A8AE
          CB90F96233374E75A0168EFF6D0BED477AD702260D8897C0A0A8C7562F81FA17
          0BFF22022A311B88BBF1A0EEA1A5EC9B9838F7F73D34B52E20D7D345D3C32D88
          08B9A38750B5746E3BC4C1637D4F3D73A9FF0F40218D5332F280F5FA8BA71963
          2C820BE74767C66889085641AD4290A2F20BAD98F2123AB7BCCABCFB9B183D72
          C08F44E7AE6EF676F5AFFEE5C8E08BC0FB807A09AC090B57CEF6BF9B99513B1D
          3FAA029515A504A9786A110185B2A925A40341F11C4A74F452E98054490945D5
          D5E4AF8F62AE8FE1637A7D0355D7C280914189F983002859B0EC17CBA6DE56FF
          5B0982198E707FBDB2E4CE4A9464F8CB469C39EFA8A960EE27AAF8EFBFFFC5CC
          BE76E636CF227BAA1B3C9442E9ECD99C397E95FDC74EAF6EEBED7A01C8F9CB21
          E5CE65497C4302201FE2ADB86855C35DDF7DA0B971CD5DF3EF20F7CE6904387A
          E82C5254CCFCE67A004A6AEB78BB6798FDDDFD6D6BCFF53CEF25304E93420CFC
          A1A3AC81F48F1B6695317ABC1BB5CA89E317D9777EE45944C5DE28FC7CDE3D75
          8467FBA8BFBD8A1A524F03BFF726F411F2D1637C209B7BE9D481DE15B36E4FD3
          7B72808383EF3DB3211CDB002097D256ADAE6B6CACE57CDF392E8C8E6D060AB7
          ECCFA9880440F9CAF299EBAA52E9E503B991E77E971F7D01F02E2CFF51E96D2B
          669656ACBC6A0A9B9F1FBDFC2CF0DEAD6C0067E852E7A71B6E5900BFE7561E18
          07CCC7FEF7FC7F246F6FD0893297950000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F40000001974455874536F6674776172650041646F626520496D616765526561
          647971C9653C0000001B744558745469746C6500477269643B53707265616473
          686565743B526F773BA57A9871000004B549444154785EC557DF6F545510FEE6
          EEB6DDB69645E80F5312AC464CD05829454C7D22C65091A64D455FF8077CACAF
          069F4C88CFFA628C4F62E2835068696B2906033142D0B64B31016CC535412394
          160153600D3BE36ECE99CC39374D7C30D6B3B97BE79C397367F69BEFCCDC2511
          C1FF39E8C0E7177070FF36D2F91AF8140018FAF89C7CF0560FC83B4D820BFF71
          301C5E5900C9D047A75ECE35E4DF4F32996E1181407C9C80CB90B8BB882E43B7
          88D8C6AAA8B612AE89A809B8FC7066E5F6F2814FDF1D3C0540B20032B9C6F59F
          F5F574B46D6A6EF4DB4883C0DCCFB7F0FC931B20296818406161095D4F351BB0
          A48E81991F6F62FBD32D20AF52FB6B37FEEC1EFEFAF221009BA10888A0AD7D63
          03CE16EF98232F5D995FC60A65FD8A224020082E5574F7333516150CA54B3F2D
          A15457EBE644208FC2CEC7D781995A5DBADD17313B23764E3D940A3143F42300
          594A6C5D6D586542B9CC104D193B5B76A6559D86EC7E1A3343BC47F1586A6A5D
          70AA8B79C1E5B2860C32BDD3B1443650E702B00F40BF1ADEFEE4FCCA8BCFB463
          AEB8E48CC4B18005A8CB2401298D8446527636AA75D3909811AA5B3B36E0CCF4
          2F38F4CE2B8F0078900580D6077731F8C20EF43ED7EAC9241A208E9F98437F6F
          2740E46120AF128C9FFC017B777782A02AAF8760ECE445F457740242C8D2865C
          82E2EC1587807240210502B823EE925793BBA9AC7089D9E9D0FCDBD0FD04868D
          C4600CB611453915BBCC014278C90B8A529423E88794B86C1CC8BA53103D28FD
          8C10C20815F13926125507E455594D2CAEB0FF6415AE6FA78BB8F6DB1F586D8C
          4DCD0544B45C1304C7A72EA482353E8C4E567512AC01ED6D790DCC1010085EEA
          7E02F79EDDEC66A27AC1F8D445F4F576FA19459E464F1430F06A17561B239305
          F4EFD96616E23CD6E732387376410D28090923889D438B93CD34AD4A4A98BD04
          32A23A4046C1B037909190D3AC8D1B0A22B259780CB680859C4C14D04482AA49
          10B57346B0522C1C3C38260C8BC9F63093430B81C45D52423BB1BD2CC60145E0
          74252FBF2FDE4138C4E7EDD8E4AC05983A1947270A9A6008EB26771F1E9F75A2
          5855696B6EB23A10927057CF16DC2B958366ACCE0B18DCD3E5E0270105ADFAD8
          97B378FDB5ED860091468EE18919ECDBDB9D2E44A8AFCBE09BF30B690E1841EC
          48DB59B7034C8898C2714784C16C7CB0F00C414921C061D3009C23829559EBF5
          514DE2301813EC34787B0DC4BA699A0371B18D9DA80AD6A724F6161338760290
          691441D5E9FB004180A9D397B178EBAEAB70A4515665C191F169F34531110F8F
          4D870EA37D8747BFB7252F3D9A6FD43945A578F7AEADB85F2A433BAA5A0E4F4C
          635FDF8EB0C642371DA9387FA3BF1B2214375D02BE18F90E6F0EEC0491CB3E89
          BBD7D524383773355D07EC4C0B0549A1D4DB844D3D94AC47D57D69B989DF9E6C
          6EB9B45310A197AE4296AAA82D932FAE1CB5667B1F9494AD398E4AB1680A98CB
          E5EBF3C5C5C7B674B4C003E66103D6AF6B406D0D2960FE34BB79BEA9BE0A6944
          454D535353AE6297E85BB1468EF9ABD751F177034059BB497DFFFEF706F21B37
          7D48485A248042657560720CAB99AC368F0D58F8E6EDE55F87BE3A7A70044089
          006400D4FA2BFB0F7FC908FF6E88FFE525007F556502A057B2867F4ED9DDCD21
          618D8706F03781666F8FA07D4A860000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F40000001974455874536F6674776172650041646F626520496D616765526561
          647971C9653C0000001E744558745469746C6500436F6C756D6E3B477269643B
          53707265616473686565743BE7F4DD31000004BF49444154785EC557CD6F5555
          10FFCD7BFDAE4DAD2D16DB408D2640A2426B15E2C6288928B66983C8C6A57F80
          AC5CB17085EED9B873A1090BF968A1C50AA426DA5823FD7A88C1DAA6B4540928
          A5C0C205D03B47CE3B6766EE7DAD6161ACF7E4BC73CE3B33E737F39BB973DE23
          E71CFECF870E1D2DE0F07BED24EB75C0747E38F2D977EE83F75F0545D09C75E0
          3F3686D3BDCC831EFC747877554DFD27B97CBED387C437B868AE03B6543C288E
          E4D7BEC906085E5E97455DA8BE5319D3493899B87B7BE9D0471F1E18F6A2DE80
          7C55EDE35F74BFF274736B536D6488F4908B5796D1B563638A40E367ACF01B5E
          DEB1096B3D170A57B1B3BD6D15F78BD7963B8FF64D7C0E60B332E01C9A5B1A6B
          303A7F17AE04697AE6165EDFDA14C10930095CB97A13CF6D7B2A784B59E3E616
          97F0FCB65601D6B6B9F50910DC93126EFF41CC812286D1E910BB63D115FAB32D
          CA926D88B2515FAAC24E728C8A5630339C2A8911A1334B3C1F9599069CF5D996
          72303B3BAA4C18189F5EC2E5F925052304C1CA7C0E03E77EFA2748BF1743E051
          480D2000A7452F1B02E5510C0027093AB636E25E65B9663AE26CF697EBE87EE3
          0580081A6C0A2083E72EA16BCF761064CB92C11BD6F3702F98024DEE9AAA1CBE
          1999CE3290B033AAE18C67105C92F68C9461D237C5417D36C756C75FE5090C94
          32C02AEC281BC72449D64E24DFA456082BC5516A886E863311B77C632E612071
          E09204143B980DD2BE851498202BA064C9CA6C73381B60385906460BD7F0F3FC
          B28273A4B12A4F18387BD1AA232CD60487D3670B25896FF9706AA860091754D0
          D25CEF314A1960ECDADE82B286BA28A9FBB834398FEE3DEDD177CA209DFA7A0A
          BD6F7560ADA77F680A3D7B454FF206A8AECAE3DBD1D920247520610673A03353
          841093536139CC558034E17CB339829E44C6523062B80C03F00CB0B317308D92
          24E9F8128852F901869C65C491914462543441F42C07909310F8A69EA980BD21
          F2210CC9DCD0220BC2A008AA9E2E002BC59684C3A30B9859BC2DF2CA45659ED0
          3734191C32DB14F4E499290DB063110AE389C1C930D56B1A686EAAD33A90790D
          5FDBD586C64D4D12063D69ECFB19ECDBDB116824972A4040DF579378E7ED178D
          01220DDF893313D8DFD5B9AA105557E631F2E3AC32909362C3425518341B7985
          61B4447081F45BDA2C6F744A94295C6422D91CE0C421F16025D728178D8B958C
          C432A398D3C648B71CB0AE3256A6573390A414A2A964D7B1EF4644E81957D4D7
          2C885D629AA00143D4B4109D19FE150BD7EFC039A30CF13A3E3E386E58944DC4
          6303E3594093C3B15363FA956C36D4D7CA3A5507D8E1CDDD5B30FBE75F316B2D
          D623E72F637FF74BC8D4530AE3F187E0EFF67486FA2012D1E92FFB2FE040EF4E
          1085E8930B6365790E3F4CCC95E60067A866B2EAC7CC16587152A964B93B3447
          48A956595DDB0159065CD100A7A5D214C9216116596337C080D56B433486A0D2
          069C29C54E0CE0072B2B37661796363ED3D61865AD6C6E68A84545392961A42F
          14505F57ED29352C9086A9AEAEEAA15E2EFE1E202D4E337337C049F20780249A
          8BEAF67D1FF7D634B41E21E43608BDB011CF3EB622B41898D16A8CADB9CE2AB0
          E39B776EFD7EF0FCC9C3FD00EE11803C808AD8CB1EF1C397F0EF1E173DBF07E0
          BE9F1300E9B975FC73CA613440C23A3F62C0DFC3876B7DC3CC2BEA0000000049
          454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F40000001974455874536F6674776172650041646F626520496D616765526561
          647971C9653C0000001C744558745469746C6500436F6E646974696F6E616C46
          6F726D617474696E673B4AEFC1C8000004CC49444154785EC557CB8F54D513FE
          AA01458D0209D0827176E263673218DC286A229AB0105D301057FA07882186FC
          7E6C349A18E3232C58FB481898C164063051D4A0E0461D5AA20BC260A2D1C4F8
          C041901998EEBEF75479BBEEA95339DD26448D5893335573EAD6D477AABE5337
          974404FFA550665F59D1932F0440B6FE0210FA9B8795B8D8402880DDAF1FB96F
          F135D7BD4884B5099A006E0BDC06C49CEA322D1E07F17D7B3EEA10B8357F71EE
          7FFF7F6AE3C700B807A071B14BA31B1F5CD31C5ABD54E3C973E2BDA3D37878FD
          6D9E102E878F9EC643EB6F755F0C26A97CC7A6B1E15E8B73F9FE8773C36387BE
          D80360C80090089A37AF5A0ACE4E5DEB5FCFCEC57D894908048150E59BB90036
          A4A6A23E3333AB3E4AC06A7443372D030B9A001A00487F896786706F09C4CA6E
          E514AA3524032816031381A438018BD9DE2661A5002512727C10529F8C24F5DE
          7BEA25F66C92F75CDDD903A44102172241A801C0008003E3FD63A7AAB2CDC1C4
          F2AFF9EA097C7622A2678A5A00160C09B0076F262CA44049357ABE892983942A
          BA72F9F51A6F372F5560C33DB75B3FBDDF207C3AC558F7CC8E54115DA8F5B1E7
          5FC2D64786B34B6927DE3BD9525F5E32A0D168E0F313DFF5B58005F653F7C04B
          50B403B8EC62C1FC2CA0DC60639AFA34A7F7C674763DCD657F873E0E80393809
          8D5D91B9DD3683BB1DA03D9F5540FF5127801139439262104DCEB8E2360F9090
          33BE41C8AF4FD14B5274814E3B965712906E47033D2E01CF09EC33220233640E
          205443E594DEDD4C0458D209F860E7AE483E64575118189D386E39331E7C533C
          89E7C6D5D6B6699BA32D2BA88F842C3AB582A2264BA0B297C6B175D330BCBC94
          7AB9F740ABF2ADF59312602DDFF1C61CB68DEC4E15602961F2DAE8B67E0ED409
          BDC4E677E6ABC9E4EDB13BAEBE844F2D0650968299B9D3F879F6CB81F757C4E2
          1C08810171D2C4619B4EEA2D13EFB54FB794406C0E882094C0A5CE7974CB4E8C
          F44615FD1C10661FB931B9E7F3E389504E11E79C9391B4027AD52E15E731DBFE
          7D004028FA6EC1FD9FBC8AD6F45B502022AA39085802565F98C328BF02223B79
          3E5AF64DB4AC6DFE0C016521D87F70D27C4E1321309093504470E703EB6A8209
          D758E3531F8DBD832D15D1FC1DE14CDF37D9C29647879D23DE3EC8E4DB55DC5D
          C64A0BC1A2850D6C7F763F80C77312A2608473BFE513439CA0793B54E59C208A
          7CF0C9974F766DA1CD81BC05C20229CAF45E75D6031CDBA2A7B71AAB3B9AD65D
          8BD1CCA4DA79A1A54F412CCE810600D224A18002093E3050F3212622BF7269F5
          FCF03D454451237B8129CD2320F9B35BF0E1FEC3A98C261C118E4D1C5702B82B
          1DA0E241ED8320178D9B522DE4D3F9C6953780FB5FC7EFDEFD3476BDB0194519
          74DFF290F4124C61A422612E126FC0718C542474063A57C60F4C61738F84BAED
          FB8B163570F0F0899C032C5E661F01463E8F16CA13C15D9E24F90D0D69F989D2
          7C89DA3920C2B1A3AA6D396A19D449CC64B7ADF7CE57E30F2B890738102AF9E5
          E4D73F35EFB865555F35B5677A779112FB4BA9B9A2F22D20DBCC5AD45CB90457
          599C0F779C3CFD2342599E01505A9DAEDDF0D8CE4DCB960FEDA246637942901B
          DE0E971CAC5997F9D614E699B367BEDD7EE4D0CB1300E62956E16A008BD5FE27
          9F6897F7733C793BAE9200D85AF0AF7D170E52262898ECB4575EA412FC01167D
          E1063929B42F0000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F40000001974455874536F6674776172650041646F626520496D616765526561
          647971C9653C00000015744558745469746C6500436F6E646974696F6E3B5275
          6C653B1B70080A0000055349444154785EC5575D88555514FEF6F5B71FABA1F9
          51D421242BA5B27046E9C1CAA0A9C407B50747F321158A1EC48720529F0A2284
          1221B21FC40C1D7F1E1C457CD03066328266E69A9919969A9AA6CE4F59A3C38C
          CE596B7567B9D7DEEE7B197C886CC1BEFB9CB5F73DDFB7D6FAD6D91CB7617B0B
          4480A5F5D31D6EA17DF0D9D7B26CF10C38201908F3E036F89E9BFF47FC60BB1E
          0AC0BDB266C2CCE12373EF02A8B56D028938103C76CF6608E29A9988CDDEEB7F
          82DFF6FB9988F3BD3D5756AC5C3EBB09000F10C80D1BEE1A9E9D3EAB6A74F918
          C03FC8C832806D7B3762C9FCE9E60DB6B7F9673CFFF483291907EC6B3E56F03F
          6424123B73EE52CDB6DD073703A836028E055515F756E054575E635EBFA9094B
          17CD0C89230658C483383808C4019D5DDDC18F18313ABA2E83581D708198FEA0
          7A6C1906F000E40038FD11113067BAF3B7DF3B31E2B61C8EFF7AD1A752202480
          381F514CB5588AD9F06D5DFC9A80C57B249649983D37CF8248404C20667C7FF4
          0C72CEE1D0913320228D82D83F3482EA800D880753A2693DC4C06101288ED950
          00606610F7E3F8C90BF8FBAF1E45E9EBEFC3E123E7F0F8A3E3C1C4D8D4D816C5
          1C8B8BCD05BF422945A73344FDEA0D32F6FFA92C1F056181759E6A8049C092E1
          C0811318792770A9F39A62B4749FC69429E3412478694E8DC2C02108754B631E
          0BE7D6A44D2982869D05BFEE8FDD6796CBE5D0F2DDE9B404CC02A27EBCB16C21
          962F5E0426E0AD379760C5F27A656BA510D38484BB105DACB1B352C5359D6D84
          12B85002D580F4E3CF2BE7A1A964A0B3FB14CC88004E7A508206D80B5C9C4775
          51A41CB6FB61FE22024E98354AEB7BE6189D69440456DF905A96580E98C8CC17
          C9A69AF4CF573302C4D00C88A2004CE2A3743A73C6857AB77A7097906B50B1A5
          1A686DCFF0C3E70731A8958F2916218339F3A09E807828D136C48239B596EB50
          DB2DBB0644586BAD181AE4DB75DF60FEAC49210192BC8C804F1B5A530DA80825
          037B2F930228967302B28CB0D35A6B5E428F8BE1C0C53E57D2A7FEE85594F51F
          7D81A5AFD505FE9C15698089B50B2CE27080B083E210832D4AAB35A2F281501A
          25A6CFE3501130F5278793BDA6631B7A658A2E0856BFF3B20F89C11090089090
          4B875A6C4F056091B0978893438EA8A40B04DB771C8099488B9F5D14DB8E3638
          CD7AFA6AD9DA988788D89A2E1211326228A468462081A4AEA7221C3FFC43AC5E
          354FFFE49B2DAAC70D80B4A17E5E2D9CA4116FDD99C78279351ED9B63B34BDB7
          1F2C082F09228E2580A8C853119224878559726BE0B19F534D38E7F520A04C34
          18F65B9832050E1A202E7E15B32E97D6581DAA0DB02769F751AC9E9851B29335
          3E70D4DD65B65F8D4B0978540366AF6EBE91904598121446F4F9E398326D4334
          6C6CC6868FF76BCDD7BDBF0B9FAC69541219A5C7B16311ECFBEA27B477742331
          8987D9D6C656C099D24300051DB42565B3B32563C613D3EEC7974D3F8289D0D7
          D38317664FB303ADF438AE7B6A12FA3352BF18844FF1B60248FDDC6945CC4C9C
          352564771FDAA31978E0E171C81F3C89F367DB515676071E993A1157C9973029
          81A84AC3510A5F6B4EEA22C6DE6E6DADF85A45480C5CCD04339E9C8C6BBDBD78
          A66EAADEB3E8480888BD806C46044E45297136B34BBEF19A19E4098FBBAF5245
          376152B5176BE96948056B3FFACB85AAC913C71467536D74E55D18363467C0E1
          50AAAA28F887A4DF3346807DD7F46684D56B5F4547779F12B878FE1298B20E00
          19FCD176FB732FAE9A5B565EBDD6E572E531ACC1DE0983E8D45F69DB8DADC4B1
          B33D7070A5FB99BA2E779C78FDF09EB71B01F43A9F85110046EAF5BFF944BBF9
          3AFBC8FBFCC81C001B43FEB3EFC252C9909249A2BDF526B0AFA2FFD3FE01AC65
          5AEFE09C14F70000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F40000001974455874536F6674776172650041646F626520496D616765526561
          647971C9653C0000001E744558745469746C6500446174616261723B56696577
          3B466F726D617474696E673BE9BCA8C10000038A49444154785EBD56CB6A544D
          10EE3AB91917E66182818088E83BB8578228181011FEB5BB0811A22218D02C5C
          B811DC096EB288649145F455FE192133093353E59CAEAAFEFADC46270B1BBA4F
          7757D5A9AAAF2E3485108A8F5F7E1C1645712BCC18E20B06CE24A077C94B5568
          32991CDDBFBB71A7DC2F1C7C3E957F3DF63F9D94962C2D46FBCDBAD18883C02D
          B396EABED8ADD37DA5E826E967E6585E2A027364A2C57265896AE3FCEFC3CF16
          FCB0D9D95AC7A5349958603A4C74935D0F44A301C262FF9368FEDAB5D54C3746
          FFD7305D705B9049558AD817402A0BE9A23A81008963E648483B08E24EC343C8
          E1A49E222C90707951D481801D446CB666B1C449F0168CA44A83500E2F5010E3
          913C54EC06C01A2155D4EB0F3AD20029885B0455DC61D203861B27EA607B0894
          F2626BBD9EE1765698256148F14C0468C9649C87223F72032623CE85EE117B24
          A3FD020E6AACE3347348F72ECBA0236C6A047EE2BC3902CC1CDE1C1C5B96A6C0
          42C23DC115605504305AC4256D90A254505E86216CDFBB118617E3285838988D
          56E3C6D4EB40C00F3B3BC7EACA42D87B7F640620042891E441AE84029BB24644
          01421D8CE66F10AE2C0402B167FBA78D36236D9DA7C3CBDD871B953EC230C206
          AAA0D909CBC91CD6D6AE762A80D34D6ABF3F089234E21BAFAC349D263902A802
          4C28E832A0365CDE14115A32F22613E41C81D1781C2D6241C79B954422ED5416
          49B5CCA9FB893A431E8F925684D1841501B346E54CF1FFBDB376C55D877A75E2
          B696031208A14E089064D2BB0FAE8750288468444863B155916E8684FD402827
          F40A2D6F433B120B4580951099DD7242497A6852A6AA67C2A0A906ECED88FE6F
          34C13D1028B72FDF1DD69E0D48662C260C5A6BF10B99BCD41B27C2219A0321E5
          C0D347B7C360A89DD0248DDB82418A50D518A3B90ED7E2833C1AC625EAE09569
          27DC79FD4D43A0F42A4C66859E13B4BAE0EC29063953EE722AC37AC6EA552255
          049CE1C9DB93F9327FCE72DD7BBCE9698446E4D61A12E884732BE82C4DEF94C0
          002F22C084791905B387068F53153010687DFB5D46C11F796BFE00018503AFA2
          5EAFED4DC89D0AFEDACEE43DD0B51751086219FC6A7B13DCF9C39EB2C7302A15
          740C9427DE0228555FDD00149784D5E5856A0D37B21E6F7EAA212E60989928FE
          46644108C6C3C1D9F7E7BB5F6F82DBFB025532347501EF099991828DDD295CB8
          573117B8381F1C4F3F23B297F1CA742E55DE5FF30D9A93974BE5D379FE1BA103
          96F31355AB8F0000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F40000001974455874536F6674776172650041646F626520496D616765526561
          647971C9653C00000014744558745469746C6500436F6C6F723B50616C657474
          653BB664109F000003A849444154785EC5954D8B1D4518859FBA73EF64466234
          99C98846F7BAD0882B51890115FC5A084A70E9D65FA0AB2CDCFA1BB210047742
          7E40F0DBACF203240A42C40F1C541CC6B977BAEB1C919EEA97A29BCB9D51B02E
          7D5FFABC549F53A7EA742780373E7A7B6248740363FA6183A907A4D233312C53
          0F0FE6D985C2BEFED6354D8189F00DE032F6D8BC1002C722B4EB1BBB12F519F0
          DC1448C897DF7CEAF52167FD1FA8C3A5210E8E6E8840B13ECCC75F5C7F169874
          026C84D83DF87D9C5C6034EC79285285A512E10AD9DE388B2480340590CC5FCD
          1CD9A30FD69030FA768539BC4703B7840DFBCD4121605AD42EF282FD669FCDE9
          6699109303C14118986AE3E55AA64DDF9F370BD627332CF70E2477441C3473B2
          C4E66C83201418088ADAD2D1FB1064077ED02E58B40BCEF834C6E180256423CC
          413BA751CB5DB30D226DA32B0C5126FA8E8D13808DDC3DB7558B6D32B9384002
          6657DE7FEDF085679EE7973F7EEA89264C984DD799AEAD8385A1AF76211536C8
          85F8A82F014686B63D64DE1C22676C83C5CE3DF7F1D5D73731DE9C02E9E987CF
          F3F8835BEC9DAFC3654C4A13A669464A6B3D4EB56A0277B917D999568758A243
          C3A533A7B661EF7EDEB9F2017D0A8C8B69E010608B050D383149FF5C6B901200
          89AECAB9AF5226BBAD08A9C5220BDB710831D8C216403529A642966969028998
          2D211C1E542124470C6D1DA9D2B8A5053D1961082D3F65700840E50059FF3D61
          90F70BCACEA87A0FA823171A1082F1BF22ACC9C148198703D07CFF23CD037768
          F67EAE5DB0916B11CA21C41652E9C73B42AA4558D1B785EFDE61FFF60FBC7BF5
          52E7C0AB4F5CE0D1472E40DE2896D6D581511DD015708F3C6FED1C0FADEDF1E4
          2B1F961802085095E9D50987585C0C178090E36B882D40E05C4F5ABEC293BBE1
          8C155FC3247720CE2723B457D8BAA8D42F22B00C08AC114B0DACB6B7AB6F5526
          674138607006F2E81E9EDCFE916A53FC2F02B879ED1B742BB1BFFB2BB6B0883C
          DBB8C4CC204ACC226A569D7F192276808565DC019CDEDAE6D6ED3BBCF7D2635D
          0C2FFE798E8BBFEDE05D8ACAA8F652CC055BA1162C9DDA22CDE7BCFCC98DA32D
          C090334861A1BB0A43115E95D00023BD9C118E184A454026488F491875296600
          192B04E0E240D6312D357805C2C022861029B001094BC75FD990B0161689A885
          396268D9589974F65EEAE4783542D3472B05F9D2218703ADF1E79F7EFBDDA5E1
          473788308133CE615C0954DDC4F5AC2F81660A2C64BF689801097B74215E4E96
          6AB21054C3609300811B609E6CF37F8EBF0182E26E1BBF6330AF000000004945
          4E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F400000040744558745469746C6500436F6E646974696F6E616C466F726D6174
          74696E7349636F6E5365744172726F7773343B436F6E646974696F6E616C466F
          726D617474696E673BCCD5276B0000098249444154785EB5567B54955516FF7D
          DFBD200889A87011541404DF9068A9F9427C01666A9AB56A1AA7655336E9506A
          4D80D0724A9D12F3D9C854D34C2FA744B22953811005CD191F544AA40492298A
          A08080F7F59D73F670CEFAEE8566D9FCD39ABDD6FEF67D9CB57FBFFDDBFB5BFB
          68996F8F873422F50041C386C7FFA5ADC84918E81F6879BBB6B67569DE2BE76B
          97AC1F492000421D531FDFCBAE0011E197989573C2D2057F0040CA63FA2CD296
          ADBF73506868EF2353C624F7CB77EE2D9DFF0C4D7D27A3E24255E36EF200BEB4
          7DAD8A9AA6A18BE900BAFEA0E1F6A64A91C9AC8277961513F280F6F8DAB8A8B0
          F09023C913E747B8F5262C989D1CB1E7F30365F72EE3536243165F38776D9700
          0049DC63E5AF4D40C2CAE3FAC957C7EDD375A41079155550A4A242F4FE3E21EB
          B40F00A6142021101BBA585B9239323ABC5FE8E1D4C9F3236ED11534B55E840E
          0B1624CFEC9BF75941E9CC253C71A8EDE1EAEFAE7D200483D75A2F35C8400545
          D5BF8E1B185C34E9F72BEF0C1E34A893807A74165AB87A85472D58B98004D71F
          7E6E5874FF81B692D4C47911B7F865343B2E8209432568A56A2CBA777ADFDDAC
          F848E28362DA30DB23DF2F5A3594C334C1016A3F405A60CA8DE726F2D9464E4E
          61E28A25F1C1E1DD40C2A5803923800434DF08702EBCEDB16E5971525FFCCCD0
          C191511DE0D3EE0BB7B3CB68B2FF084E867728DDDC8E9B74018BEE4B0CDB6D1C
          2AE10B2869CFA67355001409C63888AB8FD878ACA5E5CD5E3E0575DF9C8FEF11
          361AE476818439B9F28CE654C14BE0FEA787C40C8AB11D9A3BE3FE708BD50983
          B910E0DB0B2D8EAB30F54390BF0D02048E9B58B8705AD86EF645093344D2F17D
          75E70170C104F4A07B35992FEF5711192366CD7C3E26710C44FB454010487010
          04C009BAC505E6EEA280E6C70BAA6BEBC237EDDCA686A54F9F3B306FDE381071
          9039AF8C38FEB9F7041A1BDA3D7DB5F5EEEF5708200A004F7EE34709EEB3EBA1
          F0CCE1D393B2074F1E05DEF2BDCAC73957D58309995311105CC063D6FC4DD543
          BABC3EDD96BE14DF14E41F81E65B574120B3C75C4DFDA73B6A420138A04CC9CF
          0028F0F71787AF899B312D6BF0C4117037554301827B15D07D8240EE36C0FD5F
          0ACC5B1EED7A293D5D81C547FC56E38CC005872061C21304310F6B67F9A53F4B
          1990B1360707DFAA5539DE5D18B66AC4947BB2A2260C87FB461520048891AA18
          2400BF60547EF10D82A322608B744270EA2410DC3B408101A458A93FC1413F21
          C0BD8343E65949D0348BBF865591778D8221C13953D533A1C061E9003FFA8F13
          A8A9A87ED96D3FB360DEEF668C10AC93802E2B2670E90A404ACD894308218115
          9052C464CDC1209D383C261ADAD8DA63EF7F0A0D7E600E070CA703E47242B704
          A034AF1C478A2AD2D30E35FFE9E085B6D4FC6D85DF769D019D0B558D04540032
          0809080122328930C8734A01A17E47CF5E01308D3D5D70FDCDB2E2CA678B3FF8
          37346B2084C1818E589AFF7507F8B7191BBF736C05602F6E30EA0A2FDE4A7532
          5E62CE10ACC409440CD2CC1628407F9F1E204502E092843A0EB3AFF02802B377
          AE572B1DB9CFB2F31A771BAF8D9F138713F9675076B83A73738D738BFCFFE6B1
          4C0A9AB84E94341A7525253793CD01865508C20B59AFC134A3FE72EBD15736E4
          4FF26C3CCDDC90CCCD8F02305EC8DC0E69C17DBC0AE0E591FEB4A6C2E1DA5CE5
          C815A2062D3F5C79EE9B4BF6ADDB6B5CF2B02B6B889FC84BDF8135B17EAA9E48
          9B2F7FA2ACF5B6DBCA02C00F80AFB9D9BA56E9365F418E9F375D16653A978401
          08FC8C11D16DD7A5663A29370FFE9F4C31C5571BA7289084E7CBF4A37FBC6749
          37AB25BBADCD9993B4E164EEF1EC711CFFC3CEA42D8787DE9DDB5ED7BF4A5B7E
          005CCC02089DBC098C8BA2BB73DF4839FDD493DC53D0D8DC37A0ECD486C94AFE
          92EC094F5CF824833B1B4F53F5DE4C2A5C3D66B9D9168D8C4B906EAAA3CB2813
          952E7C00ED9FBD8FB60E9705953EF010B57DFA2EB57DF28EE97F575E98329700
          F8B4EDFD2BA41F9C95EA55401B9B5EA617678E5F3A2021E92F03931F86E6AE42
          F4CC4920C6B6EF4F232D756BF94ECDA73F97A02FCE1B1C322D36F8BDC48D2765
          06C6B930372129729C3188F656B86BBFF7341AD6905070C6A148CB4800377827
          81C217EE7E3C724C526E54CA2380F32CE0BEA8120E4E9E04C169DBC72EA6DF9F
          7B6667F6DCE8E0E971FD0BC8792BDE548609CE00C114BC22C0398819F000C907
          191C827B09989BB993801E60D55F1D38F34113FC07B36B04CD5E811845426CF9
          C84D81365BEFC5F14B32E24E6D4FF74C3C3813108C9960D084FC2E0199618E31
          41184617050C4540742140E7BEBEB43960CFDB2FC6DD37149AA176B7B90B0870
          9563C8EC7120DDFA7258C214048676871004D36462B35A320930A0C3C9602A07
          2498DBEDA95857C40410327800704C118058BAAF6EFD4E234F17EE94ACF8B9C3
          01772B401C5C261004729C42ECD4E120BA01D1F2237897759A52B4DF1745FBBD
          EB9C710EE1764950EF8546186ECF36F5EFF5D82AADCB3A772B0500184F155C59
          B7D5BD5F33185F337A4E2CC8DD0CE242110117309CA754159680FE10A293C097
          8FFDA64AD3B4484FBF1B6AEA408621DD7B29855BB500658F3E7ADD734E08AA9B
          BAEB8368D5C7B76687AB63692557D7957D7470DDE9BD9520E1AB361A73BAC01C
          1DAE369CACCC01619097C08787CAE6D454565DE9373C1CB177C762D243898061
          40184CCD0231190D4C9D3F1EC312A2D02F2614474F9C6AD8B4EFC01C752D575A
          C8B6D8AB48EF1EEB5A5D5ABF61BD511008CC4A8B9B1A0A7236FFF472E1ABE4F4
          12D876B1E6FC138C25B30F8B0A264D1CDAB79BCB0EC1993913A402AFBF0A4DBF
          0687E6833DC5E50D5F5E6F4ADEDFD6520940280203A243406ADD417F64B4ADF7
          C8F84149D1536602965A087BBDF772012160F57582BAB4203776145B5675F63B
          83F1147E841F983C21A66F372E497A0713D034D8C98AFCC3E58D12FC407B4B85
          B90DC9FB2A590287E98F8EB6852F1E1BF9D98427578EEA69EB09C108E86E8335
          204CB925A02FC8FDD36BB5A906FFDBB5CB95C57575734A8E9EAB77C06A5ECB98
          3C003B69C82BFEAAB1B4F17A8A077C75AF30F2EE82F656A70C96E9FD03DEB237
          36C57DB13603C2944F87CA05106006F30185CC49E0DAFAD564CBC861BBAED757
          30A239E238FB7CEAD84161DD88A39D6BF8B8F46C63D98DE6D4627BEB59097E65
          CD72CAD99177DB55EA0FA0078020D37BFE8CDF21C91311B6440E41FD8B69B8DA
          E19E1BF2829E7DC6BE1E3BBCFEC4FC1994153EA07E5AF71E77992B5EAB4B5F06
          E92B834201CF42F925B679402CCC1C2AAEAEAB5124E607F5894BF00FD871F866
          F3F2438ED633008C0E5052B299985B5A1BF11F2EFD028CD50F73000000000049
          454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F400000023744558745469746C65004E6577436F6E646974696F6E616C466F72
          6D617474696E6752756C653BC4CB08160000026749444154785EC5963D681451
          10C7271B6C6C344550538895B1D2C20841135012101BF110FCAC44ABD8494865
          63A985AD1F690EF2A101BDC6CEA885317E5DEC55B04E4094C821B9E4ED9B71FE
          DC66C17DB387C58B37E1C71CFC1FF71B76766F9388087592843A5C4997D6FDE9
          C5CB0F66DEBE7938FB4EB61A78E083973080D2252263674F1D3A76F5C22015D9
          DBD7834EB13278E0536F3E40B77E3EDAB373BBB9A395EF0DF468193CF0C1AB50
          029811D27F033E78F31530B33631FF083D62064FCB97AFA035D1FCC2579AA97D
          0AD8F7FE0A2D4E1CB440863326282B83073E543E8067A6D1A1FD74A97238C03B
          A6C1F1710B643863224256060F7C7F0FC09E49C8DE97779EC47BA29FCB01C820
          B220123BCB7C852B205456A963E27483D8FB006425055969F960059E4B1FA774
          4333EF94340019CED85059065F38C08BD75FF426590AC00AE66FDEA5E777AA01
          C870C642F556068F3DC0C8703F5DAC0C04FC383D4727ABDF2C90E18C89085919
          3CF0FDFB0A882476660CC0BEEC29884FE60B5680120B08E265287B052FF5E678
          54AB0740811E2983C71EE0C4503F9D3F33102042E8B13278EC01EC4B8992D899
          3D00B5FB41899891FD1448BB9FD4D8197CE1CBE8D5C2677A5CAB1781063D5606
          8FF532623A3E7C80CE558E0488107AAC0C1EE375CCA50F342A7AC6C10A98DBFD
          6B153DE3C21590D4B90FCB2BABB4AD3B09E8DBB5033D5A068FFA3EC2BB390037
          9BBF276FDD7E5ABF3E3145459E3CABA353AC4C3D4BF0C1BB3980AF556F4CCF4D
          8E8DCEDEBBD6ABEC56F6C426FBDE5EF58CA86F0ADE7C058A53D69486F24B598D
          4DF6BD8DCCE3F21548AB5871CABAD2DC42D6E1C97CD93DD0E1FA039659503B70
          A36CF40000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F40000001974455874536F6674776172650041646F626520496D616765526561
          647971C9653C00000020744558745469746C6500436C65617252756C65733B43
          6F6E646974696F6E3B52756C653B40186E53000007E749444154785EA5976B6C
          14D715C77F773D5E43456D93F048090183011B02B1212AE5516268D30808F421
          45AAA0552BA216A54ADF69204D681A07D4061A251669C22B8126C13409511E3C
          5AF14878188C707804821D83C13610023160F06377767666EEE97AF76AB4B2F7
          03528F74E6EE6A46FB3BE77FCEB97756ADDC50C56F174C53A4CCACFFB7294008
          0C019084657A3094E60AE09682B9F5E704D0800FE8EE41584056C5ABFB76A950
          569941A2CC33A240098C6F7804D1202288569844102DA0052D70AA745D903602
          4A19BA80F6BDFD7F5C38E37BE6768F00424A85CA16FE641202A0E961879FD24C
          7A7C3146C794634822EC5BBA9C85F32693D9604D65F57D86E5D3CD2C406904D1
          E0B81A8504C20A0A25821BF3D15E9C2CBB03B420A283F480E47DC7D5DD930351
          E484438848C65229A552018816C394A07F440C03453CA6D1710762760F054404
          DFF1418CEE48122C68446BB4167CDFCF18C0F179738D025A13A88BA4FD8EA000
          D7F1D16E1C9C18882008A49523EE68C4F48EEE72EDE3795E6AF515AE1BCF1880
          EFF94601113EADFB82C6F3D7D25B3760F4727C763E55619A304D0013CA95A230
          7F7FAF04B4E06B1FDF83B10DB7333D6722883038D2072007709452BAE6A15922
          26580B48CA5432E64E8A477C23E3106DE55DE6DE5F02822992B9986F4BDE2CE4
          77735E40FB3E71D723DED4CA00E706FDA64C0181FB0E1E60FB9C194F3CB86DCF
          33803FF1DDFFEACE833BE5F8F21584522510237F1AD7482D0A44072501254850
          7F052278AED0D256CFF10B6FD370742BFD8E5C23775801914F8F24FC13F2860D
          A578DAB4C7B6CF2A5B028481509FA90F28CF9440F95A83A46A28418782080664
          A09226BCB9A7055C176E765C23744131A1712479854371BEB810F48873F1027D
          0B863262EAB7176F71B57C7F77D552203EE33F7BFC1040AA09059D42275DEB40
          67520A8981078616C1755DE28E4FBCA99D7B1B8AC81B3204E7C279B4134FB88B
          8EA7DC3EDFCC6D43EFA270EAE42736974D7ADAF4449605A8F11F9673ECD0CB88
          D6A6D1740AE00B5A7CFAB777F281AE00241D8EAF3DDC04E88EC800C6D50E20BF
          607012644A08692E22D8CDCD0C1C530C5FCF5BBC31EEAA9F1E3AFA6C3005E3BF
          3B0953F000A334007CFCD6567E30ABD4A0C5CCB6472C66D3D1504FF8E26CF206
          0D4A0210E9198029A3959B8BCAED8375F91205F7942EDA08C11480ABF16FB4F6
          3CC4C4DCC78C2082E726E04E17FC73C27BB7D177F0E004BC31E80B312B123859
          B979F42A1A45D3DAF5D8AEA2F75F2BC8AB5CB328D809C5F53084F4414774AA47
          C4F481EB79D87617BC8EEC8FB7903FE84EA28D8D06983980AC3C035FB701DB0B
          11FEF30AEC55FF20BBF572B01322BE6B4E3740A51F362A19801649EE6ED16894
          F644E6D9BBDEE7B68177103D770E434E0313489F959F8237AF7F9DA89F803FB9
          9CF86B2FD25CF511B576AC42017DDF9D34A115015470D406E60321E0F2C2E771
          1C9BEB9D31464F9CC0282B42BF8D2F6090E9179339580978EF7163B8B0E9AD04
          DC22FBC915F81B56D2B47F3727A2B195152D579FB1007568F612FEF2870771E2
          1A14E9FB301AE1ED0F0E33B3AC88938D57B8DDEACB98A281B4D91E2D0F2CA078
          DBDA6E70802ED973C9291E41F39B95D8924D764276EFB50ACE26E0C723B1975E
          B97EBD1C889A120475430085424CE77AAE4B2C1AE1C4D92F69CBEACBDD23FBD3
          D2E100608D1DCB09F761C66D599DBE836225E12369DAF80E36E12E7852F6867D
          BB3966DB2FAD6BBD918403AE6566DAB81140345A48C23B3A3A68E98C92ABF219
          5DD89FCB6D0E4A54A09475F73D1C737E41C996578094EC394585346FDA8CAD7A
          61256AEE26323FB36F2735517BD51BEDED4B81081007C44AF1344A615E1E5201
          B86ED79C7752DB748582D2528617F4E3D2CD58F0BA957E2AA9B125D4380B997C
          A0929C51C369DEFC0176A837D6E22EF88BD4EFDF45756764FD3B91C8B274F882
          3E7DC4025C27EEEC7D7AC587D30580D4C8B94E8CA8F6B977C6340A0BFB71F146
          8C10183288299459C99E3081EBD126DC4DEB89595F236BD17378EB2BA8DBBF93
          037983AEBFFFD5C9BF011D18F8E73F9A2BCB767C8402C2408E59B30065D63E8F
          ADAB39FDAD6F16F0559B631417302FAAA21421D333567608EDBA54ED6FA0F4F4
          3EEE79680EFA5F2B93F0AA4874C39698DD05BF66B2F7EAE6CE1580F25DBBB100
          CF4C5B0C50C62D403C5773FE6A1463062E2830230BD909B81BB113F033646BCD
          B0F9F3A8DFBE1D67EF0E0ED8F69A6D317B19D00ED8805F377BB6E0FB00C4B5C6
          C26C3D6625ED73F4E467B5FFB4855FDF55D01F54CF3F0DE1043C1A897260EF69
          C24AF861D970767C729183CD61943568F5E7B153CF1AB803F8B5336726FBCD18
          9E084A447ABCA90221201BC89DF2F397CB479494FC6AC8B00140D07D84C3217C
          27C2C17DF5F4528A79DF19998457D7D473B5B96E4DDBE90DE5409B81EB2E38DD
          EC4FBB3E22446613539ACEEAD71F2DAFAD39B2FAEC994B389E9B701F1DF2B1DB
          DAD8BBF3332CD7E7C73346B2BDBA89AAEA5A5A1A4F1938ED99E181E123990398
          FEE86601B4E9D88EA36FFDBEBCF6F09135E7EABF04207AA38D3D3B4F62F93EF3
          EF1FC5D6036713F0535C6BAE5DDBDEF0BA919D18A0FFBD689590D9F045B0C860
          715733F9979BE4D0BAF9DA64D1FED97B8F97BBEE73D25077F111D142DFDE8A69
          A32C36ED3849538B4BEBC5FA3591A6CA2EF84D4CE623F247CBABCFFF0600E976
          3596B907263E5C89F65327E0B1377EA64C4F8481DEC62D40752B570C881AD5F4
          F0FC6229686F083A5CC8689903C860CA7896594399FF01072EDCA2FD0F73CD07
          800C110C420000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F40000001974455874536F6674776172650041646F626520496D616765526561
          647971C9653C00000029744558745469746C65004D616E61676552756C65733B
          436F6E646974696F6E3B52756C653B4F7074696F6E733BF2B3E806000007BD49
          444154785EB5570D5054D715FEEE7B6FF9915D02A944146D6A0C44CD58C17694
          6A8D56135BA2D68CA6196CB456DBAAD58EA3314CD2D1C46826D3A6B61DEB4F9D
          D43A264622A9FF4048065121540922A0469936D6CC446D31F2B32C0BCBBEF7F6
          DEDBF5DEFB9657B532CCB47738731FEFDCBDE73BDF39DFBDBB64EB9E6AAC5A3C
          99400E82FFCFE0EE99730EB8026A8E3900FA0986F41D1C0C00553377033000E8
          5BFE5C759C68FA142724510B3801080772AE2C076712396704DCF1330E44EDF6
          74297B17482C458028589C038C463E7E61E9779E121E696E00D008D1A62C7D3E
          577A18EE1AB5EB18720B5E72F81326877CAE7AFD4D2C9DFF2DFCB7F156E19927
          542CEA38DC00080317199A3603018F11CB41041B769882452CE83D419131E70A
          A50212F58BCFBA9373288C8FD3146392DF7B0210540232B82452ED2D41586106
          669940B8E74E06C4E6D4A4007778E7BDB58334C6FA00C018438C5D70D73E5CC0
          B14D0A665B8019168BB8CAD40163994C42173EA734805351C6591F0C708EF34D
          37F0F917AD77EB8603092645F9BA2DAA095D0428283747C6E3D787B385837151
          66B54E962B9DEEBA2F0041D1D8D11918F9E8E07B8AA8040731FBC9B1B1C488DA
          CEF96F53D118AC9CFD260871B2954088503670EC10714B1684903B4BC0C1DD9B
          43A20711ABC159AC24CA4740C045005DE798F2F84F40CD24586841D0BA862FBB
          2E6090371B5ECF30519E6F8EC900001D0059BBE18F626F554A0980320670770D
          A58E39EF6D34F9E8229E43046F69F5E36A931797EBFE89414322183F7128BA8C
          760CD087E093EA2E34DFD090ECBB84790B7E917368DFF6BFFE6EE30AC25457AE
          59BF4D72C498A24D8616C65C7D2319E277F4867C77EEFCDF3031670A0A56E663
          A03713172F04E13346E0D3E83CD097895FAE5A80DC7159484BFFEA6240C6E34A
          C19452C940CEB18D68A8D901CE98DC58A9825159CBB4CE2E1C655B00A9100586
          6070BA0F1D816E0C4A4B418471E43D35017B0ADB70E093EBC87C6428F2174C82
          4D19423D262296D9A3CAA0E99A2602FCFCC5CD3CA6829CE9B952BF9CF59681C9
          F9645109E6E4658B675DE34A7D0C1AE1A80CB5474104413841306862C90F67C2
          F0E8A094231436A111828ECE202CCBE400E25C7702DBF9DB021A53016C06EA6F
          EF25D9A567A61AC0D008025136EACE3721D93B00A15018172FFF038BE6E7C18E
          5050C6E0EF0C0971AA3F0160F2846C7C7AF9CA92854BD7070DC393064258A0A3
          75FBE1C2AD17622721B7234ABC700B1D9CA91EE192FED367CF23EDC114B4F903
          02D4F2C5CFC0EB4D425777184E33BBBB858ACB8846D7CD33CA4FD5AE1D36E421
          E1D9B3EFA8066059EC24E4D456B79B80E46280C8DE00605A162E355DC5BA353F
          826E1842A63DA68D40302459849416739DD666D46F5A360C83447B6492943061
          B7413F9BFBC4AC970980D483B9E3DAC195E639877B304563EBCA3FE0F1AC8750
          5BD788115F1B84E953C6A32328EF06A744AD6D7EBC5F548CEB379A9191311873
          E77D0F89495E99875C84D4542FCACBAB71B2B266C781BD9B0B0403354FAFC72B
          6B66C2B4187A2F75F5488003C5E7F0ECD3E3E0D1094665A6A3A2B216EFBC578A
          FC1FE421D81D0254C6070F9661F4A81158B12C3F1AA01665A52730EFB9398850
          2AFC03A3C1DFD97B048D8D8DAF961CD8B91540C47D122A0A01020208B92930CA
          6FDB5216DF9EF0756CDABC1B0B35800AA9CA4EEDE80860F2A471E0D030313707
          671B9AF0803711B7DA3A05488FAEE3EF573E4734F86E0011004C03203690B188
          CA5E068CC5171E0E597686E395673166F4A3D0741D11CA04309B3264663E82B3
          F597412316EAA34A792C73380C5D4A32C228825D3D1899351CDF9DF3D39F2949
          EA04C083AB5EF94BDB6B05DF878B7835CBC7F2AA263C39F9313066A1F0FD320C
          CB4847DE8C4968690FA2231802A09A1714676A1A71ED7A33863F3C14D3A68E47
          8472DC6CED8C4973F8D034947D740A1F7C78EAED339587571300BE652FBD5BEC
          F1C44DE52E080A839AB8C864427646B4B69578E3D515B7B3160AE80E99B0232C
          6A54A827C59788D4E424C199BFA31BB7FC9D88447D9A060C4888134CA5FA12F0
          DAEBDB420DB527B288A222DEA1E43EDF78350071B39F5BB971EE9CBC45FE4050
          2866C237C6C2888F47C8B4635FD598739E28496A1A01A311D4D4D42339D98BF8
          E8FA23874B0B2B4A76AF3054335000E1FB7DC5563EA3E5CBEB5B0F1E296DB62D
          BB13E05FB9D4F4D9F285CFCF4D229A019B51754CFFE74968F6845154546C5EFB
          E2EA2E5D37E234DDF0F9DB9AB703B0FAFB8344532C19CA12A7CF5CB476C68C69
          0553A74E425B9472AF37011E4347386C23180A21292101272AAA505D55BDB5BA
          62FF6F00F4A8A42D00B6C11DFDF53108217866FE0BF4E8FEDF33B5812EDF6B5A
          4AB20FF1711E24267870E840293E8B4A2D2BAA8859B366C0B46D41BB204406EF
          160094C834F463504611E80AC5D4A98EFA44DDD0D1130EE3F4E93A3436D4EFFC
          F0D08EAC86FA737FBA78E1222CD312652084C48BC0D2D8CDD6009B367349FF00
          304AC599DF1EE8764044FC6DB7F6EE2B3CF4F61BBFDAD65571FC64C9C7E5EF6D
          02D05A7D7CFF86E2E28F4ADEDAB9A7FB5871D95E7FDBCD7715EDFC5F2D1D9C71
          2EF632FA058031E4FFF845A0B76C91869A0F2E00589DF1F0A80DE150300CA0D3
          69EABAD3258B1F4849F335DFB812001076A89FBF7075ECC624B1CBA7EF1EB8E7
          6B659A9A9DD270E7BD32A6ECEEDF86FFA39FDDF43EEFDDBEBBB2FD372CA283E7
          D80D10D90000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F40000046349444154785EC557CD6B5D55109FB94DB45AEC07C43CAB9885E047
          5DCA8BB8B27561A3D085890B5BF17F70E1AABAE8524110175D57C1A61F2E62CD
          C654284D4490BEC46EA49A288882B4364D106A6A45DF9DE979C37C9C73EF2282
          18CFE3BC33F7FCCEBC9933F33B73DE456686FFB3551F7CDC8313677B805BDC8E
          7FF825A40110A0E820E3A6ADBDE61FEAB076327968001C3F71E1B9EDF7EC781B
          11C64110855D66C8E7D940816CE44C8F63DED6EB58D7B474FBD6C6D1375F3F74
          31C13470A0BAF5174E1F3AF85867ECC1DDA28F61133E9B5F86170F3C110621DA
          DCFC0ABC70E0F1C0541939610BCB30B1DFF4A2FDFCCB6FDD33B35F9F4CE29839
          80CCD07978EF6EA062D732C28DF50D9D6735828049664CD8DACD84E54AE1F8EA
          DAEF82A13B265F30F6D01EA0640F00AAD451BE38B3CC34E80C6C61B770326A54
          B870904D278B11BB1E03B1C9912626721E49044817421A5943E8B937A311E2B0
          C665CE052E16A028E5694364A889443607806A82F30BDFA5B06D40B408DD4733
          8BC50FE6ED64C258100609B8CAC003AC172EA9DEE8C87D12613B791E818967F7
          593E23DF80303DB304AF4D75819D61E0BB3A95B05727BBF9A10CEC9384BDD4F5
          9059ABAA0A2E5DFE090430221031F8C772EB3FD6E40307179C98798EB17D3C65
          B4EE29C04801D54142C83C40D100CF1887C0BA866C1972E8A8482DAEA80E5133
          02CEB770C299AB730E9A83E8C42D20CA096CA3464E3F445C94C71D47DF99DD78
          E6A947E4EC46B328B8574EB5CD9A184454B9D4EA8CEC842F2EFD00EF1D9BDA95
          D03F86940352B56AF116E3AC1B9926C7B3F0A2E7F6D4B90C03F64382A2B70847
          1C733518AA10E6BF5A2E52202109D21170C6C43C0F4C08E481C422B40491260A
          72C6CDE3A900A09ACB4254D794C0200D46D0BC9A054BCD50305FB5DC31141D6E
          5F5CDA4975DC0126DD57E439B7E7E167C616458226AA850CA42029C6A552EB18
          E260E2F374EBFD7AE3A62DB3BD883C9D2A1A7A7ECB13793A152366563CA88D82
          59050D8DCEFD3BA5F2B62AE1F389847D011038DBFE692593DF11C1F4842DC191
          A9AE5BE6489FEA3D9D7B2DE2F050057317BF6990B08E33CF2E84316EA42386E0
          0403867E59326CDE9F89B85988A82C97609DE36AA6201D536E981BFF9ACC90B3
          5EF1080371AB1272B1B384ABD16C0780BEBBD2C1D0139C759D1BB672CE712F64
          95D039707EE15BB8BE1A24040E0A9F9959D453E0A882C2115DDC6A49AFE74508
          D597074613095BD771CD7070FF3EF8BB5FCBBC935948D883C3894CAD1AAD2C3F
          3CD56D3A2CE2D9733D7845F4CA6A3E3C5CC1A773979BFF88C8C36CD623B7A1CD
          581A8280C288E3E60D4AF811B3E2062509994933AA6378A14FEDD19B8954FA54
          12D0F84328F34D0ED4A95DBFF2FDB5CE938FEE6D44537226673788EE97921495
          E16D6893458A3AA3BBE02ED3CB8AFB9595AB50F7FBAB49EC5B9CEE9D78F9ADC9
          3D2363EF63558DB8072184148F6DAE9AB4C9BB2613ADADAFFEF8C685D9776712
          701B350A77A7BE5DE47FF38AB6394EBAF33FB5F7F3F7C26DFFD97B619B32B538
          53EC764B5B38730754D1B95290F6807C0000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F4000004C249444154785EC5574D6C554514FECEED6DBB32518348412C54DA12
          A0A0581553D0679ABA5276C64535A18918350663E24617AE3426BA312CA83F40
          6B4213A3C6C4181706686BFB2A620C11914A2B424B4C1B038695C27BEFCE3992
          3977EE4C7BDFB38949E349E7CD64BEB9E79C39DFF7CEEB2511C1FF69A463796D
          FF4051F6F5EDB48088E412A8FB8F891096364907EBC82710BF7B70EC184551C1
          B9A3F480104002880320FF1A85ECAC1F440A8800C23CFAF2DE877B14C93B8989
          A8F06CEF0E451839FB797A1E5BDA9A14A0BC8B335373E8685F8D5AF6FED0B705
          001100530D8F190261A0546190F34E7A7312C1F98B97D1BA7EA5DD545C3FD313
          166F6B5995CF4C088D0D9172EE2916224268B1B0BA235F482D9D88922706CC9C
          618B8D39011B0390E2017760161863A03ACB5540B402CC9E2FA5499519E97A63
          CB6DA823D6AAD84381260868BF814714F8262F346308F77658FA1A1551920361
          1A7AE7BD61E9BAAF051766AFE843CCD6E9C953B3B872F51A964D9C26197BF3D5
          DD3D31B360DBA635D8B84185C6CC8823C657C77EC16B2F3D5A539CDFFD38831D
          77AFAB29CE13A766F0E076C5ABD91BFBBF7E08406C131071D9AAB108CC12E29C
          9C9AC73D9BD7D614E7E4F41CB677DCB9A43823C3AC748A40D20111E4C5A9A543
          5A7E091CEB760AA66BB17EFDB38176EC60664D4017020E3A33B380D9644159D2
          708150C588275703A423E05917E9DACDCAA84BC052F0FDE959CC5CFAD3822661
          6C6E5B612B50FCE102CE4DCF3B5A728DF8A34F4F64976282BA167FD1C14F2620
          929766EB5D4D10239A806146E7B6666CDDB4D6C24962102101F3597475AE47E7
          D666780B9C7F36813D4F7401A17EC86B7FE0E322F63CD9A58828E4886AAC8F30
          327ECEEE448E6B9180636178717AD3E6245A69767DC70AC8B36F41497DD1425D
          80D201A55835A0511C9F429A8961931327397FBAE7251070AC2BD59102844039
          196E38F81664397821C35415A75B036C6C12B95624AE521C24240EF0A7D830B2
          563C7EF257FC3E775545680CB6B4ADB0018E16A770FEB73FD42963A191E0D050
          31F4EAEF2764E70F8F8CF92A9177D0D2BC72E1B760D7031B502A6BBF4F2A0948
          4A307C1ADD3BDB6F60AD4E23D688747D70680CCFF4EEAAD67441207C7064147B
          9F2A840966826C6888303C3EE935E0B90B6EC39C1327029E950FA752F2732632
          01C2FE211450123622097E038303D5C5E96F6244C2F39E7B17200CBEA85FC28B
          10B1A43769A8270011126298B28A9073CDCE73E1E287C5273DA07F1C92B3C882
          0AC495A472FCF5B7BFE81687B141E1FE75F6C097477FC2CCA5CB1A88F3FFCDF6
          0F8E00800F9AA5A2D381C3C329ADE41101EE58732BD8A409F4BFD5FB1880D85E
          5FADFE0070D3D32F1EBAF8784F878AD3FBD52501FD032378BEEF11A8791C241A
          7C60182FF47567D717D1A57642C2E8C459200D5A06700DC05FC1F8BBAA3829A0
          C4E1B29067097B8A9BB3E06A2C94552002C0D54675717ADE193EBA0F1ED2CC59
          B2EACBF77A4DC28950BCCC88889CFFC5E2F472D2E5EA55B7A0BE2E725B39A935
          DD7EF30D3C05895C0497B2D394C4C81B03A8942BA5D1E75E192C48E85E421A18
          C7C7CEF8473246399B478A938A85FBC25643A65CFA064039AEF12A55FAFCF0BE
          DD001A00D42DF14AB62456E3922500D7E31A6F5A49FA26737DF95E5E556BD513
          F0843396D7E41FC0659F33EC3E73F30000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F4000003F249444154785EA5974F8B5C4514C5CF7D33763A908F309FC39D3820
          59096E85EC4441C46C66A3984008887F8220A241DC08A22B4514178211C564E3
          277091FDA8516120E9C574BF7EFDCE518B7BA9AAAEF483612E14D55431E79D7B
          F855BD37FB070707F032009DCF865D35BD271FF481E3E3634CD57EF9F01BEF7D
          FD93991D8612544A0B518200599A4D004C9090D6A8E1DEDBD7AE5C2ECC4C1B40
          AE0EB0C3979E7F12E7A98FBFF8F5E948F22C0652ECF22EFB6193664A80EA7CCD
          65AB847CEDC26C0F24318E63B75EAFEDE4E4C4CCACCA52D2CE044C62A40D4949
          8C12443554B8894AB003318E0356ABD5ECF4F45400C69A89BA5A03CC2E4712DF
          FF7C1F0FFE59E0714C6827131DAEDFFAE661C9C4EBAF5CCE4C4C19A08B52C038
          127FFEBDC0D18B4FE13C75EB935F6A265A036D57A4D20843ABF52E2604337326
          62CF004B89607E610F1C89C240C9440B2183013791991024801C0B26A2A14CA5
          609088A83DDBC73826F333000D130D0360D02D48C23613DFFEF01BFEF8EBD1D9
          984087373FBC533171F3E8D960423503CCA22241964C08BF3F78846BAF3E83F3
          D4CD0FEE544C540C50F41910B4C50483092CFB4DA47026262ECEF720FAE2D429
          1009119860221AC826CC7C0F1513F13BAF4D189004B92845886A9888920328C9
          BD645375265E62DAE1260CC0765EC5124009646E802513A121A16E52AD071052
          06559A4A800A3108AA98803351C5DC3040801D72E5636D99B3E98B483E9342C9
          042B264295D980751E00118894A40AE6C94E251011B901718B89319820802E89
          2BCD84C4900D6E00391316F90822A64E41C40490AC22276B26022A80B0083902
          3181059325A7D4D81A6821F4114CA8666214D0B9139AE598434A88B50615B139
          055171D68332813B988094FA0E302DDF399E9A774CC0AC38B20CA06B08238EB8
          05D297CDD07798620272D992F5429C45EC02C2ECCE9B900086A1EFEFBE7BFBC7
          4372C46A790A75F310AB6FC288D87247E62420FA2D1814A6EF8190EB3FFBE8EA
          730066C330CC97CBE5A5975FFBFCBEF2C55431E10040A69C82EA1BC046419DF9
          42E8B031108C6CFC7DBDFABFFABE6730A19689FC6723C0CE1D74CA7976067944
          4AF9B816D14258A4608BC542FF753F6C369BB5BF11D397CD669D990851742ECE
          98B39AA8FCDB2965DA620DE1D67F2E32337812EB75BFBAFBC63BDF2526FAD512
          4FCC2EBAA6B9910C6392F6376FF39A26BCB80DA1EDA3A9CCC4EDB7AE242600CC
          015CBA7AFDCB60228386A8E023B830784E801B1EFD18D60C34D532E183A4C060
          C2B2BC941F1846E8BB2AF71504474D1B285FF0038060227DD940F9FCB75354B5
          56BE8CB4D380A449268E6E7C75E862D507E8B60B958E0C90CF43BFBCE70DE9B1
          06A698F8F4FD178289BD8008D3655B3A04D0FB2000FD0BF987FE67A65B2F6300
          00000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F40000072549444154785EB5970B8C155719C77F67EEDCD97BEF3EA0055C0A5B
          6890F08C402D6C166D79944A0D655B6DA1B66E5331222D52B53E8A8AD8068CB1
          52539F097DC434B1518A52A514893C0AE51963A1B468BB208BA520965D97A5EC
          DDDDFB9A399F372733F7642E354D8C7E3737DF9C33E7E4FF9DEFFF7DFF995140
          F4778CB7A6787FE3BF58AFED1F7101E7474FEF989BA9ADFFBEA3D474AA4CF80F
          26D15D8520EFB3C94EEBC03F92CDBEBBEA1B2B5A77030140F207EB779F3F7DAE
          47DECB5E3E744AAC55DFEB10ADB5944A25F17DDF5C47B6E76087BC97BD75F682
          ACFDC98EF38007386E4841E3E81157E0FB828806A5400414F40DE4299574D5B1
          14224276A0402E5764F9E313993E7E218B677F9341F543492412E57D058AA500
          24BE73E4F0C120D2082400DF04A0C315061C038EA05002A062A0668C549CAF0D
          08A39B1A796CE3A758D0FC259A272F64EAA41188584E1055D913181C14B6F004
          C0804AE815620025F45A4250C4D20F8836F7993AFE3AEE6EBD973F77FC9A9F6D
          BA0F3FE8A64C0B5A0B82C147A26C689B4AD78C6D0A90304A8D10F83EB39BAF21
          97CF63A6255EEF37CC184DA150400B04BAC4C5FC09E6CF9AC7E97F9CE5C79BEE
          61CE94CF32777A1B49AF8684A32AC107DA66C0505009005061947EC9E7891796
          71BAEB68257597177B3C0B812EF0CEA5BF5253A758B4F0931C3ABC9D577EB58D
          B68FADE5EAE1E3705D97840AA90CCD8DB8DF73A8C3148EC29EEEB593FB79F4CB
          CF500AFA2CB64414482C8CBCFF2E82E0EB1203852CFD858B4CBF761CD94B8AF5
          5B963263ECEDDC72FDF2328646075519102DCCFDC858F285A0D2DBB9DC80A1A6
          58063FD9B523C416E22648952E94FC22A04DA175F67690AA6960D1ADB7F1EAEB
          477966DB2ABE70C7E3E8EA0CD81A0009F3ADC3B422C6D3D83001C18C31F72351
          131B4657EF494A7ECE8C510E0DE92174750EB071C3B35C3FA58DB68F3F60E643
          3C9B81282251B66975082C11A068D63DF9183D5D790CA4D876BC72589AD52B1E
          A1E0F7A3D1D4B8B5D4A8C1ECD9F32A7D3D19BEDEF62C63AE9E84E779388E83D6
          412C00B4D60088715613B436D088186F827A7AF55132E9DA6815FDB90156AE6F
          C12B83164A791AD28D9C79EB027B0FECE2E6E665B4DEB584543A6DC42912256D
          71543C0315020051A10EE8F0C41A0984542A4DA6D604C0CE7DC799F9E19186AE
          5229872783D9B6ED15BC6014AB976C64E45563F09249947210B182A475951085
          5589B9693C26E52254C408D108D1D8169DD6DACC1D3C72900DBF39C0AC89F7F3
          ADA5BF209D1A8EE7D540082E08C68BCD788C82970EFC8D6C5F81109F96692310
          2D2105A606CC580BECDCDB5E1124C771CD5CC7893C6B96FD8EC10DC33975FA02
          9DDD59FE72FC7C4C3C04A8CFA42E2F42D1C29C991FA4BBA79720CC46B6AF3F5C
          A811F3D3669CEDCDD23CED2A44C04D2470DC044F3CF4064A29929E67B8FED0A4
          263AF7B573D30D13B0E2298852241DC596ED47AB8B50C8E7F3AC7C7286D51740
          C4AA9CD681F1DF7BEE26945501D6DD7FD814A500284B8FD95BD16F8546558A30
          A8A24095274C7B0CF55A983AA58996EB6610044504C8F91731A74778F8C16F93
          4A3450D4795E3E708013C7F2B11792084045B2ADC32010EC126529C07681E9D1
          CFB4AE62CD537771CDE861F4E953465623A1E9CE9EA2E8E72894067082416CFD
          C3417EB8F245F3A0A9F48E186F9CA12D066C4D4B5C8A112D86BBC60F34B1F0A3
          CBD9B4F5B72CBE7D0E5D65503F2852F2F314CB1E84FAD4509EDF7098C5F31F64
          C89046128E83E54D231874B0D927969E90D61805515B78AEC7BC963B38F4FA56
          DADB4F33687891FEE2A58AE67B89341D27BA2137929BE7DCC9DFDFBEC8944975
          A022C21506B30A5450D8D313511057C21D7B4FD0DB9767F2F84696DCFA30EB7E
          792FCB3EDFCA40A9175323CAC1D119B66F3DC2DA2F6E245F807F5DE8E3A5FDED
          8884A0124FF5AE7DED91BE8422A7A8ABAD3114546500E6CF1E4F4F6F01041AEA
          6B983DED1E76EEDACD9C7963B9903D43DAABE38F2F1E63FECC258C193D8E74A6
          1639FE0EF3CAAD16990D4495037B931B674D04216649D7E1B9CD7FAA52421DD8
          B6033C2F45EB8D4BF9E799223D9D423299295FF7D37D36CDA205F7E1A552A15C
          62D50D10A8523DDBAEF17B362A87F8C3010194A3A8AFABE3739F58C3E62D7BB9
          323D8A179E7F8D156DDFA5BEA11EC76A7B6597126287A840C727AA9F05CA6440
          CC046671B4DA715DC68D9DCAD431B7B07FFF1BB44C5EC4C409D79248B806C59E
          0EB428B4050289C023F151F69962268815A168B9BC59955264D2193EBDF0ABFC
          7CC3433C70F7D7CC63D5BE1E86BF104C858566655245AEF23AAF42A5D4367DE2
          0281F683CE63EDE71A47350D236609071C8FEF2C7F0A37E9E2BAC9589475B529
          3CD78988834AAD53A6B086A4ABAA3F3779F3F839B40E3A8120E221B3E0CE476E
          BB6248D34F95A3866229B3A7B3B0B6BD2D28602558AA5B42245E025A77F774BF
          FD955D9B1FFD3D9053210D3580175E3BFFC32FE1EAB5029480029007020544FF
          84DDF07F35B19FE7F06F938AA4A4B21EE3AF0000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F4000005C349444154785EC5576B6C15C517FFCDF6BE6C81422956C016C46200
          69B142356A086F2E29A48209428C261A48043F98803186FF1FE323F84A4D0C7C
          50BF686262838A484B409E4A4854204154DA425AA52A5AD22284F2E8EDE3EE9C
          633B3399D95D488898C836B3777A66CEFB77CEEC0866C6CD7C4474FE1F0EE579
          4C2936E31F18226ED05936830C8D95011B36EE9C954CE5BE01884AB795C10C08
          A1F9C299726BACE499FD105ABC603872C86148A2A33D99AE751B5E58720000C5
          0078F1E42DB54B174E292A193554F30718EBF6346071BA2CA0DA3DF57B1AF170
          7AB25B53CC5AFF36C7171ABFFF7961DA27DBBFFF1840893100821945C5238782
          38A0C438C12C0C9D01F3BFF25B004C0C3296463D160CB5669D11EA8592D1C340
          8C22001E00A15E1CD0CCA405337328DC60618473C440C3134C0F60D65819CF46
          06B3592352365A1092D908569EB914B29D805D8803DAECBADD2ACC06D69B0D36
          DC23044312598207002449EF753A8DB630CD296210492C9835017DD93EC840F8
          4983D71AC1E0081875848D2BC246A06ED7F140757168BEBD1F5051E7D333EFC2
          9AF727A162DC222C79681D52C97C3435B7A3E3EC65BBA79FCF05CA460020E248
          0A88FBD15CA6AC3739B08CDBF736A27AFE642012F9EE9E0C7CC9B8B528859A2D
          8FA0AA720D2A272CC4D4F212789E50CAABD365D1B4A9B51F9AFE08190022E92C
          D5AF503D1380A8059218324B282BADC06D230A71E0F08738DC548F65B35E44D1
          F031281EA5D0EEF80273BA0A84E4F2CCC4C8CA2CC8978A67CEF471E8CE74AB79
          10EEBDBDBDF07D82947DE8ECF905D31FA8C4D9F64B7867EB6398317905E64C7B
          02D297C8C9F1423D826153808001D2964DD6CFE2D36F9EC5990BC743E0716876
          34E933247CF4C91E9CBFF21B52F949A4E756E2E8B1CF71E4A32FF178FA658C19
          3D118944129E50DA3550A3205404AD4079F5D5915D58FFF46B8AA61B0D41375A
          D6CC42237CC94C1D01495948F671A1AB03C43E269517A2FB621C9BBE7812F797
          2EC3E2D9CF206FD010789E0793F228061875BB1B94C2D9FD21973E2BC12D1D07
          C12063806A7DBAB4848D88A265298B9EBE4B06C4C0C5AEBF104F2550555581C6
          9F0EE0DD2DAD583AF775349D6C57AD8F64A40AA42455053E1132990CFC2C4172
          1F0A06DD0E80F51F9101236910195A9FCCE04CE7CF16E94278C84B0C41475B06
          9B771CC4F4F2E558F1E8F3183C381F77148F50983874F45418034C64DBA5E7C5
          3076C47D58F7D62B60ED916BA3EC3C6702627181952BE7814DCF4FC452F0280F
          FB7636E352FB30AC5F598B49E3A720914A41789E6DE1325A0592C8022B1E8FE1
          FF4FD52A30020483176D8C4E849A775DE9C6EA9A0A14E416E3FCE536E425F3D1
          DAD289FDBB4EA07AC62A2C5FBD0A79B9B9C8F17200219CF12A057475278416AC
          42184F26FB474259BB635F0316CD2B0B9F1100A424F892C0EC234643B0757323
          92D952BCBDB61E63C794A2A5F51CCAEFCE0F9691E1B527A8089C052ABC7AD889
          EB0B1C3A775C6F9159C6A14327F1C1A6635830F539D4FCAF16A5774E443295C2
          E9B64E23269C42C6355B31A17EF78F60164E9160DB9177EC513D21F4B132F3C1
          B12A0AAD8DB978EFD5FD282C2842F3A973683F7B5ACB108C9D7B8F2BC5F6119A
          9F98A20630AAD3F7E8905A4D6C53B0B03F05E633C4B675DFF7F1594D2B3CE10D
          78AC6AFCDE297966DF80F20654CD2FD3D60A17BD78DCC3D7DF9E8874427D6CDA
          1A17E10E687E488311507B62B1180E7EF72BAAE695BB1C9BB7E0004544CE916B
          7642C98E8185A977073A8799505B0E9DF7C1F39AE0726E3903671C5114844C06
          20A65C0C687442CC705172C0825D02A27338AD6422CBC2391AFC2C972465E7C9
          963343278C1F0921CC8A499C8040CC9C6841D9C28C58CC734417092527AEF882
          39F070A2B90D03FA00F830ABB955CB5E5A5C30BC78A3F0BC42860B6514FA8CAB
          1F6663AE30730EC65C63C6896430F1B9F31DAD6BF7D5BDB90D40B730404CAAA1
          E7DE0D5CEBAEBFEEDCC902E805D003C00F5ECB72AE27F8DF1BE570A846F43E78
          332EA737FD7AFE371649E05D1DF3195F0000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F40000060E49444154785EAD576B6C54D516FE7667A64C3B9D76AA03A58596A4
          A695B4E511CA4323D40885208A229AE606631122DE448C467FF0A3BCAA311A63
          30F8C71F261A0C2811B9A9402CA605830DC96D7C859412104C2A85B6B4B52D65
          A674A6CC59DB713F664DDB9489C195EC39E7EC59EF6FADB5CF11601200D2CC12
          6AFD539A5A469AE50020730F2925DCC9C6EBF735ACCCF465BF2784AB32B12B25
          A40484500FEA9E89FF934AA7E187D0268484DD761CE79791D0CDBA77EB6ABED7
          8E680137985C19BE9C83354F2ECC2B2A0840B27D9C3A7B05D52B4A940893D95F
          5E024BBC7F19AB96974270F8B8DA355479F8D8AF0701147116303E035222AF30
          3F00B2C1989FF04814924C649026508170380A479A28D91A42E131384A09D39C
          59B900C9191A62A6E40721D93224411B351048930D27460885C2181C1CC0C38B
          F230F0E7006E854288C51C2DC39E5BE0133A48E1C7F5350102C5C002822164EC
          25466E8F60FFD79BD13D7401960A72CBF1FA739FC3EFCFD2CE2A41CE9601130E
          11928D4F844090435CB25A966F8C33916814E72EB7E293BD0D09FDDBDEDE8048
          64143EBF1FAA1C29112D17230448C322A684800C9E52C25C398D64AC91E3C062
          72BEFB086E45AF29838E43B663ACB091671889084C9321501E36C72B381C8E4C
          6AE9E34DED6A67E9FC2048614D4A31245967E33CE70129347F73BBBAD7B14B64
          65793903533820881CD5568EA323B7789C882B5BBFBA1C5208DCB8D163124020
          493A4292AA1BD6575728FB279AFEE6AF00180578DC696869BD9C020262AC21B9
          8E25788F6C6728E3760192D495A123AE2573633380A9BB801CC36B5D1750328C
          2D888833403A03247506AC98E0599B7892107088524120C16D2C2644AFB72449
          BDA4A39C0099FE2776529A2CB00693BD946D4886DD542F6CCD488E88870AE965
          32468ECE066750828C614B92E4DDBAC0B61260F90404A263512C5910446767A7
          DAEBEBEB35CE91CA825E404F4FB7895060F1FCE9188D8CC19B9EAE0A57E8764E
          0D81244253CB6F088F4412512F5B38037B0E548D8B840820C414F6B6E03E3D53
          3B8EA7FEC5169C3AD70718E37EBF17D249E1804384D52B4A3116A3046E834383
          A081523CB6721EAA573C0A000C07116EDFE9C75B3B5E45B6B7404DBC33677FC4
          D933D7E072B9B06E7545620E783D2E9C3CDD96FA2CD0BAAD1890E9F3615BCD2E
          D47F5C8BB2B945E88FB6C1A1A87223141942EF1FDFA97BB72B1DF999653872B4
          097B5F39842C9F1FD2EA53BA58FF5DCE025B445C3D1EB70785852558B3AC1607
          BEF81FB66C5D8BAEA136DC1A1DC4582C62D403B30225F8F2504B9C6F4B9CBF14
          6EB7DB04C390F324E46E9D3088C808E9A5D9053A3A87B061CD0BE8B916C5A50B
          DD88394EDCF868C2497F46101D578631D0E5C186B5B5B87A7D181036103E2352
          1C468681DB1692341CBDFD23B83F381D2FD5EC8C67E1188219C570A5A908D5F5
          3EEF1C1CFEAA052FFF67378271BEDEBE30208569596154EAD69D4869C929213E
          BD780C1B4C3CE9E998575E89250F3E818663AD28083CA044F3738AD1F0CDFFE3
          FB4FA1A26CB1E253ADCCC3C3E8428A2E3035D0FCC3250C8722103C492124D078
          AA1DB3F373F0FC33AFE18D7736E2A1A565F0F973D0DFEDE052DB4D7CB86B3B3A
          BB4368FDF9BA92696C3A8F64CAF67B53BE11099284EAAAB9181D73180A489C6C
          6EC7BAEA0AF51C191DC5D667EBF0D9813AECD9BD09F51F1D8C3FBF8F9933F331
          C79B8105E54063731B1EAF9ECF66209139CD83A3DFFE3419026BDC8E4ABEDA95
          3CDF81F4695E2C595485E2BC4770B2F11C4A665661696595DA47E275578C9F17
          5C04A9DF882C493B92B923349310080472F1DF4D3BD1F9BBC0B64D7508E40694
          5666E4DA49D2089248310963319E0386D59E6C1C11E0F67830BBB008DB37EF47
          61513EDC6E4F62D808CB28780809C9AF735341C00310521B4E0E08A6A588BBC3
          E34947C7D5E1F8D563E161CFADAC526425982617A1B6132349E1F68BDD591573
          0BC6F166674F83CFEB61352A5AA92ADB9761261E98789FA9FD6217A4A4110031
          00C4DAF9A33463D5D33B36066714EF136969417EA1918CC53D10913330D8D7F1
          E6E9E31F3400B8AD8F061ED4C264C36B969BE1B9C72F64CEF01D00A30022260B
          527F1D33C58C6711CECCBF418C107F9E33FD05905608EDCC0B917F0000000049
          454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F40000049549444154785EC557CF6B5D5510FEE6F6C516838985D8DB8A2622B6
          A84B7995622AC5452DA89BC6455BF13FE8D25571E1465028A81B41D165D3A49B
          A446A551D1C4C6A07D09A268A55A6869A83F1ADB5AAC18FB72CF8CEF0D77CE70
          CE2682584FB89CC919BE37DF99F9662E974404FFE72AC68E4D617C7C0A7493D7
          91D149101108481EE8BEF6A2DCF10F31523F6C7603009D7CF191C77AD7375E02
          613BAC2402A8959648DDEE8BA710AE2D83B8A11B0160E93EB2787D251C7AE2F0
          C20C006E0028C2B5DF4687F61D2CFB87B67940E88E8B5FCCE1AE1D8FC297135A
          FA6C0E770FEFF463486479617E1E43C3C31953C19573679BADB75F3F0260D008
          105752F695B7A3BAFA1520E9757F3C358B72EB6D2088DF9E0424828BAD196CDE
          D6ABB67870B596E63FC196FB3658E098B6FEF24E847628011400480954370298
          031082C58D3F1802EB396B64CF3D03586D03081538AD8D22AB558170B033DF39
          A06A73D4911258BDC1EA901090B6A5748208B8AA00F2E08A6546682BC6540065
          428A07B76B02D9EF090B42C58A3102A8DA01DF4E7E846B4BE72DC51A46C93061
          FEADF70CEF19AA753CF7C6090DCE9A53E32000BABE69E46BE3E03D26588A25F8
          BAF9269E3CB81B9C095040189D58C4B3234D25A318F23A1FEDF89ED9DB4C9BD2
          7C93B50F9408B7280ABCFFEA09E0DDA70826046641FC13938C05122B4BB4459D
          2E3C3BD31D643CDCA7BB3D82C0A9065480DEFBCE00A40870DE81B123BCEC4262
          18D79B380E6E838D8067A066E7242C888B3B3A8D20817517242EF6ECC1AF0E11
          CF32B324E3B1F7D0CB537FEC78E85E2C5FBE0E5F2E786F2552726B2D0D4854DB
          29AA1CE8C3C95367F1CA0B23FD00FE6C9806F6ECBA1F41D912608028A6EDF0F4
          52ACEDD1E3E6B3481A1BA4B8051C88BE0843A320CC7E7E262981A6C445C71057
          A2AB477B98C0319194A496E1656217A7BF796229000E920E229D76E2A22150A2
          702F99247A30551BCA889162C4F59469910D630484EB7BE5754E865FD74F69A9
          5D262E46D26C7887A89982F236A4EEC187B367F0CBAFBF5B00BB8BDAA3132D90
          D537EBC8B18945CD82F94DDAA4BE858C2E50DED1070E9C4E4216C1EE8E082B75
          10C4AF8FB15A4C42B5065DE91DDF220E8C346364F1F2D5B8878DB541D0D32830
          3DF34D26C2E03D2FD1F0609295C337D784801C9F8D0C3BB7FF99251F449C8E4B
          D823101605838DA49E7900538C8FEB780E0FEA7DA802E59C80243713461D144E
          0C64B7CB083A4EFD42BA7BC66C9C8BBF17BCAD1035F0C1A7DFE1D2B28B10E212
          1EEF8A8904E2B8DAA91AA9C3E7AB8B6BE92EFE12C5E64D7DB1042EC220787CD7
          0358AD828B1000A9085BD8DF1553DE80B5CAF78F3473C26A1E3BDEC23EC5A5D3
          BCA7A7C03BD35FA66DC8C231CD16DD6BEB68A13410DCE541A29F60208680C8E7
          8B2015A1088BA26D7716AE817CB76526A79C52019A7E98149C6B2074D6A5D33F
          FC5C3EB8754B964DAD99F6AE0B3DBE9474A8F4AC233B4C4A546EEAC72D86F3E1
          8ED3DFFF845055CB002ACBD3AD7B9E7E7EEFC681C1D7A828062283D4F072F84A
          C99AB5C6B7A6305FBEB27CEEB98FA70E4F0058A13A0BEB016C50FBDF7CA2ADED
          E7FAE67FD54F4500EC59F71F7E17E6290D4A26B9ED4D5D4EE66FC7CAD4035EF3
          131F0000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F4000004A449444154785EC557CF6B5D5510FEE69A9AB4A1BF68CC4B95B610D1
          565C08F22A82A07551D3D88D09B8A8F847088212372214140ADA2E157463D3B8
          8A520826BA486A10A98D6E5CF86A1A6BA1884D5E486D639A26EFCC7873983B73
          EE7B8B08853AE13D4E66EECC7C67E69BB93C1211FC9F927DF4D9344E7F3A0DBA
          CF72EAE349101108287DA0E7CD84F0DF25F511FD70716E034027CF8CBDD8DEB1
          ED7D800EFBA302114494403C27E2368971F479500C0B12A8DAFD541198675657
          FE193AF9F6C024006E03906D69DF3AFCEAF1A72AFB1FDE05F1FC51BE9EAAA1FF
          C8A124B5CBF8D4651C3B72D06DEA4C92DB2ED4D0F782F9995CBBBE54FDE2FC4F
          6701EC2F0090082AFBF6EE024B92442FB1B0B8AC7AD12484786FCA6DF55B6049
          9D1CF87CFD76B491018B5FD8FFC86EB0A002200340F14B92CCC280B040349214
          E517D2E0520228854FDA1EF313B0780C11B5311B8F6205383EA87D246BA1464F
          825A7F2C97DBD5874A0F9072C385481098114501800363E2C2AF79D996E1E2A5
          FB7CF45229602A67739B448B9250CF900DDB8F0E49FDBABBB6C70A17936715E8
          7BFE09EBA7F51B84E1D119BC3E588518C360B73A97DB5E1BA8A643E9B62F73DB
          2B552F994A9665B8F8F31F0A4089C02CB0BFA2B716AC990FE25C3062A63DA694
          8CDE77293ED602F2167070126AF97C9E05DC3C83464C808BC748DC478FDCC215
          F5616EAE80A24B41187355A7462F11397153137BF5D2AB8B789599A5B41E3B87
          3E38BFFCECD3BD7176551C39192AA3DA26A2D3447A2E7B55BA76E0BB8BB3F8F0
          DDC19D0056DA9403716B8588967CD60B320D1C4ECA4BD6DB735F2536880D0945
          BF4B38613673435B4698FAA1566A412C89938E210913D33E0813D80A49A5D232
          BC4DECE4F4378FB502E020E545140203E2A4212F9A6D3367A9253256AB9701A3
          E823CEA732176DDC0D80B0DECBFB9CE6B3F28B500B459C26EA45025623AB4DCA
          4E2D63481B8A6FA66AF86BE15669A393CEF470BED1C8FA5B9EC891D1198888D9
          01DF5723B641DDA3F2D00E70E0D64D7834276123B056C0AF3FA264B27784333D
          B7CDE0C460D5328BB74FFD9E4951C7E396B60CE393BF349130F8CC8B1D3C9938
          1E535A4A7B9C4A9C70BDC5B5FF99A57911B13F980E00C45FCD2C1E88D3C43E41
          DA3AD323490AF132B0B46C4229DD4C189A140E0C64B72B034CFC748F8855D06F
          C5107F2F346DC23DD3434FD6BD72F6C26B6E859FADD462FBC9FCA5655C7D79A9
          3EAC33FA3FB952017033927043F1DC5B672077EB3170F2386627C6F158DF31CF
          E07070796C028FBFFC52A27614B5B16F71E8F851F5737DB6B51BE3EFBCD13486
          0D81ACCE23ACFCE9F1D5E1E6D5AB08CBD741108B252420112C5DFB1DE1766E13
          6382ED83C5B93934FE3EE8A0F5F6190734D642098034EE06300720842286050C
          81A39E535AEBEA5D5F03101A60ABBDB7ACB12E100EA6334304C0A54D1856EF84
          1B8BB3BF55F6F43E1A039199059D9503A08E6ED3194B98B1BDB22F2F698F6ACB
          73BAB3E700B2CE1E05E672A33687B5B5300FA051CCC6B653FD7B077A773F783A
          03BA6C64C458EBA49368535D61F3179363307AB6000882FA95A5B537DFFB7E61
          14C01DD22AB403E8D0F33DFC44DBD4CE7AF355FD34D2DF850FDC63D2CDC5291E
          144C72DBFB2A0EE65F3142FDEDAF20FD4D0000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F4000004B949444154785EC5574F68DC5510FE669398DA8A493076DB86861C6C
          B55E3CD8683C88D54B12CCC1F887F6A04215BCAA789022DE020A3934829722AD
          F8A75405ABADE68F82B612B42169C0838536824D30A698A6B5A6364DE8FEE673
          9337ECBCB70B4608E8C0EE3CE67BF366DE6FBE99DFAE90C4FF29B9FD8786D177
          7018F21F4BEF8113101108907C607A15A9DCF32F7D681F35CD6A00D2F356FFC3
          B5EBD6BF0148AB6F25484024F8A595728C308004212184109139881932D5D38B
          0BD7F6F5BCDA7D02805603C8D5D4DE7CF8A947EFC9376FA90FFE91E3E0C9B3E8
          DC755714DA65E8E43974ECBAD331731616B1EFCEA2FD21F38B646AFA8F9D1F1D
          1FFF1040B325002191DFBAB91ECA280883BE78E92FB3D382080404A588CDCD43
          193B79E2B37357A1A45F464276CD4D0D50220F20074056BE1845A6025482A499
          ECF15382069304693E8CCB53F223947E0669986A89472B1C50DB081294A8842C
          2D60B05329981D371F49368871C34584C8541366D68EF73EB8986EF483BDBE66
          4C1493648828E10ABBAF735582B6D7473700585AE1C0C2E5CB687B793FB83497
          2440017E1E1AC0B6F64E880114E30097B1416CEFE82CE524919E181CC0F6CE4E
          10A9E46A1B31FCE64B51096CC1A58BC8162E400488EB7075FA3C58B4AB780831
          7CBE8865D767D2E816F2CFE949640B8EB95668C6288160031236AB110F8144C2
          805B24424B84853224AB00D2383E4B922E22182510BA8004ED44D282AB05D568
          BDA2D4D604638DA0C5ECD64D76190DB8863332F5C2545B1B62A27F10F3BF4D45
          83CCD93FFEC13110341E4842BED3EF1F8B2A66E298EF37A96B6A010BA5124868
          C38C45C2B42F7320ED00590EFE05EE7DBA0B4C8FB2005F62E7335D31094D88B1
          F7FAD1FAAC612060786EC3164CFF389A7240335A8959D186CC92A16491422AAA
          30CC928BDB5FD530A647AA422B0691D50A54BFBC1805ACEE892821A59AAACF09
          F1852AEC3C032C4980D0821F652588C904238C049DF9ACB5CA45633BF1B1AA99
          5D01D212358CE152DE86F65537F0C21D5736ED68C5955FCF874CE9D526D3DADA
          2B37154618BC944E6897FAAD2D981A1FC1939F4CDD06E06A284181D8D1F508F4
          DA0C98763346DE1DC4FD7BC3242453ECD4A1213CB0B7031442DC0C0218393884
          B6E73B001212D9AB6E69C2E4D8A97212AA85D5B25E6269D828008906513AC0A2
          8163A22A56BAB46D415A3C480507A08CEE671E6AC9D0B098D5644846CD232221
          A3C12570B1EEA94C80D43890E1842A41F3809495218B93F65B52CC6EAC70A2FA
          782EEB02E0A74FBF2D9270128C371A21BF7FE72B00E283C82F50C4BEB649686E
          11F6C3812286541A9A5B00964DC281A61EF4BDB81B370A59F29085C091CF46B1
          A7FB3EB878982347C7B0E7F15633A524FCF8F351EC7E2CF809DC5E5393C3DBFB
          0E03782E2A0115249216A3DD16746F4A1A080E799080FB660A144C7E4113E9DB
          905463B26980C9E1ACD4269E87263979AD0938295582BDEC6D9815E5F7331317
          F2776FDB5CFE34B169E3ADA8A9CE057B5C1B0AF2B717B12A3163CAF5FCC63ADC
          647E8CF873E6DC0CB242611640C19E13D6B73FF15A774363739FE4728D7E8564
          E1E548256D5B6B937F12AACE5D9AFDE5956F8EF71E05705D8C07B500D6D97A0D
          7FD156C5D56EBE689F42FCBFB06ACD4157179ACE2C19C85A0F5D6B327F03D869
          9EDC4D6336B10000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F40000048049444154785EB5574B6C9C3510B6BDFF6643046D1EFD371B084254
          803891AA575E42428823D770410890B8542580389516955E7A012102524ACA43
          E271012E5C78A8EA813B0ADC40BD24DAA809DBEC26219BDDF563CCB8B677ACD5
          2ACA0F8AA52F9EF1CC6A3EFFF678269CF9C109473E2CC10714885280382409FE
          3F820342230C023217F8854BDF3E7DD7E4F4252EB2D31C7D6CDF1DE390EEE4B8
          462BD6D3B1DE1698453DCA34C0E8DF766FDD7CFB9B77E77F71264720BB7362FA
          F3E79E7AB89A4F8CA5A11222618A32B7141C07C5F26C6C70B4299DC0F4EFE6FE
          E91FAEB3CF50B91F611C0181B6EAE4F8185B6D75595701A3DF857841B19CBBD8
          442C5AADB33989489242182971961F1F6500BC1A8FDB11E0C658E6D051C68703
          1F3012011FD107F79F7BE8E7018A9BFC9C5C7B1843816500D0BF4719028CD137
          77DA72C6EF9868C738079FEBA0CF303B1976F62403AD37508448406FACAE9EB9
          F255F763F4A9FA1D874016FABBB7D6A28A8872F0C139B806EAC1E6CD7E66890E
          008DEECEE699900910D3300B281D90623C807C8BA72C2014A283E82274962C1A
          EF732081F22B0B8B8F4FE5B317B9289D626ED04E490E33EB7F1DCA04A3D54AB3
          B17EFECBA5377E8E47E0AD446028E243353E35BBFCD2F38F556767C69334B521
          384F5287643720086BEBAD538B57AF5D45F1A4FF02C58650CA54EFAE1E671D69
          FC5D81C1DB08B82E181904B3005E4252B3B57126A5C9290D0F35A84E28A999C1
          C05A5BBFAF844014D3459B9CACC1756138D34A531A167DC77BB2BBD16CEDD72A
          A323A825692B880504351CBD9782D8DCEB32A5D44638729B15AC60BAB1593F7B
          FEF2778B1822B7D69203A55F1CE945A4BA60A1F1CFF6E6D99086B648558B2938
          16308210057F6F1012B11F5251650509945E7EEDC3274F54672F96B2F25CBCE4
          D63A38891E9E308535B2CB9EFC7DABB176E1EB2B6FFDE4481525509E3C71EFF2
          8BF38FE6F74CFB34E454F506E4987802674A95FA7A6BEEA34FAF7F82E2030855
          340B4A5A435ECB8FB176573180C14A10745A4D6B292B71CE6690B852268F2F69
          C60A0EA91433C6CD36EE34092BA81A52F2F57540BB10C0A4D47D7B56B0D5825E
          4F6E34B7DBB5AC5C4E8305D90461F08B70FF30A2BDD9544C6AE9D33010E04330
          6C0884ADAFFDF9E685CB9DF7AD65B9BF5CE0D3CFE01C2B2900CE49D54400FA79
          1334765BEBAF87FA033C9C4539201B428027B3087E15AA868506207A883D443B
          A66179FEDC17CF4CD4EEC3D4AACC1D7553AA65F78FADFA8D77BE7FEFD51F6331
          AA4CD64E2E3FFBC443F9D4F81D146A40B029014EE537E593BE822610B0035DD1
          D6F6FE23D77ECD96507B10211D81121AF3096C166F34F65947A64D29BDEB4E01
          CE99706BFFB129AD6482CD1C1B6560791E8E5BB83FB71B528968CBE14DA9499A
          52384C536A079A52EEB7E13A6E6962534A37DB68AD3677DB32E9F1E8298558CD
          2CF87530C10F824FBCF1CCFB047F9BC2D9C1CD804D6987198C975643F9D7CACA
          C252BDF981AB70B1E964034D25553CFA02A9AFD348B461265F6A6CCDAD76ABBE
          E0E2A66958418C501A1EC1A05BA111BD40C0A48F8F20F9C8FF3386280F7D748E
          183655FE053D2C1C0B8D7849320000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F40000048049444154785EB5574B6C9C3510B6BDFF6643046D1EFD371B084254
          803891AA575E42428823D770410890B8542580389516955E7A012102524ACA43
          E271012E5C78A8EA813B0ADC40BD24DAA809DBEC26219BDDF563CCB8B677ACD5
          2ACA0F8AA52F9EF1CC6A3EFFF678269CF9C109473E2CC10714885280382409FE
          3F820342230C023217F8854BDF3E7DD7E4F4252EB2D31C7D6CDF1DE390EEE4B8
          462BD6D3B1DE1698453DCA34C0E8DF766FDD7CFB9B77E77F71264720BB7362FA
          F3E79E7AB89A4F8CA5A11222618A32B7141C07C5F26C6C70B4299DC0F4EFE6FE
          E91FAEB3CF50B91F611C0181B6EAE4F8185B6D75595701A3DF857841B19CBBD8
          442C5AADB33989489242182971961F1F6500BC1A8FDB11E0C658E6D051C68703
          1F3012011FD107F79F7BE8E7018A9BFC9C5C7B1843816500D0BF4719028CD137
          77DA72C6EF9868C738079FEBA0CF303B1976F62403AD37508448406FACAE9EB9
          F255F763F4A9FA1D874016FABBB7D6A28A8872F0C139B806EAC1E6CD7E66890E
          008DEECEE699900910D3300B281D90623C807C8BA72C2014A283E82274962C1A
          EF732081F22B0B8B8F4FE5B317B9289D626ED04E490E33EB7F1DCA04A3D54AB3
          B17EFECBA5377E8E47E0AD446028E243353E35BBFCD2F38F556767C69334B521
          384F5287643720086BEBAD538B57AF5D45F1A4FF02C58650CA54EFAE1E671D69
          FC5D81C1DB08B82E181904B3005E4252B3B57126A5C9290D0F35A84E28A999C1
          C05A5BBFAF844014D3459B9CACC1756138D34A531A167DC77BB2BBD16CEDD72A
          A323A825692B880504351CBD9782D8DCEB32A5D44638729B15AC60BAB1593F7B
          FEF2778B1822B7D69203A55F1CE945A4BA60A1F1CFF6E6D99086B648558B2938
          16308210057F6F1012B11F5251650509945E7EEDC3274F54672F96B2F25CBCE4
          D63A38891E9E308535B2CB9EFC7DABB176E1EB2B6FFDE4481525509E3C71EFF2
          8BF38FE6F74CFB34E454F506E4987802674A95FA7A6BEEA34FAF7F82E2030855
          340B4A5A435ECB8FB176573180C14A10745A4D6B292B71CE6690B852268F2F69
          C60A0EA91433C6CD36EE34092BA81A52F2F57540BB10C0A4D47D7B56B0D5825E
          4F6E34B7DBB5AC5C4E8305D90461F08B70FF30A2BDD9544C6AE9D33010E04330
          6C0884ADAFFDF9E685CB9DF7AD65B9BF5CE0D3CFE01C2B2900CE49D54400FA79
          1334765BEBAF87FA033C9C4539201B428027B3087E15AA868506207A883D443B
          A66179FEDC17CF4CD4EEC3D4AACC1D7553AA65F78FADFA8D77BE7FEFD51F6331
          AA4CD64E2E3FFBC443F9D4F81D146A40B029014EE537E593BE822610B0035DD1
          D6F6FE23D77ECD96507B10211D81121AF3096C166F34F65947A64D29BDEB4E01
          CE99706BFFB129AD6482CD1C1B6560791E8E5BB83FB71B528968CBE14DA9499A
          52384C536A079A52EEB7E13A6E6962534A37DB68AD3677DB32E9F1E8298558CD
          2CF87530C10F824FBCF1CCFB047F9BC2D9C1CD804D6987198C975643F9D7CACA
          C252BDF981AB70B1E964034D25553CFA02A9AFD348B461265F6A6CCDAD76ABBE
          E0E2A66958418C501A1EC1A05BA111BD40C0A48F8F20F9C8FF3386280F7D748E
          183655FE053D2C1C0B8D7849320000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F4000005F249444154785EAD976B885D5715C77FFB9C735F93CCDCB9F3B83399
          4C12ABA1819A1A422845AA360A52103F680545F18B285451F483895824540AFA
          A1012994A6DA181F69450A22A90A1A4BB186EA07633A99B44E7D24A599C978E7
          75E77167EE39F7EC73F65E0E93C36C86CB9438330B166BBFE0FF67EDFF5A679F
          0000502EEEA8C9C608228233083250CFF98E92B01BBDDD02C0FFE213BFFD48A9
          B3F27DA5FC630AC1D155E0E68090ADB915011448B6A7D64F0AD6982BE152FD3B
          E74F3DFC322099B711F04ABB2AE73F71FCD0407FA5C3416DC89B0B08A02403C7
          F1627D335B176616A263BF7979EC3CB01FB09B12B022033DDD1DDC5C68D14AAC
          53826478D9449442AD833940441005CA91241F780C968B585155C063130B0049
          53536BACE83D516200051640D689D80C710D7C3DDDEDE9B13812716A595A8931
          A9A901F24E04ECF4E4ADAF3EF38BF08728551501B102C85AB41998882042E682
          6493DB47C5AD2348B666ADCCB49667BFB631FDED04CC8BA73FFF3BE05D6DA972
          97E101BEF33B2A590152A005D8CD33E00E1A07D84622F79593CF7CA8A77FEFE3
          811F1C954C881BC5A250CA210398341959A84F9D3AF3C4232F6D2E42B7289B80
          7B802A5786CE7DE9B30F5487F7746FAC0070D7B0A12260B2B678F4DC2F5FFD09
          7017906E92813BEA649E4ED2EAD040373AB1581110274E11DCDDBB6EC740B58B
          24B555C007D41608B896106B3D35BF140E968A050796010B2E032264BD406886
          11B18EA7DE59037766666E66F2EB8F9DBEF0B4A7BC7EDCDD23CAC94100320220
          88C8EC62BDF60DC000B29D0C9817CE9EB808BC0FC8B94A6833870E16488010B0
          DB21A000FFCB279E3EDE5BDDF77810E48E88005857EF4E840882D8DB3189E3D1
          D9999B8F3D77E6E445476C6B04723DBDC33F5EAD82FEA1C1EEF5645A37004079
          0A05EBE5D858691D79E1C5CB3F7BEE0CFB81645B19D0A9ED1FAC9689B5C18A53
          FAED20E4031FBD32C7F2DBAFA217DE2609EBA48D493EA0D2EEAB3FFD5CC35A6B
          626DC62E3DF5A9A9A8955E7DFDC6DCB9933FFAEBF5E00EC0016C1CC7530BAB55
          502CE65D05A82C0A1865A8BDF23D7AEEBA9FAE83F793EFD84DB1DC0B268434C4
          A62B7E343B71AF0E1BF736EB331F2DA8BF7F12381200AACD379A073039F19F13
          AB55F0A4A7BC3E4165772F0028A578E8C1431C5CAED3FFDE07F1826E50804D41
          E511AF84E7AF12AAF8E40A753ACA9DBCF5DADF0E02419001E4803C90CDDBBBE1
          AF7F7EEA12F0FEB6A6928DCF9EA670F9D94F8F483401BBF228BF8C89C6481AAF
          A397AFD3AA252CFCFB2641214FE54095541B002F00F29F79F4DC43BD7BDFF35D
          3F281CD9CA8BC8F7151F3EDC87B9FA282229AE251A9004B10962126CBAEABE5A
          1BA73A01500150E8DB7BF7B31F3F7EA8BFAF526AEFC3D23E47B94E8802809E9C
          A136DA4BFDC618BBF77691EFF4F1C522D62092AE81B696436CA389B5118DF9E5
          11C004802FD0DFD35DE4AD7A444BFFFF2F221F787719543C87972BB138358999
          98219AFE337AF15FC4CB35C29AA139BD42695791DDBD83E472C151201F003649
          D2E946331988F4165E441931B1820E232AFB0EE077DE83E795B1512FBAF1C69A
          06A2C990FA3FAEE3F942CF5085F4DADCBA06E2B12B97BFF983F1B92795E7F549
          56E3645100719DCEEDE1CE0481C7C31FDCCF819646D265B0317816D1756C3449
          B2328E5ED4B416EB04F93C46174913A701FD97E7BF7501F83D90DBC27F810278
          E9293A9E7FE4BE0BB337C60E77ED1FA0D095C32745AC06A3D7041835228410E5
          6B5696C2114007800122406FF3A7C47676771EF6734596A66F6126E7096F5DA4
          35FF26D1E2142BB70C8DFF86943A7394AB25FC604D0325F7228294ED591A3723
          7A8687092AF7E1057DA4779748165F235AF827CD9B11532337F03CA1674F17F6
          CA3C800AB29E2E6CD39452A4B1C6260DB02D2045F40C69739CA4314E6B3E215A
          982757C86174019358000276CED2B0954C8FFEF1D2C0E03D05CA4387D955B85D
          FF76D52549885A29610CCD371769B6920940EF2481F00FD7A63E365EFBD3173A
          82578EE5940C173DB5CF1A8B5841AC254C4C2DD4F65653DB374667A3B3406347
          33F0ABD1996BC0B7817C5651EE63E774668038137EFA3F5A7488EAD33F5F2000
          00000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F40000060049444154785EBD976D6C965719C77FD7FDBCB4A5B48ED7422D1010
          564282AE4E245B16C62A64309D4CC5CD0F2A89B22C26D34CCD4CF49B9FFCE8A7
          65598271899399C85ADD2B8B9195B711B150D38EB585006EC2363AB6160A6D9F
          3ECFB92E9FAC2757EEE77E3EF061C9CE9D9373EE9C2BD7F53FD7FB117C207CB6
          C300F280F8BC05904F0956008B538920F2803CF1CCD1FB8A4DF37E27C8267378
          8698CCED4C400CCCA1FB668EC470EE463C0044C09C1A33C3D4FA4B37AFFFFAE9
          9F6F7F03D03C90148A4D7F7E74DBDAB62F2C6BC188502D83FBD6831367AF0220
          51A8513FC62666BE7278C89E0356460088096D6BDA5AD028A8E61266580A8599
          201826E06889F46A98016240E6F6715DDCDA80421B9000320720B86457210022
          AED628163007E8A42ECF300CDC74AE4F674922580040DC09D5226B336ACCED37
          88E7963189A48581AA39501FE67F6E1E35F5FF3C80AADB2C25D340C4C123B843
          8221E0FB2896CD9D4B6A834C7CE3ECF239E1F9BE0B00E22698430E8220005854
          BF801849BC1592A44D4E12418800C4D52C05182215E2FF4250CB984041CD0866
          B80D706608460846B91250559224219F4F3E5905A804A512CF4484422147924B
          A296ACC66C2286865A0098296F0E8FA1EA0EE64330962F6C66696B91C97FBC4A
          E55FC7B17BBA59706F3797C76730A063412393278E120EBD8E6CBA8B966D3BB9
          7AA3C2A58FA66AF28201B99CA0A6590D1877AF5F4A4523A1583AEF502A55187F
          E56FCC9FFD98CFEDD9C585170EF2416996F6EDF763664C1CEBA3E9BF6FB368CF
          434CFC7B88F1D75E64E18E5D5CBA0A664AC69FDDE71C4050F52800C0044DA922
          84C08D237D2CFBE10ECA674FB37ADB9D8CBC788477A767686A6966DE3B55E15B
          BE4479B49FE6F6C55CE93DC2FC6D5FC7CCD0183A447E6A82AA669DD0C17958A5
          232D4912D8D2CDE8FE9759FBB53B289D1FA173E766867A0E536C6FA36D6B17A5
          E1D398C2D0815E725B1F64692E41CD30A5865F4E0DD3AC0F440DE089C4CF3120
          9FCFB1FCFE07B8385D62F08597D8B0FD0EA64606D9B0731322C2D47F4E62A60C
          BC7C92C28E4758F7EDEFF0DE78098D99D1C043570135ABF7010C4FC5A964E245
          A5D85064D53777313A35CD40EFDFD9D8BD81C953273C330DFCF30CF907BEC7ED
          8F3C5CA56D6075FB3CD62C6FADAB070DC51CCF1E1C012005403D9B91150EA4F3
          74AECABCB06811B3D72609D76EF8E96D1D2B29CF6FC6CCBC8668B696B91352AF
          01F7520F9918B3061894A66738D7D34B38F63AEBBA567073F84C4D215AD1B98A
          F37D07195563FD7777D3D0D88424923281785ED1E04E2849AC0578BD3688FA88
          48A1522E33F2D7034CBDD6C3AA35AD4C9CEAA732354DFF1B673875ECDC27FB1B
          C323ACEC68A4F46A0F6FEDFF0BE5D959CCA4E662514A9D0FA01E86B57A8FBF94
          CBB38C3EF50C5BBAD73239740653E3ADA14BCCFBFE6318C6C073FBD8F8C5762A
          172ED2B16421C7F73DCBFA8777932F36A619CD0102349B8A4D0DB24D88774590
          CBE559BC7307C37DAFB062499ED1B7DFA775EFE374EDFD1100A7AAE7837F7C9A
          CECE65BC7BF11D166C7F9042BE505317C49C693D80A070E8F4652A41B14C4792
          24C2EAE52D7CF5973FE3CD1038DCF312EBAAC2BFFCE88FF9E05A00843BABFB7E
          84BE7D7FE2F3DFFA067757693F9C0C9C1F7D8F100C4BF94AB19060D94CA841B9
          AFAB9D9952A8ED073275FCDEDFFC8AD9279FA0586C205F28B2AA49BC5EDCF593
          C7D8B8E707D5B322E337958B57AE53514D0B772DAB5936132A807733EA42C1EB
          2142AED848537592EA8DBC34171A18FADFC7C00C410D3377621C43FCB4BE1C13
          C34570A42EDACD51DB079A6F7D2D97D57BC2F4AD15432486A419561F05915ED3
          8D830B01A8AB6819CD7A8ACDB656B1D5C12CDEC020D44781D608A96BFDC84893
          FAB702085BBB3A206AC087774D8601CD8D799EEA19CC36249606ED1DB5B76659
          6DA4420A04076C86F891202995F936D2A59F6621689818383B765BD7ED4BEBDD
          BF3E1EA87929C49D779319FD65C7E9D1313454AE0195F8346366FCFD733FFDED
          1FF4F7924B16639266E337CF28B50E9B79179D8260714DE151AD7C74FDCAB95F
          0033804AD442639C05403EC563F456740694A3F069A022917912A77C06CF7403
          02A000FF07FCC6C3B7C5C18B3C0000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F4000007E049444154785ECD570B8C5557155DFBDC37BC191C6786195B280396
          AA25D84C2A50CA771024849F1D42AD9F5A0D943AD03695588D365A6A0D9A7E34
          6D42D2966A51D332688A6923452D9D16C360918FA5B59430CCF0A7CC8F37C37C
          3F6FDEBBE7EC2DF79CF36E1889A4893171E7EDF76ECE3D77EDB5D7DEFBDEFB48
          44F0FF6AF4EF1E193EA2250A0B2FF9C7FFABE0418433CCDDDA55495C575A0205
          452A1110058A0844D1DAD502E1B93F2F8B171EB8ED7502A09ED9B1749752341F
          9719B3D4AD5BBE73210006201B6A1680416023D05A200C3CB9763791225AFBD8
          AC5F775ECCE0D5A7DEAD66406E7F70AA80012362AF1611FC69D3FB362BA43A43
          7C77C54F411101BC6E89F567C2F9F72FDE008100108800CFD53E1211529E0086
          B4C6C35FDEE8F70063465712019782CFBCF37313A7AC1EE80DA11FE45DDB37FE
          F3E5DA178EE17CEB2E61D1309C41F5230F213245A460982DA6C0C01B31808ECC
          299CEADE8393DD75681F6A84D1B16AFE8020C85DCBC80CA569E5A3B74EB866D4
          27362DAD5C8ADB172FC235A565BF5A5C5D312193CE5059F11C62CE4220314842
          8441020B20E28189480C602484110D08832F23E75DC00211A75069E92C555139
          36AFA824B9F54BF3BF5A9C462BBAB30DB8ABEAB6C2676B6AB696DF346A417363
          4F966104B13939C112B989151071C0CC1A2C911BFB2B8C61C65E81B29239C486
          5565D50DEBE74D5E38ABB82C0F9DE96348EB6EE48FEAC0A2399F9F35F90BE31F
          666DD4F8B22A6271C9C6048C1127A3983843C3E282B38661F7ABB5E404720434
          A3A46806690ED5DAC767CCBD7EDC0DEBA7DF7C0BDAD3F5180A7BEC75DDD9B398
          76EB584C9C3061FD92EA8AB95A42555EB68C620572195B56C4C8993156150B62
          BC0AC236BA971D78E6DE772CD915F75794161517D52CAF5CA1DA871AD09769F6
          E573C49BFBF7A36AC9545532AAB066FAD24F9501506FD49CB2241220374622C6
          027B2318C4C101F12A20DE935F3E1EE9E6F3045030F6C6E2E797CDAC2A0F830E
          740D9E80E630C2B3A4433380C1B003193584158BE6966FE9ABDD04A2BB747F9F
          24C78E438240602118277F6CDAB0AFBF868857C300448A4418AAAB8300A8FB7E
          3E73F5D41BA7DE31AEBC14CDFD0711EA41AB2623443AEC465AF70222D0DC816B
          C77560F62D37DFA1577375ED6F8F6C0EBA3B75C2CAAD0546322004F04646FB29
          301A82E8380B6395627B7E70304DAB7E3CEDB363CA466F9C376D1E7A869A0053
          80A41A03CD19A4D2EF81398BA2C4A701C062A43303985DF9199CFEB0E5A9F977
          4EDA5BF772C3513B86CC8C8CE90589CA8D210C4B5C02812F871389F20285D030
          526DE14BA9B63305070FFE0C2262AFBBEE932351B5FC7A68938188B26A6CFBFD
          19F475F9F99706084941B270C48B00A65B05B416301B0834E2A6D462C76848F7
          8340362B7604A2E08244023B371F9E1E28151866F20D9DB87BC3CC9ED28F4D42
          57D7491B909D7CD1DE1200A115831443981104ECA680E1EA76D91846A432BA17
          03D90BE8CBB65DF20B3021C7E793D78EB1D040224C00D9840AB200341B8FC504
          E6DC2489CDD3EFC90614840074FE98B1920040CF3FF476E4397015B9EB0B0386
          C07E582C60EE7CA6A5C972379CB5BF601B4572415904E297C51110CD2C275BB6
          1910B0EE278F63E70B8761090C7BD4BA00238C0DC80E400006431B0B94F4FBD8
          BB01A0C9D204B166DBB88E0EFC7803A4C8DDEBDC9727E503AF7C74D68120C014
          28B2D1FD645829C56602DB2311F8AA0D33DB15C8252C8848BDFFBBC70ECEF044
          880531718BC33EA008118804B9E7076202D27AB6E79E4F4D1CBDEF9EAF2F29C8
          4B04702C054D7D87E1701C9935DF586A9580088632593CF18B1DE9D38D1DDF82
          CF1E00D8B02D9D1F57DF0F7EB82C71BB3E8C00BFB5A5BEE18B6B123F78F58DDA
          67A7CE2EC240A60B4E37C46C2F0EB4E0627F8B5D2E4816E1CDED2D387FAEEB47
          A70FA48E818821B96708FC0D8C1C01E678445D3B0D27A03CFBF02F9B3F78B1FE
          48E76B4DE742E4A97C3024AEBF305B676124823C1C3FD28B77F7A77634D6B5FE
          0640E8D31528026B76E512A71A232E81971F7EFB70021C019D3A9CFAF6BEBAB6
          56CE264112585C0702FF12A190E9CFC3CEEDE75B3BCEF5AF039005C00D4D5B85
          5C05887DF38AED7E2F394BFC0273D3F895C45E114F20367D6C7F4B7BAAA9AFBA
          EEAD14E7E715821D73B0F7643012AFFDE11C77A6D26B52277B520034009934EE
          9B046F22EE16EE9A51AC1B57461288DF23C314C0B27B278B5742EF7DE578DDB9
          93BD4F7F70A80F231205F1CB49528DC4DEDD1771E678EFD3A7F75FA8CB05AF3F
          FF9247F3324701D940D8A926B00771C6BEA571C5FB405DE30FE352BCB3F3CC13
          EFFDE3E2A1AE14A0280F8A12686BD2F8FB5FDB0E9D3DD4FEA4BFA59AE50F4C11
          978D2F512E6B31369B78DEE331B424FC9A5C46C05FE4CDF477A6075B4E7655EF
          A9EDE8159D04F408ECD8F6E1404F5BBA3AD31F0E82485B24463C568A025B6436
          E2C6D0379CA542F60322452E6186C40AC0B1D6ACF1E6D1EFC4A5A87FBBF9C485
          E681EF1FD8D38DDA3FB6A2BD65F07BCD473B4FF8AE17C75B20E4A148818804E4
          1AAF808A51A08A014F10F69C92582DC7C569B2F0EE0AC7C893D9BDE568EE9F51
          FE9CAF4DFA65AAB50727FED67A1F808CAFBD055AB0AA02C22EA3BAADF50A8AF2
          E77C6552AD0A50291ED0F504F61E78A57131443297F00C4096C4BE6D0DB88AC5
          CF887CEFFEB971A5F95734021035CC482855AC884A287245C5201A199DF37BAE
          6E44349C0491B20ED047FD4F49C9FC205094081412D1F1D5FE5312FE177625AE
          E03FD8BF00196F58C9B4A5281B0000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F40000072049444154785EC5977B8C555715C67FE7CE1D18CBF02A30742C8542
          794968799662AAB50A8829AD4DAB3469156AB5FE6535485313C5AA69A8A9B142
          B55A6A8C16090315CA2094222D5405913EA633E531AD940A33CC5098618679DF
          B9F79EB3F75A8E3B67F77813464262E23AD959E7ECB573D7B7BEF5AD7B720255
          E5FF69C196AD2F72CFD23B02FFECD6FFC6345E787FB16283645104A49DBF3C10
          413FC92D60E2A5805E0C40DAFB9DAB3EB1F0A3C34B56A7D3A959A82625A8BF4B
          4C7DC09B82A2A824D94323871B5BB38FDEBBF68DBD40146F5F144000A4876AF6
          B9F10B96950DB966A23F8ABF3957F336E5B36615EC7B3B5BDD179B33B3101DD0
          5EF7FECCEE8DBFFE1D30216681FF0A40AD960D1E3914D3760CB4B0DCA6EA038C
          1C574480C6D583064AA0DA07607F5F2C70F78A7A10949682443ACAE7B8148094
          C95B4405ACF579FD0F62ADDB47501FC047A308B006051274A0800905204562FD
          6A00937749506B0BD58A12458A1A0341921C0210C14636018D82E0CE01984812
          A15F02406022CBF1975FA7EB4C9DA7D84B1734E0CDCDFB3D9E842101145EDF78
          10453D2CCF063601C0A55A101C9BF50B167FED3388168C2E4A4045E55B7CF9EE
          B93133419C455160535FECBEBBE616A4F1B1279F7D15B67C0E5F649F69BF0C88
          28FE42E324F8441A27F7E3E6FB2C885A44243E1F10C4DE4515AF812021A7D052
          09005B30D39E628D8527805BA271128BB586EB278FC68A01B1048120E2014351
          0A8022A0D803E99F8144E0C99801AA05E206143196F5FBBE4D7DF31100B6D5C0
          B85133B87FD11A942252B88165FC9861CC5D583EE6962F8CABACAFED5850F9AB
          E3758059F9CC7C4D1AECD031FC876B7637CF9E3E96F3ADDD249608DE235055A6
          4F29A3B26619AB96FFD61F62F5FA07B97BCE068EBD779E200818523A90A1A569
          76D67CF5A5FB6EFBC692ADAF3CBBFBE99555F70079C0AE787A9E2A4122421165
          F1A7A66263D5FB3907D8B4FDDF42BB111447B78D426C95D2997B9FA6AEC38C1E
          32D3513FE5BA32A64D1D4310A4400C5B5F7E9EE993662F19537E25D326CEB96D
          F9AAFC17373C7E740BA0C6AA459554A108BDE804F5FDD0C23EA804882A22A022
          2E8658AC052B4E03A096AE4C3BA7DA76B270DEE769E9A965C18DB733A26CE84F
          6EF8E4E81140FA972BAA52228906102BA0200AB19E3D070E8CDF17157756AC22
          5814E771CF22586BB1C6F26AF5EF993FE366A2A01123797AA58E4FCFBB7D747B
          FBF33F3EFAB7E68700FBCCC355FA21032A92A85F5D95C924782DB8382E668D3A
          0654C579F76C2D2A86D367DFA1A1F56DAE9F3499CEDC07EECCD98E63945F3D90
          0963277C69C983536E010600A90F35604578E5AFC7696AE9C29BA28E09808ACA
          3709025C751F9B78256241D420AACE5BAB442622B211DB0F3EC5D2C54B69EE3E
          E634D39669226F33F49AB7B8F5E3B7A6EA1B1B7E5A36B674C1F9869E0BC918AA
          B2A84F84C60A38FA13E56FDE5EC5BD7D2214141B19C25C06734011A723EBBC35
          4A3E0C79E31F3B997CED750C1A6C211C8655211B7673F5F069284AAAA8839B66
          DF34B5B33DFBAD6D4FD5AE4E00584FBFE71B92BB98766B31C6B84AAD28A211A2
          82D5C80108C3908A9DEBC88759D6FF6113D78C1BC903CB3F8B51839190E736EC
          A3A1AED5777365F9A4D23569AF7311F182F72A24119D2585258AF244618E9EEE
          1E6CA48EDEBCE9ED5B19D7825C36CF13DFAC04200A23D66E7F0063F358891C00
          6B9403158DD3804EA017C87A064C14852D274E368F9A306E140AC96B55401457
          DD77D72D218C721E24CD3D2738D759474031C6C2CF5EB81F80A220CDF2856BB1
          463036722D321239904006E8F27F4869C002D9B3674E7CE737153C994A158D20
          169F6F87AAF09783031812CC67E4B52D2CBD730928D45D388455571D3F58F130
          0A6CDBB187F6732368BDD09B13AB254643AC1A1C13C69746041800DF82EC1F37
          3EB61DD8030C481A90F875505C549C1A3EF78EF24DE5E365427A701791C9A2C0
          99F6E39CEB3E89ED1ECC4BBB5F6BA8FED3B9AF44B99FE7EE5A71C32197582C46
          F29E016FDCF9D074F5002CD00364FBF9360880948DA4A3F954E6911DDB0E6F5D
          F6F559A9B63003A8BB4AD323D8FAE2BBD27C3AF36894B327818F58ABB8DE4B41
          0B7C51EED903D03820F46F0160EA0F771C1C3C726045D56B8DCBA6CD29A537EC
          A2A4781047AA9B3951DB525957D3BE372E2425FFA9011B220E40F25AB60269F5
          8A02BD68D6A0800C03644E1FE97862FFA0BA45E327CFB88A9280A8B7983FEF7A
          A7B56FFF47319382AB10C7807806A4A0AD0E50EA323FB50408BB5AF24D2D6732
          8FEDDB554F49FA0AF6F6F9960F7A1FEF6ECD37C5EA1640ADA84B2C0836690149
          0B20C5659A9F9A53D56D3BDEAD69D9F3DED10E6AAB5B0ED455B7BD10CFB60104
          5CE1583194960CC3A8412C246D061525CD65D8F4855769EDBE268010E86E6DE8
          F9FEAECDF533DA1A338F009D6E3F612AD7F8CFD6BFAFFD5EDBCD78E4A11C0272
          71118840E1E7F9A535E0CD7FCC0E048A8128A6DEE28C541C1B045C011479E680
          9EE42CFC0B0825EA9D3F7E69320000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F40000072949444154785EC5577D6C95571D7ECE7B6F57A02D02857685D209B4
          603AB60E5060CA1456342AB069B2E11F1B24269B26CE28AE6C59C6442543C16D
          881F5B9CC6C9987319A53A681DC4755367041DB67C95AF4EBDFD58472FB72DFD
          B8B7F7BEEF3DE7773CF79793F77D03DC8425269EE6E9E9F9E8F93DBFE7F79C73
          7385D61AFFCF269EF9C59F79D0F09595223CFF3F08C099ED78B6553FF6D06A9E
          B856B2E2E9E7FF84CD5F5D25003816220F810F4A8CC2C84BC0C2F9F6CEA63B27
          1595FCC071224B000D6D73083A0D617F870F0A6F0C1F4F4AB58D8E0C6E79EA3B
          F7BF094019E86B1188DA3E32B168F24BEBD72D2EAFAC98822BC3EE3B781C5FBA
          6B910D2C0066C224D168D6EE5DB728AC0DAF75F75D5EF2EAC1B6BD006EB20A5C
          1D3D24B9A335CA67CF9CC2B96B0D683F399EF1B3B67F1BF82300B073B68740D5
          ACA9B9BE2C88C12DAF028248F9896B8418083E1514961C36B8DD43B0DB84656E
          7B22B249E66D81E988E3180424FC2036909F7520910069AB527889C06352E41B
          F73A1420B4FEB51389C1B1AB2F9380F1419B65277CD92DCC5A3BAE6A5C12E2C1
          7512D0A85F5103C529082014A6B13967B4C52179855FF7C696D01A3493D5DC01
          DB7F7C287CD32084C84B00443A6C3A3F5B1B89C1CB2440205E21CA8D1594527C
          B8E69A3279903D335CE66BDD04C75740112FB31702A97DD793860521EA0838D0
          105AE2E69A72C0F4020A11C1C60369C1CE2CC84D00114ED412C95B024D64835D
          51E7903121789D33DEFBE6B7D01D3F096EED40D58C3A6CAC7F06A41D3811CDA5
          9CFBE169F8F8DACAD9CBD75436F79C1BB973FF4FCE7501900F3FB7DCBFD45158
          791411DE32268C0F0426E41BCDCB6C42089BE1C20565E8EA3F812D1B7FE5EF7C
          72CF033873A10FA7CF27B81C934B0A317DEA24D47DAA7CDB17EE78B0B231FDF3
          DD00D61BE85D5FFBBBDAF4D3A55A43844C6886AB56CC8754641508D2DFDFDC8E
          7B8CD15859A940CA837A476324F32EFA474FA07CF26D5CEFEA3933503D6F2622
          4E048044E3EBAFE0E6EA45EB2A2BA6A1B67AC9E7376E71EFD9BBFDD43E005A2A
          ADA0B5EF019062792DF857203FC2EF03AF5B0312EF031BD1D69F4DA4904A0DA3
          7BB419AB97DE8544B203F51F5B8BD2B20FEDBCF58EF25200D19F6D3AE610854D
          48640FB78045EE870C3890E600A48809131434B8E7B1560410414A0FAD6D2F62
          79DD0A64452F24B918A718562D5D5BBEB87EE6F701141A38CF351C13C14B4841
          BA1C986083222006E1ABA3A4061B571B10F158F13F4974BD7F16BD83C7714BCD
          7C53A63EDEF3FEF06954CC2AC4DCAAB9F7AD7960C12701DC60E0F81E584FDB70
          6AE7D3A1C78F49F0A8560367CF819B228D69CB368014405A1A68EE95D248F59C
          80101AAFFDE359AC5F731FE263A7A1486228D50F57A5302EFF8995B7AF74BA7A
          7B9E2AAB2AAEBFD4931CF409A82C6179C30E687790B314FE3D00DE3DD4829ACF
          AEE552484548892AC833BF01B18F54AE67050A4B67E0E8F93F6241752D8A4A14
          E04D6155D2DE18664DADE5D39CC830962D5EF69191CBE96F34EDEE78D227C092
          A61350E97E9620FCA60FC76290C93E3699E72978374C662548670D084A679980
          9B4EE2C5032FC0CD66B0E7D5DF62F64DD3F1E58D9F81D412923CFC7A6F2B7A62
          03D6D078B8A2A6789725002D5DC58741291B37F8ECCF4A822EB90DAEAB90112E
          92A329A8AC66795D396E90E212643219EC7AE879E6ED791E7E78F03148E54251
          36478049BEFD726F2D801183718374D4965C65D22A3ED879A1BC745E354717BE
          0084A2B22A64A9108FBED4004F7AD056A178B21317476210288054C08EDF3FCA
          F31111C1373FF73D2849902ACB2592946592005206A306AE818A827D0EB7339E
          6E902FECD9ED00D3799B164C8418004A6F41955B81E8BC62DC7BF71AA61D1B3C
          02A5393B6CDDD4C099341D380C7D6922DC9171494A47A5F6A0B4042B21356CBC
          AC8134805500DE23872EBE06E0B09DB30284FA7D4F14440B9C691F5D57D15831
          87E6454B469195690EFADEE5F3B838F66FA8B112FCE1F5A3DDED872EDEBF35F3
          4BF78B9B6E7D870393E2B7C02AE0E3EEAF2FD4D603500669032F081AC0CE3932
          4BA9782CB5F940D389A60D0F2E7286BC14AC53501C2D4563F3598A77A7B67A19
          D50560622E20D79EFC128493E2B155C06F12791B93A0D8F1E123C5A5852F1F3B
          DABBA1764931C6BD514C2828C2C9B6383A3B12BF8BB55F7EC32613A5B00794C7
          AF65F8635911100D7D59D0D78C2A04AE2098EA3E39BCE32F45B14FCF995F7723
          260864C70BF056CB990133FF5D00495B6728055680C82A40082BC0841C5C7FD3
          F6606F34E1F627DE4B6D6B6DE9C284E824BC61FA44DFF8F6B101B7DFBA9B0CB4
          22CD81090415948061097E200208FBE53F6D4307CEB6270E5F38358C8EB6C4DB
          B1B6A1FDF66E4B4B804881DF8AE20953F831CA8D79CD364DEC81EB6F0B57DFA8
          3B5AFB61CD3A36D0937CA2E595AEBAA1DED423F671F1424A657AFF35F0B71F3D
          3EF4099FB9474772F336091001F9BF9E071EC867C888FD582D30C85AE9955D77
          EC5A91C124DE1BDCB46478EF7F01B1E9D97644874E9B0000000049454E44AE42
          6082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F40000092A49444154785E95970B7054E515C7FFDFBDFBC88B2490F7C3007608
          09091888DAA98F22057194228848AC76846A9101493B15EBA3A28ED8AA85A015
          C407EA5414908708A8882DD48AA03C1422490864939004926CB26C36D9DDBB8F
          BBF7DEEFF4DBCDEE7461068D67E637DFECEE647FFF73EE3767368C88C018C325
          C5626714297AE29293305814850BE8A2F7E32AECBAB44C978AE390373D353DEF
          670569D32C2676BD4992261091CC2456C8804CE2E4D4B9D14580A1EB54E70B6A
          874FB5B9F657AF396407A00B789478EBE503C4752A1F7C75CEAC6189E6C712D3
          722B93734A909C5F0A4B4A1608061252B321C932B8EECF0C0E74678238548F63
          92B7BB694176CE591C2DCE3AE1F4A8AB66FCE5B38F01680243C0719992E23B7F
          63D9E4ECE3EBE76D1D593E79DBD8D92F56E64EBC1BCC30C171F463346F79022D
          9B1EC1F1176E40FD9A9BD0B6F56EF83A36837B0F2179B81F859557A1E4B6DFA2
          6C4EF5A4E28ACA0FBEAC99B965C5FCAB0B00C802369409C89563B2DE2CB8A66A
          26D713D1F8E622E8039D20C90C2E11B81E00F1102C496680039C3834EF39582C
          6670D980A1DA01D50BC96FA0B06C02ACA9593375FDF3B07C6E740A74F900B1F1
          13A68E183B057B7E7F35AC5210C346A48059658000CE0924E09A90190271EA21
          0D7A20005956C46B194C0D40EB7722D8DA88AC9B96A1FEF3DD37471DA1A14C40
          32742E31FD1CAEAE5E83FA8D2FC0D1D506739206C9C2C0A04196C2528A646572
          005282074C7322A4881092040A0541DC8A9471B3A1D8BE816E700060437D04A2
          23C3EE6DFD6C74EE55B3907FCD2770347C0B67D3F7E83FDB084F6F07420105EE
          EE0E58AD1AACCE20464859D0354252562A52728A9090391296947478EAF762E0
          CC1111D634102F678CFD60005235C3EE696F1F9D9CD50E3E220119A565C82C2D
          07B80A461A485720998781C001D2A1BBBBC0750D9AA717AAB3156ADB59A8010F
          984EE0722A82AAD21EDB0B671F79F04727408A2FF45FB7CB735DAEEA06E34228
          990532884240A015BAF71842FD0D50BB9CD0060208F6FBE17705402609A9F9B9
          48C91D0D93290186EAC3805B852FA01F8B5E407665CD7A29DE75BA7A01810852
          DCC6E23D7DFE036E970FDCD7033284940C800B08609A0F441CE02C364F3069F0
          CF6559866C49008304700EE23A2E38359C772A7BA33B801D5D70D733277E5765
          1C5D30EF190072E9DA77A5D25737B0F8547CD16B870EF7F5F96B5DE7DBC12221
          B4C897314D01692A18CC40442A41E8012641922530591E7C9F18C8D0D12F26D3
          EBD24F3EB7BBE10800EC9B73DBD3C347153E3DE185BF21352BFD69F13A124210
          0B008AA2D99DFED5AD8D1D309CF5801043F7017E473880C000E9421D5B9A0448
          2619268B0526D90A891B202D84E6160F02C9B9EF0030FE3A77F1F2BCE2D1CBAF
          5CB4049ECF77A270C67424984DCB774C9D1C0E215D740704C692B70FEFDEB0F8
          869DB98D4D771459D2C112D30697BAA681043068501E8DC12449043083994C20
          5D47477B3F14EBA82FAB6BDEDFFEEB7B563D66BA71E2E31955D7C1BD7B1D94C6
          D3B048C3306CC278D46FFAF04900CF499704E082D0CE631D7F3A71A8C9E6683D
          05DDD7073DE08611F482870C5088C0F5E852E200634C2081E91C0EBB17E794C2
          F3DBBFB12DBBF9DE590F4FBA66DCE3F7FCE697A8B5F5E24C300D52E1181CAC59
          8BEFDEDD06875B590980E22780F7165ECFEF7BEB6B7DD7F1F3BD20CC5094D08E
          B2CA0B138A2BC741A2000CEE83A186437018110C00269029198DF56EB86854CB
          8E238DF706C674DD73CBAF0A962D9E3D09FBBFED806B408134610AB63CFF1492
          3C7EB4783C352FBBFA5600E01705D0348ED85DD875E27CE7996EF7F4FBDD8147
          6D27DB1E2A2F1F6EBD626205B83E003DE4042C5930678E42775313CE9CF4848C
          B4519BD77CFAEFBF174DC3C26953AE7D78F11D35A8ED7C1D5E3D0B99A93763C3
          E62FD0632985113CB5FA2B57DBB3D1F56C5CF42361DDBC4AACBB6B90E883B608
          D26E2DCD9BB86371457BC7674BC87D7A2D757E3C87CE7D700BD9FE59455B1FAC
          689FF5F3F21B01144EBF3F7FF58B9B6E2725D84A5FB53C491F9DACA22F1A56D0
          7D8F3D4AD7DDF604658C9CF11280D4E8F74A8B2C498805B81CB110199B1E18BF
          DDB6ED7EF2DA5EA7CEDDB323016AD7DC4ABB9EBA6B1F80D153E7E7BDF4FCC699
          E40DDAE8F8B935B4FDFBB9B4BFFE199AFF6C31DD5E3D920AC78F7D19405A4C7E
          6D7A31168A0026FC7051749369C190D1A52A4130D90A808113C194310E503575
          F2BD390F4F993A69E94377AEC2B18EB7D0E76BC170F378BCB76333FA2FA8387B
          A6FF95CE7AEF0A0041812EA006F348E8560E09432BEE570D7BD01B00932DE008
          CBCBC044177BDA0F154C9D3671E9D2B92B71B4633D1C4A13D2E5B288DCD91B40
          F329D7DA53FF89C803024D40F397BD4B0047CF4809A621C849C007FC5A97CFED
          073113E4B45268A622EC3AF02F145466552C9DB70A47DAD78BCE5B9161198F0D
          1F6D86AB2784D6C6FE576D077DCF02F0472F1DFDE195F1C4954EA4659FC3F07C
          FB8F4E806267AF5BB3073C7E707336B4C49F61DB917D08E578B074DE8B38DC26
          3AF7DA30C25C2E3ADF0AA73D085B9D6B9D90AF88972FFD4739712220790BD273
          BAC1751AF204A8BEDBDB7D7BDA28F8B5246CF97A2FBCA903F8E3BC9511B95369
          454E42454C8E967AF76B6D47FD61B912933FF47219C55F78C388FB3D3004E840
          EB807B457EA97AE2D3DD56D292515DF5E741B94FC813C3F26DB8D02DE475EE37
          3ABE0B3C1727E74B5E1A47441C317D7E41AA084060430CC062F7E0E037077615
          24CA558FAFDD839D2717469E796EE244BCFFE17638BA54349F74BFD9591B0C77
          EE11A802BE7875494C0EC680DCFC61C82D4802E734E40950348494A228D6921B
          66C361ABC5056F33F292847C879077AAB0D5BAD777D7A917C917AD1E1B51473A
          A0B03C05396139717063E80198C09C915D34A2C77CC52D25D366C3DB7618A50D
          BF40FBE9662477A6A3A9B9E96D7B43282C770B8211794D3181080444C82BF8BF
          9C8140439C008B6DC3A23195772A99E31203F63AB47E5F07DBB727E076380147
          DF5B51F9404CFE60CD98883A5639F9C9C8CE4F8CC811D6138173C4025C7E1D33
          C6100B60B126DF2DA714E181E51F003DA7832516657F4BBF6FE327ADCE0300BC
          B1B12F5C25E4843879529838C7E0493FF10E18FDCEDE928DEFAC6CD654E523BF
          E2FC706FC86F07E08B76AD09787E8585F66CEAC0106BC801B8C06FABDB9713F7
          5F8E1A3D8DE8E79427E4849F5EFF033104F249543D626B0000000049454E44AE
          426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F40000086749444154785EC5967B7015E519C69F6FF7DC92900B9184042248B8
          48002125E1266408A64251A842AD60A78C08746869A9B5746AD5D1B1753AD056
          6BB5D47AA7DA42B1A0E16EDA4AA41042120204422227F7FBF5E49C9CFB5EBFB7
          9BE49C99CCA9A9A7FED377E6373BBBDFCE3ECFBEDFBBEFBB8C88C0184344B0F0
          3184103A46AE1146824270038AB88E304484C830450A8F423CF8ECEAF4E99313
          BF6A31B1E52641984F44221358060326102787C6F54E02744DA31B7E49BD54D3
          ECFC64F7AB25DD0034031E2242756C03E137152FECDFF8407C8CF9C998C4B49C
          B889B31137290B96712920E8B025A4421045702D30411AEC9A00E2903D7D0BBD
          5DF6ADA9139B503E2BE5AAC323FFE6FEA7CF9C00A01AE8061C6384303AD5AFEF
          59997AE5CD873F983A6FE5DFEE7C705F4EDA573683E926F4959F40FDE1A7D070
          F027B8B27705AA5FCD47F3079BE16F3D04EE2D41DCF80032721660F67DDFC6DC
          8DBB17CECACEF9EBB917D71FFEC5A3B9930188062C9A0C88393353DE98BC68D3
          7AAEC5A0F68D9DD0063B4082195C20702D08E20A2CB16680039C38546F1B2C16
          635DD4A1CBDD80EC8510D09131773EAC0929EB35AD4804F050280B34B68170FA
          0905C977AEC2E91DB9B00A12E293C78159458000CE0964C055434C37308E9AA2
          420B06218A3EE35C049383505D0E488DB548C9DF83EAA2E3F7863494683220E8
          1A1798D686DCDDAFA2FA2F7BD1D7D90C73AC0AC1C2C0A04214864469D82B1383
          106C1E30D501C567981004902281B815E3E63C085F5D29349D8F2EECB16B208C
          A6E8DDDEC633485B300D6B5E3989BB9F3D8069EBBE8B841979A0F8E950844970
          7449E86DF1A3A77E10EE7E13BC0304594E8090300771B3372079F1B7207554C1
          555938F4BCC1B07834192059D5BB3D2D2DD3E2525AC0936DB82D6B2E2664CD03
          B80C462A48F34130C783C001D2A0B93BC13515AAA717B2A311727313E4A0074C
          2370310192EC6B09F7856832403EBFF2A9DBE901C96E80AB20E2E00CD0498116
          6C80EC3C01F7ADA7D07F7627BA3EDA86B6A37B50F7EEE3683AB60FDEA60BE043
          064D3690CE31E896E10F6A15A102C417192003DE3310F897DBE907F7F7807405
          201DE0060430D53F6C083C9451C6C08411FFA22842B4D8C020009C83B8867E87
          8A7687EF63007AB419E03B5F2BB9343010B8E66C6F011B36A10E3F8CA93E902A
          83C10C0C8B0A6060001320880298288E5C2706D235B85C01F43AB5EB2F1CBF59
          3ADA00632CCC7F662084DAED08BCD458DB0ADD510D18C2D0FC40A06FC880810E
          D21858F8ABE5181637592C308956085C07A90A1A1A3CE870FA7F074036A0681B
          1119E8BBDEBE74FCBDEFAD284CABB56F986249028B491C69EAAA0A32804E00B3
          20666A1E2C53E2872A1D26AB15DC530B527C686B75A1B1C37FE2F9E3D52700E8
          11038D86186B0BC2D34C29AC687DE26A89BDAEAFB1069A7F005AD00D5DF2822B
          BA8100736A3EC89C8EF60F6BE1F8B01E81EE206C9357C0E5B5A2A2CAD970E633
          D74F01A80757E62FABD8B2A5FD74C1BDA776CFCE8A0FE9318C3522DFFFCEF2B0
          29DB830B6F9FF1D6D665D74B7FBF851CA57BC979F139EABFF0037256BD48FD95
          6FD2E5C7B7517FD101926B3EA6CA1FEDA4EB077E45C56FEF6B5F9B3D6D1E80C4
          7796AFB8E7E2CEC702C11B27A9E7F89B7472CDD7CE6F9F3E33293C1B88084308
          1815AACA11AE856357DB3B5E2AAA595D525CFDDB53EF9E969B2E5F83AE8F07CC
          69683A54862905CB90989C04743B307FFBD7E1AFB0EBE56F153EF9715573D76B
          4B962E9A3567C6A9DC5D1B62F4A60E24C49891FDD87D79ABD3D2DF8F6C7EA37F
          48F0878773C23B84EF1FB922846A24666D567AE68EFC898539EBEE9E7A5BF626
          54EC7E198B7FF84D88DEC070D5136330DD9E8ECB7F2C941AAAEB9FCB9C3BFDE7
          8B0D71C5DE0C52141001AAD98CB3FB0B7B1F292B9902402523220D7C1E6113F1
          07B7DFF57AEEEA450F65ACDC86AEB272D8DF3B8FE58FDE075196409A0A3006F1
          8E0C541E3947B99B5631F55603B8A480405054867FFCF9138FBDA3EFFEBD5D75
          6500F4B00113FE7B50A8925549D13B15BF041E68C7F869C998F1C85214BF710C
          799BF361D25490A641BB6947EEDA452C78AD1A248FBCB91454515C58E6F9ACA3
          7FDDAFBBEB2B227F4E0444173C20EBDD92370841D021F75C40B2612263431EFE
          F96E91E2F7F8203907A00EBAE0ADAA86EA1C34CE9DF0F60EE0ECD1526F555BCF
          0386F8E5514D8922FAC01766810F06D4CE802700269AC1251782ED17109BBA14
          BE0453515D857DFDCCD929CCDFD90A1081009862E350D7E8A29E80FFF9577A9B
          AE468A476B20DCC5A8DFA376050D0310CC60B609B0252F466B491B2659E3D6CE
          5D9DC3DC97CA41DAC8DC2003C5EDC1BC557731BF8E5FFE4C51ECFB9AECC50078
          C4DF3484683370B3DBD7E9EE738199E261495B8EBE5B5D705FACC6E2F54BCCAE
          8BE5E0920AAE13045B2CB846E08A0ADF7563BD60BE6D4166C6D127A7CE5C05C0
          12D18CA2AE012AAE7739758DDC921C8FBEDA6E347D5489DC350B31F06909F480
          0C5D27E8A618945FED209694044E0C9AA4C273E51A96E465D9E6DD91FEE18F33
          32874C98BE8C01DD406A74049EBE71EAB4ABECE593C82EC8C660491974490271
          0E6E8EC1F94B8DDEF2C6AE278ACFD9BD2C3109E018FE14FDD5B5C85932CB966A
          B2BE13EA84F89FB7C0407AF6EFCD0757EE7A617E636BF7D996F21A101346442C
          867879B3B7B2C7B171BFA3EDFDCAAEDE6F9CBB50E7650949C3F7100474D6B4C0
          1794AF8D310DA34233F01BA8875C3D5B2C676F1C5AB164667E727C3C4A2F3779
          AB7A07361C70769601D0FEE4EC2C65C04694D1474B17DE11DFDF3788B29B9DE7
          0E0FF66C0D3D87228751B4B0500AAD33ACB1A9CF4CCC3CF27CDA8CD61DB765DC
          0320D6C034AA7BC66E4F9E5C30B43E745FA6256622006B681DE161C4A23410D9
          AE85901173C89416821BD028A3A6517BAE8EBA07615D13BE5C8485F490188589
          68E1FC73D723A7E1FF33FE0D529F910788FDFD9F0000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F4000003E649444154785EBD57BF6B554B109EB989312A010BF15A5928BE5E50
          48612318ACED6D4CA1AFB9A2A2454865218A16F2783C420A51C17FC14EF28A07
          0F85A8B5A6152401D117789890BB33727666F663B8B7B855362C6777CF4CE69B
          6F7E9CBD4C184CFB3BB47B4C9B619F9303991C6CD6519F12202A805BABFF5C9C
          3974F821139FD7064F89956DD53D598914D06361228AFF5E655C96D90E425C95
          54747DF7FFEDA595DB0B7F7740B863E1DEF3F52FD72F9FE99F3E31471A5035E1
          9E68DC7DF13E2CB50720BB338672F38F1BF3278968AF32A04CFD53FD39127808
          273AD44051D96052F33CD086BCA8B352350D415B2A0030F589A8D7AD0C408165
          43ED7BE6466B356BBB049014404434BD0806DC36B810E4510520D54B43D9C29D
          388CF729242E086A0D0086867ED60D17C80140D18D4083190E312121232861DC
          F979B2782E17196311FF6E7A8A69B0F23618606340D476F5CF948C7EA3A317F4
          73B70295BDC8897AE84F67D30543CA654CAE08241C0091A85251A794113CC76F
          DB144835E3ED1C59994E5453D89895A46400A42A7473F55D041E998EA079E718
          8921E42B20C898614E5928C0070011823F7F9FA721CA0889E8B2A68B439426C6
          60E55F9342FAC32962ACA162008A483D842293A01CA194FC96008288899D1BEB
          B9A461DAEDE4246CCCA1AC462B8DD43728AB583B24115F2364814655CCA60BE4
          1C106975AFB9EEDAB9C9B185273CAFF2005F8A1941E9B92C133C0F8D9C039E68
          1A6F181C041E6CE071FE68D05F830B00C601308F83335374EDF19A6D0040D03A
          B3711F283B0C80E360CFE5C4BF21E023EB888C32108EC0CBA8D908073AA049F9
          5E53F5C39A842B8AAA0B9052240070AF028818AB29381F8E34E786F85495D4B6
          D5267A40DD33645003249A1B9165EFB8B2C995883DA7561F15812463CAE14283
          330604002A032AC1804F8A199E98DBF65EF1DD376672A5B45C12D74579BB0000
          A011115D7DF0063D3CBA19FA12DC4F4C71EA0FA8F971899A3FD1B90A8AD0ABE5
          4BB4B35BF27D0023786E805081B0B4F8680D799095033F5A78EE84023165B25D
          00D1904D60744C791541E1252A5248C736A2883D837698466972AE39CDE65A8E
          30A3220226127314402B37155C1C6017036517C0F05E5A766BBE03A62BBA3124
          A4990115494646AE7E0094BB226B72E8E5F2822BA7E0E0BE40444766A7E9CAD2
          EBCC80464C611199CE9C6FC1A9A44C18210806F1B18A5D5BA21234009422E5C7
          C7CF5B47CFFE767C5CFAE76DBE2B8569DC26137FA3E3C3A72D9232FC8F8886F1
          D36CE7FBD78DC1FD67F294A77AC73CD372A7CB30B0CB5E799CA1ABEA4F86ACC8
          F0DBF6E6C69DCE6EB7656761D6E701D39DF8C7E8E47280BCE7C67F762C4481F7
          7CD6FD3EFC2C2F7169FA054C90604B38FCCCFB0000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F4000008C649444154785E9D970B7054D5FDC73FE7DEBBBB61034930212F4248
          20E151081040500C8262C24B505A41FF4E6BA75070CAB4F5D5A98A456DABD3D6
          07C8D84E6D7DCC5094BF08A8BC54248409F23024A824819020CF3C681262DED9
          C7DD7B4EB777F60E994C8C63BFB3BF397BEFEE9EEFE7F73BBF73E6AE504AE148
          08C1F750DF2F2BFE0719F42307AAAF44588018004001A87E26F8FB96A3AC7D20
          EF3B0106347E7EE37B49C3125357084D5F2484480531514A5925A56A0899C14F
          9B9BEAFEFFF78FFFB8410861C3F406095921F8B66C9DE87B6FE1AAAD00E2AEE5
          ABDDAFBD7DE4E9CD3BCABA8E965D54571A5A5567B7DF36E8ECF2AB2BF5ADEAC8
          890BEAF5ADC77B36BD59F4E765F7AE8D06744038736D7CE3D0F70700B475CFBD
          15FFDADBC70E7D7AF8ACEAF6059523D394AAC71F541DDD01D5D6E957ED5D01F5
          4D9B4F7D5C745A6D78FD60E9434FFE75786F8897FE7180FEA40D54F6DBE62F77
          A5A567EF983221756EFEECB178A35C545FB8C6BA970BB9EFA16D2C59BD95354F
          ED61D3E612AE34B48310CC9C3E9A293F489B3E7C44D6AEB905F77A2353899069
          F5EF3340876B9BDE3CF8CCB8ACD4F505B78EC30C4936EFFC82773E3A436C4A3A
          83E387E1898A02D324D0D946B0BD99A57347317F76269A263874F42C676BEA5E
          5DFFC8D2C700EBB957F6CABCD697FAAF8063D82BF4DF3EFBFA70B7DBFDD8ACE9
          99006C78F3086F7F728E82C573F8E3AA1BD9F0D32CD6DC96C8D8F418E2929349
          1E3B9183279BD8FE493552C1CDD346E1F6B81FFCC5631BB300F1BB87EF145913
          749C70E4181A9170011EC0131B37EC9E319989DEC15E0F272BEBD97DA886FC3B
          66F2AB82E1A40E7511B214C3620C164D89657462142E43272D3B8BE3E58D9CAF
          6DC370B918332AC91D139BB862A0A53600FDA917F61ED085360740A198317904
          F58D6D8C1E198F52F061E159E2D3B3587E4B32819024602AFCE1F005EDF78C4D
          8DA2B1DD0404A3B2D3397AB29E8CD418D2D3122829D597017F012C40F507A009
          B4394FFCB2A0D72164F1AF1D2524DC3098403044E5B9268664E410E7D523E612
          5F38FC21658F6E43E0766B6842909C12CFA99206A454C4C478B1A44A737AADA2
          339F9C2107FAF6009AB44D2118B2F09B16A190A4ABCB4794C7853F68D1D91DC4
          15EDA1BECDB40D7B7A99072C49BBDFC2E512783C8241D1063DA6690344B95D58
          96151F0110273A736D0880AFBC2B9C0A20A4B222D9030A10A01B1A3EBF49D0B4
          88BB61104A9A149EED60E184D8B0B90D609B072CA8EF0C627820DAAD03126F18
          C202FCBE008140B0935E0A4300D066A4533EF85E3400251570DD5C01D15106CD
          2D9D84A464D2F81402DD6D9C6FF5F371751BF51DA6BD0CCD3E8BEA6F02745912
          DDAD11176BD0F24D5BB8F9E25116345DEB20180A5CC116AA2F8454A001424A45
          59451D1F7C52CEFB1F9DE264791D1E8F8B53A72F6349C89F954DC7D55AC0A236
          6C5E7CA99383173B39732D40B715427709E2635DE886A2FCCC25F272472095A4
          E6EB7AFC3DDD4580A48FBCBE0B4CE9DE1601B014D3728673F78249FC70E164A6
          E68CE0F65BC6F145C545FCFE0023936298377314ADB55F1315A57047817081DB
          0383BC3A49F1EE3030947E51CD8C094924C679E9EA09507AF2ACACBD58F52EA0
          7A577AC6E053CC30DF777A009B56393B4080A560C8102F13C6A450545C41C11D
          B9FCDF821CE28ED7B0EFF353648DCF203E712871B18308FAFD5C6D68E56CD565
          E64DCDB0A3ABDB4F615119CD8D4DC1E6A6660BD081D0B38F2E10FBFEF9279513
          53C8E541D1A8EB4B20412A8400941D2825B82D6F22B5758D7C76EC34BE9E008B
          668DE50FABE71223FD949756B0FBC3624A8F954377178FDF7F3377FCD7BCCBCF
          9123E5545456B3F281FCA89CA973F6DE74FBAAF1800BD016AF79520058216987
          0D10921210D8030221045269B85D6E6E9D3581F3E76BD9BDF7184DCDED441B3A
          6B964CE3D58717F1CED33FE2955F2F60E5A2C9B885A0E95A3BEFEF2A66CFBE43
          4C1C97C1FCB9D37978EDDD09E999130FDFB960F944C00D68692B0E8A504812B2
          2C0410B3F6C977DB97CE9FCA852B2D2889230C1D468DBC014D5894945571E94A
          233993B2199D994A6A6A4218D0B00FAAFA8626BE3E5F4F59E919DA3B3A484BCF
          A0B9B985C5F933888E763139B989DA5D2F371F2AFFF7E2E7F75457024140EE5F
          374F0920F6C1C7B7B6BDF8F43D0482122140291CB16D7719F72D9D024A72F56A
          0B255FD6507DAE9EBA8616FB8CD034416AF250B23393B93137DBEEA797FEF611
          E91999549DAEE299D559DC34671EED5FBEC5F19D7BAE1585215EDC7FDE81B08C
          EB3D00A05036930225402894A5904A474941724A2277252720E7876CCACAEAAB
          E1464D46080DC2A1944008C9BA8796F0C473DBF9D91C83940B6FE04BBD466CEE
          4A662A95103477ED0B83DFB9A9E85205103000A49438BE080081422114589172
          084D8FEC160D850B047C59D5C8F8B1E90821EC4060F74EC6C854962D9C847E62
          7D0BF939F18D877792A41443A7AE62B6500966F0C3BD9AEE9ABFF1C0B9330620
          2CA95091A47BD75F39970E1B1A42387B07043ABA6120FA3CE2094DC33B78285B
          8FD4DF1FF09BEFCC5E3C2DE16AF10E5280A1B93F27B7A92DA1B3AB7003B0C406
          505252F85935E1874DE7B0708400B6EC38E120392FE7922DEF95A022780E7F4A
          720CC7CA2EB2EB4C4BB55BB0CCD753F241FE3D3726341DDD43A2106416FC86C3
          DBF64F01741B405A92797963089A1201BD97832DDB4FF093E533AEBB0A074284
          3FFB9C0756DC041163E7671E97E0E3C29300C1EDA75B2AA5692DEDF11DDB9DB7
          706A82ABE62BBA2FFBE8F1995F01D200B09CAC9D1DA07026051931743A43F52E
          B7637CDD1C402A81B4148004823B6BDA2A4C532EACAB3FFCC2F061DEBC80B9BF
          B8A2D57C14081ACEBAD167728742460A8C632E009C6B090A24BD4E51E1402867
          120B30775FECA804EE06F4C8BD20601A80B27701E076698E372A927672622C2E
          2392631FBEA48418FB33DB5D010822A9A0A40380042C07C42996130218B26CE5
          A6DD2EC333B7F7F3004A0211202440E45A0E3C2A8912600503C51F6C7EE42EA0
          1BB0E8470E801BF044461D107CBB04DF2D873800F82359CB6FFBC36B00A108A1
          7F4083EF2F1909C500FA0FBD1999BC1D57AE6C0000000049454E44AE426082}
      end>
  end
end
