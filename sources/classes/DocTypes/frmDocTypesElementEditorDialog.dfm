object frmDocTypesElementEditorDlg: TfrmDocTypesElementEditorDlg
  Left = 0
  Top = 0
  ActiveControl = edTITLE
  BorderStyle = bsDialog
  Caption = 'Item securitate'
  ClientHeight = 396
  ClientWidth = 897
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  DesignSize = (
    897
    396)
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 897
    Height = 64
    Title = 'Item'
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
    ImageIndex = 24
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 881
    Height = 261
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
      Left = 512
      Top = 212
      Width = 106
      Height = 15
      Caption = '4 - Semnul operatiei'
    end
    object cxLabel1: TLabel
      Left = 16
      Top = 12
      Width = 52
      Height = 15
      Caption = 'Denumire'
    end
    object cxLabel2: TLabel
      Left = 256
      Top = 12
      Width = 54
      Height = 15
      Caption = 'Vizibilitate'
    end
    object cxLabel4: TLabel
      Left = 16
      Top = 58
      Width = 58
      Height = 15
      Caption = 'Abriviatura'
    end
    object cxLabel6: TLabel
      Left = 512
      Top = 12
      Width = 116
      Height = 15
      Caption = 'Documentul va afecta'
    end
    object cxLabel3: TLabel
      Left = 16
      Top = 165
      Width = 80
      Height = 15
      Caption = 'Cod document'
    end
    object clbStructure: TcxCheckListBox
      Left = 256
      Top = 29
      Width = 225
      Height = 211
      Items = <>
      TabOrder = 1
      OnCheckStatesToEditValue = clbStructureCheckStatesToEditValue
      OnEditValueToCheckStates = clbStructureEditValueToCheckStates
    end
    object edTITLE: TcxTextEdit
      Left = 16
      Top = 29
      TabOrder = 0
      Text = #1053#1086#1074#1099#1081' '#1101#1083#1077#1084#1077#1085#1090
      Width = 209
    end
    object icbImageIndex: TcxImageComboBox
      Left = 136
      Top = 133
      Enabled = False
      Properties.Images = dmAdditions.cxImageList_MainTabs
      Properties.Items = <>
      TabOrder = 14
      Width = 89
    end
    object edSHORT: TcxTextEdit
      Left = 16
      Top = 75
      TabOrder = 6
      Width = 209
    end
    object cbFLG_MONEY: TCheckBox
      Left = 512
      Top = 33
      Width = 133
      Height = 17
      Caption = '1 - Casa'
      TabOrder = 3
    end
    object cbFLG_DEBTS: TCheckBox
      Left = 512
      Top = 56
      Width = 133
      Height = 17
      Caption = '2 - Datoria'
      TabOrder = 5
    end
    object cbFLG_INVOICE: TCheckBox
      Left = 512
      Top = 79
      Width = 145
      Height = 17
      Caption = '3 - Documente cu produse'
      TabOrder = 8
    end
    object cbFLG_TRANSFER: TCheckBox
      Left = 512
      Top = 102
      Width = 133
      Height = 17
      Caption = '5 - Transferurile'
      TabOrder = 10
    end
    object cbFLG_SIGN: TcxComboBox
      Left = 663
      Top = 209
      Properties.DropDownListStyle = lsFixedList
      Properties.Items.Strings = (
        '( - )'
        '(+)')
      TabOrder = 19
      Width = 41
    end
    object beTabIndex: TcxButtonEdit
      Left = 136
      Top = 104
      Enabled = False
      ParentShowHint = False
      Properties.Buttons = <
        item
          Default = True
          Hint = #1048#1089#1087#1086#1083#1100#1079#1086#1074#1072#1090#1100' '#1089#1083#1077#1076#1091#1102#1097#1080#1081' '#1080#1085#1076#1077#1082#1089
          Kind = bkEllipsis
        end>
      Properties.IncrementalSearch = False
      Properties.MaxLength = 0
      Properties.OnButtonClick = beTabIndexPropertiesButtonClick
      ShowHint = True
      TabOrder = 11
      Width = 89
    end
    object cbHasFrame: TCheckBox
      Left = 16
      Top = 107
      Width = 114
      Height = 17
      Caption = 'Index frame'
      TabOrder = 12
      OnClick = cbHasFrameClick
    end
    object cbHasImage: TCheckBox
      Left = 16
      Top = 136
      Width = 114
      Height = 17
      Caption = 'Iconita'
      TabOrder = 15
      OnClick = cbHasImageClick
    end
    object edDocTypeID: TcxTextEdit
      Left = 107
      Top = 162
      TabStop = False
      Properties.ReadOnly = True
      TabOrder = 17
      Width = 118
    end
    object cbFLG_ACNT_INVOICE: TCheckBox
      Left = 512
      Top = 125
      Width = 133
      Height = 17
      Caption = '6 - Facturi fiscale'
      TabOrder = 13
    end
    object cbFLG_SERVICE_QTY: TCheckBox
      Left = 512
      Top = 148
      Width = 205
      Height = 17
      Caption = '7 - Evidenta cantitativa in service'
      TabOrder = 16
    end
    object cbFLG_ASSEMBLE: TCheckBox
      Left = 512
      Top = 171
      Width = 133
      Height = 17
      Caption = '8 - Asamblari producere'
      TabOrder = 18
    end
    object cbFLG_ACHITARI: TCheckBox
      Left = 703
      Top = 32
      Width = 133
      Height = 17
      Caption = '9 - Achitari ???'
      TabOrder = 2
    end
    object cbFLG_DBL_JURNAL: TCheckBox
      Left = 703
      Top = 54
      Width = 122
      Height = 17
      Caption = '10 - Jurnal dublu'
      TabOrder = 4
    end
    object cbAccessVisible: TcxCheckBox
      Left = 16
      Top = 212
      Caption = 'Arata in lista drepturilor'
      Properties.Alignment = taLeftJustify
      TabOrder = 20
    end
    object cbFLG_UPR_UCET: TCheckBox
      Left = 703
      Top = 77
      Width = 160
      Height = 17
      Caption = '11 - Evidenta operationala'
      TabOrder = 7
    end
    object cbFLG_BUH_UCET: TCheckBox
      Left = 703
      Top = 100
      Width = 162
      Height = 17
      Caption = '12 - Evidenta contabila'
      TabOrder = 9
    end
  end
  object cbCreateDefaultActions: TCheckBox
    Left = 26
    Top = 354
    Width = 209
    Height = 17
    Caption = 'Creaza setul actiunilor de baza'
    TabOrder = 2
  end
  object btnCancel: TcxButton
    Left = 783
    Top = 359
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 4
  end
  object btnOk: TcxButton
    Left = 679
    Top = 359
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 3
  end
end
