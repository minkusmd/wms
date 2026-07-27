object AddCallReminderDlg: TAddCallReminderDlg
  Left = 0
  Top = 0
  ActiveControl = meReminderBody
  Caption = 'Planificarea unui contact nou cu clientul'
  ClientHeight = 374
  ClientWidth = 474
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  DesignSize = (
    474
    374)
  TextHeight = 13
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 474
    Height = 64
    Title = 'Planificarea unui contact nou cu clientul'
    Text = 'Contact telefonic'
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
    Width = 458
    Height = 244
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
      Left = 18
      Top = 109
      Width = 27
      Height = 13
      Caption = 'Client'
    end
    object Label4: TLabel
      Left = 20
      Top = 203
      Width = 125
      Height = 13
      Caption = 'Reamintele si utillizatorului'
    end
    object Label2: TLabel
      Left = 18
      Top = 136
      Width = 68
      Height = 13
      Caption = 'Numar telefon'
    end
    object Label3: TLabel
      Left = 18
      Top = 7
      Width = 51
      Height = 13
      Caption = 'Comentarii'
    end
    object Label5: TLabel
      Left = 18
      Top = 163
      Width = 52
      Height = 13
      Caption = 'Data si ora'
    end
    object edCUSTOMER: TcxTextEdit
      Left = 106
      Top = 106
      TabStop = False
      Properties.ReadOnly = False
      TabOrder = 0
      Width = 333
    end
    object edTelefon: TcxTextEdit
      Left = 106
      Top = 133
      TabStop = False
      Properties.ReadOnly = False
      TabOrder = 1
      Width = 333
    end
    object meReminderBody: TcxMemo
      Left = 21
      Top = 26
      Properties.OEMConvert = True
      TabOrder = 5
      Height = 68
      Width = 421
    end
    object deDate: TcxDateEdit
      Left = 106
      Top = 160
      EditValue = 0d
      Properties.DateButtons = [btnClear, btnToday]
      Properties.SaveTime = False
      Properties.ShowTime = False
      TabOrder = 2
      Width = 105
    end
    object teTime: TcxTimeEdit
      Left = 217
      Top = 160
      Properties.Increment = 10.000000000000000000
      Properties.LargeIncrement = 30.000000000000000000
      Properties.TimeFormat = tfHourMin
      TabOrder = 3
      Width = 69
    end
    object cxLookupComboBox1: TcxLookupComboBox
      Left = 151
      Top = 199
      Properties.DropDownListStyle = lsFixedList
      Properties.GridMode = True
      Properties.ImmediatePost = True
      Properties.KeyFieldNames = '0'
      Properties.ListColumns = <
        item
          FieldName = 'USERID'
        end
        item
          FieldName = 'USER_FULLNAME'
        end>
      Properties.ListFieldIndex = 1
      Properties.ListOptions.GridLines = glHorizontal
      Properties.ListSource = IBCDataSourceUsers
      TabOrder = 4
      Width = 290
    end
  end
  object btnOk: TButton
    Left = 261
    Top = 337
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
    ExplicitTop = 375
  end
  object btnCancel: TButton
    Left = 365
    Top = 337
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
    ExplicitTop = 375
  end
  object IBCTrUpdate: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 276
    Top = 12
  end
  object IBCQueryUsers: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT'
      ' USERID,'
      ' USER_FULLNAME'
      'FROM GET_USERS_BY_USER2')
    Left = 408
    Top = 156
  end
  object IBCDataSourceUsers: TIBCDataSource
    DataSet = IBCQueryUsers
    Left = 408
    Top = 112
  end
end
