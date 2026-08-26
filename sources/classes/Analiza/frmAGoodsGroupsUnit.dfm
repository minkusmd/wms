object frmAGoodsGroupsDlg: TfrmAGoodsGroupsDlg
  Left = 0
  Top = 0
  Caption = 'Grupe produse pentru analiza'
  ClientHeight = 522
  ClientWidth = 973
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    973
    522)
  PixelsPerInch = 96
  TextHeight = 15
  object Panel2: TPanel
    Left = 8
    Top = 8
    Width = 961
    Height = 449
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 0
    object Panel1: TPanel
      Left = 0
      Top = 0
      Width = 337
      Height = 445
      Align = alLeft
      BevelKind = bkFlat
      BevelOuter = bvNone
      Color = clWindow
      ParentBackground = False
      TabOrder = 0
      object cxGrid1: TcxGrid
        Left = 0
        Top = 28
        Width = 333
        Height = 413
        Align = alClient
        TabOrder = 1
        object cxGrid1DBTableView1: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          ScrollbarAnnotations.CustomAnnotations = <>
          DataController.DataModeController.GridMode = True
          DataController.DataSource = IBCDataSourceGroups
          DataController.KeyFieldNames = 'GROUPID'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          EditForm.DefaultColumnCount = 1
          EditForm.ItemHotTrack = True
          OptionsBehavior.AlwaysShowEditor = True
          OptionsBehavior.EditMode = emModalEditForm
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
          object cxGrid1DBTableView1GROUPID: TcxGridDBColumn
            Caption = 'Cod'
            DataBinding.FieldName = 'GROUPID'
            VisibleForEditForm = bFalse
            Width = 59
          end
          object cxGrid1DBTableView1TITLE: TcxGridDBColumn
            Caption = 'Denumire grupa'
            DataBinding.FieldName = 'TITLE'
            Width = 272
          end
        end
        object cxGrid1Level1: TcxGridLevel
          GridView = cxGrid1DBTableView1
        end
      end
      object dxBarDockControl1: TdxBarDockControl
        Left = 0
        Top = 0
        Width = 333
        Height = 28
        Align = dalTop
        BarManager = dxBarManager1
      end
    end
    object Panel3: TPanel
      Left = 337
      Top = 0
      Width = 620
      Height = 445
      Align = alClient
      BevelKind = bkFlat
      BevelOuter = bvNone
      Color = clWindow
      ParentBackground = False
      TabOrder = 1
      object dxBarDockControl2: TdxBarDockControl
        Left = 0
        Top = 0
        Width = 616
        Height = 28
        Align = dalTop
        BarManager = dxBarManager1
      end
      object cxGrid2: TcxGrid
        Left = 0
        Top = 28
        Width = 616
        Height = 413
        Align = alClient
        TabOrder = 1
        object cxGrid2DBTableView1: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          ScrollbarAnnotations.CustomAnnotations = <>
          DataController.DataSource = IBCDataSourceGoodsFolders
          DataController.KeyFieldNames = 'GROUPID;GOODSID'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.IncSearch = True
          OptionsBehavior.ImmediateEditor = False
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
          object cxGrid2DBTableView1GOODSID: TcxGridDBColumn
            Caption = 'Cod'
            DataBinding.FieldName = 'GOODSID'
          end
          object cxGrid2DBTableView1GOODS_NAME: TcxGridDBColumn
            Caption = 'Grupa produse'
            DataBinding.FieldName = 'GOODS_NAME'
            Width = 531
          end
        end
        object cxGrid2Level1: TcxGridLevel
          GridView = cxGrid2DBTableView1
        end
      end
    end
  end
  object cxButton1: TcxButton
    Left = 457
    Top = 480
    Width = 90
    Height = 29
    Caption = 'Inchide'
    ModalResult = 8
    TabOrder = 1
  end
  object IBCQueryGroups: TIBCQuery
    KeyFields = 'groupid'
    KeyGenerator = 'gen_ta_groups_id'
    SQLInsert.Strings = (
      'INSERT INTO TA_GROUPS'
      '  (GROUPID, TITLE)'
      'VALUES'
      '  (:GROUPID, :TITLE)')
    SQLDelete.Strings = (
      'DELETE FROM TA_GROUPS'
      'WHERE'
      '  GROUPID = :Old_GROUPID')
    SQLUpdate.Strings = (
      'UPDATE TA_GROUPS'
      'SET'
      '  GROUPID = :GROUPID, TITLE = :TITLE'
      'WHERE'
      '  GROUPID = :Old_GROUPID')
    SQLRefresh.Strings = (
      'SELECT GROUPID, TITLE FROM TA_GROUPS'
      'WHERE'
      '  GROUPID = :GROUPID')
    SQLLock.Strings = (
      'SELECT NULL FROM TA_GROUPS'
      'WHERE'
      'GROUPID = :Old_GROUPID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM TA_GROUPS'
      ''
      ') q')
    UpdateTransaction = IBCTrLocal
    SQL.Strings = (
      'SELECT * '
      'FROM TA_GROUPS')
    Left = 72
    Top = 168
  end
  object IBCDataSourceGroups: TIBCDataSource
    DataSet = IBCQueryGroups
    Left = 72
    Top = 112
  end
  object dxBarManager1: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Default'
      'GroupToolBar'
      'GoodsFolders')
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
    Left = 360
    Top = 80
    PixelsPerInch = 96
    object dxBarManager1Bar1: TdxBar
      Caption = 'GroupToolbar'
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1039
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbNew'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbModify'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbDelete'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar2: TdxBar
      Caption = 'GoodsFolders'
      CaptionButtons = <>
      DockControl = dxBarDockControl2
      DockedDockControl = dxBarDockControl2
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1039
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbGoodsFolderNew'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbGoodsFolderModify'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbGoodsFolderDelete'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object bbNew: TdxBarButton
      Caption = 'Nou'
      Category = 1
      Hint = 'Nou'
      Visible = ivAlways
      ImageIndex = 40
      OnClick = bbNewClick
    end
    object bbModify: TdxBarButton
      Caption = 'Modifica'
      Category = 1
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 41
      OnClick = bbModifyClick
    end
    object bbDelete: TdxBarButton
      Caption = 'Sterge'
      Category = 1
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      OnClick = bbDeleteClick
    end
    object bbGoodsFolderNew: TdxBarButton
      Caption = 'Nou'
      Category = 2
      Hint = 'Nou'
      Visible = ivAlways
      ImageIndex = 40
      OnClick = bbGoodsFolderNewClick
    end
    object bbGoodsFolderModify: TdxBarButton
      Caption = 'Modifica'
      Category = 2
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 41
      OnClick = bbGoodsFolderModifyClick
    end
    object bbGoodsFolderDelete: TdxBarButton
      Caption = 'Sterge'
      Category = 2
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      OnClick = bbGoodsFolderDeleteClick
    end
  end
  object IBCTrLocal: TIBCTransaction
    Left = 184
    Top = 256
  end
  object IBCQueryGoodsFolders: TIBCQuery
    KeyFields = 'groupid;goodsid'
    UpdateTransaction = IBCTrLocal
    SQL.Strings = (
      'SELECT *'
      'FROM VW_TA_GOODS_GROUPS')
    MasterFields = 'GROUPID'
    DetailFields = 'GROUPID'
    MasterSource = IBCDataSourceGroups
    Left = 576
    Top = 224
    ParamData = <
      item
        DataType = ftInteger
        Name = 'GROUPID'
        ParamType = ptInput
        Value = 1
      end>
  end
  object IBCDataSourceGoodsFolders: TIBCDataSource
    DataSet = IBCQueryGoodsFolders
    Left = 576
    Top = 168
  end
end
