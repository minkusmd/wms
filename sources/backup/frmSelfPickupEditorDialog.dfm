object frmSelfPickupEditorDlg: TfrmSelfPickupEditorDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1055#1091#1085#1082#1090' '#1089#1072#1084#1086#1074#1099#1074#1086#1079#1072
  ClientHeight = 432
  ClientWidth = 608
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    608
    432)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 608
    Height = 64
    Title = #1055#1091#1085#1082#1090' '#1089#1072#1084#1086#1074#1099#1074#1086#1079#1072
    Text = #1042#1099#1073#1077#1088#1080#1090#1077' '#1087#1091#1085#1082#1090' '#1089#1072#1084#1086#1074#1099#1074#1086#1079#1072
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
    ImageIndex = 30
    ExplicitLeft = 384
    ExplicitTop = 212
    ExplicitWidth = 0
  end
  object cxGrid: TcxGrid
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 592
    Height = 306
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 1
    ExplicitWidth = 548
    ExplicitHeight = 205
    object cxGridTable: TcxGridDBTableView
      NavigatorButtons.ConfirmDelete = False
      DataController.DataSource = IBCDataSourceSP
      DataController.KeyFieldNames = 'FIRMAID;ORASID;CUSTOMERID'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsCustomize.ColumnFiltering = False
      OptionsCustomize.ColumnGrouping = False
      OptionsCustomize.ColumnSorting = False
      OptionsCustomize.ColumnsQuickCustomization = True
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1084#1072#1075#1072#1079#1080#1085#1086#1074'>'
      OptionsView.ScrollBars = ssVertical
      OptionsView.ColumnAutoWidth = True
      OptionsView.GridLineColor = 13750737
      OptionsView.GroupByBox = False
      OptionsView.Indicator = True
      Styles.Header = dmAdditions.cxStyle_GridHeader
      object cxGridTable_FIRMAID: TcxGridDBColumn
        Caption = #1050#1086#1076
        DataBinding.FieldName = 'FIRMAID'
        Visible = False
        MinWidth = 50
        Options.HorzSizing = False
        Width = 50
      end
      object cxGridTable_CUSTOMER_DISPLAYNAME: TcxGridDBColumn
        Caption = #1060#1080#1088#1084#1072
        DataBinding.FieldName = 'CUSTOMER_DISPLAYNAME'
        Width = 100
      end
      object cxGridTable_ORAS_DENUMIRE: TcxGridDBColumn
        Caption = #1043#1086#1088#1086#1076
        DataBinding.FieldName = 'ORAS_DENUMIRE'
        Width = 80
      end
      object cxGridTable_CUSTOMER_ADRESA: TcxGridDBColumn
        Caption = #1040#1076#1088#1077#1089
        DataBinding.FieldName = 'CUSTOMER_ADRESA'
        Width = 100
      end
      object cxGridTable_ORASID: TcxGridDBColumn
        DataBinding.FieldName = 'ORASID'
        Visible = False
        VisibleForCustomization = False
      end
      object cxGridTable_CUSTOMERID: TcxGridDBColumn
        DataBinding.FieldName = 'CUSTOMERID'
        Visible = False
        VisibleForCustomization = False
      end
    end
    object cxGridLevel: TcxGridLevel
      GridView = cxGridTable
    end
  end
  object btnOk: TButton
    Left = 400
    Top = 389
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
    ExplicitLeft = 356
    ExplicitTop = 288
  end
  object btnCancel: TButton
    Left = 504
    Top = 389
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
    ExplicitLeft = 460
    ExplicitTop = 288
  end
  object IBCQuerySP: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT'
      ' TS_MAGAZINE.FIRMAID,'
      ' TS_MAGAZINE.ORASID,'
      
        ' (SELECT DENUMIRE FROM TS_ORASE WHERE TS_ORASE.ORASID=TS_MAGAZIN' +
        'E.ORASID) ORAS_DENUMIRE,'
      ' TS_MAGAZINE.CUSTOMERID,'
      
        ' (SELECT DISPLAYNAME FROM TS_CUSTOMER WHERE TS_CUSTOMER.CUSTOMER' +
        'ID=TS_MAGAZINE.CUSTOMERID) CUSTOMER_DISPLAYNAME,'
      ' TS_MAGAZINE.ADRESA CUSTOMER_ADRESA'
      ''
      'FROM'
      ' TS_MAGAZINE'
      ''
      'ORDER BY'
      ' ORASID, ORDERNO')
    AutoCommit = False
    LockMode = lmLockImmediate
    Left = 84
    Top = 204
  end
  object IBCDataSourceSP: TIBCDataSource
    DataSet = IBCQuerySP
    Left = 84
    Top = 152
  end
end
