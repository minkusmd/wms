object frmNacislenieZarplatiToolsDlg: TfrmNacislenieZarplatiToolsDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1053#1072#1095#1080#1089#1083#1077#1085#1080#1077' '#1079#1072#1088#1087#1083#1072#1090#1099' - '#1080#1085#1089#1090#1088#1091#1084#1077#1085#1090#1099
  ClientHeight = 469
  ClientWidth = 621
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
    Width = 621
    Height = 64
    Title = #1053#1072#1095#1080#1089#1083#1077#1085#1080#1077' '#1079#1072#1088#1087#1083#1072#1090#1099' - '#1080#1085#1089#1090#1088#1091#1084#1077#1085#1090#1099
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
  object btnClose: TButton
    Left = 510
    Top = 424
    Width = 90
    Height = 29
    Cancel = True
    Caption = #1047#1072#1082#1088#1099#1090#1100
    ModalResult = 2
    TabOrder = 1
  end
  object pcPageControl: TPageControl
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 605
    Height = 341
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    ActivePage = TabSheet1
    Align = alTop
    TabOrder = 2
    object TabSheet1: TTabSheet
      Caption = #1053#1072#1095#1072#1083#1086' '#1084#1077#1089#1103#1094#1072
      ExplicitHeight = 247
      object Label2: TLabel
        AlignWithMargins = True
        Left = 20
        Top = 20
        Width = 557
        Height = 30
        Margins.Left = 20
        Margins.Top = 20
        Margins.Right = 20
        Margins.Bottom = 20
        Align = alTop
        Caption = 
          #1043#1077#1085#1077#1088#1080#1088#1086#1074#1072#1090#1100' '#1076#1086#1082#1091#1084#1077#1085#1090#1099' '#1087#1086' '#1085#1072#1095#1080#1089#1083#1077#1085#1080#1102' '#1079#1072#1088#1087#1083#1072#1090#1099' '#1074' '#1085#1072#1095#1072#1083#1077' '#1090#1077#1082#1091#1097#1077#1075#1086' ' +
          #1084#1077#1089#1103#1094#1072'. '#13#1044#1086#1082#1091#1084#1077#1085#1090#1099' '#1073#1091#1076#1091#1090' '#1089#1075#1077#1085#1077#1088#1080#1088#1086#1074#1072#1085#1085#1099' '#1076#1083#1103' '#1074#1089#1077#1093' '#1092#1080#1088#1084'.'
        WordWrap = True
        ExplicitWidth = 440
      end
      object Label1: TLabel
        Left = 20
        Top = 80
        Width = 36
        Height = 15
        Caption = #1052#1077#1089#1103#1094
      end
      object btnGen1: TButton
        Left = 20
        Top = 133
        Width = 106
        Height = 32
        Caption = #1043#1077#1085#1077#1088#1080#1088#1086#1074#1072#1090#1100
        TabOrder = 0
        OnClick = btnGen1Click
      end
      object mmInfo1: TMemo
        Left = 148
        Top = 133
        Width = 429
        Height = 152
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 1
      end
      object dtpDate: TDateTimePicker
        Left = 62
        Top = 76
        Width = 186
        Height = 23
        Date = 40940.519957523150000000
        Time = 40940.519957523150000000
        DateFormat = dfLong
        TabOrder = 2
        OnChange = dtpDateChange
      end
    end
  end
end
