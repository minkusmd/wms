object frmCrediteRetailDlg: TfrmCrediteRetailDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Gestionarea creditelor retail'
  ClientHeight = 463
  ClientWidth = 674
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object DialogTitle1: TDialogTitle
    Left = 0
    Top = 0
    Width = 674
    Height = 64
    Title = 'Credit'
    Text = 'Gestionarea creditelor retail'
    FontTitle.Charset = DEFAULT_CHARSET
    FontTitle.Color = clWindowText
    FontTitle.Height = -16
    FontTitle.Name = 'Segoe UI'
    FontTitle.Style = [fsBold]
    FontText.Charset = DEFAULT_CHARSET
    FontText.Color = clWindowText
    FontText.Height = -12
    FontText.Name = 'Segoe UI'
    FontText.Style = []
    ImageList = dmAdditions.cxImageList_DialogIcons
    ImageIndex = 28
  end
  object Panel1: TPanel
    Left = 0
    Top = 416
    Width = 674
    Height = 47
    Align = alBottom
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    object btnCancel: TButton
      Left = 320
      Top = 9
      Width = 90
      Height = 30
      Cancel = True
      Caption = 'Renunta'
      ModalResult = 2
      TabOrder = 0
    end
    object btnOK: TButton
      Left = 224
      Top = 9
      Width = 90
      Height = 30
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 1
    end
  end
  object cxGrid1: TcxGrid
    AlignWithMargins = True
    Left = 3
    Top = 95
    Width = 668
    Height = 318
    Align = alClient
    TabOrder = 2
    object cxGrid1DBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      ScrollbarAnnotations.CustomAnnotations = <>
      DataController.DataSource = IBCDataSourceCrediteRetail
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      object cxGrid1DBTableView1_CID: TcxGridDBColumn
        DataBinding.FieldName = 'CID'
        DataBinding.IsNullValueType = True
        HeaderAlignmentHorz = taCenter
        Width = 57
      end
      object cxGrid1DBTableView1_TITLE_RO: TcxGridDBColumn
        Caption = 'RO'
        DataBinding.FieldName = 'TITLE_RO'
        DataBinding.IsNullValueType = True
        HeaderAlignmentHorz = taCenter
        Width = 251
      end
      object cxGrid1DBTableView1_TITLE_RU: TcxGridDBColumn
        Caption = 'RU'
        DataBinding.FieldName = 'TITLE_RU'
        DataBinding.IsNullValueType = True
        HeaderAlignmentHorz = taCenter
        Width = 250
      end
      object cxGrid1DBTableView1_PERCENT_COST: TcxGridDBColumn
        Caption = 'Cost, %'
        DataBinding.FieldName = 'COST'
        DataBinding.IsNullValueType = True
        HeaderAlignmentHorz = taCenter
        Width = 108
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
    end
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
    Left = 552
    Top = 144
    PixelsPerInch = 96
    DockControlHeights = (
      0
      0
      28
      0)
    object dxBarManager1Bar1: TdxBar
      Caption = 'Custom 1'
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 0
      DockedTop = 0
      DockingStyle = dsTop
      FloatLeft = 702
      FloatTop = 2
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbAdd'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbEdit'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbDelete'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbProductsList'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object bbAdd: TdxBarButton
      Caption = 'Nou'
      Category = 0
      Hint = 'Nou'
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 45
      OnClick = bbAddClick
    end
    object bbEdit: TdxBarButton
      Caption = 'Modifica'
      Category = 0
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 115
      OnClick = bbEditClick
    end
    object bbDelete: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      ShortCut = 16430
      OnClick = bbDeleteClick
    end
    object bbProductsList: TdxBarButton
      Caption = 'Produse'
      Category = 0
      Hint = 'Produse'
      Visible = ivAlways
      ImageIndex = 12
      ShortCut = 117
    end
  end
  object IBCQueryCrediteRetail: TIBCQuery
    KeyFields = 'CID'
    KeyGenerator = 'gen_tcredite_retail_id'
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = IBCTrUpdate
    SQL.Strings = (
      'select * from TCREDITE_RETAIL')
    Left = 136
    Top = 240
  end
  object IBCDataSourceCrediteRetail: TIBCDataSource
    DataSet = IBCQueryCrediteRetail
    Left = 136
    Top = 184
  end
  object IBCTrUpdate: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 328
    Top = 240
  end
end
