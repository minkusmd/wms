object frmCopyReportDlg: TfrmCopyReportDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1085#1080#1077' '#1086#1090#1095#1077#1090#1072
  ClientHeight = 278
  ClientWidth = 528
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    528
    278)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 528
    Height = 64
    Title = #1050#1086#1087#1080#1088#1086#1074#1072#1085#1080#1077' '#1086#1090#1095#1077#1090#1072
    Text = #1057#1086#1079#1076#1072#1090#1100' '#1082#1086#1087#1080#1102' '#1086#1090#1095#1077#1090#1072' '#1074' '#1074#1099#1073#1088#1072#1085#1085#1099#1077' '#1092#1080#1088#1084#1099
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
  object pnTop: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 512
    Height = 145
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
    object cxLabel1: TLabel
      Left = 22
      Top = 16
      Width = 32
      Height = 15
      Caption = #1054#1090#1095#1077#1090
    end
    object edReportTitle: TcxTextEdit
      Left = 82
      Top = 33
      TabStop = False
      Properties.ReadOnly = True
      TabOrder = 1
      Text = 'edReportTitle'
      Width = 404
    end
    object edReportID: TcxTextEdit
      Left = 22
      Top = 33
      TabStop = False
      Properties.Alignment.Horz = taRightJustify
      Properties.ReadOnly = True
      TabOrder = 0
      Width = 54
    end
    object cbDontCopyFirmsRights: TCheckBox
      Left = 22
      Top = 79
      Width = 243
      Height = 17
      Caption = #1053#1077' '#1082#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1044#1086#1089#1090#1091#1087' '#1082' '#1092#1080#1088#1084#1072#1084
      Checked = True
      State = cbChecked
      TabOrder = 2
    end
  end
  object btnOk: TcxButton
    Left = 311
    Top = 232
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TcxButton
    Left = 415
    Top = 232
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
  object IBCTrUpdate: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 468
    Top = 12
  end
end
