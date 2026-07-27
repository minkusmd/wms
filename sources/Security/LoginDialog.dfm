object frmLoginDlg: TfrmLoginDlg
  Left = 0
  Top = 0
  AutoSize = True
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  BorderWidth = 8
  Caption = 'Autentificare in sistem'
  ClientHeight = 309
  ClientWidth = 432
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyUp = FormKeyUp
  OnShow = FormShow
  TextHeight = 13
  object pnButtons: TPanel
    Left = 0
    Top = 261
    Width = 432
    Height = 48
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object btnLogin: TcxButton
      Left = 226
      Top = 13
      Width = 90
      Height = 29
      Caption = 'Intra'
      Default = True
      TabOrder = 0
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      OnClick = btnLoginClick
    end
    object btnClose: TcxButton
      Left = 332
      Top = 13
      Width = 90
      Height = 29
      Cancel = True
      Caption = 'Renunta'
      ModalResult = 2
      TabOrder = 2
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TcxLabel
      AlignWithMargins = True
      Left = 8
      Top = 11
      AutoSize = False
      Caption = 'Ctrl+F11 - Optiuni'
      Properties.ShowAccelChar = False
      TabOrder = 1
      Transparent = True
      Visible = False
      Height = 22
      Width = 145
    end
  end
  object pnMain: TPanel
    Left = 0
    Top = 0
    Width = 432
    Height = 261
    Align = alTop
    AutoSize = True
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 0
    object Bevel1: TBevel
      Left = 0
      Top = 0
      Width = 428
      Height = 165
      Align = alTop
      Shape = bsSpacer
      ExplicitTop = -4
    end
    object pnAddons: TPanel
      Left = 0
      Top = 165
      Width = 428
      Height = 92
      Align = alTop
      BevelOuter = bvNone
      Padding.Top = 2
      TabOrder = 7
      object edServerAddress: TcxTextEdit
        Left = 229
        Top = 21
        TabOrder = 4
        Width = 120
      end
      object edPort: TcxTextEdit
        Left = 362
        Top = 21
        TabOrder = 7
        Text = '3050'
        Width = 51
      end
      object edSpecial: TcxTextEdit
        Left = 14
        Top = 21
        TabStop = False
        TabOrder = 0
        Width = 67
      end
      object edDatabaseAlias: TcxTextEdit
        Left = 103
        Top = 21
        TabOrder = 1
        Width = 120
      end
      object Label3: TcxLabel
        Left = 229
        Top = 2
        Caption = 'Server'
        TabOrder = 2
        Transparent = True
      end
      object Label6: TcxLabel
        Left = 362
        Top = 2
        Caption = 'Port'
        TabOrder = 3
        Transparent = True
      end
      object Label1: TcxLabel
        Left = 14
        Top = 2
        Caption = 'Codificare'
        TabOrder = 5
        Transparent = True
      end
      object Label2: TcxLabel
        Left = 104
        Top = 2
        Caption = 'Alias'
        TabOrder = 6
        Transparent = True
      end
      object cxLabel3: TcxLabel
        Left = 15
        Top = 48
        Caption = 'Client library'
        TabOrder = 8
        Transparent = True
      end
      object beFBClientPath: TcxButtonEdit
        Left = 15
        Top = 65
        Properties.Buttons = <
          item
            Default = True
            Kind = bkEllipsis
          end>
        Properties.OnButtonClick = cxButtonEdit1PropertiesButtonClick
        TabOrder = 9
        Text = 'fbclient.dll'
        Width = 394
      end
    end
    object imgLogo: TcxImage
      Left = 7
      Top = 10
      TabStop = False
      Properties.GraphicClassName = 'TdxSmartImage'
      Properties.GraphicTransparency = gtTransparent
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Transparent = True
      Height = 120
      Width = 413
    end
    object edUserName: TcxTextEdit
      Left = 224
      Top = 80
      ParentFont = False
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -11
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = []
      Style.IsFontAssigned = True
      TabOrder = 1
      Width = 184
    end
    object edPassword: TcxTextEdit
      Left = 224
      Top = 131
      Properties.EchoMode = eemPassword
      TabOrder = 2
      Width = 156
    end
    object lbKL: TcxLabel
      Left = 386
      Top = 134
      AutoSize = False
      Caption = 'EN'
      ParentColor = False
      ParentFont = False
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -11
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = []
      Style.IsFontAssigned = True
      TabOrder = 3
      Transparent = True
      Height = 17
      Width = 47
    end
    object lbVersion: TcxLabel
      Left = 53
      Top = 136
      Caption = 'Versiunea x.x'
      ParentFont = False
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -11
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = []
      Style.IsFontAssigned = True
      TabOrder = 4
      Transparent = True
    end
    object cxLabel2: TcxLabel
      Left = 222
      Top = 108
      Caption = 'Parola'
      TabOrder = 5
      Transparent = True
    end
    object cxLabel1: TcxLabel
      Left = 224
      Top = 57
      Caption = 'Nume utilizator'
      TabOrder = 6
      Transparent = True
    end
  end
  object IBCConnection: TIBCConnection
    Database = 'SW'
    Options.Charset = 'UTF8'
    Options.EnableBCD = True
    DefaultTransaction = IBCTrSelect
    ClientLibrary = 'fbclient.dll'
    Port = '3050'
    SSLOptions.Enabled = False
    Username = 'SYSDBA'
    Server = '192.168.106.254'
    LoginPrompt = False
    Left = 36
    Top = 56
    EncryptedPassword = '92FF9EFF8CFF8BFF9AFF8DFF94FF9AFF86FF'
  end
  object IBCTrSelect: TIBCTransaction
    DefaultConnection = IBCConnection
    Left = 132
    Top = 56
  end
  object IBCQuery: TIBCQuery
    Connection = IBCConnection
    Transaction = IBCTrSelect
    Left = 80
    Top = 56
  end
  object tmKLTimer: TTimer
    Interval = 500
    OnTimer = tmKLTimerTimer
    Left = 368
    Top = 32
  end
  object dxOpenFileDialog1: TdxOpenFileDialog
    FileName = 'fbclient.dll'
    Options = [ofReadOnly, ofHideReadOnly, ofFileMustExist, ofEnableSizing, ofDontAddToRecent, ofForceShowHidden]
    Left = 184
    Top = 24
  end
end
