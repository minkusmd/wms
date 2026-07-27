object frmExportTo1CDlg: TfrmExportTo1CDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1069#1082#1089#1087#1086#1088#1090' '#1076#1072#1085#1085#1099#1093' '#1074' 1'#1057
  ClientHeight = 485
  ClientWidth = 558
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    558
    485)
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 558
    Height = 64
    Title = #1069#1082#1089#1087#1086#1088#1090' '#1076#1072#1085#1085#1099#1093' '#1074' 1'#1057
    Text = #1042#1099#1073#1077#1088#1080#1090#1077' '#1090#1088#1077#1073#1091#1077#1084#1099#1077' '#1076#1086#1082#1091#1084#1077#1085#1090#1099' '#1076#1083#1103' '#1101#1082#1089#1087#1086#1088#1090#1072
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
    ImageIndex = 11
  end
  object pcPageControl: TPageControl
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 542
    Height = 353
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    ActivePage = tbsErrors
    Align = alTop
    TabOrder = 1
    object tbsExport: TTabSheet
      Caption = #1055#1086#1089#1090#1091#1087#1083#1077#1085#1080#1077', '#1087#1077#1088#1077#1084#1077#1097#1077#1085#1080#1077' '#1080' '#1088#1077#1072#1083#1080#1079#1072#1094#1080#1103
      ImageIndex = 1
      object Label1: TLabel
        Left = 20
        Top = 31
        Width = 45
        Height = 15
        Caption = #1055#1077#1088#1080#1086#1076
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label2: TLabel
        Left = 20
        Top = 3
        Width = 409
        Height = 15
        Caption = 
          #1055#1086#1089#1090#1091#1087#1083#1077#1085#1080#1077', '#1087#1077#1088#1077#1084#1077#1097#1077#1085#1080#1077' '#1080' '#1088#1077#1072#1083#1080#1079#1072#1094#1080#1103' '#1090#1086#1074#1072#1088#1086#1074' '#1079#1072' '#1074#1099#1073#1088#1072#1085#1085#1099#1081' '#1087#1077#1088#1080#1086 +
          #1076'.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object Label4: TLabel
        Left = 20
        Top = 94
        Width = 173
        Height = 15
        Caption = #1058#1080#1087#1099' '#1076#1086#1082#1091#1084#1077#1085#1090#1072' '#1076#1083#1103' '#1101#1082#1089#1087#1086#1088#1090#1072
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label5: TLabel
        Left = 32
        Top = 55
        Width = 14
        Height = 15
        Caption = #1054#1090
      end
      object Label6: TLabel
        Left = 163
        Top = 55
        Width = 15
        Height = 15
        Caption = #1044#1086
      end
      object Label7: TLabel
        Left = 20
        Top = 207
        Width = 61
        Height = 15
        Caption = #1048#1079' '#1092#1080#1088#1084#1099
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label8: TLabel
        Left = 280
        Top = 207
        Width = 54
        Height = 15
        Caption = #1042' '#1092#1080#1088#1084#1099
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbProgressTitle: TLabel
        Left = 161
        Top = 278
        Width = 122
        Height = 15
        Caption = #1069#1082#1089#1087#1086#1088#1090' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074'...'
      end
      object btnGenDocs: TButton
        Left = 20
        Top = 265
        Width = 121
        Height = 40
        Caption = #1043#1077#1085#1077#1088#1080#1088#1086#1074#1072#1090#1100
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 11
        OnClick = btnGenDocsClick
      end
      object cbPostuplenia: TCheckBox
        Left = 32
        Top = 115
        Width = 109
        Height = 17
        Caption = #1055#1086#1089#1090#1091#1087#1083#1077#1085#1080#1103
        Checked = True
        State = cbChecked
        TabOrder = 2
      end
      object cbPeremeshenie: TCheckBox
        Left = 32
        Top = 138
        Width = 109
        Height = 17
        Caption = #1055#1077#1088#1077#1084#1077#1097#1077#1085#1080#1103
        Checked = True
        State = cbChecked
        TabOrder = 4
      end
      object cbRealizatia_SF: TCheckBox
        Left = 32
        Top = 161
        Width = 177
        Height = 17
        Caption = #1056#1077#1072#1083#1080#1079#1072#1094#1080#1103': '#1057#1095#1077#1090'-'#1092#1072#1082#1090#1091#1088#1099
        Checked = True
        State = cbChecked
        TabOrder = 6
      end
      object cbRealizatia_Cek: TCheckBox
        Left = 343
        Top = 115
        Width = 176
        Height = 17
        Caption = 'Ordine de incasare in numarar'
        Checked = True
        State = cbChecked
        TabOrder = 3
      end
      object ccbFirmaStart: TcxCheckComboBox
        Left = 20
        Top = 184
        Properties.EmptySelectionText = #1048#1079' '#1074#1089#1077#1093' '#1092#1080#1088#1084
        Properties.DropDownRows = 16
        Properties.EditValueFormat = cvfIndices
        Properties.Items = <>
        Properties.ReadOnly = False
        TabOrder = 7
        Width = 229
      end
      object ccbFirmaEnd: TcxCheckComboBox
        Left = 280
        Top = 184
        Properties.EmptySelectionText = #1042#1086' '#1074#1089#1077' '#1092#1080#1088#1084#1099'/'#1082#1086#1085#1090#1088#1072#1075#1077#1085#1090#1099
        Properties.DropDownRows = 16
        Properties.EditValueFormat = cvfIndices
        Properties.Items = <>
        TabOrder = 8
        Width = 229
      end
      object pbProgress: TProgressBar
        Left = 161
        Top = 278
        Width = 348
        Height = 19
        TabOrder = 12
      end
      object cbDocList: TCheckBox
        Left = 20
        Top = 231
        Width = 285
        Height = 17
        Caption = #1069#1082#1089#1087#1086#1088#1090#1080#1088#1086#1074#1072#1090#1100' '#1090#1086#1083#1100#1082#1086' '#1085#1077#1082#1086#1090#1086#1088#1099#1077' '#1076#1086#1082#1091#1084#1077#1085#1090#1099
        TabOrder = 10
        OnClick = cbDocListClick
      end
      object edDocList: TcxTextEdit
        Left = 311
        Top = 228
        TabOrder = 9
        Width = 198
      end
      object dtpDataStart: TcxDateEdit
        Left = 52
        Top = 52
        EditValue = 40932.4213232176d
        Properties.DisplayFormat = 'dd.mm.yyyy'
        TabOrder = 0
        Width = 89
      end
      object dtpDataEnd: TcxDateEdit
        Left = 183
        Top = 52
        EditValue = 40932.4213232176d
        Properties.DisplayFormat = 'dd.mm.yyyy'
        TabOrder = 1
        Width = 86
      end
      object CheckBox1: TCheckBox
        Left = 343
        Top = 138
        Width = 176
        Height = 17
        Caption = 'Dispozitie de plata in numarar'
        Checked = True
        State = cbChecked
        TabOrder = 5
      end
    end
    object TabSheet1: TTabSheet
      Caption = #1054#1089#1090#1072#1090#1082#1080
      object Label3: TLabel
        Left = 20
        Top = 20
        Width = 94
        Height = 15
        Caption = #1054#1089#1090#1072#1090#1082#1080' '#1090#1086#1074#1072#1088#1086#1074'.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object Label10: TLabel
        Left = 20
        Top = 132
        Width = 167
        Height = 15
        Caption = #1054#1089#1090#1072#1090#1082#1080' '#1090#1086#1074#1072#1088#1086#1074' '#1080#1079' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object btnGenerate: TButton
        Left = 20
        Top = 47
        Width = 117
        Height = 29
        Caption = #1043#1077#1085#1077#1088#1080#1088#1086#1074#1072#1090#1100
        TabOrder = 0
        OnClick = btnGenerateClick
      end
      object edOstatkiDocID: TEdit
        Left = 20
        Top = 149
        Width = 189
        Height = 23
        TabOrder = 2
      end
      object btnOstatkiDoc: TButton
        Left = 220
        Top = 146
        Width = 113
        Height = 29
        Caption = #1043#1077#1085#1077#1088#1080#1088#1086#1074#1072#1090#1100
        TabOrder = 1
        OnClick = btnOstatkiDocClick
      end
    end
    object tbsErrors: TTabSheet
      Caption = #1054#1096#1080#1073#1082#1080
      ImageIndex = 2
      object Label9: TLabel
        AlignWithMargins = True
        Left = 4
        Top = 4
        Width = 526
        Height = 15
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Align = alTop
        Caption = 
          #1044#1086#1082#1091#1084#1077#1085#1090#1099' '#1082#1086#1090#1086#1088#1099#1077' '#1085#1077' '#1089#1086#1086#1090#1074#1077#1090#1089#1074#1091#1102#1090' '#1082#1088#1080#1090#1077#1088#1080#1102' '#1101#1082#1089#1087#1086#1088#1090#1072'. '#1056#1072#1079#1073#1077#1088#1080#1090#1080#1089#1100 +
          ' '#1089' '#1085#1080#1084#1080'.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        ExplicitWidth = 438
      end
      object cxGridErrors: TcxGrid
        Left = 0
        Top = 23
        Width = 534
        Height = 300
        Align = alClient
        TabOrder = 0
        object cxGridErrorsTable: TcxGridTableView
          OnKeyDown = cxGridErrorsTableKeyDown
          OptionsBehavior.CopyCaptionsToClipboard = False
          OptionsBehavior.IncSearch = True
          OptionsBehavior.CopyPreviewToClipboard = False
          OptionsBehavior.ImmediateEditor = False
          OptionsCustomize.ColumnFiltering = False
          OptionsCustomize.ColumnSorting = False
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.MultiSelect = True
          OptionsSelection.CellMultiSelect = True
          OptionsSelection.InvertSelect = False
          OptionsView.CellEndEllipsis = True
          OptionsView.ScrollBars = ssVertical
          OptionsView.ColumnAutoWidth = True
          OptionsView.GridLineColor = 13750737
          OptionsView.GroupByBox = False
          OptionsView.GroupRowStyle = grsOffice11
          Styles.Header = dmAdditions.cxStyle_GridHeader
          object cxGridErrors_DOCID: TcxGridColumn
            Caption = 'DocID'
            DataBinding.ValueType = 'Integer'
            MinWidth = 50
            Options.HorzSizing = False
            Width = 50
          end
          object cxGridErrors_DT: TcxGridColumn
            Caption = #1060#1080#1088#1084#1072
          end
          object cxGridErrors_CT: TcxGridColumn
            Caption = #1050#1086#1085#1090#1088#1072#1075#1077#1085#1090
          end
          object cxGridErrors_SUMA: TcxGridColumn
            Caption = #1057#1091#1084#1084#1072
            DataBinding.ValueType = 'Float'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = '0.00'
            HeaderAlignmentHorz = taCenter
            MinWidth = 70
            Options.HorzSizing = False
            Width = 70
          end
          object cxGridErrors_CREATEDBY: TcxGridColumn
            Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
            Width = 50
          end
          object cxGridErrors_ERROR: TcxGridColumn
            GroupIndex = 0
          end
        end
        object cxGridErrorsLevel: TcxGridLevel
          GridView = cxGridErrorsTable
        end
      end
    end
  end
  object btnClose: TButton
    Left = 441
    Top = 448
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1047#1072#1082#1088#1099#1090#1100
    ModalResult = 2
    TabOrder = 2
    ExplicitTop = 438
  end
  object cbTestOnly: TCheckBox
    Left = 8
    Top = 427
    Width = 141
    Height = 17
    Anchors = [akLeft, akBottom]
    Caption = #1056#1077#1078#1080#1084' '#1090#1077#1089#1090#1080#1088#1086#1074#1072#1085#1080#1103
    TabOrder = 3
  end
  object cxButton1: TcxButton
    Left = 272
    Top = 448
    Width = 154
    Height = 29
    Caption = #1069#1082#1089#1087#1086#1088#1090#1080#1088#1086#1074#1072#1090#1100' '#1074' Excel'
    TabOrder = 4
  end
  object IBCQueryOst: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT DISTINCT'
      ''
      'TS_CUST_1C.FIRMA_COD,'
      'TS_CUST_1C.FIRMA_NAME,'
      'TS_CUST_INFO.IDEN_NUMBER,'
      'TS_CUST_INFO.VAT_NUMBER,'
      'TS_CUST_INFO.ADDRESS2,'
      'TS_CUST_INFO.TELEFON1,'
      'TS_CUST_1C.SKLAD_COD,'
      'TS_CUST_1C.TITLE SKLAD_TITLE,'
      'TS_CUST_1C.TYPE SKLAD_TYPE,'
      ''
      'TS_GOODS.GOODS_ACNT_ID,'
      'TS_GOODS_ACNT.NAMEACNT,'
      'ROUND(J.PRICE - J.PRICE / 6, 2), -- fara TVA'
      'J.QTY,'
      'ROUND(J.PRICE - J.PRICE / 6, 2) * J.QTY SUMA,'
      'IIF(TS_GOODS.GOODS_TYPE_ID IN (4202, 4204), 1, 0) SERVICIU,'
      'TS_GOODS.UMID,'
      'TS_UM.TITLE'
      ''
      'FROM TDB_JURNAL J'
      'INNER JOIN TDB_DOCS D ON D.DOCID = J.DOCID'
      'INNER JOIN TS_GOODS ON (TS_GOODS.GOODSID = J.GOODSID)'
      
        'INNER JOIN TS_GOODS_ACNT ON (TS_GOODS_ACNT.GOODS_ACNT_ID = TS_GO' +
        'ODS.GOODS_ACNT_ID)'
      'INNER JOIN TS_UM ON (TS_UM.UMID = TS_GOODS.UMID)'
      ''
      'INNER JOIN TS_CUST_1C ON (TS_CUST_1C.CUSTOMERID = D.DT)'
      'INNER JOIN TS_CUSTOMER ON (TS_CUSTOMER.CUSTOMERID = D.DT)'
      
        'INNER JOIN TS_CUST_INFO ON (TS_CUST_INFO.CUSTOMERID = TS_CUSTOME' +
        'R.CUSTOMERID)'
      ''
      'ORDER BY TS_CUST_1C.FIRMA_COD, TS_CUST_1C.SKLAD_COD')
    Left = 44
    Top = 656
  end
  object IBCQuerySF: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      '/* Scet-Facturi */'
      'SELECT'
      '      DOCID,'
      '      FACTURANO,'
      '      DATA_ELIBERARII,'
      '      FIRMA_COD,'
      '      FIRMA_NAME,'
      ''
      '      DT_IDEN_NUMBER,'
      '      DT_VAT_NUMBER,'
      ''
      '      DT_SKLAD_COD,'
      '      DT_SKLAD_TITLE,'
      '      DT_SKLAD_TYPE,'
      ''
      '      CT_IDEN_NUMBER,'
      '      CT_DISPLAYNAME,'
      '      CT_ADDRESS,'
      '      CT_ADDRESS2,'
      '      CT_FLG_NOTREZIDENT,'
      '      CT_VAT_NUMBER,'
      '      CT_FLG_JURIDIC,'
      '      VAT,'
      '      DATA,'
      '      DT,'
      '      CT'
      
        'FROM SP_EXPORT1C_SF(:DATA1,:DATA2,:DT,:CT,:DOCLIST,:FLG_NO_FILTE' +
        'R)')
    Left = 88
    Top = 196
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DATA1'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'DATA2'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'DT'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'CT'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'DOCLIST'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'FLG_NO_FILTER'
        Value = nil
      end>
  end
  object IBCQueryJurnal: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      '/* Goods */'
      'SELECT'
      ''
      'TDB_JURNAL.GOODSID,'
      'TS_GOODS_ACNT.GOODS_ACNT_ID,'
      'TDB_JURNAL.QTY,'
      'TDB_JURNAL.SUMA,'
      'TS_GOODS_ACNT.NAMEACNT,'
      'IIF(TS_GOODS.GOODS_TYPE_ID IN (4202,4204),1,0) FLG_SERVICIU,'
      'TS_UM.UMID,'
      'TS_UM.TITLE,'
      'Round(TDB_JURNAL.SUMAVAT,2)'
      ''
      'FROM TDB_JURNAL'
      ''
      'INNER JOIN TS_GOODS ON (TS_GOODS.GOODSID=TDB_JURNAL.GOODSID)'
      
        'INNER JOIN TS_GOODS_ACNT ON (TS_GOODS_ACNT.GOODS_ACNT_ID=TS_GOOD' +
        'S.GOODS_ACNT_ID)'
      'INNER JOIN TS_UM ON (TS_UM.UMID=TS_GOODS.UMID)'
      ''
      'WHERE TDB_JURNAL.DOCID=:DOCID')
    Left = 328
    Top = 708
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DOCID'
        Value = nil
      end>
  end
  object IBCQueryP: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      '/* Peremeshenie */'
      'SELECT'
      '      DOCID,'
      '      DATA,'
      '      FIRMA_COD,'
      '      FIRMA_NAME,'
      ''
      '      DT_IDEN_NUMBER,'
      '      DT_VAT_NUMBER,'
      ''
      '      DT_SKLAD_COD,'
      '      DT_SKLAD_TITLE,'
      '      DT_SKLAD_TYPE,'
      ''
      '      CT_SKLAD_COD,'
      '      CT_SKLAD_TITLE,'
      '      CT_SKLAD_TYPE'
      ''
      'FROM SP_EXPORT1C_PEREMESH(:DATA1,:DATA2,:DT,:CT,:DOCLIST)')
    Left = 332
    Top = 660
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DATA1'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'DATA2'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'DT'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'CT'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'DOCLIST'
        Value = nil
      end>
  end
  object IBCQueryPrihod: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      '/* Prihod */'
      'SELECT'
      '      DOCID,'
      '      FACTURANO,'
      '      DATA_ELIBERARII,'
      '      FIRMA_COD,'
      '      FIRMA_NAME,'
      ''
      '      DT_IDEN_NUMBER,'
      '      DT_VAT_NUMBER,'
      ''
      '      DT_SKLAD_COD,'
      '      DT_SKLAD_TITLE,'
      '      DT_SKLAD_TYPE,'
      ''
      '      CT_IDEN_NUMBER,'
      '      CT_DISPLAYNAME,'
      '      CT_ADDRESS,'
      '      CT_ADDRESS2,'
      '      CT_FLG_NOTREZIDENT,'
      '      CT_VAT_NUMBER,'
      '      CT_FLG_JURIDIC'
      ''
      'FROM SP_EXPORT1C_PRIHOD(:DATA1,:DATA2,:DT,:CT,:DOCLIST)')
    Left = 236
    Top = 660
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DATA1'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'DATA2'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'DT'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'CT'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'DOCLIST'
        Value = nil
      end>
  end
  object IBCQuerySF_Goods: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      '/* Goods for receipt */'
      'SELECT'
      ''
      'A.GOODSID,'
      'A.GOODS_ACNT_ID,'
      'A.QTY,'
      'A.SUMA,'
      'A.NAMEACNT,'
      
        'IIF (TS_GOODS.GOODS_TYPE_ID in (select syssid from ts_syss s whe' +
        're s.parentid=6 and s.value_str='#39'S'#39'), 1, 0) FLG_SERVICIU,'
      'TS_UM.UMID,'
      'TS_UM.TITLE,'
      'Round(A.SUMAVAT,2) SUMAVAT,'
      'IIF(TS_GOODS.GOODS_TYPE_ID IN (4203,4212),1,0) FLG_COMPLECT'
      ''
      'FROM GET_GOODS_FOR_RECEIPT(:DOCID) A'
      ''
      'INNER JOIN TS_GOODS ON (TS_GOODS.GOODSID = A.GOODSID)'
      'INNER JOIN TS_UM ON (TS_UM.UMID = TS_GOODS.UMID)')
    Left = 88
    Top = 244
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DOCID'
        Value = nil
      end>
  end
  object IBCQueryReceipt: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      '/* Cecuri */'
      'SELECT'
      '      DT,'
      '      DATA,'
      '      FIRMA_COD,'
      '      FIRMA_NAME,'
      ''
      '      DT_IDEN_NUMBER,'
      '      DT_VAT_NUMBER,'
      ''
      '      DT_SKLAD_COD,'
      '      DT_SKLAD_TITLE,'
      '      DT_SKLAD_TYPE,'
      '      DT_PERS_FIZ_COD,'
      '      DT_PERS_FIZ_TITLE'
      ''
      
        'FROM SP_EXPORT1C_CEK(:DATA1,:DATA2,:DT,:CT,:DOCLIST,:FLG_NO_FILT' +
        'ER)')
    Left = 408
    Top = 192
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DATA1'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'DATA2'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'DT'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'CT'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'DOCLIST'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'FLG_NO_FILTER'
        Value = nil
      end>
  end
  object IBCQueryReceiptGoods: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      '/* Goods for receipt */'
      'SELECT'
      'GOODSID,'
      'GOODS_ACNT_ID,'
      'QTY,'
      'SUMA,'
      'NAMEACNT,'
      'FLG_SERVICIU,'
      'UMID,'
      'UM_TITLE,'
      'SUMAVAT,'
      'DOCID,'
      'FLG_COMPLECT'
      ''
      
        'FROM SP_1C_GOODS_RECEIPT(:FIRMA, :DATA, :DOCLIST, :FLG_NO_FILTER' +
        ')')
    Left = 408
    Top = 240
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'FIRMA'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'DATA'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'DOCLIST'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'FLG_NO_FILTER'
        Value = nil
      end>
  end
  object IBCQueryOstDoc: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT'
      ''
      '       TS_CUST_1C.FIRMA_COD,'
      '       TS_CUST_1C.FIRMA_NAME,'
      '       TS_CUST_INFO.IDEN_NUMBER,'
      '       TS_CUST_INFO.VAT_NUMBER,'
      '       TS_CUST_INFO.ADDRESS2,'
      '       TS_CUST_INFO.TELEFON1,'
      '       TS_CUST_1C.SKLAD_COD,'
      '       TS_CUST_1C.TITLE SKLAD_TITLE,'
      '       TS_CUST_1C.TYPE SKLAD_TYPE,'
      ''
      '       TS_GOODS_ACNT.GOODS_ACNT_ID,'
      '       TS_GOODS_ACNT.NAMEACNT,'
      '       ROUND(TDB_JURNAL.PRICE*0.8, 2), -- fara TVA'
      '       TDB_JURNAL.QTY,'
      '       ROUND(TDB_JURNAL.PRICE*0.8, 2) * TDB_JURNAL.QTY,'
      
        '       IIF(TS_GOODS.GOODS_TYPE_ID IN (4202, 4204), 1, 0) SERVICI' +
        'U,'
      '       TS_GOODS.UMID,'
      '       TS_UM.TITLE'
      ''
      'FROM TDB_JURNAL'
      ''
      'INNER JOIN TDB_DOCS ON (TDB_DOCS.DOCID = TDB_JURNAL.DOCID)'
      'INNER JOIN TS_CUST_1C ON (TS_CUST_1C.CUSTOMERID = TDB_DOCS.DT)'
      'INNER JOIN TS_CUSTOMER ON (TS_CUSTOMER.CUSTOMERID = TDB_DOCS.DT)'
      
        'INNER JOIN TS_CUST_INFO ON (TS_CUST_INFO.CUSTOMERID = TS_CUSTOME' +
        'R.CUSTOMERID)'
      ''
      'INNER JOIN TS_GOODS ON (TS_GOODS.GOODSID = TDB_JURNAL.GOODSID)'
      
        'INNER JOIN TS_GOODS_ACNT ON (TS_GOODS_ACNT.GOODS_ACNT_ID = TS_GO' +
        'ODS.GOODS_ACNT_ID)'
      'INNER JOIN TS_UM ON (TS_UM.UMID = TS_GOODS.UMID)'
      ''
      'WHERE TDB_JURNAL.DOCID = :DOCID')
    Left = 44
    Top = 708
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DOCID'
        Value = nil
      end>
  end
  object IBCQueryPrinhodInfo: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      '/* info for DT si CT (Prihod) */'
      'SELECT'
      '      FIRMA_COD,'
      '      FIRMA_NAME,'
      '      DT_IDEN_NUMBER,'
      '      DT_VAT_NUMBER,'
      '      DT_SKLAD_COD,'
      '      DT_SKLAD_TITLE,'
      '      DT_SKLAD_TYPE,'
      ''
      '      CT_IDEN_NUMBER,'
      '      CT_DISPLAYNAME,'
      '      CT_ADDRESS,'
      '      CT_ADDRESS2,'
      '      CT_FLG_NOTREZIDENT,'
      '      CT_VAT_NUMBER,'
      '      CT_FLG_JURIDIC'
      ''
      'FROM SP_GET_PRIHOD_INFO(:DT,:CT)')
    Left = 408
    Top = 320
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DT'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'CT'
        Value = nil
      end>
  end
  object IBCQuerySF_Complecte: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      '/* Scet-Facturi care au produse in complecte */'
      'SELECT'
      '      DOCID,'
      '      FACTURANO,'
      '      DATA_ELIBERARII,'
      '      FIRMA_COD,'
      '      FIRMA_NAME,'
      ''
      '      DT_IDEN_NUMBER,'
      '      DT_VAT_NUMBER,'
      ''
      '      DT_SKLAD_COD,'
      '      DT_SKLAD_TITLE,'
      '      DT_SKLAD_TYPE,'
      ''
      '      CT_IDEN_NUMBER,'
      '      CT_DISPLAYNAME,'
      '      CT_ADDRESS,'
      '      CT_ADDRESS2,'
      '      CT_FLG_NOTREZIDENT,'
      '      CT_VAT_NUMBER,'
      '      CT_FLG_JURIDIC,'
      '      VAT,'
      '      DATA,'
      '      DT,'
      '      CT'
      
        'FROM SP_EXPORT1C_SF_COMPLECTE(:DATA1,:DATA2,:DT,:CT,:DOCLIST,:FL' +
        'G_NO_FILTER)')
    Left = 248
    Top = 196
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DATA1'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'DATA2'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'DT'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'CT'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'DOCLIST'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'FLG_NO_FILTER'
        Value = nil
      end>
  end
  object IBCQuerySF_ComplecteGoods: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      '/* Goods for receipt */'
      'SELECT'
      ''
      'A.GOODSID,'
      'A.GOODS_ACNT_ID,'
      'A.QTY,'
      'A.SUMA,'
      'A.NAMEACNT,'
      
        'IIF (TS_GOODS.GOODS_TYPE_ID in (select syssid from ts_syss s whe' +
        're s.parentid=6 and s.value_str='#39'S'#39'), 1, 0) FLG_SERVICIU,'
      'TS_UM.UMID,'
      'TS_UM.UMID,'
      'TS_UM.TITLE,'
      'Round(A.SUMAVAT,2) SUMAVAT,'
      'A.FLG_COMPLECT'
      ''
      'FROM SP_EXPORT1C_SF_COMPLECTE_GOODS(:DOCID) A'
      ''
      'INNER JOIN TS_GOODS ON (TS_GOODS.GOODSID = A.GOODSID)'
      'INNER JOIN TS_UM ON (TS_UM.UMID = TS_GOODS.UMID)')
    Left = 248
    Top = 248
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DOCID'
        Value = nil
      end>
  end
end
