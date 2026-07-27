object frmServiceWaitingIncidentPropsDlg: TfrmServiceWaitingIncidentPropsDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1057#1074#1086#1081#1089#1090#1074#1072' '#1080#1085#1094#1080#1076#1077#1085#1090#1072' '#1074' '#1086#1095#1077#1088#1077#1076#1080' '#1085#1072' '#1088#1077#1084#1086#1085#1090
  ClientHeight = 436
  ClientWidth = 501
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    501
    436)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 501
    Height = 64
    Title = #1057#1074#1086#1081#1089#1090#1074#1072' '#1080#1085#1094#1080#1076#1077#1085#1090#1072' '#1074' '#1086#1095#1077#1088#1077#1076#1080' '#1085#1072' '#1088#1077#1084#1086#1085#1090
    Text = ''
    FontTitle.Charset = DEFAULT_CHARSET
    FontTitle.Color = clWindowText
    FontTitle.Height = -13
    FontTitle.Name = 'Segoe UI'
    FontTitle.Style = [fsBold]
    FontText.Charset = DEFAULT_CHARSET
    FontText.Color = clWindowText
    FontText.Height = -11
    FontText.Name = 'Verdana'
    FontText.Style = []
    ImageList = dmAdditions.cxImageList_DialogIcons
    ImageIndex = 32
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 485
    Height = 310
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
    ShowCaption = False
    TabOrder = 1
    object Label3: TLabel
      Left = 20
      Top = 20
      Width = 110
      Height = 15
      Caption = #1043#1088#1091#1087#1087#1072' '#1080#1085#1078#1080#1085#1077#1088#1086#1074'*'
    end
    object Label1: TLabel
      Left = 256
      Top = 20
      Width = 137
      Height = 15
      Caption = #1055#1088#1080#1086#1088#1080#1090#1077#1090' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1103'*'
    end
    object Label2: TLabel
      Left = 20
      Top = 127
      Width = 77
      Height = 15
      Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080
    end
    object lcbEXEC_PERSONAL_GROUP_ID: TcxDBLookupComboBox
      Left = 20
      Top = 37
      DataBinding.DataField = 'EXEC_PERSONAL_GROUP_ID'
      ParentFont = False
      Properties.DropDownListStyle = lsFixedList
      Properties.DropDownRows = 16
      Properties.ImmediatePost = True
      Properties.KeyFieldNames = 'GROUPID'
      Properties.ListColumns = <
        item
          FieldName = 'NAME'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = IBCDataSourceGroups
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -12
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = []
      Style.IsFontAssigned = True
      TabOrder = 0
      Width = 200
    end
    object lcbPRIORITY_LEVEL_ID: TcxDBLookupComboBox
      Left = 256
      Top = 37
      DataBinding.DataField = 'PRIORITY_LEVEL_ID'
      ParentFont = False
      Properties.DropDownListStyle = lsFixedList
      Properties.ImmediatePost = True
      Properties.KeyFieldNames = 'SYSSID'
      Properties.ListColumns = <
        item
          FieldName = 'TITLE'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = IBCDataSourcePriority
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -12
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = []
      Style.IsFontAssigned = True
      TabOrder = 1
      Width = 200
    end
    object cbFLG_TOP_PRIORITY: TcxDBCheckBox
      Left = 20
      Top = 88
      Caption = #1053#1072#1080#1074#1099#1089#1096#1080#1081' '#1087#1088#1080#1086#1088#1080#1090#1077#1090' ('#1090#1088#1077#1073#1091#1077#1090' '#1082#1086#1084#1084#1077#1085#1090#1072#1088#1080#1081')'
      DataBinding.DataField = 'FLG_TOP_PRIORITY'
      ParentFont = False
      Properties.Alignment = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ValueChecked = 1
      Properties.ValueUnchecked = 0
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -12
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = []
      Style.IsFontAssigned = True
      TabOrder = 2
    end
    object mmCOMMENTS: TcxDBMemo
      Left = 20
      Top = 144
      DataBinding.DataField = 'COMMENTS'
      ParentFont = False
      Properties.ScrollBars = ssVertical
      Properties.VisibleLineCount = 8
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -12
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = []
      Style.IsFontAssigned = True
      TabOrder = 3
      Width = 436
    end
  end
  object btnOk: TButton
    Left = 280
    Top = 393
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 388
    Top = 393
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
  object IBCDataSourceGroups: TIBCDataSource
    DataSet = IBCQueryGroups
    Left = 52
    Top = 380
  end
  object IBCQueryGroups: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SElECT'
      'GROUPID, NAME'
      'FROM VW_TS_USER_GROUPS'
      'WHERE FLG_SERVICE_ENGINER=1'
      'ORDER BY NAME')
    Left = 52
    Top = 336
  end
  object IBCQueryPriority: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      'SELECT'
      ' SYSSID,'
      ' TITLE'
      'FROM TS_SYSS'
      'WHERE PARENTID=33')
    Left = 176
    Top = 340
  end
  object IBCDataSourcePriority: TIBCDataSource
    DataSet = IBCQueryPriority
    Left = 176
    Top = 388
  end
end
