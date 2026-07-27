object frmContractTypeDlg: TfrmContractTypeDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Tipuri de contracte'
  ClientHeight = 528
  ClientWidth = 686
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  DesignSize = (
    686
    528)
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 686
    Height = 64
    Title = 'Tipuri de contracte'
    Text = 'Managementul tipuri contracte'
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
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 670
    Height = 403
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 1
    object dxBarDockControl1: TdxBarDockControl
      Left = 0
      Top = 0
      Width = 670
      Height = 30
      Align = dalTop
      BarManager = dxBarManager1
      SunkenBorder = True
      UseOwnSunkenBorder = True
    end
    object cxGridCT: TcxGrid
      Left = 0
      Top = 30
      Width = 670
      Height = 373
      Align = alClient
      TabOrder = 1
      object cxGridCTTable: TcxGridDBTableView
        OnKeyDown = cxGridCTTableKeyDown
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        OnCellDblClick = cxGridCTTableCellDblClick
        OnFocusedRecordChanged = cxGridCTTableFocusedRecordChanged
        DataController.DataSource = IBCDataSourceCT
        DataController.KeyFieldNames = 'CONTRACTTYPEID'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnsQuickCustomization = True
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsSelection.HideFocusRectOnExit = False
        OptionsSelection.InvertSelect = False
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
        OptionsView.ScrollBars = ssVertical
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        Styles.Header = dmAdditions.cxStyle_GridHeader
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        object cxGridCT_CONTRACTTYPEID: TcxGridDBColumn
          Caption = 'ID'
          DataBinding.FieldName = 'CONTRACTTYPEID'
          DataBinding.IsNullValueType = True
          HeaderAlignmentHorz = taCenter
          MinWidth = 50
          Options.HorzSizing = False
          Width = 50
        end
        object cxGridCT_IMG: TcxGridDBColumn
          DataBinding.FieldName = 'FLG_FOLDER'
          DataBinding.IsNullValueType = True
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.DefaultImageIndex = 22
          Properties.Images = dmAdditions.cxImageList_SWN
          Properties.Items = <
            item
              ImageIndex = 13
              Value = 1
            end>
          MinWidth = 24
          Options.HorzSizing = False
          Width = 24
          IsCaptionAssigned = True
        end
        object cxGridCT_TITLE: TcxGridDBColumn
          Caption = 'Denumire'
          DataBinding.FieldName = 'TITLE'
          DataBinding.IsNullValueType = True
          Width = 300
        end
        object cxGridCT_CREATED_BY_NAME: TcxGridDBColumn
          Caption = #1057#1086#1079#1076#1072#1083
          DataBinding.FieldName = 'CREATED_BY_NAME'
          DataBinding.IsNullValueType = True
          Visible = False
          Width = 100
        end
      end
      object cxGridCTLevel: TcxGridLevel
        GridView = cxGridCTTable
      end
    end
  end
  object btnOk: TButton
    Left = 472
    Top = 486
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'Alege'
    TabOrder = 2
    OnClick = btnOkClick
  end
  object btnCancel: TButton
    Left = 576
    Top = 486
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
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
    Left = 400
    Top = 16
    PixelsPerInch = 96
    object dxBarManager1Bar1: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Custom 1'
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 710
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbHome'
        end
        item
          Visible = True
          ItemName = 'bbBack'
        end
        item
          Visible = True
          ItemName = 'bbForward'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarSubItem1'
        end
        item
          Visible = True
          ItemName = 'dxBarButton1'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object bbNew: TdxBarButton
      Caption = 'Tip contract nou'
      Category = 0
      Hint = 'Tip contract nou'
      Visible = ivAlways
      ImageIndex = 22
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
      ShortCut = 46
      OnClick = bbDeleteClick
    end
    object bbHome: TdxBarButton
      Caption = #1053#1072#1095#1072#1083#1086
      Category = 0
      Hint = #1053#1072#1095#1072#1083#1086
      Visible = ivAlways
      ImageIndex = 5
      ShortCut = 16420
      OnClick = bbHomeClick
    end
    object bbBack: TdxBarButton
      Caption = #1053#1072#1079#1072#1076
      Category = 0
      Hint = #1053#1072#1079#1072#1076
      Visible = ivAlways
      ImageIndex = 6
      OnClick = bbBackClick
    end
    object bbForward: TdxBarButton
      Caption = #1042#1087#1077#1088#1077#1076
      Category = 0
      Hint = #1042#1087#1077#1088#1077#1076
      Visible = ivAlways
      ImageIndex = 7
      OnClick = bbForwardClick
    end
    object dxBarSubItem1: TdxBarSubItem
      Caption = 'Tipuri contracte'
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbNewFolder'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbNew'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbEdit'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbDelete'
        end>
    end
    object bbNewFolder: TdxBarButton
      Caption = 'Grupa noua'
      Category = 0
      Hint = 'Grupa noua'
      Visible = ivAlways
      ImageIndex = 13
      OnClick = bbNewFolderClick
    end
    object dxBarButton1: TdxBarButton
      Caption = 'Tipar'
      Category = 0
      Hint = 'Tipar'
      Visible = ivAlways
      ShortCut = 16464
      OnClick = dxBarButton1Click
    end
  end
  object IBCQueryCT: TIBCQuery
    KeyFields = 'CONTRACTTYPEID'
    KeyGenerator = 'SQ_TS_CONTRACT_TYPES_ID'
    GeneratorMode = gmInsert
    SQLInsert.Strings = (
      'INSERT INTO TS_CONTRACT_TYPES'
      '  (CONTRACTTYPEID, PARENTID, FLG_FOLDER, TITLE)'
      'VALUES'
      '  (:CONTRACTTYPEID, :PARENTID, :FLG_FOLDER, :TITLE)')
    SQLDelete.Strings = (
      'DELETE FROM TS_CONTRACT_TYPES'
      'WHERE'
      '  CONTRACTTYPEID = :Old_CONTRACTTYPEID')
    SQLUpdate.Strings = (
      'UPDATE TS_CONTRACT_TYPES'
      'SET'
      '  TITLE = :TITLE'
      'WHERE'
      '  CONTRACTTYPEID = :Old_CONTRACTTYPEID')
    SQLRefresh.Strings = (
      'SELECT '
      ' CONTRACTTYPEID,'
      ' PARENTID,'
      ' FLG_FOLDER,'
      ' TITLE,'
      ' CREATED_BY,'
      ' CREATED_BY_NAME'
      'FROM VW_TS_CONTRACT_TYPES'
      'WHERE'
      '  CONTRACTTYPEID = :CONTRACTTYPEID')
    SQLLock.Strings = (
      'SELECT '
      ' NULL '
      'FROM '
      ' TS_CONTRACT_TYPES'
      'WHERE'
      ' CONTRACTTYPEID = :Old_CONTRACTTYPEID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = IBCTrUpdateCT
    SQL.Strings = (
      'SELECT'
      ' CONTRACTTYPEID,'
      ' PARENTID,'
      ' FLG_FOLDER,'
      ' TITLE,'
      ' CREATED_BY,'
      ' CREATED_BY_NAME'
      'FROM VW_TS_CONTRACT_TYPES'
      'ORDER BY '
      ' FLG_FOLDER DESC, TITLE')
    AutoCommit = False
    LockMode = lmLockImmediate
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Options.RequiredFields = False
    LocalConstraints = False
    Left = 88
    Top = 312
  end
  object IBCDataSourceCT: TIBCDataSource
    DataSet = IBCQueryCT
    Left = 88
    Top = 256
  end
  object IBCTrUpdateCT: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 88
    Top = 176
  end
end
