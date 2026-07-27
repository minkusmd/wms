inherited frame73DSE: Tframe73DSE
  Width = 1201
  Height = 598
  Font.Height = -15
  ExplicitWidth = 1201
  ExplicitHeight = 598
  PixelsPerInch = 120
  object cxGridPTN: TcxGrid
    Left = 0
    Top = 0
    Width = 1201
    Height = 303
    Align = alClient
    TabOrder = 0
    LookAndFeel.NativeStyle = True
    LookAndFeel.SkinName = ''
    object cxGridPTNTable: TcxGridDBTableView
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
      OnCellDblClick = cxGridPTNTableCellDblClick
      OnCustomDrawCell = cxGridPTNTableCustomDrawCell
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
      object cxGridPTN_FLG_CLOSED: TcxGridDBColumn
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
      object cxGridPTN_DOCID: TcxGridDBColumn
        Caption = #1050#1086#1076
        DataBinding.FieldName = 'DOCID'
        HeaderAlignmentHorz = taCenter
        MinWidth = 60
        Options.HorzSizing = False
        Width = 60
      end
      object cxGridPTN_DATA: TcxGridDBColumn
        Caption = #1044#1072#1090#1072
        DataBinding.FieldName = 'DATA'
        OnGetDisplayText = cxGridPTN_DATAGetDisplayText
        HeaderAlignmentHorz = taCenter
        MinWidth = 110
        Options.HorzSizing = False
        Width = 110
      end
      object cxGridPTN_CT_NAME: TcxGridDBColumn
        Caption = #1050#1083#1080#1077#1085#1090
        DataBinding.FieldName = 'CT_NAME'
        Styles.Content = dmAdditions.cxStyle_GridColumnBOLD
        Width = 200
      end
      object cxGridPTN_SUMA: TcxGridDBColumn
        Caption = #1057#1091#1084#1084#1072
        DataBinding.FieldName = 'SUMA'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 80
        Options.HorzSizing = False
        Width = 80
      end
      object cxGridPTN_CURRENCY_NAME: TcxGridDBColumn
        Caption = #1042#1072#1083#1102#1090#1072
        DataBinding.FieldName = 'CURRENCY_NAME'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        MinWidth = 70
        Options.HorzSizing = False
        Width = 70
      end
      object cxGridPTN_VAT: TcxGridDBColumn
        Caption = #1053#1044#1057
        DataBinding.FieldName = 'VAT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 70
        Options.HorzSizing = False
        Options.Sorting = False
        Width = 70
      end
      object cxGridPTN_RATEUSD: TcxGridDBColumn
        Caption = #1050#1091#1088#1089' USD'
        DataBinding.FieldName = 'RATEUSD'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 70
        Options.HorzSizing = False
        Width = 70
      end
      object cxGridPTN_FLG_ACNT: TcxGridDBColumn
        Caption = #1055#1041
        DataBinding.FieldName = 'FLG_ACNT'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        HeaderAlignmentHorz = taCenter
        MinWidth = 40
        Options.HorzSizing = False
        Width = 40
      end
      object cxGridPTN_CREATED_BY_NAME: TcxGridDBColumn
        Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
        DataBinding.FieldName = 'CREATED_BY_NAME'
        Width = 100
      end
      object cxGridPTN_CT: TcxGridDBColumn
        DataBinding.FieldName = 'CT'
        Visible = False
        VisibleForCustomization = False
      end
      object cxGridPTN_SC2_NAME: TcxGridDBColumn
        Caption = #1040#1085#1072#1083#1080#1090#1080#1082#1072
        DataBinding.FieldName = 'SC2_NAME'
        Width = 50
      end
    end
    object cxGridPTNLevel: TcxGridLevel
      GridView = cxGridPTNTable
    end
  end
  object pnBottom: TPanel
    Left = 0
    Top = 313
    Width = 1201
    Height = 285
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object Panel1: TPanel
      Left = 0
      Top = 0
      Width = 687
      Height = 285
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      object cxGrid1: TcxGrid
        Left = 0
        Top = 32
        Width = 687
        Height = 253
        Align = alClient
        TabOrder = 1
        object cxGridDSE: TcxGridDBTableView
          OnFocusedRecordChanged = cxGridDSEFocusedRecordChanged
          OnSelectionChanged = cxGridDSESelectionChanged
          DataController.DataSource = IBCDS_DSE
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
          Preview.LeftIndent = 25
          Preview.RightIndent = 6
          RowLayout.MinValueWidth = 100
          object cxGridDSEUID: TcxGridDBColumn
            DataBinding.FieldName = 'UID'
            Width = 50
          end
          object cxGridDSEDSE_TYPENAME: TcxGridDBColumn
            Caption = 'Tipul documentului'
            DataBinding.FieldName = 'DSE_TYPENAME'
            Width = 456
          end
          object cxGridDSEQTY: TcxGridDBColumn
            Caption = 'Cant'
            DataBinding.FieldName = 'QTY'
            Width = 97
          end
          object cxGridDSEAMOUNT: TcxGridDBColumn
            Caption = 'Suma'
            DataBinding.FieldName = 'AMOUNT'
            Width = 97
          end
          object cxGridDSECNT: TcxGridDBColumn
            Caption = 'No libere'
            DataBinding.FieldName = 'CNT'
            Width = 97
          end
        end
        object cxGrid1Level1: TcxGridLevel
          GridView = cxGridDSE
        end
      end
      object dxBarDockControl1: TdxBarDockControl
        Left = 0
        Top = 0
        Width = 687
        Height = 32
        Align = dalTop
        BarManager = dxBarManager
      end
    end
    object Panel2: TPanel
      Left = 697
      Top = 0
      Width = 504
      Height = 285
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 2
      object dxBarDockControl2: TdxBarDockControl
        Left = 0
        Top = 0
        Width = 504
        Height = 32
        Align = dalTop
        BarManager = dxBarManager
      end
      object cxGrid2: TcxGrid
        Left = 0
        Top = 32
        Width = 504
        Height = 253
        Align = alClient
        TabOrder = 1
        object cxGridDSEDetail: TcxGridDBTableView
          FindPanel.DisplayMode = fpdmAlways
          DataController.DataSource = IBCDS_DSE_Detail
          DataController.Summary.FooterSummaryItems = <
            item
              Kind = skCount
              Column = cxGridDSEDetailDSE_NO
            end>
          FilterRow.SeparatorWidth = 8
          FixedDataRows.SeparatorWidth = 8
          NewItemRow.SeparatorWidth = 8
          OptionsBehavior.IncSearch = True
          OptionsBehavior.ImmediateEditor = False
          OptionsData.CancelOnExit = False
          OptionsData.Inserting = False
          OptionsView.NavigatorOffset = 63
          OptionsView.CellAutoHeight = True
          OptionsView.FixedColumnSeparatorWidth = 3
          OptionsView.Footer = True
          OptionsView.GroupByBox = False
          Preview.LeftIndent = 25
          Preview.RightIndent = 6
          RowLayout.MinValueWidth = 100
          object cxGridDSEDetailDSE_NO: TcxGridDBColumn
            Caption = 'Numar Serie'
            DataBinding.FieldName = 'DSE_NO'
            Width = 252
          end
          object cxGridDSEDetailSTATUS: TcxGridDBColumn
            Caption = 'Status'
            DataBinding.FieldName = 'STATUS'
          end
          object cxGridDSEDetailINVOICE_DOCID: TcxGridDBColumn
            Caption = 'DocID'
            DataBinding.FieldName = 'INVOICE_DOCID'
            Width = 110
          end
        end
        object cxGridLevel1: TcxGridLevel
          GridView = cxGridDSEDetail
        end
      end
    end
    object cxSplitter1: TcxSplitter
      Left = 687
      Top = 0
      Width = 10
      Height = 285
      HotZoneClassName = 'TcxSimpleStyle'
      AlignSplitter = salRight
    end
  end
  object cxSplitter: TcxSplitter
    Left = 0
    Top = 303
    Width = 1201
    Height = 10
    HotZoneClassName = 'TcxSimpleStyle'
    AlignSplitter = salBottom
    MinSize = 300
    Control = pnBottom
  end
  object dxBarManager: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Toolbar'
      'DSE'
      'DSE Detail')
    Categories.ItemsVisibles = (
      2
      2
      2)
    Categories.Visibles = (
      True
      True
      True)
    ImageOptions.Images = dmAdditions.cxImageList_SWN
    ImageOptions.StretchGlyphs = False
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 264
    Top = 68
    PixelsPerInch = 120
    object dxBarManagerBar1: TdxBar
      Caption = 'DSE'
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1234
      FloatTop = 0
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbNewDSE'
        end
        item
          Visible = True
          ItemName = 'bbModify'
        end
        item
          Visible = True
          ItemName = 'bbDeleteDSE'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBar2: TdxBar
      Caption = 'DSE Detail'
      CaptionButtons = <>
      DockControl = dxBarDockControl2
      DockedDockControl = dxBarDockControl2
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1234
      FloatTop = 0
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbManagerSerials'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object bbDocComments: TdxBarButton
      Caption = 'Comentariu'
      Category = 0
      Hint = 'Comentariu'
      Visible = ivAlways
      OnClick = bbDocCommentsClick
    end
    object dxBarButton1: TdxBarButton
      Caption = 'Inchide document'
      Category = 0
      Hint = 'Inchide document'
      Visible = ivAlways
      ShortCut = 120
      OnClick = dxBarButton1Click
    end
    object bbNewDSE: TdxBarButton
      Caption = 'Nou'
      Category = 1
      Hint = 'Nou'
      Visible = ivAlways
      ImageIndex = 0
      PaintStyle = psCaptionGlyph
      ShortCut = 45
      OnClick = bbNewDSEClick
    end
    object bbModify: TdxBarButton
      Caption = 'Modifica'
      Category = 1
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 1
      PaintStyle = psCaptionGlyph
      OnClick = bbModifyClick
    end
    object bbDeleteDSE: TdxBarButton
      Caption = 'Sterge'
      Category = 1
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 2
      PaintStyle = psCaptionGlyph
      ShortCut = 16430
      OnClick = bbDeleteDSEClick
    end
    object bbManagerSerials: TdxBarButton
      Caption = 'Gestiune Serii DSE'
      Category = 2
      Hint = 'Gestiune Serii DSE'
      Visible = ivAlways
      ImageIndex = 30
      PaintStyle = psCaptionGlyph
      ShortCut = 117
      OnClick = bbManagerSerialsClick
    end
  end
  object dxBarPopupMenuDOCS: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
        ItemName = 'dxBarButton1'
      end
      item
        Visible = True
        ItemName = 'bbDocComments'
      end>
    UseOwnFont = False
    OnPopup = dxBarPopupMenuDOCSPopup
    Left = 433
    Top = 70
    PixelsPerInch = 120
  end
  object cxGridPopupMenuDOCS: TcxGridPopupMenu
    Grid = cxGridPTN
    PopupMenus = <
      item
        GridView = cxGridPTNTable
        HitTypes = [gvhtCell, gvhtRecord]
        Index = 0
        PopupMenu = dxBarPopupMenuDOCS
      end>
    Left = 88
    Top = 68
  end
  object cxGridPopupMenuCOMPONENTS: TcxGridPopupMenu
    PopupMenus = <
      item
        HitTypes = [gvhtCell, gvhtRecord]
        Index = 0
      end>
    Left = 321
    Top = 188
  end
  object IBCDS_DSE: TIBCDataSource
    DataSet = IBCQ_DSE
    Left = 104
    Top = 464
  end
  object IBCQ_DSE: TIBCQuery
    SQLInsert.Strings = (
      'INSERT INTO VW_TDB_DSE'
      '  (UID, DOCID, ORGID, DSE_TYPEID, QTY, AMOUNT)'
      'VALUES'
      '  (:UID, :DOCID, :ORGID, :DSE_TYPEID, :QTY, :AMOUNT)')
    SQLDelete.Strings = (
      'DELETE FROM VW_TDB_DSE'
      'WHERE'
      '  UID = :Old_UID')
    SQLUpdate.Strings = (
      'UPDATE VW_TDB_DSE'
      'SET'
      
        '  UID = :UID, DOCID = :DOCID, DSE_TYPEID = :DSE_TYPEID, QTY = :Q' +
        'TY, AMOUNT = :AMOUNT, '
      '  ORGID = :ORGID'
      'WHERE'
      '  UID = :Old_UID')
    SQLRefresh.Strings = (
      
        'SELECT UID, DOCID, ORGID, DSE_TYPEID, QTY, AMOUNT FROM VW_TDB_DS' +
        'E'
      'WHERE'
      '  UID = :UID')
    SQLLock.Strings = (
      'SELECT NULL FROM TDB_DSE'
      'WHERE'
      'UID = :Old_UID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM VW_TDB_DSE'
      ''
      ') q')
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      
        'select d.uid, D.Docid, D.Dse_Typeid, D.Dse_Typename, D.Qty, D.Am' +
        'ount, d.orgid,'
      '(select count(*)'
      '        from Tdb_Dse_Detail Dd'
      '        where Dd.Uid = D.Uid and'
      '              Status = 0) Cnt'
      'from vw_tdb_dse D')
    MasterFields = 'DOCID'
    DetailFields = 'DOCID'
    MasterSource = dmDB.IBCDataSourceDocs
    Left = 176
    Top = 464
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DOCID'
        Value = nil
      end>
  end
  object IBCQ_DSE_Detail: TIBCQuery
    SQLInsert.Strings = (
      'INSERT INTO TDB_DSE_DETAIL'
      '  (UID, DSE_NO, STATUS)'
      'VALUES'
      '  (:UID, :DSE_NO, :STATUS)')
    SQLDelete.Strings = (
      'DELETE FROM TDB_DSE_DETAIL'
      'WHERE'
      '  UID = :Old_UID AND DSE_NO = :Old_DSE_NO')
    SQLUpdate.Strings = (
      'UPDATE TDB_DSE_DETAIL'
      'SET'
      '  UID = :UID, DSE_NO = :DSE_NO, STATUS = :STATUS'
      'WHERE'
      '  UID = :Old_UID AND DSE_NO = :Old_DSE_NO')
    SQLRefresh.Strings = (
      'SELECT UID, DSE_NO, STATUS FROM TDB_DSE_DETAIL'
      'WHERE'
      '  UID = :UID AND DSE_NO = :DSE_NO')
    SQLLock.Strings = (
      'SELECT NULL FROM TDB_DSE_DETAIL'
      'WHERE'
      'UID = :Old_UID AND DSE_NO = :Old_DSE_NO'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM TDB_DSE_DETAIL'
      ''
      ') q')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'select * from tdb_dse_detail')
    MasterFields = 'UID'
    DetailFields = 'UID'
    MasterSource = IBCDS_DSE
    Left = 984
    Top = 304
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'UID'
        Value = nil
      end>
  end
  object IBCDS_DSE_Detail: TIBCDataSource
    DataSet = IBCQ_DSE_Detail
    Left = 888
    Top = 312
  end
  object IBCScript1: TIBCScript
    ScanParams = False
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultUpdate
    Left = 584
    Top = 288
  end
end
