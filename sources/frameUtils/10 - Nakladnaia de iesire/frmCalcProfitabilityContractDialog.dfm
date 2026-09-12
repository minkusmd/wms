object frmCalcProfitabilityContractDlg: TfrmCalcProfitabilityContractDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Calcularea rentabilit'#259#539'ii pe contract'
  ClientHeight = 535
  ClientWidth = 879
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 879
    Height = 64
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
  object cxGrid: TcxGrid
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 863
    Height = 409
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 1
    object cxGridDBTable: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = IBCDataSourceProfit
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <
        item
          Kind = skCount
          Column = cxGridDBTable_GOODSID
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Column = cxGridDBTable_SUMAMDL_IN
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Column = cxGridDBTable_SUMAMDL_OUT
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Column = cxGridDBTable_PROFIT_LEI
        end
        item
          OnGetText = cxGridDBTableTcxGridDBDataControllerTcxDataSummaryFooterSummaryItems4GetText
          Column = cxGridDBTable_PROFIT_PROCENTE
        end>
      DataController.Summary.SummaryGroups = <>
      OptionsCustomize.ColumnFiltering = False
      OptionsCustomize.ColumnSorting = False
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.InvertSelect = False
      OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
      OptionsView.ScrollBars = ssVertical
      OptionsView.ColumnAutoWidth = True
      OptionsView.Footer = True
      OptionsView.GridLineColor = 13750737
      OptionsView.GroupByBox = False
      OptionsView.GroupRowStyle = grsOffice11
      OptionsView.Indicator = True
      Styles.OnGetContentStyle = cxGridDBTableStylesGetContentStyle
      Styles.Footer = dmAdditions.cxStyle_GridHeader
      Styles.Header = dmAdditions.cxStyle_GridHeader
      object cxGridDBTable_GOODSID: TcxGridDBColumn
        Caption = 'Cod'
        DataBinding.FieldName = 'GOODSID'
        HeaderAlignmentHorz = taCenter
        MinWidth = 70
        Options.HorzSizing = False
        Width = 70
      end
      object cxGridDBTable_GOODS_TITLE: TcxGridDBColumn
        Caption = 'Produs'
        DataBinding.FieldName = 'GOODS_NAME'
        Width = 100
      end
      object cxGridDBTable_SUMAMDL_IN: TcxGridDBColumn
        Caption = 'Suma intrare, lei'
        DataBinding.FieldName = 'SUMAMDL_IN'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 100
        Options.HorzSizing = False
        Width = 100
      end
      object cxGridDBTable_SUMAMDL_OUT: TcxGridDBColumn
        Caption = 'Suma vinzare, lei'
        DataBinding.FieldName = 'SUMAMDL_OUT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 100
        Options.HorzSizing = False
        Width = 100
      end
      object cxGridDBTable_PROFIT_LEI: TcxGridDBColumn
        Caption = 'Rentabilitate, lei'
        DataBinding.FieldName = 'PROFIT_LEI'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 120
        Options.HorzSizing = False
        Width = 120
      end
      object cxGridDBTable_PROFIT_PROCENTE: TcxGridDBColumn
        Caption = '%'
        DataBinding.FieldName = 'PROFIT_PROCENTE'
        HeaderAlignmentHorz = taCenter
        MinWidth = 60
        Options.HorzSizing = False
        Width = 60
      end
    end
    object cxGridLevel: TcxGridLevel
      GridView = cxGridDBTable
    end
  end
  object btnCancel: TButton
    Left = 766
    Top = 492
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Inchide'
    Default = True
    ModalResult = 2
    TabOrder = 2
  end
  object IBCQueryProfit: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT '
      ' GOODSID,'
      ' GOODS_NAME, '
      ' SUM(SUMAMDL_IN) SUMAMDL_IN, '
      ' SUM(SUMAMDL_OUT) SUMAMDL_OUT,'
      ' ROUND(SUM(SUMAMDL_OUT - SUMAMDL_IN), 2) PROFIT_LEI, '
      
        ' ROUND(SUM(IIF(SUMAMDL_IN=0,100,SUMAMDL_OUT*100/SUMAMDL_IN - 100' +
        '))) PROFIT_PROCENTE'
      'FROM '
      ' SP_GET_PROFIT_BY_CONTRACT(:CONTRACTID)'
      'GROUP BY '
      ' 1,2')
    Left = 180
    Top = 244
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CONTRACTID'
        Value = nil
      end>
  end
  object IBCDataSourceProfit: TIBCDataSource
    DataSet = IBCQueryProfit
    Left = 180
    Top = 188
  end
end
