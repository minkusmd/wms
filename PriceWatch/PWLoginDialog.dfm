object frmPWLoginDlg: TfrmPWLoginDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'WMS PriceWatch - autentificare'
  ClientHeight = 318
  ClientWidth = 460
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 460
    Height = 64
    Title = 'Autentificare'
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
  object lbUser: TLabel
    Left = 24
    Top = 84
    Width = 54
    Height = 15
    Caption = 'Utilizator'
  end
  object edUser: TcxTextEdit
    Left = 24
    Top = 102
    TabOrder = 0
    Width = 412
  end
  object lbPassword: TLabel
    Left = 24
    Top = 134
    Width = 34
    Height = 15
    Caption = 'Parola'
  end
  object edPassword: TcxTextEdit
    Left = 24
    Top = 152
    Properties.EchoMode = eemPassword
    TabOrder = 1
    Width = 412
  end
  object lbServer: TLabel
    Left = 24
    Top = 184
    Width = 35
    Height = 15
    Caption = 'Server'
  end
  object edServer: TcxTextEdit
    Left = 24
    Top = 202
    TabOrder = 2
    Width = 200
  end
  object lbPort: TLabel
    Left = 232
    Top = 184
    Width = 22
    Height = 15
    Caption = 'Port'
  end
  object edPort: TcxSpinEdit
    Left = 232
    Top = 202
    Properties.MaxValue = 65535.000000000000000000
    Properties.MinValue = 1.000000000000000000
    TabOrder = 3
    Value = 3050
    Width = 72
  end
  object lbDatabase: TLabel
    Left = 312
    Top = 184
    Width = 70
    Height = 15
    Caption = 'Baza de date'
  end
  object edDatabase: TcxTextEdit
    Left = 312
    Top = 202
    TabOrder = 4
    Width = 124
  end
  object lbError: TLabel
    Left = 24
    Top = 238
    Width = 412
    Height = 30
    AutoSize = False
    Caption = ''
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object btnOk: TcxButton
    Left = 210
    Top = 276
    Width = 110
    Height = 31
    Caption = 'Intra'
    Default = True
    ModalResult = 1
    TabOrder = 5
  end
  object btnCancel: TcxButton
    Left = 326
    Top = 276
    Width = 110
    Height = 31
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 6
  end
end
