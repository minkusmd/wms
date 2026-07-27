object frmWebGoodsGroupsDlg: TfrmWebGoodsGroupsDlg
  Left = 0
  Top = 0
  Caption = 'Grupe pentru prima pagina'
  ClientHeight = 604
  ClientWidth = 939
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
    Width = 939
    Height = 64
    Title = 'Grupe pentru pagina web principala'
    Text = 'Lista de grupe pentru afisare pe prima pagina a site-ului'
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
    Width = 939
    Height = 28
    Align = dalTop
    BarManager = dxBarManager1
  end
  object Panel1: TPanel
    Left = 0
    Top = 563
    Width = 939
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    DesignSize = (
      939
      41)
    object lbInfo: TLabel
      Left = 8
      Top = 16
      Width = 31
      Height = 15
      Caption = 'lbInfo'
    end
    object btnCancel: TButton
      Left = 838
      Top = 6
      Width = 90
      Height = 29
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = 'Inchide'
      ModalResult = 2
      TabOrder = 1
    end
    object btnSelect: TButton
      Left = 728
      Top = 6
      Width = 90
      Height = 29
      Caption = 'Selecteaza'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
  end
  object cxGrid1: TcxGrid
    Left = 0
    Top = 92
    Width = 939
    Height = 471
    Align = alClient
    TabOrder = 3
    object cxGrid1DBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      ScrollbarAnnotations.CustomAnnotations = <>
      DataController.DataSource = IBCDataSourceGroups
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
      OptionsSelection.InvertSelect = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      OptionsView.Indicator = True
      Styles.OnGetContentStyle = cxGrid1DBTableView1StylesGetContentStyle
      object cxGrid1DBTableView_GGID: TcxGridDBColumn
        Caption = 'Cod'
        DataBinding.FieldName = 'GGID'
        DataBinding.IsNullValueType = True
        HeaderAlignmentHorz = taCenter
        MinWidth = 49
        Options.HorzSizing = False
        Width = 49
      end
      object cxGrid1DBTableView_Data1: TcxGridDBColumn
        Caption = 'Data inceput'
        DataBinding.FieldName = 'DATA1'
        DataBinding.IsNullValueType = True
        PropertiesClassName = 'TcxDateEditProperties'
        HeaderAlignmentHorz = taCenter
        MinWidth = 80
        Options.HorzSizing = False
        Width = 80
      end
      object cxGrid1DBTableView_Data2: TcxGridDBColumn
        Caption = 'Data sfirsit'
        DataBinding.FieldName = 'DATA2'
        DataBinding.IsNullValueType = True
        PropertiesClassName = 'TcxDateEditProperties'
        HeaderAlignmentHorz = taCenter
        MinWidth = 80
        Options.HorzSizing = False
        Width = 80
      end
      object cxGrid1DBTableView1_TITLE_RO: TcxGridDBColumn
        Caption = 'Denumire'
        DataBinding.FieldName = 'TITLE_RO'
        DataBinding.IsNullValueType = True
        HeaderAlignmentHorz = taCenter
        Width = 359
      end
      object cxGrid1DBTableView1_TITLE_RU: TcxGridDBColumn
        Caption = #1053#1072#1079#1074#1072#1085#1080#1077
        DataBinding.FieldName = 'TITLE_RU'
        DataBinding.IsNullValueType = True
        Width = 310
      end
      object cxGrid1DBTableView_CNT: TcxGridDBColumn
        Caption = 'Cant'
        DataBinding.FieldName = 'CNT'
        DataBinding.IsNullValueType = True
        HeaderAlignmentHorz = taCenter
        Width = 47
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
    ImageOptions.Images = dmAdditions.cxImageList_SWN
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 200
    Top = 144
    PixelsPerInch = 96
    object dxBarManager1Bar1: TdxBar
      Caption = 'Toolbar1'
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
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbNew'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbGroupModify'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbGroupDelete'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'dxBarButton2'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'dxBarButton1'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object bbNew: TdxBarButton
      Caption = 'Adauga'
      Category = 0
      Hint = 'Adauga'
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 45
      OnClick = bbNewClick
    end
    object bbGroupModify: TdxBarButton
      Caption = 'Modifica'
      Category = 0
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 115
      OnClick = bbGroupModifyClick
    end
    object bbGroupDelete: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      ShortCut = 16430
      OnClick = bbGroupDeleteClick
    end
    object dxBarButton1: TdxBarButton
      Caption = 'Sortare'
      Category = 0
      Hint = 'Sortare'
      Visible = ivAlways
      ImageIndex = 38
      OnClick = dxBarButton1Click
    end
    object dxBarButton2: TdxBarButton
      Caption = 'Refresh'
      Category = 0
      Hint = 'Refresh'
      Visible = ivAlways
      ImageIndex = 36
      OnClick = dxBarButton2Click
    end
  end
  object IBCDataSourceGroups: TIBCDataSource
    DataSet = IBCQueryGroups
    Left = 136
    Top = 192
  end
  object IBCQueryGroups: TIBCQuery
    KeyFields = 'GGID'
    KeyGenerator = 'gen_tweb_fp_groups_id'
    GeneratorMode = gmInsert
    SQLInsert.Strings = (
      'INSERT INTO TWEB_FP_GROUPS'
      '  (GGID, DATA1, DATA2, TITLE_RO, TITLE_RU, ORDERNO)'
      'VALUES'
      '  (:GGID, :DATA1, :DATA2, :TITLE_RO, :TITLE_RU, :ORDERNO)')
    SQLDelete.Strings = (
      'DELETE FROM TWEB_FP_GROUPS'
      'WHERE'
      '  GGID = :Old_GGID')
    SQLUpdate.Strings = (
      'UPDATE TWEB_FP_GROUPS'
      'SET'
      
        '  GGID = :GGID, DATA1 = :DATA1, DATA2 = :DATA2, TITLE_RO = :TITL' +
        'E_RO, TITLE_RU = :TITLE_RU, ORDERNO = :ORDERNO'
      'WHERE'
      '  GGID = :Old_GGID')
    SQLRefresh.Strings = (
      'SELECT GGID, DATA1, DATA2, TITLE_RO, TITLE_RU, ORDERNO,'
      
        '(select count(*) from tweb_fp_groups_goods gg where gg.ggid=g.gg' +
        'id) cnt '
      'FROM TWEB_FP_GROUPS'
      'WHERE'
      '  GGID = :GGID')
    SQLLock.Strings = (
      'SELECT NULL FROM TWEB_FP_GROUPS'
      'WHERE'
      'GGID = :Old_GGID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM TWEB_FP_GROUPS'
      ''
      ') q')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = IBCTrUpdate
    SQL.Strings = (
      'SELECT g.*, '
      
        '(select count(*) from tweb_fp_groups_goods gg where gg.ggid=g.gg' +
        'id) cnt '
      ''
      'FROM TWEB_FP_GROUPS g'
      
        '--WHERE CURRENT_DATE BETWEEN CAST(DATA1 AS DATE) AND CAST(DATA2 ' +
        'AS DATE)'
      'ORDER BY orderno')
    Options.RequiredFields = False
    Options.DefaultValues = True
    LocalConstraints = False
    Left = 257
    Top = 192
  end
  object IBCTrUpdate: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 392
    Top = 192
  end
end
