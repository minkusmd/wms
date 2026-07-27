object frmSalaryInfoCopyDlg: TfrmSalaryInfoCopyDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1085#1080#1077' '#1076#1072#1085#1085#1099#1093
  ClientHeight = 241
  ClientWidth = 367
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  TextHeight = 15
  object DialogTitle1: TDialogTitle
    Left = 0
    Top = 0
    Width = 367
    Height = 64
    Title = #1050#1086#1087#1080#1088#1086#1074#1072#1085#1080#1077' '#1076#1072#1085#1085#1099#1093
    Text = #1050#1086#1087#1080#1088#1086#1074#1072#1085#1080#1077' '#1076#1072#1085#1085#1099#1093' '#1080#1079' '#1086#1076#1085#1086#1075#1086' '#1084#1077#1089#1103#1094#1072' '#1074' '#1076#1088#1091#1075#1086#1081
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
    ImageIndex = 16
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 351
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
    TabOrder = 1
    object Label1: TLabel
      Left = 20
      Top = 24
      Width = 57
      Height = 15
      Caption = #1048#1079' '#1084#1077#1089#1103#1094#1072
    end
    object Label2: TLabel
      Left = 20
      Top = 53
      Width = 83
      Height = 15
      Caption = #1042' '#1085#1086#1074#1099#1081' '#1084#1077#1089#1103#1094
    end
    object cmbYear: TcxComboBox
      Left = 236
      Top = 50
      Properties.DropDownListStyle = lsFixedList
      Properties.DropDownRows = 12
      TabOrder = 3
      Width = 91
    end
    object cmbMonth: TcxComboBox
      Left = 109
      Top = 50
      Properties.DropDownListStyle = lsFixedList
      Properties.DropDownRows = 12
      TabOrder = 2
      Width = 121
    end
    object edMonthStart: TcxTextEdit
      Left = 109
      Top = 21
      TabStop = False
      Properties.ReadOnly = True
      TabOrder = 0
      Text = 'edMonthStart'
      Width = 121
    end
    object edYearStart: TcxTextEdit
      Left = 236
      Top = 21
      TabStop = False
      Properties.ReadOnly = True
      TabOrder = 1
      Text = 'cxTextEdit1'
      Width = 91
    end
  end
  object btnOk: TButton
    Left = 150
    Top = 196
    Width = 90
    Height = 29
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 255
    Top = 196
    Width = 90
    Height = 29
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
end
