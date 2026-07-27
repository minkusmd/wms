object frmSelectDBUserDlg: TfrmSelectDBUserDlg
  Left = 0
  Top = 0
  ActiveControl = lvUsers
  BorderStyle = bsDialog
  Caption = #1042#1099#1073#1086#1088' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103' '#1080#1079' '#1073#1072#1079#1099' '#1076#1072#1085#1085#1099#1093
  ClientHeight = 529
  ClientWidth = 365
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    365
    529)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 365
    Height = 64
    Title = #1042#1099#1073#1086#1088' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103' '#1080#1079' '#1073#1072#1079#1099' '#1076#1072#1085#1085#1099#1093
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
    ExplicitLeft = 144
    ExplicitTop = 224
    ExplicitWidth = 0
  end
  object lvUsers: TListView
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 349
    Height = 401
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    Columns = <
      item
        Caption = 'ID'
      end
      item
        AutoSize = True
        Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
      end>
    ReadOnly = True
    RowSelect = True
    TabOrder = 1
    ViewStyle = vsReport
    OnSelectItem = lvUsersSelectItem
    ExplicitWidth = 484
  end
  object btnOk: TButton
    Left = 155
    Top = 486
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'Ok'
    Default = True
    TabOrder = 2
    OnClick = btnOkClick
    ExplicitTop = 496
  end
  object btnCancel: TButton
    Left = 259
    Top = 486
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
    ExplicitTop = 496
  end
end
