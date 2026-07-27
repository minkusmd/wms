object frmInputPartNoCountDlg: TfrmInputPartNoCountDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Numere de partida'
  ClientHeight = 240
  ClientWidth = 435
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    435
    240)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 435
    Height = 64
    Title = 'Numere de partida'
    Text = 'Introduceti cantitatea numerilor de partida pentru transfer'
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
    ImageIndex = 17
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 419
    Height = 109
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
      Left = 16
      Top = 20
      Width = 165
      Height = 15
      Caption = 'Cantitatea numerilor de partida'
    end
    object lbTextCount: TLabel
      Left = 16
      Top = 61
      Width = 264
      Height = 15
      Caption = 'Total numere de partide selectate pentru adaugare'
      Transparent = True
    end
    object edQTY: TcxCalcEdit
      Left = 307
      Top = 20
      EditValue = 0.000000000000000000
      TabOrder = 0
      Width = 99
    end
    object edMaxQTY: TcxCalcEdit
      Left = 307
      Top = 58
      EditValue = 0.000000000000000000
      Enabled = False
      Properties.ReadOnly = True
      TabOrder = 1
      Width = 99
    end
  end
  object btnOK: TcxButton
    Left = 225
    Top = 195
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TcxButton
    Left = 326
    Top = 195
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
end
