object frmForcedPerioudSetupDlg: TfrmForcedPerioudSetupDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Indicatorii produselor din pricelist'
  ClientHeight = 250
  ClientWidth = 415
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
    Width = 415
    Height = 64
    Title = 'Arata in lista de preturi si web'
    Text = 
      #1055#1077#1088#1080#1086#1076' '#1076#1077#1081#1089#1090#1074#1080#1103' "'#1042#1089#1077#1075#1076#1072' '#1087#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1074' '#1087#1088#1072#1081#1089#1077'" '#1076#1083#1103' '#1074#1089#1077#1093' '#1090#1086#1074#1072#1088#1086#1074#13#10'P' +
      'erioada in care produsele vor fi arate in lista de preturi'
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
    Width = 399
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
      Width = 91
      Height = 15
      Caption = 'Sfirsitul perioadei'
    end
    object sbPreset1: TSpeedButton
      Tag = 7
      Left = 134
      Top = 64
      Width = 57
      Height = 23
      Caption = '7 zile'
      OnClick = sbPreset4Click
    end
    object Label2: TLabel
      Left = 20
      Top = 68
      Width = 65
      Height = 15
      Caption = 'Setari rapide'
    end
    object sbPreset2: TSpeedButton
      Tag = 14
      Left = 197
      Top = 64
      Width = 57
      Height = 23
      Caption = '14 zile'
      OnClick = sbPreset4Click
    end
    object sbPreset3: TSpeedButton
      Tag = 24
      Left = 260
      Top = 64
      Width = 57
      Height = 23
      Caption = '30 zile'
      OnClick = sbPreset4Click
    end
    object sbPreset4: TSpeedButton
      Tag = 30
      Left = 323
      Top = 64
      Width = 57
      Height = 23
      Caption = '60 zile'
      OnClick = sbPreset4Click
    end
    object deDate: TcxDateEdit
      Left = 134
      Top = 25
      Properties.SaveTime = False
      Properties.ShowTime = False
      Properties.WeekNumbers = True
      TabOrder = 0
      Width = 145
    end
  end
  object btnOk: TButton
    Left = 204
    Top = 208
    Width = 90
    Height = 29
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 300
    Top = 208
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
end
