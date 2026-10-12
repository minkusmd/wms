object frmECCReceiptSendDlg: TfrmECCReceiptSendDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Bon fiscal - casa ECC'
  ClientHeight = 315
  ClientWidth = 420
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 16
  object lblSummary: TLabel
    AlignWithMargins = True
    Left = 16
    Top = 12
    Width = 388
    Height = 16
    Margins.Left = 16
    Margins.Top = 12
    Margins.Right = 16
    Margins.Bottom = 0
    Align = alTop
    Caption = 'Bonul care se emite'
    WordWrap = True
  end
  object rgKinds: TRadioGroup
    AlignWithMargins = True
    Left = 16
    Top = 40
    Width = 388
    Height = 136
    Margins.Left = 16
    Margins.Top = 12
    Margins.Right = 16
    Margins.Bottom = 0
    Align = alTop
    Caption = ' Cum primeste clientul bonul '
    Items.Strings = (
      'Tiparit pe imprimanta'
      'Pe e-mail (produsele + linkul de verificare SFS)'
      'Pe Viber (imaginea bonului)'
      'Prin SMS (suma + linkul de verificare SFS)'
      'Fara actiune (bonul doar se emite si se inregistreaza in MEV)')
    TabOrder = 0
    OnClick = rgKindsClick
  end
  object lblContact: TLabel
    AlignWithMargins = True
    Left = 16
    Top = 188
    Width = 388
    Height = 16
    Margins.Left = 16
    Margins.Top = 12
    Margins.Right = 16
    Margins.Bottom = 0
    Align = alTop
    Caption = 'Contactul clientului:'
  end
  object edContact: TEdit
    AlignWithMargins = True
    Left = 16
    Top = 206
    Width = 388
    Height = 24
    Margins.Left = 16
    Margins.Top = 2
    Margins.Right = 16
    Margins.Bottom = 0
    Align = alTop
    TabOrder = 1
  end
  object pnBottom: TPanel
    Left = 0
    Top = 260
    Width = 420
    Height = 55
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object btnOK: TButton
      Left = 212
      Top = 16
      Width = 104
      Height = 27
      Anchors = [akTop, akRight]
      Caption = 'Emite bonul'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
    object btnCancel: TButton
      Left = 324
      Top = 16
      Width = 80
      Height = 27
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Renunta'
      ModalResult = 2
      TabOrder = 1
    end
  end
end
