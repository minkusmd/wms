object frmDocumentInspectorDlg: TfrmDocumentInspectorDlg
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Document Inspector'
  ClientHeight = 694
  ClientWidth = 763
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poOwnerFormCenter
  OnKeyUp = FormKeyUp
  TextHeight = 13
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 763
    Height = 64
    Title = 'Document Inspector'
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
    object Shape1: TShape
      Left = 276
      Top = 11
      Width = 33
      Height = 15
      Brush.Color = 14548957
    end
    object Shape3: TShape
      Left = 346
      Top = 11
      Width = 33
      Height = 15
    end
    object Label1: TLabel
      Left = 259
      Top = 28
      Width = 63
      Height = 26
      Alignment = taCenter
      Caption = 'Documentul Selectat'
      WordWrap = True
    end
    object Shape2: TShape
      Left = 207
      Top = 11
      Width = 33
      Height = 15
      Brush.Color = 14675967
    end
    object Label2: TLabel
      Left = 204
      Top = 28
      Width = 36
      Height = 13
      Caption = 'Parinte'
    end
    object Label3: TLabel
      Left = 340
      Top = 28
      Width = 59
      Height = 26
      Caption = 'Documente derivate'
      WordWrap = True
    end
  end
  object cxGrid: TcxGrid
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 747
    Height = 614
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alClient
    TabOrder = 1
    object cxGridTable: TcxGridTableView
      OnCustomDrawCell = cxGridTableCustomDrawCell
      OptionsBehavior.CopyCaptionsToClipboard = False
      OptionsBehavior.ColumnHeaderHints = False
      OptionsBehavior.CopyPreviewToClipboard = False
      OptionsBehavior.ImmediateEditor = False
      OptionsCustomize.ColumnFiltering = False
      OptionsCustomize.ColumnGrouping = False
      OptionsCustomize.ColumnMoving = False
      OptionsCustomize.ColumnSorting = False
      OptionsCustomize.ColumnsQuickCustomizationReordering = qcrDisabled
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.InvertSelect = False
      OptionsView.CellEndEllipsis = True
      OptionsView.NoDataToDisplayInfoText = ' '
      OptionsView.CellAutoHeight = True
      OptionsView.EditAutoHeightBorderColor = clBlack
      OptionsView.GridLineColor = 13750737
      OptionsView.GroupByBox = False
      OptionsView.HeaderHeight = 36
      OptionsView.Indicator = True
      Styles.Header = dmAdditions.cxStyle_GridHeader
      OnColumnHeaderClick = cxGridTableColumnHeaderClick
    end
    object cxGridLevel: TcxGridLevel
      GridView = cxGridTable
    end
  end
  object pnLoading: TPanel
    Left = 276
    Top = 276
    Width = 237
    Height = 61
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    ShowCaption = False
    TabOrder = 2
    object Label4: TLabel
      Left = 68
      Top = 13
      Width = 71
      Height = 13
      Caption = 'Incarca datele'
    end
    object ProgressBar1: TProgressBar
      Left = 12
      Top = 32
      Width = 209
      Height = 17
      Smooth = True
      Style = pbstMarquee
      MarqueeInterval = 50
      TabOrder = 0
    end
  end
  object cxGridPopupMenu1: TcxGridPopupMenu
    Grid = cxGrid
    PopupMenus = <
      item
        GridView = cxGridTable
        HitTypes = [gvhtCell]
        Index = 0
        PopupMenu = dxBarPopupMenu1
      end>
    AlwaysFireOnPopup = True
    Left = 356
    Top = 140
  end
  object dxBarPopupMenu1: TdxBarPopupMenu
    BarManager = dxBarManager1
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbCopyValue'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbGotoDocument'
      end
      item
        Visible = True
        ItemName = 'bbGotoIncident'
      end>
    UseOwnFont = False
    OnPopup = dxBarPopupMenu1Popup
    Left = 228
    Top = 208
    PixelsPerInch = 96
  end
  object dxBarManager1: TdxBarManager
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
    ImageOptions.StretchGlyphs = False
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 480
    Top = 16
    PixelsPerInch = 96
    object bbGotoDocument: TdxBarButton
      Caption = #1055#1077#1088#1077#1081#1090#1080' '#1082' '#1076#1086#1082#1091#1084#1077#1085#1090#1091
      Category = 0
      Hint = #1055#1077#1088#1077#1081#1090#1080' '#1082' '#1076#1086#1082#1091#1084#1077#1085#1090#1091
      Visible = ivAlways
      OnClick = bbGotoDocumentClick
    end
    object bbCopyValue: TdxBarButton
      Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1079#1085#1072#1095#1077#1085#1080#1077
      Category = 0
      Hint = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1079#1085#1072#1095#1077#1085#1080#1077
      Visible = ivAlways
      ImageIndex = 29
      ShortCut = 16451
      OnClick = bbCopyValueClick
    end
    object bbGotoIncident: TdxBarButton
      Caption = #1055#1077#1088#1077#1081#1090#1080' '#1082' '#1080#1085#1094#1080#1076#1077#1085#1090#1091
      Category = 0
      Hint = #1055#1077#1088#1077#1081#1090#1080' '#1082' '#1080#1085#1094#1080#1076#1077#1085#1090#1091
      Visible = ivAlways
      OnClick = bbGotoIncidentClick
    end
  end
end
