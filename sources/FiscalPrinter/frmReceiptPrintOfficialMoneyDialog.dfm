object frmReceiptPrintOfficialMoneyDlg: TfrmReceiptPrintOfficialMoneyDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Extragere numerar din casierie'
  ClientHeight = 261
  ClientWidth = 409
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  TextHeight = 13
  object Label9: TLabel
    Left = 8
    Top = 132
    Width = 74
    Height = 15
    Caption = 'Suma bonului'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object Label1: TLabel
    Left = 8
    Top = 73
    Width = 98
    Height = 15
    Caption = 'Eliberat pe numele'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object DialogTitle1: TDialogTitle
    Left = 0
    Top = 0
    Width = 409
    Height = 64
    Title = 'Bon fiscal'
    Text = 'Introducerea sau extragerea mijloacelor banesti din casierie'
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
    ImageIndex = 26
  end
  object edPaySuma: TEdit
    Left = 8
    Top = 153
    Width = 156
    Height = 23
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
  end
  object btnPrintReceipt: TButton
    Left = 207
    Top = 222
    Width = 90
    Height = 29
    Caption = 'Tipar cec'
    Default = True
    ModalResult = 1
    TabOrder = 3
  end
  object lcbExistingDocumentSelector: TcxLookupComboBox
    Left = 8
    Top = 94
    ParentFont = False
    Properties.DropDownRows = 16
    Properties.DropDownWidth = 600
    Properties.ImmediatePost = True
    Properties.KeyFieldNames = 'USERID'
    Properties.ListColumns = <
      item
        FieldName = 'LAST_NAME'
      end
      item
        FieldName = 'FIRST_NAME'
      end>
    Properties.ListSource = IBCDataSourceUsers
    EditValue = -1
    Style.Font.Charset = ANSI_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -12
    Style.Font.Name = 'Segoe UI'
    Style.Font.Style = []
    Style.IsFontAssigned = True
    TabOrder = 1
    Width = 393
  end
  object Button1: TButton
    Left = 311
    Top = 222
    Width = 90
    Height = 29
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 4
  end
  object IBCTrUpdate: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 372
    Top = 135
  end
  object IBCQueryUsers: TIBCQuery
    SQL.Strings = (
      
        'select * from ts_users u where get_flg_value(flags,0) =1   and u' +
        'serid>1'
      'order by u.last_name')
    Left = 120
    Top = 192
  end
  object IBCDataSourceUsers: TIBCDataSource
    DataSet = IBCQueryUsers
    Left = 32
    Top = 192
  end
end
