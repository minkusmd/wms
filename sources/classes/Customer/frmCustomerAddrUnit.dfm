object frmCustomerAddrDlg: TfrmCustomerAddrDlg
  Left = 0
  Top = 0
  Caption = 'Adrese pentru livrare'
  ClientHeight = 420
  ClientWidth = 935
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    935
    420)
  PixelsPerInch = 96
  TextHeight = 13
  object cxButton1: TcxButton
    Left = 340
    Top = 383
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 4
  end
  object cxButton2: TcxButton
    Left = 444
    Top = 383
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
    Width = 919
    Height = 326
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 3
    object cxGrid1DBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = IBCDataSourceCustAddr
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsView.GroupByBox = False
      object cxGrid1DBTableView1ADDRID: TcxGridDBColumn
        DataBinding.FieldName = 'ADDRID'
        Visible = False
      end
      object cxGrid1DBTableView1CUSTOMERID: TcxGridDBColumn
        DataBinding.FieldName = 'CUSTOMERID'
        Visible = False
      end
      object cxGrid1DBTableView1ADDRTYPEID: TcxGridDBColumn
        DataBinding.FieldName = 'ADDRTYPEID'
        Visible = False
      end
      object cxGrid1DBTableView1ADDRTYPE_NAME: TcxGridDBColumn
        DataBinding.FieldName = 'ADDRTYPE_NAME'
        Width = 100
      end
      object cxGrid1DBTableView1FULL_ADDRESS: TcxGridDBColumn
        DataBinding.FieldName = 'FULL_ADDRESS'
        Width = 282
      end
      object cxGrid1DBTableView1COUNTRYID: TcxGridDBColumn
        DataBinding.FieldName = 'COUNTRYID'
        Visible = False
      end
      object cxGrid1DBTableView1COUNTRY_NAME: TcxGridDBColumn
        DataBinding.FieldName = 'COUNTRY_NAME'
        Width = 100
      end
      object cxGrid1DBTableView1CITYID: TcxGridDBColumn
        DataBinding.FieldName = 'CITYID'
        Visible = False
      end
      object cxGrid1DBTableView1CITY_NAME: TcxGridDBColumn
        DataBinding.FieldName = 'CITY_NAME'
        Width = 100
      end
      object cxGrid1DBTableView1DISTRICTID: TcxGridDBColumn
        DataBinding.FieldName = 'DISTRICTID'
        Visible = False
      end
      object cxGrid1DBTableView1DISTRINCT_NAME: TcxGridDBColumn
        DataBinding.FieldName = 'DISTRINCT_NAME'
        Width = 107
      end
      object cxGrid1DBTableView1STREET: TcxGridDBColumn
        DataBinding.FieldName = 'STREET'
        Width = 150
      end
      object cxGrid1DBTableView1COMMENTS: TcxGridDBColumn
        DataBinding.FieldName = 'COMMENTS'
        Width = 200
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
    Left = 16
    Top = 360
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
      OnClick = bbNewClick
    end
    object bbEdit: TdxBarButton
      Caption = 'Modifica'
      Category = 0
      Hint = 'Modifica'
      Visible = ivAlways
      OnClick = bbEditClick
    end
    object bbDelete: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      OnClick = bbDeleteClick
    end
  end
  object IBCQueryCustAddr: TIBCQuery
    SQLInsert.Strings = (
      'INSERT INTO VW_TS_CUST_ADDR'
      
        '  (ADDRID, CUSTOMERID, ADDRTYPEID, ADDRTYPE_NAME, COUNTRYID, COU' +
        'NTRY_NAME, CITYID, CITY_NAME, DISTRICTID, DISTRINCT_NAME, STREET' +
        ', FULL_ADDRESS, COMMENTS)'
      'VALUES'
      
        '  (:ADDRID, :CUSTOMERID, :ADDRTYPEID, :ADDRTYPE_NAME, :COUNTRYID' +
        ', :COUNTRY_NAME, :CITYID, :CITY_NAME, :DISTRICTID, :DISTRINCT_NA' +
        'ME, :STREET, :FULL_ADDRESS, :COMMENTS)')
    SQLDelete.Strings = (
      'DELETE FROM VW_TS_CUST_ADDR'
      'WHERE'
      '  ADDRID = :Old_ADDRID')
    SQLUpdate.Strings = (
      'UPDATE VW_TS_CUST_ADDR'
      'SET'
      
        '  ADDRID = :ADDRID, CUSTOMERID = :CUSTOMERID, ADDRTYPEID = :ADDR' +
        'TYPEID, ADDRTYPE_NAME = :ADDRTYPE_NAME, COUNTRYID = :COUNTRYID, ' +
        'COUNTRY_NAME = :COUNTRY_NAME, CITYID = :CITYID, CITY_NAME = :CIT' +
        'Y_NAME, DISTRICTID = :DISTRICTID, DISTRINCT_NAME = :DISTRINCT_NA' +
        'ME, STREET = :STREET, FULL_ADDRESS = :FULL_ADDRESS, COMMENTS = :' +
        'COMMENTS'
      'WHERE'
      '  ADDRID = :Old_ADDRID')
    SQLRefresh.Strings = (
      
        'SELECT ADDRID, CUSTOMERID, ADDRTYPEID, ADDRTYPE_NAME, COUNTRYID,' +
        ' COUNTRY_NAME, CITYID, CITY_NAME, DISTRICTID, DISTRINCT_NAME, ST' +
        'REET, FULL_ADDRESS, COMMENTS FROM VW_TS_CUST_ADDR'
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
      'SELECT * FROM VW_TS_CUST_ADDR WHERE customerid=:CUSTOMERID')
    AutoCommit = False
    Active = True
    Left = 360
    Top = 224
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CUSTOMERID'
        Value = nil
      end>
  end
  object IBCDataSourceCustAddr: TIBCDataSource
    DataSet = IBCQueryCustAddr
    Left = 216
    Top = 224
  end
end
