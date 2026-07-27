object frmBonusGoodsDlg: TfrmBonusGoodsDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1041#1086#1085#1091#1089#1085#1099#1077' '#1090#1086#1074#1072#1088#1099
  ClientHeight = 674
  ClientWidth = 909
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 909
    Height = 64
    Title = #1041#1086#1085#1091#1089#1085#1099#1077' '#1090#1086#1074#1072#1088#1099
    Text = #1040#1076#1084#1080#1085#1080#1089#1090#1088#1080#1088#1086#1074#1072#1085#1080#1077' '#1073#1086#1085#1091#1089#1085#1099#1093' '#1090#1086#1074#1072#1088#1086#1074
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
    Width = 893
    Height = 541
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alClient
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 4
    object cxGrid: TcxGrid
      Left = 0
      Top = 30
      Width = 893
      Height = 511
      Align = alClient
      TabOrder = 0
      object cxGridTable: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        OnCellDblClick = cxGridTableCellDblClick
        OnFocusedRecordChanged = cxGridTableFocusedRecordChanged
        DataController.DataSource = IBCDataSourceBonus
        DataController.KeyFieldNames = 'GOODSID;DATA1'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.CopyCaptionsToClipboard = False
        OptionsBehavior.IncSearch = True
        OptionsBehavior.CopyPreviewToClipboard = False
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.MultiSelect = True
        OptionsSelection.InvertSelect = False
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
        OptionsView.ScrollBars = ssVertical
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        Styles.OnGetContentStyle = cxGridTableStylesGetContentStyle
        Styles.GroupByBox = dmAdditions.cxStyle_GridGroup
        Styles.Header = dmAdditions.cxStyle_GridHeader
        object cxGridTable_GOODSID: TcxGridDBColumn
          Caption = #1050#1086#1076
          DataBinding.FieldName = 'GOODSID'
          HeaderAlignmentHorz = taCenter
          MinWidth = 50
          Options.HorzSizing = False
          Width = 50
        end
        object cxGridTable_IMG: TcxGridDBColumn
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.DefaultImageIndex = 12
          Properties.Images = dmAdditions.cxImageList_SWN
          Properties.Items = <>
          MinWidth = 24
          Options.Focusing = False
          Options.HorzSizing = False
          Options.Sorting = False
          Width = 24
        end
        object cxGridTable_GOODSNAME: TcxGridDBColumn
          Caption = #1058#1086#1074#1072#1088
          DataBinding.FieldName = 'GOODSNAME'
          Width = 200
        end
        object cxGridTable_DATA1: TcxGridDBColumn
          Caption = #1057' '#1076#1072#1090#1099
          DataBinding.FieldName = 'DATA1'
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taCenter
          HeaderAlignmentHorz = taCenter
          MinWidth = 80
          Options.HorzSizing = False
          SortIndex = 0
          SortOrder = soDescending
          Width = 80
        end
        object cxGridTable_DATA2: TcxGridDBColumn
          Caption = #1055#1086' '#1076#1072#1090#1091
          DataBinding.FieldName = 'DATA2'
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taCenter
          HeaderAlignmentHorz = taCenter
          MinWidth = 80
          Options.HorzSizing = False
          SortIndex = 1
          SortOrder = soDescending
          Width = 80
        end
        object cxGridTable_BONUS: TcxGridDBColumn
          Caption = #1041#1086#1085#1091#1089
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taRightJustify
          OnGetDisplayText = cxGridTable_BONUSGetDisplayText
          HeaderAlignmentHorz = taCenter
          MinWidth = 100
          Options.HorzSizing = False
          Options.Sorting = False
          Width = 100
        end
        object cxGridTable_FLG_EXPIRED: TcxGridDBColumn
          DataBinding.FieldName = 'FLG_EXPIRED'
          Visible = False
          VisibleForCustomization = False
        end
        object cxGridTable_USER_FULL_NAME: TcxGridDBColumn
          Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
          DataBinding.FieldName = 'USER_FULL_NAME'
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taRightJustify
          Width = 60
        end
        object cxGridTable_SUMA_BONUS: TcxGridDBColumn
          DataBinding.FieldName = 'SUMA_BONUS'
          Visible = False
          VisibleForCustomization = False
        end
        object cxGridTable_PERCENT_BONUS: TcxGridDBColumn
          DataBinding.FieldName = 'PERCENT_BONUS'
          Visible = False
          VisibleForCustomization = False
        end
        object cxGridTable_FLG_CALC_BY_SUMA: TcxGridDBColumn
          DataBinding.FieldName = 'FLG_CALC_BY_SUMA'
          Visible = False
          VisibleForCustomization = False
        end
        object cxGridTable_CURRENCY_TITLE: TcxGridDBColumn
          DataBinding.FieldName = 'CURRENCY_TITLE'
          Visible = False
          VisibleForCustomization = False
        end
      end
      object cxGridLevel: TcxGridLevel
        GridView = cxGridTable
      end
    end
    object dxBarDockControl1: TdxBarDockControl
      Left = 0
      Top = 0
      Width = 893
      Height = 30
      Align = dalTop
      BarManager = dxBarManager
      SunkenBorder = True
      UseOwnSunkenBorder = True
    end
  end
  object pnButtons: TPanel
    Left = 0
    Top = 621
    Width = 909
    Height = 53
    Align = alBottom
    BevelOuter = bvNone
    Padding.Top = 8
    Padding.Right = 24
    Padding.Bottom = 16
    ShowCaption = False
    TabOrder = 5
    object btnClose: TcxButton
      Left = 795
      Top = 8
      Width = 90
      Height = 29
      Align = alRight
      Cancel = True
      Caption = #1047#1072#1082#1088#1099#1090#1100
      ModalResult = 2
      TabOrder = 0
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
    Left = 484
    Top = 16
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
      FloatLeft = 813
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
          ItemName = 'bbDelete'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbImportGoods'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarDateCombo'
        end
        item
          Visible = True
          ItemName = 'dxBarButton1'
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
      Caption = #1053#1086#1074#1099#1081
      Category = 0
      Hint = #1053#1086#1074#1099#1081
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 45
      OnClick = bbAddClick
    end
    object bbModify: TdxBarButton
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      Category = 0
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 115
      OnClick = bbModifyClick
    end
    object bbDelete: TdxBarButton
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Category = 0
      Hint = #1059#1076#1072#1083#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 42
      ShortCut = 46
      OnClick = bbDeleteClick
    end
    object bbImportGoods: TdxBarButton
      Caption = #1048#1084#1087#1086#1088#1090
      Category = 0
      Hint = #1048#1084#1087#1086#1088#1090
      Visible = ivAlways
      ImageIndex = 25
      OnClick = bbImportGoodsClick
    end
    object dxBarButton1: TdxBarButton
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1087#1077#1088#1080#1086#1076
      Category = 0
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100' '#1087#1077#1088#1080#1086#1076
      Visible = ivAlways
      ImageIndex = 45
      OnClick = dxBarButton1Click
    end
    object dxBarDateCombo: TdxBarDateCombo
      Caption = #1044#1072#1090#1072
      Category = 0
      Hint = #1044#1072#1090#1072
      Visible = ivAlways
      Glyph.SourceDPI = 96
      Glyph.Data = {
        424D360400000000000036000000280000001000000010000000010020000000
        000000000000C40E0000C40E00000000000000000000FF00FFFFFF00FFFFFF00
        FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
        FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
        FFFFFF00FFFF000000FF000000FF000000FF000000FF000000FF000000FF0000
        00FF000000FF000000FF000000FF000000FFFF00FFFFFF00FFFFFF00FFFFFF00
        FFFFFF00FFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF00FFFF000000FF000000FF0000
        00FF000000FF000000FFFFFFFFFF000000FF000000FF000000FF000000FF0000
        00FF000000FF000000FFFFFFFFFF000000FFFF00FFFF000000FFFFFFFFFFFFFF
        FFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF00FFFF000000FFFFFFFFFF0000
        00FF000000FF000000FFFFFFFFFFFFFFFFFFFFFFFFFF000080FF000080FFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF00FFFF000000FFFFFFFFFFFFFF
        FFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFF000080FF000080FFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF00FFFF000000FFFFFFFFFFFFFF
        FFFF000080FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000080FF0000
        80FFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF00FFFF000000FFFFFFFFFFFFFF
        FFFF000080FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000
        80FF000080FFFFFFFFFFFFFFFFFF000000FFFF00FFFF000000FFFFFFFFFFFFFF
        FFFF000080FF000000FFFFFFFFFFFFFFFFFF000080FF000080FF000080FF0000
        80FF000080FFFFFFFFFFFFFFFFFF000000FFFF00FFFF000000FFFFFFFFFFFFFF
        FFFF000080FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF00FFFF000000FFFFFFFFFFFFFF
        FFFF000080FF000000FF800000FF800000FF800000FF800000FF800000FF8000
        00FF800000FF800000FF800000FF000000FFFF00FFFF000000FFFFFFFFFFFFFF
        FFFFFFFFFFFF000000FF800000FF800000FF800000FF800000FF800000FF8000
        00FF800000FF800000FF800000FF000000FFFF00FFFF000000FF800000FF8000
        00FF800000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
        00FF000000FF000000FF000000FF000000FFFF00FFFF000000FF800000FF8000
        00FF800000FF800000FF800000FF800000FF800000FF800000FF800000FF0000
        00FFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF000000FF000000FF0000
        00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
        00FFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF}
    end
  end
  object IBCQueryBonus: TIBCQuery
    SQLInsert.Strings = (
      'INSERT INTO TDB_GOODS_BONUS'
      
        '  (GOODSID, DATA1, DATA2, SUMA_BONUS, PERCENT_BONUS, FLG_CALC_BY' +
        '_SUMA, CURRENCYID)'
      'VALUES'
      
        '  (:GOODSID, :DATA1, :DATA2, :SUMA_BONUS, :PERCENT_BONUS, :FLG_C' +
        'ALC_BY_SUMA, :CURRENCYID)')
    SQLDelete.Strings = (
      'DELETE FROM TDB_GOODS_BONUS'
      'WHERE'
      '  GOODSID = :Old_GOODSID AND DATA1 = :Old_DATA1')
    SQLUpdate.Strings = (
      'UPDATE TDB_GOODS_BONUS'
      'SET'
      '  GOODSID = :GOODSID,'
      '  DATA1 = :DATA1, '
      '  DATA2 = :DATA2, '
      '  SUMA_BONUS = :SUMA_BONUS,'
      '  PERCENT_BONUS = :PERCENT_BONUS,'
      '  FLG_CALC_BY_SUMA = :FLG_CALC_BY_SUMA,'
      '  CURRENCYID = :CURRENCYID'
      ''
      'WHERE'
      '  GOODSID = :Old_GOODSID AND DATA1 = :Old_DATA1')
    SQLRefresh.Strings = (
      'SELECT '
      ' GOODSID, '
      ' GOODSNAME, '
      ' DATA1, '
      ' DATA2, '
      ' SUMA_BONUS,'
      ' USERID,'
      ' USER_FULL_NAME,'
      ' IIF(DATA2<CURRENT_DATE,1,0) FLG_EXPIRED,'
      ' PERCENT_BONUS,'
      ' FLG_CALC_BY_SUMA,'
      ' CURRENCYID,'
      ' CURRENCY_TITLE'
      'FROM '
      ' VW_TDB_GOODS_BONUS'
      'WHERE'
      ' GOODSID = :GOODSID AND DATA1 = :DATA1')
    SQLLock.Strings = (
      'SELECT NULL FROM TDB_GOODS_BONUS'
      'WHERE'
      'GOODSID = :Old_GOODSID AND DATA1 = :Old_DATA1'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'SELECT '
      ' GOODSID, '
      ' GOODSNAME, '
      ' DATA1, '
      ' DATA2, '
      ' SUMA_BONUS,'
      ' USERID,'
      ' USER_FULL_NAME,'
      ' IIF(DATA2<CURRENT_DATE,1,0) FLG_EXPIRED,'
      ' PERCENT_BONUS,'
      ' FLG_CALC_BY_SUMA,'
      ' CURRENCYID,'
      ' CURRENCY_TITLE'
      'FROM '
      ' VW_TDB_GOODS_BONUS'
      'ORDER BY DATA1 DESC, DATA2 DESC')
    AutoCommit = False
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Options.RequiredFields = False
    LocalConstraints = False
    Left = 128
    Top = 224
  end
  object IBCDataSourceBonus: TIBCDataSource
    DataSet = IBCQueryBonus
    Left = 132
    Top = 168
  end
end
