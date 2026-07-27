object frmCrediteDlg: TfrmCrediteDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Credite'
  ClientHeight = 346
  ClientWidth = 855
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  DesignSize = (
    855
    346)
  PixelsPerInch = 96
  TextHeight = 15
  object cxGrid1: TcxGrid
    Left = 8
    Top = 32
    Width = 840
    Height = 306
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 3
    object cxGrid1DBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      ScrollbarAnnotations.CustomAnnotations = <>
      DataController.DataSource = IBCDataSourceCredite
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
      OptionsSelection.HideFocusRectOnExit = False
      OptionsSelection.InvertSelect = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      object cxGrid1DBTableView1_FLG_ACTIVE: TcxGridDBColumn
        Caption = 'A'
        DataBinding.FieldName = 'FLG_ACTIVE'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = '1'
        Properties.ValueUnchecked = '0'
        HeaderAlignmentHorz = taCenter
        Width = 24
      end
      object cxGrid1DBTableView1UID: TcxGridDBColumn
        Caption = 'Cod'
        DataBinding.FieldName = 'UID'
        HeaderAlignmentHorz = taCenter
        Width = 36
      end
      object cxGrid1DBTableView1Column1: TcxGridDBColumn
        Caption = 'OM'
        DataBinding.FieldName = 'COMAPNY_NAME'
        HeaderAlignmentHorz = taCenter
        Width = 120
      end
      object cxGrid1DBTableView1TITLE: TcxGridDBColumn
        Caption = 'Denumire'
        DataBinding.FieldName = 'TITLE'
        HeaderAlignmentHorz = taCenter
        Width = 200
      end
      object cxGrid1DBTableView1MIN_AMOUNT: TcxGridDBColumn
        Caption = 'Suma, Min'
        DataBinding.FieldName = 'MIN_AMOUNT'
        HeaderAlignmentHorz = taCenter
        Width = 80
      end
      object cxGrid1DBTableView1MAX_AMOUNT: TcxGridDBColumn
        Caption = 'Suma, Max'
        DataBinding.FieldName = 'MAX_AMOUNT'
        HeaderAlignmentHorz = taCenter
        Width = 80
      end
      object cxGrid1DBTableView1PERCENT: TcxGridDBColumn
        Caption = 'Dobinda'
        DataBinding.FieldName = 'PERCENT'
        HeaderAlignmentHorz = taCenter
        Width = 80
      end
      object cxGrid1DBTableView1BUYER_COMISION: TcxGridDBColumn
        Caption = 'Comision lunar'
        DataBinding.FieldName = 'BUYER_COMISION'
        HeaderAlignmentHorz = taCenter
        Width = 93
      end
      object cxGrid1DBTableView1MIN_MONTH: TcxGridDBColumn
        Caption = 'Luni, Min'
        DataBinding.FieldName = 'MIN_MONTH'
        HeaderAlignmentHorz = taCenter
      end
      object cxGrid1DBTableView1MAX_MONTH: TcxGridDBColumn
        Caption = 'Luni, Max'
        DataBinding.FieldName = 'MAX_MONTH'
        HeaderAlignmentHorz = taCenter
        Width = 93
      end
      object cxGrid1DBTableView1PREPAY_PERCENT: TcxGridDBColumn
        Caption = 'Avans, %'
        DataBinding.FieldName = 'PREPAY_PERCENT'
        HeaderAlignmentHorz = taCenter
        Width = 60
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
      #1055#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102)
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    ImageOptions.Images = dmAdditions.cxImageList_SWN
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 264
    Top = 64
    PixelsPerInch = 96
    DockControlHeights = (
      0
      0
      28
      0)
    object dxBarManager1Bar1: TdxBar
      Caption = 'MainTB'
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
          Visible = True
          ItemName = 'dxBarButton1'
        end
        item
          Visible = True
          ItemName = 'dxBarButton2'
        end
        item
          Visible = True
          ItemName = 'dxBarButton3'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton4'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarButton1: TdxBarButton
      Caption = 'Nou'
      Category = 0
      Hint = 'Nou'
      Visible = ivAlways
      ImageIndex = 40
      PaintStyle = psCaptionGlyph
      ShortCut = 45
      OnClick = dxBarButton1Click
    end
    object dxBarButton2: TdxBarButton
      Caption = 'Modifica'
      Category = 0
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 41
      PaintStyle = psCaptionGlyph
      ShortCut = 115
      OnClick = dxBarButton2Click
    end
    object dxBarButton3: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      PaintStyle = psCaptionGlyph
      ShortCut = 16430
      OnClick = dxBarButton3Click
    end
    object dxBarButton4: TdxBarButton
      Caption = 'Produsele in promotii'
      Category = 0
      Hint = 'Produsele in promotii'
      Visible = ivAlways
      ImageIndex = 12
      PaintStyle = psCaptionGlyph
      ShortCut = 118
      OnClick = dxBarButton4Click
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
  object IBCQueryCredite: TIBCQuery
    KeyFields = 'UID'
    KeyGenerator = 'gen_ts_finance_customer_id'
    SQLInsert.Strings = (
      'INSERT INTO VW_TS_FINANCE_CUSTOMER'
      
        '  (UID, TITLE, MIN_AMOUNT, MAX_AMOUNT, PERCENT, BUYER_COMISION, ' +
        'MIN_MONTH, MAX_MONTH, PREPAY_PERCENT, FLG_ACTIVE, CUSTOMERID, CU' +
        'STOMER_NAME)'
      'VALUES'
      
        '  (:UID, :TITLE, :MIN_AMOUNT, :MAX_AMOUNT, :PERCENT, :BUYER_COMI' +
        'SION, :MIN_MONTH, :MAX_MONTH, :PREPAY_PERCENT, :FLG_ACTIVE, :CUS' +
        'TOMERID, :CUSTOMER_NAME)')
    SQLDelete.Strings = (
      'DELETE FROM VW_TS_FINANCE_CUSTOMER'
      'WHERE'
      '  UID = :Old_UID')
    SQLUpdate.Strings = (
      'UPDATE VW_TS_FINANCE_CUSTOMER'
      'SET'
      
        '  UID = :UID, TITLE = :TITLE, MIN_AMOUNT = :MIN_AMOUNT, MAX_AMOU' +
        'NT = :MAX_AMOUNT, PERCENT = :PERCENT, BUYER_COMISION = :BUYER_CO' +
        'MISION, MIN_MONTH = :MIN_MONTH, MAX_MONTH = :MAX_MONTH, PREPAY_P' +
        'ERCENT = :PREPAY_PERCENT, FLG_ACTIVE = :FLG_ACTIVE, CUSTOMERID =' +
        ' :CUSTOMERID, CUSTOMER_NAME = :CUSTOMER_NAME'
      'WHERE'
      '  UID = :Old_UID')
    SQLRefresh.Strings = (
      
        'SELECT UID, TITLE, MIN_AMOUNT, MAX_AMOUNT, PERCENT, BUYER_COMISI' +
        'ON, MIN_MONTH, MAX_MONTH, PREPAY_PERCENT, FLG_ACTIVE, CUSTOMERID' +
        ', CUSTOMER_NAME FROM VW_TS_FINANCE_CUSTOMER'
      'WHERE'
      '  UID = :UID')
    SQLLock.Strings = (
      'SELECT NULL FROM TS_FINANCE_CUSTOMER'
      'WHERE'
      'UID = :Old_UID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM VW_TS_FINANCE_CUSTOMER'
      ''
      ') q')
    UpdateTransaction = IBCTrUpdate
    SQL.Strings = (
      'select'
      
        '    fc.uid, fc.title, fc.min_amount, fc.max_amount, fc.percent, ' +
        'fc.buyer_comision, fc.min_month,'
      
        '    fc.max_month, fc.prepay_percent, fc.flg_active, customerid, ' +
        'customer_name'
      'from vw_ts_finance_customer fc  ')
    Options.RequiredFields = False
    LocalConstraints = False
    Left = 336
    Top = 112
  end
  object IBCDataSourceCredite: TIBCDataSource
    DataSet = IBCQueryCredite
    Left = 200
    Top = 112
  end
  object IBCTrUpdate: TIBCTransaction
    Left = 456
    Top = 112
  end
end
