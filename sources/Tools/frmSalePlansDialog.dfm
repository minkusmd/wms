object frmSalePlansDlg: TfrmSalePlansDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1055#1083#1072#1085#1099' '#1087#1088#1086#1076#1072#1078
  ClientHeight = 574
  ClientWidth = 813
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
    Width = 813
    Height = 64
    Title = #1055#1083#1072#1085#1099' '#1087#1088#1086#1076#1072#1078
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
    ImageIndex = 4
  end
  object pnClient: TPanel
    Left = 0
    Top = 64
    Width = 813
    Height = 453
    Align = alTop
    BevelOuter = bvNone
    Padding.Left = 8
    Padding.Top = 8
    Padding.Right = 8
    ShowCaption = False
    TabOrder = 1
    object dxBarDockControl1: TdxBarDockControl
      Left = 8
      Top = 8
      Width = 797
      Height = 30
      Align = dalTop
      BarManager = dxBarManager
      SunkenBorder = True
      UseOwnSunkenBorder = True
    end
    object cxGrid: TcxGrid
      Left = 8
      Top = 38
      Width = 797
      Height = 415
      Align = alClient
      TabOrder = 1
      object cxGridTable: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        OnCellDblClick = cxGridTableCellDblClick
        OnFocusedRecordChanged = cxGridTableFocusedRecordChanged
        DataController.DataSource = IBCDataSourceSal
        DataController.KeyFieldNames = 'DT;DATA'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.CopyCaptionsToClipboard = False
        OptionsBehavior.IncSearch = True
        OptionsCustomize.ColumnsQuickCustomization = True
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.InvertSelect = False
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
        OptionsView.ScrollBars = ssVertical
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        OptionsView.GroupRowStyle = grsOffice11
        Styles.Header = dmAdditions.cxStyle_GridHeader
        object cxGrid_DT: TcxGridDBColumn
          Caption = #1050#1086#1076
          DataBinding.FieldName = 'DT'
          Visible = False
          HeaderAlignmentHorz = taCenter
          MinWidth = 60
          Options.Filtering = False
          Options.HorzSizing = False
          Width = 60
        end
        object cxGrid_IMAGE: TcxGridDBColumn
          DataBinding.FieldName = 'DT'
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.DefaultImageIndex = 11
          Properties.Images = dmAdditions.cxImageList_SWN
          Properties.Items = <>
          MinWidth = 26
          Options.Editing = False
          Options.Filtering = False
          Options.Focusing = False
          Options.IncSearch = False
          Options.Grouping = False
          Options.HorzSizing = False
          Options.ShowCaption = False
          Options.Sorting = False
          Width = 26
          IsCaptionAssigned = True
        end
        object cxGrid_DT_NAME: TcxGridDBColumn
          Caption = #1060#1080#1088#1084#1072
          DataBinding.FieldName = 'DT_NAME'
          Width = 200
        end
        object cxGrid_DATA: TcxGridDBColumn
          Caption = #1044#1072#1090#1072
          DataBinding.FieldName = 'DATA'
          Visible = False
          OnGetDisplayText = cxGrid_DATAGetDisplayText
          GroupIndex = 0
          HeaderAlignmentHorz = taCenter
          MinWidth = 100
          Options.HorzSizing = False
          SortIndex = 0
          SortOrder = soDescending
          Width = 100
        end
        object cxGrid_SUMA: TcxGridDBColumn
          Caption = #1055#1083#1072#1085' '#1087#1088#1086#1076#1072#1078
          DataBinding.FieldName = 'SUMA'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = ',0.00;-,0.00'
          HeaderAlignmentHorz = taCenter
          MinWidth = 120
          Options.HorzSizing = False
          Width = 120
        end
        object cxGrid_SUMA_SAL: TcxGridDBColumn
          Caption = #1060#1086#1085#1076' '#1079#1072#1087#1083#1072#1090
          DataBinding.FieldName = 'SUMA_SAL'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = ',0.00;-,0.00'
          HeaderAlignmentHorz = taCenter
          MinWidth = 120
          Options.HorzSizing = False
          Width = 120
        end
        object cxGrid_TRANSACTIONS_QTY: TcxGridDBColumn
          Caption = #1050#1086#1083'-'#1074#1086' '#1095#1077#1082#1086#1074
          DataBinding.FieldName = 'TRANSACTIONS_QTY'
        end
        object cxGrid_NUMBER_OF_SELLERS: TcxGridDBColumn
          Caption = #1050#1086#1083'-'#1074#1086' '#1087#1088#1086#1076#1072#1074#1094#1086#1074
          DataBinding.FieldName = 'NUMBER_OF_SELLERS'
        end
      end
      object cxGridLevel: TcxGridLevel
        GridView = cxGridTable
      end
    end
  end
  object btnClose: TcxButton
    Left = 704
    Top = 531
    Width = 90
    Height = 29
    Cancel = True
    Caption = #1047#1072#1082#1088#1099#1090#1100
    ModalResult = 2
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
    Left = 436
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
      FloatLeft = 837
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
          BeginGroup = True
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
          ItemName = 'bbCopy'
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
      Caption = #1053#1086#1074#1072#1103
      Category = 0
      Hint = #1053#1086#1074#1072#1103
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 45
      OnClick = bbNewClick
    end
    object bbModify: TdxBarButton
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      Category = 0
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 115
      OnClick = bbModifyClick
    end
    object bbDelete: TdxBarButton
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Category = 0
      Hint = #1059#1076#1072#1083#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 42
      ShortCut = 46
      OnClick = bbDeleteClick
    end
    object bbCopy: TdxBarButton
      Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1084#1077#1089#1103#1094
      Category = 0
      Hint = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1084#1077#1089#1103#1094
      Visible = ivAlways
      ImageIndex = 29
      OnClick = bbCopyClick
    end
  end
  object IBCQuerySal: TIBCQuery
    SQLInsert.Strings = (
      'INSERT INTO TDB_BUGET_VINZARI'
      
        '  (DT, DATA, SUMA, SUMA_SAL, TRANSACTIONS_QTY, NUMBER_OF_SELLERS' +
        ')'
      'VALUES'
      
        '  (:DT, :DATA, :SUMA, :SUMA_SAL,:TRANSACTIONS_QTY, :NUMBER_OF_SE' +
        'LLERS)')
    SQLDelete.Strings = (
      'DELETE FROM TDB_BUGET_VINZARI'
      'WHERE'
      '  DT = :Old_DT AND DATA = :Old_DATA')
    SQLUpdate.Strings = (
      'UPDATE TDB_BUGET_VINZARI'
      'SET'
      '  DT = :DT, DATA = :DATA, SUMA = :SUMA, SUMA_SAL = :SUMA_SAL,'
      
        '  TRANSACTIONS_QTY = :TRANSACTIONS_QTY, NUMBER_OF_SELLERS = :NUM' +
        'BER_OF_SELLERS'
      'WHERE'
      '  DT = :Old_DT AND DATA = :Old_DATA')
    SQLRefresh.Strings = (
      'SELECT'
      ' DT,'
      
        ' (SELECT DISPLAYNAME FROM TS_CUSTOMER WHERE CUSTOMERID=DT) DT_NA' +
        'ME,'
      ' DATA,'
      ' SUMA,'
      ' SUMA_SAL,'
      ' TRANSACTIONS_QTY,'
      ' NUMBER_OF_SELLERS'
      'FROM'
      ' TDB_BUGET_VINZARI'
      'WHERE'
      '  DT = :DT AND DATA = :DATA')
    SQLLock.Strings = (
      'SELECT NULL FROM TDB_BUGET_VINZARI'
      'WHERE'
      'DT = :Old_DT AND DATA = :Old_DATA'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'SELECT'
      ' DT,'
      
        ' (SELECT DISPLAYNAME FROM TS_CUSTOMER WHERE CUSTOMERID=DT) DT_NA' +
        'ME,'
      ' DATA,'
      ' SUMA,'
      ' SUMA_SAL,'
      ' TRANSACTIONS_QTY,'
      ' NUMBER_OF_SELLERS'
      'FROM'
      ' TDB_BUGET_VINZARI'
      'ORDER BY DATA DESC, DT_NAME')
    AutoCommit = False
    LockMode = lmLockImmediate
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Options.RequiredFields = False
    LocalConstraints = False
    Left = 84
    Top = 236
  end
  object IBCDataSourceSal: TIBCDataSource
    DataSet = IBCQuerySal
    Left = 84
    Top = 184
  end
end
