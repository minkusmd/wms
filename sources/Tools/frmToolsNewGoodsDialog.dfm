object frmToolsNewGoodsDlg: TfrmToolsNewGoodsDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1053#1086#1074#1099#1077' '#1090#1086#1074#1072#1088#1099
  ClientHeight = 684
  ClientWidth = 874
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
  object DialogTitle1: TDialogTitle
    Left = 0
    Top = 0
    Width = 874
    Height = 64
    Title = #1053#1086#1074#1099#1077' '#1090#1086#1074#1072#1088#1099
    Text = #1055#1088#1086#1089#1084#1086#1090#1088' '#1085#1086#1074#1099#1093' '#1089#1086#1079#1076#1072#1085#1085#1099#1093' '#1090#1086#1074#1072#1088#1086#1074
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
  object Panel1: TPanel
    Left = 0
    Top = 64
    Width = 874
    Height = 620
    Align = alClient
    Caption = 'Panel1'
    Padding.Left = 8
    Padding.Top = 8
    Padding.Right = 8
    Padding.Bottom = 8
    TabOrder = 1
    object cxGrid: TcxGrid
      Left = 9
      Top = 39
      Width = 856
      Height = 527
      Align = alClient
      TabOrder = 0
      object cxGridTable: TcxGridDBTableView
        OnKeyDown = cxGridTableKeyDown
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        DataController.DataSource = IBCDataSourceGoods
        DataController.KeyFieldNames = 'GOODSID'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.CopyCaptionsToClipboard = False
        OptionsBehavior.IncSearch = True
        OptionsBehavior.CopyPreviewToClipboard = False
        OptionsCustomize.ColumnFiltering = False
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.InvertSelect = False
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupRowStyle = grsOffice11
        Styles.Group = dmAdditions.cxStyle_Bold
        Styles.Header = dmAdditions.cxStyle_GridHeader
        object cxGrid_DAYDATE: TcxGridDBColumn
          Caption = #1044#1072#1090#1072
          DataBinding.FieldName = 'DATA'
          Visible = False
          GroupIndex = 0
          HeaderAlignmentHorz = taCenter
          SortIndex = 1
          SortOrder = soDescending
          Width = 40
        end
        object cxGrid_GOODSID: TcxGridDBColumn
          Caption = #1050#1086#1076
          DataBinding.FieldName = 'GOODSID'
          HeaderAlignmentHorz = taCenter
          MinWidth = 60
          Options.HorzSizing = False
          SortIndex = 0
          SortOrder = soDescending
          Width = 60
        end
        object cxGrid_TITLE: TcxGridDBColumn
          Caption = #1053#1072#1079#1074#1072#1085#1080#1077
          DataBinding.FieldName = 'TITLE'
          Width = 200
        end
        object cxGrid_PARENT_TITLE: TcxGridDBColumn
          Caption = #1055#1072#1087#1082#1072
          DataBinding.FieldName = 'PARENT_TITLE'
          Width = 100
        end
        object cxGrid_FLG_EXISTS_WEB_CATALOG: TcxGridDBColumn
          Caption = #1042' Web '#1082#1072#1090'.'
          DataBinding.FieldName = 'FLG_EXISTS_WEB_CATALOG'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          HeaderAlignmentHorz = taCenter
          MinWidth = 70
          Options.HorzSizing = False
          Width = 70
        end
      end
      object cxGridLevel: TcxGridLevel
        GridView = cxGridTable
      end
    end
    object dxBarDockControl1: TdxBarDockControl
      Left = 9
      Top = 9
      Width = 856
      Height = 30
      Align = dalTop
      BarManager = dxBarManager
      SunkenBorder = True
      UseOwnSunkenBorder = True
    end
    object pnButtons: TPanel
      Left = 9
      Top = 566
      Width = 856
      Height = 45
      Align = alBottom
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 2
      object btnCancel: TButton
        Left = 748
        Top = 11
        Width = 90
        Height = 29
        Cancel = True
        Caption = #1047#1072#1082#1088#1099#1090#1100
        ModalResult = 2
        TabOrder = 0
      end
    end
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
    Left = 432
    Top = 12
    PixelsPerInch = 96
    object dxBarManagerBar: TdxBar
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
      FloatLeft = 817
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udWidth]
          UserWidth = 58
          Visible = True
          ItemName = 'cmbCount'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbShowWebCatalog'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object bbShowWebCatalog: TdxBarButton
      Caption = 'Web '#1050#1072#1090#1072#1083#1086#1075' '#1090#1086#1074#1072#1088#1086#1074
      Category = 0
      Hint = 'Web '#1050#1072#1090#1072#1083#1086#1075' '#1090#1086#1074#1072#1088#1086#1074
      Visible = ivAlways
      ImageIndex = 7
      OnClick = bbShowWebCatalogClick
    end
    object cmbCount: TdxBarCombo
      Caption = #1055#1086#1089#1083#1077#1076#1085#1080#1093' '#1090#1086#1074#1072#1088#1086#1074
      Category = 0
      Hint = #1055#1086#1089#1083#1077#1076#1085#1080#1093' '#1090#1086#1074#1072#1088#1086#1074
      Visible = ivAlways
      OnChange = cmbCountChange
      ShowCaption = True
      Text = '1000'
      ShowEditor = False
      Items.Strings = (
        '50'
        '100'
        '200'
        '500'
        '1000')
      ItemIndex = 4
    end
  end
  object IBCQueryGoods: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      'SELECT '
      
        ' DATA, GOODSID, TITLE, PARENT_GOODSID, PARENT_TITLE, FLG_EXISTS_' +
        'WEB_CATALOG'
      'FROM SP_GET_LAST_NEW_GOODS(:count)')
    Left = 168
    Top = 296
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'count'
        Value = nil
      end>
  end
  object IBCDataSourceGoods: TIBCDataSource
    DataSet = IBCQueryGoods
    Left = 168
    Top = 248
  end
end
