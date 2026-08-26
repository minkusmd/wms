inherited frame84RegistruCashback: Tframe84RegistruCashback
  Width = 947
  Height = 598
  Font.Height = -15
  ExplicitWidth = 947
  ExplicitHeight = 598
  PixelsPerInch = 120
  object cxGridCashback: TcxGrid
    Left = 0
    Top = 0
    Width = 947
    Height = 598
    Align = alClient
    TabOrder = 0
    LookAndFeel.NativeStyle = True
    LookAndFeel.SkinName = ''
    object cxGridCashbackTable: TcxGridDBTableView
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
      OnCustomDrawCell = cxGridCashbackTableCustomDrawCell
      OnFocusedRecordChanged = cxGridCashbackTableFocusedRecordChanged
      DataController.DataSource = IBCDataSourceCashback
      DataController.Summary.FooterSummaryItems = <
        item
          Kind = skCount
          Column = cxGridCashbackTableCUSTOMERID
          DisplayText = 'TOTAL:'
        end>
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
      OptionsView.Footer = True
      OptionsView.GridLineColor = 13750737
      OptionsView.GroupByBox = False
      OptionsView.GroupRowStyle = grsOffice11
      Preview.LeftIndent = 25
      Preview.RightIndent = 6
      RowLayout.MinValueWidth = 100
      Styles.GroupByBox = dmAdditions.cxStyle_GridGroup
      Styles.Header = dmAdditions.cxStyle_GridHeader
      Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
      object cxGridCashbackTableCUSTOMERID: TcxGridDBColumn
        Caption = 'Cod client'
        DataBinding.FieldName = 'CUSTOMERID'
        HeaderAlignmentHorz = taCenter
      end
      object cxGridCashbackTableCUSTOMER_NAME: TcxGridDBColumn
        Caption = 'Client'
        DataBinding.FieldName = 'CUSTOMER_NAME'
        HeaderAlignmentHorz = taCenter
        Width = 250
      end
      object cxGridCashbackTablePHONES: TcxGridDBColumn
        Caption = 'Nr. telefon'
        DataBinding.FieldName = 'PHONES'
        Width = 120
      end
      object cxGridCashbackTableDATA: TcxGridDBColumn
        Caption = 'Data doc'
        DataBinding.FieldName = 'DATA'
        HeaderAlignmentHorz = taCenter
      end
      object cxGridCashbackTableAMOUNT: TcxGridDBColumn
        Caption = 'Suma'
        DataBinding.FieldName = 'AMOUNT'
        HeaderAlignmentHorz = taCenter
      end
      object cxGridCashbackTableDATA_START: TcxGridDBColumn
        Caption = 'Data inceput'
        DataBinding.FieldName = 'DATA_START'
        HeaderAlignmentHorz = taCenter
      end
      object cxGridCashbackTableDATA_END: TcxGridDBColumn
        Caption = 'Data sfirsit'
        DataBinding.FieldName = 'DATA_END'
        HeaderAlignmentHorz = taCenter
      end
      object cxGridCashbackTableCREATED_BY: TcxGridDBColumn
        DataBinding.FieldName = 'CREATED_BY'
        Visible = False
        VisibleForCustomization = False
        IsCaptionAssigned = True
      end
      object cxGridCashbackTableCREATE_BY_NAME: TcxGridDBColumn
        Caption = 'Creat de...'
        DataBinding.FieldName = 'CREATE_BY_NAME'
        HeaderAlignmentHorz = taCenter
        Width = 250
      end
    end
    object cxGridCashbackLevel: TcxGridLevel
      GridView = cxGridCashbackTable
    end
  end
  object IBCDataSourceCashback: TIBCDataSource
    DataSet = IBCQueryCashback
    Left = 64
    Top = 52
  end
  object IBCQueryCashback: TIBCQuery
    KeyFields = 'CUSTOMERID;DATA'
    SQLInsert.Strings = (
      'INSERT INTO VW_TDB_CASHBACK'
      
        '  (CUSTOMERID, CUSTOMER_NAME, DATA, AMOUNT, DATA_START, DATA_END' +
        ', CREATED_BY, CREATE_BY_NAME)'
      'VALUES'
      
        '  (:CUSTOMERID, :CUSTOMER_NAME, :DATA, :AMOUNT, :DATA_START, :DA' +
        'TA_END, :CREATED_BY, :CREATE_BY_NAME)')
    SQLDelete.Strings = (
      'DELETE FROM VW_TDB_CASHBACK'
      'WHERE'
      '  CUSTOMERID = :Old_CUSTOMERID AND DATA = :Old_DATA')
    SQLUpdate.Strings = (
      'UPDATE VW_TDB_CASHBACK'
      'SET'
      
        '  CUSTOMERID = :CUSTOMERID, CUSTOMER_NAME = :CUSTOMER_NAME, DATA' +
        ' = :DATA, AMOUNT = :AMOUNT, DATA_START = :DATA_START, DATA_END =' +
        ' :DATA_END, CREATED_BY = :CREATED_BY, CREATE_BY_NAME = :CREATE_B' +
        'Y_NAME'
      'WHERE'
      '  CUSTOMERID = :Old_CUSTOMERID AND DATA = :Old_DATA')
    SQLRefresh.Strings = (
      'SELECT * FROM VW_TDB_CASHBACK'
      'WHERE'
      '  CUSTOMERID = :CUSTOMERID AND DATA = :DATA')
    SQLLock.Strings = (
      'SELECT NULL FROM TDB_CASHBACK'
      'WHERE'
      'CUSTOMERID = :Old_CUSTOMERID AND DATA = :Old_DATA'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM VW_TDB_CASHBACK'
      ''
      ') q')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'select * from VW_TDB_CASHBACK')
    AutoCommit = False
    Left = 64
    Top = 96
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
    Top = 72
    PixelsPerInch = 120
  end
  object IBCQuery1: TIBCQuery
    Connection = dmDB.IBCConnection
    Left = 168
    Top = 96
  end
  object IBCDataSource1: TIBCDataSource
    DataSet = IBCQuery1
    Left = 168
    Top = 52
  end
end
