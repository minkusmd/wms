object frmIncidentCallDlg: TfrmIncidentCallDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1047#1074#1086#1085#1086#1082' '#1087#1086' '#1080#1085#1094#1080#1076#1077#1085#1090#1091
  ClientHeight = 643
  ClientWidth = 1115
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    1115
    643)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 1115
    Height = 64
    Title = #1047#1074#1086#1085#1086#1082' '#1087#1086' '#1080#1085#1094#1080#1076#1077#1085#1090#1091
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
    ImageIndex = 27
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 1099
    Height = 513
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    object Label2: TLabel
      Left = 16
      Top = 321
      Width = 49
      Height = 15
      Caption = #1058#1077#1083#1077#1092#1086#1085
    end
    object Label3: TLabel
      Left = 16
      Top = 260
      Width = 511
      Height = 18
      AutoSize = False
      Caption = #1047#1074#1086#1085#1086#1082
      Color = 12577469
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = False
      Layout = tlCenter
    end
    object Label4: TLabel
      Left = 16
      Top = 16
      Width = 511
      Height = 18
      AutoSize = False
      Caption = #1048#1085#1094#1080#1076#1077#1085#1090
      Color = 12312063
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = False
      Layout = tlCenter
    end
    object Label5: TLabel
      Left = 16
      Top = 48
      Width = 82
      Height = 15
      Caption = #1058#1080#1087' '#1080#1085#1094#1080#1076#1077#1085#1090#1072
    end
    object Label6: TLabel
      Left = 16
      Top = 77
      Width = 33
      Height = 15
      Caption = #1058#1086#1074#1072#1088
    end
    object Label7: TLabel
      Left = 16
      Top = 135
      Width = 97
      Height = 15
      Caption = #1057#1077#1088#1080#1081#1085#1099#1081' '#1085#1086#1084#1077#1088
    end
    object Label8: TLabel
      Left = 16
      Top = 106
      Width = 43
      Height = 15
      Caption = #1052#1086#1076#1077#1083#1100
    end
    object Label1: TLabel
      Left = 16
      Top = 292
      Width = 62
      Height = 15
      Caption = #1050#1086#1085#1090#1088#1072#1075#1077#1085#1090
    end
    object Label10: TLabel
      Left = 16
      Top = 408
      Width = 77
      Height = 15
      Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080
    end
    object Label11: TLabel
      Left = 16
      Top = 350
      Width = 53
      Height = 15
      Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090
    end
    object Label12: TLabel
      Left = 16
      Top = 379
      Width = 80
      Height = 15
      Caption = #1050#1083#1080#1077#1085#1090' '#1087#1088#1080#1076#1077#1090
    end
    object Label9: TLabel
      Left = 16
      Top = 172
      Width = 511
      Height = 18
      AutoSize = False
      Caption = #1057#1091#1084#1084#1072' '#1082' '#1091#1087#1083#1072#1090#1077
      Color = 12303359
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = False
      Layout = tlCenter
    end
    object Label13: TLabel
      Left = 16
      Top = 199
      Width = 87
      Height = 15
      Caption = #1057#1091#1084#1084#1072' '#1082' '#1091#1087#1083#1072#1090#1077
    end
    object Label14: TLabel
      Left = 223
      Top = 199
      Width = 21
      Height = 15
      Caption = #1051#1077#1081
    end
    object sbMoreDetails: TSpeedButton
      Left = 504
      Top = 196
      Width = 23
      Height = 23
      Caption = '>'
      OnClick = sbMoreDetailsClick
    end
    object Label15: TLabel
      Left = 313
      Top = 199
      Width = 185
      Height = 15
      Alignment = taRightJustify
      Caption = #1055#1088#1086#1080#1079#1074#1077#1076#1077#1085#1085#1099#1077' '#1088#1072#1073#1086#1090#1099' '#1080' '#1090#1086#1074#1072#1088#1099
    end
    object Label16: TLabel
      Left = 564
      Top = 16
      Width = 511
      Height = 18
      AutoSize = False
      Caption = #1058#1086#1074#1072#1088#1099
      Color = 13882323
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = False
      Layout = tlCenter
    end
    object Label17: TLabel
      Left = 564
      Top = 260
      Width = 511
      Height = 18
      AutoSize = False
      Caption = #1050#1086#1084#1077#1085#1090#1072#1088#1080#1080' '#1087#1086' '#1074#1099#1087#1086#1083#1085#1077#1085#1099#1084' '#1088#1072#1073#1086#1090#1072#1084
      Color = 13882323
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = False
      Layout = tlCenter
    end
    object edTYPE_TITLE: TcxDBTextEdit
      Left = 119
      Top = 45
      TabStop = False
      DataBinding.DataField = 'TYPE_TITLE'
      TabOrder = 0
      Width = 408
    end
    object edGOODS_NAME: TcxDBTextEdit
      Left = 119
      Top = 74
      TabStop = False
      DataBinding.DataField = 'GOODS_NAME'
      TabOrder = 1
      Width = 408
    end
    object edSN: TcxDBTextEdit
      Left = 119
      Top = 132
      TabStop = False
      DataBinding.DataField = 'SN'
      TabOrder = 2
      Width = 182
    end
    object edGOODS_MODEL: TcxDBTextEdit
      Left = 119
      Top = 103
      TabStop = False
      DataBinding.DataField = 'GOODS_MODEL'
      TabOrder = 3
      Width = 408
    end
    object edCUSTOMER_FULLNAME: TcxDBTextEdit
      Left = 119
      Top = 289
      TabStop = False
      DataBinding.DataField = 'CUSTOMER_FULLNAME'
      TabOrder = 4
      Width = 408
    end
    object mmCOMMENTS: TcxDBMemo
      Left = 119
      Top = 405
      DataBinding.DataField = 'COMMENTS'
      Properties.ScrollBars = ssVertical
      TabOrder = 5
      Height = 86
      Width = 408
    end
    object dePICKUP_DATE: TcxDBDateEdit
      Left = 119
      Top = 376
      DataBinding.DataField = 'PICKUP_DATE'
      TabOrder = 6
      Width = 158
    end
    object lcbCALL_RESULT: TcxDBLookupComboBox
      Left = 119
      Top = 347
      DataBinding.DataField = 'CALL_RESULT'
      Properties.DropDownListStyle = lsFixedList
      Properties.KeyFieldNames = 'SYSSID'
      Properties.ListColumns = <
        item
          FieldName = 'TITLE'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = IBCDataSourceResults
      TabOrder = 7
      Width = 240
    end
    object cmbPhones: TComboBox
      Left = 119
      Top = 318
      Width = 158
      Height = 23
      Style = csDropDownList
      TabOrder = 8
    end
    object cxDBTextEdit1: TcxDBTextEdit
      Left = 119
      Top = 196
      TabStop = False
      DataBinding.DataField = 'SN'
      TabOrder = 9
      Width = 98
    end
    object cxGridGoods: TcxGrid
      Left = 564
      Top = 45
      Width = 511
      Height = 192
      TabOrder = 10
      LookAndFeel.NativeStyle = True
      LookAndFeel.SkinName = ''
      object cxGridGoodsTable: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        Navigator.Buttons.First.Visible = True
        Navigator.Buttons.PriorPage.Visible = True
        Navigator.Buttons.Prior.Visible = True
        Navigator.Buttons.Next.Visible = True
        Navigator.Buttons.NextPage.Visible = True
        Navigator.Buttons.Last.Visible = True
        Navigator.Buttons.Insert.Visible = True
        Navigator.Buttons.Append.Visible = False
        Navigator.Buttons.Delete.Visible = True
        Navigator.Buttons.Edit.Visible = True
        Navigator.Buttons.Post.Visible = True
        Navigator.Buttons.Cancel.Visible = True
        Navigator.Buttons.Refresh.Visible = True
        Navigator.Buttons.SaveBookmark.Visible = True
        Navigator.Buttons.GotoBookmark.Visible = True
        Navigator.Buttons.Filter.Visible = True
        DataController.DataSource = IBCDataSourceJurnal
        DataController.KeyFieldNames = 'DOCID;DTDEP;CTDEP;GOODSCOMPLECT_ID;GOODSID'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <
          item
            Format = '#,##0.00'
            Kind = skSum
            FieldName = 'SUMAVAT'
            Column = cxGridDBCol_SUMAVAT
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Column = cxGridDBCol_SUMA
          end>
        DataController.Summary.SummaryGroups = <>
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnGrouping = False
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsSelection.InvertSelect = False
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
        OptionsView.ScrollBars = ssVertical
        OptionsView.CellAutoHeight = True
        OptionsView.ColumnAutoWidth = True
        OptionsView.Footer = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        Styles.Header = dmAdditions.cxStyle_GridHeader
        object cxGridDBCol_DTDEP_NAME: TcxGridDBColumn
          Caption = #1057#1082#1083#1072#1076
          DataBinding.FieldName = 'DTDEP_NAME'
          Visible = False
          MinWidth = 140
          Options.Filtering = False
          Options.HorzSizing = False
          Width = 140
        end
        object cxGridDBCol_GOODSID: TcxGridDBColumn
          Caption = #1050#1086#1076
          DataBinding.FieldName = 'GOODSID'
          FooterAlignmentHorz = taRightJustify
          HeaderAlignmentHorz = taCenter
          MinWidth = 40
          Options.Filtering = False
          Options.HorzSizing = False
          Width = 40
        end
        object cxGridDBCol_GOODS_NAME: TcxGridDBColumn
          Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
          DataBinding.FieldName = 'GOODS_NAME'
          Width = 200
        end
        object cxGridDBCol_QTY: TcxGridDBColumn
          Caption = #1050#1086#1083'-'#1074#1086
          DataBinding.FieldName = 'QTY'
          FooterAlignmentHorz = taRightJustify
          HeaderAlignmentHorz = taCenter
          MinWidth = 50
          Options.Filtering = False
          Options.Focusing = False
          Options.HorzSizing = False
          Width = 50
        end
        object cxGridDBCol_UM_NAME: TcxGridDBColumn
          Caption = #1045#1048
          DataBinding.FieldName = 'UM_NAME'
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taCenter
          Visible = False
          HeaderAlignmentHorz = taCenter
          MinWidth = 40
          Options.Filtering = False
          Options.Grouping = False
          Options.HorzSizing = False
          Options.Sorting = False
          Width = 40
        end
        object cxGridDBCol_K_UM: TcxGridDBColumn
          Caption = #1050
          DataBinding.FieldName = 'K_UM'
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taCenter
          Visible = False
          HeaderAlignmentHorz = taCenter
          MinWidth = 30
          Options.Filtering = False
          Options.HorzSizing = False
          Options.Sorting = False
          Width = 30
        end
        object cxGridDBCol_PRICE: TcxGridDBColumn
          Caption = #1062#1077#1085#1072
          DataBinding.FieldName = 'PRICE'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '#,##0.00'
          HeaderAlignmentHorz = taCenter
          MinWidth = 70
          Options.Filtering = False
          Options.HorzSizing = False
          Width = 70
        end
        object cxGridDBCol_SUMA: TcxGridDBColumn
          Caption = #1057#1091#1084#1084#1072
          DataBinding.FieldName = 'SUMA'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '#,##0.00'
          FooterAlignmentHorz = taRightJustify
          HeaderAlignmentHorz = taCenter
          MinWidth = 70
          Options.Filtering = False
          Options.HorzSizing = False
          Styles.Footer = dmAdditions.cxStyle_MoneyCounter_Total
          Width = 70
        end
        object cxGridDBCol_SUMAVAT: TcxGridDBColumn
          Caption = #1053#1044#1057
          DataBinding.FieldName = 'SUMAVAT'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '#,##0.00'
          Visible = False
          FooterAlignmentHorz = taRightJustify
          HeaderAlignmentHorz = taCenter
          MinWidth = 70
          Options.Filtering = False
          Options.HorzSizing = False
          Width = 70
        end
        object cxGridDBCol_GOODS_TYPE_ID: TcxGridDBColumn
          DataBinding.FieldName = 'GOODS_TYPE_ID'
          Visible = False
          VisibleForCustomization = False
        end
        object cxGridDBCol_FLG_ACTIVE: TcxGridDBColumn
          Caption = #1040#1082#1090#1080#1074
          DataBinding.FieldName = 'FLG_ACTIVE'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = '1'
          Properties.ValueUnchecked = '0'
          Visible = False
          HeaderAlignmentHorz = taCenter
          MinWidth = 40
          Options.Filtering = False
          Options.HorzSizing = False
          Width = 40
        end
        object cxGridDBCol_FLG_READY: TcxGridDBColumn
          Caption = #1043#1086#1090#1086#1074
          DataBinding.FieldName = 'FLG_READY'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = '1'
          Properties.ValueUnchecked = '0'
          Visible = False
          HeaderAlignmentHorz = taCenter
          MinWidth = 40
          Options.Filtering = False
          Options.HorzSizing = False
          Width = 40
        end
        object cxGridDBCol_STOCK_QTY: TcxGridDBColumn
          Caption = #1054#1089#1090#1072#1090#1086#1082
          DataBinding.FieldName = 'STOCK_QTY'
          Visible = False
          HeaderAlignmentHorz = taCenter
          MinWidth = 64
          Options.Filtering = False
          Options.HorzSizing = False
        end
      end
      object cxGridGoodsLevel: TcxGridLevel
        GridView = cxGridGoodsTable
      end
    end
    object cxGridComments: TcxGrid
      Left = 564
      Top = 289
      Width = 511
      Height = 204
      TabOrder = 11
      LookAndFeel.NativeStyle = True
      LookAndFeel.SkinName = ''
      object cxGridCommentsDB: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        Navigator.Buttons.First.Visible = True
        Navigator.Buttons.PriorPage.Visible = True
        Navigator.Buttons.Prior.Visible = True
        Navigator.Buttons.Next.Visible = True
        Navigator.Buttons.NextPage.Visible = True
        Navigator.Buttons.Last.Visible = True
        Navigator.Buttons.Insert.Visible = True
        Navigator.Buttons.Append.Visible = False
        Navigator.Buttons.Delete.Visible = True
        Navigator.Buttons.Edit.Visible = True
        Navigator.Buttons.Post.Visible = True
        Navigator.Buttons.Cancel.Visible = True
        Navigator.Buttons.Refresh.Visible = True
        Navigator.Buttons.SaveBookmark.Visible = True
        Navigator.Buttons.GotoBookmark.Visible = True
        Navigator.Buttons.Filter.Visible = True
        DataController.DataSource = IBCDataSourceComments
        DataController.KeyFieldNames = 'IID;TASKID'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <
          item
            Format = '#,##0.00'
            Kind = skSum
            FieldName = 'SUMAVAT'
          end
          item
            Format = '#,##0.00'
            Kind = skSum
          end>
        DataController.Summary.SummaryGroups = <>
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnGrouping = False
        OptionsCustomize.ColumnSorting = False
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsSelection.InvertSelect = False
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
        OptionsView.ScrollBars = ssVertical
        OptionsView.CellAutoHeight = True
        OptionsView.ColumnAutoWidth = True
        OptionsView.Footer = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        Styles.Header = dmAdditions.cxStyle_GridHeader
        object cxGridCommentsDB_1: TcxGridDBColumn
          Caption = #1047#1072#1076#1072#1095#1072
          DataBinding.FieldName = 'TYPE_TITLE'
          MinWidth = 200
          Options.HorzSizing = False
          Width = 200
        end
        object cxGridCommentsDB_2: TcxGridDBColumn
          Caption = #1050#1086#1084#1077#1085#1090#1072#1088#1080#1080
          DataBinding.FieldName = 'COMMENTS'
          Width = 330
        end
      end
      object cxGridCommentsLevel: TcxGridLevel
        GridView = cxGridCommentsDB
      end
    end
  end
  object btnOk: TButton
    Left = 901
    Top = 599
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = '&Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 1005
    Top = 599
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
  object IBCQueryResults: TIBCQuery
    SQL.Strings = (
      'SELECT'
      '*'
      'FROM'
      ' GET_SERVICE_CALL_RESULTS')
    Constraints = <>
    Left = 468
    Top = 348
  end
  object IBCDataSourceResults: TIBCDataSource
    DataSet = IBCQueryResults
    Left = 468
    Top = 296
  end
  object IBCQueryJurnal: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      'SELECT *'
      'FROM VW_TDB_JURNAL'
      'WHERE'
      ' DOCID in (SELECT DOCID FROM TDB_SC_RELATIONS WHERE IID=:IID)')
    AutoCommit = False
    RefreshOptions = [roAfterInsert, roAfterUpdate, roBeforeEdit]
    Options.BooleanDomainFields = True
    Options.FullRefresh = True
    Constraints = <>
    Left = 692
    Top = 208
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'IID'
        Value = nil
      end>
  end
  object IBCDataSourceJurnal: TIBCDataSource
    DataSet = IBCQueryJurnal
    Left = 692
    Top = 160
  end
  object IBCQueryComments: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      'SELECT'
      ' TDB_SC_TASK_DSC.IID,'
      ' TDB_SC_TASK_DSC.TASKID,'
      ' TDB_SC_TASK_DSC.DATA,'
      ' TDB_SC_TASK_DSC.COMMENTS,'
      ' VW_TDB_SC_TASKS.TYPE_TITLE'
      'FROM'
      ' TDB_SC_TASK_DSC'
      
        ' INNER JOIN VW_TDB_SC_TASKS ON (VW_TDB_SC_TASKS.TASKID=TDB_SC_TA' +
        'SK_DSC.TASKID)'
      'WHERE '
      ' TDB_SC_TASK_DSC.IID=:IID')
    AutoCommit = False
    RefreshOptions = [roAfterInsert, roAfterUpdate, roBeforeEdit]
    Options.BooleanDomainFields = True
    Options.FullRefresh = True
    Constraints = <>
    Left = 680
    Top = 456
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'IID'
        Value = nil
      end>
  end
  object IBCDataSourceComments: TIBCDataSource
    DataSet = IBCQueryComments
    Left = 680
    Top = 408
  end
end
