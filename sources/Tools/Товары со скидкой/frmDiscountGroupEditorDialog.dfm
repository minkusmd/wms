object frmDiscountGroupEditorDlg: TfrmDiscountGroupEditorDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1043#1088#1091#1087#1087#1072' '#1090#1086#1074#1072#1088#1086#1074' '#1076#1083#1103' '#1072#1082#1094#1080#1080
  ClientHeight = 467
  ClientWidth = 466
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
    Width = 466
    Height = 64
    Title = #1043#1088#1091#1087#1087#1072' '#1090#1086#1074#1072#1088#1086#1074' '#1076#1083#1103' '#1072#1082#1094#1080#1080
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
    ImageIndex = 0
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 450
    Height = 341
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
      Width = 88
      Height = 15
      Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1072#1082#1094#1080#1080
    end
    object Label2: TLabel
      Left = 20
      Top = 72
      Width = 42
      Height = 15
      Caption = #1055#1077#1088#1080#1086#1076
    end
    object Label4: TLabel
      Left = 20
      Top = 124
      Width = 61
      Height = 15
      Caption = #1058#1080#1087' '#1089#1082#1080#1076#1082#1080
    end
    object Label6: TLabel
      Left = 20
      Top = 187
      Width = 196
      Height = 15
      Caption = #1058#1077#1082#1089#1090' SMS '#1086#1087#1086#1074#1077#1097#1077#1085#1080#1103' (ASCII only!)'
    end
    object sbTags: TSpeedButton
      Left = 356
      Top = 204
      Width = 69
      Height = 25
      Caption = #1058#1101#1075#1080
      OnClick = sbTagsClick
    end
    object sbSendTestSMS: TSpeedButton
      Left = 20
      Top = 295
      Width = 121
      Height = 26
      Caption = #1058#1077#1089#1090#1086#1074#1099#1081' SMS'
      OnClick = sbSendTestSMSClick
    end
    object Label3: TLabel
      Left = 356
      Top = 244
      Width = 55
      Height = 45
      Caption = '~ - '#1076#1083#1103' '#1087#1077#1088#1077#1085#1086#1089#1072' '#1089#1090#1088#1086#1082#1080'!'
      WordWrap = True
    end
    object edTITLE: TcxDBTextEdit
      Left = 20
      Top = 37
      DataBinding.DataField = 'TITLE'
      TabOrder = 0
      Width = 405
    end
    object deSTART_DATE: TcxDBDateEdit
      Left = 20
      Top = 89
      DataBinding.DataField = 'START_DATE'
      TabOrder = 1
      Width = 121
    end
    object deEND_DATE: TcxDBDateEdit
      Left = 156
      Top = 89
      DataBinding.DataField = 'END_DATE'
      TabOrder = 2
      Width = 121
    end
    object cmbDISCOUNT_TYPE: TcxComboBox
      Left = 20
      Top = 141
      Properties.DropDownListStyle = lsFixedList
      Properties.Items.Strings = (
        #1055#1088#1086#1094#1077#1085#1090
        #1060#1080#1082#1089#1080#1088#1086#1074#1072#1085#1085#1072#1103' '#1089#1091#1084#1084#1072)
      TabOrder = 3
      Width = 257
    end
    object mmSMS: TcxDBMemo
      Left = 20
      Top = 204
      DataBinding.DataField = 'SMS_TEMPLATE'
      ParentFont = False
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -13
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = []
      Style.IsFontAssigned = True
      TabOrder = 4
      Height = 85
      Width = 325
    end
  end
  object btnOk: TButton
    Left = 251
    Top = 424
    Width = 90
    Height = 29
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 355
    Top = 424
    Width = 90
    Height = 29
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
  object pmTags: TPopupMenu
    Left = 388
    Top = 232
    object N1: TMenuItem
      Tag = 1
      Caption = #1050#1086#1076' '#1089#1082#1080#1076#1082#1080
      OnClick = N2Click
    end
    object N2: TMenuItem
      Tag = 2
      Caption = #1047#1085#1072#1095#1077#1085#1080#1077' '#1089#1082#1080#1076#1082#1080
      OnClick = N2Click
    end
  end
  object IBCTrSMSUpdate: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 388
    Top = 152
  end
end
