object frmHistoryGoodsPriceForeignDlg: TfrmHistoryGoodsPriceForeignDlg
  Left = 0
  Top = 0
  Caption = 'Istoria modificarii preturilor'
  ClientHeight = 541
  ClientWidth = 1018
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  DesignSize = (
    1018
    541)
  TextHeight = 13
  object Panel1: TPanel
    Left = 8
    Top = 8
    Width = 1002
    Height = 485
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 0
    object cxGrid1: TcxGrid
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 992
      Height = 475
      Align = alClient
      TabOrder = 0
      object cxGrid1DBTableView1: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        DataController.DataSource = IBCDataSourceGoodsPriceHistory
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsView.GroupByBox = False
        object cxGrid1DBTableView1DATA: TcxGridDBColumn
          DataBinding.FieldName = 'DATA'
          DataBinding.IsNullValueType = True
          Width = 77
        end
        object cxGrid1DBTableView1Column1: TcxGridDBColumn
          Caption = 'Price'
          DataBinding.FieldName = 'FLG_IN_PRICE'
          DataBinding.IsNullValueType = True
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = '1'
          Properties.ValueUnchecked = '0'
          HeaderAlignmentHorz = taCenter
          Width = 42
        end
        object cxGrid1DBTableView1GOODSID: TcxGridDBColumn
          Caption = 'Produs'
          DataBinding.FieldName = 'GOODSID'
          DataBinding.IsNullValueType = True
          Width = 54
        end
        object cxGrid1DBTableView1CUSTOMERID: TcxGridDBColumn
          Caption = 'Furnizor'
          DataBinding.FieldName = 'CUSTOMERID'
          DataBinding.IsNullValueType = True
          Width = 100
        end
        object cxGrid1DBTableView1GOODS_CODE: TcxGridDBColumn
          Caption = 'Cod produs'
          DataBinding.FieldName = 'GOODS_CODE'
          DataBinding.IsNullValueType = True
          Width = 36
        end
        object cxGrid1DBTableView1GOODS_TITLE: TcxGridDBColumn
          Caption = 'Denumire'
          DataBinding.FieldName = 'GOODS_TITLE'
          DataBinding.IsNullValueType = True
          Width = 255
        end
        object cxGrid1DBTableView1LAST_PRICE_DATE: TcxGridDBColumn
          DataBinding.FieldName = 'LAST_PRICE_DATE'
          DataBinding.IsNullValueType = True
          Visible = False
          Width = 65
        end
        object cxGrid1DBTableView1PRICE0: TcxGridDBColumn
          DataBinding.FieldName = 'PRICE0'
          DataBinding.IsNullValueType = True
          Visible = False
        end
        object cxGrid1DBTableView1CURRENCY0ID: TcxGridDBColumn
          DataBinding.FieldName = 'CURRENCY0ID'
          DataBinding.IsNullValueType = True
          Visible = False
        end
        object cxGrid1DBTableView1BASE_PRICE4: TcxGridDBColumn
          DataBinding.FieldName = 'BASE_PRICE4'
          DataBinding.IsNullValueType = True
          Visible = False
        end
        object cxGrid1DBTableView1PRICE1: TcxGridDBColumn
          DataBinding.FieldName = 'PRICE1'
          DataBinding.IsNullValueType = True
          MinWidth = 48
          Options.HorzSizing = False
          Width = 48
        end
        object cxGrid1DBTableView1PRICE2: TcxGridDBColumn
          DataBinding.FieldName = 'PRICE2'
          DataBinding.IsNullValueType = True
          MinWidth = 48
          Options.HorzSizing = False
          Width = 48
        end
        object cxGrid1DBTableView1PRICE3: TcxGridDBColumn
          DataBinding.FieldName = 'PRICE3'
          DataBinding.IsNullValueType = True
          MinWidth = 48
          Options.HorzSizing = False
          Width = 48
        end
        object cxGrid1DBTableView1CURRENCY3ID: TcxGridDBColumn
          Caption = 'V3'
          DataBinding.FieldName = 'CURRENCY3ID'
          DataBinding.IsNullValueType = True
          HeaderAlignmentHorz = taCenter
        end
        object cxGrid1DBTableView1PRICE4: TcxGridDBColumn
          DataBinding.FieldName = 'PRICE4'
          DataBinding.IsNullValueType = True
          MinWidth = 48
          Options.HorzSizing = False
          Width = 48
        end
        object cxGrid1DBTableView1CURRENCY4ID: TcxGridDBColumn
          Caption = 'V4'
          DataBinding.FieldName = 'CURRENCY4ID'
          DataBinding.IsNullValueType = True
          HeaderAlignmentHorz = taCenter
          Width = 46
        end
        object cxGrid1DBTableView1PRICE5: TcxGridDBColumn
          DataBinding.FieldName = 'PRICE5'
          DataBinding.IsNullValueType = True
          MinWidth = 48
          Options.HorzSizing = False
          Width = 48
        end
        object cxGrid1DBTableView1PRICE6: TcxGridDBColumn
          DataBinding.FieldName = 'PRICE6'
          DataBinding.IsNullValueType = True
          Width = 48
        end
        object cxGrid1DBTableView1CURRENCY6ID: TcxGridDBColumn
          Caption = 'V6'
          DataBinding.FieldName = 'CURRENCY6ID'
          DataBinding.IsNullValueType = True
          HeaderAlignmentHorz = taCenter
          Width = 48
        end
        object cxGrid1DBTableView1PRICE7: TcxGridDBColumn
          DataBinding.FieldName = 'PRICE7'
          DataBinding.IsNullValueType = True
          HeaderAlignmentHorz = taCenter
          Width = 48
        end
        object cxGrid1DBTableView1CURRENCY7ID: TcxGridDBColumn
          Caption = 'V7'
          DataBinding.FieldName = 'CURRENCY7ID'
          DataBinding.IsNullValueType = True
          HeaderAlignmentHorz = taCenter
          Width = 48
        end
        object cxGrid1DBTableView1FLAGS: TcxGridDBColumn
          DataBinding.FieldName = 'FLAGS'
          DataBinding.IsNullValueType = True
          Visible = False
        end
        object cxGrid1DBTableView1MODIFIED_BY: TcxGridDBColumn
          Caption = 'Modificat de...'
          DataBinding.FieldName = 'modified_by_user'
          DataBinding.IsNullValueType = True
          Width = 107
        end
      end
      object cxGrid1Level1: TcxGridLevel
        GridView = cxGrid1DBTableView1
      end
    end
  end
  object cxButton1: TcxButton
    Left = 897
    Top = 504
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Inchide'
    ModalResult = 1
    TabOrder = 1
  end
  object IBCQueryGoodsPriceHistory: TIBCQuery
    SQL.Strings = (
      'select'
      'l.UID,'
      'l.DATA,'
      'l.GOODSID,'
      'l.CUSTOMERID,'
      
        '(select name from ts_customer c where l.customerid = c.customeri' +
        'd) supplier_name,'
      'l.GOODS_CODE,'
      'l.GOODS_TITLE,'
      'l.URL,'
      'l.LAST_PRICE_DATE,'
      'l.PRICE0,'
      'l.CURRENCY0ID,'
      'l.PRICE1,'
      'l.PRICE2,'
      'l.PRICE3,'
      'l.PRICE4,'
      'l.PRICE5,'
      'l.CURRENCY4ID,'
      'l.PRICE7,'
      'l.CURRENCY7ID,'
      'l.FLAGS,'
      'l.BASE_PRICE4,'
      'l.MODIFIED_BY,'
      'u.last_name ||'#39' '#39'||u.first_name modified_by_user, '
      'get_flg_value(l.flags, 3) FLG_IN_PRICE'
      'from tlog_goods_foreign  l'
      'join ts_users u on u.userid = l.modified_by'
      'where goodsid = :goodsid and l.customerid = :customerid')
    Left = 104
    Top = 120
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'goodsid'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'customerid'
        Value = nil
      end>
  end
  object IBCDataSourceGoodsPriceHistory: TIBCDataSource
    DataSet = IBCQueryGoodsPriceHistory
    Left = 104
    Top = 56
  end
end
