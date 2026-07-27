object frmGoodsSendGoodsToNPSCDlg: TfrmGoodsSendGoodsToNPSCDlg
  Left = 0
  Top = 0
  ActiveControl = lcbOperator
  BorderStyle = bsDialog
  Caption = #1055#1077#1088#1077#1076#1072#1090#1100' '#1085#1072' '#1086#1092#1086#1088#1084#1083#1077#1085#1080#1077
  ClientHeight = 328
  ClientWidth = 397
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    397
    328)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 397
    Height = 64
    Title = #1055#1077#1088#1077#1076#1072#1090#1100' '#1085#1072' '#1086#1092#1086#1088#1084#1083#1077#1085#1080#1077
    Text = #1042#1099#1073#1077#1088#1080#1090#1077' '#1086#1087#1077#1088#1072#1090#1086#1088#1072' '#1076#1083#1103' '#1088#1072#1073#1086#1090#1099' '#1085#1072#1076' '#1090#1086#1074#1072#1088#1072#1084#1080
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
    ImageIndex = 1
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 381
    Height = 202
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
      Top = 87
      Width = 87
      Height = 15
      Caption = #1054#1087#1077#1088#1072#1090#1086#1088' NPSC'
    end
    object Label2: TLabel
      Left = 20
      Top = 24
      Width = 289
      Height = 15
      Caption = #1054#1090#1087#1088#1072#1074#1082#1072' '#1090#1086#1074#1072#1088#1086#1074' '#1076#1083#1103' '#1086#1092#1086#1088#1084#1083#1077#1085#1080#1103' '#1074' '#1089#1080#1089#1090#1077#1084#1091' NPSC.'
    end
    object lbInfo: TLabel
      Left = 20
      Top = 45
      Width = 3
      Height = 15
    end
    object lcbOperator: TcxLookupComboBox
      Left = 20
      Top = 104
      Properties.DropDownListStyle = lsFixedList
      Properties.DropDownRows = 16
      Properties.KeyFieldNames = 'NGS_USER_ID'
      Properties.ListColumns = <
        item
          FieldName = 'CONCATENATION'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = IBCDataSourceOP
      EditValue = 0
      TabOrder = 0
      Width = 329
    end
    object cxLabel1: TcxLabel
      Left = 20
      Top = 144
      Caption = 
        #1042' '#1086#1073#1088#1072#1073#1086#1090#1082#1091' '#1087#1086#1089#1090#1091#1087#1103#1090#1100' '#1090#1086#1083#1100#1082#1086' '#1090#1077' '#1090#1086#1074#1072#1088#1099', '#1082#1086#1090#1086#1088#1099#1077' '#1085#1072' '#1084#1086#1084#1077#1085#1090' '#1085#1077' '#1085#1072#1093 +
        #1086#1076#1103#1090#1100#1089#1103' '#1091#1078#1077' '#1074' '#1086#1073#1088#1072#1073#1086#1090#1082#1077'!'
      Style.TextColor = clMaroon
      Properties.WordWrap = True
      Width = 281
    end
  end
  object btnOk: TButton
    Left = 176
    Top = 285
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 280
    Top = 285
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
  object IBCQueryOP: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT U.NGS_USER_ID, U.FIRST_NAME || '#39' '#39' || U.LAST_NAME'
      'FROM NGS_USERS U'
      
        'INNER JOIN NGS_USER_ROLES UR ON UR.USER_ID = U.NGS_USER_ID AND U' +
        'R.ROLE_ID = 1'
      'WHERE U.FLG_ENABLED = 1'
      'ORDER BY 2')
    Left = 80
    Top = 68
  end
  object IBCDataSourceOP: TIBCDataSource
    DataSet = IBCQueryOP
    Left = 80
    Top = 120
  end
  object IBCDataSourceUsers: TIBCDataSource
    DataSet = IBCQueryUsers
    Left = 232
    Top = 128
  end
  object IBCQueryUsers: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT U.USERID, U.FULL_NAME'
      'FROM TS_USERS U'
      'join ts_user_group_links gl on (gl.userid = u.userid)'
      
        'join ts_user_groups ug on (ug.groupid=gl.groupid) and (gl.groupi' +
        'd=22)'
      'WHERE (get_flg_value(U.flags,0) = 1)'
      'ORDER BY 2')
    Left = 232
    Top = 76
  end
end
