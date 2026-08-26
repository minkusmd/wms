object frmSelectGoodsTypeDlg: TfrmSelectGoodsTypeDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Tipuri de produse'
  ClientHeight = 364
  ClientWidth = 729
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OnActivate = FormActivate
  TextHeight = 13
  object cxGrid1: TcxGrid
    Left = 8
    Top = 8
    Width = 712
    Height = 313
    TabOrder = 0
    object cxGrid1DBTableView1: TcxGridDBTableView
      OnDblClick = cxGrid1DBTableView1DblClick
      OnKeyDown = cxGrid1DBTableView1KeyDown
      FindPanel.DisplayMode = fpdmAlways
      FindPanel.UseExtendedSyntax = True
      FindPanel.Location = fplGroupByBox
      DataController.DataSource = IBCDataSourceGoodsTypes
      DataController.KeyFieldNames = 'GOODSTYPEID'
      OptionsBehavior.IncSearch = True
      OptionsBehavior.ImmediateEditor = False
      OptionsView.GroupByBox = False
      OptionsView.Indicator = True
      object cxGrid1DBTableView1COD: TcxGridDBColumn
        Caption = 'Cod'
        DataBinding.FieldName = 'GOODSTYPEID'
        HeaderAlignmentHorz = taCenter
        Width = 62
      end
      object cxGrid1DBTableView1Denumire: TcxGridDBColumn
        Caption = 'Denumire'
        DataBinding.FieldName = 'TITLE'
        HeaderAlignmentHorz = taCenter
        Width = 291
      end
      object cxGrid1DBTableView1TITLE_RUS: TcxGridDBColumn
        Caption = #1053#1072#1079#1074#1072#1085#1080#1077
        DataBinding.FieldName = 'TITLE_RUS'
        HeaderAlignmentHorz = taCenter
        Width = 334
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
    end
  end
  object cxButton1: TcxButton
    Left = 512
    Top = 327
    Width = 90
    Height = 29
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object cxButton2: TcxButton
    Left = 608
    Top = 327
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 2
  end
  object cxButton3: TcxButton
    Left = 8
    Top = 327
    Width = 90
    Height = 29
    Caption = 'Catalog'
    TabOrder = 3
    OnClick = cxButton3Click
  end
  object IBCQueryGoodsTypes: TIBCQuery
    KeyFields = 'GOODSTYPEID'
    SQL.Strings = (
      'select gt.GOODSTYPEID, gt.TITLE, gt.TITLE_RUS'
      'from TS_GOODS_TYPE gt'
      'join ts_goods g on g.webgoodstype_id = gt.goodstypeid '
      'join ts_goods_ACNT GA on ga.goods_acnt_id = g.goods_ACNT_ID'
      'and gA.goods_acnt_id = :goods_acnt_id'
      '')
    Left = 232
    Top = 176
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'goods_acnt_id'
        Value = nil
      end>
  end
  object IBCDataSourceGoodsTypes: TIBCDataSource
    DataSet = IBCQueryGoodsTypes
    Left = 232
    Top = 112
  end
end
