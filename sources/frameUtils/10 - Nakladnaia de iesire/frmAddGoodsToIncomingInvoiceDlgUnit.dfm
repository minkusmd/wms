object frmAddGoodsToIncomingInvoiceDlg: TfrmAddGoodsToIncomingInvoiceDlg
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Adauga in "Factura de Intrare"'
  ClientHeight = 520
  ClientWidth = 1000
  Color = clBtnFace
  Constraints.MinHeight = 400
  Constraints.MinWidth = 760
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  TextHeight = 15
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 1000
    Height = 52
    Align = alTop
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 0
    object lbGoods: TcxLabel
      Left = 8
      Top = 4
      Caption = 'Produs'
      ParentFont = False
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -13
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = [fsBold]
      Style.IsFontAssigned = True
    end
    object lbInfo: TcxLabel
      Left = 8
      Top = 28
      Caption =
        'Facturile de intrare deschise ale firmei curente. Pretul propus ' +
        '= pretul0 al produsului de la furnizorul facturii, in valuta fac' +
        'turii.'
      Style.TextColor = clGrayText
    end
  end
  object pnlMode: TPanel
    Left = 0
    Top = 52
    Width = 1000
    Height = 30
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object rbExistingDoc: TRadioButton
      Left = 8
      Top = 6
      Width = 260
      Height = 19
      Caption = 'In factura de intrare deschisa'
      Checked = True
      TabOrder = 0
      TabStop = True
      OnClick = rbModeClick
    end
    object rbNewDoc: TRadioButton
      Left = 280
      Top = 6
      Width = 340
      Height = 19
      Caption = 'Factura de intrare noua de la furnizorul ales'
      TabOrder = 1
      OnClick = rbModeClick
    end
  end
  object cxGridDocs: TcxGrid
    Left = 0
    Top = 82
    Width = 1000
    Height = 353
    Align = alClient
    TabOrder = 2
    object tvDocs: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      ScrollbarAnnotations.CustomAnnotations = <>
      OnCellDblClick = tvDocsCellDblClick
      DataController.DataSource = dsDocs
      DataController.KeyFieldNames = 'DOCID'
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
      OptionsView.Indicator = True
      object tvDocsDOCID: TcxGridDBColumn
        Caption = 'Nr. doc'
        DataBinding.FieldName = 'DOCID'
        HeaderAlignmentHorz = taCenter
        Width = 70
      end
      object tvDocsDATA: TcxGridDBColumn
        Caption = 'Data'
        DataBinding.FieldName = 'DATA'
        HeaderAlignmentHorz = taCenter
        Width = 110
      end
      object tvDocsCT_NAME: TcxGridDBColumn
        Caption = 'Furnizor'
        DataBinding.FieldName = 'CT_NAME'
        HeaderAlignmentHorz = taCenter
        Width = 200
      end
      object tvDocsDTDEP_NAME: TcxGridDBColumn
        Caption = 'Depozit'
        DataBinding.FieldName = 'DTDEP_NAME'
        HeaderAlignmentHorz = taCenter
        Width = 110
      end
      object tvDocsSUMA: TcxGridDBColumn
        Caption = 'Suma'
        DataBinding.FieldName = 'SUMA'
        HeaderAlignmentHorz = taCenter
        Width = 80
      end
      object tvDocsCURRENCY_NAME: TcxGridDBColumn
        Caption = 'Valuta'
        DataBinding.FieldName = 'CURRENCY_NAME'
        HeaderAlignmentHorz = taCenter
        Width = 50
      end
      object tvDocsSUPPLIER_PRICE0: TcxGridDBColumn
        Caption = 'Pret0 furnizor'
        DataBinding.FieldName = 'SUPPLIER_PRICE0'
        HeaderAlignmentHorz = taCenter
        Width = 85
      end
      object tvDocsCURRENCY0_NAME: TcxGridDBColumn
        Caption = 'Valuta pret0'
        DataBinding.FieldName = 'CURRENCY0_NAME'
        HeaderAlignmentHorz = taCenter
        Width = 70
      end
      object tvDocsDOC_PRICE: TcxGridDBColumn
        Caption = 'Pret in factura'
        DataBinding.FieldName = 'DOC_PRICE'
        HeaderAlignmentHorz = taCenter
        Width = 85
      end
      object tvDocsQTY_IN_DOC: TcxGridDBColumn
        Caption = 'Deja in factura'
        DataBinding.FieldName = 'QTY_IN_DOC'
        HeaderAlignmentHorz = taCenter
        Width = 80
      end
      object tvDocsCREATED_BY_NAME: TcxGridDBColumn
        Caption = 'Creat de'
        DataBinding.FieldName = 'CREATED_BY_NAME'
        HeaderAlignmentHorz = taCenter
        Width = 120
      end
    end
    object tvLines: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      ScrollbarAnnotations.CustomAnnotations = <>
      OnCustomDrawCell = tvLinesCustomDrawCell
      DataController.DataSource = dsLines
      DataController.DetailKeyFieldNames = 'DOCID'
      DataController.KeyFieldNames = 'DOCID;DTDEP;CTDEP;GOODSCOMPLECT_ID;GOODSID'
      DataController.MasterKeyFieldNames = 'DOCID'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <
        item
          Format = '0 pozitii'
          Kind = skCount
          Column = tvLinesGOODS_NAME
        end
        item
          Format = ',0.00'
          Kind = skSum
          Column = tvLinesSUMA
        end>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.Footer = True
      OptionsView.GroupByBox = False
      object tvLinesGOODSID: TcxGridDBColumn
        Caption = 'Cod'
        DataBinding.FieldName = 'GOODSID'
        Width = 70
      end
      object tvLinesGOODS_NAME: TcxGridDBColumn
        Caption = 'Produs'
        DataBinding.FieldName = 'GOODS_NAME'
        Width = 330
      end
      object tvLinesDTDEP_NAME: TcxGridDBColumn
        Caption = 'Depozit'
        DataBinding.FieldName = 'DTDEP_NAME'
        Width = 110
      end
      object tvLinesUM_NAME: TcxGridDBColumn
        Caption = 'UM'
        DataBinding.FieldName = 'UM_NAME'
        Width = 45
      end
      object tvLinesQTY: TcxGridDBColumn
        Caption = 'Cantitate'
        DataBinding.FieldName = 'QTY'
        PropertiesClassName = 'TcxCalcEditProperties'
        Properties.DisplayFormat = '0.###'
        Width = 75
      end
      object tvLinesPRICE: TcxGridDBColumn
        Caption = 'Pret'
        DataBinding.FieldName = 'PRICE'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00'
        Width = 85
      end
      object tvLinesSUMA: TcxGridDBColumn
        Caption = 'Suma'
        DataBinding.FieldName = 'SUMA'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00'
        Width = 95
      end
    end
    object lvDocs: TcxGridLevel
      GridView = tvDocs
      object lvLines: TcxGridLevel
        GridView = tvLines
      end
    end
  end
  object pnlSuppliers: TPanel
    Left = 0
    Top = 82
    Width = 1000
    Height = 353
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 3
    Visible = False
    object pnlSuppliersTop: TPanel
      Left = 0
      Top = 0
      Width = 1000
      Height = 34
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object btnOtherSupplier: TButton
        Left = 8
        Top = 4
        Width = 120
        Height = 26
        Caption = 'Alt furnizor...'
        TabOrder = 0
        OnClick = btnOtherSupplierClick
      end
      object lbSuppliersInfo: TcxLabel
        Left = 138
        Top = 8
        Caption = 
          'Furnizorii produsului; "Alt furnizor..." alege din catalogul de ' +
          'clienti.'
        Style.TextColor = clGrayText
      end
    end
    object cxGridSuppliers: TcxGrid
      Left = 0
      Top = 34
      Width = 1000
      Height = 319
      Align = alClient
      TabOrder = 1
      object tvSuppliers: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        OnCellDblClick = tvDocsCellDblClick
        DataController.DataSource = dsSuppliers
        DataController.KeyFieldNames = 'CUSTOMERID'
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
        OptionsView.Indicator = True
        object tvSuppliersNAME: TcxGridDBColumn
          Caption = 'Furnizor'
          DataBinding.FieldName = 'NAME'
          HeaderAlignmentHorz = taCenter
          Width = 260
        end
        object tvSuppliersFLG_IN_STOCK: TcxGridDBColumn
          Caption = 'In stoc'
          DataBinding.FieldName = 'FLG_IN_STOCK'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          HeaderAlignmentHorz = taCenter
          Width = 60
        end
        object tvSuppliersPRICE0: TcxGridDBColumn
          Caption = 'Pret0'
          DataBinding.FieldName = 'PRICE0'
          HeaderAlignmentHorz = taCenter
          Width = 85
        end
        object tvSuppliersCURRENCY0_NAME: TcxGridDBColumn
          Caption = 'Valuta pret0'
          DataBinding.FieldName = 'CURRENCY0_NAME'
          HeaderAlignmentHorz = taCenter
          Width = 70
        end
        object tvSuppliersPRICE0_MDL: TcxGridDBColumn
          Caption = 'Pret0, lei'
          DataBinding.FieldName = 'PRICE0_MDL'
          HeaderAlignmentHorz = taCenter
          Width = 90
        end
        object tvSuppliersLAST_PRICE_DATE: TcxGridDBColumn
          Caption = 'Pret actualizat'
          DataBinding.FieldName = 'LAST_PRICE_DATE'
          HeaderAlignmentHorz = taCenter
          Width = 120
        end
        object tvSuppliersOPEN_DOCS: TcxGridDBColumn
          Caption = 'Facturi deschise'
          DataBinding.FieldName = 'OPEN_DOCS'
          HeaderAlignmentHorz = taCenter
          Width = 95
        end
      end
      object lvSuppliers: TcxGridLevel
        GridView = tvSuppliers
      end
    end
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 435
    Width = 1000
    Height = 44
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 4
    object lbQty: TcxLabel
      Left = 8
      Top = 12
      Caption = 'Cantitatea'
    end
    object ceQty: TcxCalcEdit
      Left = 76
      Top = 10
      EditValue = 0.000000000000000000
      TabOrder = 1
      Width = 100
    end
    object lbPrice: TcxLabel
      Left = 200
      Top = 12
      Caption = 'Pretul'
    end
    object cePrice: TcxCalcEdit
      Left = 244
      Top = 10
      EditValue = 0.000000000000000000
      TabOrder = 3
      Width = 120
    end
    object lbPriceCurrency: TcxLabel
      Left = 370
      Top = 12
      Caption = ''
    end
  end
  object RzDialogButtons1: TRzDialogButtons
    Left = 0
    Top = 479
    Width = 1000
    Height = 41
    TabOrder = 5
  end
  object qDocs: TIBCQuery
    KeyFields = 'DOCID'
    SQL.Strings = (
      'SELECT D.DOCID, D.DATA, D.CT, D.CT_NAME, D.DTDEP, D.DTDEP_NAME, D.CTDEP,'
      '       D.SUMA, D.CURRENCYID, D.CURRENCY_NAME, D.RATE, D.FLG_ACNT,'
      '       D.CREATED_BY_NAME,'
      '       GF.PRICE0 SUPPLIER_PRICE0, GF.CURRENCY0_NAME,'
      '       IIF(COALESCE(GF.PRICE0, 0) = 0, 0,'
      '           IIF(GF.CURRENCY0ID = D.CURRENCYID, GF.PRICE0,'

        '               ROUND(GF.PRICE0 * GF.EXCHANGE_RATE / IIF(COALESCE(D.' +
        'RATE, 0) = 0, 1, D.RATE), 2))) DOC_PRICE,'
      '       (SELECT SUM(J.QTY) FROM TDB_JURNAL J'

        '        WHERE J.DOCID = D.DOCID AND J.GOODSID = :GOODSID AND J.GOODS' +
        'COMPLECT_ID = -1) QTY_IN_DOC,'
      '       IIF(GF.CURRENCY0ID IS NULL, 0, 1) FLG_SUPPLIER_GOODS'
      'FROM VW_TDB_DOCS D'
      'LEFT JOIN LATERAL ('

        '  SELECT FIRST 1 F.PRICE0, COALESCE(F.CURRENCY0ID, 498) CURRENCY0' +
        'ID,'
      '         C.TITLE CURRENCY0_NAME, C.EXCHANGE_RATE'
      '  FROM TS_GOODS_FOREIGN F'

        '  LEFT JOIN TS_CURRENCY C ON C.CURRENCYID = COALESCE(F.CURRENCY0I' +
        'D, 498)'
      '  WHERE F.GOODSID = :GOODSID_F AND F.CUSTOMERID = D.CT'

        '  ORDER BY IIF(COALESCE(F.PRICE0, 0) > 0, 0, 1), F.LAST_PRICE_DA' +
        'TE DESC NULLS LAST'
      ') GF ON 1 = 1'
      'WHERE D.DOCTYPEID = :DOCTYPEID AND D.DT = :FIRMA'
      '  AND D.FLG_CLOSED = 0 AND D.FLG_DEL = 0'
      'ORDER BY FLG_SUPPLIER_GOODS DESC, D.DOCID DESC')
    ReadOnly = True
    Left = 72
    Top = 152
    ParamData = <
      item
        DataType = ftInteger
        Name = 'GOODSID'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftInteger
        Name = 'GOODSID_F'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftInteger
        Name = 'DOCTYPEID'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftInteger
        Name = 'FIRMA'
        ParamType = ptInput
        Value = nil
      end>
  end
  object dsDocs: TIBCDataSource
    DataSet = qDocs
    OnDataChange = dsDocsDataChange
    Left = 152
    Top = 152
  end
  object qLines: TIBCQuery
    KeyFields = 'DOCID;DTDEP;CTDEP;GOODSCOMPLECT_ID;GOODSID'
    ReadOnly = True
    Left = 312
    Top = 152
  end
  object dsLines: TIBCDataSource
    DataSet = qLines
    Left = 384
    Top = 152
  end
  object qSuppliers: TIBCQuery
    KeyFields = 'CUSTOMERID'
    SQL.Strings = (
      'SELECT S.* FROM ('
      '  SELECT C.CUSTOMERID, C.NAME,'
      '         COALESCE(GF.FLG_IN_STOCK, 0) FLG_IN_STOCK, GF.PRICE0, GF.CURRENCY0_NAME,'
      '         GF.PRICE0_MDL, GF.LAST_PRICE_DATE,'
      '         (SELECT COUNT(*) FROM TDB_DOCS D'
      '          WHERE D.DOCTYPEID = :DOCTYPEID AND D.DT = :FIRMA AND D.CT = C.CUSTOMERID'
      '            AND GET_FLG_VALUE(D.FLAGS, 10) = 0 AND GET_FLG_VALUE(D.FLAGS, 2) = 0) OPEN_DOCS'
      '  FROM TS_CUSTOMER C'
      '  LEFT JOIN LATERAL ('
      '    SELECT FIRST 1 GET_FLG_VALUE(F.FLAGS, 3) FLG_IN_STOCK, F.PRICE0, CU.TITLE CURRENCY0_NAME,'
      '           ROUND(F.PRICE0 * CU.EXCHANGE_RATE, 2) PRICE0_MDL, F.LAST_PRICE_DATE'
      '    FROM TS_GOODS_FOREIGN F'
      '    LEFT JOIN TS_CURRENCY CU ON CU.CURRENCYID = COALESCE(F.CURRENCY0ID, 498)'
      '    WHERE F.GOODSID = :GOODSID AND F.CUSTOMERID = C.CUSTOMERID'
      '    ORDER BY GET_FLG_VALUE(F.FLAGS, 3) DESC, IIF(COALESCE(F.PRICE0, 0) > 0, 0, 1), F.PRICE0'
      '  ) GF ON 1 = 1'
      '  WHERE (C.CUSTOMERID IN (SELECT F2.CUSTOMERID FROM TS_GOODS_FOREIGN F2 WHERE F2.GOODSID = :GOODSID_F)'
      '         OR C.CUSTOMERID = :EXTRA_CT)'
      '    AND C.CUSTOMERID > 0'
      ') S'
      'ORDER BY S.FLG_IN_STOCK DESC, IIF(COALESCE(S.PRICE0, 0) > 0, 0, 1), S.PRICE0_MDL, S.NAME')
    ReadOnly = True
    Left = 72
    Top = 216
    ParamData = <
      item
        DataType = ftInteger
        Name = 'DOCTYPEID'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftInteger
        Name = 'FIRMA'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftInteger
        Name = 'GOODSID'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftInteger
        Name = 'GOODSID_F'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftInteger
        Name = 'EXTRA_CT'
        ParamType = ptInput
        Value = nil
      end>
  end
  object dsSuppliers: TIBCDataSource
    DataSet = qSuppliers
    OnDataChange = dsSuppliersDataChange
    Left = 152
    Top = 216
  end
  object trWrite: TIBCTransaction
    Left = 232
    Top = 152
  end
end
