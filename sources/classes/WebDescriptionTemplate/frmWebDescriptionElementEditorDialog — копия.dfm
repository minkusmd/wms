object frmWebDescriptionElementEditorDlg: TfrmWebDescriptionElementEditorDlg
  Left = 0
  Top = 0
  ActiveControl = btnChangeFilter
  BorderStyle = bsDialog
  Caption = 'Caracteristicile produsului'
  ClientHeight = 444
  ClientWidth = 686
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnKeyDown = FormKeyDown
  DesignSize = (
    686
    444)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 686
    Height = 64
    Title = 'Caracteristicile produsului'
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
    Height = 312
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
      Top = 61
      Width = 55
      Height = 15
      Caption = 'Proprietati'
    end
    object Label3: TLabel
      Left = 16
      Top = 121
      Width = 51
      Height = 15
      Caption = #1057#1074#1086#1081#1089#1090#1074#1072
    end
    object Label5: TLabel
      Left = 16
      Top = 182
      Width = 40
      Height = 15
      Caption = 'Optiuni'
    end
    object Label6: TLabel
      Left = 288
      Top = 61
      Width = 38
      Height = 15
      Caption = 'Valoare'
    end
    object Label7: TLabel
      Left = 288
      Top = 121
      Width = 53
      Height = 15
      Caption = #1047#1085#1072#1095#1077#1085#1080#1077
    end
    object mmPARAM_VALUE_ROM: TcxMemo
      Left = 288
      Top = 81
      TabStop = False
      Properties.ReadOnly = True
      Properties.ScrollBars = ssVertical
      Properties.VisibleLineCount = 1
      TabOrder = 3
      Width = 273
    end
    object cbFLG_VISIBLE: TcxDBCheckBox
      Left = 24
      Top = 203
      Caption = 'Visibil'
      DataBinding.DataField = 'FLG_VISIBLE'
      Properties.Alignment = taLeftJustify
      Properties.ValueChecked = 1
      Properties.ValueUnchecked = 0
      TabOrder = 6
    end
    object cbFLG_COMPATIBILITY: TcxDBCheckBox
      Left = 24
      Top = 232
      Caption = 'Particip'#259' la c'#259'utarea unui produs prin compatibilitate'
      DataBinding.DataField = 'FLG_COMPATIBILITY'
      Properties.Alignment = taLeftJustify
      Properties.ValueChecked = 1
      Properties.ValueUnchecked = 0
      TabOrder = 7
    end
    object cbFLG_COMPARE: TcxDBCheckBox
      Left = 24
      Top = 261
      Caption = 'Particip'#259' la compararea produselor'
      DataBinding.DataField = 'FLG_COMPARE'
      Properties.Alignment = taLeftJustify
      Properties.ValueChecked = 1
      Properties.ValueUnchecked = 0
      TabOrder = 8
    end
    object mmPARAM_VALUE_RUS: TcxMemo
      Left = 288
      Top = 141
      TabStop = False
      Properties.ReadOnly = True
      Properties.ScrollBars = ssVertical
      Properties.VisibleLineCount = 1
      TabOrder = 5
      Width = 273
    end
    object edFILTER_NAME_ROM: TcxTextEdit
      Left = 15
      Top = 81
      TabStop = False
      Properties.ReadOnly = True
      TabOrder = 2
      Width = 219
    end
    object edFILTER_NAME_RUS: TcxTextEdit
      Left = 15
      Top = 141
      TabStop = False
      Properties.ReadOnly = True
      TabOrder = 4
      Width = 219
    end
    object btnChangeFilter: TcxButton
      Left = 576
      Top = 73
      Width = 81
      Height = 90
      Caption = 'Schimb'#259' '#1048#1079#1084#1077#1085#1080#1090#1100' (F4)'
      Default = True
      SpeedButtonOptions.Flat = True
      SpeedButtonOptions.Transparent = True
      TabOrder = 1
      WordWrap = True
      OnClick = btnChangeFilterClick
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
    Top = 399
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TcxButton
    Left = 576
    Top = 399
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
end
