object frmUserMissedHourEditorDlg: TfrmUserMissedHourEditorDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Gestionarea orelor de lucru'
  ClientHeight = 368
  ClientWidth = 413
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
    Width = 413
    Height = 64
    Title = 'Gestionarea orelor de lucru'
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
    Width = 397
    Height = 241
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
      Top = 53
      Width = 38
      Height = 15
      Caption = 'Salariat'
    end
    object Label2: TLabel
      Left = 20
      Top = 110
      Width = 19
      Height = 15
      Caption = 'Ore'
    end
    object Label4: TLabel
      Left = 20
      Top = 139
      Width = 48
      Height = 15
      Caption = 'Mentiuni'
    end
    object Label5: TLabel
      Left = 20
      Top = 82
      Width = 32
      Height = 15
      Caption = 'Cauza'
    end
    object Label6: TLabel
      Left = 20
      Top = 23
      Width = 25
      Height = 15
      Caption = #1044#1072#1090#1072
    end
    object lcbUSERID: TcxDBLookupComboBox
      Left = 88
      Top = 49
      DataBinding.DataField = 'CT'
      Properties.DropDownListStyle = lsFixedList
      Properties.DropDownRows = 16
      Properties.KeyFieldNames = 'CT'
      Properties.ListColumns = <
        item
          Fixed = True
          Width = 50
          FieldName = 'CT'
        end
        item
          FieldName = 'CT_NAME'
        end>
      Properties.ListFieldIndex = 1
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = IBCDataSourceUsers
      TabOrder = 1
      Width = 281
    end
    object seHOURS: TcxDBSpinEdit
      Left = 88
      Top = 107
      DataBinding.DataField = 'HOURS'
      Properties.AssignedValues.MinValue = True
      Properties.ImmediatePost = True
      Properties.MaxValue = 10.000000000000000000
      Properties.ValueType = vtInt
      TabOrder = 3
      Width = 121
    end
    object mmDESCRIPTION: TcxDBMemo
      Left = 88
      Top = 136
      DataBinding.DataField = 'DESCRIPTION'
      Properties.ScrollBars = ssVertical
      Properties.VisibleLineCount = 5
      TabOrder = 4
      Width = 281
    end
    object lcbMOTIV_ID: TcxDBLookupComboBox
      Left = 88
      Top = 78
      DataBinding.DataField = 'MOTIV_ID'
      Properties.DropDownListStyle = lsFixedList
      Properties.DropDownRows = 16
      Properties.KeyFieldNames = 'SYSSID'
      Properties.ListColumns = <
        item
          FieldName = 'TITLE'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = IBCDataSourceMotiv
      TabOrder = 2
      Width = 281
    end
    object deDATA: TcxDBDateEdit
      Left = 88
      Top = 20
      DataBinding.DataField = 'DATA'
      Properties.SaveTime = False
      Properties.ShowTime = False
      Properties.WeekNumbers = True
      TabOrder = 0
      Width = 165
    end
  end
  object btnOk: TButton
    Left = 200
    Top = 324
    Width = 90
    Height = 29
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 304
    Top = 324
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
  object IBCQueryUsers: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT'
      ' CT,'
      ' CT_NAME'
      'FROM '
      ' GET_USERS_BY_USER3(:DT)')
    Left = 52
    Top = 256
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DT'
        Value = nil
      end>
  end
  object IBCDataSourceUsers: TIBCDataSource
    DataSet = IBCQueryUsers
    Left = 52
    Top = 312
  end
  object IBCQueryMotiv: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT'
      ' SYSSID, '
      ' TITLE'
      'FROM TS_SYSS'
      'WHERE PARENTID=22')
    Left = 144
    Top = 260
  end
  object IBCDataSourceMotiv: TIBCDataSource
    DataSet = IBCQueryMotiv
    Left = 144
    Top = 312
  end
end
