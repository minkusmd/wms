object frmSearchDocByDocNoDlg: TfrmSearchDocByDocNoDlg
  Left = 0
  Top = 0
  ActiveControl = edSeachText
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = #1055#1086#1080#1089#1082' '#1057#1095#1077#1090' '#1085#1072' '#1054#1087#1083#1072#1090#1091
  ClientHeight = 518
  ClientWidth = 835
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 835
    Height = 64
    Title = #1055#1086#1080#1089#1082' '#1057#1095#1077#1090' '#1085#1072' '#1054#1087#1083#1072#1090#1091
    Text = #1055#1086#1080#1089#1082' '#1076#1086#1082#1091#1084#1077#1085#1090#1072' '#1087#1086' '#1077#1075#1086' '#1085#1086#1084#1077#1088#1091
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
    ExplicitLeft = 492
    ExplicitTop = 264
    ExplicitWidth = 0
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 819
    Height = 385
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
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
      Width = 99
      Height = 15
      Caption = #1053#1086#1084#1077#1088' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
    end
    object cxGrid: TcxGrid
      AlignWithMargins = True
      Left = 16
      Top = 56
      Width = 783
      Height = 309
      Margins.Left = 0
      Margins.Top = 40
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alClient
      TabOrder = 0
      ExplicitLeft = 388
      ExplicitTop = 52
      ExplicitWidth = 250
      ExplicitHeight = 200
      object cxGridTable: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
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
          MinWidth = 60
          Options.HorzSizing = False
          Width = 60
        end
        object cxGridTable_DOCNO: TcxGridDBColumn
          Caption = #1053#1086#1084#1077#1088
          DataBinding.FieldName = 'DOCNO'
          MinWidth = 60
          Options.HorzSizing = False
          Width = 60
        end
        object cxGridTable_DATA: TcxGridDBColumn
          Caption = #1044#1072#1090#1072
          DataBinding.FieldName = 'DATA'
          MinWidth = 120
          Options.HorzSizing = False
          Width = 120
        end
        object cxGridTable_CREATED_BY_NAME: TcxGridDBColumn
          Caption = #1057#1086#1079#1076#1072#1083
          DataBinding.FieldName = 'CREATED_BY_NAME'
          Width = 100
        end
        object cxGridTable_CT_NAME: TcxGridDBColumn
          Caption = #1055#1083#1072#1090#1077#1083#1100#1097#1080#1082
          DataBinding.FieldName = 'CT_NAME'
          Width = 100
        end
        object cxGridTable_CURRENCY_NAME: TcxGridDBColumn
          Caption = #1042#1072#1083#1102#1090#1072
          DataBinding.FieldName = 'CURRENCY_NAME'
          HeaderAlignmentHorz = taCenter
          MinWidth = 60
          Options.HorzSizing = False
          Width = 60
        end
        object cxGridTable_SUMA: TcxGridDBColumn
          Caption = #1057#1091#1084#1084#1072
          DataBinding.FieldName = 'SUMA'
          HeaderAlignmentHorz = taCenter
          MinWidth = 80
          Options.HorzSizing = False
          Width = 80
        end
        object cxGridTable_RATE: TcxGridDBColumn
          Caption = #1050#1091#1088#1089
          DataBinding.FieldName = 'RATE'
          HeaderAlignmentHorz = taCenter
          MinWidth = 60
          Options.HorzSizing = False
          Width = 60
        end
        object cxGridTable_RATEUSD: TcxGridDBColumn
          Caption = #1050#1091#1088#1089' $'
          DataBinding.FieldName = 'RATEUSD'
          HeaderAlignmentHorz = taCenter
          MinWidth = 60
          Options.HorzSizing = False
          Width = 60
        end
        object cxGridTable_FLG_PAID: TcxGridDBColumn
          Caption = #1054#1087#1083#1086#1095#1077#1085
          DataBinding.FieldName = 'FLG_PAID'
          Visible = False
          VisibleForCustomization = False
        end
        object cxGridTable_FLG_INVOICE: TcxGridDBColumn
          Caption = #1056#1072#1089#1093#1086#1076
          DataBinding.FieldName = 'FLG_INVOICE'
          Visible = False
          VisibleForCustomization = False
        end
      end
      object cxGridLevel: TcxGridLevel
        GridView = cxGridTable
      end
    end
    object btnSearch: TButton
      Left = 254
      Top = 16
      Width = 75
      Height = 25
      Caption = #1055#1086#1080#1089#1082
      Default = True
      TabOrder = 1
      OnClick = btnSearchClick
    end
    object edSeachText: TEdit
      Left = 121
      Top = 16
      Width = 127
      Height = 23
      TabOrder = 2
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
    Left = 452
    Top = 16
    DockControlHeights = (
      0
      0
      0
      0)
  end
  object IBCQueryDocs: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT'
      '*'
      'FROM'
      ' VW_TDB_DOCS'
      'WHERE'
      '  (doctypeid=101) AND (docno=:docno)')
    Left = 208
    Top = 276
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'docno'
        Value = nil
      end>
  end
  object IBCDataSourceDocs: TIBCDataSource
    DataSet = IBCQueryDocs
    Left = 208
    Top = 224
  end
end
