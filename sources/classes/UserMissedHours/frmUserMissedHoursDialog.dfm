object frmUserMissedHoursDlg: TfrmUserMissedHoursDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Registru lipselor salariatilor'
  ClientHeight = 605
  ClientWidth = 848
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 848
    Height = 64
    Title = 'Registru lipselor salariatilor'
    Text = 'Gestionarea orelor lipsa a angajatilor'
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
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 832
    Height = 481
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 1
    object cxGrid: TcxGrid
      Left = 0
      Top = 30
      Width = 832
      Height = 451
      Align = alClient
      TabOrder = 1
      object cxGridTable: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        OnFocusedRecordChanged = cxGridTableFocusedRecordChanged
        DataController.DataSource = IBCDataSourceMiss
        DataController.KeyFieldNames = 'MISSHOURID'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <
          item
            Kind = skCount
            Column = cxGrid_USER_NAME
          end
          item
            Kind = skSum
            Column = cxGrid_HOURS
          end>
        DataController.Summary.SummaryGroups = <>
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsView.CellEndEllipsis = True
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
        OptionsView.ScrollBars = ssVertical
        OptionsView.ColumnAutoWidth = True
        OptionsView.Footer = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupRowStyle = grsOffice11
        OptionsView.Indicator = True
        Styles.FilterBox = dmAdditions.cxStyle_GridGroup
        Styles.Footer = dmAdditions.cxStyle_GridHeader
        Styles.Group = dmAdditions.cxStyle_Bold
        Styles.Header = dmAdditions.cxStyle_GridHeader
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        object cxGrid_MISSHOURID: TcxGridDBColumn
          Caption = 'Cod'
          DataBinding.FieldName = 'MISSHOURID'
          DataBinding.IsNullValueType = True
          HeaderAlignmentHorz = taCenter
          MinWidth = 50
          Options.Filtering = False
          Options.HorzSizing = False
          Width = 50
        end
        object cxGrid_DATA: TcxGridDBColumn
          Caption = 'Data'
          DataBinding.FieldName = 'DATA'
          DataBinding.IsNullValueType = True
          HeaderAlignmentHorz = taCenter
          MinWidth = 100
          Options.Filtering = False
          Options.HorzSizing = False
          SortIndex = 0
          SortOrder = soDescending
          Width = 100
        end
        object cxGrid_MOTIV_TITLE: TcxGridDBColumn
          Caption = 'Cauza'
          DataBinding.FieldName = 'MOTIV_TITLE'
          DataBinding.IsNullValueType = True
          Width = 100
        end
        object cxGrid_USER_NAME: TcxGridDBColumn
          Caption = 'Salariat'
          DataBinding.FieldName = 'CT_NAME'
          DataBinding.IsNullValueType = True
          Width = 150
        end
        object cxGrid_HOURS: TcxGridDBColumn
          Caption = 'Orele'
          DataBinding.FieldName = 'HOURS'
          DataBinding.IsNullValueType = True
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taCenter
          FooterAlignmentHorz = taCenter
          HeaderAlignmentHorz = taCenter
          MinWidth = 50
          Options.Filtering = False
          Options.HorzSizing = False
          Width = 50
        end
        object cxGrid_DESCRIPTION: TcxGridDBColumn
          Caption = 'Comentariu'
          DataBinding.FieldName = 'DESCRIPTION'
          DataBinding.IsNullValueType = True
          Options.Filtering = False
          Width = 200
        end
        object cxGrid_CREATED_BY_NAME: TcxGridDBColumn
          Caption = 'Utilizator'
          DataBinding.FieldName = 'CREATED_BY_NAME'
          DataBinding.IsNullValueType = True
          MinWidth = 100
          Options.Filtering = False
          Options.HorzSizing = False
          Width = 100
        end
        object cxGrid_DATE_INDEX: TcxGridDBColumn
          Caption = 'Luna'
          DataBinding.FieldName = 'DATE_INDEX'
          DataBinding.IsNullValueType = True
          Visible = False
          OnGetDisplayText = cxGrid_DATE_INDEXGetDisplayText
          GroupIndex = 0
          SortIndex = 1
          SortOrder = soDescending
        end
      end
      object cxGridLevel: TcxGridLevel
        GridView = cxGridTable
      end
    end
    object dxBarDockControl1: TdxBarDockControl
      Left = 0
      Top = 0
      Width = 832
      Height = 30
      Align = dalTop
      BarManager = dxBarManager
      SunkenBorder = True
      UseOwnSunkenBorder = True
    end
  end
  object btnClose: TButton
    Left = 750
    Top = 564
    Width = 90
    Height = 29
    Caption = 'Inchide'
    ModalResult = 1
    TabOrder = 2
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
    Left = 468
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
      FloatLeft = 716
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
    object bbSetInterval: TdxBarButton
      Caption = #1059#1089#1090#1072#1085#1086#1074#1082#1072' '#1087#1077#1088#1080#1086#1076#1072' '#1076#1083#1103' '#1089#1086#1073#1099#1090#1080#1103'...'
      Category = 0
      Hint = #1059#1089#1090#1072#1085#1086#1074#1082#1072' '#1087#1077#1088#1080#1086#1076#1072' '#1076#1083#1103' '#1089#1086#1073#1099#1090#1080#1103
      Visible = ivAlways
      ImageIndex = 37
      OnClick = bbSetIntervalClick
    end
  end
  object IBCQueryMiss: TIBCQuery
    KeyFields = 'MISSHOURID'
    KeyGenerator = 'SQ_TDB_USER_MISS_HOURS_ID'
    GeneratorMode = gmInsert
    SQLInsert.Strings = (
      'INSERT INTO TDB_USER_MISS_HOURS'
      '  (MISSHOURID, DATA, CT, HOURS, MOTIV_ID, DESCRIPTION)'
      'VALUES'
      '  (:MISSHOURID, :DATA, :CT, :HOURS, :MOTIV_ID, :DESCRIPTION)')
    SQLDelete.Strings = (
      'DELETE FROM TDB_USER_MISS_HOURS'
      'WHERE'
      '  MISSHOURID = :Old_MISSHOURID')
    SQLUpdate.Strings = (
      'UPDATE TDB_USER_MISS_HOURS'
      'SET'
      
        '  DATA = :DATA, CT = :CT, HOURS = :HOURS, MOTIV_ID = :MOTIV_ID, ' +
        'DESCRIPTION = :DESCRIPTION'
      'WHERE'
      '  MISSHOURID = :Old_MISSHOURID')
    SQLRefresh.Strings = (
      'SELECT'
      ' VW_TDB_USER_MISS_HOURS.*,'
      
        'EXTRACT(YEAR FROM VW_TDB_USER_MISS_HOURS.DATA)*100+EXTRACT(MONTH' +
        ' FROM VW_TDB_USER_MISS_HOURS.DATA) DATE_INDEX'
      'FROM '
      ' VW_TDB_USER_MISS_HOURS'
      'WHERE'
      '  MISSHOURID = :MISSHOURID')
    SQLLock.Strings = (
      'SELECT NULL FROM TDB_USER_MISS_HOURS'
      'WHERE'
      'MISSHOURID = :Old_MISSHOURID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'SELECT'
      'VW_TDB_USER_MISS_HOURS.*,'
      
        'EXTRACT(YEAR FROM VW_TDB_USER_MISS_HOURS.DATA)*100+EXTRACT(MONTH' +
        ' FROM VW_TDB_USER_MISS_HOURS.DATA) DATE_INDEX'
      'FROM VW_TDB_USER_MISS_HOURS'
      'WHERE CT_DEFAULT_DT=:DT'
      'order by data desc')
    AutoCommit = False
    LockMode = lmLockImmediate
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Left = 88
    Top = 212
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DT'
        Value = nil
      end>
  end
  object IBCDataSourceMiss: TIBCDataSource
    DataSet = IBCQueryMiss
    Left = 88
    Top = 268
  end
  object dxBarPopupMenu1: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbSetInterval'
      end>
    UseOwnFont = False
    Left = 376
    Top = 192
    PixelsPerInch = 96
  end
  object cxGridPopupMenu1: TcxGridPopupMenu
    Grid = cxGrid
    PopupMenus = <
      item
        GridView = cxGridTable
        HitTypes = [gvhtCell, gvhtRecord]
        Index = 0
        PopupMenu = dxBarPopupMenu1
      end>
    Left = 376
    Top = 256
  end
end
