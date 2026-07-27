object frmSearchInDocsLog2Dlg: TfrmSearchInDocsLog2Dlg
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = #1055#1086#1080#1089#1082' '#1074' '#1078#1091#1088#1085#1072#1083#1077' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074
  ClientHeight = 612
  ClientWidth = 975
  Color = clBtnFace
  Constraints.MinHeight = 600
  Constraints.MinWidth = 990
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
    Width = 975
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
  object pnFilters: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 959
    Height = 193
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
      Left = 20
      Top = 78
      Width = 38
      Height = 15
      Caption = #1060#1080#1088#1084#1072
    end
    object Label2: TLabel
      Left = 20
      Top = 107
      Width = 62
      Height = 15
      Caption = #1050#1086#1085#1090#1088#1072#1075#1077#1085#1090
    end
    object Label4: TLabel
      Left = 20
      Top = 20
      Width = 81
      Height = 15
      Caption = #1050#1086#1076' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
    end
    object Label5: TLabel
      Left = 368
      Top = 78
      Width = 77
      Height = 15
      Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
    end
    object Label6: TLabel
      Left = 368
      Top = 20
      Width = 32
      Height = 15
      Caption = #1058#1086#1074#1072#1088
    end
    object Label7: TLabel
      Left = 368
      Top = 49
      Width = 68
      Height = 15
      Caption = 'SN '#1080#1083#1080' PART'
    end
    object Label3: TLabel
      Left = 745
      Top = 20
      Width = 119
      Height = 15
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1088#1077#1079#1091#1083#1100#1090#1072#1090#1086#1074
    end
    object Label8: TLabel
      Left = 20
      Top = 49
      Width = 81
      Height = 15
      Caption = #1058#1080#1087' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
    end
    object lbRecordCount: TLabel
      Left = 875
      Top = 128
      Width = 60
      Height = 15
      Alignment = taRightJustify
      Caption = #1053#1072#1081#1076#1077#1085#1086': 0'
    end
    object Label9: TLabel
      Left = 368
      Top = 107
      Width = 42
      Height = 15
      Caption = #1055#1077#1088#1080#1086#1076
    end
    object lbWaitInfo: TLabel
      Left = 0
      Top = 174
      Width = 955
      Height = 15
      Align = alBottom
      Alignment = taCenter
      Caption = 
        #1048#1076#1077#1090' '#1087#1086#1080#1089#1082'. '#1069#1090#1086' '#1084#1086#1078#1077#1090' '#1079#1072#1085#1103#1090#1100' '#1085#1077#1082#1086#1090#1086#1088#1086#1077' '#1074#1088#1077#1084#1103'. '#1044#1086#1078#1076#1080#1090#1077#1089#1100' '#1086#1082#1086#1085#1095#1072#1085#1080 +
        #1077' '#1087#1086#1080#1089#1082#1072'.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      ExplicitWidth = 436
    end
    object edDOCID: TEdit
      Left = 107
      Top = 17
      Width = 90
      Height = 23
      TabOrder = 0
    end
    object lcbDT: TcxLookupComboBox
      Left = 107
      Top = 75
      Properties.ClearKey = 46
      Properties.DropDownListStyle = lsFixedList
      Properties.DropDownRows = 16
      Properties.DropDownWidth = 300
      Properties.KeyFieldNames = 'CUSTOMERID'
      Properties.ListColumns = <
        item
          Fixed = True
          Width = 50
          FieldName = 'CUSTOMERID'
        end
        item
          Width = 200
          FieldName = 'DISPLAYNAME'
        end>
      Properties.ListFieldIndex = 1
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = IBCDataSourceFIRMS
      EditValue = 0
      TabOrder = 6
      Width = 214
    end
    object beCT: TcxButtonEdit
      Left = 107
      Top = 104
      Properties.Buttons = <
        item
          Caption = #1042#1099#1073#1088#1072#1090#1100'...'
          Default = True
          Kind = bkText
        end
        item
          Caption = #1053#1077#1090
          Kind = bkText
        end>
      Properties.ClickKey = 0
      Properties.ViewStyle = vsHideCursor
      Properties.OnButtonClick = beCTPropertiesButtonClick
      TabOrder = 8
      Width = 214
    end
    object edSNPARTS: TEdit
      Left = 454
      Top = 46
      Width = 214
      Height = 23
      TabOrder = 4
    end
    object lcbUSERS: TcxLookupComboBox
      Left = 454
      Top = 75
      Properties.ClearKey = 46
      Properties.DropDownListStyle = lsFixedList
      Properties.DropDownRows = 16
      Properties.DropDownWidth = 400
      Properties.KeyFieldNames = 'USERID'
      Properties.ListColumns = <
        item
          Fixed = True
          Width = 50
          FieldName = 'USERID'
        end
        item
          FieldName = 'USER_FULLNAME'
        end>
      Properties.ListFieldIndex = 1
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = IBCDataSourceUSERS
      EditValue = 0
      TabOrder = 7
      Width = 214
    end
    object btnSearch: TButton
      Left = 838
      Top = 58
      Width = 97
      Height = 40
      Caption = #1048#1089#1082#1072#1090#1100
      Default = True
      TabOrder = 5
      OnClick = btnSearchClick
    end
    object cbMOD_UPDATE: TcxCheckBox
      Left = 20
      Top = 144
      Caption = #1048#1079#1084#1077#1085#1077#1085#1080#1103
      Properties.Alignment = taLeftJustify
      TabOrder = 11
    end
    object cbMOD_DELETE: TcxCheckBox
      Left = 131
      Top = 144
      Caption = #1059#1076#1072#1083#1077#1085#1080#1103
      Properties.Alignment = taLeftJustify
      TabOrder = 12
    end
    object cbMOD_FLG_CLOSED: TcxCheckBox
      Left = 227
      Top = 144
      Caption = #1047#1072#1082#1088#1099#1090#1080#1077' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
      Properties.Alignment = taLeftJustify
      TabOrder = 13
    end
    object cbMOD_FLG_SHIP: TcxCheckBox
      Left = 379
      Top = 144
      Caption = #1054#1090#1087#1088#1072#1074#1082#1072' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
      Properties.Alignment = taLeftJustify
      TabOrder = 14
    end
    object cmbResultCount: TComboBox
      Left = 870
      Top = 17
      Width = 65
      Height = 23
      Style = csDropDownList
      TabOrder = 2
      Items.Strings = (
        '100'
        '200'
        '300'
        '500'
        '1000'
        '2000')
    end
    object beGOODS: TcxButtonEdit
      Left = 454
      Top = 17
      Properties.Buttons = <
        item
          Caption = #1042#1099#1073#1088#1072#1090#1100'...'
          Default = True
          Kind = bkText
        end
        item
          Caption = #1053#1077#1090
          Kind = bkText
        end>
      Properties.ClickKey = 0
      Properties.ViewStyle = vsHideCursor
      Properties.OnButtonClick = beGOODSPropertiesButtonClick
      TabOrder = 1
      Width = 214
    end
    object lcbDocType: TcxLookupComboBox
      Left = 107
      Top = 46
      Properties.ClearKey = 46
      Properties.DropDownListStyle = lsFixedList
      Properties.DropDownRows = 16
      Properties.DropDownWidth = 400
      Properties.KeyFieldNames = 'DOCTYPEID'
      Properties.ListColumns = <
        item
          Fixed = True
          Width = 50
          FieldName = 'DOCTYPEID'
        end
        item
          Width = 200
          FieldName = 'TITLE'
        end>
      Properties.ListFieldIndex = 1
      Properties.ListSource = IBCDataSourceDOCTYPE
      EditValue = 0
      TabOrder = 3
      Width = 214
    end
    object deStartDate: TcxDateEdit
      Left = 454
      Top = 104
      Properties.ImmediatePost = True
      Properties.SaveTime = False
      Properties.ShowTime = False
      TabOrder = 9
      Width = 121
    end
    object deEndDate: TcxDateEdit
      Left = 581
      Top = 104
      Properties.ImmediatePost = True
      Properties.SaveTime = False
      Properties.ShowTime = False
      TabOrder = 10
      Width = 121
    end
    object cbMOD_JURNAL: TcxCheckBox
      Left = 531
      Top = 144
      Caption = #1046#1091#1088#1085#1072#1083
      Properties.Alignment = taLeftJustify
      TabOrder = 15
    end
    object cbMOD_SN: TcxCheckBox
      Left = 611
      Top = 144
      Caption = 'SN'
      Properties.Alignment = taLeftJustify
      TabOrder = 16
    end
    object cbMOD_PARTS: TcxCheckBox
      Left = 663
      Top = 144
      Caption = 'PARTS'
      Properties.Alignment = taLeftJustify
      TabOrder = 17
    end
  end
  object cxGrid: TcxGrid
    AlignWithMargins = True
    Left = 8
    Top = 267
    Width = 959
    Height = 337
    Margins.Left = 8
    Margins.Top = 2
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alClient
    TabOrder = 2
    ExplicitHeight = 323
    object cxGridView: TcxGridDBTableView
      OnKeyDown = cxGridViewKeyDown
      Navigator.Buttons.CustomButtons = <>
      ScrollbarAnnotations.CustomAnnotations = <>
      OnCustomDrawCell = cxGridViewCustomDrawCell
      DataController.DataSource = IBCDataSourceLog
      DataController.KeyFieldNames = 'LOGID'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsCustomize.ColumnsQuickCustomization = True
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.InvertSelect = False
      OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
      OptionsView.CellAutoHeight = True
      OptionsView.ColumnAutoWidth = True
      OptionsView.GridLineColor = 13750737
      OptionsView.GroupByBox = False
      OptionsView.Indicator = True
      Styles.OnGetContentStyle = cxGridViewStylesGetContentStyle
      Styles.Header = dmAdditions.cxStyle_GridHeader
      Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
      object cxGridView_DOCTYPE_TITLE: TcxGridDBColumn
        Caption = #1058#1080#1087' '#1076#1086#1082
        DataBinding.FieldName = 'DOCTYPE_TITLE'
        Width = 100
      end
      object cxGridView_DOCID: TcxGridDBColumn
        Caption = #1050#1086#1076' '#1076#1086#1082
        DataBinding.FieldName = 'DOCID'
        MinWidth = 60
        Options.HorzSizing = False
        Width = 60
      end
      object cxGridView_DATETIME: TcxGridDBColumn
        Caption = #1044#1072#1090#1072
        DataBinding.FieldName = 'DATETIME'
        MinWidth = 130
        Options.HorzSizing = False
        Width = 130
      end
      object cxGridView_DESCRIPTION: TcxGridDBColumn
        Caption = #1054#1087#1080#1089#1072#1085#1080#1077
        DataBinding.FieldName = 'DESCRIPTION'
        OnGetDataText = cxGridView_DESCRIPTIONGetDataText
        Options.Grouping = False
        Options.Sorting = False
        Width = 300
      end
      object cxGridView_CREATED_BY_NAME: TcxGridDBColumn
        Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
        DataBinding.FieldName = 'CREATED_BY_NAME'
        Width = 70
      end
      object cxGridView_DT_NAME: TcxGridDBColumn
        Caption = #1060#1080#1088#1084#1072
        DataBinding.FieldName = 'DT_NAME'
        Width = 70
      end
      object cxGridView_CT_NAME: TcxGridDBColumn
        Caption = #1050#1086#1085#1090#1088#1072#1075#1077#1085#1090
        DataBinding.FieldName = 'CT_NAME'
        Width = 70
      end
      object cxGridView_MOD_FLG_CLOSED: TcxGridDBColumn
        DataBinding.FieldName = 'MOD_FLG_CLOSED'
        Visible = False
        VisibleForCustomization = False
        IsCaptionAssigned = True
      end
      object cxGridView_MOD_DELETE: TcxGridDBColumn
        DataBinding.FieldName = 'MOD_DELETE'
        Visible = False
        VisibleForCustomization = False
        IsCaptionAssigned = True
      end
      object cxGridView_MOD_SN: TcxGridDBColumn
        DataBinding.FieldName = 'MOD_SN'
        Visible = False
        VisibleForCustomization = False
        IsCaptionAssigned = True
      end
      object cxGridView_MOD_PARTS: TcxGridDBColumn
        DataBinding.FieldName = 'MOD_PARTS'
        Visible = False
        VisibleForCustomization = False
        IsCaptionAssigned = True
      end
    end
    object cxGridLevel: TcxGridLevel
      GridView = cxGridView
    end
  end
  object IBCQueryLog: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT FIRST(:DOC_COUNT)'
      '*'
      'FROM VW_TLOG_DOCS2')
    Left = 284
    Top = 448
    ParamData = <
      item
        DataType = ftInteger
        Name = 'DOC_COUNT'
        ParamType = ptInput
        Value = nil
      end>
  end
  object IBCDataSourceLog: TIBCDataSource
    DataSet = IBCQueryLog
    Left = 284
    Top = 504
  end
  object IBCQueryFIRMS: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT'
      ' CUSTOMERID,'
      ' DISPLAYNAME'
      'FROM GET_FIRMS_BY_USER2')
    Left = 40
    Top = 344
  end
  object IBCDataSourceFIRMS: TIBCDataSource
    DataSet = IBCQueryFIRMS
    Left = 40
    Top = 400
  end
  object IBCQueryDOCTYPE: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT'
      ' DOCTYPEID,'
      ' TITLE'
      'FROM GET_DOCTYPES_BY_USER2')
    Left = 164
    Top = 344
  end
  object IBCDataSourceDOCTYPE: TIBCDataSource
    DataSet = IBCQueryDOCTYPE
    Left = 164
    Top = 400
  end
  object IBCQueryUSERS: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT'
      ' USERID,'
      ' USER_FULLNAME'
      'FROM GET_USERS_BY_USER2(1)')
    Left = 444
    Top = 340
  end
  object IBCDataSourceUSERS: TIBCDataSource
    DataSet = IBCQueryUSERS
    Left = 444
    Top = 392
  end
end
