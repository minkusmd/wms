object frmBanksBrowserDlg: TfrmBanksBrowserDlg
  Left = 0
  Top = 0
  ActiveControl = cxGridBanks
  BorderStyle = bsDialog
  Caption = 'Nomeclator Banci'
  ClientHeight = 485
  ClientWidth = 691
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  DesignSize = (
    691
    485)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 691
    Height = 64
    Title = 'Banci'
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
    Width = 675
    Height = 352
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 0
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelOuter = bvNone
    TabOrder = 1
    object dxBarDockControl1: TdxBarDockControl
      AlignWithMargins = True
      Left = 0
      Top = 0
      Width = 675
      Height = 30
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 1
      Align = dalTop
      AllowDocking = False
      BarManager = dxBarManager
    end
    object cxGridBanks: TcxGrid
      Left = 0
      Top = 31
      Width = 675
      Height = 321
      Align = alClient
      TabOrder = 1
      object cxGridBanksDB: TcxGridDBTableView
        PopupMenu = dxBarPopupMenu
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
        OnCellDblClick = cxGridBanksDBCellDblClick
        OnFocusedRecordChanged = cxGridBanksDBFocusedRecordChanged
        DataController.DataSource = IBCDataSourceBanks
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
        OptionsView.NoDataToDisplayInfoText = '<nu sint inregistrari>'
        OptionsView.ScrollBars = ssVertical
        OptionsView.ShowEditButtons = gsebForFocusedRecord
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        Styles.ContentEven = dmAdditions.cxStyle_GridContentEven
        Styles.Header = dmAdditions.cxStyle_GridHeader
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        object cxGridBanksDBBANKACCOUNT: TcxGridDBColumn
          Caption = 'BIC'
          DataBinding.FieldName = 'BANKACCOUNT'
          MinWidth = 120
          Options.HorzSizing = False
          VisibleForCustomization = False
          Width = 120
        end
        object cxGridBanksDB_BANKNAME: TcxGridDBColumn
          Caption = 'Banca'
          DataBinding.FieldName = 'BANKNAME'
          VisibleForCustomization = False
          Width = 240
        end
        object cxGridBanksDBSWIFT_BIC: TcxGridDBColumn
          Caption = 'SWIFT'
          DataBinding.FieldName = 'SWIFT_BIC'
          Visible = False
          Width = 100
        end
        object cxGridBanksDBADDRESS: TcxGridDBColumn
          Caption = #1040#1076#1088#1077#1089' '#1073#1072#1085#1082#1072
          DataBinding.FieldName = 'ADDRESS'
          Visible = False
          Width = 200
        end
      end
      object cxGridBanksLevel: TcxGridLevel
        GridView = cxGridBanksDB
      end
    end
  end
  object btnOk: TcxButton
    Left = 473
    Top = 440
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    TabOrder = 2
    OnClick = btnOkClick
  end
  object btnCancel: TcxButton
    Left = 577
    Top = 440
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Anuleaza'
    ModalResult = 2
    TabOrder = 3
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
    PopupMenuLinks = <>
    ShowFullMenusAfterDelay = False
    ShowShortCutInHint = True
    SunkenBorder = True
    UseSystemFont = True
    Left = 428
    Top = 68
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
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbNew'
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
    object bbNew: TdxBarButton
      Caption = 'Adauga'
      Category = 0
      Hint = 'Adauga'
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 45
      OnClick = bbNewClick
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
    object bbRemove: TdxBarButton
      Caption = 'Elimina'
      Category = 0
      Hint = 'Elimina'
      Visible = ivAlways
      ImageIndex = 42
      ShortCut = 46
      OnClick = bbRemoveClick
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
  end
  object IBCQueryBanks: TIBCQuery
    SQLInsert.Strings = (
      'INSERT INTO TS_BANKS'
      '  (BANKACCOUNT, BANKNAME, SWIFT_BIC, ADDRESS)'
      'VALUES'
      '  (:BANKACCOUNT, :BANKNAME, :SWIFT_BIC, :ADDRESS)')
    SQLDelete.Strings = (
      'DELETE FROM TS_BANKS'
      'WHERE'
      '  BANKACCOUNT = :Old_BANKACCOUNT')
    SQLUpdate.Strings = (
      'UPDATE TS_BANKS'
      'SET'
      
        '  BANKACCOUNT = :BANKACCOUNT, BANKNAME = :BANKNAME, SWIFT_BIC = ' +
        ':SWIFT_BIC, ADDRESS = :ADDRESS'
      'WHERE'
      '  BANKACCOUNT = :Old_BANKACCOUNT')
    SQLRefresh.Strings = (
      
        'SELECT TS_BANKS.BANKACCOUNT, TS_BANKS.BANKNAME, TS_BANKS.SWIFT_B' +
        'IC, TS_BANKS.ADDRESS FROM TS_BANKS'
      'WHERE'
      '  BANKACCOUNT = :BANKACCOUNT')
    SQLLock.Strings = (
      'SELECT NULL FROM TS_BANKS'
      'WHERE'
      'BANKACCOUNT = :Old_BANKACCOUNT'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    UpdateTransaction = IBCTrUpdate
    SQL.Strings = (
      'SELECT'
      '    BANKACCOUNT,'
      '    BANKNAME,'
      '    SWIFT_BIC,'
      '    ADDRESS'
      'FROM'
      '    TS_BANKS')
    AutoCommit = False
    LockMode = lmLockImmediate
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Left = 52
    Top = 204
  end
  object IBCDataSourceBanks: TIBCDataSource
    DataSet = IBCQueryBanks
    Left = 52
    Top = 156
  end
  object IBCTrUpdate: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 52
    Top = 264
  end
  object dxBarPopupMenu: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbNew'
      end
      item
        Visible = True
        ItemName = 'bbModify'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbRemove'
      end>
    UseOwnFont = False
    Left = 248
    Top = 176
    PixelsPerInch = 96
  end
end
