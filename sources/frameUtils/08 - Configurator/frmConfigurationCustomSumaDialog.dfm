object frmConfigurationCustomSumaDlg: TfrmConfigurationCustomSumaDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  ClientHeight = 260
  ClientWidth = 486
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  DesignSize = (
    486
    260)
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 486
    Height = 64
    Text = 'Modifica suma'
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
    ImageIndex = 4
    ExplicitLeft = -8
    ExplicitTop = -3
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 470
    Height = 138
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
    TabOrder = 1
    ExplicitLeft = 13
    ExplicitTop = 74
    ExplicitHeight = 225
    object lbCurrency: TLabel
      Left = 445
      Top = 45
      Width = 15
      Height = 15
      Caption = 'LEI'
    end
    object lbInfo: TLabel
      Left = 32
      Top = 110
      Width = 407
      Height = 18
      AutoSize = False
      Caption = 'lbInfo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      Layout = tlBottom
      WordWrap = True
    end
    object Label1: TLabel
      Left = 445
      Top = 84
      Width = 10
      Height = 15
      Caption = '%'
    end
    object edAddSuma: TEdit
      Left = 341
      Top = 42
      Width = 98
      Height = 23
      Enabled = False
      TabOrder = 1
      Text = '0'
    end
    object edAddPercent: TEdit
      Left = 341
      Top = 81
      Width = 98
      Height = 23
      TabOrder = 2
      Text = '0'
    end
    object rbPercent: TcxRadioButton
      Left = 32
      Top = 87
      Width = 113
      Height = 17
      Caption = 'Adauga procent'
      Checked = True
      TabOrder = 3
      TabStop = True
    end
    object rbSuma: TcxRadioButton
      Left = 32
      Top = 42
      Width = 177
      Height = 17
      Caption = 'Adauga suma'
      TabOrder = 0
      OnClick = rbSumaClick
    end
  end
  object btnOk: TcxButton
    Left = 273
    Top = 223
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
    ExplicitTop = 318
  end
  object btnCancel: TcxButton
    Left = 375
    Top = 223
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
    ExplicitTop = 318
  end
end
