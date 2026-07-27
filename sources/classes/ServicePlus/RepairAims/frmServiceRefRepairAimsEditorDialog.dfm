object frmServiceRefRepairAimsEditorDlg: TfrmServiceRefRepairAimsEditorDlg
  Left = 0
  Top = 0
  ActiveControl = edTITLE
  BorderStyle = bsDialog
  Caption = #1062#1077#1083#1100' '#1088#1077#1084#1086#1085#1090#1072
  ClientHeight = 413
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
    413)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 564
    Height = 64
    Title = #1062#1077#1083#1100' '#1088#1077#1084#1086#1085#1090#1072
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
    ImageIndex = 23
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 548
    Height = 279
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
    object Label1: TLabel
      Left = 16
      Top = 16
      Width = 52
      Height = 15
      Caption = #1053#1072#1079#1074#1072#1085#1080#1077
    end
    object Label2: TLabel
      Left = 16
      Top = 76
      Width = 55
      Height = 15
      Caption = #1054#1087#1080#1089#1072#1085#1080#1077
    end
    object Label3: TLabel
      Left = 16
      Top = 208
      Width = 161
      Height = 15
      Caption = #1042#1088#1077#1084#1103' '#1085#1072' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1077', '#1095#1072#1089#1086#1074
    end
    object Label4: TLabel
      Left = 264
      Top = 169
      Width = 129
      Height = 15
      Caption = #1042#1099#1073#1088#1072#1085' '#1087#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
    end
    object bbDaysPreset: TSpeedButton
      Left = 143
      Top = 226
      Width = 55
      Height = 23
      Caption = #1076#1085#1080
      OnClick = bbDaysPresetClick
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
      Top = 93
      DataBinding.DataField = 'DESCRIPTION'
      Properties.ScrollBars = ssVertical
      Properties.VisibleLineCount = 3
      TabOrder = 1
      Width = 505
    end
    object cbFLG_ENABLED: TcxDBCheckBox
      Left = 16
      Top = 169
      Caption = #1044#1086#1089#1090#1091#1087#1077#1085
      DataBinding.DataField = 'FLG_ENABLED'
      Properties.Alignment = taLeftJustify
      Properties.ValueChecked = 1
      Properties.ValueUnchecked = 0
      TabOrder = 2
    end
    object ceESTIMATED_HOURS: TcxDBCalcEdit
      Left = 16
      Top = 226
      DataBinding.DataField = 'ESTIMATED_HOURS'
      TabOrder = 5
      Width = 121
    end
    object cbFLG_DEFAULT_GARANT: TcxDBCheckBox
      Left = 264
      Top = 190
      Caption = #1074' '#1088#1077#1084#1086#1085#1090#1077' '#1087#1086' '#1075#1072#1088#1072#1085#1090#1080#1080
      DataBinding.DataField = 'FLG_DEFAULT_GARANT'
      Properties.Alignment = taLeftJustify
      Properties.ValueChecked = 1
      Properties.ValueUnchecked = 0
      TabOrder = 3
    end
    object cbFLG_DEFAULT_REPAIR: TcxDBCheckBox
      Left = 264
      Top = 219
      Caption = #1074' '#1086#1073#1099#1095#1085#1086#1084' '#1088#1077#1084#1086#1085#1090#1077
      DataBinding.DataField = 'FLG_DEFAULT_REPAIR'
      Properties.Alignment = taLeftJustify
      Properties.ValueChecked = 1
      Properties.ValueUnchecked = 0
      TabOrder = 4
    end
  end
  object btnOk: TButton
    Left = 348
    Top = 366
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 452
    Top = 366
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
  object pmDays: TPopupMenu
    Left = 164
    Top = 336
    object N11: TMenuItem
      Tag = 24
      Caption = '1 '#1076#1077#1085#1100
      OnClick = N261Click
    end
    object N31: TMenuItem
      Tag = 48
      Caption = '2 '#1076#1085#1103
      OnClick = N261Click
    end
    object N32: TMenuItem
      Tag = 72
      Caption = '3 '#1076#1085#1103
      OnClick = N261Click
    end
    object N51: TMenuItem
      Tag = 120
      Caption = '5 '#1076#1085#1077#1081
      OnClick = N261Click
    end
    object N141: TMenuItem
      Tag = 336
      Caption = '14 '#1076#1085#1077#1081
      OnClick = N261Click
    end
    object N261: TMenuItem
      Tag = 624
      Caption = '26 '#1076#1085#1103
      OnClick = N261Click
    end
  end
end
