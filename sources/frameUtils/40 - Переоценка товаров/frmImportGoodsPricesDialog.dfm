object frmImportGoodsPricesDlg: TfrmImportGoodsPricesDlg
  Left = 0
  Top = 0
  ActiveControl = cxSpreadSheet
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Import produse si reevaluare preturi din Excel'
  ClientHeight = 688
  ClientWidth = 1327
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 15
  object DialogTitle1: TDialogTitle
    Left = 0
    Top = 0
    Width = 1327
    Height = 64
    Title = 'Import produse si reevaluare preturi din Excel'
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
    ImageIndex = 0
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 0
    Top = 64
    Width = 1327
    Height = 555
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 8
    Align = alClient
    BevelOuter = bvNone
    Caption = 'pnClient'
    TabOrder = 1
    object dxBarDockControl1: TdxBarDockControl
      Left = 0
      Top = 0
      Width = 1327
      Height = 30
      Align = dalTop
      BarManager = dxBarManager1
      SunkenBorder = True
      UseOwnSunkenBorder = True
    end
    object cxPageControl1: TcxPageControl
      Left = 0
      Top = 30
      Width = 1327
      Height = 525
      Align = alClient
      TabOrder = 1
      Properties.ActivePage = cxTabSheet2
      Properties.CustomButtons.Buttons = <>
      Properties.HideTabs = True
      ClientRectBottom = 521
      ClientRectLeft = 4
      ClientRectRight = 1323
      ClientRectTop = 4
      object cxTabSheet2: TcxTabSheet
        Caption = 'cxTabSheet2'
        ImageIndex = 1
        object cxSpreadSheet: TdxSpreadSheet
          Left = 0
          Top = 0
          Width = 1319
          Height = 517
          Align = alClient
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial Narrow'
          Font.Style = []
          LookAndFeel.NativeStyle = False
          LookAndFeel.SkinName = 'Whiteprint'
          ParentFont = False
          Data = {
            9802000044585353763242461000000042465320000000000000000001000101
            010100000100000001004246532000000000424653200100000001000000200B
            00000007000000430061006C0069006200720069000000000000002000000020
            0000000020000000000020000000000020000000000020000007000000470045
            004E004500520041004C00000000000002000000000000000001424653200100
            0000424653201700000054006400780053007000720065006100640053006800
            6500650074005400610062006C00650056006900650077000600000053006800
            650065007400310001FFFFFFFFFFFFFFFF640000000200000002000000020000
            0055000000140000000200000002000000000200000002000000000000010000
            0000000101000042465320550000000000000042465320000000004246532014
            0000000000000042465320000000000000000000000000010000000000000000
            0000000000000000000000424653200000000002020000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000064000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000200020200020000000000000000000000000000000000020000000000
            0000000000000000000000000000000000000000000000000000000000000202
            0000000000000000424653200000000000000000000000000000000000000000
            0C00000053002E004D0069006E00630068006500760069006300690000000000
            000000000000000000000000337E43F54DA1E5400000000000000000}
        end
      end
    end
  end
  object pnButtons: TPanel
    Left = 0
    Top = 627
    Width = 1327
    Height = 61
    Align = alBottom
    BevelOuter = bvNone
    Padding.Top = 16
    Padding.Bottom = 16
    ShowCaption = False
    TabOrder = 2
    object Shape1: TShape
      Left = 4
      Top = 3
      Width = 37
      Height = 15
      Brush.Color = 26367
      Pen.Color = 26367
      Pen.Width = 3
      Shape = stRoundRect
    end
    object Label1: TLabel
      Left = 51
      Top = 3
      Width = 169
      Height = 15
      Caption = 'Codurile produselor se dubleaza'
    end
    object Shape2: TShape
      Left = 268
      Top = 3
      Width = 37
      Height = 15
      Brush.Color = clRed
      Pen.Color = clRed
      Pen.Width = 3
      Shape = stRoundRect
    end
    object lbInfoUnlink: TLabel
      Left = 311
      Top = 3
      Width = 227
      Height = 15
      Caption = 'Asa cod nu exista pentru furnizorul selectat'
    end
    object Label3: TLabel
      Left = 12
      Top = 32
      Width = 164
      Height = 15
      Caption = '498-MDL    840-USD     976-EUR'
      Color = clCream
      ParentColor = False
      Transparent = True
    end
    object Label2: TLabel
      Left = 607
      Top = 3
      Width = 77
      Height = 15
      Caption = 'Produse gasite'
    end
    object Shape3: TShape
      Left = 564
      Top = 3
      Width = 37
      Height = 15
      Brush.Color = clGreen
      Pen.Color = clGreen
      Pen.Width = 3
      Shape = stRoundRect
    end
    object btnCancel: TcxButton
      AlignWithMargins = True
      Left = 1217
      Top = 16
      Width = 90
      Height = 29
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 20
      Margins.Bottom = 0
      Align = alRight
      Cancel = True
      Caption = 'Renunta'
      ModalResult = 2
      TabOrder = 4
    end
    object btnImport: TcxButton
      AlignWithMargins = True
      Left = 1090
      Top = 16
      Width = 111
      Height = 29
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 16
      Margins.Bottom = 0
      Align = alRight
      Caption = 'Importa'
      TabOrder = 3
      OnClick = btnImportClick
    end
    object lbUnlinkedGoods: TcxLabel
      Left = 274
      Top = 1
      AutoSize = False
      Caption = '0'
      ParentColor = False
      ParentFont = False
      Style.Color = clRed
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWhite
      Style.Font.Height = -11
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = [fsBold]
      Style.IsFontAssigned = True
      Properties.Alignment.Horz = taCenter
      Transparent = True
      Height = 17
      Width = 25
      AnchorX = 287
    end
    object lbNonIdenticalGoods: TcxLabel
      Left = 10
      Top = 1
      AutoSize = False
      Caption = '0'
      ParentColor = False
      ParentFont = False
      Style.Color = clRed
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWhite
      Style.Font.Height = -11
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = [fsBold]
      Style.IsFontAssigned = True
      Properties.Alignment.Horz = taCenter
      Transparent = True
      Height = 17
      Width = 25
      AnchorX = 23
    end
    object lbFoundGoods: TcxLabel
      Left = 569
      Top = 1
      AutoSize = False
      Caption = '0'
      ParentColor = False
      ParentFont = False
      Style.Color = clRed
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWhite
      Style.Font.Height = -11
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = [fsBold]
      Style.IsFontAssigned = True
      Properties.Alignment.Horz = taCenter
      Transparent = True
      Height = 17
      Width = 32
      AnchorX = 585
    end
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
    ImageOptions.StretchGlyphs = False
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 588
    Top = 16
    PixelsPerInch = 96
    object dxBarManager1Bar1: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Custom 1'
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1007
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          Visible = True
          ItemName = 'bbOpenFile'
        end
        item
          Visible = True
          ItemName = 'bbSaveAs'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarSubItem2'
        end
        item
          Visible = True
          ItemName = 'bb1'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarProgressItem1'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object bbOpenFile: TdxBarButton
      Caption = 'Deschide fisier'
      Category = 0
      Hint = 'Deschide fisier'
      Visible = ivAlways
      ImageIndex = 13
      PaintStyle = psCaption
      OnClick = bbOpenFileClick
    end
    object bbClearAll: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 35
    end
    object dxBarSubItem2: TdxBarSubItem
      Caption = 'Setari'
      Category = 0
      Visible = ivAlways
      ImageIndex = 81
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbCodeNeuron'
        end
        item
          Visible = True
          ItemName = 'bbCodeVendor'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbGridHeader'
        end
        item
          Visible = True
          ItemName = 'bbGetCurrencyToSheet'
        end
        item
          Visible = True
          ItemName = 'dxBarButton2'
        end
        item
          Visible = True
          ItemName = 'bbRRPCurrency'
        end
        item
          Visible = True
          ItemName = 'bbCurrency7'
        end>
    end
    object bbCodeNeuron: TdxBarButton
      Caption = 'Cod produs intern'
      Category = 0
      Hint = 'Cod produs intern'
      Visible = ivAlways
      ButtonStyle = bsChecked
      GroupIndex = 1
    end
    object bbCodeVendor: TdxBarButton
      Caption = 'Cod produse furnizor...'
      Category = 0
      Hint = 'Cod produse furnizor'
      Visible = ivAlways
      ButtonStyle = bsChecked
      GroupIndex = 1
      Down = True
    end
    object bbGridHeader: TdxBarButton
      Caption = 'Denumirea colonitelor'
      Category = 0
      Hint = 'Denumirea colonitelor'
      Visible = ivAlways
      ButtonStyle = bsChecked
      Down = True
    end
    object bbGoods: TdxBarButton
      Caption = 'Cauta produs'
      Category = 0
      Hint = 'Cauta produs'
      Visible = ivAlways
      ImageIndex = 4
      ShortCut = 16468
    end
    object beCustomer1: TcxBarEditItem
      Caption = 'Furnizor'
      Category = 0
      Hint = 'Furnizor'
      Style = dmAdditions.cxStyle_DocInSpector_Parent
      Visible = ivNever
      ShowCaption = True
      PropertiesClassName = 'TcxButtonEditProperties'
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      Properties.LookupItems.Strings = (
        'DOXY')
      Properties.ViewStyle = vsHideCursor
      Properties.OnButtonClick = beCustomerPropertiesButtonClick
      InternalEditValue = nil
    end
    object dxBarProgressItem1: TdxBarProgressItem
      Caption = 'Progress'
      Category = 0
      Hint = 'Progress'
      Visible = ivNever
      Width = 500
    end
    object bbSaveAs: TdxBarButton
      Caption = 'Salveaza'
      Category = 0
      Hint = 'Salveaza'
      Visible = ivAlways
      ImageIndex = 32
      PaintStyle = psCaptionInMenu
      OnClick = bbSaveAsClick
    end
    object dxBarButton1: TdxBarButton
      Caption = 'Copy to Clipboard'
      Category = 0
      Hint = 'Copy to Clipboard'
      Visible = ivAlways
      ShortCut = 16451
    end
    object bbPaste: TdxBarButton
      Caption = 'Paste'
      Category = 0
      Hint = 'Paste'
      Visible = ivAlways
      ShortCut = 16470
    end
    object dxBarSubItem3: TdxBarSubItem
      Caption = 'Modifica'
      Category = 0
      Visible = ivAlways
      ItemLinks = <>
    end
    object bb1: TdxBarButton
      Caption = 'Valideaza'
      Category = 0
      Hint = 'Valideaza'
      Visible = ivAlways
      ImageIndex = 43
      PaintStyle = psCaptionGlyph
      ShortCut = 120
      OnClick = bb1Click
    end
    object cmbValuta4: TdxBarCombo
      Caption = 'Valuta 4'
      Category = 0
      Hint = 'Valuta 4'
      Visible = ivAlways
      ShowCaption = True
      Text = 'MDL'
      Items.Strings = (
        'MDL'
        'USD'
        'EUR')
      ItemIndex = 0
    end
    object cmbValuta7: TdxBarCombo
      Caption = 'Valuta 7'
      Category = 0
      Hint = 'Valuta 7'
      Visible = ivAlways
      ShowCaption = True
      Text = 'USD'
      Items.Strings = (
        'MDL'
        'USD'
        'EUR')
      ItemIndex = 1
    end
    object bbGetCurrencyToSheet: TdxBarButton
      Caption = 'Valuta la validare'
      Category = 0
      Hint = 'Valuta la validare'
      Visible = ivAlways
      ButtonStyle = bsChecked
    end
    object dxBarButton2: TdxBarButton
      Caption = 'Seteaza RPP pentru toate produsele'
      Category = 0
      Hint = 'Seteaza RPP pentru toate produsele'
      Visible = ivAlways
      OnClick = dxBarButton2Click
    end
    object bbRRPCurrency: TdxBarButton
      Caption = 'Seteaza valuta RRP'
      Category = 0
      Hint = 'Seteaza valuta RRP'
      Visible = ivAlways
      OnClick = bbRRPCurrencyClick
    end
    object bbCurrency7: TdxBarButton
      Caption = 'Seteaza Valuta 7'
      Category = 0
      Hint = 'Seteaza Valuta 7'
      Visible = ivAlways
      OnClick = bbCurrency7Click
    end
  end
  object IBCQuery: TIBCQuery
    Connection = dmDB.IBCConnection
    Left = 392
    Top = 208
  end
  object dxBarPopupMenu1: TdxBarPopupMenu
    BarManager = dxBarManager1
    ItemLinks = <>
    UseOwnFont = False
    Left = 394
    Top = 134
    PixelsPerInch = 96
  end
end
