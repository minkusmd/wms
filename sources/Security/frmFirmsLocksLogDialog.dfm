object frmFirmsLocksLogDlg: TfrmFirmsLocksLogDlg
  Left = 0
  Top = 0
  ActiveControl = cxGridLog
  BorderStyle = bsDialog
  Caption = #1046#1091#1088#1085#1072#1083' '#1073#1083#1086#1082#1080#1088#1086#1074#1086#1082
  ClientHeight = 503
  ClientWidth = 676
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 676
    Height = 64
    Title = 'Registru blocarilor'
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
  end
  object cxGridLog: TcxGrid
    AlignWithMargins = True
    Left = 8
    Top = 103
    Width = 660
    Height = 345
    Margins.Left = 8
    Margins.Top = 0
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    TabOrder = 2
    object cxGridLogTable: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      ScrollbarAnnotations.CustomAnnotations = <>
      DataController.DataModeController.GridMode = True
      DataController.DataSource = IBCDataSourceLog
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsCustomize.ColumnFiltering = False
      OptionsCustomize.ColumnSorting = False
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
      OptionsView.ScrollBars = ssVertical
      OptionsView.ColumnAutoWidth = True
      OptionsView.GridLineColor = 13750737
      OptionsView.GroupByBox = False
      OptionsView.Indicator = True
      Styles.Header = dmAdditions.cxStyle_GridHeader
      object cxGridLogTable_DATA: TcxGridDBColumn
        Caption = 'Data'
        DataBinding.FieldName = 'DATA'
        MinWidth = 120
        Options.HorzSizing = False
        Width = 120
      end
      object cxGridLogTable_DT_NAME: TcxGridDBColumn
        Caption = 'Intreprinderea'
        DataBinding.FieldName = 'DT_NAME'
        Width = 120
      end
      object cxGridLogTable_USER_NAME: TcxGridDBColumn
        Caption = 'Utilizator'
        DataBinding.FieldName = 'USER_NAME'
        Width = 80
      end
      object cxGridLogTable_LOCK_ENABLED: TcxGridDBColumn
        Caption = 'Bloc'
        DataBinding.FieldName = 'LOCK_ENABLED'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        HeaderAlignmentHorz = taCenter
        MinWidth = 50
        Options.HorzSizing = False
        Width = 50
      end
    end
    object cxGridLogLevel: TcxGridLevel
      GridView = cxGridLogTable
    end
  end
  object dxBarDockControl1: TdxBarDockControl
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 660
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
  object btnCancel: TcxButton
    Left = 572
    Top = 459
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Inchide'
    ModalResult = 2
    TabOrder = 3
  end
  object IBCQueryLog: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      'SELECT'
      ' *'
      'FROM'
      ' VW_TSS_DBLOCKS_LOG')
    Left = 76
    Top = 256
  end
  object IBCDataSourceLog: TIBCDataSource
    DataSet = IBCQueryLog
    Left = 76
    Top = 204
  end
  object dxBarManager: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      #1055#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102)
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    ImageOptions.Images = dmAdditions.cxImageList_SWN
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 252
    Top = 136
    PixelsPerInch = 96
    object dxBarManagerBar1: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' 1'
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 700
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbClearLog'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object bbClearLog: TdxBarButton
      Caption = 'Curata jurnalul'
      Category = 0
      Hint = 'Curata jurnalul'
      Visible = ivAlways
      ImageIndex = 35
      OnClick = bbClearLogClick
    end
  end
end
