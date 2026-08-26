inherited frame96DistribuireRamburs: Tframe96DistribuireRamburs
  Width = 1159
  Height = 769
  Font.Height = -15
  ExplicitWidth = 1159
  ExplicitHeight = 769
  PixelsPerInch = 120
  object cxSplitter1: TcxSplitter
    Left = 0
    Top = 337
    Width = 1159
    Height = 8
    AlignSplitter = salTop
  end
  object Panel1: TPanel
    Left = 800
    Top = 345
    Width = 359
    Height = 424
    Align = alRight
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 6
    object cxSplitter2: TcxSplitter
      Left = -3
      Top = 0
      Width = 9
      Height = 424
      AlignSplitter = salRight
    end
    object Panel2: TPanel
      Left = 6
      Top = 0
      Width = 353
      Height = 424
      Align = alRight
      BevelKind = bkFlat
      BevelOuter = bvNone
      Color = clWindow
      ParentBackground = False
      TabOrder = 1
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 345
    Width = 800
    Height = 424
    Align = alClient
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 2
    object cxGridRamburs: TcxGrid
      Left = 0
      Top = 0
      Width = 796
      Height = 420
      Align = alClient
      BorderStyle = cxcbsNone
      TabOrder = 0
      object cxGridRambursDBTableView: TcxGridDBTableView
        OnKeyDown = cxGridRambursDBTableViewKeyDown
        OnFocusedRecordChanged = cxGridRambursDBTableViewFocusedRecordChanged
        DataController.DataSource = IBCDataSourceDistributieRamburs
        DataController.KeyFieldNames = 'DOCID;CUSTOMERID;AWB'
        DataController.Summary.FooterSummaryItems = <
          item
            Format = '0.00'
            Kind = skSum
            FieldName = 'RAMBURS'
            Column = cxGridRambursDBTableViewRAMBURS
          end
          item
            Format = '0.00'
            Kind = skSum
            FieldName = 'PRET_LIVRARE'
            Column = cxGridRambursDBTableViewPRET_LIVRARE
          end>
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
        OptionsView.Footer = True
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        Preview.LeftIndent = 25
        Preview.RightIndent = 6
        RowLayout.MinValueWidth = 100
        object cxGridRambursDBTableViewCUSTOMERID: TcxGridDBColumn
          Caption = 'Cod'
          DataBinding.FieldName = 'CUSTOMERID'
          HeaderAlignmentHorz = taCenter
        end
        object cxGridRambursDBTableViewCUSTOMER_NAME: TcxGridDBColumn
          Caption = 'Nume client'
          DataBinding.FieldName = 'CUSTOMER_NAME'
          HeaderAlignmentHorz = taCenter
          Width = 160
        end
        object cxGridRambursDBTableViewAWB: TcxGridDBColumn
          DataBinding.FieldName = 'AWB'
          HeaderAlignmentHorz = taCenter
          Width = 150
        end
        object cxGridRambursDBTableViewRAMBURS: TcxGridDBColumn
          Caption = 'Ramburs'
          DataBinding.FieldName = 'RAMBURS'
          HeaderAlignmentHorz = taCenter
          Width = 64
        end
        object cxGridRambursDBTableViewPRET_LIVRARE: TcxGridDBColumn
          Caption = 'Pret livrare'
          DataBinding.FieldName = 'PRET_LIVRARE'
          HeaderAlignmentHorz = taCenter
          Width = 64
        end
        object cxGridRambursDBTableViewCOMISION: TcxGridDBColumn
          Caption = 'Comision'
          DataBinding.FieldName = 'COMISION'
          HeaderAlignmentHorz = taCenter
          Width = 64
        end
        object cxGridRambursDBTableViewCONTRACTID: TcxGridDBColumn
          Caption = 'Nr contract'
          DataBinding.FieldName = 'CONTRACTID'
        end
      end
      object cxGridRambursLevel1: TcxGridLevel
        GridView = cxGridRambursDBTableView
      end
    end
  end
  object cxGridBankPDNS: TcxGrid
    Left = 0
    Top = 0
    Width = 1159
    Height = 305
    Align = alTop
    TabOrder = 0
    LookAndFeel.NativeStyle = True
    LookAndFeel.SkinName = ''
    object cxGridBankPDNSTable: TcxGridDBTableView
      PopupMenu = dxBarPopupMenu1
      OnKeyDown = cxGridBankPDNSTableKeyDown
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
      OnFocusedRecordChanged = cxGridBankPDNSTableFocusedRecordChanged
      DataController.DataSource = dmDB.IBCDataSourceDocs
      DataController.KeyFieldNames = 'DOCID'
      DataController.Summary.FooterSummaryItems = <
        item
          Kind = skSum
          Column = cxGridBankPDNSTableSuma
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
      OptionsView.ScrollBars = ssVertical
      OptionsView.ColumnAutoWidth = True
      OptionsView.FixedColumnSeparatorWidth = 3
      OptionsView.Footer = True
      OptionsView.GridLineColor = 13750737
      OptionsView.GroupRowStyle = grsOffice11
      Preview.LeftIndent = 25
      Preview.RightIndent = 6
      RowLayout.MinValueWidth = 100
      Styles.OnGetContentStyle = cxGridBankPDNSTableStylesGetContentStyle
      object cxGridBankPDNS_FLG_CLOSED: TcxGridDBColumn
        Caption = 'Inchis'
        DataBinding.FieldName = 'FLG_CLOSED'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        HeaderAlignmentHorz = taCenter
        MinWidth = 50
        Options.IncSearch = False
        Options.Grouping = False
        Options.HorzSizing = False
        Options.Sorting = False
        Width = 50
      end
      object cxGridBankPDNSTableDocID: TcxGridDBColumn
        Caption = 'Cod'
        DataBinding.FieldName = 'DOCID'
        HeaderAlignmentHorz = taCenter
        MinWidth = 60
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 60
      end
      object cxGridBankPDNS_DATA: TcxGridDBColumn
        Caption = 'Data'
        DataBinding.FieldName = 'DATA'
        HeaderAlignmentHorz = taCenter
        MinWidth = 100
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 100
      end
      object cxGridBankPDNSTableCtName: TcxGridDBColumn
        Caption = 'Incasat de la'
        DataBinding.FieldName = 'CT_NAME'
        MinWidth = 50
        Options.Grouping = False
        Styles.Content = dmAdditions.cxStyle_Bold
        Width = 200
      end
      object cxGridBankPDNSTableSuma: TcxGridDBColumn
        Caption = 'Suma'
        DataBinding.FieldName = 'SUMA'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 70
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 70
      end
      object cxGridBankPDNSTableCurrencyName: TcxGridDBColumn
        Caption = 'Valuta'
        DataBinding.FieldName = 'CURRENCY_NAME'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        MinWidth = 70
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 70
      end
      object cxGridBankPDNSTableVAT: TcxGridDBColumn
        Caption = 'TVA'
        DataBinding.FieldName = 'VAT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 70
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 70
      end
      object cxGridBankPDNSTableRate: TcxGridDBColumn
        Caption = 'Rata'
        DataBinding.FieldName = 'RATE'
        HeaderAlignmentHorz = taCenter
        MinWidth = 70
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 70
      end
      object cxGridBankPDNS_RATEUSD: TcxGridDBColumn
        Caption = 'Rata USD'
        DataBinding.FieldName = 'RATEUSD'
        HeaderAlignmentHorz = taCenter
        MinWidth = 70
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 70
      end
      object cxGridBankPDNSTableParentDocID: TcxGridDBColumn
        Caption = 'cod parinte'
        DataBinding.FieldName = 'PARENTDOCID'
        HeaderAlignmentHorz = taCenter
        MinWidth = 70
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 70
      end
      object cxGridBankPDNSTableFlgACNT: TcxGridDBColumn
        Caption = 'Contab'
        DataBinding.FieldName = 'FLG_ACNT'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        HeaderAlignmentHorz = taCenter
        MinWidth = 40
        Options.Grouping = False
        Options.HorzSizing = False
        Width = 40
      end
      object cxGridBankPDNSTableCreatedBy: TcxGridDBColumn
        Caption = 'Utilizator'
        DataBinding.FieldName = 'CREATED_BY_NAME'
        Options.Grouping = False
        Width = 100
      end
      object cxGridBankPDNS_CT: TcxGridDBColumn
        DataBinding.FieldName = 'CT'
        Visible = False
        VisibleForCustomization = False
      end
      object cxGridBankPDNS_DTSC_NAME: TcxGridDBColumn
        Caption = 'Analitica 1'
        DataBinding.FieldName = 'DTSC_NAME'
        MinWidth = 40
        Width = 70
      end
      object cxGridBankPDNS_SC2_NAME: TcxGridDBColumn
        Caption = 'Analitica 2'
        DataBinding.FieldName = 'SC2_NAME'
      end
    end
    object cxGridBankPDNSLevel1: TcxGridLevel
      GridView = cxGridBankPDNSTable
    end
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
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 688
    Top = 192
    PixelsPerInch = 120
    DockControlHeights = (
      0
      0
      32
      0)
    object dxBarManager1Bar1: TdxBar
      Caption = 'Custom 1'
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 0
      DockedTop = 0
      DockingStyle = dsTop
      FloatLeft = 1385
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
          ItemName = 'bbEdit'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbDelete'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbImport'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbImportSS'
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
    object bbEdit: TdxBarButton
      Caption = 'Modifica'
      Category = 0
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 115
      OnClick = bbEditClick
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
    object bbCloseDocument: TdxBarButton
      Caption = 'Inchide documentul...'
      Category = 0
      Hint = 'Inchide documentul'
      Visible = ivAlways
      ShortCut = 120
      OnClick = bbCloseDocumentClick
    end
    object bbOpenDocument: TdxBarButton
      Caption = 'Deschide documentul...'
      Category = 0
      Hint = 'Deschide documentul'
      Visible = ivAlways
      OnClick = bbOpenDocumentClick
    end
    object bbImport: TdxBarButton
      Caption = 'Importa cu AWB'
      Category = 0
      Hint = 'Importa cu AWB'
      Visible = ivAlways
      ShortCut = 16457
      OnClick = bbImportClick
    end
    object bbImportSS: TdxBarButton
      Caption = 'Importa'
      Category = 0
      Hint = 'Importa'
      Visible = ivAlways
      OnClick = bbImportSSClick
    end
  end
  object IBCQueryDistributieRamburs: TIBCQuery
    KeyFields = 'DOCID;CUSTOMERID;AWB'
    SQLInsert.Strings = (
      'INSERT INTO VW_TDB_DISTRIBUTIE_RAMBURS'
      
        '  (DOCID, CUSTOMERID, CUSTOMER_NAME, AWB, RAMBURS, PRET_LIVRARE,' +
        ' COMISION, CONTRACTID, FLG_ACNT, REFERER_DOCID)'
      'VALUES'
      
        '  (:DOCID, :CUSTOMERID, :CUSTOMER_NAME, :AWB, :RAMBURS, :PRET_LI' +
        'VRARE, :COMISION, :CONTRACTID, :FLG_ACNT, :REFERER_DOCID)')
    SQLDelete.Strings = (
      'DELETE FROM VW_TDB_DISTRIBUTIE_RAMBURS'
      'WHERE'
      
        '  DOCID = :Old_DOCID AND CUSTOMERID = :Old_CUSTOMERID AND AWB = ' +
        ':Old_AWB')
    SQLUpdate.Strings = (
      'UPDATE VW_TDB_DISTRIBUTIE_RAMBURS'
      'SET'
      
        '  DOCID = :DOCID, CUSTOMERID = :CUSTOMERID, CUSTOMER_NAME = :CUS' +
        'TOMER_NAME, AWB = :AWB, RAMBURS = :RAMBURS, '
      
        '  PRET_LIVRARE = :PRET_LIVRARE, COMISION = :COMISION, CONTRACTID' +
        ' = :CONTRACTID, FLG_ACNT = :FLG_ACNT,'
      '  REFERER_DOCID = :REFERER_DOCID'
      'WHERE'
      
        '  DOCID = :Old_DOCID AND CUSTOMERID = :Old_CUSTOMERID AND AWB = ' +
        ':Old_AWB')
    SQLRefresh.Strings = (
      
        'SELECT DOCID, CUSTOMERID, CUSTOMER_NAME, AWB, RAMBURS, PRET_LIVR' +
        'ARE, COMISION, CONTRACTID, FLG_ACNT, REFERER_DOCID FROM VW_TDB_D' +
        'ISTRIBUTIE_RAMBURS'
      'WHERE'
      
        '  DOCID = :DOCID AND CUSTOMERID = :CUSTOMERID AND AWB = :AWB and' +
        ' REFERER_DOCID = :REFERER_DOCID')
    SQLLock.Strings = (
      'SELECT NULL FROM TDB_DISTRIBUTIE_RAMBURS'
      'WHERE'
      
        'DOCID = :Old_DOCID AND CUSTOMERID = :Old_CUSTOMERID AND AWB = :O' +
        'ld_AWB'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM VW_TDB_DISTRIBUTIE_RAMBURS'
      ''
      ') q')
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'select * from vw_tdb_distributie_ramburs')
    MasterFields = 'DOCID'
    DetailFields = 'DOCID'
    MasterSource = dmDB.IBCDataSourceDocs
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Left = 464
    Top = 552
    ParamData = <
      item
        DataType = ftInteger
        Name = 'DOCID'
        ParamType = ptInput
        Value = 1250212
      end>
  end
  object IBCDataSourceDistributieRamburs: TIBCDataSource
    DataSet = IBCQueryDistributieRamburs
    Left = 464
    Top = 496
  end
  object dxBarPopupMenu1: TdxBarPopupMenu
    BarManager = dxBarManager1
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbCloseDocument'
      end
      item
        Visible = True
        ItemName = 'bbOpenDocument'
      end>
    UseOwnFont = False
    Left = 688
    Top = 96
    PixelsPerInch = 120
  end
end
