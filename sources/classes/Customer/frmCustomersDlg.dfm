object frmCustomersDlg: TfrmCustomersDlg
  Left = 0
  Top = 0
  ActiveControl = cxGridCustomers
  BorderIcons = [biSystemMenu]
  Caption = 'Nomenclator clienti'
  ClientHeight = 600
  ClientWidth = 1033
  Color = clBtnFace
  Constraints.MinHeight = 365
  Constraints.MinWidth = 599
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  OnCreate = FormCreate
  TextHeight = 15
  object pnBottom: TPanel
    Left = 0
    Top = 556
    Width = 1033
    Height = 44
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 5
    DesignSize = (
      1033
      44)
    object btnOk: TcxButton
      Left = 827
      Top = 6
      Width = 90
      Height = 29
      Anchors = [akTop, akRight]
      Caption = 'OK'
      TabOrder = 0
      OnClick = btnOkClick
    end
    object btnCancel: TcxButton
      Left = 923
      Top = 6
      Width = 90
      Height = 29
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Renunta'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object cxGridCustomers: TcxGrid
    Left = 0
    Top = 26
    Width = 1033
    Height = 530
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = cxcbsNone
    TabOrder = 0
    LookAndFeel.NativeStyle = True
    LookAndFeel.SkinName = ''
    object cxGridCustomersTable: TcxGridDBTableView
      PopupMenu = dxBarPopupMenu
      OnDblClick = cxGridCustomersTableDblClick
      OnKeyDown = cxGridCustomersDBTableView1KeyUp
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
      OnCustomDrawCell = cxGridCustomersTableCustomDrawCell
      OnFocusedRecordChanged = cxGridCustomersTableFocusedRecordChanged
      DataController.DataModeController.GridMode = True
      DataController.DataModeController.GridModeBufferCount = 100
      DataController.DataSource = IBCDataSourceCustomer
      DataController.KeyFieldNames = 'CUSTOMERID'
      OptionsBehavior.IncSearch = True
      OptionsCustomize.ColumnFiltering = False
      OptionsCustomize.ColumnGrouping = False
      OptionsCustomize.ColumnHiding = True
      OptionsCustomize.ColumnMoving = False
      OptionsCustomize.ColumnsQuickCustomization = True
      OptionsCustomize.ColumnsQuickCustomizationReordering = qcrDisabled
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.MultiSelect = True
      OptionsView.CellEndEllipsis = True
      OptionsView.NoDataToDisplayInfoText = '<Nu sunt inregistrari>'
      OptionsView.ScrollBars = ssVertical
      OptionsView.ColumnAutoWidth = True
      OptionsView.GridLineColor = 13750737
      OptionsView.GroupByBox = False
      Styles.Header = dmAdditions.cxStyle_GridHeader
      Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
      object cxGridCustomers_CUSTOMERID: TcxGridDBColumn
        AlternateCaption = 'Cod client'
        Caption = 'Cod'
        DataBinding.FieldName = 'CUSTOMERID'
        FooterAlignmentHorz = taRightJustify
        GroupSummaryAlignment = taRightJustify
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Options.Filtering = False
        Options.FilteringFilteredItemsList = False
        Options.ShowEditButtons = isebNever
        Options.SortByDisplayText = isbtOff
        Width = 104
      end
      object cxGridCustomers_IMG: TcxGridDBColumn
        DataBinding.FieldName = 'IMAGE_INDEX'
        PropertiesClassName = 'TcxImageComboBoxProperties'
        Properties.Images = dmAdditions.cxImageList_SWN
        Properties.Items = <
          item
            Description = 'Mapa'
            ImageIndex = 13
            Value = 0
          end
          item
            Description = 'Subdiviziune proprie'
            ImageIndex = 11
            Value = 2
          end
          item
            Description = 'Angajat'
            ImageIndex = 20
            Value = 1
          end
          item
            Description = 'Client'
            ImageIndex = 10
            Value = 4
          end
          item
            Description = 'Persoana juridica'
            ImageIndex = 56
            Value = 3
          end
          item
            Description = 'Client web'
            ImageIndex = 57
            Value = 5
          end
          item
            Description = 'Diler'
            ImageIndex = 77
            Value = 6
          end>
        MinWidth = 24
        Options.Editing = False
        Options.Filtering = False
        Options.Focusing = False
        Options.IncSearch = False
        Options.ShowEditButtons = isebNever
        Options.GroupFooters = False
        Options.Grouping = False
        Options.HorzSizing = False
        Options.Moving = False
        Options.Sorting = False
        VisibleForCustomization = False
        Width = 24
        IsCaptionAssigned = True
      end
      object cxGridCustomers_DISPLAYNAME: TcxGridDBColumn
        Caption = 'Client'
        DataBinding.FieldName = 'DISPLAYNAME'
        Styles.OnGetContentStyle = cxGridCustomers_DISPLAYNAMEStylesGetContentStyle
        VisibleForCustomization = False
        Width = 468
      end
      object cxGridCustomers_TELEFON1: TcxGridDBColumn
        Caption = 'Telefon'
        DataBinding.FieldName = 'TELEFON1'
        MinWidth = 90
        Options.HorzSizing = False
        Width = 90
      end
      object cxGridCustomers_FAX: TcxGridDBColumn
        Caption = #1060#1072#1082#1089
        DataBinding.FieldName = 'FAX'
        Visible = False
        MinWidth = 90
        Options.HorzSizing = False
        Width = 90
      end
      object cxGridCustomers_MOBILE: TcxGridDBColumn
        Caption = 'Tel. Mobil'
        DataBinding.FieldName = 'MOBILE'
        Width = 125
      end
      object cxGridCustomers_ACCOUNTNUMBER: TcxGridDBColumn
        Caption = 'Cont bancar'
        DataBinding.FieldName = 'ACCOUNTNUMBER'
        Visible = False
        MinWidth = 100
        Options.HorzSizing = False
        Width = 100
      end
      object cxGridCustomers_IDEN_NUMBER: TcxGridDBColumn
        Caption = 'Cod fiscal'
        DataBinding.FieldName = 'IDEN_NUMBER'
        MinWidth = 100
        Options.HorzSizing = False
        Width = 100
      end
      object cxGridCustomers_FLG_FOLDER: TcxGridDBColumn
        DataBinding.FieldName = 'FLG_FOLDER'
        Visible = False
        VisibleForCustomization = False
      end
      object cxGridCustomers_CUSTOMER_STATUS_ID: TcxGridDBColumn
        Caption = 'Status'
        DataBinding.FieldName = 'CUSTOMER_STATUS_ID'
        Visible = False
        VisibleForCustomization = False
      end
    end
    object cxGridCustomersLevel: TcxGridLevel
      GridView = cxGridCustomersTable
    end
  end
  object dxBarManager: TdxBarManager
    AllowReset = False
    AutoDockColor = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    CanCustomize = False
    Categories.Strings = (
      'Default'
      'Navigation'
      'Customer'
      'Addons'
      'Search')
    Categories.ItemsVisibles = (
      2
      2
      2
      2
      2)
    Categories.Visibles = (
      True
      True
      True
      True
      True)
    DockColor = clBtnFace
    ImageOptions.Images = dmAdditions.cxImageList_SWN
    ImageOptions.MakeDisabledImagesFaded = True
    ImageOptions.SmoothGlyphs = True
    LookAndFeel.SkinName = ''
    NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
    PopupMenuLinks = <>
    ShowFullMenusAfterDelay = False
    ShowShortCutInHint = True
    SunkenBorder = True
    UseF10ForMenu = False
    UseSystemFont = False
    Left = 31
    Top = 66
    PixelsPerInch = 96
    DockControlHeights = (
      0
      0
      26
      0)
    object dxBarManager1Bar1: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      BorderStyle = bbsNone
      Caption = 'Navigator'
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 0
      DockedTop = 0
      DockingStyle = dsTop
      FloatLeft = 705
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbFirst'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbBack'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbForward'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarSubItem1'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbAdditionalTools'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbTools'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbPrint'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'dxBarButton1'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      SizeGrip = False
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object bbChangeFolderOrder: TdxBarButton
      Caption = 'Sorteaza mape'
      Category = 0
      Hint = 'Sorteaza mape'
      Visible = ivAlways
      ImageIndex = 38
      OnClick = bbChangeFolderOrderClick
    end
    object bbGotoCustomer: TdxBarButton
      Caption = 'Treci in mapa clientului'
      Category = 0
      Hint = 'Treci in mapa clientului'
      Visible = ivAlways
      ShortCut = 32
      OnClick = bbGotoCustomerClick
    end
    object bbTools: TdxBarSubItem
      Caption = 'Instrumente'
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbJoinCustomers'
        end
        item
          Visible = True
          ItemName = 'bbSetupFirmsFor1C'
        end
        item
          Visible = True
          ItemName = 'bbDial'
        end
        item
          Visible = True
          ItemName = 'bbChangeParent'
        end
        item
          Visible = True
          ItemName = 'bbChangeFolderOrder'
        end
        item
          Visible = True
          ItemName = 'bbCustomerCurrentDebts'
        end
        item
          Visible = True
          ItemName = 'bbNotifyCustDebts'
        end>
    end
    object bbJoinCustomers: TdxBarButton
      Caption = 'Fuzionarea clientilor'
      Category = 0
      Hint = 'Fuzionarea clientilor'
      Visible = ivAlways
      CloseSubMenuOnClick = False
      ShortCut = 32838
      OnClick = bbJoinCustomersClick
    end
    object bbPrint: TdxBarButton
      Caption = 'Tipar'
      Category = 0
      Hint = 'Tipar'
      Visible = ivAlways
      ImageIndex = 28
      ShortCut = 16464
      OnClick = bbPrintClick
    end
    object bbNotifyCustDebts: TdxBarButton
      Caption = 'Alerte la datorii'
      Category = 0
      Hint = 'Alerte la datorii'
      Visible = ivAlways
      OnClick = bbNotifyCustDebtsClick
    end
    object bbSetupFirmsFor1C: TdxBarButton
      Caption = 'Setarea intreprinderilor pentru 1C'
      Category = 0
      Hint = 'Setarea intreprinderilor pentru 1C'
      Visible = ivAlways
      OnClick = bbSetupFirmsFor1CClick
    end
    object bbCustomerContracts: TdxBarButton
      Caption = 'Contracte'
      Category = 0
      Hint = 'Contracte'
      Visible = ivAlways
      ShortCut = 32835
      OnClick = bbCustomerContractsClick
    end
    object bbDial: TdxBarButton
      Caption = 'Apel telefonic'
      Category = 0
      Hint = 'Apel telefonic'
      Visible = ivAlways
      ShortCut = 32836
      OnClick = bbDialClick
    end
    object bbSMSHistory: TdxBarButton
      Caption = 'Istoria SMS'
      Category = 0
      Hint = 'Istoria SMS'
      Visible = ivAlways
    end
    object dxBarButton2: TdxBarButton
      Caption = 'Adrese pentru livrare...'
      Category = 0
      Hint = 'Adrese pentru livrare'
      Visible = ivAlways
      ShortCut = 16460
      OnClick = dxBarButton2Click
    end
    object dxBarButton3: TdxBarButton
      Caption = 'Informatii generale'
      Category = 0
      Hint = 'Informatii generale'
      Visible = ivAlways
      ShortCut = 112
      OnClick = dxBarButton3Click
    end
    object dxBarButton4: TdxBarButton
      Caption = 'Categorii - Liste de preturi'
      Category = 0
      Hint = 'Categorii - Liste de preturi'
      Visible = ivAlways
      OnClick = dxBarButton4Click
    end
    object bbConditiiDeLucru: TdxBarButton
      Caption = 'Conditii de lucru'
      Category = 0
      Hint = 'Conditii de lucru'
      Visible = ivAlways
      OnClick = bbConditiiDeLucruClick
    end
    object bbGoodsFromSupplierDlg: TdxBarButton
      Caption = 'Produse de la acest furnitor'
      Category = 0
      Hint = 'Produse de la acest furnitor'
      Visible = ivAlways
      ShortCut = 117
      OnClick = bbGoodsFromSupplierDlgClick
    end
    object bbFirst: TdxBarButton
      Caption = 'Inceput'
      Category = 1
      Hint = 'Inceput'
      Visible = ivAlways
      ImageIndex = 5
      OnClick = bbFirstClick
    end
    object bbBack: TdxBarButton
      Caption = 'Inapoi'
      Category = 1
      Hint = 'Inapoi'
      Visible = ivAlways
      ImageIndex = 6
      OnClick = bbBackClick
    end
    object bbForward: TdxBarButton
      Caption = 'Inainte'
      Category = 1
      Hint = 'Inainte'
      Visible = ivAlways
      ImageIndex = 7
      OnClick = bbForwardClick
    end
    object dxBarSubItem1: TdxBarSubItem
      Caption = 'Client'
      Category = 2
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbGotoCustomer'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbNewFolder'
        end
        item
          Visible = True
          ItemName = 'bbNewCustomer'
        end
        item
          Visible = True
          ItemName = 'bbEditCustomer'
        end
        item
          Visible = True
          ItemName = 'bbDeleteCustomer'
        end>
    end
    object bbNewCustomer: TdxBarButton
      Caption = 'Client nou...'
      Category = 2
      Hint = 'Client nou'
      Visible = ivAlways
      ImageIndex = 10
      ShortCut = 45
      OnClick = bbNewCustomerClick
    end
    object bbEditCustomer: TdxBarButton
      Caption = 'Modifica'
      Category = 2
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 115
      OnClick = bbEditCustomerClick
    end
    object bbDeleteCustomer: TdxBarButton
      Caption = 'Sterge'
      Category = 2
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      ShortCut = 46
      OnClick = bbDeleteCustomerClick
    end
    object bbNewFolder: TdxBarButton
      Caption = 'Mapa noua'
      Category = 2
      Hint = 'Mapa noua'
      Visible = ivAlways
      ImageIndex = 13
      OnClick = bbNewFolderClick
    end
    object bbAdditionalTools: TdxBarSubItem
      Caption = 'Suplimentar'
      Category = 3
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarButton3'
        end
        item
          Visible = True
          ItemName = 'bbAccounts'
        end
        item
          Visible = True
          ItemName = 'bbDiscounts'
        end
        item
          Visible = True
          ItemName = 'bbCredits'
        end
        item
          Visible = True
          ItemName = 'bbWEB'
        end
        item
          Visible = True
          ItemName = 'bbComments'
        end
        item
          Visible = True
          ItemName = 'bbConditiiDeLucru'
        end
        item
          Visible = True
          ItemName = 'bbStamp'
        end
        item
          Visible = True
          ItemName = 'bbCustomerContracts'
        end
        item
          Visible = True
          ItemName = 'dxBarButton2'
        end
        item
          Visible = True
          ItemName = 'bbGoodsFromSupplierDlg'
        end
        item
          Visible = True
          ItemName = 'dxBarButton4'
        end>
    end
    object bbAccounts: TdxBarButton
      Caption = 'Rechizite bancare'
      Category = 3
      Hint = 'Rechizite bancare'
      Visible = ivAlways
      ShortCut = 16450
      OnClick = bbAccountsClick
    end
    object bbDiscounts: TdxBarButton
      Caption = 'Carduri de reducere'
      Category = 3
      Hint = 'Carduri de reducere'
      Visible = ivAlways
      ImageIndex = 21
      ShortCut = 16466
      OnClick = bbDiscountsClick
    end
    object bbCredits: TdxBarButton
      Caption = 'Credite'
      Category = 3
      Hint = 'Credite'
      Visible = ivAlways
      ShortCut = 16459
      OnClick = bbCreditsClick
    end
    object bbWEB: TdxBarButton
      Caption = 'Acces internet'
      Category = 3
      Hint = 'Acces internet'
      Visible = ivAlways
      ShortCut = 16471
      OnClick = bbWEBClick
    end
    object bbComments: TdxBarButton
      Caption = 'Comentarii'
      Category = 3
      Hint = 'Comentarii'
      Visible = ivAlways
      ImageIndex = 22
      OnClick = bbCommentsClick
    end
    object bbChangeParent: TdxBarButton
      Caption = 'Modifica parinte'
      Category = 3
      Hint = 'Modifica parinte'
      Visible = ivAlways
      ShortCut = 16461
      OnClick = bbChangeParentClick
    end
    object bbCustomerCurrentDebts: TdxBarButton
      Caption = 'Datorii curente ...'
      Category = 3
      Hint = 'Datorii curente '
      Visible = ivAlways
      ShortCut = 16452
      OnClick = bbCustomerCurrentDebtsClick
    end
    object bbStamp: TdxBarButton
      Caption = 'Logo si stampila pentru rapoarte'
      Category = 3
      Hint = 'Logo si stampila pentru rapoarte'
      Visible = ivAlways
      OnClick = bbStampClick
    end
    object dxBarButton1: TdxBarButton
      Caption = 'Cauta...'
      Category = 4
      Hint = 'Cauta'
      Visible = ivAlways
      ImageIndex = 4
      ShortCut = 16454
      OnClick = dxBarButton1Click
    end
  end
  object IBCDataSourceCustomer: TIBCDataSource
    DataSet = IBCQueryCustomer
    Left = 208
    Top = 44
  end
  object IBCTrUpdateCustomer: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 456
    Top = 92
  end
  object dxBarPopupMenu: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbNewFolder'
      end
      item
        Visible = True
        ItemName = 'bbNewCustomer'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbEditCustomer'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbCredits'
      end
      item
        Visible = True
        ItemName = 'bbAccounts'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbDiscounts'
      end
      item
        Visible = True
        ItemName = 'bbWEB'
      end
      item
        Visible = True
        ItemName = 'bbComments'
      end
      item
        Visible = True
        ItemName = 'bbStamp'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbNotifyCustDebts'
      end
      item
        Visible = True
        ItemName = 'bbCustomerCurrentDebts'
      end>
    UseOwnFont = False
    Left = 28
    Top = 120
    PixelsPerInch = 96
  end
  object cxPropertiesStore1: TcxPropertiesStore
    Components = <>
    StorageName = 'cxPropertiesStore1'
    Left = 456
    Top = 184
  end
  object IBCQueryCustomer: TIBCQuery
    KeyFields = 'CUSTOMERID'
    KeyGenerator = 'SQ_TS_CUSTOMER_CUSTOMERID'
    GeneratorMode = gmInsert
    SQLInsert.Strings = (
      'INSERT INTO VW_TS_CUSTOMER'
      
        '  (CUSTOMERID, PARENTID, FLG_FOLDER, PREFIXNAME, NAME, SUFIXNAME' +
        ', DISPLAYNAME, ORG_PARENT_ID, CUSTOMER_TYPE_ID, CUSTOMER_STATUS_' +
        'ID, VAT, ORDERNO, CHIEF, ACCOUNTANT, TELEFON1, MOBILE, FAX, IDEN' +
        '_NUMBER, VAT_NUMBER, EMAIL, ADDRESS, ADDRESS2, REZIDENT, CITY_ID' +
        ', ACCOUNTNUMBER, PRICECOLUMN, CUSTOMER_TYPE_TITLE, CUSTOMER_STAT' +
        'US_TITLE, CITY_TITLE, USERID, USER_NAME, BIRTH_DATE, IMAGE_INDEX' +
        ', WEBPAGE, GENDER, flg_furnizor, flg_cumparator, rrp_discount)'
      'VALUES'
      
        '  (:CUSTOMERID, :PARENTID, :FLG_FOLDER, :PREFIXNAME, :NAME, :SUF' +
        'IXNAME, :DISPLAYNAME, :ORG_PARENT_ID, :CUSTOMER_TYPE_ID, :CUSTOM' +
        'ER_STATUS_ID, :VAT, :ORDERNO, :CHIEF, :ACCOUNTANT, :TELEFON1, :M' +
        'OBILE, :FAX, :IDEN_NUMBER, :VAT_NUMBER, :EMAIL, trim(:ADDRESS), ' +
        'trim(:ADDRESS2), :REZIDENT, :CITY_ID, :ACCOUNTNUMBER, :PRICECOLU' +
        'MN, :CUSTOMER_TYPE_TITLE, :CUSTOMER_STATUS_TITLE, :CITY_TITLE, :' +
        'USERID, :USER_NAME, :BIRTH_DATE, :IMAGE_INDEX, :WEBPAGE, :GENDER' +
        ', :flg_furnizor, :flg_cumparator, :rrp_discount)')
    SQLDelete.Strings = (
      'DELETE FROM VW_TS_CUSTOMER'
      'WHERE'
      '  CUSTOMERID = :Old_CUSTOMERID')
    SQLUpdate.Strings = (
      'UPDATE VW_TS_CUSTOMER'
      'SET'
      
        '  CUSTOMERID = :CUSTOMERID, PARENTID = :PARENTID, FLG_FOLDER = :' +
        'FLG_FOLDER, '
      'PREFIXNAME = :PREFIXNAME, NAME = :NAME, SUFIXNAME = :SUFIXNAME, '
      'DISPLAYNAME = :DISPLAYNAME, ORG_PARENT_ID = :ORG_PARENT_ID, '
      
        'CUSTOMER_TYPE_ID = :CUSTOMER_TYPE_ID, CUSTOMER_STATUS_ID = :CUST' +
        'OMER_STATUS_ID, '
      
        'VAT = :VAT, ORDERNO = :ORDERNO, CHIEF = :CHIEF, ACCOUNTANT = :AC' +
        'COUNTANT, '
      
        'TELEFON1 = :TELEFON1, MOBILE = :MOBILE, FAX = :FAX, IDEN_NUMBER ' +
        '= :IDEN_NUMBER, '
      
        'VAT_NUMBER = :VAT_NUMBER, EMAIL = :EMAIL, ADDRESS = :ADDRESS, AD' +
        'DRESS2 = :ADDRESS2, '
      
        'REZIDENT = :REZIDENT, CITY_ID = :CITY_ID, ACCOUNTNUMBER = :ACCOU' +
        'NTNUMBER, '
      
        'PRICECOLUMN = :PRICECOLUMN, CUSTOMER_TYPE_TITLE = :CUSTOMER_TYPE' +
        '_TITLE, '
      
        'CUSTOMER_STATUS_TITLE = :CUSTOMER_STATUS_TITLE, CITY_TITLE = :CI' +
        'TY_TITLE, '
      
        'USERID = :USERID, USER_NAME = :USER_NAME, BIRTH_DATE = :BIRTH_DA' +
        'TE, '
      
        'IMAGE_INDEX = :IMAGE_INDEX, WEBPAGE = :WEBPAGE, GENDER = :GENDER' +
        ', flg_furnizor = :flg_furnizor, flg_cumparator = :flg_cumparator' +
        ','
      'rrp_discount = :rrp_discount'
      'WHERE'
      '  CUSTOMERID = :Old_CUSTOMERID')
    SQLRefresh.Strings = (
      'SELECT * FROM VW_TS_CUSTOMER'
      'WHERE'
      '  CUSTOMERID = :CUSTOMERID')
    SQLLock.Strings = (
      'SELECT NULL FROM TS_CUSTOMER'
      'WHERE'
      'CUSTOMERID = :Old_CUSTOMERID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM VW_TS_CUSTOMER'
      ''
      ') q')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = IBCTrUpdateCustomer
    SQL.Strings = (
      'SELECT * FROM SELECT_CUSTOMERS(-1, 8, '#39'ANDREI'#39')')
    FetchRows = 100
    AutoCommit = False
    RefreshOptions = [roAfterInsert, roAfterUpdate, roBeforeEdit]
    Options.QueryRowsAffected = False
    Options.DetailDelay = 300
    Left = 207
    Top = 106
  end
end
