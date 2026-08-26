object frmGoodsImagesEditorDialog: TfrmGoodsImagesEditorDialog
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  ClientHeight = 572
  ClientWidth = 431
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnShow = FormShow
  DesignSize = (
    431
    572)
  PixelsPerInch = 96
  TextHeight = 15
  object dxBarDockControl1: TdxBarDockControl
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 415
    Height = 30
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 1
    Align = dalTop
    BarManager = dxBarManager
    SunkenBorder = True
    UseOwnSunkenBorder = True
  end
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 431
    Height = 64
    Title = #1042#1085#1077#1096#1085#1080#1081' '#1074#1080#1076' '#1090#1086#1074#1072#1088#1072
    Text = #1047#1072#1075#1088#1091#1079#1080#1090#1077' '#1082#1072#1088#1090#1080#1085#1082#1080' '#1076#1083#1103' '#1076#1072#1085#1085#1086#1075#1086' '#1090#1086#1074#1072#1088#1072
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
  end
  object cxGridInfo: TcxGrid
    AlignWithMargins = True
    Left = 8
    Top = 103
    Width = 415
    Height = 414
    Margins.Left = 8
    Margins.Top = 0
    Margins.Right = 8
    Margins.Bottom = 1
    Align = alTop
    TabOrder = 2
    object cxGridInfoTable: TcxGridDBTableView
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
      OnCellDblClick = cxGridInfoTableCellDblClick
      DataController.DataSource = IBCDataSourceGoodsImages
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.ImmediateEditor = False
      OptionsCustomize.ColumnFiltering = False
      OptionsCustomize.ColumnGrouping = False
      OptionsCustomize.ColumnMoving = False
      OptionsCustomize.ColumnSorting = False
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
      OptionsView.ScrollBars = ssVertical
      OptionsView.ShowEditButtons = gsebForFocusedRecord
      OptionsView.ColumnAutoWidth = True
      OptionsView.DataRowHeight = 128
      OptionsView.GridLineColor = 13750737
      OptionsView.GroupByBox = False
      OptionsView.Indicator = True
      Styles.ContentEven = dmAdditions.cxStyle_GridContentEven
      Styles.Header = dmAdditions.cxStyle_GridHeader
      Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
      object cxGridInfoTableID: TcxGridDBColumn
        Caption = 'ID'
        DataBinding.FieldName = 'GOODS_IMAGE_ID'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Vert = taVCenter
        FooterAlignmentHorz = taCenter
        HeaderAlignmentHorz = taCenter
        MinWidth = 40
        Options.Filtering = False
        Options.Grouping = False
        Options.HorzSizing = False
        Options.Moving = False
        Options.Sorting = False
        Width = 40
      end
      object cxGridInfoTableImage: TcxGridDBColumn
        Caption = #1050#1072#1088#1090#1080#1085#1082#1072
        DataBinding.FieldName = 'IMAGE'
        PropertiesClassName = 'TcxImageProperties'
        Properties.Caption = #1085#1077#1090#1091' '#1082#1072#1088#1090#1080#1085#1082#1080
        Properties.GraphicClassName = 'TJPEGImage'
        Properties.PopupMenuLayout.MenuItems = [pmiCopy, pmiPaste, pmiLoad, pmiSave]
        Options.Filtering = False
        Options.Moving = False
        Options.Sorting = False
        Width = 394
      end
      object cxGridInfoTableColumn1: TcxGridDBColumn
        Caption = #1053#1072#1095#1072#1083#1086' '#1087#1086#1082#1072#1079#1072
        DataBinding.FieldName = 'DATA_START'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taCenter
        Properties.Alignment.Vert = taVCenter
        HeaderAlignmentHorz = taCenter
        MinWidth = 100
        Options.ShowEditButtons = isebNever
        Options.HorzSizing = False
        Styles.Content = dmAdditions.cxStyle_Bold
        Width = 100
      end
      object cxGridInfoTableColumn2: TcxGridDBColumn
        Caption = #1050#1086#1085#1077#1094' '#1087#1086#1082#1072#1079#1072
        DataBinding.FieldName = 'DATA_END'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taCenter
        Properties.Alignment.Vert = taVCenter
        HeaderAlignmentHorz = taCenter
        MinWidth = 100
        Options.ShowEditButtons = isebNever
        Options.HorzSizing = False
        Styles.Content = dmAdditions.cxStyle_Bold
        Width = 100
      end
    end
    object cxGridInfoLevel: TcxGridLevel
      GridView = cxGridInfoTable
    end
  end
  object btnOk: TcxButton
    Left = 217
    Top = 529
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'Ok'
    TabOrder = 3
    OnClick = btnOkClick
  end
  object btnCancel: TcxButton
    Left = 321
    Top = 529
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 8
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
    Left = 296
    Top = 136
    DockControlHeights = (
      0
      0
      0
      0)
    object dxBarManagerBar1: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Image'
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 515
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbNewImage'
        end
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
          ItemName = 'bbRemove'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbViewImage'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object bbRemove: TdxBarButton
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Category = 0
      Hint = #1059#1076#1072#1083#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 2
      ShortCut = 16430
      OnClick = bbRemoveClick
    end
    object bbNewImage: TdxBarButton
      Caption = #1053#1086#1074#1072#1103' '#1082#1072#1088#1090#1080#1085#1082#1072
      Category = 0
      Hint = #1053#1086#1074#1072#1103' '#1082#1072#1088#1090#1080#1085#1082#1072
      Visible = ivAlways
      ImageIndex = 0
      OnClick = bbNewImageClick
    end
    object bbViewImage: TdxBarButton
      Caption = #1054#1088#1080#1075#1080#1085#1072#1083
      Category = 0
      Hint = #1054#1088#1080#1075#1080#1085#1072#1083
      Visible = ivAlways
      ImageIndex = 4
      OnClick = bbViewImageClick
    end
    object dxBarButton1: TdxBarButton
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      Category = 0
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 1
      OnClick = dxBarButton1Click
    end
  end
  object IBCDataSourceGoodsImages: TIBCDataSource
    DataSet = IBCQueryGoodsImages
    OnDataChange = DataSourceGoodsImagesDataChange
    Left = 76
    Top = 140
  end
  object IBCQueryGoodsImages: TIBCQuery
    UpdatingTable = 'TS_GOODS_IMAGE'
    SQLInsert.Strings = (
      'INSERT INTO TS_GOODS_IMAGE'
      '  (GOODSID, GOODS_IMAGE_ID, IMAGE, DATA_START, DATA_END)'
      'VALUES'
      '  (:GOODSID, :GOODS_IMAGE_ID, :IMAGE, :DATA_START, :DATA_END)')
    SQLDelete.Strings = (
      'DELETE FROM TS_GOODS_IMAGE'
      'WHERE'
      ' GOODSID = :Old_GOODSID '
      ' AND '
      ' GOODS_IMAGE_ID = :Old_GOODS_IMAGE_ID')
    SQLUpdate.Strings = (
      'UPDATE TS_GOODS_IMAGE'
      'SET'
      ' GOODSID = :GOODSID, '
      ' GOODS_IMAGE_ID = :GOODS_IMAGE_ID, '
      ' IMAGE = :IMAGE, '
      ' DATA_START = :DATA_START, '
      ' DATA_END = :DATA_END'
      'WHERE'
      
        '  GOODSID = :Old_GOODSID AND GOODS_IMAGE_ID = :Old_GOODS_IMAGE_I' +
        'D')
    SQLRefresh.Strings = (
      'SELECT'
      ' TS_GOODS_IMAGE.GOODSID,'
      ' TS_GOODS_IMAGE.GOODS_IMAGE_ID,'
      ' TS_GOODS_IMAGE.IMAGE,'
      ' TS_GOODS_IMAGE.DATA_START,'
      ' TS_GOODS_IMAGE.DATA_END '
      'FROM '
      ' TS_GOODS_IMAGE'
      'WHERE'
      ' GOODSID = :GOODSID '
      ' AND'
      ' GOODS_IMAGE_ID = :GOODS_IMAGE_ID')
    SQLLock.Strings = (
      'SELECT NULL FROM TS_GOODS_IMAGE'
      'WHERE'
      'GOODSID = :Old_GOODSID AND GOODS_IMAGE_ID = :Old_GOODS_IMAGE_ID'
      'FOR UPDATE WITH LOCK')
    UpdateTransaction = IBCTrUpdateGoodsImages
    SQL.Strings = (
      'SELECT'
      ' GOODSID,'
      ' GOODS_IMAGE_ID,'
      ' IMAGE,'
      ' DATA_START,'
      ' DATA_END   '
      'FROM'
      ' TS_GOODS_IMAGE'
      'ORDER BY '
      ' GOODS_IMAGE_ID')
    MasterFields = 'GOODSID'
    DetailFields = 'GOODSID'
    AutoCommit = False
    Options.BooleanDomainFields = True
    Constraints = <>
    Left = 76
    Top = 192
  end
  object IBCTrUpdateGoodsImages: TIBCTransaction
    Left = 76
    Top = 248
  end
end
