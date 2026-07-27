object frmSortingWebGroupsGoodsDlg: TfrmSortingWebGroupsGoodsDlg
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
      Width = 30
      Position.ColIndex = 1
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
    end
    object cxTree_PRICE: TcxTreeListColumn
      PropertiesClassName = 'TcxCalcEditProperties'
      Properties.Alignment.Horz = taRightJustify
      Properties.DisplayFormat = '0.00'
      Caption.AlignHorz = taCenter
      Caption.Text = 'Pret, MDL'
      Width = 24
      Position.ColIndex = 2
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
      'INSERT INTO VW_TWEB_FP_GROUPS_GOODS'
      
        '  (GGID, GOODSID, GOODSNAME, CREATED_BY, CREATED_BY_NAME, ORDERN' +
        'O)'
      'VALUES'
      
        '  (:GGID, :GOODSID, :GOODSNAME, :CREATED_BY, :CREATED_BY_NAME, :' +
        'ORDERNO)')
    SQLDelete.Strings = (
      'DELETE FROM VW_TWEB_FP_GROUPS_GOODS'
      'WHERE'
      '  GGID = :Old_GGID AND GOODSID = :Old_GOODSID')
    SQLUpdate.Strings = (
      'UPDATE VW_TWEB_FP_GROUPS_GOODS'
      'SET'
      
        '  GGID = :GGID, GOODSID = :GOODSID, GOODSNAME = :GOODSNAME, CREA' +
        'TED_BY = :CREATED_BY, CREATED_BY_NAME = :CREATED_BY_NAME, ORDERN' +
        'O = :ORDERNO'
      'WHERE'
      '  GGID = :Old_GGID AND GOODSID = :Old_GOODSID')
    SQLRefresh.Strings = (
      
        'SELECT GGID, GOODSID, GOODSNAME, CREATED_BY, CREATED_BY_NAME, OR' +
        'DERNO FROM VW_TWEB_FP_GROUPS_GOODS'
      'WHERE'
      '  GGID = :Old_GGID AND GOODSID = :Old_GOODSID')
    SQLLock.Strings = (
      'SELECT NULL FROM TWEB_FP_GROUPS_GOODS'
      'WHERE'
      'GGID = :Old_GGID AND GOODSID = :Old_GOODSID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM VW_TWEB_FP_GROUPS_GOODS'
      ''
      ') q')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = IBCtrUpdate
    SQL.Strings = (
      
        'select gg.GGID, gg.GOODSID, gg.GOODSNAME, gg.CREATED_BY, gg.CREA' +
        'TED_BY_NAME, gg.orderno, mi.price1_lei price,'
      'iif(exists(select GOODSID'
      ' from TDB_GOODS_FLAGS'
      ' where GOODSID = GG.GOODSID and'
      '       FLAGTYPEID in (3, 5) and'
      '       DT = 5213), 1, 0) FLG_FORCED'
      'from VW_TWEB_FP_GROUPS_GOODS GG'
      'inner join WEB_GET_GOODS_MIN_INFO(gg.goodsid) mi on 1=1'
      'where GG.GGID = :GGID'
      ''
      '  ')
    CachedUpdates = True
    AutoCommit = False
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Left = 104
    Top = 280
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'GGID'
        Value = nil
      end>
  end
end
