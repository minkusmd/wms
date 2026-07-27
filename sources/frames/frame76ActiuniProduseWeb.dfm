inherited frame76ActiuniProduseWeb: Tframe76ActiuniProduseWeb
  Font.Height = -15
  PixelsPerInch = 120
  object cxGridPTN: TcxGrid
    Left = 0
    Top = 0
    Width = 986
    Height = 340
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
      object cxGridPTN_DOCID: TcxGridDBColumn
        Caption = 'Cod'
        DataBinding.FieldName = 'DOCID'
        HeaderAlignmentHorz = taCenter
        MinWidth = 60
        Options.HorzSizing = False
        Width = 60
      end
      object cxGridPTN_DATA: TcxGridDBColumn
        Caption = 'Data'
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
        Visible = False
        Styles.Content = dmAdditions.cxStyle_GridColumnBOLD
        Width = 200
      end
      object cxGridPTN_SUMA: TcxGridDBColumn
        Caption = #1057#1091#1084#1084#1072
        DataBinding.FieldName = 'SUMA'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        Visible = False
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
        Visible = False
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
        Visible = False
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
        Visible = False
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
        Visible = False
        HeaderAlignmentHorz = taCenter
        MinWidth = 40
        Options.HorzSizing = False
        Width = 40
      end
      object cxGridPTN_CREATED_BY_NAME: TcxGridDBColumn
        Caption = 'Creat de ...'
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
        Visible = False
        Width = 50
      end
    end
    object cxGridPTNLevel: TcxGridLevel
      GridView = cxGridPTNTable
    end
  end
  object cxSplitter: TcxSplitter
    Left = 0
    Top = 340
    Width = 986
    Height = 10
    HotZoneClassName = 'TcxSimpleStyle'
    AlignSplitter = salBottom
    MinSize = 300
  end
  object Panel1: TPanel
    Left = 0
    Top = 350
    Width = 986
    Height = 318
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object cxGrid1: TcxGrid
      Left = 0
      Top = 32
      Width = 986
      Height = 286
      Align = alClient
      TabOrder = 1
      object cxGrid1DBTableView1: TcxGridDBTableView
        OnSelectionChanged = cxGrid1DBTableView1SelectionChanged
        DataController.DataSource = IBCDS_ALERT_GOODS_AVL
        FilterRow.SeparatorWidth = 8
        FixedDataRows.SeparatorWidth = 8
        NewItemRow.SeparatorWidth = 8
        OptionsView.NavigatorOffset = 63
        OptionsView.ColumnAutoWidth = True
        OptionsView.FixedColumnSeparatorWidth = 3
        OptionsView.GroupByBox = False
        Preview.LeftIndent = 25
        Preview.RightIndent = 6
        RowLayout.MinValueWidth = 100
        object cxGrid1DBTableView1CUSTOMERID: TcxGridDBColumn
          DataBinding.FieldName = 'CUSTOMERID'
          Visible = False
          HeaderAlignmentHorz = taCenter
          Options.Editing = False
        end
        object cxGrid1DBTableView1CUSTOMER_NAME: TcxGridDBColumn
          Caption = 'Client'
          DataBinding.FieldName = 'CUSTOMER_NAME'
          HeaderAlignmentHorz = taCenter
          Options.Editing = False
          Width = 200
        end
        object cxGrid1DBTableView1EMAIL: TcxGridDBColumn
          Caption = 'EMail'
          DataBinding.FieldName = 'EMAIL'
          HeaderAlignmentHorz = taCenter
          Options.Editing = False
          Width = 200
        end
        object cxGrid1DBTableView1GSM_NUMBER: TcxGridDBColumn
          Caption = 'SMS numar'
          DataBinding.FieldName = 'GSM_NUMBER'
          HeaderAlignmentHorz = taCenter
          Options.Editing = False
          Width = 100
        end
        object cxGrid1DBTableView1GOODSID: TcxGridDBColumn
          Caption = 'Produs'
          DataBinding.FieldName = 'GOODSID'
          HeaderAlignmentHorz = taCenter
          Options.Editing = False
        end
        object cxGrid1DBTableView1GOODS_NAME: TcxGridDBColumn
          Caption = 'Denumire produs'
          DataBinding.FieldName = 'GOODS_NAME'
          HeaderAlignmentHorz = taCenter
          Options.Editing = False
          Width = 250
        end
        object cxGrid1DBTableView1CREATED_BY: TcxGridDBColumn
          DataBinding.FieldName = 'CREATED_BY'
          Visible = False
          HeaderAlignmentHorz = taCenter
          Options.Editing = False
        end
        object cxGrid1DBTableView1CREATE_BY_NAME: TcxGridDBColumn
          Caption = 'Creat de'
          DataBinding.FieldName = 'CREATE_BY_NAME'
          HeaderAlignmentHorz = taCenter
          Options.Editing = False
          Width = 150
        end
        object cxGrid1DBTableView1FLG_ALERT_SMS: TcxGridDBColumn
          Caption = 'SMS'
          DataBinding.FieldName = 'FLG_ALERT_SMS'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.Alignment = taRightJustify
          HeaderAlignmentHorz = taCenter
          MinWidth = 32
          Options.Editing = False
          Options.HorzSizing = False
          Width = 32
        end
        object cxGrid1DBTableView1FLG_ALERT_MAIL: TcxGridDBColumn
          Caption = 'M'
          DataBinding.FieldName = 'FLG_ALERT_MAIL'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.Alignment = taRightJustify
          HeaderAlignmentHorz = taCenter
          MinWidth = 26
          Options.Editing = False
          Options.HorzSizing = False
          Width = 26
        end
        object cxGrid1DBTableView1FLG_ACTIVE: TcxGridDBColumn
          Caption = 'A'
          DataBinding.FieldName = 'FLG_ACTIVE_REQUEST'
          HeaderAlignmentHorz = taCenter
          MinWidth = 24
          Options.Editing = False
          Options.HorzSizing = False
          Width = 24
        end
      end
      object cxGrid1Level1: TcxGridLevel
        GridView = cxGrid1DBTableView1
      end
    end
    object dxBarDockControl1: TdxBarDockControl
      Left = 0
      Top = 0
      Width = 986
      Height = 32
      Align = dalTop
      BarManager = dxBarManager
    end
  end
  object dxBarManager: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Toolbar')
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    ImageOptions.Images = dmAdditions.cxImageList_SWN
    ImageOptions.StretchGlyphs = False
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 264
    Top = 68
    PixelsPerInch = 120
    object dxBarManagerBar1: TdxBar
      Caption = 'Custom 1'
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1204
      FloatTop = 0
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
          ItemName = 'bbModify'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbDelete'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object bbNew: TdxBarButton
      Caption = 'Nou'
      Category = 0
      Hint = 'Nou'
      Visible = ivAlways
      ImageIndex = 90
      OnClick = bbNewClick
    end
    object bbModify: TdxBarButton
      Caption = 'Modifica'
      Category = 0
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 91
      OnClick = bbModifyClick
    end
    object bbDelete: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 92
      OnClick = bbDeleteClick
    end
  end
  object dxBarPopupMenuDOCS: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <>
    UseOwnFont = False
    OnPopup = dxBarPopupMenuDOCSPopup
    Left = 433
    Top = 70
    PixelsPerInch = 120
  end
  object IBCQueryALERT_GOODS_AVL: TIBCQuery
    KeyFields = 'UID'
    KeyGenerator = 'GEN_TDB_DOCS_ALERT_GOODS_AVL'
    SQLInsert.Strings = (
      'INSERT INTO VW_TDB_DOCS_ALERT_GOODS_AVL'
      
        '  (UID, DOCID, CUSTOMERID, CUSTOMER_NAME, FREE_NAME, FLG_ACTIVE_' +
        'REQUEST, FLG_ALERT_MAIL, FLG_ALERT_SMS, EMAIL, GSM_NUMBER, GOODS' +
        'ID, GOODS_NAME, CREATED_BY, CREATE_BY_NAME)'
      'VALUES'
      
        '  (:UID, :DOCID, :CUSTOMERID, :CUSTOMER_NAME, :FREE_NAME, :FLG_A' +
        'CTIVE_REQUEST, :FLG_ALERT_MAIL, :FLG_ALERT_SMS, :EMAIL, :GSM_NUM' +
        'BER, :GOODSID, :GOODS_NAME, :CREATED_BY, :CREATE_BY_NAME)')
    SQLDelete.Strings = (
      'DELETE FROM VW_TDB_DOCS_ALERT_GOODS_AVL'
      'WHERE'
      '  UID = :Old_UID')
    SQLUpdate.Strings = (
      'UPDATE VW_TDB_DOCS_ALERT_GOODS_AVL'
      'SET'
      
        '  UID = :UID, DOCID = :DOCID, CUSTOMERID = :CUSTOMERID, CUSTOMER' +
        '_NAME = :CUSTOMER_NAME, FREE_NAME = :FREE_NAME, FLG_ACTIVE_REQUE' +
        'ST = :FLG_ACTIVE_REQUEST, FLG_ALERT_MAIL = :FLG_ALERT_MAIL, FLG_' +
        'ALERT_SMS = :FLG_ALERT_SMS, EMAIL = :EMAIL, GSM_NUMBER = :GSM_NU' +
        'MBER, GOODSID = :GOODSID, GOODS_NAME = :GOODS_NAME, CREATED_BY =' +
        ' :CREATED_BY, CREATE_BY_NAME = :CREATE_BY_NAME'
      'WHERE'
      '  UID = :Old_UID')
    SQLRefresh.Strings = (
      
        'SELECT UID, DOCID, CUSTOMERID, CUSTOMER_NAME, FREE_NAME, FLG_ACT' +
        'IVE_REQUEST, FLG_ALERT_MAIL, FLG_ALERT_SMS, EMAIL, GSM_NUMBER, G' +
        'OODSID, GOODS_NAME, CREATED_BY, CREATE_BY_NAME FROM VW_TDB_DOCS_' +
        'ALERT_GOODS_AVL'
      'WHERE'
      '  UID = :UID')
    SQLLock.Strings = (
      'SELECT NULL FROM VW_TDB_DOCS_ALERT_GOODS_AVL'
      'WHERE'
      'UID = :Old_UID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM VW_TDB_DOCS_ALERT_GOODS_AVL'
      ''
      ') q')
    Connection = dmDB.IBCConnection
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'select * from VW_TDB_DOCS_ALERT_GOODS_AVL')
    MasterFields = 'DOCID'
    DetailFields = 'DOCID'
    MasterSource = dmDB.IBCDataSourceDocs
    Active = True
    Left = 584
    Top = 312
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DOCID'
        Value = nil
      end>
  end
  object IBCDS_ALERT_GOODS_AVL: TIBCDataSource
    DataSet = IBCQueryALERT_GOODS_AVL
    Left = 480
    Top = 312
  end
end
