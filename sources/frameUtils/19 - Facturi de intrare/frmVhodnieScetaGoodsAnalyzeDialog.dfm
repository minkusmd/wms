object frmVhodnieScetaGoodsAnalyzeDlg: TfrmVhodnieScetaGoodsAnalyzeDlg
  Left = 0
  Top = 0
  ActiveControl = cxGrid
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Analiza preturilor'
  ClientHeight = 605
  ClientWidth = 893
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
    Width = 893
    Height = 64
    Title = 'Analiza preturilor'
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
    ImageIndex = 16
  end
  object pnBottom: TPanel
    Left = 0
    Top = 556
    Width = 893
    Height = 49
    Align = alBottom
    BevelOuter = bvNone
    Padding.Left = 8
    Padding.Top = 8
    Padding.Right = 24
    Padding.Bottom = 12
    ShowCaption = False
    TabOrder = 2
    object btnClose: TButton
      Left = 779
      Top = 8
      Width = 90
      Height = 29
      Align = alRight
      Cancel = True
      Caption = 'Inchide'
      ModalResult = 2
      TabOrder = 0
    end
  end
  object cxGrid: TcxGrid
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 877
    Height = 484
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 0
    Align = alClient
    TabOrder = 1
    object cxGridTable: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      ScrollbarAnnotations.CustomAnnotations = <>
      OnCustomDrawCell = cxGridTableCustomDrawCell
      DataController.DataSource = IBCDataSourceData
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.IncSearch = True
      OptionsCustomize.ColumnsQuickCustomization = True
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.InvertSelect = False
      OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1090#1086#1074#1072#1088#1086#1074'>'
      OptionsView.ColumnAutoWidth = True
      OptionsView.GridLineColor = 13750737
      OptionsView.GroupByBox = False
      OptionsView.Indicator = True
      Styles.Header = dmAdditions.cxStyle_GridHeader
      Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
      object cxGridTable_GOODSID: TcxGridDBColumn
        Caption = 'Cod'
        DataBinding.FieldName = 'GOODSID'
        HeaderAlignmentHorz = taCenter
        MinWidth = 70
        Options.HorzSizing = False
        Width = 70
      end
      object cxGridTable_GOODS_TITLE: TcxGridDBColumn
        Caption = 'Produs'
        DataBinding.FieldName = 'GOODS_TITLE'
        Width = 200
      end
      object cxGridTable_PRICE_DIFF: TcxGridDBColumn
        DataBinding.FieldName = 'PRICE_DIFF'
        PropertiesClassName = 'TcxImageComboBoxProperties'
        Properties.Alignment.Horz = taCenter
        Properties.Images = dmAdditions.cxImageList_SWN
        Properties.Items = <
          item
            ImageIndex = 8
            Value = -1
          end
          item
            ImageIndex = 68
            Value = 1
          end
          item
            Value = 0
          end>
        MinWidth = 30
        Options.HorzSizing = False
        Width = 30
        IsCaptionAssigned = True
      end
      object cxGridTable_PRICE0_NEW: TcxGridDBColumn
        Caption = 'Pret nou'
        DataBinding.FieldName = 'PRICE0_NEW'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 100
        Options.HorzSizing = False
        Width = 100
      end
      object cxGridTable_PRICE0_OLD: TcxGridDBColumn
        Caption = 'Pret vechi'
        DataBinding.FieldName = 'PRICE0_OLD'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 100
        Options.HorzSizing = False
        Width = 100
      end
    end
    object cxGridLevel: TcxGridLevel
      GridView = cxGridTable
    end
  end
  object IBCQueryData: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      'SELECT'
      ' GOODSID,'
      ' GOODS_TITLE,'
      ' PRICE0_OLD,'
      ' PRICE0_NEW,'
      ' PRICE_DIFF'
      'FROM '
      ' SP_F19_ANALYZE_PRICE0(:DOCID)')
    ReadOnly = True
    Left = 232
    Top = 228
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DOCID'
        Value = nil
      end>
  end
  object IBCDataSourceData: TIBCDataSource
    DataSet = IBCQueryData
    Left = 232
    Top = 292
  end
end
