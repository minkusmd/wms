object frmFinantareEditorDlg: TfrmFinantareEditorDlg
  Left = 0
  Top = 0
  Caption = 'Cerere de finantare'
  ClientHeight = 692
  ClientWidth = 920
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  TextHeight = 15
  object lblHeader: TLabel
    Left = 12
    Top = 10
    Width = 896
    Height = 15
    AutoSize = False
    Caption = 'Oferta'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object gbApplicant: TcxGroupBox
    Left = 12
    Top = 32
    Caption = 'Solicitant'
    TabOrder = 0
    Height = 232
    Width = 440
    object lblNPP: TLabel
      Left = 12
      Top = 27
      Width = 95
      Height = 15
      Caption = 'Nume, prenume *'
    end
    object edNPP: TcxTextEdit
      Left = 140
      Top = 24
      Properties.MaxLength = 512
      Style.HotTrack = False
      TabOrder = 0
      OnExit = edNPPExit
      Width = 284
    end
    object lblIDEN: TLabel
      Left = 12
      Top = 55
      Width = 31
      Height = 15
      Caption = 'IDNP'
    end
    object edIDEN: TcxTextEdit
      Left = 140
      Top = 52
      Properties.MaxLength = 64
      Style.HotTrack = False
      TabOrder = 1
      Width = 140
    end
    object lblBirth: TLabel
      Left = 12
      Top = 83
      Width = 71
      Height = 15
      Caption = 'Data nasterii'
    end
    object deBirth: TcxDateEdit
      Left = 140
      Top = 80
      Style.HotTrack = False
      TabOrder = 2
      Width = 140
    end
    object lblPhone: TLabel
      Left = 12
      Top = 111
      Width = 80
      Height = 15
      Caption = 'Telefon mobil'
    end
    object edPhone: TcxTextEdit
      Left = 140
      Top = 108
      Properties.MaxLength = 1020
      Style.HotTrack = False
      TabOrder = 3
      Width = 140
    end
    object lblEmail: TLabel
      Left = 12
      Top = 139
      Width = 37
      Height = 15
      Caption = 'E-mail'
    end
    object edEmail: TcxTextEdit
      Left = 140
      Top = 136
      Properties.MaxLength = 255
      Style.HotTrack = False
      TabOrder = 4
      Width = 284
    end
    object lblAddress: TLabel
      Left = 12
      Top = 167
      Width = 110
      Height = 15
      Caption = 'Adresa (locul de trai)'
    end
    object edAddress: TcxTextEdit
      Left = 140
      Top = 164
      Properties.MaxLength = 1020
      Style.HotTrack = False
      TabOrder = 5
      Width = 284
    end
    object lblHomePhone: TLabel
      Left = 12
      Top = 195
      Width = 94
      Height = 15
      Caption = 'Telefon domiciliu'
    end
    object edHomePhone: TcxTextEdit
      Left = 140
      Top = 192
      Properties.MaxLength = 1020
      Style.HotTrack = False
      TabOrder = 6
      Width = 140
    end
  end
  object gbWork: TcxGroupBox
    Left = 12
    Top = 272
    Caption = 'Loc de munca'
    TabOrder = 1
    Height = 176
    Width = 440
    object lblWorkEmployer: TLabel
      Left = 12
      Top = 27
      Width = 54
      Height = 15
      Caption = 'Angajator'
    end
    object edWorkEmployer: TcxTextEdit
      Left = 140
      Top = 24
      Properties.MaxLength = 1020
      Style.HotTrack = False
      TabOrder = 0
      Width = 284
    end
    object lblWorkJob: TLabel
      Left = 12
      Top = 55
      Width = 40
      Height = 15
      Caption = 'Functia'
    end
    object edWorkJob: TcxTextEdit
      Left = 140
      Top = 52
      Properties.MaxLength = 1020
      Style.HotTrack = False
      TabOrder = 1
      Width = 284
    end
    object lblWorkPhone: TLabel
      Left = 12
      Top = 83
      Width = 85
      Height = 15
      Caption = 'Telefon serviciu'
    end
    object edWorkPhone: TcxTextEdit
      Left = 140
      Top = 80
      Properties.MaxLength = 1020
      Style.HotTrack = False
      TabOrder = 2
      Width = 140
    end
    object lblWorkSalary: TLabel
      Left = 12
      Top = 111
      Width = 40
      Height = 15
      Caption = 'Salariu'
    end
    object edWorkSalary: TcxTextEdit
      Left = 140
      Top = 108
      Properties.MaxLength = 1020
      Style.HotTrack = False
      TabOrder = 3
      Width = 140
    end
    object lblWorkDuration: TLabel
      Left = 12
      Top = 139
      Width = 46
      Height = 15
      Caption = 'Vechime'
    end
    object edWorkDuration: TcxTextEdit
      Left = 140
      Top = 136
      Properties.MaxLength = 1020
      Style.HotTrack = False
      TabOrder = 4
      Width = 140
    end
  end
  object gbScans: TcxGroupBox
    Left = 12
    Top = 456
    Caption = 'Copia buletinului'
    TabOrder = 2
    Height = 120
    Width = 440
    object lblScan1: TLabel
      Left = 12
      Top = 27
      Width = 24
      Height = 15
      Caption = 'Fata'
    end
    object edScan1Name: TcxTextEdit
      Left = 60
      Top = 24
      Properties.ReadOnly = True
      Style.HotTrack = False
      TabOrder = 0
      Width = 220
    end
    object btnScan1Load: TcxButton
      Left = 288
      Top = 23
      Width = 70
      Height = 25
      Caption = 'Incarca...'
      TabOrder = 1
      OnClick = btnScan1LoadClick
    end
    object btnScan1Open: TcxButton
      Left = 362
      Top = 23
      Width = 66
      Height = 25
      Caption = 'Vezi'
      TabOrder = 2
      OnClick = btnScan1OpenClick
    end
    object lblScan2: TLabel
      Left = 12
      Top = 55
      Width = 32
      Height = 15
      Caption = 'Verso'
    end
    object edScan2Name: TcxTextEdit
      Left = 60
      Top = 52
      Properties.ReadOnly = True
      Style.HotTrack = False
      TabOrder = 3
      Width = 220
    end
    object btnScan2Load: TcxButton
      Left = 288
      Top = 51
      Width = 70
      Height = 25
      Caption = 'Incarca...'
      TabOrder = 4
      OnClick = btnScan2LoadClick
    end
    object btnScan2Open: TcxButton
      Left = 362
      Top = 51
      Width = 66
      Height = 25
      Caption = 'Vezi'
      TabOrder = 5
      OnClick = btnScan2OpenClick
    end
    object lblFilesStatus: TLabel
      Left = 12
      Top = 84
      Width = 270
      Height = 15
      AutoSize = False
      Caption = 'eCredit: -'
      ShowHint = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGrayText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object btnUploadScans: TcxButton
      Left = 288
      Top = 79
      Width = 140
      Height = 25
      Hint = 'Trimite copia buletinului la partener.ecredit.md pentru URN-ul cererii'
      Caption = 'Trimite la eCredit'
      TabOrder = 6
      OnClick = btnUploadScansClick
    end
  end
  object gbCredit: TcxGroupBox
    Left = 464
    Top = 32
    Caption = 'Credit'
    TabOrder = 3
    Height = 232
    Width = 444
    object lblOrg: TLabel
      Left = 12
      Top = 27
      Width = 46
      Height = 15
      Caption = 'Creditor'
    end
    object lcbOrg: TcxLookupComboBox
      Left = 140
      Top = 24
      Properties.ClearKey = 46
      Properties.DropDownListStyle = lsFixedList
      Properties.KeyFieldNames = 'UID'
      Properties.ListColumns = <
        item
          FieldName = 'TITLE'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = dsOrg
      Style.HotTrack = False
      TabOrder = 0
      Width = 284
    end
    object lblCreditType: TLabel
      Left = 12
      Top = 55
      Width = 88
      Height = 15
      Caption = 'Tip credit (%)'
    end
    object edCreditType: TcxTextEdit
      Left = 140
      Top = 52
      Properties.MaxLength = 128
      Style.HotTrack = False
      TabOrder = 1
      Width = 140
    end
    object lblGoodsPriceCap: TLabel
      Left = 12
      Top = 83
      Width = 102
      Height = 15
      Caption = 'Pretul marfii (oferta)'
    end
    object lblGoodsPrice: TLabel
      Left = 140
      Top = 83
      Width = 60
      Height = 15
      Caption = '0.00 MDL'
    end
    object lblAvans: TLabel
      Left = 12
      Top = 111
      Width = 33
      Height = 15
      Caption = 'Avans'
    end
    object ceAvans: TcxCurrencyEdit
      Left = 140
      Top = 108
      Properties.DisplayFormat = ',0.00;-,0.00'
      Style.HotTrack = False
      TabOrder = 2
      Width = 140
    end
    object lblCreditSuma: TLabel
      Left = 12
      Top = 139
      Width = 94
      Height = 15
      Caption = 'Suma creditului *'
    end
    object ceCreditSuma: TcxCurrencyEdit
      Left = 140
      Top = 136
      Properties.DisplayFormat = ',0.00;-,0.00'
      Style.HotTrack = False
      TabOrder = 3
      Width = 140
    end
    object lblMonths: TLabel
      Left = 12
      Top = 167
      Width = 74
      Height = 15
      Caption = 'Termen (luni)'
    end
    object seMonths: TcxSpinEdit
      Left = 140
      Top = 164
      Properties.MaxValue = 60.000000000000000000
      Properties.OnChange = seMonthsPropertiesChange
      Style.HotTrack = False
      TabOrder = 4
      Width = 80
    end
    object lblPlataLunara: TLabel
      Left = 12
      Top = 195
      Width = 64
      Height = 15
      Caption = 'Rata lunara'
    end
    object cePlataLunara: TcxCurrencyEdit
      Left = 140
      Top = 192
      Properties.DisplayFormat = ',0.00;-,0.00'
      Style.HotTrack = False
      TabOrder = 5
      Width = 140
    end
    object chkFax: TcxCheckBox
      Left = 296
      Top = 192
      Caption = 'Copie prin fax'
      Style.HotTrack = False
      TabOrder = 6
    end
  end
  object gbECredit: TcxGroupBox
    Left = 464
    Top = 272
    Caption = 'eCredit (api.ecredit.md)'
    TabOrder = 4
    Height = 276
    Width = 444
    object lblProduct: TLabel
      Left = 12
      Top = 27
      Width = 95
      Height = 15
      Caption = 'Produs de credit *'
    end
    object cbProduct: TcxComboBox
      Left = 140
      Top = 24
      Properties.OnChange = cbProductPropertiesChange
      Style.HotTrack = False
      TabOrder = 0
      Width = 244
    end
    object btnProducts: TcxButton
      Left = 388
      Top = 23
      Width = 40
      Height = 25
      Hint = 'Citeste produsele din API (ECM_ShopProducts)'
      Caption = 'API'
      TabOrder = 1
      OnClick = btnProductsClick
    end
    object lblFirstPay: TLabel
      Left = 12
      Top = 55
      Width = 62
      Height = 15
      Caption = 'Prima rata *'
    end
    object deFirstPay: TcxDateEdit
      Left = 140
      Top = 52
      Style.HotTrack = False
      TabOrder = 2
      Width = 120
    end
    object lblEnv: TLabel
      Left = 268
      Top = 55
      Width = 160
      Height = 15
      AutoSize = False
      Caption = 'Mediu: -'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGrayText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object lblNames: TLabel
      Left = 12
      Top = 83
      Width = 120
      Height = 15
      Caption = 'Nume / prenume / patr. *'
    end
    object edLastName: TcxTextEdit
      Left = 140
      Top = 80
      Properties.MaxLength = 64
      Style.HotTrack = False
      TabOrder = 3
      Width = 92
    end
    object edFirstName: TcxTextEdit
      Left = 236
      Top = 80
      Properties.MaxLength = 64
      Style.HotTrack = False
      TabOrder = 4
      Width = 92
    end
    object edFatherName: TcxTextEdit
      Left = 332
      Top = 80
      Properties.MaxLength = 64
      Style.HotTrack = False
      TabOrder = 5
      Width = 96
    end
    object btnCheckClient: TcxButton
      Left = 140
      Top = 108
      Width = 140
      Height = 25
      Caption = 'Verifica clientul'
      TabOrder = 6
      OnClick = btnCheckClientClick
    end
    object btnCalc: TcxButton
      Left = 288
      Top = 108
      Width = 140
      Height = 25
      Caption = 'Calculeaza rata'
      TabOrder = 7
      OnClick = btnCalcClick
    end
    object lblCalc: TLabel
      Left = 12
      Top = 138
      Width = 416
      Height = 30
      AutoSize = False
      Caption = ''
      WordWrap = True
    end
    object lblURNCap: TLabel
      Left = 12
      Top = 172
      Width = 72
      Height = 15
      Caption = 'URN / statut:'
    end
    object lblURN: TLabel
      Left = 140
      Top = 172
      Width = 288
      Height = 15
      AutoSize = False
      Caption = '-'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblDocStatus: TLabel
      Left = 12
      Top = 192
      Width = 416
      Height = 15
      AutoSize = False
      Caption = 'Contract: -'
    end
    object lblMessage: TLabel
      Left = 12
      Top = 212
      Width = 416
      Height = 15
      AutoSize = False
      Caption = ''
    end
    object btnSend: TcxButton
      Left = 12
      Top = 238
      Width = 118
      Height = 25
      Caption = 'Transmite in eCredit'
      TabOrder = 8
      OnClick = btnSendClick
    end
    object btnStatus: TcxButton
      Left = 134
      Top = 238
      Width = 118
      Height = 25
      Caption = 'Actualizeaza statutul'
      TabOrder = 9
      OnClick = btnStatusClick
    end
    object btnCancelReq: TcxButton
      Left = 256
      Top = 238
      Width = 86
      Height = 25
      Caption = 'Anuleaza'
      TabOrder = 10
      OnClick = btnCancelReqClick
    end
    object btnContract: TcxButton
      Left = 346
      Top = 238
      Width = 82
      Height = 25
      Hint = 'Descarca contractul de semnat (ECM_GetDocs_V2)'
      Caption = 'Contract'
      TabOrder = 11
      OnClick = btnContractClick
    end
  end
  object mmLog: TcxMemo
    Left = 12
    Top = 584
    Properties.ReadOnly = True
    Properties.ScrollBars = ssVertical
    Style.HotTrack = False
    TabOrder = 5
    Height = 56
    Width = 896
  end
  object pnButtons: TPanel
    Left = 0
    Top = 648
    Width = 920
    Height = 44
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 6
    object lblRequired: TLabel
      Left = 12
      Top = 14
      Width = 200
      Height = 15
      Caption = '* - obligatoriu la transmiterea in eCredit'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGrayText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object btnSave: TcxButton
      Left = 688
      Top = 7
      Width = 104
      Height = 31
      Anchors = [akTop, akRight]
      Caption = 'Salveaza'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
    object btnCancel: TcxButton
      Left = 800
      Top = 7
      Width = 104
      Height = 31
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Renunta'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object trWrite: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 848
    Top = 8
  end
  object qOrg: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (

        'SELECT UID, TITLE || '#39' ['#39' || MIN_MONTH || '#39'..'#39' || MAX_MONTH || '#39' ' +
        'luni]'#39' AS TITLE'
      'FROM TS_FINANCE_CUSTOMER'
      'ORDER BY TITLE, MIN_MONTH')
    ReadOnly = True
    Left = 800
    Top = 8
  end
  object dsOrg: TIBCDataSource
    DataSet = qOrg
    Left = 760
    Top = 8
  end
  object dlgOpenScan: TOpenDialog
    Filter =
      'Imagini si PDF (*.jpg;*.jpeg;*.png;*.pdf)|*.jpg;*.jpeg;*.png;*.p' +
      'df|Toate fisierele (*.*)|*.*'
    Options = [ofHideReadOnly, ofFileMustExist, ofEnableSizing]
    Title = 'Copia buletinului'
    Left = 712
    Top = 8
  end
end
