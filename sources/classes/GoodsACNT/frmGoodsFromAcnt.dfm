object fmGoodsFromAcnt: TfmGoodsFromAcnt
  Left = 0
  Top = 0
  ActiveControl = cxGrid
  BorderIcons = [biSystemMenu]
  Caption = #1057#1087#1080#1089#1086#1082' '#1090#1086#1074#1072#1088#1072
  ClientHeight = 654
  ClientWidth = 837
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 837
    Height = 64
    Title = #1058#1086#1074#1072#1088#1099
    Text = #1058#1086#1074#1072#1088#1099' '#1087#1088#1080#1074#1103#1079#1103#1085#1085#1099#1077' '#1082' '#1073#1091#1093#1075#1072#1083#1090#1077#1088#1089#1082#1086#1084#1091' '#1082#1086#1076#1091
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
  object pnBottom: TPanel
    Left = 0
    Top = 613
    Width = 837
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    Padding.Left = 8
    Padding.Right = 8
    Padding.Bottom = 12
    TabOrder = 2
    object btnCancel: TcxButton
      AlignWithMargins = True
      Left = 727
      Top = 0
      Width = 90
      Height = 29
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 12
      Margins.Bottom = 0
      Align = alRight
      Cancel = True
      Caption = #1047#1072#1082#1088#1099#1090#1100
      ModalResult = 2
      TabOrder = 0
    end
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 821
    Height = 533
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alClient
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 1
    object dxBarDockControl1: TdxBarDockControl
      Left = 0
      Top = 0
      Width = 821
      Height = 30
      Align = dalTop
      BarManager = dxBarManager
      SunkenBorder = True
      UseOwnSunkenBorder = True
    end
    object cxGrid: TcxGrid
      Left = 0
      Top = 30
      Width = 821
      Height = 503
      Align = alClient
      TabOrder = 1
      object cxGridDBTable: TcxGridDBTableView
        OnKeyDown = cxGridDBTableKeyDown
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        OnCustomDrawCell = cxGridDBTableCustomDrawCell
        OnFocusedRecordChanged = cxGridDBTableFocusedRecordChanged
        DataController.DataSource = IBCDSGoods
        DataController.KeyFieldNames = 'GOODSID'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <
          item
            Kind = skCount
            Column = cxGridDBTableGOODSID
          end>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.IncSearch = True
        OptionsBehavior.ImmediateEditor = False
        OptionsCustomize.ColumnFiltering = False
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.InvertSelect = False
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
        OptionsView.ScrollBars = ssVertical
        OptionsView.ColumnAutoWidth = True
        OptionsView.Footer = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        Styles.Header = dmAdditions.cxStyle_GridHeader
        object cxGridDBTableGOODSID: TcxGridDBColumn
          Caption = #1050#1086#1076
          DataBinding.FieldName = 'GOODSID'
          MinWidth = 80
          Options.HorzSizing = False
          Width = 80
        end
        object cxGridDBTableTITLE: TcxGridDBColumn
          Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
          DataBinding.FieldName = 'TITLE'
          Width = 300
        end
        object cxGridDBTable_Price1: TcxGridDBColumn
          Caption = #1062#1077#1085#1072' 1 ('#1083#1077#1081')'
          DataBinding.FieldName = 'PRICE1_LEI'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          MinWidth = 80
          Options.HorzSizing = False
          Width = 80
        end
        object cxGridDBTable_Price0: TcxGridDBColumn
          Caption = #1062#1077#1085#1072' 0 ('#1074#1072#1083'.)'
          DataBinding.FieldName = 'PRICE0'
          DataBinding.IsNullValueType = True
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          MinWidth = 80
          Options.HorzSizing = False
          Width = 80
        end
      end
      object cxGridLevel: TcxGridLevel
        GridView = cxGridDBTable
      end
    end
  end
  object IBCQueryGoods: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = IBCLocalUpdate
    SQL.Strings = (
      'select *'
      'from VW_TS_GOODS G'
      'where G.GOODS_ACNT_ID = :GOODSACNTID')
    AutoCommit = False
    Active = True
    Left = 100
    Top = 216
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'goodsacntid'
        Value = nil
      end>
  end
  object IBCDSGoods: TIBCDataSource
    DataSet = IBCQueryGoods
    Left = 100
    Top = 164
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
      FloatClientWidth = 110
      FloatClientHeight = 103
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbAddGoods'
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
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbEditGoods'
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
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      Category = 0
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 45
      OnClick = bbAddGoodsClick
    end
    object bbRemoveGoods: TdxBarButton
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Category = 0
      Hint = #1059#1076#1072#1083#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 42
      ShortCut = 46
      OnClick = bbRemoveGoodsClick
    end
    object bbEditGoods: TdxBarButton
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1090#1086#1074#1072#1088
      Category = 0
      Hint = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1090#1086#1074#1072#1088
      Visible = ivAlways
      ImageIndex = 41
      OnClick = bbEditGoodsClick
    end
  end
  object IBCLocalUpdate: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 100
    Top = 268
  end
end
