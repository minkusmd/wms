object frmWorkStationsSetupDlg: TfrmWorkStationsSetupDlg
  Left = 0
  Top = 0
  ActiveControl = cxGridWS
  BorderStyle = bsDialog
  Caption = 'Statii de lucru'
  ClientHeight = 365
  ClientWidth = 794
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 794
    Height = 64
    Title = 'Statii de lucru'
    Text = 'Calculatoarele care pot fi legate la MCC'
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
    ImageIndex = 26
  end
  object btnClose: TButton
    Left = 684
    Top = 324
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Inchide'
    Default = True
    ModalResult = 2
    TabOrder = 2
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 778
    Height = 241
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object dxBarDockControl1: TdxBarDockControl
      Left = 0
      Top = 0
      Width = 778
      Height = 26
      Align = dalTop
      BarManager = dxBarManager1
      SunkenBorder = True
      UseOwnSunkenBorder = True
    end
    object cxGridWS: TcxGrid
      Left = 0
      Top = 26
      Width = 778
      Height = 215
      Align = alClient
      TabOrder = 1
      object cxGridWSTable: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        OnFocusedRecordChanged = cxGridWSTableFocusedRecordChanged
        DataController.DataSource = IBCDataSourceWS
        DataController.KeyFieldNames = 'WS_ID'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnsQuickCustomization = True
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsSelection.InvertSelect = False
        OptionsView.ScrollBars = ssVertical
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        Styles.Header = dmAdditions.cxStyle_GridHeader
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        object cxGridWSTable_WS_ID: TcxGridDBColumn
          Caption = 'Cod'
          DataBinding.FieldName = 'WS_ID'
          Visible = False
          HeaderAlignmentHorz = taCenter
          MinWidth = 40
          Options.HorzSizing = False
          Width = 40
        end
        object cxGridWSTable_FLG_ENABLED: TcxGridDBColumn
          Caption = 'Activ'
          DataBinding.FieldName = 'FLG_ENABLED'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          HeaderAlignmentHorz = taCenter
          MinWidth = 40
          Options.HorzSizing = False
          Width = 40
        end
        object cxGridWSTable_COMPUTER_NAME: TcxGridDBColumn
          Caption = 'Nume calculator'
          DataBinding.FieldName = 'COMPUTER_NAME'
          MinWidth = 140
          Width = 160
        end
        object cxGridWSTable_FIRMA_NAME: TcxGridDBColumn
          Caption = 'Subdiviziune'
          DataBinding.FieldName = 'FIRMA_NAME'
          Width = 175
        end
        object cxGridWSTable_DESCRIPTION: TcxGridDBColumn
          Caption = 'Descriere'
          DataBinding.FieldName = 'DESCRIPTION'
          Width = 250
        end
        object cxGridWSTable_CREATED_DATE: TcxGridDBColumn
          Caption = 'Inregistrat'
          DataBinding.FieldName = 'CREATED_DATE'
          HeaderAlignmentHorz = taCenter
          Width = 90
        end
      end
      object cxGridWSLevel: TcxGridLevel
        GridView = cxGridWSTable
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
      'Default')
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    ImageOptions.Images = dmAdditions.cxImageList_SWN
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 440
    Top = 12
    PixelsPerInch = 96
    object dxBarManager1Bar1: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      BorderStyle = bbsNone
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 669
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      IsMainMenu = True
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
      MultiLine = True
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = True
    end
    object bbNew: TdxBarButton
      Caption = 'Adauga'
      Category = 0
      Hint = 'Adauga'
      Visible = ivAlways
      ImageIndex = 40
      OnClick = bbNewClick
    end
    object bbEdit: TdxBarButton
      Caption = 'Modifica'
      Category = 0
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 41
      OnClick = bbEditClick
    end
    object bbDelete: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      OnClick = bbDeleteClick
    end
  end
  object IBCQueryWS: TIBCQuery
    KeyFields = 'WS_ID'
    KeyGenerator = 'SQ_WS_WORK_STATIONS_ID'
    GeneratorMode = gmInsert
    SQLInsert.Strings = (
      'INSERT INTO WS_WORK_STATIONS'
      '  (WS_ID, FIRMA_ID, COMPUTER_NAME, DESCRIPTION, FLG_ENABLED, CREATED_DATE)'
      'VALUES'
      '  (:WS_ID, :FIRMA_ID, :COMPUTER_NAME, :DESCRIPTION, :FLG_ENABLED, CURRENT_DATE)')
    SQLDelete.Strings = (
      'DELETE FROM WS_WORK_STATIONS'
      'WHERE'
      '  WS_ID = :Old_WS_ID')
    SQLUpdate.Strings = (
      'UPDATE WS_WORK_STATIONS'
      'SET'
      '  FIRMA_ID = :FIRMA_ID, '
      '  COMPUTER_NAME = :COMPUTER_NAME, '
      '  DESCRIPTION = :DESCRIPTION, '
      '  FLG_ENABLED = :FLG_ENABLED'
      'WHERE'
      '  WS_ID = :Old_WS_ID')
    SQLRefresh.Strings = (
      'SELECT '
      ' WS_ID, '
      ' FIRMA_ID, '
      ' FIRMA_NAME, '
      ' COMPUTER_NAME, '
      ' DESCRIPTION, '
      ' FLG_ENABLED, '
      ' CREATED_DATE'
      'FROM '
      ' VW_WS_WORK_STATIONS'
      'WHERE'
      ' WS_ID = :WS_ID')
    SQLLock.Strings = (
      'SELECT NULL FROM WS_WORK_STATIONS'
      'WHERE'
      'WS_ID = :Old_WS_ID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = IBCTrUpdate
    SQL.Strings = (
      'SELECT '
      ' WS_ID, '
      ' FIRMA_ID, '
      ' FIRMA_NAME, '
      ' COMPUTER_NAME, '
      ' DESCRIPTION, '
      ' FLG_ENABLED, '
      ' CREATED_DATE'
      'FROM '
      ' VW_WS_WORK_STATIONS'
      'ORDER BY '
      ' FIRMA_NAME, COMPUTER_NAME')
    AutoCommit = False
    LockMode = lmLockImmediate
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Left = 64
    Top = 152
  end
  object IBCDataSourceWS: TIBCDataSource
    DataSet = IBCQueryWS
    Left = 64
    Top = 208
  end
  object IBCTrUpdate: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 160
    Top = 152
  end
end
