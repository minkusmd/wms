object frmPricesTypesDlg: TfrmPricesTypesDlg
  Left = 0
  Top = 0
  Caption = 'Tipuri de preturi'
  ClientHeight = 453
  ClientWidth = 884
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    884
    453)
  PixelsPerInch = 96
  TextHeight = 15
  object cxGrid1: TcxGrid
    Left = 8
    Top = 32
    Width = 868
    Height = 374
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelInner = bvNone
    TabOrder = 2
    object cxGrid1DBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      ScrollbarAnnotations.CustomAnnotations = <>
      DataController.DataSource = IBCDataSourcePricesTypes
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsView.GroupByBox = False
      object cxGrid1DBTableView1ID: TcxGridDBColumn
        Caption = 'Cod'
        DataBinding.FieldName = 'ID'
      end
      object cxGrid1DBTableView1CURRENCY_NAME: TcxGridDBColumn
        Caption = 'Valuta'
        DataBinding.FieldName = 'CURRENCY_NAME'
        Width = 39
      end
      object cxGrid1DBTableView1NAME: TcxGridDBColumn
        Caption = 'Denumire'
        DataBinding.FieldName = 'NAME'
        Width = 169
      end
      object cxGrid1DBTableView1PRICE_TYPE_NAME: TcxGridDBColumn
        Caption = 'Tip de pret'
        DataBinding.FieldName = 'PRICE_TYPE_NAME'
        Width = 100
      end
      object cxGrid1DBTableView1BASIC_PRICE_TYPE_NAME: TcxGridDBColumn
        Caption = 'Pret de baza'
        DataBinding.FieldName = 'BASIC_PRICE_TYPE_NAME'
        Width = 100
      end
      object cxGrid1DBTableView1VAT: TcxGridDBColumn
        Caption = 'TVA'
        DataBinding.FieldName = 'VAT'
        Width = 46
      end
      object cxGrid1DBTableView1PRICEING_METHOD_NAME: TcxGridDBColumn
        Caption = 'Metoda de calcul'
        DataBinding.FieldName = 'PRICEING_METHOD_NAME'
        Width = 100
      end
      object cxGrid1DBTableView1MARGIN: TcxGridDBColumn
        Caption = 'Adaos'
        DataBinding.FieldName = 'MARGIN'
      end
      object cxGrid1DBTableView1ROUNDING: TcxGridDBColumn
        Caption = 'Rotungine'
        DataBinding.FieldName = 'ROUNDING'
      end
      object cxGrid1DBTableView1ROUNDING_METHOD_NAME: TcxGridDBColumn
        Caption = 'Metoda de rotungire'
        DataBinding.FieldName = 'ROUNDING_METHOD_NAME'
        Width = 100
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
    end
  end
  object cxButton1: TcxButton
    Left = 784
    Top = 420
    Width = 75
    Height = 25
    Caption = 'Inchide'
    Default = True
    ModalResult = 8
    TabOrder = 4
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
    Left = 336
    Top = 168
    PixelsPerInch = 96
    DockControlHeights = (
      0
      0
      28
      0)
    object dxBarManager1Bar1: TdxBar
      Caption = 'Toolbar1'
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 0
      DockedTop = 0
      DockingStyle = dsTop
      FloatLeft = 712
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
      ImageIndex = 90
      PaintStyle = psCaptionGlyph
      ShortCut = 45
      OnClick = bbNewClick
    end
    object bbEdit: TdxBarButton
      Caption = 'Modifica'
      Category = 0
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 91
      PaintStyle = psCaptionGlyph
      ShortCut = 115
    end
    object bbDelete: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 92
      PaintStyle = psCaptionGlyph
      ShortCut = 16430
    end
  end
  object IBCQueryPricesTypes: TIBCQuery
    KeyFields = 'ID'
    KeyGenerator = 'GEN_TS_PRICES_TYPES_ID'
    SQLInsert.Strings = (
      'INSERT INTO VW_TS_PRICES_TYPES'
      
        '  (ID, CURRENCYID, CURRENCY_NAME, NAME, PRICE_TYPE, PRICE_TYPE_N' +
        'AME, BASIC_PRICE_TYPE, BASIC_PRICE_TYPE_NAME, VAT, PRICEING_METH' +
        'OD, PRICEING_METHOD_NAME, MARGIN, ROUNDING, ROUNDING_METHOD, ROU' +
        'NDING_METHOD_NAME)'
      'VALUES'
      
        '  (:ID, :CURRENCYID, :CURRENCY_NAME, :NAME, :PRICE_TYPE, :PRICE_' +
        'TYPE_NAME, :BASIC_PRICE_TYPE, :BASIC_PRICE_TYPE_NAME, :VAT, :PRI' +
        'CEING_METHOD, :PRICEING_METHOD_NAME, :MARGIN, :ROUNDING, :ROUNDI' +
        'NG_METHOD, :ROUNDING_METHOD_NAME)')
    SQLDelete.Strings = (
      'DELETE FROM VW_TS_PRICES_TYPES'
      'WHERE'
      '  ID = :Old_ID')
    SQLUpdate.Strings = (
      'UPDATE VW_TS_PRICES_TYPES'
      'SET'
      
        '  ID = :ID, CURRENCYID = :CURRENCYID, CURRENCY_NAME = :CURRENCY_' +
        'NAME, NAME = :NAME, PRICE_TYPE = :PRICE_TYPE, PRICE_TYPE_NAME = ' +
        ':PRICE_TYPE_NAME, BASIC_PRICE_TYPE = :BASIC_PRICE_TYPE, BASIC_PR' +
        'ICE_TYPE_NAME = :BASIC_PRICE_TYPE_NAME, VAT = :VAT, PRICEING_MET' +
        'HOD = :PRICEING_METHOD, PRICEING_METHOD_NAME = :PRICEING_METHOD_' +
        'NAME, MARGIN = :MARGIN, ROUNDING = :ROUNDING, ROUNDING_METHOD = ' +
        ':ROUNDING_METHOD, ROUNDING_METHOD_NAME = :ROUNDING_METHOD_NAME'
      'WHERE'
      '  ID = :Old_ID')
    SQLRefresh.Strings = (
      
        'SELECT ID, CURRENCYID, CURRENCY_NAME, NAME, PRICE_TYPE, PRICE_TY' +
        'PE_NAME, BASIC_PRICE_TYPE, BASIC_PRICE_TYPE_NAME, VAT, PRICEING_' +
        'METHOD, PRICEING_METHOD_NAME, MARGIN, ROUNDING, ROUNDING_METHOD,' +
        ' ROUNDING_METHOD_NAME FROM VW_TS_PRICES_TYPES'
      'WHERE'
      '  ID = :ID')
    SQLLock.Strings = (
      'SELECT NULL FROM VW_TS_PRICES_TYPES'
      'WHERE'
      'ID = :Old_ID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM VW_TS_PRICES_TYPES'
      ''
      ') q')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'SELECT ID,'
      'CURRENCYID,'
      'CURRENCY_NAME,'
      'NAME,'
      'PRICE_TYPE,'
      'PRICE_TYPE_NAME,'
      'BASIC_PRICE_TYPE,'
      'BASIC_PRICE_TYPE_NAME,'
      'VAT,'
      'PRICEING_METHOD,'
      'PRICEING_METHOD_NAME,'
      'MARGIN,'
      'ROUNDING,'
      'ROUNDING_METHOD,'
      'ROUNDING_METHOD_NAME '
      'FROM VW_TS_PRICES_TYPES'
      'ORDER BY ID')
    Left = 336
    Top = 232
  end
  object IBCDataSourcePricesTypes: TIBCDataSource
    DataSet = IBCQueryPricesTypes
    Left = 184
    Top = 232
  end
end
