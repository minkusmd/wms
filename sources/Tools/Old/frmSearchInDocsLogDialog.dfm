object frmSearchInDocsLogDlg: TfrmSearchInDocsLogDlg
  Left = 0
  Top = 0
  ActiveControl = edDOCID
  BorderStyle = bsDialog
  Caption = #1055#1086#1080#1089#1082' '#1074' '#1078#1091#1088#1085#1072#1083#1077' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074
  ClientHeight = 617
  ClientWidth = 1089
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
  object lbWaitInfo: TLabel
    Left = 21
    Top = 574
    Width = 436
    Height = 15
    Caption = 
      #1048#1076#1077#1090' '#1087#1086#1080#1089#1082'. '#1069#1090#1086' '#1084#1086#1078#1077#1090' '#1079#1072#1085#1103#1090#1100' '#1085#1077#1082#1086#1090#1086#1088#1086#1077' '#1074#1088#1077#1084#1103'. '#1044#1086#1078#1076#1080#1090#1077#1089#1100' '#1086#1082#1086#1085#1095#1072#1085#1080 +
      #1077' '#1087#1086#1080#1089#1082#1072'.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 1089
    Height = 64
    Title = #1055#1086#1080#1089#1082' '#1074' '#1078#1091#1088#1085#1072#1083#1077' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074
    Text = #1055#1086#1080#1089#1082' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1080' '#1074' '#1078#1091#1088#1085#1072#1083#1077' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074
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
    ImageIndex = 9
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 1073
    Height = 105
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 4
    Align = alTop
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    object Label1: TLabel
      Left = 16
      Top = 16
      Width = 81
      Height = 15
      Caption = #1050#1086#1076' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
    end
    object Label2: TLabel
      Left = 140
      Top = 16
      Width = 98
      Height = 15
      Caption = #1050#1086#1076' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
    end
    object Label3: TLabel
      Left = 260
      Top = 16
      Width = 60
      Height = 15
      Caption = #1050#1086#1076' '#1090#1086#1074#1072#1088#1072
    end
    object Label4: TLabel
      Left = 384
      Top = 16
      Width = 97
      Height = 15
      Caption = #1057#1077#1088#1080#1081#1085#1099#1081' '#1085#1086#1084#1077#1088
    end
    object Label5: TLabel
      Left = 516
      Top = 16
      Width = 103
      Height = 15
      Caption = #1055#1072#1088#1090#1080#1081#1085#1099#1081' '#1085#1086#1084#1077#1088
    end
    object Label6: TLabel
      Left = 16
      Top = 72
      Width = 152
      Height = 15
      Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1099#1081' '#1089#1074#1086#1081#1089#1090#1074#1072':'
    end
    object Label7: TLabel
      Left = 696
      Top = 16
      Width = 119
      Height = 15
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1088#1077#1079#1091#1083#1100#1090#1072#1090#1086#1074
    end
    object lbRecordCount: TLabel
      Left = 1004
      Top = 72
      Width = 45
      Height = 15
      Alignment = taRightJustify
      Caption = 'Records:'
    end
    object edDOCID: TEdit
      Left = 16
      Top = 33
      Width = 90
      Height = 23
      TabOrder = 0
    end
    object edUSERID: TEdit
      Left = 140
      Top = 33
      Width = 90
      Height = 23
      TabOrder = 1
    end
    object edGOODSID: TEdit
      Left = 260
      Top = 33
      Width = 90
      Height = 23
      TabOrder = 2
    end
    object edSN: TEdit
      Left = 384
      Top = 33
      Width = 90
      Height = 23
      TabOrder = 3
    end
    object edPARTNO: TEdit
      Left = 516
      Top = 33
      Width = 90
      Height = 23
      TabOrder = 4
    end
    object btnSearch: TButton
      Left = 952
      Top = 16
      Width = 97
      Height = 40
      Caption = #1048#1089#1082#1072#1090#1100
      Default = True
      TabOrder = 7
      OnClick = btnSearchClick
    end
    object cbUPDATES: TCheckBox
      Left = 188
      Top = 72
      Width = 89
      Height = 17
      Caption = #1080#1079#1084#1077#1085#1077#1085#1080#1103
      TabOrder = 5
    end
    object cbDELETES: TCheckBox
      Left = 296
      Top = 72
      Width = 89
      Height = 17
      Caption = #1091#1076#1072#1083#1077#1085#1080#1103
      TabOrder = 6
    end
    object cmbResultCount: TComboBox
      Left = 696
      Top = 33
      Width = 119
      Height = 23
      Style = csDropDownList
      ItemIndex = 2
      TabOrder = 8
      Text = '300'
      Items.Strings = (
        '100'
        '200'
        '300'
        '500')
    end
  end
  object cxGrid: TcxGrid
    AlignWithMargins = True
    Left = 8
    Top = 181
    Width = 1073
    Height = 376
    Margins.Left = 8
    Margins.Top = 0
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    TabOrder = 2
    object cxGridTable: TcxGridDBBandedTableView
      DataController.DataSource = IBCDataSourceSearch
      DataController.KeyFieldNames = 'LOGID'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <
        item
          Kind = skCount
          Column = cxGridTable_DATETIME
        end>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.ImmediateEditor = False
      OptionsBehavior.IncSearch = True
      OptionsCustomize.ColumnFiltering = False
      OptionsCustomize.ColumnGrouping = False
      OptionsCustomize.ColumnMoving = False
      OptionsCustomize.BandMoving = False
      OptionsCustomize.BandSizing = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsSelection.InvertSelect = False
      OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
      OptionsView.ScrollBars = ssVertical
      OptionsView.CellAutoHeight = True
      OptionsView.ColumnAutoWidth = True
      OptionsView.DataRowHeight = 32
      OptionsView.GridLineColor = 13750737
      OptionsView.GroupByBox = False
      OptionsView.Indicator = True
      OptionsView.BandHeaders = False
      Styles.ContentEven = dmAdditions.cxStyle_MarginGroup
      Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
      Styles.Header = dmAdditions.cxStyle_GridHeader
      Bands = <
        item
          VisibleForCustomization = False
        end>
      object cxGridTable_DATETIME: TcxGridDBBandedColumn
        Caption = #1044#1072#1090#1072
        DataBinding.FieldName = 'DATETIME'
        MinWidth = 140
        Options.HorzSizing = False
        SortIndex = 0
        SortOrder = soAscending
        Width = 140
        Position.BandIndex = 0
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxGridTable_DOCID: TcxGridDBBandedColumn
        Caption = #1044#1086#1082#1091#1084#1077#1085#1090
        DataBinding.FieldName = 'DOCID'
        MinWidth = 70
        Options.HorzSizing = False
        Width = 70
        Position.BandIndex = 0
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxGridTable_DOCTYPE_NAME: TcxGridDBBandedColumn
        Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
        DataBinding.FieldName = 'DOCTYPE_NAME'
        Styles.Content = dmAdditions.cxStyle_Bold
        Width = 100
        Position.BandIndex = 0
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxGridTable_USERID: TcxGridDBBandedColumn
        Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
        DataBinding.FieldName = 'USERID'
        MinWidth = 80
        Options.HorzSizing = False
        Width = 80
        Position.BandIndex = 0
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object cxGridTable_USER_FULL_NAME: TcxGridDBBandedColumn
        Caption = #1048#1084#1103' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
        DataBinding.FieldName = 'USER_FULL_NAME'
        Styles.Content = dmAdditions.cxStyle_FirmaName
        Width = 80
        Position.BandIndex = 0
        Position.ColIndex = 4
        Position.RowIndex = 0
      end
      object cxGridTable_USER_FIRMA_NAME: TcxGridDBBandedColumn
        Caption = #1060#1080#1088#1084#1072' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
        DataBinding.FieldName = 'USER_FIRMA_NAME'
        Options.Sorting = False
        Width = 120
        Position.BandIndex = 0
        Position.ColIndex = 5
        Position.RowIndex = 0
      end
      object cxGridTable_DESCRIPTION: TcxGridDBBandedColumn
        Caption = #1054#1087#1080#1089#1072#1085#1080#1077
        DataBinding.FieldName = 'DESCRIPTION'
        Options.Sorting = False
        Styles.Content = dmAdditions.cxStyle_Italic
        Width = 200
        Position.BandIndex = 0
        Position.ColIndex = 0
        Position.RowIndex = 1
      end
    end
    object cxGridLevel: TcxGridLevel
      GridView = cxGridTable
    end
  end
  object btnClose: TButton
    Left = 984
    Top = 568
    Width = 90
    Height = 29
    Caption = #1047#1072#1082#1088#1099#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
  object IBCQuerySearch: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT'
      ' LOGID,'
      ' DOCID,'
      ' USERID,'
      ' DESCRIPTION,'
      ' DATETIME,'
      ' USER_FULL_NAME,'
      ' USER_FIRMA_NAME,'
      ' DOCTYPE_NAME'
      'FROM '
      
        ' SP_TOOLS_DOCS_LOG(:ADOCID,:AUSERID,:AGOODSID,:ASN,:APARTNO,:AFL' +
        'G_UPDATE,:AFLG_DELETE,:RESULT_COUNT)'
      'ORDER BY '
      ' DATETIME')
    Left = 88
    Top = 324
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ADOCID'
      end
      item
        DataType = ftUnknown
        Name = 'AUSERID'
      end
      item
        DataType = ftUnknown
        Name = 'AGOODSID'
      end
      item
        DataType = ftUnknown
        Name = 'ASN'
      end
      item
        DataType = ftUnknown
        Name = 'APARTNO'
      end
      item
        DataType = ftUnknown
        Name = 'AFLG_UPDATE'
      end
      item
        DataType = ftUnknown
        Name = 'AFLG_DELETE'
      end
      item
        DataType = ftUnknown
        Name = 'RESULT_COUNT'
      end>
  end
  object IBCDataSourceSearch: TIBCDataSource
    DataSet = IBCQuerySearch
    Left = 204
    Top = 324
  end
end
