object frmGoodsRelatedDlg: TfrmGoodsRelatedDlg
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Chei pentru produse inrudite'
  ClientHeight = 616
  ClientWidth = 1309
  Color = clBtnFace
  Constraints.MinHeight = 400
  Constraints.MinWidth = 500
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 1309
    Height = 64
    Title = 'Denumirea cheilor inrudite'
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
    ImageList = dmAdditions.cxImageList_DialogIcons
    ImageIndex = 0
  end
  object pnMain: TPanel
    AlignWithMargins = True
    Left = 5
    Top = 69
    Width = 1299
    Height = 496
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alClient
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    object Panel2: TPanel
      Left = 417
      Top = 0
      Width = 176
      Height = 492
      Align = alLeft
      BevelOuter = bvNone
      Color = clWindow
      ParentBackground = False
      TabOrder = 1
      object cxGrid1: TcxGrid
        Left = 0
        Top = 30
        Width = 176
        Height = 462
        Align = alClient
        TabOrder = 1
        object cxGrid1DBTableView1: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          ScrollbarAnnotations.CustomAnnotations = <>
          DataController.DataSource = IBCDataSourceRelatedGoods
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.IncSearch = True
          OptionsBehavior.ImmediateEditor = False
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.InvertSelect = False
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
          object cxGrid1DBTableView1RELATED_KEY: TcxGridDBColumn
            Caption = 'Key'
            DataBinding.FieldName = 'RELATED_KEY'
            Width = 221
          end
          object cxGrid1DBTableView1GOODSID: TcxGridDBColumn
            DataBinding.FieldName = 'GOODSID'
            Visible = False
            Width = 99
          end
        end
        object cxGrid1Level1: TcxGridLevel
          GridView = cxGrid1DBTableView1
        end
      end
      object dxBarDockControl2: TdxBarDockControl
        Left = 0
        Top = 0
        Width = 176
        Height = 30
        Align = dalTop
        BarManager = dxBarManager
      end
    end
    object Panel3: TPanel
      Left = 593
      Top = 0
      Width = 702
      Height = 492
      Align = alClient
      TabOrder = 2
      object dxBarDockControl3: TdxBarDockControl
        Left = 1
        Top = 1
        Width = 700
        Height = 30
        Align = dalTop
        BarManager = dxBarManager
      end
      object cxGrid2: TcxGrid
        Left = 1
        Top = 31
        Width = 700
        Height = 202
        Align = alTop
        TabOrder = 1
        object cxGridDBTableView1: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          ScrollbarAnnotations.CustomAnnotations = <>
          DataController.DataSource = IBCDataSourceGoods
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
          object cxGridDBTableView1_GOODSID: TcxGridDBColumn
            Caption = 'Cod'
            DataBinding.FieldName = 'GOODSID'
            Width = 57
          end
          object cxGridDBTableView1_TITLE: TcxGridDBColumn
            Caption = 'Denumire'
            DataBinding.FieldName = 'TITLE'
            Width = 503
          end
          object cxGridDBTableView1_PRICE: TcxGridDBColumn
            Caption = 'Pret'
            DataBinding.FieldName = 'PRICE4'
            Width = 68
          end
          object cxGridDBTableView1_FLG_IN_PRICE: TcxGridDBColumn
            Caption = '...'
            DataBinding.FieldName = 'FLG_IN_PRICE'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ValueChecked = '1'
            Properties.ValueGrayed = 0
            Properties.ValueUnchecked = '0'
            MinWidth = 24
            Options.HorzSizing = False
            Width = 24
          end
        end
        object cxGridLevel1: TcxGridLevel
          GridView = cxGridDBTableView1
        end
      end
      object cxGrid3: TcxGrid
        Left = 1
        Top = 233
        Width = 700
        Height = 258
        Align = alClient
        TabOrder = 2
        object cxGridDBTableView2: TcxGridDBTableView
          OnKeyDown = cxGridDBTableView2KeyDown
          Navigator.Buttons.CustomButtons = <>
          ScrollbarAnnotations.CustomAnnotations = <>
          DataController.DataSource = IBCDataSourceResultGoods
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.IncSearch = True
          OptionsBehavior.ImmediateEditor = False
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.InvertSelect = False
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
          object cxGrid1DBTableView1_GOODSID: TcxGridDBColumn
            Caption = 'Cod'
            DataBinding.FieldName = 'GOODSID'
            HeaderAlignmentHorz = taCenter
            MinWidth = 64
            Options.HorzSizing = False
          end
          object cxGrid1DBTableView1_WEBGOODSTYPE: TcxGridDBColumn
            Caption = 'Tip produs'
            DataBinding.FieldName = 'WEBGOODSTYPE_TITLE'
            MinWidth = 130
            Options.HorzSizing = False
            Width = 130
          end
          object cxGrid1DBTableView1_GOODS_NAME: TcxGridDBColumn
            Caption = 'Produs'
            DataBinding.FieldName = 'TITLE'
            HeaderAlignmentHorz = taCenter
            Width = 547
          end
          object cxGrid1DBTableView1_PRICE_MDL: TcxGridDBColumn
            Caption = 'Pret'
            DataBinding.FieldName = 'PRICE1_LEI'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            Properties.UseThousandSeparator = True
            HeaderAlignmentHorz = taCenter
            MinWidth = 79
            Options.HorzSizing = False
            Width = 79
          end
          object cxGrid1DBTableView1_FLG_IN_PRICE: TcxGridDBColumn
            Caption = 'P'
            DataBinding.FieldName = 'FLG_IN_PRICE'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ValueChecked = '1'
            Properties.ValueGrayed = 0
            Properties.ValueUnchecked = '0'
            HeaderAlignmentHorz = taCenter
            MinWidth = 24
            Options.HorzSizing = False
            Width = 24
          end
        end
        object cxGridLevel2: TcxGridLevel
          GridView = cxGridDBTableView2
        end
      end
    end
    object Panel4: TPanel
      Left = 0
      Top = 0
      Width = 417
      Height = 492
      Align = alLeft
      Caption = 'Panel4'
      TabOrder = 0
      object cxGridGoodsAcnt: TcxGrid
        Left = 1
        Top = 32
        Width = 415
        Height = 459
        Align = alClient
        TabOrder = 1
        object cxGridGoodsRelatedKeys: TcxGridDBTableView
          PopupMenu = dxBarPopupMenu
          OnKeyDown = cxGridGoodsRelatedKeysKeyDown
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
          OnCellDblClick = cxGridGoodsRelatedKeysCellDblClick
          OnFocusedRecordChanged = cxGridGoodsRelatedKeysFocusedRecordChanged
          DataController.DataModeController.GridModeBufferCount = 50
          DataController.DataSource = IBCDataSourceRelatedKeys
          DataController.KeyFieldNames = 'RELATED_KEY'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.IncSearch = True
          OptionsBehavior.ImmediateEditor = False
          OptionsCustomize.ColumnGrouping = False
          OptionsCustomize.ColumnsQuickCustomization = True
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.InvertSelect = False
          OptionsSelection.MultiSelectMode = msmPersistent
          OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
          OptionsView.ScrollBars = ssVertical
          OptionsView.ColumnAutoWidth = True
          OptionsView.GridLineColor = 13750737
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          Styles.OnGetContentStyle = cxGridGoodsRelatedKeysStylesGetContentStyle
          Styles.Footer = dmAdditions.cxStyle_GridHeader
          Styles.Header = dmAdditions.cxStyle_GridHeader
          Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
          object cxGridGoodsRelatedKeysFolder: TcxGridDBColumn
            DataBinding.FieldName = 'FLG_FOLDER'
            PropertiesClassName = 'TcxImageComboBoxProperties'
            Properties.Images = dmAdditions.cxImageList_SWN
            Properties.Items = <
              item
                ImageIndex = 22
                Value = 0
              end
              item
                ImageIndex = 13
                Value = 1
              end>
            HeaderAlignmentHorz = taCenter
            MinWidth = 0
            Options.Editing = False
            Options.Focusing = False
            Options.ShowEditButtons = isebNever
            Options.AutoWidthSizable = False
            Options.ExpressionEditing = False
            Options.GroupFooters = False
            Options.Grouping = False
            Options.Moving = False
            Options.ShowCaption = False
            Options.Sorting = False
            VisibleForCustomization = False
            Width = 28
            IsCaptionAssigned = True
          end
          object cxGridGoodsRelated_Key: TcxGridDBColumn
            Caption = 'Key'
            DataBinding.FieldName = 'RELATED_KEY'
            PropertiesClassName = 'TcxCalcEditProperties'
            HeaderAlignmentHorz = taCenter
            MinWidth = 150
            Width = 220
          end
          object cxGridGoodsRelatedKeysTitle: TcxGridDBColumn
            Caption = 'Denumire'
            DataBinding.FieldName = 'TITLE'
            HeaderAlignmentHorz = taCenter
            Options.Moving = False
            Styles.OnGetContentStyle = cxGridGoodsRelatedKeysTitleStylesGetContentStyle
            VisibleForCustomization = False
            Width = 153
          end
        end
        object cxGridGoodsAcntLevel: TcxGridLevel
          GridView = cxGridGoodsRelatedKeys
        end
      end
      object dxBarDockControl1: TdxBarDockControl
        AlignWithMargins = True
        Left = 1
        Top = 1
        Width = 415
        Height = 30
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 1
        Align = dalTop
        AllowDocking = False
        BarManager = dxBarManager
      end
    end
  end
  object pnBottom: TPanel
    Left = 0
    Top = 570
    Width = 1309
    Height = 46
    Align = alBottom
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 2
    DesignSize = (
      1309
      46)
    object btnCancel: TcxButton
      Left = 1196
      Top = 11
      Width = 90
      Height = 29
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Renunta'
      ModalResult = 2
      TabOrder = 1
    end
    object btnOk: TcxButton
      Left = 1086
      Top = 11
      Width = 90
      Height = 29
      Anchors = [akTop, akRight]
      Caption = 'Alege'
      ModalResult = 1
      TabOrder = 0
      OnClick = btnOkClick
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
      'Tools'
      'Related keys'
      'produse')
    Categories.ItemsVisibles = (
      2
      2
      2
      2)
    Categories.Visibles = (
      True
      True
      True
      True)
    DockColor = clBtnFace
    ImageOptions.Images = dmAdditions.cxImageList_SWN
    PopupMenuLinks = <>
    ShowFullMenusAfterDelay = False
    ShowShortCutInHint = True
    SunkenBorder = True
    UseSystemFont = True
    Left = 524
    Top = 4
    PixelsPerInch = 96
    object dxBarManager1Bar2: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Toolbar'
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 38
      FloatTop = 185
      FloatClientWidth = 51
      FloatClientHeight = 24
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          Visible = True
          ItemName = 'bbHome'
        end
        item
          UserDefine = [udPaintStyle]
          Visible = True
          ItemName = 'bbBack'
        end
        item
          UserDefine = [udPaintStyle]
          Visible = True
          ItemName = 'bbForward'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbNewFolder'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbNew'
        end
        item
          UserDefine = [udPaintStyle]
          Visible = True
          ItemName = 'bbModify'
        end
        item
          UserDefine = [udPaintStyle]
          Visible = True
          ItemName = 'bbRemove'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbSearch'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBar1: TdxBar
      Caption = 'Related Keys'
      CaptionButtons = <>
      DockControl = dxBarDockControl2
      DockedDockControl = dxBarDockControl2
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1367
      FloatTop = 2
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbAddSelectedKeys'
        end
        item
          Visible = True
          ItemName = 'bbDeleteKey'
        end
        item
          Visible = True
          ItemName = 'bbRefreshRelatedKeys'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBar2: TdxBar
      Caption = 'Linked Goods'
      CaptionButtons = <>
      DockControl = dxBarDockControl3
      DockedDockControl = dxBarDockControl3
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1367
      FloatTop = 2
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbRefreshGoods'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object bbNew: TdxBarButton
      Caption = 'Cheie noua'
      Category = 0
      Hint = 'Cheie noua'
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 45
      OnClick = bbNewClick
    end
    object bbModify: TdxBarButton
      Caption = 'Modifica...'
      Category = 0
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 115
      OnClick = bbModifyClick
    end
    object bbRemove: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      ShortCut = 16430
      OnClick = bbRemoveClick
    end
    object bbHome: TdxBarButton
      Caption = #1053#1072#1095#1072#1083#1086
      Category = 0
      Hint = #1053#1072#1095#1072#1083#1086
      Visible = ivAlways
      ImageIndex = 27
      ShortCut = 36
      OnClick = bbHomeClick
    end
    object bbBack: TdxBarButton
      Caption = #1053#1072#1079#1072#1076
      Category = 0
      Hint = #1053#1072#1079#1072#1076
      Visible = ivAlways
      ImageIndex = 6
      ShortCut = 8
      OnClick = bbBackClick
    end
    object bbForward: TdxBarButton
      Caption = #1042#1087#1077#1088#1077#1076
      Category = 0
      Hint = #1042#1087#1077#1088#1077#1076
      Visible = ivAlways
      ImageIndex = 7
      OnClick = bbForwardClick
    end
    object bbNewFolder: TdxBarButton
      Caption = 'Mapa noua...'
      Category = 0
      Hint = 'Mapa noua'
      Visible = ivAlways
      ImageIndex = 13
      ShortCut = 16429
      OnClick = bbNewFolderClick
    end
    object bbSearch: TdxBarButton
      Caption = 'Cauta'
      Category = 0
      Hint = 'Cauta'
      Visible = ivAlways
      ImageIndex = 4
      ShortCut = 16454
      OnClick = bbSearchClick
    end
    object bbAddSelectedKeys: TdxBarButton
      Caption = 'Adauga cheile selectate'
      Category = 2
      Hint = 'Adauga cheile selectate'
      Visible = ivAlways
      ImageIndex = 90
      ShortCut = 16416
      OnClick = bbAddSelectedKeysClick
    end
    object bbDeleteKey: TdxBarButton
      Caption = 'Sterge'
      Category = 2
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 92
      OnClick = bbDeleteKeyClick
    end
    object bbRefreshRelatedKeys: TdxBarButton
      Caption = 'Refresh'
      Category = 2
      Hint = 'Refresh'
      Visible = ivAlways
      ImageIndex = 36
      OnClick = bbRefreshRelatedKeysClick
    end
    object bbRefreshGoods: TdxBarButton
      Caption = 'Refresh'
      Category = 3
      Hint = 'Refresh'
      Visible = ivAlways
      ImageIndex = 36
      ShortCut = 116
      OnClick = bbRefreshGoodsClick
    end
  end
  object IBCDataSourceRelatedKeys: TIBCDataSource
    DataSet = IBCQueryRelatedKeys
    Left = 100
    Top = 224
  end
  object IBCTrLocalUpdate: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 76
    Top = 360
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
        ItemName = 'bbNew'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbModify'
      end>
    UseOwnFont = False
    Left = 160
    Top = 160
    PixelsPerInch = 96
  end
  object IBCQueryGoodsRelatedGoods: TIBCQuery
    KeyFields = 'goodsid;related_key'
    Connection = dmDB.IBCConnection
    UpdateTransaction = IBCTrLocalUpdate
    SQL.Strings = (
      'select * '
      'from ts_related_goods '
      'where '
      'goodsid = :goodsid')
    Left = 536
    Top = 264
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'goodsid'
        Value = nil
      end>
  end
  object IBCDataSourceRelatedGoods: TIBCDataSource
    DataSet = IBCQueryGoodsRelatedGoods
    Left = 536
    Top = 192
  end
  object IBCQueryGoods: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'select * from ('
      'select '
      '  rg.related_key f1,'
      '  g.goodsid, '
      '  g.title,'
      '  get_flg_in_price(g.goodsid) flg_in_price,'
      
        '  (select price_mdl from get_goods_price(g.goodsid, 4, 498)) pri' +
        'ce4'
      'from ts_goods g'
      'join ts_related_goods rg on rg.goodsid=g.goodsid'
      ')')
    MasterFields = 'RELATED_KEY'
    DetailFields = 'F1'
    MasterSource = IBCDataSourceRelatedKeys
    Left = 976
    Top = 248
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'RELATED_KEY'
        Value = nil
      end>
  end
  object IBCDataSourceGoods: TIBCDataSource
    DataSet = IBCQueryGoods
    Left = 980
    Top = 200
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 344
    Top = 152
    PixelsPerInch = 96
    object cxStyleExistKey: TcxStyle
      AssignedValues = [svColor]
      Color = clLime
    end
  end
  object IBCQueryRelatedKeys: TIBCQuery
    SQLInsert.Strings = (
      'INSERT INTO TS_RELATED_KEYS'
      '  (RELATED_KEY, PARENT_KEY, FLG_FOLDER, TITLE)'
      'VALUES'
      '  (:RELATED_KEY, :PARENT_KEY, :FLG_FOLDER, :TITLE)')
    SQLDelete.Strings = (
      'DELETE FROM TS_RELATED_KEYS'
      'WHERE'
      '  RELATED_KEY = :Old_RELATED_KEY')
    SQLUpdate.Strings = (
      'UPDATE TS_RELATED_KEYS'
      'SET'
      
        '  RELATED_KEY = :RELATED_KEY, PARENT_KEY = :PARENT_KEY, FLG_FOLD' +
        'ER = :FLG_FOLDER, TITLE = :TITLE'
      'WHERE'
      '  RELATED_KEY = :Old_RELATED_KEY')
    SQLRefresh.Strings = (
      
        'SELECT RELATED_KEY, PARENT_KEY, FLG_FOLDER, TITLE FROM TS_RELATE' +
        'D_KEYS'
      'WHERE'
      '  RELATED_KEY = :RELATED_KEY')
    SQLLock.Strings = (
      'SELECT NULL FROM TS_RELATED_KEYS'
      'WHERE'
      'RELATED_KEY = :Old_RELATED_KEY'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM TS_RELATED_KEYS'
      ''
      ') q')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = IBCTrLocalUpdate
    SQL.Strings = (
      'SELECT'
      ' A.related_key,'
      ' A.PARENT_KEY,'
      ' A.FLG_FOLDER,'
      ' A.TITLE'
      'FROM TS_RELATED_KEYS A'
      
        'LEFT OUTER JOIN TS_RELATED_KEYS A2 ON A2.RELATED_KEY=A.PARENT_KE' +
        'Y'
      'WHERE (A.RELATED_KEY<>'#39#39')'
      'ORDER BY'
      ' A.FLG_FOLDER DESC, A.RELATED_KEY')
    Left = 96
    Top = 288
  end
  object IBCDataSourceResultGoods: TIBCDataSource
    DataSet = IBCQueryResultGoods
    Left = 936
    Top = 352
  end
  object IBCQueryResultGoods: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      
        'select distinct g.goodsid, g.webgoodstype_id, g.webgoodstype_tit' +
        'le, g.title, g.price1_lei, g.flg_in_price from vw_ts_goods g'
      'join ts_related_goods rg on g.goodsid = rg.goodsid'
      
        'join ts_related_goods z on z.goodsid = :goodsid and z.related_ke' +
        'y = rg.related_key'
      'order by  g.flg_in_price desc, g.webgoodstype_title, g.title')
    Left = 936
    Top = 400
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'goodsid'
        Value = nil
      end>
  end
end
