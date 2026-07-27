object frmTaskConfigDlg: TfrmTaskConfigDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1047#1072#1076#1072#1095#1072
  ClientHeight = 374
  ClientWidth = 413
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnShow = FormShow
  DesignSize = (
    413
    374)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 413
    Height = 64
    Title = #1047#1072#1076#1072#1095#1072
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
    Width = 397
    Height = 241
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
      Left = 16
      Top = 12
      Width = 92
      Height = 15
      Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1079#1072#1076#1072#1095#1080
    end
    object Label2: TLabel
      Left = 16
      Top = 104
      Width = 105
      Height = 15
      Caption = #1042#1088#1077#1084#1103' '#1080#1089#1087#1086#1083#1085#1077#1085#1080#1103
    end
    object Label4: TLabel
      Left = 335
      Top = 124
      Width = 35
      Height = 15
      Caption = #1095#1095':'#1084#1084
    end
    object Label5: TLabel
      Left = 16
      Top = 165
      Width = 234
      Height = 15
      Caption = #1047#1072#1076#1072#1095#1072' '#1076#1083#1103' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1103' (Stored procedure)'
    end
    object cbEnabled: TCheckBox
      Left = 16
      Top = 68
      Width = 113
      Height = 17
      Caption = #1047#1072#1076#1072#1095#1072' '#1072#1082#1090#1080#1074#1085#1072
      TabOrder = 1
    end
    object edTaskTitle: TEdit
      Left = 16
      Top = 29
      Width = 357
      Height = 23
      TabOrder = 0
    end
    object cmbCalendarTarget: TComboBox
      Left = 16
      Top = 121
      Width = 145
      Height = 23
      Style = csDropDownList
      Enabled = False
      ItemIndex = 0
      TabOrder = 2
      Text = #1050#1072#1078#1076#1099#1081' '#1076#1077#1085#1100
      Items.Strings = (
        #1050#1072#1078#1076#1099#1081' '#1076#1077#1085#1100
        #1050#1072#1078#1076#1091#1102' '#1085#1077#1076#1077#1083#1100#1102
        #1050#1072#1078#1076#1099#1081' '#1084#1077#1089#1103#1081#1094)
    end
    object edTime: TEdit
      Left = 291
      Top = 121
      Width = 38
      Height = 23
      TabOrder = 3
    end
    object cmbStoredProcedure: TComboBox
      Left = 16
      Top = 182
      Width = 357
      Height = 23
      CharCase = ecUpperCase
      TabOrder = 4
    end
    object cmbRunMode: TComboBox
      Left = 167
      Top = 121
      Width = 118
      Height = 23
      Style = csDropDownList
      TabOrder = 5
      Items.Strings = (
        #1090#1086#1095#1085#1086' '#1074
        #1095#1077#1088#1077#1079' '#1080#1085#1090#1077#1088#1074#1072#1083)
    end
  end
  object btnOk: TButton
    Left = 197
    Top = 328
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'Ok'
    Default = True
    TabOrder = 2
    OnClick = btnOkClick
  end
  object btnCancel: TButton
    Left = 301
    Top = 328
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
end
