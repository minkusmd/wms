object fMain: TfMain
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'SWN Service Manager'
  ClientHeight = 466
  ClientWidth = 631
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    631
    466)
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 631
    Height = 64
    Title = 'SWN Service Manager'
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
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 615
    Height = 337
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
    object lbTaskTitle: TLabel
      Left = 8
      Top = 20
      Width = 39
      Height = 15
      Caption = #1047#1072#1076#1072#1095#1080
    end
    object lbServiceSettings: TLabel
      Left = 541
      Top = 8
      Width = 60
      Height = 15
      Cursor = crHandPoint
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 9915136
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsUnderline]
      ParentFont = False
      OnClick = lbServiceSettingsClick
    end
    object lbViewLog: TLabel
      Left = 468
      Top = 8
      Width = 44
      Height = 15
      Cursor = crHandPoint
      Caption = #1046#1091#1088#1085#1072#1083
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 9915136
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsUnderline]
      ParentFont = False
    end
    object sbNewTask: TSpeedButton
      Left = 8
      Top = 291
      Width = 101
      Height = 23
      Caption = #1053#1086#1074#1072#1103' '#1079#1072#1076#1072#1095#1072
      OnClick = sbNewTaskClick
    end
    object sbModifyTask: TSpeedButton
      Left = 115
      Top = 291
      Width = 101
      Height = 23
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      OnClick = sbModifyTaskClick
    end
    object sbDeleteTask: TSpeedButton
      Left = 500
      Top = 291
      Width = 101
      Height = 23
      Caption = #1059#1076#1072#1083#1080#1090#1100
      OnClick = sbDeleteTaskClick
    end
    object lvTasks: TListView
      Left = 8
      Top = 37
      Width = 593
      Height = 248
      Columns = <
        item
          AutoSize = True
          Caption = #1047#1072#1076#1072#1095#1072
        end
        item
          Alignment = taCenter
          Caption = #1040#1082#1090#1080#1074#1085#1072
          Width = 60
        end
        item
          Caption = #1042#1088#1077#1084#1103
          Width = 100
        end
        item
          Caption = #1055#1088#1086#1094#1077#1076#1091#1088#1072
          Width = 200
        end>
      ReadOnly = True
      RowSelect = True
      TabOrder = 0
      ViewStyle = vsReport
      OnSelectItem = lvTasksSelectItem
    end
  end
  object btnClose: TButton
    Left = 521
    Top = 423
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = #1047#1072#1082#1088#1099#1090#1100
    TabOrder = 3
    OnClick = btnCloseClick
  end
  object btnSave: TButton
    Left = 18
    Top = 423
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    TabOrder = 2
    OnClick = btnSaveClick
  end
end
