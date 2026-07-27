object frmChooseGoodsDlg: TfrmChooseGoodsDlg
  Left = 0
  Top = 0
  ActiveControl = cxGrid1
  BorderStyle = bsDialog
  Caption = 'Alege produsul din lista'
  ClientHeight = 458
  ClientWidth = 552
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 15
  object DialogTitle1: TDialogTitle
    Left = 0
    Top = 0
    Width = 552
    Height = 64
    Title = 'Lista de produse vindute clientuliu'
    Text = 'Alegeti produsul care trebuie returnat'
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
    ImageIndex = 17
  end
  object cxButton1: TcxButton
    Left = 336
    Top = 421
    Width = 90
    Height = 29
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 5
  end
  object cxButton2: TcxButton
    Left = 440
    Top = 421
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 6
  end
  object cxGrid1: TcxGrid
    Left = 8
    Top = 104
    Width = 537
    Height = 297
    TabOrder = 4
    object cxGrid1DBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = IBCDataSourceGoodsList
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
      object cxGrid1DBTableView1DOCID: TcxGridDBColumn
        Caption = 'docid'
        DataBinding.FieldName = 'DOCID'
        Width = 56
      end
      object cxGrid1DBTableView1DATA: TcxGridDBColumn
        Caption = 'Data'
        DataBinding.FieldName = 'DATA'
        Width = 80
      end
      object cxGrid1DBTableView1GOODSID: TcxGridDBColumn
        Caption = 'Cod'
        DataBinding.FieldName = 'GOODSID'
        Width = 50
      end
      object cxGrid1DBTableView1GOODSNAME: TcxGridDBColumn
        Caption = 'Denumire'
        DataBinding.FieldName = 'GOODSNAME'
        Width = 429
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
    end
  end
  object IBCQueryGoodsList: TIBCQuery
    SQL.Strings = (
      'SELECT * '
      '  FROM get_sell_goods(:CUSTOMERID, :UNTIL_DATE)'
      'ORDER BY DATA desc, DOCID, GOODSNAME')
    Constraints = <>
    Left = 440
    Top = 8
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CUSTOMERID'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'UNTIL_DATE'
        Value = nil
      end>
  end
  object IBCDataSourceGoodsList: TIBCDataSource
    DataSet = IBCQueryGoodsList
    Left = 360
    Top = 8
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
    Left = 224
    Top = 8
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
      Caption = 'Custom 1'
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 0
      DockedTop = 0
      DockingStyle = dsTop
      FloatLeft = 792
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbSelectSerialNumber'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object bbSelectSerialNumber: TdxBarButton
      Caption = 'Alege seria / partida...'
      Category = 0
      Hint = 'Alege seria / partida'
      Visible = ivAlways
      ImageIndex = 30
      OnClick = bbSelectSerialNumberClick
    end
  end
  object IBCQuerySupplierInfo: TIBCQuery
    Connection = dmDB.IBCConnection
    Constraints = <>
    Left = 264
    Top = 232
  end
  object IBCDataSourceSupplierInfo: TIBCDataSource
    DataSet = IBCQuerySupplierInfo
    Left = 152
    Top = 208
  end
end
