object frmLinkFirmsTo1CDlg: TfrmLinkFirmsTo1CDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1055#1088#1080#1074#1103#1079#1082#1072' '#1092#1080#1088#1084' '#1082' 1'#1057
  ClientHeight = 410
  ClientWidth = 852
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    852
    410)
  PixelsPerInch = 96
  TextHeight = 15
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 836
    Height = 285
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 0
    object dxBarDockControl1: TdxBarDockControl
      Left = 0
      Top = 0
      Width = 836
      Height = 30
      Align = dalTop
      BarManager = dxBarManager1
      SunkenBorder = True
      UseOwnSunkenBorder = True
    end
    object cxGrid: TcxGrid
      Left = 0
      Top = 30
      Width = 836
      Height = 255
      Align = alClient
      TabOrder = 1
      object cxGridTable: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        OnFocusedRecordChanged = cxGridTableFocusedRecordChanged
        DataController.DataSource = IBCDataSource1C
        DataController.KeyFieldNames = 'CUSTOMERID'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnSorting = False
        OptionsCustomize.ColumnsQuickCustomization = True
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsSelection.InvertSelect = False
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
        OptionsView.ScrollBars = ssVertical
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        Styles.Header = dmAdditions.cxStyle_GridHeader
        object cxGridT_CUSTOMERID: TcxGridDBColumn
          Caption = #1060#1080#1088#1084#1072' '#1082#1086#1076
          DataBinding.FieldName = 'CUSTOMERID'
          MinWidth = 60
          Options.HorzSizing = False
          Width = 60
        end
        object cxGrid_CUSTOMER_TITLE: TcxGridDBColumn
          Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1092#1080#1088#1084#1099
          DataBinding.FieldName = 'CUSTOMER_TITLE'
          Width = 100
        end
        object cxGrid_FIRMA_COD: TcxGridDBColumn
          Caption = #1050#1086#1076' '#1092#1080#1088#1084#1099' '#1074' 1'#1057
          DataBinding.FieldName = 'FIRMA_COD'
          Width = 60
        end
        object cxGrid_FIRMA_NAME: TcxGridDBColumn
          Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1092#1080#1088#1084#1099' '#1074' 1'#1057
          DataBinding.FieldName = 'FIRMA_NAME'
          Width = 100
        end
        object cxGrid_SKLAD_COD: TcxGridDBColumn
          Caption = #1050#1086#1076' '#1089#1082#1083#1072#1076#1072' '#1074' 1'#1057
          DataBinding.FieldName = 'SKLAD_COD'
          Visible = False
        end
        object cxGrid_SKLAD_TITLE: TcxGridDBColumn
          Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1089#1082#1083#1072#1076#1072' '#1074' 1'#1057
          DataBinding.FieldName = 'SKLAD_TITLE'
          Visible = False
        end
        object cxGrid_SKLAD_TYPE: TcxGridDBColumn
          Caption = #1058#1080#1087' '#1089#1082#1083#1072#1076#1072
          DataBinding.FieldName = 'SKLAD_TYPE'
          Visible = False
        end
        object cxGrid_PERS_FIZ_CODE: TcxGridDBColumn
          Caption = #1050#1086#1076' '#1092#1080#1079' '#1083#1080#1094#1072' '#1074' 1'#1057
          DataBinding.FieldName = 'PERS_FIZ_CODE'
          Visible = False
        end
        object cxGrid_PERS_FIZ_TITLE: TcxGridDBColumn
          Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1092#1080#1079' '#1083#1080#1094#1072' '#1074' 1'#1057
          DataBinding.FieldName = 'PERS_FIZ_TITLE'
          Visible = False
        end
        object cxGrid_DT_TITLE: TcxGridDBColumn
          Caption = #1043#1086#1083#1086#1074#1085#1072#1103' '#1092#1080#1088#1084#1072
          DataBinding.FieldName = 'DT_TITLE'
          Width = 100
        end
      end
      object cxGridLevel: TcxGridLevel
        GridView = cxGridTable
      end
    end
  end
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 852
    Height = 64
    Title = #1055#1088#1080#1074#1103#1079#1082#1072' '#1092#1080#1088#1084' '#1082' 1'#1057
    Text = #1053#1072#1089#1090#1088#1086#1081#1082#1080'  '#1092#1080#1088#1084' '#1076#1083#1103' '#1101#1082#1089#1087#1086#1088#1090#1072' '#1076#1072#1085#1085#1099#1093' '#1074' 1'#1057
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
    ImageIndex = 15
  end
  object btnOk: TButton
    Left = 743
    Top = 368
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1047#1072#1082#1088#1099#1090#1100
    Default = True
    ModalResult = 1
    TabOrder = 2
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
    Left = 604
    Top = 8
    DockControlHeights = (
      0
      0
      0
      0)
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
      FloatLeft = 813
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbAddFirma'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbModifyFirma'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbDeleteFirma'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object bbAddFirma: TdxBarButton
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1092#1080#1088#1084#1091
      Category = 0
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1092#1080#1088#1084#1091
      Visible = ivAlways
      ImageIndex = 40
      OnClick = bbAddFirmaClick
    end
    object bbModifyFirma: TdxBarButton
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      Category = 0
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 41
      OnClick = bbModifyFirmaClick
    end
    object bbDeleteFirma: TdxBarButton
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Category = 0
      Hint = #1059#1076#1072#1083#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 42
      OnClick = bbDeleteFirmaClick
    end
  end
  object IBCQuery1C: TIBCQuery
    SQLInsert.Strings = (
      'INSERT INTO VW_TS_CUST_1C'
      
        '  (CUSTOMERID, FIRMA_COD, SKLAD_COD, SKLAD_TITLE, SKLAD_TYPE, FI' +
        'RMA_NAME, PERS_FIZ_CODE, PERS_FIZ_TITLE, DT)'
      'VALUES'
      
        '  (:CUSTOMERID, :FIRMA_COD, :SKLAD_COD, :SKLAD_TITLE, :SKLAD_TYP' +
        'E, :FIRMA_NAME, :PERS_FIZ_CODE, :PERS_FIZ_TITLE, :DT)')
    SQLDelete.Strings = (
      'DELETE FROM VW_TS_CUST_1C'
      'WHERE'
      '  CUSTOMERID = :Old_CUSTOMERID')
    SQLUpdate.Strings = (
      'UPDATE VW_TS_CUST_1C'
      'SET'
      ' CUSTOMERID = :CUSTOMERID,'
      ' FIRMA_COD = :FIRMA_COD,'
      ' SKLAD_COD = :SKLAD_COD,'
      ' SKLAD_TITLE = :SKLAD_TITLE,'
      ' SKLAD_TYPE = :SKLAD_TYPE,'
      ' FIRMA_NAME = :FIRMA_NAME,'
      ' PERS_FIZ_CODE = :PERS_FIZ_CODE,'
      ' PERS_FIZ_TITLE = :PERS_FIZ_TITLE,'
      ' DT = :DT'
      'WHERE'
      '  CUSTOMERID = :Old_CUSTOMERID')
    SQLRefresh.Strings = (
      'SELECT '
      ' CUSTOMERID, '
      ' CUSTOMER_TITLE,'
      ' CUSTOMER_PARENT_ID,'
      ' FIRMA_COD, '
      ' SKLAD_COD, '
      ' SKLAD_TITLE, '
      ' SKLAD_TYPE, '
      ' FIRMA_NAME, '
      ' PERS_FIZ_CODE, '
      ' PERS_FIZ_TITLE,'
      ' DT,'
      ' DT_TITLE'
      'FROM '
      ' VW_TS_CUST_1C'
      'WHERE'
      ' CUSTOMERID = :CUSTOMERID')
    SQLLock.Strings = (
      'SELECT NULL FROM TS_CUST_1C'
      'WHERE'
      'CUSTOMERID = :Old_CUSTOMERID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = IBCTr1СUpdate
    SQL.Strings = (
      'SELECT '
      ' CUSTOMERID, '
      ' CUSTOMER_TITLE,'
      ' CUSTOMER_PARENT_ID,'
      ' FIRMA_COD, '
      ' SKLAD_COD, '
      ' SKLAD_TITLE, '
      ' SKLAD_TYPE, '
      ' FIRMA_NAME, '
      ' PERS_FIZ_CODE, '
      ' PERS_FIZ_TITLE,'
      ' DT,'
      ' DT_TITLE'
      'FROM '
      ' VW_TS_CUST_1C'
      'WHERE'
      ' CUSTOMER_PARENT_ID = :PARENTID')
    AutoCommit = False
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Left = 88
    Top = 172
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PARENTID'
        Value = nil
      end>
  end
  object IBCDataSource1C: TIBCDataSource
    DataSet = IBCQuery1C
    Left = 88
    Top = 228
  end
  object IBCTr1СUpdate: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 176
    Top = 220
  end
end
