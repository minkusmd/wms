object frmUserWorkBonusEditorDlg: TfrmUserWorkBonusEditorDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1041#1086#1085#1091#1089' '#1088#1072#1073#1086#1090#1085#1080#1082#1072
  ClientHeight = 343
  ClientWidth = 492
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
    Width = 492
    Height = 64
    Title = #1041#1086#1085#1091#1089' '#1088#1072#1073#1086#1090#1085#1080#1082#1072
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
    Width = 476
    Height = 217
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
    object Label1: TLabel
      Left = 20
      Top = 24
      Width = 25
      Height = 15
      Caption = #1044#1072#1090#1072
    end
    object Label2: TLabel
      Left = 20
      Top = 54
      Width = 62
      Height = 15
      Caption = #1050#1086#1085#1090#1088#1072#1075#1077#1085#1090
    end
    object Label3: TLabel
      Left = 20
      Top = 82
      Width = 33
      Height = 15
      Caption = #1041#1086#1085#1091#1089
    end
    object Label4: TLabel
      Left = 20
      Top = 111
      Width = 55
      Height = 15
      Caption = #1054#1087#1080#1089#1072#1085#1080#1077
    end
    object Label5: TLabel
      Left = 196
      Top = 82
      Width = 242
      Height = 15
      Caption = #1083#1077#1077#1074'. '#1054#1090#1088#1080#1094#1072#1090#1077#1083#1100#1085#1086#1077' '#1079#1085#1072#1095#1077#1085#1080#1077' '#1076#1083#1103' '#1096#1090#1088#1072#1092#1072'.'
    end
    object deDATA: TcxDBDateEdit
      Left = 92
      Top = 21
      DataBinding.DataField = 'DATA'
      TabOrder = 0
      Width = 161
    end
    object lcbCT: TcxDBLookupComboBox
      Left = 92
      Top = 50
      DataBinding.DataField = 'CT'
      Properties.DropDownListStyle = lsFixedList
      Properties.DropDownRows = 16
      Properties.DropDownWidth = 500
      Properties.KeyFieldNames = 'CT'
      Properties.ListColumns = <
        item
          Caption = #1050#1086#1076
          Fixed = True
          Width = 60
          FieldName = 'CT'
        end
        item
          Caption = #1050#1086#1085#1090#1088#1072#1075#1077#1085#1090
          Width = 100
          FieldName = 'CT_NAME'
        end
        item
          Width = 100
          FieldName = 'FIRMA_NAME'
        end>
      Properties.ListFieldIndex = 1
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = IBCDataSourceUsers
      TabOrder = 1
      Width = 357
    end
    object mmDESCRIPTION: TcxDBMemo
      Left = 92
      Top = 108
      DataBinding.DataField = 'DESCRIPTION'
      Properties.ScrollBars = ssVertical
      Properties.VisibleLineCount = 5
      TabOrder = 3
      Width = 357
    end
    object edBONUS_VALUE: TcxDBTextEdit
      Left = 92
      Top = 79
      DataBinding.DataField = 'BONUS_VALUE'
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 2
      Width = 98
    end
  end
  object btnOk: TButton
    Left = 276
    Top = 300
    Width = 90
    Height = 29
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 380
    Top = 300
    Width = 90
    Height = 29
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
  object IBCQueryUsers: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      
        'SELECT TS_USERS.CUSTOMERID CT , TS_CUSTOMER.DISPLAYNAME CT_NAME,' +
        ' FIRMA.DISPLAYNAME FIRMA_NAME'
      'FROM TS_USERS'
      
        'INNER JOIN TS_CUSTOMER ON (TS_CUSTOMER.CUSTOMERID=TS_USERS.CUSTO' +
        'MERID)'
      
        'INNER JOIN TS_CUSTOMER FIRMA ON (FIRMA.CUSTOMERID=TS_USERS.DEFAU' +
        'LT_DT)'
      
        'WHERE GET_FLG_VALUE(TS_USERS.FLAGS,0)=1 AND TS_USERS.CUSTOMERID<' +
        '>-1'
      'ORDER BY FIRMA.CUSTOMERID, TS_CUSTOMER.DISPLAYNAME')
    Left = 52
    Top = 240
  end
  object IBCDataSourceUsers: TIBCDataSource
    DataSet = IBCQueryUsers
    Left = 52
    Top = 296
  end
end
