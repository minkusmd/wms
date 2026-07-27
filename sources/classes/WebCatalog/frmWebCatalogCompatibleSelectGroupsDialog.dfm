object frmWebCatalogCompatibleSelectGroupsDlg: TfrmWebCatalogCompatibleSelectGroupsDlg
  Left = 0
  Top = 0
  ActiveControl = cxDBTreeList
  BorderStyle = bsDialog
  Caption = #1042#1099#1073#1086#1088' '#1075#1088#1091#1087#1087#1099' '#1090#1086#1074#1072#1088#1086#1074
  ClientHeight = 495
  ClientWidth = 488
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
  object DialogTitle1: TDialogTitle
    Left = 0
    Top = 0
    Width = 488
    Height = 64
    Title = #1042#1099#1073#1086#1088' '#1075#1088#1091#1087#1087#1099' '#1090#1086#1074#1072#1088#1086#1074
    Text = #1042#1099#1073#1077#1088#1080#1090#1077' '#1075#1088#1091#1087#1087#1091' '#1090#1086#1074#1072#1088#1086#1074' '#1080#1079' Web '#1082#1072#1090#1072#1083#1086#1075#1072
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
    ImageIndex = 0
  end
  object cxDBTreeList: TcxDBTreeList
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 472
    Height = 365
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    Bands = <
      item
      end>
    DataController.DataSource = IBCDataSourceTree
    DataController.ParentField = 'PARENTID'
    DataController.KeyField = 'CATALOGID'
    Navigator.Buttons.CustomButtons = <>
    OptionsBehavior.ChangeDelay = 1000
    OptionsData.Editing = False
    OptionsData.Deleting = False
    OptionsSelection.InvertSelect = False
    OptionsView.ColumnAutoWidth = True
    RootValue = 0
    ScrollbarAnnotations.CustomAnnotations = <>
    Styles.ColumnHeader = dmAdditions.cxStyle_GridHeader
    TabOrder = 1
    object cxDBTreeListcxDBTreeListColumn1: TcxDBTreeListColumn
      Caption.Text = 'Denumirea'
      DataBinding.FieldName = 'TITLE'
      Width = 100
      Position.ColIndex = 0
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
    end
    object cxDBTreeListcxDBTreeListColumn2: TcxDBTreeListColumn
      Caption.Text = #1053#1072#1079#1074#1072#1085#1080#1077
      DataBinding.FieldName = 'TITLE_RUS'
      Width = 100
      Position.ColIndex = 1
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
    end
    object cxDBTreeList_CATALOGID: TcxDBTreeListColumn
      Caption.Text = #1050#1086#1076
      DataBinding.FieldName = 'CATALOGID'
      Options.Sizing = False
      Width = 50
      Position.ColIndex = 2
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
    end
  end
  object btnOk: TButton
    Left = 276
    Top = 451
    Width = 90
    Height = 29
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 380
    Top = 451
    Width = 90
    Height = 29
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
  object IBCDataSourceTree: TIBCDataSource
    DataSet = IBCQueryTree
    Left = 160
    Top = 220
  end
  object IBCQueryTree: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT'
      ' *'
      'FROM'
      ' VW_TWEB_CATALOG'
      'WHERE CATALOGID<>:id'
      'ORDER BY'
      ' ORDERNO')
    AutoCommit = False
    Left = 160
    Top = 272
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        Value = nil
      end>
  end
end
