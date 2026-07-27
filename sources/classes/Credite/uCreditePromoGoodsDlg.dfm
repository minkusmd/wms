object frmCreditePromoGoodsDlg: TfrmCreditePromoGoodsDlg
  Left = 0
  Top = 0
  Caption = 'Promotiile pentru produse in credit'
  ClientHeight = 512
  ClientWidth = 678
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  DesignSize = (
    678
    512)
  TextHeight = 15
  object cxGrid1: TcxGrid
    Left = 8
    Top = 32
    Width = 662
    Height = 472
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 3
    object cxGridGoodsTable: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      ScrollbarAnnotations.CustomAnnotations = <>
      DataController.DataSource = IBCDataSourceCreditPromoGoods
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.IncSearch = True
      OptionsBehavior.ImmediateEditor = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.HideFocusRectOnExit = False
      OptionsSelection.InvertSelect = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      object cxGridGoodsTableGOODSID: TcxGridDBColumn
        Caption = 'Cod'
        DataBinding.FieldName = 'GOODSID'
        HeaderAlignmentHorz = taCenter
      end
      object cxGridGoodsTableGOODSNAME: TcxGridDBColumn
        Caption = 'Denumire'
        DataBinding.FieldName = 'GOODSNAME'
        HeaderAlignmentHorz = taCenter
        Width = 331
      end
      object cxGridGoodsTableDATA1: TcxGridDBColumn
        Caption = 'Start'
        DataBinding.FieldName = 'DATA1'
        HeaderAlignmentHorz = taCenter
        Width = 98
      end
      object cxGridGoodsTableDATA2: TcxGridDBColumn
        Caption = 'Finis'
        DataBinding.FieldName = 'DATA2'
        HeaderAlignmentHorz = taCenter
        Width = 89
      end
      object cxGridGoodsTablePREPAY_AMOUNT: TcxGridDBColumn
        Caption = 'Avans'
        DataBinding.FieldName = 'PREPAY_AMOUNT'
        HeaderAlignmentHorz = taCenter
        Width = 64
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGridGoodsTable
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
    Left = 120
    Top = 96
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
      FloatLeft = 712
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
      ImageIndex = 40
      PaintStyle = psCaptionGlyph
      ShortCut = 45
      OnClick = bbNewClick
    end
    object bbEdit: TdxBarButton
      Caption = 'Modifica'
      Category = 0
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 41
      PaintStyle = psCaptionGlyph
      ShortCut = 115
      OnClick = bbEditClick
    end
    object bbDelete: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      PaintStyle = psCaptionGlyph
      ShortCut = 16430
      OnClick = bbDeleteClick
    end
    object dxBarSubItem1: TdxBarSubItem
      Caption = 'Window'
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarButton5'
        end>
    end
    object dxBarButton5: TdxBarButton
      Caption = 'Inchide'
      Category = 0
      Hint = 'Inchide'
      Visible = ivAlways
      ShortCut = 27
      OnClick = dxBarButton5Click
    end
  end
  object IBCQueryCreditPromoGoods: TIBCQuery
    KeyFields = 'uid;goodsid'
    SQLInsert.Strings = (
      'INSERT INTO VW_MK_CREDIT_GOODS'
      '  (UID, GOODSID, GOODSNAME, DATA1, DATA2, PREPAY_AMOUNT)'
      'VALUES'
      '  (:UID, :GOODSID, :GOODSNAME, :DATA1, :DATA2, :PREPAY_AMOUNT)')
    SQLDelete.Strings = (
      'DELETE FROM VW_MK_CREDIT_GOODS'
      'WHERE'
      '  UID = :Old_UID AND GOODSID = :Old_GOODSID')
    SQLUpdate.Strings = (
      'UPDATE VW_MK_CREDIT_GOODS'
      'SET'
      
        '  UID = :UID, GOODSID = :GOODSID, GOODSNAME = :GOODSNAME, DATA1 ' +
        '= :DATA1, DATA2 = :DATA2, PREPAY_AMOUNT = :PREPAY_AMOUNT'
      'WHERE'
      '  UID = :Old_UID AND GOODSID = :Old_GOODSID')
    SQLRefresh.Strings = (
      
        'SELECT UID, GOODSID, GOODSNAME, DATA1, DATA2, PREPAY_AMOUNT FROM' +
        ' VW_MK_CREDIT_GOODS'
      'WHERE'
      '  UID = :UID AND GOODSID = :GOODSID')
    SQLLock.Strings = (
      'SELECT NULL FROM VW_MK_CREDIT_GOODS'
      'WHERE'
      'UID = :Old_UID AND GOODSID = :Old_GOODSID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM VW_MK_CREDIT_GOODS'
      ''
      ') q')
    UpdateTransaction = IBCTrUpdate
    SQL.Strings = (
      'select * from VW_MK_CREDIT_GOODS'
      'where uid=:uid')
    Active = True
    Left = 448
    Top = 168
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'uid'
        Value = nil
      end>
  end
  object IBCDataSourceCreditPromoGoods: TIBCDataSource
    DataSet = IBCQueryCreditPromoGoods
    Left = 264
    Top = 224
  end
  object IBCTrUpdate: TIBCTransaction
    Left = 536
    Top = 168
  end
end
