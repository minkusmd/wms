object frmGroupGoodsAnalizeDlg: TfrmGroupGoodsAnalizeDlg
  Left = 0
  Top = 0
  ActiveControl = cxGrid1
  BorderStyle = bsDialog
  Caption = 'Grupa de produse pentru analiza financiara'
  ClientHeight = 526
  ClientWidth = 791
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 15
  object Panel1: TPanel
    Left = 8
    Top = 70
    Width = 385
    Height = 403
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    object dxBarDockControl1: TdxBarDockControl
      Left = 0
      Top = 0
      Width = 385
      Height = 28
      Align = dalTop
      BarManager = dxBarManager1
    end
    object cxGrid1: TcxGrid
      Left = 0
      Top = 28
      Width = 385
      Height = 375
      Align = alClient
      TabOrder = 1
      object cxGrid1DBTableView1: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        DataController.DataSource = IBCDataSourceAG
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.IncSearch = True
        OptionsBehavior.ImmediateEditor = False
        OptionsView.ColumnAutoWidth = True
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        object cxGrid1DBTableView1GGID: TcxGridDBColumn
          Caption = 'cod'
          DataBinding.FieldName = 'GGID'
          HeaderAlignmentHorz = taCenter
        end
        object cxGrid1DBTableView1TITLE: TcxGridDBColumn
          Caption = 'Denumire'
          DataBinding.FieldName = 'TITLE'
          HeaderAlignmentHorz = taCenter
          Width = 300
        end
      end
      object cxGrid1Level1: TcxGridLevel
        GridView = cxGrid1DBTableView1
      end
    end
  end
  object Panel2: TPanel
    Left = 399
    Top = 70
    Width = 378
    Height = 403
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 2
    object dxBarDockControl2: TdxBarDockControl
      Left = 0
      Top = 0
      Width = 378
      Height = 28
      Align = dalTop
      BarManager = dxBarManager1
    end
    object cxGrid2: TcxGrid
      Left = 0
      Top = 28
      Width = 378
      Height = 375
      Align = alClient
      TabOrder = 1
      object cxGridDBTableView1: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        DataController.DataSource = IBCDataSourceGG
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.IncSearch = True
        OptionsBehavior.ImmediateEditor = False
        OptionsView.ColumnAutoWidth = True
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        object cxGridDBTableView1FOLDERGOODSID: TcxGridDBColumn
          Caption = 'cod'
          DataBinding.FieldName = 'FOLDERGOODSID'
          HeaderAlignmentHorz = taCenter
        end
        object cxGridDBTableView1FOLDERNAME: TcxGridDBColumn
          Caption = 'denumire'
          DataBinding.FieldName = 'FOLDERNAME'
          HeaderAlignmentHorz = taCenter
          Width = 300
        end
      end
      object cxGridLevel1: TcxGridLevel
        GridView = cxGridDBTableView1
      end
    end
  end
  object btnOK: TcxButton
    Left = 671
    Top = 489
    Width = 90
    Height = 29
    Caption = 'Inchide'
    Default = True
    ModalResult = 1
    TabOrder = 3
  end
  object DialogTitle1: TDialogTitle
    Left = 0
    Top = 0
    Width = 791
    Height = 64
    Title = 'Analiza vinzarilor'
    Text = 'Grupe de produse pentru analiza vinzarilor...'
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
    ImageIndex = 1
  end
  object dxBarManager1: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Default'
      'Groups Analize'
      'Goods Groups')
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
    Left = 16
    Top = 88
    PixelsPerInch = 96
    object dxBarManager1Bar1: TdxBar
      Caption = 'Groups Analize'
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1012
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbgaNew'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbgaEdit'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbaDelete'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'dxBarButton1'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar2: TdxBar
      Caption = 'Goods Groups'
      CaptionButtons = <>
      DockControl = dxBarDockControl2
      DockedDockControl = dxBarDockControl2
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1012
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbggNew'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbggDelete'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarButton1: TdxBarButton
      Caption = 'Analiza'
      Category = 0
      Hint = 'Analiza'
      Visible = ivAlways
      ImageIndex = 116
      OnClick = dxBarButton1Click
    end
    object bbgaNew: TdxBarButton
      Caption = 'Nou'
      Category = 1
      Hint = 'Nou'
      Visible = ivAlways
      ImageIndex = 90
      OnClick = bbgaNewClick
    end
    object bbgaEdit: TdxBarButton
      Caption = 'Modifica'
      Category = 1
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 91
      OnClick = bbgaEditClick
    end
    object bbaDelete: TdxBarButton
      Caption = 'Sterge'
      Category = 1
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 92
    end
    object bbggNew: TdxBarButton
      Caption = 'Nou'
      Category = 2
      Hint = 'Nou'
      Visible = ivAlways
      ImageIndex = 90
      OnClick = bbggNewClick
    end
    object bbggDelete: TdxBarButton
      Caption = 'Sterge'
      Category = 2
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 92
      OnClick = bbggDeleteClick
    end
  end
  object IBCQueryAG: TIBCQuery
    KeyFields = 'GGID'
    KeyGenerator = 'gen_trp_ggid'
    SQLInsert.Strings = (
      'INSERT INTO TRP_GOODS_GROUPS'
      '  (GGID, TITLE, MANAGED_BY)'
      'VALUES'
      '  (:GGID, :TITLE, :MANAGED_BY)')
    SQLDelete.Strings = (
      'DELETE FROM TRP_GOODS_GROUPS'
      'WHERE'
      '  GGID = :Old_GGID')
    SQLUpdate.Strings = (
      'UPDATE TRP_GOODS_GROUPS'
      'SET'
      '  GGID = :GGID, TITLE = :TITLE, MANAGED_BY = :MANAGED_BY'
      'WHERE'
      '  GGID = :Old_GGID')
    SQLRefresh.Strings = (
      'SELECT GGID, TITLE, MANAGED_BY FROM TRP_GOODS_GROUPS'
      'WHERE'
      '  GGID = :GGID')
    SQLLock.Strings = (
      'SELECT NULL FROM TRP_GOODS_GROUPS'
      'WHERE'
      'GGID = :Old_GGID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM TRP_GOODS_GROUPS'
      ''
      ') q')
    UpdateTransaction = IBCTrLocalUpdate
    SQL.Strings = (
      'select * from TRP_GOODS_GROUPS')
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Left = 136
    Top = 184
  end
  object IBCDataSourceAG: TIBCDataSource
    DataSet = IBCQueryAG
    Left = 136
    Top = 120
  end
  object IBCQueryGG: TIBCQuery
    KeyFields = 'ggid;foldergoodsid'
    SQLInsert.Strings = (
      'INSERT INTO VW_TRP_GOODS_GROUPS_LINKS'
      '  (GGID, FOLDERGOODSID, FOLDERNAME)'
      'VALUES'
      '  (:GGID, :FOLDERGOODSID, :FOLDERNAME)')
    SQLDelete.Strings = (
      'DELETE FROM VW_TRP_GOODS_GROUPS_LINKS'
      'WHERE'
      '  GGID = :Old_GGID AND FOLDERGOODSID = :Old_FOLDERGOODSID')
    SQLUpdate.Strings = (
      'UPDATE VW_TRP_GOODS_GROUPS_LINKS'
      'SET'
      
        '  GGID = :GGID, FOLDERGOODSID = :FOLDERGOODSID, FOLDERNAME = :FO' +
        'LDERNAME'
      'WHERE'
      '  GGID = :Old_GGID AND FOLDERGOODSID = :Old_FOLDERGOODSID')
    SQLRefresh.Strings = (
      
        'SELECT GGID, FOLDERGOODSID, FOLDERNAME FROM VW_TRP_GOODS_GROUPS_' +
        'LINKS'
      'WHERE'
      '  GGID = :GGID AND FOLDERGOODSID = :FOLDERGOODSID')
    SQLLock.Strings = (
      'SELECT NULL FROM TRP_GOODS_GROUPS_LINKS'
      'WHERE'
      'GGID = :Old_GGID AND FOLDERGOODSID = :Old_FOLDERGOODSID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM VW_TRP_GOODS_GROUPS_LINKS'
      ''
      ') q')
    UpdateTransaction = IBCTrLocalUpdate
    SQL.Strings = (
      'select * from VW_TRP_GOODS_GROUPS_LINKS')
    MasterFields = 'GGID'
    DetailFields = 'GGID'
    MasterSource = IBCDataSourceAG
    AutoCommit = False
    Left = 472
    Top = 176
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'GGID'
        Value = nil
      end>
  end
  object IBCDataSourceGG: TIBCDataSource
    DataSet = IBCQueryGG
    Left = 472
    Top = 120
  end
  object IBCTrLocalUpdate: TIBCTransaction
    Left = 320
    Top = 120
  end
end
