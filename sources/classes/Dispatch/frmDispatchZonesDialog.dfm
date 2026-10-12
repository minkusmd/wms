object frmDispatchZonesDlg: TfrmDispatchZonesDlg
  Left = 0
  Top = 0
  Caption = 'Zone logistice'
  ClientHeight = 480
  ClientWidth = 720
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 720
    Height = 64
    Title = 'Zone logistice'
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
  object cxGridZones: TcxGrid
    Left = 8
    Top = 72
    Width = 704
    Height = 352
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
    object cxGridZonesTable: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = IBCDataSourceZones
      DataController.KeyFieldNames = 'ZONEID'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.Inserting = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      object colZONEID: TcxGridDBColumn
        DataBinding.FieldName = 'ZONEID'
        Visible = False
      end
      object colCODE: TcxGridDBColumn
        Caption = 'Cod'
        DataBinding.FieldName = 'CODE'
        Width = 110
      end
      object colNAME: TcxGridDBColumn
        Caption = 'Denumirea'
        DataBinding.FieldName = 'NAME'
        Width = 200
      end
      object colORDERNO: TcxGridDBColumn
        Caption = 'Ordine'
        DataBinding.FieldName = 'ORDERNO'
        PropertiesClassName = 'TcxSpinEditProperties'
        Width = 60
      end
      object colFLG_ACTIVE: TcxGridDBColumn
        Caption = 'Activa'
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
        Width = 220
      end
    end
    object cxGridZonesLevel: TcxGridLevel
      GridView = cxGridZonesTable
    end
  end
  object btnAdd: TcxButton
    Left = 8
    Top = 436
    Width = 100
    Height = 31
    Anchors = [akLeft, akBottom]
    Caption = 'Adauga'
    TabOrder = 1
    OnClick = btnAddClick
  end
  object btnDelete: TcxButton
    Left = 114
    Top = 436
    Width = 100
    Height = 31
    Anchors = [akLeft, akBottom]
    Caption = 'Sterge'
    TabOrder = 2
    OnClick = btnDeleteClick
  end
  object btnOk: TcxButton
    Left = 486
    Top = 436
    Width = 110
    Height = 31
    Anchors = [akRight, akBottom]
    Caption = 'Salveaza'
    Default = True
    ModalResult = 1
    TabOrder = 3
  end
  object btnCancel: TcxButton
    Left = 602
    Top = 436
    Width = 110
    Height = 31
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 4
  end
  object IBCQueryZones: TIBCQuery
    KeyFields = 'ZONEID'
    KeyGenerator = 'SQ_TS_LOGISTIC_ZONE_ID'
    GeneratorMode = gmInsert
    SQLInsert.Strings = (
      'INSERT INTO TS_LOGISTIC_ZONE'
      '  (ZONEID, CODE, NAME, ORDERNO, FLG_ACTIVE, NOTE)'
      'VALUES'
      '  (:ZONEID, :CODE, :NAME, :ORDERNO, :FLG_ACTIVE, :NOTE)')
    SQLDelete.Strings = (
      'DELETE FROM TS_LOGISTIC_ZONE'
      'WHERE'
      '  ZONEID = :Old_ZONEID')
    SQLUpdate.Strings = (
      'UPDATE TS_LOGISTIC_ZONE'
      'SET'
      '  CODE = :CODE, NAME = :NAME, ORDERNO = :ORDERNO,'
      '  FLG_ACTIVE = :FLG_ACTIVE, NOTE = :NOTE'
      'WHERE'
      '  ZONEID = :Old_ZONEID')
    SQLRefresh.Strings = (
      'SELECT ZONEID, CODE, NAME, ORDERNO, FLG_ACTIVE, NOTE'
      'FROM TS_LOGISTIC_ZONE'
      'WHERE ZONEID = :ZONEID')
    BeforePost = IBCQueryZonesBeforePost
    OnNewRecord = IBCQueryZonesNewRecord
    SQL.Strings = (
      'SELECT ZONEID, CODE, NAME, ORDERNO, FLG_ACTIVE, NOTE'
      'FROM TS_LOGISTIC_ZONE'
      'ORDER BY ORDERNO, NAME')
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    AutoCommit = False
    Left = 48
    Top = 180
  end
  object IBCDataSourceZones: TIBCDataSource
    DataSet = IBCQueryZones
    Left = 128
    Top = 180
  end
  object IBCTransactionUpdate: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 208
    Top = 180
  end
end
