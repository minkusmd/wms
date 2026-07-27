object frmKitTemplateItemsEditorDlg: TfrmKitTemplateItemsEditorDlg
  Left = 0
  Top = 0
  ActiveControl = cxGridTemplateDetails
  BorderStyle = bsDialog
  Caption = #1057#1086#1089#1090#1072#1074' '#1096#1072#1073#1083#1086#1085#1072' '#1082#1086#1085#1092#1080#1075#1091#1088#1072#1094#1080#1080
  ClientHeight = 605
  ClientWidth = 745
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  DesignSize = (
    745
    605)
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel
    Left = 18
    Top = 556
    Width = 270
    Height = 15
    Caption = #1048#1089#1087#1086#1083#1100#1079#1091#1081#1090#1077' "+" '#1080' "-" '#1076#1083#1103' '#1091#1089#1090#1072#1085#1086#1074#1082#1080' '#1082#1086#1083#1080#1095#1077#1089#1090#1074#1072'.'
  end
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 745
    Height = 64
    Title = #1057#1086#1089#1090#1072#1074' '#1096#1072#1073#1083#1086#1085#1072' '#1082#1086#1085#1092#1080#1075#1091#1088#1072#1094#1080#1080
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
    Top = 115
    Width = 729
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
  object cxGridTemplateDetails: TcxGrid
    AlignWithMargins = True
    Left = 8
    Top = 146
    Width = 729
    Height = 399
    Margins.Left = 8
    Margins.Top = 0
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    TabOrder = 3
    object cxGridTemplateDetailsTable: TcxGridDBTableView
      OnKeyUp = cxGridTemplateDetailsTableKeyUp
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
      OnFocusedRecordChanged = cxGridTemplateDetailsTableFocusedRecordChanged
      DataController.DataSource = IBCDataSourceItems
      DataController.KeyFieldNames = 'GOODSID'
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
        MinWidth = 60
        Options.Filtering = False
        Options.HorzSizing = False
        Options.Moving = False
        Width = 60
      end
      object cxGridTemplateItem_GOODS_TYPE_ID: TcxGridDBColumn
        DataBinding.FieldName = 'GOODS_TYPE_ID'
        PropertiesClassName = 'TcxImageComboBoxProperties'
        Properties.Items = <>
        MinWidth = 24
        Options.Filtering = False
        Options.Focusing = False
        Options.ShowEditButtons = isebNever
        Options.HorzSizing = False
        Width = 24
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
        HeaderAlignmentHorz = taCenter
        MinWidth = 50
        Options.Filtering = False
        Options.HorzSizing = False
        VisibleForCustomization = False
        Width = 50
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
      object cxGridTemplateItem_ORDERNO: TcxGridDBColumn
        DataBinding.FieldName = 'ORDERNO'
        Visible = False
        VisibleForCustomization = False
      end
    end
    object cxGridTemplateLevel: TcxGridLevel
      GridView = cxGridTemplateDetailsTable
    end
  end
  object pnKit: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 729
    Height = 41
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
    object cxLabel1: TLabel
      Left = 8
      Top = 11
      Width = 45
      Height = 15
      Caption = #1064#1072#1073#1083#1086#1085
    end
    object edTITLE: TcxDBTextEdit
      Left = 63
      Top = 8
      TabStop = False
      DataBinding.DataField = 'TITLE'
      Properties.ReadOnly = True
      TabOrder = 0
      Width = 546
    end
  end
  object btnOk: TcxButton
    Left = 532
    Top = 559
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = '&Ok'
    Default = True
    TabOrder = 4
    OnClick = btnOkClick
  end
  object btnCancel: TcxButton
    Left = 636
    Top = 559
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 5
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
    PixelsPerInch = 96
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
      FloatClientWidth = 114
      FloatClientHeight = 106
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbNewGoods'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbModifyItem'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbRemoveItem'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbSortItem'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object bbSortItem: TdxBarButton
      Caption = #1059#1087#1086#1088#1103#1076#1086#1095#1080#1090#1100'...'
      Category = 0
      Hint = #1059#1087#1086#1088#1103#1076#1086#1095#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 38
      OnClick = bbSortItemClick
    end
    object bbNewGoods: TdxBarButton
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1090#1086#1074#1072#1088
      Category = 1
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1090#1086#1074#1072#1088
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 45
      OnClick = bbNewGoodsClick
    end
    object bbModifyItem: TdxBarButton
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      Category = 1
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 115
      OnClick = bbModifyItemClick
    end
    object bbRemoveItem: TdxBarButton
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Category = 1
      Hint = #1059#1076#1072#1083#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 42
      ShortCut = 46
      OnClick = bbRemoveItemClick
    end
  end
  object IBCDataSourceItems: TIBCDataSource
    DataSet = IBCQueryItems
    Left = 80
    Top = 232
  end
  object IBCQueryItems: TIBCQuery
    SQLInsert.Strings = (
      'INSERT INTO VW_TS_KIT_TEMPLATE_ITEMS'
      '  (KITTEMPLATEID, GOODSID, QTY, FLG_ACTIVE, ORDERNO)'
      'VALUES'
      '  (:KITTEMPLATEID, :GOODSID, :QTY, :FLG_ACTIVE, :ORDERNO)')
    SQLDelete.Strings = (
      'DELETE FROM VW_TS_KIT_TEMPLATE_ITEMS'
      'WHERE'
      '  KITTEMPLATEID = :Old_KITTEMPLATEID AND GOODSID = :Old_GOODSID')
    SQLUpdate.Strings = (
      'UPDATE VW_TS_KIT_TEMPLATE_ITEMS'
      'SET'
      
        '  KITTEMPLATEID = :KITTEMPLATEID, GOODSID = :GOODSID, QTY = :QTY' +
        ', FLG_ACTIVE = :FLG_ACTIVE, ORDERNO = :ORDERNO'
      'WHERE'
      '  KITTEMPLATEID = :Old_KITTEMPLATEID AND GOODSID = :Old_GOODSID')
    SQLRefresh.Strings = (
      'SELECT'
      ' KITTEMPLATEID,'
      ' GOODSID,'
      ' QTY,'
      ' FLG_ACTIVE,'
      ' GOODS_NAME,'
      ' UMID,'
      ' UM_NAME,'
      ' ORDERNO,'
      ' GOODS_TYPE_ID'
      'FROM '
      ' VW_TS_KIT_TEMPLATE_ITEMS'
      'WHERE'
      '  KITTEMPLATEID = :KITTEMPLATEID AND GOODSID = :GOODSID')
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT'
      ' KITTEMPLATEID,'
      ' GOODSID,'
      ' QTY,'
      ' FLG_ACTIVE,'
      ' GOODS_NAME,'
      ' UMID,'
      ' UM_NAME,'
      ' ORDERNO,'
      ' GOODS_TYPE_ID'
      'FROM '
      ' VW_TS_KIT_TEMPLATE_ITEMS'
      'ORDER BY ORDERNO')
    MasterFields = 'KITTEMPLATEID'
    DetailFields = 'KITTEMPLATEID'
    AutoCommit = False
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Left = 80
    Top = 284
  end
end
