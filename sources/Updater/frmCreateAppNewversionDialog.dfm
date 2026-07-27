object frmCreateAppNewversionDlg: TfrmCreateAppNewversionDlg
  Left = 0
  Top = 0
  ActiveControl = mmInfo
  BorderStyle = bsDialog
  Caption = 'Crearea versiunii noi a aplicatiei'
  ClientHeight = 600
  ClientWidth = 564
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  DesignSize = (
    564
    600)
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 564
    Height = 64
    Title = 'Crearea versiunii noi a aplicatiei'
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
    Width = 548
    Height = 465
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
      Top = 156
      Width = 142
      Height = 15
      Caption = 'Versiunea noua  a aplicatiei'
    end
    object Label2: TLabel
      Left = 20
      Top = 16
      Width = 100
      Height = 15
      Caption = 'Versiunea aplicatiei'
    end
    object lbAppVersion: TLabel
      Left = 170
      Top = 156
      Width = 37
      Height = 15
      Caption = '0.0.0.0'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbDBAppVersion: TLabel
      Left = 126
      Top = 16
      Width = 37
      Height = 15
      Caption = '0.0.0.0'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbTitle: TLabel
      Left = 20
      Top = 223
      Width = 125
      Height = 15
      Caption = 'Ce nou in veriunea data'
    end
    object lbProgress: TLabel
      Left = 20
      Top = 399
      Width = 501
      Height = 18
      Alignment = taCenter
      AutoSize = False
      Caption = 'lbProgress'
    end
    object mmInfo: TMemo
      Left = 20
      Top = 240
      Width = 501
      Height = 125
      ScrollBars = ssVertical
      TabOrder = 5
    end
    object pbProgressBar: TProgressBar
      Left = 20
      Top = 376
      Width = 501
      Height = 17
      TabOrder = 6
    end
    object cbCritical: TCheckBox
      Left = 20
      Top = 188
      Width = 166
      Height = 17
      Caption = 'Update critic'
      Checked = True
      State = cbChecked
      TabOrder = 3
    end
    object mmPrevVersion: TMemo
      Left = 20
      Top = 33
      Width = 501
      Height = 88
      TabStop = False
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
    end
    object rbFullInstall: TRadioButton
      Left = 408
      Top = 156
      Width = 113
      Height = 17
      Caption = 'Instalare completa'
      TabOrder = 1
    end
    object rbUpdate: TRadioButton
      Left = 408
      Top = 179
      Width = 113
      Height = 17
      Caption = 'Update'
      Checked = True
      TabOrder = 2
      TabStop = True
    end
    object rbSpecialUpdate: TRadioButton
      Left = 408
      Top = 202
      Width = 113
      Height = 17
      Caption = 'Update special'
      TabOrder = 4
    end
    object btnCreate: TcxButton
      Left = 336
      Top = 423
      Width = 185
      Height = 29
      Caption = 'Creaza si inchide'
      TabOrder = 7
      OnClick = btnCreateClick
    end
  end
  object btnClose: TcxButton
    Left = 224
    Top = 563
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Inchide'
    ModalResult = 2
    TabOrder = 2
  end
end
