object frmCustomerCallInfoDlg: TfrmCustomerCallInfoDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Informatii despre client'
  ClientHeight = 558
  ClientWidth = 857
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object btnClose: TcxButton
    Left = 392
    Top = 526
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Inchide'
    ModalResult = 1
    TabOrder = 1
  end
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 8
    Width = 841
    Height = 510
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 0
    object Label1: TLabel
      Left = 21
      Top = 11
      Width = 77
      Height = 15
      Caption = 'Numar telefon'
    end
    object lbPhoneNumber: TLabel
      Left = 120
      Top = 11
      Width = 97
      Height = 15
      AutoSize = False
      Caption = '00000000'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object cxGrid1: TcxGrid
      Left = 8
      Top = 40
      Width = 825
      Height = 193
      TabOrder = 0
      object cxGrid1DBTableView1: TcxGridDBTableView
        OnKeyDown = cxGrid1DBTableView1KeyDown
        DataController.DataSource = IBCDataSourceLocalDocs
        OptionsBehavior.IncSearch = True
        OptionsBehavior.ImmediateEditor = False
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.ColumnAutoWidth = True
        OptionsView.GroupByBox = False
        object cxGrid1DBTableView1_FLG_CLOSED: TcxGridDBColumn
          Caption = 'Inchis'
          DataBinding.FieldName = 'FLG_CLOSED'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = '1'
          Properties.ValueUnchecked = '0'
          MinWidth = 41
          Options.HorzSizing = False
          Width = 41
        end
        object cxGrid1DBTableView1Column1: TcxGridDBColumn
          Caption = 'DocID'
          DataBinding.FieldName = 'DOCID'
          Width = 52
        end
        object cxGrid1DBTableView1Column2: TcxGridDBColumn
          Caption = 'Data'
          DataBinding.FieldName = 'DATA'
          Width = 91
        end
        object cxGrid1DBTableView1Column7: TcxGridDBColumn
          Caption = 'Document'
          DataBinding.FieldName = 'DOCTYPE_NAME'
          Width = 158
        end
        object cxGrid1DBTableView1Column3: TcxGridDBColumn
          Caption = 'Client'
          DataBinding.FieldName = 'CT_NAME'
          Width = 206
        end
        object cxGrid1DBTableView1Column4: TcxGridDBColumn
          Caption = 'Suma'
          DataBinding.FieldName = 'SUMA'
          Width = 84
        end
        object cxGrid1DBTableView1Column5: TcxGridDBColumn
          Caption = 'Valuta'
          DataBinding.FieldName = 'Currency_name'
          Width = 39
        end
        object cxGrid1DBTableView1Column6: TcxGridDBColumn
          Caption = 'Operator'
          DataBinding.FieldName = 'CREATED_BY_NAME'
          Width = 72
        end
        object cxGrid1DBTableView1Column8: TcxGridDBColumn
          Caption = 'Curs'
          DataBinding.FieldName = 'RATE'
          HeaderAlignmentHorz = taCenter
          MinWidth = 40
          Options.HorzSizing = False
          Width = 40
        end
        object cxGrid1DBTableView1Column9: TcxGridDBColumn
          Caption = 'Curs $'
          DataBinding.FieldName = 'RATE_USD'
          HeaderAlignmentHorz = taCenter
          MinWidth = 40
          Options.HorzSizing = False
          Width = 40
        end
      end
      object cxGrid1Level1: TcxGridLevel
        GridView = cxGrid1DBTableView1
      end
    end
    object cxGrid2: TcxGrid
      Left = 8
      Top = 239
      Width = 825
      Height = 258
      TabOrder = 1
      object cxGrid2DBTableView1: TcxGridDBTableView
        OnKeyDown = cxGrid2DBTableView1KeyDown
        DataController.DataSource = IBCDataSourceLocalJurnal
        DataController.Summary.FooterSummaryItems = <
          item
            Format = '0.00'
            Kind = skSum
            FieldName = 'SUMA'
          end
          item
            Kind = skCount
            Column = cxGrid2DBTableView1Column1
          end>
        OptionsBehavior.IncSearch = True
        OptionsBehavior.ImmediateEditor = False
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.ColumnAutoWidth = True
        OptionsView.Footer = True
        OptionsView.GroupByBox = False
        object cxGrid2DBTableView1Column1: TcxGridDBColumn
          Caption = 'Cod'
          DataBinding.FieldName = 'GOODSID'
          Width = 60
        end
        object cxGrid2DBTableView1Column2: TcxGridDBColumn
          Caption = 'Produs'
          DataBinding.FieldName = 'GOODS_NAME'
          Width = 566
        end
        object cxGrid2DBTableView1Column3: TcxGridDBColumn
          Caption = 'Cant'
          DataBinding.FieldName = 'QTY'
          Width = 45
        end
        object cxGrid2DBTableView1Column4: TcxGridDBColumn
          Caption = 'Pret'
          DataBinding.FieldName = 'PRICE'
          Width = 58
        end
        object cxGrid2DBTableView1Column5: TcxGridDBColumn
          Caption = 'Suma'
          DataBinding.FieldName = 'SUMA'
          Width = 78
        end
      end
      object cxGrid2Level1: TcxGridLevel
        GridView = cxGrid2DBTableView1
      end
    end
  end
  object IBCQueryLocalDocs: TIBCQuery
    SQL.Strings = (
      
        'select D.DOCID, D.data, D.CT, C.NAME CT_NAME, D.SUMA, DT.TITLE D' +
        'OCTYPE_NAME, V.SHORTNAME CURRENCY_NAME,'
      
        '       U.LAST_NAME || '#39' '#39' || U.FIRST_NAME CREATED_BY_NAME, get_f' +
        'lg_value(d.flags, 10) flg_closed'
      'from TS_CUST_PHONES CP'
      'inner join TS_CUSTOMER C on C.CUSTOMERID = CP.CUSTOMERID and'
      '      C.CUSTOMER_TYPE_ID <> 4006 /* colaboratori */'
      'inner join TDB_DOCS D on D.CT = CP.CUSTOMERID'
      'inner join TS_CURRENCY V on V.CURRENCYID = D.CURRENCYID'
      'inner join TS_USERS U on U.USERID = D.CREATED_BY'
      'inner join TS_DOCTYPES DT on DT.DOCTYPEID = D.DOCTYPEID '
      'where CP.PHONENUMBER containing :PHONENUMBER and'
      '      CP.CUSTOMERID <> 9'
      'order by d.data      ')
    Left = 384
    Top = 144
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'phonenumber'
        Value = nil
      end>
  end
  object IBCQueryLocalJurnal: TIBCQuery
    SQL.Strings = (
      'select * from vw_tdb_jurnal where docid=:docid')
    MasterFields = 'DOCID'
    DetailFields = 'DOCID'
    MasterSource = IBCDataSourceLocalDocs
    Left = 416
    Top = 416
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'docid'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'DOCID'
        Value = nil
      end>
  end
  object IBCDataSourceLocalDocs: TIBCDataSource
    DataSet = IBCQueryLocalDocs
    Left = 296
    Top = 144
  end
  object IBCDataSourceLocalJurnal: TIBCDataSource
    DataSet = IBCQueryLocalJurnal
    Left = 336
    Top = 416
  end
end
