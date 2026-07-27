object frmContractsDlg: TfrmContractsDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Contracte'
  ClientHeight = 484
  ClientWidth = 1132
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
    Width = 1132
    Height = 64
    Title = 'Contracte'
    Text = 'Managementul contractelor...'
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
    ImageIndex = 11
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 1116
    Height = 355
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 0
    Align = alClient
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 1
    object dxBarDockControl1: TdxBarDockControl
      Left = 0
      Top = 0
      Width = 1116
      Height = 30
      Align = dalTop
      BarManager = dxBarManager1
      SunkenBorder = True
      UseOwnSunkenBorder = True
    end
    object cxGridC: TcxGrid
      Left = 0
      Top = 30
      Width = 1116
      Height = 169
      Align = alClient
      TabOrder = 1
      object cxGridCTable: TcxGridDBTableView
        OnCellDblClick = cxGridCTableCellDblClick
        OnCustomDrawCell = cxGridCTableCustomDrawCell
        OnFocusedRecordChanged = cxGridCTableFocusedRecordChanged
        DataController.DataSource = IBCDataSourceC
        DataController.KeyFieldNames = 'CONTRACTID'
        OptionsCustomize.ColumnsQuickCustomization = True
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsSelection.InvertSelect = False
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
        OptionsView.ScrollBars = ssVertical
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        Styles.Header = dmAdditions.cxStyle_GridHeader
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        object cxGridC_FLG_CLOSED: TcxGridDBColumn
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
        object cxGridC_CONTRACTID: TcxGridDBColumn
          Caption = 'ID'
          DataBinding.FieldName = 'CONTRACTID'
          HeaderAlignmentHorz = taCenter
          MinWidth = 50
          Options.Filtering = False
          Options.HorzSizing = False
          Width = 50
        end
        object cxGridC_CODE: TcxGridDBColumn
          Caption = 'Numar/Denumire'
          DataBinding.FieldName = 'CODE'
          HeaderAlignmentHorz = taCenter
          MinWidth = 120
          Options.HorzSizing = False
          VisibleForCustomization = False
          Width = 120
        end
        object cxGridC_CONTRACT_TYPE_TITLE: TcxGridDBColumn
          Caption = 'Tip contract'
          DataBinding.FieldName = 'CONTRACT_TYPE_TITLE'
          MinWidth = 101
          Options.HorzSizing = False
          Width = 101
        end
        object cxGridC_DT_NAME: TcxGridDBColumn
          Caption = 'Organizatia'
          DataBinding.FieldName = 'DT_NAME'
          VisibleForCustomization = False
          Width = 345
        end
        object cxGridC_CT_NAME: TcxGridDBColumn
          Caption = 'Clientul'
          DataBinding.FieldName = 'CT_NAME'
          Width = 174
        end
        object cxGridC_VAT: TcxGridDBColumn
          Caption = 'TVA'
          DataBinding.FieldName = 'VAT'
          HeaderAlignmentHorz = taCenter
          HeaderGlyphAlignmentHorz = taRightJustify
          Width = 74
        end
        object cxGridC_SIGN_DATE: TcxGridDBColumn
          Caption = 'Data Semn.'
          DataBinding.FieldName = 'SIGN_DATE'
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taCenter
          HeaderAlignmentHorz = taCenter
          MinWidth = 100
          Options.Filtering = False
          Options.HorzSizing = False
          Width = 100
        end
        object cxGridC_EXPIRE_DATE: TcxGridDBColumn
          Caption = 'Data fin.'
          DataBinding.FieldName = 'EXPIRE_DATE'
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taCenter
          HeaderAlignmentHorz = taCenter
          MinWidth = 100
          Options.Filtering = False
          Options.HorzSizing = False
          Width = 100
        end
        object cxGridC_CURRENCY_TITLE: TcxGridDBColumn
          Caption = 'Valuta'
          DataBinding.FieldName = 'CURRENCY_TITLE'
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taCenter
          OnGetDisplayText = cxGridC_CURRENCY_TITLEGetDisplayText
          HeaderAlignmentHorz = taCenter
          MinWidth = 60
          Options.HorzSizing = False
          Width = 60
        end
        object cxGridC_PRICE_COLUMN: TcxGridDBColumn
          DataBinding.FieldName = 'PRICE_COLUMN'
          Visible = False
          VisibleForCustomization = False
          IsCaptionAssigned = True
        end
        object cxGridC_FLG_ACNT: TcxGridDBColumn
          Caption = 'Acnt'
          DataBinding.FieldName = 'FLG_ACNT'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          HeaderAlignmentHorz = taCenter
          MinWidth = 40
          Options.HorzSizing = False
          Width = 40
        end
        object cxGridC_CREATED_BY_NAME: TcxGridDBColumn
          Caption = #1057#1086#1079#1076#1072#1083
          DataBinding.FieldName = 'CREATED_BY_NAME'
          Visible = False
          HeaderAlignmentHorz = taCenter
          Width = 100
        end
        object cxGridC_FLG_DEFAULT: TcxGridDBColumn
          Caption = 'Default'
          DataBinding.FieldName = 'FLG_DEFAULT'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = '1'
          Properties.ValueUnchecked = '0'
          MinWidth = 50
          Options.HorzSizing = False
          Width = 50
        end
        object cxGridC_RAGAZ_PLATA: TcxGridDBColumn
          Caption = 'Term Achit'
          DataBinding.FieldName = 'RAGAZ_PLATA'
          Width = 80
        end
      end
      object cxGridCLevel: TcxGridLevel
        GridView = cxGridCTable
      end
    end
    object pnFiles: TPanel
      Left = 0
      Top = 199
      Width = 1116
      Height = 156
      Align = alBottom
      BevelOuter = bvNone
      Caption = 'pnFiles'
      Padding.Top = 2
      TabOrder = 2
      object dxBarDockControl2: TdxBarDockControl
        Left = 0
        Top = 2
        Width = 1116
        Height = 30
        Align = dalTop
        BarManager = dxBarManager1
        SunkenBorder = True
        UseOwnSunkenBorder = True
      end
      object cxGridFiles: TcxGrid
        Left = 0
        Top = 32
        Width = 1116
        Height = 124
        Align = alClient
        TabOrder = 1
        object cxGridFilesTable: TcxGridDBTableView
          OnFocusedRecordChanged = cxGridFilesTableFocusedRecordChanged
          DataController.DataSource = IBCDataSourceFiles
          DataController.KeyFieldNames = 'CONTRACTFILEID'
          OptionsCustomize.ColumnFiltering = False
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsSelection.InvertSelect = False
          OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
          OptionsView.ScrollBars = ssVertical
          OptionsView.ColumnAutoWidth = True
          OptionsView.GridLineColor = 13750737
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          Styles.Header = dmAdditions.cxStyle_GridHeader
          Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
          object cxGridFiles_IMG: TcxGridDBColumn
            PropertiesClassName = 'TcxImageComboBoxProperties'
            Properties.DefaultImageIndex = 32
            Properties.Images = dmAdditions.cxImageList_SWN
            Properties.Items = <>
            MinWidth = 24
            Options.HorzSizing = False
            Width = 24
          end
          object cxGridFiles_TITLE: TcxGridDBColumn
            Caption = 'Denumire'
            DataBinding.FieldName = 'TITLE'
            Width = 300
          end
          object cxGridFiles_FILENAME: TcxGridDBColumn
            Caption = 'FileName'
            DataBinding.FieldName = 'FILENAME'
            Width = 100
          end
          object cxGridFiles_FILESIZE: TcxGridDBColumn
            Caption = 'Marime, bytes'
            DataBinding.FieldName = 'FILESIZE'
            HeaderAlignmentHorz = taCenter
            MinWidth = 100
            Options.HorzSizing = False
            Width = 100
          end
        end
        object cxGridFilesLevel: TcxGridLevel
          GridView = cxGridFilesTable
        end
      end
    end
  end
  object pnBottom: TPanel
    Left = 0
    Top = 427
    Width = 1132
    Height = 57
    Align = alBottom
    BevelOuter = bvNone
    Padding.Left = 8
    Padding.Top = 12
    Padding.Right = 24
    Padding.Bottom = 16
    ShowCaption = False
    TabOrder = 2
    object btnOk: TButton
      AlignWithMargins = True
      Left = 916
      Top = 12
      Width = 90
      Height = 29
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 12
      Margins.Bottom = 0
      Align = alRight
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
    object btnCancel: TButton
      Left = 1018
      Top = 12
      Width = 90
      Height = 29
      Align = alRight
      Cancel = True
      Caption = 'Renunta'
      ModalResult = 2
      TabOrder = 1
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
    ImageOptions.StretchGlyphs = False
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 636
    Top = 16
    PixelsPerInch = 96
    object dxBarManager1Bar1: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Custom 1'
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1050
      FloatTop = 8
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
          ItemName = 'dxBarSubItem1'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar2: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Custom 2'
      CaptionButtons = <>
      DockControl = dxBarDockControl2
      DockedDockControl = dxBarDockControl2
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1050
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbFileNew'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbFileDelete'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbFileSave'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton1'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
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
      ShortCut = 46
      OnClick = bbDeleteClick
    end
    object bbFileNew: TdxBarButton
      Caption = 'Nou'
      Category = 0
      Hint = 'Nou'
      Visible = ivAlways
      ImageIndex = 40
      OnClick = bbFileNewClick
    end
    object bbFileDelete: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      OnClick = bbFileDeleteClick
    end
    object bbFileSave: TdxBarButton
      Caption = 'Salveaza'
      Category = 0
      Hint = 'Salveaza'
      Visible = ivAlways
      ImageIndex = 32
      OnClick = bbFileSaveClick
    end
    object dxBarButton1: TdxBarButton
      Caption = 'Preview'
      Category = 0
      Hint = 'Preview'
      Visible = ivAlways
      OnClick = dxBarButton1Click
    end
    object dxBarButton2: TdxBarButton
      Caption = 'Contracte'
      Category = 0
      Hint = '|Contracte'
      Visible = ivAlways
      ShortCut = 16464
      OnClick = dxBarButton2Click
    end
    object dxBarSubItem1: TdxBarSubItem
      Caption = 'Tipar'
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarButton2'
        end>
    end
  end
  object IBCQueryC: TIBCQuery
    KeyFields = 'CONTRACTID'
    KeyGenerator = 'SQ_TDB_CONTRACTS_ID'
    GeneratorMode = gmInsert
    SQLInsert.Strings = (
      'INSERT INTO VW_TDB_CONTRACTS'
      
        '  (CONTRACTID, CODE, DT, DT_NAME, CT, CT_NAME, DT_RESPONSABILE_P' +
        'ERSON, DT_RESPONSABILE_PERSON_NAME, CT_RESPONSABILE_PERSON, CT_R' +
        'ESPONSABILE_PERSON_NAME, SIGN_DATE, EXPIRE_DATE, CONTRACT_TYPE, ' +
        'CONTRACT_TYPE_TITLE, PRICE_COLUMN, CURRENCYID, CURRENCY_TITLE, C' +
        'REATED_BY, CREATED_BY_NAME, CREATED_DATE, VAT, FLG_ACNT, FLG_CLO' +
        'SED, FLG_DEFAULT, DT_BANKACCOUNT, DT_BANK_NAME, DT_IBAN, CT_BANK' +
        'ACCOUNT, CT_BANK_NAME, CT_IBAN, DELIVERY_TERM_DAYS, PAYMENT_TERM' +
        '_DAYS, DELIVERY_PLACE)'
      'VALUES'
      
        '  (:CONTRACTID, :CODE, :DT, :DT_NAME, :CT, :CT_NAME, :DT_RESPONS' +
        'ABILE_PERSON, :DT_RESPONSABILE_PERSON_NAME, :CT_RESPONSABILE_PER' +
        'SON, :CT_RESPONSABILE_PERSON_NAME, :SIGN_DATE, :EXPIRE_DATE, :CO' +
        'NTRACT_TYPE, :CONTRACT_TYPE_TITLE, :PRICE_COLUMN, :CURRENCYID, :' +
        'CURRENCY_TITLE, :CREATED_BY, :CREATED_BY_NAME, :CREATED_DATE, :V' +
        'AT, :FLG_ACNT, :FLG_CLOSED, :FLG_DEFAULT, :DT_BANKACCOUNT, :DT_B' +
        'ANK_NAME, :DT_IBAN, :CT_BANKACCOUNT, :CT_BANK_NAME, :CT_IBAN, :D' +
        'ELIVERY_TERM_DAYS, :PAYMENT_TERM_DAYS, :DELIVERY_PLACE)')
    SQLDelete.Strings = (
      'DELETE FROM VW_TDB_CONTRACTS'
      'WHERE'
      '  CONTRACTID = :Old_CONTRACTID')
    SQLUpdate.Strings = (
      'UPDATE VW_TDB_CONTRACTS'
      'SET'
      
        '  CONTRACTID = :CONTRACTID, CODE = :CODE, DT = :DT, DT_NAME = :D' +
        'T_NAME, CT = :CT, CT_NAME = :CT_NAME, DT_RESPONSABILE_PERSON = :' +
        'DT_RESPONSABILE_PERSON, DT_RESPONSABILE_PERSON_NAME = :DT_RESPON' +
        'SABILE_PERSON_NAME, CT_RESPONSABILE_PERSON = :CT_RESPONSABILE_PE' +
        'RSON, CT_RESPONSABILE_PERSON_NAME = :CT_RESPONSABILE_PERSON_NAME' +
        ', SIGN_DATE = :SIGN_DATE, EXPIRE_DATE = :EXPIRE_DATE, CONTRACT_T' +
        'YPE = :CONTRACT_TYPE, CONTRACT_TYPE_TITLE = :CONTRACT_TYPE_TITLE' +
        ', PRICE_COLUMN = :PRICE_COLUMN, CURRENCYID = :CURRENCYID, CURREN' +
        'CY_TITLE = :CURRENCY_TITLE, CREATED_BY = :CREATED_BY, CREATED_BY' +
        '_NAME = :CREATED_BY_NAME, CREATED_DATE = :CREATED_DATE, VAT = :V' +
        'AT, FLG_ACNT = :FLG_ACNT, FLG_CLOSED = :FLG_CLOSED, FLG_DEFAULT ' +
        '= :FLG_DEFAULT, DT_BANKACCOUNT = :DT_BANKACCOUNT, DT_BANK_NAME =' +
        ' :DT_BANK_NAME, DT_IBAN = :DT_IBAN, CT_BANKACCOUNT = :CT_BANKACC' +
        'OUNT, CT_BANK_NAME = :CT_BANK_NAME, CT_IBAN = :CT_IBAN, DELIVERY' +
        '_TERM_DAYS = :DELIVERY_TERM_DAYS, PAYMENT_TERM_DAYS = :PAYMENT_T' +
        'ERM_DAYS, DELIVERY_PLACE = :DELIVERY_PLACE'
      'WHERE'
      '  CONTRACTID = :Old_CONTRACTID')
    SQLRefresh.Strings = (
      
        'SELECT CONTRACTID, CODE, DT, DT_NAME, CT, CT_NAME, DT_RESPONSABI' +
        'LE_PERSON, DT_RESPONSABILE_PERSON_NAME, CT_RESPONSABILE_PERSON, ' +
        'CT_RESPONSABILE_PERSON_NAME, SIGN_DATE, EXPIRE_DATE, CONTRACT_TY' +
        'PE, CONTRACT_TYPE_TITLE, PRICE_COLUMN, CURRENCYID, CURRENCY_TITL' +
        'E, CREATED_BY, CREATED_BY_NAME, CREATED_DATE, VAT, FLG_ACNT, FLG' +
        '_CLOSED, FLG_DEFAULT, DT_BANKACCOUNT, DT_BANK_NAME, DT_IBAN, CT_' +
        'BANKACCOUNT, CT_BANK_NAME, CT_IBAN, DELIVERY_TERM_DAYS, PAYMENT_' +
        'TERM_DAYS, DELIVERY_PLACE FROM VW_TDB_CONTRACTS'
      'WHERE'
      '  CONTRACTID = :CONTRACTID')
    SQLLock.Strings = (
      'SELECT NULL FROM TDB_CONTRACTS'
      'WHERE'
      'CONTRACTID = :Old_CONTRACTID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM VW_TDB_CONTRACTS'
      ''
      ') q')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = IBCTrUpdate
    SQL.Strings = (
      'SELECT'
      '*'
      'FROM VW_TDB_CONTRACTS '
      'WHERE CT=:CT'
      'ORDER BY EXPIRE_DATE DESC')
    LockMode = lmLockImmediate
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Options.RequiredFields = False
    Options.DefaultValues = True
    Options.StrictUpdate = False
    LocalConstraints = False
    Left = 76
    Top = 168
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CT'
        Value = nil
      end>
  end
  object IBCDataSourceC: TIBCDataSource
    DataSet = IBCQueryC
    Left = 76
    Top = 108
  end
  object IBCTrUpdate: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 300
    Top = 204
  end
  object IBCQueryFiles: TIBCQuery
    KeyFields = 'CONTRACTFILEID'
    KeyGenerator = 'SQ_TDB_CONTRACT_FILES_ID'
    GeneratorMode = gmInsert
    SQLInsert.Strings = (
      'INSERT INTO TDB_CONTRACT_FILES'
      '  (CONTRACTFILEID, CONTRACTID, TITLE, FILENAME, FILESIZE)'
      'VALUES'
      '  (:CONTRACTFILEID, :CONTRACTID, :TITLE, :FILENAME, :FILESIZE)')
    SQLDelete.Strings = (
      'DELETE FROM TDB_CONTRACT_FILES'
      'WHERE'
      '  CONTRACTFILEID = :Old_CONTRACTFILEID')
    SQLRefresh.Strings = (
      'SELECT CONTRACTFILEID, CONTRACTID, TITLE, FILENAME, FILESIZE'
      'FROM TDB_CONTRACT_FILES'
      'WHERE CONTRACTFILEID = :CONTRACTFILEID')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = IBCTrUpdate
    SQL.Strings = (
      'SELECT'
      ' CONTRACTFILEID, '
      ' CONTRACTID, '
      ' TITLE, '
      ' FILENAME, '
      ' FILESIZE'
      'FROM '
      ' TDB_CONTRACT_FILES')
    MasterFields = 'CONTRACTID'
    DetailFields = 'CONTRACTID'
    MasterSource = IBCDataSourceC
    RefreshOptions = [roAfterInsert]
    Options.RequiredFields = False
    Options.DetailDelay = 50
    LocalConstraints = False
    Left = 112
    Top = 396
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CONTRACTID'
        Value = nil
      end>
  end
  object IBCDataSourceFiles: TIBCDataSource
    DataSet = IBCQueryFiles
    Left = 216
    Top = 396
  end
end
