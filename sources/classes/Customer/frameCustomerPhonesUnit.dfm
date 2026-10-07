object frameCustomerPhones: TframeCustomerPhones
  Left = 0
  Top = 0
  Width = 763
  Height = 240
  TabOrder = 0
  object cxGrid1: TcxGrid
    Left = 0
    Top = 28
    Width = 763
    Height = 212
    Align = alClient
    TabOrder = 1
    ExplicitLeft = -8
    ExplicitTop = 36
    object cxGridDBTableView1: TcxGridDBTableView
      OnKeyDown = cxGridDBTableView1KeyDown
      DataController.DataSource = IBCDataSourceCustomerPhones
      OptionsBehavior.IncSearch = True
      OptionsBehavior.ImmediateEditor = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      OptionsView.Indicator = True
      object cxGridDBTableView1_ID: TcxGridDBColumn
        Caption = 'ID'
        DataBinding.FieldName = 'PHONEID'
        HeaderAlignmentHorz = taCenter
        MinWidth = 64
        Options.HorzSizing = False
      end
      object cxGridDBTableView1_TIP_TELEFON: TcxGridDBColumn
        Caption = 'Tip telefon'
        DataBinding.FieldName = 'PHONETYPE'
        MinWidth = 138
        Options.HorzSizing = False
        Width = 138
      end
      object cxGridDBTableView1_FLG_SMS: TcxGridDBColumn
        Caption = 'Sms'
        DataBinding.FieldName = 'FLG_SMS'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = '1'
        Properties.ValueUnchecked = '0'
        HeaderAlignmentHorz = taCenter
        MinWidth = 33
        Options.HorzSizing = False
        Width = 33
      end
      object cxGridDBTableView1_NUMAR_TELEFON: TcxGridDBColumn
        Caption = 'Numar telefon'
        DataBinding.FieldName = 'PHONENUMBER'
        MinWidth = 120
        Options.HorzSizing = False
        Width = 120
      end
      object cxGridDBTableView1_NOTE: TcxGridDBColumn
        Caption = 'Mentiuni'
        DataBinding.FieldName = 'COMMENT'
        Width = 362
      end
    end
    object cxGridLevel1: TcxGridLevel
      GridView = cxGridDBTableView1
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
    ImageOptions.Images = dmAdditions.cxImageList_SWN
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 360
    Top = 104
    PixelsPerInch = 96
    DockControlHeights = (
      0
      0
      28
      0)
    object dxBarManager1Bar1: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Custom 1'
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 0
      DockedTop = 0
      DockingStyle = dsTop
      FloatLeft = 773
      FloatTop = 0
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbNewCustomerPhones'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbEditCustomerPhones'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbDeleteCustomerPhones'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object bbNewCustomerPhones: TdxBarButton
      Caption = 'Nou'
      Category = 0
      Hint = 'Nou'
      Visible = ivAlways
      ImageIndex = 90
      ShortCut = 45
      OnClick = bbNewCustomerPhonesClick
    end
    object bbEditCustomerPhones: TdxBarButton
      Caption = 'Modifica'
      Category = 0
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 91
      ShortCut = 115
      OnClick = bbEditCustomerPhonesClick
    end
    object bbDeleteCustomerPhones: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 92
      ShortCut = 16430
      OnClick = bbDeleteCustomerPhonesClick
    end
  end
  object IBCQueryCustomerPhones: TIBCQuery
    KeyFields = 'PHONEID'
    KeyGenerator = 'gen_ts_cust_phones_id'
    SQLInsert.Strings = (
      'INSERT INTO VW_TS_CUST_PHONES'
      
        '  (PHONEID, CUSTOMERID, PHONENUMBER, COMMENT, PHONETYPEID, PHONE' +
        'TYPE, FLG_SMS)'
      'VALUES'
      
        '  (:PHONEID, :CUSTOMERID, :PHONENUMBER, :COMMENT, :PHONETYPEID, ' +
        ':PHONETYPE, :FLG_SMS)')
    SQLDelete.Strings = (
      'DELETE FROM VW_TS_CUST_PHONES'
      'WHERE'
      '  PHONEID = :Old_PHONEID')
    SQLUpdate.Strings = (
      'UPDATE VW_TS_CUST_PHONES'
      'SET'
      
        '  PHONEID = :PHONEID, CUSTOMERID = :CUSTOMERID, PHONENUMBER = :P' +
        'HONENUMBER, COMMENT = :COMMENT, PHONETYPEID = :PHONETYPEID, PHON' +
        'ETYPE = :PHONETYPE, FLG_SMS = :FLG_SMS'
      'WHERE'
      '  PHONEID = :Old_PHONEID')
    SQLRefresh.Strings = (
      
        'SELECT PHONEID, CUSTOMERID, PHONENUMBER, COMMENT, PHONETYPEID, P' +
        'HONETYPE, FLG_SMS FROM VW_TS_CUST_PHONES'
      'WHERE'
      '  PHONEID = :PHONEID')
    SQLLock.Strings = (
      'SELECT NULL FROM TS_CUST_PHONES'
      'WHERE'
      'PHONEID = :Old_PHONEID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM VW_TS_CUST_PHONES'
      ''
      ') q')
    SQL.Strings = (
      'select p.* from vw_ts_cust_phones p  '
      'where customerid=:customerid')
    Debug = True
    AutoCommit = False
    IndexFieldNames = 'PHONEID'
    Left = 360
    Top = 160
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'customerid'
        Value = nil
      end>
  end
  object IBCDataSourceCustomerPhones: TIBCDataSource
    DataSet = IBCQueryCustomerPhones
    Left = 168
    Top = 160
  end
end
