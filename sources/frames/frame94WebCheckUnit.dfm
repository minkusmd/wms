inherited frame94WebCheck: Tframe94WebCheck
  Width = 1109
  Height = 588
  Font.Height = -15
  ExplicitWidth = 1109
  ExplicitHeight = 588
  PixelsPerInch = 120
  object cxPageControl1: TcxPageControl
    AlignWithMargins = True
    Left = 3
    Top = 35
    Width = 1103
    Height = 550
    Align = alClient
    TabOrder = 0
    Properties.ActivePage = cxTabSheet1
    Properties.CustomButtons.Buttons = <>
    ClientRectBottom = 546
    ClientRectLeft = 4
    ClientRectRight = 1099
    ClientRectTop = 32
    object cxTabSheet1: TcxTabSheet
      Caption = 'Produsele fara legatura pe web'
      ImageIndex = 0
      ExplicitTop = 29
      ExplicitHeight = 517
      object cxGrid1: TcxGrid
        Left = 0
        Top = 0
        Width = 1095
        Height = 514
        Align = alClient
        TabOrder = 0
        ExplicitHeight = 517
        object cxGrid1DBTableView1: TcxGridDBTableView
          OnKeyDown = cxGrid1DBTableView1KeyDown
          FindPanel.Behavior = fcbFilter
          FindPanel.DisplayMode = fpdmAlways
          FindPanel.FocusViewOnApplyFilter = True
          FindPanel.UseExtendedSyntax = True
          DataController.DataSource = IBCDataSourceGoodsNotInWeb
          DataController.KeyFieldNames = 'GOODSID'
          FilterRow.SeparatorWidth = 8
          FixedDataRows.SeparatorWidth = 8
          NewItemRow.SeparatorWidth = 8
          OptionsBehavior.IncSearch = True
          OptionsBehavior.ImmediateEditor = False
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.NavigatorOffset = 63
          OptionsView.ColumnAutoWidth = True
          OptionsView.FixedColumnSeparatorWidth = 3
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          Preview.LeftIndent = 25
          Preview.RightIndent = 6
          RowLayout.MinValueWidth = 100
          object cxGrid1DBTableView1PATH: TcxGridDBColumn
            Caption = 'BreadCrumb'
            DataBinding.FieldName = 'PATH'
            HeaderAlignmentHorz = taCenter
            Width = 450
          end
          object cxGrid1DBTableView1GOODSID: TcxGridDBColumn
            Caption = 'Cod'
            DataBinding.FieldName = 'GOODSID'
            HeaderAlignmentHorz = taCenter
            MinWidth = 78
            Options.HorzSizing = False
            Width = 78
          end
          object cxGrid1DBTableView1GOODS_NAME: TcxGridDBColumn
            Caption = 'Produs'
            DataBinding.FieldName = 'GOODS_NAME'
            HeaderAlignmentHorz = taCenter
            Width = 553
          end
        end
        object cxGrid1Level1: TcxGridLevel
          GridView = cxGrid1DBTableView1
        end
      end
    end
  end
  object dxBarDockControl1: TdxBarDockControl
    Left = 0
    Top = 0
    Width = 1109
    Height = 32
    Align = dalTop
    BarManager = dxBarManager1
  end
  object IBCQueryGoodsNotInWeb: TIBCQuery
    KeyFields = 'goodsid'
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      
        'select (select BREADCRUMB from get_goods_path(g.goodsid))path, g' +
        '.goodsid, g.title goods_name from ts_goods g'
      'join ts_goods gg on gg.goodsid = g.parentid'
      'where get_flg_in_price(g.goodsid)=1 and'
      'not exists(select * from GET_CATALOG_PATH(g.parentid))'
      'order by 1')
    Left = 120
    Top = 176
  end
  object IBCDataSourceGoodsNotInWeb: TIBCDataSource
    DataSet = IBCQueryGoodsNotInWeb
    Left = 120
    Top = 128
  end
  object dxBarManager1: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
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
    Left = 344
    Top = 144
    PixelsPerInch = 120
    object dxBarManager1Bar1: TdxBar
      Caption = 'WebCheckToolbar'
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1119
      FloatTop = 0
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbOpen'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object bbOpen: TdxBarButton
      Caption = 'Open'
      Category = 0
      Hint = 'Open'
      Visible = ivAlways
      ImageIndex = 79
      OnClick = bbOpenClick
    end
  end
end
