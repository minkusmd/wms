object frmSelectUserDialog: TfrmSelectUserDialog
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Nomenclatorul utilizatorilor activi'
  ClientHeight = 421
  ClientWidth = 497
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object cxGrid1: TcxGrid
    Left = 8
    Top = 8
    Width = 481
    Height = 361
    TabOrder = 0
    object cxGridUsersView: TcxGridDBTableView
      OnDblClick = cxGridUsersViewDblClick
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = IBCDataSourceUsers
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.IncSearch = True
      OptionsBehavior.ImmediateEditor = False
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.HideFocusRectOnExit = False
      OptionsSelection.InvertSelect = False
      OptionsSelection.UnselectFocusedRecordOnExit = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      object cxGridUsersView_USERID: TcxGridDBColumn
        DataBinding.FieldName = 'USERID'
        Width = 47
      end
      object cxGridUsersView_LOGIN_NAME: TcxGridDBColumn
        DataBinding.FieldName = 'LOGIN_NAME'
        Width = 129
      end
      object cxGridUsersView_FULL_NAME: TcxGridDBColumn
        DataBinding.FieldName = 'FULL_NAME'
        Width = 207
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGridUsersView
    end
  end
  object cxButton1: TcxButton
    Left = 327
    Top = 388
    Width = 75
    Height = 25
    Caption = 'Alege'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object cxButton2: TcxButton
    Left = 408
    Top = 388
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 2
  end
  object IBCQueryUsers: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      
        'SELECT * FROM TS_USERS WHERE get_flg_value(FLAGS, 0) = 1 and use' +
        'rid>0')
    Left = 272
    Top = 120
  end
  object IBCDataSourceUsers: TIBCDataSource
    DataSet = IBCQueryUsers
    Left = 344
    Top = 120
  end
end
