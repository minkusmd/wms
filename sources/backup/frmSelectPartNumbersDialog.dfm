object frmSelectPartsDlg: TfrmSelectPartsDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1042#1099#1073#1086#1088' '#1087#1072#1088#1090#1080#1080
  ClientHeight = 480
  ClientWidth = 700
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnShow = FormShow
  DesignSize = (
    700
    480)
  PixelsPerInch = 96
  TextHeight = 15
  object DialogTitle1: TDialogTitle
    Left = 0
    Top = 0
    Width = 700
    Height = 64
    Title = #1042#1099#1073#1086#1088' '#1087#1072#1088#1090#1080#1080
    Text = #1042#1099#1073#1077#1088#1080#1090#1077' '#1087#1072#1088#1090#1080#1080' '#1080#1079' '#1089#1087#1080#1089#1082#1072' '
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
    ImageIndex = 17
  end
  object btnOk: TcxButton
    Left = 482
    Top = 435
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'Ok'
    TabOrder = 2
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 684
    Height = 346
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object cxGridAParts: TcxGrid
      AlignWithMargins = True
      Left = 0
      Top = 31
      Width = 289
      Height = 315
      Margins.Left = 0
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 0
      Align = alLeft
      TabOrder = 1
      object cxGridAPartsTable: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        DataController.DataSource = dsGetParts
        DataController.KeyFieldNames = 'PARTNO'
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
        OptionsSelection.InvertSelect = False
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        Styles.ContentEven = dmAdditions.cxStyle_GridContentEven
        Styles.Header = dmAdditions.cxStyle_GridHeader
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        object cxGridAPartsTablePartNO: TcxGridDBColumn
          Caption = #1055#1072#1088#1090#1080#1103
          DataBinding.FieldName = 'PARTNO'
          Width = 226
        end
        object cxGridAPartsTableQTY: TcxGridDBColumn
          Caption = #1050#1086#1083'-'#1074#1086
          DataBinding.FieldName = 'QTY'
          Width = 61
        end
      end
      object cxGridAPartsLevel: TcxGridLevel
        GridView = cxGridAPartsTable
      end
    end
    object cxGridSParts: TcxGrid
      AlignWithMargins = True
      Left = 291
      Top = 31
      Width = 393
      Height = 315
      Margins.Left = 1
      Margins.Top = 1
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alClient
      TabOrder = 2
      object cxGridSPartsTable: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        DataController.DataSource = dsSetParts
        DataController.KeyFieldNames = 'PARTNO'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsSelection.InvertSelect = False
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        Styles.ContentEven = dmAdditions.cxStyle_GridContentEven
        Styles.Header = dmAdditions.cxStyle_GridHeader
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        object cxGridDBPartNO: TcxGridDBColumn
          Caption = #1055#1072#1088#1090#1080#1103
          DataBinding.FieldName = 'PARTNO'
          Width = 254
        end
        object cxGridSPartsTableQTY: TcxGridDBColumn
          Caption = #1050#1086#1083'-'#1074#1086
          DataBinding.FieldName = 'QTY'
          Width = 67
        end
      end
      object cxGridLevel: TcxGridLevel
        GridView = cxGridSPartsTable
      end
    end
    object dxBarDockControl1: TdxBarDockControl
      Left = 0
      Top = 0
      Width = 684
      Height = 30
      Align = dalTop
      BarManager = dxBarManager
      SunkenBorder = True
      UseOwnSunkenBorder = True
    end
  end
  object cxButton1: TcxButton
    Left = 586
    Top = 435
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
  object dxBarManager: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      #1055#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
      #1052#1077#1085#1102)
    Categories.ItemsVisibles = (
      2
      2)
    Categories.Visibles = (
      True
      True)
    ImageOptions.Images = dmAdditions.cxImageList_SWN
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 356
    Top = 16
    PixelsPerInch = 96
    object dxBarManager1Bar1: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' 1'
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 771
      FloatTop = 177
      FloatClientWidth = 51
      FloatClientHeight = 22
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'dxBarButton1'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'dxBarButton2'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object dxBarButton1: TdxBarButton
      Caption = #1042#1099#1073#1088#1072#1090#1100' '#1087#1072#1088#1090#1080#1102
      Category = 1
      Hint = #1042#1099#1073#1088#1072#1090#1100' '#1087#1072#1088#1090#1080#1102
      Visible = ivAlways
      ImageIndex = 34
      ShortCut = 16465
      OnClick = dxBarButton1Click
    end
    object dxBarButton2: TdxBarButton
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1074#1089#1077
      Category = 1
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1074#1089#1077
      Visible = ivAlways
      ImageIndex = 35
      OnClick = dxBarButton2Click
    end
  end
  object IBCGetParts: TIBCQuery
    KeyFields = 'PARTNO'
    SQLInsert.Strings = (
      'INSERT INTO TMP_SN'
      '  (SN)'
      'VALUES'
      '  (:SN)')
    SQL.Strings = (
      'SELECT * FROM TMP_PARTS ORDER BY QTY')
    MasterFields = 'GOODSID;DTDEP;DT'
    DetailFields = 'GOODSID;DTDEP;DT'
    AutoCommit = False
    Left = 144
    Top = 160
  end
  object dsGetParts: TIBCDataSource
    DataSet = IBCGetParts
    Left = 64
    Top = 160
  end
  object IBCSetParts: TIBCQuery
    KeyFields = 'DOCID;DTDEP;CTDEP;GOODSCOMPLECT_ID;GOODSID;PARTNO'
    SQL.Strings = (
      'select * from tdb_parts')
    MasterFields = 'DOCID;DTDEP;CTDEP;GOODSCOMPLECT_ID;GOODSID'
    DetailFields = 'DOCID;DTDEP;CTDEP;GOODSCOMPLECT_ID;GOODSID'
    AutoCommit = False
    Options.RequiredFields = False
    LocalConstraints = False
    Left = 536
    Top = 160
  end
  object dsSetParts: TIBCDataSource
    DataSet = IBCSetParts
    Left = 464
    Top = 152
  end
end
