object frmJobVacanciesDlg: TfrmJobVacanciesDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Functii vacante'
  ClientHeight = 525
  ClientWidth = 918
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 472
    Width = 918
    Height = 53
    Align = alBottom
    BevelOuter = bvLowered
    TabOrder = 4
    ExplicitTop = 478
    object cxButton1: TcxButton
      Left = 688
      Top = 16
      Width = 90
      Height = 29
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
    object cxButton2: TcxButton
      Left = 792
      Top = 16
      Width = 90
      Height = 29
      Cancel = True
      Caption = 'Renunta'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object cxGrid1: TcxGrid
    Left = 0
    Top = 28
    Width = 918
    Height = 444
    Align = alClient
    TabOrder = 1
    ExplicitTop = 22
    object cxGrid1DBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      ScrollbarAnnotations.CustomAnnotations = <>
      DataController.DataSource = IBCDataSourceJobs
      DataController.KeyFieldNames = 'JOBID'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsView.GroupByBox = False
      object cxGrid1DBTableView1JOBID: TcxGridDBColumn
        DataBinding.FieldName = 'JOBID'
      end
      object cxGrid1DBTableView1TITLE_RO: TcxGridDBColumn
        DataBinding.FieldName = 'TITLE_RO'
        Width = 400
      end
      object cxGrid1DBTableView1TITLE_RU: TcxGridDBColumn
        DataBinding.FieldName = 'TITLE_RU'
        Width = 400
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
    end
  end
  object dxBarManager1: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Default')
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 408
    Top = 112
    PixelsPerInch = 96
    DockControlHeights = (
      0
      0
      28
      0)
    object dxBarManager1Bar1: TdxBar
      Caption = 'Main'
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 0
      DockedTop = 0
      DockingStyle = dsTop
      FloatLeft = 936
      FloatTop = 2
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbNew'
        end
        item
          Visible = True
          ItemName = 'bbEdit'
        end
        item
          Visible = True
          ItemName = 'bbDelete'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object bbNew: TdxBarButton
      Caption = 'Nou'
      Category = 0
      Hint = 'Nou'
      Visible = ivAlways
    end
    object bbEdit: TdxBarButton
      Caption = 'Modifica'
      Category = 0
      Hint = 'Modifica'
      Visible = ivAlways
    end
    object bbDelete: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
    end
  end
  object IBCQueryJobs: TIBCQuery
    KeyFields = 'jobid'
    KeyGenerator = 'gen_ts_jobs_id'
    SQLInsert.Strings = (
      'INSERT INTO TS_JOBS'
      '  (JOBID, TITLE_RO, TITLE_RU, DESCRIPTION_RO, DESCRIPTION_RU)'
      'VALUES'
      
        '  (:JOBID, :TITLE_RO, :TITLE_RU, :DESCRIPTION_RO, :DESCRIPTION_R' +
        'U)')
    SQLDelete.Strings = (
      'DELETE FROM TS_JOBS'
      'WHERE'
      '  JOBID = :Old_JOBID')
    SQLUpdate.Strings = (
      'UPDATE TS_JOBS'
      'SET'
      
        '  JOBID = :JOBID, TITLE_RO = :TITLE_RO, TITLE_RU = :TITLE_RU, DE' +
        'SCRIPTION_RO = :DESCRIPTION_RO, DESCRIPTION_RU = :DESCRIPTION_RU'
      'WHERE'
      '  JOBID = :Old_JOBID')
    SQLRefresh.Strings = (
      
        'SELECT JOBID, TITLE_RO, TITLE_RU, DESCRIPTION_RO, DESCRIPTION_RU' +
        ' FROM TS_JOBS'
      'WHERE'
      '  JOBID = :JOBID')
    SQLLock.Strings = (
      'SELECT NULL FROM TS_JOBS'
      'WHERE'
      'JOBID = :Old_JOBID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM TS_JOBS'
      ''
      ') q')
    SQL.Strings = (
      'select * from vw_ts_jobs'
      'order by jobid desc'
      '')
    Left = 352
    Top = 280
  end
  object IBCDataSourceJobs: TIBCDataSource
    DataSet = IBCQueryJobs
    Left = 352
    Top = 224
  end
end
