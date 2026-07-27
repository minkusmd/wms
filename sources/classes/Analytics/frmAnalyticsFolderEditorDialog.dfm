object frmAnalyticsFolderEditorDlg: TfrmAnalyticsFolderEditorDlg
  Left = 0
  Top = 0
  ActiveControl = edTITLE
  BorderStyle = bsDialog
  Caption = 'Grupa analitica'
  ClientHeight = 350
  ClientWidth = 372
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    372
    350)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 372
    Height = 64
    Title = 'Grupa analitica'
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
    Width = 356
    Height = 216
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
      Left = 16
      Top = 16
      Width = 52
      Height = 15
      Caption = 'Denumire'
    end
    object Label2: TLabel
      Left = 16
      Top = 76
      Width = 48
      Height = 15
      Caption = 'Descriere'
    end
    object edTITLE: TcxDBTextEdit
      Left = 16
      Top = 33
      DataBinding.DataField = 'TITLE'
      TabOrder = 0
      Width = 313
    end
    object mmDESCRIPTION: TcxDBMemo
      Left = 16
      Top = 93
      DataBinding.DataField = 'DESCRIPTION'
      TabOrder = 1
      Height = 89
      Width = 313
    end
  end
  object btnOk: TcxButton
    Left = 156
    Top = 303
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TcxButton
    Left = 260
    Top = 303
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Anuleaza'
    ModalResult = 2
    TabOrder = 3
  end
end
