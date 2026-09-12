object frmUserActivityMonitorEditorDlg: TfrmUserActivityMonitorEditorDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1052#1086#1085#1080#1090#1086#1088' '#1072#1082#1090#1080#1074#1085#1086#1089#1090#1080
  ClientHeight = 272
  ClientWidth = 456
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    456
    272)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 456
    Height = 64
    Title = #1052#1086#1085#1080#1090#1086#1088' '#1072#1082#1090#1080#1074#1085#1086#1089#1090#1080
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
    ImageIndex = 2
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 440
    Height = 146
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
    TabOrder = 1
    object Label1: TLabel
      Left = 20
      Top = 60
      Width = 77
      Height = 15
      Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
    end
    object Label2: TLabel
      Left = 20
      Top = 89
      Width = 53
      Height = 15
      Caption = #1048#1085#1090#1077#1088#1074#1072#1083
    end
    object Label3: TLabel
      Left = 230
      Top = 89
      Width = 21
      Height = 15
      Caption = 'min'
    end
    object clbUsers: TcxDBLookupComboBox
      Left = 103
      Top = 57
      DataBinding.DataField = 'USERID'
      Properties.DropDownListStyle = lsFixedList
      Properties.DropDownRows = 16
      Properties.DropDownWidth = 450
      Properties.KeyFieldNames = 'USERID'
      Properties.ListColumns = <
        item
          Width = 200
          FieldName = 'FULL_NAME'
        end
        item
          Width = 150
          FieldName = 'DISPLAYNAME'
        end
        item
          Width = 100
          FieldName = 'FUNCTIA_DETINUTA'
        end>
      Properties.ListSource = IBCDataSourceUsers
      TabOrder = 1
      Width = 306
    end
    object seInterval: TcxDBSpinEdit
      Left = 103
      Top = 86
      DataBinding.DataField = 'INTERVAL'
      Properties.MaxValue = 60.000000000000000000
      Properties.MinValue = 1.000000000000000000
      TabOrder = 2
      Width = 121
    end
    object cbFLG_ENABLED: TcxDBCheckBox
      Left = 20
      Top = 20
      Caption = #1052#1086#1085#1080#1090#1086#1088' '#1072#1082#1090#1080#1074#1077#1085
      DataBinding.DataField = 'FLG_ENABLED'
      Properties.Alignment = taLeftJustify
      Properties.ValueChecked = 1
      Properties.ValueUnchecked = 0
      TabOrder = 0
    end
  end
  object btnOk: TButton
    Left = 246
    Top = 229
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 346
    Top = 229
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
  object IBCQueryUsers: TIBCQuery
    SQL.Strings = (
      'SELECT'
      'TS_USERS.USERID,'
      'TS_USERS.FULL_NAME,'
      'TS_CUSTOMER.DISPLAYNAME,'
      'TS_USERS.FUNCTIA_DETINUTA'
      'FROM TS_USERS'
      
        'INNER JOIN TS_CUSTOMER ON (TS_CUSTOMER.CUSTOMERID=TS_USERS.DEFAU' +
        'LT_DT)'
      'WHERE (TS_USERS.USERID NOT IN (-1,1,7,9,202,204,210))'
      'Order BY 2,3')
    ReadOnly = True
    Left = 136
    Top = 164
  end
  object IBCDataSourceUsers: TIBCDataSource
    DataSet = IBCQueryUsers
    Left = 136
    Top = 216
  end
end
