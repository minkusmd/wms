object frmBringGoodsDlg: TfrmBringGoodsDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Aduce'#539'i m'#259'rfurile'
  ClientHeight = 272
  ClientWidth = 497
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
    Width = 497
    Height = 64
    Title = 'Aduce'#539'i m'#259'rfurile'
    Text = 'Notifica'#539'i depozitul despre ridicarea bunurilor din factur'#259
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
    Width = 481
    Height = 146
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
      AlignWithMargins = True
      Left = 12
      Top = 12
      Width = 453
      Height = 30
      Margins.Left = 12
      Margins.Top = 12
      Margins.Right = 12
      Margins.Bottom = 4
      Align = alTop
      Caption = 
        'Notifica'#539'i depozitul despre ridicarea bunurilor din factur'#259'.'#13#10'Pe' +
        'ntru ac'#539'iuni suplimentare, introduce'#539'i comentariile de mai jos:'
      WordWrap = True
      ExplicitWidth = 339
    end
    object mmComments: TMemo
      AlignWithMargins = True
      Left = 12
      Top = 46
      Width = 453
      Height = 84
      Margins.Left = 12
      Margins.Top = 0
      Margins.Right = 12
      Margins.Bottom = 12
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      Lines.Strings = (
        'Aduce'#539'i bunurile la magazin!')
      ParentFont = False
      TabOrder = 0
    end
  end
  object btnOk: TcxButton
    Left = 284
    Top = 229
    Width = 90
    Height = 29
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TcxButton
    Left = 388
    Top = 229
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
end
