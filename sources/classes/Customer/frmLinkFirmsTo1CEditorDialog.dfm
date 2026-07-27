object frmLinkFirmsTo1CEditorDlg: TfrmLinkFirmsTo1CEditorDlg
  Left = 0
  Top = 0
  ActiveControl = lcbCUSTOMERID
  BorderStyle = bsDialog
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1092#1080#1088#1084#1099' '#1076#1083#1103' 1'#1057
  ClientHeight = 448
  ClientWidth = 551
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    551
    448)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 551
    Height = 64
    Title = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1092#1080#1088#1084#1099' '#1076#1083#1103' 1'#1057
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
    Width = 535
    Height = 321
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
      Left = 20
      Top = 24
      Width = 38
      Height = 15
      Caption = #1060#1080#1088#1084#1072
    end
    object Label2: TLabel
      Left = 20
      Top = 56
      Width = 90
      Height = 15
      Caption = #1050#1086#1076' '#1092#1080#1088#1084#1099' '#1074' 1'#1057
    end
    object Label3: TLabel
      Left = 20
      Top = 85
      Width = 122
      Height = 15
      Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1092#1080#1088#1084#1099' '#1074' 1'#1057
    end
    object Label4: TLabel
      Left = 20
      Top = 114
      Width = 86
      Height = 15
      Caption = #1050#1086#1076' '#1089#1082#1083#1072#1076#1072' '#1074' 1'#1057
    end
    object Label5: TLabel
      Left = 20
      Top = 143
      Width = 118
      Height = 15
      Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1089#1082#1083#1072#1076#1072' '#1074' 1'#1057
    end
    object Label6: TLabel
      Left = 20
      Top = 172
      Width = 60
      Height = 15
      Caption = #1058#1080#1087' '#1089#1082#1083#1072#1076#1072
    end
    object Label7: TLabel
      Left = 20
      Top = 201
      Width = 100
      Height = 15
      Caption = #1050#1086#1076' '#1092#1080#1079' '#1083#1080#1094#1072' '#1074' 1'#1057
    end
    object Label8: TLabel
      Left = 20
      Top = 230
      Width = 132
      Height = 15
      Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1092#1080#1079' '#1083#1080#1094#1072' '#1074' 1'#1057
    end
    object Label9: TLabel
      Left = 20
      Top = 260
      Width = 93
      Height = 15
      Caption = #1043#1086#1083#1086#1074#1085#1072#1103' '#1092#1080#1088#1084#1072
    end
    object edFIRMA_COD: TcxDBTextEdit
      Left = 168
      Top = 53
      DataBinding.DataField = 'FIRMA_COD'
      TabOrder = 1
      Width = 157
    end
    object edFIRMA_NAME: TcxDBTextEdit
      Left = 168
      Top = 82
      DataBinding.DataField = 'FIRMA_NAME'
      TabOrder = 2
      Width = 341
    end
    object edSKLAD_COD: TcxDBTextEdit
      Left = 168
      Top = 111
      DataBinding.DataField = 'SKLAD_COD'
      TabOrder = 3
      Width = 157
    end
    object edSKLAD_TITLE: TcxDBTextEdit
      Left = 168
      Top = 140
      DataBinding.DataField = 'SKLAD_TITLE'
      TabOrder = 4
      Width = 341
    end
    object cmbSKLAD_TYPE: TcxDBComboBox
      Left = 168
      Top = 169
      DataBinding.DataField = 'SKLAD_TYPE'
      Properties.Items.Strings = (
        #1056#1086#1079#1085#1080#1095#1085#1099#1081)
      TabOrder = 5
      Width = 157
    end
    object edPERS_FIZ_CODE: TcxDBTextEdit
      Left = 168
      Top = 198
      DataBinding.DataField = 'PERS_FIZ_CODE'
      TabOrder = 6
      Width = 157
    end
    object edPERS_FIZ_TITLE: TcxDBTextEdit
      Left = 168
      Top = 227
      DataBinding.DataField = 'PERS_FIZ_TITLE'
      TabOrder = 7
      Width = 341
    end
    object lcbCUSTOMERID: TcxDBLookupComboBox
      Left = 168
      Top = 21
      DataBinding.DataField = 'CUSTOMERID'
      Properties.DropDownListStyle = lsFixedList
      Properties.DropDownRows = 16
      Properties.KeyFieldNames = 'CUSTOMERID'
      Properties.ListColumns = <
        item
          FieldName = 'DISPLAYNAME'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = IBCDataSourceFirms
      TabOrder = 0
      Width = 341
    end
    object lcbDT: TcxDBLookupComboBox
      Left = 168
      Top = 256
      DataBinding.DataField = 'DT'
      Properties.DropDownListStyle = lsFixedList
      Properties.DropDownRows = 16
      Properties.KeyFieldNames = 'CUSTOMERID'
      Properties.ListColumns = <
        item
          FieldName = 'DISPLAYNAME'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = IBCDataSourceMainFirms
      TabOrder = 8
      Width = 341
    end
  end
  object btnOk: TButton
    Left = 336
    Top = 404
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 440
    Top = 404
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
  object IBCQueryFirms: TIBCQuery
    SQL.Strings = (
      'SELECT '
      'CUSTOMERID,'
      'DISPLAYNAME'
      'FROM TS_CUSTOMER'
      'WHERE PARENTID=:PARENTID')
    Left = 60
    Top = 352
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PARENTID'
        Value = nil
      end>
  end
  object IBCDataSourceFirms: TIBCDataSource
    DataSet = IBCQueryFirms
    Left = 60
    Top = 404
  end
  object IBCQueryMainFirms: TIBCQuery
    SQL.Strings = (
      'SELECT '
      'CUSTOMERID,'
      'DISPLAYNAME'
      'FROM TS_CUSTOMER'
      'WHERE PARENTID=:PARENTID')
    Left = 172
    Top = 352
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PARENTID'
        Value = nil
      end>
  end
  object IBCDataSourceMainFirms: TIBCDataSource
    DataSet = IBCQueryMainFirms
    Left = 172
    Top = 404
  end
end
