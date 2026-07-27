object frmBankEditorDialog: TfrmBankEditorDialog
  Left = 0
  Top = 0
  ActiveControl = edBancAccount
  BorderStyle = bsDialog
  Caption = 'Banca'
  ClientHeight = 355
  ClientWidth = 382
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    382
    355)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 382
    Height = 64
    Title = 'Banca'
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
  end
  object pnCard: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 366
    Height = 226
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
    object cxLabel1: TLabel
      Left = 12
      Top = 16
      Width = 61
      Height = 15
      Caption = 'Cod bancar'
    end
    object cxLabel2: TLabel
      Left = 12
      Top = 72
      Width = 52
      Height = 15
      Caption = 'Denumire'
    end
    object cxLabel3: TLabel
      Left = 188
      Top = 16
      Width = 53
      Height = 15
      Caption = 'SWIFT BIC'
    end
    object cxLabel4: TLabel
      Left = 12
      Top = 132
      Width = 36
      Height = 15
      Caption = 'Adresa'
    end
    object mmAddress: TcxDBMemo
      Left = 12
      Top = 149
      DataBinding.DataField = 'ADDRESS'
      TabOrder = 3
      Height = 57
      Width = 336
    end
    object edBancAccount: TcxDBTextEdit
      Left = 12
      Top = 33
      DataBinding.DataField = 'BANKACCOUNT'
      TabOrder = 0
      Width = 160
    end
    object edBankName: TcxDBTextEdit
      Left = 12
      Top = 89
      DataBinding.DataField = 'BANKNAME'
      TabOrder = 2
      Width = 336
    end
    object edSWIFT: TcxDBTextEdit
      Left = 188
      Top = 33
      DataBinding.DataField = 'SWIFT_BIC'
      TabOrder = 1
      Width = 160
    end
  end
  object btnOk: TcxButton
    Left = 171
    Top = 312
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TcxButton
    Left = 276
    Top = 312
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Anuleaza'
    ModalResult = 2
    TabOrder = 3
  end
end
