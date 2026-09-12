object frmApplyPromoCodeDlg: TfrmApplyPromoCodeDlg
  Left = 0
  Top = 0
  ActiveControl = edCode
  BorderStyle = bsDialog
  Caption = 'Promo cod'
  ClientHeight = 375
  ClientWidth = 439
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
    Width = 439
    Height = 64
    Title = 'Promo cod'
    Text = 'Aplicarea unui cod promo'#539'ional la vinzare'
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
    Width = 423
    Height = 249
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
    object Label2: TLabel
      Left = 20
      Top = 20
      Width = 59
      Height = 15
      Caption = 'Promo cod'
    end
    object Label1: TLabel
      Left = 20
      Top = 80
      Width = 61
      Height = 15
      Caption = 'Validare log'
    end
    object edCode: TEdit
      Left = 20
      Top = 37
      Width = 225
      Height = 28
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      Text = 'XXXX-XXXX'
    end
    object btnCheck: TButton
      Left = 251
      Top = 37
      Width = 82
      Height = 28
      Caption = 'Validare'
      Default = True
      TabOrder = 1
      OnClick = btnCheckClick
    end
    object mmInfo: TMemo
      Left = 20
      Top = 97
      Width = 377
      Height = 124
      TabStop = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 2
    end
  end
  object btnOk: TButton
    Left = 229
    Top = 332
    Width = 90
    Height = 29
    Caption = 'Aplica'
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 332
    Top = 332
    Width = 90
    Height = 29
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
end
