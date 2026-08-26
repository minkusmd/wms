object frmContentPackageDlg: TfrmContentPackageDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Editor pachete content'
  ClientHeight = 216
  ClientWidth = 467
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 467
    Height = 180
    Align = alClient
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 16
      Width = 59
      Height = 13
      Caption = 'Data finisarii'
    end
    object Label2: TLabel
      Left = 16
      Top = 46
      Width = 87
      Height = 13
      Caption = 'Pretul unui produs'
    end
    object Label3: TLabel
      Left = 16
      Top = 70
      Width = 44
      Height = 13
      Caption = 'Operator'
    end
    object deDATA_END: TcxDBDateEdit
      Left = 120
      Top = 12
      DataBinding.DataField = 'DATA_END'
      TabOrder = 0
      Width = 105
    end
    object cePrice: TcxDBCalcEdit
      Left = 120
      Top = 40
      DataBinding.DataField = 'PRICE'
      TabOrder = 1
      Width = 105
    end
    object meComments: TcxDBMemo
      Left = 120
      Top = 98
      DataBinding.DataField = 'COMMENT'
      TabOrder = 2
      Height = 65
      Width = 329
    end
    object cbNoSalary: TcxDBCheckBox
      Left = 382
      Top = 12
      Caption = 'Fara plata'
      DataBinding.DataField = 'FLG_NO_SALARY'
      Properties.Alignment = taLeftJustify
      Properties.ImmediatePost = True
      Properties.NullStyle = nssUnchecked
      Properties.ValueChecked = 1
      Properties.ValueUnchecked = 0
      Style.Shadow = False
      Style.TransparentBorder = False
      TabOrder = 3
    end
  end
  object lcbUser: TcxDBLookupComboBox
    Left = 122
    Top = 69
    DataBinding.DataField = 'RESPONSABLE_USERID'
    Properties.KeyFieldNames = 'USERID'
    Properties.ListColumns = <
      item
        Caption = 'Operator'
        Width = 150
        FieldName = 'FULL_NAME'
      end
      item
        Caption = 'Cant'
        Width = 48
        FieldName = 'ACTIVE_GOODS_COUNT'
      end>
    Properties.ListOptions.ShowHeader = False
    Properties.ListSource = IBCDataSourceUsers
    TabOrder = 1
    Width = 265
  end
  object RzDialogButtons1: TRzDialogButtons
    Left = 0
    Top = 180
    Width = 467
    TabOrder = 2
  end
  object IBCQueryUsers: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'select * from get_available_content_users')
    Left = 344
    Top = 44
  end
  object IBCDataSourceUsers: TIBCDataSource
    DataSet = IBCQueryUsers
    Left = 344
    Top = 96
  end
end
