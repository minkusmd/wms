object frmBankInOut: TfrmBankInOut
  Left = 0
  Top = 0
  ActiveControl = cxTreeList1
  Caption = 'Operatii bancare'
  ClientHeight = 598
  ClientWidth = 1354
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 15
  object DialogTitle1: TDialogTitle
    Left = 0
    Top = 0
    Width = 1354
    Height = 64
    Title = 'Banca pe zi'
    Text = 'Gestiunea operatiilor bancare'
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
    ImageIndex = 38
  end
  object Panel1: TPanel
    Left = 0
    Top = 557
    Width = 1354
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 8
    DesignSize = (
      1354
      41)
    object cxButton1: TcxButton
      Left = 635
      Top = 9
      Width = 90
      Height = 29
      Anchors = [akRight, akBottom]
      Caption = 'Inchide'
      ModalResult = 1
      TabOrder = 0
    end
  end
  object Panel2: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 93
    Width = 238
    Height = 461
    Align = alLeft
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    object cxTreeList1: TcxTreeList
      AlignWithMargins = True
      Left = 3
      Top = 165
      Width = 228
      Height = 289
      BorderStyle = cxcbsNone
      Align = alClient
      Bands = <
        item
        end>
      Navigator.Buttons.CustomButtons = <>
      OptionsBehavior.ChangeDelay = 1000
      OptionsData.CancelOnExit = False
      OptionsData.Editing = False
      OptionsData.Deleting = False
      OptionsSelection.HideFocusRect = False
      OptionsSelection.InvertSelect = False
      OptionsView.ColumnAutoWidth = True
      ScrollbarAnnotations.CustomAnnotations = <>
      TabOrder = 1
      OnCollapsing = cxTreeList1Collapsing
      OnFocusedNodeChanged = cxTreeList1FocusedNodeChanged
      object cxTreeList1Column1: TcxTreeListColumn
        Caption.Text = 'Denumire'
        Width = 159
        Position.ColIndex = 0
        Position.RowIndex = 0
        Position.BandIndex = 0
        SortOrder = soAscending
        SortIndex = 0
        Summary.FooterSummaryItems = <>
        Summary.GroupFooterSummaryItems = <>
      end
    end
    object cxDateNavigator1: TcxDateNavigator
      Left = 0
      Top = 0
      Width = 234
      Height = 162
      Align = alTop
      BorderStyle = cxcbsNone
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      LookAndFeel.NativeStyle = True
      LookAndFeel.ScrollbarMode = sbmDefault
      SelectPeriod = False
      ShowDatesContainingEventsInBold = False
      TabOrder = 0
      OnClick = cxDateNavigator1Click
    end
  end
  object cxSplitter1: TcxSplitter
    Left = 1351
    Top = 90
    Width = 3
    Height = 467
    AlignSplitter = salRight
  end
  object Panel3: TPanel
    AlignWithMargins = True
    Left = 247
    Top = 93
    Width = 1101
    Height = 461
    Align = alClient
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 2
    ExplicitTop = 117
    ExplicitHeight = 437
    object cxGrid1: TcxGrid
      Left = 0
      Top = 28
      Width = 1097
      Height = 429
      Align = alClient
      BevelInner = bvNone
      BorderStyle = cxcbsNone
      TabOrder = 1
      object cxGrid1DBTableView1: TcxGridDBTableView
        PopupMenu = dxBarPopupMenu1
        OnDblClick = cxGrid1DBTableView1DblClick
        OnKeyDown = cxGrid1DBTableView1KeyDown
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        DataController.DataSource = IBCDataSourceDocs
        DataController.Summary.DefaultGroupSummaryItems = <
          item
            Kind = skSum
            Column = cxGrid1DBTableView1_IBAN
          end>
        DataController.Summary.FooterSummaryItems = <
          item
            Format = '# ##0.00'
            Kind = skSum
            Column = cxGrid1DBTableView1Column5
          end
          item
            Kind = skCount
            Column = cxGrid1DBTableView1_IBAN
          end>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.IncSearch = True
        OptionsBehavior.ImmediateEditor = False
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.ColumnAutoWidth = True
        OptionsView.Footer = True
        object cxGrid1DBTableView1_FLG_CLOSED: TcxGridDBColumn
          Caption = '...'
          DataBinding.FieldName = 'FLG_CLOSED'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = '1'
          Properties.ValueUnchecked = '0'
          Options.Focusing = False
          Options.HorzSizing = False
          Width = 20
        end
        object cxGrid1DBTableView1Column1: TcxGridDBColumn
          Caption = 'docid'
          DataBinding.FieldName = 'DOCID'
          Width = 56
        end
        object cxGrid1DBTableView1Column2: TcxGridDBColumn
          Caption = 'data'
          DataBinding.FieldName = 'DATA'
          Width = 93
        end
        object cxGrid1DBTableView1_DOCTYPE_NAME: TcxGridDBColumn
          Caption = 'tip document'
          DataBinding.FieldName = 'DOCTYPE_NAME'
          Width = 161
        end
        object cxGrid1DBTableView1_IBAN: TcxGridDBColumn
          Caption = 'iban'
          DataBinding.FieldName = 'DT_cd'
          Width = 141
        end
        object cxGrid1DBTableView1Column3: TcxGridDBColumn
          Caption = 'contract'
          DataBinding.FieldName = 'CONTRACT_CODE'
          Width = 152
        end
        object cxGrid1DBTableView1Column4: TcxGridDBColumn
          Caption = 'client'
          DataBinding.FieldName = 'CT_NAME'
          Width = 142
        end
        object cxGrid1DBTableView1Column5: TcxGridDBColumn
          Caption = 'suma'
          DataBinding.FieldName = 'SUMA'
          PropertiesClassName = 'TcxCalcEditProperties'
          Properties.DisplayFormat = '# ##0.00'
          Styles.Content = dmAdditions.cxStyle_Bold
          Width = 104
        end
        object cxGrid1DBTableView1Column6: TcxGridDBColumn
          Caption = 'valuta'
          DataBinding.FieldName = 'CURRENCY_NAME'
          Width = 44
        end
        object cxGrid1DBTableView1Column7: TcxGridDBColumn
          Caption = 'analitica 1'
          DataBinding.FieldName = 'DTSC_NAME'
          Visible = False
          Width = 103
        end
        object cxGrid1DBTableView1Column8: TcxGridDBColumn
          Caption = 'analitica 2'
          DataBinding.FieldName = 'DTDEP_NAME'
          Visible = False
          Width = 102
        end
        object cxGrid1DBTableView1Column9: TcxGridDBColumn
          Caption = 'analitica 3'
          DataBinding.FieldName = 'SC2_NAME'
          Visible = False
          VisibleForCustomization = False
          Width = 155
        end
        object cxGrid1DBTableView1Column10: TcxGridDBColumn
          Caption = 'creat de'
          DataBinding.FieldName = 'CREATED_BY_NAME'
          Visible = False
          Width = 29
        end
      end
      object cxGrid1Level1: TcxGridLevel
        GridView = cxGrid1DBTableView1
      end
    end
    object dxBarDockControl1: TdxBarDockControl
      Left = 0
      Top = 0
      Width = 1097
      Height = 28
      Align = dalTop
      BarManager = dxBarManager1
    end
  end
  object dxBarManager1: TdxBarManager
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
    PopupMenuLinks = <>
    UseSystemFont = False
    Left = 336
    Top = 16
    PixelsPerInch = 96
    DockControlHeights = (
      0
      0
      26
      0)
    object dxBarManager1Bar1: TdxBar
      Caption = 'Main Toolbar'
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 0
      DockedTop = 0
      DockingStyle = dsTop
      FloatLeft = 964
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udWidth]
          UserWidth = 255
          Visible = True
          ItemName = 'cbIBAN'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar2: TdxBar
      Caption = 'Docs operation'
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 791
      FloatTop = 360
      FloatClientWidth = 51
      FloatClientHeight = 24
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbNew'
        end
        item
          Visible = True
          ItemName = 'bbEdit'
        end
        item
          Visible = True
          ItemName = 'bbDelete'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbCloneDocument'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarSubItem1'
        end
        item
          Visible = True
          ItemName = 'dxBarButton1'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object cbIBAN: TdxBarCombo
      Caption = 'IBAN'
      Category = 0
      Hint = 'IBAN'
      Visible = ivAlways
      OnChange = cbIBANChange
      ShowCaption = True
      ShowEditor = False
      ItemIndex = -1
    end
    object bbNew: TdxBarButton
      Caption = 'Nou'
      Category = 0
      Hint = 'Nou'
      Visible = ivAlways
      ImageIndex = 0
      PaintStyle = psCaptionGlyph
      ShortCut = 45
      OnClick = bbNewClick
    end
    object bbEdit: TdxBarButton
      Caption = 'Modifica'
      Category = 0
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 1
      PaintStyle = psCaptionGlyph
      ShortCut = 115
      OnClick = bbEditClick
    end
    object bbDelete: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 2
      PaintStyle = psCaptionGlyph
      OnClick = bbDeleteClick
    end
    object bbCloseDocument: TdxBarButton
      Caption = 'Inchide documentele'
      Category = 0
      Hint = 'Inchide documentele'
      Visible = ivAlways
      ImageIndex = 121
      ShortCut = 120
      OnClick = bbCloseDocumentClick
    end
    object dxBarSubItem1: TdxBarSubItem
      Caption = 'Instrumente'
      Category = 0
      Visible = ivAlways
      ImageIndex = 126
      Images = dmAdditions.cxImageList_SWN
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbCloseDocument'
        end
        item
          Visible = True
          ItemName = 'bbOpenDocument'
        end>
    end
    object bbOpenDocument: TdxBarButton
      Caption = 'Deschide document'
      Category = 0
      Hint = 'Deschide document'
      Visible = ivAlways
      ImageIndex = 115
      OnClick = bbOpenDocumentClick
    end
    object bbCloneDocument: TdxBarButton
      Caption = 'Creaza in baza documentului curent...'
      Category = 0
      Hint = 'Creaza in baza documentului curent'
      Visible = ivAlways
      ShortCut = 16397
      OnClick = bbCloneDocumentClick
    end
    object dxBarButton1: TdxBarButton
      Caption = 'Import documente bancare ECB'
      Category = 0
      Hint = 'Import documente bancare ECB'
      Visible = ivAlways
    end
  end
  object IBCQueryIBAN: TIBCQuery
    SQL.Strings = (
      'SELECT * FROM TS_CUST_ACCOUNTS'
      'inner join sp_get_org(customerid) z on 1=1'
      'where customerid = :dt')
    Left = 600
    Top = 24
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'dt'
        Value = nil
      end>
  end
  object IBCDataSourceIBAN: TIBCDataSource
    DataSet = IBCQueryIBAN
    Left = 512
    Top = 24
  end
  object IBCQueryDocs: TIBCQuery
    KeyFields = 'DOCID'
    KeyGenerator = 'SQ_TDB_DOCS_DOCID'
    GeneratorMode = gmInsert
    SQLInsert.Strings = (
      'INSERT INTO VW_TDB_DOCS'
      
        '  (DOCID, DOCNO, DATA, DT, DT_NAME, CT, CT_NAME, DTDEP, DTDEP_NA' +
        'ME, CTDEP, CTDEP_NAME, DTSC, DTSC_NAME, CTSC, CTSC_NAME, SC2, SC' +
        '2_NAME, SUMA, VAT, CURRENCYID, CURRENCY_NAME, DISCOUNT, RATE, RA' +
        'TEUSD, FLG_SHIP, FLG_ACNT, FLG_DEL, FLG_PROTECTED, FLG_SEND, FLG' +
        '_RECEIVE, FLG_PAID, FLG_INVOICE, FLG_GOODS_ARRIVAL, FLG_READY, F' +
        'LG_CLOSED, FLG_EXPORTED, FLG_CHILD, FLG_NEW_CEC, FLG_SALARY, FLG' +
        '_UPDATE_DATE, FLG_FURNITURE, CREATED_DATE, CREATED_BY, CREATED_B' +
        'Y_NAME, DELETED_DATE, DELETED_BY, DELETED_BY_NAME, PARENTDOCID, ' +
        'ACC$MASK, DOCTYPEID, DOCTYPE_NAME, CONTRACTID, CONTRACT_CODE, CO' +
        'NTRACT_SIGN_DATE, CONTRACT_CURRENCYID, CONTRACT_TYPE_TITLE, CONT' +
        'RACT_PRICECOLUMN, FLG_WITH_DELIVERY, PHONELIST)'
      'VALUES'
      
        '  (:DOCID, :DOCNO, :DATA, :DT, :DT_NAME, :CT, :CT_NAME, :DTDEP, ' +
        ':DTDEP_NAME, :CTDEP, :CTDEP_NAME, :DTSC, :DTSC_NAME, :CTSC, :CTS' +
        'C_NAME, :SC2, :SC2_NAME, :SUMA, :VAT, :CURRENCYID, :CURRENCY_NAM' +
        'E, :DISCOUNT, :RATE, :RATEUSD, :FLG_SHIP, :FLG_ACNT, :FLG_DEL, :' +
        'FLG_PROTECTED, :FLG_SEND, :FLG_RECEIVE, :FLG_PAID, :FLG_INVOICE,' +
        ' :FLG_GOODS_ARRIVAL, :FLG_READY, :FLG_CLOSED, :FLG_EXPORTED, :FL' +
        'G_CHILD, :FLG_NEW_CEC, :FLG_SALARY, :FLG_UPDATE_DATE, :FLG_FURNI' +
        'TURE, :CREATED_DATE, :CREATED_BY, :CREATED_BY_NAME, :DELETED_DAT' +
        'E, :DELETED_BY, :DELETED_BY_NAME, :PARENTDOCID, :ACC$MASK, :DOCT' +
        'YPEID, :DOCTYPE_NAME, :CONTRACTID, :CONTRACT_CODE, :CONTRACT_SIG' +
        'N_DATE, :CONTRACT_CURRENCYID, :CONTRACT_TYPE_TITLE, :CONTRACT_PR' +
        'ICECOLUMN, :FLG_WITH_DELIVERY, :PHONELIST)')
    SQLDelete.Strings = (
      'DELETE FROM VW_TDB_DOCS'
      'WHERE'
      '  DOCID = :Old_DOCID')
    SQLUpdate.Strings = (
      'UPDATE VW_TDB_DOCS'
      'SET'
      
        '  DOCID = :DOCID, DOCNO = :DOCNO, DATA = :DATA, DT = :DT, DT_NAM' +
        'E = :DT_NAME, CT = :CT, CT_NAME = :CT_NAME, DTDEP = :DTDEP, DTDE' +
        'P_NAME = :DTDEP_NAME, CTDEP = :CTDEP, CTDEP_NAME = :CTDEP_NAME, ' +
        'DTSC = :DTSC, DTSC_NAME = :DTSC_NAME, CTSC = :CTSC, CTSC_NAME = ' +
        ':CTSC_NAME, SC2 = :SC2, SC2_NAME = :SC2_NAME, SUMA = :SUMA, VAT ' +
        '= :VAT, CURRENCYID = :CURRENCYID, CURRENCY_NAME = :CURRENCY_NAME' +
        ', DISCOUNT = :DISCOUNT, RATE = :RATE, RATEUSD = :RATEUSD, FLG_SH' +
        'IP = :FLG_SHIP, FLG_ACNT = :FLG_ACNT, FLG_DEL = :FLG_DEL, FLG_PR' +
        'OTECTED = :FLG_PROTECTED, FLG_SEND = :FLG_SEND, FLG_RECEIVE = :F' +
        'LG_RECEIVE, FLG_PAID = :FLG_PAID, FLG_INVOICE = :FLG_INVOICE, FL' +
        'G_GOODS_ARRIVAL = :FLG_GOODS_ARRIVAL, FLG_READY = :FLG_READY, FL' +
        'G_CLOSED = :FLG_CLOSED, FLG_EXPORTED = :FLG_EXPORTED, FLG_CHILD ' +
        '= :FLG_CHILD, FLG_NEW_CEC = :FLG_NEW_CEC, FLG_SALARY = :FLG_SALA' +
        'RY, FLG_UPDATE_DATE = :FLG_UPDATE_DATE, FLG_FURNITURE = :FLG_FUR' +
        'NITURE, CREATED_DATE = :CREATED_DATE, CREATED_BY = :CREATED_BY, ' +
        'CREATED_BY_NAME = :CREATED_BY_NAME, DELETED_DATE = :DELETED_DATE' +
        ', DELETED_BY = :DELETED_BY, DELETED_BY_NAME = :DELETED_BY_NAME, ' +
        'PARENTDOCID = :PARENTDOCID, ACC$MASK = :ACC$MASK, DOCTYPEID = :D' +
        'OCTYPEID, DOCTYPE_NAME = :DOCTYPE_NAME, CONTRACTID = :CONTRACTID' +
        ', CONTRACT_CODE = :CONTRACT_CODE, CONTRACT_SIGN_DATE = :CONTRACT' +
        '_SIGN_DATE, CONTRACT_CURRENCYID = :CONTRACT_CURRENCYID, CONTRACT' +
        '_TYPE_TITLE = :CONTRACT_TYPE_TITLE, CONTRACT_PRICECOLUMN = :CONT' +
        'RACT_PRICECOLUMN, FLG_WITH_DELIVERY = :FLG_WITH_DELIVERY, PHONEL' +
        'IST = :PHONELIST'
      'WHERE'
      '  DOCID = :Old_DOCID')
    SQLRefresh.Strings = (
      
        'SELECT DOCID, DOCNO, DATA, DT, DT_NAME, CT, CT_NAME, DTDEP, DTDE' +
        'P_NAME, CTDEP, CTDEP_NAME, DTSC, DTSC_NAME, CTSC, CTSC_NAME, SC2' +
        ', SC2_NAME, SUMA, VAT, CURRENCYID, CURRENCY_NAME, DISCOUNT, RATE' +
        ', RATEUSD, FLG_SHIP, FLG_ACNT, FLG_DEL, FLG_PROTECTED, FLG_SEND,' +
        ' FLG_RECEIVE, FLG_PAID, FLG_INVOICE, FLG_GOODS_ARRIVAL, FLG_READ' +
        'Y, FLG_CLOSED, FLG_EXPORTED, FLG_CHILD, FLG_NEW_CEC, FLG_SALARY,' +
        ' FLG_UPDATE_DATE, FLG_FURNITURE, CREATED_DATE, CREATED_BY, CREAT' +
        'ED_BY_NAME, DELETED_DATE, DELETED_BY, DELETED_BY_NAME, PARENTDOC' +
        'ID, ACC$MASK, DOCTYPEID, DOCTYPE_NAME, CONTRACTID, CONTRACT_CODE' +
        ', CONTRACT_SIGN_DATE, CONTRACT_CURRENCYID, CONTRACT_TYPE_TITLE, ' +
        'CONTRACT_PRICECOLUMN, FLG_WITH_DELIVERY, PHONELIST FROM VW_TDB_D' +
        'OCS'
      'WHERE'
      '  DOCID = :DOCID')
    SQLLock.Strings = (
      'SELECT NULL FROM TDB_DOCS'
      'WHERE'
      'DOCID = :Old_DOCID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM VW_TDB_DOCS'
      ''
      ') q')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = IBCTrUpdate
    SQL.Strings = (
      'select * from vw_tdb_docs d '
      'left outer join tdb_docs_rechizite dr on dr.docid = d.docid'
      
        'where d.doctypeid = :doctypeid and cast(d.data as date) = :DATA ' +
        'and DT=:DT'
      '&iban'
      'order by d.docid')
    Debug = True
    LockMode = lmLockImmediate
    Options.RequiredFields = False
    LocalConstraints = False
    IndexFieldNames = 'DATA'
    Left = 496
    Top = 264
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'doctypeid'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'DATA'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'DT'
        Value = nil
      end>
    MacroData = <
      item
        Name = 'iban'
      end>
  end
  object IBCDataSourceDocs: TIBCDataSource
    DataSet = IBCQueryDocs
    Left = 376
    Top = 264
  end
  object IBCTrUpdate: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 576
    Top = 264
  end
  object dxBarPopupMenu1: TdxBarPopupMenu
    BarManager = dxBarManager1
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbOpenDocument'
      end
      item
        Visible = True
        ItemName = 'bbCloseDocument'
      end>
    UseOwnFont = False
    Left = 672
    Top = 304
    PixelsPerInch = 96
  end
end
