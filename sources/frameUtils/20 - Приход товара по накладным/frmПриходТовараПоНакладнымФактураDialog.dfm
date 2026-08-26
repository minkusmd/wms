object frmPTNInvoiceDlg: TfrmPTNInvoiceDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1057#1095#1077#1090'-'#1060#1072#1082#1090#1091#1088#1099
  ClientHeight = 287
  ClientWidth = 371
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
    Width = 371
    Height = 64
    Title = #1057#1095#1077#1090'-'#1060#1072#1082#1090#1091#1088#1099
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
    ImageIndex = 20
    ExplicitLeft = 184
    ExplicitTop = 88
    ExplicitWidth = 0
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 355
    Height = 161
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
      Top = 20
      Width = 89
      Height = 15
      Caption = #1053#1086#1084#1077#1088' '#1092#1072#1082#1090#1091#1088#1099
    end
    object Label2: TLabel
      Left = 20
      Top = 84
      Width = 69
      Height = 15
      Caption = #1044#1072#1090#1072' '#1074#1099#1076#1072#1095#1080
    end
    object edFACTURANO: TcxDBTextEdit
      Left = 20
      Top = 37
      DataBinding.DataField = 'FACTURANO'
      Properties.CharCase = ecUpperCase
      TabOrder = 0
      Width = 185
    end
    object deDATA_ELIBERARII: TcxDBDateEdit
      Left = 20
      Top = 101
      DataBinding.DataField = 'DATA_ELIBERARII'
      Properties.SaveTime = False
      Properties.ShowTime = False
      Properties.WeekNumbers = True
      TabOrder = 1
      Width = 185
    end
  end
  object btnOk: TButton
    Left = 152
    Top = 244
    Width = 90
    Height = 29
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 260
    Top = 244
    Width = 90
    Height = 29
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
end
