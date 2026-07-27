inherited frame38ServiceFinishedIncidents: Tframe38ServiceFinishedIncidents
  Font.Height = -15
  PixelsPerInch = 120
  object pnClient: TPanel
    Left = 0
    Top = 0
    Width = 986
    Height = 358
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object pnClientClient: TPanel
      Left = 0
      Top = 0
      Width = 986
      Height = 358
      Align = alClient
      BevelOuter = bvNone
      Padding.Bottom = 2
      TabOrder = 0
      object dxBarDockControl1: TdxBarDockControl
        Left = 0
        Top = 0
        Width = 986
        Height = 34
        Align = dalTop
        BarManager = dxBarManager
        SunkenBorder = True
        UseOwnSunkenBorder = True
      end
      object cxGridIncidente: TcxGrid
        Left = 0
        Top = 34
        Width = 986
        Height = 322
        Align = alClient
        TabOrder = 1
        object cxGridIncidenteTable: TcxGridDBTableView
          PopupMenu = dxBarPopupMenu1
          OnKeyDown = cxGridIncidenteTableKeyDown
          OnCustomDrawCell = cxGridIncidenteTableCustomDrawCell
          DataController.KeyFieldNames = 'INCIDENTID'
          FilterRow.SeparatorWidth = 8
          FixedDataRows.SeparatorWidth = 8
          NewItemRow.SeparatorWidth = 8
          OptionsBehavior.IncSearch = True
          OptionsBehavior.ImmediateEditor = False
          OptionsCustomize.ColumnsQuickCustomization = True
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.InvertSelect = False
          OptionsView.NavigatorOffset = 63
          OptionsView.ScrollBars = ssVertical
          OptionsView.ColumnAutoWidth = True
          OptionsView.FixedColumnSeparatorWidth = 3
          OptionsView.GridLineColor = 13750737
          OptionsView.GroupRowStyle = grsOffice11
          OptionsView.Indicator = True
          Preview.LeftIndent = 25
          Preview.RightIndent = 6
          RowLayout.MinValueWidth = 100
          Styles.Header = dmAdditions.cxStyle_GridHeader
          Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
          object cxGridIncidente_INCIDENTID: TcxGridDBColumn
            Caption = #1050#1086#1076
            DataBinding.FieldName = 'INCIDENTID'
            HeaderAlignmentHorz = taCenter
            MinWidth = 60
            Options.HorzSizing = False
            VisibleForCustomization = False
            Width = 60
          end
          object cxGridIncidente_DATA_FINISHED: TcxGridDBColumn
            Caption = #1044#1072#1090#1072' '#1079#1072#1074#1077#1088#1096#1077#1085#1080#1103
            DataBinding.FieldName = 'DATA_FINISHED'
            PropertiesClassName = 'TcxLabelProperties'
            Properties.Alignment.Horz = taCenter
            OnGetDisplayText = cxGridIncidente_DATA_FINISHEDGetDisplayText
            HeaderAlignmentHorz = taCenter
            MinWidth = 100
            Options.HorzSizing = False
            VisibleForCustomization = False
            Width = 100
          end
          object cxGridIncidente_DOC_CUSTOMER: TcxGridDBColumn
            Caption = #1050#1086#1085#1090#1088#1072#1075#1077#1085#1090
            DataBinding.FieldName = 'DOC_CUSTOMER'
            Styles.Content = dmAdditions.cxStyle_Bold
            VisibleForCustomization = False
            Width = 200
          end
          object cxGridIncidente_TYPE_TITLE: TcxGridDBColumn
            Caption = #1048#1085#1094#1080#1076#1077#1085#1090
            DataBinding.FieldName = 'TYPE_TITLE'
            VisibleForCustomization = False
            Width = 200
          end
          object cxGridIncidente_VENDOR_TITLE: TcxGridDBColumn
            Caption = #1055#1088#1086#1080#1079#1074#1086#1076#1080#1090#1077#1083#1100
            DataBinding.FieldName = 'VENDOR_TITLE'
            Visible = False
            Width = 80
          end
          object cxGridIncidente_GOODS_MODEL: TcxGridDBColumn
            Caption = #1058#1086#1074#1072#1088
            DataBinding.FieldName = 'GOODS_MODEL'
            HeaderAlignmentHorz = taCenter
            VisibleForCustomization = False
            Width = 100
          end
          object cxGridIncidente_GOODS_SN: TcxGridDBColumn
            Caption = #1057#1077#1088#1080#1081#1085#1099#1081' '#1085#1086#1084#1077#1088
            DataBinding.FieldName = 'GOODS_SN'
            HeaderAlignmentHorz = taCenter
            VisibleForCustomization = False
            Width = 100
          end
          object cxGridIncidente_STATUS_TITLE: TcxGridDBColumn
            Caption = #1057#1090#1072#1090#1091#1089' '#1080#1085#1094#1080#1076#1077#1085#1090#1072
            DataBinding.FieldName = 'STATUS_TITLE'
            Visible = False
            GroupIndex = 0
            VisibleForCustomization = False
            Width = 100
          end
          object cxGridIncidente_RETURN_DOCID: TcxGridDBColumn
            Caption = #8470' '#1074#1086#1079#1074#1088#1072#1090#1072
            DataBinding.FieldName = 'RETURN_DOCID'
            HeaderAlignmentHorz = taCenter
            MinWidth = 80
            Options.HorzSizing = False
            Width = 80
          end
          object cxGridIncidente_RASHOD_DOCID: TcxGridDBColumn
            AlternateCaption = #8470' '#1056#1072#1089#1093#1086#1076#1072' '#1082#1083#1080#1077#1085#1090#1072
            Caption = #8470' '#1056#1072#1089#1093'. '#1050#1083#1080#1077#1085#1090#1072
            DataBinding.FieldName = 'RASHOD_DOCID'
            HeaderAlignmentHorz = taCenter
            MinWidth = 100
            Options.HorzSizing = False
            Width = 100
          end
          object cxGridIncidente_PAYER_RASHOD_DOCID: TcxGridDBColumn
            AlternateCaption = #8470' '#1056#1072#1089#1093#1086#1076#1072' '#1087#1083#1072#1090#1077#1083#1100#1097#1080#1082#1072
            Caption = #8470' '#1056#1072#1089#1093'. '#1087#1083#1072#1090#1077#1083#1100#1097#1080#1082#1072
            DataBinding.FieldName = 'PAYER_RASHOD_DOCID'
            HeaderAlignmentHorz = taCenter
            MinWidth = 130
            Options.HorzSizing = False
            Width = 130
          end
        end
        object cxGridIncidenteLevel: TcxGridLevel
          GridView = cxGridIncidenteTable
        end
      end
    end
  end
  object pnBottom: TPanel
    Left = 0
    Top = 368
    Width = 986
    Height = 300
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object pcPageControl: TcxPageControl
      Left = 0
      Top = 0
      Width = 986
      Height = 300
      Align = alClient
      TabOrder = 0
      TabStop = False
      Properties.ActivePage = tbsGeneralInfo
      Properties.CustomButtons.Buttons = <>
      Properties.TabPosition = tpBottom
      ClientRectBottom = 268
      ClientRectLeft = 4
      ClientRectRight = 982
      ClientRectTop = 4
      object tbsGeneralInfo: TcxTabSheet
        Caption = #1054#1073#1097#1072#1103' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1103' (&1)'
        ImageIndex = 3
        ExplicitHeight = 267
        object GridPanel1: TGridPanel
          Left = 0
          Top = 0
          Width = 978
          Height = 264
          Align = alClient
          BevelOuter = bvNone
          ColumnCollection = <
            item
              Value = 50.000000000000000000
            end
            item
              Value = 50.000000000000000000
            end>
          ControlCollection = <
            item
              Column = 0
              Control = GridPanel2
              Row = 0
            end
            item
              Column = 1
              Control = Panel2
              Row = 0
            end>
          RowCollection = <
            item
              Value = 100.000000000000000000
            end>
          ShowCaption = False
          TabOrder = 0
          ExplicitHeight = 267
          object GridPanel2: TGridPanel
            Left = 0
            Top = 0
            Width = 489
            Height = 264
            Align = alClient
            BevelOuter = bvNone
            ColumnCollection = <
              item
                Value = 100.000000000000000000
              end>
            ControlCollection = <
              item
                Column = 0
                Control = Panel1
                Row = 0
              end
              item
                Column = 0
                Control = Panel3
                Row = 1
              end>
            RowCollection = <
              item
                Value = 50.000000000000000000
              end
              item
                Value = 50.000000000000000000
              end>
            ShowCaption = False
            TabOrder = 0
            ExplicitHeight = 267
            object Panel1: TPanel
              Left = 0
              Top = 0
              Width = 489
              Height = 132
              Align = alClient
              BevelOuter = bvNone
              Padding.Left = 8
              Padding.Top = 8
              Padding.Right = 8
              Padding.Bottom = 8
              ShowCaption = False
              TabOrder = 0
              ExplicitHeight = 134
              object lbDefectPresets: TLabel
                Left = 8
                Top = 8
                Width = 473
                Height = 20
                Cursor = crHandPoint
                Align = alTop
                Caption = #1054#1087#1080#1089#1072#1085#1080#1077' '#1087#1088#1077#1076#1087#1086#1083#1086#1075#1072#1077#1084#1086#1075#1086' '#1076#1077#1092#1077#1082#1090#1072
                ExplicitWidth = 259
              end
              object mmDEFECTE_DSC: TcxDBMemo
                AlignWithMargins = True
                Left = 8
                Top = 30
                Margins.Left = 0
                Margins.Top = 2
                Margins.Right = 0
                Margins.Bottom = 0
                TabStop = False
                Align = alClient
                DataBinding.DataField = 'DEFECTE_DSC'
                ParentFont = False
                Properties.ReadOnly = True
                Properties.ScrollBars = ssVertical
                Style.Font.Charset = DEFAULT_CHARSET
                Style.Font.Color = clNavy
                Style.Font.Height = -13
                Style.Font.Name = 'Arial'
                Style.Font.Style = []
                Style.IsFontAssigned = True
                TabOrder = 0
                ExplicitTop = 25
                ExplicitHeight = 101
                Height = 94
                Width = 473
              end
            end
            object Panel3: TPanel
              Left = 0
              Top = 132
              Width = 489
              Height = 132
              Align = alClient
              BevelOuter = bvNone
              Padding.Left = 8
              Padding.Top = 8
              Padding.Right = 8
              Padding.Bottom = 8
              ShowCaption = False
              TabOrder = 1
              ExplicitTop = 134
              ExplicitHeight = 133
              object lbAspect: TLabel
                Left = 8
                Top = 8
                Width = 473
                Height = 20
                Cursor = crHandPoint
                Margins.Left = 0
                Margins.Top = 8
                Margins.Right = 0
                Align = alTop
                Caption = #1042#1085#1077#1096#1085#1080#1081' '#1074#1080#1076' '#1090#1086#1074#1072#1088#1072
                ExplicitWidth = 146
              end
              object mmASPECT_VISUAL_DSC: TcxDBMemo
                Left = 8
                Top = 28
                TabStop = False
                Align = alClient
                DataBinding.DataField = 'ASPECT_VISUAL_DSC'
                ParentFont = False
                Properties.ReadOnly = True
                Properties.ScrollBars = ssVertical
                Style.Font.Charset = DEFAULT_CHARSET
                Style.Font.Color = clNavy
                Style.Font.Height = -13
                Style.Font.Name = 'Arial'
                Style.Font.Style = []
                Style.IsFontAssigned = True
                TabOrder = 0
                ExplicitTop = 23
                ExplicitHeight = 102
                Height = 96
                Width = 473
              end
            end
          end
          object Panel2: TPanel
            Left = 489
            Top = 0
            Width = 489
            Height = 264
            Align = alClient
            BevelOuter = bvNone
            Padding.Left = 8
            Padding.Top = 8
            Padding.Right = 8
            Padding.Bottom = 8
            ShowCaption = False
            TabOrder = 1
            ExplicitHeight = 267
            object Label8: TLabel
              Left = 8
              Top = 8
              Width = 473
              Height = 20
              Margins.Left = 0
              Margins.Top = 8
              Margins.Right = 0
              Align = alTop
              Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1081' '#1076#1083#1103' '#1080#1085#1078#1080#1085#1077#1088#1086#1074
              ExplicitWidth = 211
            end
            object mmCOMMENTS: TcxDBMemo
              Left = 8
              Top = 28
              TabStop = False
              Align = alClient
              DataBinding.DataField = 'COMMENTS'
              ParentFont = False
              Properties.ReadOnly = True
              Properties.ScrollBars = ssVertical
              Style.Font.Charset = DEFAULT_CHARSET
              Style.Font.Color = clNavy
              Style.Font.Height = -13
              Style.Font.Name = 'Arial'
              Style.Font.Style = []
              Style.IsFontAssigned = True
              TabOrder = 0
              ExplicitTop = 23
              ExplicitHeight = 236
              Height = 228
              Width = 473
            end
          end
        end
      end
      object cxTabSheet3: TcxTabSheet
        Caption = #1040#1082#1090#1099' '#1082#1086#1085#1089#1090#1072#1090#1072#1094#1080#1080' (&2)'
        ImageIndex = 2
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object cxGrid1: TcxGrid
          Left = 0
          Top = 0
          Width = 838
          Height = 270
          Align = alClient
          TabOrder = 0
          ExplicitWidth = 443
          object cxGrid1DBTableView1: TcxGridDBTableView
            DataController.DataSource = IBCDS_Incident_Act
            FilterRow.SeparatorWidth = 8
            FixedDataRows.SeparatorWidth = 8
            NewItemRow.SeparatorWidth = 8
            OptionsData.Deleting = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsSelection.CellSelect = False
            OptionsSelection.InvertSelect = False
            OptionsView.NavigatorOffset = 63
            OptionsView.ScrollBars = ssVertical
            OptionsView.ColumnAutoWidth = True
            OptionsView.FixedColumnSeparatorWidth = 3
            OptionsView.GridLineColor = 13750737
            OptionsView.GroupByBox = False
            OptionsView.Indicator = True
            Preview.LeftIndent = 25
            Preview.RightIndent = 6
            RowLayout.MinValueWidth = 100
            Styles.Header = dmAdditions.cxStyle_GridHeader
            Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
            object cxGrid1DBTable_IMG: TcxGridDBColumn
              PropertiesClassName = 'TcxImageComboBoxProperties'
              Properties.DefaultImageIndex = 22
              Properties.Images = dmAdditions.cxImageList_SWN
              Properties.Items = <>
              MinWidth = 30
              Options.HorzSizing = False
              Width = 30
            end
            object cxGrid1_ACTNO: TcxGridDBColumn
              Caption = #8470' '#1072#1082#1090#1072
              DataBinding.FieldName = 'ACTNO'
            end
            object cxGrid1_DOCID: TcxGridDBColumn
              Caption = #8470' '#1044#1086#1082#1091#1084#1077#1085#1090
              DataBinding.FieldName = 'DOCID'
            end
            object cxGrid1_INCIDENTID: TcxGridDBColumn
              Caption = #1050#1086#1076' '#1080#1085#1094#1080#1076#1077#1085#1090#1072
              DataBinding.FieldName = 'INCIDENTID'
            end
            object cxGrid1_ACCEPTED_BY_NAME: TcxGridDBColumn
              Caption = #1059#1090#1074#1077#1088#1078#1076#1077#1085
              DataBinding.FieldName = 'ACCEPTED_BY_NAME'
              Width = 229
            end
            object cxGrid1ACCEPTED_DATE: TcxGridDBColumn
              Caption = #1044#1072#1090#1072' '#1091#1090#1074#1077#1088#1078#1076'.'
              DataBinding.FieldName = 'ACCEPTED_DATE'
              Width = 82
            end
            object cxGrid1_CREATED_BY_NAME: TcxGridDBColumn
              Caption = #1057#1086#1079#1076#1072#1085
              DataBinding.FieldName = 'CREATED_BY_NAME'
              Width = 183
            end
            object cxGrid1CREATED_DATE: TcxGridDBColumn
              Caption = #1044#1072#1090#1072' '#1089#1086#1079#1076'.'
              DataBinding.FieldName = 'CREATED_DATE'
              Width = 91
            end
          end
          object cxGrid1Level1: TcxGridLevel
            GridView = cxGrid1DBTableView1
          end
        end
      end
    end
  end
  object cxSplitter: TcxSplitter
    Left = 0
    Top = 358
    Width = 986
    Height = 10
    HotZoneClassName = 'TcxMediaPlayer9Style'
    AlignSplitter = salBottom
    MinSize = 200
    Control = pnBottom
  end
  object dxBarManager: TdxBarManager
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
    ImageOptions.StretchGlyphs = False
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 360
    Top = 96
    PixelsPerInch = 120
    object dxBarManagerBar1: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Main'
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1078
      FloatTop = 0
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbIncidentDescription'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object dxBarButton1: TdxBarButton
      Caption = 'Act '#1082#1086#1085#1089#1090#1072#1090#1072#1094#1080#1080
      Category = 0
      Hint = 'Act '#1082#1086#1085#1089#1090#1072#1090#1072#1094#1080#1080
      Visible = ivAlways
      OnClick = dxBarButton1Click
    end
    object bbIncidentDescription: TdxBarButton
      Caption = #1054#1087#1080#1089#1072#1085#1080#1077' '#1080#1085#1094#1080#1076#1077#1085#1090#1072
      Category = 0
      Hint = #1054#1087#1080#1089#1072#1085#1080#1077' '#1080#1085#1094#1080#1076#1077#1085#1090#1072
      Visible = ivAlways
      ImageIndex = 16
      ShortCut = 115
      OnClick = bbIncidentDescriptionClick
    end
  end
  object dxBarPopupMenu1: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
        ItemName = 'dxBarButton1'
      end>
    UseOwnFont = False
    Left = 496
    Top = 96
    PixelsPerInch = 120
  end
  object IBC_Incident_Act: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      
        'SELECT ACTNO, DOCID, INCIDENTID, DEFICIENTA, REZOLUTIA, NOTA, DA' +
        'TE_ADITIONALE, DATE_ADITIONALE2, CREATED_BY,'
      
        '       CREATED_BY_NAME, CREATED_DATE, ACCEPTED_BY, ACCEPTED_BY_N' +
        'AME, ACCEPTED_DATE'
      'FROM VW_SC_INCIDENT_ACT')
    MasterFields = 'INCIDENTID'
    DetailFields = 'INCIDENTID'
    MasterSource = dmDB.IBCDataSourceIncidente
    Left = 460
    Top = 424
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'INCIDENTID'
        Value = nil
      end>
  end
  object IBCDS_Incident_Act: TIBCDataSource
    DataSet = IBC_Incident_Act
    Left = 380
    Top = 424
  end
end
