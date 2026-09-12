object frmRascetKonfiguratiiDlg: TfrmRascetKonfiguratiiDlg
  Left = 0
  Top = 0
  ActiveControl = cxGrid
  BorderStyle = bsDialog
  Caption = 'Profit estimativ ofertei'
  ClientHeight = 597
  ClientWidth = 956
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
    Width = 956
    Height = 64
    Title = 'Calcul estimativ al ofertei'
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
    ImageIndex = 28
  end
  object cxGrid: TcxGrid
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 940
    Height = 465
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    TabOrder = 1
    object cxGridTable: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      ScrollbarAnnotations.CustomAnnotations = <>
      DataController.DataSource = IBCDataSourceGoods
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <
        item
          Format = '#,##0.00'
          Kind = skSum
          Column = cxGridTable_PROFIT
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Column = cxGridTable_AMOUNT
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Column = cxGridTable_COST
        end>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.IncSearch = True
      OptionsCustomize.ColumnFiltering = False
      OptionsCustomize.ColumnGrouping = False
      OptionsCustomize.ColumnMoving = False
      OptionsCustomize.ColumnSorting = False
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
      OptionsView.ColumnAutoWidth = True
      OptionsView.Footer = True
      OptionsView.GridLineColor = 13750737
      OptionsView.GroupByBox = False
      Styles.Header = dmAdditions.cxStyle_GridHeader
      object cxGridTable_GOODSID: TcxGridDBColumn
        Caption = 'Cod'
        DataBinding.FieldName = 'GOODSID'
        DataBinding.IsNullValueType = True
        HeaderAlignmentHorz = taCenter
        MinWidth = 60
        Options.HorzSizing = False
        Width = 60
      end
      object cxGridTable_IMG: TcxGridDBColumn
        DataBinding.FieldName = 'GOODS_TYPE_ID'
        DataBinding.IsNullValueType = True
        PropertiesClassName = 'TcxImageComboBoxProperties'
        Properties.DefaultImageIndex = 12
        Properties.Images = dmAdditions.cxImageList_SWN
        Properties.Items = <
          item
            ImageIndex = 44
            Value = 4203
          end>
        MinWidth = 26
        Options.HorzSizing = False
        VisibleForCustomization = False
        Width = 26
        IsCaptionAssigned = True
      end
      object cxGridTable_GOODS_NAME: TcxGridDBColumn
        Caption = 'Produs'
        DataBinding.FieldName = 'GOODS_NAME'
        DataBinding.IsNullValueType = True
      end
      object cxGridTable_COST: TcxGridDBColumn
        Caption = 'Intrari, LEI'
        DataBinding.FieldName = 'COST'
        DataBinding.IsNullValueType = True
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 100
        Options.HorzSizing = False
        Styles.Footer = dmAdditions.cxStyle_Bold
        Width = 100
      end
      object cxGridTable_AMOUNT: TcxGridDBColumn
        Caption = 'Iesiri, LEI'
        DataBinding.FieldName = 'AMOUNT'
        DataBinding.IsNullValueType = True
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 100
        Options.HorzSizing = False
        Styles.Footer = dmAdditions.cxStyle_Bold
        Width = 100
      end
      object cxGridTable_PROFIT: TcxGridDBColumn
        Caption = 'Profit brut, LEI'
        DataBinding.FieldName = 'PROFIT'
        DataBinding.IsNullValueType = True
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 100
        Options.HorzSizing = False
        Styles.Footer = dmAdditions.cxStyle_Bold
        Width = 100
      end
    end
    object cxGridLevel: TcxGridLevel
      GridView = cxGridTable
    end
  end
  object btnClose: TcxButton
    Left = 844
    Top = 552
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Inchide'
    Default = True
    ModalResult = 2
    TabOrder = 2
  end
  object IBCQueryGoods: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      'SELECT'
      ' GOODSID,'
      ' GOODS_NAME,'
      ' COST,'
      ' AMOUNT,'
      ' PROFIT,'
      
        ' (SELECT GOODS_TYPE_ID FROM TS_GOODS WHERE TS_GOODS.GOODSID=A.GO' +
        'ODSID) GOODS_TYPE_ID'
      'FROM'
      'SP_GET_CONF_PROFIT(:DOCID) A')
    Left = 72
    Top = 240
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DOCID'
        Value = nil
      end>
  end
  object IBCDataSourceGoods: TIBCDataSource
    DataSet = IBCQueryGoods
    Left = 72
    Top = 192
  end
end
