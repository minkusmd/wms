object frmDocTypeStatesDlg: TfrmDocTypeStatesDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Statutul documentui'
  ClientHeight = 365
  ClientWidth = 640
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poDefault
  DesignSize = (
    640
    365)
  PixelsPerInch = 96
  TextHeight = 15
  object cxButton1: TcxButton
    Left = 429
    Top = 328
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object cxButton2: TcxButton
    Left = 525
    Top = 328
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 5
  end
  object cxGrid1: TcxGrid
    Left = 8
    Top = 32
    Width = 625
    Height = 273
    TabOrder = 0
    object cxGrid1DBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      ScrollbarAnnotations.CustomAnnotations = <>
      DataController.DataSource = IBCDataSourceDoctype_States
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.GroupByBox = False
      OptionsView.Indicator = True
      object cxGrid1DBTableView1_STATEID: TcxGridDBColumn
        Caption = 'Cod'
        DataBinding.FieldName = 'STATEID'
      end
      object cxGrid1DBTableView1_TITLE: TcxGridDBColumn
        Caption = 'Denumire'
        DataBinding.FieldName = 'TITLE'
        Width = 450
      end
      object cxGrid1DBTableView1_INT_VALUE: TcxGridDBColumn
        Caption = 'P1'
        DataBinding.FieldName = 'INT_VALUE'
      end
      object cxGrid1DBTableView1_STR_VALUE: TcxGridDBColumn
        Caption = 'P2'
        DataBinding.FieldName = 'STR_VALUE'
      end
      object cxGrid1DBTableView1_ORDERNO: TcxGridDBColumn
        DataBinding.FieldName = 'ORDER_NO'
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
    end
  end
  object IBCQueryDoctype_States: TIBCQuery
    KeyFields = 'STATEID'
    KeyGenerator = 'GEN_TS_DOCTYPES_STATES_ID'
    SQLInsert.Strings = (
      'INSERT INTO TS_DOCTYPES_STATES'
      '  (STATEID, DOCTYPEID, TITLE, INT_VALUE, STR_VALUE, ORDERNO)'
      'VALUES'
      
        '  (:STATEID, :DOCTYPEID, :TITLE, :INT_VALUE, :STR_VALUE, :ORDERN' +
        'O)')
    SQLDelete.Strings = (
      'DELETE FROM TS_DOCTYPES_STATES'
      'WHERE'
      '  STATEID = :Old_STATEID')
    SQLUpdate.Strings = (
      'UPDATE TS_DOCTYPES_STATES'
      'SET'
      
        '  STATEID = :STATEID, DOCTYPEID = :DOCTYPEID, TITLE = :TITLE, IN' +
        'T_VALUE = :INT_VALUE, STR_VALUE = :STR_VALUE, ORDERNO = :ORDERNO'
      'WHERE'
      '  STATEID = :Old_STATEID')
    SQLRefresh.Strings = (
      
        'SELECT STATEID, DOCTYPEID, TITLE, INT_VALUE, STR_VALUE, ORDERNO ' +
        'FROM TS_DOCTYPES_STATES'
      'WHERE'
      '  STATEID = :STATEID')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM TS_DOCTYPES_STATES'
      ''
      ') q')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'select * from TS_DOCTYPES_STATES '
      'where DOCTYPEID = :DOCTYPEID'
      'order by title, int_value desc')
    Left = 160
    Top = 144
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DOCTYPEID'
        Value = nil
      end>
  end
  object IBCDataSourceDoctype_States: TIBCDataSource
    DataSet = IBCQueryDoctype_States
    Left = 80
    Top = 144
  end
  object dxBarManager1: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      #1055#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102)
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    ImageOptions.Images = dmAdditions.cxImageList_SWN
    PopupMenuLinks = <>
    UseSystemFont = False
    Left = 312
    Top = 184
    PixelsPerInch = 96
    DockControlHeights = (
      0
      0
      28
      0)
    object dxBarManager1Bar1: TdxBar
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' 1'
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 0
      DockedTop = 0
      DockingStyle = dsTop
      FloatLeft = 669
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbNewL1'
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
    object bbEdit: TdxBarButton
      Caption = 'Modifica'
      Category = 0
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 115
      OnClick = bbEditClick
    end
    object bbDelete: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      ShortCut = 16430
      OnClick = bbDeleteClick
    end
    object bbNewL1: TdxBarButton
      Caption = 'Nou'
      Category = 0
      Hint = 'Nou'
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 45
      OnClick = bbNewL1Click
    end
    object bbNewL2: TdxBarButton
      Caption = 'Nou - nivel 2'
      Category = 0
      Hint = 'Nou - nivel 2'
      Visible = ivAlways
    end
  end
end
