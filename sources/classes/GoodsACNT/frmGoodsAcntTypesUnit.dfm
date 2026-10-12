object frmGoodsAcntTypesDlg: TfrmGoodsAcntTypesDlg
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Denumiri contabile pe tipuri de produs'
  ClientHeight = 680
  ClientWidth = 1280
  Color = clBtnFace
  Constraints.MinHeight = 500
  Constraints.MinWidth = 1000
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 15
  object splTypes: TSplitter
    Left = 330
    Top = 44
    Height = 592
  end
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 1280
    Height = 44
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object lbSearch: TcxLabel
      Left = 8
      Top = 12
      Caption = 'Cauta in toate tipurile:'
    end
    object edSearch: TcxTextEdit
      Left = 150
      Top = 10
      TabOrder = 1
      OnKeyDown = edSearchKeyDown
      Width = 300
    end
    object btnSearch: TButton
      Left = 456
      Top = 9
      Width = 80
      Height = 25
      Caption = 'Cauta'
      TabOrder = 2
      OnClick = btnSearchClick
    end
    object btnShowType: TButton
      Left = 542
      Top = 9
      Width = 110
      Height = 25
      Caption = 'Inapoi la tip'
      Enabled = False
      TabOrder = 3
      OnClick = btnShowTypeClick
    end
    object cbSearchGoods: TcxCheckBox
      Left = 664
      Top = 10
      Caption = 'Cauta si in denumirile produselor'
      TabOrder = 4
    end
    object cbAllTypes: TcxCheckBox
      Left = 900
      Top = 10
      Caption = 'Arata si tipurile fara denumiri'
      Properties.OnChange = cbAllTypesPropertiesChange
      TabOrder = 5
    end
  end
  object pnlTypes: TPanel
    Left = 0
    Top = 44
    Width = 330
    Height = 592
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 1
    object cxGridTypes: TcxGrid
      Left = 0
      Top = 0
      Width = 330
      Height = 592
      Align = alClient
      TabOrder = 0
      object tvTypes: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        FindPanel.DisplayMode = fpdmAlways
        ScrollbarAnnotations.CustomAnnotations = <>
        DataController.DataSource = dsTypes
        DataController.KeyFieldNames = 'GOODSTYPEID'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsView.ColumnAutoWidth = True
        OptionsView.GroupByBox = False
        object tvTypesTITLE: TcxGridDBColumn
          Caption = 'Tipul produsului'
          DataBinding.FieldName = 'TITLE'
          HeaderAlignmentHorz = taCenter
          Width = 250
        end
        object tvTypesN: TcxGridDBColumn
          Caption = 'Denumiri'
          DataBinding.FieldName = 'N'
          HeaderAlignmentHorz = taCenter
          Width = 60
        end
      end
      object lvTypes: TcxGridLevel
        GridView = tvTypes
      end
    end
  end
  object pnlRight: TPanel
    Left = 333
    Top = 44
    Width = 947
    Height = 592
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object splGoods: TSplitter
      Left = 0
      Top = 409
      Width = 947
      Height = 3
      Cursor = crVSplit
      Align = alBottom
    end
    object lbMode: TcxLabel
      Left = 0
      Top = 0
      Align = alTop
      Caption = ''
      Style.TextStyle = [fsBold]
    end
    object cxGridItems: TcxGrid
      Left = 0
      Top = 21
      Width = 947
      Height = 388
      Align = alClient
      TabOrder = 1
      object tvItems: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        OnCellDblClick = tvItemsCellDblClick
        DataController.DataSource = dsItems
        DataController.KeyFieldNames = 'GOODS_ACNT_ID'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsSelection.MultiSelect = True
        OptionsView.ColumnAutoWidth = True
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        object tvItemsGOODS_ACNT_ID: TcxGridDBColumn
          Caption = 'Cod'
          DataBinding.FieldName = 'GOODS_ACNT_ID'
          HeaderAlignmentHorz = taCenter
          Width = 60
        end
        object tvItemsNAMEACNT: TcxGridDBColumn
          Caption = 'Denumirea contabila'
          DataBinding.FieldName = 'NAMEACNT'
          HeaderAlignmentHorz = taCenter
          Width = 280
        end
        object tvItemsPRICE_ACNT: TcxGridDBColumn
          Caption = 'Pret contabil'
          DataBinding.FieldName = 'PRICE_ACNT'
          HeaderAlignmentHorz = taCenter
          Width = 75
        end
        object tvItemsFOLDER_NAME: TcxGridDBColumn
          Caption = 'Mapa'
          DataBinding.FieldName = 'FOLDER_NAME'
          HeaderAlignmentHorz = taCenter
          Width = 130
        end
        object tvItemsTYPE_TITLE: TcxGridDBColumn
          Caption = 'Tipul actual'
          DataBinding.FieldName = 'TYPE_TITLE'
          HeaderAlignmentHorz = taCenter
          Width = 140
        end
        object tvItemsN_GOODS: TcxGridDBColumn
          Caption = 'Produse'
          DataBinding.FieldName = 'N_GOODS'
          HeaderAlignmentHorz = taCenter
          Width = 55
        end
        object tvItemsPROPOSED_TITLE: TcxGridDBColumn
          Caption = 'Tipul propus'
          DataBinding.FieldName = 'PROPOSED_TITLE'
          OnCustomDrawCell = tvItemsPROPOSED_TITLECustomDrawCell
          HeaderAlignmentHorz = taCenter
          Width = 140
        end
        object tvItemsPROPOSED_SHARE: TcxGridDBColumn
          Caption = 'Propus, %'
          DataBinding.FieldName = 'PROPOSED_SHARE'
          HeaderAlignmentHorz = taCenter
          Width = 65
        end
        object tvItemsGOODS_TYPEID: TcxGridDBColumn
          DataBinding.FieldName = 'GOODS_TYPEID'
          Visible = False
          VisibleForCustomization = False
        end
        object tvItemsPROPOSED_TYPEID: TcxGridDBColumn
          DataBinding.FieldName = 'PROPOSED_TYPEID'
          Visible = False
          VisibleForCustomization = False
        end
        object tvItemsFLG_DIFF: TcxGridDBColumn
          DataBinding.FieldName = 'FLG_DIFF'
          Visible = False
          VisibleForCustomization = False
        end
      end
      object lvItems: TcxGridLevel
        GridView = tvItems
      end
    end
    object cxGridGoods: TcxGrid
      Left = 0
      Top = 412
      Width = 947
      Height = 180
      Align = alBottom
      TabOrder = 2
      object tvGoods: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        DataController.DataSource = dsGoods
        DataController.KeyFieldNames = 'GOODSID'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsView.ColumnAutoWidth = True
        OptionsView.GroupByBox = False
        object tvGoodsGOODSID: TcxGridDBColumn
          Caption = 'Cod produs'
          DataBinding.FieldName = 'GOODSID'
          HeaderAlignmentHorz = taCenter
          Width = 70
        end
        object tvGoodsTITLE: TcxGridDBColumn
          Caption = 'Produsele legate de denumire'
          DataBinding.FieldName = 'TITLE'
          HeaderAlignmentHorz = taCenter
          Width = 450
        end
        object tvGoodsTYPE_TITLE: TcxGridDBColumn
          Caption = 'Tipul produsului'
          DataBinding.FieldName = 'TYPE_TITLE'
          HeaderAlignmentHorz = taCenter
          Width = 200
        end
      end
      object lvGoods: TcxGridLevel
        GridView = tvGoods
      end
    end
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 636
    Width = 1280
    Height = 44
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    DesignSize = (
      1280
      44)
    object btnSetType: TButton
      Left = 8
      Top = 9
      Width = 130
      Height = 27
      Caption = 'Seteaza tipul...'
      TabOrder = 0
      OnClick = btnSetTypeClick
    end
    object btnApplyProposed: TButton
      Left = 144
      Top = 9
      Width = 150
      Height = 27
      Caption = 'Aplica tipul propus'
      TabOrder = 1
      OnClick = btnApplyProposedClick
    end
    object btnAutoFill: TButton
      Left = 300
      Top = 9
      Width = 170
      Height = 27
      Caption = 'Completeaza automat...'
      TabOrder = 2
      OnClick = btnAutoFillClick
    end
    object lbHint: TcxLabel
      Left = 480
      Top = 13
      Caption =
        'Ctrl / Shift + clic = selectie multipla; dublu-clic = seteaza tip' +
        'ul. Tipul propus: albastru = denumire fara tip, rosu = alt tip.'
      Style.TextColor = clGrayText
    end
    object btnClose: TButton
      Left = 1182
      Top = 9
      Width = 90
      Height = 27
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Inchide'
      ModalResult = 2
      TabOrder = 4
    end
  end
  object qTypes: TIBCQuery
    KeyFields = 'GOODSTYPEID'
    SQL.Strings = (
      'SELECT Z.* FROM ('
      '  SELECT -1 GOODSTYPEID, CAST(''(fara tip)'' AS VARCHAR(512)) TITLE, COUNT(*) N'
      '  FROM TS_GOODS_ACNT A'
      '  WHERE A.GOODS_TYPEID IS NULL AND COALESCE(A.FLG_FOLDER, 0) = 0 AND A.GOODS_ACNT_ID > 0'
      '  UNION ALL'
      '  SELECT T.GOODSTYPEID, T.TITLE, COUNT(A.GOODS_ACNT_ID) N'
      '  FROM TS_GOODS_TYPE T'
      '  &JOINKIND TS_GOODS_ACNT A ON A.GOODS_TYPEID = T.GOODSTYPEID'
      '    AND COALESCE(A.FLG_FOLDER, 0) = 0 AND A.GOODS_ACNT_ID > 0'
      '  GROUP BY T.GOODSTYPEID, T.TITLE'
      ') Z'
      'ORDER BY IIF(Z.GOODSTYPEID = -1, 0, 1), Z.TITLE')
    ReadOnly = True
    Left = 72
    Top = 224
    MacroData = <
      item
        Name = 'JOINKIND'
      end>
  end
  object dsTypes: TIBCDataSource
    DataSet = qTypes
    OnDataChange = dsTypesDataChange
    Left = 136
    Top = 224
  end
  object qItems: TIBCQuery
    KeyFields = 'GOODS_ACNT_ID'
    SQL.Strings = (
      'SELECT A.GOODS_ACNT_ID, A.NAMEACNT, A.PRICE_ACNT, A.GOODS_TYPEID, T.TITLE TYPE_TITLE,'
      '       PF.NAMEACNT FOLDER_NAME,'
      '       COALESCE(P.TOT, 0) N_GOODS, P.T_BEST PROPOSED_TYPEID, PT.TITLE PROPOSED_TITLE,'
      '       IIF(P.TOT > 0, P.N_BEST * 100 / P.TOT, NULL) PROPOSED_SHARE,'
      '       IIF(P.T_BEST IS NOT NULL AND P.T_BEST IS DISTINCT FROM A.GOODS_TYPEID, 1, 0) FLG_DIFF'
      'FROM TS_GOODS_ACNT A'
      'LEFT JOIN TS_GOODS_TYPE T ON T.GOODSTYPEID = A.GOODS_TYPEID'
      'LEFT JOIN TS_GOODS_ACNT PF ON PF.GOODS_ACNT_ID = A.PARENTID'
      'LEFT JOIN ('
      '  SELECT X.GOODS_ACNT_ID, SUM(X.N) TOT,'
      '         CAST(SUBSTRING(MAX(LPAD(X.N, 9, ''0'') || LPAD(X.T, 9, ''0'')) FROM 1 FOR 9) AS INTEGER) N_BEST,'
      '         CAST(SUBSTRING(MAX(LPAD(X.N, 9, ''0'') || LPAD(X.T, 9, ''0'')) FROM 10 FOR 9) AS INTEGER) T_BEST'
      '  FROM (SELECT G.GOODS_ACNT_ID, G.WEBGOODSTYPE_ID T, COUNT(*) N FROM TS_GOODS G'
      '        WHERE G.GOODS_ACNT_ID > 0 AND G.WEBGOODSTYPE_ID + 0 > 1'
      '        GROUP BY G.GOODS_ACNT_ID, G.WEBGOODSTYPE_ID) X'
      '  GROUP BY X.GOODS_ACNT_ID'
      ') P ON P.GOODS_ACNT_ID = A.GOODS_ACNT_ID'
      'LEFT JOIN TS_GOODS_TYPE PT ON PT.GOODSTYPEID = P.T_BEST'
      'WHERE COALESCE(A.FLG_FOLDER, 0) = 0 AND A.GOODS_ACNT_ID > 0'
      '  &COND'
      'ORDER BY A.NAMEACNT')
    ReadOnly = True
    Left = 72
    Top = 288
    MacroData = <
      item
        Name = 'COND'
      end>
  end
  object dsItems: TIBCDataSource
    DataSet = qItems
    Left = 136
    Top = 288
  end
  object qGoods: TIBCQuery
    KeyFields = 'GOODSID'
    SQL.Strings = (
      'SELECT G.GOODSID, G.TITLE, T.TITLE TYPE_TITLE'
      'FROM TS_GOODS G'
      'LEFT JOIN TS_GOODS_TYPE T ON T.GOODSTYPEID = G.WEBGOODSTYPE_ID'
      'WHERE G.GOODS_ACNT_ID = :GOODS_ACNT_ID'
      'ORDER BY G.TITLE')
    MasterSource = dsItems
    ReadOnly = True
    Left = 72
    Top = 352
    ParamData = <
      item
        DataType = ftInteger
        Name = 'GOODS_ACNT_ID'
        ParamType = ptInput
        Value = nil
      end>
  end
  object dsGoods: TIBCDataSource
    DataSet = qGoods
    Left = 136
    Top = 352
  end
  object trWrite: TIBCTransaction
    Left = 208
    Top = 224
  end
end
