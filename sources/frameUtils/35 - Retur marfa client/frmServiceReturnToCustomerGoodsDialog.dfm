object frmServiceReturnToCustomerGoodsDlg: TfrmServiceReturnToCustomerGoodsDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1058#1086#1074#1072#1088' '#1076#1083#1103' '#1074#1086#1079#1074#1088#1072#1090#1072' '#1082#1083#1080#1077#1085#1090#1091
  ClientHeight = 357
  ClientWidth = 894
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    894
    357)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 894
    Height = 64
    Title = #1058#1086#1074#1072#1088' '#1076#1083#1103' '#1074#1086#1079#1074#1088#1072#1090#1072' '#1082#1083#1080#1077#1085#1090#1091
    Text = 
      #1042#1099#1073#1077#1088#1080#1090#1077' '#1090#1086#1074#1072#1088' '#1076#1083#1103' '#1076#1086#1073#1072#1074#1083#1077#1085#1080#1103'. '#1055#1086#1082#1072#1079#1072#1085#1099' '#1090#1086#1074#1072#1088#1099' '#1082#1086#1090#1086#1088#1099#1077' '#1085#1072#1093#1086#1076#1103#1090#1089#1103 +
      ' '#1091' '#1085#1072#1089'.'
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
    ImageIndex = 10
    ExplicitLeft = 292
    ExplicitTop = 84
    ExplicitWidth = 0
  end
  object cxGrid: TcxGrid
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 878
    Height = 231
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    TabOrder = 1
    object cxGridTable: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxGridTableCustomDrawCell
      DataController.DataSource = IBCDataSourceGoods
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsCustomize.ColumnFiltering = False
      OptionsCustomize.ColumnSorting = False
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.InvertSelect = False
      OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1090#1086#1074#1072#1088#1086#1074'>'
      OptionsView.ColumnAutoWidth = True
      OptionsView.GridLineColor = 13750737
      OptionsView.GroupByBox = False
      Styles.Header = dmAdditions.cxStyle_GridHeader
      object cxGridTable_DOCID: TcxGridDBColumn
        Caption = #1050#1086#1076' '#1076#1086#1082'.'
        DataBinding.FieldName = 'DOCID'
        HeaderAlignmentHorz = taCenter
        MinWidth = 60
        Options.HorzSizing = False
        Width = 60
      end
      object cxGridTable_DATA: TcxGridDBColumn
        Caption = #1044#1072#1090#1072
        DataBinding.FieldName = 'DATA'
        OnGetDisplayText = cxGridTable_DATAGetDisplayText
        HeaderAlignmentHorz = taCenter
        MinWidth = 90
        Options.HorzSizing = False
        Width = 90
      end
      object cxGridTable_DOC_TYPE: TcxGridDBColumn
        Caption = #1044#1086#1082#1091#1084#1077#1085#1090' '#1087#1088#1080#1077#1084#1072' '#1090#1086#1074#1072#1088#1072
        DataBinding.FieldName = 'DOC_TYPE'
        MinWidth = 210
        Options.HorzSizing = False
        Width = 210
      end
      object cxGridTable_GOODSID: TcxGridDBColumn
        Caption = #1050#1086#1076
        DataBinding.FieldName = 'GOODSID'
        HeaderAlignmentHorz = taCenter
        MinWidth = 60
        Options.HorzSizing = False
        Width = 60
      end
      object cxGridTable_SNPN: TcxGridDBColumn
        Caption = #1053#1086#1084#1077#1088
        DataBinding.FieldName = 'SNPN'
        HeaderAlignmentHorz = taCenter
        MinWidth = 150
        Options.HorzSizing = False
        Width = 150
      end
      object cxGridTable_TITLE: TcxGridDBColumn
        Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
        DataBinding.FieldName = 'TITLE'
        MinWidth = 100
        Width = 400
      end
    end
    object cxGridLevel: TcxGridLevel
      GridView = cxGridTable
    end
  end
  object btnOk: TButton
    Left = 685
    Top = 314
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
    ExplicitLeft = 436
    ExplicitTop = 283
  end
  object btnCancel: TButton
    Left = 785
    Top = 314
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
    ExplicitLeft = 536
    ExplicitTop = 283
  end
  object IBCQueryGoods: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT'
      ' DOCID,'
      ' DOC_TYPE,'
      ' DATA,'
      ' GOODSID,'
      ' TITLE,'
      ' SERIAL_TYPE_ID,'
      ' SNPN'
      'FROM '
      '    SP_F35_GET_GOODS_BY_CUSTOMER(:DOCID)')
    Constraints = <>
    Left = 88
    Top = 120
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DOCID'
        Value = nil
      end>
  end
  object IBCDataSourceGoods: TIBCDataSource
    DataSet = IBCQueryGoods
    Left = 88
    Top = 172
  end
end
