object frmReportGroupEditorDlg: TfrmReportGroupEditorDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1043#1088#1091#1087#1087#1072' '#1086#1090#1095#1077#1090#1086#1074
  ClientHeight = 237
  ClientWidth = 531
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
    Width = 531
    Height = 64
    Title = #1043#1088#1091#1087#1087#1072' '#1086#1090#1095#1077#1090#1086#1074
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
    Width = 515
    Height = 113
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
      Top = 32
      Width = 96
      Height = 15
      Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1075#1088#1091#1087#1087#1099
    end
    object Label2: TLabel
      Left = 20
      Top = 61
      Width = 62
      Height = 15
      Caption = #1050#1086#1076' '#1087#1086#1080#1089#1082#1072
    end
    object edTITLE: TcxDBTextEdit
      Left = 122
      Top = 29
      DataBinding.DataField = 'TITLE'
      TabOrder = 0
      Width = 371
    end
    object edCODE: TcxDBTextEdit
      Left = 122
      Top = 58
      DataBinding.DataField = 'CODE'
      Properties.CharCase = ecUpperCase
      TabOrder = 1
      Width = 163
    end
  end
  object btnOk: TButton
    Left = 316
    Top = 196
    Width = 90
    Height = 29
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 420
    Top = 196
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Button1'
    ModalResult = 2
    TabOrder = 3
  end
end
