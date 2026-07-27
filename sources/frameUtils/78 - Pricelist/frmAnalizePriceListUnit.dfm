object frmAnalizePriceListDlg: TfrmAnalizePriceListDlg
  Left = 0
  Top = 0
  Caption = 'frmAnalizePriceListDlg'
  ClientHeight = 609
  ClientWidth = 1165
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object cxPageControl1: TcxPageControl
    Left = 200
    Top = 32
    Width = 957
    Height = 537
    TabOrder = 0
    Properties.ActivePage = tbsAllPriceList
    Properties.CustomButtons.Buttons = <>
    ClientRectBottom = 533
    ClientRectLeft = 4
    ClientRectRight = 953
    ClientRectTop = 26
    object tbsAllPriceList: TcxTabSheet
      Caption = 'Toate produsele'
      ImageIndex = 0
      object cxGrid1: TcxGrid
        Left = 3
        Top = 3
        Width = 926
        Height = 479
        TabOrder = 0
        object cxGrid1DBTableView1: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          ScrollbarAnnotations.CustomAnnotations = <>
          DataController.DataSource = IBCDataSource1
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          object cxGrid1DBTableView1PLID: TcxGridDBColumn
            DataBinding.FieldName = 'PLID'
            DataBinding.IsNullValueType = True
          end
          object cxGrid1DBTableView1SUPPLIER_GOODS_CODE: TcxGridDBColumn
            DataBinding.FieldName = 'SUPPLIER_GOODS_CODE'
            DataBinding.IsNullValueType = True
            Width = 70
          end
          object cxGrid1DBTableView1GOODSID: TcxGridDBColumn
            DataBinding.FieldName = 'GOODSID'
            DataBinding.IsNullValueType = True
          end
          object cxGrid1DBTableView1SUPPLIER_GOODS_NAME: TcxGridDBColumn
            DataBinding.FieldName = 'SUPPLIER_GOODS_NAME'
            DataBinding.IsNullValueType = True
            Width = 350
          end
          object cxGrid1DBTableView1AVAILABILITY: TcxGridDBColumn
            DataBinding.FieldName = 'AVAILABILITY'
            DataBinding.IsNullValueType = True
          end
          object cxGrid1DBTableView1FLAGS: TcxGridDBColumn
            DataBinding.FieldName = 'FLAGS'
            DataBinding.IsNullValueType = True
          end
          object cxGrid1DBTableView1PRICE0: TcxGridDBColumn
            DataBinding.FieldName = 'PRICE0'
            DataBinding.IsNullValueType = True
          end
          object cxGrid1DBTableView1PRICE7: TcxGridDBColumn
            DataBinding.FieldName = 'PRICE7'
            DataBinding.IsNullValueType = True
          end
          object cxGrid1DBTableView1WARANTY: TcxGridDBColumn
            DataBinding.FieldName = 'WARANTY'
            DataBinding.IsNullValueType = True
          end
        end
        object cxGrid1Level1: TcxGridLevel
          GridView = cxGrid1DBTableView1
        end
      end
    end
    object cxTabSheet1: TcxTabSheet
      Caption = 'Produse noi'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
    end
    object cxTabSheet2: TcxTabSheet
      Caption = 'Produse eliminate'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
    end
    object cxTabSheet3: TcxTabSheet
      Caption = 'Preturi marite'
      ImageIndex = 3
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
    end
    object cxTabSheet4: TcxTabSheet
      Caption = 'Preturi scazute'
      ImageIndex = 4
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
    end
  end
  object btnClose: TcxButton
    Left = 1043
    Top = 575
    Width = 90
    Height = 29
    Caption = 'Inchide'
    ModalResult = 8
    TabOrder = 1
  end
  object Panel1: TPanel
    Left = 0
    Top = 28
    Width = 185
    Height = 581
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 6
    object Label1: TLabel
      Left = 16
      Top = 12
      Width = 78
      Height = 15
      Caption = 'Pricelist curent'
    end
    object Label2: TLabel
      Left = 16
      Top = 62
      Width = 85
      Height = 15
      Caption = 'Pricelist anterior'
    end
    object cxLookupComboBox1: TcxLookupComboBox
      Left = 24
      Top = 33
      Properties.ListColumns = <>
      TabOrder = 0
      Width = 145
    end
    object cxLookupComboBox2: TcxLookupComboBox
      Left = 24
      Top = 81
      Properties.ListColumns = <>
      TabOrder = 1
      Width = 145
    end
    object cxButton1: TcxButton
      Left = 94
      Top = 120
      Width = 75
      Height = 25
      Caption = 'Refresh'
      TabOrder = 2
    end
  end
  object IBCQuery1: TIBCQuery
    SQL.Strings = (
      'select * From ts_pricelist_items')
    Left = 520
    Top = 312
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
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 552
    Top = 56
    PixelsPerInch = 96
    DockControlHeights = (
      0
      0
      28
      0)
    object dxBarManager1Bar1: TdxBar
      Caption = 'Main toolbar'
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 0
      DockedTop = 0
      DockingStyle = dsTop
      FloatLeft = 1089
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbPrepare'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbImport2Directory'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbReevaluare'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object bbImport2Directory: TdxBarButton
      Caption = 'Import in nomenclator'
      Category = 0
      Hint = 'Import in nomenclator'
      Visible = ivAlways
    end
    object bbReevaluare: TdxBarButton
      Caption = 'Reevaluarea preturilor'
      Category = 0
      Hint = 'Reevaluarea preturilor'
      Visible = ivAlways
    end
    object bbPrepare: TdxBarButton
      Caption = 'Modificare'
      Category = 0
      Hint = 'Modificare'
      Visible = ivAlways
    end
  end
  object IBCQueryCurrentPriceList: TIBCQuery
    SQL.Strings = (
      'select plid, data from ts_pricelist where supplierid=:supplierid')
    Left = 72
    Top = 176
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'supplierid'
        Value = nil
      end>
  end
  object IBCQueryOldPriceList: TIBCQuery
    SQL.Strings = (
      'select plid, data from ts_pricelist where supplierid=:supplierid')
    Left = 72
    Top = 224
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'supplierid'
        Value = nil
      end>
  end
  object IBCDataSource1: TIBCDataSource
    DataSet = IBCQuery1
    Left = 376
    Top = 280
  end
end
