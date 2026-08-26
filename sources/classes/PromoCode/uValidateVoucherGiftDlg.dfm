object frmValidateVoucherGiftDlg: TfrmValidateVoucherGiftDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Validarea voucherului cadou'
  ClientHeight = 336
  ClientWidth = 397
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 397
    Height = 64
    Title = 'Voucher cadou'
    Text = 'Validarea codului'
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
    ImageIndex = 2
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 381
    Height = 201
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
      Top = 52
      Width = 61
      Height = 13
      Caption = 'Cod voucher'
    end
    object Label4: TLabel
      Left = 20
      Top = 20
      Width = 80
      Height = 15
      Caption = '1. Validare cod'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 20
      Top = 99
      Width = 73
      Height = 15
      Caption = '2. Informatie'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbInfo: TLabel
      Left = 20
      Top = 117
      Width = 337
      Height = 60
      AutoSize = False
      Caption = '...'
    end
    object edCode: TEdit
      Left = 104
      Top = 49
      Width = 157
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 1
      Text = 'XXXX-XXXX-XXXX-XXXX'
    end
    object btnCheck: TButton
      Left = 267
      Top = 47
      Width = 90
      Height = 25
      Caption = 'Valideaza'
      TabOrder = 0
      OnClick = btnCheckClick
    end
  end
  object btnClose: TButton
    Left = 229
    Top = 299
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 2
  end
  object btnApply: TButton
    Left = 92
    Top = 299
    Width = 119
    Height = 29
    Caption = 'Aplica'
    TabOrder = 3
  end
end
