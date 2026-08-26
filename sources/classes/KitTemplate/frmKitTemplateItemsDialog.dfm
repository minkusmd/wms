object frmKitTemplatesDlg: TfrmKitTemplatesDlg
  Left = 0
  Top = 0
  ActiveControl = cxGridTemplate
  BorderStyle = bsDialog
  Caption = #1064#1072#1073#1083#1086#1085#1099' '#1082#1086#1085#1092#1080#1075#1091#1088#1072#1094#1080#1081
  ClientHeight = 439
  ClientWidth = 709
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnShow = FormShow
  DesignSize = (
    709
    439)
  PixelsPerInch = 96
  TextHeight = 15
  object DialogTitle1: TDialogTitle
    Left = 0
    Top = 0
    Width = 709
    Height = 64
    Title = #1064#1072#1073#1083#1086#1085#1099' '#1082#1086#1085#1092#1080#1075#1091#1088#1072#1094#1080#1081
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
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 693
    Height = 305
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object cxGridTemplateDetails: TcxGrid
      AlignWithMargins = True
      Left = 243
      Top = 30
      Width = 450
      Height = 275
      Margins.Left = 2
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alClient
      TabOrder = 0
      object cxGridTemplateDetailsTable: TcxGridDBTableView
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
        OnCellDblClick = cxGridTemplateDetailsTableCellDblClick
        DataController.DataSource = IBCDataSourceItems
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsCustomize.ColumnsQuickCustomization = True
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
        Styles.ContentEven = dmAdditions.cxStyle_GridContentEven
        Styles.Header = dmAdditions.cxStyle_GridHeader
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        object cxGridTemplateItemCol_ID: TcxGridDBColumn
          AlternateCaption = #1050#1086#1076' '#1090#1086#1074#1072#1088#1072
          Caption = #1050#1086#1076
          DataBinding.FieldName = 'GOODSID'
          Visible = False
          MinWidth = 50
          Options.Filtering = False
          Options.HorzSizing = False
          Options.Moving = False
          Width = 50
        end
        object cxGridTemplateItemCol_GOODS_NAME: TcxGridDBColumn
          Caption = #1058#1086#1074#1072#1088
          DataBinding.FieldName = 'GOODS_NAME'
          Options.Filtering = False
          VisibleForCustomization = False
        end
        object cxGridTemplateItemCol_UM_NAME: TcxGridDBColumn
          Caption = #1045#1048
          DataBinding.FieldName = 'UM_NAME'
          HeaderAlignmentHorz = taCenter
          MinWidth = 40
          Options.Filtering = False
          Options.HorzSizing = False
          VisibleForCustomization = False
          Width = 40
        end
        object cxGridTemplateItemCol_QTY: TcxGridDBColumn
          Caption = #1050#1086#1083'-'#1074#1086
          DataBinding.FieldName = 'QTY'
          HeaderAlignmentHorz = taCenter
          MinWidth = 50
          Options.Filtering = False
          Options.HorzSizing = False
          VisibleForCustomization = False
          Width = 50
        end
        object cxGridTemplateItemCol_FLG_ACTIVE: TcxGridDBColumn
          Caption = #1040#1082#1090#1080#1074#1077#1085
          DataBinding.FieldName = 'FLG_ACTIVE'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          HeaderAlignmentHorz = taCenter
          MinWidth = 60
          Options.Filtering = False
          Options.HorzSizing = False
          VisibleForCustomization = False
          Width = 60
        end
      end
      object cxGridTemplateLevel: TcxGridLevel
        GridView = cxGridTemplateDetailsTable
      end
    end
    object dxBarDockControl1: TdxBarDockControl
      Left = 0
      Top = 0
      Width = 693
      Height = 30
      Align = dalTop
      BarManager = dxBarManager
      SunkenBorder = True
      UseOwnSunkenBorder = True
    end
    object cxGridTemplate: TcxGrid
      Left = 0
      Top = 30
      Width = 241
      Height = 275
      Align = alLeft
      TabOrder = 2
      object cxGridTemplateTable: TcxGridDBTableView
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
        OnCellDblClick = cxGridTemplateTableCellDblClick
        DataController.DataSource = IBCDataSourceKit
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsCustomize.ColumnsQuickCustomization = True
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
        Styles.ContentEven = dmAdditions.cxStyle_GridContentEven
        Styles.Header = dmAdditions.cxStyle_GridHeader
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        object cxGridTemplateColID: TcxGridDBColumn
          AlternateCaption = #1050#1086#1076' '#1096#1072#1073#1083#1086#1085#1072
          Caption = #1050#1086#1076
          DataBinding.FieldName = 'KITTEMPLATEID'
          Visible = False
          HeaderAlignmentHorz = taCenter
          MinWidth = 50
          Options.Filtering = False
          Options.HorzSizing = False
          Options.Moving = False
          Width = 50
        end
        object cxGridTemplateColTITLE: TcxGridDBColumn
          Caption = #1053#1072#1079#1074#1072#1085#1080#1077
          DataBinding.FieldName = 'TITLE'
          Options.Filtering = False
          VisibleForCustomization = False
        end
      end
      object cxGridLevel: TcxGridLevel
        GridView = cxGridTemplateTable
      end
    end
  end
  object btnCancel: TcxButton
    Left = 595
    Top = 393
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 7
  end
  object btnOk: TcxButton
    Left = 491
    Top = 393
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'Ok'
    Default = True
    TabOrder = 2
    OnClick = btnOkClick
  end
  object dxBarManager: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Default'
      'General')
    Categories.ItemsVisibles = (
      2
      2)
    Categories.Visibles = (
      True
      True)
    ImageOptions.Images = dmAdditions.cxImageList_SWN
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 408
    Top = 28
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
      Caption = 'Template'
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 3
      FloatTop = 386
      FloatClientWidth = 98
      FloatClientHeight = 100
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbNew'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbNewGoods'
        end
        item
          Visible = True
          ItemName = 'bsModifyMenu'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bsRemoveMenu'
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
      Caption = #1053#1086#1074#1099#1081' '#1096#1072#1073#1083#1086#1085
      Category = 1
      Hint = #1053#1086#1074#1099#1081' '#1096#1072#1073#1083#1086#1085
      Visible = ivAlways
      ImageIndex = 0
      OnClick = bbNewClick
    end
    object bbNewGoods: TdxBarButton
      Caption = #1053#1086#1074#1099#1081' '#1090#1086#1074#1072#1088
      Category = 1
      Hint = #1053#1086#1074#1099#1081' '#1090#1086#1074#1072#1088
      Visible = ivAlways
      ImageIndex = 12
      ShortCut = 16429
      OnClick = bbNewGoodsClick
    end
    object bsModifyMenu: TdxBarSubItem
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      Category = 1
      Visible = ivAlways
      ImageIndex = 1
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbModifyTemplate'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbModifyItem'
        end>
    end
    object bbModifyTemplate: TdxBarButton
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1096#1072#1073#1083#1086#1085
      Category = 1
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100' '#1096#1072#1073#1083#1086#1085
      Visible = ivAlways
      OnClick = bbModifyTemplateClick
    end
    object bbModifyItem: TdxBarButton
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1090#1086#1074#1072#1088
      Category = 1
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100' '#1090#1086#1074#1072#1088
      Visible = ivAlways
      OnClick = bbModifyItemClick
    end
    object bsRemoveMenu: TdxBarSubItem
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Category = 1
      Visible = ivAlways
      ImageIndex = 2
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbRemoveTemplate'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbRemoveItem'
        end>
    end
    object bbRemoveTemplate: TdxBarButton
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1096#1072#1073#1083#1086#1085
      Category = 1
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1096#1072#1073#1083#1086#1085
      Visible = ivAlways
      OnClick = bbRemoveTemplateClick
    end
    object bbRemoveItem: TdxBarButton
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1090#1086#1074#1072#1088
      Category = 1
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1090#1086#1074#1072#1088
      Visible = ivAlways
      ShortCut = 16430
      OnClick = bbRemoveItemClick
    end
  end
  object IBCQueryKit: TIBCQuery
    UpdatingTable = 'VW_TS_KIT_TEMPLATES'
    KeyFields = 'KITTEMPLATEID'
    KeyGenerator = 'SQ_TS_KIT_TEMPLATES_ID'
    GeneratorMode = gmInsert
    SQLInsert.Strings = (
      'INSERT INTO VW_TS_KIT_TEMPLATES'
      '  (KITTEMPLATEID, TITLE)'
      'VALUES'
      '  (:KITTEMPLATEID, :TITLE)')
    SQLDelete.Strings = (
      'DELETE FROM VW_TS_KIT_TEMPLATES'
      'WHERE'
      '  KITTEMPLATEID = :Old_KITTEMPLATEID')
    SQLUpdate.Strings = (
      'UPDATE VW_TS_KIT_TEMPLATES'
      'SET'
      '  KITTEMPLATEID = :KITTEMPLATEID, '
      '  TITLE = :TITLE'
      'WHERE'
      '  KITTEMPLATEID = :Old_KITTEMPLATEID')
    SQLRefresh.Strings = (
      'SELECT '
      ' KITTEMPLATEID, '
      ' TITLE '
      'FROM '
      ' VW_TS_KIT_TEMPLATES'
      'WHERE'
      '  KITTEMPLATEID = :KITTEMPLATEID')
    SQLLock.Strings = (
      'SELECT NULL FROM VW_TS_KIT_TEMPLATES'
      'WHERE'
      'KITTEMPLATEID = :Old_KITTEMPLATEID'
      'FOR UPDATE WITH LOCK')
    UpdateTransaction = IBCTrUpdateKit
    SQL.Strings = (
      'SELECT KITTEMPLATEID, TITLE'
      'FROM VW_TS_KIT_TEMPLATES')
    AutoCommit = False
    Options.BooleanDomainFields = True
    Constraints = <>
    Left = 176
    Top = 168
  end
  object IBCDataSourceKit: TIBCDataSource
    DataSet = IBCQueryKit
    OnDataChange = IBCDataSourceKitDataChange
    Left = 176
    Top = 112
  end
  object IBCDataSourceItems: TIBCDataSource
    DataSet = IBCQueryItems
    OnDataChange = IBCDataSourceItemsDataChange
    Left = 328
    Top = 160
  end
  object IBCQueryItems: TIBCQuery
    UpdatingTable = 'VW_TS_KIT_TEMPLATE_ITEMS'
    SQLInsert.Strings = (
      'INSERT INTO VW_TS_KIT_TEMPLATE_ITEMS'
      '  (KITTEMPLATEID, GOODSID, QTY, FLG_ACTIVE)'
      'VALUES'
      '  (:KITTEMPLATEID, :GOODSID, :QTY, :FLG_ACTIVE)')
    SQLDelete.Strings = (
      'DELETE FROM VW_TS_KIT_TEMPLATE_ITEMS'
      'WHERE'
      '  KITTEMPLATEID = :Old_KITTEMPLATEID AND GOODSID = :Old_GOODSID')
    SQLUpdate.Strings = (
      'UPDATE VW_TS_KIT_TEMPLATE_ITEMS'
      'SET'
      
        '  KITTEMPLATEID = :KITTEMPLATEID, GOODSID = :GOODSID, QTY = :QTY' +
        ', FLG_ACTIVE = :FLG_ACTIVE'
      'WHERE'
      '  KITTEMPLATEID = :Old_KITTEMPLATEID AND GOODSID = :Old_GOODSID')
    SQLRefresh.Strings = (
      
        'SELECT VW_TS_KIT_TEMPLATE_ITEMS.KITTEMPLATEID, VW_TS_KIT_TEMPLAT' +
        'E_ITEMS.GOODSID, VW_TS_KIT_TEMPLATE_ITEMS.QTY, VW_TS_KIT_TEMPLAT' +
        'E_ITEMS.FLG_ACTIVE FROM VW_TS_KIT_TEMPLATE_ITEMS'
      'WHERE'
      '  KITTEMPLATEID = :KITTEMPLATEID AND GOODSID = :GOODSID')
    SQLLock.Strings = (
      'SELECT NULL FROM VW_TS_KIT_TEMPLATE_ITEMS'
      'WHERE'
      'KITTEMPLATEID = :Old_KITTEMPLATEID AND GOODSID = :Old_GOODSID'
      'FOR UPDATE WITH LOCK')
    UpdateTransaction = IBCTrUpdateItems
    SQL.Strings = (
      'SELECT * FROM VW_TS_KIT_TEMPLATE_ITEMS')
    MasterFields = 'KITTEMPLATEID'
    DetailFields = 'KITTEMPLATEID'
    MasterSource = IBCDataSourceKit
    AutoCommit = False
    RefreshOptions = [roAfterInsert, roAfterUpdate, roBeforeEdit]
    Options.BooleanDomainFields = True
    Constraints = <>
    Left = 328
    Top = 212
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'KITTEMPLATEID'
        Value = nil
      end>
  end
  object IBCTrUpdateKit: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 176
    Top = 220
  end
  object IBCTrUpdateItems: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 328
    Top = 264
  end
end
