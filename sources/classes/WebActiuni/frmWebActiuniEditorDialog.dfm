object frmWebActiuniEditorDlg: TfrmWebActiuniEditorDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1042#1077#1073'-'#1072#1082#1094#1080#1103
  ClientHeight = 514
  ClientWidth = 847
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
    Width = 847
    Height = 64
    Title = #1042#1077#1073'-'#1072#1082#1094#1080#1103
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
    ImageIndex = 30
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 831
    Height = 381
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
      Top = 20
      Width = 52
      Height = 15
      Caption = #1053#1072#1079#1074#1072#1085#1080#1077
    end
    object Label2: TLabel
      Left = 20
      Top = 116
      Width = 55
      Height = 15
      Caption = #1054#1087#1080#1089#1072#1085#1080#1077
    end
    object Label3: TLabel
      Left = 32
      Top = 44
      Width = 45
      Height = 15
      Caption = #1056#1091#1089#1089#1082#1080#1081
    end
    object Label4: TLabel
      Left = 33
      Top = 73
      Width = 44
      Height = 15
      Caption = 'Rom'#226'na'
    end
    object Label5: TLabel
      Left = 32
      Top = 169
      Width = 44
      Height = 15
      Caption = 'Rom'#226'na'
    end
    object Label6: TLabel
      Left = 32
      Top = 140
      Width = 45
      Height = 15
      Caption = #1056#1091#1089#1089#1082#1080#1081
    end
    object Label7: TLabel
      Left = 17
      Top = 212
      Width = 93
      Height = 15
      Caption = #1044#1072#1090#1072' '#1087#1088#1086#1074#1077#1076#1077#1085#1080#1103
    end
    object Label8: TLabel
      Left = 32
      Top = 236
      Width = 42
      Height = 15
      Caption = #1053#1072#1095#1072#1083#1086
    end
    object Label9: TLabel
      Left = 216
      Top = 236
      Width = 34
      Height = 15
      Caption = #1050#1086#1085#1077#1094
    end
    object Label10: TLabel
      Left = 20
      Top = 278
      Width = 172
      Height = 15
      Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1087#1080#1084#1087#1086#1095#1082#1080' '#1074' '#1082#1072#1090#1072#1083#1086#1075#1077
    end
    object Label11: TLabel
      Left = 29
      Top = 304
      Width = 45
      Height = 15
      Caption = #1056#1091#1089#1089#1082#1080#1081
    end
    object Label12: TLabel
      Left = 30
      Top = 333
      Width = 44
      Height = 15
      Caption = 'Rom'#226'na'
    end
    object Label13: TLabel
      Left = 452
      Top = 20
      Width = 191
      Height = 15
      Caption = #1050#1072#1088#1090#1080#1085#1082#1072' '#1076#1083#1103' '#1085#1072#1083#1086#1078#1077#1085#1080#1103' (240x240)'
    end
    object Label14: TLabel
      Left = 724
      Top = 20
      Width = 82
      Height = 15
      Caption = #1048#1082#1086#1085#1082#1072' (48x48)'
    end
    object Label15: TLabel
      Left = 452
      Top = 301
      Width = 105
      Height = 15
      Caption = #1057#1089#1099#1083#1082#1072' '#1085#1072' '#1085#1086#1074#1086#1089#1090#1100
    end
    object edTITLE_RUS: TcxDBTextEdit
      Left = 83
      Top = 41
      DataBinding.DataField = 'TITLE_RUS'
      TabOrder = 0
      Width = 262
    end
    object edTITLE_ROM: TcxDBTextEdit
      Left = 83
      Top = 70
      DataBinding.DataField = 'TITLE_ROM'
      TabOrder = 1
      Width = 262
    end
    object edTEXT_RUS: TcxDBTextEdit
      Left = 83
      Top = 137
      DataBinding.DataField = 'TEXT_RUS'
      TabOrder = 2
      Width = 294
    end
    object edTEXT_ROM: TcxDBTextEdit
      Left = 82
      Top = 166
      DataBinding.DataField = 'TEXT_ROM'
      TabOrder = 3
      Width = 295
    end
    object deSTART_DATE: TcxDBDateEdit
      Left = 80
      Top = 233
      DataBinding.DataField = 'START_DATE'
      Properties.DateButtons = [btnToday]
      Properties.ImmediatePost = True
      Properties.SaveTime = False
      Properties.ShowTime = False
      Properties.WeekNumbers = True
      TabOrder = 4
      Width = 121
    end
    object deEND_DATE: TcxDBDateEdit
      Left = 256
      Top = 233
      DataBinding.DataField = 'END_DATE'
      Properties.DateButtons = [btnToday]
      Properties.ImmediatePost = True
      Properties.SaveTime = False
      Properties.ShowTime = False
      Properties.WeekNumbers = True
      TabOrder = 5
      Width = 121
    end
    object edBUTTON_TITLE_RUS: TcxDBTextEdit
      Left = 80
      Top = 301
      DataBinding.DataField = 'BUTTON_TITLE_RUS'
      TabOrder = 7
      Width = 262
    end
    object edBUTTON_TITLE_ROM: TcxDBTextEdit
      Left = 80
      Top = 330
      DataBinding.DataField = 'BUTTON_TITLE_ROM'
      TabOrder = 8
      Width = 262
    end
    object edNAV_LINK: TcxDBTextEdit
      Left = 452
      Top = 322
      DataBinding.DataField = 'NAV_LINK'
      TabOrder = 9
      Width = 353
    end
    object imgOVERLAY: TcxImage
      Left = 452
      Top = 41
      Properties.GraphicClassName = 'TdxPNGImage'
      Properties.ImmediatePost = True
      Properties.PopupMenuLayout.MenuItems = [pmiCopy, pmiPaste, pmiLoad, pmiSave]
      Properties.OnChange = imgOVERLAYPropertiesChange
      Style.Color = clSilver
      TabOrder = 10
      Height = 244
      Width = 244
    end
    object imgICON: TcxImage
      Left = 724
      Top = 41
      Properties.GraphicClassName = 'TdxPNGImage'
      Properties.ImmediatePost = True
      Properties.PopupMenuLayout.MenuItems = [pmiCopy, pmiPaste, pmiLoad, pmiSave]
      Properties.OnChange = imgOVERLAYPropertiesChange
      Style.Color = clSilver
      TabOrder = 11
      Height = 52
      Width = 52
    end
    object cbFLG_HIDE_BUTTON: TcxDBCheckBox
      Left = 240
      Top = 276
      Caption = #1053#1077' '#1087#1086#1082#1072#1079#1099#1074#1072#1090#1100
      DataBinding.DataField = 'FLG_HIDE_BUTTON'
      Properties.ImmediatePost = True
      Properties.ValueChecked = 1
      Properties.ValueUnchecked = 0
      TabOrder = 6
    end
  end
  object btnOk: TButton
    Left = 636
    Top = 468
    Width = 90
    Height = 29
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 740
    Top = 468
    Width = 90
    Height = 29
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
end
