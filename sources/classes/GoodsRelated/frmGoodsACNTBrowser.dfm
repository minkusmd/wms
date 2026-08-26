object frmGoodsRelatedDlg: TfrmGoodsRelatedDlg
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Chei pentru produse inrudite'
  ClientHeight = 510
  ClientWidth = 617
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
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 617
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
    ExplicitWidth = 864
  end
  object pnMain: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 601
    Height = 380
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 12
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 4
    ExplicitLeft = 3
    ExplicitTop = 75
    ExplicitWidth = 848
    ExplicitHeight = 650
    object dxBarDockControl1: TdxBarDockControl
      AlignWithMargins = True
      Left = 0
      Top = 0
      Width = 601
      Height = 30
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 1
      Align = dalTop
      AllowDocking = False
      BarManager = dxBarManager
      ExplicitWidth = 848
    end
    object cxGridGoodsAcnt: TcxGrid
      Left = 0
      Top = 31
      Width = 601
      Height = 349
      Align = alClient
      TabOrder = 1
      ExplicitTop = 34
      ExplicitWidth = 481
      ExplicitHeight = 234
      object cxGridGoodsAcntTable: TcxGridDBTableView
        PopupMenu = dxBarPopupMenu
        OnKeyDown = cxGridGoodsAcntTableKeyUp
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
        OnCellDblClick = cxGridGoodsAcntTableCellDblClick
        OnCustomDrawCell = cxGridGoodsAcntTableCustomDrawCell
        OnFocusedRecordChanged = cxGridGoodsAcntTableFocusedRecordChanged
        DataController.DataModeController.GridMode = True
        DataController.DataModeController.GridModeBufferCount = 50
        DataController.DataSource = IBCDataSourceRelatedKeys
        DataController.KeyFieldNames = 'GOODS_ACNT_ID'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.IncSearch = True
        OptionsBehavior.ImmediateEditor = False
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnGrouping = False
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
        Styles.Footer = dmAdditions.cxStyle_GridHeader
        Styles.Header = dmAdditions.cxStyle_GridHeader
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        object cxGridGoodsAcnt_GOODS_ACNT_ID: TcxGridDBColumn
          AlternateCaption = #1050#1086#1076' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1103
          Caption = 'Cod'
          DataBinding.FieldName = 'GOODS_ACNT_ID'
          HeaderAlignmentHorz = taCenter
          MinWidth = 50
          Options.Filtering = False
          Options.GroupFooters = False
          Options.Grouping = False
          Options.HorzSizing = False
          Options.Moving = False
          Width = 50
        end
        object cxGridGoodsAcntTableFolder: TcxGridDBColumn
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
          MinWidth = 24
          Options.Filtering = False
          Options.Focusing = False
          Options.ShowEditButtons = isebNever
          Options.Grouping = False
          Options.HorzSizing = False
          Options.Moving = False
          Options.ShowCaption = False
          Options.Sorting = False
          VisibleForCustomization = False
          Width = 24
          IsCaptionAssigned = True
        end
        object cxGridGoodsAcnt_QTY: TcxGridDBColumn
          Caption = 'ID'
          DataBinding.FieldName = 'RELATED_KEY'
          PropertiesClassName = 'TcxCalcEditProperties'
          HeaderAlignmentHorz = taCenter
          MinWidth = 150
          Options.HorzSizing = False
          Width = 150
        end
        object cxGridGoodsAcntTableTitle: TcxGridDBColumn
          Caption = 'Denumire'
          DataBinding.FieldName = 'NAMEACNT'
          Options.Moving = False
          Styles.OnGetContentStyle = cxGridGoodsAcntTableTitleStylesGetContentStyle
          VisibleForCustomization = False
        end
        object cxGridGoodsAcnt_LOW_BOUND: TcxGridDBColumn
          Caption = #1053#1080#1078#1085#1080#1081' '#1087#1086#1088#1086#1075
          DataBinding.FieldName = 'LOW_BOUND'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.Alignment.Horz = taRightJustify
          Properties.DisplayFormat = '#,##0.00'
          Visible = False
          HeaderAlignmentHorz = taCenter
          MinWidth = 90
          Options.HorzSizing = False
          Styles.Content = dmAdditions.cxStyle_DocInSpector_Parent
          Width = 90
        end
        object cxGridGoodsAcnt_HIGH_BOUND: TcxGridDBColumn
          Caption = #1042#1077#1088#1093#1085#1080#1081' '#1087#1086#1088#1086#1075
          DataBinding.FieldName = 'HIGH_BOUND'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.Alignment.Horz = taRightJustify
          Properties.DisplayFormat = '#,##0.00'
          Visible = False
          HeaderAlignmentHorz = taCenter
          MinWidth = 90
          Options.HorzSizing = False
          Styles.Content = dmAdditions.cxStyle_DocInSpector_Parent
          Width = 90
        end
      end
      object cxGridGoodsAcntLevel: TcxGridLevel
        GridView = cxGridGoodsAcntTable
      end
    end
  end
  object pnBottom: TPanel
    Left = 0
    Top = 464
    Width = 617
    Height = 46
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 5
    ExplicitTop = 556
    ExplicitWidth = 864
    DesignSize = (
      617
      46)
    object btnCancel: TcxButton
      Left = 504
      Top = 1
      Width = 90
      Height = 29
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Renunta'
      ModalResult = 2
      TabOrder = 1
      ExplicitLeft = 751
    end
    object btnOk: TcxButton
      Left = 404
      Top = 1
      Width = 90
      Height = 29
      Anchors = [akTop, akRight]
      Caption = 'Alege'
      TabOrder = 0
      OnClick = btnOkClick
      ExplicitLeft = 651
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
      'Tools')
    Categories.ItemsVisibles = (
      2
      2)
    Categories.Visibles = (
      True
      True)
    DockColor = clBtnFace
    ImageOptions.Images = dmAdditions.cxImageList_SWN
    PopupMenuLinks = <>
    ShowFullMenusAfterDelay = False
    ShowShortCutInHint = True
    SunkenBorder = True
    UseSystemFont = True
    Left = 444
    Top = 12
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
          Visible = True
          ItemName = 'bbItem'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbAdditionalTools'
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
    object bbNew: TdxBarButton
      Caption = 'Denumire noua...'
      Category = 0
      Hint = 'Denumire noua'
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
      ImageIndex = 5
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
    object bbItem: TdxBarSubItem
      Caption = 'Produse'
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbNewFolder'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbNew'
        end
        item
          BeginGroup = True
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
          ItemName = 'bbRemove'
        end>
    end
    object bbAdditionalTools: TdxBarSubItem
      Caption = 'Instrumente'
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbChangeParent'
        end
        item
          Visible = True
          ItemName = 'bbSortFolders'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton1'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbRelatedGoods'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbGoodsInfoCard'
        end>
    end
    object bbRelatedGoods: TdxBarButton
      Caption = 'Produse anexate la aceasta denumire contabila'
      Category = 0
      Hint = 'Produse anexate la aceasta denumire contabila'
      Visible = ivAlways
      ImageIndex = 12
      ShortCut = 117
      OnClick = bbRelatedGoodsClick
    end
    object bbGoodsInfoCard: TdxBarButton
      Caption = 'Miscarea produselor...'
      Category = 0
      Hint = 'Miscarea produselor'
      Visible = ivAlways
      ShortCut = 16463
    end
    object dxBarButton1: TdxBarButton
      Caption = 'Paste'
      Category = 0
      Hint = 'Paste'
      Visible = ivAlways
      ShortCut = 49238
      OnClick = dxBarButton1Click
    end
    object bbChangeParent: TdxBarButton
      Caption = 'Modifica parinte'
      Category = 1
      Hint = 'Modifica parinte'
      Visible = ivAlways
      OnClick = bbChangeParentClick
    end
    object bbSortFolders: TdxBarButton
      Caption = 'Sorteaza mapele'
      Category = 1
      Hint = 'Sorteaza mapele'
      Visible = ivAlways
      ImageIndex = 38
      OnClick = bbSortFoldersClick
    end
  end
  object IBCDataSourceRelatedKeys: TIBCDataSource
    DataSet = IBCQueryRelatedKeys
    Left = 76
    Top = 248
  end
  object IBCQueryRelatedKeys: TIBCQuery
    UpdatingTable = 'TS_RELATED_KEYS'
    KeyFields = 'RELATED_KEY'
    GeneratorMode = gmInsert
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
    AutoCommit = False
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Options.RequiredFields = False
    LocalConstraints = False
    Left = 76
    Top = 312
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
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbChangeParent'
      end>
    UseOwnFont = False
    Left = 160
    Top = 160
    PixelsPerInch = 96
  end
end
