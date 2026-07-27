object frmDocumentCommentsV2Dlg: TfrmDocumentCommentsV2Dlg
  Left = 0
  Top = 0
  ActiveControl = edComments
  BorderStyle = bsDialog
  Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080' '#1082' '#1076#1086#1082#1091#1084#1077#1085#1090#1091
  ClientHeight = 547
  ClientWidth = 698
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    698
    547)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 698
    Height = 64
    Title = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080' '#1082' '#1076#1086#1082#1091#1084#1077#1085#1090#1091
    Text = #1044#1086#1073#1072#1074#1090#1077' '#1082#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080' '#1082' '#1076#1086#1082#1091#1084#1077#1085#1090#1091
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
    ImageIndex = 23
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 682
    Height = 422
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    object Label1: TLabel
      Left = 16
      Top = 20
      Width = 117
      Height = 15
      Caption = #1053#1086#1074#1099#1081' '#1082#1086#1084#1084#1077#1085#1090#1072#1088#1080#1081
    end
    object Label2: TLabel
      Left = 16
      Top = 131
      Width = 47
      Height = 15
      Caption = #1048#1089#1090#1086#1088#1080#1103
    end
    object btnAdd: TButton
      Left = 582
      Top = 36
      Width = 75
      Height = 25
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      Default = True
      TabOrder = 1
      OnClick = btnAddClick
    end
    object cxGrid: TcxGrid
      Left = 16
      Top = 148
      Width = 641
      Height = 249
      TabOrder = 2
      object cxGridTable: TcxGridTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnSorting = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsSelection.InvertSelect = False
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1082#1086#1084#1084#1077#1085#1090#1072#1088#1080#1077#1074'>'
        OptionsView.ScrollBars = ssVertical
        OptionsView.CellAutoHeight = True
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        Styles.Header = dmAdditions.cxStyle_GridHeader
        object cxGridTable_USER: TcxGridColumn
          Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
          MinWidth = 100
          Options.HorzSizing = False
          Width = 100
        end
        object cxGridTable_DATA: TcxGridColumn
          Caption = #1044#1072#1090#1072
          MinWidth = 100
          Options.HorzSizing = False
          Width = 100
        end
        object cxGridTable_COMMENTS: TcxGridColumn
          Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1081
        end
      end
      object cxGridLevel: TcxGridLevel
        GridView = cxGridTable
      end
    end
    object edComments: TcxMemo
      Left = 16
      Top = 37
      Properties.ScrollBars = ssVertical
      Properties.VisibleLineCount = 4
      TabOrder = 0
      Width = 560
    end
  end
  object btnOk: TButton
    Left = 480
    Top = 505
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = '&Ok'
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 585
    Top = 505
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
  object cxGridPopupMenu: TcxGridPopupMenu
    Grid = cxGrid
    PopupMenus = <
      item
        GridView = cxGridTable
        HitTypes = [gvhtCell, gvhtRecord]
        Index = 0
        PopupMenu = dxBarPopupMenu1
      end>
    Left = 264
    Top = 272
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
    ImageOptions.StretchGlyphs = False
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 368
    Top = 220
    PixelsPerInch = 96
    object bbDeleteRecord: TdxBarButton
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1079#1072#1087#1080#1089#1100
      Category = 0
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1079#1072#1087#1080#1089#1100
      Visible = ivAlways
      ImageIndex = 35
      OnClick = bbDeleteRecordClick
    end
  end
  object dxBarPopupMenu1: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbDeleteRecord'
      end>
    UseOwnFont = False
    Left = 364
    Top = 332
    PixelsPerInch = 96
  end
end
