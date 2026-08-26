object frmLoanTypesDlg: TfrmLoanTypesDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Tipuri de credite'
  ClientHeight = 342
  ClientWidth = 379
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object btnOK: TButton
    Left = 192
    Top = 311
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    DoubleBuffered = True
    ModalResult = 1
    ParentDoubleBuffered = False
    TabOrder = 0
    OnClick = btnOKClick
  end
  object Button2: TButton
    Left = 280
    Top = 311
    Width = 75
    Height = 25
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 1
  end
  object cxGrid1: TcxGrid
    Left = 8
    Top = 8
    Width = 361
    Height = 289
    TabOrder = 2
    object cxGrid1DBTableView1: TcxGridDBTableView
      Navigator.Buttons.ConfirmDelete = True
      Navigator.Buttons.CustomButtons = <>
      Navigator.Buttons.First.Visible = False
      Navigator.Buttons.PriorPage.Visible = False
      Navigator.Buttons.Next.Visible = False
      Navigator.Buttons.NextPage.Visible = False
      Navigator.Buttons.Last.Visible = False
      Navigator.Buttons.Insert.Visible = True
      Navigator.Buttons.Append.Visible = False
      Navigator.Buttons.SaveBookmark.Visible = False
      Navigator.Buttons.GotoBookmark.Visible = False
      Navigator.InfoPanel.Visible = True
      Navigator.Visible = True
      DataController.DataSource = IBCDataSourceLoanTypes
      DataController.KeyFieldNames = 'LOAN_TYPEID'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.ImmediateEditor = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      OptionsView.Indicator = True
      object cxGrid1DBTableView1_MinValue: TcxGridDBColumn
        Caption = 'Cod'
        DataBinding.FieldName = 'LOAN_TYPEID'
        MinWidth = 56
        Options.Editing = False
        Options.IncSearch = False
        Options.HorzSizing = False
        Options.Moving = False
        Width = 56
      end
      object cxGrid1DBTableView1_MaxValue: TcxGridDBColumn
        Caption = 'Denumire'
        DataBinding.FieldName = 'TITLE'
        Width = 303
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
    end
  end
  object IBCQueryLoanTypes: TIBCQuery
    KeyFields = 'LOAN_TYPEID'
    KeyGenerator = 'gen_ts_loan_types_id'
    SQLInsert.Strings = (
      'INSERT INTO TS_LOAN_TYPES'
      '  (LOAN_TYPEID, TITLE)'
      'VALUES'
      '  (:LOAN_TYPEID, :TITLE)')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM TS_LOAN_TYPES'
      ''
      ') q')
    UpdateTransaction = IBCTrUpdate
    SQL.Strings = (
      'select * From ts_loan_types order by loan_typeid')
    Options.RequiredFields = False
    LocalConstraints = False
    Constraints = <>
    Left = 120
    Top = 160
  end
  object IBCDataSourceLoanTypes: TIBCDataSource
    DataSet = IBCQueryLoanTypes
    Left = 48
    Top = 160
  end
  object IBCTrUpdate: TIBCTransaction
    Left = 232
    Top = 160
  end
end
