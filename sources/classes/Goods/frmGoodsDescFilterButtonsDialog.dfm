object frmGoodsDescFilterButtonsDlg: TfrmGoodsDescFilterButtonsDlg
  Left = 0
  Top = 0
  ActiveControl = cxGrid
  BorderStyle = bsDialog
  Caption = 'Butoane de trecere pentru caracteristici'
  ClientHeight = 383
  ClientWidth = 436
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
    Width = 436
    Height = 64
    Title = 'Butoane de trecere pentru caracteristici'
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
    ImageIndex = 7
  end
  object pnClient: TPanel
    Left = 0
    Top = 64
    Width = 436
    Height = 265
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
      Width = 420
      Height = 30
      Align = dalTop
      BarManager = dxBarManager
      SunkenBorder = True
      UseOwnSunkenBorder = True
    end
    object cxGrid: TcxGrid
      Left = 8
      Top = 38
      Width = 420
      Height = 227
      Align = alClient
      TabOrder = 1
      object cxGridTable: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        OnFocusedRecordChanged = cxGridTableFocusedRecordChanged
        DataController.DataSource = IBCDataSourceButtons
        DataController.KeyFieldNames = 'GOODSID;DESCRIPTIONID;FILTER_BUTTON_ID'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsCustomize.ColumnFiltering = False
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsSelection.InvertSelect = False
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1082#1085#1086#1087#1086#1082'>'
        OptionsView.ScrollBars = ssVertical
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        Styles.Header = dmAdditions.cxStyle_GridHeader
        object cxGrid_FILTER_BUTTON_ID: TcxGridDBColumn
          Caption = 'ID'
          DataBinding.FieldName = 'FILTER_BUTTON_ID'
          HeaderAlignmentHorz = taCenter
          MinWidth = 40
          Options.HorzSizing = False
          Width = 40
        end
        object cxGrid_FILTER_BUTON_TITLE: TcxGridDBColumn
          Caption = 'Buton'
          DataBinding.FieldName = 'FILTER_BUTTON_TITLE'
        end
        object cxGridTableColumn3: TcxGridDBColumn
          Caption = 'Activ'
          DataBinding.FieldName = 'FILTER_BUTTON_FLG_ACTIVE'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          HeaderAlignmentHorz = taCenter
          MinWidth = 36
          Options.HorzSizing = False
          Width = 36
        end
        object cxGrid_ORDERNO: TcxGridDBColumn
          DataBinding.FieldName = 'ORDERNO'
          Visible = False
          SortIndex = 0
          SortOrder = soAscending
          VisibleForCustomization = False
          IsCaptionAssigned = True
        end
      end
      object cxGridLevel: TcxGridLevel
        GridView = cxGridTable
      end
    end
  end
  object btnClose: TButton
    Left = 328
    Top = 340
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Inchide'
    Default = True
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
    Left = 284
    Top = 8
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
      FloatLeft = 460
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbAdd'
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
          ItemName = 'bbRemove'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object bbAdd: TdxBarButton
      Caption = 'Adauga'
      Category = 0
      Hint = 'Adauga'
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 45
      OnClick = bbAddClick
    end
    object bbRemove: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      ShortCut = 46
      OnClick = bbRemoveClick
    end
    object bbModify: TdxBarButton
      Caption = 'Modifica'
      Category = 0
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 41
      OnClick = bbModifyClick
    end
  end
  object IBCQueryButtons: TIBCQuery
    SQLInsert.Strings = (
      'INSERT INTO TS_GOODS_DESC_BUTTONS'
      '  (GOODSID, DESCRIPTIONID, FILTER_BUTTON_ID)'
      'VALUES'
      '  (:GOODSID, :DESCRIPTIONID, :FILTER_BUTTON_ID)')
    SQLDelete.Strings = (
      'DELETE FROM TS_GOODS_DESC_BUTTONS'
      'WHERE'
      '  GOODSID = :Old_GOODSID '
      '  AND '
      '  DESCRIPTIONID = :Old_DESCRIPTIONID '
      '  AND '
      '  FILTER_BUTTON_ID = :Old_FILTER_BUTTON_ID')
    SQLUpdate.Strings = (
      'UPDATE TS_GOODS_DESC_BUTTONS'
      'SET'
      '  GOODSID = :GOODSID,'
      '  DESCRIPTIONID = :DESCRIPTIONID,'
      '  FILTER_BUTTON_ID = :FILTER_BUTTON_ID'
      'WHERE'
      '  GOODSID = :Old_GOODSID '
      '  AND '
      '  DESCRIPTIONID = :Old_DESCRIPTIONID '
      '  AND '
      '  FILTER_BUTTON_ID = :Old_FILTER_BUTTON_ID')
    SQLRefresh.Strings = (
      'SELECT'
      ' GOODSID,'
      ' DESCRIPTIONID,'
      ' FILTER_BUTTON_ID,'
      ' FILTER_BUTTON_TITLE,'
      ' FILTER_BUTTON_FLG_ACTIVE,'
      ' ORDERNO'
      'FROM '
      ' VW_TS_GOODS_DESC_BUTTONS'
      'WHERE'
      ' GOODSID = :GOODSID'
      ' AND'
      ' DESCRIPTIONID = :DESCRIPTIONID'
      ' AND'
      ' FILTER_BUTTON_ID = :FILTER_BUTTON_ID')
    SQLLock.Strings = (
      'SELECT '
      ' NULL '
      'FROM'
      ' TS_GOODS_DESC_BUTTONS'
      'WHERE'
      '  GOODSID = :Old_GOODSID '
      '  AND '
      '  DESCRIPTIONID = :Old_DESCRIPTIONID '
      '  AND '
      '  FILTER_BUTTON_ID = :Old_FILTER_BUTTON_ID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT'
      ' GOODSID,'
      ' DESCRIPTIONID,'
      ' FILTER_BUTTON_ID,'
      ' FILTER_BUTTON_TITLE,'
      ' FILTER_BUTTON_FLG_ACTIVE,'
      ' ORDERNO'
      'FROM '
      ' VW_TS_GOODS_DESC_BUTTONS'
      'WHERE'
      ' GOODSID = :G_ID'
      ' AND'
      ' DESCRIPTIONID = :D_ID')
    AutoCommit = False
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Options.RequiredFields = False
    LocalConstraints = False
    Left = 76
    Top = 236
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'G_ID'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'D_ID'
        Value = nil
      end>
  end
  object IBCDataSourceButtons: TIBCDataSource
    DataSet = IBCQueryButtons
    Left = 76
    Top = 180
  end
end
