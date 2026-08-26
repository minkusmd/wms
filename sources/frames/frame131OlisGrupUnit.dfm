object frame131OligGrup: Tframe131OligGrup
  Left = 0
  Top = 0
  Margins.Left = 4
  Margins.Top = 4
  Margins.Right = 4
  Margins.Bottom = 4
  ClientHeight = 803
  ClientWidth = 1729
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Segoe UI'
  Font.Style = []
  PixelsPerInch = 120
  TextHeight = 20
  object cxGrid1: TcxGrid
    Left = 0
    Top = 0
    Width = 1729
    Height = 511
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Align = alTop
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
end
