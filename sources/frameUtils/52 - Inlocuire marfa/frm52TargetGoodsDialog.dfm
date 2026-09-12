object frm52TargetGoodsDlg: Tfrm52TargetGoodsDlg
  Left = 0
  Top = 0
  Margins.Left = 4
  Margins.Top = 4
  Margins.Right = 4
  Margins.Bottom = 4
  BorderStyle = bsDialog
  Caption = #1058#1086#1074#1072#1088#1099' '#1091' '#1082#1086#1085#1090#1088#1072#1075#1077#1085#1090#1072
  ClientHeight = 793
  ClientWidth = 1296
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  PixelsPerInch = 120
  TextHeight = 20
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 1296
    Height = 80
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Title = #1058#1086#1074#1072#1088#1099' '#1091' '#1082#1086#1085#1090#1088#1072#1075#1077#1085#1090#1072
    Text = ''
    FontTitle.Charset = DEFAULT_CHARSET
    FontTitle.Color = clWindowText
    FontTitle.Height = -18
    FontTitle.Name = 'Segoe UI'
    FontTitle.Style = [fsBold]
    FontText.Charset = DEFAULT_CHARSET
    FontText.Color = clWindowText
    FontText.Height = -15
    FontText.Name = 'Segoe UI'
    FontText.Style = []
    ImageList = dmAdditions.cxImageList_DialogIcons
    ImageIndex = 21
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 10
    Top = 90
    Width = 1276
    Height = 631
    Margins.Left = 10
    Margins.Top = 10
    Margins.Right = 10
    Margins.Bottom = 10
    Align = alClient
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 1
    object pnSettings: TPanel
      AlignWithMargins = True
      Left = 0
      Top = 0
      Width = 1276
      Height = 101
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 5
      Align = alTop
      BevelKind = bkFlat
      BevelOuter = bvNone
      Color = clWindow
      ParentBackground = False
      ShowCaption = False
      TabOrder = 0
      object Label1: TLabel
        Left = 20
        Top = 20
        Width = 79
        Height = 20
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Caption = #1050#1086#1085#1090#1088#1072#1075#1077#1085#1090
      end
      object beCUSTOMER: TcxButtonEdit
        Left = 20
        Top = 41
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Properties.Buttons = <
          item
            Caption = #1042#1099#1073#1088#1072#1090#1100
            Default = True
            Kind = bkText
          end>
        Properties.ViewStyle = vsHideCursor
        Properties.OnButtonClick = beCUSTOMERPropertiesButtonClick
        TabOrder = 0
        Width = 506
      end
    end
    object dxBarDockControl1: TdxBarDockControl
      Left = 0
      Top = 106
      Width = 1276
      Height = 34
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Align = dalTop
      BarManager = dxBarManager1
      SunkenBorder = True
      UseOwnSunkenBorder = True
    end
    object cxGrid: TcxGrid
      Left = 0
      Top = 140
      Width = 1276
      Height = 491
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Align = alClient
      TabOrder = 2
      object cxGridTable: TcxGridDBTableView
        OnKeyDown = cxGridTableKeyDown
        OnCellDblClick = cxGridTableCellDblClick
        OnCustomDrawCell = cxGridTableCustomDrawCell
        OnFocusedRecordChanged = cxGridTableFocusedRecordChanged
        DataController.DataSource = IBCDataSourceGoods
        DataController.KeyFieldNames = 'DOCID;DT_DEP;DT_GOODSID'
        FilterRow.SeparatorWidth = 8
        FixedDataRows.SeparatorWidth = 8
        NewItemRow.SeparatorWidth = 8
        OptionsBehavior.IncSearch = True
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
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        Preview.LeftIndent = 25
        Preview.RightIndent = 6
        RowLayout.MinValueWidth = 100
        Styles.Header = dmAdditions.cxStyle_GridHeader
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        object cxGrid_DOCID: TcxGridDBColumn
          Caption = #1050#1086#1076'. '#1076#1086#1082'.'
          DataBinding.FieldName = 'DOCID'
          HeaderAlignmentHorz = taCenter
          MinWidth = 100
          Options.Filtering = False
          Options.HorzSizing = False
          Width = 100
        end
        object cxGrid_DOC_DATA: TcxGridDBColumn
          Caption = #1044#1072#1090#1072
          DataBinding.FieldName = 'DOC_DATA'
          OnGetDisplayText = cxGrid_DOC_DATAGetDisplayText
          HeaderAlignmentHorz = taCenter
          MinWidth = 138
          Options.HorzSizing = False
          Width = 138
        end
        object cxGrid_DOC_CT_NAME: TcxGridDBColumn
          Caption = #1050#1086#1085#1090#1088#1072#1075#1077#1085#1090
          DataBinding.FieldName = 'DOC_CT_NAME'
          Visible = False
          MinWidth = 25
          VisibleForCustomization = False
          Width = 125
        end
        object cxGrid_DT_GOODSID: TcxGridDBColumn
          Caption = #1050#1086#1076'. '#1090#1086#1074'.'
          DataBinding.FieldName = 'DT_GOODSID'
          HeaderAlignmentHorz = taCenter
          MinWidth = 100
          Options.Filtering = False
          Options.HorzSizing = False
          Width = 100
        end
        object cxGrid_DT_GOODS_TITLE: TcxGridDBColumn
          Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
          DataBinding.FieldName = 'DT_GOODS_TITLE'
          MinWidth = 25
          Width = 250
        end
        object cxGrid_DT_IDENT: TcxGridDBColumn
          Caption = #1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088
          DataBinding.FieldName = 'DT_IDENT'
          HeaderAlignmentHorz = taCenter
          MinWidth = 150
          Options.HorzSizing = False
          Width = 150
        end
        object cxGrid_DT_PRICE: TcxGridDBColumn
          Caption = #1062#1077#1085#1072
          DataBinding.FieldName = 'DT_PRICE'
          HeaderAlignmentHorz = taCenter
          MinWidth = 100
          Options.Filtering = False
          Options.HorzSizing = False
          Width = 100
        end
      end
      object cxGridLevel: TcxGridLevel
        GridView = cxGridTable
      end
    end
  end
  object pnButtons: TPanel
    Left = 0
    Top = 731
    Width = 1296
    Height = 62
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Align = alBottom
    BevelOuter = bvNone
    Padding.Top = 5
    Padding.Right = 30
    Padding.Bottom = 20
    ShowCaption = False
    TabOrder = 2
    object btnClose: TButton
      Left = 1153
      Top = 5
      Width = 113
      Height = 37
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Align = alRight
      Cancel = True
      Caption = #1047#1072#1082#1088#1099#1090#1100
      ModalResult = 2
      TabOrder = 0
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
    ImageOptions.StretchGlyphs = False
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 492
    Top = 8
    PixelsPerInch = 120
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
      FloatLeft = 1059
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbProcess'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object bbProcess: TdxBarButton
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      Category = 0
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 115
      OnClick = bbProcessClick
    end
  end
  object IBCQueryGoods: TIBCQuery
    SQLUpdate.Strings = (
      'UPDATE VW_TDB_JURNAL_SP'
      'SET'
      ' DOCID = :DOCID, '
      ' DT_DEP = :DT_DEP, '
      ' DT_GOODSID = :DT_GOODSID, '
      ' DT_IDENT = :DT_IDENT, '
      ' DT_PRICE = :DT_PRICE,'
      ' CT_DEP = :CT_DEP, '
      ' CT_GOODSID = :CT_GOODSID, '
      ' CT_IDENT = :CT_IDENT,'
      ' CT_PRICE = :CT_PRICE,'
      ' DT_FLG_BALANCE = :DT_FLG_BALANCE, '
      ' DT_FLG_PERESORT = :DT_FLG_PERESORT,'
      ' DT_FLG_NEDOSTACIA = :DT_FLG_NEDOSTACIA,'
      ' CT_FLG_BALANCE = :CT_FLG_BALANCE,'
      ' CT_FLG_PERESORT = :CT_FLG_PERESORT,'
      ' CT_FLG_NEDOSTACIA = :CT_FLG_NEDOSTACIA'
      ''
      'WHERE'
      ' DOCID = :Old_DOCID '
      ' AND '
      ' DT_DEP = :Old_DT_DEP '
      ' AND '
      ' DT_GOODSID = :Old_DT_GOODSID')
    SQLRefresh.Strings = (
      'SELECT'
      ' VW_TDB_JURNAL_SP.*,'
      ' TDB_DOCS.DATA DOC_DATA,'
      ' TS_CUSTOMER.CUSTOMERID,'
      ' TS_CUSTOMER.DISPLAYNAME DOC_CT_NAME'
      'FROM VW_TDB_JURNAL_SP'
      'INNER JOIN TDB_DOCS ON (TDB_DOCS.DOCID=VW_TDB_JURNAL_SP.DOCID)'
      'INNER JOIN TS_CUSTOMER ON (TS_CUSTOMER.CUSTOMERID=TDB_DOCS.CT)'
      'WHERE'
      ' VW_TDB_JURNAL_SP.DOCID = :DOCID '
      ' AND '
      ' VW_TDB_JURNAL_SP.DT_DEP = :DT_DEP '
      ' AND '
      ' VW_TDB_JURNAL_SP.DT_GOODSID = :DT_GOODSID')
    SQLLock.Strings = (
      'SELECT '
      ' NULL '
      'FROM '
      ' TDB_JURNAL_SP'
      'WHERE'
      ' DOCID = :Old_DOCID '
      ' AND '
      ' DT_DEP = :Old_DT_DEP '
      ' AND '
      ' DT_GOODSID = :DT_GOODSID'
      'FOR UPDATE '
      ' WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'SELECT'
      ' VW_TDB_JURNAL_SP.*,'
      ' TDB_DOCS.DATA DOC_DATA,'
      ' TS_CUSTOMER.CUSTOMERID,'
      ' TS_CUSTOMER.DISPLAYNAME DOC_CT_NAME'
      'FROM VW_TDB_JURNAL_SP'
      'INNER JOIN TDB_DOCS ON (TDB_DOCS.DOCID=VW_TDB_JURNAL_SP.DOCID)'
      'INNER JOIN TS_CUSTOMER ON (TS_CUSTOMER.CUSTOMERID=TDB_DOCS.CT)'
      'WHERE (TS_CUSTOMER.CUSTOMERID=:ID) '
      
        '      AND (VW_TDB_JURNAL_SP.CT_GOODSID IS NULL OR VW_TDB_JURNAL_' +
        'SP.CT_IDENT IS NULL)'
      '      AND (GET_FLG_VALUE(TDB_DOCS.FLAGS,10)=0)')
    AutoCommit = False
    Options.DetailDelay = 500
    Left = 120
    Top = 268
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
        Value = nil
      end>
  end
  object IBCDataSourceGoods: TIBCDataSource
    DataSet = IBCQueryGoods
    Left = 120
    Top = 328
  end
end
