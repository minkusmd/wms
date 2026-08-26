object frmAttributeEditorDlg: TfrmAttributeEditorDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Atribut'
  ClientHeight = 437
  ClientWidth = 494
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  DesignSize = (
    494
    437)
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 494
    Height = 64
    Title = 'Atribut'
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
    ImageIndex = 16
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 478
    Height = 315
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 12
      Width = 71
      Height = 15
      Caption = 'Denumire RO'
    end
    object Label2: TLabel
      Left = 16
      Top = 60
      Width = 70
      Height = 15
      Caption = 'Denumire RU'
    end
    object Label3: TLabel
      Left = 16
      Top = 108
      Width = 36
      Height = 15
      Caption = 'Ordine'
    end
    object Label4: TLabel
      Left = 140
      Top = 108
      Width = 72
      Height = 15
      Caption = 'Unit. mas. RO'
    end
    object Label5: TLabel
      Left = 280
      Top = 108
      Width = 71
      Height = 15
      Caption = 'Unit. mas. RU'
    end
    object edNAME_RO: TcxDBTextEdit
      Left = 16
      Top = 29
      DataBinding.DataField = 'NAME_RO'
      Properties.MaxLength = 512
      Properties.ValidateOnEnter = True
      TabOrder = 0
      Width = 437
    end
    object edNAME_RU: TcxDBTextEdit
      Left = 16
      Top = 77
      DataBinding.DataField = 'NAME_RU'
      Properties.MaxLength = 512
      Properties.ValidateOnEnter = True
      TabOrder = 1
      Width = 437
    end
    object edORDERNO: TcxDBSpinEdit
      Left = 16
      Top = 125
      DataBinding.DataField = 'ORDERNO'
      TabOrder = 2
      Width = 100
    end
    object edUOM_RO: TcxDBTextEdit
      Left = 140
      Top = 125
      DataBinding.DataField = 'UOM_RO'
      Properties.MaxLength = 64
      TabOrder = 3
      Width = 120
    end
    object edUOM_RU: TcxDBTextEdit
      Left = 280
      Top = 125
      DataBinding.DataField = 'UOM_RU'
      Properties.MaxLength = 64
      TabOrder = 4
      Width = 120
    end
    object chkFILTERABLE: TcxDBCheckBox
      Left = 14
      Top = 158
      Caption = 'Filtrabil'
      DataBinding.DataField = 'FLG_FILTERABLE'
      Properties.NullStyle = nssUnchecked
      Properties.ValueChecked = 1
      Properties.ValueUnchecked = 0
      TabOrder = 5
      Transparent = True
    end
    object chkVARIATION: TcxDBCheckBox
      Left = 14
      Top = 180
      Caption = 'Creeaza variatie'
      DataBinding.DataField = 'FLG_VARIATION'
      Properties.NullStyle = nssUnchecked
      Properties.ValueChecked = 1
      Properties.ValueUnchecked = 0
      TabOrder = 6
      Transparent = True
    end
    object chkIN_NAME: TcxDBCheckBox
      Left = 14
      Top = 202
      Caption = 'Participa la denumire'
      DataBinding.DataField = 'FLG_IN_NAME'
      Properties.NullStyle = nssUnchecked
      Properties.ValueChecked = 1
      Properties.ValueUnchecked = 0
      TabOrder = 7
      Transparent = True
    end
    object chkRECOMMENDED: TcxDBCheckBox
      Left = 16
      Top = 224
      Caption = 'Recomandat'
      DataBinding.DataField = 'FLG_RECOMMENDED'
      Properties.NullStyle = nssUnchecked
      Properties.ValueChecked = 1
      Properties.ValueUnchecked = 0
      TabOrder = 8
      Transparent = True
    end
    object chkMULTI: TcxDBCheckBox
      Left = 14
      Top = 246
      Caption = 'Valori multiple (ex. note parfum)'
      DataBinding.DataField = 'FLG_MULTI'
      Properties.NullStyle = nssUnchecked
      Properties.ValueChecked = 1
      Properties.ValueUnchecked = 0
      TabOrder = 9
      Transparent = True
    end
    object chkFREE_VALUE: TcxDBCheckBox
      Left = 14
      Top = 267
      Caption = 'Valoare libera (fara dictionar)'
      DataBinding.DataField = 'FLG_FREE_VALUE'
      Properties.NullStyle = nssUnchecked
      Properties.ValueChecked = 1
      Properties.ValueUnchecked = 0
      TabOrder = 10
      Transparent = True
    end
  end
  object btnOk: TcxButton
    Left = 280
    Top = 396
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancel: TcxButton
    Left = 376
    Top = 396
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 2
  end
end
