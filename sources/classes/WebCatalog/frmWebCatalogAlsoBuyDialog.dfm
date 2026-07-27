object frmWebCatalogAlsoBuyDlg: TfrmWebCatalogAlsoBuyDlg
  Left = 0
  Top = 0
  ActiveControl = cxGrid
  BorderStyle = bsDialog
  Caption = 'Cu acest produs se mai cumpara'
  ClientHeight = 442
  ClientWidth = 466
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
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 8
    Width = 450
    Height = 377
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 0
    object dxBarDockControl1: TdxBarDockControl
      Left = 0
      Top = 0
      Width = 450
      Height = 30
      Align = dalTop
      BarManager = dxBarManager1
      SunkenBorder = True
      UseOwnSunkenBorder = True
    end
    object cxGrid: TcxGrid
      Left = 0
      Top = 30
      Width = 450
      Height = 347
      Align = alClient
      TabOrder = 1
      object cxGridTable: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        OnFocusedRecordChanged = cxGridTableFocusedRecordChanged
        DataController.DataSource = IBCDataSourceData
        DataController.KeyFieldNames = 'CATALOGID;GOODSID'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsCustomize.ColumnFiltering = False
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
        Styles.Header = dmAdditions.cxStyle_GridHeader
        object cxGridTable_GOODSID: TcxGridDBColumn
          Caption = 'Cod grupa'
          DataBinding.FieldName = 'GOODSID'
          HeaderAlignmentHorz = taCenter
          MinWidth = 70
          Options.HorzSizing = False
          Width = 70
        end
        object cxGridTable_IMG: TcxGridDBColumn
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.DefaultImageIndex = 13
          Properties.Images = dmAdditions.cxImageList_SWN
          Properties.Items = <>
          MinWidth = 26
          Options.HorzSizing = False
          Width = 26
        end
        object cxGridTable_TITLE: TcxGridDBColumn
          Caption = 'Denumire'
          DataBinding.FieldName = 'TITLE'
          Width = 200
        end
        object cxGridTable_ORDERNO: TcxGridDBColumn
          DataBinding.FieldName = 'ORDERNO'
          Visible = False
          SortIndex = 0
          SortOrder = soAscending
          VisibleForCustomization = False
        end
      end
      object cxGridLevel: TcxGridLevel
        GridView = cxGridTable
      end
    end
  end
  object btnOk: TButton
    Left = 247
    Top = 404
    Width = 90
    Height = 29
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancel: TButton
    Left = 351
    Top = 404
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
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
    Left = 252
    Top = 168
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
      FloatLeft = 595
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbAddGroup'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbRemoveGroup'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object bbAddGroup: TdxBarButton
      Caption = 'Nou'
      Category = 0
      Hint = 'Nou'
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 45
      OnClick = bbAddGroupClick
    end
    object bbRemoveGroup: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      ShortCut = 46
      OnClick = bbRemoveGroupClick
    end
  end
  object IBCQueryData: TIBCQuery
    SQLInsert.Strings = (
      'INSERT INTO TWEB_CATALOG_ALSOBUY'
      '  (CATALOGID, GOODSID)'
      'VALUES'
      '  (:CATALOGID, :GOODSID)')
    SQLDelete.Strings = (
      'DELETE FROM TWEB_CATALOG_ALSOBUY'
      'WHERE'
      '  CATALOGID = :Old_CATALOGID AND GOODSID = :Old_GOODSID')
    SQLRefresh.Strings = (
      'SELECT '
      ' C.CATALOGID,'
      ' C.GOODSID,'
      ' C.ORDERNO,'
      ' G.TITLE'
      'FROM TWEB_CATALOG_ALSOBUY C'
      'INNER JOIN TS_GOODS G ON G.GOODSID = C.GOODSID'
      'WHERE'
      '  C.CATALOGID = :CATALOGID AND C.GOODSID = :GOODSID')
    SQL.Strings = (
      'SELECT '
      ' C.CATALOGID,'
      ' C.GOODSID,'
      ' C.ORDERNO,'
      ' G.TITLE'
      'FROM TWEB_CATALOG_ALSOBUY C'
      'INNER JOIN TS_GOODS G ON G.GOODSID = C.GOODSID'
      'ORDER BY C.ORDERNO')
    MasterFields = 'CATALOGID'
    DetailFields = 'CATALOGID'
    AutoCommit = False
    RefreshOptions = [roAfterInsert]
    Options.RequiredFields = False
    LocalConstraints = False
    Left = 76
    Top = 236
  end
  object IBCDataSourceData: TIBCDataSource
    DataSet = IBCQueryData
    Left = 76
    Top = 180
  end
end
