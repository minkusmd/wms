object frmDocumentStatesDlg: TfrmDocumentStatesDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Statutul documentelor'
  ClientHeight = 478
  ClientWidth = 909
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 41
    Top = 239
    Width = 104
    Height = 13
    Caption = 'Statutul documentului'
  end
  object Label2: TLabel
    Left = 41
    Top = 282
    Width = 55
    Height = 13
    Caption = 'Comentariu'
  end
  object cxDBMemo1: TcxDBMemo
    Left = 41
    Top = 301
    DataBinding.DataField = 'COMMENTS'
    DataBinding.DataSource = IBCDataSourceDocStates
    TabOrder = 0
    Height = 60
    Width = 304
  end
  object Button1: TButton
    Left = 343
    Top = 418
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object Button2: TButton
    Left = 424
    Top = 418
    Width = 75
    Height = 25
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 2
  end
  object cxDBLookupComboBox1: TcxDBLookupComboBox
    Left = 41
    Top = 258
    DataBinding.DataField = 'EVENT_TYPE'
    DataBinding.DataSource = IBCDataSourceDocStates
    Properties.DropDownAutoSize = True
    Properties.DropDownListStyle = lsFixedList
    Properties.DropDownSizeable = True
    Properties.GridMode = True
    Properties.ImmediatePost = True
    Properties.KeyFieldNames = 'SYSSID'
    Properties.ListColumns = <
      item
        Caption = 'Denumire'
        HeaderAlignment = taCenter
        MinWidth = 250
        Width = 300
        FieldName = 'TITLE'
      end
      item
        Caption = 'Timp alocat (minute)'
        HeaderAlignment = taCenter
        Sorting = False
        Width = 64
        FieldName = 'VALUE_INT'
      end>
    Properties.ListSource = IBCDataSourceSysS
    Properties.OnChange = cxDBLookupComboBox1PropertiesChange
    TabOrder = 3
    Width = 129
  end
  object cxDBCheckBox1: TcxDBCheckBox
    Left = 209
    Top = 258
    Caption = 'Aminteste la'
    DataBinding.DataField = 'FLG_REMIDER'
    DataBinding.DataSource = IBCDataSourceDocStates
    Properties.ValueChecked = '1'
    Properties.ValueUnchecked = '0'
    TabOrder = 4
  end
  object cxReminderDate: TcxDBDateEdit
    Left = 298
    Top = 259
    DataBinding.DataField = 'REMINDER'
    DataBinding.DataSource = IBCDataSourceDocStates
    Properties.Animation = False
    Properties.Kind = ckDateTime
    Properties.View = cavModern
    TabOrder = 5
    Width = 136
  end
  object cxGrid1: TcxGrid
    Left = 8
    Top = 8
    Width = 515
    Height = 225
    TabOrder = 6
    object cxGrid1DBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      ScrollbarAnnotations.CustomAnnotations = <>
      DataController.DataSource = IBCDataSourceDocStates
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      object cxGrid1DBTableView1_UID: TcxGridDBColumn
        Caption = 'uid'
        DataBinding.FieldName = 'UID'
      end
      object cxGrid1DBTableView1_DATA: TcxGridDBColumn
        Caption = 'Data'
        DataBinding.FieldName = 'BEGIN_DATE'
        HeaderAlignmentHorz = taCenter
        Width = 79
      end
      object cxGrid1DBTableView1_USER: TcxGridDBColumn
        Caption = 'Utilizator'
        DataBinding.FieldName = 'CREATED_BY'
        HeaderAlignmentHorz = taCenter
        Width = 100
      end
      object cxGrid1DBTableView1_STATUS: TcxGridDBColumn
        Caption = 'Statutul documentului'
        DataBinding.FieldName = 'EVENT_TYPE'
        HeaderAlignmentHorz = taCenter
        Width = 150
      end
      object cxGrid1DBTableView1_ESTIMATE_FINISH: TcxGridDBColumn
        Caption = 'plan. finisat '
        DataBinding.FieldName = 'END_DATE'
        HeaderAlignmentHorz = taCenter
        Width = 90
      end
      object cxGrid1DBTableView1_REAL_FINISH: TcxGridDBColumn
        Caption = 'real finisat'
        HeaderAlignmentHorz = taCenter
        Width = 90
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
    end
  end
  object IBCQuerySysS: TIBCQuery
    SQLInsert.Strings = (
      'INSERT INTO TS_DOCTYPE_STATES'
      '  (DOCTYPEID, STATUSID, PARENTID, TITLE, ESTIMATED_TIME, FLAGS)'
      'VALUES'
      
        '  (:DOCTYPEID, :STATUSID, :PARENTID, :TITLE, :ESTIMATED_TIME, :F' +
        'LAGS)')
    SQLDelete.Strings = (
      'DELETE FROM TS_DOCTYPE_STATES'
      'WHERE'
      '  DOCTYPEID = :Old_DOCTYPEID AND STATUSID = :Old_STATUSID')
    SQLUpdate.Strings = (
      'UPDATE TS_DOCTYPE_STATES'
      'SET'
      
        '  DOCTYPEID = :DOCTYPEID, STATUSID = :STATUSID, PARENTID = :PARE' +
        'NTID, TITLE = :TITLE, ESTIMATED_TIME = :ESTIMATED_TIME, FLAGS = ' +
        ':FLAGS'
      'WHERE'
      '  DOCTYPEID = :Old_DOCTYPEID AND STATUSID = :Old_STATUSID')
    SQLRefresh.Strings = (
      
        'SELECT DOCTYPEID, STATUSID, PARENTID, TITLE, ESTIMATED_TIME, FLA' +
        'GS FROM TS_DOCTYPE_STATES'
      'WHERE'
      '  DOCTYPEID = :DOCTYPEID AND STATUSID = :STATUSID')
    SQLLock.Strings = (
      'SELECT NULL FROM TS_DOCTYPE_STATES'
      'WHERE'
      'DOCTYPEID = :Old_DOCTYPEID AND STATUSID = :Old_STATUSID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM TS_DOCTYPE_STATES'
      ''
      ') q')
    SQL.Strings = (
      'select * from TS_DOCTYPE_STATES where doctypeid=:doctypeid')
    Left = 56
    Top = 186
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'doctypeid'
        Value = nil
      end>
  end
  object IBCDataSourceSysS: TIBCDataSource
    DataSet = IBCQuerySysS
    Left = 56
    Top = 130
  end
  object IBCQueryDocStates: TIBCQuery
    KeyFields = 'UID'
    KeyGenerator = 'gen_tdb_docs_events_id'
    SQLInsert.Strings = (
      'INSERT INTO TDB_DOCS_EVENTS'
      
        '  (UID, DOCID, EVENT_TYPE, CREATED_BY, BEGIN_DATE, END_DATE, COM' +
        'MENTS, CALLID, FLG_REMINDER, REMINDER)'
      'VALUES'
      
        '  (:UID, :DOCID, :EVENT_TYPE, :CREATED_BY, :BEGIN_DATE, :END_DAT' +
        'E, :COMMENTS, :CALLID, :FLG_REMINDER, :REMINDER)')
    SQLDelete.Strings = (
      'DELETE FROM TDB_DOCS_EVENTS'
      'WHERE'
      '  UID = :Old_UID')
    SQLUpdate.Strings = (
      'UPDATE TDB_DOCS_EVENTS'
      'SET'
      
        '  UID = :UID, DOCID = :DOCID, EVENT_TYPE = :EVENT_TYPE, CREATED_' +
        'BY = :CREATED_BY, BEGIN_DATE = :BEGIN_DATE, END_DATE = :END_DATE' +
        ', COMMENTS = :COMMENTS, CALLID = :CALLID, FLG_REMINDER = :FLG_RE' +
        'MINDER, REMINDER = :REMINDER'
      'WHERE'
      '  UID = :Old_UID')
    SQLRefresh.Strings = (
      
        'SELECT UID, DOCID, EVENT_TYPE, CREATED_BY, BEGIN_DATE, END_DATE,' +
        ' COMMENTS, CALLID, FLG_REMINDER, REMINDER FROM TDB_DOCS_EVENTS'
      'WHERE'
      '  UID = :UID')
    SQLLock.Strings = (
      'SELECT NULL FROM TDB_DOCS_EVENTS'
      'WHERE'
      'UID = :Old_UID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM TDB_DOCS_EVENTS'
      ''
      ') q')
    UpdateTransaction = IBCTrLocalUpdate
    SQL.Strings = (
      'select * from tdb_docs_events where docid=:docid')
    RefreshOptions = [roBeforeEdit]
    Options.RequiredFields = False
    LocalConstraints = False
    Left = 208
    Top = 186
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'docid'
        Value = nil
      end>
  end
  object IBCDataSourceDocStates: TIBCDataSource
    DataSet = IBCQueryDocStates
    Left = 208
    Top = 130
  end
  object IBCTrLocalUpdate: TIBCTransaction
    Left = 120
    Top = 64
  end
end
