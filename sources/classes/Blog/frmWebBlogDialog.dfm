object frmWebBlogDlg: TfrmWebBlogDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Articole web'
  ClientHeight = 520
  ClientWidth = 775
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
    Width = 775
    Height = 64
    Title = 'Articole web'
    Text = 'Gestionarea articolor din blog'
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
    ImageIndex = 41
  end
  object Panel1: TPanel
    Left = 0
    Top = 479
    Width = 775
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 6
    object cxButton1: TcxButton
      Left = 536
      Top = 8
      Width = 90
      Height = 29
      Caption = 'OK'
      ModalResult = 1
      TabOrder = 0
    end
    object cxButton2: TcxButton
      Left = 641
      Top = 8
      Width = 90
      Height = 29
      Caption = 'Renunta'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object cxGrid1: TcxGrid
    Left = 0
    Top = 92
    Width = 775
    Height = 387
    Align = alClient
    TabOrder = 2
    object cxGrid1DBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      ScrollbarAnnotations.CustomAnnotations = <>
      DataController.DataSource = IBCDataSourceBlog
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.InvertSelect = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      OptionsView.Indicator = True
      object cxGrid1DBTableView1BLOGID: TcxGridDBColumn
        Caption = 'ID'
        DataBinding.FieldName = 'BLOGID'
        DataBinding.IsNullValueType = True
        Width = 47
      end
      object cxGrid1DBTableView1DATA: TcxGridDBColumn
        Caption = 'Data'
        DataBinding.FieldName = 'DATA'
        DataBinding.IsNullValueType = True
        Width = 123
      end
      object cxGrid1DBTableView1TITLE_RO: TcxGridDBColumn
        Caption = 'Titlu'
        DataBinding.FieldName = 'TITLE_RO'
        DataBinding.IsNullValueType = True
        Width = 293
      end
      object cxGrid1DBTableView1TITLE_RU: TcxGridDBColumn
        Caption = #1053#1072#1079#1074#1072#1085#1080#1077
        DataBinding.FieldName = 'TITLE_RU'
        DataBinding.IsNullValueType = True
        Width = 310
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
    Left = 472
    Top = 32
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
      FloatLeft = 793
      FloatTop = 2
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbNew'
        end
        item
          Visible = True
          ItemName = 'bbEdit'
        end
        item
          Visible = True
          ItemName = 'bbDelete'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object bbNew: TdxBarButton
      Caption = 'Nou'
      Category = 0
      Hint = 'Nou'
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 45
      OnClick = bbNewClick
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
  end
  object IBCQueryBlog: TIBCQuery
    KeyFields = 'BLOGID'
    KeyGenerator = 'gen_tweb_blog_id'
    SQLInsert.Strings = (
      'INSERT INTO TWEB_BLOG'
      
        '  (BLOGID, DATA, TITLE_RO, TITLE_RU, IMAGE_RO, IMAGE_RU, ARTICLE' +
        '_RO, ARTICLE_RU)'
      'VALUES'
      
        '  (:BLOGID, :DATA, :TITLE_RO, :TITLE_RU, :IMAGE_RO, :IMAGE_RU, :' +
        'ARTICLE_RO, :ARTICLE_RU)')
    SQLDelete.Strings = (
      'DELETE FROM TWEB_BLOG'
      'WHERE'
      '  BLOGID = :Old_BLOGID')
    SQLUpdate.Strings = (
      'UPDATE TWEB_BLOG'
      'SET'
      
        '  BLOGID = :BLOGID, DATA = :DATA, TITLE_RO = :TITLE_RO, TITLE_RU' +
        ' = :TITLE_RU, IMAGE_RO = :IMAGE_RO, IMAGE_RU = :IMAGE_RU, ARTICL' +
        'E_RO = :ARTICLE_RO, ARTICLE_RU = :ARTICLE_RU'
      'WHERE'
      '  BLOGID = :Old_BLOGID')
    SQLRefresh.Strings = (
      
        'SELECT BLOGID, DATA, TITLE_RO, TITLE_RU, IMAGE_RO, IMAGE_RU, ART' +
        'ICLE_RO, ARTICLE_RU FROM TWEB_BLOG'
      'WHERE'
      '  BLOGID = :BLOGID')
    SQLLock.Strings = (
      'SELECT NULL FROM TWEB_BLOG'
      'WHERE'
      'BLOGID = :Old_BLOGID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM TWEB_BLOG'
      ''
      ') q')
    UpdateTransaction = IBCTrLocal
    SQL.Strings = (
      'select * from tweb_blog'
      'order by data desc')
    AutoCommit = False
    Left = 80
    Top = 192
  end
  object IBCDataSourceBlog: TIBCDataSource
    DataSet = IBCQueryBlog
    Left = 80
    Top = 128
  end
  object IBCTrLocal: TIBCTransaction
    Left = 472
    Top = 256
  end
end
