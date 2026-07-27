object frmTransportDlg: TfrmTransportDlg
  Left = 0
  Top = 0
  Caption = 'frmTransportDlg'
  ClientHeight = 464
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    635
    464)
  PixelsPerInch = 96
  TextHeight = 13
  object cxGrid1: TcxGrid
    Left = 8
    Top = 36
    Width = 619
    Height = 385
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 1
    object cxGrid1DBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      ScrollbarAnnotations.CustomAnnotations = <>
      DataController.DataSource = IBCDataSourceTransport
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      object cxGrid1DBTableView1TRANSPORTID: TcxGridDBColumn
        Caption = 'ID'
        DataBinding.FieldName = 'TRANSPORTID'
        Width = 37
      end
      object cxGrid1DBTableView1NAME: TcxGridDBColumn
        Caption = 'Transport'
        DataBinding.FieldName = 'NAME'
        Width = 167
      end
      object cxGrid1DBTableView1MODEL: TcxGridDBColumn
        Caption = 'Model'
        DataBinding.FieldName = 'MODEL'
        Width = 109
      end
      object cxGrid1DBTableView1REGISTRATION_NUMBER: TcxGridDBColumn
        Caption = 'Numar inreg'
        DataBinding.FieldName = 'REGISTRATION_NUMBER'
        Width = 72
      end
      object cxGrid1DBTableView1CONSUMPTION: TcxGridDBColumn
        Caption = 'Consum'
        DataBinding.FieldName = 'CONSUMPTION'
        Width = 71
      end
      object cxGrid1DBTableView1DRIVER_NAME: TcxGridDBColumn
        Caption = 'Sofer'
        DataBinding.FieldName = 'DRIVER_NAME'
        Width = 161
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
    end
  end
  object cxButton1: TcxButton
    Left = 432
    Top = 427
    Width = 90
    Height = 29
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 3
  end
  object cxButton2: TcxButton
    Left = 529
    Top = 427
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 5
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
    Left = 312
    Top = 152
    PixelsPerInch = 96
    DockControlHeights = (
      0
      0
      28
      0)
    object dxBarManager1Bar1: TdxBar
      Caption = 'Custom 1'
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
  object IBCQueryTransport: TIBCQuery
    KeyFields = 'TRANSPORTID'
    KeyGenerator = 'gen_ts_transport_id'
    SQLInsert.Strings = (
      'INSERT INTO VW_TS_TRANSPORT'
      
        '  (TRANSPORTID, NAME, MODEL, REGISTRATION_NUMBER, CONSUMPTION, D' +
        'RIVER, DRIVER_NAME)'
      'VALUES'
      
        '  (:TRANSPORTID, :NAME, :MODEL, :REGISTRATION_NUMBER, :CONSUMPTI' +
        'ON, :DRIVER, :DRIVER_NAME)')
    SQLDelete.Strings = (
      'DELETE FROM VW_TS_TRANSPORT'
      'WHERE'
      '  TRANSPORTID = :Old_TRANSPORTID')
    SQLUpdate.Strings = (
      'UPDATE VW_TS_TRANSPORT'
      'SET'
      
        '  TRANSPORTID = :TRANSPORTID, NAME = :NAME, MODEL = :MODEL, REGI' +
        'STRATION_NUMBER = :REGISTRATION_NUMBER, CONSUMPTION = :CONSUMPTI' +
        'ON, DRIVER = :DRIVER, DRIVER_NAME = :DRIVER_NAME'
      'WHERE'
      '  TRANSPORTID = :Old_TRANSPORTID')
    SQLRefresh.Strings = (
      
        'SELECT TRANSPORTID, NAME, MODEL, REGISTRATION_NUMBER, CONSUMPTIO' +
        'N, DRIVER, DRIVER_NAME FROM VW_TS_TRANSPORT'
      'WHERE'
      '  TRANSPORTID = :TRANSPORTID')
    SQLLock.Strings = (
      'SELECT NULL FROM TS_TRANSPORT'
      'WHERE'
      'TRANSPORTID = :Old_TRANSPORTID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM VW_TS_TRANSPORT'
      ''
      ') q')
    SQL.Strings = (
      'SELECT * FROM VW_TS_TRANSPORT ')
    Left = 224
    Top = 296
  end
  object IBCDataSourceTransport: TIBCDataSource
    DataSet = IBCQueryTransport
    Left = 104
    Top = 296
  end
end
