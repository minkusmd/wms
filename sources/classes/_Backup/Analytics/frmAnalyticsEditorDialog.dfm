object frmAnalyticsEditorDlg: TfrmAnalyticsEditorDlg
  Left = 0
  Top = 0
  ActiveControl = edTITLE
  BorderStyle = bsDialog
  Caption = #1040#1085#1072#1083#1080#1090#1080#1082#1072
  ClientHeight = 419
  ClientWidth = 564
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    564
    419)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 564
    Height = 64
    Title = #1040#1085#1072#1083#1080#1090#1080#1082#1072
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
    Width = 548
    Height = 285
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
    ExplicitHeight = 287
    object Label1: TLabel
      Left = 16
      Top = 16
      Width = 52
      Height = 15
      Caption = #1053#1072#1079#1074#1072#1085#1080#1077
    end
    object Label2: TLabel
      Left = 16
      Top = 148
      Width = 55
      Height = 15
      Caption = #1054#1087#1080#1089#1072#1085#1080#1077
    end
    object Label3: TLabel
      Left = 16
      Top = 72
      Width = 148
      Height = 15
      Caption = #1052#1086#1076#1080#1092#1080#1082#1072#1090#1086#1088#1099' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
    end
    object edTITLE: TcxDBTextEdit
      Left = 16
      Top = 33
      DataBinding.DataField = 'TITLE'
      TabOrder = 0
      Width = 505
    end
    object mmDESCRIPTION: TcxDBMemo
      Left = 16
      Top = 165
      DataBinding.DataField = 'DESCRIPTION'
      TabOrder = 3
      Height = 89
      Width = 505
    end
    object cbFLG_CHANGE_BALANS: TcxDBCheckBox
      Left = 16
      Top = 93
      Caption = #1048#1079#1084#1077#1085#1103#1077#1090' '#1073#1072#1083#1072#1085#1089
      DataBinding.DataField = 'FLG_CHANGE_BALANS'
      Properties.Alignment = taLeftJustify
      Properties.ValueChecked = 1
      Properties.ValueUnchecked = 0
      TabOrder = 1
      Width = 121
    end
    object cbFLG_EXPENSES: TcxDBCheckBox
      Left = 162
      Top = 93
      Caption = #1047#1072#1090#1088#1072#1090#1099
      DataBinding.DataField = 'FLG_EXPENSES'
      Properties.Alignment = taLeftJustify
      Properties.ValueChecked = 1
      Properties.ValueUnchecked = 0
      TabOrder = 2
      Width = 75
    end
    object cbFLG_CALC_SALDO: TcxDBCheckBox
      Left = 260
      Top = 93
      Caption = #1056#1072#1089#1095#1080#1090#1099#1074#1072#1090#1100' '#1089#1072#1083#1100#1076#1086
      DataBinding.DataField = 'FLG_CALC_SALDO'
      Properties.Alignment = taLeftJustify
      Properties.ValueChecked = 1
      Properties.ValueUnchecked = 0
      TabOrder = 4
      Width = 139
    end
  end
  object btnOk: TButton
    Left = 348
    Top = 372
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
    ExplicitTop = 374
  end
  object btnCancel: TButton
    Left = 452
    Top = 372
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
    ExplicitTop = 374
  end
end
