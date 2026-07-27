object frmEditGGAnalizeDlg: TfrmEditGGAnalizeDlg
  Left = 0
  Top = 0
  ActiveControl = edTitle
  BorderStyle = bsDialog
  Caption = 'Modifica inregistrarea'
  ClientHeight = 196
  ClientWidth = 464
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel
    Left = 8
    Top = 16
    Width = 52
    Height = 15
    Caption = 'Denumire'
  end
  object Label2: TLabel
    Left = 8
    Top = 72
    Width = 63
    Height = 15
    Caption = 'Responsabil'
  end
  object edTitle: TcxDBTextEdit
    Left = 8
    Top = 35
    DataBinding.DataField = 'TITLE'
    TabOrder = 0
    Width = 441
  end
  object cbUsers: TcxDBLookupComboBox
    Left = 8
    Top = 93
    DataBinding.DataField = 'MANAGED_BY'
    Properties.ImmediatePost = True
    Properties.IncrementalFilteringOptions = [ifoHighlightSearchText, ifoUseContainsOperator]
    Properties.KeyFieldNames = 'USERID'
    Properties.ListColumns = <
      item
        Caption = 'Utilizator'
        Width = 250
        FieldName = 'FULL_NAME'
      end>
    Properties.ListSource = IBCDataSourceUsers
    TabOrder = 1
    Width = 441
  end
  object cxButton1: TcxButton
    Left = 120
    Top = 151
    Width = 90
    Height = 29
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object cxButton2: TcxButton
    Left = 224
    Top = 151
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
  object IBCQueryUsers: TIBCQuery
    SQL.Strings = (
      'select * From ts_users where get_flg_value(flags, 0) = 1')
    Left = 288
    Top = 8
  end
  object IBCDataSourceUsers: TIBCDataSource
    DataSet = IBCQueryUsers
    Left = 184
    Top = 8
  end
end
