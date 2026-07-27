object frmSyssFolderEditorDlg: TfrmSyssFolderEditorDlg
  Left = 0
  Top = 0
  ActiveControl = edTITLE
  BorderStyle = bsDialog
  Caption = #1043#1088#1091#1087#1087#1072' '#1089#1087#1088#1072#1074#1086#1095#1085#1080#1082#1086#1074
  ClientHeight = 352
  ClientWidth = 512
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    512
    352)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 512
    Height = 64
    Title = #1043#1088#1091#1087#1087#1072' '#1089#1087#1088#1072#1074#1086#1095#1085#1080#1082#1086#1074
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
    Width = 496
    Height = 221
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
    object lbMasterGroup: TLabel
      Left = 189
      Top = 176
      Width = 82
      Height = 15
      Caption = #1052#1072#1089#1090#1077#1088' '#1075#1088#1091#1087#1087#1072
      Enabled = False
      Transparent = True
    end
    object lbFieldName: TLabel
      Left = 189
      Top = 84
      Width = 82
      Height = 15
      Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1087#1086#1083#1103
      Enabled = False
      Transparent = True
    end
    object cxLabel2: TLabel
      Left = 12
      Top = 16
      Width = 20
      Height = 15
      Caption = #1050#1086#1076
      Transparent = True
    end
    object cxLabel1: TLabel
      Left = 64
      Top = 16
      Width = 96
      Height = 15
      Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1075#1088#1091#1087#1087#1099
      Transparent = True
    end
    object edTITLE: TcxDBTextEdit
      Left = 64
      Top = 36
      DataBinding.DataField = 'TITLE'
      TabOrder = 1
      Width = 406
    end
    object lcbVALUE_INT: TcxDBLookupComboBox
      Left = 281
      Top = 172
      DataBinding.DataField = 'VALUE_INT'
      Enabled = False
      Properties.DropDownListStyle = lsFixedList
      Properties.KeyFieldNames = 'SYSSID'
      Properties.ListColumns = <
        item
          FieldName = 'TITLE'
        end>
      Properties.ListSource = IBCDataSourceSYSSGroups
      Properties.OnInitPopup = lcbVALUE_INTPropertiesInitPopup
      TabOrder = 6
      Width = 189
    end
    object edVALUE_STR: TcxDBTextEdit
      Left = 281
      Top = 81
      DataBinding.DataField = 'VALUE_STR'
      Enabled = False
      TabOrder = 2
      Width = 189
    end
    object edID: TcxDBTextEdit
      Left = 12
      Top = 36
      TabStop = False
      DataBinding.DataField = 'SYSSID'
      TabOrder = 0
      Width = 46
    end
    object rbMastered: TRadioButton
      Left = 40
      Top = 176
      Width = 145
      Height = 17
      Caption = #1043#1088#1091#1087#1087#1072' '#1079#1085#1072#1095#1077#1085#1080#1081
      Enabled = False
      TabOrder = 7
      OnClick = rbSimpleValueClick
    end
    object rbSimpleValue: TRadioButton
      Left = 40
      Top = 149
      Width = 145
      Height = 17
      Caption = #1055#1088#1086#1089#1090#1086#1077' '#1079#1085#1072#1095#1077#1085#1080#1077
      Checked = True
      Enabled = False
      TabOrder = 5
      TabStop = True
      OnClick = rbSimpleValueClick
    end
    object cbNeedValue: TCheckBox
      Left = 12
      Top = 120
      Width = 152
      Height = 17
      Caption = #1063#1080#1089#1083#1086#1074#1086#1077' '#1087#1086#1083#1077
      TabOrder = 4
      OnClick = cbNeedValueClick
    end
    object cbNeedEditor: TCheckBox
      Left = 12
      Top = 84
      Width = 161
      Height = 17
      Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1086#1077' '#1087#1086#1083#1077
      TabOrder = 3
      OnClick = cbNeedEditorClick
    end
  end
  object btnOk: TcxButton
    Left = 298
    Top = 307
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = '&Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TcxButton
    Left = 402
    Top = 307
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
  object IBCQuerySYSSGroups: TIBCQuery
    KeyFields = 'SYSSID'
    SQL.Strings = (
      'SELECT'
      ' SYSSID,'
      ' TITLE'
      'FROM '
      ' TS_SYSS'
      'WHERE'
      ' (PARENTID = 0)')
    Options.RequiredFields = False
    LocalConstraints = False
    Left = 436
    Top = 144
  end
  object IBCDataSourceSYSSGroups: TIBCDataSource
    DataSet = IBCQuerySYSSGroups
    Left = 436
    Top = 92
  end
end
