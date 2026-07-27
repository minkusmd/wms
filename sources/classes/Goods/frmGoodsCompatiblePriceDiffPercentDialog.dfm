object frmGoodsCompatiblePriceDiffPercentDlg: TfrmGoodsCompatiblePriceDiffPercentDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1062#1077#1085#1086#1074#1072#1103' '#1088#1072#1079#1085#1080#1094#1072', %'
  ClientHeight = 288
  ClientWidth = 518
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    518
    288)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 518
    Height = 64
    Title = #1062#1077#1085#1086#1074#1072#1103' '#1088#1072#1079#1085#1080#1094#1072', %'
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
    Width = 502
    Height = 155
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
    object Label1: TLabel
      Left = 16
      Top = 63
      Width = 95
      Height = 15
      Caption = #1062#1077#1085#1086#1074#1072#1103' '#1088#1072#1079#1085#1080#1094#1072
    end
    object Label2: TLabel
      Left = 207
      Top = 63
      Width = 10
      Height = 15
      Caption = '%'
    end
    object Label3: TLabel
      Left = 16
      Top = 19
      Width = 32
      Height = 15
      Caption = #1058#1086#1074#1072#1088
    end
    object cmbDIFFSUMPERCENT: TcxDBComboBox
      Left = 117
      Top = 59
      DataBinding.DataField = 'DIFFSUMPERCENT'
      Properties.DropDownListStyle = lsFixedList
      Properties.Items.Strings = (
        '1'
        '2'
        '3')
      TabOrder = 1
      Width = 84
    end
    object cbMakeDefault: TCheckBox
      Left = 16
      Top = 100
      Width = 222
      Height = 17
      Caption = #1057#1076#1077#1083#1072#1090#1100' '#1079#1085#1072#1095#1077#1085#1080#1077' '#1087#1086' '#1091#1087#1086#1083#1095#1072#1085#1080#1102
      TabOrder = 2
    end
    object edCOMPATIBLE_GOODS_NAME: TcxDBTextEdit
      Left = 55
      Top = 16
      TabStop = False
      DataBinding.DataField = 'COMPATIBLE_GOODS_NAME'
      Properties.ReadOnly = True
      TabOrder = 0
      Width = 426
    end
  end
  object btnOk: TcxButton
    Left = 309
    Top = 242
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = '&Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TcxButton
    Left = 413
    Top = 242
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
end
