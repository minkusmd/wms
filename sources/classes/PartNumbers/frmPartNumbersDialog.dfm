object frmPartNumbersDlg: TfrmPartNumbersDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1094#1080#1103' '#1087#1072#1088#1090#1080#1081
  ClientHeight = 587
  ClientWidth = 1011
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  DesignSize = (
    1011
    587)
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 1011
    Height = 64
    Title = #1055#1072#1088#1090#1080#1080
    Text = #1059#1087#1088#1072#1074#1083#1077#1085#1080#1077' '#1087#1072#1088#1090#1080#1103#1084#1080
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
    Width = 995
    Height = 458
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 1
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    object lbInfo: TLabel
      AlignWithMargins = True
      Left = 8
      Top = 428
      Width = 975
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
      ExplicitLeft = 6
      ExplicitWidth = 873
    end
    object dxBarDockControl1: TdxBarDockControl
      AlignWithMargins = True
      Left = 8
      Top = 47
      Width = 975
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
    object cxGridParts: TcxGrid
      AlignWithMargins = True
      Left = 8
      Top = 78
      Width = 975
      Height = 342
      Margins.Left = 8
      Margins.Top = 1
      Margins.Right = 8
      Margins.Bottom = 0
      Align = alClient
      TabOrder = 2
      object cxGridPartsTable: TcxGridDBTableView
        OnKeyDown = cxGridPartsTableKeyDown
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
        OnCellDblClick = cxGridPartsTableCellDblClick
        OnFocusedRecordChanged = cxGridPartsTableFocusedRecordChanged
        DataController.DataSource = IBCDataSourceParts
        DataController.KeyFieldNames = 'DOCID;DTDEP;CTDEP;GOODSCOMPLECT_ID;GOODSID;PARTNO;COMPLECT_SN'
        DataController.Summary.FooterSummaryItems = <
          item
            Format = '0'
            Kind = skSum
            FieldName = 'QTY'
            Column = cxGridParts_QTY
          end
          item
            Format = '0'
            Kind = skCount
            Column = cxGridParts_PARTNO
          end>
        OptionsBehavior.ImmediateEditor = False
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnHorzSizing = False
        OptionsCustomize.ColumnMoving = False
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
        OptionsView.ScrollBars = ssVertical
        OptionsView.ShowEditButtons = gsebForFocusedRecord
        OptionsView.ColumnAutoWidth = True
        OptionsView.Footer = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        OptionsView.HeaderHeight = 40
        OptionsView.Indicator = True
        Styles.Footer = dmAdditions.cxStyle_GridHeader
        Styles.Header = dmAdditions.cxStyle_GridHeader
        object cxGridParts_IMG: TcxGridDBColumn
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.DefaultImageIndex = 31
          Properties.Images = dmAdditions.cxImageList_SWN
          Properties.Items = <>
          MinWidth = 24
          Options.Filtering = False
          Options.Focusing = False
          Options.ShowEditButtons = isebNever
          Options.Grouping = False
          Options.HorzSizing = False
          Options.Moving = False
          Options.Sorting = False
          Width = 24
        end
        object cxGridParts_PARTNO: TcxGridDBColumn
          Caption = #1055#1072#1088#1090#1080#1103
          DataBinding.FieldName = 'PARTNO'
          MinWidth = 120
          Width = 120
        end
        object cxGridParts_QTY: TcxGridDBColumn
          Caption = #1050#1086#1083'-'#1074#1086
          DataBinding.FieldName = 'QTY'
          PropertiesClassName = 'TcxCalcEditProperties'
          HeaderAlignmentHorz = taCenter
          MinWidth = 80
          Options.ShowEditButtons = isebNever
          Options.HorzSizing = False
          Width = 80
        end
        object cxGridParts_EXPIRATION_DATE: TcxGridDBColumn
          Caption = #1057#1088#1086#1082' '#1075#1086#1076#1085#1086#1089#1090#1080
          DataBinding.FieldName = 'EXPIRATION_DATE'
          PropertiesClassName = 'TcxDateEditProperties'
        end
        object cxGridParts_VENDORWARRANTY: TcxGridDBColumn
          Caption = #1043#1072#1088#1072#1085#1090#1080#1103' '#1087#1086#1089#1090#1072#1074#1097#1080#1082#1072
          DataBinding.FieldName = 'VENDORWARRANTY'
          HeaderAlignmentHorz = taCenter
          MinWidth = 80
          Options.HorzSizing = False
          Width = 80
        end
        object cxGridParts_OWNWARRANTY: TcxGridDBColumn
          Caption = #1043#1072#1088#1072#1085#1090#1080#1103' '#1087#1088#1086#1076#1072#1074#1094#1072
          DataBinding.FieldName = 'OWNWARRANTY'
          HeaderAlignmentHorz = taCenter
          MinWidth = 90
          Options.HorzSizing = False
          Width = 90
        end
        object cxGridPartsTable_SUMA_ACCIZE: TcxGridDBColumn
          Caption = #1057#1091#1084#1084#1072' '#1072#1082#1094#1080#1079#1086#1074
          DataBinding.FieldName = 'SUMA_ACCIZE'
          Visible = False
          HeaderAlignmentHorz = taCenter
          MinWidth = 80
          Options.HorzSizing = False
          Width = 80
        end
        object cxGridParts_COUNTRY_TITLE: TcxGridDBColumn
          Caption = #1057#1090#1088#1072#1085#1072' '#1087#1088#1086#1080#1089#1093#1086#1078#1076#1077#1085#1080#1103
          DataBinding.FieldName = 'COUNTRY_TITLE'
          HeaderAlignmentHorz = taCenter
          MinWidth = 100
          Options.HorzSizing = False
          Width = 100
        end
        object cxGridParts_VENDOR_TITLE: TcxGridDBColumn
          Caption = #1055#1088#1086#1080#1079#1074#1086#1076#1080#1090#1077#1083#1100
          DataBinding.FieldName = 'VENDOR_TITLE'
          HeaderAlignmentHorz = taCenter
          MinWidth = 100
          Options.HorzSizing = False
          Width = 100
        end
        object cxGridParts_CREATED_BY_NAME: TcxGridDBColumn
          Caption = #1057#1086#1079#1076#1072#1085
          DataBinding.FieldName = 'CREATED_BY_NAME'
          HeaderAlignmentHorz = taCenter
          MinWidth = 120
          Options.HorzSizing = False
          Width = 120
        end
      end
      object cxGridPartsLevel: TcxGridLevel
        GridView = cxGridPartsTable
      end
    end
    object pnTop: TPanel
      Left = 0
      Top = 0
      Width = 991
      Height = 47
      Align = alTop
      BevelOuter = bvNone
      Color = clWindow
      ParentBackground = False
      TabOrder = 0
      object cxLabel1: TLabel
        Left = 8
        Top = 15
        Width = 33
        Height = 15
        Caption = #1058#1086#1074#1072#1088
        Transparent = True
      end
      object cxLabel2: TLabel
        Left = 721
        Top = 15
        Width = 38
        Height = 15
        Caption = #1082#1086#1083'-'#1074#1086
        Transparent = True
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
        Width = 546
      end
      object edGOODS_QTY: TcxDBCalcEdit
        Left = 766
        Top = 12
        DataBinding.DataField = 'QTY'
        ParentFont = False
        Properties.Alignment.Horz = taLeftJustify
        Properties.ReadOnly = True
        Style.TextStyle = [fsBold]
        TabOrder = 2
        Width = 113
      end
    end
  end
  object btnOk: TcxButton
    Left = 797
    Top = 543
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = '&OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TcxButton
    Left = 903
    Top = 543
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
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
      #1054#1073#1097#1080#1077
      #1048#1085#1089#1090#1088#1091#1084#1077#1085#1090#1099)
    Categories.ItemsVisibles = (
      2
      2)
    Categories.Visibles = (
      True
      True)
    ImageOptions.Images = dmAdditions.cxImageList_SWN
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 276
    Top = 216
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
          ItemName = 'bbNewPartNo'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton1'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbModifyPartNo'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbRemovePartNo'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object bbNewPartNo: TdxBarButton
      Caption = #1053#1086#1074#1099#1081
      Category = 0
      Hint = #1053#1086#1074#1099#1081' '#1089#1077#1088#1080#1081#1085#1099#1081' '#1085#1086#1084#1077#1088
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 45
      OnClick = bbNewPartNoClick
    end
    object bbModifyPartNo: TdxBarButton
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      Category = 0
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 115
      OnClick = bbModifyPartNoClick
    end
    object bbRemovePartNo: TdxBarButton
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Category = 0
      Hint = #1059#1076#1072#1083#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 42
      ShortCut = 46
      OnClick = bbRemovePartNoClick
    end
    object dxBarButton1: TdxBarButton
      Caption = #1057#1082#1072#1085#1080#1088#1086#1074#1072#1090#1100
      Category = 0
      Hint = #1057#1082#1072#1085#1080#1088#1086#1074#1072#1090#1100
      Visible = ivAlways
      ShortCut = 16429
      OnClick = dxBarButton1Click
    end
  end
  object IBCQueryParts: TIBCQuery
    KeyFields = 'DOCID;DTDEP;CTDEP;GOODSCOMPLECT_ID;GOODSID;PARTNO;COMPLECT_SN'
    SQLInsert.Strings = (
      'INSERT INTO VW_TDB_PARTS'
      
        '  (DOCID, DTDEP, CTDEP, GOODSCOMPLECT_ID, GOODSID, PARTNO, COMPL' +
        'ECT_SN, QTY, CREATED_BY, VENDORWARRANTY, '
      
        '   OWNWARRANTY, SUMA_ACCIZE, COUNTRYID, VENDORID, VALID_UNTIL_DA' +
        'TE)'
      'VALUES'
      
        '  (:DOCID, :DTDEP, :CTDEP, :GOODSCOMPLECT_ID, :GOODSID, :PARTNO,' +
        ' :COMPLECT_SN, :QTY, :CREATED_BY, :VENDORWARRANTY, '
      
        '   :OWNWARRANTY, :SUMA_ACCIZE, :COUNTRYID, :VENDORID, :VALID_UNT' +
        'IL_DATE)')
    SQLDelete.Strings = (
      'DELETE FROM VW_TDB_PARTS'
      'WHERE'
      
        '  DOCID = :Old_DOCID AND DTDEP = :Old_DTDEP AND CTDEP = :Old_CTD' +
        'EP AND GOODSCOMPLECT_ID = :Old_GOODSCOMPLECT_ID AND GOODSID = :O' +
        'ld_GOODSID AND PARTNO = :Old_PARTNO AND COMPLECT_SN = :Old_COMPL' +
        'ECT_SN')
    SQLUpdate.Strings = (
      'UPDATE VW_TDB_PARTS'
      'SET'
      
        '  DOCID = :DOCID, DTDEP = :DTDEP, CTDEP = :CTDEP, GOODSCOMPLECT_' +
        'ID = :GOODSCOMPLECT_ID, GOODSID = :GOODSID, PARTNO = :PARTNO, '
      
        '  COMPLECT_SN = :COMPLECT_SN, QTY = :QTY, CREATED_BY = :CREATED_' +
        'BY, VENDORWARRANTY = :VENDORWARRANTY, OWNWARRANTY = :OWNWARRANTY' +
        ', '
      
        '  SUMA_ACCIZE = :SUMA_ACCIZE, COUNTRYID = :COUNTRYID, VENDORID =' +
        ' :VENDORID, VALID_UNTIL_DATE = :VALID_UNTIL_DATE'
      'WHERE'
      
        '  DOCID = :Old_DOCID AND DTDEP = :Old_DTDEP AND CTDEP = :Old_CTD' +
        'EP AND GOODSCOMPLECT_ID = :Old_GOODSCOMPLECT_ID AND '
      
        '  GOODSID = :Old_GOODSID AND PARTNO = :Old_PARTNO AND COMPLECT_S' +
        'N = :Old_COMPLECT_SN')
    SQLRefresh.Strings = (
      'SELECT'
      ' *'
      'FROM'
      '  VW_TDB_PARTS'
      'WHERE'
      '  DOCID = :DOCID AND '
      '  DTDEP = :DTDEP AND '
      '  CTDEP = :CTDEP AND '
      '  GOODSCOMPLECT_ID = :GOODSCOMPLECT_ID AND '
      '  GOODSID = :GOODSID AND '
      '  PARTNO = :PARTNO AND '
      '  COMPLECT_SN = :COMPLECT_SN')
    SQLLock.Strings = (
      'SELECT NULL FROM TDB_PARTS'
      'WHERE'
      
        'DOCID = :Old_DOCID AND DTDEP = :Old_DTDEP AND CTDEP = :Old_CTDEP' +
        ' AND GOODSCOMPLECT_ID = :Old_GOODSCOMPLECT_ID AND GOODSID = :Old' +
        '_GOODSID AND PARTNO = :Old_PARTNO AND COMPLECT_SN = :Old_COMPLEC' +
        'T_SN'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'SELECT'
      ' *'
      'FROM'
      '  VW_TDB_PARTS')
    MasterFields = 'DOCID;DTDEP;CTDEP;GOODSCOMPLECT_ID;GOODSID'
    DetailFields = 'DOCID;DTDEP;CTDEP;GOODSCOMPLECT_ID;GOODSID'
    AutoCommit = False
    LockMode = lmLockImmediate
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Options.QueryRecCount = True
    Left = 100
    Top = 260
  end
  object IBCDataSourceParts: TIBCDataSource
    DataSet = IBCQueryParts
    Left = 100
    Top = 212
  end
end
