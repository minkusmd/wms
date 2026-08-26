object frmApplyActiuneCodeDlg: TfrmApplyActiuneCodeDlg
  Left = 0
  Top = 0
  ActiveControl = edCode
  BorderStyle = bsDialog
  Caption = 'Coduri pentru pomotii'
  ClientHeight = 487
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
    Title = 'Cod pentru promotie'
    Text = 'Aplicarea codului'
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
    Width = 423
    Height = 361
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
      Width = 74
      Height = 15
      Caption = 'Cod promotie'
    end
    object Label2: TLabel
      Left = 20
      Top = 81
      Width = 49
      Height = 15
      Caption = 'Promotie'
    end
    object Label3: TLabel
      Left = 20
      Top = 110
      Width = 64
      Height = 15
      Caption = 'Cumparator'
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
    object Label5: TLabel
      Left = 20
      Top = 280
      Width = 107
      Height = 15
      Caption = '3. Aplicarea codului'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbInfo: TLabel
      Left = 156
      Top = 307
      Width = 172
      Height = 15
      Caption = 'Eroare! Nu se poate aplica codul.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 20
      Top = 139
      Width = 49
      Height = 15
      Caption = 'REducere'
    end
    object Label6: TLabel
      Left = 16
      Top = 179
      Width = 198
      Height = 15
      Caption = '2. Validare documentului de vinzare'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edCode: TEdit
      Left = 104
      Top = 49
      Width = 157
      Height = 23
      CharCase = ecUpperCase
      TabOrder = 0
      Text = 'XXX-XXX-XXX'
    end
    object btnCheck: TButton
      Left = 267
      Top = 48
      Width = 90
      Height = 25
      Caption = 'Validare'
      Default = True
      TabOrder = 1
      OnClick = btnCheckClick
    end
    object btnApply: TButton
      Left = 20
      Top = 301
      Width = 119
      Height = 29
      Caption = 'Aplica cod'
      TabOrder = 2
      OnClick = btnApplyClick
    end
    object edActiuneTitle: TEdit
      Left = 104
      Top = 78
      Width = 297
      Height = 23
      TabStop = False
      ReadOnly = True
      TabOrder = 3
    end
    object edCustomer: TEdit
      Left = 104
      Top = 107
      Width = 297
      Height = 23
      TabStop = False
      ReadOnly = True
      TabOrder = 4
    end
    object edDiscount: TEdit
      Left = 104
      Top = 136
      Width = 157
      Height = 23
      TabStop = False
      ReadOnly = True
      TabOrder = 5
    end
    object mmInfo: TMemo
      Left = 16
      Top = 196
      Width = 385
      Height = 61
      TabStop = False
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 6
    end
  end
  object btnClose: TButton
    Left = 325
    Top = 444
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Inchide'
    ModalResult = 2
    TabOrder = 2
  end
end
