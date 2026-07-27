object frmUserMissedHoursSetIntervalDlg: TfrmUserMissedHoursSetIntervalDlg
  Left = 0
  Top = 0
  ActiveControl = deEND
  BorderStyle = bsDialog
  Caption = #1059#1089#1090#1072#1085#1086#1074#1082#1072' '#1087#1077#1088#1080#1086#1076#1072' '#1076#1083#1103' '#1089#1086#1073#1099#1090#1080#1103
  ClientHeight = 286
  ClientWidth = 460
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    460
    286)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 460
    Height = 64
    Title = #1059#1089#1090#1072#1085#1086#1074#1082#1072' '#1087#1077#1088#1080#1086#1076#1072' '#1076#1083#1103' '#1089#1086#1073#1099#1090#1080#1103
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
    ImageIndex = 2
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 444
    Height = 161
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
    object Label6: TLabel
      Left = 24
      Top = 75
      Width = 91
      Height = 15
      Caption = #1053#1072#1095#1072#1083#1086' '#1087#1077#1088#1080#1086#1076#1072
    end
    object Label1: TLabel
      Left = 192
      Top = 75
      Width = 83
      Height = 15
      Caption = #1050#1086#1085#1077#1094' '#1087#1077#1088#1080#1086#1076#1072
    end
    object sbDates: TSpeedButton
      Left = 356
      Top = 92
      Width = 57
      Height = 23
      Caption = #1044#1072#1090#1099
      OnClick = sbDatesClick
    end
    object Label2: TLabel
      Left = 24
      Top = 23
      Width = 364
      Height = 30
      Caption = 
        #1042#1099#1073#1077#1088#1080#1090#1077' '#1076#1072#1090#1091' '#1086#1082#1086#1085#1095#1072#1085#1080#1103' '#1087#1077#1088#1080#1086#1076#1072' '#1076#1083#1103' '#1089#1086#1073#1099#1090#1080#1103'.'#13#1057#1086#1073#1099#1090#1080#1077' '#1073#1091#1076#1077#1090' '#1089#1082#1086#1087#1080 +
        #1088#1086#1074#1072#1085#1086' '#1074' '#1082#1072#1078#1076#1099#1081' '#1076#1077#1085#1100' '#1074#1099#1073#1088#1072#1085#1085#1086#1075#1086' '#1087#1077#1088#1080#1086#1076#1072'.'
      WordWrap = True
    end
    object deSTART: TcxDateEdit
      Left = 24
      Top = 92
      Enabled = False
      Properties.SaveTime = False
      Properties.ShowTime = False
      TabOrder = 0
      Width = 149
    end
    object deEND: TcxDateEdit
      Left = 192
      Top = 92
      Properties.DateButtons = [btnToday]
      Properties.SaveTime = False
      Properties.ShowTime = False
      Properties.WeekNumbers = True
      TabOrder = 1
      Width = 149
    end
  end
  object btnOk: TButton
    Left = 250
    Top = 244
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 354
    Top = 244
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
  object pmDates: TPopupMenu
    Left = 380
    Top = 192
    object N11: TMenuItem
      Tag = 7
      Caption = '1 '#1085#1077#1076#1077#1083#1103
      OnClick = N201Click
    end
    object N1011: TMenuItem
      Tag = 10
      Caption = '10 '#1076#1085#1077#1081
      OnClick = N201Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object N21: TMenuItem
      Tag = 14
      Caption = '2 '#1085#1077#1076#1077#1083#1080
      OnClick = N201Click
    end
    object N201: TMenuItem
      Tag = 20
      Caption = '20 '#1076#1085#1077#1081
      OnClick = N201Click
    end
  end
end
