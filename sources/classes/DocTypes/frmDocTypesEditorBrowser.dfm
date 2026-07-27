object frmDocTypesEditorDlg: TfrmDocTypesEditorDlg
  Left = 0
  Top = 0
  ActiveControl = cxTreeActions
  BorderIcons = [biSystemMenu]
  Caption = 'Tipuri de documente'
  ClientHeight = 630
  ClientWidth = 1197
  Color = clBtnFace
  Constraints.MinHeight = 400
  Constraints.MinWidth = 600
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnClose = FormClose
  DesignSize = (
    1197
    630)
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 1197
    Height = 64
    Title = 'Tipuri de documente'
    Text = 'Tipuri de documente si proprietatile lor'
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
  object dxBarDockControl3: TdxBarDockControl
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 1181
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
  object cxTreeActions: TcxTreeList
    AlignWithMargins = True
    Left = 8
    Top = 103
    Width = 1181
    Height = 466
    Margins.Left = 8
    Margins.Top = 0
    Margins.Right = 8
    Margins.Bottom = 0
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    Bands = <
      item
      end>
    DragMode = dmAutomatic
    FindPanel.DisplayMode = fpdmAlways
    Images = dmAdditions.cxImageList_SWN
    Navigator.Buttons.CustomButtons = <>
    OptionsBehavior.ImmediateEditor = False
    OptionsBehavior.ChangeDelay = 1000
    OptionsBehavior.Sorting = False
    OptionsCustomizing.BandCustomizing = False
    OptionsData.Deleting = False
    OptionsSelection.CellSelect = False
    OptionsView.CellAutoHeight = True
    OptionsView.ScrollBars = ssVertical
    OptionsView.ColumnAutoWidth = True
    OptionsView.GridLineColor = 13750737
    OptionsView.GridLines = tlglVert
    OptionsView.UseImageIndexForSelected = False
    PopupMenu = pmActions
    ScrollbarAnnotations.CustomAnnotations = <>
    Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
    Styles.ColumnHeader = dmAdditions.cxStyle_GridHeader
    Styles.ContentEven = dmAdditions.cxStyle_GridContentEven
    TabOrder = 3
    OnCustomDrawDataCell = cxTreeActionsCustomDrawDataCell
    OnDblClick = cxTreeActionsDblClick
    OnDeletion = cxTreeActionsDeletion
    OnDragDrop = cxTreeActionsDragDrop
    OnDragOver = cxTreeActionsDragOver
    OnFocusedNodeChanged = cxTreeActionsFocusedNodeChanged
    OnMoveTo = cxTreeActionsMoveTo
    ExplicitLeft = 11
    ExplicitTop = 102
    object cxTreeActionscxTreeListColumn1: TcxTreeListColumn
      PropertiesClassName = 'TcxLabelProperties'
      Properties.Alignment.Vert = taVCenter
      Caption.Text = 'Denumire'
      Options.Customizing = False
      Options.IncSearch = False
      Options.Moving = False
      Options.Sorting = False
      Width = 200
      Position.ColIndex = 0
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
      OnGetDisplayText = cxTreeActionscxTreeListColumn1GetDisplayText
    end
    object cxTreeActions_STRUCTMASK: TcxTreeListColumn
      PropertiesClassName = 'TcxCheckComboBoxProperties'
      Properties.Delimiter = ', '
      Properties.ShowEmptyText = False
      Properties.Items = <
        item
        end>
      Caption.Text = 'Vizibilitate'
      DataBinding.ValueType = 'Integer'
      Options.Sizing = False
      Width = 220
      Position.ColIndex = 1
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
      OnGetDisplayText = cxTreeActions_STRUCTMASKGetDisplayText
    end
    object cxTreeActionscxTreeListColumn2: TcxTreeListColumn
      Visible = False
      Caption.Text = #1057#1086#1082#1088'.'
      Options.Sizing = False
      Width = 50
      Position.ColIndex = 2
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
    end
    object cxTreeActions_FLG_ACCESS_VISIBLE: TcxTreeListColumn
      PropertiesClassName = 'TcxCheckBoxProperties'
      Caption.AlignHorz = taCenter
      Caption.Text = 'View'
      DataBinding.ValueType = 'Boolean'
      Width = 30
      Position.ColIndex = 3
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
    end
    object cxTreeActionscxTreeListColumn3: TcxTreeListColumn
      PropertiesClassName = 'TcxLabelProperties'
      Properties.Alignment.Horz = taCenter
      Caption.AlignHorz = taCenter
      Caption.Text = 'Tabsheet'
      Options.Sizing = False
      Width = 60
      Position.ColIndex = 4
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
      OnGetDisplayText = cxTreeActionscxTreeListColumn3GetDisplayText
    end
    object cxTreeActions_IMAGEINDEX: TcxTreeListColumn
      PropertiesClassName = 'TcxImageComboBoxProperties'
      Properties.Alignment.Horz = taCenter
      Properties.Images = dmAdditions.cxImageList_MainTabs
      Properties.Items = <>
      Caption.AlignHorz = taCenter
      Caption.Text = 'Iconita'
      DataBinding.ValueType = 'Integer'
      Options.Sizing = False
      Options.ShowEditButtons = eisbNever
      Width = 60
      Position.ColIndex = 5
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
    end
    object cxTreeActions_FLG_MONEY: TcxTreeListColumn
      PropertiesClassName = 'TcxLabelProperties'
      Properties.Alignment.Horz = taCenter
      Styles.Content = dmAdditions.cxStyle_DocTypeFlag
      Caption.AlignHorz = taCenter
      Caption.Text = 'M'
      Options.Sizing = False
      Width = 30
      Position.ColIndex = 6
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
      OnGetDisplayText = cxTreeActions_FLG_MONEYGetDisplayText
    end
    object cxTreeActions_FLG_DEBTS: TcxTreeListColumn
      PropertiesClassName = 'TcxLabelProperties'
      Properties.Alignment.Horz = taCenter
      Styles.Content = dmAdditions.cxStyle_DocTypeFlag
      Caption.AlignHorz = taCenter
      Caption.Text = 'D'
      Options.Sizing = False
      Width = 30
      Position.ColIndex = 7
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
      OnGetDisplayText = cxTreeActions_FLG_DEBTSGetDisplayText
    end
    object cxTreeActions_FLG_INVOICE: TcxTreeListColumn
      PropertiesClassName = 'TcxLabelProperties'
      Properties.Alignment.Horz = taCenter
      Styles.Content = dmAdditions.cxStyle_DocTypeFlag
      Caption.AlignHorz = taCenter
      Caption.Text = 'P'
      Options.Sizing = False
      Width = 30
      Position.ColIndex = 8
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
      OnGetDisplayText = cxTreeActions_FLG_INVOICEGetDisplayText
    end
    object cxTreeActions_FLG_SIGN: TcxTreeListColumn
      PropertiesClassName = 'TcxLabelProperties'
      Properties.Alignment.Horz = taCenter
      Styles.Content = dmAdditions.cxStyle_Bold
      Caption.AlignHorz = taCenter
      Caption.Text = '+/-'
      Options.Sizing = False
      Width = 30
      Position.ColIndex = 11
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
      OnGetDisplayText = cxTreeActions_FLG_SIGNGetDisplayText
    end
    object cxTreeActions_FLG_TRANSFER: TcxTreeListColumn
      PropertiesClassName = 'TcxLabelProperties'
      Properties.Alignment.Horz = taCenter
      Styles.Content = dmAdditions.cxStyle_DocTypeFlag
      Caption.AlignHorz = taCenter
      Caption.Text = 'T'
      Options.Sizing = False
      Width = 30
      Position.ColIndex = 10
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
      OnGetDisplayText = cxTreeActions_FLG_TRANSFERGetDisplayText
    end
    object cxTreeActions_FLG_ACNT_INVOICE: TcxTreeListColumn
      PropertiesClassName = 'TcxLabelProperties'
      Properties.Alignment.Horz = taCenter
      Styles.Content = dmAdditions.cxStyle_DocTypeFlag
      Caption.AlignHorz = taCenter
      Caption.ShowEndEllipsis = False
      Caption.Text = 'Cnt'
      Options.Sizing = False
      Width = 32
      Position.ColIndex = 9
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
      OnGetDisplayText = cxTreeActions_FLG_ACNT_INVOICEGetDisplayText
    end
    object cxTreeActions_FLG_SERVICE_QTY: TcxTreeListColumn
      PropertiesClassName = 'TcxLabelProperties'
      Properties.Alignment.Horz = taCenter
      Styles.Content = dmAdditions.cxStyle_DocTypeFlag
      Caption.AlignHorz = taCenter
      Caption.Text = 'Service'
      Options.Sizing = False
      Width = 36
      Position.ColIndex = 12
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
      OnGetDisplayText = cxTreeActions_FLG_SERVICE_QTYGetDisplayText
    end
    object cxTreeActions_FLG_ASSEMBLE: TcxTreeListColumn
      PropertiesClassName = 'TcxLabelProperties'
      Properties.Alignment.Horz = taCenter
      Styles.Content = dmAdditions.cxStyle_DocTypeFlag
      Caption.AlignHorz = taCenter
      Caption.Text = 'Producere'
      Options.Sizing = False
      Width = 50
      Position.ColIndex = 13
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
      OnGetDisplayText = cxTreeActions_FLG_ASSEMBLEGetDisplayText
    end
    object cxTreeActions_FLG_ACHITARI: TcxTreeListColumn
      PropertiesClassName = 'TcxLabelProperties'
      Properties.Alignment.Horz = taCenter
      Styles.Content = dmAdditions.cxStyle_DocTypeFlag
      Caption.AlignHorz = taCenter
      Caption.Text = 'Recalcul'
      Options.Sizing = False
      Width = 64
      Position.ColIndex = 14
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
      OnGetDisplayText = cxTreeActions_FLG_ACHITARIGetDisplayText
    end
    object cxTreeActions_FLG_URP_UCET: TcxTreeListColumn
      PropertiesClassName = 'TcxLabelProperties'
      Properties.Alignment.Horz = taCenter
      Styles.Content = dmAdditions.cxStyle_DocTypeFlag
      Caption.AlignHorz = taCenter
      Caption.Text = 'UU'
      Width = 24
      Position.ColIndex = 15
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
      OnGetDisplayText = cxTreeActions_FLG_URP_UCETGetDisplayText
    end
    object cxTreeActions_FLG_BUH_UCET: TcxTreeListColumn
      PropertiesClassName = 'TcxLabelProperties'
      Properties.Alignment.Horz = taCenter
      Styles.Content = dmAdditions.cxStyle_DocTypeFlag
      Caption.AlignHorz = taCenter
      Caption.Text = 'BU'
      Width = 24
      Position.ColIndex = 16
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
      OnGetDisplayText = cxTreeActions_FLG_BUH_UCETGetDisplayText
    end
  end
  object btnOk: TcxButton
    Left = 991
    Top = 583
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    TabOrder = 2
    OnClick = btnOkClick
  end
  object btnCancel: TcxButton
    Left = 1091
    Top = 583
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 4
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
      'Actions'
      'Options')
    Categories.ItemsVisibles = (
      2
      2
      2)
    Categories.Visibles = (
      True
      True
      True)
    DockColor = clBtnFace
    ImageOptions.Images = dmAdditions.cxImageList_SWN
    NotDocking = [dsNone]
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 536
    Top = 152
    PixelsPerInch = 96
    object dxBarManagerBar1: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Actions'
      CaptionButtons = <>
      DockControl = dxBarDockControl3
      DockedDockControl = dxBarDockControl3
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 563
      FloatTop = 8
      FloatClientWidth = 115
      FloatClientHeight = 130
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          Visible = True
          ItemName = 'bbSecNewArea'
        end
        item
          UserDefine = [udPaintStyle]
          Visible = True
          ItemName = 'bbSecNewItem'
        end
        item
          UserDefine = [udPaintStyle]
          Visible = True
          ItemName = 'bbSecNewAction'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbSecModify'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbSecDelete'
        end
        item
          Visible = True
          ItemName = 'dxBarButton3'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbSubAdditional'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarSubItem1'
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
      Caption = #1042#1074#1077#1088#1093
      Category = 0
      Hint = #1042#1074#1077#1088#1093
      Visible = ivAlways
      ImageIndex = 9
      ShortCut = 16469
      OnClick = bbMoveUpClick
    end
    object bbMoveDown: TdxBarButton
      Caption = #1042#1085#1080#1079
      Category = 0
      Hint = #1042#1085#1080#1079
      Visible = ivAlways
      ImageIndex = 8
      ShortCut = 16452
      OnClick = bbMoveDownClick
    end
    object bbDocAnalytics: TdxBarButton
      Caption = 'Analitica tipului de document'
      Category = 0
      Hint = 'Analitica tipului de document'
      Visible = ivAlways
      ImageIndex = 50
      ShortCut = 116
      OnClick = bbDocAnalyticsClick
    end
    object bbDocDefaults: TdxBarButton
      Caption = 'Valorile implicite pentr tipull de document'
      Category = 0
      Hint = 'Valorile implicite pentr tipull de document'
      Visible = ivAlways
      ImageIndex = 25
      ShortCut = 117
      OnClick = bbDocDefaultsClick
    end
    object dxBarSubItem1: TdxBarSubItem
      Caption = 'Instrumente'
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbDocAnalytics'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbDocDefaults'
        end
        item
          Visible = True
          ItemName = 'bbDocumentStates'
        end>
    end
    object bbDocumentStates: TdxBarButton
      Caption = 'Starile documentului'
      Category = 0
      Hint = 'Starile documentului'
      Visible = ivAlways
      ShortCut = 118
      OnClick = bbDocumentStatesClick
    end
    object dxBarButton3: TdxBarButton
      Caption = 'Vizualizare grupe setate'
      Category = 0
      Hint = 'Vizualizare grupe setate'
      Visible = ivAlways
      OnClick = dxBarButton3Click
    end
    object bbSecNewArea: TdxBarButton
      Caption = 'Regiune noua'
      Category = 1
      Hint = 'Regiune noua'
      Visible = ivAlways
      ImageIndex = 14
      OnClick = bbSecNewAreaClick
    end
    object bbSecNewItem: TdxBarButton
      Caption = 'Element nou'
      Category = 1
      Hint = 'Element nou'
      Visible = ivAlways
      ImageIndex = 16
      OnClick = bbSecNewItemClick
    end
    object bbSecNewAction: TdxBarButton
      Caption = 'Actiune noua'
      Category = 1
      Hint = 'Actiune noua'
      Visible = ivAlways
      ImageIndex = 17
      OnClick = bbSecNewActionClick
    end
    object bbSecModify: TdxBarButton
      Caption = 'Modifica'
      Category = 1
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 115
      OnClick = bbSecModifyClick
    end
    object bbSecDelete: TdxBarButton
      Caption = 'Sterge'
      Category = 1
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      ShortCut = 16430
      OnClick = bbSecDeleteClick
    end
    object bbCreateDDL: TdxBarButton
      Caption = 'Create Const list'
      Category = 1
      Hint = 'Create Const list'
      Visible = ivAlways
      ImageIndex = 5
    end
    object bbSubAdditional: TdxBarSubItem
      Caption = 'Optiuni'
      Category = 2
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbNewIDs'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton1'
        end
        item
          Visible = True
          ItemName = 'dxBarButton2'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbExportDocTypes'
        end>
    end
    object bbNewIDs: TdxBarButton
      Caption = 'Genereaza ID-uri noi'
      Category = 2
      Hint = 'Genereaza ID-uri noi'
      Visible = ivAlways
      ButtonStyle = bsChecked
      UnclickAfterDoing = False
    end
    object dxBarButton1: TdxBarButton
      Caption = 'Export Pascal Const list...'
      Category = 2
      Hint = 'Export Pascal Const list'
      Visible = ivAlways
      OnClick = dxBarButton1Click
    end
    object dxBarButton2: TdxBarButton
      Caption = 'Export Text list...'
      Category = 2
      Hint = 'Export Text list'
      Visible = ivAlways
      OnClick = dxBarButton2Click
    end
    object bbExportDocTypes: TdxBarButton
      Caption = 'Export Pascal DocTypes...'
      Category = 2
      Hint = 'Export Pascal DocTypes'
      Visible = ivAlways
      OnClick = bbExportDocTypesClick
    end
  end
  object pmActions: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbSecModify'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbSecNewArea'
      end
      item
        Visible = True
        ItemName = 'bbSecNewItem'
      end
      item
        Visible = True
        ItemName = 'bbSecNewAction'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbMoveUp'
      end
      item
        Visible = True
        ItemName = 'bbMoveDown'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbSecDelete'
      end>
    UseOwnFont = False
    Left = 168
    Top = 164
    PixelsPerInch = 96
  end
end
