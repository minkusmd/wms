object frmCustomerContractEditorDlg: TfrmCustomerContractEditorDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Contracte'
  ClientHeight = 576
  ClientWidth = 550
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  DesignSize = (
    550
    576)
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 550
    Height = 64
    Title = 'Contract'
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
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 534
    Height = 450
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
    ExplicitLeft = 3
    ExplicitHeight = 546
    object Label1: TLabel
      Left = 24
      Top = 20
      Width = 84
      Height = 15
      Caption = 'Numar contract'
    end
    object Label2: TLabel
      Left = 24
      Top = 76
      Width = 61
      Height = 15
      Caption = 'Intrepridere'
    end
    object Label3: TLabel
      Left = 24
      Top = 132
      Width = 31
      Height = 15
      Caption = 'Client'
    end
    object Label4: TLabel
      Left = 273
      Top = 17
      Width = 72
      Height = 15
      Caption = 'Data semnarii'
    end
    object Label5: TLabel
      Left = 400
      Top = 17
      Width = 65
      Height = 15
      Caption = 'Data finisarii'
    end
    object Label6: TLabel
      Left = 24
      Top = 196
      Width = 94
      Height = 15
      Caption = 'Tipul contractului'
    end
    object Label7: TLabel
      Left = 140
      Top = 265
      Width = 71
      Height = 15
      Caption = 'Grila e preturi'
    end
    object Label9: TLabel
      Left = 24
      Top = 268
      Width = 32
      Height = 15
      Caption = 'Valuta'
    end
    object Label8: TLabel
      Left = 272
      Top = 76
      Width = 182
      Height = 15
      Caption = 'Persoana cu functie de raspundere'
    end
    object Label10: TLabel
      Left = 272
      Top = 132
      Width = 182
      Height = 15
      Caption = 'Persoana cu functie de raspundere'
    end
    object Label11: TLabel
      Left = 260
      Top = 265
      Width = 21
      Height = 15
      Caption = 'TVA'
    end
    object Label12: TLabel
      Left = 24
      Top = 320
      Width = 85
      Height = 15
      Caption = 'Termen de plata'
    end
    object Label13: TLabel
      Left = 136
      Top = 320
      Width = 91
      Height = 15
      Caption = 'Termen de livrare'
    end
    object Label14: TLabel
      Left = 24
      Top = 376
      Width = 87
      Height = 15
      Caption = 'Adresa de livrare'
    end
    object lcbDT: TcxDBLookupComboBox
      Left = 24
      Top = 93
      DataBinding.DataField = 'DT'
      Properties.DropDownListStyle = lsFixedList
      Properties.KeyFieldNames = 'CUSTOMERID'
      Properties.ListColumns = <
        item
          FieldName = 'DISPLAYNAME'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = IBCDataSourceDT
      TabOrder = 2
      Width = 221
    end
    object deSIGN_DATE: TcxDBDateEdit
      Left = 272
      Top = 38
      DataBinding.DataField = 'SIGN_DATE'
      Properties.SaveTime = False
      Properties.ShowTime = False
      Properties.WeekNumbers = True
      TabOrder = 5
      Width = 111
    end
    object deEXPIRE_DATE: TcxDBDateEdit
      Left = 400
      Top = 38
      DataBinding.DataField = 'EXPIRE_DATE'
      Properties.SaveTime = False
      Properties.ShowTime = False
      Properties.WeekNumbers = True
      TabOrder = 6
      Width = 114
    end
    object cmbPRICE_COLUMN: TcxDBComboBox
      Left = 141
      Top = 286
      DataBinding.DataField = 'PRICE_COLUMN'
      Properties.DropDownListStyle = lsFixedList
      Properties.Items.Strings = (
        '1'
        '2'
        '3'
        '4'
        '5'
        '6'
        '7'
        '0')
      TabOrder = 11
      Width = 104
    end
    object lcbCURRENCYID: TcxDBLookupComboBox
      Left = 23
      Top = 286
      DataBinding.DataField = 'CURRENCYID'
      Properties.DropDownListStyle = lsFixedList
      Properties.KeyFieldNames = 'CURRENCYID'
      Properties.ListColumns = <
        item
          FieldName = 'TITLE'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = dmDB.IBCDataSourceCurrency
      TabOrder = 9
      Width = 105
    end
    object beContractType: TcxButtonEdit
      Left = 24
      Top = 220
      Properties.Buttons = <
        item
          Caption = #1042#1099#1073#1088#1072#1090#1100'...'
          Default = True
          ImageIndex = 13
          Kind = bkGlyph
        end>
      Properties.ClickKey = 115
      Properties.Images = dmAdditions.cxImageList_SWN
      Properties.ViewStyle = vsHideCursor
      Properties.OnButtonClick = beContractTypePropertiesButtonClick
      TabOrder = 7
      Width = 490
    end
    object cbFLG_ACNT: TcxDBCheckBox
      Left = 390
      Top = 262
      Caption = 'Export contabilitate'
      DataBinding.DataField = 'FLG_ACNT'
      Properties.Alignment = taLeftJustify
      Properties.ValueChecked = 1
      Properties.ValueUnchecked = 0
      TabOrder = 8
    end
    object beCT_NAME: TcxButtonEdit
      Left = 24
      Top = 149
      Properties.Buttons = <
        item
          Default = True
          ImageIndex = 13
          Kind = bkGlyph
        end>
      Properties.ClickKey = 115
      Properties.Images = dmAdditions.cxImageList_SWN
      Properties.ViewStyle = vsHideCursor
      Properties.OnButtonClick = beCT_NAMEPropertiesButtonClick
      TabOrder = 3
      Width = 221
    end
    object beDT_RESP: TcxButtonEdit
      Left = 272
      Top = 91
      Properties.Buttons = <
        item
          Default = True
          ImageIndex = 13
          Kind = bkGlyph
        end>
      Properties.ClickKey = 115
      Properties.Images = dmAdditions.cxImageList_SWN
      Properties.ViewStyle = vsHideCursor
      Properties.OnButtonClick = beDT_RESPPropertiesButtonClick
      TabOrder = 1
      Width = 242
    end
    object beCT_RESP: TcxButtonEdit
      Left = 272
      Top = 149
      Properties.Buttons = <
        item
          Default = True
          ImageIndex = 13
          Kind = bkGlyph
        end>
      Properties.ClickKey = 115
      Properties.Images = dmAdditions.cxImageList_SWN
      Properties.ViewStyle = vsHideCursor
      Properties.OnButtonClick = beCT_RESPPropertiesButtonClick
      TabOrder = 4
      Width = 242
    end
    object cmbVAT: TcxDBComboBox
      Left = 259
      Top = 286
      DataBinding.DataField = 'VAT'
      Properties.DropDownListStyle = lsFixedList
      Properties.ImmediatePost = True
      Properties.Items.Strings = (
        '0'
        '20'
        '')
      TabOrder = 13
      Width = 73
    end
    object beContractCode: TcxDBButtonEdit
      Left = 24
      Top = 38
      DataBinding.DataField = 'CODE'
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      Properties.OnButtonClick = beContractCodePropertiesButtonClick
      TabOrder = 0
      Width = 221
    end
    object cbFLG_DefaultContract: TcxDBCheckBox
      Left = 391
      Top = 294
      Caption = 'Contract de baza'
      DataBinding.DataField = 'FLG_DEFAULT'
      Properties.Alignment = taLeftJustify
      Properties.ValueChecked = 1
      Properties.ValueUnchecked = 0
      Style.TransparentBorder = False
      TabOrder = 10
    end
    object ceRagazPlata: TcxDBCalcEdit
      Left = 24
      Top = 341
      DataBinding.DataField = 'PAYMENT_TERM_DAYS'
      TabOrder = 12
      Width = 84
    end
    object ceDELIVERY_TERM_DAYS: TcxDBCalcEdit
      Left = 136
      Top = 341
      DataBinding.DataField = 'DELIVERY_TERM_DAYS'
      TabOrder = 14
      Width = 84
    end
    object teDeliveryPlace: TcxDBTextEdit
      Left = 24
      Top = 397
      DataBinding.DataField = 'DELIVERY_PLACE'
      TabOrder = 15
      Width = 490
    end
  end
  object btnOk: TButton
    Left = 330
    Top = 533
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
    ExplicitTop = 629
  end
  object btnCancel: TButton
    Left = 434
    Top = 533
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
    ExplicitTop = 629
  end
  object IBCQueryDT: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT'
      'p.CUSTOMERID,'
      'p.DISPLAYNAME'
      'FROM GET_FIRMS_BY_USER2 p'
      
        'inner join ts_customer c on c.customerid=p.customerid and c.pare' +
        'ntid=5209'
      '')
    Left = 268
    Top = 24
  end
  object IBCDataSourceDT: TIBCDataSource
    DataSet = IBCQueryDT
    Left = 328
    Top = 48
  end
end
