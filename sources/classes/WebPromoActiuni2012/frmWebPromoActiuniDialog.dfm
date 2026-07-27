object frmWebPromoActiuniDlg: TfrmWebPromoActiuniDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Promotii pe web-site'
  ClientHeight = 588
  ClientWidth = 1113
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  DesignSize = (
    1113
    588)
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 1113
    Height = 64
    Title = 'Promotii pe web-site'
    Text = 'Gestionarea promotiilor pe web-site'
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
    Width = 1097
    Height = 465
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelOuter = bvNone
    TabOrder = 1
    object dxBarDockControl1: TdxBarDockControl
      Left = 0
      Top = 0
      Width = 1097
      Height = 30
      Align = dalTop
      BarManager = dxBarManager1
      SunkenBorder = True
      UseOwnSunkenBorder = True
    end
    object cxGrid: TcxGrid
      Left = 0
      Top = 30
      Width = 1097
      Height = 435
      Align = alClient
      TabOrder = 1
      ExplicitTop = 31
      object cxGridTable: TcxGridDBTableView
        PopupMenu = dxBarPopupMenu1
        FindPanel.DisplayMode = fpdmAlways
        OnCustomDrawCell = cxGridTableCustomDrawCell
        OnFocusedRecordChanged = cxGridTableFocusedRecordChanged
        DataController.DataSource = IBCDataSourceActiuni
        DataController.KeyFieldNames = 'PROMOACTIONID'
        OptionsBehavior.IncSearch = True
        OptionsBehavior.ImmediateEditor = False
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnsQuickCustomization = True
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
        OptionsView.ScrollBars = ssVertical
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        Styles.Header = dmAdditions.cxStyle_GridHeader
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        object cxGrid_PROMOACTIONID: TcxGridDBColumn
          Caption = 'ID'
          DataBinding.FieldName = 'PROMOACTIONID'
          HeaderAlignmentHorz = taCenter
          MinWidth = 50
          Options.HorzSizing = False
          Width = 50
        end
        object cxGridTable_ORDERNO: TcxGridDBColumn
          Caption = 'O'
          DataBinding.FieldName = 'ORDERNO'
          Visible = False
          Width = 35
        end
        object cxGrid_FLG_ENABLED: TcxGridDBColumn
          Caption = 'Act'
          DataBinding.FieldName = 'FLG_ENABLED'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          HeaderAlignmentHorz = taCenter
          MinWidth = 40
          Options.HorzSizing = False
          Width = 40
        end
        object cxGrid_START_DATE: TcxGridDBColumn
          Caption = 'Inceput'
          DataBinding.FieldName = 'START_DATE'
          MinWidth = 80
          Options.HorzSizing = False
          Width = 80
        end
        object cxGrid_END_DATE: TcxGridDBColumn
          Caption = 'Sfirsit'
          DataBinding.FieldName = 'END_DATE'
          MinWidth = 80
          Options.HorzSizing = False
          Width = 80
        end
        object cxGrid_DAYS_REMAIN: TcxGridDBColumn
          Caption = 'Zile act.'
          DataBinding.FieldName = 'DAYS_REMAIN'
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taRightJustify
          HeaderAlignmentHorz = taCenter
          MinWidth = 60
          Options.HorzSizing = False
          Width = 60
        end
        object cxGrid_TITLE: TcxGridDBColumn
          Caption = 'Denumire'
          DataBinding.FieldName = 'TITLE'
          Width = 300
        end
        object cxGrid_FLG_SHOW_BANNER: TcxGridDBColumn
          AlternateCaption = #1041#1072#1085#1085#1077#1088
          Caption = 'B'
          DataBinding.FieldName = 'FLG_SHOW_BANNER'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          HeaderAlignmentHorz = taCenter
          MinWidth = 30
          Options.HorzSizing = False
          Width = 30
        end
        object cxGrid_FLG_SHOW_GOODS: TcxGridDBColumn
          AlternateCaption = #1058#1086#1074#1072#1088#1099
          Caption = 'P'
          DataBinding.FieldName = 'FLG_SHOW_GOODS'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          HeaderAlignmentHorz = taCenter
          MinWidth = 30
          Options.HorzSizing = False
          Width = 30
        end
        object cxGrid_FLG_SHOW_BRICKS: TcxGridDBColumn
          AlternateCaption = #1056#1077#1082#1083#1072#1084#1072
          Caption = 'R'
          DataBinding.FieldName = 'FLG_SHOW_BRICKS'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          HeaderAlignmentHorz = taCenter
          MinWidth = 30
          Options.HorzSizing = False
          Width = 30
        end
        object cxGrid_FLG_FAKE_PROMOTION: TcxGridDBColumn
          Caption = 'FP'
          DataBinding.FieldName = 'FLG_FAKE_PROMOTION'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = '1'
          Properties.ValueUnchecked = '0'
          HeaderAlignmentHorz = taCenter
          MinWidth = 30
          Options.HorzSizing = False
          Width = 30
        end
        object cxGrid_CREATED_BY_NAME: TcxGridDBColumn
          Caption = 'Operator'
          DataBinding.FieldName = 'CREATED_BY_NAME'
        end
      end
      object cxGridLevel: TcxGridLevel
        GridView = cxGridTable
      end
    end
  end
  object btnClose: TButton
    Left = 995
    Top = 548
    Width = 90
    Height = 30
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Inchide'
    ModalResult = 2
    TabOrder = 3
  end
  object btnOK: TButton
    Left = 899
    Top = 548
    Width = 90
    Height = 30
    Anchors = [akRight, akBottom]
    Caption = 'Selecteaza'
    Default = True
    ModalResult = 1
    TabOrder = 2
    Visible = False
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
    Left = 420
    Top = 12
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
      FloatLeft = 662
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
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbRefresh'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbBanner'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbGoods'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'dxBarButton2'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbBricks'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'dxBarButton1'
        end
        item
          BeginGroup = True
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
      ShortCut = 113
      OnClick = bbEditClick
    end
    object bbDelete: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      ShortCut = 16503
      OnClick = bbDeleteClick
    end
    object bbBanner: TdxBarButton
      Caption = 'Banere'
      Category = 0
      Hint = 'Banere'
      Visible = ivAlways
      ImageIndex = 22
      ShortCut = 115
      OnClick = bbBannerClick
    end
    object bbGoods: TdxBarButton
      Caption = 'Produse si preturi...'
      Category = 0
      Hint = 'Produse si preturi'
      Visible = ivAlways
      ImageIndex = 12
      ShortCut = 117
      OnClick = bbGoodsClick
    end
    object bbBricks: TdxBarButton
      Caption = 'Reclama'
      Category = 0
      Hint = 'Reclama'
      Visible = ivAlways
      ImageIndex = 50
      ShortCut = 119
      OnClick = bbBricksClick
    end
    object dxBarButton1: TdxBarButton
      Caption = 'Sortare'
      Category = 0
      Hint = 'Sortare'
      Visible = ivAlways
      ImageIndex = 38
      ShortCut = 16467
      OnClick = dxBarButton1Click
    end
    object dxBarButton2: TdxBarButton
      Caption = 'Oformarea produselor pe site'
      Category = 0
      Hint = 'Oformarea produselor pe site'
      Visible = ivAlways
      ImageIndex = 95
      ShortCut = 118
      OnClick = dxBarButton2Click
    end
    object dxBarSubItem1: TdxBarSubItem
      Caption = 'Instrumente'
      Category = 0
      Visible = ivAlways
      ItemLinks = <>
    end
    object dxBarButton3: TdxBarButton
      Caption = 'Tipar'
      Category = 0
      Hint = 'Tipar'
      Visible = ivAlways
      ImageIndex = 28
      ShortCut = 16464
      OnClick = dxBarButton3Click
    end
    object bbRefresh: TdxBarButton
      Caption = 'Refresh'
      Category = 0
      Hint = 'Refresh'
      Visible = ivAlways
      ImageIndex = 36
      ShortCut = 116
      OnClick = bbRefreshClick
    end
    object bbStartStopPromo: TdxBarButton
      Caption = 'Porneste/Opreste promotia'
      Category = 0
      Hint = 'Porneste/Opreste promotia'
      Visible = ivAlways
      ShortCut = 120
      OnClick = bbStartStopPromoClick
    end
  end
  object IBCQueryActiuni: TIBCQuery
    KeyFields = 'PROMOACTIONID'
    KeyGenerator = 'SQ_TWEB_PROMOS_ID'
    GeneratorMode = gmInsert
    SQLInsert.Strings = (
      'INSERT INTO VW_TWEB_PROMOS'
      '  (PROMOACTIONID, DT, TITLE, START_DATE, END_DATE, ORDERNO,     '
      '    META_TITLE_RO,'
      '    META_TITLE_RU,'
      '    META_DESCRIPTION_RO,'
      '    META_DESCRIPTION_RU,'
      
        '    FLG_ENABLED, FLG_SHOW_BANNER, FLG_SHOW_GOODS, FLG_SHOW_BRICK' +
        'S, FLG_FAKE_PROMOTION, '
      
        '    PROMO_GOODS_GROUP_ID, PROMO_GOODS_GROUP_TITLE, promo_typeid,' +
        ' promo_type_name)'
      'VALUES'
      
        '  (:PROMOACTIONID, :DT, :TITLE, :START_DATE, :END_DATE, :ORDERNO' +
        ', '
      '    :META_TITLE_RO,'
      '    :META_TITLE_RU,'
      '    :META_DESCRIPTION_RO,'
      '    :META_DESCRIPTION_RU,'
      
        '    :FLG_ENABLED, :FLG_SHOW_BANNER, :FLG_SHOW_GOODS, :FLG_SHOW_B' +
        'RICKS, :FLG_FAKE_PROMOTION, '
      
        '    :PROMO_GOODS_GROUP_ID, :PROMO_GOODS_GROUP_TITLE, :promo_type' +
        'id, :promo_type_name)')
    SQLDelete.Strings = (
      'DELETE FROM TWEB_PROMOS'
      'WHERE'
      '  PROMOACTIONID = :Old_PROMOACTIONID')
    SQLUpdate.Strings = (
      'UPDATE VW_TWEB_PROMOS'
      'SET'
      ' TITLE = :TITLE, '
      ' DT = :DT,'
      ' START_DATE = :START_DATE, '
      ' END_DATE = :END_DATE, '
      ' ORDERNO = :ORDERNO,'
      ' META_TITLE_RO =  :META_TITLE_RO,'
      ' META_TITLE_RU = :META_TITLE_RU,'
      ' META_DESCRIPTION_RO = :META_DESCRIPTION_RO,'
      ' META_DESCRIPTION_RU = :META_DESCRIPTION_RU,'
      ' FLG_ENABLED = :FLG_ENABLED,'
      ' FLG_SHOW_BANNER = :FLG_SHOW_BANNER, '
      ' FLG_SHOW_GOODS = :FLG_SHOW_GOODS, '
      ' FLG_SHOW_BRICKS = :FLG_SHOW_BRICKS,'
      ' FLG_FAKE_PROMOTION = :FLG_FAKE_PROMOTION,'
      ' PROMO_GOODS_GROUP_ID = :PROMO_GOODS_GROUP_ID,'
      ' PROMO_GOODS_GROUP_TITLE = :PROMO_GOODS_GROUP_TITLE,'
      ' promo_typeid = :promo_typeid, '
      ' promo_type_name = :promo_type_name'
      'WHERE'
      '  PROMOACTIONID = :Old_PROMOACTIONID')
    SQLRefresh.Strings = (
      'SELECT '
      ' PROMOACTIONID, '
      ' DT, '
      ' TITLE, '
      ' START_DATE, '
      ' END_DATE, '
      ' ORDERNO,'
      '    META_TITLE_RO,'
      '    META_TITLE_RU,'
      '    META_DESCRIPTION_RO,'
      '    META_DESCRIPTION_RU,'
      ' FLG_ENABLED,'
      ' FLG_SHOW_BANNER, '
      ' FLG_SHOW_GOODS, '
      ' FLG_SHOW_BRICKS,'
      ' FLG_FAKE_PROMOTION,'
      ' IIF(FLG_ENABLED=1,'
      '     IIF(DATEDIFF(DAY, CURRENT_DATE, END_DATE)<0,NULL,'
      
        '         IIF(DATEDIFF(DAY, CURRENT_DATE, END_DATE)>0,DATEDIFF(DA' +
        'Y, CURRENT_DATE, END_DATE),'#39#1089#1077#1075#1086#1076#1085#1103#39')'
      '        ),NULL'
      '    ) DAYS_REMAIN,'
      ' PROMO_GOODS_GROUP_ID,'
      ' PROMO_GOODS_GROUP_TITLE,'
      ' promo_typeid,'
      ' promo_type_name'
      'FROM '
      ' VW_TWEB_PROMOS'
      'WHERE'
      ' PROMOACTIONID = :PROMOACTIONID')
    SQLLock.Strings = (
      'SELECT NULL FROM TWEB_PROMOS'
      'WHERE'
      ' PROMOACTIONID = :Old_PROMOACTIONID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = IBCTrUpdate
    SQL.Strings = (
      'SELECT '
      ' PROMOACTIONID, '
      ' DT, '
      ' TITLE, '
      ' START_DATE, '
      ' END_DATE, '
      ' ORDERNO,'
      ' META_TITLE_RO,'
      ' META_TITLE_RU,'
      ' META_DESCRIPTION_RO,'
      ' META_DESCRIPTION_RU,'
      ' FLG_ENABLED,'
      ' FLG_SHOW_BANNER, '
      ' FLG_SHOW_GOODS, '
      ' FLG_SHOW_BRICKS,'
      ' FLG_FAKE_PROMOTION,'
      ' IIF(FLG_ENABLED=1,'
      '     IIF(DATEDIFF(DAY, CURRENT_DATE, END_DATE)<0,NULL,'
      
        '         IIF(DATEDIFF(DAY, CURRENT_DATE, END_DATE)>0,DATEDIFF(DA' +
        'Y, CURRENT_DATE, END_DATE),'#39#1089#1077#1075#1086#1076#1085#1103#39')'
      '        ),NULL'
      '    ) DAYS_REMAIN,'
      ' PROMO_GOODS_GROUP_ID,'
      ' PROMO_GOODS_GROUP_TITLE,'
      ' promo_typeid, '
      ' promo_type_name, '
      ' created_by_name'
      'FROM '
      ' VW_TWEB_PROMOS'
      'WHERE DT = :DT'
      'ORDER BY'
      ' FLG_ENABLED desc, ORDERNO, END_DATE desc ')
    AutoCommit = False
    LockMode = lmLockImmediate
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Left = 104
    Top = 280
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DT'
        Value = nil
      end>
  end
  object IBCDataSourceActiuni: TIBCDataSource
    AutoEdit = False
    DataSet = IBCQueryActiuni
    Left = 104
    Top = 340
  end
  object IBCTrUpdate: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 192
    Top = 280
  end
  object dxBarPopupMenu1: TdxBarPopupMenu
    BarManager = dxBarManager1
    ItemLinks = <
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
        ItemName = 'bbBanner'
      end
      item
        Visible = True
        ItemName = 'bbGoods'
      end
      item
        Visible = True
        ItemName = 'dxBarButton2'
      end
      item
        Visible = True
        ItemName = 'bbBricks'
      end
      item
        Visible = True
        ItemName = 'dxBarButton1'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbStartStopPromo'
      end>
    UseOwnFont = False
    Left = 552
    Top = 296
    PixelsPerInch = 96
  end
end
