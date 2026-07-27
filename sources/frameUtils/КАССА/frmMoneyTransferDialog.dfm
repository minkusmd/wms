object frmMoneyTransferDlg: TfrmMoneyTransferDlg
  Left = 0
  Top = 0
  ActiveControl = edSuma
  BorderStyle = bsDialog
  Caption = #1058#1088#1072#1085#1089#1092#1077#1088' '#1076#1077#1085#1077#1075' '#1089#1077#1073#1077
  ClientHeight = 437
  ClientWidth = 496
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  DesignSize = (
    496
    437)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 496
    Height = 64
    Title = #1058#1088#1072#1085#1089#1092#1077#1088' '#1076#1077#1085#1077#1075' '#1089#1077#1073#1077
    Text = #1058#1088#1072#1085#1089#1092#1077#1088' '#1076#1077#1085#1077#1075' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
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
    Width = 480
    Height = 306
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
    object cxLabel1: TLabel
      Left = 16
      Top = 151
      Width = 41
      Height = 15
      Caption = #1042#1072#1083#1102#1090#1072
    end
    object cxLabel2: TLabel
      Left = 172
      Top = 152
      Width = 38
      Height = 15
      Caption = #1057#1091#1084#1084#1072
    end
    object Label1: TLabel
      Left = 16
      Top = 20
      Width = 77
      Height = 15
      Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
    end
    object Label2: TLabel
      Left = 226
      Top = 20
      Width = 58
      Height = 15
      Caption = #1048#1079' '#1092#1080#1088#1084#1099
    end
    object Label3: TLabel
      Left = 16
      Top = 83
      Width = 48
      Height = 15
      Caption = #1042' '#1092#1080#1088#1084#1091
    end
    object Label5: TLabel
      Left = 16
      Top = 216
      Width = 77
      Height = 15
      Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1081
    end
    object edSuma: TEdit
      Left = 172
      Top = 169
      Width = 79
      Height = 23
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      Text = '0'
    end
    object edUserName: TcxTextEdit
      Left = 16
      Top = 36
      TabStop = False
      Properties.ReadOnly = True
      TabOrder = 0
      Width = 193
    end
    object clbFirme: TcxLookupComboBox
      Left = 16
      Top = 100
      Properties.DropDownListStyle = lsFixedList
      Properties.DropDownRows = 16
      Properties.KeyFieldNames = 'CUSTOMERID'
      Properties.ListColumns = <
        item
          Fixed = True
          Width = 70
          FieldName = 'CUSTOMERID'
        end
        item
          SortOrder = soAscending
          FieldName = 'DISPLAYNAME'
        end>
      Properties.ListFieldIndex = 1
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = IBCDataSourceFirme
      EditValue = -1
      TabOrder = 2
      Width = 440
    end
    object cmbCURRENCY: TcxLookupComboBox
      Left = 16
      Top = 168
      Properties.DropDownListStyle = lsFixedList
      Properties.ImmediatePost = True
      Properties.KeyFieldNames = 'CURRENCYID'
      Properties.ListColumns = <
        item
          FieldName = 'TITLE'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = dmDB.IBCDataSourceCurrency
      Properties.ReadOnly = False
      EditValue = -1
      TabOrder = 3
      Width = 137
    end
    object cbACNT: TCheckBox
      Left = 276
      Top = 172
      Width = 113
      Height = 17
      Caption = #1041#1072#1085#1082
      TabOrder = 5
    end
    object mmComments: TcxMemo
      Left = 16
      Top = 237
      Properties.VisibleLineCount = 3
      TabOrder = 6
      Width = 440
    end
    object edFirmaName: TcxTextEdit
      Left = 226
      Top = 36
      TabStop = False
      Properties.ReadOnly = True
      TabOrder = 1
      Width = 230
    end
  end
  object btnCancel: TcxButton
    Left = 386
    Top = 392
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
  object btnOk: TcxButton
    Left = 286
    Top = 392
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = '&Ok'
    Default = True
    TabOrder = 2
    OnClick = btnOkClick
  end
  object IBCQueryFirme: TIBCQuery
    SQL.Strings = (
      'SELECT'
      ' *'
      'FROM'
      ' GET_FIRMS_BY_USER(:USERID)'
      'WHERE '
      ' CUSTOMERID<>:currFirma'
      'ORDER BY'
      ' DISPLAYNAME')
    Left = 324
    Top = 57
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'USERID'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'currFirma'
        Value = nil
      end>
  end
  object IBCDataSourceFirme: TIBCDataSource
    AutoEdit = False
    DataSet = IBCQueryFirme
    Left = 324
    Top = 9
  end
end
