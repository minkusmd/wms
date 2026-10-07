object frmFiscalPrinterEditDlg: TfrmFiscalPrinterEditDlg
  Left = 0
  Top = 0
  ActiveControl = cbFLG_ENABLED
  BorderStyle = bsDialog
  Caption = 'MCC'
  ClientHeight = 717
  ClientWidth = 384
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnDestroy = FormDestroy
  DesignSize = (
    384
    717)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 384
    Height = 64
    Title = 'MCC'
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
    ImageIndex = 26
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 368
    Height = 591
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
      Top = 60
      Width = 80
      Height = 15
      Caption = 'Numar de serie'
    end
    object Label2: TLabel
      Left = 20
      Top = 108
      Width = 48
      Height = 15
      Caption = 'Descriere'
    end
    object Label3: TLabel
      Left = 20
      Top = 192
      Width = 67
      Height = 15
      Caption = 'Subdiviziune'
    end
    object Label4: TLabel
      Left = 20
      Top = 248
      Width = 64
      Height = 15
      Caption = 'Workstation'
    end
    object cbFLG_ENABLED: TcxDBCheckBox
      Left = 20
      Top = 20
      Caption = 'Accesibil pentru tipar'
      DataBinding.DataField = 'FLG_ENABLED'
      Properties.Alignment = taLeftJustify
      Properties.ValueChecked = 1
      Properties.ValueUnchecked = 0
      TabOrder = 0
    end
    object mmDESCRIPTION: TcxDBMemo
      Left = 20
      Top = 125
      DataBinding.DataField = 'DESCRIPTION'
      Properties.ScrollBars = ssVertical
      Properties.VisibleLineCount = 3
      TabOrder = 2
      Width = 321
    end
    object edSERIAL_NUMBER: TcxDBTextEdit
      Left = 20
      Top = 77
      DataBinding.DataField = 'SERIAL_NUMBER'
      Properties.CharCase = ecUpperCase
      TabOrder = 1
      Width = 321
    end
    object lcbFIRMA_ID: TcxDBLookupComboBox
      Left = 20
      Top = 209
      DataBinding.DataField = 'FIRMA_ID'
      Properties.DropDownListStyle = lsFixedList
      Properties.KeyFieldNames = 'CUSTOMERID'
      Properties.ListColumns = <
        item
          FieldName = 'DISPLAYNAME'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = dmDB.IBCDataSourceFirms
      TabOrder = 3
      Width = 321
    end
    object lcbWS_ID: TcxDBLookupComboBox
      Left = 20
      Top = 265
      DataBinding.DataField = 'WS_ID'
      Properties.DropDownListStyle = lsFixedList
      Properties.KeyFieldNames = 'WS_ID'
      Properties.ListColumns = <
        item
          Caption = #1050#1086#1084#1087#1100#1102#1090#1077#1088
          Width = 100
          FieldName = 'COMPUTER_NAME'
        end
        item
          Caption = #1054#1087#1080#1089#1072#1085#1080#1077
          Width = 200
          FieldName = 'DESCRIPTION'
        end>
      Properties.ListSource = IBCDataSourceWS
      Properties.OnInitPopup = lcbWS_IDPropertiesInitPopup
      TabOrder = 4
      Width = 321
    end
    object Label5: TLabel
      Left = 20
      Top = 304
      Width = 160
      Height = 15
      Caption = 'Adresa server ZFPLab (gol = MCC locala)'
    end
    object edSERVER_ADDRESS: TcxDBTextEdit
      Left = 20
      Top = 321
      DataBinding.DataField = 'SERVER_ADDRESS'
      TabOrder = 5
      Width = 321
    end
    object Label6: TLabel
      Left = 20
      Top = 352
      Width = 50
      Height = 15
      Caption = 'Port COM'
    end
    object edCOM_PORT: TcxDBTextEdit
      Left = 20
      Top = 369
      DataBinding.DataField = 'COM_PORT'
      Properties.CharCase = ecUpperCase
      TabOrder = 6
      Width = 140
    end
    object Label7: TLabel
      Left = 180
      Top = 352
      Width = 70
      Height = 15
      Caption = 'Viteza (baud)'
    end
    object edBAUD_RATE: TcxDBTextEdit
      Left = 180
      Top = 369
      DataBinding.DataField = 'BAUD_RATE'
      TabOrder = 7
      Width = 161
    end
    object Label8: TLabel
      Left = 20
      Top = 400
      Width = 320
      Height = 30
      Caption =
        'Portul si viteza sint obligatorii doar pentru MCC din retea - pe' +
        ' calculatorul strain nu se face cautare automata.'
      WordWrap = True
    end
    object rgDEVICE_TYPE: TcxDBRadioGroup
      Left = 20
      Top = 440
      Caption = 'Tip aparat'
      DataBinding.DataField = 'DEVICE_TYPE'
      Properties.DefaultValue = 0
      Properties.Items = <
        item
          Caption = 'MCC Tremol (server ZFPLab)'
          Value = 0
        end
        item
          Caption = 'Casa ECC Fiscal Partner (cloud)'
          Value = 1
        end>
      Properties.OnChange = rgDEVICE_TYPEPropertiesChange
      TabOrder = 8
      Height = 70
      Width = 321
    end
    object Label9: TLabel
      Left = 20
      Top = 518
      Width = 300
      Height = 15
      Caption = 'Casa ECC (cod din Setari > Configurari API)'
    end
    object cmbECC_API_CODE: TcxDBComboBox
      Left = 20
      Top = 535
      DataBinding.DataField = 'ECC_API_CODE'
      Properties.CharCase = ecUpperCase
      Properties.DropDownListStyle = lsFixedList
      TabOrder = 9
      Width = 321
    end
  end
  object btnOk: TButton
    Left = 169
    Top = 674
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 273
    Top = 674
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
  object IBCQueryWS: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      'SELECT WS_ID, COMPUTER_NAME, DESCRIPTION'
      'FROM WS_WORK_STATIONS'
      'WHERE (FLG_ENABLED=1) AND (FIRMA_ID=:ID)')
    Options.DetailDelay = 50
    Left = 208
    Top = 4
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
        Value = nil
      end>
  end
  object IBCDataSourceWS: TIBCDataSource
    DataSet = IBCQueryWS
    Left = 208
    Top = 48
  end
end
