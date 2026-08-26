inherited frame87SupplierPromo: Tframe87SupplierPromo
  Width = 970
  Height = 639
  Font.Height = -15
  ExplicitWidth = 970
  ExplicitHeight = 639
  PixelsPerInch = 120
  object cxGridSupplierPromo: TcxGrid
    Left = 0
    Top = 39
    Width = 970
    Height = 600
    Align = alClient
    TabOrder = 1
    LookAndFeel.NativeStyle = True
    LookAndFeel.SkinName = ''
    object cxGridSupplierPromoTable: TcxGridDBTableView
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
      OnCustomDrawCell = cxGridSupplierPromoTableCustomDrawCell
      OnFocusedRecordChanged = cxGridSupplierPromoTableFocusedRecordChanged
      DataController.DataSource = IBCDataSourceSupplierPromo
      DataController.KeyFieldNames = 'ID'
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
      object cxGridSupplierPromoTable_ID: TcxGridDBColumn
        DataBinding.FieldName = 'id'
        HeaderAlignmentHorz = taCenter
        Width = 82
      end
      object cxGridSupplierPromoTable_SupplierID: TcxGridDBColumn
        Caption = 'Furnizor'
        DataBinding.FieldName = 'SUPPLIER_NAME'
        HeaderAlignmentHorz = taCenter
        Width = 221
      end
      object cxGridSupplierPromoTable_TITLE: TcxGridDBColumn
        Caption = 'Denumire'
        DataBinding.FieldName = 'TITLE'
        HeaderAlignmentHorz = taCenter
        Width = 525
      end
      object cxGridSupplierPromoTable_DATA1: TcxGridDBColumn
        Caption = 'Data inceput'
        DataBinding.FieldName = 'DATA1'
        HeaderAlignmentHorz = taCenter
        Width = 169
      end
      object cxGridSupplierPromoTable_DATA2: TcxGridDBColumn
        Caption = 'Data sfirsit'
        DataBinding.FieldName = 'DATA2'
        HeaderAlignmentHorz = taCenter
        Width = 160
      end
    end
    object cxGridSupplierPromoLevel: TcxGridLevel
      GridView = cxGridSupplierPromoTable
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 970
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
  end
  object IBCQuerySupplierPromo: TIBCQuery
    KeyFields = 'ID'
    KeyGenerator = 'GEN_MK_SUPPLIER_PROMO_ID'
    SQLInsert.Strings = (
      'INSERT INTO VW_MK_SUPPLIER_PROMO'
      
        '  (ID, SUPPLIERID, SUPPLIER_NAME, TITLE, DATA1, DATA2, GGID, GG_' +
        'NAME)'
      'VALUES'
      
        '  (:ID, :SUPPLIERID, :SUPPLIER_NAME, :TITLE, :DATA1, :DATA2, :GG' +
        'ID, :GG_NAME)')
    SQLDelete.Strings = (
      'DELETE FROM VW_MK_SUPPLIER_PROMO'
      'WHERE'
      '  ID = :Old_ID')
    SQLUpdate.Strings = (
      'UPDATE VW_MK_SUPPLIER_PROMO'
      'SET'
      
        '  ID = :ID, SUPPLIERID = :SUPPLIERID, SUPPLIER_NAME = :SUPPLIER_' +
        'NAME, TITLE = :TITLE, DATA1 = :DATA1, DATA2 = :DATA2, GGID = :GG' +
        'ID, GG_NAME = :GG_NAME'
      'WHERE'
      '  ID = :Old_ID')
    SQLRefresh.Strings = (
      
        'SELECT ID, SUPPLIERID, SUPPLIER_NAME, TITLE, DATA1, DATA2, GGID,' +
        ' GG_NAME FROM VW_MK_SUPPLIER_PROMO'
      'WHERE'
      '  ID = :ID')
    SQLLock.Strings = (
      'SELECT NULL FROM MK_SUPPLIER_PROMO'
      'WHERE'
      'ID = :Old_ID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM VW_MK_SUPPLIER_PROMO'
      ''
      ') q')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'select * from VW_MK_SUPPLIER_PROMO'
      'order by data2 ')
    AutoCommit = False
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Options.DefaultValues = True
    Left = 216
    Top = 80
  end
  object IBCDataSourceSupplierPromo: TIBCDataSource
    DataSet = IBCQuerySupplierPromo
    Left = 96
    Top = 80
  end
end
