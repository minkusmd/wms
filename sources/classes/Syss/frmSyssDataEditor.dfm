object frmSyssDataEditorDlg: TfrmSyssDataEditorDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Nomenclator SysS'
  ClientHeight = 447
  ClientWidth = 612
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 612
    Height = 64
    Title = 'Nomenclator'
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
    Width = 596
    Height = 313
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
    object pnVALUE_INT2: TPanel
      Left = 0
      Top = 137
      Width = 592
      Height = 56
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      object lbValue_INT2: TLabel
        Left = 12
        Top = 0
        Width = 32
        Height = 15
        Caption = 'Name'
        Transparent = True
      end
      object lcbVALUE_INT: TcxDBLookupComboBox
        Left = 13
        Top = 18
        DataBinding.DataField = 'VALUE_INT'
        Properties.DropDownListStyle = lsFixedList
        Properties.KeyFieldNames = 'SYSSID'
        Properties.ListColumns = <
          item
            FieldName = 'TITLE'
          end>
        Properties.ListOptions.ShowHeader = False
        TabOrder = 0
        Width = 245
      end
    end
    object pnVALUE_STR: TPanel
      Left = 0
      Top = 193
      Width = 592
      Height = 61
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 2
      object lbValue_STR: TLabel
        Left = 13
        Top = 0
        Width = 32
        Height = 15
        Caption = 'Name'
        Transparent = True
      end
      object edVALUE_STR: TcxDBTextEdit
        Left = 13
        Top = 17
        DataBinding.DataField = 'VALUE_STR'
        TabOrder = 0
        Width = 572
      end
    end
    object pnGeneral: TPanel
      Left = 0
      Top = 0
      Width = 592
      Height = 137
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object cxLabel1: TLabel
        Left = 12
        Top = 56
        Width = 52
        Height = 15
        Caption = 'Denumire'
        Transparent = True
      end
      object cxLabel2: TLabel
        Left = 12
        Top = 8
        Width = 22
        Height = 15
        Caption = 'Cod'
        Transparent = True
      end
      object edSYSSID: TcxDBTextEdit
        Left = 12
        Top = 26
        DataBinding.DataField = 'SYSSID'
        TabOrder = 0
        Width = 77
      end
      object edTitle: TcxDBMemo
        Left = 13
        Top = 74
        DataBinding.DataField = 'TITLE'
        ParentFont = False
        Properties.VisibleLineCount = 3
        Style.Font.Charset = RUSSIAN_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -13
        Style.Font.Name = 'Consolas'
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 1
        Width = 572
      end
    end
    object pnValue_INT1: TPanel
      Left = 0
      Top = 254
      Width = 592
      Height = 55
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 3
      object lbValue_INT1: TLabel
        Left = 12
        Top = 0
        Width = 32
        Height = 15
        Caption = 'Name'
        Transparent = True
      end
      object edVALUE_INT: TcxDBTextEdit
        Left = 12
        Top = 17
        DataBinding.DataField = 'VALUE_INT'
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 0
        Width = 129
      end
    end
  end
  object pnButtons: TPanel
    Left = 0
    Top = 393
    Width = 612
    Height = 48
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    DesignSize = (
      612
      48)
    object lbIDInfo: TLabel
      Left = 22
      Top = 3
      Width = 185
      Height = 30
      Caption = 'Introduceti un cod nou consecutiv pentru grupa selectata.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
    object btnCancel: TcxButton
      Left = 498
      Top = 7
      Width = 90
      Height = 29
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = 'Renunta'
      ModalResult = 2
      TabOrder = 1
    end
    object btnOk: TcxButton
      Left = 396
      Top = 7
      Width = 90
      Height = 29
      Anchors = [akRight, akBottom]
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
  end
end
