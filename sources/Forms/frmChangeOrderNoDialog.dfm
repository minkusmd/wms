object frmChangeOrderNoDlg: TfrmChangeOrderNoDlg
  Left = 0
  Top = 0
  ActiveControl = cxTree
  BorderIcons = [biSystemMenu]
  ClientHeight = 566
  ClientWidth = 515
  Color = clBtnFace
  Constraints.MinHeight = 400
  Constraints.MinWidth = 500
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 515
    Height = 64
    Text = 'Modifica ordinea de vizionare a elementelor'#13#10
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
    Width = 499
    Height = 408
    Margins.Left = 8
    Margins.Top = 1
    Margins.Right = 8
    Margins.Bottom = 12
    Align = alClient
    Bands = <
      item
      end>
    DragMode = dmAutomatic
    Images = dmAdditions.cxImageList_SWN
    Navigator.Buttons.CustomButtons = <>
    OptionsBehavior.ImmediateEditor = False
    OptionsBehavior.ChangeDelay = 1000
    OptionsBehavior.DragCollapse = False
    OptionsBehavior.DragDropText = True
    OptionsBehavior.DragFocusing = True
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
    PopupMenu = dxBarPopupMenu
    ScrollbarAnnotations.CustomAnnotations = <>
    Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
    Styles.ColumnHeader = dmAdditions.cxStyle_GridHeader
    Styles.ContentEven = dmAdditions.cxStyle_GridContentEven
    TabOrder = 2
    OnDragDrop = cxTreeDragDrop
    OnDragOver = cxTreeDragOver
    OnFocusedNodeChanged = cxTreeFocusedNodeChanged
    OnKeyDown = cxTreeKeyDown
    OnMoveTo = cxTreeMoveTo
    object cxTree_TITLE: TcxTreeListColumn
      Caption.Text = 'Folder'
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
  object dxBarDockControl1: TdxBarDockControl
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 499
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
  object pnBottom: TPanel
    Left = 0
    Top = 524
    Width = 515
    Height = 42
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    DesignSize = (
      515
      42)
    object btnOk: TcxButton
      AlignWithMargins = True
      Left = 312
      Top = 0
      Width = 90
      Height = 29
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 16
      Margins.Bottom = 12
      Anchors = [akTop, akRight]
      Caption = 'OK'
      Default = True
      TabOrder = 0
      OnClick = btnOkClick
    end
    object btnCancel: TcxButton
      AlignWithMargins = True
      Left = 410
      Top = 0
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
  object IBCQuery: TIBCQuery
    Connection = dmDB.IBCConnection
    AutoCommit = False
    Left = 188
    Top = 205
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
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbSortAscending'
        end
        item
          Visible = True
          ItemName = 'bbSortDescending'
        end
        item
          BeginGroup = True
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
      OnClick = bbMoveUpClick
    end
    object bbMoveDown: TdxBarButton
      Caption = 'In jos'
      Category = 0
      Hint = 'In jos'
      Visible = ivAlways
      ImageIndex = 8
      OnClick = bbMoveDownClick
    end
    object bbSortAscending: TdxBarButton
      Caption = 'A-Z'
      Category = 0
      Hint = 'A-Z'
      Visible = ivAlways
      OnClick = bbSortAscendingClick
    end
    object bbSortDescending: TdxBarButton
      Caption = 'Z-A'
      Category = 0
      Hint = 'Z-A'
      Visible = ivAlways
      OnClick = bbSortDescendingClick
    end
    object bbMoveTop: TdxBarButton
      Caption = #1055#1077#1088#1077#1084#1077#1089#1090#1080#1090#1100' '#1074' '#1085#1072#1095#1072#1083#1086
      Category = 0
      Hint = #1055#1077#1088#1077#1084#1077#1089#1090#1080#1090#1100' '#1074' '#1085#1072#1095#1072#1083#1086
      Visible = ivAlways
      OnClick = bbMoveTopClick
    end
    object bbMoveBottom: TdxBarButton
      Caption = #1055#1077#1088#1077#1084#1077#1089#1090#1080#1090#1100' '#1074' '#1082#1086#1085#1077#1094
      Category = 0
      Hint = #1055#1077#1088#1077#1084#1077#1089#1090#1080#1090#1100' '#1074' '#1082#1086#1085#1077#1094
      Visible = ivAlways
      OnClick = bbMoveBottomClick
    end
  end
  object dxBarPopupMenu: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbMoveUp'
      end
      item
        Visible = True
        ItemName = 'bbMoveDown'
      end
      item
        Visible = True
        ItemName = 'bbMoveTop'
      end
      item
        Visible = True
        ItemName = 'bbMoveBottom'
      end>
    UseOwnFont = False
    Left = 292
    Top = 236
    PixelsPerInch = 96
  end
end
