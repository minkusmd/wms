object frmGoodsCompatibleGoodsDlg: TfrmGoodsCompatibleGoodsDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Produse care pot fi inlocuite'
  ClientHeight = 634
  ClientWidth = 830
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  DesignSize = (
    830
    634)
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 830
    Height = 64
    Title = 'Produse care pot fi inlocuite'
    Text = 'Produse care pot fi inlocuite'
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
    ImageIndex = 1
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 814
    Height = 505
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 2
    Align = alTop
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    object Bevel1: TBevel
      Left = 0
      Top = 0
      Width = 810
      Height = 49
      Align = alTop
      Shape = bsSpacer
    end
    object cxLabel1: TLabel
      Left = 8
      Top = 15
      Width = 92
      Height = 15
      Caption = 'Denumire produs'
    end
    object edGOODS_NAME: TcxDBTextEdit
      Left = 176
      Top = 12
      TabStop = False
      DataBinding.DataField = 'TITLE'
      Properties.ReadOnly = True
      TabOrder = 1
      Width = 626
    end
    object edGOODSID: TcxDBTextEdit
      Left = 106
      Top = 12
      TabStop = False
      DataBinding.DataField = 'GOODSID'
      Properties.ReadOnly = True
      TabOrder = 0
      Width = 67
    end
    object dxBarDockControl1: TdxBarDockControl
      AlignWithMargins = True
      Left = 8
      Top = 49
      Width = 794
      Height = 30
      Margins.Left = 8
      Margins.Top = 0
      Margins.Right = 8
      Margins.Bottom = 1
      Align = dalTop
      BarManager = dxBarManager
      SunkenBorder = True
      UseOwnSunkenBorder = True
    end
    object cxGridGoods: TcxGrid
      AlignWithMargins = True
      Left = 8
      Top = 80
      Width = 794
      Height = 413
      Margins.Left = 8
      Margins.Top = 0
      Margins.Right = 8
      Margins.Bottom = 8
      Align = alClient
      TabOrder = 3
      object cxGridGoodsTable: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        OnCellDblClick = cxGridGoodsTableCellDblClick
        OnFocusedRecordChanged = cxGridGoodsTableFocusedRecordChanged
        DataController.DataModeController.GridMode = True
        DataController.DataSource = IBCDataSourceCompatible
        DataController.KeyFieldNames = 'GOODSID;COMPATIBLE_GOODSID'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnSorting = False
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.InvertSelect = False
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
        OptionsView.ScrollBars = ssVertical
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        Styles.ContentEven = dmAdditions.cxStyle_GridContentEven
        Styles.Header = dmAdditions.cxStyle_GridHeader
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        object cxGridGoodsTable_GOODSID: TcxGridDBColumn
          Caption = 'Cod'
          DataBinding.FieldName = 'COMPATIBLE_GOODSID'
          DataBinding.IsNullValueType = True
          HeaderAlignmentHorz = taCenter
          MinWidth = 50
          Options.HorzSizing = False
          Width = 50
        end
        object cxGridGoodsTable_IMG: TcxGridDBColumn
          DataBinding.FieldName = 'COMPATIBLE_GOODS_TYPE_ID'
          DataBinding.IsNullValueType = True
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.Items = <>
          MinWidth = 24
          Options.Filtering = False
          Options.Focusing = False
          Options.IncSearch = False
          Options.Grouping = False
          Options.HorzSizing = False
          Options.Moving = False
          Options.Sorting = False
          VisibleForCustomization = False
          Width = 24
          IsCaptionAssigned = True
        end
        object cxGridGoodsTable_GOODS_NAME: TcxGridDBColumn
          Caption = 'Denumire produs'
          DataBinding.FieldName = 'COMPATIBLE_GOODS_NAME'
          DataBinding.IsNullValueType = True
        end
        object cxGridGoodsTable_ORDERNO: TcxGridDBColumn
          DataBinding.FieldName = 'ORDERNO'
          DataBinding.IsNullValueType = True
          Visible = False
          VisibleForCustomization = False
        end
      end
      object cxGridGoodsLevel: TcxGridLevel
        GridView = cxGridGoodsTable
      end
    end
  end
  object btnOk: TcxButton
    AlignWithMargins = True
    Left = 617
    Top = 588
    Width = 90
    Height = 29
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 16
    Margins.Bottom = 12
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TcxButton
    AlignWithMargins = True
    Left = 723
    Top = 588
    Width = 90
    Height = 29
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 16
    Margins.Bottom = 12
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
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
      'Default')
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    ImageOptions.Images = dmAdditions.cxImageList_SWN
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 424
    Top = 12
    PixelsPerInch = 96
    object dxBarManagerBar1: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Goods'
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 588
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbAddGoods'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbModifyGoods'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbRemoveGoods'
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
    object bbAddGoods: TdxBarButton
      Caption = 'Nou'
      Category = 0
      Hint = 'Nou'
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 45
      OnClick = bbAddGoodsClick
    end
    object bbRemoveGoods: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      ShortCut = 46
      OnClick = bbRemoveGoodsClick
    end
    object bbReorder: TdxBarButton
      Caption = 'Sortare'
      Category = 0
      Hint = 'Sortare'
      Visible = ivAlways
      ImageIndex = 38
      OnClick = bbReorderClick
    end
    object bbModifyGoods: TdxBarButton
      Caption = 'Modifica'
      Category = 0
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 115
      OnClick = bbModifyGoodsClick
    end
    object dxBarSubItem1: TdxBarSubItem
      Caption = 'Suplimentar'
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbReorder'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbCustomDiffPrice'
        end>
    end
    object bbCustomDiffPrice: TdxBarSubItem
      Caption = 'Diferenta de preturi'
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarButton1'
        end
        item
          Visible = True
          ItemName = 'dxBarButton2'
        end
        item
          Visible = True
          ItemName = 'dxBarButton3'
        end>
    end
    object dxBarButton1: TdxBarButton
      Tag = 1
      Caption = '1%'
      Category = 0
      Hint = '1%'
      Visible = ivAlways
      ShortCut = 16433
      OnClick = dxBarButton1Click
    end
    object dxBarButton2: TdxBarButton
      Tag = 2
      Caption = '2%'
      Category = 0
      Hint = '2%'
      Visible = ivAlways
      ShortCut = 16434
      OnClick = dxBarButton1Click
    end
    object dxBarButton3: TdxBarButton
      Tag = 3
      Caption = '3%'
      Category = 0
      Hint = '3%'
      Visible = ivAlways
      ShortCut = 16435
      OnClick = dxBarButton1Click
    end
  end
  object IBCQueryCompatible: TIBCQuery
    UpdatingTable = 'VW_TS_GOODS_COMPATIBLE'
    SQLInsert.Strings = (
      'INSERT INTO VW_TS_GOODS_COMPATIBLE'
      
        '  (GOODSID, COMPATIBLE_GOODSID, DIFFSUMPERCENT, ORDERNO, COMPATI' +
        'BLE_GOODS_NAME)'
      'VALUES'
      
        '  (:GOODSID, :COMPATIBLE_GOODSID, :DIFFSUMPERCENT, :ORDERNO, :CO' +
        'MPATIBLE_GOODS_NAME)')
    SQLDelete.Strings = (
      'DELETE FROM VW_TS_GOODS_COMPATIBLE'
      'WHERE'
      
        '  GOODSID = :Old_GOODSID AND COMPATIBLE_GOODSID = :Old_COMPATIBL' +
        'E_GOODSID')
    SQLUpdate.Strings = (
      'UPDATE VW_TS_GOODS_COMPATIBLE'
      'SET'
      
        '  GOODSID = :GOODSID, COMPATIBLE_GOODSID = :COMPATIBLE_GOODSID, ' +
        'DIFFSUMPERCENT = :DIFFSUMPERCENT, ORDERNO = :ORDERNO, COMPATIBLE' +
        '_GOODS_NAME = :COMPATIBLE_GOODS_NAME'
      'WHERE'
      
        '  GOODSID = :Old_GOODSID AND COMPATIBLE_GOODSID = :Old_COMPATIBL' +
        'E_GOODSID')
    SQLRefresh.Strings = (
      'SELECT'
      ' GOODSID,'
      ' COMPATIBLE_GOODSID,'
      ' DIFFSUMPERCENT,'
      ' ORDERNO,'
      ' COMPATIBLE_GOODS_NAME,'
      ' COMPATIBLE_GOODS_TYPE_ID'
      'FROM'
      ' VW_TS_GOODS_COMPATIBLE'
      'WHERE'
      ' GOODSID = :GOODSID AND COMPATIBLE_GOODSID = :COMPATIBLE_GOODSID')
    SQLLock.Strings = (
      'SELECT NULL FROM VW_TS_GOODS_COMPATIBLE'
      'WHERE'
      
        'GOODSID = :Old_GOODSID AND COMPATIBLE_GOODSID = :Old_COMPATIBLE_' +
        'GOODSID'
      'FOR UPDATE WITH LOCK')
    SQL.Strings = (
      'SELECT'
      ' GOODSID,'
      ' COMPATIBLE_GOODSID,'
      ' DIFFSUMPERCENT,'
      ' ORDERNO,'
      ' COMPATIBLE_GOODS_NAME,'
      ' COMPATIBLE_GOODS_TYPE_ID'
      'FROM'
      ' VW_TS_GOODS_COMPATIBLE'
      'ORDER BY'
      ' ORDERNO')
    MasterFields = 'GOODSID'
    DetailFields = 'GOODSID'
    AutoCommit = False
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Left = 108
    Top = 272
  end
  object IBCDataSourceCompatible: TIBCDataSource
    DataSet = IBCQueryCompatible
    Left = 108
    Top = 224
  end
end
