object frmDescriptionTemplateEditorDlg: TfrmDescriptionTemplateEditorDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1064#1072#1073#1083#1086#1085' '#1086#1087#1080#1089#1072#1085#1080#1103
  ClientHeight = 237
  ClientWidth = 413
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  DesignSize = (
    413
    237)
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 413
    Height = 64
    Title = #1064#1072#1073#1083#1086#1085' '#1086#1087#1080#1089#1072#1085#1080#1103
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
    Width = 397
    Height = 110
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
      Top = 20
      Width = 58
      Height = 15
      Caption = 'Denumirea'
    end
    object Label2: TLabel
      Left = 16
      Top = 49
      Width = 52
      Height = 15
      Caption = #1053#1072#1079#1074#1072#1085#1080#1077
    end
    object edTITLE_ROM: TcxDBTextEdit
      Left = 83
      Top = 17
      DataBinding.DataField = 'TITLE_ROM'
      TabOrder = 0
      Width = 290
    end
    object edTITLE_RUS: TcxDBTextEdit
      Left = 83
      Top = 46
      DataBinding.DataField = 'TITLE_RUS'
      TabOrder = 1
      Width = 290
    end
  end
  object btnOk: TcxButton
    Left = 204
    Top = 193
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TcxButton
    Left = 307
    Top = 193
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
end
