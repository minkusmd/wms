object frmDatePeriodDlg: TfrmDatePeriodDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  ClientHeight = 252
  ClientWidth = 396
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
    Width = 396
    Height = 64
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
    Width = 380
    Height = 125
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    object Label1: TLabel
      Left = 20
      Top = 28
      Width = 102
      Height = 15
      Caption = 'Inceputul perioadei'
    end
    object Label2: TLabel
      Left = 20
      Top = 65
      Width = 88
      Height = 15
      Caption = 'Sfirsitul perioade'
    end
    object sbPresets: TSpeedButton
      Left = 267
      Top = 62
      Width = 78
      Height = 23
      Caption = 'setari'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      OnClick = sbPresetsClick
    end
    object deDate1: TcxDateEdit
      Left = 124
      Top = 25
      EditValue = 0d
      Properties.SaveTime = False
      Properties.ShowTime = False
      Properties.WeekNumbers = True
      TabOrder = 0
      Width = 137
    end
    object deDate2: TcxDateEdit
      Left = 124
      Top = 62
      EditValue = 0d
      Properties.SaveTime = False
      Properties.ShowTime = False
      Properties.WeekNumbers = True
      TabOrder = 1
      Width = 137
    end
  end
  object btnOk: TButton
    Left = 180
    Top = 208
    Width = 90
    Height = 29
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 284
    Top = 208
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
  object pmDates: TPopupMenu
    Left = 312
    Top = 80
    object miMore5Days: TMenuItem
      Tag = 5
      Caption = '5 '#1076#1085#1077#1081
      OnClick = N301Click
    end
    object N101: TMenuItem
      Tag = 10
      Caption = '10 '#1076#1085#1077#1081
      OnClick = N301Click
    end
    object N201: TMenuItem
      Tag = 20
      Caption = '20 '#1076#1085#1077#1081
      OnClick = N301Click
    end
    object N301: TMenuItem
      Tag = 30
      Caption = '30 '#1076#1085#1077#1081
      OnClick = N301Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object miEndOfMonth: TMenuItem
      Caption = #1044#1086' '#1082#1086#1085#1094#1072' '#1084#1077#1089#1103#1094#1072
      OnClick = miEndOfMonthClick
    end
    object miEndOfQuarter: TMenuItem
      Caption = #1044#1086' '#1082#1086#1085#1094#1072' '#1082#1074#1072#1088#1090#1072#1083#1072
      OnClick = miEndOfQuarterClick
    end
    object miEndOfYear: TMenuItem
      Caption = #1044#1086' '#1082#1086#1085#1094#1072' '#1075#1086#1076#1072
      OnClick = miEndOfYearClick
    end
  end
end
