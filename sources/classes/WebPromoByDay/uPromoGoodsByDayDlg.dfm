object frmPromoGoodsByDayDlg: TfrmPromoGoodsByDayDlg
  Left = 0
  Top = 0
  Caption = 'Produse promotioale web'
  ClientHeight = 508
  ClientWidth = 857
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object DialogTitle1: TDialogTitle
    Left = 0
    Top = 0
    Width = 857
    Height = 64
    Title = 'Produse promotionale'
    Text = 'Produsele la pret special pentru prima pagina de pe site'
    FontTitle.Charset = DEFAULT_CHARSET
    FontTitle.Color = clWindowText
    FontTitle.Height = -13
    FontTitle.Name = 'Segoe UI'
    FontTitle.Style = [fsBold]
    FontText.Charset = DEFAULT_CHARSET
    FontText.Color = clWindowText
    FontText.Height = -12
    FontText.Name = 'Segoe UI'
    FontText.Style = []
    ImageList = dmAdditions.cxImageList_DialogIcons
    ImageIndex = 30
  end
  object dxBarDockControl1: TdxBarDockControl
    Left = 0
    Top = 64
    Width = 857
    Height = 28
    Margins.Left = 7
    Margins.Top = 7
    Margins.Right = 7
    Margins.Bottom = 7
    Align = dalTop
    BarManager = dxBarManager1
  end
  object cxGrid2: TcxGrid
    Left = 8
    Top = 96
    Width = 841
    Height = 404
    TabOrder = 2
    object cxGrid2DBTableView1: TcxGridDBTableView
      DataController.DataSource = IBCDataSourcePGBD
      DataController.KeyFieldNames = 'UID'
      DataController.Summary.FooterSummaryItems = <
        item
          Kind = skCount
          Column = cxGrid2DBTableView1GOODSID
        end>
      OptionsBehavior.ImmediateEditor = False
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.Footer = True
      OptionsView.GroupByBox = False
      OptionsView.Indicator = True
      object cxGrid2DBTableView1UID: TcxGridDBColumn
        DataBinding.FieldName = 'UID'
        Visible = False
      end
      object cxGrid2DBTableView1DATA: TcxGridDBColumn
        Caption = 'data'
        DataBinding.FieldName = 'DATA'
        Width = 80
      end
      object cxGrid2DBTableView1GOODSID: TcxGridDBColumn
        Caption = 'cod'
        DataBinding.FieldName = 'GOODSID'
      end
      object cxGrid2DBTableView1GOODSNAME: TcxGridDBColumn
        Caption = 'produs'
        DataBinding.FieldName = 'GOODSNAME'
        Width = 476
      end
      object cxGrid2DBTableView1WEBGOODSTYPE_NAME: TcxGridDBColumn
        Caption = 'tip produs'
        DataBinding.FieldName = 'WEBGOODSTYPE_NAME'
        Width = 220
      end
    end
    object cxGrid2Level1: TcxGridLevel
      GridView = cxGrid2DBTableView1
    end
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
    UseSystemFont = True
    Left = 256
    Top = 264
    PixelsPerInch = 96
    object dxBarManager1Bar1: TdxBar
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' 1'
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 669
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarSubItem1'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbNewGoods'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'dxBarButton3'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarDateCombo1'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarSubItem1: TdxBarSubItem
      Caption = 'Window'
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbClose'
        end>
    end
    object bbClose: TdxBarButton
      Caption = 'Inchide'
      Category = 0
      Hint = 'Inchide'
      Visible = ivAlways
      ShortCut = 27
      OnClick = bbCloseClick
    end
    object bbNewGoods: TdxBarButton
      Caption = 'Produs nou'
      Category = 0
      Hint = 'Produs nou'
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 45
      OnClick = bbNewGoodsClick
    end
    object dxBarButton3: TdxBarButton
      Caption = 'Sterge produs'
      Category = 0
      Hint = 'Sterge produs'
      Visible = ivAlways
      ImageIndex = 42
      ShortCut = 16430
      OnClick = dxBarButton3Click
    end
    object dxBarDateCombo1: TdxBarDateCombo
      Caption = 'Data'
      Category = 0
      Hint = 'Data'
      Visible = ivAlways
      Glyph.SourceDPI = 96
      Glyph.Data = {
        424D360400000000000036000000280000001000000010000000010020000000
        000000000000C40E0000C40E00000000000000000000FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00000000FF000000FF000000FF000000FF000000FF000000FF0000
        00FF000000FF000000FF000000FF000000FFFF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF00FF00000000FF000000FF0000
        00FF000000FF000000FFFFFFFFFF000000FF000000FF000000FF000000FF0000
        00FF000000FF000000FFFFFFFFFF000000FFFF00FF00000000FFFFFFFFFFFFFF
        FFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF00FF00000000FFFFFFFFFF0000
        00FF000000FF000000FFFFFFFFFFFFFFFFFFFFFFFFFF000080FF000080FFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF00FF00000000FFFFFFFFFFFFFF
        FFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFF000080FF000080FFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF00FF00000000FFFFFFFFFFFFFF
        FFFF000080FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000080FF0000
        80FFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF00FF00000000FFFFFFFFFFFFFF
        FFFF000080FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000
        80FF000080FFFFFFFFFFFFFFFFFF000000FFFF00FF00000000FFFFFFFFFFFFFF
        FFFF000080FF000000FFFFFFFFFFFFFFFFFF000080FF000080FF000080FF0000
        80FF000080FFFFFFFFFFFFFFFFFF000000FFFF00FF00000000FFFFFFFFFFFFFF
        FFFF000080FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF00FF00000000FFFFFFFFFFFFFF
        FFFF000080FF000000FF800000FF800000FF800000FF800000FF800000FF8000
        00FF800000FF800000FF800000FF000000FFFF00FF00000000FFFFFFFFFFFFFF
        FFFFFFFFFFFF000000FF800000FF800000FF800000FF800000FF800000FF8000
        00FF800000FF800000FF800000FF000000FFFF00FF00000000FF800000FF8000
        00FF800000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
        00FF000000FF000000FF000000FF000000FFFF00FF00000000FF800000FF8000
        00FF800000FF800000FF800000FF800000FF800000FF800000FF800000FF0000
        00FFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00000000FF000000FF0000
        00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
        00FFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      ShowCaption = True
    end
  end
  object IBCQueryPGBD: TIBCQuery
    KeyFields = 'UID'
    KeyGenerator = 'GEN_TWEB_PROMO_GOODS_BY_DAY_ID'
    SQLInsert.Strings = (
      'INSERT INTO VW_TWEB_PROMO_GOODS_BY_DAY'
      
        '  (UID, DATA, GOODSID, PARENTID, WEBGOODSTYPE_ID, WEBGOODSTYPE_N' +
        'AME, GOODSNAME)'
      'VALUES'
      
        '  (:UID, :DATA, :GOODSID, :PARENTID, :WEBGOODSTYPE_ID, :WEBGOODS' +
        'TYPE_NAME, :GOODSNAME)')
    SQLDelete.Strings = (
      'DELETE FROM VW_TWEB_PROMO_GOODS_BY_DAY'
      'WHERE'
      '  UID = :Old_UID')
    SQLUpdate.Strings = (
      'UPDATE VW_TWEB_PROMO_GOODS_BY_DAY'
      'SET'
      
        '  UID = :UID, DATA = :DATA, GOODSID = :GOODSID, PARENTID = :PARE' +
        'NTID, WEBGOODSTYPE_ID = :WEBGOODSTYPE_ID, WEBGOODSTYPE_NAME = :W' +
        'EBGOODSTYPE_NAME, GOODSNAME = :GOODSNAME'
      'WHERE'
      '  UID = :Old_UID')
    SQLRefresh.Strings = (
      
        'SELECT UID, DATA, GOODSID, PARENTID, WEBGOODSTYPE_ID, WEBGOODSTY' +
        'PE_NAME, GOODSNAME FROM VW_TWEB_PROMO_GOODS_BY_DAY'
      'WHERE'
      '  UID = :UID')
    SQLLock.Strings = (
      'SELECT NULL FROM VW_TWEB_PROMO_GOODS_BY_DAY'
      'WHERE'
      'UID = :Old_UID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM VW_TWEB_PROMO_GOODS_BY_DAY'
      ''
      ') q')
    UpdateTransaction = IBCTrUpdate
    SQL.Strings = (
      'select * from '
      'VW_TWEB_DAILY_DEALS'
      'ORDER BY DEAL_DATE')
    Left = 360
    Top = 208
  end
  object IBCDataSourcePGBD: TIBCDataSource
    DataSet = IBCQueryPGBD
    Left = 256
    Top = 208
  end
  object IBCTrUpdate: TIBCTransaction
    Left = 472
    Top = 208
  end
end
