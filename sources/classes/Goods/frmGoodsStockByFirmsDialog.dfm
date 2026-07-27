object frmGoodsStockByFirmsDlg: TfrmGoodsStockByFirmsDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1054#1089#1090#1072#1090#1082#1080' '#1087#1086' '#1092#1080#1088#1084#1072#1084
  ClientHeight = 563
  ClientWidth = 498
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 498
    Height = 64
    Title = #1054#1089#1090#1072#1090#1082#1080' '#1087#1086' '#1092#1080#1088#1084#1072#1084
    Text = #1054#1089#1090#1072#1090#1082#1080' '#1090#1086#1074#1072#1088#1072' '#1087#1086' '#1074#1089#1077#1084' '#1092#1080#1088#1084#1072#1084
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
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 482
    Height = 437
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 0
    Align = alTop
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    object Label1: TLabel
      Left = 8
      Top = 12
      Width = 20
      Height = 15
      Caption = #1050#1086#1076
    end
    object Label2: TLabel
      Left = 63
      Top = 12
      Width = 32
      Height = 15
      Caption = #1058#1086#1074#1072#1088
    end
    object Bevel1: TBevel
      Left = 0
      Top = 0
      Width = 478
      Height = 81
      Align = alTop
      Shape = bsSpacer
    end
    object edGOODSID: TcxDBTextEdit
      Left = 8
      Top = 28
      TabStop = False
      DataBinding.DataField = 'GOODSID'
      Properties.ReadOnly = True
      Style.LookAndFeel.NativeStyle = True
      StyleDisabled.LookAndFeel.NativeStyle = True
      StyleFocused.LookAndFeel.NativeStyle = True
      StyleHot.LookAndFeel.NativeStyle = True
      TabOrder = 0
      Width = 49
    end
    object mmTITLE: TcxDBMemo
      Left = 63
      Top = 28
      TabStop = False
      DataBinding.DataField = 'TITLE'
      Properties.ReadOnly = True
      Properties.ScrollBars = ssVertical
      Properties.VisibleLineCount = 2
      Style.LookAndFeel.Kind = lfUltraFlat
      Style.LookAndFeel.NativeStyle = True
      StyleDisabled.LookAndFeel.Kind = lfUltraFlat
      StyleDisabled.LookAndFeel.NativeStyle = True
      StyleFocused.LookAndFeel.Kind = lfUltraFlat
      StyleFocused.LookAndFeel.NativeStyle = True
      StyleHot.LookAndFeel.Kind = lfUltraFlat
      StyleHot.LookAndFeel.NativeStyle = True
      TabOrder = 1
      Width = 407
    end
    object cxGrid: TcxGrid
      AlignWithMargins = True
      Left = 8
      Top = 84
      Width = 462
      Height = 312
      Margins.Left = 8
      Margins.Top = 0
      Margins.Right = 8
      Margins.Bottom = 8
      BevelEdges = [beLeft, beRight, beBottom]
      BevelInner = bvNone
      BevelOuter = bvNone
      TabOrder = 2
      TabStop = False
      LookAndFeel.NativeStyle = True
      object cxGridTable: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        DataController.DataSource = IBCDataSourceStockQTY
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsCustomize.ColumnFiltering = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsSelection.HideSelection = True
        OptionsView.NoDataToDisplayInfoText = #1053#1077#1090' '#1074' '#1085#1072#1083#1080#1095#1080#1077
        OptionsView.ScrollBars = ssVertical
        OptionsView.ColumnAutoWidth = True
        OptionsView.EditAutoHeightBorderColor = clSilver
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        Styles.OnGetContentStyle = cxGridTableStylesGetContentStyle
        Styles.Header = dmAdditions.cxStyle_GridHeader
        object cxGridTable_IMG: TcxGridDBColumn
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.DefaultImageIndex = 11
          Properties.Images = dmAdditions.cxImageList_SWN
          Properties.Items = <>
          MinWidth = 24
          Options.ShowEditButtons = isebNever
          Options.HorzSizing = False
          Options.Sorting = False
          Width = 24
        end
        object cxGridTable_FIRMA: TcxGridDBColumn
          Caption = #1060#1080#1088#1084#1072
          DataBinding.FieldName = 'CUSTOMER_TITLE'
          Options.Sorting = False
        end
        object cxGridTable_QTY: TcxGridDBColumn
          Caption = #1054#1089#1090#1072#1090#1086#1082
          DataBinding.FieldName = 'QTY'
          PropertiesClassName = 'TcxCalcEditProperties'
          HeaderAlignmentHorz = taCenter
          MinWidth = 80
          Options.HorzSizing = False
          Width = 80
        end
        object cxGridTable_TRANSIT_QTY: TcxGridDBColumn
          Caption = #1042' '#1087#1077#1088#1077#1084#1077#1097#1077#1085#1080#1103#1093
          DataBinding.FieldName = 'TRANSIT_QTY'
          PropertiesClassName = 'TcxCalcEditProperties'
          HeaderAlignmentHorz = taCenter
          MinWidth = 110
          Options.HorzSizing = False
          Styles.OnGetContentStyle = cxGridTable_TRANSIT_QTYStylesGetContentStyle
          Width = 110
        end
      end
      object cxGridLevel: TcxGridLevel
        GridView = cxGridTable
      end
    end
    object cbShowOnlyAvailable: TcxCheckBox
      Left = 8
      Top = 404
      Caption = #1055#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1090#1086#1083#1100#1082#1086' '#1092#1080#1088#1084#1099' '#1075#1076#1077' '#1089#1091#1097#1077#1089#1090#1074#1091#1077#1090' '#1090#1086#1074#1072#1088
      Properties.ValueChecked = '1'
      Properties.ValueUnchecked = '0'
      Style.LookAndFeel.NativeStyle = True
      StyleDisabled.LookAndFeel.NativeStyle = True
      StyleFocused.LookAndFeel.NativeStyle = True
      StyleHot.LookAndFeel.NativeStyle = True
      TabOrder = 3
    end
  end
  object btnClose: TcxButton
    Left = 405
    Top = 522
    Width = 75
    Height = 25
    Cancel = True
    Caption = #1047#1072#1082#1088#1099#1090#1100
    LookAndFeel.NativeStyle = True
    ModalResult = 2
    TabOrder = 2
  end
  object IBCQueryStockQTY: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      'SELECT '
      ' *'
      'FROM'
      ' SP_GOODS_STOCK_QTY_BY_FIRMS(:GOODSID)')
    Left = 188
    Top = 208
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'GOODSID'
        Value = nil
      end>
  end
  object IBCDataSourceStockQTY: TIBCDataSource
    DataSet = IBCQueryStockQTY
    Left = 188
    Top = 160
  end
end
