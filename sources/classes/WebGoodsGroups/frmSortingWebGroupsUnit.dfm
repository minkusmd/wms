object frmSortingWebGroupsDlg: TfrmSortingWebGroupsDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Sortarea elementelor'
  ClientHeight = 557
  ClientWidth = 645
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poMainFormCenter
  TextHeight = 13
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 645
    Height = 64
    Title = 'Sortarea elementelor'
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
    ImageIndex = 7
  end
  object cxTree: TcxTreeList
    AlignWithMargins = True
    Left = 8
    Top = 104
    Width = 629
    Height = 399
    Margins.Left = 8
    Margins.Top = 1
    Margins.Right = 8
    Margins.Bottom = 12
    Align = alClient
    Bands = <
      item
      end>
    DragMode = dmAutomatic
    Navigator.Buttons.CustomButtons = <>
    OptionsBehavior.ImmediateEditor = False
    OptionsBehavior.ChangeDelay = 1000
    OptionsBehavior.DragCollapse = False
    OptionsBehavior.DragDropText = True
    OptionsBehavior.DragFocusing = True
    OptionsBehavior.IncSearch = True
    OptionsBehavior.Sorting = False
    OptionsCustomizing.ColumnCustomizing = False
    OptionsCustomizing.ColumnHorzSizing = False
    OptionsCustomizing.ColumnMoving = False
    OptionsData.Editing = False
    OptionsData.Deleting = False
    OptionsSelection.CellSelect = False
    OptionsView.ScrollBars = ssVertical
    OptionsView.ColumnAutoWidth = True
    OptionsView.ShowRoot = False
    ScrollbarAnnotations.CustomAnnotations = <>
    Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
    Styles.ColumnHeader = dmAdditions.cxStyle_GridHeader
    Styles.ContentEven = dmAdditions.cxStyle_GridContentEven
    TabOrder = 2
    OnDragDrop = cxTreeDragDrop
    OnDragOver = cxTreeDragOver
    object cxTree_TITLE: TcxTreeListColumn
      Caption.Text = 'Element'
      Width = 100
      Position.ColIndex = 0
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
    end
    object cxTree_ID: TcxTreeListColumn
      PropertiesClassName = 'TcxLabelProperties'
      Properties.Alignment.Horz = taRightJustify
      Caption.AlignHorz = taCenter
      Caption.Text = 'Cod'
      Options.Sizing = False
      Width = 50
      Position.ColIndex = 1
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 515
    Width = 645
    Height = 42
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    DesignSize = (
      645
      42)
    object Button1: TButton
      AlignWithMargins = True
      Left = 442
      Top = 6
      Width = 90
      Height = 29
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 16
      Margins.Bottom = 12
      Anchors = [akTop, akRight]
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
    object Button2: TButton
      AlignWithMargins = True
      Left = 540
      Top = 6
      Width = 90
      Height = 29
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 16
      Margins.Bottom = 12
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Renunta'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object dxBarDockControl1: TdxBarDockControl
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 629
    Height = 30
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 1
    Align = dalTop
    BarManager = dxBarManager
    SunkenBorder = True
    UseOwnSunkenBorder = True
  end
  object dxBarManager: TdxBarManager
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
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 344
    Top = 144
    PixelsPerInch = 96
    object dxBarManagerBar1: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'FS'
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 487
      FloatTop = 34
      FloatClientWidth = 146
      FloatClientHeight = 24
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          Visible = True
          ItemName = 'bbMoveUp'
        end
        item
          UserDefine = [udPaintStyle]
          Visible = True
          ItemName = 'bbMoveDown'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object bbMoveUp: TdxBarButton
      Caption = 'In sus'
      Category = 0
      Hint = 'In sus'
      Visible = ivAlways
      ImageIndex = 9
      ShortCut = 16422
      OnClick = bbMoveUpClick
    end
    object bbMoveDown: TdxBarButton
      Caption = 'In jos'
      Category = 0
      Hint = 'In jos'
      Visible = ivAlways
      ImageIndex = 8
      ShortCut = 16424
      OnClick = bbMoveDownClick
    end
  end
  object IBCtrUpdate: TIBCTransaction
    Left = 312
    Top = 280
  end
  object IBCQueryActiuni: TIBCQuery
    KeyFields = 'GGID'
    KeyGenerator = 'SQ_TWEB_PROMOS_ID'
    GeneratorMode = gmInsert
    SQLInsert.Strings = (
      'INSERT INTO TWEB_FP_GROUPS'
      
        '  (GGID, DATA1, DATA2, TITLE_RO, TITLE_RU, META_DSC_RO, META_DSC' +
        '_RU, ORDERNO)'
      'VALUES'
      
        '  (:GGID, :DATA1, :DATA2, :TITLE_RO, :TITLE_RU, :META_DSC_RO, :M' +
        'ETA_DSC_RU, :ORDERNO)')
    SQLDelete.Strings = (
      'DELETE FROM TWEB_FP_GROUPS'
      'WHERE'
      '  GGID = :Old_GGID')
    SQLUpdate.Strings = (
      'UPDATE TWEB_FP_GROUPS'
      'SET'
      
        '  GGID = :GGID, DATA1 = :DATA1, DATA2 = :DATA2, TITLE_RO = :TITL' +
        'E_RO, TITLE_RU = :TITLE_RU, META_DSC_RO = :META_DSC_RO, META_DSC' +
        '_RU = :META_DSC_RU, ORDERNO = :ORDERNO'
      'WHERE'
      '  GGID = :Old_GGID')
    SQLRefresh.Strings = (
      
        'SELECT GGID, DATA1, DATA2, TITLE_RO, TITLE_RU, META_DSC_RO, META' +
        '_DSC_RU, ORDERNO FROM TWEB_FP_GROUPS'
      'WHERE'
      '  GGID = :GGID')
    SQLLock.Strings = (
      'SELECT NULL FROM TWEB_FP_GROUPS'
      'WHERE'
      'GGID = :Old_GGID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM TWEB_FP_GROUPS'
      ''
      ') q')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = IBCtrUpdate
    SQL.Strings = (
      'SELECT '
      'GGID, '
      
        'DATA1, DATA2, TITLE_RO, TITLE_RU, META_DSC_RO, META_DSC_RU, ORDE' +
        'RNO'
      'FROM '
      ' TWEB_FP_GROUPS'
      'WHERE '
      
        '  CURRENT_DATE BETWEEN CAST(DATA1 AS DATE) AND CAST(DATA2 AS DAT' +
        'E)'
      'ORDER BY'
      ' ORDERNO')
    CachedUpdates = True
    AutoCommit = False
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Left = 104
    Top = 280
  end
end
