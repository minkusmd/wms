object frameCustomerAddr: TframeCustomerAddr
  Left = 0
  Top = 0
  Width = 846
  Height = 219
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object cxGrid3: TcxGrid
    Left = 0
    Top = 28
    Width = 846
    Height = 191
    Align = alClient
    TabOrder = 1
    ExplicitHeight = 452
    object cxGridCustomerAddr: TcxGridDBTableView
      OnKeyDown = cxGridCustomerAddrKeyDown
      DataController.DataModeController.GridMode = True
      DataController.DataSource = IBCDataSourceCustomerAddr
      DataController.KeyFieldNames = 'ADDRID'
      OptionsBehavior.IncSearch = True
      OptionsBehavior.ImmediateEditor = False
      OptionsData.Inserting = False
      OptionsSelection.InvertSelect = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      OptionsView.Indicator = True
      object cxGridCustomerAddr_TIP_EVENIMENT: TcxGridDBColumn
        Caption = 'Tip adresa'
        DataBinding.FieldName = 'ADDRTYPE_NAME'
        HeaderAlignmentHorz = taCenter
        Width = 100
      end
      object cxGridCustomerAddr_Oras: TcxGridDBColumn
        Caption = 'Oras'
        DataBinding.FieldName = 'CITY_NAME'
        Width = 154
      end
      object cxGridCustomerAddrRaion: TcxGridDBColumn
        Caption = 'Raion'
        DataBinding.FieldName = 'DISTRICT_NAME'
        HeaderAlignmentHorz = taCenter
        Width = 130
      end
      object cxGridCustomerAddr_DATA: TcxGridDBColumn
        Caption = 'Adresa'
        DataBinding.FieldName = 'STREET'
        HeaderAlignmentHorz = taCenter
        Width = 154
      end
      object cxGridCustomerAddrNOTA: TcxGridDBColumn
        Caption = 'Nota'
        DataBinding.FieldName = 'COMMENTS'
        HeaderAlignmentHorz = taCenter
        Width = 88
      end
    end
    object cxGridLevel3: TcxGridLevel
      GridView = cxGridCustomerAddr
    end
  end
  object IBCDataSourceCustomerAddr: TIBCDataSource
    DataSet = IBCQueryCustomerAddr
    Left = 64
    Top = 87
  end
  object IBCQueryCustomerAddr: TIBCQuery
    KeyFields = 'ADDRID'
    KeyGenerator = 'GEN_TS_CUST_ADDR_ID'
    GeneratorMode = gmInsert
    SQLInsert.Strings = (
      'INSERT INTO VW_TS_CUST_ADDR'
      
        '  (ADDRID, CUSTOMERID, ADDRTYPEID, ADDRTYPE_NAME, COUNTRYID, COU' +
        'NTRY_NAME, '
      
        '   CITYID, CITY_NAME, DISTRICTID, DISTRICT_NAME, STREET, FULL_AD' +
        'DRESS, '
      '   COMMENTS)'
      'VALUES'
      
        '  (:ADDRID, :CUSTOMERID, :ADDRTYPEID, :ADDRTYPE_NAME, :COUNTRYID' +
        ', :COUNTRY_NAME, '
      
        '   :CITYID, :CITY_NAME, :DISTRICTID, :DISTRICT_NAME, :STREET, :F' +
        'ULL_ADDRESS, '
      '   :COMMENTS)')
    SQLDelete.Strings = (
      'DELETE FROM VW_TS_CUST_ADDR'
      'WHERE'
      '  ADDRID = :Old_ADDRID')
    SQLUpdate.Strings = (
      'UPDATE VW_TS_CUST_ADDR'
      'SET'
      
        '  ADDRID = :ADDRID, CUSTOMERID = :CUSTOMERID, ADDRTYPEID = :ADDR' +
        'TYPEID, '
      '  ADDRTYPE_NAME = :ADDRTYPE_NAME, COUNTRYID = :COUNTRYID, '
      
        '  COUNTRY_NAME = :COUNTRY_NAME, CITYID = :CITYID, CITY_NAME = :C' +
        'ITY_NAME, '
      
        '  DISTRICTID = :DISTRICTID, DISTRICT_NAME = :DISTRICT_NAME, STRE' +
        'ET = :STREET, '
      '  FULL_ADDRESS = :FULL_ADDRESS, COMMENTS = :COMMENTS'
      'WHERE'
      '  ADDRID = :Old_ADDRID')
    SQLRefresh.Strings = (
      
        'SELECT ADDRID, CUSTOMERID, ADDRTYPEID, ADDRTYPE_NAME, COUNTRYID,' +
        ' COUNTRY_NAME, '
      
        '       CITYID, CITY_NAME, DISTRICTID, DISTRICT_NAME, STREET, FUL' +
        'L_ADDRESS, '
      '       COMMENTS '
      'FROM VW_TS_CUST_ADDR'
      'WHERE'
      '  ADDRID = :ADDRID')
    SQLLock.Strings = (
      'SELECT NULL FROM TS_CUST_ADDR'
      'WHERE'
      'ADDRID = :Old_ADDRID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM VW_TS_CUST_ADDR'
      ''
      ') q')
    SQL.Strings = (
      'SELECT * '
      '  FROM VW_TS_CUST_ADDR'
      ' WHERE CUSTOMERID=:CUSTOMERID')
    CachedUpdates = True
    AutoCommit = False
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    BeforePost = IBCQueryCustomerAddrBeforePost
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
    Left = 224
    Top = 87
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
          ItemName = 'bbNew'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbEdit'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbCloneAddr'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
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
      ImageIndex = 90
      ShortCut = 45
      OnClick = bbNewClick
    end
    object bbEdit: TdxBarButton
      Caption = 'Modifica'
      Category = 0
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 91
      ShortCut = 115
      OnClick = bbEditClick
    end
    object bbCloneAddr: TdxBarButton
      Caption = 'Cloneaza (fizica <-> juridica)'
      Category = 0
      Hint =
        'Cloneaza adresa selectata cu tipul schimbat: fizica -> juridica' +
        ', juridica -> fizica'
      Visible = ivAlways
      ImageIndex = 29
      ShortCut = 16452
      OnClick = bbCloneAddrClick
    end
    object bbDelete: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 92
      ShortCut = 16430
      OnClick = bbDeleteClick
    end
  end
end
