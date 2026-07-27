object frmWebUrlsDialog: TfrmWebUrlsDialog
  Left = 0
  Top = 0
  Caption = 'Gestiune URL'
  ClientHeight = 511
  ClientWidth = 1119
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    1119
    511)
  PixelsPerInch = 96
  TextHeight = 13
  object DialogTitle1: TDialogTitle
    Left = 0
    Top = 0
    Width = 1119
    Height = 64
    Title = 'Gestiune URL'
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
  end
  object Panel1: TPanel
    Left = 9
    Top = 98
    Width = 1102
    Height = 352
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelOuter = bvLowered
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    object cxGrid1: TcxGrid
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 1094
      Height = 344
      Align = alClient
      BorderStyle = cxcbsNone
      TabOrder = 0
      object cxGrid1DBTableView1: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.FocusFirstCellOnNewRecord = True
        OptionsBehavior.IncSearch = True
        OptionsBehavior.ImmediateEditor = False
        OptionsView.GroupByBox = False
        object cxGrid1DBTableView1_URL_ID: TcxGridDBColumn
          Caption = 'ID'
          HeaderAlignmentHorz = taCenter
        end
        object cxGrid1DBTableView1_TITLE: TcxGridDBColumn
          Caption = 'Denumire'
          HeaderAlignmentHorz = taCenter
          Width = 150
        end
        object cxGrid1DBTableView1_FLG_ACTIVE: TcxGridDBColumn
          Caption = 'Activ'
          PropertiesClassName = 'TcxCheckBoxProperties'
          HeaderAlignmentHorz = taCenter
          Width = 32
        end
        object cxGrid1DBTableView1_HUMAN_URL: TcxGridDBColumn
          Caption = 'Seo url'
          HeaderAlignmentHorz = taCenter
          Width = 400
        end
        object cxGrid1DBTableView1_URL: TcxGridDBColumn
          Caption = 'Url'
          HeaderAlignmentHorz = taCenter
          Width = 400
        end
      end
      object cxGrid1Level1: TcxGridLevel
        GridView = cxGrid1DBTableView1
      end
    end
  end
  object Button2: TButton
    Left = 497
    Top = 474
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Inchide'
    ModalResult = 8
    TabOrder = 2
  end
  object dxBarDockControl1: TdxBarDockControl
    Left = 0
    Top = 64
    Width = 1119
    Height = 28
    Align = dalTop
    BarManager = dxBarManager1
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
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 336
    Top = 264
    PixelsPerInch = 96
    object dxBarManager1Bar1: TdxBar
      Caption = 'Main'
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 712
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbNewURL'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbModifyURL'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbDeleteURL'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object bbNewURL: TdxBarButton
      Caption = 'Adauga'
      Category = 0
      Hint = 'Adauga'
      Visible = ivAlways
      ImageIndex = 40
      OnClick = bbNewURLClick
    end
    object bbModifyURL: TdxBarButton
      Caption = 'Modifica'
      Category = 0
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 41
      OnClick = bbModifyURLClick
    end
    object bbDeleteURL: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
    end
  end
  object IBCQuerySeoURL: TIBCQuery
    SQL.Strings = (
      'select * from tweb_urls')
    Left = 568
    Top = 208
  end
  object IBCDataSourceSeoURL: TIBCDataSource
    DataSet = IBCQuerySeoURL
    Left = 568
    Top = 152
  end
end
