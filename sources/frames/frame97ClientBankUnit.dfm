inherited frame97ClientBank: Tframe97ClientBank
  Width = 1139
  Height = 689
  Margins.Left = 4
  Margins.Top = 4
  Margins.Right = 4
  Margins.Bottom = 4
  Font.Height = -12
  ExplicitWidth = 1139
  ExplicitHeight = 689
  object cxPageControl1: TcxPageControl
    Left = 0
    Top = 0
    Width = 1139
    Height = 504
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    TabOrder = 0
    Properties.ActivePage = tbsMaib
    Properties.CustomButtons.Buttons = <>
    ClientRectBottom = 500
    ClientRectLeft = 4
    ClientRectRight = 1135
    ClientRectTop = 26
    object tbsMaib: TcxTabSheet
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'MAIB'
      ImageIndex = 0
      object cxGrid1: TcxGrid
        Left = 0
        Top = 28
        Width = 711
        Height = 446
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alLeft
        TabOrder = 1
        object cxGrid1DBTableView1: TcxGridDBTableView
          Navigator.Visible = True
          FindPanel.DisplayMode = fpdmAlways
          FindPanel.UseExtendedSyntax = True
          DataController.DataModeController.GridModeBufferCount = 75
          DataController.DataSource = IBCDataSourcePaymentsMAIB
          DataController.KeyFieldNames = 'DOC_NUMBER;DOC_DATE'
          OptionsBehavior.IncSearch = True
          OptionsBehavior.ImmediateEditor = False
          OptionsData.CancelOnExit = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.GroupByBox = False
          object cxGrid1DBTableView1DOCID: TcxGridDBColumn
            DataBinding.FieldName = 'DOCID'
            MinWidth = 16
          end
          object cxGrid1DBTableView1CUSTOMERID: TcxGridDBColumn
            DataBinding.FieldName = 'CUSTOMERID'
            MinWidth = 16
          end
          object cxGrid1DBTableView1SC2: TcxGridDBColumn
            DataBinding.FieldName = 'SC2'
            MinWidth = 16
          end
          object cxGrid1DBTableView1DOC_NUMBER: TcxGridDBColumn
            DataBinding.FieldName = 'DOC_NUMBER'
            MinWidth = 16
          end
          object cxGrid1DBTableView1DOC_DATE: TcxGridDBColumn
            DataBinding.FieldName = 'DOC_DATE'
            MinWidth = 16
          end
          object cxGrid1DBTableView1P_NAME: TcxGridDBColumn
            DataBinding.FieldName = 'P_NAME'
            MinWidth = 16
            Width = 120
          end
          object cxGrid1DBTableView1P_ACCOUNT: TcxGridDBColumn
            DataBinding.FieldName = 'P_ACCOUNT'
            MinWidth = 16
            Width = 80
          end
          object cxGrid1DBTableView1P_FCODE: TcxGridDBColumn
            DataBinding.FieldName = 'P_FCODE'
            MinWidth = 16
          end
          object cxGrid1DBTableView1P_BIC: TcxGridDBColumn
            DataBinding.FieldName = 'P_BIC'
            MinWidth = 16
          end
          object cxGrid1DBTableView1P_BANKNAME: TcxGridDBColumn
            DataBinding.FieldName = 'P_BANKNAME'
            MinWidth = 16
            Width = 120
          end
          object cxGrid1DBTableView1P_CURRCODE: TcxGridDBColumn
            DataBinding.FieldName = 'P_CURRCODE'
            MinWidth = 16
          end
          object cxGrid1DBTableView1P_AMOUNT: TcxGridDBColumn
            DataBinding.FieldName = 'P_AMOUNT'
            MinWidth = 16
          end
          object cxGrid1DBTableView1R_NAME: TcxGridDBColumn
            DataBinding.FieldName = 'R_NAME'
            MinWidth = 16
            Width = 120
          end
          object cxGrid1DBTableView1R_ACCOUNT: TcxGridDBColumn
            DataBinding.FieldName = 'R_ACCOUNT'
            MinWidth = 16
            Width = 80
          end
          object cxGrid1DBTableView1R_FCODE: TcxGridDBColumn
            DataBinding.FieldName = 'R_FCODE'
            MinWidth = 16
          end
          object cxGrid1DBTableView1R_BIC: TcxGridDBColumn
            DataBinding.FieldName = 'R_BIC'
            MinWidth = 16
          end
          object cxGrid1DBTableView1R_BANKNAME: TcxGridDBColumn
            DataBinding.FieldName = 'R_BANKNAME'
            MinWidth = 16
            Width = 80
          end
          object cxGrid1DBTableView1R_CURRCODE: TcxGridDBColumn
            DataBinding.FieldName = 'R_CURRCODE'
            MinWidth = 16
          end
          object cxGrid1DBTableView1R_AMOUNT: TcxGridDBColumn
            DataBinding.FieldName = 'R_AMOUNT'
            MinWidth = 16
          end
          object cxGrid1DBTableView1DESCRIPTION: TcxGridDBColumn
            DataBinding.FieldName = 'DESCRIPTION'
            MinWidth = 16
            Width = 240
          end
        end
        object cxGrid1Level1: TcxGridLevel
          GridView = cxGrid1DBTableView1
        end
      end
      object dxBarDockControl2: TdxBarDockControl
        Left = 0
        Top = 0
        Width = 1131
        Height = 28
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = dalTop
        BarManager = dxBarManager1
      end
      object DBGrid2: TDBGrid
        Left = 711
        Top = 28
        Width = 420
        Height = 446
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alClient
        DataSource = DataSource1
        TabOrder = 2
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Segoe UI'
        TitleFont.Style = []
      end
    end
    object tbsECB: TcxTabSheet
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'ECB'
      ImageIndex = 1
      object cxGrid2: TcxGrid
        Left = 0
        Top = 28
        Width = 1131
        Height = 446
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alClient
        TabOrder = 1
        object cxGrid2DBTableView1: TcxGridDBTableView
          PopupMenu = dxBarPopupMenu1
          FindPanel.DisplayMode = fpdmAlways
          FindPanel.UseExtendedSyntax = True
          DataController.DataSource = IBCDataSourceECB
          OptionsBehavior.IncSearch = True
          OptionsBehavior.ImmediateEditor = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.GroupByBox = False
          object cxGrid2DBTableView1DOCID: TcxGridDBColumn
            DataBinding.FieldName = 'DOCID'
            MinWidth = 16
          end
          object cxGrid2DBTableView1REFERID: TcxGridDBColumn
            DataBinding.FieldName = 'REFERID'
            MinWidth = 16
          end
          object cxGrid2DBTableView1INTERNALNO: TcxGridDBColumn
            DataBinding.FieldName = 'INTERNALNO'
            Visible = False
            MinWidth = 16
          end
          object cxGrid2DBTableView1DATADOC: TcxGridDBColumn
            DataBinding.FieldName = 'DATADOC'
            MinWidth = 16
          end
          object cxGrid2DBTableView1SUMADT: TcxGridDBColumn
            DataBinding.FieldName = 'SUMADT'
            MinWidth = 16
          end
          object cxGrid2DBTableView1SUMACT: TcxGridDBColumn
            DataBinding.FieldName = 'SUMACT'
            MinWidth = 16
          end
          object cxGrid2DBTableView1CUSTOMERNAME: TcxGridDBColumn
            DataBinding.FieldName = 'CUSTOMERNAME'
            MinWidth = 16
            Width = 120
          end
          object cxGrid2DBTableView1CUSTOMERIBAN: TcxGridDBColumn
            DataBinding.FieldName = 'CUSTOMERIBAN'
            MinWidth = 16
          end
          object cxGrid2DBTableView1CUSTOMERIDNO: TcxGridDBColumn
            DataBinding.FieldName = 'CUSTOMERIDNO'
            MinWidth = 16
          end
          object cxGrid2DBTableView1CUSTOMERMFO: TcxGridDBColumn
            DataBinding.FieldName = 'CUSTOMERMFO'
            MinWidth = 16
          end
          object cxGrid2DBTableView1CUSTOMERBANKNAME: TcxGridDBColumn
            DataBinding.FieldName = 'CUSTOMERBANKNAME'
            MinWidth = 16
            Width = 120
          end
          object cxGrid2DBTableView1DOC_DATE: TcxGridDBColumn
            DataBinding.FieldName = 'DOC_DATE'
            MinWidth = 16
          end
          object cxGrid2DBTableView1P_NAME: TcxGridDBColumn
            DataBinding.FieldName = 'P_NAME'
            MinWidth = 16
            Width = 120
          end
          object cxGrid2DBTableView1P_ACCOUNT: TcxGridDBColumn
            DataBinding.FieldName = 'P_ACCOUNT'
            MinWidth = 16
          end
          object cxGrid2DBTableView1P_FCODE: TcxGridDBColumn
            DataBinding.FieldName = 'P_FCODE'
            MinWidth = 16
          end
          object cxGrid2DBTableView1P_BIC: TcxGridDBColumn
            DataBinding.FieldName = 'P_BIC'
            MinWidth = 16
          end
          object cxGrid2DBTableView1P_BANKNAME: TcxGridDBColumn
            DataBinding.FieldName = 'P_BANKNAME'
            MinWidth = 16
            Width = 120
          end
          object cxGrid2DBTableView1P_CURRCODE: TcxGridDBColumn
            DataBinding.FieldName = 'P_CURRCODE'
            MinWidth = 16
          end
          object cxGrid2DBTableView1P_AMOUNT: TcxGridDBColumn
            DataBinding.FieldName = 'P_AMOUNT'
            MinWidth = 16
          end
          object cxGrid2DBTableView1R_NAME: TcxGridDBColumn
            DataBinding.FieldName = 'R_NAME'
            MinWidth = 16
            Width = 120
          end
          object cxGrid2DBTableView1R_ACCOUNT: TcxGridDBColumn
            DataBinding.FieldName = 'R_ACCOUNT'
            MinWidth = 16
          end
          object cxGrid2DBTableView1R_FCODE: TcxGridDBColumn
            DataBinding.FieldName = 'R_FCODE'
            MinWidth = 16
          end
          object cxGrid2DBTableView1R_BIC: TcxGridDBColumn
            DataBinding.FieldName = 'R_BIC'
            MinWidth = 16
          end
          object cxGrid2DBTableView1R_BANKNAME: TcxGridDBColumn
            DataBinding.FieldName = 'R_BANKNAME'
            MinWidth = 16
            Width = 120
          end
          object cxGrid2DBTableView1R_CURRCODE: TcxGridDBColumn
            DataBinding.FieldName = 'R_CURRCODE'
            MinWidth = 16
          end
          object cxGrid2DBTableView1R_AMOUNT: TcxGridDBColumn
            DataBinding.FieldName = 'R_AMOUNT'
            MinWidth = 16
          end
          object cxGrid2DBTableView1DESCRIPTION: TcxGridDBColumn
            DataBinding.FieldName = 'DESCRIPTION'
            MinWidth = 16
            Width = 200
          end
          object cxGrid2DBTableView1CUSTOMERID: TcxGridDBColumn
            DataBinding.FieldName = 'CUSTOMERID'
            MinWidth = 16
          end
          object cxGrid2DBTableView1SC2: TcxGridDBColumn
            DataBinding.FieldName = 'SC2'
            MinWidth = 16
          end
        end
        object cxGrid2Level1: TcxGridLevel
          GridView = cxGrid2DBTableView1
        end
      end
      object dxBarDockControl1: TdxBarDockControl
        Left = 0
        Top = 0
        Width = 1131
        Height = 28
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = dalTop
        BarManager = dxBarManager1
      end
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 504
    Width = 1139
    Height = 185
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alBottom
    DataSource = DataSource1
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
  end
  object ADOConnectionMAIB: TADOConnection
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=c:\temp;Mode=Read;P' +
      'ersist Security Info=False;'
    LoginPrompt = False
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 512
    Top = 104
  end
  object ADODataSet1: TADODataSet
    Connection = ADOConnectionMAIB
    Parameters = <>
    Left = 512
    Top = 208
  end
  object DataSource1: TDataSource
    DataSet = ADODataSet1
    Left = 512
    Top = 152
  end
  object IBCQueryPaymentsMAIB: TIBCQuery
    KeyFields = 'DOC_NUMBER'
    SQLInsert.Strings = (
      'INSERT INTO TDB_PAYMENTS_MAIB'
      
        '  (DOC_NUMBER, DOC_DATE, P_NAME, P_ACCOUNT, P_FCODE, P_BIC, P_BA' +
        'NKNAME, P_CURRCODE, P_AMOUNT, R_NAME, R_ACCOUNT, R_FCODE, R_BIC,' +
        ' R_BANKNAME, R_CURRCODE, R_AMOUNT, DESCRIPTION, DOCID, CUSTOMERI' +
        'D, SC2)'
      'VALUES'
      
        '  (:DOC_NUMBER, :DOC_DATE, :P_NAME, :P_ACCOUNT, :P_FCODE, :P_BIC' +
        ', :P_BANKNAME, :P_CURRCODE, :P_AMOUNT, :R_NAME, :R_ACCOUNT, :R_F' +
        'CODE, :R_BIC, :R_BANKNAME, :R_CURRCODE, :R_AMOUNT, :DESCRIPTION,' +
        ' :DOCID, :CUSTOMERID, :SC2)')
    SQLDelete.Strings = (
      'DELETE FROM TDB_PAYMENTS_MAIB'
      'WHERE'
      '  DOC_NUMBER = :Old_DOC_NUMBER')
    SQLUpdate.Strings = (
      'UPDATE TDB_PAYMENTS_MAIB'
      'SET'
      
        '  DOC_NUMBER = :DOC_NUMBER, DOC_DATE = :DOC_DATE, P_NAME = :P_NA' +
        'ME, P_ACCOUNT = :P_ACCOUNT, P_FCODE = :P_FCODE, P_BIC = :P_BIC, ' +
        'P_BANKNAME = :P_BANKNAME, P_CURRCODE = :P_CURRCODE, P_AMOUNT = :' +
        'P_AMOUNT, R_NAME = :R_NAME, R_ACCOUNT = :R_ACCOUNT, R_FCODE = :R' +
        '_FCODE, R_BIC = :R_BIC, R_BANKNAME = :R_BANKNAME, R_CURRCODE = :' +
        'R_CURRCODE, R_AMOUNT = :R_AMOUNT, DESCRIPTION = :DESCRIPTION, DO' +
        'CID = :DOCID, CUSTOMERID = :CUSTOMERID, SC2 = :SC2'
      'WHERE'
      '  DOC_NUMBER = :Old_DOC_NUMBER')
    SQLRefresh.Strings = (
      
        'SELECT DOC_NUMBER, DOC_DATE, P_NAME, P_ACCOUNT, P_FCODE, P_BIC, ' +
        'P_BANKNAME, P_CURRCODE, P_AMOUNT, R_NAME, R_ACCOUNT, R_FCODE, R_' +
        'BIC, R_BANKNAME, R_CURRCODE, R_AMOUNT, DESCRIPTION, DOCID, CUSTO' +
        'MERID, SC2 FROM TDB_PAYMENTS_MAIB'
      'WHERE'
      '  DOC_NUMBER = :DOC_NUMBER')
    SQLLock.Strings = (
      'SELECT NULL FROM TDB_PAYMENTS_MAIB'
      'WHERE'
      'DOC_NUMBER = :Old_DOC_NUMBER'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM TDB_PAYMENTS_MAIB'
      ''
      ') q')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = IBCTrLocalUpdate
    SQL.Strings = (
      'select * from TDB_PAYMENTS_MAIB order by doc_date desc')
    FetchRows = 100
    AutoCommit = False
    Left = 664
    Top = 208
  end
  object IBCTrLocalUpdate: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 664
    Top = 104
  end
  object IBCDataSourcePaymentsMAIB: TIBCDataSource
    DataSet = IBCQueryPaymentsMAIB
    Left = 664
    Top = 152
  end
  object IBCQueryECB: TIBCQuery
    Connection = dmDB.IBCConnection
    UpdateTransaction = IBCTrLocalUpdate
    SQL.Strings = (
      'select * from TDB_DOCS_BANKS order by datadoc desc')
    Left = 432
    Top = 416
  end
  object IBCDataSourceECB: TIBCDataSource
    DataSet = IBCQueryECB
    Left = 436
    Top = 354
  end
  object dxBarPopupMenu1: TdxBarPopupMenu
    BarManager = dxBarManager1
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbCreateBankIncomeDocument'
      end>
    UseOwnFont = False
    Left = 349
    Top = 228
    PixelsPerInch = 96
  end
  object dxBarManager1: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'ECB'
      'MAIB')
    Categories.ItemsVisibles = (
      2
      2)
    Categories.Visibles = (
      True
      True)
    ImageOptions.Images = dmAdditions.cxImageList_SWN
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 575
    Top = 379
    PixelsPerInch = 96
    object dxBarManager1Bar1: TdxBar
      Caption = 'ECB'
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 860
      FloatTop = 0
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbOpenECB'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbImportECB'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar2: TdxBar
      Caption = 'MAIB'
      CaptionButtons = <>
      DockControl = dxBarDockControl2
      DockedDockControl = dxBarDockControl2
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 860
      FloatTop = 0
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbOpenMAIB'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbImportMaib'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object bbCreateBankIncomeDocument: TdxBarButton
      Caption = 'Creaza document de incasare bancara'
      Category = 0
      Hint = 'Creaza document de incasare bancara'
      Visible = ivAlways
      OnClick = bbCreateBankIncomeDocumentClick
    end
    object bbImportECB: TdxBarButton
      Caption = 'Import'
      Category = 0
      Hint = 'Import'
      Visible = ivAlways
      ImageIndex = 145
      OnClick = bbImportECBClick
    end
    object bbOpenECB: TdxBarButton
      Caption = 'Open ECB'
      Category = 0
      Hint = 'Open ECB'
      Visible = ivAlways
      ImageIndex = 79
      OnClick = bbOpenECBClick
    end
    object bbOpenMAIB: TdxBarButton
      Caption = 'Open'
      Category = 1
      Hint = 'Open'
      Visible = ivAlways
      ImageIndex = 79
    end
    object bbImportMaib: TdxBarButton
      Caption = 'Import'
      Category = 1
      Hint = 'Import'
      Visible = ivAlways
      ImageIndex = 145
      OnClick = bbImportMaibClick
    end
  end
end
