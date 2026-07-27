object frm57ChangeUser: Tfrm57ChangeUser
  Left = 0
  Top = 0
  ActiveControl = cbNewUser
  BorderStyle = bsDialog
  Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
  ClientHeight = 241
  ClientWidth = 473
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
  object DialogTitle1: TDialogTitle
    Left = 0
    Top = 0
    Width = 473
    Height = 64
    Title = #1048#1079#1084#1077#1085#1080#1090#1100' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
    Text = #1048#1079#1084#1077#1085#1080#1090#1100' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103' '#1076#1083#1103' '#1074#1099#1073#1088#1072#1085#1085#1086#1075#1086' '#1090#1086#1074#1072#1088#1072
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
    ImageIndex = 2
  end
  object btnOK: TcxButton
    Left = 262
    Top = 200
    Width = 90
    Height = 29
    Caption = #1054#1050
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TcxButton
    Left = 363
    Top = 200
    Width = 90
    Height = 29
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 3
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 457
    Height = 117
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    ShowCaption = False
    TabOrder = 1
    object cxLabel2: TcxLabel
      Left = 16
      Top = 24
      Caption = #1058#1077#1082#1091#1097#1080#1081' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
    end
    object teOldUserName: TcxTextEdit
      Left = 160
      Top = 23
      TabOrder = 1
      Width = 273
    end
    object cxLabel1: TcxLabel
      Left = 16
      Top = 63
      Caption = #1053#1086#1074#1099#1081' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
    end
    object cbNewUser: TcxLookupComboBox
      Left = 160
      Top = 62
      Properties.DropDownListStyle = lsFixedList
      Properties.DropDownRows = 16
      Properties.DropDownWidth = 400
      Properties.KeyFieldNames = 'USERID'
      Properties.ListColumns = <
        item
          Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
          FieldName = 'FULL_NAME'
        end
        item
          Caption = #1060#1080#1088#1084#1072
          FieldName = 'DISPLAYNAME'
        end>
      Properties.ListSource = IBCDS_Users
      EditValue = -1
      TabOrder = 3
      Width = 273
    end
  end
  object IBC_Users: TIBCQuery
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      'SELECT U.USERID, U.FULL_NAME, C.DISPLAYNAME'
      'FROM TS_USERS U'
      'INNER JOIN TS_CUSTOMER C ON C.CUSTOMERID=U.DEFAULT_DT'
      'WHERE GET_FLG_VALUE(U.FLAGS, 0) = 1'
      'ORDER BY 3,2')
    Left = 316
    Top = 12
  end
  object IBCDS_Users: TIBCDataSource
    DataSet = IBC_Users
    Left = 260
    Top = 12
  end
end
