object frmContentGoodsEditorDlg: TfrmContentGoodsEditorDlg
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Descrierea produselor'
  ClientHeight = 598
  ClientWidth = 975
  Color = clBtnFace
  Constraints.MinHeight = 600
  Constraints.MinWidth = 980
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnCloseQuery = FormCloseQuery
  TextHeight = 15
  object pnGoods: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 8
    Width = 959
    Height = 65
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 0
    Align = alTop
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 0
    TabStop = True
    object mmTITLE: TcxDBMemo
      Left = 6
      Top = 6
      DataBinding.DataField = 'TITLE'
      ParentFont = False
      Properties.ScrollBars = ssVertical
      Properties.VisibleLineCount = 3
      Style.Color = clWindow
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -12
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = [fsBold]
      Style.IsFontAssigned = True
      TabOrder = 0
      Width = 947
    end
  end
  object pnButtons: TPanel
    Left = 0
    Top = 545
    Width = 975
    Height = 53
    Align = alBottom
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Padding.Left = 8
    Padding.Top = 8
    Padding.Right = 24
    Padding.Bottom = 16
    ParentBackground = False
    ParentFont = False
    ShowCaption = False
    TabOrder = 2
    TabStop = True
    object btnCancel: TcxButton
      AlignWithMargins = True
      Left = 857
      Top = 8
      Width = 90
      Height = 25
      Margins.Left = 16
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alRight
      Cancel = True
      Caption = 'Renunta'
      ModalResult = 2
      TabOrder = 1
    end
    object btnOk: TcxButton
      Left = 751
      Top = 8
      Width = 90
      Height = 25
      Align = alRight
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
    object cxDBLabel1: TcxDBLabel
      Left = 13
      Top = 16
      DataBinding.DataField = 'USER_FULLNAME'
      ParentFont = False
      TabOrder = 2
      Height = 21
      Width = 692
    end
  end
  object pcPageControl: TcxPageControl
    AlignWithMargins = True
    Left = 5
    Top = 78
    Width = 965
    Height = 462
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alClient
    TabOrder = 1
    Properties.ActivePage = tbsDescriptions
    Properties.CustomButtons.Buttons = <>
    OnPageChanging = pcPageControlPageChanging
    ClientRectBottom = 458
    ClientRectLeft = 4
    ClientRectRight = 961
    ClientRectTop = 26
    object tbWebName: TcxTabSheet
      Caption = '&0 Denumire web'
      ImageIndex = 0
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object dxBarDockControl4: TdxBarDockControl
        Left = 0
        Top = 0
        Width = 957
        Height = 28
        Align = dalTop
        BarManager = dxBarManager
      end
      object cxPageControl1: TcxPageControl
        Left = 0
        Top = 275
        Width = 957
        Height = 157
        Align = alClient
        TabOrder = 1
        Properties.ActivePage = tbsSearchKeys
        Properties.CustomButtons.Buttons = <>
        ClientRectBottom = 153
        ClientRectLeft = 4
        ClientRectRight = 953
        ClientRectTop = 26
        object tbsSearchKeys: TcxTabSheet
          Caption = 'Search Keys'
          ImageIndex = 1
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object cxDBMemo2: TcxDBMemo
            AlignWithMargins = True
            Left = 3
            Top = 31
            Align = alClient
            DataBinding.DataField = 'SEARCHKEYS'
            DataBinding.DataSource = IBCDataSourceSearchkeys
            ParentFont = False
            Properties.ScrollBars = ssBoth
            TabOrder = 1
            Height = 93
            Width = 943
          end
          object dxBarDockControl2: TdxBarDockControl
            Left = 0
            Top = 0
            Width = 949
            Height = 28
            Align = dalTop
            BarManager = dxBarManager
          end
        end
      end
      object Panel1: TPanel
        Left = 0
        Top = 28
        Width = 957
        Height = 247
        Align = alTop
        BevelKind = bkFlat
        BevelOuter = bvNone
        Color = clWindow
        ParentBackground = False
        TabOrder = 2
        inline frameGoodsEditDescription1: TframeGoodsEditDescription
          Left = 12
          Top = -2
          Width = 926
          Height = 232
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
      end
    end
    object tbsDescriptions: TcxTabSheet
      Caption = '&1 - Descriere'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object pcDescriptions: TPageControl
        Left = 0
        Top = 0
        Width = 957
        Height = 432
        ActivePage = tbsDescription
        Align = alClient
        TabOrder = 0
        object tbsDescription: TTabSheet
          Caption = 'Descriere / '#1054#1087#1080#1089#1072#1085#1080#1077' HTML'
          ImageIndex = 1
          object dxBarDockControl3: TdxBarDockControl
            Left = 0
            Top = 0
            Width = 949
            Height = 30
            Margins.Left = 8
            Margins.Top = 8
            Margins.Right = 8
            Margins.Bottom = 1
            Align = dalTop
            BarManager = dxBarManager
            SunkenBorder = True
            UseOwnSunkenBorder = True
          end
          object mmGOODS_Description_RO: TDBSynEdit
            Left = 16
            Top = 34
            Width = 913
            Height = 183
            Cursor = crIBeam
            DataField = 'DESCRIPTION_RO'
            DataSource = IBCDataSourceDSC
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Consolas'
            Font.Style = []
            Font.Quality = fqClearTypeNatural
            ParentColor = False
            ParentFont = False
            TabOrder = 1
            Gutter.Font.Charset = DEFAULT_CHARSET
            Gutter.Font.Color = clWindowText
            Gutter.Font.Height = -11
            Gutter.Font.Name = 'Consolas'
            Gutter.Font.Style = []
            Gutter.Font.Quality = fqClearTypeNatural
            Gutter.Bands = <
              item
                Kind = gbkMarks
                Width = 13
              end
              item
                Kind = gbkLineNumbers
              end
              item
                Kind = gbkFold
              end
              item
                Kind = gbkTrackChanges
              end
              item
                Kind = gbkMargin
                Width = 3
              end>
          end
          object mmGOODS_Description: TDBSynEdit
            Left = 16
            Top = 220
            Width = 913
            Height = 286
            Cursor = crIBeam
            DataField = 'DESCRIPTION'
            DataSource = IBCDataSourceDSC
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Consolas'
            Font.Style = []
            Font.Quality = fqClearTypeNatural
            ParentColor = False
            ParentFont = False
            TabOrder = 2
            Gutter.Font.Charset = DEFAULT_CHARSET
            Gutter.Font.Color = clWindowText
            Gutter.Font.Height = -11
            Gutter.Font.Name = 'Consolas'
            Gutter.Font.Style = []
            Gutter.Font.Quality = fqClearTypeNatural
            Gutter.Bands = <
              item
                Kind = gbkMarks
                Width = 13
              end
              item
                Kind = gbkLineNumbers
              end
              item
                Kind = gbkFold
              end
              item
                Kind = gbkTrackChanges
              end
              item
                Kind = gbkMargin
                Width = 3
              end>
            Highlighter = SynHTMLSyn1
          end
        end
        object TabSheet3: TTabSheet
          Caption = 'Caracteristici mobilier'
          ImageIndex = 2
          DesignSize = (
            949
            402)
          object cxDBMemo1: TcxDBMemo
            Left = 3
            Top = 3
            Anchors = [akLeft, akTop, akRight, akBottom]
            DataBinding.DataField = 'DESCRIERE_MOBILA'
            DataBinding.DataSource = IBCDataSourceDSC
            ParentFont = False
            Style.LookAndFeel.ScrollbarMode = sbmClassic
            Style.LookAndFeel.SkinName = ''
            Style.Shadow = False
            StyleDisabled.LookAndFeel.ScrollbarMode = sbmClassic
            StyleDisabled.LookAndFeel.SkinName = ''
            StyleFocused.LookAndFeel.ScrollbarMode = sbmClassic
            StyleFocused.LookAndFeel.SkinName = ''
            StyleHot.LookAndFeel.ScrollbarMode = sbmClassic
            StyleHot.LookAndFeel.SkinName = ''
            StyleReadOnly.LookAndFeel.ScrollbarMode = sbmClassic
            StyleReadOnly.LookAndFeel.SkinName = ''
            TabOrder = 0
            Height = 399
            Width = 943
          end
        end
      end
    end
    object tbsFilters: TcxTabSheet
      Caption = '&2 - Caracteristici'
      ImageIndex = 2
      object dxBarDockFilters: TdxBarDockControl
        Left = 0
        Top = 0
        Width = 957
        Height = 30
        Align = dalTop
        BarManager = dxBarManager
        SunkenBorder = True
        UseOwnSunkenBorder = True
      end
      object cxGridFilters: TcxGrid
        Left = 0
        Top = 30
        Width = 957
        Height = 402
        Align = alClient
        TabOrder = 1
        object cxGridFiltersTable: TcxGridDBTableView
          OnCellDblClick = cxGridFiltersTableCellDblClick
          OnFocusedRecordChanged = cxGridFiltersTableFocusedRecordChanged
          DataController.DataSource = IBCDataSourceFilters
          DataController.KeyFieldNames = 'DESCRIPTIONID'
          DataController.MasterKeyFieldNames = 'GOODSID'
          OptionsBehavior.IncSearch = True
          OptionsBehavior.ImmediateEditor = False
          OptionsCustomize.ColumnGrouping = False
          OptionsCustomize.ColumnHorzSizing = False
          OptionsCustomize.ColumnMoving = False
          OptionsCustomize.ColumnSorting = False
          OptionsCustomize.ColumnsQuickCustomization = True
          OptionsData.Deleting = False
          OptionsData.Inserting = False
          OptionsSelection.MultiSelect = True
          OptionsSelection.HideFocusRectOnExit = False
          OptionsSelection.InvertSelect = False
          OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1093#1072#1088#1072#1082#1090#1077#1088#1080#1089#1090#1080#1082'>'
          OptionsView.ScrollBars = ssVertical
          OptionsView.ColumnAutoWidth = True
          OptionsView.GridLineColor = 13750737
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          Styles.OnGetContentStyle = cxGridFiltersTableStylesGetContentStyle
          Styles.Header = dmAdditions.cxStyle_GridHeader
          object cxGridFilters_FLG_GROUP: TcxGridDBColumn
            DataBinding.FieldName = 'FLG_GROUP'
            PropertiesClassName = 'TcxImageComboBoxProperties'
            Properties.DefaultImageIndex = 26
            Properties.Images = dmAdditions.cxImageList_SWN
            Properties.Items = <
              item
                Value = 1
              end>
            HeaderAlignmentHorz = taCenter
            MinWidth = 24
            Options.Editing = False
            Options.HorzSizing = False
            VisibleForCustomization = False
            Width = 24
            IsCaptionAssigned = True
          end
          object cxGridFilters_FLG_ORDINARY_FILTER: TcxGridDBColumn
            Caption = 'O'
            DataBinding.FieldName = 'FLG_ORDINARY_FILTER'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.DisplayGrayed = 'False'
            Properties.ValueChecked = 1
            Properties.ValueGrayed = 0
            Properties.ValueUnchecked = '0'
            HeaderAlignmentHorz = taCenter
            MinWidth = 28
            Options.HorzSizing = False
            Width = 28
          end
          object cxGridFilters_FILTERID: TcxGridDBColumn
            Caption = #1050#1086#1076
            DataBinding.FieldName = 'FILTERID'
            HeaderAlignmentHorz = taCenter
            MinWidth = 50
            Options.HorzSizing = False
            Width = 50
          end
          object cxGridFilters_FILTERNAME_ROM: TcxGridDBColumn
            Caption = 'Caracteristica'
            DataBinding.FieldName = 'FILTERNAME_ROM'
            OnGetDisplayText = cxGridFilters_FILTERNAME_ROMGetDisplayText
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Width = 200
          end
          object cxGridFilters_FILTERPARAMID: TcxGridDBColumn
            AlternateCaption = #1050#1086#1076' '#1079#1085#1072#1095#1077#1085#1080#1103
            Caption = #1050#1086#1076' '#1079#1085#1072#1095
            DataBinding.FieldName = 'FILTERPARAMID'
            HeaderAlignmentHorz = taCenter
            MinWidth = 60
            Options.HorzSizing = False
            Width = 60
          end
          object cxGridFilters_PARAM_VALUE_ROM: TcxGridDBColumn
            Caption = 'Valoare'
            DataBinding.FieldName = 'PARAM_VALUE_ROM'
            OnGetDisplayText = cxGridFilters_PARAM_VALUE_ROMGetDisplayText
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Width = 70
          end
          object cxGridFilters_FILTERNAME_RUS: TcxGridDBColumn
            Caption = #1061#1072#1088#1072#1082#1090#1077#1088#1080#1089#1090#1080#1082#1072
            DataBinding.FieldName = 'FILTERNAME_RUS'
            OnGetDisplayText = cxGridFilters_FILTERNAME_RUSGetDisplayText
            HeaderAlignmentHorz = taCenter
            MinWidth = 200
            Options.Editing = False
            Width = 200
          end
          object cxGridFilters_PARAM_VALUE_RUS: TcxGridDBColumn
            Caption = #1047#1085#1072#1095#1077#1085#1080#1077
            DataBinding.FieldName = 'PARAM_VALUE_RUS'
            OnGetDisplayText = cxGridFilters_PARAM_VALUE_RUSGetDisplayText
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Width = 70
          end
          object cxGridFilters_FLG_VISIBLE: TcxGridDBColumn
            AlternateCaption = #1055#1086#1082#1072#1079#1099#1074#1072#1090#1100
            Caption = 'Show'
            DataBinding.FieldName = 'FLG_VISIBLE'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ImmediatePost = True
            Properties.ValueChecked = 1
            Properties.ValueUnchecked = 0
            HeaderAlignmentHorz = taCenter
            MinWidth = 36
            Options.IncSearch = False
            Options.HorzSizing = False
            Options.Sorting = False
            Width = 36
          end
          object cxGridFilters_FLG_COMPATIBILITY: TcxGridDBColumn
            AlternateCaption = #1057#1086#1074#1084#1077#1089#1090#1080#1084#1099#1077
            Caption = #8776
            DataBinding.FieldName = 'FLG_COMPATIBILITY'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ValueChecked = 1
            Properties.ValueUnchecked = 0
            HeaderAlignmentHorz = taCenter
            MinWidth = 36
            Options.Editing = False
            Options.HorzSizing = False
            Options.Sorting = False
            Width = 36
          end
          object cxGridFilters_FLG_COMPARE: TcxGridDBColumn
            AlternateCaption = #1057#1088#1072#1074#1085#1080#1090#1100
            Caption = '='
            DataBinding.FieldName = 'FLG_COMPARE'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ValueChecked = 1
            Properties.ValueUnchecked = 0
            HeaderAlignmentHorz = taCenter
            MinWidth = 36
            Options.Editing = False
            Options.HorzSizing = False
            Width = 36
          end
          object cxGridFilters_FLG_GOODS_LINK: TcxGridDBColumn
            AlternateCaption = #1057#1089#1099#1083#1082#1072
            Caption = 'Link'
            DataBinding.FieldName = 'FLG_GOODS_LINK'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ValueChecked = 1
            Properties.ValueUnchecked = 0
            HeaderAlignmentHorz = taCenter
            MinWidth = 36
            Options.Editing = False
            Options.HorzSizing = False
            Width = 36
          end
          object cxGridFilters_ORDERNO: TcxGridDBColumn
            DataBinding.FieldName = 'ORDERNO'
            Visible = False
            HeaderAlignmentHorz = taCenter
            SortIndex = 0
            SortOrder = soAscending
            Width = 50
          end
          object cxGridFilters_CREATE_BY_NAME: TcxGridDBColumn
            Caption = 'Creat'
            DataBinding.FieldName = 'CREATED_BY_NAME'
            HeaderAlignmentHorz = taCenter
            MinWidth = 100
            Options.Editing = False
            Options.HorzSizing = False
            Width = 100
          end
        end
        object cxGridFiltersLevel: TcxGridLevel
          GridView = cxGridFiltersTable
        end
      end
    end
    object tbsImages: TcxTabSheet
      Caption = '&3 - Imagini'
      ImageIndex = 3
      OnShow = tbsImagesShow
      object dxBarDockControl1: TdxBarDockControl
        Left = 0
        Top = 0
        Width = 957
        Height = 30
        Margins.Left = 8
        Margins.Top = 8
        Margins.Right = 8
        Margins.Bottom = 1
        Align = dalTop
        BarManager = dxBarManager
        SunkenBorder = True
        UseOwnSunkenBorder = True
      end
      object lbImages: TListBox
        Left = 0
        Top = 30
        Width = 957
        Height = 402
        Style = lbOwnerDrawFixed
        Align = alClient
        DoubleBuffered = False
        ParentDoubleBuffered = False
        TabOrder = 1
        OnClick = lbImagesClick
        OnDragOver = lbImagesDragOver
        OnDrawItem = lbImagesDrawItem
      end
    end
    object tbsVideo: TcxTabSheet
      Caption = '&4 - Video'
      object imgYouTube: TImage
        Left = 16
        Top = 104
        Width = 320
        Height = 180
        Center = True
        Proportional = True
        Stretch = True
      end
      object lbYouTubeCaption: TcxLabel
        Left = 16
        Top = 16
        Caption = 'URL YouTube (spot produs):'
        ParentFont = False
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -12
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 0
        Transparent = True
      end
      object edYouTubeURL: TcxTextEdit
        Left = 16
        Top = 40
        ParentFont = False
        Properties.OnChange = edYouTubeURLPropertiesChange
        TabOrder = 1
        Width = 600
      end
      object lbYouTubeHint: TcxLabel
        Left = 16
        Top = 72
        Caption = ' '
        ParentFont = False
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clGrayText
        Style.Font.Height = -12
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 2
        Transparent = True
      end
      object btnOpenYouTube: TcxButton
        Left = 632
        Top = 38
        Width = 150
        Height = 25
        Caption = 'Deschide '#238'n browser'
        TabOrder = 3
        OnClick = btnOpenYouTubeClick
      end
    end
    object tsSEO: TcxTabSheet
      Caption = 'Seo'
      ImageIndex = 4
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object cxLabel1: TcxLabel
        Left = 12
        Top = 4
        Caption = 'Title RO'
        ParentFont = False
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -12
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 0
        Transparent = True
      end
      object teTitleRO: TcxDBTextEdit
        Left = 116
        Top = 3
        DataBinding.DataField = 'META_TITLE_RO'
        DataBinding.DataSource = IBCDataSourceWebGoods
        ParentFont = False
        TabOrder = 1
        Width = 808
      end
      object cxLabel2: TcxLabel
        Left = 12
        Top = 27
        Caption = '/usage'
        ParentFont = False
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -12
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 2
        Transparent = True
      end
      object teTitleRU: TcxDBTextEdit
        Left = 116
        Top = 26
        DataBinding.DataField = 'META_TITLE_RU'
        DataBinding.DataSource = IBCDataSourceWebGoods
        ParentFont = False
        TabOrder = 3
        Width = 808
      end
      object cxLabel3: TcxLabel
        Left = 11
        Top = 224
        Caption = 'Desc RO'
        ParentFont = False
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -12
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 4
        Transparent = True
      end
      object teKeysRO: TcxDBTextEdit
        Left = 115
        Top = 118
        DataBinding.DataField = 'META_KEY_RO'
        DataBinding.DataSource = IBCDataSourceWebGoods
        ParentFont = False
        TabOrder = 5
        Width = 808
      end
      object cxLabel8: TcxLabel
        Left = 12
        Top = 143
        Caption = 'Keys RU'
        ParentFont = False
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -12
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 6
        Transparent = True
      end
      object teKeysRU: TcxDBTextEdit
        Left = 116
        Top = 142
        DataBinding.DataField = 'META_KEY_RU'
        DataBinding.DataSource = IBCDataSourceWebGoods
        ParentFont = False
        TabOrder = 7
        Width = 808
      end
      object teDescRO: TcxDBMemo
        Left = 115
        Top = 223
        DataBinding.DataField = 'META_DESC_RO'
        DataBinding.DataSource = IBCDataSourceWebGoods
        ParentFont = False
        Properties.VisibleLineCount = 2
        TabOrder = 8
        Width = 808
      end
      object teDescRU: TcxDBMemo
        Left = 115
        Top = 258
        DataBinding.DataField = 'META_DESC_RU'
        DataBinding.DataSource = IBCDataSourceWebGoods
        ParentFont = False
        Properties.VisibleLineCount = 2
        TabOrder = 9
        Width = 808
      end
      object cxLabel4: TcxLabel
        Left = 11
        Top = 259
        Caption = 'Desc RU'
        ParentFont = False
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -12
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 10
        Transparent = True
      end
      object cxLabel5: TcxLabel
        Left = 12
        Top = 118
        Caption = 'Keys RO'
        ParentFont = False
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -12
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 11
        Transparent = True
      end
      object cxLabel7: TcxLabel
        Left = 12
        Top = 176
        Caption = 'slug ro/ru'
        ParentFont = False
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -12
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 12
        Transparent = True
      end
      object teSlugRO: TcxDBTextEdit
        Left = 115
        Top = 171
        DataBinding.DataField = 'slug_ro'
        DataBinding.DataSource = IBCDataSourceWebGoods
        ParentFont = False
        TabOrder = 13
        Width = 334
      end
      object teSlugRU: TcxDBTextEdit
        Left = 455
        Top = 171
        DataBinding.DataField = 'slug_ru'
        DataBinding.DataSource = IBCDataSourceWebGoods
        ParentFont = False
        TabOrder = 14
        Width = 381
      end
      object cxLabel6: TcxLabel
        Left = 12
        Top = 58
        Caption = 'H1 RO'
        ParentFont = False
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -12
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 15
        Transparent = True
      end
      object cxLabel9: TcxLabel
        Left = 12
        Top = 83
        Caption = 'H1 RU'
        ParentFont = False
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -12
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 16
        Transparent = True
      end
      object teH1RU: TcxDBTextEdit
        Left = 116
        Top = 82
        DataBinding.DataField = 'H1_RU'
        DataBinding.DataSource = IBCDataSourceWebGoods
        ParentFont = False
        TabOrder = 17
        Width = 808
      end
      object teH1RO: TcxDBTextEdit
        Left = 115
        Top = 55
        DataBinding.DataField = 'H1_RO'
        DataBinding.DataSource = IBCDataSourceWebGoods
        ParentFont = False
        TabOrder = 18
        Width = 808
      end
      object btnGenSlug: TcxButton
        Left = 852
        Top = 171
        Width = 75
        Height = 25
        Caption = 'Genereaza'
        TabOrder = 19
        OnClick = btnGenSlugClick
      end
    end
    object tbsAttributes: TcxTabSheet
      Caption = '&5 - Atribute'
      ImageIndex = 5
      inline frameGoodsAttributes1: TframeGoodsAttributes
        Left = 0
        Top = 0
        Width = 957
        Height = 432
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        inherited pnTop: TPanel
          Width = 957
        end
        inherited cxGridAttrs: TcxGrid
          Width = 957
          Height = 320
          inherited cxGridAttrsTable: TcxGridDBTableView
            OptionsView.Indicator = True
          end
        end
        inherited pnPreview: TPanel
          Top = 360
          Width = 957
        end
      end
    end
    object tbsServices: TcxTabSheet
      Caption = '&6 - Servicii'
      ImageIndex = 5
      inline frameGoodsServices1: TframeGoodsServices
        Left = 0
        Top = 0
        Width = 957
        Height = 432
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        inherited pnTop: TPanel
          Width = 957
        end
        inherited cxGridSvc: TcxGrid
          Width = 957
          Height = 372
        end
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
      'Images'
      'Default'
      'MetaTags'
      'Search Keys'
      'LikeGoods')
    Categories.ItemsVisibles = (
      2
      2
      2
      2
      2)
    Categories.Visibles = (
      True
      True
      True
      True
      True)
    ImageOptions.Images = dmAdditions.cxImageList_SWN
    ImageOptions.StretchGlyphs = False
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 596
    Top = 12
    PixelsPerInch = 96
    object dxBarManagerBar1: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Images'
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 113
      FloatTop = 310
      FloatClientWidth = 82
      FloatClientHeight = 77
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbAddNewImage'
        end
        item
          UserDefine = [udPaintStyle]
          Visible = True
          ItemName = 'bbImageEvent'
        end
        item
          UserDefine = [udPaintStyle]
          Visible = True
          ItemName = 'dxBarButton2'
        end
        item
          Visible = True
          ItemName = 'dxBarButton9'
        end
        item
          UserDefine = [udPaintStyle]
          Visible = True
          ItemName = 'bbSave'
        end
        item
          UserDefine = [udPaintStyle]
          Visible = True
          ItemName = 'bbRefresh'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          Visible = True
          ItemName = 'bbDeleteImage'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbDeleteAll'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbShowFullSize'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbMoveImageUp'
        end
        item
          Visible = True
          ItemName = 'bbMoveImageDown'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarSubItem1'
        end
        item
          BeginGroup = True
          UserDefine = [udWidth]
          UserWidth = 86
          Visible = True
          ItemName = 'dxcmbBarcode'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'dxBarButton8'
        end
        item
          Visible = True
          ItemName = 'dxBarStatic1'
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
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Descriptions'
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 0
      DockedTop = 0
      DockingStyle = dsTop
      FloatLeft = 874
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbNewInfo'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbModifyInfo'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbMoveTextUp'
        end
        item
          Visible = True
          ItemName = 'bbMoveTextDown'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbDeleteInfo'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbDeleteAllInfo'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbCopyFields'
        end
        item
          UserDefine = [udPaintStyle]
          Visible = True
          ItemName = 'bbPasteFields'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbFieldTemplates'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = False
      WholeRow = False
    end
    object dxBarManagerBar4: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Custom 2'
      CaptionButtons = <>
      DockControl = dxBarDockFilters
      DockedDockControl = dxBarDockFilters
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 996
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbFilterTemplates'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbFilterAdd'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbFilterEdit'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbDeleteGoodsProperty'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbDeleteAllProperties'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bsiInstrumente'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = True
    end
    object dxBarManagerBar5: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Custom 3'
      CaptionButtons = <>
      DockControl = dxBarDockControl3
      DockedDockControl = dxBarDockControl3
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 998
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbDescriptionRo_Paste'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbP'
        end
        item
          Visible = True
          ItemName = 'bbB'
        end
        item
          Visible = True
          ItemName = 'bbDiv'
        end
        item
          Visible = True
          ItemName = 'bbImg'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbYouTube'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbTranslateRom2Rus'
        end
        item
          Visible = True
          ItemName = 'bbRus2Rom'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBar6: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'MeetaTags'
      CaptionButtons = <>
      DockControl = dxBarDockControl4
      DockedDockControl = dxBarDockControl4
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 0
      FloatTop = 478
      FloatClientWidth = 154
      FloatClientHeight = 72
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbModifyGoodsTitle'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBar3: TdxBar
      Caption = 'Search Keys'
      CaptionButtons = <>
      DockControl = dxBarDockControl2
      DockedDockControl = dxBarDockControl2
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1003
      FloatTop = 2
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbSaveSearchKeys'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBar7: TdxBar
      Caption = 'LikeGoods'
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 0
      DockedTop = 0
      DockingStyle = dsTop
      FloatLeft = 1003
      FloatTop = 2
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbNewFilter'
        end
        item
          Visible = True
          ItemName = 'bbDeleteFilter'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbAddFilterParam'
        end
        item
          Visible = True
          ItemName = 'bbDeleteFilterParams'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = False
      WholeRow = False
    end
    object bbDeleteImage: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      ShortCut = 16430
      OnClick = bbDeleteImageClick
    end
    object bbImageEvent: TdxBarButton
      Caption = 'Prima imagine temporara'
      Category = 0
      Hint = 'Prima imagine temporara'
      Visible = ivAlways
      ImageIndex = 37
      ShortCut = 113
      OnClick = bbImageEventClick
    end
    object bbMoveImageUp: TdxBarButton
      Caption = 'In sus'
      Category = 0
      Hint = 'In sus'
      Visible = ivAlways
      ImageIndex = 9
      ShortCut = 16421
      OnClick = bbMoveImageUpClick
    end
    object bbMoveImageDown: TdxBarButton
      Caption = 'In jos'
      Category = 0
      Hint = 'In jos'
      Visible = ivAlways
      ImageIndex = 8
      ShortCut = 16423
      OnClick = bbMoveImageDownClick
    end
    object bbAddNewImage: TdxBarButton
      Caption = 'Nou'
      Category = 0
      Hint = 'Nou'
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 45
      OnClick = bbAddNewImageClick
    end
    object bbShowFullSize: TdxBarButton
      Caption = 'Visualizeaza'
      Category = 0
      Hint = #1055#1088#1086#1089#1084#1086#1090#1088' '#1074' '#1085#1072#1090#1091#1088#1072#1083#1100#1085#1091#1102' '#1074#1077#1083#1080#1095#1080#1085#1091
      Visible = ivAlways
      ImageIndex = 4
      OnClick = bbShowFullSizeClick
    end
    object bbFieldTemplates: TdxBarSubItem
      Caption = #1064#1072#1073#1083#1086#1085#1085#1099
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbSaveFieldsAsTemplate'
        end
        item
          Visible = True
          ItemName = 'bbSaveFields'
        end>
      ItemOptions.Size = misNormal
    end
    object bbCopyFields: TdxBarButton
      Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1074#1089#1077
      Category = 0
      Hint = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1074#1089#1077
      Visible = ivAlways
      ImageIndex = 29
    end
    object bbSaveFieldsAsTemplate: TdxBarButton
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1093#1072#1088#1072#1082#1090#1077#1088#1080#1089#1090#1080#1082#1080' '#1082#1072#1082' '#1085#1086#1074#1099#1081'  '#1096#1072#1073#1083#1086#1085'...'
      Category = 0
      Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1093#1072#1088#1072#1082#1090#1077#1088#1080#1089#1090#1080#1082#1080' '#1082#1072#1082' '#1085#1086#1074#1099#1081'  '#1096#1072#1073#1083#1086#1085
      Visible = ivAlways
    end
    object dxBarButton2: TdxBarButton
      Caption = 'Lipeste imaginea'
      Category = 0
      Hint = 'Lipeste imaginea'
      Visible = ivAlways
      ImageIndex = 75
      PaintStyle = psCaptionGlyph
      ShortCut = 16470
      OnClick = dxBarButton2Click
    end
    object bbP: TdxBarButton
      Caption = '<p>'
      Category = 0
      Hint = '<p>'
      Visible = ivAlways
      OnClick = bbPClick
    end
    object bbB: TdxBarButton
      Caption = '<b>'
      Category = 0
      Hint = '<b>'
      Visible = ivAlways
      ShortCut = 16450
      OnClick = bbBClick
    end
    object bbDiv: TdxBarButton
      Caption = '<div>'
      Category = 0
      Hint = '<div>'
      Visible = ivAlways
      OnClick = bbDivClick
    end
    object bbImg: TdxBarButton
      Caption = '<img>'
      Category = 0
      Hint = '<img>'
      Visible = ivAlways
      OnClick = bbImgClick
    end
    object bbYouTube: TdxBarButton
      Caption = '<Youtube>'
      Category = 0
      Hint = '<Youtube>'
      Visible = ivAlways
      OnClick = bbYouTubeClick
    end
    object bbNewInfo: TdxBarButton
      Caption = #1053#1086#1074#1072#1103
      Category = 1
      Hint = #1053#1086#1074#1072#1103
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 45
    end
    object bbModifyInfo: TdxBarButton
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      Category = 1
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 113
    end
    object bbDeleteInfo: TdxBarButton
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Category = 1
      Hint = #1059#1076#1072#1083#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 42
      ShortCut = 46
    end
    object bbPasteFields: TdxBarButton
      Caption = #1042#1089#1090#1072#1074#1080#1090#1100
      Category = 1
      Hint = #1042#1089#1090#1072#1074#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 24
    end
    object bbDeleteAllInfo: TdxBarButton
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1074#1089#1077
      Category = 1
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1074#1089#1077
      Visible = ivAlways
      ImageIndex = 35
      ShortCut = 16430
    end
    object dxBarButton1: TdxBarButton
      Caption = #1042#1089#1090#1072#1074#1080#1090#1100' '#1080#1079' '#1092#1072#1081#1083#1072'...'
      Category = 1
      Hint = #1042#1089#1090#1072#1074#1080#1090#1100' '#1080#1079' '#1092#1072#1081#1083#1072
      Visible = ivAlways
      ImageIndex = 13
    end
    object bbDescription_Paste: TdxBarButton
      Caption = #1042#1089#1090#1072#1074#1080#1090#1100
      Category = 1
      Hint = #1042#1089#1090#1072#1074#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 24
    end
    object bbMoveTextUp: TdxBarButton
      Caption = #1055#1077#1088#1077#1084#1077#1089#1090#1080#1090#1100' '#1074#1074#1077#1088#1093
      Category = 1
      Hint = #1055#1077#1088#1077#1084#1077#1089#1090#1080#1090#1100' '#1074#1074#1077#1088#1093
      Visible = ivAlways
      ImageIndex = 9
    end
    object bbMoveTextDown: TdxBarButton
      Caption = #1055#1077#1088#1077#1084#1077#1089#1090#1080#1090#1100' '#1074#1085#1080#1079
      Category = 1
      Hint = #1055#1077#1088#1077#1084#1077#1089#1090#1080#1090#1100' '#1074#1085#1080#1079
      Visible = ivAlways
      ImageIndex = 8
    end
    object bbDeleteAllProperties: TdxBarButton
      Caption = 'Sterge tot'
      Category = 1
      Hint = 'Sterge tot'
      Visible = ivAlways
      ImageIndex = 35
      OnClick = bbDeleteAllPropertiesClick
    end
    object bbFilterEdit: TdxBarButton
      Caption = 'Modifica Filtru'
      Category = 1
      Hint = 'Modifica Filtru'
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 115
      OnClick = bbFilterEditClick
    end
    object bbFilterTemplates: TdxBarButton
      Caption = 'Sablon'
      Category = 1
      Hint = #1048#1084#1087#1086#1088#1090' '#1092#1080#1083#1100#1090#1088#1086#1074' '#1086#1090' '#1087#1088#1077#1076#1082#1072
      Visible = ivAlways
      ImageIndex = 13
      ShortCut = 16429
      OnClick = bbFilterTemplatesClick
    end
    object bbFilterSort: TdxBarButton
      Caption = 'Sorteaza'
      Category = 1
      Hint = 'Sorteaza'
      Visible = ivAlways
      ImageIndex = 38
      ShortCut = 32851
      OnClick = bbFilterSortClick
    end
    object bbSaveFields: TdxBarButton
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1093#1072#1088#1072#1082#1090#1077#1088#1080#1089#1090#1080#1082#1080' '#1082#1072#1082' '
      Category = 1
      Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1093#1072#1088#1072#1082#1090#1077#1088#1080#1089#1090#1080#1082#1080' '#1082#1072#1082' '
      Visible = ivAlways
    end
    object bbChangeFilterVisibility: TdxBarButton
      Caption = 'New Button'
      Category = 1
      Hint = 'New Button'
      Visible = ivAlways
      ImageIndex = 26
      ShortCut = 16453
      OnClick = bbChangeFilterVisibilityClick
    end
    object bbPrint: TdxBarButton
      Caption = 'Tpar'
      Category = 1
      Hint = 'Tpar'
      Visible = ivAlways
      ImageIndex = 28
      ShortCut = 16464
      OnClick = bbPrintClick
    end
    object bbGotoButtons: TdxBarButton
      Caption = 'Butonul de trecere'
      Category = 1
      Hint = 'Butonul de trecere'
      Visible = ivAlways
      ImageIndex = 3
      ShortCut = 16455
      OnClick = bbGotoButtonsClick
    end
    object bbFilterClone: TdxBarButton
      Caption = 'Clonare filtru...'
      Category = 1
      Hint = 'Clonare filtru'
      Visible = ivAlways
      ImageIndex = 29
      ShortCut = 16452
      OnClick = bbFilterCloneClick
    end
    object bbFilterAdd: TdxBarButton
      Caption = 'Adauga filtru'
      Category = 1
      Hint = 'Adauga filtru'
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 45
      OnClick = bbFilterAddClick
    end
    object bbDescriptionRo_Paste: TdxBarButton
      Caption = 'New Button'
      Category = 1
      Hint = 'New Button'
      Visible = ivAlways
      ImageIndex = 24
    end
    object dxBarButton3: TdxBarButton
      Caption = 'Seteaza ca schita'
      Category = 1
      Hint = 'Seteaza ca schita'
      Visible = ivAlways
      ShortCut = 16467
      OnClick = dxBarButton3Click
    end
    object dxBarSubItem1: TdxBarSubItem
      Caption = 'Instrumente'
      Category = 1
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarButton3'
        end
        item
          Visible = True
          ItemName = 'bbImportImageFromGoods'
        end>
    end
    object dxBarStatic1: TdxBarStatic
      Align = iaRight
      Caption = 'Imagine'
      Category = 1
      Hint = 'Imagine'
      Visible = ivAlways
      Alignment = taRightJustify
    end
    object bsiInstrumente: TdxBarSubItem
      Caption = 'Instrumente'
      Category = 1
      Visible = ivAlways
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbFilterClone'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbGotoButtons'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbFilterSort'
        end
        item
          Visible = True
          ItemName = 'bbImport'
        end
        item
          Visible = True
          ItemName = 'bbHistory'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbFilterProperties'
        end
        item
          Visible = True
          ItemName = 'dxBarButton4'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbPrint'
        end>
    end
    object bbImport: TdxBarButton
      Caption = 'Importa caracteristici din alt produs...'
      Category = 1
      Hint = 'Importa caracteristici din alt produs'
      Visible = ivNotInCustomizing
      ImageIndex = 8
      ShortCut = 32841
      OnClick = bbImportClick
    end
    object bbImportImageFromGoods: TdxBarButton
      Caption = 'Importa din alt produs...'
      Category = 1
      Hint = 'Importa din alt produs'
      Visible = ivAlways
      ShortCut = 32841
      OnClick = bbImportImageFromGoodsClick
    end
    object dxcmbBarcode: TdxBarCombo
      Caption = 'Cod Furnizor'
      Category = 1
      Hint = 'Cod Furnizor'
      Visible = ivAlways
      ShowCaption = True
      ItemIndex = -1
    end
    object dxBarButton7: TdxBarButton
      Caption = 'Sterge meta tag-urile'
      Category = 1
      Hint = 'Sterge meta tag-urile'
      Visible = ivAlways
      ImageIndex = 35
      PaintStyle = psCaptionGlyph
      OnClick = dxBarButton7Click
    end
    object dxBarButton8: TdxBarButton
      Caption = 'Cauta imagini'
      Category = 1
      Hint = 'Cauta imagini'
      Visible = ivAlways
      ImageIndex = 134
      ShortCut = 32839
      OnClick = dxBarButton8Click
    end
    object bbHistory: TdxBarButton
      Caption = 'Istoria'
      Category = 1
      Hint = 'Istoria'
      Visible = ivAlways
      ShortCut = 16456
      OnClick = bbHistoryClick
    end
    object bbDeleteGoodsProperty: TdxBarButton
      Caption = 'Sterge'
      Category = 1
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      OnClick = bbDeleteGoodsPropertyClick
    end
    object bbSave: TdxBarButton
      Action = actSaveImages
      Category = 1
      ImageIndex = 32
      ShortCut = 16467
    end
    object bbRefresh: TdxBarButton
      Caption = 'Refresh'
      Category = 1
      Hint = 'Refresh'
      Visible = ivAlways
      ImageIndex = 36
      ShortCut = 116
      OnClick = bbRefreshClick
    end
    object bbModifyGoodsTitle: TdxBarButton
      Caption = 'Modifica denumirea de sistema'
      Category = 1
      Hint = 'Modifica denumirea de sistema'
      Visible = ivAlways
      ImageIndex = 71
      ShortCut = 113
      OnClick = bbModifyGoodsTitleClick
    end
    object bbFilterProperties: TdxBarButton
      Caption = 'Proprietatile filtrului'
      Category = 1
      Hint = 'Proprietatile filtrului'
      Visible = ivAlways
      ShortCut = 32838
      OnClick = bbFilterPropertiesClick
    end
    object dxBarButton4: TdxBarButton
      Caption = 'Visibil / Invisibil'
      Category = 1
      Hint = 'Visibil / Invisibil'
      Visible = ivAlways
      ShortCut = 32854
      OnClick = dxBarButton4Click
    end
    object dxBarButton9: TdxBarButton
      Caption = 'Download'
      Category = 1
      Hint = 'Download'
      Visible = ivAlways
      OnClick = dxBarButton9Click
    end
    object bbDeleteAll: TdxBarButton
      Caption = 'Sterge tot'
      Category = 1
      Hint = 'Sterge tot'
      Visible = ivAlways
      ImageIndex = 35
      OnClick = bbDeleteAllClick
    end
    object bbTranslateRom2Rus: TdxBarButton
      Caption = 'Rom -> Rus'
      Category = 1
      Hint = 'Rom -> Rus'
      Visible = ivAlways
      OnClick = bbTranslateRom2RusClick
    end
    object bbRus2Rom: TdxBarButton
      Caption = 'Rus -> Rom'
      Category = 1
      Hint = 'Rus -> Rom'
      Visible = ivAlways
    end
    object dxBarButton5: TdxBarButton
      Caption = 'Competeaza denumirea'
      Category = 2
      Enabled = False
      Hint = 'Competeaza denumirea'
      Visible = ivAlways
      ImageIndex = 74
      PaintStyle = psCaptionGlyph
      ShortCut = 115
    end
    object dxBarButton6: TdxBarButton
      Caption = 'Completeaza Meta'
      Category = 2
      Enabled = False
      Hint = 'Completeaza Meta'
      Visible = ivAlways
      ImageIndex = 110
      PaintStyle = psCaptionGlyph
      ShortCut = 116
    end
    object bbSaveSearchKeys: TdxBarButton
      Action = actSaveSearchKeys
      Category = 3
    end
    object bbNewFilter: TdxBarButton
      Caption = 'Adauga Filtru'
      Category = 4
      Hint = 'Adauga Filtru'
      Visible = ivAlways
    end
    object bbAddFilterParam: TdxBarButton
      Caption = 'Valoarea filtrului'
      Category = 4
      Hint = 'Valoarea filtrului'
      Visible = ivAlways
    end
    object bbDeleteFilter: TdxBarButton
      Caption = 'Sterge filtru'
      Category = 4
      Hint = 'Sterge filtru'
      Visible = ivAlways
    end
    object bbDeleteFilterParams: TdxBarButton
      Caption = 'Sterge valoarea filtrului'
      Category = 4
      Hint = 'Sterge valoarea filtrului'
      Visible = ivAlways
    end
  end
  object OpenPictureDialog: TOpenPictureDialog
    Filter = 
      'All images|*.png;*.jpg;*.jpeg;*.gif|JPEG Image File (*.jpg)|*.jp' +
      'g|JPEG Image File (*.jpeg)|*.jpeg|PNG Image File (*.png)|*.png|G' +
      'IF Image File (*.gif)|*.gif'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing, ofDontAddToRecent]
    Left = 728
    Top = 72
  end
  object IBCQueryFilters: TIBCQuery
    KeyFields = 'DESCRIPTIONID'
    KeyGenerator = 'SQ_TS_GOODS_DESCRIPTIONS_ID'
    GeneratorMode = gmInsert
    SQLInsert.Strings = (
      'INSERT INTO VW_TS_GOODS_DESCRIPTIONS'
      
        '  (GOODSID, DESCRIPTIONID, FLG_GROUP, FILTERID, FILTERNAME_ROM, ' +
        'FILTERNAME_RUS, FILTERPARAMID, PARAM_VALUE_ROM, PARAM_VALUE_RUS,' +
        ' FLG_VISIBLE, FLG_COMPATIBILITY, FLG_COMPARE, FLG_GOODS_LINK, FL' +
        'G_ORDINARY_FILTER, ORDERNO, BUTTONS_LIST, CREATED_BY, CREATED_BY' +
        '_NAME)'
      'VALUES'
      
        '  (:GOODSID, :DESCRIPTIONID, :FLG_GROUP, :FILTERID, :FILTERNAME_' +
        'ROM, :FILTERNAME_RUS, :FILTERPARAMID, :PARAM_VALUE_ROM, :PARAM_V' +
        'ALUE_RUS, :FLG_VISIBLE, :FLG_COMPATIBILITY, :FLG_COMPARE, :FLG_G' +
        'OODS_LINK, :FLG_ORDINARY_FILTER, :ORDERNO, :BUTTONS_LIST, :CREAT' +
        'ED_BY, :CREATED_BY_NAME)')
    SQLDelete.Strings = (
      'DELETE FROM VW_TS_GOODS_DESCRIPTIONS'
      'WHERE'
      '  DESCRIPTIONID = :Old_DESCRIPTIONID')
    SQLUpdate.Strings = (
      'UPDATE VW_TS_GOODS_DESCRIPTIONS'
      'SET'
      
        '  GOODSID = :GOODSID, DESCRIPTIONID = :DESCRIPTIONID, FLG_GROUP ' +
        '= :FLG_GROUP, FILTERID = :FILTERID, FILTERNAME_ROM = :FILTERNAME' +
        '_ROM, FILTERNAME_RUS = :FILTERNAME_RUS, FILTERPARAMID = :FILTERP' +
        'ARAMID, PARAM_VALUE_ROM = :PARAM_VALUE_ROM, PARAM_VALUE_RUS = :P' +
        'ARAM_VALUE_RUS, FLG_VISIBLE = :FLG_VISIBLE, FLG_COMPATIBILITY = ' +
        ':FLG_COMPATIBILITY, FLG_COMPARE = :FLG_COMPARE, FLG_GOODS_LINK =' +
        ' :FLG_GOODS_LINK, FLG_ORDINARY_FILTER = :FLG_ORDINARY_FILTER, OR' +
        'DERNO = :ORDERNO, BUTTONS_LIST = :BUTTONS_LIST, CREATED_BY = :CR' +
        'EATED_BY, CREATED_BY_NAME = :CREATED_BY_NAME'
      'WHERE'
      '  DESCRIPTIONID = :Old_DESCRIPTIONID')
    SQLRefresh.Strings = (
      'SELECT * FROM VW_TS_GOODS_DESCRIPTIONS'
      'WHERE'
      '  DESCRIPTIONID = :DESCRIPTIONID')
    SQLLock.Strings = (
      '')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM VW_TS_GOODS_DESCRIPTIONS'
      ''
      ') q')
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT'
      '*'
      'FROM '
      ' VW_TS_GOODS_DESCRIPTIONS'
      'ORDER BY'
      ' ORDERNO')
    MasterFields = 'GOODSID'
    DetailFields = 'GOODSID'
    AutoCommit = False
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Options.RequiredFields = False
    LocalConstraints = False
    Left = 196
    Top = 308
  end
  object IBCDataSourceFilters: TIBCDataSource
    DataSet = IBCQueryFilters
    Left = 196
    Top = 248
  end
  object cxGridPopupMenu: TcxGridPopupMenu
    PopupMenus = <
      item
        HitTypes = [gvhtCell, gvhtRecord]
        Index = 0
        PopupMenu = dxBarPopupMenuFilters
      end>
    UseBuiltInPopupMenus = False
    AlwaysFireOnPopup = True
    Left = 464
    Top = 336
  end
  object dxBarPopupMenuFilters: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbFilterEdit'
      end
      item
        Visible = True
        ItemName = 'bbDeleteGoodsProperty'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbFilterSort'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbChangeFilterVisibility'
      end>
    UseOwnFont = False
    OnPopup = dxBarPopupMenuFiltersPopup
    Left = 336
    Top = 336
    PixelsPerInch = 96
  end
  object IBCQueryDSC: TIBCQuery
    KeyFields = 'GOODSID'
    SQLInsert.Strings = (
      'INSERT INTO TS_GOODS_DSC'
      '  (GOODSID, DESCRIPTION, DESCRIPTION_RO, DESCRIERE_MOBILA)'
      'VALUES'
      '  (:GOODSID, :DESCRIPTION, :DESCRIPTION_RO, :DESCRIERE_MOBILA)')
    SQLDelete.Strings = (
      'DELETE FROM TS_GOODS_DSC'
      'WHERE'
      '  GOODSID = :Old_GOODSID')
    SQLUpdate.Strings = (
      'UPDATE TS_GOODS_DSC'
      'SET'
      '  GOODSID = :GOODSID, '
      '  DESCRIPTION = :DESCRIPTION,'
      '  DESCRIPTION_RO = :DESCRIPTION_RO,'
      '  DESCRIERE_MOBILA = :DESCRIERE_MOBILA'
      'WHERE'
      '  GOODSID = :Old_GOODSID')
    SQLRefresh.Strings = (
      
        'SELECT GOODSID, DESCRIPTION, DESCRIPTION_RO, DESCRIERE_MOBILA FR' +
        'OM TS_GOODS_DSC'
      'WHERE'
      '  GOODSID = :GOODSID')
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT '
      ' GOODSID, '
      ' DESCRIPTION, '
      ' DESCRIPTION_RO, '
      ' DESCRIERE_MOBILA'
      'FROM '
      ' TS_GOODS_DSC')
    MasterFields = 'GOODSID'
    DetailFields = 'GOODSID'
    AutoCommit = False
    Left = 352
    Top = 288
  end
  object IBCDataSourceDSC: TIBCDataSource
    DataSet = IBCQueryDSC
    Left = 352
    Top = 236
  end
  object dxComponentPrinter: TdxComponentPrinter
    CurrentLink = dxComponentPrinterLink1
    PreviewOptions.EnableOptions = [peoCanChangeMargins, peoPageSetup, peoPreferences, peoPrint]
    PreviewOptions.VisibleOptions = [pvoPageSetup, pvoPreferences, pvoPrint, pvoPageMargins]
    PreviewOptions.WindowState = wsMaximized
    PrintTitle = #1054#1087#1080#1089#1072#1085#1080#1077' '#1090#1086#1074#1072#1088#1072
    Version = 0
    Left = 592
    Top = 340
    PixelsPerInch = 96
    object dxComponentPrinterLink1: TdxGridReportLink
      PrinterPage.DMPaper = 9
      PrinterPage.Footer = 6350
      PrinterPage.GrayShading = True
      PrinterPage.Header = 6350
      PrinterPage.Margins.Bottom = 12700
      PrinterPage.Margins.Left = 12700
      PrinterPage.Margins.Right = 12700
      PrinterPage.Margins.Top = 12700
      PrinterPage.Orientation = poLandscape
      PrinterPage.PageSize.X = 210000
      PrinterPage.PageSize.Y = 297000
      PrinterPage._dxMeasurementUnits_ = 0
      PrinterPage._dxLastMU_ = 2
      ReportDocument.CreationDate = 44101.954015266200000000
      ReportDocument.Creator = 'SWN'
      ReportDocument.IsCaptionAssigned = True
      ReportTitle.Font.Charset = RUSSIAN_CHARSET
      ReportTitle.Font.Color = clBlack
      ReportTitle.Font.Height = -16
      ReportTitle.Font.Name = 'Calibri'
      ReportTitle.Font.Style = [fsBold]
      ReportTitle.Mode = tmOnFirstPage
      ReportTitle.TextAlignX = taLeft
      OptionsFormatting.ConsumeSelectionStyle = True
      OptionsLevels.Unwrap = True
      OptionsOnEveryPage.Footers = False
      OptionsOnEveryPage.Caption = False
      OptionsOnEveryPage.FilterBar = False
      OptionsRefinements.TransparentGraphics = True
      OptionsSize.AutoWidth = True
      OptionsView.Footers = False
      OptionsView.Caption = False
      OptionsView.ExpandButtons = False
      OptionsView.FilterBar = False
      OptionsView.GroupFooters = False
      StyleRepository = dmAdditions.cxMainStyleRepository
      PixelsPerInch = 96
      BuiltInReportLink = True
    end
  end
  object IBCTrLog: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 592
    Top = 400
  end
  object IBCDataSourceWebGoods: TIBCDataSource
    DataSet = IBCQueryWebGoods
    Left = 729
    Top = 22
  end
  object IBCQueryWebGoods: TIBCQuery
    KeyFields = 'GOODSID'
    SQLInsert.Strings = (
      'INSERT INTO TWEB_GOODS'
      
        '  (GOODSID, NAME_RO, NAME_RU, META_TITLE_RO, META_TITLE_RU, META' +
        '_DESC_RO, META_DESC_RU, META_KEY_RO, META_KEY_RU)'
      'VALUES'
      
        '  (:GOODSID, :NAME_RO, :NAME_RU, :META_TITLE_RO, :META_TITLE_RU,' +
        ' :META_DESC_RO, :META_DESC_RU, :META_KEY_RO, :META_KEY_RU)')
    SQLDelete.Strings = (
      'DELETE FROM TWEB_GOODS'
      'WHERE'
      '  GOODSID = :Old_GOODSID')
    SQLUpdate.Strings = (
      'UPDATE TWEB_GOODS'
      'SET'
      
        '  GOODSID = :GOODSID, NAME_RO = :NAME_RO, NAME_RU = :NAME_RU, ME' +
        'TA_TITLE_RO = :META_TITLE_RO, META_TITLE_RU = :META_TITLE_RU, ME' +
        'TA_DESC_RO = :META_DESC_RO, META_DESC_RU = :META_DESC_RU, META_K' +
        'EY_RO = :META_KEY_RO, META_KEY_RU = :META_KEY_RU'
      'WHERE'
      '  GOODSID = :Old_GOODSID')
    SQLRefresh.Strings = (
      
        'SELECT GOODSID, NAME_RO, NAME_RU, META_TITLE_RO, META_TITLE_RU, ' +
        'META_DESC_RO, META_DESC_RU, META_KEY_RO, META_KEY_RU FROM TWEB_G' +
        'OODS'
      'WHERE'
      '  GOODSID = :GOODSID')
    SQLLock.Strings = (
      'SELECT NULL FROM TWEB_GOODS'
      'WHERE'
      'GOODSID = :Old_GOODSID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM TWEB_GOODS'
      ''
      ') q')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      'select * from tweb_goods where goodsid=:goodsid')
    MasterFields = 'GOODSID'
    DetailFields = 'GOODSID'
    AutoCommit = False
    Left = 825
    Top = 19
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'goodsid'
        Value = nil
      end>
  end
  object dxBarPopupMenuImages: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
        ItemName = 'dxBarButton2'
      end>
    UseOwnFont = False
    Left = 336
    Top = 400
    PixelsPerInch = 96
  end
  object ActionList1: TActionList
    Images = dmAdditions.cxImageList_SWN
    Left = 364
    Top = 132
    object actSaveImages: TAction
      Caption = 'Salveaza'
      OnExecute = actSaveImagesExecute
      OnUpdate = actSaveImagesUpdate
    end
  end
  object IBCTrImage: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 512
    Top = 192
  end
  object IBCQuerySearchkeys: TIBCQuery
    KeyFields = 'GOODSID'
    SQLInsert.Strings = (
      'INSERT INTO TS_GOODS_SEARCHKEYS'
      '  (GOODSID, SEARCHKEYS)'
      'VALUES'
      '  (:GOODSID, :SEARCHKEYS)')
    SQLDelete.Strings = (
      'DELETE FROM TS_GOODS_SEARCHKEYS'
      'WHERE'
      '  GOODSID = :Old_GOODSID')
    SQLUpdate.Strings = (
      'UPDATE TS_GOODS_SEARCHKEYS'
      'SET'
      '  GOODSID = :GOODSID, SEARCHKEYS = :SEARCHKEYS'
      'WHERE'
      '  GOODSID = :Old_GOODSID')
    SQLRefresh.Strings = (
      'SELECT GOODSID, SEARCHKEYS FROM TS_GOODS_SEARCHKEYS'
      'WHERE'
      '  GOODSID = :GOODSID')
    SQLLock.Strings = (
      'SELECT NULL FROM TS_GOODS_SEARCHKEYS'
      'WHERE'
      'GOODSID = :Old_GOODSID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM TS_GOODS_SEARCHKEYS'
      ''
      ') q')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      'select * from ts_goods_searchkeys')
    MasterFields = 'GOODSID'
    DetailFields = 'GOODSID'
    AutoCommit = False
    Left = 664
    Top = 192
  end
  object IBCDataSourceSearchkeys: TIBCDataSource
    DataSet = IBCQuerySearchkeys
    Left = 668
    Top = 143
  end
  object ActionList2: TActionList
    Images = dmAdditions.cxImageList_SWN
    Left = 112
    Top = 336
    object actSaveSearchKeys: TAction
      Caption = 'Salveaza'
      ImageIndex = 139
      OnExecute = actSaveSearchKeysExecute
      OnUpdate = actSaveSearchKeysUpdate
    end
  end
  object SynHTMLSyn1: TSynHTMLSyn
    Brackets = '<>()[]{}'
    Left = 480
    Top = 360
  end
end
