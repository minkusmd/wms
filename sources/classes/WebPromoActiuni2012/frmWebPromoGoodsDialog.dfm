object frmWebPromoGoodsDlg: TfrmWebPromoGoodsDlg
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Produse din promotii'
  ClientHeight = 736
  ClientWidth = 1558
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 1558
    Height = 64
    ImageOffset = 32
    Title = 'Produse din promotii'
    Text = ''
    FontTitle.Charset = DEFAULT_CHARSET
    FontTitle.Color = clWindowText
    FontTitle.Height = -16
    FontTitle.Name = 'Segoe UI'
    FontTitle.Style = [fsBold]
    FontText.Charset = DEFAULT_CHARSET
    FontText.Color = clWindowText
    FontText.Height = -13
    FontText.Name = 'Segoe UI'
    FontText.Style = []
    ImageList = dmAdditions.cxImageList_DialogIcons
    ImageIndex = 30
  end
  object pcPages: TcxPageControl
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 1542
    Height = 661
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Align = alClient
    TabOrder = 1
    TabStop = False
    Properties.ActivePage = cxTabSheet1
    Properties.CustomButtons.Buttons = <>
    Properties.Images = dmAdditions.cxImageList_SWN
    ClientRectBottom = 657
    ClientRectLeft = 4
    ClientRectRight = 1538
    ClientRectTop = 27
    object tbsGoods: TcxTabSheet
      Caption = 'Produse'
      ImageIndex = 44
      object cxGrid: TcxGrid
        Left = 0
        Top = 30
        Width = 1534
        Height = 555
        Align = alClient
        BevelInner = bvNone
        TabOrder = 1
        LookAndFeel.Kind = lfUltraFlat
        LookAndFeel.NativeStyle = True
        LookAndFeel.SkinName = ''
        object cxGridDBBandedTableView1: TcxGridDBBandedTableView
          PopupMenu = dxBarPopupMenu1
          OnKeyDown = cxGridDBBandedTableView1KeyDown
          Navigator.Buttons.First.Enabled = False
          Navigator.Buttons.First.Visible = False
          Navigator.Buttons.PriorPage.Visible = False
          Navigator.Buttons.Prior.Visible = False
          Navigator.Buttons.Next.Visible = False
          Navigator.Buttons.NextPage.Visible = False
          Navigator.Buttons.Last.Visible = False
          Navigator.Buttons.Insert.Visible = False
          Navigator.Buttons.Append.Enabled = False
          Navigator.Buttons.Delete.Enabled = False
          Navigator.Buttons.Delete.Visible = False
          Navigator.Buttons.Edit.Enabled = False
          Navigator.Buttons.Edit.Visible = False
          Navigator.Buttons.Post.Visible = True
          Navigator.Buttons.Cancel.Enabled = False
          Navigator.Buttons.Cancel.Visible = True
          Navigator.Buttons.Refresh.Visible = False
          Navigator.Buttons.SaveBookmark.Visible = False
          Navigator.Buttons.GotoBookmark.Visible = False
          Navigator.Buttons.Filter.Enabled = False
          Navigator.InfoPanel.Visible = True
          Navigator.Visible = True
          FindPanel.ApplyInputDelay = 500
          FindPanel.DisplayMode = fpdmAlways
          OnFocusedRecordChanged = cxGridDBBandedTableView1FocusedRecordChanged
          DataController.DataSource = IBCDataSourceGoods
          DataController.KeyFieldNames = 'GOODS_CODE;SUPPLIERID'
          DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
          OptionsBehavior.IncSearch = True
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Inserting = False
          OptionsSelection.MultiSelect = True
          OptionsSelection.HideSelection = True
          OptionsView.Footer = True
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          Bands = <
            item
              FixedKind = fkLeft
              Width = 840
            end
            item
              Caption = 'Preturi'
              Width = 305
            end
            item
              Caption = 'Reducere'
              Width = 204
            end
            item
              Width = 40
            end>
          ConditionalFormatting = {
            010000000A000000360000005400640078005300700072006500610064005300
            680065006500740043006F006E0064006900740069006F006E0061006C004600
            6F0072006D0061007400740069006E006700520075006C006500440075007000
            6C0069006300610074006500560061006C007500650073006D00000000000000
            0000000000000000FFFFFF7F0001FF0000000B00000007000000430061006C00
            6900620072006900000000000000200000002000000000200000000020000000
            002000000000200007000000470045004E004500520041004C00000000000002
            000000000000000001}
          object cxGridDBBandedTableView1_GOODSID: TcxGridDBBandedColumn
            Caption = 'Cod'
            DataBinding.FieldName = 'GOODSID'
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Width = 72
            Position.BandIndex = 0
            Position.ColIndex = 3
            Position.RowIndex = 0
          end
          object cxGridDBBandedTableView1_GOODS_NAME: TcxGridDBBandedColumn
            Caption = 'Produs'
            DataBinding.FieldName = 'GOODS_NAME'
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Width = 363
            Position.BandIndex = 0
            Position.ColIndex = 4
            Position.RowIndex = 0
          end
          object cxGridDBBandedTableView1_PRICE4: TcxGridDBBandedColumn
            Caption = 'Promo'
            DataBinding.FieldName = 'PRICE4'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            Properties.UseDisplayFormatWhenEditing = True
            Properties.UseThousandSeparator = True
            HeaderAlignmentHorz = taCenter
            Width = 82
            Position.BandIndex = 1
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object cxGridDBBandedTableView1_OLD_PRICE4: TcxGridDBBandedColumn
            Caption = 'Vechi'
            DataBinding.FieldName = 'OLD_PRICE4'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            Properties.UseDisplayFormatWhenEditing = True
            Properties.UseThousandSeparator = True
            HeaderAlignmentHorz = taCenter
            Width = 61
            Position.BandIndex = 1
            Position.ColIndex = 2
            Position.RowIndex = 0
          end
          object cxGridDBBandedTableView1_DISCOUNT_AMOUNT: TcxGridDBBandedColumn
            Caption = 'Valoarea'
            DataBinding.FieldName = 'DISCOUNT_AMOUNT'
            PropertiesClassName = 'TcxCalcEditProperties'
            Properties.OnEditValueChanged = cxGridDBBandedTableView1_DISCOUNT_AMOUNTPropertiesEditValueChanged
            HeaderAlignmentHorz = taCenter
            Options.IncSearch = False
            Options.GroupFooters = False
            Options.Grouping = False
            Width = 54
            Position.BandIndex = 2
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object cxGridDBBandedTableView1_DISCOUNT_TYPEID: TcxGridDBBandedColumn
            Caption = 'Tip'
            DataBinding.FieldName = 'DISCOUNT_TYPEID'
            PropertiesClassName = 'TcxImageComboBoxProperties'
            Properties.Images = cxImageList1
            Properties.Items = <
              item
                ImageIndex = 0
                Value = 0
              end
              item
                ImageIndex = 1
                Value = 1
              end>
            HeaderAlignmentHorz = taCenter
            Width = 35
            Position.BandIndex = 3
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object cxGridDBBandedTableView1_DISCOUNT_PERCENT: TcxGridDBBandedColumn
            Caption = '%'
            DataBinding.FieldName = 'DISCOUNT_PERCENT'
            PropertiesClassName = 'TcxCalcEditProperties'
            Properties.OnEditValueChanged = cxGridDBBandedTableView1_DISCOUNT_PERCENTPropertiesEditValueChanged
            HeaderAlignmentHorz = taCenter
            Options.IncSearch = False
            Options.GroupFooters = False
            Options.Grouping = False
            Width = 36
            Position.BandIndex = 2
            Position.ColIndex = 2
            Position.RowIndex = 0
          end
          object cxGridDBBandedTableView1_DISCOUNT_VALUE_MDL: TcxGridDBBandedColumn
            Caption = 'Valoarea, MDL'
            DataBinding.FieldName = 'DISCOUNT_VALUE_MDL'
            PropertiesClassName = 'TcxCalcEditProperties'
            HeaderAlignmentHorz = taCenter
            Width = 68
            Position.BandIndex = 2
            Position.ColIndex = 3
            Position.RowIndex = 0
          end
          object cxGridDBBandedTableView1_FLG_IN_PRICE: TcxGridDBBandedColumn
            AlternateCaption = 'In price'
            Caption = 'FP'
            DataBinding.FieldName = 'FLG_IN_PRICE'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.Alignment = taRightJustify
            Properties.ValueChecked = '1'
            Properties.ValueUnchecked = '0'
            HeaderAlignmentHorz = taCenter
            Width = 35
            Position.BandIndex = 3
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object cxGridDBBandedTableView1_CURRENCYID: TcxGridDBBandedColumn
            Caption = 'Valuta'
            DataBinding.FieldName = 'CURRENCYID'
            PropertiesClassName = 'TcxLookupComboBoxProperties'
            Properties.Alignment.Horz = taCenter
            Properties.DropDownListStyle = lsFixedList
            Properties.GridMode = True
            Properties.ImmediatePost = True
            Properties.KeyFieldNames = 'CURRENCYID'
            Properties.ListColumns = <
              item
                FieldName = 'TITLE'
              end>
            Properties.ListOptions.ShowHeader = False
            Properties.ListSource = IBCDataSourceCurrency
            HeaderAlignmentHorz = taCenter
            Width = 42
            Position.BandIndex = 1
            Position.ColIndex = 3
            Position.RowIndex = 0
          end
          object cxGridDBBandedTableView1_CURRENT_PRICE4: TcxGridDBBandedColumn
            Caption = 'P4 din catalog'
            DataBinding.FieldName = 'CURRENT_PRICE4'
            Visible = False
            HeaderAlignmentHorz = taCenter
            Styles.OnGetContentStyle = cgColorGalleryGetCustomColorSet
            Width = 118
            Position.BandIndex = 1
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object cxGridDBBandedTableView1_CASHBACK: TcxGridDBBandedColumn
            Caption = 'Cashback, %'
            DataBinding.FieldName = 'CASHBACK_PERCENT'
            Options.IncSearch = False
            Width = 72
            Position.BandIndex = 2
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object cxGridDBBandedTableView1Column1: TcxGridDBBandedColumn
            Caption = 'Furnizor'
            DataBinding.FieldName = 'SUPPLIER_NAME'
            Options.Editing = False
            Width = 81
            Position.BandIndex = 0
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object cxGridDBBandedTableView1_SupplierID: TcxGridDBBandedColumn
            Caption = 'Cod F'
            DataBinding.FieldName = 'SUPPLIERID'
            Width = 57
            Position.BandIndex = 0
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object cxGridDBBandedTableView1_LabelRO: TcxGridDBBandedColumn
            Caption = 'Hint ro'
            DataBinding.FieldName = 'LABEL_RO'
            Width = 108
            Position.BandIndex = 0
            Position.ColIndex = 5
            Position.RowIndex = 0
          end
          object cxGridDBBandedTableView1_LabelRU: TcxGridDBBandedColumn
            Caption = 'Hint ru'
            DataBinding.FieldName = 'LABEL_RU'
            Width = 106
            Position.BandIndex = 0
            Position.ColIndex = 6
            Position.RowIndex = 0
          end
          object cxGridDBBandedTableView1_CPF: TcxGridDBBandedColumn
            Caption = 'CPF'
            DataBinding.FieldName = 'GOODS_CODE'
            Width = 53
            Position.BandIndex = 0
            Position.ColIndex = 2
            Position.RowIndex = 0
          end
          object cxGridDBBandedTableView1_PRICE7: TcxGridDBBandedColumn
            Caption = 'Pret 7'
            DataBinding.FieldName = 'PRICE7'
            HeaderAlignmentHorz = taCenter
            Width = 62
            Position.BandIndex = 1
            Position.ColIndex = 4
            Position.RowIndex = 0
          end
          object cxGridDBBandedTableView1_CURRENCY7ID: TcxGridDBBandedColumn
            Caption = 'Val. 7'
            DataBinding.FieldName = 'CURRENCY7ID'
            HeaderAlignmentHorz = taCenter
            Width = 58
            Position.BandIndex = 1
            Position.ColIndex = 5
            Position.RowIndex = 0
          end
        end
        object cxGridLevel: TcxGridLevel
          GridView = cxGridDBBandedTableView1
          Options.DetailFrameWidth = 0
          Options.DetailTabsPosition = dtpTop
        end
      end
      object dxBarDockControl1: TdxBarDockControl
        Left = 0
        Top = 0
        Width = 1534
        Height = 30
        Align = dalTop
        BarManager = dxBarManager1
        SunkenBorder = True
        UseOwnSunkenBorder = True
      end
      object pnButtons: TPanel
        Left = 0
        Top = 585
        Width = 1534
        Height = 45
        Align = alBottom
        BevelKind = bkFlat
        BevelOuter = bvNone
        Color = clWindow
        Padding.Right = 24
        Padding.Bottom = 16
        ParentBackground = False
        ShowCaption = False
        TabOrder = 2
        object btnOk: TButton
          AlignWithMargins = True
          Left = 725
          Top = 8
          Width = 90
          Height = 25
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 16
          Margins.Bottom = 0
          Caption = 'OK'
          Default = True
          ModalResult = 1
          TabOrder = 1
        end
        object btnCancel: TButton
          Left = 829
          Top = 8
          Width = 90
          Height = 25
          Cancel = True
          Caption = 'Renunta'
          ModalResult = 2
          TabOrder = 2
        end
        object cxButton1: TcxButton
          Left = 8
          Top = 8
          Width = 90
          Height = 29
          Caption = 'Exporta'
          TabOrder = 0
          Visible = False
          OnClick = cxButton1Click
        end
      end
    end
    object cxTabSheet1: TcxTabSheet
      Caption = 'Import produse'
      ImageIndex = 144
      object dxBarDockControl2: TdxBarDockControl
        Left = 0
        Top = 0
        Width = 1534
        Height = 28
        Align = dalTop
        BarManager = dxBarManager1
      end
      object dxSpreadSheet1: TdxSpreadSheet
        Left = 0
        Top = 106
        Width = 1534
        Height = 430
        Align = alClient
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
          000000000000000000000000FD5708CE6E51E6400000000000000000}
      end
      object Panel1: TPanel
        Left = 0
        Top = 28
        Width = 1534
        Height = 78
        Align = alTop
        BevelKind = bkFlat
        BevelOuter = bvNone
        Color = clWindow
        ParentBackground = False
        TabOrder = 1
        object Label1: TLabel
          Left = 412
          Top = 50
          Width = 167
          Height = 15
          Caption = '840 - USD; 498 - MDL; 976 - EUR'
        end
        object rbSupplierGoodsCode: TcxRadioButton
          Left = 32
          Top = 24
          Width = 113
          Height = 17
          Caption = 'Cod furnizor'
          Checked = True
          TabOrder = 3
          TabStop = True
        end
        object rbInternalGoodsID: TcxRadioButton
          Left = 32
          Top = 47
          Width = 113
          Height = 17
          Caption = 'Cod intern'
          TabOrder = 10
        end
        object cxLabel1: TcxLabel
          Left = 16
          Top = 4
          Caption = 'Criterii pentru import'
          ParentFont = False
          TabOrder = 6
        end
        object beSupplier: TcxButtonEdit
          Tag = -1
          Left = 412
          Top = 21
          ParentFont = False
          Properties.Buttons = <
            item
              Default = True
              Kind = bkEllipsis
            end>
          Properties.OnButtonClick = beSupplierPropertiesButtonClick
          TabOrder = 1
          Text = '<Selecteaza furnizorul>'
          Width = 346
        end
        object cxLabel2: TcxLabel
          Left = 412
          Top = 4
          Caption = 'Alegeti furnizorul'
          ParentFont = False
          TabOrder = 7
        end
        object cbCurrPrice: TcxCheckBox
          Left = 189
          Top = 4
          Caption = 'Pretul curent in pret vechi'
          ParentFont = False
          Style.TransparentBorder = False
          TabOrder = 0
        end
        object lcbNewCurrency: TcxLookupComboBox
          Left = 207
          Top = 46
          ParentFont = False
          Properties.KeyFieldNames = 'CURRENCYID'
          Properties.ListColumns = <
            item
              FieldName = 'TITLE'
            end>
          Properties.ListSource = IBCDataSourceCurrency
          TabOrder = 4
          Visible = False
          Width = 65
        end
        object cxLabel3: TcxLabel
          Left = 207
          Top = 21
          Caption = 'Valuta noua'
          ParentFont = False
          TabOrder = 8
          Visible = False
        end
        object cxLabel4: TcxLabel
          Left = 278
          Top = 23
          Caption = 'Valuta veche'
          ParentFont = False
          TabOrder = 9
        end
        object lcbOldCurrency: TcxLookupComboBox
          Left = 278
          Top = 46
          ParentFont = False
          Properties.KeyFieldNames = 'CURRENCYID'
          Properties.ListColumns = <
            item
              FieldName = 'TITLE'
            end>
          Properties.ListSource = IBCDataSourceCurrency
          TabOrder = 5
          Width = 65
        end
        object cxButton2: TcxButton
          Left = 774
          Top = 22
          Width = 153
          Height = 25
          Caption = 'Pret curent in pret nou'
          TabOrder = 2
          OnClick = cxButton2Click
        end
      end
      object meErrors: TMemo
        Left = 0
        Top = 536
        Width = 1534
        Height = 94
        Align = alBottom
        ScrollBars = ssBoth
        TabOrder = 3
      end
    end
  end
  object dxBarManager1: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Default'
      'Web')
    Categories.ItemsVisibles = (
      2
      2)
    Categories.Visibles = (
      True
      True)
    ImageOptions.Images = dmAdditions.cxImageList_SWN
    ImageOptions.StretchGlyphs = False
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 668
    Top = 228
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
      FloatLeft = 579
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbAdd'
        end
        item
          Visible = True
          ItemName = 'bbAddBurstGoods'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbModify'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbDelete'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbDeleteAll'
        end
        item
          Visible = True
          ItemName = 'dxBarButton11'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarSubItem1'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbUpdatePrices'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbCreateRevaluation'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar2: TdxBar
      Caption = 'Custom 2'
      CaptionButtons = <>
      DockControl = dxBarDockControl2
      DockedDockControl = dxBarDockControl2
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1018
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbClearSheet'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbJsonImport'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbOpenFile'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbSaveToExcel'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbValidate'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'dxBarButton6'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object bbAdd: TdxBarButton
      Caption = 'Adauga'
      Category = 0
      Hint = 'Adauga'
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 45
      OnClick = bbAddClick
    end
    object bbDelete: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      ShortCut = 16430
      OnClick = bbDeleteClick
    end
    object bbDeleteAll: TdxBarButton
      Caption = 'Sterge tot...'
      Category = 0
      Hint = 'Sterge tot'
      Visible = ivAlways
      ImageIndex = 35
      OnClick = bbDeleteAllClick
    end
    object bbEditGoodsPrices: TdxBarButton
      Caption = 'New Button'
      Category = 0
      Hint = 'New Button'
      Visible = ivAlways
      ImageIndex = 91
      OnClick = bbEditGoodsPricesClick
    end
    object dxBarSubItem1: TdxBarSubItem
      Caption = 'Instrumente'
      Category = 0
      Visible = ivAlways
      ImageIndex = 81
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarButton7'
        end
        item
          Visible = True
          ItemName = 'dxBarButton8'
        end
        item
          Visible = True
          ItemName = 'dxBarButton9'
        end
        item
          Visible = True
          ItemName = 'dxBarButton13'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbSetHint'
        end
        item
          Visible = True
          ItemName = 'dxBarButton10'
        end
        item
          Visible = True
          ItemName = 'dxBarButton1'
        end
        item
          Visible = True
          ItemName = 'dxBarButton12'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'dxBarButton3'
        end
        item
          Visible = True
          ItemName = 'dxBarButton4'
        end
        item
          Visible = True
          ItemName = 'bbImportFromFirstPage'
        end>
    end
    object dxBarButton2: TdxBarButton
      Caption = 'Actualizeaza preturile'
      Category = 0
      Enabled = False
      Hint = 'Actualizeaza preturile'
      Visible = ivAlways
      ShortCut = 16466
      OnClick = dxBarButton2Click
    end
    object dxBarButton3: TdxBarButton
      Caption = 'Sortare'
      Category = 0
      Hint = 'Sortare'
      Visible = ivAlways
      ImageIndex = 38
      OnClick = dxBarButton3Click
    end
    object dxBarButton4: TdxBarButton
      Caption = 'Import...'
      Category = 0
      Hint = 'Import'
      Visible = ivAlways
      OnClick = dxBarButton4Click
    end
    object dxBarButton5: TdxBarButton
      Caption = 'Valideaza'
      Category = 0
      Hint = 'Valideaza'
      Visible = ivAlways
    end
    object dxBarButton6: TdxBarButton
      Caption = 'Importa'
      Category = 0
      Hint = 'Importa'
      Visible = ivAlways
      Glyph.SourceDPI = 96
      Glyph.SourceHeight = 16
      Glyph.SourceWidth = 16
      Glyph.Data = {
        3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D225554
        462D38223F3E0D0A3C7376672076657273696F6E3D22312E31222069643D224C
        617965725F312220786D6C6E733D22687474703A2F2F7777772E77332E6F7267
        2F323030302F7376672220786D6C6E733A786C696E6B3D22687474703A2F2F77
        77772E77332E6F72672F313939392F786C696E6B2220783D223070782220793D
        22307078222076696577426F783D2230203020333220333222207374796C653D
        22656E61626C652D6261636B67726F756E643A6E657720302030203332203332
        3B2220786D6C3A73706163653D227072657365727665223E262331333B262331
        303B3C7374796C6520747970653D22746578742F6373732220786D6C3A737061
        63653D227072657365727665223E2E5265647B66696C6C3A234431314331433B
        7D262331333B262331303B2623393B2E426C61636B7B66696C6C3A2337323732
        37323B7D262331333B262331303B2623393B2E426C75657B66696C6C3A233131
        373744373B7D262331333B262331303B2623393B2E477265656E7B66696C6C3A
        233033394332333B7D262331333B262331303B2623393B2E59656C6C6F777B66
        696C6C3A234646423131353B7D262331333B262331303B2623393B2E57686974
        657B66696C6C3A234646464646463B7D262331333B262331303B2623393B2E73
        74307B6F7061636974793A302E353B7D262331333B262331303B2623393B2E73
        74317B6F7061636974793A302E37353B7D262331333B262331303B2623393B2E
        7374327B6F7061636974793A302E32353B7D3C2F7374796C653E0D0A3C672069
        643D224C6F77496D706F7274616E6365223E0D0A09093C706F6C79676F6E2063
        6C6173733D22426C75652220706F696E74733D2231382C32302E332031382C34
        2031342C342031342C32302E3320362C31322E3320362C31382031362C323820
        32362C31382032362C31322E33202623393B222F3E0D0A093C2F673E0D0A3C2F
        7376673E0D0A}
      ShortCut = 120
      OnClick = dxBarButton6Click
    end
    object dxBarButton7: TdxBarButton
      Caption = 'Seteaza tip reducere'
      Category = 0
      Hint = 'Seteaza tip reducere'
      Visible = ivAlways
      OnClick = dxBarButton7Click
    end
    object dxBarButton8: TdxBarButton
      Caption = 'Vizualizare Tip / Suma'
      Category = 0
      Hint = 'Vizualizare Tip / Suma'
      Visible = ivAlways
      OnClick = dxBarButton8Click
    end
    object dxBarButton9: TdxBarButton
      Caption = 'Rotungeste preturile'
      Category = 0
      Hint = 'Rotungeste preturile'
      Visible = ivAlways
      OnClick = dxBarButton9Click
    end
    object dxBarButton10: TdxBarButton
      Caption = 'Calcula reducerea dupa valoare'
      Category = 0
      Hint = 'Calcula reducerea dupa valoare'
      Visible = ivAlways
      OnClick = dxBarButton10Click
    end
    object bbUpdatePrices: TdxBarButton
      Caption = 'Actualizeaza preturile'
      Category = 0
      Hint = 'Actualizeaza preturile'
      Visible = ivAlways
      Glyph.SourceDPI = 96
      Glyph.Data = {
        89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
        6100000027744558745469746C6500526566726573683B5265706561743B4261
        72733B526962626F6E3B52656C6F6164CD4DF6E90000030249444154785EA593
        6D4C926B18C76F018114A40D6D619DE98433AAE3F16D7CB173AC43666FE69C7A
        D4F48825339D4E6136D314EB2C23B46C332B957484A0522E5B6E2C31B537B437
        319BCECC17B2652D672FC715E03194AEEE875A6BB53E796DBFDDCF7EF7FFFFE1
        DAB3DB0500D052C6E5A7FEC73B70F2FDC89A4D48D664FA5A5AF5DB1FE4E8928B
        E2226D9F11FB0F04459A7B3D052A63DE0E71B11B91C10E77FA9D5D94DF70DF59
        4E93EB7EC957DF1B4F935FE009B3EBB7A59FE8704C59E6E185E503DC9D7C0B9A
        5B66D8A7BA33243AD4E087F3A4E9F98F683FD1959EBD8BF0B8E6D418BB1F3C9B
        855DA57A23871BC00C15D755FD99D508E1521DE49EB90E833356B8D4F71C726A
        7A460285F11EC48A92CF5D44D973CC50A8BDF504C6FE7780F2CA3044481AFEF5
        FE3598C1DD24F5E10A73F88109958A8DD94DF69E171638D53E0AA2A36D07885E
        E6E95E8476E6D5090AD57D0B66DB02F45B1661DC6A87B4B2F685E0D8C3422284
        21619605FC5DA148ADE884F303D3905C6630112EF5C40D449AB550D5BDBDA314
        D9C99BC862B52379ED6DF478E215C595B9AAFE4B9918D2CC4857CBE4F834A22D
        672287831C881D4B9B2F74232EE918CFA81283FDDA4B1B241CE9062F7E441076
        0C0C19438B2CD63F8A3AD8017187BB4033F61E88EFA8920E882CD24F92F8D1D5
        F3383467B3D846269EFE877CBC5928707372CAB7FFFFF9F01D890783BE98951E
        8628542ACACDDC88ACAF5E3B4C8656090ACBBD4C846802514DE9DEDAFBD038F4
        06E28F742F083395C7F91B44416BFEDACDA731BD38214995E519AA01A837CF41
        A2A213BC422455B8C744828C56E78E8C956B3921E226739666109A47DE81E4DC
        0024286E424CE935F83DA95A87337E41A92A93ECEA14B043F63F2451591CE78A
        01BB5B50DB14B105725D199C28F0FF47FD24EEF86D28D19B4139340BCAC15908
        2F6807DFF042317BCD9650FF14ED33EA8AB0F5384F65AC2B40889FD48CD1394F
        42D2D9BCD53E5BE515BC98DA21EC017BE0C52A877DB797CBC8547716CE786068
        74AE1411E0F90132C61DC3C67030DE18CF2F8EFC7D78C9CFF9136643522887EA
        10230000000049454E44AE426082}
      OnClick = bbUpdatePricesClick
    end
    object dxBarButton1: TdxBarButton
      Caption = 'Seteaza valoarea reducerii in %'
      Category = 0
      Hint = 'Seteaza valoarea reducerii in %'
      Visible = ivAlways
      OnClick = dxBarButton1Click
    end
    object dxBarButton12: TdxBarButton
      Caption = 'Seteaza valoarea reducerii'
      Category = 0
      Hint = 'Seteaza valoarea reducerii'
      Visible = ivAlways
      OnClick = dxBarButton12Click
    end
    object dxBarButton13: TdxBarButton
      Caption = 'Actualizeaza cashback pentru toate produsele'
      Category = 0
      Hint = 'Actualizeaza cashback pentru toate produsele'
      Visible = ivAlways
      OnClick = dxBarButton13Click
    end
    object bbModify: TdxBarButton
      Caption = 'Modifica'
      Category = 0
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 115
      OnClick = bbModifyClick
    end
    object bbValidate: TdxBarButton
      Caption = 'Valideaza'
      Category = 0
      Enabled = False
      Hint = 'Valideaza'
      Visible = ivAlways
      Glyph.SourceDPI = 96
      Glyph.Data = {
        89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
        6100000015744558745469746C6500436865636B3B4D61726B3B5469636B0B00
        C7240000026B49444154785E95924D48156B18C77F338D7A94B436816090828B
        8B94919BBE886304C5599CEA9A14145177211246AB3641F6B16861044610B408
        23C842FB2410B4ACB06BDDD55510823072532267A19E93E76BE6FDCAF3323910
        44F4303CFF7786797EFFE77978BD9B2FF6BE715DA7955F8589040CC63818345A
        99B13389D13D5EA9B87DDB05FE341EFC7B310EB89E5286824A912ABC8FDCA2F4
        F3BB9575952D48A9019C6580466B89D63FAAED4F51B11558585CA27A75259EE7
        A2748092060B2891941168AD4213EB132930323AC1FF935FA85B5FC3F12371A4
        F6114202E009A12C512AB5E2684AC931F67C7F708CB565BBB8717690AEAB5B48
        67965853E12382B003DF170855442AC9CC4C8AFEC7236C6DD9C4EE783323AF26
        A8ADDEC7A9F66EAEF49DA03D99205659812F0A148A3E165022E5FD1CD97C9EFE
        872FE9E9FA8F47AF6ED1737D809D1B4FD2D176817BC397A9AD536C68A822574C
        53EE6411225C621048842C10C880B644923BCFBA39DF7997C9E9C3FC55BF994C
        EE33E3538374FC93643E9BB2E355951510221C41488D6F013E750D352C6632DC
        7E728ED3477BC175B874AD93FD895616B2B380C618F0450E1128003C19683B93
        54826F6A9EA6E675BC1B9FE2E9EB5E1AEB9B70631962D5057C195877005FE6A3
        7B2084A628F30825D00616E51CDB7734F27CA88FBEE14F1C3BF437393F83C158
        773025C368075228029127500227BC44F3B9AF1C4CB652597E80B9F4478A4202
        7A05501405A20EA4B11DC4BC1AB02E1A6D0CE9FC1C0BB95930066F5585FD8E01
        6DECCE501680F18A3931363CF4210E267C88344CB6D605B4E5E1601081790B48
        6FA0673A017880CBEFC309D50002F0BF03C5148A5699E7E19C0000000049454E
        44AE426082}
      ShortCut = 32854
      OnClick = bbValidateClick
    end
    object bbClearSheet: TdxBarButton
      Caption = 'Initializeaza tabela'
      Category = 0
      Hint = 'Initializeaza tabela'
      Visible = ivAlways
      ImageIndex = 71
      ShortCut = 32841
      OnClick = bbClearSheetClick
    end
    object bbCreateRevaluation: TdxBarButton
      Caption = 'Creaza reevaluare'
      Category = 0
      Hint = 'Creaza reevaluare'
      Visible = ivAlways
      OnClick = bbCreateRevaluationClick
    end
    object bbSaveToExcel: TdxBarButton
      Caption = 'Salveaza'
      Category = 0
      Hint = 'Salveaza'
      Visible = ivAlways
      ImageIndex = 32
      OnClick = bbSaveToExcelClick
    end
    object bbOpenFile: TdxBarButton
      Caption = 'Deschide'
      Category = 0
      Hint = 'Deschide'
      Visible = ivAlways
      ImageIndex = 79
      OnClick = bbOpenFileClick
    end
    object bbSetHint: TdxBarButton
      Caption = 'Seteaza Hint pe imagine'
      Category = 0
      Hint = 'Seteaza Hint pe imagine'
      Visible = ivAlways
      OnClick = bbSetHintClick
    end
    object bbImportFromFirstPage: TdxBarButton
      Caption = 'Importa de pe prima pagina'
      Category = 0
      Hint = 'Importa de pe prima pagina'
      Visible = ivAlways
      OnClick = bbImportFromFirstPageClick
    end
    object dxBarButton11: TdxBarButton
      Caption = 'New Button'
      Category = 0
      Hint = 'New Button'
      Visible = ivAlways
      Glyph.SourceDPI = 96
      Glyph.Data = {
        89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
        6100000030744558745469746C6500436C6561723B45726173653B52656D6F76
        653B426172733B526962626F6E3B466F726D617474696E673B9B846D96000002
        F849444154785E8DD27F6855751CC7E1D7399EDD192A4C45A752D46EBADC86CE
        0C56518B50B73551291D49D0482C98656898CC5F15655941CA656D7369AB2490
        F5431C543396DBEE8499B8C66D4EE71CFD2189DE9B26F3D7EEB67BCF39DF776C
        5C68D23F3DF0FEEFCD870F1F3ED6E11F7BC296653F0D2009014848C208100861
        7CBF7D7DD9234B2519C6FBF24844FFC7C16F7E13E048627C1CD7F300F8BAB18B
        C65FCEF15CF102D6AE78180021002C20D5FB0F3B99F400683AD14BED7BAB690A
        9F47C6D0D2D1C7EA8ACF90846FC01DEB615DACDC40F7F3A563F9BDAC04677480
        04CB9FCAA562E7779495E673FC641FB587DAD8BC7E19C6082432A74F06B0839F
        1CB0019D5EB5549E31F0715D9B8C314AB8BE46FDD47A56CB5E0CE958DB590D25
        5CDD8A27141F76D57EEA0F453694EF39BF719D9A8B9F7C1F7000CB763D1F0946
        121E8DCD67081D6CE6CD978B98989EC68AF210E19317900C81AE16662ECCDB99
        55BE967B0B9F78ABE1F1C5BB01C771932E46E01BF1697D33951B9753F868366B
        5EA9A6A1B6829FDB7B88357ECB1CFF6F32B21FC2BB7E95070A163162077654DF
        1EB2533710C688F0F7950C0E27194EFABCF6D2127E381E617EAC1B92D7999A33
        17FFD60002ECB959389123CCC998BACDDAB2FBA83EDCBE8ADB8349045802C7B1
        0838D0792CCCEC9E5666CE0F4232011269B9F9F4BFB3976B83773877F5AF9055
        FE7A7DAB6D4F5822401239F366F1E0FDD3E88DC671666452148812FCB313CB82
        C0C2C5F4BF5BC5E59B034462576AF6C4A2DB2D20004CE05F81955B1B3ECA5B94
        F36A3098896B20F7D269F2A743FF07FBB938708D5FA397F6D7DC18D8060CDDF5
        96CFEE6A02B8A764CB51854E5CD1BEF0E5B11CEE8E69D3A62FF4D5BC055A3769
        F201600A60BF90968ECD38FD672E0098BECE53551D2D5D245C9F6993605F553B
        2D518F9A785AFDA1F8602510EF78ACD8DCF13CEEDAE0BEC2B7016C60CAEC8237
        AAF3D6D4297B6595B28AF66A56C1D6CF810CC02EB56C4AB028C2C292440A33F2
        37E3FB2E377AEB6C201D9898BA8F014646F30CB6F11129FC03F994B9D32092AD
        6E0000000049454E44AE426082}
    end
    object bbAddBurstGoods: TdxBarButton
      Caption = 'Adauga multiplu'
      Category = 0
      Hint = 'Adauga multiplu'
      Visible = ivAlways
      OnClick = bbAddBurstGoodsClick
    end
    object bbJsonImport: TdxBarButton
      Caption = 'Importa din json'
      Category = 0
      Hint = 'Importa din json'
      Visible = ivAlways
      OnClick = bbJsonImportClick
    end
    object bbAddToWebMainPage: TdxBarButton
      Caption = 'Adauga pe pagina principala'
      Category = 1
      Hint = 'Adauga pe pagina principala'
      Visible = ivAlways
      OnClick = bbAddToWebMainPageClick
    end
  end
  object IBCQueryGoods: TIBCQuery
    KeyFields = 'PROMOACTIONID;GOODS_CODE;SUPPLIERID'
    SQLInsert.Strings = (
      'INSERT INTO VW_TWEB_PA_GOODS'
      
        '  (PROMOACTIONID, SUPPLIERID, SUPPLIER_NAME, GOODSID, GOODS_NAME' +
        ', GOODS_CODE, ORDERNO, PRICE4, OLD_PRICE4, CURRENCYID, OLD_CURRE' +
        'NCYID, PRICE7, CURRENCY7ID, DISCOUNT_VALUE, FLG_FREEZE_PRICES, F' +
        'LG_DISCOUNT_TYPE, FLG_SHOW_DISCOUNT_AS_AMOUNT, FLG_FAKE_PROMOTIO' +
        'N, DISCOUNT_PERCENT, DISCOUNT_AMOUNT, DISCOUNT_VALUE_MDL, FLG_IN' +
        '_PRICE, DISCOUNT_TYPEID, CASHBACK_PERCENT, LABEL_RO, LABEL_RU)'
      'VALUES'
      
        '  (:PROMOACTIONID, :SUPPLIERID, :SUPPLIER_NAME, :GOODSID, :GOODS' +
        '_NAME, :GOODS_CODE, :ORDERNO, :PRICE4, :OLD_PRICE4, :CURRENCYID,' +
        ' :OLD_CURRENCYID, :PRICE7, :CURRENCY7ID, :DISCOUNT_VALUE, :FLG_F' +
        'REEZE_PRICES, :FLG_DISCOUNT_TYPE, :FLG_SHOW_DISCOUNT_AS_AMOUNT, ' +
        ':FLG_FAKE_PROMOTION, :DISCOUNT_PERCENT, :DISCOUNT_AMOUNT, :DISCO' +
        'UNT_VALUE_MDL, :FLG_IN_PRICE, :DISCOUNT_TYPEID, :CASHBACK_PERCEN' +
        'T, :LABEL_RO, :LABEL_RU)')
    SQLDelete.Strings = (
      'DELETE FROM VW_TWEB_PA_GOODS'
      'WHERE'
      
        '  PROMOACTIONID = :Old_PROMOACTIONID AND GOODS_CODE = :Old_GOODS' +
        '_CODE AND SUPPLIERID = :Old_SUPPLIERID')
    SQLUpdate.Strings = (
      'UPDATE VW_TWEB_PA_GOODS'
      'SET'
      
        '  PROMOACTIONID = :PROMOACTIONID, SUPPLIERID = :SUPPLIERID, SUPP' +
        'LIER_NAME = :SUPPLIER_NAME, GOODSID = :GOODSID, GOODS_NAME = :GO' +
        'ODS_NAME, GOODS_CODE = :GOODS_CODE, ORDERNO = :ORDERNO, PRICE4 =' +
        ' :PRICE4, OLD_PRICE4 = :OLD_PRICE4, CURRENCYID = :CURRENCYID, OL' +
        'D_CURRENCYID = :OLD_CURRENCYID, PRICE7 = :PRICE7, CURRENCY7ID = ' +
        ':CURRENCY7ID, DISCOUNT_VALUE = :DISCOUNT_VALUE, FLG_FREEZE_PRICE' +
        'S = :FLG_FREEZE_PRICES, FLG_DISCOUNT_TYPE = :FLG_DISCOUNT_TYPE, ' +
        'FLG_SHOW_DISCOUNT_AS_AMOUNT = :FLG_SHOW_DISCOUNT_AS_AMOUNT, FLG_' +
        'FAKE_PROMOTION = :FLG_FAKE_PROMOTION, DISCOUNT_PERCENT = :DISCOU' +
        'NT_PERCENT, DISCOUNT_AMOUNT = :DISCOUNT_AMOUNT, DISCOUNT_VALUE_M' +
        'DL = :DISCOUNT_VALUE_MDL, FLG_IN_PRICE = :FLG_IN_PRICE, DISCOUNT' +
        '_TYPEID = :DISCOUNT_TYPEID, CASHBACK_PERCENT = :CASHBACK_PERCENT' +
        ', LABEL_RO = :LABEL_RO, LABEL_RU = :LABEL_RU'
      'WHERE'
      
        '  PROMOACTIONID = :Old_PROMOACTIONID AND GOODS_CODE = :Old_GOODS' +
        '_CODE AND SUPPLIERID = :Old_SUPPLIERID')
    SQLRefresh.Strings = (
      
        'SELECT PROMOACTIONID, SUPPLIERID, SUPPLIER_NAME, GOODSID, GOODS_' +
        'NAME, GOODS_CODE, ORDERNO, PRICE4, OLD_PRICE4, CURRENCYID, OLD_C' +
        'URRENCYID, PRICE7, CURRENCY7ID, DISCOUNT_VALUE, FLG_FREEZE_PRICE' +
        'S, FLG_DISCOUNT_TYPE, FLG_SHOW_DISCOUNT_AS_AMOUNT, FLG_FAKE_PROM' +
        'OTION, DISCOUNT_PERCENT, DISCOUNT_AMOUNT, DISCOUNT_VALUE_MDL, FL' +
        'G_IN_PRICE, DISCOUNT_TYPEID, CASHBACK_PERCENT, LABEL_RO, LABEL_R' +
        'U FROM VW_TWEB_PA_GOODS'
      'WHERE'
      
        '  PROMOACTIONID = :PROMOACTIONID AND GOODS_CODE = :GOODS_CODE AN' +
        'D SUPPLIERID = :SUPPLIERID')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM VW_TWEB_PA_GOODS'
      ''
      ') q')
    Connection = dmDB.IBCConnection
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'SELECT'
      'g.*,'
      
        '(select price_mdl from get_goods_price(g.goodsid, 4, 498)) curre' +
        'nt_price4'
      'FROM VW_TWEB_PA_GOODS G'
      'WHERE G.PROMOACTIONID=:PROMOACTIONID')
    MasterFields = 'PROMOACTIONID'
    DetailFields = 'PROMOACTIONID'
    AutoCommit = False
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Left = 68
    Top = 352
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PROMOACTIONID'
        Value = nil
      end>
  end
  object IBCDataSourceGoods: TIBCDataSource
    DataSet = IBCQueryGoods
    Left = 68
    Top = 296
  end
  object IBCQueryCurrency: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT * FROM TS_CURRENCY')
    Left = 192
    Top = 352
  end
  object IBCDataSourceCurrency: TIBCDataSource
    DataSet = IBCQueryCurrency
    Left = 192
    Top = 296
  end
  object cxImageList1: TcxImageList
    SourceDPI = 96
    FormatVersion = 1
    Left = 360
    Top = 232
    Bitmap = {
      494C010102000500040010001000FFFFFFFF2110FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000042A3D7D14B1
      FFFF14B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1
      FFFF14B1FFFF14B1FFFF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000042A
      3D7D14B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1
      FFFF14B1FFFF14B1FFFF00000000000000000000000000000000000000000202
      02256A6A6AF7444444C60000000200000000000000000E0E0E5B5B5B5BE56F6F
      6FFC3F3F3FBF0101011B00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000042A3D7D14B1FFFF14ADFBFD0218235F0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00001919197A717171FF1414146B00000000000000176B6B6BF93E3E3EBD0C0C
      0C565C5C5CE7363636B100000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000042A3D7D14B1FFFF14ADFBFD0218235F00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000054C4C4CD1656565F10101011C08080846717171FF0C0C0C550000
      00002A2A2A9C636363EF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000042A3D7D14B1FFFF14ADFBFD0218235F000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000050505376F6F6FFC363636B10303032F717171FF151515700000
      00003D3D3DBB5C5C5CE600000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000042A3D7D14B1FFFF14ADFBFD0218235F0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000024242491717171FF0C0C0C55383838B46B6B6BF74A4A
      4ACE717171FF2121218A00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000052D428214B1FFFF14ADF9FC0216205B0000
      0000000000000000000000000000000000000000000000000000000000020D0D
      0D592121218C1313136A00000016585858E15C5C5CE6000000150F0F0F5E1F1F
      1F860D0D0D590000000200000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000052D428214B1FFFF14ADF9FC0216205B000000000000
      0000000000000000000000000000000000000000000000000000202020887171
      71FF474747CA676767F43D3D3DBC0A0A0A4C717171FF2929299A000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000052D428214B1FFFF14ADF9FC0216205B00000000000000000000
      0000000000000000000000000000000000000000000000000000606060EC3A3A
      3AB80000000012121268717171FF0303032B313131A8707070FE0606063E0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000052D428214B1FFFF14ADF9FC0216205B0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000676767F42E2E
      2EA2000000000A0A0A4F717171FF0606063E00000017626262EE515151D80000
      0008000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000052D
      428214B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1
      FFFF14B1FFFF14B1FFFF00000000000000000000000000000000363636B06161
      61EC0F0F0F5D3A3A3AB86B6B6BF9000000150000000011111163717171FF1D1D
      1D83000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000052D428214B1
      FFFF14B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1
      FFFF14B1FFFF14B1FFFF00000000000000000000000000000000000000163636
      36B1696969F5595959E20E0E0E5C0000000000000000000000013F3F3FBE6B6B
      6BF90303032C0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000}
    DesignInfo = 15204712
    ImageInfo = <
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D225554
          462D38223F3E0D0A3C7376672076657273696F6E3D22312E31222069643D224C
          617965725F312220786D6C6E733D22687474703A2F2F7777772E77332E6F7267
          2F323030302F7376672220786D6C6E733A786C696E6B3D22687474703A2F2F77
          77772E77332E6F72672F313939392F786C696E6B2220783D223070782220793D
          22307078222076696577426F783D2230203020333220333222207374796C653D
          22656E61626C652D6261636B67726F756E643A6E657720302030203332203332
          3B2220786D6C3A73706163653D227072657365727665223E262331333B262331
          303B3C7374796C6520747970653D22746578742F6373732220786D6C3A737061
          63653D227072657365727665223E2E426C75657B66696C6C3A23313137374437
          3B7D262331333B262331303B2623393B2E59656C6C6F777B66696C6C3A234646
          423131353B7D262331333B262331303B2623393B2E426C61636B7B66696C6C3A
          233732373237323B7D262331333B262331303B2623393B2E477265656E7B6669
          6C6C3A233033394332333B7D262331333B262331303B2623393B2E5265647B66
          696C6C3A234431314331433B7D262331333B262331303B2623393B2E7374307B
          6F7061636974793A302E37353B7D262331333B262331303B2623393B2E737431
          7B6F7061636974793A302E353B7D3C2F7374796C653E0D0A3C672069643D2253
          756D223E0D0A09093C706F6C79676F6E20636C6173733D2259656C6C6F772220
          706F696E74733D2232382C382032382C3420342C342031362C31362031362C31
          3620382C323420382C323420382C323420342C32382032382C32382032382C32
          342031332E372C32342032312E372C31362032312E372C31362031332E372C38
          202623393B222F3E0D0A093C2F673E0D0A3C2F7376673E0D0A}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D225554
          462D38223F3E0D0A3C7376672076657273696F6E3D22312E31222069643D2250
          657263656E745F5374796C652220786D6C6E733D22687474703A2F2F7777772E
          77332E6F72672F323030302F7376672220786D6C6E733A786C696E6B3D226874
          74703A2F2F7777772E77332E6F72672F313939392F786C696E6B2220783D2230
          70782220793D22307078222076696577426F783D223020302033322033322220
          7374796C653D22656E61626C652D6261636B67726F756E643A6E657720302030
          2033322033323B2220786D6C3A73706163653D227072657365727665223E2623
          31333B262331303B3C7374796C6520747970653D22746578742F637373223E2E
          426C61636B7B66696C6C3A233732373237323B7D3C2F7374796C653E0D0A3C70
          61746820636C6173733D22426C61636B2220643D224D392E312C31352E31632D
          312E352C302D322E382D302E352D332E372D312E3443342E352C31322E372C34
          2C31312E342C342C392E3843342C382C342E352C362E362C352E352C352E3663
          312D312C322E332D312E362C342D312E3620202623393B63312E362C302C322E
          382C302E352C332E372C312E3463302E392C302E392C312E332C322E332C312E
          332C3463302C312E382D302E352C332E322D312E352C342E324331322E312C31
          342E362C31302E382C31352E312C392E312C31352E317A204D32342E392C346C
          2D31342C323248372E316C31342D32324832342E397A20202623393B204D392E
          342C362E36632D312E352C302D322E322C312D322E322C3363302C312E392C30
          2E372C322E392C322E312C322E3963312E342C302C322E312D312C322E312D33
          4331312E342C372E362C31302E382C362E362C392E342C362E367A204D32322E
          352C3236632D312E352C302D322E382D302E352D332E372D312E342020262339
          3B632D302E392D312D312E342D322E332D312E342D332E3963302D312E382C30
          2E352D332E322C312E352D342E3263312D312C322E332D312E362C342D312E36
          63312E362C302C322E392C302E352C332E372C312E3463302E392C302E392C31
          2E332C322E332C312E332C3420202623393B63302C312E382D302E352C332E32
          2D312E352C342E324332352E352C32352E352C32342E322C32362C32322E352C
          32367A204D32322E382C31372E35632D312E352C302D322E322C312D322E322C
          3363302C312E392C302E372C322E392C322E312C322E3963312E342C302C322E
          312D312C322E312D3320202623393B63302D302E392D302E322D312E362D302E
          362D322E314332332E392C31372E372C32332E342C31372E352C32322E382C31
          372E357A222F3E0D0A3C2F7376673E0D0A}
      end>
  end
  object cxPropertiesStore1: TcxPropertiesStore
    Components = <
      item
        Component = cxGridDBBandedTableView1
        Properties.Strings = (
          'BackgroundBitmaps'
          'Bands'
          'DataController'
          'DateTimeHandling'
          'DragMode'
          'EditForm'
          'FakeComponentLink1'
          'FakeComponentLink2'
          'FakeComponentLink3'
          'FilterBox'
          'Filtering'
          'FilterRow'
          'FindPanel'
          'FixedDataRows'
          'Images'
          'Name'
          'Navigator'
          'NavigatorButtons'
          'NewItemRow'
          'OptionsBehavior'
          'OptionsCustomize'
          'OptionsData'
          'OptionsSelection'
          'OptionsView'
          'PopupMenu'
          'Preview'
          'RowLayout'
          'ScrollbarAnnotations'
          'Styles'
          'Synchronization'
          'Tag')
      end
      item
        Component = cxGridDBBandedTableView1Column1
        Properties.Strings = (
          'AlternateCaption'
          'BestFitMaxWidth'
          'Caption'
          'DataBinding'
          'DateTimeGrouping'
          'FakeComponentLink1'
          'FakeComponentLink2'
          'FakeComponentLink3'
          'FixedKind'
          'FooterAlignmentHorz'
          'GroupIndex'
          'GroupSummaryAlignment'
          'HeaderAlignmentHorz'
          'HeaderAlignmentVert'
          'HeaderGlyph'
          'HeaderGlyphAlignmentHorz'
          'HeaderGlyphAlignmentVert'
          'HeaderHint'
          'HeaderImageIndex'
          'IsChildInMergedGroup'
          'LayoutItem'
          'MinWidth'
          'Name'
          'Options'
          'Position'
          'Properties'
          'PropertiesClassName'
          'RepositoryItem'
          'RowLayoutItem'
          'SortIndex'
          'SortOrder'
          'Styles'
          'Summary'
          'Tag'
          'Visible'
          'VisibleForCustomization'
          'VisibleForEditForm'
          'VisibleForExpressionEditor'
          'VisibleForRowLayout'
          'Width')
      end
      item
        Component = cxGridDBBandedTableView1_CASHBACK
        Properties.Strings = (
          'AlternateCaption'
          'BestFitMaxWidth'
          'Caption'
          'DataBinding'
          'DateTimeGrouping'
          'FakeComponentLink1'
          'FakeComponentLink2'
          'FakeComponentLink3'
          'FixedKind'
          'FooterAlignmentHorz'
          'GroupIndex'
          'GroupSummaryAlignment'
          'HeaderAlignmentHorz'
          'HeaderAlignmentVert'
          'HeaderGlyph'
          'HeaderGlyphAlignmentHorz'
          'HeaderGlyphAlignmentVert'
          'HeaderHint'
          'HeaderImageIndex'
          'IsChildInMergedGroup'
          'LayoutItem'
          'MinWidth'
          'Name'
          'Options'
          'Position'
          'Properties'
          'PropertiesClassName'
          'RepositoryItem'
          'RowLayoutItem'
          'SortIndex'
          'SortOrder'
          'Styles'
          'Summary'
          'Tag'
          'Visible'
          'VisibleForCustomization'
          'VisibleForEditForm'
          'VisibleForExpressionEditor'
          'VisibleForRowLayout'
          'Width')
      end
      item
        Component = cxGridDBBandedTableView1_CPF
        Properties.Strings = (
          'AlternateCaption'
          'BestFitMaxWidth'
          'Caption'
          'DataBinding'
          'DateTimeGrouping'
          'FakeComponentLink1'
          'FakeComponentLink2'
          'FakeComponentLink3'
          'FixedKind'
          'FooterAlignmentHorz'
          'GroupIndex'
          'GroupSummaryAlignment'
          'HeaderAlignmentHorz'
          'HeaderAlignmentVert'
          'HeaderGlyph'
          'HeaderGlyphAlignmentHorz'
          'HeaderGlyphAlignmentVert'
          'HeaderHint'
          'HeaderImageIndex'
          'IsChildInMergedGroup'
          'LayoutItem'
          'MinWidth'
          'Name'
          'Options'
          'Position'
          'Properties'
          'PropertiesClassName'
          'RepositoryItem'
          'RowLayoutItem'
          'SortIndex'
          'SortOrder'
          'Styles'
          'Summary'
          'Tag'
          'Visible'
          'VisibleForCustomization'
          'VisibleForEditForm'
          'VisibleForExpressionEditor'
          'VisibleForRowLayout'
          'Width')
      end
      item
        Component = cxGridDBBandedTableView1_CURRENCYID
        Properties.Strings = (
          'AlternateCaption'
          'BestFitMaxWidth'
          'Caption'
          'DataBinding'
          'DateTimeGrouping'
          'FakeComponentLink1'
          'FakeComponentLink2'
          'FakeComponentLink3'
          'FixedKind'
          'FooterAlignmentHorz'
          'GroupIndex'
          'GroupSummaryAlignment'
          'HeaderAlignmentHorz'
          'HeaderAlignmentVert'
          'HeaderGlyph'
          'HeaderGlyphAlignmentHorz'
          'HeaderGlyphAlignmentVert'
          'HeaderHint'
          'HeaderImageIndex'
          'IsChildInMergedGroup'
          'LayoutItem'
          'MinWidth'
          'Name'
          'Options'
          'Position'
          'Properties'
          'PropertiesClassName'
          'RepositoryItem'
          'RowLayoutItem'
          'SortIndex'
          'SortOrder'
          'Styles'
          'Summary'
          'Tag'
          'Visible'
          'VisibleForCustomization'
          'VisibleForEditForm'
          'VisibleForExpressionEditor'
          'VisibleForRowLayout'
          'Width')
      end
      item
        Component = cxGridDBBandedTableView1_CURRENT_PRICE4
        Properties.Strings = (
          'AlternateCaption'
          'BestFitMaxWidth'
          'Caption'
          'DataBinding'
          'DateTimeGrouping'
          'FakeComponentLink1'
          'FakeComponentLink2'
          'FakeComponentLink3'
          'FixedKind'
          'FooterAlignmentHorz'
          'GroupIndex'
          'GroupSummaryAlignment'
          'HeaderAlignmentHorz'
          'HeaderAlignmentVert'
          'HeaderGlyph'
          'HeaderGlyphAlignmentHorz'
          'HeaderGlyphAlignmentVert'
          'HeaderHint'
          'HeaderImageIndex'
          'IsChildInMergedGroup'
          'LayoutItem'
          'MinWidth'
          'Name'
          'Options'
          'Position'
          'Properties'
          'PropertiesClassName'
          'RepositoryItem'
          'RowLayoutItem'
          'SortIndex'
          'SortOrder'
          'Styles'
          'Summary'
          'Tag'
          'Visible'
          'VisibleForCustomization'
          'VisibleForEditForm'
          'VisibleForExpressionEditor'
          'VisibleForRowLayout'
          'Width')
      end
      item
        Component = cxGridDBBandedTableView1_DISCOUNT_AMOUNT
        Properties.Strings = (
          'AlternateCaption'
          'BestFitMaxWidth'
          'Caption'
          'DataBinding'
          'DateTimeGrouping'
          'FakeComponentLink1'
          'FakeComponentLink2'
          'FakeComponentLink3'
          'FixedKind'
          'FooterAlignmentHorz'
          'GroupIndex'
          'GroupSummaryAlignment'
          'HeaderAlignmentHorz'
          'HeaderAlignmentVert'
          'HeaderGlyph'
          'HeaderGlyphAlignmentHorz'
          'HeaderGlyphAlignmentVert'
          'HeaderHint'
          'HeaderImageIndex'
          'IsChildInMergedGroup'
          'LayoutItem'
          'MinWidth'
          'Name'
          'Options'
          'Position'
          'Properties'
          'PropertiesClassName'
          'RepositoryItem'
          'RowLayoutItem'
          'SortIndex'
          'SortOrder'
          'Styles'
          'Summary'
          'Tag'
          'Visible'
          'VisibleForCustomization'
          'VisibleForEditForm'
          'VisibleForExpressionEditor'
          'VisibleForRowLayout'
          'Width')
      end
      item
        Component = cxGridDBBandedTableView1_DISCOUNT_PERCENT
        Properties.Strings = (
          'AlternateCaption'
          'BestFitMaxWidth'
          'Caption'
          'DataBinding'
          'DateTimeGrouping'
          'FakeComponentLink1'
          'FakeComponentLink2'
          'FakeComponentLink3'
          'FixedKind'
          'FooterAlignmentHorz'
          'GroupIndex'
          'GroupSummaryAlignment'
          'HeaderAlignmentHorz'
          'HeaderAlignmentVert'
          'HeaderGlyph'
          'HeaderGlyphAlignmentHorz'
          'HeaderGlyphAlignmentVert'
          'HeaderHint'
          'HeaderImageIndex'
          'IsChildInMergedGroup'
          'LayoutItem'
          'MinWidth'
          'Name'
          'Options'
          'Position'
          'Properties'
          'PropertiesClassName'
          'RepositoryItem'
          'RowLayoutItem'
          'SortIndex'
          'SortOrder'
          'Styles'
          'Summary'
          'Tag'
          'Visible'
          'VisibleForCustomization'
          'VisibleForEditForm'
          'VisibleForExpressionEditor'
          'VisibleForRowLayout'
          'Width')
      end
      item
        Component = cxGridDBBandedTableView1_DISCOUNT_TYPEID
        Properties.Strings = (
          'AlternateCaption'
          'BestFitMaxWidth'
          'Caption'
          'DataBinding'
          'DateTimeGrouping'
          'FakeComponentLink1'
          'FakeComponentLink2'
          'FakeComponentLink3'
          'FixedKind'
          'FooterAlignmentHorz'
          'GroupIndex'
          'GroupSummaryAlignment'
          'HeaderAlignmentHorz'
          'HeaderAlignmentVert'
          'HeaderGlyph'
          'HeaderGlyphAlignmentHorz'
          'HeaderGlyphAlignmentVert'
          'HeaderHint'
          'HeaderImageIndex'
          'IsChildInMergedGroup'
          'LayoutItem'
          'MinWidth'
          'Name'
          'Options'
          'Position'
          'Properties'
          'PropertiesClassName'
          'RepositoryItem'
          'RowLayoutItem'
          'SortIndex'
          'SortOrder'
          'Styles'
          'Summary'
          'Tag'
          'Visible'
          'VisibleForCustomization'
          'VisibleForEditForm'
          'VisibleForExpressionEditor'
          'VisibleForRowLayout'
          'Width')
      end
      item
        Component = cxGridDBBandedTableView1_DISCOUNT_VALUE_MDL
        Properties.Strings = (
          'AlternateCaption'
          'BestFitMaxWidth'
          'Caption'
          'DataBinding'
          'DateTimeGrouping'
          'FakeComponentLink1'
          'FakeComponentLink2'
          'FakeComponentLink3'
          'FixedKind'
          'FooterAlignmentHorz'
          'GroupIndex'
          'GroupSummaryAlignment'
          'HeaderAlignmentHorz'
          'HeaderAlignmentVert'
          'HeaderGlyph'
          'HeaderGlyphAlignmentHorz'
          'HeaderGlyphAlignmentVert'
          'HeaderHint'
          'HeaderImageIndex'
          'IsChildInMergedGroup'
          'LayoutItem'
          'MinWidth'
          'Name'
          'Options'
          'Position'
          'Properties'
          'PropertiesClassName'
          'RepositoryItem'
          'RowLayoutItem'
          'SortIndex'
          'SortOrder'
          'Styles'
          'Summary'
          'Tag'
          'Visible'
          'VisibleForCustomization'
          'VisibleForEditForm'
          'VisibleForExpressionEditor'
          'VisibleForRowLayout'
          'Width')
      end
      item
        Component = cxGridDBBandedTableView1_FLG_IN_PRICE
        Properties.Strings = (
          'AlternateCaption'
          'BestFitMaxWidth'
          'Caption'
          'DataBinding'
          'DateTimeGrouping'
          'FakeComponentLink1'
          'FakeComponentLink2'
          'FakeComponentLink3'
          'FixedKind'
          'FooterAlignmentHorz'
          'GroupIndex'
          'GroupSummaryAlignment'
          'HeaderAlignmentHorz'
          'HeaderAlignmentVert'
          'HeaderGlyph'
          'HeaderGlyphAlignmentHorz'
          'HeaderGlyphAlignmentVert'
          'HeaderHint'
          'HeaderImageIndex'
          'IsChildInMergedGroup'
          'LayoutItem'
          'MinWidth'
          'Name'
          'Options'
          'Position'
          'Properties'
          'PropertiesClassName'
          'RepositoryItem'
          'RowLayoutItem'
          'SortIndex'
          'SortOrder'
          'Styles'
          'Summary'
          'Tag'
          'Visible'
          'VisibleForCustomization'
          'VisibleForEditForm'
          'VisibleForExpressionEditor'
          'VisibleForRowLayout'
          'Width')
      end
      item
        Component = cxGridDBBandedTableView1_GOODSID
        Properties.Strings = (
          'AlternateCaption'
          'BestFitMaxWidth'
          'Caption'
          'DataBinding'
          'DateTimeGrouping'
          'FakeComponentLink1'
          'FakeComponentLink2'
          'FakeComponentLink3'
          'FixedKind'
          'FooterAlignmentHorz'
          'GroupIndex'
          'GroupSummaryAlignment'
          'HeaderAlignmentHorz'
          'HeaderAlignmentVert'
          'HeaderGlyph'
          'HeaderGlyphAlignmentHorz'
          'HeaderGlyphAlignmentVert'
          'HeaderHint'
          'HeaderImageIndex'
          'IsChildInMergedGroup'
          'LayoutItem'
          'MinWidth'
          'Name'
          'Options'
          'Position'
          'Properties'
          'PropertiesClassName'
          'RepositoryItem'
          'RowLayoutItem'
          'SortIndex'
          'SortOrder'
          'Styles'
          'Summary'
          'Tag'
          'Visible'
          'VisibleForCustomization'
          'VisibleForEditForm'
          'VisibleForExpressionEditor'
          'VisibleForRowLayout'
          'Width')
      end
      item
        Component = cxGridDBBandedTableView1_GOODS_NAME
        Properties.Strings = (
          'AlternateCaption'
          'BestFitMaxWidth'
          'Caption'
          'DataBinding'
          'DateTimeGrouping'
          'FakeComponentLink1'
          'FakeComponentLink2'
          'FakeComponentLink3'
          'FixedKind'
          'FooterAlignmentHorz'
          'GroupIndex'
          'GroupSummaryAlignment'
          'HeaderAlignmentHorz'
          'HeaderAlignmentVert'
          'HeaderGlyph'
          'HeaderGlyphAlignmentHorz'
          'HeaderGlyphAlignmentVert'
          'HeaderHint'
          'HeaderImageIndex'
          'IsChildInMergedGroup'
          'LayoutItem'
          'MinWidth'
          'Name'
          'Options'
          'Position'
          'Properties'
          'PropertiesClassName'
          'RepositoryItem'
          'RowLayoutItem'
          'SortIndex'
          'SortOrder'
          'Styles'
          'Summary'
          'Tag'
          'Visible'
          'VisibleForCustomization'
          'VisibleForEditForm'
          'VisibleForExpressionEditor'
          'VisibleForRowLayout'
          'Width')
      end
      item
        Component = cxGridDBBandedTableView1_LabelRO
        Properties.Strings = (
          'AlternateCaption'
          'BestFitMaxWidth'
          'Caption'
          'DataBinding'
          'DateTimeGrouping'
          'FakeComponentLink1'
          'FakeComponentLink2'
          'FakeComponentLink3'
          'FixedKind'
          'FooterAlignmentHorz'
          'GroupIndex'
          'GroupSummaryAlignment'
          'HeaderAlignmentHorz'
          'HeaderAlignmentVert'
          'HeaderGlyph'
          'HeaderGlyphAlignmentHorz'
          'HeaderGlyphAlignmentVert'
          'HeaderHint'
          'HeaderImageIndex'
          'IsChildInMergedGroup'
          'LayoutItem'
          'MinWidth'
          'Name'
          'Options'
          'Position'
          'Properties'
          'PropertiesClassName'
          'RepositoryItem'
          'RowLayoutItem'
          'SortIndex'
          'SortOrder'
          'Styles'
          'Summary'
          'Tag'
          'Visible'
          'VisibleForCustomization'
          'VisibleForEditForm'
          'VisibleForExpressionEditor'
          'VisibleForRowLayout'
          'Width')
      end
      item
        Component = cxGridDBBandedTableView1_LabelRU
        Properties.Strings = (
          'AlternateCaption'
          'BestFitMaxWidth'
          'Caption'
          'DataBinding'
          'DateTimeGrouping'
          'FakeComponentLink1'
          'FakeComponentLink2'
          'FakeComponentLink3'
          'FixedKind'
          'FooterAlignmentHorz'
          'GroupIndex'
          'GroupSummaryAlignment'
          'HeaderAlignmentHorz'
          'HeaderAlignmentVert'
          'HeaderGlyph'
          'HeaderGlyphAlignmentHorz'
          'HeaderGlyphAlignmentVert'
          'HeaderHint'
          'HeaderImageIndex'
          'IsChildInMergedGroup'
          'LayoutItem'
          'MinWidth'
          'Name'
          'Options'
          'Position'
          'Properties'
          'PropertiesClassName'
          'RepositoryItem'
          'RowLayoutItem'
          'SortIndex'
          'SortOrder'
          'Styles'
          'Summary'
          'Tag'
          'Visible'
          'VisibleForCustomization'
          'VisibleForEditForm'
          'VisibleForExpressionEditor'
          'VisibleForRowLayout'
          'Width')
      end
      item
        Component = cxGridDBBandedTableView1_OLD_PRICE4
        Properties.Strings = (
          'AlternateCaption'
          'BestFitMaxWidth'
          'Caption'
          'DataBinding'
          'DateTimeGrouping'
          'FakeComponentLink1'
          'FakeComponentLink2'
          'FakeComponentLink3'
          'FixedKind'
          'FooterAlignmentHorz'
          'GroupIndex'
          'GroupSummaryAlignment'
          'HeaderAlignmentHorz'
          'HeaderAlignmentVert'
          'HeaderGlyph'
          'HeaderGlyphAlignmentHorz'
          'HeaderGlyphAlignmentVert'
          'HeaderHint'
          'HeaderImageIndex'
          'IsChildInMergedGroup'
          'LayoutItem'
          'MinWidth'
          'Name'
          'Options'
          'Position'
          'Properties'
          'PropertiesClassName'
          'RepositoryItem'
          'RowLayoutItem'
          'SortIndex'
          'SortOrder'
          'Styles'
          'Summary'
          'Tag'
          'Visible'
          'VisibleForCustomization'
          'VisibleForEditForm'
          'VisibleForExpressionEditor'
          'VisibleForRowLayout'
          'Width')
      end
      item
        Component = cxGridDBBandedTableView1_PRICE4
        Properties.Strings = (
          'AlternateCaption'
          'BestFitMaxWidth'
          'Caption'
          'DataBinding'
          'DateTimeGrouping'
          'FakeComponentLink1'
          'FakeComponentLink2'
          'FakeComponentLink3'
          'FixedKind'
          'FooterAlignmentHorz'
          'GroupIndex'
          'GroupSummaryAlignment'
          'HeaderAlignmentHorz'
          'HeaderAlignmentVert'
          'HeaderGlyph'
          'HeaderGlyphAlignmentHorz'
          'HeaderGlyphAlignmentVert'
          'HeaderHint'
          'HeaderImageIndex'
          'IsChildInMergedGroup'
          'LayoutItem'
          'MinWidth'
          'Name'
          'Options'
          'Position'
          'Properties'
          'PropertiesClassName'
          'RepositoryItem'
          'RowLayoutItem'
          'SortIndex'
          'SortOrder'
          'Styles'
          'Summary'
          'Tag'
          'Visible'
          'VisibleForCustomization'
          'VisibleForEditForm'
          'VisibleForExpressionEditor'
          'VisibleForRowLayout'
          'Width')
      end
      item
        Component = cxGridDBBandedTableView1_SupplierID
        Properties.Strings = (
          'AlternateCaption'
          'BestFitMaxWidth'
          'Caption'
          'DataBinding'
          'DateTimeGrouping'
          'FakeComponentLink1'
          'FakeComponentLink2'
          'FakeComponentLink3'
          'FixedKind'
          'FooterAlignmentHorz'
          'GroupIndex'
          'GroupSummaryAlignment'
          'HeaderAlignmentHorz'
          'HeaderAlignmentVert'
          'HeaderGlyph'
          'HeaderGlyphAlignmentHorz'
          'HeaderGlyphAlignmentVert'
          'HeaderHint'
          'HeaderImageIndex'
          'IsChildInMergedGroup'
          'LayoutItem'
          'MinWidth'
          'Name'
          'Options'
          'Position'
          'Properties'
          'PropertiesClassName'
          'RepositoryItem'
          'RowLayoutItem'
          'SortIndex'
          'SortOrder'
          'Styles'
          'Summary'
          'Tag'
          'Visible'
          'VisibleForCustomization'
          'VisibleForEditForm'
          'VisibleForExpressionEditor'
          'VisibleForRowLayout'
          'Width')
      end
      item
        Component = cxGridLevel
        Properties.Strings = (
          'Caption'
          'FakeComponentLink1'
          'FakeComponentLink2'
          'FakeComponentLink3'
          'GridView'
          'ImageIndex'
          'MaxDetailHeight'
          'Name'
          'Options'
          'Styles'
          'Tag'
          'Visible')
      end>
    StorageName = 'cxPropertiesStore1'
    Left = 760
    Top = 224
  end
  object dxBarPopupMenu1: TdxBarPopupMenu
    BarManager = dxBarManager1
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbAddToWebMainPage'
      end
      item
        Visible = True
        ItemName = 'bbSetHint'
      end
      item
        Visible = True
        ItemName = 'bbImportFromFirstPage'
      end>
    UseOwnFont = False
    Left = 584
    Top = 224
    PixelsPerInch = 96
  end
  object IBCTrLocalUpdate: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 272
    Top = 232
  end
end
