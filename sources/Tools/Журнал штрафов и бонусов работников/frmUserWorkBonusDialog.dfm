object frmUserWorkBonusDlg: TfrmUserWorkBonusDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Registrul amenzilor si bonurilor'
  ClientHeight = 495
  ClientWidth = 695
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  DesignSize = (
    695
    495)
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 695
    Height = 64
    Title = 'Registrul amenzilor si bonurilor'
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
    ImageList = dmAdditions.cxImageList_DialogIcons
    ImageIndex = 2
    ExplicitWidth = 696
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 679
    Height = 370
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 1
    ExplicitWidth = 680
    ExplicitHeight = 412
    object dxBarDockControl1: TdxBarDockControl
      Left = 0
      Top = 0
      Width = 679
      Height = 30
      Align = dalTop
      BarManager = dxBarManager
      SunkenBorder = True
      UseOwnSunkenBorder = True
      ExplicitWidth = 680
    end
    object cxGrid: TcxGrid
      Left = 0
      Top = 30
      Width = 679
      Height = 340
      Align = alClient
      TabOrder = 1
      ExplicitWidth = 680
      ExplicitHeight = 382
      object cxGridTable: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        OnCellDblClick = cxGridTableCellDblClick
        OnFocusedRecordChanged = cxGridTableFocusedRecordChanged
        DataController.DataSource = IBCDataSourceB
        DataController.KeyFieldNames = 'BONUSID'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.CopyCaptionsToClipboard = False
        OptionsCustomize.ColumnsQuickCustomization = True
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsView.CellEndEllipsis = True
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
        OptionsView.ScrollBars = ssVertical
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupRowStyle = grsOffice11
        OptionsView.Indicator = True
        Styles.Header = dmAdditions.cxStyle_GridHeader
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        object cxGrid_BONUSID: TcxGridDBColumn
          Caption = #1050#1086#1076
          DataBinding.FieldName = 'BONUSID'
          DataBinding.IsNullValueType = True
          Visible = False
          MinWidth = 40
          Options.HorzSizing = False
          Width = 40
        end
        object cxGrid_DATA: TcxGridDBColumn
          Caption = 'Data'
          DataBinding.FieldName = 'DATA'
          DataBinding.IsNullValueType = True
          HeaderAlignmentHorz = taCenter
          MinWidth = 100
          Options.Filtering = False
          Options.HorzSizing = False
          Width = 100
        end
        object cxGrid_CT: TcxGridDBColumn
          AlternateCaption = #1050#1086#1076' '#1082#1086#1085#1090#1088#1072#1075#1077#1085#1090#1072
          Caption = #1050#1086#1076' '#1082#1086#1085#1090#1088'.'
          DataBinding.FieldName = 'CT'
          DataBinding.IsNullValueType = True
          Visible = False
          MinWidth = 50
          Options.HorzSizing = False
          Width = 50
        end
        object cxGrid_CT_NAME: TcxGridDBColumn
          Caption = 'Client'
          DataBinding.FieldName = 'CT_NAME'
          DataBinding.IsNullValueType = True
          Width = 100
        end
        object cxGrid_BONUS_VALUE: TcxGridDBColumn
          Caption = 'Bonus'
          DataBinding.FieldName = 'BONUS_VALUE'
          DataBinding.IsNullValueType = True
          HeaderAlignmentHorz = taCenter
          MinWidth = 60
          Options.HorzSizing = False
          Width = 60
        end
        object cxGrid_DESCRIPTION: TcxGridDBColumn
          Caption = 'Descriere'
          DataBinding.FieldName = 'DESCRIPTION'
          DataBinding.IsNullValueType = True
          Options.Filtering = False
          Width = 160
        end
        object cxGrid_CREATED_NAME: TcxGridDBColumn
          Caption = 'Utilizator'
          DataBinding.FieldName = 'CREATED_NAME'
          DataBinding.IsNullValueType = True
          Width = 60
        end
      end
      object cxGridLevel: TcxGridLevel
        GridView = cxGridTable
      end
    end
  end
  object btnClose: TButton
    Left = 583
    Top = 453
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Inchide'
    ModalResult = 1
    TabOrder = 2
    ExplicitLeft = 584
    ExplicitTop = 495
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
    Left = 440
    Top = 12
    PixelsPerInch = 96
    object dxBarManagerBar1: TdxBar
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
      FloatLeft = 720
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
          ItemName = 'bbEdit'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbDelete'
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
      ShortCut = 113
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
  end
  object IBCQueryB: TIBCQuery
    KeyFields = 'BONUSID'
    KeyGenerator = 'SQ_TDB_USER_WORK_BONUS_ID'
    GeneratorMode = gmInsert
    SQLInsert.Strings = (
      'INSERT INTO TDB_USER_WORK_BONUS'
      '  (BONUSID, DATA, CT, BONUS_VALUE, DESCRIPTION)'
      'VALUES'
      '  (:BONUSID, :DATA, :CT, :BONUS_VALUE, :DESCRIPTION)')
    SQLDelete.Strings = (
      'DELETE FROM TDB_USER_WORK_BONUS'
      'WHERE'
      '  BONUSID = :Old_BONUSID')
    SQLUpdate.Strings = (
      'UPDATE TDB_USER_WORK_BONUS'
      'SET'
      '  BONUSID = :BONUSID, '
      '  DATA = :DATA, '
      '  CT = :CT, '
      '  BONUS_VALUE = :BONUS_VALUE, '
      '  DESCRIPTION = :DESCRIPTION'
      'WHERE'
      '  BONUSID = :Old_BONUSID')
    SQLRefresh.Strings = (
      'SELECT '
      ' *'
      'FROM '
      ' VW_TDB_USER_WORK_BONUS'
      'WHERE'
      '  BONUSID = :BONUSID')
    SQLLock.Strings = (
      'SELECT NULL FROM TDB_USER_WORK_BONUS'
      'WHERE'
      'BONUSID = :Old_BONUSID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = IBCTrUpdate
    SQL.Strings = (
      'SELECT'
      '*'
      'FROM'
      ' VW_TDB_USER_WORK_BONUS'
      'ORDER BY'
      ' DATA desc, ct_name')
    AutoCommit = False
    LockMode = lmLockImmediate
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Options.RequiredFields = False
    LocalConstraints = False
    Left = 76
    Top = 176
  end
  object IBCDataSourceB: TIBCDataSource
    DataSet = IBCQueryB
    Left = 77
    Top = 237
  end
  object IBCTrUpdate: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 160
    Top = 196
  end
  object ActionList1: TActionList
    Left = 336
    Top = 272
    object actModifyRecord: TAction
      Caption = 'actModifyRecord'
      OnExecute = actModifyRecordExecute
      OnUpdate = actModifyRecordUpdate
    end
    object actDeleteRecord: TAction
      Caption = 'actDeleteRecord'
      OnExecute = actDeleteRecordExecute
      OnUpdate = actDeleteRecordUpdate
    end
  end
end
