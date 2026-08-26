object frmWebSelectFilterParamDlg: TfrmWebSelectFilterParamDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Proprietatile filtrelor'
  ClientHeight = 310
  ClientWidth = 686
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnKeyDown = FormKeyDown
  DesignSize = (
    686
    310)
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 686
    Height = 64
    Title = 'Proprietatile filtrelor'
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
    ImageIndex = 11
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 670
    Height = 178
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
    object Label5: TLabel
      Left = 24
      Top = 62
      Width = 40
      Height = 15
      Caption = 'Optiuni'
    end
    object cbFLG_VISIBLE: TcxDBCheckBox
      Left = 32
      Top = 83
      Caption = 'Visibil'
      DataBinding.DataField = 'FLG_VISIBLE'
      Properties.Alignment = taLeftJustify
      Properties.ValueChecked = 1
      Properties.ValueUnchecked = 0
      TabOrder = 1
    end
    object cbFLG_COMPATIBILITY: TcxDBCheckBox
      Left = 32
      Top = 112
      Caption = 'Particip'#259' la c'#259'utarea unui produs prin compatibilitate'
      DataBinding.DataField = 'FLG_COMPATIBILITY'
      Properties.Alignment = taLeftJustify
      Properties.ValueChecked = 1
      Properties.ValueUnchecked = 0
      TabOrder = 2
    end
    object cbFLG_COMPARE: TcxDBCheckBox
      Left = 32
      Top = 141
      Caption = 'Particip'#259' la compararea produselor'
      DataBinding.DataField = 'FLG_COMPARE'
      Properties.Alignment = taLeftJustify
      Properties.ValueChecked = 1
      Properties.ValueUnchecked = 0
      TabOrder = 3
    end
    object cbFLG_GROUP: TcxDBCheckBox
      Left = 24
      Top = 23
      Caption = 'Proprietatea este grupa'
      DataBinding.DataField = 'FLG_GROUP'
      Properties.Alignment = taLeftJustify
      Properties.ValueChecked = 1
      Properties.ValueUnchecked = 0
      Style.TransparentBorder = False
      TabOrder = 0
    end
  end
  object btnOk: TcxButton
    Left = 473
    Top = 265
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TcxButton
    Left = 576
    Top = 265
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
end
