object frmActiuneTVAInapoiDlg: TfrmActiuneTVAInapoiDlg
  Left = 0
  Top = 0
  ActiveControl = edCODE
  BorderStyle = bsDialog
  Caption = #1042#1077#1088#1085#1077#1084' '#1053#1044#1057' 20%'
  ClientHeight = 493
  ClientWidth = 560
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    560
    493)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 560
    Height = 64
    Title = 'Intoarcem TVA 20%'
    Text = #206'nregistra'#539'i-v'#259' pentru a primi '#238'napoi TVA.'
    FontTitle.Charset = DEFAULT_CHARSET
    FontTitle.Color = clBlack
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
    Width = 544
    Height = 366
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
    ShowCaption = False
    TabOrder = 1
    object Label1: TLabel
      Left = 20
      Top = 20
      Width = 84
      Height = 15
      Caption = 'Cod participare'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 20
      Top = 41
      Width = 291
      Height = 15
      Caption = 'Introduce'#539'i codul de participare din SMS-ul contrap'#259'r'#539'ii'
    end
    object Label3: TLabel
      Left = 20
      Top = 92
      Width = 127
      Height = 15
      Caption = 'Participant la promotie'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 20
      Top = 113
      Width = 190
      Height = 15
      Caption = 'Cumparator din documentul primar'
    end
    object Label5: TLabel
      Left = 20
      Top = 220
      Width = 76
      Height = 15
      Caption = 'Pa'#537'ii urm'#259'tori'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label6: TLabel
      Left = 20
      Top = 241
      Width = 375
      Height = 30
      Caption = 
        '1. Pre'#539'ul tuturor bunurilor din Rezerva va fi modificat de prima' +
        ' coloan'#259';'#13#10'2. Se va ad'#259'uga un produs nou cu suma de reducere pen' +
        'tru actiune.'
    end
    object Label7: TLabel
      Left = 20
      Top = 292
      Width = 84
      Height = 15
      Caption = 'Nu este permis'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label8: TLabel
      Left = 20
      Top = 313
      Width = 169
      Height = 30
      Caption = '1. Schimba'#539'i contrapartida;'#13#10'2. Modifica'#539'i componen'#539'a pl'#259#539'ii.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Label9: TLabel
      Left = 177
      Top = 142
      Width = 38
      Height = 15
      Caption = 'Telefon'
    end
    object Label10: TLabel
      Left = 20
      Top = 171
      Width = 147
      Height = 15
      Caption = 'Cumparator din doc. curent'
    end
    object edCODE: TcxTextEdit
      Left = 274
      Top = 34
      ParentFont = False
      Properties.CharCase = ecUpperCase
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -15
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = []
      Style.TextStyle = [fsBold]
      Style.IsFontAssigned = True
      TabOrder = 0
      Text = 'XXX-XXX'
      Width = 151
    end
    object btnCheckCode: TButton
      Left = 431
      Top = 34
      Width = 85
      Height = 28
      Caption = 'Validare'
      Default = True
      TabOrder = 1
      OnClick = btnCheckCodeClick
    end
    object edCustomer: TcxTextEdit
      Left = 232
      Top = 110
      TabStop = False
      Properties.ReadOnly = True
      Style.TextColor = clGray
      TabOrder = 2
      Text = #1085#1077#1090#1091
      Width = 284
    end
    object edPhone: TcxTextEdit
      Left = 232
      Top = 139
      TabStop = False
      Properties.ReadOnly = True
      Style.TextColor = clGray
      TabOrder = 3
      Text = #1085#1077#1090#1091
      Width = 125
    end
    object edCurrentCustomer: TcxTextEdit
      Left = 232
      Top = 168
      TabStop = False
      Properties.ReadOnly = True
      TabOrder = 4
      Width = 284
    end
  end
  object btnYes: TButton
    Left = 316
    Top = 449
    Width = 111
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'Aplica'
    ModalResult = 6
    TabOrder = 2
  end
  object Button3: TButton
    Left = 441
    Top = 449
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
end
