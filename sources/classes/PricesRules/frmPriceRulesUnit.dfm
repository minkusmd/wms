object frmPricesRulesDlg: TfrmPricesRulesDlg
  Left = 0
  Top = 0
  Caption = 'Politica de creare a preturilor'
  ClientHeight = 388
  ClientWidth = 656
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    656
    388)
  PixelsPerInch = 96
  TextHeight = 15
  object cxGrid1: TcxGrid
    AlignWithMargins = True
    Left = 0
    Top = 32
    Width = 656
    Height = 313
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 2
    object cxGrid1DBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = IBCDataSourcePriceRules
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.IncSearch = True
      OptionsBehavior.ImmediateEditor = False
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      OptionsView.Indicator = True
      object cxGrid1DBTableView1Column1: TcxGridDBColumn
        Caption = 'GP'
        DataBinding.FieldName = 'PRICECOLUMN'
        HeaderAlignmentHorz = taCenter
      end
      object cxGrid1DBTableView1Column2: TcxGridDBColumn
        Caption = 'Min'
        DataBinding.FieldName = 'MIN_VALUE'
        HeaderAlignmentHorz = taCenter
      end
      object cxGrid1DBTableView1Column3: TcxGridDBColumn
        Caption = 'Max'
        DataBinding.FieldName = 'MAX_VALUE'
        HeaderAlignmentHorz = taCenter
      end
      object cxGrid1DBTableView1Column4: TcxGridDBColumn
        Caption = 'Formula'
        DataBinding.FieldName = 'FORMULA'
        HeaderAlignmentHorz = taCenter
        Width = 425
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
    end
  end
  object cxButton1: TcxButton
    Left = 549
    Top = 356
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Inchide'
    ModalResult = 1
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
    Left = 312
    Top = 192
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
      Caption = 'Main'
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 0
      DockedTop = 0
      DockingStyle = dsTop
      FloatLeft = 274
      FloatTop = 126
      FloatClientWidth = 75
      FloatClientHeight = 106
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbClone'
        end
        item
          BeginGroup = True
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
    object bbDelete: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 92
      ShortCut = 16430
      OnClick = bbDeleteClick
    end
    object bbClone: TdxBarButton
      Caption = 'Import'
      Category = 0
      Hint = 'Import'
      Visible = ivAlways
      ImageIndex = 73
      ShortCut = 16457
      OnClick = bbCloneClick
    end
  end
  object IBCQueryPriceRules: TIBCQuery
    SQLInsert.Strings = (
      'INSERT INTO TPRICE_GOODSTYPE'
      '  (PGT_ID, PRICECOLUMN, MIN_VALUE, MAX_VALUE, FORMULA)'
      'VALUES'
      '  (:PGT_ID, :PRICECOLUMN, :MIN_VALUE, :MAX_VALUE, :FORMULA)')
    SQLDelete.Strings = (
      'DELETE FROM TPRICE_GOODSTYPE'
      'WHERE'
      
        '  PGT_ID = :Old_PGT_ID AND PRICECOLUMN = :Old_PRICECOLUMN AND MI' +
        'N_VALUE = :Old_MIN_VALUE')
    SQLUpdate.Strings = (
      'UPDATE TPRICE_GOODSTYPE'
      'SET'
      
        '  PGT_ID = :PGT_ID, PRICECOLUMN = :PRICECOLUMN, MIN_VALUE = :MIN' +
        '_VALUE, MAX_VALUE = :MAX_VALUE, FORMULA = :FORMULA'
      'WHERE'
      
        '  PGT_ID = :Old_PGT_ID AND PRICECOLUMN = :Old_PRICECOLUMN AND MI' +
        'N_VALUE = :Old_MIN_VALUE')
    SQLRefresh.Strings = (
      
        'SELECT PGT_ID, PRICECOLUMN, MIN_VALUE, MAX_VALUE, FORMULA FROM T' +
        'PRICE_GOODSTYPE'
      'WHERE'
      
        '  PGT_ID = :PGT_ID AND PRICECOLUMN = :PRICECOLUMN AND MIN_VALUE ' +
        '= :MIN_VALUE')
    SQLLock.Strings = (
      'SELECT NULL FROM TPRICE_GOODSTYPE'
      'WHERE'
      
        'PGT_ID = :Old_PGT_ID AND PRICECOLUMN = :Old_PRICECOLUMN AND MIN_' +
        'VALUE = :Old_MIN_VALUE'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM TPRICE_GOODSTYPE'
      ''
      ') q')
    UpdateTransaction = IBCTrLocalUpdate
    SQL.Strings = (
      'select * from tprice_GOODSTYPE'
      'where pgt_id=:pgt_id'
      'order by pricecolumn, min_value')
    Constraints = <>
    Left = 216
    Top = 152
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'pgt_id'
        Value = nil
      end>
  end
  object IBCDataSourcePriceRules: TIBCDataSource
    DataSet = IBCQueryPriceRules
    Left = 144
    Top = 152
  end
  object IBCTrLocalUpdate: TIBCTransaction
    Left = 328
    Top = 120
  end
end
