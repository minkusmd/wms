object frmSelectPercentValueDlg: TfrmSelectPercentValueDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Ajusteaza valoarea procentual'
  ClientHeight = 213
  ClientWidth = 451
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  DesignSize = (
    451
    213)
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 451
    Height = 64
    Text = 'Vezi optiunile de modificare'
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
    Width = 435
    Height = 89
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
    object Label2: TLabel
      Left = 16
      Top = 50
      Width = 210
      Height = 15
      Caption = '(-) scade procentul, (+) creste procentul'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 16
      Top = 3
      Width = 38
      Height = 15
      Caption = 'Valoare'
    end
    object edValue: TcxCalcEdit
      Left = 16
      Top = 21
      EditValue = -1.000000000000000000
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.DisplayFormat = '0.00'
      Properties.ImmediatePost = True
      TabOrder = 1
      Width = 100
    end
    object rbOptionAmount: TRadioButton
      Left = 311
      Top = 11
      Width = 100
      Height = 18
      Caption = 'Suma'
      TabOrder = 0
    end
    object rbOptionPercent: TRadioButton
      Left = 311
      Top = 35
      Width = 100
      Height = 18
      Caption = 'Procent'
      Checked = True
      TabOrder = 2
      TabStop = True
    end
  end
  object btnOk: TcxButton
    Left = 251
    Top = 176
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TcxButton
    Left = 353
    Top = 176
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
end
