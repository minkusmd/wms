object frmGoodsQuickInfoDlg: TfrmGoodsQuickInfoDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Informatia despre produs'
  ClientHeight = 681
  ClientWidth = 872
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 872
    Height = 64
    Title = 'Informatia despre produs'
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
    ImageIndex = 1
    ExplicitWidth = 875
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 856
    Height = 549
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    ExplicitWidth = 859
    object Bevel1: TBevel
      Left = 0
      Top = 0
      Width = 852
      Height = 121
      Align = alTop
      Shape = bsSpacer
      ExplicitLeft = -2
      ExplicitTop = -3
      ExplicitWidth = 855
    end
    object Label1: TLabel
      Left = 12
      Top = 15
      Width = 52
      Height = 15
      Caption = 'Denumire'
    end
    object Label2: TLabel
      Left = 12
      Top = 59
      Width = 77
      Height = 15
      Caption = 'Denumire web'
    end
    object lbWarning: TLabel
      AlignWithMargins = True
      Left = 12
      Top = 569
      Width = 828
      Height = 15
      Margins.Left = 12
      Margins.Top = 16
      Margins.Right = 12
      Margins.Bottom = 24
      Align = alTop
      Caption = 'Nu exista descrieri suplimentare pentru acest produs!'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      ExplicitWidth = 278
    end
    object pcPageControl: TPageControl
      AlignWithMargins = True
      Left = 8
      Top = 121
      Width = 836
      Height = 424
      Margins.Left = 8
      Margins.Top = 0
      Margins.Right = 8
      Margins.Bottom = 8
      ActivePage = tbsDescriptions
      Align = alTop
      Images = cxImageList1
      TabOrder = 6
      OnChange = pcPageControlChange
      ExplicitWidth = 839
      object tbsDescriptions: TTabSheet
        Caption = '&1 - Descriere'
        ImageIndex = -1
        object mmDESCRIPTION: TMemo
          Left = 0
          Top = 0
          Width = 828
          Height = 394
          TabStop = False
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 0
          ExplicitWidth = 831
        end
      end
      object tbsFields: TTabSheet
        Caption = '&2 - Caracteristici'
        ImageIndex = -1
        object cxGridInfo: TcxGrid
          Left = 0
          Top = 0
          Width = 828
          Height = 394
          Margins.Left = 8
          Margins.Top = 0
          Margins.Right = 8
          Margins.Bottom = 8
          Align = alClient
          TabOrder = 0
          ExplicitWidth = 831
          object cxGridInfoTable: TcxGridTableView
            Navigator.Buttons.First.Visible = True
            Navigator.Buttons.PriorPage.Visible = True
            Navigator.Buttons.Prior.Visible = True
            Navigator.Buttons.Next.Visible = True
            Navigator.Buttons.NextPage.Visible = True
            Navigator.Buttons.Last.Visible = True
            Navigator.Buttons.Insert.Visible = True
            Navigator.Buttons.Append.Visible = False
            Navigator.Buttons.Delete.Visible = True
            Navigator.Buttons.Edit.Visible = True
            Navigator.Buttons.Post.Visible = True
            Navigator.Buttons.Cancel.Visible = True
            Navigator.Buttons.Refresh.Visible = True
            Navigator.Buttons.SaveBookmark.Visible = True
            Navigator.Buttons.GotoBookmark.Visible = True
            Navigator.Buttons.Filter.Visible = True
            OptionsBehavior.ImmediateEditor = False
            OptionsCustomize.ColumnFiltering = False
            OptionsCustomize.ColumnGrouping = False
            OptionsCustomize.ColumnMoving = False
            OptionsCustomize.ColumnSorting = False
            OptionsData.Deleting = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsSelection.InvertSelect = False
            OptionsView.NoDataToDisplayInfoText = '<Fara caracteristici>'
            OptionsView.ScrollBars = ssVertical
            OptionsView.CellAutoHeight = True
            OptionsView.ColumnAutoWidth = True
            OptionsView.GridLineColor = 13750737
            OptionsView.GroupByBox = False
            OptionsView.Indicator = True
            Styles.OnGetContentStyle = cxGridInfoTableStylesGetContentStyle
            Styles.Header = dmAdditions.cxStyle_GridHeader
            object cxGridInfo_FLG_GROUP: TcxGridColumn
              DataBinding.ValueType = 'Boolean'
              Visible = False
              VisibleForCustomization = False
            end
            object cxGridInfo_FILTERNAME_RUS: TcxGridColumn
              Caption = 'Caracteristica'
              Width = 177
            end
            object cxGridInfo_PARAM_VALUE_RUS: TcxGridColumn
              Caption = 'Valoare'
              PropertiesClassName = 'TcxMemoProperties'
              Properties.WantReturns = False
              Properties.WordWrap = False
              Width = 394
            end
          end
          object cxGridInfoLevel: TcxGridLevel
            GridView = cxGridInfoTable
          end
        end
      end
      object tbsImages: TTabSheet
        Caption = '&3 - Imagini'
        ImageIndex = -1
        object lbImages: TListBox
          Left = 648
          Top = 0
          Width = 180
          Height = 394
          Style = lbOwnerDrawFixed
          Align = alRight
          BorderStyle = bsNone
          DoubleBuffered = False
          ExtendedSelect = False
          ParentDoubleBuffered = False
          TabOrder = 1
          OnClick = lbImagesClick
          OnDrawItem = lbImagesDrawItem
          ExplicitLeft = 651
        end
        object imgImage: TcxImage
          Left = 0
          Top = 0
          Margins.Right = 8
          Align = alClient
          ParentFont = False
          Properties.FitMode = ifmProportionalStretch
          Properties.GraphicClassName = 'TdxSmartImage'
          ZoomingOptions.MaxZoom = 300
          ZoomingOptions.MinZoom = 25
          ZoomingOptions.ShowZoomTrackBar = True
          TabOrder = 0
          ExplicitWidth = 651
          Height = 394
          Width = 648
        end
      end
      object tbsUsedFor: TTabSheet
        Caption = '&4 - Se foloseste pentru...'
        ImageIndex = -1
        object cxDBMemo1: TcxDBMemo
          AlignWithMargins = True
          Left = 3
          Top = 3
          Align = alClient
          DataBinding.DataField = 'SEARCHKEYS'
          DataBinding.DataSource = IBCDataSourceSearchkeys
          ParentFont = False
          Properties.ReadOnly = True
          Properties.ScrollBars = ssBoth
          Style.Font.Charset = RUSSIAN_CHARSET
          Style.Font.Color = clWindowText
          Style.Font.Height = -13
          Style.Font.Name = 'Consolas'
          Style.Font.Style = []
          Style.IsFontAssigned = True
          TabOrder = 0
          ExplicitWidth = 825
          Height = 388
          Width = 822
        end
      end
      object tbsRelatedKey: TTabSheet
        Caption = '&5 - Produse inrudite'
        ImageIndex = -1
        object cxGrid1: TcxGrid
          Left = 0
          Top = 0
          Width = 828
          Height = 394
          Align = alClient
          TabOrder = 0
          ExplicitWidth = 831
          object cxGrid1DBTableView1: TcxGridDBTableView
            OnKeyDown = cxGrid1DBTableView1KeyDown
            DataController.DataSource = IBCDataSourceRelatedGoods
            OptionsBehavior.IncSearch = True
            OptionsBehavior.ImmediateEditor = False
            OptionsData.CancelOnExit = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsSelection.InvertSelect = False
            OptionsView.ColumnAutoWidth = True
            OptionsView.GroupByBox = False
            object cxGrid1DBTableView1_GOODSID: TcxGridDBColumn
              Caption = 'Cod'
              DataBinding.FieldName = 'GOODSID'
              HeaderAlignmentHorz = taCenter
              MinWidth = 64
              Options.HorzSizing = False
            end
            object cxGrid1DBTableView1_WEBGOODSTYPE: TcxGridDBColumn
              Caption = 'Tip produs'
              DataBinding.FieldName = 'WEBGOODSTYPE_TITLE'
              MinWidth = 150
              Options.HorzSizing = False
              Width = 150
            end
            object cxGrid1DBTableView1_GOODS_NAME: TcxGridDBColumn
              Caption = 'Produs'
              DataBinding.FieldName = 'TITLE_ROM'
              HeaderAlignmentHorz = taCenter
              Width = 547
            end
            object cxGrid1DBTableView1_PRICE_MDL: TcxGridDBColumn
              Caption = 'Pret'
              DataBinding.FieldName = 'PRICE'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = ',0.00;-,0.00'
              Properties.UseThousandSeparator = True
              HeaderAlignmentHorz = taCenter
              MinWidth = 79
              Options.HorzSizing = False
              Width = 79
            end
            object cxGrid1DBTableView1_FLG_IN_PRICE: TcxGridDBColumn
              Caption = 'P'
              DataBinding.FieldName = 'FLG_IN_PRICE'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.ValueChecked = '1'
              Properties.ValueGrayed = 0
              Properties.ValueUnchecked = '0'
              HeaderAlignmentHorz = taCenter
              MinWidth = 24
              Options.HorzSizing = False
              Width = 24
            end
            object cxGrid1DBTableView1Column1: TcxGridDBColumn
              Caption = 'Imagine'
              DataBinding.FieldName = 'GOODS_IMAGE'
              PropertiesClassName = 'TcxImageProperties'
              Properties.GraphicClassName = 'TdxSmartImage'
            end
          end
          object cxGrid1Level1: TcxGridLevel
            GridView = cxGrid1DBTableView1
          end
        end
      end
    end
    object mmTITLE: TMemo
      Left = 126
      Top = 12
      Width = 586
      Height = 38
      TabStop = False
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
    end
    object edWEBTYPE: TEdit
      Left = 126
      Top = 56
      Width = 159
      Height = 23
      TabStop = False
      ReadOnly = True
      TabOrder = 1
    end
    object edVENDOR: TEdit
      Left = 381
      Top = 56
      Width = 157
      Height = 23
      TabStop = False
      ReadOnly = True
      TabOrder = 3
    end
    object edCODE: TEdit
      Left = 544
      Top = 56
      Width = 168
      Height = 23
      TabStop = False
      ReadOnly = True
      TabOrder = 4
    end
    object edDETAILS: TEdit
      Left = 126
      Top = 85
      Width = 586
      Height = 23
      TabStop = False
      ReadOnly = True
      TabOrder = 5
    end
    object edBASE_CODE: TEdit
      Left = 291
      Top = 56
      Width = 84
      Height = 23
      TabStop = False
      ReadOnly = True
      TabOrder = 2
    end
    object cxDBImage1: TcxDBImage
      Left = 718
      Top = 8
      DataBinding.DataField = 'GOODS_IMAGE'
      DataBinding.DataSource = IBCDataSourceRelatedGoods
      Properties.GraphicClassName = 'TdxSmartImage'
      TabOrder = 7
      Height = 100
      Width = 122
    end
  end
  object pnButtons: TPanel
    Left = 0
    Top = 629
    Width = 872
    Height = 52
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    ExplicitWidth = 875
    DesignSize = (
      872
      52)
    object btnClose: TcxButton
      Left = 762
      Top = 7
      Width = 90
      Height = 29
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = 'Inchide'
      ModalResult = 2
      TabOrder = 0
      ExplicitLeft = 765
    end
  end
  object IBCQuerySearchkeys: TIBCQuery
    KeyFields = 'GOODSID'
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      'select * from ts_goods_searchkeys'
      'where goodsid = :goodsid')
    MasterFields = 'GOODSID'
    DetailFields = 'GOODSID'
    AutoCommit = False
    Left = 480
    Top = 344
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'goodsid'
        Value = nil
      end>
  end
  object IBCDataSourceSearchkeys: TIBCDataSource
    DataSet = IBCQuerySearchkeys
    Left = 476
    Top = 295
  end
  object cxImageList1: TcxImageList
    SourceDPI = 96
    FormatVersion = 1
    Left = 368
    Top = 344
    Bitmap = {
      494C010101000800040010001000FFFFFFFF2110FFFFFFFFFFFFFFFF424D3600
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
      000000000000000000000000000000000000000000000000000000000000052D
      4282000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000014B1
      FFFF052D42820000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000014B1
      FFFF14B1FFFF052D428200000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000129FE5F214B1FFFF14B1
      FFFF14B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1
      FFFF13A2E9F40000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000014B1FFFF14B1FFFF14B1
      FFFF14B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1
      FFFF14B1FFFF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000014B1FFFF14B1FFFF14B1
      FFFF14B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1
      FFFF14B1FFFF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000014B1FFFF14B1FFFF14B1
      FFFF14B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1FFFF13A2E9F4042738780002
      031D000000020000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000014B1FFFF14B1FFFF14B1
      FFFF14B1FFFF14B1FFFF14B1FFFF14B1FFFF13A2E9F400070A340414005C1970
      02D8229A02FD197202DA0415005F000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000014B1FFFF14B1FFFF14B1
      FFFF14B1FFFF14B1FFFF14B1FFFF14B1FFFF04283B7B0413005B229C02FF2196
      02FA0414005E219402F9229C02FF0415005F0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000014B1FFFF14B1FFFF14B1
      FFFF14B1FFFF14B1FFFF14B1FFFF14B1FFFF00020421186D02D5229C02FF0927
      0180000000000825007D229C02FF197102D90000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000129DE1F014B1FFFF14B1
      FFFF14B1FFFF14B1FFFF14B1FFFF14B1FFFF00000006219502F9166602CF0000
      00050000000000000005166401CD229A02FD0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000186C02D4229C02FF229C
      02FF00000000229C02FF229C02FF197002D80000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000004120059229C02FF229C
      02FF00000000229C02FF229C02FF0414005D0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000004120059186C
      02D4219502F9186E02D60413005B000000000000000000000000000000000000
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
    DesignInfo = 22544752
    ImageInfo = <
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D225554
          462D38223F3E0D0A3C7376672076657273696F6E3D22312E31222069643D224E
          657874436F6D6D656E742220786D6C6E733D22687474703A2F2F7777772E7733
          2E6F72672F323030302F7376672220786D6C6E733A786C696E6B3D2268747470
          3A2F2F7777772E77332E6F72672F313939392F786C696E6B2220783D22307078
          2220793D22307078222076696577426F783D2230203020333220333222207374
          796C653D22656E61626C652D6261636B67726F756E643A6E6577203020302033
          322033323B2220786D6C3A73706163653D227072657365727665223E26233133
          3B262331303B3C7374796C6520747970653D22746578742F6373732220786D6C
          3A73706163653D227072657365727665223E2E59656C6C6F777B66696C6C3A23
          4646423131353B7D262331333B262331303B2623393B2E477265656E7B66696C
          6C3A233033394332333B7D3C2F7374796C653E0D0A3C7061746820636C617373
          3D2259656C6C6F772220643D224D32352C3136632D352C302D392D342D392D39
          63302D302E332C302D302E372C302E312D31483343322E342C362C322C362E34
          2C322C3776313463302C302E362C302E342C312C312C31683376366C362D3668
          313363302E362C302C312D302E342C312D3120202623393B762D352E31433235
          2E372C31362C32352E332C31362C32352C31367A222F3E0D0A3C706174682063
          6C6173733D22477265656E2220643D224D32352C3134632D332E392C302D372D
          332E312D372D3763302D332E392C332E312D372C372D3773372C332E312C372C
          374333322C31302E392C32382E392C31342C32352C31347A204D32362C365632
          682D327634682D336C342C366C342D364832367A222F3E0D0A3C2F7376673E0D
          0A}
        FileName = 'SVG Images\Comments\NextComment.svg'
        Keywords = 'Comments;NextComment'
      end>
  end
  object IBCQueryGoodsRelatedGoods: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT RELATEDGOODSID GOODSID,'
      'WEBGOODSTYPE_ID,'
      'WEBGOODSTYPE_TITLE,'
      'WEBGOODSTYPE_TITLE_RUS,'
      'TITLE_ROM,'
      'TITLE_RUS,'
      'PRICE,'
      'CASHBACK_VALUE,'
      'GOODS_IMAGE,'
      'RAITING,'
      'CATALOGID,'
      'FLG_IN_PRICE FROM WEB_GET_RELATEDGOODS(:goodsid)')
    Left = 72
    Top = 320
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'goodsid'
        Value = nil
      end>
  end
  object IBCDataSourceRelatedGoods: TIBCDataSource
    DataSet = IBCQueryGoodsRelatedGoods
    Left = 72
    Top = 248
  end
end
