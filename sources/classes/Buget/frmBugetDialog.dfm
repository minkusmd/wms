object frmBugetDlg: TfrmBugetDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Nomenlator articole buget'
  ClientHeight = 441
  ClientWidth = 581
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object cxGrid1: TcxGrid
    Left = 16
    Top = 8
    Width = 553
    Height = 369
    TabOrder = 0
    object cxGrid1DBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      Navigator.Visible = True
      ScrollbarAnnotations.CustomAnnotations = <>
      OnEditKeyDown = cxGrid1DBTableView1EditKeyDown
      DataController.DataSource = IBCDataSourceBuget
      DataController.KeyFieldNames = 'BUGETID'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      object cxGrid1DBTableView1BUGETID: TcxGridDBColumn
        Caption = 'Nr'
        DataBinding.FieldName = 'BUGETID'
        MinWidth = 67
        Options.Editing = False
        Options.Focusing = False
        Options.IgnoreTimeForFiltering = False
        Options.GroupFooters = False
        Options.Grouping = False
        Options.HorzSizing = False
        Options.Moving = False
        Options.Sorting = False
        Width = 67
      end
      object cxGrid1DBTableView1TITLE: TcxGridDBColumn
        Caption = 'Articol'
        DataBinding.FieldName = 'TITLE'
        HeaderAlignmentHorz = taCenter
        Width = 216
      end
      object cxGrid1DBTableView1Column1: TcxGridDBColumn
        Caption = 'Subdiviziune'
        HeaderAlignmentHorz = taCenter
        Width = 157
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
    end
  end
  object btnOK: TcxButton
    Left = 254
    Top = 400
    Width = 99
    Height = 25
    Caption = #1047#1072#1082#1088#1099#1090#1100
    ModalResult = 1
    TabOrder = 1
  end
  object IBCDataSourceBuget: TIBCDataSource
    DataSet = IBCQueryBuget
    Left = 40
    Top = 104
  end
  object IBCQueryBuget: TIBCQuery
    KeyFields = 'bugetid'
    KeyGenerator = 'gen_ts_bugets_id'
    SQLInsert.Strings = (
      'INSERT INTO TS_BUGETS'
      '  (BUGETID, TITLE)'
      'VALUES'
      '  (:BUGETID, :TITLE)')
    SQLDelete.Strings = (
      'DELETE FROM TS_BUGETS'
      'WHERE'
      '  BUGETID = :Old_BUGETID')
    SQLUpdate.Strings = (
      'UPDATE TS_BUGETS'
      'SET'
      '  BUGETID = :BUGETID, TITLE = :TITLE'
      'WHERE'
      '  BUGETID = :Old_BUGETID')
    SQLRefresh.Strings = (
      'SELECT BUGETID, TITLE FROM TS_BUGETS'
      'WHERE'
      '  BUGETID = :BUGETID')
    SQLLock.Strings = (
      'SELECT NULL FROM TS_BUGETS'
      'WHERE'
      'BUGETID = :Old_BUGETID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM TS_BUGETS'
      ''
      ') q')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = IBCTrUpdate
    SQL.Strings = (
      'SELECT * FROM TS_BUGETS ORDER BY BUGETID')
    Left = 136
    Top = 104
  end
  object IBCTrUpdate: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 208
    Top = 104
  end
end
