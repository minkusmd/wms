object frmSerialNumbersDlg: TfrmSerialNumbersDlg
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Numere de serii'
  ClientHeight = 587
  ClientWidth = 909
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  DesignSize = (
    909
    587)
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 909
    Height = 64
    Title = 'Numere de serii'
    Text = 'Gestionarea numerilor de serii'
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
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 893
    Height = 458
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 1
    Align = alTop
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    object lbInfo: TLabel
      AlignWithMargins = True
      Left = 8
      Top = 428
      Width = 873
      Height = 18
      Margins.Left = 8
      Margins.Top = 8
      Margins.Right = 8
      Margins.Bottom = 8
      Align = alBottom
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
      Transparent = False
      Layout = tlCenter
      ExplicitLeft = -35
      ExplicitTop = 417
      ExplicitWidth = 656
    end
    object pnGoods: TPanel
      Left = 0
      Top = 0
      Width = 889
      Height = 47
      Align = alTop
      BevelOuter = bvNone
      Color = clWindow
      ParentBackground = False
      TabOrder = 0
      object cxLabel1: TLabel
        Left = 12
        Top = 15
        Width = 58
        Height = 15
        Caption = 'Denumirea'
        Transparent = True
      end
      object cxLabel2: TLabel
        Left = 802
        Top = 15
        Width = 25
        Height = 15
        Caption = 'Cant'
        Transparent = True
      end
      object edQTY: TcxDBTextEdit
        Left = 833
        Top = 12
        TabStop = False
        DataBinding.DataField = 'QTY'
        ParentFont = False
        Properties.ReadOnly = True
        Style.TextStyle = [fsBold]
        TabOrder = 2
        Width = 46
      end
      object edGOODSID: TcxDBTextEdit
        Left = 101
        Top = 12
        TabStop = False
        DataBinding.DataField = 'GOODSID'
        ParentFont = False
        Properties.ReadOnly = True
        TabOrder = 0
        Width = 56
      end
      object edGOODS_NAME: TcxDBTextEdit
        Left = 159
        Top = 12
        TabStop = False
        DataBinding.DataField = 'GOODS_NAME'
        ParentFont = False
        Properties.ReadOnly = True
        TabOrder = 1
        Width = 586
      end
    end
    object dxBarDockControl1: TdxBarDockControl
      AlignWithMargins = True
      Left = 8
      Top = 47
      Width = 873
      Height = 30
      Margins.Left = 8
      Margins.Top = 0
      Margins.Right = 8
      Margins.Bottom = 0
      Align = dalTop
      BarManager = dxBarManager
      SunkenBorder = True
      UseOwnSunkenBorder = True
    end
    object cxGridSerials: TcxGrid
      AlignWithMargins = True
      Left = 8
      Top = 77
      Width = 873
      Height = 343
      Margins.Left = 8
      Margins.Top = 0
      Margins.Right = 8
      Margins.Bottom = 0
      Align = alClient
      TabOrder = 2
      object cxGridSerialsTable: TcxGridDBTableView
        PopupMenu = pmPopupMenu
        OnKeyDown = cxGridSerialsTableKeyDown
        Navigator.Buttons.CustomButtons = <>
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
        ScrollbarAnnotations.CustomAnnotations = <>
        OnCellDblClick = cxGridSerialsTableCellDblClick
        OnFocusedRecordChanged = cxGridSerialsTableFocusedRecordChanged
        DataController.DataSource = IBCDataSourceSN
        DataController.KeyFieldNames = 'DOCID;DTDEP;CTDEP;GOODSCOMPLECT_ID;GOODSID;SN'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <
          item
            Format = '0'
            Kind = skCount
            FieldName = 'SN'
            Column = cxGridSerialsTable_SN
            DisplayText = 'Total: '
          end>
        DataController.Summary.SummaryGroups = <>
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnMoving = False
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.InvertSelect = False
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
        OptionsView.ScrollBars = ssVertical
        OptionsView.ShowEditButtons = gsebForFocusedRecord
        OptionsView.ColumnAutoWidth = True
        OptionsView.Footer = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        Styles.ContentEven = dmAdditions.cxStyle_GridContentEven
        Styles.Header = dmAdditions.cxStyle_GridHeader
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        object cxGridSerialsTable_IMG: TcxGridDBColumn
          DataBinding.IsNullValueType = True
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.DefaultImageIndex = 31
          Properties.Images = dmAdditions.cxImageList_SWN
          Properties.Items = <>
          MinWidth = 24
          Options.Filtering = False
          Options.Focusing = False
          Options.IncSearch = False
          Options.ShowEditButtons = isebNever
          Options.HorzSizing = False
          Options.Moving = False
          Options.ShowCaption = False
          Options.Sorting = False
          Width = 24
        end
        object cxGridSerialsTable_SN: TcxGridDBColumn
          Caption = 'Numar de serie'
          DataBinding.FieldName = 'SN'
          DataBinding.IsNullValueType = True
          Width = 150
        end
        object cxGridSerialsTable_VENDORWARRANTY: TcxGridDBColumn
          Caption = 'Garant. furnizor'
          DataBinding.FieldName = 'VENDORWARRANTY'
          DataBinding.IsNullValueType = True
          HeaderAlignmentHorz = taCenter
          MinWidth = 80
          Options.Filtering = False
          Options.HorzSizing = False
          Width = 80
        end
        object cxGridSerialsTable_OWNWARRANTY: TcxGridDBColumn
          Caption = 'Garant. vinz'
          DataBinding.FieldName = 'OWNWARRANTY'
          DataBinding.IsNullValueType = True
          HeaderAlignmentHorz = taCenter
          MinWidth = 100
          Options.Filtering = False
          Options.HorzSizing = False
          Width = 100
        end
        object cxGridSerialsTable_SUMA_ACCIZE: TcxGridDBColumn
          Caption = 'Suma accize'
          DataBinding.FieldName = 'SUMA_ACCIZE'
          DataBinding.IsNullValueType = True
          HeaderAlignmentHorz = taCenter
          MinWidth = 80
          Options.HorzSizing = False
          Width = 80
        end
        object cxGridSerials_COUNTRY_TITLE: TcxGridDBColumn
          Caption = 'Tara'
          DataBinding.FieldName = 'COUNTRY_TITLE'
          DataBinding.IsNullValueType = True
          HeaderAlignmentHorz = taCenter
          MinWidth = 75
          Options.HorzSizing = False
          Width = 75
        end
        object cxGridSerials_VENDOR_TITLE: TcxGridDBColumn
          Caption = 'Producator'
          DataBinding.FieldName = 'VENDOR_TITLE'
          DataBinding.IsNullValueType = True
          HeaderAlignmentHorz = taCenter
          MinWidth = 85
          Options.HorzSizing = False
          Width = 85
        end
        object cxGridSerials_CREATED_BY_NAME: TcxGridDBColumn
          Caption = 'Creat de'
          DataBinding.FieldName = 'CREATED_BY_NAME'
          DataBinding.IsNullValueType = True
          HeaderAlignmentHorz = taCenter
          MinWidth = 100
          Options.HorzSizing = False
          Width = 100
        end
        object cxGridSerials_CREATED_DATE: TcxGridDBColumn
          Caption = 'Data'
          DataBinding.FieldName = 'CREATED_DATE'
          DataBinding.IsNullValueType = True
          OnGetDisplayText = cxGridSerials_CREATED_DATEGetDisplayText
          HeaderAlignmentHorz = taCenter
          MinWidth = 100
          Options.ShowEditButtons = isebNever
          Options.HorzSizing = False
          Width = 100
        end
      end
      object cxGridSerialsLevel: TcxGridLevel
        GridView = cxGridSerialsTable
      end
    end
  end
  object btnOk: TcxButton
    Left = 695
    Top = 543
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TcxButton
    Left = 799
    Top = 543
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
  object dxBarManager: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'General'
      'Tools')
    Categories.ItemsVisibles = (
      2
      2)
    Categories.Visibles = (
      True
      True)
    ImageOptions.Images = dmAdditions.cxImageList_SWN
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 412
    Top = 252
    PixelsPerInch = 96
    object dxBarManagerBar1: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 3
      FloatTop = 386
      FloatClientWidth = 110
      FloatClientHeight = 79
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbNewSerial'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbScanner'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbGenerateKitSerials'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbModifySerial'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbRemoveSerial'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbCopy'
        end
        item
          Visible = True
          ItemName = 'bbPaste'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'dxBarButton3'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object bbNewSerial: TdxBarButton
      Caption = 'Nou'
      Category = 0
      Hint = #1053#1086#1074#1099#1081' '#1089#1077#1088#1080#1081#1085#1099#1081' '#1085#1086#1084#1077#1088
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 45
      OnClick = bbNewSerialClick
    end
    object bbModifySerial: TdxBarButton
      Caption = 'Modifica'
      Category = 0
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 115
      OnClick = bbModifySerialClick
    end
    object bbRemoveSerial: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      ShortCut = 46
      OnClick = bbRemoveSerialClick
    end
    object bbScanner: TdxBarButton
      Caption = 'Scanner'
      Category = 0
      Hint = #1053#1086#1074#1099#1077' '#1089#1077#1088#1080#1081#1085#1099#1077' '#1085#1086#1084#1077#1088#1072' '#1089#1086' '#1089#1082#1072#1085#1085#1077#1088#1072
      Visible = ivAlways
      ImageIndex = 30
      OnClick = bbScannerClick
    end
    object bbPaste: TdxBarButton
      Caption = 'Paste'
      Category = 0
      Hint = #1042#1089#1090#1072#1074#1080#1090#1100' '#1080#1079' '#1073#1091#1092#1077#1088#1072
      Visible = ivAlways
      ImageIndex = 24
      ShortCut = 16470
      OnClick = bbPasteClick
    end
    object bbCopy: TdxBarButton
      Caption = 'Copy'
      Category = 0
      Hint = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1074' '#1073#1091#1092#1077#1088
      Visible = ivAlways
      ImageIndex = 29
      ShortCut = 16451
      OnClick = bbCopyClick
    end
    object bbGenerateKitSerials: TdxBarButton
      Caption = 'Serii pentru asamblare'
      Category = 0
      Hint = 'Serii pentru asamblare'
      Visible = ivNever
      ImageIndex = 31
      OnClick = bbGenerateKitSerialsClick
    end
    object bsubTools: TdxBarSubItem
      Caption = 'Suplimentar'
      Category = 1
      Visible = ivAlways
      ItemLinks = <>
    end
    object dxBarButton3: TdxBarButton
      Caption = 'Exporta numere de serii'
      Category = 1
      Hint = 'Exporta numere de serii'
      Visible = ivAlways
      ImageIndex = 32
      OnClick = dxBarButton3Click
    end
  end
  object IBCDataSourceSN: TIBCDataSource
    DataSet = IBCQuerySN
    Left = 148
    Top = 232
  end
  object pmPopupMenu: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbNewSerial'
      end
      item
        Visible = True
        ItemName = 'bbModifySerial'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbRemoveSerial'
      end>
    UseOwnFont = False
    Left = 292
    Top = 256
    PixelsPerInch = 96
  end
  object IBCQuerySN: TIBCQuery
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
      
        '  DOCID = :DOCID AND DTDEP = :DTDEP AND CTDEP = :CTDEP AND GOODS' +
        'COMPLECT_ID = :GOODSCOMPLECT_ID AND GOODSID = :GOODSID AND SN = ' +
        ':SN')
    SQLLock.Strings = (
      'SELECT NULL FROM VW_TDB_SN'
      'WHERE'
      
        'DOCID = :Old_DOCID AND DTDEP = :Old_DTDEP AND CTDEP = :Old_CTDEP' +
        ' AND GOODSCOMPLECT_ID = :Old_GOODSCOMPLECT_ID AND GOODSID = :Old' +
        '_GOODSID AND SN = :Old_SN'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM VW_TDB_SN'
      ''
      ') q')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      'SELECT * FROM VW_TDB_SN')
    MasterFields = 'DOCID;DTDEP;CTDEP;GOODSCOMPLECT_ID;GOODSID'
    DetailFields = 'DOCID;DTDEP;CTDEP;GOODSCOMPLECT_ID;GOODSID'
    Left = 144
    Top = 296
  end
end
