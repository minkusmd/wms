object frmServiceRefTaskTypeEditorDlg: TfrmServiceRefTaskTypeEditorDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1058#1080#1087' '#1079#1072#1076#1072#1095#1080
  ClientHeight = 522
  ClientWidth = 538
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 538
    Height = 64
    Title = #1058#1080#1087' '#1079#1072#1076#1072#1095#1080
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
    ImageIndex = 32
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 522
    Height = 397
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
      Left = 20
      Top = 20
      Width = 52
      Height = 15
      Caption = #1053#1072#1079#1074#1072#1085#1080#1077
    end
    object Label2: TLabel
      Left = 20
      Top = 80
      Width = 55
      Height = 15
      Caption = #1054#1087#1080#1089#1072#1085#1080#1077
    end
    object Label3: TLabel
      Left = 20
      Top = 215
      Width = 100
      Height = 15
      Caption = #1042#1080#1076#1080#1084#1086#1089#1090#1100' '#1079#1072#1076#1072#1095#1080
    end
    object Label4: TLabel
      Left = 286
      Top = 240
      Width = 53
      Height = 15
      Caption = #1047#1085#1072#1095#1077#1085#1080#1077
    end
    object Label5: TLabel
      Left = 20
      Top = 323
      Width = 114
      Height = 15
      Caption = #1048#1089#1087#1086#1083#1085#1080#1090#1077#1083#1100' '#1079#1072#1076#1072#1095#1080
    end
    object edTITLE: TcxDBTextEdit
      Left = 20
      Top = 37
      DataBinding.DataField = 'TITLE'
      TabOrder = 0
      Width = 469
    end
    object mmDESCRIPTION: TcxDBMemo
      Left = 20
      Top = 97
      DataBinding.DataField = 'DESCRIPTION'
      Properties.ScrollBars = ssVertical
      Properties.VisibleLineCount = 3
      TabOrder = 1
      Width = 469
    end
    object cbFLG_START_STATE: TcxDBCheckBox
      Left = 32
      Top = 232
      Caption = #1074' '#1085#1072#1095#1072#1083#1077' '#1101#1090#1072#1087#1072
      DataBinding.DataField = 'FLG_START_STATE'
      Properties.Alignment = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ValueChecked = 1
      Properties.ValueUnchecked = 0
      TabOrder = 3
    end
    object cbFLG_END_STATE: TcxDBCheckBox
      Left = 32
      Top = 257
      Caption = #1074' '#1082#1086#1085#1094#1077' '#1101#1090#1072#1087#1072
      DataBinding.DataField = 'FLG_END_STATE'
      Properties.Alignment = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ValueChecked = 1
      Properties.ValueUnchecked = 0
      TabOrder = 4
    end
    object cbFLG_CODE_STATE: TcxDBCheckBox
      Left = 32
      Top = 282
      Caption = #1090#1086#1083#1100#1082#1086' '#1076#1083#1103' '#1087#1088#1086#1075#1088#1072#1084#1084#1080#1089#1090#1072
      DataBinding.DataField = 'FLG_CODE_STATE'
      Properties.Alignment = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ValueChecked = 1
      Properties.ValueUnchecked = 0
      TabOrder = 6
    end
    object cmbValue: TcxComboBox
      Left = 286
      Top = 257
      Properties.DropDownListStyle = lsFixedList
      Properties.Items.Strings = (
        #1053#1077' '#1074#1072#1078#1085#1086
        #1054#1090#1088#1080#1094#1072#1090#1077#1083#1100#1085#1086#1077
        #1055#1086#1083#1086#1078#1080#1090#1077#1083#1100#1085#1086#1077)
      TabOrder = 5
      Text = #1053#1077' '#1074#1072#1078#1085#1086
      Width = 181
    end
    object cbFLG_ENABLED: TcxDBCheckBox
      Left = 20
      Top = 174
      Caption = #1058#1080#1087' '#1079#1072#1076#1072#1095#1080' '#1076#1086#1089#1090#1091#1087#1077#1085
      DataBinding.DataField = 'FLG_ENABLED'
      Properties.Alignment = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ValueChecked = 1
      Properties.ValueUnchecked = 0
      TabOrder = 2
    end
    object cbFLG_OTHER_EXECUTANT: TcxDBCheckBox
      Left = 32
      Top = 344
      Caption = #1058#1088#1077#1073#1091#1077#1090#1089#1103' '#1076#1088#1091#1075#1086#1081' '#1080#1089#1087#1086#1083#1085#1080#1090#1077#1083#1100
      DataBinding.DataField = 'FLG_OTHER_EXECUTANT'
      Properties.Alignment = taLeftJustify
      Properties.ImmediatePost = True
      Properties.ValueChecked = 1
      Properties.ValueUnchecked = 0
      TabOrder = 7
    end
    object clbUSER_GROUP_ID: TcxDBLookupComboBox
      Left = 241
      Top = 344
      DataBinding.DataField = 'USER_GROUP_ID'
      Properties.DropDownListStyle = lsFixedList
      Properties.DropDownRows = 16
      Properties.KeyFieldNames = 'GROUPID'
      Properties.ListColumns = <
        item
          FieldName = 'NAME'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = IBCDataSourceUG
      TabOrder = 8
      Width = 226
    end
  end
  object btnOk: TButton
    Left = 316
    Top = 480
    Width = 90
    Height = 29
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 424
    Top = 480
    Width = 90
    Height = 29
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
  object IBCQueryUG: TIBCQuery
    SQL.Strings = (
      'SElECT'
      'GROUPID, NAME'
      'FROM VW_TS_USER_GROUPS'
      'WHERE FLG_SERVICE=1'
      'ORDER BY NAME')
    Left = 356
    Top = 144
  end
  object IBCDataSourceUG: TIBCDataSource
    DataSet = IBCQueryUG
    Left = 356
    Top = 200
  end
end
