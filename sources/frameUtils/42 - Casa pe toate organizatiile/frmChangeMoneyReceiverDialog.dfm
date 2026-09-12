object frmChangeMoneyReceiverDlg: TfrmChangeMoneyReceiverDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1048#1079#1084#1077#1085#1077#1085#1080#1077' '#1087#1086#1083#1091#1095#1072#1090#1077#1083#1103' '#1076#1077#1085#1077#1075
  ClientHeight = 324
  ClientWidth = 510
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    510
    324)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 510
    Height = 64
    Title = #1048#1079#1084#1077#1085#1077#1085#1080#1077' '#1087#1086#1083#1091#1095#1072#1090#1077#1083#1103' '#1076#1077#1085#1077#1075
    Text = #1042#1099#1073#1077#1088#1080#1090#1077' '#1085#1086#1074#1086#1075#1086' '#1087#1086#1083#1091#1095#1072#1090#1077#1083#1103' '#1076#1077#1085#1077#1075
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
    ImageIndex = 28
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 494
    Height = 193
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
    object cxLabel3: TLabel
      Left = 16
      Top = 92
      Width = 105
      Height = 15
      Caption = #1053#1086#1074#1099#1081' '#1087#1086#1083#1091#1095#1072#1090#1077#1083#1100
    end
    object Label1: TLabel
      Left = 16
      Top = 20
      Width = 77
      Height = 15
      Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
    end
    object Label2: TLabel
      Left = 224
      Top = 20
      Width = 85
      Height = 15
      Caption = #1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077
    end
    object Label3: TLabel
      Left = 224
      Top = 92
      Width = 85
      Height = 15
      Caption = #1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077
    end
    object edUserName: TcxTextEdit
      Left = 16
      Top = 36
      TabStop = False
      Properties.ReadOnly = True
      TabOrder = 0
      Width = 193
    end
    object edFirmaName: TcxTextEdit
      Left = 224
      Top = 36
      TabStop = False
      Properties.ReadOnly = True
      TabOrder = 1
      Width = 241
    end
    object lcbUser: TcxLookupComboBox
      Left = 16
      Top = 109
      Properties.DropDownListStyle = lsFixedList
      Properties.DropDownRows = 16
      Properties.KeyFieldNames = 'USERID'
      Properties.ListColumns = <
        item
          FieldName = 'USER_FULLNAME'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = IBCDataSourceUsers
      EditValue = -1
      TabOrder = 2
      Width = 193
    end
    object lcbFirma: TcxLookupComboBox
      Left = 224
      Top = 109
      Properties.DropDownListStyle = lsFixedList
      Properties.DropDownRows = 16
      Properties.KeyFieldNames = 'CUSTOMERID'
      Properties.ListColumns = <
        item
          FieldName = 'DISPLAYNAME'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = IBCDataSourceFirme
      EditValue = -1
      TabOrder = 3
      Width = 241
    end
  end
  object btnOk: TButton
    Left = 292
    Top = 280
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = '&Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 400
    Top = 280
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
  object IBCQueryUsers: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      'SELECT'
      ' USERID,'
      ' USER_FULLNAME'
      'FROM'
      ' GET_USERS_BY_USER2(:SCU)'
      'ORDER BY'
      ' USER_FULLNAME')
    Left = 352
    Top = 53
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'SCU'
        Value = nil
      end>
  end
  object IBCDataSourceUsers: TIBCDataSource
    AutoEdit = False
    DataSet = IBCQueryUsers
    Left = 352
    Top = 5
  end
  object IBCQueryFirme: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      'SELECT'
      ' *'
      'FROM'
      ' GET_FIRMS_BY_USER(:USERID)'
      'ORDER BY'
      ' DISPLAYNAME')
    Left = 468
    Top = 57
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'USERID'
        Value = nil
      end>
  end
  object IBCDataSourceFirme: TIBCDataSource
    AutoEdit = False
    DataSet = IBCQueryFirme
    Left = 468
    Top = 9
  end
end
