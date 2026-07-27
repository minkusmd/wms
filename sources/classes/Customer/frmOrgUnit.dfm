object frmOrgDlg: TfrmOrgDlg
  Left = 0
  Top = 0
  Caption = 'Organizatii'
  ClientHeight = 513
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 321
    Top = 64
    Height = 400
    ExplicitLeft = 8
    ExplicitTop = 8
    ExplicitHeight = 379
  end
  object DialogTitle1: TDialogTitle
    Left = 0
    Top = 0
    Width = 635
    Height = 64
    Title = 'Organizatii'
    Text = 'Gestionarea organizatiilor si subdiviziunilor'
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
    ImageIndex = 15
    ExplicitLeft = 328
    ExplicitTop = 136
    ExplicitWidth = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 64
    Width = 321
    Height = 400
    Align = alLeft
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    ExplicitLeft = -6
    ExplicitTop = 58
    ExplicitHeight = 379
    object dxBarDockControl1: TdxBarDockControl
      Left = 0
      Top = 0
      Width = 321
      Height = 28
      Align = dalTop
      BarManager = dxBarManager1
    end
    object cxGrid1: TcxGrid
      Left = 0
      Top = 28
      Width = 321
      Height = 372
      Align = alClient
      TabOrder = 1
      ExplicitLeft = 32
      ExplicitTop = 88
      ExplicitWidth = 250
      ExplicitHeight = 200
      object cxGrid1DBTableView1: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsView.GroupByBox = False
        object cxGrid1DBTableView1Column1: TcxGridDBColumn
          Caption = 'Cod'
          DataBinding.FieldName = 'CUSTOMERID'
        end
        object cxGrid1DBTableView1Column2: TcxGridDBColumn
          Caption = 'Organizatie'
          DataBinding.FieldName = 'DISPLAYNAME'
          Width = 235
        end
      end
      object cxGrid1Level1: TcxGridLevel
        GridView = cxGrid1DBTableView1
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 464
    Width = 635
    Height = 49
    Align = alBottom
    BevelOuter = bvNone
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    ExplicitTop = 470
    object cxButton1: TcxButton
      Left = 280
      Top = 16
      Width = 90
      Height = 29
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
  end
  object Panel3: TPanel
    Left = 324
    Top = 64
    Width = 311
    Height = 400
    Align = alClient
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 3
    ExplicitLeft = 327
    ExplicitTop = 58
    ExplicitHeight = 379
    object dxBarDockControl2: TdxBarDockControl
      Left = 0
      Top = 0
      Width = 311
      Height = 28
      Align = dalTop
      BarManager = dxBarManager1
    end
    object cxGrid2: TcxGrid
      Left = 0
      Top = 28
      Width = 311
      Height = 372
      Align = alClient
      TabOrder = 1
      ExplicitLeft = 32
      ExplicitTop = 88
      ExplicitWidth = 250
      ExplicitHeight = 200
      object cxGridDBTableView1: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsView.GroupByBox = False
        object cxGridDBTableView1Column1: TcxGridDBColumn
          Caption = 'Cod'
        end
        object cxGridDBTableView1Column2: TcxGridDBColumn
          Caption = 'Subdiviziune'
          Width = 224
        end
      end
      object cxGridLevel1: TcxGridLevel
        GridView = cxGridDBTableView1
      end
    end
  end
  object dxBarManager1: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Default'
      'Organizatii'
      'Subdiviziuni')
    Categories.ItemsVisibles = (
      2
      2
      2)
    Categories.Visibles = (
      True
      True
      True)
    ImageOptions.Images = dmAdditions.cxImageList_SWN
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 312
    Top = 264
    PixelsPerInch = 96
    object dxBarManager1Bar1: TdxBar
      Caption = 'Organizatii'
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 669
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbOrgNew'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbOrgEdit'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbOrgDelete'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar2: TdxBar
      Caption = 'Subdiviziuni'
      CaptionButtons = <>
      DockControl = dxBarDockControl2
      DockedDockControl = dxBarDockControl2
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 669
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbSubDivNew'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbSubDivEdit'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbSubDivDelete'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object bbOrgNew: TdxBarButton
      Caption = 'Nou'
      Category = 1
      Hint = 'Nou'
      Visible = ivAlways
      ImageIndex = 40
    end
    object bbOrgEdit: TdxBarButton
      Caption = 'Modifica'
      Category = 1
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 41
    end
    object bbOrgDelete: TdxBarButton
      Caption = 'Sterge'
      Category = 1
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
    end
    object bbSubDivNew: TdxBarButton
      Caption = 'Nou'
      Category = 2
      Hint = 'Nou'
      Visible = ivAlways
      ImageIndex = 90
    end
    object bbSubDivEdit: TdxBarButton
      Caption = 'Modifica'
      Category = 2
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 91
    end
    object bbSubDivDelete: TdxBarButton
      Caption = 'Sterge'
      Category = 2
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 92
    end
  end
end
