object frmSelectSNDlg: TfrmSelectSNDlg
  Left = 0
  Top = 0
  ActiveControl = cxGridAvSN
  BorderStyle = bsDialog
  Caption = 'Alegerea seriilor'
  ClientHeight = 628
  ClientWidth = 892
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnClose = FormClose
  DesignSize = (
    892
    628)
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 892
    Height = 64
    Title = 'Gestionarea numerilor de serie'
    Text = 'Alege seriile'
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
    ImageIndex = 17
  end
  object pnGoods: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 876
    Height = 497
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 0
    Align = alTop
    BevelKind = bkTile
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    object cxLabel1: TLabel
      Left = 12
      Top = 19
      Width = 52
      Height = 15
      Caption = 'Denumire'
      Transparent = True
    end
    object cxLabel2: TLabel
      Left = 702
      Top = 19
      Width = 103
      Height = 15
      Caption = 'Cantitatea necesara'
      Transparent = True
    end
    object sbAddSerials: TSpeedButton
      Left = 316
      Top = 70
      Width = 36
      Height = 29
      Action = actAddSerialNumber
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
    end
    object sbRemoveSerials: TSpeedButton
      Left = 316
      Top = 105
      Width = 36
      Height = 29
      Action = actRemoveSerialNumber
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
    end
    object lbInfo: TLabel
      Left = 12
      Top = 453
      Width = 849
      Height = 25
      Alignment = taCenter
      AutoSize = False
      Color = 28895
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = True
      Layout = tlCenter
    end
    object Label1: TLabel
      Left = 12
      Top = 456
      Width = 77
      Height = 15
      Caption = 'Cautare rapida'
    end
    object edGOODS_NAME: TcxDBTextEdit
      Left = 156
      Top = 16
      TabStop = False
      DataBinding.DataField = 'GOODS_NAME'
      Properties.ReadOnly = True
      TabOrder = 1
      Width = 515
    end
    object edQTY: TcxDBTextEdit
      Left = 811
      Top = 16
      TabStop = False
      DataBinding.DataField = 'QTY'
      Properties.ReadOnly = True
      Style.TextStyle = [fsBold]
      TabOrder = 2
      Width = 46
    end
    object cxGridAvSN: TcxGrid
      AlignWithMargins = True
      Left = 12
      Top = 56
      Width = 290
      Height = 394
      Margins.Left = 0
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 0
      TabOrder = 3
      object cxGridAvSNTable: TcxGridTableView
        OnKeyDown = cxGridAvSNTableKeyDown
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        OnCellDblClick = cxGridAvSNTableCellDblClick
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <
          item
            Kind = skCount
            Column = cxGridAvSNTable_SN
          end>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.CopyCaptionsToClipboard = False
        OptionsBehavior.IncSearch = True
        OptionsBehavior.CopyPreviewToClipboard = False
        OptionsBehavior.PullFocusing = True
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnMoving = False
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsSelection.MultiSelect = True
        OptionsSelection.InvertSelect = False
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
        OptionsView.ScrollBars = ssVertical
        OptionsView.ColumnAutoWidth = True
        OptionsView.Footer = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GridLines = glHorizontal
        OptionsView.GroupByBox = False
        Styles.Header = dmAdditions.cxStyle_GridHeader
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        object cxGridAvSNTable_IMG: TcxGridColumn
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.DefaultImageIndex = 31
          Properties.Images = dmAdditions.cxImageList_SWN
          Properties.Items = <>
          MinWidth = 24
          Options.IncSearch = False
          Options.ShowEditButtons = isebNever
          Options.HorzSizing = False
          Width = 24
        end
        object cxGridAvSNTable_SN: TcxGridColumn
          Caption = #1057#1077#1088#1080#1081#1085#1099#1081' '#1085#1086#1084#1077#1088
          FooterAlignmentHorz = taRightJustify
          SortIndex = 0
          SortOrder = soAscending
        end
      end
      object cxGridAvSNDB: TcxGridDBTableView
        OnDblClick = cxGridAvSNDBDblClick
        OnKeyDown = cxGridAvSNTableKeyDown
        Navigator.Buttons.CustomButtons = <>
        FindPanel.ApplyInputDelay = 300
        FindPanel.FocusViewOnApplyFilter = True
        ScrollbarAnnotations.CustomAnnotations = <>
        DataController.DataSource = IBCDS_AvSN
        DataController.KeyFieldNames = 'SN'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.IncSearch = True
        OptionsBehavior.IncSearchItem = cxGridAvSNDB_SN
        OptionsBehavior.ImmediateEditor = False
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.HideFocusRectOnExit = False
        OptionsSelection.InvertSelect = False
        OptionsView.ColumnAutoWidth = True
        OptionsView.GroupByBox = False
        Styles.Content = dmAdditions.cxStyle_SN
        object cxGridAvSNDB_IMG: TcxGridDBColumn
          DataBinding.IsNullValueType = True
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.DefaultImageIndex = 31
          Properties.Images = dmAdditions.cxImageList_SWN
          Properties.Items = <>
          MinWidth = 24
          Options.Editing = False
          Options.Filtering = False
          Options.Focusing = False
          Options.IgnoreTimeForFiltering = False
          Options.IncSearch = False
          Options.FilteringFilteredItemsList = False
          Options.FilteringMRUItemsList = False
          Options.FilteringPopup = False
          Options.FilteringPopupMultiSelect = False
          Options.GroupFooters = False
          Options.Grouping = False
          Options.HorzSizing = False
          Options.Moving = False
          Options.ShowCaption = False
          Options.Sorting = False
          Width = 24
        end
        object cxGridAvSNDB_SN: TcxGridDBColumn
          Caption = 'Seriile accesibile'
          DataBinding.FieldName = 'SN'
          DataBinding.IsNullValueType = True
        end
      end
      object cxGridAvSNLevel: TcxGridLevel
        GridView = cxGridAvSNDB
      end
    end
    object edGOODSID: TcxDBTextEdit
      Left = 101
      Top = 16
      TabStop = False
      DataBinding.DataField = 'GOODSID'
      Properties.ReadOnly = True
      TabOrder = 0
      Width = 52
    end
    object edQuickSearchAv: TEdit
      Left = 104
      Top = 453
      Width = 198
      Height = 23
      CharCase = ecUpperCase
      TabOrder = 5
      OnChange = edQuickSearchAvChange
      OnKeyDown = edQuickSearchAvKeyDown
    end
    object cxGrid1: TcxGrid
      Left = 358
      Top = 56
      Width = 503
      Height = 369
      TabOrder = 4
      object cxGrid1DBSN: TcxGridDBTableView
        OnDblClick = cxGrid1DBSNDblClick
        OnKeyDown = cxGrid1DBSNKeyDown
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        DataController.DataSource = IBCDS_SN
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        DataController.OnDataChanged = cxGrid1DBSNDataControllerDataChanged
        OptionsBehavior.IncSearch = True
        OptionsBehavior.IncSearchItem = cxGrid1DBSN_SN
        OptionsBehavior.ImmediateEditor = False
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.HideFocusRectOnExit = False
        OptionsSelection.InvertSelect = False
        OptionsView.ColumnAutoWidth = True
        OptionsView.GroupByBox = False
        object cxGrid1DBSN_IMG: TcxGridDBColumn
          DataBinding.IsNullValueType = True
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.DefaultImageIndex = 31
          Properties.Images = dmAdditions.cxImageList_SWN
          Properties.Items = <>
          MinWidth = 24
          Options.Editing = False
          Options.Filtering = False
          Options.Focusing = False
          Options.IgnoreTimeForFiltering = False
          Options.IncSearch = False
          Options.FilteringFilteredItemsList = False
          Options.FilteringMRUItemsList = False
          Options.FilteringPopup = False
          Options.FilteringPopupMultiSelect = False
          Options.GroupFooters = False
          Options.Grouping = False
          Options.HorzSizing = False
          Options.Moving = False
          Options.ShowCaption = False
          Options.Sorting = False
          Width = 24
        end
        object cxGrid1DBSN_SN: TcxGridDBColumn
          DataBinding.FieldName = 'SN'
          DataBinding.IsNullValueType = True
          Styles.Content = dmAdditions.cxStyle_SN
          Width = 239
          IsCaptionAssigned = True
        end
        object cxGrid1DBSN_CREATED_BY_NAME: TcxGridDBColumn
          Caption = 'Operator'
          DataBinding.FieldName = 'CREATED_BY_NAME'
          DataBinding.IsNullValueType = True
          Styles.Content = dmAdditions.cxStyle_TextGray
          Width = 124
        end
        object cxGrid1DBSN_CREATED_DATE: TcxGridDBColumn
          Caption = 'Data'
          DataBinding.FieldName = 'CREATED_DATE'
          DataBinding.IsNullValueType = True
          Styles.Content = dmAdditions.cxStyle_TextGray
          Width = 114
        end
      end
      object cxGrid1Level1: TcxGridLevel
        GridView = cxGrid1DBSN
      end
    end
  end
  object cxDBMemo1: TcxDBMemo
    Left = 368
    Top = 505
    DataBinding.DataField = 'COMMENTS'
    DataBinding.DataSource = IBCDS_SN_COMMENTS
    TabOrder = 2
    OnEnter = cxDBMemo1Enter
    OnExit = cxDBMemo1Exit
    Height = 45
    Width = 503
  end
  object btnOk: TcxButton
    Left = 677
    Top = 582
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    TabOrder = 3
    OnClick = btnOkClick
  end
  object btnCancel: TcxButton
    Left = 781
    Top = 582
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 4
  end
  object IBCDS_SN: TIBCDataSource
    DataSet = IBC_SN
    Left = 412
    Top = 180
  end
  object IBC_SN: TIBCQuery
    KeyFields = 'DOCID;DTDEP;CTDEP;GOODSCOMPLECT_ID;GOODSID'
    SQLInsert.Strings = (
      'INSERT INTO VW_TDB_SN'
      
        '  (DOCID, DTDEP, DTDEP_NAME, CTDEP, CTDEP_NAME, GOODSCOMPLECT_ID' +
        ', GOODSCOMPLECT_ID_NAME, GOODSID, GOODS_NAME, SN, COMPLECT_SN, V' +
        'ENDORWARRANTY, OWNWARRANTY, SUMA_ACCIZE, CREATED_BY, CREATED_BY_' +
        'NAME, COUNTRYID, COUNTRY_TITLE, VENDORID, VENDOR_TITLE, CREATED_' +
        'DATE)'
      'VALUES'
      
        '  (:DOCID, :DTDEP, :DTDEP_NAME, :CTDEP, :CTDEP_NAME, :GOODSCOMPL' +
        'ECT_ID, :GOODSCOMPLECT_ID_NAME, :GOODSID, :GOODS_NAME, :SN, :COM' +
        'PLECT_SN, :VENDORWARRANTY, :OWNWARRANTY, :SUMA_ACCIZE, :CREATED_' +
        'BY, :CREATED_BY_NAME, :COUNTRYID, :COUNTRY_TITLE, :VENDORID, :VE' +
        'NDOR_TITLE, :CREATED_DATE)')
    SQLDelete.Strings = (
      'DELETE FROM VW_TDB_SN'
      'WHERE'
      
        '  DOCID = :Old_DOCID AND DTDEP = :Old_DTDEP AND CTDEP = :Old_CTD' +
        'EP AND GOODSCOMPLECT_ID = :Old_GOODSCOMPLECT_ID AND GOODSID = :O' +
        'ld_GOODSID AND SN = :Old_SN')
    SQLUpdate.Strings = (
      'UPDATE VW_TDB_SN'
      'SET'
      
        '  DOCID = :DOCID, DTDEP = :DTDEP, DTDEP_NAME = :DTDEP_NAME, CTDE' +
        'P = :CTDEP, CTDEP_NAME = :CTDEP_NAME, GOODSCOMPLECT_ID = :GOODSC' +
        'OMPLECT_ID, GOODSCOMPLECT_ID_NAME = :GOODSCOMPLECT_ID_NAME, GOOD' +
        'SID = :GOODSID, GOODS_NAME = :GOODS_NAME, SN = :SN, COMPLECT_SN ' +
        '= :COMPLECT_SN, VENDORWARRANTY = :VENDORWARRANTY, OWNWARRANTY = ' +
        ':OWNWARRANTY, SUMA_ACCIZE = :SUMA_ACCIZE, CREATED_BY = :CREATED_' +
        'BY, CREATED_BY_NAME = :CREATED_BY_NAME, COUNTRYID = :COUNTRYID, ' +
        'COUNTRY_TITLE = :COUNTRY_TITLE, VENDORID = :VENDORID, VENDOR_TIT' +
        'LE = :VENDOR_TITLE, CREATED_DATE = :CREATED_DATE'
      'WHERE'
      
        '  DOCID = :Old_DOCID AND DTDEP = :Old_DTDEP AND CTDEP = :Old_CTD' +
        'EP AND GOODSCOMPLECT_ID = :Old_GOODSCOMPLECT_ID AND GOODSID = :O' +
        'ld_GOODSID AND SN = :Old_SN')
    SQLRefresh.Strings = (
      
        'SELECT DOCID, DTDEP, DTDEP_NAME, CTDEP, CTDEP_NAME, GOODSCOMPLEC' +
        'T_ID, GOODSCOMPLECT_ID_NAME, GOODSID, GOODS_NAME, SN, COMPLECT_S' +
        'N, VENDORWARRANTY, OWNWARRANTY, SUMA_ACCIZE, CREATED_BY, CREATED' +
        '_BY_NAME, COUNTRYID, COUNTRY_TITLE, VENDORID, VENDOR_TITLE, CREA' +
        'TED_DATE FROM VW_TDB_SN'
      'WHERE'
      
        '  DOCID = :P_1_Old_DOCID AND DTDEP = :P_1_Old_DTDEP AND CTDEP = ' +
        ':P_1_Old_CTDEP AND GOODSCOMPLECT_ID = :P_1_Old_GOODSCOMPLECT_ID ' +
        'AND GOODSID = :P_1_Old_GOODSID AND SN = :Old_SN')
    SQLLock.Strings = (
      'SELECT NULL FROM VW_TDB_SN'
      'WHERE'
      
        'DOCID = :Old_DOCID AND DTDEP = :Old_DTDEP AND CTDEP = :Old_CTDEP' +
        ' AND GOODSCOMPLECT_ID = :Old_GOODSCOMPLECT_ID AND GOODSID = :Old' +
        '_GOODSID AND SN = :Old_SN'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultUpdate
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'SELECT * FROM VW_TDB_SN')
    MasterFields = 'DOCID;DTDEP;CTDEP;GOODSCOMPLECT_ID;GOODSID'
    DetailFields = 'DOCID;DTDEP;CTDEP;GOODSCOMPLECT_ID;GOODSID'
    MasterSource = dmDB.IBCDataSourceJurnal
    CachedUpdates = True
    AutoCommit = False
    Options.RequiredFields = False
    LocalConstraints = False
    Left = 526
    Top = 179
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DOCID'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'DTDEP'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'CTDEP'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'GOODSCOMPLECT_ID'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'GOODSID'
        Value = nil
      end>
  end
  object IBC_SN_COMMENTS: TIBCQuery
    KeyFields = 'SN'
    SQLInsert.Strings = (
      'INSERT INTO TDB_SN_COMMENTS'
      
        '  (DOCID, DTDEP, CTDEP, GOODSCOMPLECT_ID, GOODSID, SN, COMMENTS,' +
        ' CREATED_BY)'
      'VALUES'
      
        '  (:DOCID, :DTDEP, :CTDEP, :GOODSCOMPLECT_ID, :GOODSID, :SN, :CO' +
        'MMENTS, :CREATED_BY)')
    SQLDelete.Strings = (
      'DELETE FROM TDB_SN_COMMENTS'
      'WHERE'
      
        '  DOCID = :Old_DOCID AND DTDEP = :Old_DTDEP AND CTDEP = :Old_CTD' +
        'EP AND GOODSCOMPLECT_ID = :Old_GOODSCOMPLECT_ID AND GOODSID = :O' +
        'ld_GOODSID AND SN = :Old_SN')
    SQLUpdate.Strings = (
      'UPDATE TDB_SN_COMMENTS'
      'SET'
      
        '  DOCID = :DOCID, DTDEP = :DTDEP, CTDEP = :CTDEP, GOODSCOMPLECT_' +
        'ID = :GOODSCOMPLECT_ID, GOODSID = :GOODSID, SN = :SN, COMMENTS =' +
        ' :COMMENTS, CREATED_BY = :CREATED_BY'
      'WHERE'
      
        '  DOCID = :Old_DOCID AND DTDEP = :Old_DTDEP AND CTDEP = :Old_CTD' +
        'EP AND GOODSCOMPLECT_ID = :Old_GOODSCOMPLECT_ID AND GOODSID = :O' +
        'ld_GOODSID AND SN = :Old_SN')
    SQLRefresh.Strings = (
      
        'SELECT DOCID, DTDEP, CTDEP, GOODSCOMPLECT_ID, GOODSID, SN, COMME' +
        'NTS, CREATED_BY FROM TDB_SN_COMMENTS'
      'WHERE'
      
        '  DOCID = :P_1_DOCID AND DTDEP = :P_1_DTDEP AND CTDEP = :P_1_CTD' +
        'EP AND GOODSCOMPLECT_ID = :P_1_GOODSCOMPLECT_ID AND GOODSID = :P' +
        '_1_GOODSID AND SN = :SN')
    SQLLock.Strings = (
      'SELECT NULL FROM TDB_SN_COMMENTS'
      'WHERE'
      
        'DOCID = :Old_DOCID AND DTDEP = :Old_DTDEP AND CTDEP = :Old_CTDEP' +
        ' AND GOODSCOMPLECT_ID = :Old_GOODSCOMPLECT_ID AND GOODSID = :Old' +
        '_GOODSID AND SN = :Old_SN'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'SELECT * FROM TDB_SN_COMMENTS')
    MasterFields = 'DOCID;DTDEP;CTDEP;GOODSCOMPLECT_ID;GOODSID;SN'
    DetailFields = 'DOCID;DTDEP;CTDEP;GOODSCOMPLECT_ID;GOODSID;SN'
    MasterSource = IBCDS_SN
    CachedUpdates = True
    AutoCommit = False
    Options.RequiredFields = False
    LocalConstraints = False
    Left = 526
    Top = 232
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DOCID'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'DTDEP'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'CTDEP'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'GOODSCOMPLECT_ID'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'GOODSID'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'SN'
        Value = nil
      end>
  end
  object IBCDS_SN_COMMENTS: TIBCDataSource
    DataSet = IBC_SN_COMMENTS
    Left = 404
    Top = 232
  end
  object IBC_AvSN: TIBCQuery
    KeyFields = 'SN'
    SQLInsert.Strings = (
      'INSERT INTO TMP_SN'
      '  (SN, COUNTRYID, VENDORID)'
      'VALUES'
      '  (:SN, :COUNTRYID, :VENDORID)')
    SQLDelete.Strings = (
      'DELETE FROM TMP_SN'
      'WHERE'
      '  SN = :Old_SN')
    SQLRefresh.Strings = (
      'SELECT SN, COUNTRYID, VENDORID FROM TMP_SN'
      'WHERE'
      '  SN = :SN')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultUpdate
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'SELECT * FROM TMP_SN')
    AutoCommit = False
    Left = 160
    Top = 184
  end
  object IBCDS_AvSN: TIBCDataSource
    DataSet = IBC_AvSN
    Left = 80
    Top = 184
  end
  object ActionList1: TActionList
    Left = 336
    Top = 8
    object actAddSerialNumber: TAction
      Caption = '>'
      ShortCut = 16397
      OnExecute = actAddSerialNumberExecute
    end
    object actRemoveSerialNumber: TAction
      Caption = '<'
      ShortCut = 16466
      OnExecute = actRemoveSerialNumberExecute
    end
  end
end
