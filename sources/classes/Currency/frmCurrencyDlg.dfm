object frmCurrencyDialog: TfrmCurrencyDialog
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Nomenclator valuta'
  ClientHeight = 316
  ClientWidth = 433
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 433
    Height = 64
    Title = 'Valute'
    Text = ''
    FontTitle.Charset = DEFAULT_CHARSET
    FontTitle.Color = clWindowText
    FontTitle.Height = -15
    FontTitle.Name = 'Segoe UI'
    FontTitle.Style = [fsBold]
    FontText.Charset = DEFAULT_CHARSET
    FontText.Color = clWindowText
    FontText.Height = -12
    FontText.Name = 'Segoe UI'
    FontText.Style = []
    ImageList = dmAdditions.cxImageList_DialogIcons
    ImageIndex = 4
    ExplicitWidth = 621
  end
  object pnMain: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 417
    Height = 195
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alClient
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 4
    ExplicitHeight = 227
    object dxBarDockControl1: TdxBarDockControl
      AlignWithMargins = True
      Left = 0
      Top = 0
      Width = 413
      Height = 30
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 1
      Align = dalTop
      BarManager = dxBarManager
      ExplicitWidth = 605
    end
    object cxGridCurrency: TcxGrid
      Left = 0
      Top = 31
      Width = 413
      Height = 160
      Align = alClient
      TabOrder = 1
      ExplicitWidth = 605
      ExplicitHeight = 196
      object cxGridCurrencyTable: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        Navigator.Buttons.First.Visible = True
        Navigator.Buttons.PriorPage.Visible = True
        Navigator.Buttons.Prior.Visible = True
        Navigator.Buttons.Next.Visible = True
        Navigator.Buttons.NextPage.Visible = True
        Navigator.Buttons.Last.Visible = True
        Navigator.Buttons.Insert.Visible = True
        Navigator.Buttons.Append.Visible = False
        Navigator.Buttons.Delete.Visible = True
        Navigator.Buttons.Edit.Visible = True
        Navigator.Buttons.Post.Visible = True
        Navigator.Buttons.Cancel.Visible = True
        Navigator.Buttons.Refresh.Visible = True
        Navigator.Buttons.SaveBookmark.Visible = True
        Navigator.Buttons.GotoBookmark.Visible = True
        Navigator.Buttons.Filter.Visible = True
        FilterBox.CustomizeDialog = False
        ScrollbarAnnotations.CustomAnnotations = <>
        OnCellDblClick = cxGridCurrencyTableCellDblClick
        OnFocusedRecordChanged = cxGridCurrencyTableFocusedRecordChanged
        DataController.DataSource = IBCDataSourceCurrency
        DataController.KeyFieldNames = 'CURRENCYID'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.ImmediateEditor = False
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnGrouping = False
        OptionsCustomize.ColumnHorzSizing = False
        OptionsCustomize.ColumnMoving = False
        OptionsCustomize.ColumnSorting = False
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
        OptionsView.ScrollBars = ssNone
        OptionsView.ShowEditButtons = gsebForFocusedRecord
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        object cxGridCurrencyTableColumn1: TcxGridDBColumn
          Caption = 'ID'
          DataBinding.FieldName = 'CURRENCYID'
          DataBinding.IsNullValueType = True
          HeaderAlignmentHorz = taCenter
          MinWidth = 40
          Options.Filtering = False
          Options.Grouping = False
          Options.HorzSizing = False
          Width = 40
        end
        object cxGridCurrency_TITLE: TcxGridDBColumn
          Caption = 'Denumire'
          DataBinding.FieldName = 'TITLE'
          DataBinding.IsNullValueType = True
          HeaderAlignmentHorz = taCenter
          Width = 200
        end
        object cxGridCurrencyTableColumn3: TcxGridDBColumn
          Caption = 'Simbol'
          DataBinding.FieldName = 'SHORTNAME'
          DataBinding.IsNullValueType = True
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taCenter
          HeaderAlignmentHorz = taCenter
          MinWidth = 60
          Options.Filtering = False
          Options.HorzSizing = False
          Width = 60
        end
        object cxGridCurrencyTableColumn6: TcxGridDBColumn
          Caption = 'Rata transfer'
          DataBinding.FieldName = 'TRANSFER_RATE'
          DataBinding.IsNullValueType = True
          HeaderAlignmentHorz = taCenter
          MinWidth = 120
          Options.HorzSizing = False
          Width = 120
        end
      end
      object cxGridCurrencyLevel: TcxGridLevel
        GridView = cxGridCurrencyTable
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 275
    Width = 433
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 5
    ExplicitTop = 303
    DesignSize = (
      433
      41)
    object btnOK: TcxButton
      Left = 223
      Top = 9
      Width = 91
      Height = 29
      Anchors = [akRight, akBottom]
      Caption = 'OK'
      ModalResult = 1
      TabOrder = 0
      ExplicitLeft = 219
      ExplicitTop = 5
    end
    object btnCancel: TcxButton
      Left = 320
      Top = 9
      Width = 90
      Height = 29
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = 'Inchide'
      ModalResult = 2
      TabOrder = 1
      ExplicitLeft = 316
      ExplicitTop = 5
    end
  end
  object dxBarManager: TdxBarManager
    AllowReset = False
    AutoDockColor = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    CanCustomize = False
    Categories.Strings = (
      'Default')
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    DockColor = clBtnFace
    ImageOptions.Images = dmAdditions.cxImageList_SWN
    NotDocking = [dsNone]
    PopupMenuLinks = <>
    ShowFullMenusAfterDelay = False
    ShowShortCutInHint = True
    SunkenBorder = True
    UseSystemFont = True
    Left = 147
    Top = 8
    PixelsPerInch = 96
    object dxBarManager1Bar1: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Currency'
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 645
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbChangeRate'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbCurrencyHistory'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarSubItem1'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object dxBarSubItem1: TdxBarSubItem
      Caption = 'Suplimentar'
      Category = 0
      Enabled = False
      Visible = ivAlways
      ImageIndex = 3
      ItemLinks = <>
    end
    object bbChangeRate: TdxBarButton
      Caption = 'Modifica rata'
      Category = 0
      Hint = 'Modifica rata'
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 115
      OnClick = bbChangeRateClick
    end
    object bbCurrencyHistory: TdxBarButton
      Caption = 'Istoria ratelor de schimb'
      Category = 0
      Hint = 'Istoria ratelor de schimb'
      Visible = ivAlways
      OnClick = bbCurrencyHistoryClick
    end
  end
  object IBCQueryCurrency: TIBCQuery
    SQLInsert.Strings = (
      'INSERT INTO TS_CURRENCY'
      
        '  (CURRENCYID, TITLE, SHORTNAME, EXCHANGE_RATE, BNM_RATE, TRANSF' +
        'ER_RATE, DEGHEST_RATE)'
      'VALUES'
      
        '  (:CURRENCYID, :TITLE, :SHORTNAME, :EXCHANGE_RATE, :BNM_RATE, :' +
        'TRANSFER_RATE, :DEGHEST_RATE)')
    SQLUpdate.Strings = (
      'UPDATE TS_CURRENCY'
      'SET'
      '  CURRENCYID = :CURRENCYID, '
      '  TITLE = :TITLE, '
      '  SHORTNAME = :SHORTNAME, '
      '  EXCHANGE_RATE = :EXCHANGE_RATE, '
      '  BNM_RATE = :BNM_RATE, '
      '  TRANSFER_RATE = :TRANSFER_RATE,'
      '  DEGHEST_RATE = :DEGHEST_RATE'
      'WHERE'
      '  CURRENCYID = :Old_CURRENCYID')
    SQLRefresh.Strings = (
      
        'SELECT TS_CURRENCY.CURRENCYID, TS_CURRENCY.TITLE, TS_CURRENCY.SH' +
        'ORTNAME, TS_CURRENCY.EXCHANGE_RATE, TS_CURRENCY.BNM_RATE, TS_CUR' +
        'RENCY.TRANSFER_RATE, DEGHEST_RATE FROM TS_CURRENCY'
      'WHERE'
      '  CURRENCYID = :CURRENCYID')
    SQLLock.Strings = (
      'SELECT NULL FROM TS_CURRENCY'
      'WHERE'
      'CURRENCYID = :Old_CURRENCYID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'SELECT'
      ' CURRENCYID,'
      ' TITLE,'
      ' SHORTNAME,'
      ' EXCHANGE_RATE,'
      ' BNM_RATE,'
      ' TRANSFER_RATE,'
      ' DEGHEST_RATE'
      'FROM'
      ' TS_CURRENCY')
    AutoCommit = False
    RefreshOptions = [roAfterUpdate]
    BeforePost = IBCQueryCurrencyBeforePost
    Left = 180
    Top = 152
  end
  object IBCDataSourceCurrency: TIBCDataSource
    DataSet = IBCQueryCurrency
    OnDataChange = IBCDataSourceCurrencyDataChange
    Left = 68
    Top = 152
  end
end
