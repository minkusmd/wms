object frmBonusGoods2Dlg: TfrmBonusGoods2Dlg
  Left = 0
  Top = 0
  ActiveControl = cxGrid
  BorderStyle = bsDialog
  Caption = 'Cross Sell'
  ClientHeight = 698
  ClientWidth = 1024
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    1024
    698)
  PixelsPerInch = 96
  TextHeight = 15
  object DialogTitle1: TDialogTitle
    Left = 0
    Top = 0
    Width = 1024
    Height = 64
    Title = 'Cross sell'
    Text = 'Genstionarea produselor cu bonus'
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
    ImageIndex = 1
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 1008
    Height = 572
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 1
    object Panel1: TPanel
      Left = 508
      Top = 0
      Width = 500
      Height = 572
      Align = alRight
      BevelOuter = bvNone
      Padding.Left = 2
      ShowCaption = False
      TabOrder = 1
      object Panel2: TPanel
        Left = 2
        Top = 0
        Width = 498
        Height = 265
        Align = alTop
        BevelOuter = bvNone
        ShowCaption = False
        TabOrder = 0
        object dxBarDockControl2: TdxBarDockControl
          Left = 0
          Top = 0
          Width = 498
          Height = 30
          Align = dalTop
          BarManager = dxBarManager
          SunkenBorder = True
          UseOwnSunkenBorder = True
        end
        object cxGridGoods: TcxGrid
          Left = 0
          Top = 30
          Width = 498
          Height = 235
          Align = alClient
          TabOrder = 1
          object cxGridGoodsTable: TcxGridDBTableView
            Navigator.Buttons.CustomButtons = <>
            ScrollbarAnnotations.CustomAnnotations = <>
            OnFocusedRecordChanged = cxGridGoodsTableFocusedRecordChanged
            DataController.DataSource = IBCDataSourceGoods
            DataController.KeyFieldNames = 'GBONUSID;GOODSID'
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <
              item
                Kind = skCount
                Column = cxGridGoods_GOODSID
              end>
            DataController.Summary.SummaryGroups = <>
            OptionsCustomize.ColumnFiltering = False
            OptionsData.Deleting = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsSelection.CellSelect = False
            OptionsView.CellEndEllipsis = True
            OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
            OptionsView.ScrollBars = ssVertical
            OptionsView.ColumnAutoWidth = True
            OptionsView.Footer = True
            OptionsView.GridLineColor = 13750737
            OptionsView.GroupByBox = False
            OptionsView.Indicator = True
            Styles.Footer = dmAdditions.cxStyle_GridHeader
            Styles.Header = dmAdditions.cxStyle_GridHeader
            Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
            object cxGridGoods_FLG_FOLDER: TcxGridDBColumn
              DataBinding.FieldName = 'FLG_FOLDER'
              PropertiesClassName = 'TcxImageComboBoxProperties'
              Properties.Images = dmAdditions.cxImageList_SWN
              Properties.Items = <
                item
                  ImageIndex = 12
                  Value = 0
                end
                item
                  ImageIndex = 13
                  Value = 1
                end>
              MinWidth = 24
              Options.HorzSizing = False
              Options.ShowCaption = False
              Options.Sorting = False
              Width = 24
              IsCaptionAssigned = True
            end
            object cxGridGoods_GOODSID: TcxGridDBColumn
              Caption = 'Cod'
              DataBinding.FieldName = 'GOODSID'
              FooterAlignmentHorz = taRightJustify
              HeaderAlignmentHorz = taCenter
              MinWidth = 50
              Options.HorzSizing = False
              Width = 50
            end
            object cxGridGoods_TITLE: TcxGridDBColumn
              Caption = 'Denumire'
              DataBinding.FieldName = 'TITLE'
              SortIndex = 0
              SortOrder = soAscending
              Width = 100
            end
          end
          object cxGridGoodsLevel: TcxGridLevel
            GridView = cxGridGoodsTable
          end
        end
      end
      object Panel3: TPanel
        Left = 2
        Top = 265
        Width = 498
        Height = 307
        Align = alClient
        BevelOuter = bvNone
        Padding.Top = 2
        ShowCaption = False
        TabOrder = 1
        object dxBarDockControl3: TdxBarDockControl
          Left = 0
          Top = 2
          Width = 498
          Height = 30
          Align = dalTop
          BarManager = dxBarManager
          SunkenBorder = True
          UseOwnSunkenBorder = True
        end
        object cxGridAddons: TcxGrid
          Left = 0
          Top = 32
          Width = 498
          Height = 275
          Align = alClient
          TabOrder = 1
          object cxGridAddonsTable: TcxGridDBTableView
            Navigator.Buttons.CustomButtons = <>
            ScrollbarAnnotations.CustomAnnotations = <>
            OnFocusedRecordChanged = cxGridAddonsTableFocusedRecordChanged
            DataController.DataSource = IBCDataSourceAddons
            DataController.KeyFieldNames = 'GBONUSID;GOODSID'
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <
              item
                Kind = skCount
                Column = cxGridAddons_GOODSID
              end>
            DataController.Summary.SummaryGroups = <>
            OptionsCustomize.ColumnFiltering = False
            OptionsData.Deleting = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsSelection.CellSelect = False
            OptionsView.CellEndEllipsis = True
            OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
            OptionsView.ScrollBars = ssVertical
            OptionsView.ColumnAutoWidth = True
            OptionsView.Footer = True
            OptionsView.GridLineColor = 13750737
            OptionsView.GroupByBox = False
            OptionsView.Indicator = True
            Styles.Footer = dmAdditions.cxStyle_GridHeader
            Styles.Header = dmAdditions.cxStyle_GridHeader
            Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
            object cxGridAddons_IMG: TcxGridDBColumn
              DataBinding.FieldName = 'FLG_FOLDER'
              PropertiesClassName = 'TcxImageComboBoxProperties'
              Properties.Images = dmAdditions.cxImageList_SWN
              Properties.Items = <
                item
                  ImageIndex = 12
                  Value = 0
                end
                item
                  ImageIndex = 13
                  Value = 1
                end>
              MinWidth = 24
              Options.HorzSizing = False
              Options.ShowCaption = False
              Options.Sorting = False
              SortIndex = 0
              SortOrder = soDescending
              Width = 24
              IsCaptionAssigned = True
            end
            object cxGridAddons_GOODSID: TcxGridDBColumn
              Caption = 'Cod'
              DataBinding.FieldName = 'GOODSID'
              FooterAlignmentHorz = taRightJustify
              HeaderAlignmentHorz = taCenter
              MinWidth = 50
              Options.HorzSizing = False
              Width = 50
            end
            object cxGridAddons_TITLE: TcxGridDBColumn
              Caption = 'Denumire'
              DataBinding.FieldName = 'TITLE'
              SortIndex = 1
              SortOrder = soAscending
              Width = 100
            end
          end
          object cxGridAddonsLevel: TcxGridLevel
            GridView = cxGridAddonsTable
          end
        end
      end
    end
    object Panel4: TPanel
      Left = 0
      Top = 0
      Width = 508
      Height = 572
      Align = alClient
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 0
      object dxBarDockControl1: TdxBarDockControl
        Left = 0
        Top = 0
        Width = 508
        Height = 30
        Align = dalTop
        BarManager = dxBarManager
        SunkenBorder = True
        UseOwnSunkenBorder = True
      end
      object cxGrid: TcxGrid
        Left = 0
        Top = 30
        Width = 508
        Height = 542
        Align = alClient
        TabOrder = 1
        object cxGridTable: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          ScrollbarAnnotations.CustomAnnotations = <>
          OnCellDblClick = cxGridTableCellDblClick
          OnCustomDrawCell = cxGridTableCustomDrawCell
          OnFocusedRecordChanged = cxGridTableFocusedRecordChanged
          DataController.DataSource = IBCDataSourceBonus
          DataController.KeyFieldNames = 'GBONUSID'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsCustomize.ColumnFiltering = False
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsView.CellEndEllipsis = True
          OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
          OptionsView.ColumnAutoWidth = True
          OptionsView.GridLineColor = 13750737
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          Styles.Header = dmAdditions.cxStyle_GridHeader
          Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
          object cxGridTable_ORDERNO: TcxGridDBColumn
            AlternateCaption = #1055#1088#1080#1086#1088#1080#1090#1077#1090' '#1085#1072#1095#1080#1089#1083#1077#1085#1080#1103
            Caption = 'Prioritate'
            DataBinding.FieldName = 'ORDERNO'
            HeaderAlignmentHorz = taCenter
            MinWidth = 60
            Options.HorzSizing = False
            SortIndex = 1
            SortOrder = soAscending
            Width = 60
          end
          object cxGrid_TITLE: TcxGridDBColumn
            Caption = 'Denumire'
            DataBinding.FieldName = 'TITLE'
            Width = 100
          end
          object cxGrid_START_DATE: TcxGridDBColumn
            Caption = 'Inceput'
            DataBinding.FieldName = 'START_DATE'
            HeaderAlignmentHorz = taCenter
            MinWidth = 70
            Options.HorzSizing = False
            SortIndex = 2
            SortOrder = soDescending
            Width = 70
          end
          object cxGrid_END_DATE: TcxGridDBColumn
            Caption = 'Sfirsit'
            DataBinding.FieldName = 'END_DATE'
            HeaderAlignmentHorz = taCenter
            MinWidth = 70
            Options.HorzSizing = False
            SortIndex = 3
            SortOrder = soDescending
            Width = 70
          end
          object cxGrid_REQ_QTY: TcxGridDBColumn
            Caption = 'Cant'
            DataBinding.FieldName = 'REQ_QTY'
            HeaderAlignmentHorz = taCenter
            MinWidth = 50
            Options.HorzSizing = False
            Width = 50
          end
          object cxGrid_BONUS_POINTS: TcxGridDBColumn
            Caption = 'Bonus'
            DataBinding.FieldName = 'BONUS_POINTS'
            HeaderAlignmentHorz = taCenter
            MinWidth = 50
            Options.HorzSizing = False
            Width = 50
          end
          object cxGrid_FLG_OLD: TcxGridDBColumn
            DataBinding.FieldName = 'FLG_OLD'
            Visible = False
            SortIndex = 0
            SortOrder = soAscending
            VisibleForCustomization = False
          end
        end
        object cxGridLevel: TcxGridLevel
          GridView = cxGridTable
        end
      end
    end
  end
  object btnClose: TButton
    Left = 914
    Top = 655
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Inchide'
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
    Left = 544
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
      FloatLeft = 966
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbBonusAdd'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbBonusEdit'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbBonusDelete'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbBonusTools'
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
      Caption = 'Custom 2'
      CaptionButtons = <>
      DockControl = dxBarDockControl2
      DockedDockControl = dxBarDockControl2
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 966
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbGoodsNew'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbGoodsDelete'
        end
        item
          Visible = True
          ItemName = 'dxBarStatic1'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBar3: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Custom 3'
      CaptionButtons = <>
      DockControl = dxBarDockControl3
      DockedDockControl = dxBarDockControl3
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 966
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbAddonsNew'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbAddonsDelete'
        end
        item
          Visible = True
          ItemName = 'dxBarStatic2'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object bbBonusAdd: TdxBarButton
      Caption = 'Adauga'
      Category = 0
      Hint = 'Adauga'
      Visible = ivAlways
      ImageIndex = 40
      OnClick = bbBonusAddClick
    end
    object bbBonusEdit: TdxBarButton
      Caption = 'Modifica'
      Category = 0
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 41
      OnClick = bbBonusEditClick
    end
    object bbBonusDelete: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      OnClick = bbBonusDeleteClick
    end
    object bbGoodsNew: TdxBarButton
      Caption = 'Adauga produs'
      Category = 0
      Hint = 'Adauga produs'
      Visible = ivAlways
      ImageIndex = 40
      OnClick = bbGoodsNewClick
    end
    object bbGoodsDelete: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      OnClick = bbGoodsDeleteClick
    end
    object bbAddonsNew: TdxBarButton
      Caption = 'Adauga produs'
      Category = 0
      Hint = 'Adauga produs'
      Visible = ivAlways
      ImageIndex = 40
      OnClick = bbAddonsNewClick
    end
    object bbAddonsDelete: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      OnClick = bbAddonsDeleteClick
    end
    object dxBarStatic1: TdxBarStatic
      Align = iaRight
      Caption = 'Produse care au bonus'
      Category = 0
      Hint = 'Produse care au bonus'
      Visible = ivAlways
    end
    object dxBarStatic2: TdxBarStatic
      Align = iaRight
      Caption = 'Produse care trebuie vindute pentru a primi bonusul'
      Category = 0
      Hint = 'Produse care trebuie vindute pentru a primi bonusul'
      Visible = ivAlways
    end
    object bbBonusSort: TdxBarButton
      Caption = 'Sortare'
      Category = 0
      Hint = 'Sortare'
      Visible = ivAlways
      ImageIndex = 38
      OnClick = bbBonusSortClick
    end
    object bbBonusTools: TdxBarSubItem
      Caption = 'Intrumente'
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbBonusSort'
        end
        item
          Visible = True
          ItemName = 'bbBonusCopySet'
        end>
    end
    object bbBonusCopySet: TdxBarButton
      Caption = 'Copie in clipboard'
      Category = 0
      Hint = 'Copie in clipboard'
      Visible = ivAlways
      ImageIndex = 29
      OnClick = bbBonusCopySetClick
    end
  end
  object IBCQueryBonus: TIBCQuery
    KeyFields = 'GBONUSID'
    KeyGenerator = 'SQ_TDB_GOODS_BONUS2_ID'
    GeneratorMode = gmInsert
    SQLInsert.Strings = (
      'INSERT INTO TDB_GOODS_BONUS2'
      
        '  (GBONUSID, TITLE, START_DATE, END_DATE, BONUS_POINTS, REQ_QTY,' +
        ' ORDERNO)'
      'VALUES'
      
        '  (:GBONUSID, :TITLE, :START_DATE, :END_DATE, :BONUS_POINTS, :RE' +
        'Q_QTY, :ORDERNO)')
    SQLDelete.Strings = (
      'DELETE FROM TDB_GOODS_BONUS2'
      'WHERE'
      '  GBONUSID = :Old_GBONUSID')
    SQLUpdate.Strings = (
      'UPDATE TDB_GOODS_BONUS2'
      'SET'
      '  GBONUSID = :GBONUSID, '
      '  TITLE = :TITLE, '
      '  START_DATE = :START_DATE, '
      '  END_DATE = :END_DATE, '
      '  BONUS_POINTS = :BONUS_POINTS, '
      '  REQ_QTY = :REQ_QTY,'
      '  ORDERNO = :ORDERNO'
      'WHERE'
      '  GBONUSID = :Old_GBONUSID')
    SQLRefresh.Strings = (
      'SELECT '
      ' GBONUSID, '
      ' TITLE, '
      ' START_DATE, '
      ' END_DATE, '
      ' BONUS_POINTS, '
      ' REQ_QTY,'
      ' ORDERNO,'
      ' IIF(END_DATE<CURRENT_DATE,1,0) FLG_OLD '
      'FROM '
      ' TDB_GOODS_BONUS2'
      'WHERE'
      ' GBONUSID = :GBONUSID')
    SQLLock.Strings = (
      'SELECT NULL FROM TDB_GOODS_BONUS2'
      'WHERE'
      'GBONUSID = :Old_GBONUSID'
      'FOR UPDATE WITH LOCK')
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = IBCTrUpdate
    SQL.Strings = (
      'SELECT '
      ' GBONUSID, '
      ' TITLE, '
      ' START_DATE, '
      ' END_DATE, '
      ' BONUS_POINTS, '
      ' REQ_QTY,'
      ' ORDERNO,'
      ' IIF(END_DATE<CURRENT_DATE,1,0) FLG_OLD '
      'FROM '
      ' TDB_GOODS_BONUS2'
      'ORDER BY '
      ' 8, ORDERNO, START_DATE DESC, END_DATE DESC')
    AutoCommit = False
    LockMode = lmLockImmediate
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Options.RequiredFields = False
    LocalConstraints = False
    Left = 84
    Top = 216
  end
  object IBCDataSourceBonus: TIBCDataSource
    DataSet = IBCQueryBonus
    Left = 84
    Top = 276
  end
  object IBCTrUpdate: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 164
    Top = 240
  end
  object IBCQueryGoods: TIBCQuery
    SQLInsert.Strings = (
      'INSERT INTO TDB_GOODS_BONUS2_GOODS'
      '  (GBONUSID, GOODSID)'
      'VALUES'
      '  (:GBONUSID, :GOODSID)')
    SQLDelete.Strings = (
      'DELETE FROM TDB_GOODS_BONUS2_GOODS'
      'WHERE'
      '  GBONUSID = :Old_GBONUSID AND GOODSID = :Old_GOODSID')
    SQLUpdate.Strings = (
      'UPDATE TDB_GOODS_BONUS2_GOODS'
      'SET'
      '  GBONUSID = :GBONUSID, GOODSID = :GOODSID'
      'WHERE'
      '  GBONUSID = :Old_GBONUSID AND GOODSID = :Old_GOODSID')
    SQLRefresh.Strings = (
      'SELECT '
      ' GBONUSID, '
      ' TDB_GOODS_BONUS2_GOODS.GOODSID,'
      ' TS_GOODS.TITLE,'
      ' TS_GOODS.FLG_FOLDER'
      'FROM TDB_GOODS_BONUS2_GOODS'
      
        'INNER JOIN TS_GOODS ON (TS_GOODS.GOODSID=TDB_GOODS_BONUS2_GOODS.' +
        'GOODSID)'
      'WHERE'
      
        '  GBONUSID = :GBONUSID AND TDB_GOODS_BONUS2_GOODS.GOODSID = :GOO' +
        'DSID')
    SQLLock.Strings = (
      'SELECT NULL FROM TDB_GOODS_BONUS2_GOODS'
      'WHERE'
      'GBONUSID = :Old_GBONUSID AND GOODSID = :Old_GOODSID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = IBCTrUpdate
    SQL.Strings = (
      'SELECT '
      ' GBONUSID, '
      ' TDB_GOODS_BONUS2_GOODS.GOODSID,'
      ' TS_GOODS.TITLE,'
      ' TS_GOODS.FLG_FOLDER'
      'FROM TDB_GOODS_BONUS2_GOODS'
      
        'INNER JOIN TS_GOODS ON (TS_GOODS.GOODSID=TDB_GOODS_BONUS2_GOODS.' +
        'GOODSID)'
      'ORDER BY 3')
    MasterFields = 'GBONUSID'
    DetailFields = 'GBONUSID'
    MasterSource = IBCDataSourceBonus
    AutoCommit = False
    LockMode = lmLockImmediate
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Options.DetailDelay = 500
    Left = 532
    Top = 144
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'GBONUSID'
        Value = nil
      end>
  end
  object IBCDataSourceGoods: TIBCDataSource
    DataSet = IBCQueryGoods
    Left = 532
    Top = 200
  end
  object IBCQueryAddons: TIBCQuery
    SQLInsert.Strings = (
      'INSERT INTO TDB_GOODS_BONUS2_ADDONS'
      '  (GBONUSID, GOODSID)'
      'VALUES'
      '  (:GBONUSID, :GOODSID)')
    SQLDelete.Strings = (
      'DELETE FROM TDB_GOODS_BONUS2_ADDONS'
      'WHERE'
      '  GBONUSID = :Old_GBONUSID AND GOODSID = :Old_GOODSID')
    SQLUpdate.Strings = (
      'UPDATE TDB_GOODS_BONUS2_ADDONS'
      'SET'
      '  GBONUSID = :GBONUSID, GOODSID = :GOODSID'
      'WHERE'
      '  GBONUSID = :Old_GBONUSID AND GOODSID = :Old_GOODSID')
    SQLRefresh.Strings = (
      'SELECT '
      ' GBONUSID, '
      ' TDB_GOODS_BONUS2_ADDONS.GOODSID,'
      ' TS_GOODS.TITLE,'
      ' TS_GOODS.FLG_FOLDER'
      'FROM '
      ' TDB_GOODS_BONUS2_ADDONS'
      
        ' INNER JOIN TS_GOODS ON (TS_GOODS.GOODSID=TDB_GOODS_BONUS2_ADDON' +
        'S.GOODSID)'
      'WHERE'
      
        ' TDB_GOODS_BONUS2_ADDONS.GBONUSID = :GBONUSID AND TDB_GOODS_BONU' +
        'S2_ADDONS.GOODSID = :GOODSID')
    SQLLock.Strings = (
      'SELECT NULL FROM TDB_GOODS_BONUS2_ADDONS'
      'WHERE'
      'GBONUSID = :Old_GBONUSID AND GOODSID = :Old_GOODSID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = IBCTrUpdate
    SQL.Strings = (
      'SELECT '
      ' GBONUSID, '
      ' TDB_GOODS_BONUS2_ADDONS.GOODSID,'
      ' TS_GOODS.TITLE,'
      ' TS_GOODS.FLG_FOLDER'
      'FROM '
      ' TDB_GOODS_BONUS2_ADDONS'
      
        'INNER JOIN TS_GOODS ON (TS_GOODS.GOODSID=TDB_GOODS_BONUS2_ADDONS' +
        '.GOODSID)'
      'ORDER BY 4 desc,3')
    MasterFields = 'GBONUSID'
    DetailFields = 'GBONUSID'
    MasterSource = IBCDataSourceBonus
    AutoCommit = False
    LockMode = lmLockImmediate
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Options.DetailDelay = 500
    Left = 444
    Top = 336
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'GBONUSID'
        Value = nil
      end>
  end
  object IBCDataSourceAddons: TIBCDataSource
    DataSet = IBCQueryAddons
    Left = 516
    Top = 424
  end
end
