inherited frame85Apeluri: Tframe85Apeluri
  Font.Height = -15
  PixelsPerInch = 120
  object cxGrid1: TcxGrid
    Left = 0
    Top = 0
    Width = 986
    Height = 468
    Align = alClient
    TabOrder = 0
    object cxGrid1DBTableView1: TcxGridDBTableView
      FilterRow.SeparatorWidth = 8
      FixedDataRows.SeparatorWidth = 8
      NewItemRow.SeparatorWidth = 8
      OptionsView.NavigatorOffset = 63
      OptionsView.FixedColumnSeparatorWidth = 3
      Preview.LeftIndent = 25
      Preview.RightIndent = 6
      RowLayout.MinValueWidth = 100
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
    end
  end
  object cxGrid2: TcxGrid
    Left = 0
    Top = 468
    Width = 986
    Height = 200
    Align = alBottom
    TabOrder = 1
    object cxGrid2DBTableView1: TcxGridDBTableView
      FilterRow.SeparatorWidth = 8
      FixedDataRows.SeparatorWidth = 8
      NewItemRow.SeparatorWidth = 8
      OptionsView.NavigatorOffset = 63
      OptionsView.FixedColumnSeparatorWidth = 3
      Preview.LeftIndent = 25
      Preview.RightIndent = 6
      RowLayout.MinValueWidth = 100
    end
    object cxGrid2Level1: TcxGridLevel
      GridView = cxGrid2DBTableView1
    end
  end
end
