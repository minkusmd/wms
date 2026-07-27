object frmServiceEnginerCreateNewTaskDlg: TfrmServiceEnginerCreateNewTaskDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1053#1086#1074#1072#1103' '#1079#1072#1076#1072#1095#1072
  ClientHeight = 475
  ClientWidth = 485
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
    Width = 485
    Height = 64
    Title = #1053#1086#1074#1072#1103' '#1079#1072#1076#1072#1095#1072
    Text = #1057#1086#1079#1076#1072#1085#1080#1077' '#1085#1086#1074#1086#1081' '#1079#1072#1076#1072#1095#1080' '#1074' '#1080#1085#1094#1080#1076#1077#1085#1090#1077
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
  object btnNext: TButton
    Left = 270
    Top = 432
    Width = 90
    Height = 29
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancel: TButton
    Left = 374
    Top = 432
    Width = 90
    Height = 29
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 2
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 469
    Height = 349
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
    TabOrder = 3
    object Label1: TLabel
      Left = 44
      Top = 43
      Width = 78
      Height = 15
      Caption = #1053#1086#1074#1072#1103' '#1079#1072#1076#1072#1095#1072'*'
    end
    object Label2: TLabel
      Left = 44
      Top = 147
      Width = 130
      Height = 15
      Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1103'*'
    end
    object Label3: TLabel
      Left = 44
      Top = 203
      Width = 195
      Height = 15
      Caption = #1050#1086#1084#1077#1085#1090#1072#1088#1080#1081' '#1082' '#1074#1099#1087#1086#1083#1085#1077#1085#1086#1081' '#1079#1072#1076#1072#1095#1080'*'
    end
    object rbContinue: TRadioButton
      Left = 20
      Top = 20
      Width = 209
      Height = 17
      Caption = #1055#1088#1086#1076#1086#1083#1078#1080#1090#1100' '#1088#1072#1073#1086#1090#1091' '#1085#1072#1076' '#1079#1072#1076#1072#1095#1077#1081
      TabOrder = 0
      OnClick = rbContinueClick
    end
    object rbFinish: TRadioButton
      Left = 20
      Top = 125
      Width = 125
      Height = 17
      Caption = #1047#1072#1082#1086#1085#1095#1080#1090#1100' '#1079#1072#1076#1072#1095#1091
      TabOrder = 1
      OnClick = rbContinueClick
    end
    object lcbContinueTaskType: TcxLookupComboBox
      Left = 44
      Top = 60
      Properties.DropDownListStyle = lsFixedList
      Properties.DropDownRows = 16
      Properties.KeyFieldNames = 'TASKTYPEID'
      Properties.ListColumns = <
        item
          FieldName = 'TITLE'
        end
        item
          Fixed = True
          HeaderAlignment = taCenter
          Width = 90
          FieldName = 'FLG_MUST_BE'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = IBCDataSourceCont
      EditValue = 0
      TabOrder = 2
      Width = 401
    end
    object lcbFinishTaskType: TcxLookupComboBox
      Left = 44
      Top = 164
      Properties.DropDownListStyle = lsFixedList
      Properties.KeyFieldNames = 'TASKTYPEID'
      Properties.ListColumns = <
        item
          FieldName = 'TITLE'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = IBCDataSourceFinish
      EditValue = 0
      TabOrder = 3
      Width = 401
    end
    object mmComments: TcxMemo
      Left = 44
      Top = 220
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
      TabOrder = 4
      Width = 401
    end
  end
  object IBCQueryCont: TIBCQuery
    SQL.Strings = (
      'SELECT'
      'TASKTYPEID, TITLE,'
      'IIF(EXISTS(SELECT TASKTYPEID'
      '           FROM SC_REF_SCOP_TASK_TYPE'
      
        '           WHERE SC_REF_SCOP_TASK_TYPE.TASKTYPEID=SC_REF_TASK_TY' +
        'PE.TASKTYPEID'
      
        '                 AND GET_FLG_VALUE(SC_REF_SCOP_TASK_TYPE.FLAGS,' +
        '0)=1'
      '          ),'#39#1054#1073#1100#1103#1079#1072#1090#1077#1083#1100#1085#1086#39','#39#39') FLG_MUST_BE'
      'FROM SC_REF_TASK_TYPE'
      'WHERE FLAGS=1 /* only FLG_ENABLED */')
    Left = 276
    Top = 168
  end
  object IBCQueryFinish: TIBCQuery
    SQL.Strings = (
      'SELECT'
      'TASKTYPEID, TITLE'
      'FROM SC_REF_TASK_TYPE'
      'WHERE GET_FLG_VALUE(FLAGS,2)=1 /* FLG_END_STATE */')
    Left = 272
    Top = 272
  end
  object IBCDataSourceCont: TIBCDataSource
    DataSet = IBCQueryCont
    Left = 376
    Top = 168
  end
  object IBCDataSourceFinish: TIBCDataSource
    DataSet = IBCQueryFinish
    Left = 372
    Top = 272
  end
end
