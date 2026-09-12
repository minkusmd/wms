object frmWebEcommInfoDialog: TfrmWebEcommInfoDialog
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Detalii tranzactii ecomm'
  ClientHeight = 437
  ClientWidth = 844
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object cxDBVerticalGrid1: TcxDBVerticalGrid
    Left = 8
    Top = 8
    Width = 825
    Height = 377
    OptionsView.RowHeaderWidth = 186
    Navigator.Buttons.CustomButtons = <>
    ScrollbarAnnotations.CustomAnnotations = <>
    TabOrder = 0
    DataController.DataSource = IBCDataSource1
    DataController.GridMode = True
    Version = 1
    object cxDBVerticalGrid1TRANSACTIONID: TcxDBEditorRow
      Properties.DataBinding.FieldName = 'TRANSACTIONID'
      ID = 0
      ParentID = -1
      Index = 0
      Version = 1
    end
    object cxDBVerticalGrid1TRANSACTIONRESULT: TcxDBEditorRow
      Properties.EditPropertiesClassName = 'TcxMemoProperties'
      Properties.EditProperties.VisibleLineCount = 5
      Properties.DataBinding.FieldName = 'TRANSACTIONRESULT'
      ID = 1
      ParentID = -1
      Index = 1
      Version = 1
    end
    object cxDBVerticalGrid1REGISTERDATE: TcxDBEditorRow
      Properties.DataBinding.FieldName = 'REGISTERDATE'
      ID = 2
      ParentID = -1
      Index = 2
      Version = 1
    end
    object cxDBVerticalGrid1SUBMITDATE: TcxDBEditorRow
      Properties.DataBinding.FieldName = 'SUBMITDATE'
      ID = 3
      ParentID = -1
      Index = 3
      Version = 1
    end
    object cxDBVerticalGrid1SHOPPINGCARTOBJECTS: TcxDBEditorRow
      Properties.EditPropertiesClassName = 'TcxMemoProperties'
      Properties.EditProperties.VisibleLineCount = 10
      Properties.DataBinding.FieldName = 'SHOPPINGCARTOBJECTS'
      ID = 4
      ParentID = -1
      Index = 4
      Version = 1
    end
    object cxDBVerticalGrid1DOCID: TcxDBEditorRow
      Properties.DataBinding.FieldName = 'DOCID'
      ID = 5
      ParentID = -1
      Index = 5
      Version = 1
    end
    object cxDBVerticalGrid1AMOUNT: TcxDBEditorRow
      Properties.DataBinding.FieldName = 'AMOUNT'
      ID = 6
      ParentID = -1
      Index = 6
      Version = 1
    end
    object cxDBVerticalGrid1STATUS: TcxDBEditorRow
      Properties.DataBinding.FieldName = 'STATUS'
      ID = 7
      ParentID = -1
      Index = 7
      Version = 1
    end
    object cxDBVerticalGrid1MESSAGE: TcxDBEditorRow
      Properties.DataBinding.FieldName = 'MESSAGE'
      ID = 8
      ParentID = -1
      Index = 8
      Version = 1
    end
    object cxDBVerticalGrid1IP: TcxDBEditorRow
      Properties.DataBinding.FieldName = 'IP'
      ID = 9
      ParentID = -1
      Index = 9
      Version = 1
    end
    object cxDBVerticalGrid1UANCIRC_RESERVCODE: TcxDBEditorRow
      Properties.DataBinding.FieldName = 'UANCIRC_RESERVCODE'
      ID = 10
      ParentID = -1
      Index = 10
      Version = 1
    end
  end
  object btnClose: TcxButton
    Left = 389
    Top = 404
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Inchide'
    Default = True
    ModalResult = 8
    TabOrder = 1
  end
  object IBCDataSource1: TIBCDataSource
    DataSet = IBCQuery1
    Left = 185
    Top = 47
  end
  object IBCQuery1: TIBCQuery
    KeyFields = 'TRANSACTIONID'
    SQL.Strings = (
      'select * from TDB_ECOMM_TRANSACTIONS'
      'where docid=:docid')
    ReadOnly = True
    Active = True
    Left = 185
    Top = 110
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'docid'
        Value = nil
      end>
  end
end
