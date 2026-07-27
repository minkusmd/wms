object frmKitTemplatesDlg: TfrmKitTemplatesDlg
  Left = 0
  Top = 0
  ActiveControl = cxGridTemplate
  BorderIcons = [biSystemMenu]
  Caption = #1064#1072#1073#1083#1086#1085#1099' '#1082#1086#1085#1092#1080#1075#1091#1088#1072#1094#1080#1081
  ClientHeight = 646
  ClientWidth = 750
  Color = clBtnFace
  Constraints.MinHeight = 500
  Constraints.MinWidth = 600
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
    Width = 750
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
    ImageIndex = 11
  end
  object dxBarDockControl1: TdxBarDockControl
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 734
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
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 103
    Width = 734
    Height = 486
    Margins.Left = 8
    Margins.Top = 0
    Margins.Right = 8
    Margins.Bottom = 0
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object cxGridTemplate: TcxGrid
      Left = 0
      Top = 0
      Width = 734
      Height = 174
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 2
      Margins.Bottom = 0
      Align = alClient
      TabOrder = 0
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
        ScrollbarAnnotations.CustomAnnotations = <>
        OnCellDblClick = cxGridTemplateTableCellDblClick
        DataController.DataSource = IBCDataSourceKit
        DataController.KeyFieldNames = 'KITTEMPLATEID'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnGrouping = False
        OptionsCustomize.ColumnSorting = False
        OptionsCustomize.ColumnsQuickCustomization = True
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
        OptionsView.ScrollBars = ssVertical
        OptionsView.ShowEditButtons = gsebForFocusedRecord
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        Styles.Footer = dmAdditions.cxStyle_GridHeader
        Styles.Header = dmAdditions.cxStyle_GridHeader
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        object cxGridTemplate_IMG: TcxGridDBColumn
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.DefaultImageIndex = 44
          Properties.Images = dmAdditions.cxImageList_SWN
          Properties.Items = <>
          MinWidth = 26
          Options.Filtering = False
          Options.Focusing = False
          Options.ShowEditButtons = isebNever
          Options.HorzSizing = False
          Options.Moving = False
          Options.Sorting = False
          VisibleForCustomization = False
          Width = 26
        end
        object cxGridTemplate_KITTEMPLATEID: TcxGridDBColumn
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
        object cxGridTemplate_TITLE: TcxGridDBColumn
          Caption = #1053#1072#1079#1074#1072#1085#1080#1077
          DataBinding.FieldName = 'TITLE'
          MinWidth = 100
          Options.Filtering = False
          Styles.OnGetContentStyle = cxGridTemplate_TITLEStylesGetContentStyle
          VisibleForCustomization = False
          Width = 200
        end
        object cxGridTemplate_DESCRIPTION: TcxGridDBColumn
          Caption = #1054#1087#1080#1089#1072#1085#1080#1077
          DataBinding.FieldName = 'DESCRIPTION'
          MinWidth = 100
          Width = 300
        end
        object cxGridTemplate_USER_NAME: TcxGridDBColumn
          Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
          DataBinding.FieldName = 'USER_NAME'
          Visible = False
          MinWidth = 140
          Options.HorzSizing = False
          Width = 140
        end
        object cxGridTemplate_FLG_PUBLIC: TcxGridDBColumn
          Caption = #1054#1073#1097#1080#1081
          DataBinding.FieldName = 'FLG_PUBLIC'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          Visible = False
          HeaderAlignmentHorz = taCenter
          MinWidth = 50
          Options.Filtering = False
          Options.HorzSizing = False
          Width = 50
        end
        object cxGridTemplate_GOODS_COUNT: TcxGridDBColumn
          Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1081
          DataBinding.FieldName = 'GOODS_COUNT'
          HeaderAlignmentHorz = taCenter
          MinWidth = 80
          Options.Filtering = False
          Options.HorzSizing = False
          Width = 80
        end
      end
      object cxGridLevel: TcxGridLevel
        GridView = cxGridTemplateTable
      end
    end
    object cxGridTemplateDetails: TcxGrid
      AlignWithMargins = True
      Left = 0
      Top = 176
      Width = 734
      Height = 310
      Margins.Left = 0
      Margins.Top = 2
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alBottom
      TabOrder = 1
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
        ScrollbarAnnotations.CustomAnnotations = <>
        OnCellDblClick = cxGridTemplateDetailsTableCellDblClick
        DataController.DataSource = IBCDataSourceItems
        DataController.KeyFieldNames = 'KITTEMPLATEID;GOODSID'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <
          item
            Kind = skCount
            Column = cxGridTemplateItemCol_ID
          end
          item
            Kind = skSum
            Column = cxGridTemplateItemCol_QTY
          end>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.CopyCaptionsToClipboard = False
        OptionsBehavior.ImmediateEditor = False
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnGrouping = False
        OptionsCustomize.ColumnHidingOnGrouping = False
        OptionsCustomize.ColumnHorzSizing = False
        OptionsCustomize.ColumnMoving = False
        OptionsCustomize.ColumnSorting = False
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
        OptionsView.ScrollBars = ssVertical
        OptionsView.ColumnAutoWidth = True
        OptionsView.Footer = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        Styles.Footer = dmAdditions.cxStyle_GridHeader
        Styles.Header = dmAdditions.cxStyle_GridHeader
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        object cxGridTemplateItemCol_ID: TcxGridDBColumn
          AlternateCaption = #1050#1086#1076' '#1090#1086#1074#1072#1088#1072
          Caption = #1050#1086#1076
          DataBinding.FieldName = 'GOODSID'
          FooterAlignmentHorz = taRightJustify
          HeaderAlignmentHorz = taCenter
          MinWidth = 50
          Options.Filtering = False
          Options.HorzSizing = False
          Options.Moving = False
          Width = 50
        end
        object cxGridTemplateItemCol_IMG: TcxGridDBColumn
          DataBinding.FieldName = 'GOODS_TYPE_ID'
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.Items = <>
          MinWidth = 26
          Options.Filtering = False
          Options.Focusing = False
          Options.ShowEditButtons = isebNever
          Options.HorzSizing = False
          Options.Moving = False
          Options.Sorting = False
          Width = 26
          IsCaptionAssigned = True
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
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taCenter
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
          PropertiesClassName = 'TcxCalcEditProperties'
          FooterAlignmentHorz = taRightJustify
          HeaderAlignmentHorz = taCenter
          MinWidth = 80
          Options.Filtering = False
          Options.HorzSizing = False
          VisibleForCustomization = False
          Width = 80
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
  end
  object pnBottom: TPanel
    Left = 0
    Top = 589
    Width = 750
    Height = 57
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    DesignSize = (
      750
      57)
    object btnOk: TcxButton
      Left = 528
      Top = 13
      Width = 90
      Height = 29
      Anchors = [akRight, akBottom]
      Caption = #1042#1099#1073#1088#1072#1090#1100
      Default = True
      TabOrder = 0
      OnClick = btnOkClick
    end
    object btnCancel: TcxButton
      Left = 636
      Top = 13
      Width = 90
      Height = 29
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100
      ModalResult = 2
      TabOrder = 1
    end
  end
  object dxBarManager: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'General')
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    ImageOptions.Images = dmAdditions.cxImageList_SWN
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 408
    Top = 28
    PixelsPerInch = 96
    object dxBarManagerBar1: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Kit'
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 945
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbNewTemplate'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbModifyTemplate'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbRemoveTemplate'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbTemplateItems'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'cbViewItems'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object bbNewTemplate: TdxBarButton
      Caption = #1053#1086#1074#1099#1081' '#1096#1072#1073#1083#1086#1085
      Category = 0
      Hint = #1053#1086#1074#1099#1081' '#1096#1072#1073#1083#1086#1085
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 45
      OnClick = bbNewTemplateClick
    end
    object bbModifyTemplate: TdxBarButton
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      Category = 0
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 115
      OnClick = bbModifyTemplateClick
    end
    object bbRemoveTemplate: TdxBarButton
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Category = 0
      Hint = #1059#1076#1072#1083#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 42
      ShortCut = 46
      OnClick = bbRemoveTemplateClick
    end
    object bbTemplateItems: TdxBarButton
      Caption = #1057#1086#1089#1090#1072#1074' '#1096#1072#1073#1083#1086#1085#1072'...'
      Category = 0
      Hint = #1057#1086#1089#1090#1072#1074' '#1096#1072#1073#1083#1086#1085#1072
      Visible = ivAlways
      ImageIndex = 12
      ShortCut = 116
      OnClick = bbTemplateItemsClick
    end
    object cbViewItems: TdxBarButton
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1089#1086#1089#1090#1072#1074
      Category = 0
      Hint = #1055#1086#1082#1072#1079#1072#1090#1100' '#1089#1086#1089#1090#1072#1074
      Visible = ivAlways
      ButtonStyle = bsChecked
      Down = True
      ShortCut = 16470
      OnClick = cbViewItemsClick
    end
  end
  object IBCQueryKit: TIBCQuery
    KeyFields = 'KITTEMPLATEID'
    KeyGenerator = 'SQ_TS_KIT_TEMPLATES_ID'
    GeneratorMode = gmInsert
    SQLInsert.Strings = (
      'INSERT INTO VW_TS_KIT_TEMPLATES'
      '  (KITTEMPLATEID, USERID, TITLE, DESCRIPTION, FLG_PUBLIC)'
      'VALUES'
      '  (:KITTEMPLATEID, :USERID, :TITLE, :DESCRIPTION, :FLG_PUBLIC)')
    SQLDelete.Strings = (
      'DELETE FROM VW_TS_KIT_TEMPLATES'
      'WHERE'
      '  KITTEMPLATEID = :Old_KITTEMPLATEID')
    SQLUpdate.Strings = (
      'UPDATE '
      ' VW_TS_KIT_TEMPLATES'
      'SET'
      ' KITTEMPLATEID = :KITTEMPLATEID, '
      ' USERID = :USERID, '
      ' TITLE = :TITLE, '
      ' DESCRIPTION = :DESCRIPTION, '
      ' FLG_PUBLIC = :FLG_PUBLIC'
      'WHERE'
      ' KITTEMPLATEID = :Old_KITTEMPLATEID')
    SQLRefresh.Strings = (
      'SELECT '
      ' KITTEMPLATEID,'
      ' USERID,  '
      ' TITLE,'
      ' DESCRIPTION,'
      ' FLG_PUBLIC,'
      ' USER_NAME,'
      
        ' (SELECT COUNT(GOODSID) FROM TS_KIT_TEMPLATE_ITEMS WHERE TS_KIT_' +
        'TEMPLATE_ITEMS.KITTEMPLATEID=VW_TS_KIT_TEMPLATES.KITTEMPLATEID) ' +
        'GOODS_COUNT'
      'FROM '
      ' VW_TS_KIT_TEMPLATES'
      'WHERE'
      ' KITTEMPLATEID = :KITTEMPLATEID')
    SQLLock.Strings = (
      'SELECT '
      ' NULL '
      'FROM '
      ' TS_KIT_TEMPLATES'
      'WHERE'
      ' KITTEMPLATEID = :Old_KITTEMPLATEID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = IBCTrUpdateKit
    SQL.Strings = (
      'SELECT '
      ' KITTEMPLATEID,'
      ' USERID,  '
      ' TITLE,'
      ' DESCRIPTION,'
      ' FLG_PUBLIC,'
      ' USER_NAME,'
      
        ' (SELECT COUNT(GOODSID) FROM TS_KIT_TEMPLATE_ITEMS WHERE TS_KIT_' +
        'TEMPLATE_ITEMS.KITTEMPLATEID=VW_TS_KIT_TEMPLATES.KITTEMPLATEID) ' +
        'GOODS_COUNT'
      'FROM '
      ' VW_TS_KIT_TEMPLATES'
      'WHERE'
      ' (FLG_PUBLIC=1) OR (USERID=:UserID)'
      'ORDER BY '
      ' FLG_PUBLIC DESC, TITLE')
    AutoCommit = False
    LockMode = lmLockImmediate
    RefreshOptions = [roAfterInsert]
    Left = 128
    Top = 176
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'UserID'
        Value = nil
      end>
  end
  object IBCDataSourceKit: TIBCDataSource
    DataSet = IBCQueryKit
    OnDataChange = IBCDataSourceKitDataChange
    Left = 132
    Top = 128
  end
  object IBCTrUpdateKit: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 128
    Top = 224
  end
  object IBCQueryItems: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      'SELECT '
      ' * '
      'FROM '
      ' VW_TS_KIT_TEMPLATE_ITEMS'
      'ORDER BY'
      ' ORDERNO')
    MasterFields = 'KITTEMPLATEID'
    DetailFields = 'KITTEMPLATEID'
    MasterSource = IBCDataSourceKit
    AutoCommit = False
    Options.DetailDelay = 500
    Left = 84
    Top = 416
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'KITTEMPLATEID'
        Value = nil
      end>
  end
  object IBCDataSourceItems: TIBCDataSource
    DataSet = IBCQueryItems
    Left = 84
    Top = 364
  end
end
