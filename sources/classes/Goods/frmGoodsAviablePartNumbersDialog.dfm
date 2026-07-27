object frmGoodsAviablePartNumbersDlg: TfrmGoodsAviablePartNumbersDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Partide disponibile'
  ClientHeight = 595
  ClientWidth = 620
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
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 620
    Height = 64
    Title = 'Partide disponibile'
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
    ImageIndex = 17
  end
  object pnClient: TPanel
    Left = 0
    Top = 64
    Width = 620
    Height = 477
    Align = alTop
    BevelOuter = bvNone
    Padding.Left = 8
    Padding.Top = 8
    Padding.Right = 8
    ShowCaption = False
    TabOrder = 1
    object dxBarDockControl1: TdxBarDockControl
      Left = 8
      Top = 8
      Width = 604
      Height = 30
      Align = dalTop
      BarManager = dxBarManager1
      SunkenBorder = True
      UseOwnSunkenBorder = True
    end
    object cxGrid: TcxGrid
      Left = 8
      Top = 38
      Width = 604
      Height = 439
      Align = alClient
      TabOrder = 1
      object cxGridTable: TcxGridDBTableView
        OnKeyDown = cxGridTableKeyDown
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        DataController.DataSource = IBCDataSourcePARTS
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <
          item
            Kind = skCount
            Column = cxGridTable_PARTNO
          end
          item
            Kind = skSum
            Column = cxGridTable_QTY
          end>
        DataController.Summary.SummaryGroups = <>
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnsQuickCustomization = True
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsSelection.InvertSelect = False
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
        object cxGridTable_PARTNO: TcxGridDBColumn
          Caption = 'Partida'
          DataBinding.FieldName = 'PARTNO'
          Width = 191
        end
        object cxGridTable_QTY: TcxGridDBColumn
          Caption = 'Cant'
          DataBinding.FieldName = 'QTY'
          PropertiesClassName = 'TcxCalcEditProperties'
          FooterAlignmentHorz = taRightJustify
          HeaderAlignmentHorz = taCenter
          MinWidth = 70
          Options.HorzSizing = False
          Width = 70
        end
        object cxGridTable_STOCK_TITLE: TcxGridDBColumn
          Caption = 'Depozit'
          DataBinding.FieldName = 'STOCK_TITLE'
          Width = 125
        end
        object cxGridTable_COUNTRY_NAME: TcxGridDBColumn
          Caption = 'Tara'
          DataBinding.FieldName = 'COUNTRY_NAME'
          Width = 103
        end
        object cxGridTable_VENDOR_NAME: TcxGridDBColumn
          Caption = 'Producator'
          DataBinding.FieldName = 'VENDOR_NAME'
          Width = 101
        end
      end
      object cxGridLevel: TcxGridLevel
        GridView = cxGridTable
      end
    end
  end
  object btnClose: TButton
    Left = 522
    Top = 558
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Inchide'
    ModalResult = 2
    TabOrder = 2
  end
  object dxBarManager1: TdxBarManager
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
    Left = 276
    Top = 12
    PixelsPerInch = 96
    object dxBarManager1Bar1: TdxBar
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
      FloatLeft = 522
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
  end
  object IBCQueryPARTS: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      'SELECT '
      ' A.STOCKID,'
      ' ST.TITLE STOCK_TITLE,'
      ' A.PARTNO,'
      ' A.QTY,'
      ' A.COUNTRYID, '
      ' CNT.TITLE COUNTRY_NAME,'
      ' A.VENDORID,'
      ' VN.TITLE VENDOR_NAME'
      'FROM GET_AVAILABLE_PARTS (:FIRMA, :GOODSID) A'
      'INNER JOIN TS_STOCKS ST ON ST.STOCKID = A.STOCKID'
      'INNER JOIN TS_SYSS CNT ON CNT.SYSSID=A.COUNTRYID'
      'INNER JOIN TS_SYSS VN ON VN.SYSSID=A.VENDORID')
    Left = 72
    Top = 164
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'FIRMA'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'GOODSID'
        Value = nil
      end>
  end
  object IBCDataSourcePARTS: TIBCDataSource
    DataSet = IBCQueryPARTS
    Left = 72
    Top = 228
  end
end
