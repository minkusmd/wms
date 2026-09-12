inherited frame91APIAccent: Tframe91APIAccent
  Width = 1173
  Height = 554
  Margins.Left = 4
  Margins.Top = 4
  Margins.Right = 4
  Margins.Bottom = 4
  Font.Height = -12
  ExplicitWidth = 1173
  ExplicitHeight = 554
  object cxPageControl1: TcxPageControl
    Left = 0
    Top = 0
    Width = 1173
    Height = 554
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    TabOrder = 0
    Properties.ActivePage = tsPriceList
    Properties.CustomButtons.Buttons = <>
    ClientRectBottom = 550
    ClientRectLeft = 4
    ClientRectRight = 1169
    ClientRectTop = 26
    object tsPriceList: TcxTabSheet
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Price list'
      ImageIndex = 0
      DesignSize = (
        1165
        524)
      object lcbPriceCategory: TcxLookupComboBox
        Left = 224
        Top = 14
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        ParentFont = False
        Properties.ImmediatePost = True
        Properties.KeyFieldNames = 'PRICE_CATEGORYID'
        Properties.ListColumns = <
          item
            FieldName = 'TITLE'
          end>
        Properties.ListOptions.GridLines = glHorizontal
        Properties.ListOptions.ShowHeader = False
        Properties.ListOptions.SyncMode = True
        Properties.ListSource = IBCDataSourcePriceCategories
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -12
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 6
        Width = 193
      end
      object cxLabel3: TcxLabel
        Left = 184
        Top = 15
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #1056#1072#1079#1088#1077#1079' '#1087#1088#1072#1081#1089#1072
        ParentFont = False
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -12
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 7
        Transparent = True
      end
      object Button1: TButton
        Left = 435
        Top = 13
        Width = 142
        Height = 20
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Generare in PriceList'
        TabOrder = 1
        OnClick = Button1Click
      end
      object cbRRP: TcxCheckBox
        Left = 224
        Top = 38
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #1048#1084#1087#1086#1088#1090' '#1056#1056#1062
        ParentFont = False
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -12
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = []
        Style.TransparentBorder = False
        Style.IsFontAssigned = True
        TabOrder = 8
      end
      object lbMaxTr: TcxLabel
        Left = 435
        Top = 38
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'lbMaxTr'
        ParentFont = False
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -12
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 9
      end
      object btnGetPriceList: TButton
        Left = 2
        Top = 13
        Width = 159
        Height = 20
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Actualizare lista de preturi'
        TabOrder = 0
        OnClick = btnGetPriceListClick
      end
      object Button3: TButton
        Left = 602
        Top = 13
        Width = 84
        Height = 20
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #1055#1088#1072#1081#1089
        TabOrder = 2
        OnClick = Button3Click
      end
      object btnGeneratePrice: TButton
        Left = 690
        Top = 13
        Width = 124
        Height = 20
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #1057#1075#1077#1085#1077#1088#1080#1088#1086#1074#1072#1090#1100' '#1087#1088#1072#1081#1089
        TabOrder = 3
        OnClick = btnGeneratePriceClick
      end
      object btnLoadImages: TButton
        Left = 818
        Top = 13
        Width = 84
        Height = 20
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #1048#1079#1086#1073#1088#1072#1078#1077#1085#1080#1103
        TabOrder = 4
        OnClick = btnLoadImagesClick
      end
      object cxPageControl2: TcxPageControl
        Left = 2
        Top = 58
        Width = 1143
        Height = 463
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Anchors = [akLeft, akTop, akRight, akBottom]
        TabOrder = 11
        Properties.ActivePage = tbsProperties
        Properties.CustomButtons.Buttons = <>
        ClientRectBottom = 459
        ClientRectLeft = 4
        ClientRectRight = 1139
        ClientRectTop = 26
        object tbsPricelist: TcxTabSheet
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #1042#1077#1088#1089#1080#1103' 1'
          ImageIndex = 0
          object cxGrid1: TcxGrid
            Left = 0
            Top = 28
            Width = 1135
            Height = 405
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Align = alClient
            TabOrder = 0
            object cxGrid1TableView1: TcxGridTableView
              Navigator.Buttons.First.Visible = False
              Navigator.Buttons.PriorPage.Visible = False
              Navigator.Buttons.Prior.Visible = False
              Navigator.Buttons.Next.Visible = False
              Navigator.Buttons.NextPage.Visible = False
              Navigator.Buttons.Last.Visible = False
              Navigator.Buttons.Insert.Visible = False
              Navigator.Buttons.Delete.Visible = False
              Navigator.Buttons.Edit.Visible = False
              Navigator.Buttons.Post.Visible = False
              Navigator.Buttons.Cancel.Visible = False
              Navigator.Buttons.Refresh.Visible = False
              Navigator.Buttons.SaveBookmark.Visible = False
              Navigator.Buttons.GotoBookmark.Visible = False
              Navigator.Buttons.Filter.Visible = False
              Navigator.InfoPanel.Visible = True
              Navigator.Visible = True
              FindPanel.DisplayMode = fpdmAlways
              FindPanel.UseExtendedSyntax = True
              Filtering.ExpressionEditing = True
              Filtering.ColumnExcelPopup.ApplyChanges = efacImmediately
              OptionsBehavior.IncSearch = True
              OptionsBehavior.CopyPreviewToClipboard = False
              OptionsBehavior.ImmediateEditor = False
              OptionsData.CancelOnExit = False
              OptionsData.Deleting = False
              OptionsData.DeletingConfirmation = False
              OptionsData.Inserting = False
              OptionsSelection.MultiSelect = True
              OptionsSelection.UnselectFocusedRecordOnExit = False
              OptionsView.GroupByBox = False
              Styles.OnGetContentStyle = cxGrid1TableView1StylesGetContentStyle
              object cxGrid1TableView1_PROMODESCRIPTION: TcxGridColumn
                Caption = 'Promotii'
                MinWidth = 16
                Width = 156
              end
              object cxGrid1TableView1_PROMOSTART: TcxGridColumn
                Caption = 'Start'
                MinWidth = 64
                Options.HorzSizing = False
                Width = 64
              end
              object cxGrid1TableView1_PROMOFINISH: TcxGridColumn
                Caption = 'Finish'
                MinWidth = 64
                Options.HorzSizing = False
                Width = 64
              end
              object cxGrid1TableView1_ROOTNAME: TcxGridColumn
                Caption = 'Root'
                MinWidth = 16
                SortIndex = 1
                SortOrder = soAscending
                Width = 89
              end
              object cxGrid1TableView1_FOLDERNAME: TcxGridColumn
                Caption = 'Folder Name'
                MinWidth = 16
                SortIndex = 0
                SortOrder = soAscending
                Width = 78
              end
              object cxGrid1TableView1_VENDORNAME: TcxGridColumn
                Caption = 'Producator'
                MinWidth = 16
                SortIndex = 2
                SortOrder = soAscending
                Width = 66
              end
              object cxGrid1TableView1_INPRICELIST: TcxGridColumn
                Caption = 'Stoc'
                DataBinding.ValueType = 'Integer'
                PropertiesClassName = 'TcxCheckBoxProperties'
                Properties.NullStyle = nssUnchecked
                Properties.ReadOnly = True
                Properties.ValueChecked = '1'
                Properties.ValueUnchecked = '0'
                MinWidth = 16
                Width = 34
              end
              object cxGrid1TableView1_GOODS_CODE: TcxGridColumn
                Caption = 'Cod produs'
                MinWidth = 16
                Width = 72
              end
              object cxGrid1TableView1_GOODSNAME: TcxGridColumn
                Caption = 'Denumire'
                MinWidth = 16
                Width = 255
              end
              object cxGrid1TableView1_PRICE3: TcxGridColumn
                Caption = 'PriceRRP'
                DataBinding.ValueType = 'Float'
                PropertiesClassName = 'TcxCalcEditProperties'
                Properties.Alignment.Horz = taRightJustify
                MinWidth = 16
                Width = 59
              end
              object cxGrid1TableView1_promoprice: TcxGridColumn
                Caption = 'Promo Price'
                MinWidth = 16
                Width = 63
              end
              object cxGrid1TableView1_promopricevalute: TcxGridColumn
                Caption = 'Promo valute'
                MinWidth = 16
                Width = 60
              end
              object cxGrid1TableView1_PRICE7: TcxGridColumn
                Caption = 'Price7'
                DataBinding.ValueType = 'Float'
                PropertiesClassName = 'TcxCalcEditProperties'
                MinWidth = 16
                Width = 46
              end
              object cxGrid1TableView1_COST: TcxGridColumn
                Caption = 'Cost'
                DataBinding.ValueType = 'Float'
                PropertiesClassName = 'TcxCalcEditProperties'
                MinWidth = 16
                Width = 41
              end
              object cxGrid1TableView1_PARENT_CODE: TcxGridColumn
                Caption = 'Parent'
                Visible = False
                MinWidth = 16
                Width = 70
              end
              object cxGrid1TableView1_QTY: TcxGridColumn
                Caption = 'Qty'
                DataBinding.ValueType = 'Float'
                PropertiesClassName = 'TcxCalcEditProperties'
                MinWidth = 16
              end
              object cxGrid1TableView1_OQTY: TcxGridColumn
                Caption = 'OQty'
                DataBinding.ValueType = 'Float'
                PropertiesClassName = 'TcxCalcEditProperties'
                MinWidth = 16
              end
              object cxGrid1TableView1_MARGIN: TcxGridColumn
                Caption = '% B'
                DataBinding.ValueType = 'Float'
                PropertiesClassName = 'TcxCalcEditProperties'
                Properties.DisplayFormat = '0.00'
                MinWidth = 16
              end
              object cxGrid1TableView1_MARGIN_RRP: TcxGridColumn
                Caption = '% RRP'
                DataBinding.ValueType = 'Float'
                PropertiesClassName = 'TcxCalcEditProperties'
                Properties.DisplayFormat = '0.00'
                MinWidth = 16
              end
              object cxGrid1TableView1_IMAGESLIST: TcxGridColumn
                Caption = 'Img'
                MinWidth = 16
              end
              object cxGrid1TableView1_WARRANTY: TcxGridColumn
                AlternateCaption = 'Warranty'
                Caption = 'W'
                MinWidth = 16
                Width = 38
              end
            end
            object cxGrid1Level1: TcxGridLevel
              GridView = cxGrid1TableView1
            end
          end
          object dxBarDockControl1: TdxBarDockControl
            Left = 0
            Top = 0
            Width = 1135
            Height = 28
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Align = dalTop
            BarManager = dxBarManager1
          end
        end
        object tsImages: TcxTabSheet
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #1048#1079#1086#1073#1088#1072#1078#1077#1085#1080#1103
          ImageIndex = 1
          object cxGrid3: TcxGrid
            Left = 14
            Top = 13
            Width = 685
            Height = 417
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            TabOrder = 0
            object cxGrid3DBTableView1: TcxGridDBTableView
              Navigator.Buttons.First.Visible = False
              Navigator.Buttons.PriorPage.Visible = False
              Navigator.Buttons.Prior.Visible = False
              Navigator.Buttons.Next.Visible = False
              Navigator.Buttons.NextPage.Visible = False
              Navigator.Buttons.Last.Visible = False
              Navigator.Buttons.Delete.Visible = False
              Navigator.Buttons.Edit.Visible = False
              Navigator.Buttons.Post.Visible = False
              Navigator.Buttons.Cancel.Visible = False
              Navigator.Buttons.Refresh.Visible = False
              Navigator.Buttons.SaveBookmark.Visible = False
              Navigator.Buttons.GotoBookmark.Visible = False
              Navigator.Buttons.Filter.Visible = False
              Navigator.InfoPanel.Visible = True
              Navigator.Visible = True
              DataController.DataSource = IBCDataSourceImages
              OptionsData.CancelOnExit = False
              OptionsData.Deleting = False
              OptionsData.DeletingConfirmation = False
              OptionsData.Editing = False
              OptionsData.Inserting = False
              OptionsView.GroupByBox = False
              object cxGrid3DBTableView1GOODSID: TcxGridDBColumn
                DataBinding.FieldName = 'GOODSID'
                MinWidth = 16
              end
              object cxGrid3DBTableView1GOODS_CODE: TcxGridDBColumn
                DataBinding.FieldName = 'GOODS_CODE'
                MinWidth = 16
                Width = 120
              end
              object cxGrid3DBTableView1IMAGESLIST: TcxGridDBColumn
                DataBinding.FieldName = 'IMAGESLIST'
                MinWidth = 16
                Width = 480
              end
            end
            object cxGrid3Level1: TcxGridLevel
              GridView = cxGrid3DBTableView1
            end
          end
          object cxImage1: TcxImage
            Left = 723
            Top = 13
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            ParentFont = False
            Properties.GraphicClassName = 'TdxSmartImage'
            Style.Font.Charset = DEFAULT_CHARSET
            Style.Font.Color = clWindowText
            Style.Font.Height = -12
            Style.Font.Name = 'Segoe UI'
            Style.Font.Style = []
            Style.IsFontAssigned = True
            TabOrder = 1
            Height = 237
            Width = 398
          end
          object Memo1: TMemo
            Left = 723
            Top = 269
            Width = 398
            Height = 161
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Lines.Strings = (
              'Memo1')
            ScrollBars = ssBoth
            TabOrder = 2
          end
        end
        object tbsProperties: TcxTabSheet
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #1061#1072#1088#1072#1082#1090#1077#1088#1080#1089#1090#1080#1082#1080
          ImageIndex = 2
          object cxGrid4: TcxGrid
            Left = 21
            Top = 19
            Width = 685
            Height = 417
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            TabOrder = 0
            object cxGridDBTableView1: TcxGridDBTableView
              Navigator.Buttons.First.Visible = False
              Navigator.Buttons.PriorPage.Visible = False
              Navigator.Buttons.Prior.Visible = False
              Navigator.Buttons.Next.Visible = False
              Navigator.Buttons.NextPage.Visible = False
              Navigator.Buttons.Last.Visible = False
              Navigator.Buttons.Insert.Visible = False
              Navigator.Buttons.Delete.Visible = False
              Navigator.Buttons.Edit.Visible = False
              Navigator.Buttons.Post.Visible = False
              Navigator.Buttons.Cancel.Visible = False
              Navigator.Buttons.Refresh.Visible = False
              Navigator.Buttons.SaveBookmark.Visible = False
              Navigator.Buttons.GotoBookmark.Visible = False
              Navigator.Buttons.Filter.Visible = False
              Navigator.InfoPanel.Visible = True
              Navigator.Visible = True
              DataController.DataSource = IBCDataSourceProperties
              OptionsData.CancelOnExit = False
              OptionsData.Deleting = False
              OptionsData.DeletingConfirmation = False
              OptionsData.Editing = False
              OptionsData.Inserting = False
              OptionsView.GroupByBox = False
              object cxGridDBColumn1: TcxGridDBColumn
                DataBinding.FieldName = 'GOODSID'
                MinWidth = 16
              end
              object cxGridDBColumn2: TcxGridDBColumn
                DataBinding.FieldName = 'GOODS_CODE'
                MinWidth = 16
                Width = 120
              end
              object cxGridDBColumn3: TcxGridDBColumn
                DataBinding.FieldName = 'TITLE'
                MinWidth = 16
                Width = 480
              end
            end
            object cxGridLevel1: TcxGridLevel
              GridView = cxGridDBTableView1
            end
          end
        end
        object cxTabSheet1: TcxTabSheet
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = 'cxTabSheet1'
          ImageIndex = 3
          object cxGrid5: TcxGrid
            Left = 0
            Top = 0
            Width = 1135
            Height = 433
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Align = alClient
            TabOrder = 0
            object cxGrid5DBTableView1: TcxGridDBTableView
              FindPanel.DisplayMode = fpdmAlways
              FindPanel.UseExtendedSyntax = True
            end
            object cxGrid5Level1: TcxGridLevel
              GridView = cxGrid5DBTableView1
            end
          end
        end
      end
      object btnLoadCaracteristics: TButton
        Left = 907
        Top = 13
        Width = 84
        Height = 20
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #1061#1072#1088#1072#1082#1090#1077#1088#1080#1089#1090#1080#1082#1080
        TabOrder = 5
        OnClick = btnLoadCaracteristicsClick
      end
      object cxProgressBar2: TcxProgressBar
        Left = 602
        Top = 38
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        ParentFont = False
        Properties.PeakValue = 30.000000000000000000
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -12
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 10
        Width = 485
      end
    end
    object cxTabSheet2: TcxTabSheet
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Products Images'
      ImageIndex = 1
      DesignSize = (
        1165
        524)
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 148
        Height = 524
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alLeft
        TabOrder = 0
        object btnStart: TcxButton
          Left = 6
          Top = 70
          Width = 129
          Height = 20
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = 'Start'
          OptionsImage.Spacing = 3
          TabOrder = 2
          OnClick = btnStartClick
        end
        object ckbNoImage: TcxCheckBox
          Left = 6
          Top = 19
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = 'Fara imagini'
          ParentFont = False
          Style.Font.Charset = DEFAULT_CHARSET
          Style.Font.Color = clWindowText
          Style.Font.Height = -12
          Style.Font.Name = 'Segoe UI'
          Style.Font.Style = []
          Style.TransparentBorder = False
          Style.IsFontAssigned = True
          TabOrder = 0
        end
        object ckbInPrice: TcxCheckBox
          Left = 6
          Top = 39
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = 'In pricelist'
          ParentFont = False
          Style.Font.Charset = DEFAULT_CHARSET
          Style.Font.Color = clWindowText
          Style.Font.Height = -12
          Style.Font.Name = 'Segoe UI'
          Style.Font.Style = []
          Style.TransparentBorder = False
          Style.IsFontAssigned = True
          TabOrder = 1
        end
        object btnStop: TcxButton
          Left = 6
          Top = 95
          Width = 129
          Height = 20
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = 'Stop'
          Enabled = False
          OptionsImage.Spacing = 3
          TabOrder = 3
        end
        object cxLabel1: TcxLabel
          Left = 6
          Top = 122
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = 'Timp de executie'
          ParentFont = False
          Style.Font.Charset = DEFAULT_CHARSET
          Style.Font.Color = clWindowText
          Style.Font.Height = -12
          Style.Font.Name = 'Segoe UI'
          Style.Font.Style = []
          Style.IsFontAssigned = True
          TabOrder = 4
        end
        object lbTime: TcxLabel
          Left = 96
          Top = 122
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          AutoSize = False
          Caption = '00:00'
          ParentFont = False
          Style.Font.Charset = DEFAULT_CHARSET
          Style.Font.Color = clWindowText
          Style.Font.Height = -12
          Style.Font.Name = 'Segoe UI'
          Style.Font.Style = []
          Style.IsFontAssigned = True
          Properties.LabelStyle = cxlsLowered
          TabOrder = 5
          Height = 16
          Width = 26
        end
        object cxProgressBar1: TcxProgressBar
          Left = 6
          Top = 141
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          ParentFont = False
          Style.Font.Charset = DEFAULT_CHARSET
          Style.Font.Color = clWindowText
          Style.Font.Height = -12
          Style.Font.Name = 'Segoe UI'
          Style.Font.Style = []
          Style.IsFontAssigned = True
          TabOrder = 6
          Width = 129
        end
      end
      object cxGrid2: TcxGrid
        Left = 153
        Top = 2
        Width = 1010
        Height = 364
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Anchors = [akLeft, akTop, akRight, akBottom]
        TabOrder = 1
        ExplicitWidth = 1011
        ExplicitHeight = 365
        object cxGrid2DBTableView1: TcxGridDBTableView
          DataController.DataSource = IBCDataSourceGoods
          OptionsView.ColumnAutoWidth = True
          object cxGrid2DBTableView1Column1: TcxGridDBColumn
            DataBinding.FieldName = 'GOODSID'
            MinWidth = 16
          end
          object cxGrid2DBTableView1Column2: TcxGridDBColumn
            DataBinding.FieldName = 'GOODS_CODE'
            MinWidth = 16
            Width = 96
          end
          object cxGrid2DBTableView1Column3: TcxGridDBColumn
            DataBinding.FieldName = 'GOODS_TITLE'
            MinWidth = 16
            Width = 817
          end
          object cxGrid2DBTableView1Column4: TcxGridDBColumn
            Caption = 'P'
            DataBinding.FieldName = 'FLG_IN_PRICE'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.NullStyle = nssUnchecked
            Properties.ValueChecked = '1'
            Properties.ValueUnchecked = '0'
            MinWidth = 16
            Width = 19
          end
        end
        object cxGrid2Level1: TcxGridLevel
          GridView = cxGrid2DBTableView1
        end
      end
    end
  end
  object IdHTTP1: TIdHTTP
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 448
    Top = 40
  end
  object IBCQueryPriceCategories: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'select * from TS_CUST_PRICE_CATEGORIES'
      'where customerid = :customerid')
    Left = 144
    Top = 184
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'customerid'
        Value = nil
      end>
  end
  object IBCDataSourcePriceCategories: TIBCDataSource
    DataSet = IBCQueryPriceCategories
    Left = 88
    Top = 288
  end
  object IBCTrLocal: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 448
    Top = 104
  end
  object IBCQueryCurrencyUSD: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'select transfer_rate from ts_currency where currencyid = 840')
    Left = 280
    Top = 184
  end
  object IBCQueryGoods: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'select GF.GOODSID, GF.GOODS_CODE, gf.goods_title,'
      'get_flg_in_price(gf.goodsid) FLG_IN_PRICE'
      'from TS_GOODS_FOREIGN GF'
      'where GF.CUSTOMERID = 198'
      '&FlgNoImage'
      '&FlgInPrice')
    Left = 448
    Top = 240
    MacroData = <
      item
        Name = 'FlgNoImage'
      end
      item
        Name = 'FlgInPrice'
      end>
  end
  object IBCDataSourceGoods: TIBCDataSource
    DataSet = IBCQueryGoods
    Left = 448
    Top = 184
  end
  object IBCQueryImages: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'select gf.goodsid, gf.goods_code, g.title, an.imageslist from'
      'ts_goods_foreign gf'
      'join ts_goods g on g.goodsid = gf.goodsid'
      
        'join tapi_accent_nomeclature an on an.product_code = gf.goods_co' +
        'de and gf.customerid = 198'
      'where not exists('
      
        '    select * from ts_goods_image gi where gi.goodsid = gf.goodsi' +
        'd'
      '    )')
    Left = 720
    Top = 336
  end
  object IBCDataSourceImages: TIBCDataSource
    DataSet = IBCQueryImages
    Left = 720
    Top = 280
  end
  object IBCQueryProperties: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'select gf.goodsid, gf.goods_code, an.internalid, g.title'
      'from ts_goods_foreign gf'
      'join ts_goods g on g.goodsid = gf.goodsid'
      
        'join tapi_accent_nomeclature an on an.product_code = gf.goods_co' +
        'de and'
      '      gf.customerid = 198'
      'where not exists(select *'
      '                 from ts_goods_descriptions gi'
      '                 where gi.goodsid = gf.goodsid)')
    Left = 600
    Top = 440
  end
  object IBCDataSourceProperties: TIBCDataSource
    DataSet = IBCQueryProperties
    Left = 600
    Top = 376
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
    Left = 368
    Top = 336
    PixelsPerInch = 96
    object dxBarManager1Bar1: TdxBar
      Caption = 'Custom 1'
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 623
      FloatTop = 272
      FloatClientWidth = 92
      FloatClientHeight = 24
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbGenerateWebPromotion'
        end
        item
          Visible = True
          ItemName = 'bbSaveData'
        end
        item
          Visible = True
          ItemName = 'bbLoadData'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object bbGenerateWebPromotion: TdxBarButton
      Caption = 'Add to web promo'
      Category = 0
      Hint = 'Add to web promo'
      Visible = ivAlways
      ImageIndex = 33
      OnClick = bbGenerateWebPromotionClick
    end
    object bbSaveData: TdxBarButton
      Caption = 'Save data'
      Category = 0
      Hint = 'Save data'
      Visible = ivAlways
      OnClick = bbSaveDataClick
    end
    object bbLoadData: TdxBarButton
      Caption = 'Load data'
      Category = 0
      Hint = 'Load data'
      Visible = ivAlways
      OnClick = bbLoadDataClick
    end
  end
end
