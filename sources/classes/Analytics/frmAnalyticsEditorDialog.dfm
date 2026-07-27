object frmAnalyticsEditorDlg: TfrmAnalyticsEditorDlg
  Left = 0
  Top = 0
  ActiveControl = edTITLE
  BorderStyle = bsDialog
  Caption = 'Analitica'
  ClientHeight = 419
  ClientWidth = 564
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    564
    419)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 564
    Height = 64
    Title = 'Analitica'
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
    Width = 548
    Height = 285
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
      Top = 148
      Width = 48
      Height = 15
      Caption = 'Descriere'
    end
    object Label3: TLabel
      Left = 16
      Top = 72
      Width = 141
      Height = 15
      Caption = 'Ce modifica in documente'
    end
    object edTITLE: TcxDBTextEdit
      Left = 16
      Top = 33
      DataBinding.DataField = 'TITLE'
      TabOrder = 0
      Width = 505
    end
    object mmDESCRIPTION: TcxDBMemo
      Left = 16
      Top = 165
      DataBinding.DataField = 'DESCRIPTION'
      TabOrder = 4
      Height = 89
      Width = 505
    end
    object cbFLG_CHANGE_BALANS: TcxDBCheckBox
      Left = 16
      Top = 93
      Caption = 'Modifica bilanta'
      DataBinding.DataField = 'FLG_CHANGE_BALANS'
      Properties.Alignment = taLeftJustify
      Properties.ValueChecked = 1
      Properties.ValueUnchecked = 0
      TabOrder = 1
    end
    object cbFLG_EXPENSES: TcxDBCheckBox
      Left = 162
      Top = 93
      Caption = 'Cheltuieli'
      DataBinding.DataField = 'FLG_EXPENSES'
      Properties.Alignment = taLeftJustify
      Properties.ValueChecked = 1
      Properties.ValueUnchecked = 0
      TabOrder = 2
    end
    object cbFLG_CALC_SALDO: TcxDBCheckBox
      Left = 260
      Top = 93
      Caption = 'Calcula soldul'
      DataBinding.DataField = 'FLG_CALC_SALDO'
      Properties.Alignment = taLeftJustify
      Properties.ValueChecked = 1
      Properties.ValueUnchecked = 0
      TabOrder = 3
    end
  end
  object btnOk: TcxButton
    Left = 348
    Top = 372
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TcxButton
    Left = 452
    Top = 372
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Anuleaza'
    ModalResult = 2
    TabOrder = 3
  end
end
