object frmSelectAttributeValueDlg: TfrmSelectAttributeValueDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Alege valoarea'
  ClientHeight = 420
  ClientWidth = 740
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  DesignSize = (
    740
    420)
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 740
    Height = 64
    Title = 'Alege valoarea'
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
    ImageIndex = 16
  end
  object cxGridVal: TcxGrid
    Left = 8
    Top = 70
    Width = 724
    Height = 300
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
    object cxGridValTable: TcxGridDBTableView
      OnCellDblClick = cxGridValTableCellDblClick
      DataController.DataSource = IBCDataSourceValues
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsSelection.MultiSelect = True
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      object cxGridVal_VALUEID: TcxGridDBColumn
        DataBinding.FieldName = 'VALUEID'
        Visible = False
      end
      object cxGridVal_VALUE_RO: TcxGridDBColumn
        Caption = 'Valoare RO'
        DataBinding.FieldName = 'VALUE_RO'
        Width = 290
      end
      object cxGridVal_VALUE_RU: TcxGridDBColumn
        Caption = 'Valoare RU'
        DataBinding.FieldName = 'VALUE_RU'
        Width = 290
      end
    end
    object cxGridValLevel: TcxGridLevel
      GridView = cxGridValTable
    end
  end
  object btnNewValue: TcxButton
    Left = 8
    Top = 381
    Width = 100
    Height = 29
    Anchors = [akLeft, akBottom]
    Caption = 'Valoare noua'
    TabOrder = 1
    OnClick = btnNewValueClick
  end
  object btnEditValue: TcxButton
    Left = 112
    Top = 381
    Width = 90
    Height = 29
    Anchors = [akLeft, akBottom]
    Caption = 'Modifica'
    TabOrder = 2
    OnClick = btnEditValueClick
  end
  object btnDeleteValue: TcxButton
    Left = 206
    Top = 381
    Width = 90
    Height = 29
    Anchors = [akLeft, akBottom]
    Caption = 'Sterge'
    TabOrder = 3
    OnClick = btnDeleteValueClick
  end
  object btnMergeValues: TcxButton
    Left = 300
    Top = 381
    Width = 110
    Height = 29
    Anchors = [akLeft, akBottom]
    Caption = 'Uneste valorile'
    TabOrder = 4
    OnClick = btnMergeValuesClick
  end
  object btnManualValue: TcxButton
    Left = 414
    Top = 381
    Width = 120
    Height = 29
    Anchors = [akLeft, akBottom]
    Caption = 'Valoare manuala'
    TabOrder = 5
    OnClick = btnManualValueClick
  end
  object btnOk: TcxButton
    Left = 546
    Top = 381
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 6
  end
  object btnCancel: TcxButton
    Left = 642
    Top = 381
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 7
  end
  object IBCQueryValues: TIBCQuery
    KeyFields = 'VALUEID'
    KeyGenerator = 'SQ_TS_ATTRIBUTE_VALUE_ID'
    SQL.Strings = (
      'SELECT VALUEID, ATTRID, VALUE_RO, VALUE_RU'
      'FROM TS_ATTRIBUTE_VALUE'
      'WHERE ATTRID = :attrid'
      'ORDER BY ORDERNO')
    AutoCommit = False
    Left = 48
    Top = 96
    ParamData = <
      item
        DataType = ftInteger
        Name = 'attrid'
        Value = nil
      end>
  end
  object IBCDataSourceValues: TIBCDataSource
    DataSet = IBCQueryValues
    Left = 128
    Top = 96
  end
  object IBCTransactionUpdate: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 208
    Top = 96
  end
end
