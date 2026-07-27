object frmGoodsImageEventDlg: TfrmGoodsImageEventDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1050#1072#1088#1090#1080#1085#1082#1072' '#1089#1086#1073#1099#1090#1080#1103
  ClientHeight = 281
  ClientWidth = 448
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  DesignSize = (
    448
    281)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 448
    Height = 64
    Title = #1050#1072#1088#1090#1080#1085#1082#1072' '#1089#1086#1073#1099#1090#1080#1103
    Text = #1042#1074#1077#1076#1080#1090#1077' '#1076#1072#1090#1091' '#1089#1086#1073#1099#1090#1080#1103' '#1076#1083#1103' '#1086#1090#1086#1073#1088#1072#1078#1077#1085#1080#1103' '#1074#1099#1073#1088#1072#1085#1085#1086#1081' '#1082#1072#1088#1090#1080#1085#1082#1080
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
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 432
    Height = 147
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
    object cxLabel8: TLabel
      AlignWithMargins = True
      Left = 12
      Top = 8
      Width = 404
      Height = 30
      Margins.Left = 12
      Margins.Top = 8
      Margins.Right = 12
      Margins.Bottom = 8
      Align = alTop
      Caption = 
        #1045#1089#1083#1080' '#1085#1091#1078#1085#1086' '#1074#1099#1074#1077#1089#1090#1080' '#1082#1072#1088#1090#1080#1085#1082#1091' '#1074' '#1086#1087#1088#1077#1076#1077#1083#1077#1085#1085#1099#1081' '#1080#1085#1090#1077#1088#1074#1072#1083' '#1074#1088#1077#1084#1077#1085#1080', '#1074#1082#1083 +
        #1102#1095#1080#1090#1077' '#1085#1080#1078#1085#1102#1102' '#1086#1087#1094#1080#1102
      Transparent = True
      WordWrap = True
      ExplicitWidth = 371
    end
    object lbDateStart: TLabel
      Left = 38
      Top = 77
      Width = 108
      Height = 15
      Caption = #1044#1072#1090#1072' '#1085#1072#1095#1072#1083#1086' '#1087#1086#1082#1072#1079#1072
      Transparent = True
    end
    object lbDateEnd: TLabel
      Left = 214
      Top = 77
      Width = 128
      Height = 15
      Caption = #1044#1072#1090#1072' '#1086#1082#1086#1085#1095#1072#1085#1080#1103' '#1087#1086#1082#1072#1079#1072
      Transparent = True
    end
    object cbSpecialImage: TCheckBox
      Left = 12
      Top = 54
      Width = 153
      Height = 17
      Caption = #1057#1087#1077#1094#1080#1072#1083#1100#1085#1072#1103' '#1082#1072#1088#1090#1080#1085#1082#1072
      TabOrder = 0
    end
    object deDATA_START: TcxDateEdit
      Left = 38
      Top = 98
      EditValue = 0d
      Properties.DateButtons = [btnToday]
      Properties.ImmediatePost = True
      Properties.ShowTime = False
      Properties.WeekNumbers = True
      TabOrder = 2
      Width = 147
    end
    object deDATA_END: TcxDateEdit
      Left = 214
      Top = 96
      EditValue = 0d
      Properties.DateButtons = [btnToday]
      Properties.ImmediatePost = True
      Properties.SaveTime = False
      Properties.ShowTime = False
      Properties.WeekNumbers = True
      TabOrder = 1
      Width = 147
    end
  end
  object btnOk: TcxButton
    Left = 234
    Top = 235
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = '&Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TcxButton
    Left = 338
    Top = 235
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
end
