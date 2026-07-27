object frmPrepareGoodsForImportDlg: TfrmPrepareGoodsForImportDlg
  Left = 0
  Top = 0
  Caption = 'Analiza produselor'
  ClientHeight = 602
  ClientWidth = 944
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object dxSpreadSheet1: TdxSpreadSheet
    Left = 0
    Top = 48
    Width = 944
    Height = 554
    Align = alClient
    Data = {
      A802000044585353763242460D00000042465320000000000000000001000101
      010100000000000001004246532000000000424653200200000001000000200B
      00000007000000430061006C0069006200720069000000000000002000000020
      00000000200000000020000000002000000000200007000000470045004E0045
      00520041004C0000000000000200000000000000000101000000200B00000007
      000000430061006C006900620072006900000000000000200000002000000000
      200000000020000000002000000000200007000000470045004E004500520041
      004C000000000000020000000000000000014246532001000000424653201700
      0000540064007800530070007200650061006400530068006500650074005400
      610062006C006500560069006500770006000000530068006500650074003100
      01FFFFFFFFFFFFFFFF6400000002000000020000000200000055000000140000
      0002000000020000000002000000020000000000000100000000000101000042
      4653205500000000000000424653200000000042465320140000000000000042
      4653200000000000000000000000000100000000000000000000000000000000
      0000004246532000000000020200000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000640000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000200020200
      0200000000000000000000000000000000000200000000000000000000000000
      0000000000000000000000000000000000000000000002020000000000000000
      424653200000000000000000}
  end
  object dxSpreadSheetFormulaBar1: TdxSpreadSheetFormulaBar
    Left = 0
    Top = 25
    Width = 944
    Height = 23
    Align = alTop
    SpreadSheet = dxSpreadSheet1
    TabOrder = 1
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
    Left = 464
    Top = 304
    PixelsPerInch = 96
    DockControlHeights = (
      0
      0
      25
      0)
    object dxBarManager1Bar1: TdxBar
      Caption = 'Custom 1'
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 0
      DockedTop = 0
      DockingStyle = dsTop
      FloatLeft = 978
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      IsMainMenu = True
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbFile'
        end
        item
          Visible = True
          ItemName = 'dxBarSubItem1'
        end>
      MultiLine = True
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = True
    end
    object bbFileOpen: TdxBarButton
      Caption = 'Incarca'
      Category = 0
      Hint = 'Incarca'
      Visible = ivAlways
    end
    object bbFile: TdxBarSubItem
      Caption = 'File'
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbFileOpen'
        end
        item
          Visible = True
          ItemName = 'bbSave'
        end>
    end
    object bbSave: TdxBarButton
      Caption = 'Salveaza'
      Category = 0
      Hint = 'Salveaza'
      Visible = ivAlways
    end
    object dxBarSubItem1: TdxBarSubItem
      Caption = 'Produse'
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarButton2'
        end>
    end
    object dxBarButton2: TdxBarButton
      Caption = 'Valideaza'
      Category = 0
      Hint = 'Valideaza'
      Visible = ivAlways
      OnClick = dxBarButton2Click
    end
  end
end
