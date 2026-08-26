object frmServiceEndTaskDlg: TfrmServiceEndTaskDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1047#1072#1074#1077#1088#1096#1077#1085#1080#1077' '#1079#1072#1076#1072#1095#1080
  ClientHeight = 542
  ClientWidth = 1029
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    1029
    542)
  PixelsPerInch = 96
  TextHeight = 15
  object DialogTitle1: TDialogTitle
    Left = 0
    Top = 0
    Width = 1029
    Height = 64
    Title = #1047#1072#1074#1077#1088#1096#1077#1085#1080#1077' '#1079#1072#1076#1072#1095#1080
    Text = #1047#1072#1074#1077#1088#1096#1077#1085#1080#1077' '#1090#1077#1082#1091#1097#1077#1081' '#1079#1072#1076#1072#1095#1080' '#1080' '#1085#1072#1095#1072#1083#1086' '#1085#1086#1074#1086#1081
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
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 1013
    Height = 410
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    object ControlGroup1: TControlGroup
      Left = 16
      Top = 16
      Width = 312
      Height = 373
      Title = '1. '#1047#1072#1074#1077#1088#1096#1080#1090#1100' '#1090#1077#1082#1091#1097#1080#1102' '#1079#1072#1076#1072#1095#1091
      FontTitle.Charset = DEFAULT_CHARSET
      FontTitle.Color = 10040064
      FontTitle.Height = -15
      FontTitle.Name = 'Segoe UI'
      FontTitle.Style = []
      GroupType = cgtInfo
      object Label3: TLabel
        Left = 16
        Top = 76
        Width = 38
        Height = 15
        Caption = #1047#1072#1076#1072#1095#1072
      end
      object Label4: TLabel
        Left = 16
        Top = 132
        Width = 106
        Height = 15
        Caption = #1057#1090#1072#1090#1091#1089' '#1079#1072#1074#1077#1088#1096#1077#1085#1080#1103
      end
      object Label7: TLabel
        Left = 16
        Top = 257
        Width = 167
        Height = 15
        Caption = #1050#1086#1084#1077#1085#1090#1072#1088#1080#1080' '#1082' '#1090#1077#1082#1091#1097#1077#1081' '#1079#1072#1076#1072#1095#1080
      end
      object edTYPE_TITLE: TcxDBTextEdit
        Left = 16
        Top = 93
        TabStop = False
        DataBinding.DataField = 'TYPE_TITLE'
        Properties.ReadOnly = True
        TabOrder = 0
        Width = 280
      end
      object cmbSTATUS_ID: TcxLookupComboBox
        Left = 16
        Top = 150
        Enabled = False
        Properties.DropDownListStyle = lsFixedList
        Properties.DropDownRows = 16
        Properties.KeyFieldNames = 'SYSSID'
        Properties.ListColumns = <
          item
            FieldName = 'TITLE'
          end>
        Properties.ListOptions.ShowHeader = False
        Properties.ListSource = IBCDataSourceTaskStatus
        EditValue = 0
        TabOrder = 1
        Width = 280
      end
      object mmCOMMENTS: TcxDBMemo
        Left = 16
        Top = 274
        DataBinding.DataField = 'COMMENTS'
        DataBinding.DataSource = IBCDataSourceTaskDSC
        Properties.ScrollBars = ssVertical
        TabOrder = 2
        Height = 81
        Width = 280
      end
    end
    object ControlGroup2: TControlGroup
      Left = 348
      Top = 16
      Width = 312
      Height = 373
      Title = '2. '#1053#1072#1095#1072#1090#1100' '#1085#1086#1074#1091#1102' '#1079#1072#1076#1072#1095#1091
      FontTitle.Charset = DEFAULT_CHARSET
      FontTitle.Color = 10040064
      FontTitle.Height = -15
      FontTitle.Name = 'Segoe UI'
      FontTitle.Style = []
      GroupType = cgtWarning
      object lbNew_Task: TLabel
        Left = 16
        Top = 76
        Width = 73
        Height = 15
        Caption = #1053#1086#1074#1072#1103' '#1079#1072#1076#1072#1095#1072
      end
      object lbNew_NewStatus: TLabel
        Left = 16
        Top = 132
        Width = 101
        Height = 15
        Caption = #1053#1072#1095#1072#1083#1100#1085#1099#1081' '#1089#1090#1072#1090#1091#1089
      end
      object lbNew_AssignedUser: TLabel
        Left = 16
        Top = 193
        Width = 125
        Height = 15
        Caption = #1048#1089#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1086#1077' '#1083#1080#1094#1086
      end
      object lbNew_Comments: TLabel
        Left = 16
        Top = 257
        Width = 154
        Height = 15
        Caption = #1050#1086#1084#1077#1085#1090#1072#1088#1080#1080' '#1082' '#1085#1086#1074#1086#1081' '#1079#1072#1076#1072#1095#1080
      end
      object cbCreateNewTask: TCheckBox
        Left = 16
        Top = 40
        Width = 153
        Height = 17
        Caption = #1053#1072#1095#1072#1090#1100' '#1085#1086#1074#1091#1102' '#1079#1072#1076#1072#1095#1091
        Checked = True
        State = cbChecked
        TabOrder = 0
        OnClick = cbCreateNewTaskClick
      end
      object cmbNew_TYPE_ID: TcxLookupComboBox
        Left = 16
        Top = 93
        Properties.DropDownListStyle = lsFixedList
        Properties.DropDownRows = 16
        Properties.KeyFieldNames = 'SYSSID'
        Properties.ListColumns = <
          item
            FieldName = 'TITLE'
          end>
        Properties.ListOptions.ShowHeader = False
        Properties.ListSource = IBCDataSourceTaskTypes
        EditValue = 0
        TabOrder = 1
        Width = 280
      end
      object cmbNew_STATUS_ID: TcxLookupComboBox
        Left = 16
        Top = 150
        Properties.DropDownListStyle = lsFixedList
        Properties.DropDownRows = 16
        Properties.KeyFieldNames = 'SYSSID'
        Properties.ListColumns = <
          item
            FieldName = 'TITLE'
          end>
        Properties.ListOptions.ShowHeader = False
        Properties.ListSource = IBCDataSourceTaskStatus
        EditValue = 0
        TabOrder = 2
        Width = 280
      end
      object cmbNew_ASSIGNED_USER_ID: TcxLookupComboBox
        Left = 16
        Top = 210
        Properties.DropDownListStyle = lsFixedList
        Properties.DropDownRows = 16
        Properties.KeyFieldNames = 'USERID'
        Properties.ListColumns = <
          item
            FieldName = 'USER_NAME'
          end>
        Properties.ListOptions.ShowHeader = False
        Properties.ListSource = IBCDataSourceAssignedUsers
        EditValue = 0
        TabOrder = 3
        Width = 280
      end
      object mmNewTaskComments: TcxMemo
        Left = 16
        Top = 273
        Properties.ScrollBars = ssVertical
        TabOrder = 4
        Height = 81
        Width = 280
      end
    end
    object ControlGroup3: TControlGroup
      Left = 680
      Top = 16
      Width = 312
      Height = 373
      Title = '3. '#1057#1090#1072#1090#1091#1089' '#1048#1085#1094#1080#1076#1077#1085#1090#1072
      FontTitle.Charset = DEFAULT_CHARSET
      FontTitle.Color = 10040064
      FontTitle.Height = -15
      FontTitle.Name = 'Segoe UI'
      FontTitle.Style = []
      GroupType = cgtError
      object Label8: TLabel
        Left = 16
        Top = 76
        Width = 154
        Height = 15
        Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1089#1090#1072#1090#1091#1089' '#1048#1085#1094#1080#1076#1077#1085#1090#1072
      end
      object Label1: TLabel
        Left = 16
        Top = 132
        Width = 273
        Height = 76
        AutoSize = False
        Caption = 
          #1059#1089#1090#1072#1085#1086#1074#1080#1090#1077' '#1089#1090#1072#1090#1091#1089' '#1048#1085#1094#1080#1076#1077#1085#1090#1072' '#1074' '#1089#1086#1086#1090#1074#1077#1090#1089#1090#1074#1080#1077' '#1089#1086' '#1089#1090#1072#1090#1091#1089#1086#1084' '#1079#1072#1074#1077#1088#1097#1077#1085#1085 +
          #1086#1081' '#1080#1083#1080' '#1085#1086#1074#1086#1081' '#1079#1072#1076#1072#1095#1080'. '#1057#1090#1072#1090#1091#1089' '#1080#1085#1094#1080#1076#1077#1085#1090#1072' '#1076#1086#1083#1078#1077#1085' '#1086#1087#1080#1089#1099#1074#1072#1090#1100' '#1090#1077#1082#1091#1097#1077#1077' '#1089 +
          #1086#1089#1090#1086#1103#1085#1080#1077' '#1080#1085#1094#1080#1076#1077#1085#1090#1072'.'
        WordWrap = True
      end
      object cmbI_STATUS_ID: TcxLookupComboBox
        Left = 16
        Top = 93
        Properties.DropDownListStyle = lsFixedList
        Properties.DropDownRows = 16
        Properties.KeyFieldNames = 'SYSSID'
        Properties.ListColumns = <
          item
            FieldName = 'TITLE'
          end>
        Properties.ListOptions.ShowHeader = False
        Properties.ListSource = IBCDataSourceIncidentStatus
        EditValue = 0
        TabOrder = 0
        Width = 273
      end
    end
  end
  object btnOk: TButton
    Left = 809
    Top = 497
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = '&Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 917
    Top = 497
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
  object IBCQueryTaskStatus: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT'
      ' *'
      'FROM'
      ' GET_SC_TASK_STATUSES')
    Constraints = <>
    Left = 232
    Top = 212
  end
  object IBCDataSourceTaskStatus: TIBCDataSource
    DataSet = IBCQueryTaskStatus
    Left = 232
    Top = 264
  end
  object IBCQueryIncidentStatus: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT'
      ' *'
      'FROM'
      ' GET_INCIDENT_STATUSES')
    Constraints = <>
    Left = 904
    Top = 80
  end
  object IBCDataSourceIncidentStatus: TIBCDataSource
    DataSet = IBCQueryIncidentStatus
    Left = 904
    Top = 132
  end
  object IBCQueryTaskTypes: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT'
      ' *'
      'FROM'
      ' GET_SC_TASK_TYPES')
    Constraints = <>
    Left = 432
    Top = 364
  end
  object IBCDataSourceTaskTypes: TIBCDataSource
    DataSet = IBCQueryTaskTypes
    Left = 432
    Top = 420
  end
  object IBCQueryAssignedUsers: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT'
      ' *'
      'FROM'
      ' GET_SC_TASK_USERS')
    Constraints = <>
    Left = 588
    Top = 364
  end
  object IBCDataSourceAssignedUsers: TIBCDataSource
    DataSet = IBCQueryAssignedUsers
    Left = 588
    Top = 420
  end
  object IBCQueryTaskDSC: TIBCQuery
    SQLInsert.Strings = (
      'INSERT INTO TDB_SC_TASK_DSC'
      '  (IID, TASKID, COMMENTS)'
      'VALUES'
      '  (:IID, :TASKID, :COMMENTS)')
    SQLDelete.Strings = (
      'DELETE FROM TDB_SC_TASK_DSC'
      'WHERE'
      '  IID = :Old_IID AND TASKID = :Old_TASKID')
    SQLUpdate.Strings = (
      'UPDATE TDB_SC_TASK_DSC'
      'SET'
      '  IID = :IID, TASKID = :TASKID, COMMENTS = :COMMENTS'
      'WHERE'
      '  IID = :Old_IID AND TASKID = :Old_TASKID')
    SQLRefresh.Strings = (
      
        'SELECT TDB_SC_TASK_DSC.IID, TDB_SC_TASK_DSC.TASKID, TDB_SC_TASK_' +
        'DSC.COMMENTS FROM TDB_SC_TASK_DSC'
      'WHERE'
      '  IID = :IID AND TASKID = :TASKID')
    SQLLock.Strings = (
      'SELECT NULL FROM TDB_SC_TASK_DSC'
      'WHERE'
      'IID = :Old_IID AND TASKID = :Old_TASKID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      'SELECT'
      ' IID,'
      ' TASKID,'
      ' COMMENTS'
      'FROM'
      ' TDB_SC_TASK_DSC')
    MasterFields = 'IID;TASKID'
    DetailFields = 'IID;TASKID'
    Constraints = <>
    Left = 128
    Top = 400
  end
  object IBCDataSourceTaskDSC: TIBCDataSource
    DataSet = IBCQueryTaskDSC
    Left = 128
    Top = 456
  end
end
