object frmServiceRequestWarrantyDescriptionDlg: TfrmServiceRequestWarrantyDescriptionDlg
  Left = 0
  Top = 0
  ActiveControl = lcbCERTIFICAT_TIP
  BorderStyle = bsDialog
  Caption = #1054#1087#1080#1089#1072#1085#1080#1077' '#1079#1072#1103#1074#1082#1080' '#1085#1072' '#1075#1072#1088#1072#1085#1090#1080#1081#1085#1099#1081' '#1088#1077#1084#1086#1085#1090
  ClientHeight = 589
  ClientWidth = 717
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
    Width = 717
    Height = 64
    Title = #1054#1087#1080#1089#1072#1085#1080#1077' '#1079#1072#1103#1074#1082#1080' '#1085#1072' '#1075#1072#1088#1072#1085#1090#1080#1081#1085#1099#1081' '#1088#1077#1084#1086#1085#1090
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
    ImageIndex = 10
  end
  object pnCleint: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 701
    Height = 465
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    ShowCaption = False
    TabOrder = 1
    object Label1: TLabel
      Left = 20
      Top = 24
      Width = 287
      Height = 15
      Caption = #1055#1088#1080#1077#1084' '#1090#1086#1074#1072#1088#1072' '#1086#1089#1091#1097#1077#1089#1090#1074#1083#1103#1077#1090#1089#1103' '#1085#1072' '#1073#1072#1079#1077' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 20
      Top = 77
      Width = 13
      Height = 15
      Caption = #8470
    end
    object Label3: TLabel
      Left = 180
      Top = 77
      Width = 12
      Height = 15
      Caption = #1086#1090
    end
    object Label4: TLabel
      Left = 20
      Top = 127
      Width = 119
      Height = 15
      Caption = #1062#1077#1083#1100' '#1087#1088#1080#1105#1084#1072' '#1090#1086#1074#1072#1088#1072
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 20
      Top = 240
      Width = 127
      Height = 15
      Caption = #1050#1086#1084#1087#1083#1077#1082#1090#1072#1094#1080#1103' '#1090#1086#1074#1072#1088#1072
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label6: TLabel
      Left = 336
      Top = 24
      Width = 230
      Height = 15
      Caption = #1044#1077#1092#1077#1082#1090#1099' '#1087#1088#1077#1076#1100#1103#1074#1083#1077#1085#1085#1099' '#1087#1086#1090#1088#1077#1073#1080#1090#1077#1083#1077#1084
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label7: TLabel
      Left = 336
      Top = 127
      Width = 186
      Height = 15
      Caption = #1044#1077#1092#1077#1082#1090#1099' '#1074#1085#1077#1096#1085#1077#1075#1086' '#1074#1080#1076#1072' '#1090#1086#1074#1072#1088#1072
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label8: TLabel
      Left = 336
      Top = 240
      Width = 233
      Height = 15
      Caption = #1055#1088#1077#1076#1074#1072#1088#1080#1090#1077#1083#1100#1085#1099#1081' '#1090#1077#1093#1085#1080#1095#1077#1089#1082#1080#1081' '#1086#1089#1084#1086#1090#1088
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lcbCERTIFICAT_TIP: TcxDBLookupComboBox
      Left = 20
      Top = 45
      DataBinding.DataField = 'CERTIFICAT_TIP'
      DataBinding.DataSource = IBCDataSourceInfo
      Properties.DropDownListStyle = lsFixedList
      Properties.KeyFieldNames = 'CERTIFICAT_TIP'
      Properties.ListColumns = <
        item
          FieldName = 'TITLE_RUS'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = IBCDataSourceCTYPES
      TabOrder = 0
      Width = 287
    end
    object deCERTIFICAT_DATA: TcxDBDateEdit
      Left = 198
      Top = 74
      DataBinding.DataField = 'CERTIFICAT_DATA'
      DataBinding.DataSource = IBCDataSourceInfo
      Properties.DateButtons = [btnToday]
      Properties.SaveTime = False
      Properties.ShowTime = False
      TabOrder = 3
      Width = 109
    end
    object edCERTIFICAT_NUMAR: TcxDBTextEdit
      Left = 39
      Top = 74
      DataBinding.DataField = 'CERTIFICAT_NUMAR'
      DataBinding.DataSource = IBCDataSourceInfo
      Properties.CharCase = ecUpperCase
      TabOrder = 2
      Width = 121
    end
    object clbFLAGS_SCOP: TcxDBCheckListBox
      Left = 20
      Top = 148
      Width = 287
      Height = 61
      DataBinding.DataSource = IBCDataSourceInfo
      DataBinding.DataField = 'FLAGS_SCOP'
      Items = <
        item
          Tag = 1
          Text = #1041#1077#1089#1087#1083#1072#1090#1085#1086#1077' '#1091#1089#1090#1088#1072#1085#1077#1085#1080#1077' '#1085#1077#1087#1086#1083#1072#1076#1086#1082' ('#1088#1077#1084#1086#1085#1090')'
        end
        item
          Tag = 2
          Text = #1055#1083#1072#1085#1086#1074#1086#1077' '#1090#1077#1093#1085#1080#1095#1077#1089#1082#1086#1077' '#1086#1073#1089#1083#1091#1078#1080#1074#1072#1085#1080#1077
        end
        item
          Tag = 4
          Text = #1042#1086#1079#1074#1088#1072#1090
        end>
      ParentColor = False
      TabOrder = 4
    end
    object clbFLAGS_COMPLECTINFO: TcxDBCheckListBox
      Left = 20
      Top = 261
      Width = 287
      Height = 172
      DataBinding.DataSource = IBCDataSourceInfo
      DataBinding.DataField = 'FLAGS_COMPLECTINFO'
      Items = <
        item
          Tag = 1
          Text = #1050#1086#1088#1086#1073#1082#1072
        end
        item
          Tag = 2
          Text = #1059#1087#1072#1082#1086#1074#1082#1072
        end
        item
          Tag = 4
          Text = #1057#1091#1084#1082#1072
        end
        item
          Tag = 8
          Text = #1048#1085#1089#1090#1088#1091#1082#1094#1080#1103' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
        end
        item
          Tag = 16
          Text = #1050#1072#1073#1077#1083#1100' '#1087#1080#1090#1072#1085#1080#1103
        end
        item
          Tag = 32
          Text = #1050#1072#1073#1077#1083#1100' '#1076#1072#1085#1085#1099#1093
        end
        item
          Tag = 64
          Text = #1047#1072#1088#1103#1076#1085#1086#1077' '#1091#1089#1090#1088#1086#1081#1089#1090#1074#1086' ('#1041#1083#1086#1082' '#1087#1084#1090#1072#1085#1080#1103')'
        end
        item
          Tag = 128
          Text = #1040#1082#1082#1091#1084#1091#1083#1103#1090#1086#1088' ('#1041#1072#1090#1072#1088#1077#1103')'
        end
        item
          Tag = 256
          Text = 'Plcu'#539#259' spate metal al pl'#259'cii de baz'#259
        end
        item
          Tag = 512
          Text = 'CD '#1089' '#1076#1088#1072#1081#1074#1077#1088#1072#1084#1080
        end
        item
          Tag = 1024
          Text = 'CD '#1089' '#1087#1088#1086#1075#1088#1072#1084#1085#1099#1084' '#1086#1073#1077#1089#1087#1077#1095#1077#1085#1080#1077#1084
        end>
      ParentColor = False
      TabOrder = 6
    end
    object mmDEFECTE_PRESUPUSE: TcxDBMemo
      Left = 336
      Top = 45
      DataBinding.DataField = 'DEFECTE_PRESUPUSE'
      DataBinding.DataSource = IBCDataSourceInfo
      TabOrder = 1
      Height = 52
      Width = 337
    end
    object mmDEFECTE_ESTETITE: TcxDBMemo
      Left = 336
      Top = 148
      DataBinding.DataField = 'DEFECTE_ESTETITE'
      DataBinding.DataSource = IBCDataSourceInfo
      TabOrder = 5
      Height = 61
      Width = 337
    end
    object mmEXAMINAREA_PREVENTIVA: TcxDBMemo
      Left = 336
      Top = 261
      DataBinding.DataField = 'EXAMINAREA_PREVENTIVA'
      DataBinding.DataSource = IBCDataSourceInfo
      TabOrder = 7
      Height = 172
      Width = 337
    end
  end
  object btnOk: TButton
    Left = 500
    Top = 548
    Width = 90
    Height = 29
    Caption = #1047#1072#1087#1080#1089#1072#1090#1100
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 600
    Top = 548
    Width = 90
    Height = 29
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
  object IBCQueryInfo: TIBCQuery
    SQLInsert.Strings = (
      'INSERT INTO TDB_DOC_125INFO'
      
        '  (DOCID, CERTIFICAT_TIP, CERTIFICAT_NUMAR, CERTIFICAT_DATA, FLA' +
        'GS_SCOP, FLAGS_COMPLECTINFO, DEFECTE_PRESUPUSE, DEFECTE_ESTETITE' +
        ', EXAMINAREA_PREVENTIVA)'
      'VALUES'
      
        '  (:DOCID, :CERTIFICAT_TIP, :CERTIFICAT_NUMAR, :CERTIFICAT_DATA,' +
        ' :FLAGS_SCOP, :FLAGS_COMPLECTINFO, :DEFECTE_PRESUPUSE, :DEFECTE_' +
        'ESTETITE, :EXAMINAREA_PREVENTIVA)')
    SQLUpdate.Strings = (
      'UPDATE TDB_DOC_125INFO'
      'SET'
      
        '  DOCID = :DOCID, CERTIFICAT_TIP = :CERTIFICAT_TIP, CERTIFICAT_N' +
        'UMAR = :CERTIFICAT_NUMAR, CERTIFICAT_DATA = :CERTIFICAT_DATA, FL' +
        'AGS_SCOP = :FLAGS_SCOP, FLAGS_COMPLECTINFO = :FLAGS_COMPLECTINFO' +
        ', DEFECTE_PRESUPUSE = :DEFECTE_PRESUPUSE, DEFECTE_ESTETITE = :DE' +
        'FECTE_ESTETITE, EXAMINAREA_PREVENTIVA = :EXAMINAREA_PREVENTIVA'
      'WHERE'
      '  DOCID = :Old_DOCID')
    SQLLock.Strings = (
      'SELECT NULL FROM TDB_DOC_125INFO'
      'WHERE'
      'DOCID = :Old_DOCID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT'
      '*'
      'FROM TDB_DOC_125INFO')
    MasterFields = 'DOCID'
    DetailFields = 'DOCID'
    AutoCommit = False
    Options.RequiredFields = False
    LocalConstraints = False
    Left = 444
    Top = 388
  end
  object IBCDataSourceInfo: TIBCDataSource
    DataSet = IBCQueryInfo
    Left = 444
    Top = 436
  end
  object IBCQueryCTYPES: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      'SELECT'
      ' CERTIFICAT_TIP,'
      ' TITLE_RUS'
      'FROM '
      ' TS_DOC125_CTYPES'
      'ORDER BY'
      ' CERTIFICAT_TIP')
    Left = 560
    Top = 368
  end
  object IBCDataSourceCTYPES: TIBCDataSource
    DataSet = IBCQueryCTYPES
    Left = 560
    Top = 420
  end
end
