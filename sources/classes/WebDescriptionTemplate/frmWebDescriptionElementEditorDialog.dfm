object frmWebDescriptionElementEditorDlg: TfrmWebDescriptionElementEditorDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Caracteristicile produsului'
  ClientHeight = 423
  ClientWidth = 723
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnKeyDown = FormKeyDown
  DesignSize = (
    723
    423)
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 723
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
    Width = 707
    Height = 291
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
    object cxGroupBox1: TcxGroupBox
      Left = 16
      Top = 143
      Caption = 'Proprietati filtru'
      TabOrder = 1
      Height = 129
      Width = 677
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
      object cbFLG_VISIBLE: TcxDBCheckBox
        Left = 24
        Top = 46
        Caption = 'Visibil'
        DataBinding.DataField = 'FLG_VISIBLE'
        Properties.Alignment = taLeftJustify
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        Style.TransparentBorder = False
        TabOrder = 1
      end
      object cbFLG_COMPATIBILITY: TcxDBCheckBox
        Left = 24
        Top = 71
        Caption = 'Particip'#259' la c'#259'utarea unui produs prin compatibilitate'
        DataBinding.DataField = 'FLG_COMPATIBILITY'
        Properties.Alignment = taLeftJustify
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        Style.TransparentBorder = False
        TabOrder = 2
      end
      object cbFLG_COMPARE: TcxDBCheckBox
        Left = 24
        Top = 95
        Caption = 'Particip'#259' la compararea produselor'
        DataBinding.DataField = 'FLG_COMPARE'
        Properties.Alignment = taLeftJustify
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        Style.TransparentBorder = False
        TabOrder = 3
      end
    end
    object cxGroupBox3: TcxGroupBox
      Left = 16
      Top = 8
      Caption = 'Filtreu cu  proprietati'
      TabOrder = 0
      Height = 129
      Width = 677
      object Label7: TLabel
        Left = 293
        Top = 68
        Width = 53
        Height = 15
        Caption = #1047#1085#1072#1095#1077#1085#1080#1077
      end
      object Label6: TLabel
        Left = 293
        Top = 21
        Width = 38
        Height = 15
        Caption = 'Valoare'
      end
      object Label3: TLabel
        Left = 16
        Top = 68
        Width = 51
        Height = 15
        Caption = #1057#1074#1086#1081#1089#1090#1074#1072
      end
      object Label1: TLabel
        Left = 16
        Top = 21
        Width = 27
        Height = 15
        Caption = 'Filtru'
      end
      object edFILTER_NAME_ROM: TcxTextEdit
        Left = 16
        Top = 39
        TabStop = False
        Properties.ReadOnly = True
        TabOrder = 0
        Width = 223
      end
      object btnChangeFilter: TcxButton
        Left = 593
        Top = 39
        Width = 81
        Height = 74
        Caption = 'Schimb'#259' '#1048#1079#1084#1077#1085#1080#1090#1100' (F4)'
        Default = True
        SpeedButtonOptions.Flat = True
        SpeedButtonOptions.Transparent = True
        TabOrder = 2
        WordWrap = True
        OnClick = btnChangeFilterClick
      end
      object edFILTER_NAME_RUS: TcxTextEdit
        Left = 16
        Top = 86
        TabStop = False
        Properties.ReadOnly = True
        TabOrder = 3
        Width = 223
      end
      object mmPARAM_VALUE_RUS: TcxMemo
        Left = 293
        Top = 86
        TabStop = False
        Properties.ReadOnly = True
        Properties.ScrollBars = ssVertical
        Properties.VisibleLineCount = 1
        TabOrder = 4
        Width = 273
      end
      object mmPARAM_VALUE_ROM: TcxMemo
        Left = 293
        Top = 39
        TabStop = False
        Properties.ReadOnly = True
        Properties.ScrollBars = ssVertical
        Properties.VisibleLineCount = 1
        TabOrder = 1
        Width = 273
      end
    end
  end
  object btnOk: TcxButton
    Left = 509
    Top = 378
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TcxButton
    Left = 613
    Top = 378
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
end
