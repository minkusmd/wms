object frmCustomerCategoryPricesDlg: TfrmCustomerCategoryPricesDlg
  Left = 0
  Top = 0
  Margins.Left = 5
  Margins.Top = 5
  Margins.Right = 5
  Margins.Bottom = 5
  BorderStyle = bsDialog
  Caption = 'Categorii produse in pricelist'
  ClientHeight = 751
  ClientWidth = 737
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -19
  Font.Name = 'Tahoma'
  Font.Style = []
  PixelsPerInch = 168
  TextHeight = 23
  object Panel1: TPanel
    Left = 0
    Top = 679
    Width = 737
    Height = 72
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 9
    Margins.Bottom = 5
    Align = alBottom
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 5
    object Button1: TButton
      Left = 238
      Top = 11
      Width = 158
      Height = 50
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'Inchide'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 45
    Width = 737
    Height = 634
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alClient
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 0
    ExplicitTop = 49
    ExplicitHeight = 630
    object cxGrid1: TcxGrid
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 723
      Height = 221
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alTop
      TabOrder = 0
      ExplicitWidth = 720
      object cxGrid1DBTableView1: TcxGridDBTableView
        DataController.DataSource = IBCDataSourceCust_Price_Categories
        DataController.KeyFieldNames = 'PRICE_CATEGORYID'
        FilterRow.SeparatorWidth = 11
        FixedDataRows.SeparatorWidth = 11
        NewItemRow.SeparatorWidth = 11
        OptionsView.NavigatorOffset = 88
        OptionsView.ColumnAutoWidth = True
        OptionsView.FixedColumnSeparatorWidth = 4
        OptionsView.GroupByBox = False
        Preview.LeftIndent = 35
        Preview.RightIndent = 9
        RowLayout.MinValueWidth = 140
        object cxGrid1DBTableView1_PRICE_CATEGORYID: TcxGridDBColumn
          Caption = 'ID'
          DataBinding.FieldName = 'PRICE_CATEGORYID'
          MinWidth = 35
          Width = 114
        end
        object cxGrid1DBTableView1_TITLE: TcxGridDBColumn
          Caption = 'Denumire'
          DataBinding.FieldName = 'TITLE'
          MinWidth = 35
          Width = 1038
        end
      end
      object cxGrid1Level1: TcxGridLevel
        GridView = cxGrid1DBTableView1
      end
    end
    object cxDBMemo1: TcxDBMemo
      AlignWithMargins = True
      Left = 5
      Top = 236
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alClient
      DataBinding.DataField = 'WORKING_RULES'
      DataBinding.DataSource = IBCDataSourceCustSuppliers
      TabOrder = 1
      ExplicitWidth = 720
      ExplicitHeight = 382
      Height = 389
      Width = 723
    end
  end
  object dxBarManager1: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Default')
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    ImageOptions.Images = dmAdditions.cxImageList_SWN
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 360
    Top = 200
    PixelsPerInch = 168
    DockControlHeights = (
      0
      0
      45
      0)
    object dxBarManager1Bar1: TdxBar
      Caption = 'Custom 1'
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 0
      DockedTop = 0
      DockingStyle = dsTop
      FloatLeft = 756
      FloatTop = 2
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
      ImageIndex = 40
      ShortCut = 45
      OnClick = bbNewClick
    end
    object bbModify: TdxBarButton
      Caption = 'Modifica'
      Category = 0
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 115
      OnClick = bbModifyClick
    end
    object bbDelete: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      ShortCut = 16430
      OnClick = bbDeleteClick
    end
  end
  object IBCQueryCust_Price_Categories: TIBCQuery
    KeyFields = 'price_categoryid'
    KeyGenerator = 'gen_ts_cust_price_categories_id'
    SQLInsert.Strings = (
      'INSERT INTO TS_CUST_PRICE_CATEGORIES'
      '  (PRICE_CATEGORYID, CUSTOMERID, TITLE)'
      'VALUES'
      '  (:PRICE_CATEGORYID, :CUSTOMERID, :TITLE)')
    SQLDelete.Strings = (
      'DELETE FROM TS_CUST_PRICE_CATEGORIES'
      'WHERE'
      '  PRICE_CATEGORYID = :Old_PRICE_CATEGORYID')
    SQLUpdate.Strings = (
      'UPDATE TS_CUST_PRICE_CATEGORIES'
      'SET'
      
        '  PRICE_CATEGORYID = :PRICE_CATEGORYID, CUSTOMERID = :CUSTOMERID' +
        ', TITLE = :TITLE'
      'WHERE'
      '  PRICE_CATEGORYID = :Old_PRICE_CATEGORYID')
    SQLRefresh.Strings = (
      
        'SELECT PRICE_CATEGORYID, CUSTOMERID, TITLE FROM TS_CUST_PRICE_CA' +
        'TEGORIES'
      'WHERE'
      '  PRICE_CATEGORYID = :PRICE_CATEGORYID')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM TS_CUST_PRICE_CATEGORIES'
      ''
      ') q')
    UpdateTransaction = IBCTrLocal
    SQL.Strings = (
      
        'select * from ts_cust_price_categories where customerid = :custo' +
        'merid')
    Left = 313
    Top = 121
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'customerid'
        Value = nil
      end>
  end
  object IBCDataSourceCust_Price_Categories: TIBCDataSource
    DataSet = IBCQueryCust_Price_Categories
    Left = 161
    Top = 98
  end
  object IBCTrLocal: TIBCTransaction
    Left = 306
    Top = 201
  end
  object IBCQueryCustSuppliers: TIBCQuery
    KeyFields = 'CUSTOMERID'
    SQLInsert.Strings = (
      'INSERT INTO TS_CUST_SUPPLIERS'
      '  (CUSTOMERID, DEFERRED_PAYMENT_DAYS, WORKING_RULES)'
      'VALUES'
      '  (:CUSTOMERID, :DEFERRED_PAYMENT_DAYS, :WORKING_RULES)')
    SQLDelete.Strings = (
      'DELETE FROM TS_CUST_SUPPLIERS'
      'WHERE'
      '  CUSTOMERID = :Old_CUSTOMERID')
    SQLUpdate.Strings = (
      'UPDATE TS_CUST_SUPPLIERS'
      'SET'
      
        '  CUSTOMERID = :CUSTOMERID, DEFERRED_PAYMENT_DAYS = :DEFERRED_PA' +
        'YMENT_DAYS, WORKING_RULES = :WORKING_RULES'
      'WHERE'
      '  CUSTOMERID = :Old_CUSTOMERID')
    SQLRefresh.Strings = (
      
        'SELECT CUSTOMERID, DEFERRED_PAYMENT_DAYS, WORKING_RULES FROM TS_' +
        'CUST_SUPPLIERS'
      'WHERE'
      '  CUSTOMERID = :CUSTOMERID')
    SQLLock.Strings = (
      'SELECT NULL FROM TS_CUST_SUPPLIERS'
      'WHERE'
      'CUSTOMERID = :Old_CUSTOMERID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM TS_CUST_SUPPLIERS'
      ''
      ') q')
    UpdateTransaction = IBCTrLocal
    SQL.Strings = (
      'select * from TS_CUST_SUPPLIERS'
      'where customerid = :customerid')
    BeforePost = IBCQueryCustSuppliersBeforePost
    Left = 98
    Top = 287
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'customerid'
        Value = nil
      end>
  end
  object IBCDataSourceCustSuppliers: TIBCDataSource
    DataSet = IBCQueryCustSuppliers
    Left = 100
    Top = 231
  end
end
