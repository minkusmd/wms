object frmGoodsTypeDlg: TfrmGoodsTypeDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Categoria de produse'
  ClientHeight = 590
  ClientWidth = 1089
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnActivate = FormActivate
  DesignSize = (
    1089
    590)
  TextHeight = 15
  object dxBarDockControl1: TdxBarDockControl
    AlignWithMargins = True
    Left = 8
    Top = 3
    Width = 1073
    Height = 32
    Margins.Left = 8
    Margins.Right = 8
    Margins.Bottom = 1
    Align = dalTop
    BarManager = dxBarManager
    SunkenBorder = True
    UseOwnSunkenBorder = True
  end
  object cxGridGoodsType: TcxGrid
    AlignWithMargins = True
    Left = 8
    Top = 37
    Width = 1073
    Height = 497
    Margins.Left = 8
    Margins.Top = 1
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 1
    object cxGridGoodsTypeTable: TcxGridDBTableView
      Navigator.Buttons.First.Visible = False
      Navigator.Buttons.PriorPage.Visible = False
      Navigator.Buttons.Next.Visible = False
      Navigator.Buttons.NextPage.Visible = False
      Navigator.Buttons.Last.Visible = False
      Navigator.Buttons.Insert.Visible = False
      Navigator.Buttons.Append.Enabled = False
      Navigator.Buttons.Delete.Visible = False
      Navigator.Buttons.Edit.Visible = False
      Navigator.Buttons.Post.Visible = False
      Navigator.Buttons.Cancel.Enabled = False
      Navigator.Buttons.Cancel.Visible = False
      Navigator.Buttons.SaveBookmark.Visible = False
      Navigator.Buttons.GotoBookmark.Visible = False
      Navigator.InfoPanel.Visible = True
      Navigator.Visible = True
      FindPanel.DisplayMode = fpdmAlways
      FindPanel.ShowCloseButton = False
      FindPanel.UseExtendedSyntax = True
      OnCellDblClick = cxGridGoodsTypeTableCellDblClick
      OnFocusedRecordChanged = cxGridGoodsTypeTableFocusedRecordChanged
      DataController.DataSource = IBCDataSourceGoodsType
      DataController.KeyFieldNames = 'GOODSTYPEID'
      OptionsBehavior.IncSearch = True
      OptionsCustomize.ColumnGrouping = False
      OptionsCustomize.ColumnMoving = False
      OptionsCustomize.ColumnsQuickCustomization = True
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.InvertSelect = False
      OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
      OptionsView.ScrollBars = ssVertical
      OptionsView.ColumnAutoWidth = True
      OptionsView.GridLineColor = 13750737
      OptionsView.GroupByBox = False
      OptionsView.Indicator = True
      Styles.Header = dmAdditions.cxStyle_GridHeader
      object cxGridGoodsType_GOODSTYPEID: TcxGridDBColumn
        Caption = 'ID'
        DataBinding.FieldName = 'GOODSTYPEID'
        MinWidth = 70
        Options.HorzSizing = False
        Width = 70
      end
      object cxGridGoodsType_TITLE: TcxGridDBColumn
        Caption = 'Denumirea'
        DataBinding.FieldName = 'TITLE'
        Width = 269
      end
      object cxGridGoodsType_TITLE_RUS: TcxGridDBColumn
        Caption = #1053#1072#1079#1074#1072#1085#1080#1077
        DataBinding.FieldName = 'TITLE_RUS'
        Width = 262
      end
      object cxGridGoodsType_DESCRIPTION: TcxGridDBColumn
        Caption = 'Descrierea'
        DataBinding.FieldName = 'DESCRIPTION'
        Visible = False
        Width = 149
      end
      object cxGridGoodsType_SEARCH_KEYS: TcxGridDBColumn
        Caption = 'Cuvinte cheie suplumentare pentru cautare'
        DataBinding.FieldName = 'SEARCH_KEYS'
        Visible = False
        Width = 159
      end
      object cxGridGoodsType_Model: TcxGridDBColumn
        Caption = 'Model'
        DataBinding.FieldName = 'MODEL_EX'
        Visible = False
        Width = 163
      end
      object cxGridGoodsTypeTableColumn4: TcxGridDBColumn
        Caption = 'Parametru'
        DataBinding.FieldName = 'PARAM_EX'
        Visible = False
        Width = 147
      end
      object cxGridGoodsTypeTableColumn1: TcxGridDBColumn
        Caption = 'Denumirea scurta'
        DataBinding.FieldName = 'SHORT_TITLE'
        Visible = False
        Width = 100
      end
      object cxGridGoodsTypeTableColumn6: TcxGridDBColumn
        Caption = 'Catalog folder'
        DataBinding.FieldName = 'GOODS_FOLDER_TITLE'
        Width = 276
      end
      object cxGridGoodsType_USER_NAME: TcxGridDBColumn
        Caption = 'Utilizator'
        DataBinding.FieldName = 'USER_NAME'
        Width = 106
      end
      object cxGridGoodsTypeTableColumn2: TcxGridDBColumn
        Caption = 'DI'
        DataBinding.FieldName = 'FLG_DEF_IMAGE'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = '1'
        Properties.ValueUnchecked = '0'
        Options.HorzSizing = False
        Width = 20
      end
      object cxGridGoodsTypeTableColumn3: TcxGridDBColumn
        Caption = 'MI'
        DataBinding.FieldName = 'FLG_MENU_IMAGE'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = '1'
        Properties.ValueUnchecked = '0'
        Options.HorzSizing = False
        Width = 20
      end
      object cxGridGoodsTypeTableColumn5: TcxGridDBColumn
        Caption = 'Feed'
        DataBinding.FieldName = 'FLG_FEED'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.NullStyle = nssUnchecked
        Properties.ValueChecked = '1'
        Properties.ValueUnchecked = '0'
        MinWidth = 36
        Options.HorzSizing = False
        Width = 36
      end
      object cxGridGoodsTypeTable_COUNT_GOODS: TcxGridDBColumn
        Caption = 'Qty'
        DataBinding.FieldName = 'COUNT_GOODS'
        Visible = False
        HeaderAlignmentHorz = taCenter
        MinWidth = 48
        Options.HorzSizing = False
        Width = 48
      end
    end
    object cxGridGoodsTypeLevel: TcxGridLevel
      GridView = cxGridGoodsTypeTable
    end
  end
  object btnClose: TcxButton
    Left = 971
    Top = 553
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
  object btnOK: TcxButton
    Left = 875
    Top = 553
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object dxBarManager: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      #1055#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
      'Instrumente'
      'NPSC')
    Categories.ItemsVisibles = (
      2
      2
      2)
    Categories.Visibles = (
      True
      True
      True)
    ImageOptions.Images = dmAdditions.cxImageList_SWN
    ImageOptions.StretchGlyphs = False
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 436
    Top = 144
    PixelsPerInch = 96
    object dxBarManagerBar1: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' 1'
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 646
      FloatTop = 0
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbNewType'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbModify'
        end
        item
          BeginGroup = True
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
          ItemName = 'bbSearch'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarSubItemNPSC'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarSubItem2'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object bbNewType: TdxBarButton
      Caption = 'Nou'
      Category = 0
      Hint = 'Nou'
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 45
      OnClick = bbNewTypeClick
    end
    object bbModify: TdxBarButton
      Caption = 'Modifica'
      Category = 0
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 115
      OnClick = bbModifyClick
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
    object bbSearch: TdxBarButton
      Caption = 'Cauta'
      Category = 0
      Hint = 'Cauta'
      Visible = ivAlways
      ImageIndex = 4
      ShortCut = 114
      OnClick = bbSearchClick
    end
    object dxBarSubItemNPSC: TdxBarSubItem
      Caption = 'NPSC'
      Category = 0
      Visible = ivAlways
      ImageIndex = 50
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbNPSC'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbCloseNPSC'
        end>
    end
    object dxBarSubItem2: TdxBarSubItem
      Caption = 'Instrumente'
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'dxBarButton1'
        end
        item
          Visible = True
          ItemName = 'bbCategorySuppliers'
        end
        item
          Visible = True
          ItemName = 'bbMergeGoodsType'
        end
        item
          Visible = True
          ItemName = 'dxBarButton2'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbGoodsAttributesTemplate'
        end>
    end
    object bbMergeGoodsType: TdxBarButton
      Caption = 'Uneste 2 tipuri de produse'
      Category = 1
      Hint = 'Uneste 2 tipuri de produse'
      Visible = ivAlways
      ShortCut = 16461
      OnClick = bbMergeGoodsTypeClick
    end
    object dxBarButton2: TdxBarButton
      Caption = 'Seteaza exportul in feed'
      Category = 1
      Hint = 'Seteaza exportul in feed'
      Visible = ivAlways
      ShortCut = 32838
      OnClick = dxBarButton2Click
    end
    object bbCategorySuppliers: TdxBarButton
      Caption = 'Furnizori din categorie'
      Category = 1
      Hint = 'Furnizori din categorie'
      Visible = ivAlways
      ShortCut = 49222
      OnClick = bbCategorySuppliersClick
    end
    object dxBarButton1: TdxBarButton
      Caption = 'Produsele din categorie'
      Category = 1
      Hint = 'Produsele din categorie'
      Visible = ivAlways
      ImageIndex = 84
      ShortCut = 117
      OnClick = dxBarButton1Click
    end
    object bbGoodsAttributesTemplate: TdxBarButton
      Caption = 'Sabloane atribute produse'
      Category = 1
      Hint = 'Sabloane atribute produse'
      Visible = ivAlways
      ShortCut = 32833
    end
    object bbNPSC: TdxBarButton
      Caption = 'Tipizare in denumirea produsului...'
      Category = 2
      Hint = 'Fantastic Product Support Center'
      Visible = ivAlways
      ShortCut = 120
      OnClick = bbNPSCClick
    end
    object bbCloseNPSC: TdxBarButton
      Caption = 'Copierea tipizarii din alt produs...'
      Category = 2
      Hint = 'Copierea tipizarii din alt produs'
      Visible = ivAlways
      OnClick = bbCloseNPSCClick
    end
  end
  object IBCQueryGoodsType: TIBCQuery
    KeyFields = 'GOODSTYPEID'
    KeyGenerator = 'SQ_TS_GOODS_TYPE_ID'
    GeneratorMode = gmInsert
    SQLInsert.Strings = (
      'INSERT INTO VW_TS_GOODS_TYPE'
      
        '  (GOODSTYPEID, TITLE, TITLE_RUS, DESCRIPTION, SEARCH_KEYS, USER' +
        'ID, FLG_LANG_UNIQUE, SHORT_TITLE, FLG_FEED, GOODS_FOLDERID, GOOD' +
        'S_FOLDER_TITLE)'
      'VALUES'
      
        '  (:GOODSTYPEID, :TITLE, :TITLE_RUS, :DESCRIPTION, :SEARCH_KEYS,' +
        ' :USERID, :FLG_LANG_UNIQUE, :SHORT_TITLE, :FLG_FEED, :GOODS_FOLD' +
        'ERID, :GOODS_FOLDER_TITLE)')
    SQLDelete.Strings = (
      'DELETE FROM VW_TS_GOODS_TYPE'
      'WHERE'
      '  GOODSTYPEID = :Old_GOODSTYPEID')
    SQLUpdate.Strings = (
      'UPDATE VW_TS_GOODS_TYPE'
      'SET'
      
        '  GOODSTYPEID = :GOODSTYPEID, TITLE = :TITLE, TITLE_RUS = :TITLE' +
        '_RUS, DESCRIPTION = :DESCRIPTION, SEARCH_KEYS = :SEARCH_KEYS, US' +
        'ERID = :USERID, FLG_LANG_UNIQUE = :FLG_LANG_UNIQUE, SHORT_TITLE ' +
        '= :SHORT_TITLE, FLG_FEED = :FLG_FEED, GOODS_FOLDERID = :GOODS_FO' +
        'LDERID, GOODS_FOLDER_TITLE = :GOODS_FOLDER_TITLE'
      'WHERE'
      '  GOODSTYPEID = :Old_GOODSTYPEID')
    SQLRefresh.Strings = (
      
        'SELECT GOODSTYPEID, TITLE, TITLE_RUS, DESCRIPTION, SEARCH_KEYS, ' +
        'USERID, FLG_LANG_UNIQUE, SHORT_TITLE, FLG_FEED, GOODS_FOLDERID, ' +
        'GOODS_FOLDER_TITLE FROM VW_TS_GOODS_TYPE'
      'WHERE'
      '  GOODSTYPEID = :GOODSTYPEID')
    SQLLock.Strings = (
      'SELECT NULL FROM TS_GOODS_TYPE'
      'WHERE'
      'GOODSTYPEID = :Old_GOODSTYPEID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM VW_TS_GOODS_TYPE'
      ''
      ') q')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = IBCTrUpdate
    SQL.Strings = (
      'SELECT '
      ' gt.GOODSTYPEID, '
      ' gt.SHORT_TITLE, '
      ' gt.TITLE,'
      ' gt.TITLE_RUS,'
      ' gt.DESCRIPTION,'
      ' gt.SEARCH_KEYS,'
      ' gt.FLG_LANG_UNIQUE,'
      ' gt.USERID,'
      
        ' (SELECT FULL_NAME FROM TS_USERS WHERE TS_USERS.USERID=Gt.USERID' +
        ') USER_NAME,'
      ' gt.FLG_FEED,'
      
        ' IIF(EXISTS(SELECT 1 FROM TS_GOODS_TYPE_IMAGE A WHERE OCTET_LENG' +
        'TH(A.IMAGE) > 0 AND A.GOODSTYPEID = Gt.GOODSTYPEID),1,0) FLG_DEF' +
        '_IMAGE,'
      
        ' IIF(EXISTS(SELECT 1 FROM TS_GOODS_TYPE_IMAGE A WHERE OCTET_LENG' +
        'TH(A.MENU_IMAGE)>0 AND A.GOODSTYPEID = Gt.GOODSTYPEID),1,0) FLG_' +
        'MENU_IMAGE,'
      
        '-- (select count(goodsid) from ts_goods g where g.webgoodstype_i' +
        'd=gt.goodstypeid and get_flg_in_price(g.goodsid)=1) count_goods,'
      ' gt.goods_folderid, '
      ' gt.goods_folder_title'
      'FROM'
      ' vw_TS_GOODS_TYPE Gt'
      'WHERE'
      ' (GOODSTYPEID<>-1)'
      ''
      'order by title'
      '')
    AutoCommit = False
    LockMode = lmLockImmediate
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Options.RequiredFields = False
    LocalConstraints = False
    Left = 283
    Top = 204
  end
  object IBCTrUpdate: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 288
    Top = 92
  end
  object IBCDataSourceGoodsType: TIBCDataSource
    DataSet = IBCQueryGoodsType
    Left = 286
    Top = 144
  end
end
