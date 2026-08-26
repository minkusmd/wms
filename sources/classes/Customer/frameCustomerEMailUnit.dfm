object frameCustomerEMail: TframeCustomerEMail
  Left = 0
  Top = 0
  Width = 763
  Height = 256
  TabOrder = 0
  object cxGridCustEmail: TcxGrid
    Left = 0
    Top = 28
    Width = 763
    Height = 228
    Align = alClient
    TabOrder = 1
    ExplicitHeight = 212
    object cxGridCustEmailDBTableView: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      ScrollbarAnnotations.CustomAnnotations = <>
      DataController.DataSource = IBCDataSourceCustomerEmail
      DataController.KeyFieldNames = 'ID'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.IncSearch = True
      OptionsBehavior.ImmediateEditor = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      OptionsView.Indicator = True
      object cxGridCustEmailDBTableViewColumn1: TcxGridDBColumn
        DataBinding.FieldName = 'ID'
        DataBinding.IsNullValueType = True
        Visible = False
      end
      object cxGridCustEmailDBTableViewEMail: TcxGridDBColumn
        Caption = 'EMail'
        DataBinding.FieldName = 'EMAIL'
        DataBinding.IsNullValueType = True
        Width = 437
      end
      object cxGridCustEmailDBTableViewUNSUBSCRIBED: TcxGridDBColumn
        AlternateCaption = 'Unsubscribed'
        Caption = 'U'
        DataBinding.FieldName = 'UNSUBSCRIBED'
        DataBinding.IsNullValueType = True
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = '1'
        Properties.ValueUnchecked = '0'
        HeaderAlignmentHorz = taCenter
        MinWidth = 33
        Options.IncSearch = False
        Options.HorzSizing = False
        Options.Moving = False
        Width = 33
      end
      object cxGridCustEmailDBTableViewCREATED_DATE: TcxGridDBColumn
        Caption = 'Creat la'
        DataBinding.FieldName = 'CREATED_DATE'
        DataBinding.IsNullValueType = True
        HeaderAlignmentHorz = taCenter
        Width = 140
      end
      object cxGridCustEmailDBTableViewUNSUBSCRIBE_DATE: TcxGridDBColumn
        AlternateCaption = 'Data anularii abonarii'
        Caption = 'UD'
        DataBinding.FieldName = 'UNSUBSCRIBE_DATE'
        DataBinding.IsNullValueType = True
        HeaderAlignmentHorz = taCenter
        Width = 139
      end
    end
    object cxGridLevel1: TcxGridLevel
      GridView = cxGridCustEmailDBTableView
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
    Left = 368
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
          ItemName = 'bbNewCustomerEmail'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbEditCustomerEmail'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbDeleteCustomerEmail'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbClearEmails'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object bbNewCustomerEmail: TdxBarButton
      Caption = 'Nou'
      Category = 0
      Hint = 'Nou'
      Visible = ivAlways
      ImageIndex = 90
      ShortCut = 45
      OnClick = bbNewCustomerEmailClick
    end
    object bbEditCustomerEmail: TdxBarButton
      Caption = 'Modifica'
      Category = 0
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 91
      ShortCut = 115
      OnClick = bbEditCustomerEmailClick
    end
    object bbDeleteCustomerEmail: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 92
      ShortCut = 16430
      OnClick = bbDeleteCustomerEmailClick
    end
    object bbClearEmails: TdxBarButton
      Caption = 'Sterge toate'
      Category = 0
      Hint = 'Sterge toate'
      Visible = ivAlways
      OnClick = bbClearEmailsClick
    end
  end
  object IBCQueryCustomerEMail: TIBCQuery
    KeyFields = 'ID'
    KeyGenerator = 'gen_ts_cust_emails_id'
    SQLInsert.Strings = (
      'INSERT INTO TS_CUST_EMAILS'
      
        '  (EMAIL, CUSTOMERID, UNSUBSCRIBED, CREATED_DATE, UNSUBSCRIBE_DA' +
        'TE)'
      'VALUES'
      
        '  (:EMAIL, :CUSTOMERID, :UNSUBSCRIBED, :CREATED_DATE, :UNSUBSCRI' +
        'BE_DATE)')
    SQLDelete.Strings = (
      'DELETE FROM TS_CUST_EMAILS'
      'WHERE'
      '  CUSTOMERID = :Old_CUSTOMERID AND EMAIL = :Old_EMAIL')
    SQLUpdate.Strings = (
      'UPDATE TS_CUST_EMAILS'
      'SET'
      
        '  EMAIL = :EMAIL, CUSTOMERID = :CUSTOMERID, UNSUBSCRIBED = :UNSU' +
        'BSCRIBED, CREATED_DATE = :CREATED_DATE, UNSUBSCRIBE_DATE = :UNSU' +
        'BSCRIBE_DATE'
      'WHERE'
      '  CUSTOMERID = :Old_CUSTOMERID AND EMAIL = :Old_EMAIL')
    SQLRefresh.Strings = (
      
        'SELECT EMAIL, CUSTOMERID, UNSUBSCRIBED, CREATED_DATE, UNSUBSCRIB' +
        'E_DATE FROM TS_CUST_EMAILS'
      'WHERE'
      '  CUSTOMERID = :CUSTOMERID AND EMAIL = :EMAIL')
    SQLLock.Strings = (
      'SELECT NULL FROM TS_CUST_EMAILS'
      'WHERE'
      'CUSTOMERID = :Old_CUSTOMERID AND EMAIL = :Old_EMAIL'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM TS_CUST_EMAILS'
      ''
      ') q')
    SQL.Strings = (
      'select * from TS_CUST_EMAILS e  '
      'where customerid=:customerid')
    CachedUpdates = True
    AutoCommit = False
    Left = 360
    Top = 160
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'customerid'
        Value = nil
      end>
  end
  object IBCDataSourceCustomerEmail: TIBCDataSource
    DataSet = IBCQueryCustomerEMail
    Left = 168
    Top = 160
  end
end
