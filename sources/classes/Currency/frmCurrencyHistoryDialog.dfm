object frmCurrencyHistoryDlg: TfrmCurrencyHistoryDlg
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMaximize]
  BorderStyle = bsDialog
  Caption = #1048#1089#1090#1086#1088#1080#1103' '#1082#1091#1088#1089#1072' '#1074#1072#1083#1102#1090
  ClientHeight = 598
  ClientWidth = 960
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 960
    Height = 64
    Title = #1048#1089#1090#1086#1088#1080#1103' '#1082#1091#1088#1089#1072' '#1074#1072#1083#1102#1090
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
    ImageIndex = 4
  end
  object Panel1: TPanel
    Left = 8
    Top = 70
    Width = 947
    Height = 239
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    object cxGridHistory: TcxGrid
      AlignWithMargins = True
      Left = 8
      Top = 8
      Width = 931
      Height = 223
      Margins.Left = 8
      Margins.Top = 8
      Margins.Right = 8
      Margins.Bottom = 8
      Align = alTop
      TabOrder = 0
      object cxGridHistoryTable: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        DataController.DataModeController.GridMode = True
        DataController.DataSource = IBCDataSourceHistory
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnMoving = False
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
        Styles.Header = dmAdditions.cxStyle_GridHeader
        object cxGridHistory_DATA: TcxGridDBColumn
          Caption = #1044#1072#1090#1072' '#1080' '#1074#1088#1077#1084#1103
          DataBinding.FieldName = 'DATA'
          HeaderAlignmentHorz = taCenter
          MinWidth = 120
          Options.HorzSizing = False
          Width = 120
        end
        object cxGridHistory_EXCHANGE_RATE: TcxGridDBColumn
          Caption = #1053#1072#1083
          DataBinding.FieldName = 'EXCHANGE_RATE'
          HeaderAlignmentHorz = taCenter
          Width = 50
        end
        object cxGridHistory_TRANSFER_RATE: TcxGridDBColumn
          Caption = #1073'-'#1085#1072#1083
          DataBinding.FieldName = 'TRANSFER_RATE'
          HeaderAlignmentHorz = taCenter
          Width = 50
        end
        object cxGridHistory_DEGHEST_RATE: TcxGridDBColumn
          Caption = #1050#1091#1088#1089' DEGHEST'
          DataBinding.FieldName = 'DEGHEST_RATE'
          Width = 80
        end
        object cxGridHistory_BNM_RATE: TcxGridDBColumn
          Caption = 'BNM'
          DataBinding.FieldName = 'BNM_RATE'
          HeaderAlignmentHorz = taCenter
          Width = 50
        end
        object cxGridHistory_FULL_NAME: TcxGridDBColumn
          Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
          DataBinding.FieldName = 'FULL_NAME'
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taRightJustify
          HeaderAlignmentHorz = taCenter
          Width = 100
        end
      end
      object cxGridHistoryLevel: TcxGridLevel
        GridView = cxGridHistoryTable
      end
    end
  end
  object Panel2: TPanel
    Left = 8
    Top = 316
    Width = 947
    Height = 239
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 2
    object cxGrid1: TcxGrid
      AlignWithMargins = True
      Left = 8
      Top = 8
      Width = 931
      Height = 223
      Margins.Left = 8
      Margins.Top = 8
      Margins.Right = 8
      Margins.Bottom = 8
      Align = alTop
      TabOrder = 0
      object cxGrid1DBChartView1: TcxGridDBChartView
        Categories.DataBinding.FieldName = 'DATA'
        DataController.DataSource = IBCDataSourceHistoryChart
        DataController.KeyFieldNames = 'CURRENCYID;DATA'
        DiagramLine.Active = True
        DiagramLine.Legend.Position = cppTop
        DiagramLine.AxisValue.MinMaxValues = mmvAuto
        DiagramLine.Values.LineWidth = 2
        DiagramLine.Values.MarkerStyle = cmsCircle
        OptionsCustomize.DataDrillDown = False
        OptionsCustomize.DataGroupMoving = False
        OptionsCustomize.OptionsCustomization = False
        OptionsCustomize.SeriesCustomization = False
        ToolBox.Border = tbNone
        object cxGrid1DBChartView1Series1: TcxGridDBChartSeries
          DataBinding.FieldName = 'DEGHEST_RATE'
        end
      end
      object cxGridLevel1: TcxGridLevel
        GridView = cxGrid1DBChartView1
      end
    end
  end
  object btnClose: TcxButton
    Left = 834
    Top = 561
    Width = 90
    Height = 29
    Cancel = True
    Caption = #1047#1072#1082#1088#1099#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
  object IBCQueryHistory: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT '
      
        ' CURRENCYID,DATA, EXCHANGE_RATE, BNM_RATE, TRANSFER_RATE, DEGHES' +
        'T_RATE, MODIFIED_BY,'
      ' (SELECT FULL_NAME FROM TS_USERS WHERE USERID=MODIFIED_BY)'
      'FROM '
      ' TS_CURRENCY_HISTORY'
      'WHERE '
      ' CURRENCYID=:curr'
      'ORDER BY '
      ' DATA DESC')
    Left = 62
    Top = 138
    ParamData = <
      item
        DataType = ftInteger
        Name = 'curr'
        ParamType = ptInput
        Value = 840
      end>
  end
  object IBCDataSourceHistory: TIBCDataSource
    DataSet = IBCQueryHistory
    Left = 62
    Top = 190
  end
  object IBCQueryHistoryChart: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT first 30 * from (select '
      
        ' CURRENCYID,DATA, EXCHANGE_RATE, BNM_RATE, TRANSFER_RATE, DEGHES' +
        'T_RATE, MODIFIED_BY,'
      ' (SELECT FULL_NAME FROM TS_USERS WHERE USERID=MODIFIED_BY)'
      'FROM '
      ' TS_CURRENCY_HISTORY'
      'WHERE '
      ' CURRENCYID=:curr'
      'ORDER BY '
      ' DATA DESC)')
    Left = 301
    Top = 367
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'curr'
        ParamType = ptInput
        Value = nil
      end>
  end
  object IBCDataSourceHistoryChart: TIBCDataSource
    DataSet = IBCQueryHistoryChart
    Left = 301
    Top = 419
  end
end
