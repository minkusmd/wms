inherited frame47ActiuniMarketing: Tframe47ActiuniMarketing
  Width = 1095
  Height = 626
  Font.Height = -15
  ExplicitWidth = 1095
  ExplicitHeight = 626
  PixelsPerInch = 120
  object cxGridActiuni: TcxGrid
    Left = 0
    Top = 39
    Width = 1095
    Height = 587
    Align = alClient
    TabOrder = 1
    LookAndFeel.NativeStyle = True
    LookAndFeel.SkinName = ''
    object cxGridActiuniTable: TcxGridDBTableView
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
      OnCustomDrawCell = cxGridActiuniTableCustomDrawCell
      OnFocusedRecordChanged = cxGridActiuniTableFocusedRecordChanged
      DataController.DataSource = IBCDataSourceActiuni
      DataController.KeyFieldNames = 'ACTIUNE_ID'
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
      object cxGridActiuniTable_ACTIUNE_ID: TcxGridDBColumn
        Caption = 'Cod'
        DataBinding.FieldName = 'ACTIUNE_ID'
        HeaderAlignmentHorz = taCenter
        MinWidth = 60
        Options.HorzSizing = False
        Width = 60
      end
      object cxGridActiuniTable_TITLE: TcxGridDBColumn
        Caption = 'Denumire'
        DataBinding.FieldName = 'TITLE'
        Width = 300
      end
      object cxGridActiuniTable_DISCOUNT: TcxGridDBColumn
        Caption = 'Reducere, %'
        DataBinding.FieldName = 'DISCOUNT'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        MinWidth = 80
        Options.HorzSizing = False
        Width = 80
      end
      object cxGridActiuniTableColumn1: TcxGridDBColumn
        PropertiesClassName = 'TcxComboBoxProperties'
      end
      object cxGridActiuniTable_START_DATE: TcxGridDBColumn
        Caption = 'Inceput'
        DataBinding.FieldName = 'START_DATE'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        MinWidth = 80
        Options.HorzSizing = False
        Width = 80
      end
      object cxGridActiuniTable_END_DATE: TcxGridDBColumn
        Caption = 'Sfirsit'
        DataBinding.FieldName = 'END_DATE'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        MinWidth = 80
        Options.HorzSizing = False
        Width = 80
      end
      object cxGridActiuniTable_FLG_ENABLED: TcxGridDBColumn
        Caption = 'Activ'
        DataBinding.FieldName = 'FLG_ENABLED'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        HeaderAlignmentHorz = taCenter
        MinWidth = 40
        Options.HorzSizing = False
        Width = 40
      end
      object cxGridActiuniTable_ANALITICA_TITLE: TcxGridDBColumn
        Caption = 'Analitica'
        DataBinding.FieldName = 'ANALITICA_TITLE'
        MinWidth = 160
        Options.HorzSizing = False
        Width = 160
      end
      object cxGridActiuniTable_CREATED_BY_NAME: TcxGridDBColumn
        Caption = 'Operator'
        DataBinding.FieldName = 'CREATED_BY_NAME'
        MinWidth = 160
        Options.HorzSizing = False
        Width = 160
      end
    end
    object cxGridActiuniLevel: TcxGridLevel
      GridView = cxGridActiuniTable
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1095
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
      Width = 1079
      Height = 23
      Align = alTop
      Caption = 'Actiuni de marketing'
      Color = clTeal
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clHighlightText
      Font.Height = -17
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      ExplicitWidth = 171
    end
  end
  object IBCQueryActiuni: TIBCQuery
    KeyFields = 'ACTIUNE_ID'
    KeyGenerator = 'SQ_MK_ACTIUNI_ID'
    GeneratorMode = gmInsert
    SQLInsert.Strings = (
      'INSERT INTO VW_MK_ACTIUNI'
      
        '  (ACTIUNE_ID, TITLE, DESCRIPTION, START_DATE, END_DATE, WEEK_DA' +
        'YS, ANALITICA_ID, DIST_CNT_VALUE, DIST_CNT_GROUP_ID, '
      
        '   SINGLE_QTY_VALUE, TOTAL_QTY_VALUE, TOTAL_QTY_GROUP_ID, TOTAL_' +
        'SUM_VALUE, TOTAL_SUM_GROUP_ID, '
      
        '   FLG_ENABLED, FLG_DIST_CNT, FLG_SINGLE_QTY, FLG_TOTAL_QTY, FLG' +
        '_TOTAL_SUM,'
      
        '   FLG_CLIENT, FLG_CLIENT_CARD, FLG_CLIENT_DEALER, FLG_POST_RC, ' +
        'FLG_CASHBACK, DISCOUNT, DISCOUNT_TYPE, SELECTED_FIRME, '
      '   PROMO_GOODS_GROUP_ID, DEST_GOODS_GROUPS_ID)'
      'VALUES'
      
        '  (:ACTIUNE_ID, :TITLE, :DESCRIPTION, :START_DATE, :END_DATE, :W' +
        'EEK_DAYS, :ANALITICA_ID, :DIST_CNT_VALUE, :DIST_CNT_GROUP_ID, '
      
        '   :SINGLE_QTY_VALUE, :TOTAL_QTY_VALUE, :TOTAL_QTY_GROUP_ID, :TO' +
        'TAL_SUM_VALUE, :TOTAL_SUM_GROUP_ID, '
      
        '   :FLG_ENABLED, :FLG_DIST_CNT, :FLG_SINGLE_QTY, :FLG_TOTAL_QTY,' +
        ' :FLG_TOTAL_SUM,'
      
        '   :FLG_CLIENT, :FLG_CLIENT_CARD, :FLG_CLIENT_DEALER, :FLG_POST_' +
        'RC, :FLG_CASHBACK, :DISCOUNT, :DISCOUNT_TYPE, :SELECTED_FIRME, '
      '   :PROMO_GOODS_GROUP_ID, :DEST_GOODS_GROUPS_ID)')
    SQLDelete.Strings = (
      'DELETE FROM MK_ACTIUNI'
      'WHERE'
      '  ACTIUNE_ID = :Old_ACTIUNE_ID')
    SQLUpdate.Strings = (
      'UPDATE VW_MK_ACTIUNI'
      'SET'
      '  ACTIUNE_ID = :ACTIUNE_ID, '
      '  TITLE = :TITLE, '
      '  DESCRIPTION = :DESCRIPTION, '
      '  START_DATE = :START_DATE, '
      '  END_DATE = :END_DATE, '
      '  WEEK_DAYS = :WEEK_DAYS, '
      '  ANALITICA_ID = :ANALITICA_ID, '
      '  DIST_CNT_VALUE = :DIST_CNT_VALUE, '
      '  DIST_CNT_GROUP_ID = :DIST_CNT_GROUP_ID, '
      '  SINGLE_QTY_VALUE = :SINGLE_QTY_VALUE, '
      '  TOTAL_QTY_VALUE = :TOTAL_QTY_VALUE, '
      '  TOTAL_QTY_GROUP_ID = :TOTAL_QTY_GROUP_ID, '
      '  TOTAL_SUM_VALUE = :TOTAL_SUM_VALUE, '
      '  TOTAL_SUM_GROUP_ID = :TOTAL_SUM_GROUP_ID, '
      '  FLG_ENABLED = :FLG_ENABLED, '
      '  FLG_DIST_CNT = :FLG_DIST_CNT, '
      '  FLG_SINGLE_QTY = :FLG_SINGLE_QTY, '
      '  FLG_TOTAL_QTY = :FLG_TOTAL_QTY, '
      '  FLG_TOTAL_SUM = :FLG_TOTAL_SUM,'
      '  FLG_CLIENT = :FLG_CLIENT,'
      '  FLG_CLIENT_CARD = :FLG_CLIENT_CARD,'
      '  FLG_CLIENT_DEALER = :FLG_CLIENT_DEALER,'
      '  FLG_POST_RC = :FLG_POST_RC,'
      '  FLG_CASHBACK = :FLG_CASHBACK, '
      '  DISCOUNT = :DISCOUNT,'
      '  DISCOUNT_TYPE = :DISCOUNT_TYPE,'
      '  SELECTED_FIRME = :SELECTED_FIRME,'
      '  PROMO_GOODS_GROUP_ID = :PROMO_GOODS_GROUP_ID,'
      '  DEST_GOODS_GROUPS_ID = :DEST_GOODS_GROUPS_ID'
      ''
      'WHERE'
      '  ACTIUNE_ID = :Old_ACTIUNE_ID')
    SQLRefresh.Strings = (
      'SELECT '
      ' ACTIUNE_ID, '
      ' TITLE, '
      ' DESCRIPTION, '
      ' START_DATE, '
      ' END_DATE, '
      ' WEEK_DAYS, '
      ' ANALITICA_ID, '
      ' ANALITICA_TITLE,'
      ' DIST_CNT_VALUE, '
      ' DIST_CNT_GROUP_ID, '
      ' DIST_CNT_GROUP_TITLE,'
      ' SINGLE_QTY_VALUE, '
      ' TOTAL_QTY_VALUE, '
      ' TOTAL_QTY_GROUP_ID, '
      ' TOTAL_QTY_GROUP_TITLE,'
      ' TOTAL_SUM_VALUE, '
      ' TOTAL_SUM_GROUP_ID, '
      ' TOTAL_SUM_GROUP_TITLE,'
      ' FLG_ENABLED, '
      ' FLG_DIST_CNT, '
      ' FLG_SINGLE_QTY, '
      ' FLG_TOTAL_QTY, '
      ' FLG_TOTAL_SUM,'
      ' CREATED_BY_NAME,'
      ' FLG_CLIENT,'
      ' FLG_CLIENT_CARD,'
      ' FLG_CLIENT_DEALER,'
      ' FLG_POST_RC,'
      ' FLG_CASHBACK,'
      ' DISCOUNT,'
      ' DISCOUNT_TYPE,'
      ' SELECTED_FIRME,'
      ' PROMO_GOODS_GROUP_ID,'
      ' PROMO_GOODS_GROUP_TITLE,'
      ' DEST_GOODS_GROUPS_ID,'
      ' DEST_GOODS_GROUPS_TITLE'
      ''
      'FROM '
      ' VW_MK_ACTIUNI'
      'WHERE'
      '  ACTIUNE_ID = :ACTIUNE_ID')
    SQLLock.Strings = (
      'SELECT '
      ' NULL '
      'FROM '
      ' MK_ACTIUNI'
      'WHERE'
      ' ACTIUNE_ID = :Old_ACTIUNE_ID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM (SELECT 1 AS C  FROM MK_ACTIUNI) q')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'SELECT '
      ' ACTIUNE_ID, '
      ' TITLE, '
      ' DESCRIPTION, '
      ' START_DATE, '
      ' END_DATE, '
      ' WEEK_DAYS, '
      ' ANALITICA_ID, '
      ' ANALITICA_TITLE,'
      ' DIST_CNT_VALUE, '
      ' DIST_CNT_GROUP_ID, '
      ' DIST_CNT_GROUP_TITLE,'
      ' SINGLE_QTY_VALUE, '
      ' TOTAL_QTY_VALUE, '
      ' TOTAL_QTY_GROUP_ID, '
      ' TOTAL_QTY_GROUP_TITLE,'
      ' TOTAL_SUM_VALUE, '
      ' TOTAL_SUM_GROUP_ID, '
      ' TOTAL_SUM_GROUP_TITLE,'
      ' FLG_ENABLED, '
      ' FLG_DIST_CNT, '
      ' FLG_SINGLE_QTY, '
      ' FLG_TOTAL_QTY, '
      ' FLG_TOTAL_SUM,'
      ' CREATED_BY_NAME,'
      ' FLG_CLIENT,'
      ' FLG_CLIENT_CARD,'
      ' FLG_CLIENT_DEALER,'
      ' FLG_POST_RC,'
      ' FLG_CASHBACK,'
      ' DISCOUNT,'
      ' DISCOUNT_TYPE,'
      ' SELECTED_FIRME,'
      ' PROMO_GOODS_GROUP_ID,'
      ' PROMO_GOODS_GROUP_TITLE,'
      ' DEST_GOODS_GROUPS_ID,'
      ' DEST_GOODS_GROUPS_TITLE'
      ''
      'FROM '
      ' VW_MK_ACTIUNI')
    AutoCommit = False
    LockMode = lmLockImmediate
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Left = 300
    Top = 148
  end
  object IBCDataSourceActiuni: TIBCDataSource
    DataSet = IBCQueryActiuni
    Left = 296
    Top = 300
  end
end
