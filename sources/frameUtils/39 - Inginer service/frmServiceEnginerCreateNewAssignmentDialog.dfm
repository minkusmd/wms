object frmServiceEnginerCreateNewAssignmentDlg: TfrmServiceEnginerCreateNewAssignmentDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1053#1086#1074#1099#1081' '#1079#1072#1087#1088#1086#1089
  ClientHeight = 417
  ClientWidth = 602
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
    Width = 602
    Height = 64
    Title = #1053#1086#1074#1099#1081' '#1079#1072#1087#1088#1086#1089
    Text = #1057#1086#1079#1076#1072#1085#1080#1077' '#1085#1086#1074#1086#1075#1086' '#1079#1072#1087#1088#1086#1089#1072' '#1085#1072' '#1091#1089#1083#1091#1075#1091' '#1080#1083#1080' '#1088#1077#1084#1086#1085#1090
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
    ImageIndex = 32
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 586
    Height = 289
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
      Top = 20
      Width = 45
      Height = 15
      Caption = #1047#1072#1087#1088#1086#1089'*'
    end
    object Label2: TLabel
      Left = 20
      Top = 80
      Width = 82
      Height = 15
      Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1081'*'
    end
    object Label3: TLabel
      Left = 20
      Top = 220
      Width = 250
      Height = 15
      Caption = #1057#1077#1088#1080#1081#1085#1085#1099#1081' '#1085#1086#1084#1077#1088' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1103' '#1080#1079' '#1079#1072#1087#1088#1086#1089#1072
    end
    object Label4: TLabel
      Left = 344
      Top = 220
      Width = 122
      Height = 15
      Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100' '#1079#1072#1076#1072#1095#1091' '#1076#1086'*'
    end
    object lcbTaskTypeID: TcxLookupComboBox
      Left = 20
      Top = 37
      Properties.DropDownListStyle = lsFixedList
      Properties.DropDownRows = 16
      Properties.KeyFieldNames = 'TASKTYPEID'
      Properties.ListColumns = <
        item
          Caption = #1047#1072#1087#1088#1086#1089
          Width = 200
          FieldName = 'TITLE'
        end
        item
          Caption = #1043#1088#1091#1087#1087#1072' '#1080#1085#1078#1077#1085#1077#1088#1086#1074
          Width = 100
          FieldName = 'NAME'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = IBCDataSourceTasks
      EditValue = 0
      TabOrder = 0
      Width = 537
    end
    object mmComments: TcxMemo
      Left = 20
      Top = 97
      Lines.Strings = (
        'mmComments')
      ParentFont = False
      Properties.ScrollBars = ssVertical
      Properties.VisibleLineCount = 6
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -13
      Style.Font.Name = 'Verdana'
      Style.Font.Style = []
      Style.IsFontAssigned = True
      TabOrder = 1
      Width = 537
    end
    object edSN: TcxTextEdit
      Left = 20
      Top = 237
      ParentFont = False
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -13
      Style.Font.Name = 'Verdana'
      Style.Font.Style = []
      Style.IsFontAssigned = True
      TabOrder = 2
      Text = 'edSN'
      Width = 277
    end
    object deEndDateTime: TcxDateEdit
      Left = 344
      Top = 237
      ParentFont = False
      Properties.DateButtons = [btnClear, btnNow, btnToday]
      Properties.Kind = ckDateTime
      Properties.WeekNumbers = True
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -13
      Style.Font.Name = 'Verdana'
      Style.Font.Style = []
      Style.IsFontAssigned = True
      TabOrder = 3
      Width = 213
    end
  end
  object btnOk: TButton
    Left = 384
    Top = 372
    Width = 90
    Height = 29
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 492
    Top = 372
    Width = 90
    Height = 29
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
  object IBCQueryTasks: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT'
      ' SC_REF_TASK_TYPE.TASKTYPEID,'
      ' SC_REF_TASK_TYPE.TITLE,'
      ' TS_USER_GROUPS.NAME'
      'FROM SC_REF_TASK_TYPE'
      
        'INNER JOIN TS_USER_GROUPS ON (TS_USER_GROUPS.GROUPID=SC_REF_TASK' +
        '_TYPE.USER_GROUP_ID)'
      
        'WHERE BIN_AND(SC_REF_TASK_TYPE.FLAGS,17)=17 /* FLG_ENABLED + FLG' +
        '_OTHER_EXECUTANT */'
      'ORDER BY SC_REF_TASK_TYPE.TITLE')
    Left = 272
    Top = 132
  end
  object IBCDataSourceTasks: TIBCDataSource
    DataSet = IBCQueryTasks
    Left = 272
    Top = 184
  end
end
