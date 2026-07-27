object frmSystemPeriodDlg: TfrmSystemPeriodDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Gestiunea la perioadelor'
  ClientHeight = 258
  ClientWidth = 628
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 15
  object cxGrid1: TcxGrid
    Left = 8
    Top = 37
    Width = 612
    Height = 169
    TabOrder = 3
    object cxGrid1DBTableView1: TcxGridDBTableView
      OnDblClick = cxGrid1DBTableView1DblClick
      Navigator.Buttons.CustomButtons = <>
      ScrollbarAnnotations.CustomAnnotations = <>
      DataController.DataSource = IBCDataSourceSystemPeriods
      DataController.KeyFieldNames = 'ID'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      EditForm.DefaultColumnCount = 3
      EditForm.DefaultStretch = fsHorizontal
      EditForm.UseDefaultLayout = False
      OptionsBehavior.IncSearch = True
      OptionsBehavior.ImmediateEditor = False
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.HideFocusRectOnExit = False
      OptionsSelection.InvertSelect = False
      OptionsSelection.UnselectFocusedRecordOnExit = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      OptionsView.Indicator = True
      object cxGrid1DBTableView1ID: TcxGridDBColumn
        Caption = #1050#1086#1076
        DataBinding.FieldName = 'ID'
        Visible = False
        HeaderGlyphAlignmentHorz = taCenter
        MinWidth = 48
        Options.Editing = False
        Options.Focusing = False
        Options.GroupFooters = False
        Options.Grouping = False
        Options.HorzSizing = False
        Options.Moving = False
        Options.Sorting = False
        Width = 48
      end
      object cxGrid1DBTableView1DATA1: TcxGridDBColumn
        Caption = 'Data initiala'
        DataBinding.FieldName = 'DATA1'
        PropertiesClassName = 'TcxDateEditProperties'
        HeaderGlyphAlignmentHorz = taCenter
        LayoutItem = cxGrid1DBTableView1LayoutItem1.Owner
        Width = 93
      end
      object cxGrid1DBTableView1DATA2: TcxGridDBColumn
        Caption = 'Data finala'
        DataBinding.FieldName = 'DATA2'
        PropertiesClassName = 'TcxDateEditProperties'
        HeaderGlyphAlignmentHorz = taCenter
        LayoutItem = cxGrid1DBTableView1LayoutItem2.Owner
        Width = 95
      end
      object cxGrid1DBTableView1DESCRIPTION: TcxGridDBColumn
        Caption = 'Mentiuni'
        DataBinding.FieldName = 'DESCRIPTION'
        PropertiesClassName = 'TcxMemoProperties'
        HeaderAlignmentHorz = taCenter
        LayoutItem = cxGrid1DBTableView1LayoutItem4.Owner
        Width = 410
      end
      object cxGrid1DBTableView1RootGroup: TcxGridInplaceEditFormGroup
        AlignHorz = ahClient
        AlignVert = avTop
        CaptionOptions.Text = 'Template Card'
        ButtonOptions.Buttons = <>
        Hidden = True
        ShowBorder = False
        Index = -1
      end
      object cxGrid1DBTableView1LayoutItem1: TcxGridInplaceEditFormLayoutItem
        Parent = cxGrid1DBTableView1Group2.Owner
        AlignHorz = ahClient
        AlignVert = avTop
        Index = 0
      end
      object cxGrid1DBTableView1LayoutItem2: TcxGridInplaceEditFormLayoutItem
        Parent = cxGrid1DBTableView1Group2.Owner
        AlignHorz = ahClient
        AlignVert = avTop
        Index = 1
      end
      object cxGrid1DBTableView1LayoutItem4: TcxGridInplaceEditFormLayoutItem
        Parent = cxGrid1DBTableView1RootGroup
        AlignHorz = ahClient
        AlignVert = avTop
        Index = 1
      end
      object cxGrid1DBTableView1Group2: TdxLayoutAutoCreatedGroup
        Parent = cxGrid1DBTableView1RootGroup
        LayoutDirection = ldHorizontal
        Index = 0
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
    end
  end
  object btnClose: TcxButton
    Left = 257
    Top = 221
    Width = 90
    Height = 29
    Caption = 'Inchide'
    ModalResult = 8
    TabOrder = 4
  end
  object IBCQuerySystemPeriods: TIBCQuery
    KeyFields = 'ID'
    KeyGenerator = 'GEN_TDB_OPEN_PERIODS_ID'
    SQLInsert.Strings = (
      'INSERT INTO TDB_OPEN_PERIODS'
      '  (ID, DATA1, DATA2, DESCRIPTION, ACC$MASK)'
      'VALUES'
      '  (:ID, :DATA1, :DATA2, :DESCRIPTION, :ACC$MASK)')
    SQLDelete.Strings = (
      'DELETE FROM TDB_OPEN_PERIODS'
      'WHERE'
      '  ID = :Old_ID')
    SQLUpdate.Strings = (
      'UPDATE TDB_OPEN_PERIODS'
      'SET'
      
        '  ID = :ID, DATA1 = :DATA1, DATA2 = :DATA2, DESCRIPTION = :DESCR' +
        'IPTION, ACC$MASK = :ACC$MASK'
      'WHERE'
      '  ID = :Old_ID')
    SQLRefresh.Strings = (
      
        'SELECT ID, DATA1, DATA2, DESCRIPTION, ACC$MASK FROM TDB_OPEN_PER' +
        'IODS'
      'WHERE'
      '  ID = :ID')
    SQLLock.Strings = (
      'SELECT NULL FROM TDB_OPEN_PERIODS'
      'WHERE'
      'ID = :Old_ID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM TDB_OPEN_PERIODS'
      ''
      ') q')
    Connection = dmDB.IBCConnection
    UpdateTransaction = IBCTrUpdate
    SQL.Strings = (
      'SELECT * FROM '
      'TDB_OPEN_PERIODS')
    IndexFieldNames = 'ID'
    Left = 57
    Top = 86
  end
  object IBCDataSourceSystemPeriods: TIBCDataSource
    DataSet = IBCQuerySystemPeriods
    Left = 58
    Top = 34
  end
  object IBCTrUpdate: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 210
    Top = 42
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
    Left = 303
    Top = 123
    PixelsPerInch = 96
    DockControlHeights = (
      0
      0
      28
      0)
    object dxBarManager1Bar1: TdxBar
      Caption = 'Main'
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 0
      DockedTop = 0
      DockingStyle = dsTop
      FloatLeft = 652
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarButton1'
        end
        item
          Visible = True
          ItemName = 'dxBarButton3'
        end
        item
          Visible = True
          ItemName = 'dxBarButton2'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarButton1: TdxBarButton
      Caption = 'Nou'
      Category = 0
      Hint = 'Nou'
      Visible = ivAlways
      ImageIndex = 0
      PaintStyle = psCaptionGlyph
      ShortCut = 45
      OnClick = dxBarButton1Click
    end
    object dxBarButton2: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 2
      PaintStyle = psCaptionGlyph
      ShortCut = 16430
      OnClick = dxBarButton2Click
    end
    object dxBarButton3: TdxBarButton
      Caption = 'Modifica'
      Category = 0
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 1
      PaintStyle = psCaptionGlyph
      ShortCut = 115
      OnClick = dxBarButton3Click
    end
  end
end
