object frmNewVersionDlg: TfrmNewVersionDlg
  Left = 0
  Top = 0
  AutoSize = True
  BorderStyle = bsDialog
  Caption = 'Versiune noua'
  ClientHeight = 424
  ClientWidth = 513
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Pitch = fpFixed
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 15
  object pnInfo: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 497
    Height = 289
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 0
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    AutoSize = True
    BevelKind = bkFlat
    BevelOuter = bvNone
    BorderWidth = 16
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    object Label3: TLabel
      Left = 16
      Top = 16
      Width = 84
      Height = 15
      Caption = 'verciunea noua:'
    end
    object Label4: TLabel
      Left = 16
      Top = 38
      Width = 96
      Height = 15
      Caption = 'versiunea curenta:'
    end
    object lbNewVersionInfo: TLabel
      Left = 115
      Top = 16
      Width = 100
      Height = 15
      Caption = 'lbNewVersionInfo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Pitch = fpFixed
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbCurrentVersionInfo: TLabel
      Left = 115
      Top = 38
      Width = 117
      Height = 15
      Caption = 'lbCurrentVersionInfo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGrayText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Pitch = fpFixed
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbProgress: TLabel
      Left = 16
      Top = 120
      Width = 461
      Height = 21
      Alignment = taCenter
      AutoSize = False
      Caption = #1047#1072#1075#1088#1091#1079#1082#1072' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1081
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Pitch = fpFixed
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
    end
    object lbWhatsNew: TLabel
      Left = 16
      Top = 69
      Width = 159
      Height = 15
      Caption = 'Modificarile in versiunea noua'
    end
    object lbCritical: TLabel
      Left = 401
      Top = 16
      Width = 76
      Height = 15
      Alignment = taRightJustify
      Caption = 'Update critic!'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Pitch = fpFixed
      Font.Style = [fsBold]
      ParentFont = False
    end
    object mmInfo: TMemo
      Left = 16
      Top = 86
      Width = 461
      Height = 183
      TabStop = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Pitch = fpFixed
      Font.Style = []
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 0
    end
  end
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 513
    Height = 64
    Title = 'A aparut o versiune noua a aplicatiei'
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
    ImageList = dmAdditions.cxImageList_DialogIcons
    ImageIndex = 29
  end
  object pnButtons: TPanel
    Left = 0
    Top = 361
    Width = 513
    Height = 63
    Align = alTop
    BevelOuter = bvNone
    Padding.Top = 17
    Padding.Bottom = 17
    TabOrder = 2
    object btnUpdate: TcxButton
      AlignWithMargins = True
      Left = 293
      Top = 17
      Width = 90
      Height = 29
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 20
      Margins.Bottom = 0
      Align = alRight
      Caption = 'Instaleaza'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
    object btnPostpone: TcxButton
      AlignWithMargins = True
      Left = 403
      Top = 17
      Width = 90
      Height = 29
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 20
      Margins.Bottom = 0
      Align = alRight
      Cancel = True
      Caption = 'Renunta'
      ModalResult = 2
      TabOrder = 1
    end
  end
end
