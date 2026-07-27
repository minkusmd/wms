object frmUMDialog: TfrmUMDialog
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1045#1076#1080#1085#1080#1094#1099' '#1080#1079#1084#1077#1088#1077#1085#1080#1103
  ClientHeight = 364
  ClientWidth = 688
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 688
    Height = 64
    Title = #1045#1076#1080#1085#1080#1094#1099' '#1080#1079#1084#1077#1088#1077#1085#1080#1103
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
    ImageIndex = 11
  end
  object pnMain: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 672
    Height = 234
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object dxBarDockControl1: TdxBarDockControl
      AlignWithMargins = True
      Left = 0
      Top = 0
      Width = 672
      Height = 30
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 1
      Align = dalTop
      BarManager = dxBarManager
    end
    object cxGridUM: TcxGrid
      Left = 0
      Top = 31
      Width = 672
      Height = 203
      Align = alClient
      TabOrder = 1
      object cxGridUMTable: TcxGridDBTableView
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
        FilterBox.CustomizeDialog = False
        ScrollbarAnnotations.CustomAnnotations = <>
        DataController.DataSource = IBCDataSourceUM
        DataController.KeyFieldNames = 'UMID'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.ImmediateEditor = False
        OptionsCustomize.ColumnGrouping = False
        OptionsCustomize.ColumnMoving = False
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
        OptionsView.ScrollBars = ssNone
        OptionsView.ShowEditButtons = gsebForFocusedRecord
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        Styles.ContentEven = dmAdditions.cxStyle_GridContentEven
        Styles.Header = dmAdditions.cxStyle_GridHeader
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        object cxGridUMTableUMID: TcxGridDBColumn
          Caption = #1050#1086#1076
          DataBinding.FieldName = 'UMID'
          Width = 36
        end
        object cxGridUMTableTITLE: TcxGridDBColumn
          Caption = #1053#1072#1079#1074#1072#1085#1080#1077
          DataBinding.FieldName = 'TITLE'
        end
        object cxGridUMTableK_UM: TcxGridDBColumn
          Caption = #1050
          DataBinding.FieldName = 'K_UM'
          HeaderAlignmentHorz = taCenter
        end
        object cxGridUMTableTITLE2: TcxGridDBColumn
          Caption = #1053#1072#1079#1074#1072#1085#1080#1077' 2'
          DataBinding.FieldName = 'TITLE2'
        end
      end
      object cxGridUMLevel: TcxGridLevel
        GridView = cxGridUMTable
      end
    end
  end
  object btnCancel: TButton
    Left = 572
    Top = 317
    Width = 90
    Height = 29
    Cancel = True
    Caption = #1047#1072#1082#1088#1099#1090#1100
    ModalResult = 2
    TabOrder = 2
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
      'Default')
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    DockColor = clBtnFace
    ImageOptions.Images = dmAdditions.cxImageList_SWN
    NotDocking = [dsNone]
    PopupMenuLinks = <>
    ShowFullMenusAfterDelay = False
    ShowShortCutInHint = True
    SunkenBorder = True
    UseSystemFont = True
    Left = 444
    Top = 16
    PixelsPerInch = 96
    object dxBarManager1Bar1: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Currency'
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 645
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbNewRecord'
        end
        item
          Visible = True
          ItemName = 'bbCurrencyHistory'
        end
        item
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
    object dxBarSubItem1: TdxBarSubItem
      Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1086
      Category = 0
      Enabled = False
      Visible = ivAlways
      ImageIndex = 3
      ItemLinks = <>
    end
    object bbNewRecord: TdxBarButton
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      Category = 0
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 0
      ShortCut = 45
      OnClick = bbNewRecordClick
    end
    object bbCurrencyHistory: TdxBarButton
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      Category = 0
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 1
      PaintStyle = psCaptionGlyph
      ShortCut = 115
      OnClick = bbCurrencyHistoryClick
    end
    object dxBarButton1: TdxBarButton
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Category = 0
      Hint = #1059#1076#1072#1083#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 2
      PaintStyle = psCaptionGlyph
      ShortCut = 16430
    end
  end
  object IBCQueryUM: TIBCQuery
    KeyFields = 'UMID'
    KeyGenerator = 'SQ_TS_UM_UMID'
    SQLInsert.Strings = (
      'INSERT INTO TS_UM'
      '  (UMID, PARENTID, TITLE, K_UM, TITLE2)'
      'VALUES'
      '  (:UMID, :PARENTID, :TITLE, :K_UM, :TITLE2)')
    SQLDelete.Strings = (
      'DELETE FROM TS_UM'
      'WHERE'
      '  UMID = :Old_UMID')
    SQLUpdate.Strings = (
      'UPDATE TS_UM'
      'SET'
      
        '  UMID = :UMID, PARENTID = :PARENTID, TITLE = :TITLE, K_UM = :K_' +
        'UM, TITLE2 = :TITLE2'
      'WHERE'
      '  UMID = :Old_UMID')
    SQLRefresh.Strings = (
      'SELECT UMID, PARENTID, TITLE, K_UM, TITLE2 FROM TS_UM'
      'WHERE'
      '  UMID = :UMID')
    SQLLock.Strings = (
      'SELECT NULL FROM TS_UM'
      'WHERE'
      'UMID = :Old_UMID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'SELECT UMID, PARENTID, TITLE, K_UM, TITLE2'
      '     FROM TS_UM'
      '     where umid>-1'
      '     order by umid')
    AutoCommit = False
    RefreshOptions = [roAfterUpdate]
    Options.RequiredFields = False
    Options.DefaultValues = True
    LocalConstraints = False
    Left = 180
    Top = 152
  end
  object IBCDataSourceUM: TIBCDataSource
    DataSet = IBCQueryUM
    Left = 68
    Top = 152
  end
end
