object frmSelectInventoryCostingMethodDlg: TfrmSelectInventoryCostingMethodDlg
  Left = 0
  Top = 0
  ActiveControl = lcbSerialNumber
  BorderStyle = bsDialog
  Caption = 'Tip evidenta'
  ClientHeight = 137
  ClientWidth = 476
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poOwnerFormCenter
  TextHeight = 13
  object LabelInventoryCostingMethod: TLabel
    Left = 16
    Top = 24
    Width = 67
    Height = 13
    Caption = 'Tip evidenta'
  end
  object lcbSerialNumber: TcxLookupComboBox
    Left = 112
    Top = 20
    ParentFont = False
    Properties.DropDownListStyle = lsFixedList
    Properties.DropDownRows = 16
    Properties.KeyFieldNames = 'GOODSSERIALTYPEID'
    Properties.ListColumns = <
      item
        Caption = 'Cod'
        Fixed = True
        Width = 50
        FieldName = 'GOODSSERIALTYPEID'
      end
      item
        Caption = 'Denumire'
        FieldName = 'TITLE'
      end>
    Properties.ListFieldIndex = 1
    Properties.ListOptions.ShowHeader = False
    Properties.ListSource = IBCDataSourceGST
    TabOrder = 0
    Width = 348
  end
  object btnOK: TcxButton
    Left = 274
    Top = 92
    Width = 90
    Height = 29
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancel: TcxButton
    Left = 370
    Top = 92
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 2
  end
  object IBCQueryGST: TIBCQuery
    SQL.Strings = (
      'SELECT'
      '    GOODSSERIALTYPEID,'
      '    TITLE'
      'FROM'
      '    GET_GOODS_SERIAL_TYPES'
      'ORDER BY'
      '    TITLE')
    Left = 112
    Top = 80
  end
  object IBCDataSourceGST: TIBCDataSource
    DataSet = IBCQueryGST
    Left = 176
    Top = 80
  end
end
