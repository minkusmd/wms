inherited frame83PromoCoduri: Tframe83PromoCoduri
  Width = 1062
  Height = 667
  Font.Height = -15
  ExplicitWidth = 1062
  ExplicitHeight = 667
  PixelsPerInch = 120
  object cxGridPromoTickets: TcxGrid
    Left = 0
    Top = 71
    Width = 1062
    Height = 288
    Align = alClient
    TabOrder = 3
    LookAndFeel.NativeStyle = True
    LookAndFeel.SkinName = ''
    object cxGridPromoTicketsTable: TcxGridDBTableView
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
      OnCustomDrawCell = cxGridPromoTicketsTableCustomDrawCell
      OnFocusedRecordChanged = cxGridPromoTicketsTableFocusedRecordChanged
      DataController.DataSource = IBCDataSourcePromoTickets
      DataController.KeyFieldNames = 'TICKETID'
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
      OptionsView.ColumnAutoWidth = True
      OptionsView.FixedColumnSeparatorWidth = 3
      OptionsView.GridLineColor = 13750737
      OptionsView.GroupByBox = False
      OptionsView.GroupRowStyle = grsOffice11
      Preview.LeftIndent = 25
      Preview.RightIndent = 6
      RowLayout.MinValueWidth = 100
      Styles.GroupByBox = dmAdditions.cxStyle_GridGroup
      Styles.Header = dmAdditions.cxStyle_GridHeader
      Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
      object cxGridPromoTicketsTableTICKETID: TcxGridDBColumn
        Caption = 'ID'
        DataBinding.FieldName = 'TICKETID'
        HeaderAlignmentHorz = taCenter
        Width = 78
      end
      object cxGridPromoTicketsTableTITLE: TcxGridDBColumn
        Caption = 'Denumire'
        DataBinding.FieldName = 'TITLE_RO'
        HeaderAlignmentHorz = taCenter
        Width = 586
      end
      object cxGridPromoTicketsTableTICKET_CODE: TcxGridDBColumn
        Caption = 'Promo Code'
        DataBinding.FieldName = 'TICKET_CODE'
        HeaderAlignmentHorz = taCenter
        Width = 156
      end
      object cxGridPromoTicketsTableDATA1: TcxGridDBColumn
        Caption = 'Data inceput'
        DataBinding.FieldName = 'DATA1'
        HeaderAlignmentHorz = taCenter
        Width = 188
      end
      object cxGridPromoTicketsTableDATA2: TcxGridDBColumn
        Caption = 'Data sfirsit'
        DataBinding.FieldName = 'DATA2'
        HeaderAlignmentHorz = taCenter
        Width = 179
      end
      object cxGridPromoTicketsTableDISCOUNT_VALUE: TcxGridDBColumn
        Caption = 'Valoarea reducerii'
        DataBinding.FieldName = 'DISCOUNT_VALUE'
        HeaderAlignmentHorz = taCenter
        Width = 183
      end
      object cxGridPromoTicketsTableDISCOUNT_PERCENT: TcxGridDBColumn
        Caption = 'Procentul reducerii'
        DataBinding.FieldName = 'DISCOUNT_PERCENT'
        HeaderAlignmentHorz = taCenter
        Width = 180
      end
    end
    object cxGridPromoTicketsLevel: TcxGridLevel
      GridView = cxGridPromoTicketsTable
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1062
    Height = 39
    Align = alTop
    AutoSize = True
    BevelOuter = bvNone
    Color = clGray
    Padding.Left = 8
    Padding.Top = 8
    Padding.Right = 8
    Padding.Bottom = 8
    ParentBackground = False
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 1046
      Height = 23
      Align = alTop
      Caption = 'Promo coduri'
      Color = clGray
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clHighlightText
      Font.Height = -17
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = False
      ExplicitWidth = 109
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 367
    Width = 1062
    Height = 300
    Align = alBottom
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    object cxGrid1: TcxGrid
      Left = 0
      Top = 32
      Width = 1062
      Height = 268
      Align = alClient
      TabOrder = 1
      object cxGrid1DBTableView1: TcxGridDBTableView
        DataController.DataSource = IBCDataSourcePromoTicketsItems
        FilterRow.SeparatorWidth = 8
        FixedDataRows.SeparatorWidth = 8
        NewItemRow.SeparatorWidth = 8
        OptionsView.NavigatorOffset = 63
        OptionsView.FixedColumnSeparatorWidth = 3
        OptionsView.GroupByBox = False
        Preview.LeftIndent = 25
        Preview.RightIndent = 6
        RowLayout.MinValueWidth = 100
        object cxGrid1DBTableView1TICKETID: TcxGridDBColumn
          DataBinding.FieldName = 'TICKETID'
          Visible = False
        end
        object cxGrid1DBTableView1PROMO_CODE: TcxGridDBColumn
          DataBinding.FieldName = 'PROMO_CODE'
        end
      end
      object cxGrid1Level1: TcxGridLevel
        GridView = cxGrid1DBTableView1
      end
    end
    object dxBarDockControl1: TdxBarDockControl
      Left = 0
      Top = 0
      Width = 1062
      Height = 32
      Align = dalTop
      BarManager = dxBarManager1
    end
  end
  object cxSplitter1: TcxSplitter
    Left = 0
    Top = 359
    Width = 1062
    Height = 8
    AlignSplitter = salBottom
  end
  object dxBarDockControl2: TdxBarDockControl
    Left = 0
    Top = 39
    Width = 1062
    Height = 32
    Align = dalTop
    BarManager = dxBarManager1
  end
  object IBCQueryPromoTickets: TIBCQuery
    KeyFields = 'TICKETID'
    KeyGenerator = 'GEN_MK_PROMO_TICKETS_ID'
    GeneratorMode = gmInsert
    SQLInsert.Strings = (
      'INSERT INTO VW_MK_PROMO_TICKETS'
      
        '  (TICKETID, TITLE_RO, TITLE_RU, TICKET_CODE, DATA1, DATA2, DISC' +
        'OUNT_VALUE, DISCOUNT_PERCENT, GG_ID, GOODS_GROUP_TITLE, '
      '   IMAGE_RO, IMAGE_RU, flg_enabled)'
      'VALUES'
      
        '  (:TICKETID, :TITLE_RO, :TITLE_RU, :TICKET_CODE, :DATA1, :DATA2' +
        ', :DISCOUNT_VALUE, :DISCOUNT_PERCENT, :GG_ID, :GOODS_GROUP_TITLE' +
        ', '
      '   :IMAGE_RO, :IMAGE_RU, :flg_enabled)')
    SQLDelete.Strings = (
      'DELETE FROM VW_MK_PROMO_TICKETS'
      'WHERE'
      '  TICKETID = :Old_TICKETID')
    SQLUpdate.Strings = (
      'UPDATE VW_MK_PROMO_TICKETS'
      'SET'
      
        '  TICKETID = :TICKETID, TITLE_RO = :TITLE_RO, TITLE_RU = :TITLE_' +
        'RU, TICKET_CODE = :TICKET_CODE, '
      
        'DATA1 = :DATA1, DATA2 = :DATA2, DISCOUNT_VALUE = :DISCOUNT_VALUE' +
        ', DISCOUNT_PERCENT = :DISCOUNT_PERCENT, '
      
        'GG_ID = :GG_ID, GOODS_GROUP_TITLE = :GOODS_GROUP_TITLE, IMAGE_RO' +
        ' = :IMAGE_RO, IMAGE_RU = :IMAGE_RU,'
      'flg_enabled = :flg_enabled'
      'WHERE'
      '  TICKETID = :Old_TICKETID')
    SQLRefresh.Strings = (
      
        'SELECT TICKETID, TITLE_RO, TITLE_RU, TICKET_CODE, DATA1, DATA2, ' +
        'DISCOUNT_VALUE, DISCOUNT_PERCENT, GG_ID, GOODS_GROUP_TITLE, '
      '  IMAGE_RO, IMAGE_RU, flg_enabled'
      'FROM VW_MK_PROMO_TICKETS'
      'WHERE'
      '  TICKETID = :TICKETID')
    SQLLock.Strings = (
      'SELECT NULL FROM MK_PROMO_TICKETS'
      'WHERE'
      'TICKETID = :Old_TICKETID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM VW_MK_PROMO_TICKETS'
      ''
      ') q')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'SELECT '
      ' *'
      'FROM '
      ' vw_MK_PROMO_TICKETS'
      '&m45days')
    AutoCommit = False
    LockMode = lmLockImmediate
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Left = 300
    Top = 148
    MacroData = <
      item
        Name = 'm45days'
      end>
  end
  object IBCDataSourcePromoTickets: TIBCDataSource
    DataSet = IBCQueryPromoTickets
    Left = 304
    Top = 84
  end
  object IBCQueryPromoTicketsItems: TIBCQuery
    SQLInsert.Strings = (
      'INSERT INTO MK_PROMO_TICKETS_ITEMS'
      '  (TICKETID, PROMO_CODE)'
      'VALUES'
      '  (:TICKETID, :PROMO_CODE)')
    SQLDelete.Strings = (
      'DELETE FROM MK_PROMO_TICKETS_ITEMS'
      'WHERE'
      '  TICKETID = :Old_TICKETID AND PROMO_CODE = :Old_PROMO_CODE')
    SQLUpdate.Strings = (
      'UPDATE MK_PROMO_TICKETS_ITEMS'
      'SET'
      '  TICKETID = :TICKETID, PROMO_CODE = :PROMO_CODE'
      'WHERE'
      '  TICKETID = :Old_TICKETID AND PROMO_CODE = :Old_PROMO_CODE')
    SQLRefresh.Strings = (
      'SELECT TICKETID, PROMO_CODE FROM MK_PROMO_TICKETS_ITEMS'
      'WHERE'
      '  TICKETID = :TICKETID AND PROMO_CODE = :PROMO_CODE')
    SQLLock.Strings = (
      'SELECT NULL FROM MK_PROMO_TICKETS_ITEMS'
      'WHERE'
      'TICKETID = :Old_TICKETID AND PROMO_CODE = :Old_PROMO_CODE'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM MK_PROMO_TICKETS_ITEMS'
      ''
      ') q')
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'select * from MK_PROMO_TICKETS_ITEMS')
    MasterFields = 'TICKETID'
    DetailFields = 'TICKETID'
    MasterSource = IBCDataSourcePromoTickets
    Active = True
    Left = 760
    Top = 472
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TICKETID'
        Value = nil
      end>
  end
  object IBCDataSourcePromoTicketsItems: TIBCDataSource
    DataSet = IBCQueryPromoTicketsItems
    Left = 760
    Top = 416
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
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 688
    Top = 320
    PixelsPerInch = 120
    object dxBarManager1Bar1: TdxBar
      Caption = 'Items'
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1406
      FloatTop = 0
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar2: TdxBar
      Caption = 'Promo Coduri'
      CaptionButtons = <>
      DockControl = dxBarDockControl2
      DockedDockControl = dxBarDockControl2
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1072
      FloatTop = 0
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbShowAllRecords'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object bbShowAllRecords: TdxBarButton
      Caption = 'Arata toate inregistrarile'
      Category = 0
      Hint = 'Arata toate inregistrarile'
      Visible = ivAlways
      ButtonStyle = bsChecked
      OnClick = bbShowAllRecordsClick
    end
  end
end
