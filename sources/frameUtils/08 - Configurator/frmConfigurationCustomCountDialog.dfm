object frmConfigurationCustomCountDlg: TfrmConfigurationCustomCountDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  ClientHeight = 259
  ClientWidth = 384
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  DesignSize = (
    384
    259)
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 384
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
    Width = 368
    Height = 129
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
    object lbInfo: TLabel
      Left = 16
      Top = 80
      Width = 333
      Height = 34
      AutoSize = False
      Caption = 'lbInfo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
    object rbOption1: TRadioButton
      Left = 16
      Top = 21
      Width = 189
      Height = 18
      Caption = 'Seteaza cantitatea'
      TabOrder = 1
      TabStop = True
      OnClick = rbOption1Click
    end
    object rbOption2: TRadioButton
      Left = 16
      Top = 48
      Width = 189
      Height = 18
      Caption = 'Inmulteste cantitatea'
      TabOrder = 3
      TabStop = True
      OnClick = rbOption1Click
    end
    object edCountValue: TcxCalcEdit
      Left = 211
      Top = 16
      EditValue = 1.000000000000000000
      Properties.Alignment.Horz = taLeftJustify
      Properties.ImmediatePost = True
      TabOrder = 0
      Width = 78
    end
    object edMultiplyValue: TcxCalcEdit
      Left = 211
      Top = 45
      EditValue = 1
      Properties.Alignment.Horz = taLeftJustify
      Properties.ImmediatePost = True
      TabOrder = 2
      Width = 78
    end
  end
  object btnOk: TcxButton
    Left = 172
    Top = 215
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TcxButton
    Left = 274
    Top = 215
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
end
