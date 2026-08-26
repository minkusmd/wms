object frmQuickCustomerInfoDlg: TfrmQuickCustomerInfoDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Informatia generala despre client'
  ClientHeight = 671
  ClientWidth = 621
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 621
    Height = 64
    Title = 'Informatia generala despre client'
    Text = 'Vizualizarea informatiei generale despre client'
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
    ImageIndex = 2
  end
  object pnButtons: TPanel
    Left = 0
    Top = 614
    Width = 621
    Height = 57
    Align = alBottom
    BevelOuter = bvNone
    Color = clWindow
    Padding.Left = 12
    Padding.Top = 12
    Padding.Right = 12
    Padding.Bottom = 14
    ParentBackground = False
    ShowCaption = False
    TabOrder = 2
    object btnClose: TcxButton
      AlignWithMargins = True
      Left = 511
      Top = 12
      Width = 90
      Height = 31
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 8
      Margins.Bottom = 0
      Align = alRight
      Cancel = True
      Caption = 'Inchide'
      ModalResult = 2
      TabOrder = 0
    end
  end
  object pnClient: TPanel
    Left = 0
    Top = 64
    Width = 621
    Height = 550
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 0
    Align = alClient
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    object dxBarDockControl1: TdxBarDockControl
      Left = 0
      Top = 0
      Width = 621
      Height = 28
      Align = dalTop
      BarManager = dxBarManager
      SunkenBorder = True
      UseOwnSunkenBorder = True
    end
    object Panel: TPanel
      AlignWithMargins = True
      Left = 0
      Top = 29
      Width = 621
      Height = 521
      Margins.Left = 0
      Margins.Top = 1
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alClient
      BevelKind = bkFlat
      BevelOuter = bvNone
      Color = clWindow
      ParentBackground = False
      TabOrder = 1
      object Label1: TLabel
        Left = 16
        Top = 26
        Width = 61
        Height = 15
        Caption = 'Cod, Nume'
      end
      object Label2: TLabel
        Left = 16
        Top = 69
        Width = 51
        Height = 15
        Caption = 'Telefoane'
      end
      object Label4: TLabel
        Left = 16
        Top = 100
        Width = 29
        Height = 15
        Caption = 'Email'
      end
      object Label5: TLabel
        Left = 16
        Top = 124
        Width = 66
        Height = 15
        Caption = 'Adresa fizica'
      end
      object cxLabel10: TLabel
        Left = 16
        Top = 197
        Width = 52
        Height = 15
        Caption = 'Cod fiscal'
        Transparent = True
      end
      object cxLabel11: TLabel
        Left = 16
        Top = 228
        Width = 46
        Height = 15
        Caption = 'Cod TVA'
        Transparent = True
      end
      object cxLabel19: TLabel
        Left = 16
        Top = 164
        Width = 40
        Height = 15
        Caption = 'Juridica'
        Transparent = True
      end
      object sbOpenCustomer: TSpeedButton
        Left = 531
        Top = 19
        Width = 62
        Height = 25
        Caption = 'Deschide'
        OnClick = sbOpenCustomerClick
      end
      object cxDBTextEdit1: TcxDBTextEdit
        Left = 84
        Top = 21
        TabStop = False
        DataBinding.DataField = 'CUSTOMERID'
        DataBinding.DataSource = IBCDataSourceInfo
        ParentFont = False
        Properties.ReadOnly = True
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -12
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 0
        Width = 69
      end
      object cxDBTextEdit2: TcxDBTextEdit
        Left = 159
        Top = 21
        TabStop = False
        DataBinding.DataField = 'DISPLAYNAME'
        DataBinding.DataSource = IBCDataSourceInfo
        ParentFont = False
        Properties.ReadOnly = True
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -12
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = []
        Style.TextStyle = []
        Style.IsFontAssigned = True
        TabOrder = 1
        Width = 366
      end
      object cxDBTextEdit3: TcxDBTextEdit
        Left = 84
        Top = 64
        TabStop = False
        DataBinding.DataField = 'TELEFON1'
        DataBinding.DataSource = IBCDataSourceInfo
        ParentFont = False
        Properties.ReadOnly = True
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -12
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 4
        Width = 173
      end
      object cxDBTextEdit5: TcxDBTextEdit
        Left = 264
        Top = 62
        TabStop = False
        DataBinding.DataField = 'MOBILE'
        DataBinding.DataSource = IBCDataSourceInfo
        ParentFont = False
        Properties.ReadOnly = True
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -12
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 3
        Width = 117
      end
      object cxDBTextEdit7: TcxDBTextEdit
        Left = 84
        Top = 95
        TabStop = False
        DataBinding.DataField = 'EMAIL'
        DataBinding.DataSource = IBCDataSourceInfo
        ParentFont = False
        Properties.ReadOnly = True
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -12
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 5
        Width = 337
      end
      object cxDBTextEdit8: TcxDBTextEdit
        Left = 320
        Top = 126
        TabStop = False
        DataBinding.DataField = 'ADDRESS'
        DataBinding.DataSource = IBCDataSourceInfo
        ParentFont = False
        Properties.ReadOnly = True
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -12
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 7
        Width = 273
      end
      object cxDBTextEdit9: TcxDBTextEdit
        Left = 84
        Top = 192
        TabStop = False
        DataBinding.DataField = 'IDEN_NUMBER'
        DataBinding.DataSource = IBCDataSourceInfo
        ParentFont = False
        Properties.ReadOnly = True
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -12
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 9
        Width = 186
      end
      object cxDBTextEdit10: TcxDBTextEdit
        Left = 84
        Top = 223
        TabStop = False
        DataBinding.DataField = 'VAT_NUMBER'
        DataBinding.DataSource = IBCDataSourceInfo
        ParentFont = False
        Properties.ReadOnly = True
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -12
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 11
        Width = 186
      end
      object cxDBTextEdit11: TcxDBTextEdit
        Left = 84
        Top = 161
        TabStop = False
        DataBinding.DataField = 'ADDRESS2'
        DataBinding.DataSource = IBCDataSourceInfo
        ParentFont = False
        Properties.ReadOnly = True
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -12
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 8
        Width = 509
      end
      object cxDBTextEdit12: TcxDBTextEdit
        Left = 84
        Top = 126
        TabStop = False
        DataBinding.DataField = 'CITY_TITLE'
        DataBinding.DataSource = IBCDataSourceInfo
        ParentFont = False
        Properties.ReadOnly = True
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -12
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 6
        Width = 230
      end
      object cxDBCheckBox1: TcxDBCheckBox
        Left = 424
        Top = 197
        TabStop = False
        Caption = 'Cartele de reducere'
        DataBinding.DataField = 'HAS_DISCOUNT_CARD'
        DataBinding.DataSource = IBCDataSourceInfo
        ParentFont = False
        Properties.Alignment = taLeftJustify
        Properties.ReadOnly = True
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        TabOrder = 10
      end
      object cxDBCheckBox2: TcxDBCheckBox
        Left = 424
        Top = 228
        TabStop = False
        Caption = 'Cont pe website'
        DataBinding.DataField = 'HAS_WEB_LOGIN'
        DataBinding.DataSource = IBCDataSourceInfo
        ParentFont = False
        Properties.Alignment = taLeftJustify
        Properties.ReadOnly = True
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        TabOrder = 13
      end
      object cxPageControl1: TcxPageControl
        Left = 6
        Top = 257
        Width = 585
        Height = 254
        TabOrder = 15
        Properties.ActivePage = cxTabSheet3
        Properties.CustomButtons.Buttons = <>
        Properties.Images = cxImageList2
        ClientRectBottom = 250
        ClientRectLeft = 4
        ClientRectRight = 581
        ClientRectTop = 26
        object cxTabSheet5: TcxTabSheet
          Caption = 'Numere de telefon'
          ImageIndex = 1
          OnShow = cxTabSheet5Show
          inline frameCustomerPhones1: TframeCustomerPhones
            Left = 0
            Top = 0
            Width = 577
            Height = 224
            Align = alClient
            TabOrder = 0
            ExplicitWidth = 577
            ExplicitHeight = 224
            inherited cxGrid1: TcxGrid
              Width = 577
              Height = 196
              ExplicitWidth = 577
              ExplicitHeight = 196
            end
            inherited dxBarManager1: TdxBarManager
              PixelsPerInch = 96
            end
            inherited IBCQueryCustomerPhones: TIBCQuery
              Left = 184
              Top = 152
            end
            inherited IBCDataSourceCustomerPhones: TIBCDataSource
              Left = 184
              Top = 96
            end
          end
        end
        object cxTabSheet4: TcxTabSheet
          Caption = 'Adrese'
          ImageIndex = 2
          inline frameCustomerAddr1: TframeCustomerAddr
            Left = 0
            Top = 0
            Width = 577
            Height = 224
            Align = alClient
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            ExplicitWidth = 577
            ExplicitHeight = 224
            inherited cxGrid3: TcxGrid
              Width = 577
              Height = 196
              ExplicitWidth = 577
              ExplicitHeight = 196
            end
            inherited IBCQueryCustomerAddr: TIBCQuery
              Connection = dmDB.IBCConnection
            end
            inherited dxBarManager1: TdxBarManager
              PixelsPerInch = 96
            end
          end
        end
        object cxTabSheet3: TcxTabSheet
          Caption = 'Apeluri'
          ImageIndex = 4
          OnShow = cxTabSheet3Show
          object cxGrid1: TcxGrid
            Left = 0
            Top = 28
            Width = 577
            Height = 173
            Align = alClient
            BevelInner = bvNone
            BevelOuter = bvNone
            TabOrder = 1
            object cxGrid1DBTableView1: TcxGridDBTableView
              OnKeyDown = cxGrid1DBTableView1KeyDown
              DataController.DataSource = IBCDataSourceDialHistory
              OptionsBehavior.ImmediateEditor = False
              OptionsData.CancelOnExit = False
              OptionsData.Deleting = False
              OptionsData.DeletingConfirmation = False
              OptionsData.Editing = False
              OptionsData.Inserting = False
              OptionsView.ColumnAutoWidth = True
              OptionsView.GroupByBox = False
              object cxGrid1DBTableView1Column1: TcxGridDBColumn
                Caption = '...'
                DataBinding.FieldName = 'CALLTYPEID'
                PropertiesClassName = 'TcxImageComboBoxProperties'
                Properties.Images = dmAdditions.cxImageList_SWN
                Properties.Items = <
                  item
                    ImageIndex = 131
                    Value = 1
                  end
                  item
                    ImageIndex = 132
                    Value = 0
                  end>
                HeaderAlignmentHorz = taCenter
                MinWidth = 26
                Options.HorzSizing = False
                Width = 26
              end
              object cxGrid1DBTableView1DATA: TcxGridDBColumn
                Caption = 'Data'
                DataBinding.FieldName = 'DATA'
                HeaderAlignmentHorz = taCenter
                Width = 100
              end
              object cxGrid1DBTableView1SOURCEID: TcxGridDBColumn
                Caption = 'Telefon'
                DataBinding.FieldName = 'SOURCEID'
                HeaderAlignmentHorz = taCenter
                Width = 120
              end
              object cxGrid1DBTableView1Column2: TcxGridDBColumn
                Caption = 'Durata'
                DataBinding.FieldName = 'DURATION'
                HeaderAlignmentHorz = taCenter
                Width = 80
              end
              object cxGrid1DBTableView1WAV: TcxGridDBColumn
                DataBinding.FieldName = 'WAV'
                Visible = False
                HeaderAlignmentHorz = taCenter
                MinWidth = 64
                Options.HorzSizing = False
                VisibleForCustomization = False
              end
              object cxGrid1DBTableView1USERNAME: TcxGridDBColumn
                Caption = 'Operator'
                DataBinding.FieldName = 'USERNAME'
                HeaderAlignmentHorz = taCenter
                Width = 200
              end
            end
            object cxGrid1Level1: TcxGridLevel
              GridView = cxGrid1DBTableView1
            end
          end
          object dxBarDockControl2: TdxBarDockControl
            Left = 0
            Top = 0
            Width = 577
            Height = 28
            Align = dalTop
            BarManager = dxBarManager
          end
          object Panel1: TPanel
            Left = 0
            Top = 201
            Width = 577
            Height = 23
            Align = alBottom
            BevelKind = bkFlat
            BevelOuter = bvNone
            Color = clWindow
            ParentBackground = False
            TabOrder = 2
            object TrackBar1: TTrackBar
              Left = 0
              Top = 0
              Width = 573
              Height = 17
              Align = alTop
              Max = 1000
              Frequency = 100
              PageSize = 50
              PositionToolTip = ptBottom
              TabOrder = 0
              ThumbLength = 16
              TickStyle = tsNone
              OnChange = TrackBar1Change
            end
          end
        end
        object cxTabSheet1: TcxTabSheet
          Caption = 'Conturi bancare'
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object cxGridAccounts: TcxGrid
            Left = 0
            Top = 0
            Width = 577
            Height = 224
            Align = alClient
            TabOrder = 0
            object cxGridAccountsDB: TcxGridDBTableView
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
              DataController.DataSource = IBCDataSourceAcc
              DataController.KeyFieldNames = 'CUSTOMERID;ACCOUNTNUMBER'
              OptionsBehavior.ImmediateEditor = False
              OptionsCustomize.ColumnFiltering = False
              OptionsCustomize.ColumnGrouping = False
              OptionsData.Deleting = False
              OptionsData.Editing = False
              OptionsData.Inserting = False
              OptionsSelection.CellSelect = False
              OptionsView.CellEndEllipsis = True
              OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
              OptionsView.ScrollBars = ssVertical
              OptionsView.ShowEditButtons = gsebForFocusedRecord
              OptionsView.ColumnAutoWidth = True
              OptionsView.GridLineColor = 13750737
              OptionsView.GroupByBox = False
              Styles.Header = dmAdditions.cxStyle_GridHeader
              object cxGridAccountsDBACCOUNTNUMBER: TcxGridDBColumn
                Caption = 'Cont'
                DataBinding.FieldName = 'ACCOUNTNUMBER'
                HeaderAlignmentHorz = taCenter
                Width = 100
              end
              object cxGridAccountsDBACCOUNTNAME: TcxGridDBColumn
                Caption = 'Denumirea'
                DataBinding.FieldName = 'ACCOUNTNAME'
                HeaderAlignmentHorz = taCenter
                Width = 100
              end
              object cxGridAccountsDBBANKNAME: TcxGridDBColumn
                Caption = 'Banca'
                DataBinding.FieldName = 'BANKNAME'
                HeaderAlignmentHorz = taCenter
                Width = 200
              end
              object cxGridAccountsDBDEFAULT_ACCOUNT: TcxGridDBColumn
                Caption = 'De baza'
                DataBinding.FieldName = 'DEFAULT_ACCOUNT'
                PropertiesClassName = 'TcxCheckBoxProperties'
                Properties.ValueChecked = 1
                Properties.ValueUnchecked = 0
                HeaderAlignmentHorz = taCenter
                MinWidth = 60
                Options.Filtering = False
                Options.ShowEditButtons = isebNever
                Options.Grouping = False
                Options.HorzSizing = False
                Options.Sorting = False
                Width = 60
              end
            end
            object cxGridAccountsLevel: TcxGridLevel
              GridView = cxGridAccountsDB
            end
          end
        end
        object cxTabSheet2: TcxTabSheet
          Caption = 'Descriere'
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object mmCOMMENTS: TcxDBMemo
            Left = 0
            Top = 0
            Align = alClient
            DataBinding.DataField = 'COMMENTS'
            DataBinding.DataSource = IBCDataSourceInfo
            ParentFont = False
            Properties.ReadOnly = True
            Properties.ScrollBars = ssVertical
            Properties.VisibleLineCount = 5
            TabOrder = 0
            ExplicitHeight = 89
            Width = 577
          end
        end
      end
      object cxLabel1: TcxLabel
        Left = 387
        Top = 63
        Caption = 'Cachback disponibil'
        ParentFont = False
        TabOrder = 12
      end
      object lbCashback: TcxLabel
        Left = 509
        Top = 62
        AutoSize = False
        Caption = '0.00'
        ParentFont = False
        Style.BorderStyle = ebsThick
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -12
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = []
        Style.IsFontAssigned = True
        Properties.Alignment.Horz = taRightJustify
        Properties.Alignment.Vert = taVCenter
        TabOrder = 14
        Height = 22
        Width = 58
        AnchorX = 567
        AnchorY = 73
      end
      object cxButton1: TcxButton
        Left = 573
        Top = 61
        Width = 24
        Height = 25
        Caption = '...'
        TabOrder = 2
        OnClick = cxButton1Click
      end
    end
  end
  object dxBarManager: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Default'
      'Apeluri')
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
    Left = 368
    Top = 288
    PixelsPerInch = 96
    object dxBarManagerBar1: TdxBar
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
      FloatLeft = 1313
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udWidth]
          UserWidth = 448
          Visible = True
          ItemName = 'lcbCustomers'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBar2: TdxBar
      Caption = 'Apeluri'
      CaptionButtons = <>
      DockControl = dxBarDockControl2
      DockedDockControl = dxBarDockControl2
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 645
      FloatTop = 10
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          Visible = True
          ItemName = 'bbPlay'
        end
        item
          Visible = True
          ItemName = 'dxBarButton2'
        end
        item
          Visible = True
          ItemName = 'dxBarButton1'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          Visible = True
          ItemName = 'bbSaveAs'
        end
        item
          Visible = True
          ItemName = 'cxBarEditItem1'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object lcbCustomers: TcxBarEditItem
      Align = iaClient
      Caption = 'Client'
      Category = 0
      Hint = 'Client'
      Visible = ivAlways
      ShowCaption = True
      PropertiesClassName = 'TcxLookupComboBoxProperties'
      Properties.DropDownListStyle = lsFixedList
      Properties.ImmediatePost = True
      Properties.KeyFieldNames = 'CUSTOMERID'
      Properties.ListColumns = <
        item
          FieldName = 'DISPLAYNAME'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = IBCDataSourceCustomers
      Properties.OnChange = lcbCustomersPropertiesChange
      StyleEdit = dmAdditions.cxStyle_Bold
      InternalEditValue = 0
    end
    object dxBarContainerItem1: TdxBarContainerItem
      Caption = 'New Item'
      Category = 0
      Visible = ivAlways
      ItemLinks = <>
    end
    object dxBarControlContainerItem1: TdxBarControlContainerItem
      Caption = 'New Item'
      Category = 0
      Hint = 'New Item'
      Visible = ivAlways
    end
    object dxBarButton1: TdxBarButton
      Caption = 'New Button'
      Category = 0
      Hint = 'New Button'
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
        303B3C7374796C6520747970653D22746578742F637373223E2E426C75657B66
        696C6C3A233131373744373B7D3C2F7374796C653E0D0A3C7061746820636C61
        73733D22426C75652220643D224D32352C32364837632D302E362C302D312D30
        2E352D312D31563763302D302E362C302E342D312C312D3168313863302E352C
        302C312C302E342C312C317631384332362C32352E352C32352E352C32362C32
        352C32367A222F3E0D0A3C2F7376673E0D0A}
      OnClick = dxBarButton1Click
    end
    object dxBarButton2: TdxBarButton
      Caption = 'New Button'
      Category = 0
      Hint = 'New Button'
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
        303B3C7374796C6520747970653D22746578742F637373223E2E426C75657B66
        696C6C3A233131373744373B7D3C2F7374796C653E0D0A3C7061746820636C61
        73733D22426C75652220643D224D31332C32364837632D302E362C302D312D30
        2E352D312D31563763302D302E362C302E342D312C312D31683663302E362C30
        2C312C302E342C312C317631384331342C32352E352C31332E362C32362C3133
        2C32367A222F3E0D0A3C7061746820636C6173733D22426C75652220643D224D
        32352C3236682D36632D302E352C302D312D302E352D312D31563763302D302E
        362C302E352D312C312D31683663302E352C302C312C302E342C312C31763138
        4332362C32352E352C32352E352C32362C32352C32367A222F3E0D0A3C2F7376
        673E0D0A}
      OnClick = dxBarButton2Click
    end
    object cxBarEditItem1: TcxBarEditItem
      Caption = 'New Item'
      Category = 0
      Hint = 'New Item'
      Visible = ivAlways
      PropertiesClassName = 'TcxLabelProperties'
    end
    object bbPlay: TdxBarButton
      Caption = 'Play'
      Category = 1
      Hint = 'Play'
      Visible = ivAlways
      ImageIndex = 72
      OnClick = bbPlayClick
    end
    object bbSaveAs: TdxBarButton
      Caption = 'Salveaza'
      Category = 1
      Hint = 'Salveaza'
      Visible = ivAlways
      ImageIndex = 32
      OnClick = bbSaveAsClick
    end
  end
  object IBCQueryCustomers: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT'
      ' c.CUSTOMERID,'
      ' c.DISPLAYNAME,'
      ' z.cashback cashback_available'
      'FROM'
      ' TS_CUSTOMER c'
      ' inner join get_available_cashback(c.customerid) z on 1=1')
    Left = 280
    Top = 52
  end
  object IBCDataSourceCustomers: TIBCDataSource
    DataSet = IBCQueryCustomers
    Left = 280
    Top = 4
  end
  object IBCQueryInfo: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT'
      ' VW_TS_CUSTOMER.*,'
      
        ' IIF(EXISTS(SELECT FIRST 1 SN FROM TS_CUST_DISCOUNT WHERE TS_CUS' +
        'T_DISCOUNT.CUSTOMERID=VW_TS_CUSTOMER.CUSTOMERID AND TS_CUST_DISC' +
        'OUNT.FLG_ENABLED=1),1,0) HAS_DISCOUNT_CARD,'
      
        ' IIF(EXISTS(SELECT LOGIN FROM TS_CUST_WEB WHERE TS_CUST_WEB.CUST' +
        'OMERID=VW_TS_CUSTOMER.CUSTOMERID AND TS_CUST_WEB.FLG_ENABLED=1),' +
        '1,0) HAS_WEB_LOGIN,'
      ' TS_CUST_COMMENTS.COMMENTS'
      'FROM VW_TS_CUSTOMER'
      
        'LEFT OUTER JOIN TS_CUST_COMMENTS ON (TS_CUST_COMMENTS.CUSTOMERID' +
        '=VW_TS_CUSTOMER.CUSTOMERID)'
      'WHERE VW_TS_CUSTOMER.CUSTOMERID=:id')
    ReadOnly = True
    Left = 428
    Top = 68
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        Value = nil
      end>
  end
  object IBCDataSourceInfo: TIBCDataSource
    DataSet = IBCQueryInfo
    Left = 764
    Top = 284
  end
  object IBCQueryAcc: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT'
      ' TS_CUST_ACCOUNTS.*,'
      
        ' (SELECT BANKNAME FROM TS_BANKS WHERE TS_BANKS.BANKACCOUNT=TS_CU' +
        'ST_ACCOUNTS.BANKACCOUNT) BANKNAME'
      'FROM'
      ' TS_CUST_ACCOUNTS'
      'ORDER BY'
      ' DEFAULT_ACCOUNT DESC')
    MasterFields = 'CUSTOMERID'
    DetailFields = 'CUSTOMERID'
    MasterSource = IBCDataSourceInfo
    Left = 424
    Top = 488
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CUSTOMERID'
        Value = nil
      end>
  end
  object IBCDataSourceAcc: TIBCDataSource
    DataSet = IBCQueryAcc
    Left = 424
    Top = 444
  end
  object IBCQueryDialHistory: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'select first 30 P.CALLID, p.data, P.CALLTYPEID, PH.DURATION,'
      '       (select FULL_NAME'
      '        from TS_USERS'
      
        '        where USERID = p.userid) USERNAME, P.PHONENUMBER, PH.SOU' +
        'RCEID, PH.WAV'
      'from TS_PHONE_CALLS_HISTORY P'
      'JOIN TS_PHONE_CALLS_REGISTER PH ON PH.CALLID = P.CALLID'
      'inner join SP_SPLIT_STR(:PHONENUMBER) s on s.str = p.phonenumber'
      'order by P.data desc')
    Left = 72
    Top = 487
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'phonenumber'
        Value = nil
      end>
  end
  object IBCDataSourceDialHistory: TIBCDataSource
    DataSet = IBCQueryDialHistory
    Left = 72
    Top = 424
  end
  object cxImageList1: TcxImageList
    SourceDPI = 96
    FormatVersion = 1
    DesignInfo = 8388856
  end
  object cxImageList2: TcxImageList
    SourceDPI = 96
    FormatVersion = 1
    Left = 280
    Top = 288
    Bitmap = {
      494C010105000900040010001000FFFFFFFF2110FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000002000000001002000000000000020
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000001E8902EF229C02FF229C
      02FF229C02FF229C02FF229C02FF229C02FF229C02FF229C02FF229C02FF229C
      02FF229C02FF229C02FF1F8C02F2000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000229C02FF229C02FF229C
      02FF229C02FF229C02FF229C02FF229C02FF229C02FF229C02FF229C02FF229C
      02FF229C02FF229C02FF229C02FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000229C02FF229C02FF229C
      02FF229C02FF229C02FF229C02FF229C02FF229C02FF229C02FF229C02FF229C
      02FF229C02FF229C02FF229C02FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000229C02FF229C02FF229C
      02FF229C02FF229C02FF229C02FF229C02FF229C02FF229C02FF229C02FF229C
      02FF229C02FF229C02FF229C02FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000229C02FF229C02FF229C
      02FF229C02FF229C02FF020C0049197202DA229C02FF229C02FF229C02FF229C
      02FF229C02FF229C02FF229C02FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000229C02FF229C02FF229C
      02FF229C02FF229C02FF00000000000000070824007C209002F5229C02FF229C
      02FF229C02FF229C02FF229C02FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000229C02FF229C02FF229C
      02FF229C02FF229C02FF00000000000000000000000000020020104901AF229C
      02FF229C02FF229C02FF229C02FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000229C02FF229C02FF229C
      02FF229C02FF229C02FF00000000000000000000000000020023114D01B4229C
      02FF229C02FF229C02FF229C02FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000229C02FF229C02FF229C
      02FF229C02FF229C02FF000000000000000909270081209202F7229C02FF229C
      02FF229C02FF229C02FF229C02FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000229C02FF229C02FF229C
      02FF229C02FF229C02FF030E004E1A7602DE229C02FF229C02FF229C02FF229C
      02FF229C02FF229C02FF229C02FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000229C02FF229C02FF229C
      02FF229C02FF229C02FF229C02FF229C02FF229C02FF229C02FF229C02FF229C
      02FF229C02FF229C02FF229C02FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000229C02FF229C02FF229C
      02FF229C02FF229C02FF229C02FF229C02FF229C02FF229C02FF229C02FF229C
      02FF229C02FF229C02FF229C02FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000229C02FF229C02FF229C
      02FF229C02FF229C02FF229C02FF229C02FF229C02FF229C02FF229C02FF229C
      02FF229C02FF229C02FF229C02FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000001D8702ED229C02FF229C
      02FF229C02FF229C02FF229C02FF229C02FF229C02FF229C02FF229C02FF229C
      02FF229C02FF229C02FF1E8902EF000000000000000000000000000000000000
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
      000000000000000000000000000000000000000000020000000A000000100000
      0011000000110000001100000012000000120000001200000012000000120000
      001300000013000000120000000C000000030000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000A624339C2B47B68FFB37A
      68FFB37A67FFB37967FFB37967FFB27967FFB37867FFB27867FFB27866FFB277
      66FFB17766FFB17765FF604137C30000000B0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000001A0E025A1D10025F00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000EB77E6DFFFBF7F4FFF8EE
      E9FFF8EEE8FFF7EFE8FFFAF4F0FFFBF7F4FFFBF6F3FFFAF4EFFFF6EDE6FFF6EC
      E6FFF6ECE6FFF6ECE5FFB47A68FF000000110000000000000000000000000000
      000000000000000000000000000000000004160C01525B3107A6A1580CDDCF72
      10FA884B0BCB0000001100000000000000000000000000000000000000000000
      0000000000000000000001000012B5630EEABA660EED01000015000000000000
      000000000000000000000000000000000000D77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FF0000000EB98471FFFBF8F5FFF8F0
      EAFFF7EFE9FFF8EFE9FF806A61FF533A30FF533A2FFF7E6960FFF7EDE7FFF7EC
      E7FFF6ECE6FFF7EDE7FFB77E6DFF000000110000000000000000000000000000
      00000000000000000000100901479D560CDAD77610FFD77610FFD77610FFD776
      10FFD77610FF864A0ACA00000000000000000000000000000000000000000000
      0000000000000000000049290596D77610FFD77610FF4F2B069B000000000000
      000000000000000000000000000000000000D77610FFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFD77610FF0000000EBC8977FFFCF9F7FFF9F1
      EDFFF8F0ECFFF8F0EBFFF9F0EBFF98877DFF816D63FFF8EFEAFFF7EFE9FFF8EE
      E9FFF7EEE8FFF8EEE9FFB98471FF000000100000000000000000000000000000
      000000000000361E0480D57610FED77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FF3F23048B00000000000000000000000000000000000000000000
      0000000000000603002DD17310FCD77610FFD77610FFD37410FD070400310000
      000000000000000000000000000000000000D77610FFE4A560FFFCF6EFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFDF7F1FFE5A765FFD77610FF0000000DC08E7CFFFCFAF8FFFAF3
      EFFFF9F2EEFFF9F2EEFFF9F2EDFF9A887EFF836F65FFF9F1ECFFF8F1EBFFF9F0
      EBFFF8EFEAFFF8F1EBFFBC8976FF000000100000000000000000000000000000
      0000361E0480D77610FFD77610FFD77610FF7D4509C383480AC7D77610FFD776
      10FF4024048C0000000000000000000000000000000000000000000000000000
      0000000000006F3D08B7D77610FFD77610FFD77610FFD77610FF764009BD0000
      000000000000000000000000000000000000D77610FFF1D1AEFFDE903BFFF5DE
      C5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFF6E0C8FFDE903CFFF1CFAAFFD77610FF0000000CC39482FFFCFBF9FFFBF5
      F2FFFBF4F1FFFAF4F1FFFAF3F0FF9B8981FF847167FFFAF2EEFFF9F2EEFFF9F2
      EDFFF9F2EDFFF9F2EEFFC08E7BFF0000000F0000000000000000000000000F08
      0145D57510FED77610FFD57510FE301A0379000000010000000D7C4409C23F23
      048B000000000000000000000000000000000000000000000000000000000000
      00000E070142D77610FFD77610FFD77610FFD77610FFD77610FFD77610FF1009
      014800000000000000000000000000000000D77610FFFFFFFFFFFAEFE3FFE19A
      4DFFEAB883FFFEFCFBFFFDF7F1FFE5A765FFE4A560FFFCF6EFFFFEFDFBFFEBBB
      88FFE1984AFFFAEEE1FFFFFFFFFFD77610FF0000000BC79887FFFDFCFAFFFBF7
      F4FFFBF6F4FFFBF6F2FFFCF9F7FF9D8C84FF877267FFFAF5F1FFFAF4F1FFFAF3
      F0FFFAF3F0FFFAF4F0FFC49381FF0000000E0000000000000000000000039A55
      0BD8D77610FFD77610FF311B037A000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000081470AC6D77610FFD77610FFD77610FFD77610FFD77610FFD77610FF884B
      0BCB00000001000000000000000000000000D77610FFFFFFFFFFFFFFFFFFFEFD
      FCFFECBE8DFFE09646FFDE903CFFF1CFABFFF1D1AEFFDE903BFFE09747FFEBBB
      88FFFEFDFCFFFFFFFFFFFFFFFFFFD77610FF0000000BC99D8CFFFDFCFBFFFCF8
      F6FFFCF7F5FFFCF7F5FF897369FF5E4437FF887369FFFBF6F3FFFBF6F2FFFBF6
      F2FFFAF5F2FFFAF6F2FFC69886FF0000000D0000000000000000140B014FD776
      10FFD77610FF80460AC500000002000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000F08
      0144D77610FFD87A17FFEEC59AFFFDF8F3FFFDF8F4FFEEC79DFFD87A18FFD776
      10FF11090149000000000000000000000000D77610FFFFFFFFFFFFFFFFFFFEFD
      FBFFEBBB88FFE1984BFFFAEEE1FFFFFFFFFFFFFFFFFFFAEFE3FFE1994CFFEAB8
      83FFFEFCFBFFFFFFFFFFFFFFFFFFD77610FF0000000ACDA190FFFEFDFCFFFCF9
      F8FFFCF8F7FFFCF9F7FFFCF8F7FFBEB1AAFF8B746AFFFCF7F6FFFCF7F6FFFCF7
      F5FFFBF6F5FFFBF7F5FFC99D8BFF0000000D0000000000000000562F06A2D776
      10FFD77610FF8B4C0BCD00000011000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006A3A
      08B3D77610FFEEC498FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEEC79DFFD776
      10FF703D08B8000000000000000000000000D77610FFFFFFFFFFFAEDE0FFE198
      4AFFEBBB89FFFEFDFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFDFCFFECBD
      8CFFE09647FFF9ECDEFFFFFFFFFFD77610FF00000009CFA594FFFEFDFDFFFDFA
      F9FFFDF9F9FFFDFAF8FFFDF9F8FFFDFAF8FFFCF9F7FFFCF9F7FFFCF9F7FFFDF8
      F7FFFCF9F7FFFCF9F7FFCCA290FF0000000C00000000000000009B550BD9D776
      10FFD77610FFD77610FF884B0BCB000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C76D
      10F6D77610FFFCF6EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDF8F3FFD776
      10FFCF7210FB000000000000000000000000D77610FFF1CEAAFFDE903DFFF6E0
      C9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFF6E2CCFFDE903DFFF0CCA5FFD77610FF000000084A52C3FF8D9EECFF677B
      E3FF6577E2FF6375E1FF6071E0FF5E6FDFFF5C6BDEFF5A68DCFF5865DBFF5563
      DAFF5361D9FF606CDCFF3236AAFF0000000B0000000000000000C76D0FF5D776
      10FFD77610FFD77610FF4023048B000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000A75C
      0DE1D77610FFFCF5EEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDF8F3FFD776
      10FFAF600DE6000000000000000000000000D77610FFE5A866FFFDF7F2FFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFDF8F3FFE6AA69FFD77610FF000000084B54C4FF93A4EEFF6B80
      E6FF697DE4FF677AE4FF6577E2FF6274E1FF6071E0FF5D6EDEFF5B6BDDFF5968
      DCFF5665DAFF6371DDFF3437ABFF0000000A0000000000000000884A0BCBD776
      10FFD77610FF4024048C00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000004A29
      0596D77610FFEDC295FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEEC59AFFD776
      10FF502C069C000000000000000000000000D77610FFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFD77610FF000000074C55C6FF96A7EFFF95A6
      EFFF93A4EDFF90A2EDFF8F9FEDFF8B9BEBFF8898EAFF8595EAFF8291E7FF7E8D
      E7FF7C89E5FF7887E5FF3438ACFF00000009000000000000000001000013884B
      0BCB3F23048B0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000301
      0020C46C0FF4D87916FFEDC295FFFCF5EEFFFCF6EFFFEEC498FFD87A17FFC76E
      0FF504020024000000000000000000000000D77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FF000000042B306FC14C54C5FF4A52
      C3FF4950C1FF474EBFFF454CBEFF434ABBFF4148B9FF3F45B7FF3D43B4FF3B40
      B3FF393DB0FF383BAEFF1E2061C2000000060000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000140B0150CB7010F8D77610FFD77610FFD77610FFD77610FFCD7010F9170C
      0154000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000100000004000000060000
      0006000000060000000700000007000000070000000700000007000000070000
      0008000000080000000700000005000000010000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000007040031673908B1C0690FF1C16A0FF26A3A08B3080400330000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000200000000100010000000000000100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000}
    DesignInfo = 18874648
    ImageInfo = <
      item
        ImageClass = 'TdxPNGImage'
        Image.Data = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          6100000017744558745469746C650044617920566965773B4461793B56696577
          CCD4B13D000001CC49444154785E85533D6B1551103D93F7100BF3435205C44A
          48AA3416160A42FE8648F0BB89C620F26CFC0596B66A91801626011551131041
          B014045B311FFBE6C3993BBB83C6C2E51DCEBDE7CE9C39DC7D4B000223C70CEA
          691A0AFFEAE650078FA379EBD2F997EEB0A8AA5035049B431C4D935C5BB0644D
          C7BCBDFCE6DD5233181316E72E9C032C9BA10288419961228043D8D9A11CE78C
          D74F5F2CB45E00A466ADF0F0EB9734909C1A9AC53AB9D6A353B3312B1E0A0358
          C4EE3A484CE48C6F2C3D0F66A1F7DAD4D9B40C68EFE25D9C5D9EC7AC18103F42
          63385B8E0AE401E5FEF9935DE0ED9934E0988A2CAE7AE7671B5B78B5F31E0F56
          2FA714A23A08987A8A4AC0CCAD590D69E058B93DC187BDCF383D3F077171F0CD
          8232C038379940E3D09C014CD6AE60F2E831BE7DFF517AA5A3ECA904D321810E
          45862331888420CEA955BF8501FF61D0496B14B5E1D22A91AA0567BB513BA799
          6306B1893EED0DD2228AD5B5C06080C624F4F71D74BE8929624302C2F55BEBF8
          B8FBA9995DBDB98E7B77AE017D122280EB0E909BE8337520DFF5C3FB37301E51
          D3590D07478CE1896153AE04E0FDFD9FDB2B6B9B0BE8E3D76DD5BFAAF45A7787
          BF7682A8FF8C4F3A4E1CFB8CE93F9F73E738F80D367091E573343C2600000000
          49454E44AE426082}
      end
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
          423131353B7D262331333B262331303B2623393B2E5265647B66696C6C3A2344
          31314331433B7D262331333B262331303B2623393B2E477265656E7B66696C6C
          3A233033394332333B7D262331333B262331303B2623393B2E426C61636B7B66
          696C6C3A233732373237323B7D262331333B262331303B2623393B2E57686974
          657B66696C6C3A234646464646463B7D262331333B262331303B2623393B2E73
          74307B6F7061636974793A302E353B7D262331333B262331303B2623393B2E73
          74317B6F7061636974793A302E37353B7D262331333B262331303B2623393B2E
          7374327B646973706C61793A6E6F6E653B7D262331333B262331303B2623393B
          2E7374337B646973706C61793A696E6C696E653B66696C6C3A23464642313135
          3B7D262331333B262331303B2623393B2E7374347B646973706C61793A696E6C
          696E653B7D262331333B262331303B2623393B2E7374357B646973706C61793A
          696E6C696E653B6F7061636974793A302E37353B7D262331333B262331303B26
          23393B2E7374367B646973706C61793A696E6C696E653B6F7061636974793A30
          2E353B7D262331333B262331303B2623393B2E7374377B646973706C61793A69
          6E6C696E653B66696C6C3A233033394332333B7D262331333B262331303B2623
          393B2E7374387B646973706C61793A696E6C696E653B66696C6C3A2344313143
          31433B7D262331333B262331303B2623393B2E7374397B646973706C61793A69
          6E6C696E653B66696C6C3A233131373744373B7D262331333B262331303B2623
          393B2E737431307B646973706C61793A696E6C696E653B66696C6C3A23464646
          4646463B7D3C2F7374796C653E0D0A3C672069643D2250686F6E65223E0D0A09
          093C7061746820636C6173733D22426C75652220643D224D32372E372C32332E
          366C2D352E332D352E33632D302E342D302E342D312D302E342D312E342C306C
          2D322E382C322E38632D332E322D312E352D352E382D342E312D372E332D372E
          336C322E382D322E3863302E342D302E342C302E342D312C302D312E34202026
          23393B2623393B4C382E342C342E33632D302E342D302E342D312D302E342D31
          2E352C304C342E332C362E3943342E312C372E322C342C372E342C342C372E37
          43342C31382E392C31332E312C32382C32342E332C323863302E332C302C302E
          352D302E312C302E372D302E336C322E362D322E3620202623393B2623393B43
          32382E312C32342E362C32382E312C32342C32372E372C32332E367A222F3E0D
          0A093C2F673E0D0A3C2F7376673E0D0A}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D225554
          462D38223F3E0D0A3C7376672076657273696F6E3D22312E31222069643D22D0
          A1D0BBD0BED0B95F312220786D6C6E733D22687474703A2F2F7777772E77332E
          6F72672F323030302F7376672220786D6C6E733A786C696E6B3D22687474703A
          2F2F7777772E77332E6F72672F313939392F786C696E6B2220783D2230707822
          20793D22307078222076696577426F783D223020302033322033322220737479
          6C653D22656E61626C652D6261636B67726F756E643A6E657720302030203332
          2033323B2220786D6C3A73706163653D227072657365727665223E262331333B
          262331303B3C7374796C6520747970653D22746578742F6373732220786D6C3A
          73706163653D227072657365727665223E2E426C75657B66696C6C3A23313137
          3744373B7D262331333B262331303B2623393B2E57686974657B66696C6C3A23
          4646464646463B7D3C2F7374796C653E0D0A3C7061746820636C6173733D2242
          6C75652220643D224D31362C33304C31362C33304C31362C33304331342E352C
          32382E332C362C31332E352C362C313143362C352E352C31302E352C302C3136
          2C307331302C352E352C31302C31314332362C31332E352C31372E352C32382E
          332C31362C33307A222F3E0D0A3C7061746820636C6173733D22576869746522
          20643D224D31362C3463332E332C302C362C322E372C362C36732D322E372C36
          2D362C36732D362D322E372D362D365331322E372C342C31362C347A222F3E0D
          0A3C2F7376673E0D0A}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D225554
          462D38223F3E0D0A3C7376672076657273696F6E3D22312E31222069643D22D0
          A1D0BBD0BED0B95F312220786D6C6E733D22687474703A2F2F7777772E77332E
          6F72672F323030302F7376672220786D6C6E733A786C696E6B3D22687474703A
          2F2F7777772E77332E6F72672F313939392F786C696E6B2220783D2230707822
          20793D22307078222076696577426F783D223020302033322033322220737479
          6C653D22656E61626C652D6261636B67726F756E643A6E657720302030203332
          2033323B2220786D6C3A73706163653D227072657365727665223E262331333B
          262331303B3C7374796C6520747970653D22746578742F6373732220786D6C3A
          73706163653D227072657365727665223E2E57686974657B66696C6C3A234646
          464646463B7D262331333B262331303B2623393B2E426C75657B66696C6C3A23
          3131373744373B7D3C2F7374796C653E0D0A3C672069643D224D61696C223E0D
          0A09093C7265637420793D22342220636C6173733D22426C7565222077696474
          683D22333222206865696768743D223234222F3E0D0A09093C7265637420783D
          22322220793D22362220636C6173733D225768697465222077696474683D2232
          3822206865696768743D223230222F3E0D0A09093C706F6C79676F6E20636C61
          73733D22426C75652220706F696E74733D2233302C382031362C313820322C38
          20322C31302031302E342C313620322C323220322C32342031312E382C313720
          31362C32302032302E322C31372033302C32342033302C32322032312E362C31
          362033302C3130202623393B222F3E0D0A093C2F673E0D0A3C2F7376673E0D0A}
      end
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
          303B3C7374796C6520747970653D22746578742F637373223E2E477265656E7B
          66696C6C3A233033394332333B7D3C2F7374796C653E0D0A3C7061746820636C
          6173733D22477265656E2220643D224D32392C32483343322E352C322C322C32
          2E352C322C3376323663302C302E352C302E352C312C312C3168323663302E35
          2C302C312D302E352C312D3156334333302C322E352C32392E352C322C32392C
          327A204D31322C32325631306C31302C364C31322C32327A20202623393B222F
          3E0D0A3C2F7376673E0D0A}
      end>
  end
  object MP3In1: TMP3In
    Loop = False
    EndSample = -1
    StartSample = 0
    HighPrecision = False
    OutputChannels = cnMonoOrStereo
    Left = 304
    Top = 344
  end
  object DXAudioOut1: TDXAudioOut
    Input = WaveIn1
    DeviceNumber = 0
    Latency = 100
    PrefetchData = True
    PollingInterval = 100
    FramesInBuffer = 24576
    SpeedFactor = 1.000000000000000000
    OnDone = DXAudioOut1Done
    OnProgress = DXAudioOut1Progress
    Left = 424
    Top = 352
  end
  object WaveIn1: TWaveIn
    Loop = False
    EndSample = -1
    StartSample = 0
    Left = 232
    Top = 352
  end
end
