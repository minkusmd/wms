object frmBSToolsCopyGridClipboardDlg: TfrmBSToolsCopyGridClipboardDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Copie datele din tabela'
  ClientHeight = 309
  ClientWidth = 382
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  DesignSize = (
    382
    309)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 382
    Height = 64
    Title = 'Copie datele din tabela'
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
    ImageIndex = 16
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 366
    Height = 184
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
    object Label1: TLabel
      Left = 20
      Top = 24
      Width = 71
      Height = 15
      Caption = 'Ce de copiat?'
    end
    object Label2: TLabel
      Left = 20
      Top = 53
      Width = 82
      Height = 15
      Caption = 'Unde de salvat?'
    end
    object Label3: TLabel
      Left = 20
      Top = 121
      Width = 24
      Height = 15
      Caption = 'Info:'
    end
    object lbInfo: TLabel
      Left = 20
      Top = 142
      Width = 31
      Height = 15
      Caption = 'lbInfo'
    end
    object Label4: TLabel
      Left = 20
      Top = 79
      Width = 3
      Height = 15
    end
    object cmbSource: TComboBox
      Left = 118
      Top = 21
      Width = 199
      Height = 23
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 0
      Text = 'Toate datele din tabela'
      Items.Strings = (
        'Toate datele din tabela'
        'Doar coloana selectata'
        'Doar rindul selectat')
    end
    object cmbTarget: TComboBox
      Left = 118
      Top = 50
      Width = 155
      Height = 23
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 1
      Text = 'in Clipboard'
      Items.Strings = (
        'in Clipboard'
        'in File')
    end
    object cbHeaders: TCheckBox
      Left = 20
      Top = 87
      Width = 129
      Height = 17
      Caption = 'Denumirea colonitelor'
      TabOrder = 2
    end
  end
  object btnOk: TButton
    Left = 164
    Top = 267
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 268
    Top = 267
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
end
