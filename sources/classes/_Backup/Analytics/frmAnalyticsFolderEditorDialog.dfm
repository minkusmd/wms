object frmAnalyticsFolderEditorDlg: TfrmAnalyticsFolderEditorDlg
  Left = 0
  Top = 0
  ActiveControl = edTITLE
  BorderStyle = bsDialog
  Caption = #1043#1088#1091#1087#1087#1072' '#1072#1085#1072#1083#1080#1090#1080#1082
  ClientHeight = 350
  ClientWidth = 372
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    372
    350)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 372
    Height = 64
    Title = #1043#1088#1091#1087#1087#1072' '#1072#1085#1072#1083#1080#1090#1080#1082
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
    ExplicitWidth = 564
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 356
    Height = 216
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
    ExplicitWidth = 548
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
    object edTITLE: TcxDBTextEdit
      Left = 16
      Top = 33
      DataBinding.DataField = 'TITLE'
      TabOrder = 0
      Width = 313
    end
    object mmDESCRIPTION: TcxDBMemo
      Left = 16
      Top = 93
      DataBinding.DataField = 'DESCRIPTION'
      TabOrder = 1
      Height = 89
      Width = 313
    end
  end
  object btnOk: TButton
    Left = 156
    Top = 303
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
    ExplicitLeft = 348
  end
  object btnCancel: TButton
    Left = 260
    Top = 303
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
    ExplicitLeft = 452
  end
end
