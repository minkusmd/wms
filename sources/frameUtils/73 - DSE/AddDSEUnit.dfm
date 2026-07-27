object frmDSE: TfrmDSE
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'DSE'
  ClientHeight = 303
  ClientWidth = 367
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 15
  object cbDSEType: TcxDBLookupComboBox
    Left = 24
    Top = 93
    DataBinding.DataField = 'DSE_TYPEID'
    Properties.KeyFieldNames = 'SYSSID'
    Properties.ListColumns = <
      item
        Caption = 'Cod'
        MinWidth = 50
        Width = 80
        FieldName = 'SYSSID'
      end
      item
        Caption = 'Tip'
        MinWidth = 150
        Width = 250
        FieldName = 'TITLE'
      end>
    Properties.ListFieldIndex = 1
    Properties.ListSource = DSSysS
    TabOrder = 2
    Width = 329
  end
  object edQty: TcxDBCalcEdit
    Left = 24
    Top = 143
    DataBinding.DataField = 'QTY'
    TabOrder = 4
    Width = 121
  end
  object edAmount: TcxDBCalcEdit
    Left = 24
    Top = 192
    DataBinding.DataField = 'AMOUNT'
    TabOrder = 6
    Width = 121
  end
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 367
    Height = 64
    Title = 'Gestiune DSE'
    Text = 'Documente de stricta evidenta '
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
  object cxLabel1: TcxLabel
    Left = 8
    Top = 70
    Caption = 'Tipul documentului'
  end
  object cxLabel2: TcxLabel
    Left = 8
    Top = 120
    Caption = 'Cantitate'
  end
  object cxLabel3: TcxLabel
    Left = 8
    Top = 170
    Caption = 'Suma'
  end
  object btnOK: TcxButton
    Left = 159
    Top = 266
    Width = 90
    Height = 29
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 8
  end
  object btnCancel: TcxButton
    Left = 263
    Top = 266
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 9
  end
  object edOrgID: TcxDBTextEdit
    Left = 24
    Top = 232
    DataBinding.DataField = 'ORGID'
    TabOrder = 7
    Width = 121
  end
  object qSysS: TIBCQuery
    KeyFields = 'SYSSID'
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      'select * from ts_syss where parentid=35 /* DSE */')
    Left = 304
    Top = 72
  end
  object DSSysS: TIBCDataSource
    DataSet = qSysS
    Left = 264
    Top = 72
  end
end
