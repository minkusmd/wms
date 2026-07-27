object frameCustomerEvents: TframeCustomerEvents
  Left = 0
  Top = 0
  Width = 714
  Height = 217
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  OnEnter = FrameEnter
  object cxGrid3: TcxGrid
    Left = 0
    Top = 28
    Width = 714
    Height = 189
    Align = alClient
    TabOrder = 1
    object cxGridImportantEvents: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      ScrollbarAnnotations.CustomAnnotations = <>
      DataController.DataSource = IBCDataSourceCustomerEvents
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      object cxGridImportantEvents_TIP_EVENIMENT: TcxGridDBColumn
        Caption = 'Tip eveniment'
        DataBinding.FieldName = 'CUSTOMER_EVENT_TYPE'
        Width = 129
      end
      object cxGridImportantEvents_DATA: TcxGridDBColumn
        Caption = 'Data'
        DataBinding.FieldName = 'DATA'
        Width = 93
      end
      object cxGridImportantEvents_DATA_NEXT: TcxGridDBColumn
        Caption = 'Data urmatoare'
        DataBinding.FieldName = 'NEXT_DATA'
        Width = 90
      end
      object cxGridImportantEventsNOTA: TcxGridDBColumn
        Caption = 'Nota'
        DataBinding.FieldName = 'NOTA'
        Width = 383
      end
    end
    object cxGridLevel3: TcxGridLevel
      GridView = cxGridImportantEvents
    end
  end
  object IBCDataSourceCustomerEvents: TIBCDataSource
    DataSet = IBCQueryCustomerEvents
    Left = 64
    Top = 87
  end
  object IBCQueryCustomerEvents: TIBCQuery
    KeyFields = 'EVENTID'
    KeyGenerator = 'gen_ts_cust_events_id'
    SQLInsert.Strings = (
      'INSERT INTO VW_TS_CUST_EVENTS'
      
        '  (EVENTID, CUSTOMERID, DATA, EVENTTYPEID, CUSTOMER_EVENT_TYPE, ' +
        'NOTES, NEXT_DATA, PERIODICITATE)'
      'VALUES'
      
        '  (:EVENTID, :CUSTOMERID, :DATA, :EVENTTYPEID, :CUSTOMER_EVENT_T' +
        'YPE, :NOTES, :NEXT_DATA, :PERIODICITATE)')
    SQLDelete.Strings = (
      'DELETE FROM VW_TS_CUST_EVENTS'
      'WHERE'
      '  EVENTID = :Old_EVENTID')
    SQLUpdate.Strings = (
      'UPDATE VW_TS_CUST_EVENTS'
      'SET'
      
        '  EVENTID = :EVENTID, CUSTOMERID = :CUSTOMERID, DATA = :DATA, EV' +
        'ENTTYPEID = :EVENTTYPEID, CUSTOMER_EVENT_TYPE = :CUSTOMER_EVENT_' +
        'TYPE, NOTES = :NOTES, NEXT_DATA = :NEXT_DATA, PERIODICITATE = :P' +
        'ERIODICITATE'
      'WHERE'
      '  EVENTID = :Old_EVENTID')
    SQLRefresh.Strings = (
      
        'SELECT EVENTID, CUSTOMERID, DATA, EVENTTYPEID, CUSTOMER_EVENT_TY' +
        'PE, NOTES, NEXT_DATA, PERIODICITATE FROM VW_TS_CUST_EVENTS'
      'WHERE'
      '  EVENTID = :EVENTID')
    SQLLock.Strings = (
      'SELECT NULL FROM TS_CUST_EVENTS'
      'WHERE'
      'EVENTID = :Old_EVENTID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM VW_TS_CUST_EVENTS'
      ''
      ') q')
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT * '
      '  FROM VW_TS_CUST_EVENTS'
      ' WHERE CUSTOMERID=:CUSTOMERID')
    AutoCommit = False
    Left = 64
    Top = 143
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CUSTOMERID'
        Value = nil
      end>
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
    ImageOptions.Images = dmAdditions.cxImageList_SWN
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 344
    Top = 128
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
      FloatLeft = 724
      FloatTop = 0
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbNewCustomerEvent'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbEditCustomerEvent'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbDeleteCustomerEvent'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object bbNewCustomerEvent: TdxBarButton
      Caption = 'Nou'
      Category = 0
      Hint = 'Nou'
      Visible = ivAlways
      ImageIndex = 90
      ShortCut = 45
      OnClick = bbNewCustomerEventClick
    end
    object bbEditCustomerEvent: TdxBarButton
      Caption = 'Modifica'
      Category = 0
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 91
      ShortCut = 115
      OnClick = bbEditCustomerEventClick
    end
    object bbDeleteCustomerEvent: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 92
      ShortCut = 16430
      OnClick = bbDeleteCustomerEventClick
    end
  end
end
