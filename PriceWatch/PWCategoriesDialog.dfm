object frmPWCategoriesDlg: TfrmPWCategoriesDlg
  Left = 0
  Top = 0
  Caption = 'Categoriile monitorizate'
  ClientHeight = 640
  ClientWidth = 1100
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 1100
    Height = 64
    Align = alTop
    Title = 'Categoriile monitorizate'
    Text = ''
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
  end
  object pnCats: TPanel
    Left = 0
    Top = 64
    Width = 1100
    Height = 260
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object lbCats: TLabel
      Left = 0
      Top = 0
      Width = 1100
      Height = 22
      Align = alTop
      Caption = '  Categoriile noastre (TWEB_CATALOG)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
    end
    object cxGridCats: TcxGrid
      Left = 0
      Top = 22
      Width = 1100
      Height = 194
      Align = alClient
      TabOrder = 0
      object cxGridCatsTable: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = IBCDataSourceCats
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.Deleting = False
        OptionsData.Inserting = False
        OptionsView.ColumnAutoWidth = True
        OptionsView.GroupByBox = False
        object colC_CATALOGID: TcxGridDBColumn
          Caption = 'CATALOGID'
          DataBinding.FieldName = 'CATALOGID'
          Width = 90
        end
        object colC_CATALOG_TITLE: TcxGridDBColumn
          Caption = 'Categoria pe site-ul nostru'
          DataBinding.FieldName = 'CATALOG_TITLE'
          Options.Editing = False
          Width = 220
        end
        object colC_TITLE: TcxGridDBColumn
          Caption = 'Denumire in rapoarte'
          DataBinding.FieldName = 'TITLE'
          Width = 220
        end
        object colC_FLG_ACTIVE: TcxGridDBColumn
          Caption = 'Activ'
          DataBinding.FieldName = 'FLG_ACTIVE'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = 1
          Properties.ValueGrayed = 0
          Properties.ValueUnchecked = 0
          Width = 50
        end
        object colC_ORDERNO: TcxGridDBColumn
          Caption = 'Ordine'
          DataBinding.FieldName = 'ORDERNO'
          Width = 60
        end
        object colC_MIN_SCORE: TcxGridDBColumn
          Caption = 'Scor minim (gol = global)'
          DataBinding.FieldName = 'MIN_SCORE'
          Width = 130
        end
        object colC_URLS: TcxGridDBColumn
          Caption = 'URL-uri'
          DataBinding.FieldName = 'URL_COUNT'
          Options.Editing = False
          Width = 60
        end
      end
      object cxGridCatsLevel: TcxGridLevel
        GridView = cxGridCatsTable
      end
    end
    object pnCatsButtons: TPanel
      Left = 0
      Top = 216
      Width = 1100
      Height = 44
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      object btnCatAdd: TcxButton
        Left = 8
        Top = 7
        Width = 130
        Height = 31
        Caption = 'Adauga categorie'
        TabOrder = 0
        OnClick = btnCatAddClick
      end
      object btnCatDelete: TcxButton
        Left = 144
        Top = 7
        Width = 130
        Height = 31
        Caption = 'Sterge categoria'
        TabOrder = 1
        OnClick = btnCatDeleteClick
      end
    end
  end
  object splMain: TSplitter
    Left = 0
    Top = 324
    Width = 1100
    Height = 5
    Cursor = crVSplit
    Align = alTop
  end
  object pnUrls: TPanel
    Left = 0
    Top = 329
    Width = 1100
    Height = 267
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object lbUrls: TLabel
      Left = 0
      Top = 0
      Width = 1100
      Height = 22
      Align = alTop
      Caption = '  Adresa categoriei pe site-urile concurentilor'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
    end
    object cxGridUrls: TcxGrid
      Left = 0
      Top = 22
      Width = 1100
      Height = 201
      Align = alClient
      TabOrder = 0
      object cxGridUrlsTable: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = IBCDataSourceUrls
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.Deleting = False
        OptionsData.Inserting = False
        OptionsView.ColumnAutoWidth = True
        OptionsView.GroupByBox = False
        object colU_SITEID: TcxGridDBColumn
          Caption = 'Site'
          DataBinding.FieldName = 'SITEID'
          PropertiesClassName = 'TcxLookupComboBoxProperties'
          Properties.DropDownListStyle = lsFixedList
          Properties.KeyFieldNames = 'SITEID'
          Properties.ListColumns = <
            item
              FieldName = 'SITE_CODE'
            end>
          Properties.ListSource = IBCDataSourceSites
          Width = 140
        end
        object colU_URL: TcxGridDBColumn
          Caption = 'URL-ul categoriei pe site'
          DataBinding.FieldName = 'URL'
          Width = 520
        end
        object colU_FLG_ACTIVE: TcxGridDBColumn
          Caption = 'Activ'
          DataBinding.FieldName = 'FLG_ACTIVE'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = 1
          Properties.ValueGrayed = 0
          Properties.ValueUnchecked = 0
          Width = 50
        end
        object colU_LAST_SCAN: TcxGridDBColumn
          Caption = 'Ultima scanare'
          DataBinding.FieldName = 'LAST_SCAN'
          Options.Editing = False
          Width = 110
        end
        object colU_LAST_ITEMS: TcxGridDBColumn
          Caption = 'Produse'
          DataBinding.FieldName = 'LAST_ITEMS'
          Options.Editing = False
          Width = 60
        end
        object colU_LAST_ERROR: TcxGridDBColumn
          Caption = 'Ultima eroare'
          DataBinding.FieldName = 'LAST_ERROR'
          Options.Editing = False
          Width = 200
        end
      end
      object cxGridUrlsLevel: TcxGridLevel
        GridView = cxGridUrlsTable
      end
    end
    object pnUrlsButtons: TPanel
      Left = 0
      Top = 223
      Width = 1100
      Height = 44
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      object btnUrlAdd: TcxButton
        Left = 8
        Top = 7
        Width = 130
        Height = 31
        Caption = 'Adauga URL'
        TabOrder = 0
        OnClick = btnUrlAddClick
      end
      object btnUrlDelete: TcxButton
        Left = 144
        Top = 7
        Width = 130
        Height = 31
        Caption = 'Sterge URL'
        TabOrder = 1
        OnClick = btnUrlDeleteClick
      end
    end
  end
  object pnBottom: TPanel
    Left = 0
    Top = 596
    Width = 1100
    Height = 44
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object btnOk: TcxButton
      Left = 866
      Top = 7
      Width = 110
      Height = 31
      Anchors = [akTop, akRight]
      Caption = 'Salveaza'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
    object btnCancel: TcxButton
      Left = 982
      Top = 7
      Width = 110
      Height = 31
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Renunta'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object IBCQueryCats: TIBCQuery
    KeyFields = 'CATID'
    SQLInsert.Strings = (
      'INSERT INTO TWEB_COMPETITOR_CATEGORIES'
      '  (CATID, CATALOGID, TITLE, FLG_ACTIVE, ORDERNO, MIN_SCORE)'
      'VALUES'
      '  (:CATID, :CATALOGID, :TITLE, :FLG_ACTIVE, :ORDERNO, :MIN_SCORE)')
    SQLDelete.Strings = (
      'DELETE FROM TWEB_COMPETITOR_CATEGORIES'
      'WHERE'
      '  CATID = :Old_CATID')
    SQLUpdate.Strings = (
      'UPDATE TWEB_COMPETITOR_CATEGORIES'
      'SET'
      '  CATALOGID = :CATALOGID, TITLE = :TITLE, FLG_ACTIVE = :FLG_ACTIVE,'
      '  ORDERNO = :ORDERNO, MIN_SCORE = :MIN_SCORE'
      'WHERE'
      '  CATID = :Old_CATID')
    SQLRefresh.Strings = (
      'SELECT c.*,'
      '  (SELECT w.TITLE FROM TWEB_CATALOG w WHERE w.CATALOGID = c.CATALOGID) AS CATALOG_TITLE,'
      '  (SELECT COUNT(*) FROM TWEB_COMPETITOR_CAT_URLS u WHERE u.CATID = c.CATID) AS URL_COUNT'
      'FROM TWEB_COMPETITOR_CATEGORIES c'
      'WHERE c.CATID = :CATID')
    BeforePost = IBCQueryCatsBeforePost
    OnNewRecord = IBCQueryCatsNewRecord
    SQL.Strings = (
      'SELECT c.*,'
      '  (SELECT w.TITLE FROM TWEB_CATALOG w WHERE w.CATALOGID = c.CATALOGID) AS CATALOG_TITLE,'
      '  (SELECT COUNT(*) FROM TWEB_COMPETITOR_CAT_URLS u WHERE u.CATID = c.CATID) AS URL_COUNT'
      'FROM TWEB_COMPETITOR_CATEGORIES c'
      'ORDER BY c.ORDERNO, c.CATID')
    AutoCommit = False
    Left = 56
    Top = 400
  end
  object IBCDataSourceCats: TIBCDataSource
    DataSet = IBCQueryCats
    Left = 144
    Top = 400
  end
  object IBCQueryUrls: TIBCQuery
    KeyFields = 'CATURLID'
    SQLInsert.Strings = (
      'INSERT INTO TWEB_COMPETITOR_CAT_URLS'
      '  (CATURLID, SITEID, CATID, URL, FLG_ACTIVE)'
      'VALUES'
      '  (:CATURLID, :SITEID, :CATID, :URL, :FLG_ACTIVE)')
    SQLDelete.Strings = (
      'DELETE FROM TWEB_COMPETITOR_CAT_URLS'
      'WHERE'
      '  CATURLID = :Old_CATURLID')
    SQLUpdate.Strings = (
      'UPDATE TWEB_COMPETITOR_CAT_URLS'
      'SET'
      '  SITEID = :SITEID, URL = :URL, FLG_ACTIVE = :FLG_ACTIVE'
      'WHERE'
      '  CATURLID = :Old_CATURLID')
    SQLRefresh.Strings = (
      'SELECT * FROM TWEB_COMPETITOR_CAT_URLS'
      'WHERE CATURLID = :CATURLID')
    MasterSource = IBCDataSourceCats
    BeforePost = IBCQueryUrlsBeforePost
    OnNewRecord = IBCQueryUrlsNewRecord
    SQL.Strings = (
      'SELECT * FROM TWEB_COMPETITOR_CAT_URLS'
      'WHERE CATID = :CATID'
      'ORDER BY SITEID, CATURLID')
    AutoCommit = False
    Left = 56
    Top = 456
    ParamData = <
      item
        DataType = ftInteger
        Name = 'CATID'
        ParamType = ptInput
      end>
  end
  object IBCDataSourceUrls: TIBCDataSource
    DataSet = IBCQueryUrls
    Left = 144
    Top = 456
  end
  object IBCQuerySites: TIBCQuery
    SQL.Strings = (
      'SELECT SITEID, SITE_CODE FROM TWEB_COMPETITOR_SITES ORDER BY SITE_CODE')
    AutoCommit = False
    Left = 56
    Top = 512
  end
  object IBCDataSourceSites: TIBCDataSource
    DataSet = IBCQuerySites
    Left = 144
    Top = 512
  end
  object IBCTransactionUpdate: TIBCTransaction
    Left = 240
    Top = 400
  end
end
