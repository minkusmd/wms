object frmWebPromoSortingActiuniDlg: TfrmWebPromoSortingActiuniDlg
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
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
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
    Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
    Styles.ColumnHeader = dmAdditions.cxStyle_GridHeader
    Styles.ContentEven = dmAdditions.cxStyle_GridContentEven
    TabOrder = 1
    OnDragDrop = cxTreeDragDrop
    OnDragOver = cxTreeDragOver
    object cxTree_TITLE: TcxTreeListColumn
      Caption.Text = 'Element'
      DataBinding.ValueType = 'String'
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
      DataBinding.ValueType = 'String'
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
    TabOrder = 2
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
    KeyFields = 'PROMOACTIONID'
    KeyGenerator = 'SQ_TWEB_PROMOS_ID'
    GeneratorMode = gmInsert
    SQLInsert.Strings = (
      'INSERT INTO VW_TWEB_PROMOS'
      
        '  (PROMOACTIONID, TITLE, START_DATE, END_DATE, ORDERNO,FLG_ENABL' +
        'ED, FLG_SHOW_BANNER, FLG_SHOW_GOODS, FLG_SHOW_BRICKS)'
      'VALUES'
      
        '  (:PROMOACTIONID, :TITLE, :START_DATE, :END_DATE, :ORDERNO,:FLG' +
        '_ENABLED, :FLG_SHOW_BANNER, :FLG_SHOW_GOODS, :FLG_SHOW_BRICKS)')
    SQLDelete.Strings = (
      'DELETE FROM TWEB_PROMOS'
      'WHERE'
      '  PROMOACTIONID = :Old_PROMOACTIONID')
    SQLUpdate.Strings = (
      'UPDATE VW_TWEB_PROMOS'
      'SET'
      ' TITLE = :TITLE, '
      ' START_DATE = :START_DATE, '
      ' END_DATE = :END_DATE, '
      ' ORDERNO = :ORDERNO,'
      ' FLG_ENABLED = :FLG_ENABLED,'
      ' FLG_SHOW_BANNER = :FLG_SHOW_BANNER, '
      ' FLG_SHOW_GOODS = :FLG_SHOW_GOODS, '
      ' FLG_SHOW_BRICKS = :FLG_SHOW_BRICKS'
      'WHERE'
      '  PROMOACTIONID = :Old_PROMOACTIONID')
    SQLRefresh.Strings = (
      'SELECT '
      ' PROMOACTIONID, '
      ' TITLE, '
      ' START_DATE, '
      ' END_DATE, '
      ' ORDERNO,'
      ' FLG_ENABLED,'
      ' FLG_SHOW_BANNER, '
      ' FLG_SHOW_GOODS, '
      ' FLG_SHOW_BRICKS,'
      ' IIF(FLG_ENABLED=1,'
      '     IIF(DATEDIFF(DAY, CURRENT_DATE, END_DATE)<0,NULL,'
      
        '         IIF(DATEDIFF(DAY, CURRENT_DATE, END_DATE)>0,DATEDIFF(DA' +
        'Y, CURRENT_DATE, END_DATE),'#39#1089#1077#1075#1086#1076#1085#1103#39')'
      '        ),NULL'
      '    ) DAYS_REMAIN '
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
    UpdateTransaction = IBCtrUpdate
    SQL.Strings = (
      'SELECT '
      ' PROMOACTIONID, '
      ' TITLE, '
      ' START_DATE, '
      ' END_DATE, '
      ' ORDERNO,'
      ' FLG_ENABLED,'
      ' FLG_SHOW_BANNER, '
      ' FLG_SHOW_GOODS, '
      ' FLG_SHOW_BRICKS,'
      ' IIF(FLG_ENABLED=1,'
      '     IIF(DATEDIFF(DAY, CURRENT_DATE, END_DATE)<0,NULL,'
      
        '         IIF(DATEDIFF(DAY, CURRENT_DATE, END_DATE)>0,DATEDIFF(DA' +
        'Y, CURRENT_DATE, END_DATE),'#39#1089#1077#1075#1086#1076#1085#1103#39')'
      '        ),NULL'
      '    ) DAYS_REMAIN'
      'FROM '
      ' VW_TWEB_PROMOS'
      'WHERE FLG_ENABLED=1 AND DATEDIFF(DAY, CURRENT_DATE, END_DATE)>0'
      'ORDER BY'
      ' orderno')
    AutoCommit = False
    LockMode = lmLockImmediate
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Constraints = <>
    Left = 104
    Top = 280
  end
end
