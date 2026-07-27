object frmSearchSciotNaOplatuDlg: TfrmSearchSciotNaOplatuDlg
  Left = 0
  Top = 0
  ActiveControl = edSearchText
  BorderIcons = [biSystemMenu, biMaximize]
  BorderStyle = bsDialog
  Caption = #1055#1086#1080#1089#1082' '#1057#1095#1077#1090' '#1085#1072' '#1054#1087#1083#1072#1090#1091
  ClientHeight = 635
  ClientWidth = 1098
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 1098
    Height = 64
    Title = #1055#1086#1080#1089#1082' '#1057#1095#1077#1090' '#1085#1072' '#1054#1087#1083#1072#1090#1091
    Text = #1055#1086#1080#1089#1082' '#1076#1086#1082#1091#1084#1077#1085#1090#1072' '#1087#1086' '#1077#1075#1086' '#1082#1086#1076#1091' '#1080#1083#1080' '#1085#1086#1084#1077#1088#1091
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
    ImageIndex = 9
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 1082
    Height = 502
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alClient
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    Padding.Left = 16
    Padding.Top = 16
    Padding.Right = 16
    Padding.Bottom = 16
    ParentBackground = False
    ShowCaption = False
    TabOrder = 1
    object Label1: TLabel
      Left = 16
      Top = 19
      Width = 146
      Height = 15
      Caption = #1050#1086#1076' '#1080#1083#1080' '#1053#1086#1084#1077#1088' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
    end
    object cxGrid: TcxGrid
      AlignWithMargins = True
      Left = 16
      Top = 56
      Width = 1046
      Height = 426
      Margins.Left = 0
      Margins.Top = 40
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alClient
      TabOrder = 2
      object cxGridTable: TcxGridDBTableView
        OnKeyDown = cxGridTableKeyDown
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        OnCustomDrawCell = cxGridTableCustomDrawCell
        OnFocusedRecordChanged = cxGridTableFocusedRecordChanged
        DataController.DataModeController.GridMode = True
        DataController.DataSource = IBCDataSourceDocs
        DataController.KeyFieldNames = 'DOCID'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsCustomize.ColumnFiltering = False
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
        Styles.GroupByBox = dmAdditions.cxStyle_GridGroup
        Styles.Header = dmAdditions.cxStyle_GridHeader
        object cxGridTable_DOCID: TcxGridDBColumn
          Caption = #1050#1086#1076
          DataBinding.FieldName = 'DOCID'
          DataBinding.IsNullValueType = True
          MinWidth = 60
          Options.HorzSizing = False
          Width = 60
        end
        object cxGridTable_DATA: TcxGridDBColumn
          Caption = #1044#1072#1090#1072
          DataBinding.FieldName = 'DATA'
          DataBinding.IsNullValueType = True
          MinWidth = 60
          Width = 80
        end
        object cxGridTable_CREATED_BY_NAME: TcxGridDBColumn
          Caption = #1057#1086#1079#1076#1072#1083
          DataBinding.FieldName = 'CREATED_BY_NAME'
          DataBinding.IsNullValueType = True
          MinWidth = 40
          Width = 80
        end
        object cxGridTable_DT: TcxGridDBColumn
          Caption = #1060#1080#1088#1084#1072
          DataBinding.FieldName = 'DT_NAME'
          DataBinding.IsNullValueType = True
          MinWidth = 40
          Width = 100
        end
        object cxGridTable_CT_NAME: TcxGridDBColumn
          Caption = #1055#1083#1072#1090#1077#1083#1100#1097#1080#1082
          DataBinding.FieldName = 'CT_NAME'
          DataBinding.IsNullValueType = True
          MinWidth = 40
          Width = 100
        end
        object cxGridTable_CURRENCY_NAME: TcxGridDBColumn
          Caption = #1042#1072#1083#1102#1090#1072
          DataBinding.FieldName = 'CURRENCY_NAME'
          DataBinding.IsNullValueType = True
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taCenter
          HeaderAlignmentHorz = taCenter
          MinWidth = 50
          Options.HorzSizing = False
          Width = 50
        end
        object cxGridTable_SUMA: TcxGridDBColumn
          Caption = #1057#1091#1084#1084#1072
          DataBinding.FieldName = 'SUMA'
          DataBinding.IsNullValueType = True
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          HeaderAlignmentHorz = taCenter
          MinWidth = 70
          Options.HorzSizing = False
          Width = 70
        end
        object cxGridTable_RATE: TcxGridDBColumn
          Caption = #1050#1091#1088#1089
          DataBinding.FieldName = 'RATE'
          DataBinding.IsNullValueType = True
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          HeaderAlignmentHorz = taCenter
          MinWidth = 50
          Options.HorzSizing = False
          Width = 50
        end
        object cxGridTable_RATEUSD: TcxGridDBColumn
          Caption = #1050#1091#1088#1089' $'
          DataBinding.FieldName = 'RATEUSD'
          DataBinding.IsNullValueType = True
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          HeaderAlignmentHorz = taCenter
          MinWidth = 50
          Options.HorzSizing = False
          Width = 50
        end
        object cxGridTable_FLG_PAID: TcxGridDBColumn
          Caption = #1054#1087#1083#1072#1095#1077#1085
          DataBinding.FieldName = 'FLG_PAID'
          DataBinding.IsNullValueType = True
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          HeaderAlignmentHorz = taCenter
          MinWidth = 50
          Options.HorzSizing = False
          VisibleForCustomization = False
          Width = 50
        end
        object cxGridTable_FLG_INVOICE: TcxGridDBColumn
          Caption = #1056#1072#1089#1093#1086#1076
          DataBinding.FieldName = 'FLG_INVOICE'
          DataBinding.IsNullValueType = True
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          HeaderAlignmentHorz = taCenter
          MinWidth = 50
          Options.HorzSizing = False
          VisibleForCustomization = False
          Width = 50
        end
      end
      object cxGridLevel: TcxGridLevel
        GridView = cxGridTable
      end
    end
    object edSearchText: TEdit
      Left = 168
      Top = 16
      Width = 127
      Height = 23
      TabOrder = 1
    end
    object btnSearch: TcxButton
      Left = 301
      Top = 15
      Width = 75
      Height = 25
      Caption = #1055#1086#1080#1089#1082
      Default = True
      TabOrder = 0
      OnClick = btnSearchClick
    end
  end
  object pnButtons: TPanel
    Left = 0
    Top = 582
    Width = 1098
    Height = 53
    Align = alBottom
    BevelOuter = bvNone
    Padding.Left = 8
    Padding.Top = 8
    Padding.Right = 24
    Padding.Bottom = 16
    ShowCaption = False
    TabOrder = 2
    object btnCancel: TcxButton
      AlignWithMargins = True
      Left = 984
      Top = 8
      Width = 90
      Height = 29
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
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
    Left = 469
    Top = 188
    PixelsPerInch = 96
    object bbPrihod: TdxBarButton
      Caption = #1055#1088#1080#1093#1086#1076' '#1076#1077#1085#1077#1075' '#1085#1072' '#1089#1095#1077#1090'...'
      Category = 0
      Hint = #1055#1088#1080#1093#1086#1076' '#1076#1077#1085#1077#1075' '#1085#1072' '#1089#1095#1077#1090
      Visible = ivAlways
      OnClick = bbPrihodClick
    end
    object bbCreateRashod: TdxBarButton
      Caption = #1057#1086#1079#1076#1072#1090#1100' "'#1056#1072#1089#1093#1086#1076#1085#1091#1102' '#1085#1072#1082#1083#1072#1076#1085#1091#1102'"...'
      Category = 0
      Hint = #1057#1086#1079#1076#1072#1090#1100' "'#1056#1072#1089#1093#1086#1076#1085#1091#1102' '#1085#1072#1082#1083#1072#1076#1085#1091#1102'"'
      Visible = ivAlways
      OnClick = bbCreateRashodClick
    end
    object bbGotoDocument: TdxBarButton
      Caption = #1055#1077#1088#1077#1081#1090#1080' '#1082' '#1076#1086#1082#1091#1084#1077#1085#1090#1091
      Category = 0
      Hint = #1055#1077#1088#1077#1081#1090#1080' '#1082' '#1076#1086#1082#1091#1084#1077#1085#1090#1091
      Visible = ivAlways
      ImageIndex = 7
      OnClick = bbGotoDocumentClick
    end
  end
  object IBCQueryDocs: TIBCQuery
    SQLRefresh.Strings = (
      'SELECT'
      ' VW_TDB_DOCS.*,'
      
        ' IIF(EXISTS(SELECT GOODSID FROM TDB_JURNAL WHERE TDB_JURNAL.DOCI' +
        'D=VW_TDB_DOCS.DOCID),1,0) HAS_JURNAL_GOODS'
      'FROM'
      ' VW_TDB_DOCS'
      'WHERE'
      '  DOCID = :DOCID')
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT'
      ' VW_TDB_DOCS.*,'
      
        ' IIF(EXISTS(SELECT GOODSID FROM TDB_JURNAL WHERE TDB_JURNAL.DOCI' +
        'D=VW_TDB_DOCS.DOCID),1,0) HAS_JURNAL_GOODS'
      'FROM'
      ' VW_TDB_DOCS'
      'WHERE'
      '  (doctypeid=101) AND DOCID=:DOCID')
    Left = 208
    Top = 276
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DOCID'
        Value = nil
      end>
  end
  object IBCDataSourceDocs: TIBCDataSource
    DataSet = IBCQueryDocs
    Left = 208
    Top = 224
  end
  object dxBarPopupMenu: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbPrihod'
      end
      item
        Visible = True
        ItemName = 'bbCreateRashod'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbGotoDocument'
      end>
    UseOwnFont = False
    OnPopup = dxBarPopupMenuPopup
    Left = 204
    Top = 352
    PixelsPerInch = 96
  end
  object cxGridPopupMenu: TcxGridPopupMenu
    Grid = cxGrid
    PopupMenus = <
      item
        GridView = cxGridTable
        HitTypes = [gvhtCell, gvhtRecord]
        Index = 0
        PopupMenu = dxBarPopupMenu
      end>
    Left = 364
    Top = 188
  end
end
