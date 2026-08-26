object frmApiConfigDlg: TfrmApiConfigDlg
  Left = 0
  Top = 0
  Caption = 'Configurari API'
  ClientHeight = 520
  ClientWidth = 1000
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  DesignSize = (
    1000
    520)
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 1000
    Height = 64
    Title = 'Configurari API'
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
    ImageIndex = 16
  end
  object pnTop: TPanel
    Left = 0
    Top = 64
    Width = 1000
    Height = 36
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object lbHint: TLabel
      Left = 8
      Top = 10
      Width = 560
      Height = 15
      Caption =
        'Un rand = un parametru al unui API, identificat prin (Cod API, Pa' +
        'rametru). Modificarile se salveaza la OK.'
    end
    object chkShowSecrets: TcxCheckBox
      Left = 790
      Top = 6
      Caption = 'Arata valorile ascunse'
      Properties.OnChange = chkShowSecretsPropertiesChange
      TabOrder = 0
      Transparent = True
      Width = 190
    end
  end
  object cxGridConfig: TcxGrid
    Left = 8
    Top = 108
    Width = 984
    Height = 356
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 1
    object cxGridConfigTable: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = IBCDataSourceConfig
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      object colCONFIGID: TcxGridDBColumn
        DataBinding.FieldName = 'CONFIGID'
        Visible = False
      end
      object colAPI_CODE: TcxGridDBColumn
        Caption = 'Cod API'
        DataBinding.FieldName = 'API_CODE'
        Width = 120
      end
      object colPARAM_NAME: TcxGridDBColumn
        Caption = 'Parametru'
        DataBinding.FieldName = 'PARAM_NAME'
        Width = 130
      end
      object colPARAM_VALUE: TcxGridDBColumn
        Caption = 'Valoare'
        DataBinding.FieldName = 'PARAM_VALUE'
        OnGetDataText = colPARAM_VALUEGetDataText
        Width = 280
      end
      object colSUPPLIERID: TcxGridDBColumn
        Caption = 'Furnizor'
        DataBinding.FieldName = 'SUPPLIERID'
        Width = 80
      end
      object colFLG_ACTIVE: TcxGridDBColumn
        Caption = 'Activ'
        DataBinding.FieldName = 'FLG_ACTIVE'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueGrayed = 0
        Properties.ValueUnchecked = 0
        Width = 50
      end
      object colNOTE: TcxGridDBColumn
        Caption = 'Nota'
        DataBinding.FieldName = 'NOTE'
        Width = 200
      end
      object colUPDATED_AT: TcxGridDBColumn
        Caption = 'Modificat la'
        DataBinding.FieldName = 'UPDATED_AT'
        Options.Editing = False
        Width = 130
      end
      object colUPDATED_BY: TcxGridDBColumn
        Caption = 'Modificat de'
        DataBinding.FieldName = 'UPDATED_BY'
        Options.Editing = False
        Width = 120
      end
    end
    object cxGridConfigLevel: TcxGridLevel
      GridView = cxGridConfigTable
    end
  end
  object btnAdd: TcxButton
    Left = 8
    Top = 476
    Width = 120
    Height = 31
    Anchors = [akLeft, akBottom]
    Caption = 'Adauga'
    TabOrder = 2
    OnClick = btnAddClick
  end
  object btnDelete: TcxButton
    Left = 134
    Top = 476
    Width = 100
    Height = 31
    Anchors = [akLeft, akBottom]
    Caption = 'Sterge'
    TabOrder = 3
    OnClick = btnDeleteClick
  end
  object btnOk: TcxButton
    Left = 766
    Top = 476
    Width = 110
    Height = 31
    Anchors = [akRight, akBottom]
    Caption = 'Salveaza'
    Default = True
    ModalResult = 1
    TabOrder = 4
  end
  object btnCancel: TcxButton
    Left = 882
    Top = 476
    Width = 110
    Height = 31
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 5
  end
  object IBCQueryConfig: TIBCQuery
    KeyFields = 'CONFIGID'
    KeyGenerator = 'SQ_TS_API_CONFIG_ID'
    GeneratorMode = gmInsert
    SQLInsert.Strings = (
      'INSERT INTO TS_API_CONFIG'
      '  (CONFIGID, API_CODE, PARAM_NAME, PARAM_VALUE, SUPPLIERID,'
      '   FLG_ACTIVE, NOTE, UPDATED_BY)'
      'VALUES'
      '  (:CONFIGID, :API_CODE, :PARAM_NAME, :PARAM_VALUE, :SUPPLIERID,'
      '   :FLG_ACTIVE, :NOTE, :UPDATED_BY)')
    SQLDelete.Strings = (
      'DELETE FROM TS_API_CONFIG'
      'WHERE'
      '  CONFIGID = :Old_CONFIGID')
    SQLUpdate.Strings = (
      'UPDATE TS_API_CONFIG'
      'SET'
      '  API_CODE = :API_CODE, PARAM_NAME = :PARAM_NAME,'
      '  PARAM_VALUE = :PARAM_VALUE, SUPPLIERID = :SUPPLIERID,'
      '  FLG_ACTIVE = :FLG_ACTIVE, NOTE = :NOTE, UPDATED_BY = :UPDATED_BY'
      'WHERE'
      '  CONFIGID = :Old_CONFIGID')
    BeforePost = IBCQueryConfigBeforePost
    OnNewRecord = IBCQueryConfigNewRecord
    SQL.Strings = (
      'SELECT * FROM TS_API_CONFIG'
      'ORDER BY API_CODE, PARAM_NAME')
    AutoCommit = False
    Left = 48
    Top = 152
  end
  object IBCDataSourceConfig: TIBCDataSource
    DataSet = IBCQueryConfig
    Left = 128
    Top = 152
  end
  object IBCTransactionUpdate: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 208
    Top = 152
  end
end
