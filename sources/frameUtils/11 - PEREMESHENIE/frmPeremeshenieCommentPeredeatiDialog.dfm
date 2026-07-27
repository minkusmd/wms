object frmPeremeshenieCommentPeredeatiDlg: TfrmPeremeshenieCommentPeredeatiDlg
  Left = 0
  Top = 0
  Caption = 'Mentiuni document'
  ClientHeight = 553
  ClientWidth = 690
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    690
    553)
  PixelsPerInch = 96
  TextHeight = 13
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 690
    Height = 64
    Visible = False
    Title = 'Mentiuni la document'
    Text = 'Adaugati comentarii, mentiuni la acest document'
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
    Width = 674
    Height = 419
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
      Width = 40
      Height = 13
      Caption = 'Mentiuni'
    end
    object Label2: TLabel
      Left = 16
      Top = 131
      Width = 30
      Height = 13
      Caption = 'Istoric'
    end
    object btnAdd: TButton
      Left = 582
      Top = 36
      Width = 75
      Height = 25
      Caption = 'Adauta'
      Default = True
      TabOrder = 0
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
        ScrollbarAnnotations.CustomAnnotations = <>
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
          Caption = 'Utilizator'
          MinWidth = 100
          Options.HorzSizing = False
          Width = 100
        end
        object cxGridTable_DATA: TcxGridColumn
          Caption = 'Data'
          MinWidth = 100
          Options.HorzSizing = False
          Width = 100
        end
        object cxGridTable_COMMENTS: TcxGridColumn
          Caption = 'Mentiuni'
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
      TabOrder = 1
      Width = 560
    end
  end
  object btnOk: TButton
    Left = 496
    Top = 516
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 592
    Top = 516
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
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
