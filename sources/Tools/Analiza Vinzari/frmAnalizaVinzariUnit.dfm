object frmAnalizaVinzariDlg: TfrmAnalizaVinzariDlg
  Left = 0
  Top = 0
  Caption = 'Analiza vinzari pe grupe de produse'
  ClientHeight = 601
  ClientWidth = 1153
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object cxDBPivotGrid1: TcxDBPivotGrid
    Left = 0
    Top = 92
    Width = 1153
    Height = 489
    Align = alClient
    DataSource = IBCDataSourceAnalizaVinzari
    Groups = <>
    TabOrder = 3
    ExplicitTop = 86
    object cxDBPivotGrid1_UserName: TcxDBPivotGridField
      Area = faRow
      AreaIndex = 0
      IsCaptionAssigned = True
      Caption = 'Responsabil'
      DataBinding.FieldName = 'USERNAME'
      Visible = True
      UniqueName = 'Responsabil'
    end
    object cxDBPivotGrid1GGID: TcxDBPivotGridField
      AreaIndex = 0
      DataBinding.FieldName = 'GGID'
      UniqueName = 'GGID'
    end
    object cxDBPivotGrid1GG_NAME: TcxDBPivotGridField
      Area = faRow
      AreaIndex = 1
      IsCaptionAssigned = True
      Caption = 'Grupa'
      DataBinding.FieldName = 'GG_NAME'
      Visible = True
      Width = 120
      UniqueName = 'GG_NAME'
    end
    object cxDBPivotGrid1DT: TcxDBPivotGridField
      AreaIndex = 1
      DataBinding.FieldName = 'DT'
      UniqueName = 'DT'
    end
    object cxDBPivotGrid1DOCID: TcxDBPivotGridField
      AreaIndex = 2
      DataBinding.FieldName = 'DOCID'
      UniqueName = 'DOCID'
    end
    object cxDBPivotGrid1DATA: TcxDBPivotGridField
      Area = faColumn
      AreaIndex = 0
      IsCaptionAssigned = True
      Caption = 'Data'
      DataBinding.FieldName = 'DATA'
      Visible = True
      UniqueName = 'DATA'
    end
    object cxDBPivotGrid1GOODSID: TcxDBPivotGridField
      Area = faRow
      AreaIndex = 4
      IsCaptionAssigned = True
      Caption = 'Cod produs'
      DataBinding.FieldName = 'GOODSID'
      Visible = True
      Width = 64
      UniqueName = 'GOODSID'
    end
    object cxDBPivotGrid1GOODS_NAME: TcxDBPivotGridField
      Area = faRow
      AreaIndex = 5
      IsCaptionAssigned = True
      Caption = 'Denumire produs'
      DataBinding.FieldName = 'GOODS_NAME'
      Visible = True
      Width = 250
      UniqueName = 'GOODS_NAME'
    end
    object cxDBPivotGrid1SUMAMDL_IN: TcxDBPivotGridField
      Area = faData
      AreaIndex = 1
      IsCaptionAssigned = True
      Caption = 'Suma Intrare'
      DataBinding.FieldName = 'SUMAMDL_IN'
      Visible = True
      Width = 70
      UniqueName = 'SUMAMDL_IN'
    end
    object cxDBPivotGrid1SUMAMDL_OUT: TcxDBPivotGridField
      Area = faData
      AreaIndex = 2
      IsCaptionAssigned = True
      Caption = 'Suma Vinzare'
      DataBinding.FieldName = 'SUMAMDL_OUT'
      Visible = True
      Width = 74
      UniqueName = 'SUMAMDL_OUT'
    end
    object cxDBPivotGrid1WEBGOODSTYPE_ID: TcxDBPivotGridField
      AreaIndex = 7
      IsCaptionAssigned = True
      Caption = 'Cod tip produs'
      DataBinding.FieldName = 'WEBGOODSTYPE_ID'
      UniqueName = 'WEBGOODSTYPE_ID'
    end
    object cxDBPivotGrid1WEBGOODSTYPE_NAME: TcxDBPivotGridField
      Area = faRow
      AreaIndex = 2
      IsCaptionAssigned = True
      Caption = 'Tip produs'
      DataBinding.FieldName = 'WEBGOODSTYPE_NAME'
      Visible = True
      UniqueName = 'WEBGOODSTYPE_NAME'
    end
    object cxDBPivotGrid1VENDORID: TcxDBPivotGridField
      AreaIndex = 3
      DataBinding.FieldName = 'VENDORID'
      UniqueName = 'VENDORID'
    end
    object cxDBPivotGrid1VENDOR_NAME: TcxDBPivotGridField
      AreaIndex = 4
      DataBinding.FieldName = 'VENDOR_NAME'
      Visible = True
      UniqueName = 'VENDOR_NAME'
    end
    object cxDBPivotGrid1PARENTID: TcxDBPivotGridField
      AreaIndex = 5
      DataBinding.FieldName = 'PARENTID'
      UniqueName = 'PARENTID'
    end
    object cxDBPivotGrid1PARENT_NAME: TcxDBPivotGridField
      Area = faRow
      AreaIndex = 3
      IsCaptionAssigned = True
      Caption = 'Mapa'
      DataBinding.FieldName = 'PARENT_NAME'
      Visible = True
      UniqueName = 'PARENT_NAME'
    end
    object cxDBPivotGrid1USERID: TcxDBPivotGridField
      AreaIndex = 6
      DataBinding.FieldName = 'USERID'
      UniqueName = 'USERID'
    end
    object cxDBPivotGrid1QTY: TcxDBPivotGridField
      Area = faData
      AreaIndex = 0
      IsCaptionAssigned = True
      Caption = 'Cant'
      DataBinding.FieldName = 'QTY'
      Visible = True
      Width = 39
      UniqueName = 'QTY'
    end
  end
  object dxStatusBar1: TdxStatusBar
    Left = 0
    Top = 581
    Width = 1153
    Height = 20
    Panels = <>
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
  end
  object DialogTitle1: TDialogTitle
    Left = 0
    Top = 0
    Width = 1153
    Height = 64
    Title = 'Analiza vinzari pe grupe de produse'
    Text = ''
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
    ImageIndex = 25
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
    Left = 584
    Top = 312
    PixelsPerInch = 96
    DockControlHeights = (
      0
      0
      28
      0)
    object dxBarManager1Bar1: TdxBar
      Caption = 'Custom 1'
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 0
      DockedTop = 0
      DockingStyle = dsTop
      FloatLeft = 1187
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udWidth]
          UserWidth = 81
          Visible = True
          ItemName = 'dxBarDateCombo1'
        end
        item
          UserDefine = [udWidth]
          UserWidth = 81
          Visible = True
          ItemName = 'dxBarDateCombo2'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'dxBarButton1'
        end
        item
          Visible = True
          ItemName = 'dxBarButton2'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarDateCombo1: TdxBarDateCombo
      Caption = 'Perioada'
      Category = 0
      Hint = 'Perioada'
      Visible = ivAlways
      Glyph.SourceDPI = 96
      Glyph.Data = {
        424D360400000000000036000000280000001000000010000000010020000000
        000000000000C40E0000C40E00000000000000000000FF00FFFFFF00FFFFFF00
        FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
        FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
        FFFFFF00FFFF000000FF000000FF000000FF000000FF000000FF000000FF0000
        00FF000000FF000000FF000000FF000000FFFF00FFFFFF00FFFFFF00FFFFFF00
        FFFFFF00FFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF00FFFF000000FF000000FF0000
        00FF000000FF000000FFFFFFFFFF000000FF000000FF000000FF000000FF0000
        00FF000000FF000000FFFFFFFFFF000000FFFF00FFFF000000FFFFFFFFFFFFFF
        FFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF00FFFF000000FFFFFFFFFF0000
        00FF000000FF000000FFFFFFFFFFFFFFFFFFFFFFFFFF000080FF000080FFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF00FFFF000000FFFFFFFFFFFFFF
        FFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFF000080FF000080FFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF00FFFF000000FFFFFFFFFFFFFF
        FFFF000080FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000080FF0000
        80FFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF00FFFF000000FFFFFFFFFFFFFF
        FFFF000080FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000
        80FF000080FFFFFFFFFFFFFFFFFF000000FFFF00FFFF000000FFFFFFFFFFFFFF
        FFFF000080FF000000FFFFFFFFFFFFFFFFFF000080FF000080FF000080FF0000
        80FF000080FFFFFFFFFFFFFFFFFF000000FFFF00FFFF000000FFFFFFFFFFFFFF
        FFFF000080FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF00FFFF000000FFFFFFFFFFFFFF
        FFFF000080FF000000FF800000FF800000FF800000FF800000FF800000FF8000
        00FF800000FF800000FF800000FF000000FFFF00FFFF000000FFFFFFFFFFFFFF
        FFFFFFFFFFFF000000FF800000FF800000FF800000FF800000FF800000FF8000
        00FF800000FF800000FF800000FF000000FFFF00FFFF000000FF800000FF8000
        00FF800000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
        00FF000000FF000000FF000000FF000000FFFF00FFFF000000FF800000FF8000
        00FF800000FF800000FF800000FF800000FF800000FF800000FF800000FF0000
        00FFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF000000FF000000FF0000
        00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
        00FFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF}
      ShowCaption = True
      ShowDayText = False
    end
    object dxBarDateCombo2: TdxBarDateCombo
      Caption = '-'
      Category = 0
      Hint = '-'
      Visible = ivAlways
      Glyph.SourceDPI = 96
      Glyph.Data = {
        424D360400000000000036000000280000001000000010000000010020000000
        000000000000C40E0000C40E00000000000000000000FF00FFFFFF00FFFFFF00
        FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
        FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
        FFFFFF00FFFF000000FF000000FF000000FF000000FF000000FF000000FF0000
        00FF000000FF000000FF000000FF000000FFFF00FFFFFF00FFFFFF00FFFFFF00
        FFFFFF00FFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF00FFFF000000FF000000FF0000
        00FF000000FF000000FFFFFFFFFF000000FF000000FF000000FF000000FF0000
        00FF000000FF000000FFFFFFFFFF000000FFFF00FFFF000000FFFFFFFFFFFFFF
        FFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF00FFFF000000FFFFFFFFFF0000
        00FF000000FF000000FFFFFFFFFFFFFFFFFFFFFFFFFF000080FF000080FFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF00FFFF000000FFFFFFFFFFFFFF
        FFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFF000080FF000080FFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF00FFFF000000FFFFFFFFFFFFFF
        FFFF000080FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000080FF0000
        80FFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF00FFFF000000FFFFFFFFFFFFFF
        FFFF000080FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000
        80FF000080FFFFFFFFFFFFFFFFFF000000FFFF00FFFF000000FFFFFFFFFFFFFF
        FFFF000080FF000000FFFFFFFFFFFFFFFFFF000080FF000080FF000080FF0000
        80FF000080FFFFFFFFFFFFFFFFFF000000FFFF00FFFF000000FFFFFFFFFFFFFF
        FFFF000080FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF00FFFF000000FFFFFFFFFFFFFF
        FFFF000080FF000000FF800000FF800000FF800000FF800000FF800000FF8000
        00FF800000FF800000FF800000FF000000FFFF00FFFF000000FFFFFFFFFFFFFF
        FFFFFFFFFFFF000000FF800000FF800000FF800000FF800000FF800000FF8000
        00FF800000FF800000FF800000FF000000FFFF00FFFF000000FF800000FF8000
        00FF800000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
        00FF000000FF000000FF000000FF000000FFFF00FFFF000000FF800000FF8000
        00FF800000FF800000FF800000FF800000FF800000FF800000FF800000FF0000
        00FFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF000000FF000000FF0000
        00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
        00FFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF}
      ShowCaption = True
      ShowDayText = False
    end
    object dxBarButton1: TdxBarButton
      Caption = 'Executa'
      Category = 0
      Hint = 'Executa'
      Visible = ivAlways
      ImageIndex = 71
      OnClick = dxBarButton1Click
    end
    object dxBarButton2: TdxBarButton
      Caption = 'Exporta'
      Category = 0
      Hint = 'Exporta'
      Visible = ivAlways
      OnClick = dxBarButton2Click
    end
  end
  object IBCQueryAnalizaVinzari: TIBCQuery
    SQL.Strings = (
      
        'select z.*, u.Last_Name ||'#39' '#39'|| u.First_Name UserName from RP_AN' +
        'ALIZA_VINZARI (:data1, :data2) z'
      'left outer join ts_users u on u.userid=z.userid')
    Left = 464
    Top = 312
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'data1'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'data2'
        ParamType = ptInput
        Value = nil
      end>
  end
  object IBCDataSourceAnalizaVinzari: TIBCDataSource
    DataSet = IBCQueryAnalizaVinzari
    Left = 328
    Top = 312
  end
end
