inherited frame36ServiceCardClient: Tframe36ServiceCardClient
  Width = 1198
  Height = 813
  object pnClientInfo: TPanel
    Left = 0
    Top = 0
    Width = 1198
    Height = 159
    Align = alTop
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 0
    ExplicitWidth = 451
    object Bevel1: TBevel
      AlignWithMargins = True
      Left = 4
      Top = 124
      Width = 1186
      Height = 31
      Margins.Left = 4
      Margins.Top = 0
      Margins.Right = 4
      Margins.Bottom = 0
      Align = alBottom
      Shape = bsTopLine
      ExplicitTop = 123
      ExplicitWidth = 970
    end
    object Label1: TLabel
      Left = 12
      Top = 12
      Width = 74
      Height = 15
      Caption = #1048#1084#1103' '#1082#1083#1080#1077#1085#1090#1072':'
    end
    object Label5: TLabel
      Left = 12
      Top = 58
      Width = 61
      Height = 15
      Caption = #1058#1077#1083#1077#1092#1086#1085#1099':'
    end
    object Label2: TLabel
      Left = 12
      Top = 37
      Width = 42
      Height = 15
      Caption = #1040#1076#1088#1077#1089#1089':'
    end
    object Label6: TLabel
      Left = 464
      Top = 36
      Width = 95
      Height = 15
      Caption = #1060#1080#1089#1082#1072#1083#1100#1085#1099#1081' '#1082#1086#1076':'
    end
    object Label7: TLabel
      Left = 464
      Top = 57
      Width = 50
      Height = 15
      Caption = #1053#1044#1057' '#1082#1086#1076':'
    end
    object Label8: TLabel
      Left = 464
      Top = 78
      Width = 130
      Height = 15
      Caption = #1044#1080#1088#1077#1082#1090#1086#1088' '#1087#1088#1077#1076#1087#1088#1080#1103#1090#1080#1103':'
    end
    object Label9: TLabel
      Left = 12
      Top = 79
      Width = 30
      Height = 15
      Caption = #1060#1072#1082#1089':'
    end
    object Label10: TLabel
      Left = 464
      Top = 99
      Width = 57
      Height = 15
      Caption = #1041#1091#1093#1075#1072#1083#1090#1077#1088':'
    end
    object Label11: TLabel
      Left = 12
      Top = 100
      Width = 43
      Height = 15
      Caption = #1045'-'#1084#1101#1081#1083':'
    end
    object Label4: TLabel
      Left = 12
      Top = 132
      Width = 86
      Height = 15
      Caption = #1057#1090#1072#1090#1091#1089' '#1082#1083#1080#1077#1085#1090#1072':'
    end
    object cxDBLabel2: TcxDBLabel
      Left = 92
      Top = 34
      DataBinding.DataField = 'ADDRESS'
      DataBinding.DataSource = IBCDataSourceCustomerInfo
      Style.TextColor = clNavy
      Height = 21
      Width = 333
    end
    object cxDBLabel3: TcxDBLabel
      Left = 92
      Top = 54
      DataBinding.DataField = 'CALC_ALL_PHONES'
      DataBinding.DataSource = IBCDataSourceCustomerInfo
      Style.TextColor = clNavy
      Height = 21
      Width = 333
    end
    object cxDBLabel4: TcxDBLabel
      Left = 92
      Top = 74
      DataBinding.DataField = 'FAX'
      DataBinding.DataSource = IBCDataSourceCustomerInfo
      Style.TextColor = clNavy
      Height = 21
      Width = 333
    end
    object cxDBLabel5: TcxDBLabel
      Left = 92
      Top = 94
      DataBinding.DataField = 'EMAIL'
      DataBinding.DataSource = IBCDataSourceCustomerInfo
      Style.TextColor = clNavy
      Height = 21
      Width = 333
    end
    object cxDBLabel6: TcxDBLabel
      Left = 600
      Top = 34
      DataBinding.DataField = 'IDEN_NUMBER'
      DataBinding.DataSource = IBCDataSourceCustomerInfo
      Style.TextColor = clMaroon
      Height = 21
      Width = 333
    end
    object cxDBLabel7: TcxDBLabel
      Left = 600
      Top = 55
      DataBinding.DataField = 'VAT_NUMBER'
      DataBinding.DataSource = IBCDataSourceCustomerInfo
      Style.TextColor = clMaroon
      Height = 21
      Width = 333
    end
    object cxDBLabel8: TcxDBLabel
      Left = 600
      Top = 76
      DataBinding.DataField = 'CHIEF'
      DataBinding.DataSource = IBCDataSourceCustomerInfo
      Style.TextColor = clMaroon
      Height = 21
      Width = 333
    end
    object cxDBLabel9: TcxDBLabel
      Left = 600
      Top = 97
      DataBinding.DataField = 'ACCOUNTANT'
      DataBinding.DataSource = IBCDataSourceCustomerInfo
      Style.TextColor = clMaroon
      Height = 21
      Width = 333
    end
    object cxDBLabel10: TcxDBLabel
      Left = 104
      Top = 130
      AutoSize = True
      DataBinding.DataField = 'CUSTOMER_STATUS_TITLE'
      DataBinding.DataSource = IBCDataSourceCustomerInfo
      Style.TextColor = clRed
    end
    object dbeCUSTOMER: TcxDBButtonEdit
      Left = 92
      Top = 9
      DataBinding.DataField = 'DISPLAYNAME'
      DataBinding.DataSource = IBCDataSourceCustomerInfo
      Properties.Buttons = <
        item
          Default = True
          Glyph.Data = {
            36050000424D3605000000000000360400002800000010000000100000000100
            08000000000000010000120B0000120B0000000100000000000000000000FFFF
            FF00FF00FF00AA878E00987D8200AD898E007B616100907676008B757500DCC5
            C500E2CECE005F5B5B00AB8B88008B747200D8BCBA009F858100B9938A00E0BD
            B300E0C0B600DCB3A000B7948100D2B19E00D2B4A400BC9A8600CEA88E00E0B8
            9E00E5BDA300E5BFA600F1E5DD00B79E8C00CCAC9300EFC9A600CEB09600CCB2
            9900E0C7AE00F5CFA400F1CFA900EFDAC200F3D2A800FFDDAA00FFE3B900FFDF
            AC00FFF7EA00FFE3B000FFE6B900FFE4B100FFF2D700FFECBF00F5EFE000FFEE
            BC00FFEFBC00F3EDDA00FFF0BD00FFF1BF00FFF1C200FFF2C000FFF3C600FFF5
            C500FFF5C900FFF6CD00FFFBE800FFF5C200FFF6C600FFF7C400FFF8CD00FFF9
            C600FFF9C700FFFCD100FFFDD100FFFFCD00FFFFD600FFFFD700FFFFD800FFFF
            D900FFFFDA00FFFFDB00FFFFDC00FFFFE500FFFFE700FFFFE800FFFFEC00FFFF
            F700FFFFF800FFFFFB00C9D0D40052B8FF0053B9FF0053B8FE0089B0CA008ECE
            FF00A5D8FF00BDE3FF008CCCFF004088DF004385D9004483D600588CCF007375
            89007376A8007979A7008B8B8E00ABABAB00A1A1A100969696008C8C8C008181
            8100777777006C6C6C0062626200575757000000000000000000000000000000
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
            000000000000000000000000000000000000000000000000000002686D6A0202
            020202020202020202026561030B6A0202020202020202020202585D62050B6A
            020202020202020202025B555E63050B6A020202020202020202025A565E6305
            0B67020202020202020202025C575F630469666B6D6D6C680202020202595760
            6408172022160D6D6802020202025A540C2439444B4C300F6D6802020202020A
            1F373F484F520133066B020202020211362D414B5053514A1D6D02020202021A
            3A273D464D504E49216D02020202021B3A2C3245474B48431E6B020202020212
            3B2E28353D423F3E146802020202020925012A2F292B34260702020202020202
            0E1C3C4031382310020202020202020202091518191368020202}
          Kind = bkGlyph
        end>
      Properties.ClickKey = 115
      Properties.ReadOnly = True
      Properties.ViewStyle = vsHideCursor
      Properties.OnButtonClick = dbeCUSTOMERPropertiesButtonClick
      Style.TextStyle = [fsBold]
      TabOrder = 9
      Width = 357
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 159
    Width = 1198
    Height = 654
    Align = alClient
    BevelOuter = bvNone
    Padding.Top = 2
    TabOrder = 5
    ExplicitWidth = 451
    ExplicitHeight = 145
    object pnIncidente: TPanel
      Left = 0
      Top = 2
      Width = 615
      Height = 652
      Margins.Left = 0
      Margins.Top = 2
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      ExplicitWidth = 692
      ExplicitHeight = 143
      object dxBarDockControl2: TdxBarDockControl
        Left = 0
        Top = 0
        Width = 615
        Height = 30
        Align = dalTop
        BarManager = dxBarManager
        SunkenBorder = True
        UseOwnSunkenBorder = True
        ExplicitWidth = 692
      end
      object cxDBTreeList: TcxDBTreeList
        Left = 0
        Top = 30
        Width = 615
        Height = 388
        Align = alClient
        Bands = <
          item
          end>
        DataController.DataSource = IBCDataSourceIncidents
        DataController.ParentField = 'PARENTID'
        DataController.KeyField = 'IID'
        OptionsBehavior.ExpandOnIncSearch = True
        OptionsBehavior.IncSearch = True
        OptionsData.Editing = False
        OptionsData.Deleting = False
        OptionsSelection.CellSelect = False
        OptionsView.ScrollBars = ssVertical
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GridLines = tlglBoth
        OptionsView.Indicator = True
        OptionsView.SimpleCustomizeBox = True
        RootValue = 0
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        Styles.ColumnHeader = dmAdditions.cxStyle_GridHeader
        TabOrder = 1
        OnDblClick = cxDBTreeListDblClick
        OnSelectionChanged = cxDBTreeListSelectionChanged
        ExplicitWidth = 692
        ExplicitHeight = 349
        object cxDBTreeListcxDBTreeListColumn1: TcxDBTreeListColumn
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taRightJustify
          Properties.Alignment.Vert = taVCenter
          Caption.AlignHorz = taCenter
          Caption.AlignVert = vaCenter
          Caption.Text = #1050#1086#1076
          DataBinding.FieldName = 'IID'
          Options.Sizing = False
          Width = 70
          Position.ColIndex = 0
          Position.RowIndex = 0
          Position.BandIndex = 0
          Summary.FooterSummaryItems = <>
          Summary.GroupFooterSummaryItems = <>
        end
        object cxDBTreeList1cxDBTreeListColumn1: TcxDBTreeListColumn
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Vert = taVCenter
          Properties.WordWrap = True
          Caption.AlignVert = vaCenter
          Caption.Text = #1058#1080#1087' '#1080#1085#1094#1080#1076#1077#1085#1090#1072
          DataBinding.FieldName = 'TYPE_TITLE'
          Options.Sizing = False
          Width = 140
          Position.ColIndex = 3
          Position.RowIndex = 0
          Position.BandIndex = 0
          Summary.FooterSummaryItems = <>
          Summary.GroupFooterSummaryItems = <>
        end
        object cxDBTreeList1cxDBTreeListColumn5: TcxDBTreeListColumn
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Vert = taVCenter
          Caption.AlignVert = vaCenter
          Caption.Text = #1057#1077#1088#1080#1081#1085#1099#1081' '#1085#1086#1084#1077#1088
          DataBinding.FieldName = 'SN'
          Options.Sizing = False
          Width = 120
          Position.ColIndex = 4
          Position.RowIndex = 0
          Position.BandIndex = 0
          Summary.FooterSummaryItems = <>
          Summary.GroupFooterSummaryItems = <>
        end
        object cxDBTreeList1cxDBTreeListColumn6: TcxDBTreeListColumn
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Vert = taVCenter
          Properties.WordWrap = True
          Caption.AlignVert = vaCenter
          Caption.Text = #1053#1072#1079#1074#1072#1085#1080#1077' '#1090#1086#1074#1072#1088#1072
          DataBinding.FieldName = 'GOODS_NAME'
          Width = 300
          Position.ColIndex = 5
          Position.RowIndex = 0
          Position.BandIndex = 0
          Summary.FooterSummaryItems = <>
          Summary.GroupFooterSummaryItems = <>
        end
        object cxDBTreeList_Col_DATA: TcxDBTreeListColumn
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taCenter
          Properties.Alignment.Vert = taVCenter
          Properties.WordWrap = True
          Caption.AlignHorz = taCenter
          Caption.AlignVert = vaCenter
          Caption.Text = #1044#1072#1090#1072
          DataBinding.FieldName = 'DATA'
          Options.Sizing = False
          Width = 80
          Position.ColIndex = 1
          Position.RowIndex = 0
          Position.BandIndex = 0
          Summary.FooterSummaryItems = <>
          Summary.GroupFooterSummaryItems = <>
          OnGetDisplayText = cxDBTreeList_Col_DATAGetDisplayText
        end
        object cxDBTreeList1cxDBTreeListColumn4: TcxDBTreeListColumn
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taCenter
          Properties.Alignment.Vert = taVCenter
          Properties.WordWrap = True
          Caption.AlignHorz = taCenter
          Caption.AlignVert = vaCenter
          Caption.Text = #1057#1090#1072#1090#1091#1089
          DataBinding.FieldName = 'STATUS_TITLE'
          Options.Sizing = False
          Width = 100
          Position.ColIndex = 6
          Position.RowIndex = 0
          Position.BandIndex = 0
          Summary.FooterSummaryItems = <>
          Summary.GroupFooterSummaryItems = <>
        end
        object cxDBTreeList_Col_PRIORITY: TcxDBTreeListColumn
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taCenter
          Visible = False
          Caption.AlignHorz = taCenter
          Caption.AlignVert = vaCenter
          Caption.Text = #1055#1088#1080#1086#1088#1080#1090#1077#1090
          DataBinding.FieldName = 'PRIORITY'
          Options.Sizing = False
          Width = 100
          Position.ColIndex = 2
          Position.RowIndex = 0
          Position.BandIndex = 0
          Summary.FooterSummaryItems = <>
          Summary.GroupFooterSummaryItems = <>
          OnGetDisplayText = cxDBTreeList_Col_PRIORITYGetDisplayText
        end
        object cxDBTreeList_Col_FLG_INCIDENT_FINISHED: TcxDBTreeListColumn
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          Caption.AlignHorz = taCenter
          Caption.AlignVert = vaCenter
          Caption.Text = #1043#1086#1090#1086#1074
          DataBinding.FieldName = 'FLG_INCIDENT_SOLVED'
          Options.Sizing = False
          Width = 50
          Position.ColIndex = 7
          Position.RowIndex = 0
          Position.BandIndex = 0
          Summary.FooterSummaryItems = <>
          Summary.GroupFooterSummaryItems = <>
        end
        object cxDBTreeList_Col_FLG_INCIDENT_CLOSED: TcxDBTreeListColumn
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          Caption.AlignHorz = taCenter
          Caption.AlignVert = vaCenter
          Caption.Text = #1047#1072#1082#1088#1099#1090
          DataBinding.FieldName = 'FLG_INCIDENT_CLOSED'
          Options.Sizing = False
          Width = 50
          Position.ColIndex = 8
          Position.RowIndex = 0
          Position.BandIndex = 0
          Summary.FooterSummaryItems = <>
          Summary.GroupFooterSummaryItems = <>
        end
        object cxDBTreeList_Col_DATA_CLOSED: TcxDBTreeListColumn
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taCenter
          Properties.Alignment.Vert = taVCenter
          Caption.AlignHorz = taCenter
          Caption.AlignVert = vaCenter
          Caption.Text = #1044#1072#1090#1072' '#1079#1072#1082#1088#1099#1090#1080#1103
          DataBinding.FieldName = 'DATA_CLOSED'
          Options.Sizing = False
          Width = 80
          Position.ColIndex = 9
          Position.RowIndex = 0
          Position.BandIndex = 0
          Summary.FooterSummaryItems = <>
          Summary.GroupFooterSummaryItems = <>
          OnGetDisplayText = cxDBTreeList_Col_DATA_CLOSEDGetDisplayText
        end
      end
      object pnIncidentInfo: TPanel
        Left = 0
        Top = 418
        Width = 615
        Height = 234
        Align = alBottom
        BevelOuter = bvNone
        Padding.Top = 4
        TabOrder = 2
        ExplicitTop = -91
        ExplicitWidth = 692
        object pcPageControlID: TPageControl
          Left = 0
          Top = 4
          Width = 615
          Height = 230
          ActivePage = TabSheet1
          Align = alClient
          TabOrder = 0
          ExplicitWidth = 692
          object TabSheet1: TTabSheet
            Caption = #1055#1086#1076#1088#1086#1073#1085#1086#1089#1090#1080
            ExplicitWidth = 684
            object Panel2: TPanel
              Left = 399
              Top = 0
              Width = 208
              Height = 200
              Align = alRight
              BevelOuter = bvNone
              Padding.Left = 2
              TabOrder = 0
              ExplicitLeft = 476
              object Label13: TLabel
                Left = 2
                Top = 0
                Width = 206
                Height = 15
                Align = alTop
                Caption = #1050#1086#1084#1087#1083#1077#1082#1090#1072#1094#1080#1103
                ExplicitWidth = 80
              end
              object clbFLAGS_COMPLECT: TcxDBCheckListBox
                Left = 2
                Top = 15
                Width = 206
                Height = 185
                TabStop = False
                Align = alClient
                DataBinding.DataSource = IBCDataSourceIncidents
                DataBinding.DataField = 'FLAGS_COMPLECT'
                IntegralHeight = True
                Items = <
                  item
                    Text = #1055#1086#1083#1085#1099#1081' '#1082#1086#1084#1087#1083#1077#1082#1090
                  end
                  item
                    Text = #1059#1087#1072#1082#1086#1074#1082#1072
                  end
                  item
                    Text = #1056#1091#1082#1086#1074#1086#1076#1089#1090#1074#1086' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
                  end
                  item
                    Text = #1052#1072#1085#1091#1072#1083
                  end
                  item
                    Text = #1050#1086#1084#1087#1072#1082#1090' '#1076#1080#1089#1082' '#1089' '#1076#1088#1072#1081#1074#1077#1088#1072#1084#1080
                  end
                  item
                    Text = #1050#1072#1073#1077#1083#1100' '#1087#1080#1090#1072#1085#1080#1103
                  end
                  item
                    Text = #1050#1072#1073#1077#1083#1100' USB'
                  end
                  item
                    Text = #1050#1072#1073#1077#1083#1080' '#1089#1086#1077#1076#1080#1085#1077#1085#1080#1103
                  end
                  item
                    Text = #1041#1083#1086#1082' '#1087#1080#1090#1072#1085#1080#1103
                  end
                  item
                    Text = #1057#1091#1084#1082#1072
                  end
                  item
                    Text = #1057#1087#1083#1080#1090#1090#1077#1088
                  end
                  item
                    Text = #1053#1072#1091#1096#1085#1080#1082#1080
                  end>
                ParentColor = False
                TabOrder = 0
              end
            end
            object Panel3: TPanel
              Left = 143
              Top = 0
              Width = 256
              Height = 200
              Align = alRight
              BevelOuter = bvNone
              Caption = 'Panel3'
              Padding.Left = 2
              Padding.Right = 2
              TabOrder = 1
              ExplicitLeft = 220
              object Label14: TLabel
                Left = 2
                Top = 0
                Width = 252
                Height = 15
                Align = alTop
                Caption = #1042#1085#1077#1096#1085#1077#1077' '#1086#1087#1080#1089#1072#1085#1080#1077
                ExplicitWidth = 106
              end
              object cxDBMemo2: TcxDBMemo
                Left = 2
                Top = 15
                TabStop = False
                Align = alClient
                DataBinding.DataField = 'EXTERNAL_DSC'
                DataBinding.DataSource = IBCDataSourceIncidents
                ParentFont = False
                Properties.ReadOnly = True
                Properties.ScrollBars = ssVertical
                Style.Font.Charset = DEFAULT_CHARSET
                Style.Font.Color = clWindowText
                Style.Font.Height = -13
                Style.Font.Name = 'Courier New'
                Style.Font.Style = []
                Style.IsFontAssigned = True
                TabOrder = 0
                Height = 185
                Width = 252
              end
            end
            object Panel4: TPanel
              Left = 0
              Top = 0
              Width = 143
              Height = 200
              Align = alClient
              BevelOuter = bvNone
              Caption = 'Panel4'
              Padding.Right = 2
              TabOrder = 2
              ExplicitWidth = 220
              object Label15: TLabel
                Left = 0
                Top = 0
                Width = 141
                Height = 15
                Align = alTop
                Caption = #1054#1087#1080#1089#1072#1085#1080#1077' '#1076#1077#1092#1077#1082#1090#1072
                ExplicitWidth = 102
              end
              object cxDBMemo1: TcxDBMemo
                Left = 0
                Top = 15
                TabStop = False
                Align = alClient
                DataBinding.DataField = 'DEFECT_DSC'
                DataBinding.DataSource = IBCDataSourceIncidents
                ParentFont = False
                Properties.ReadOnly = True
                Properties.ScrollBars = ssVertical
                Style.Font.Charset = DEFAULT_CHARSET
                Style.Font.Color = clWindowText
                Style.Font.Height = -13
                Style.Font.Name = 'Courier New'
                Style.Font.Style = []
                Style.IsFontAssigned = True
                TabOrder = 0
                ExplicitWidth = 218
                Height = 185
                Width = 141
              end
            end
          end
        end
      end
    end
    object cxSplitter: TcxSplitter
      Left = 615
      Top = 2
      Width = 8
      Height = 652
      HotZoneClassName = 'TcxMediaPlayer9Style'
      AlignSplitter = salRight
      MinSize = 400
      Control = pcPageControlIR
      ExplicitLeft = -132
      ExplicitHeight = 143
    end
    object pcPageControlIR: TPageControl
      Left = 623
      Top = 2
      Width = 575
      Height = 652
      ActivePage = tbsSales
      Align = alRight
      TabOrder = 2
      ExplicitLeft = -124
      ExplicitHeight = 143
      object tbsSales: TTabSheet
        Caption = #1055#1088#1086#1076#1072#1078#1080
        ExplicitHeight = 113
        object dxBarDockControl3: TdxBarDockControl
          Left = 0
          Top = 0
          Width = 567
          Height = 30
          Align = dalTop
          BarManager = dxBarManager
          SunkenBorder = True
          UseOwnSunkenBorder = True
        end
        object cxGridRashod: TcxGrid
          AlignWithMargins = True
          Left = 0
          Top = 30
          Width = 567
          Height = 360
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 2
          Align = alClient
          TabOrder = 1
          LookAndFeel.NativeStyle = True
          LookAndFeel.SkinName = ''
          object cxGridRashodTable: TcxGridDBTableView
            NavigatorButtons.ConfirmDelete = False
            NavigatorButtons.First.Visible = True
            NavigatorButtons.PriorPage.Visible = True
            NavigatorButtons.Prior.Visible = True
            NavigatorButtons.Next.Visible = True
            NavigatorButtons.NextPage.Visible = True
            NavigatorButtons.Last.Visible = True
            NavigatorButtons.Insert.Visible = True
            NavigatorButtons.Append.Visible = False
            NavigatorButtons.Delete.Visible = True
            NavigatorButtons.Edit.Visible = True
            NavigatorButtons.Post.Visible = True
            NavigatorButtons.Cancel.Visible = True
            NavigatorButtons.Refresh.Visible = True
            NavigatorButtons.SaveBookmark.Visible = True
            NavigatorButtons.GotoBookmark.Visible = True
            NavigatorButtons.Filter.Visible = True
            DataController.DataModeController.GridMode = True
            DataController.DataSource = IBCDataSourceDocs
            DataController.KeyFieldNames = 'DOCID'
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsBehavior.ImmediateEditor = False
            OptionsCustomize.ColumnsQuickCustomization = True
            OptionsData.Deleting = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsSelection.CellSelect = False
            OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
            OptionsView.ScrollBars = ssVertical
            OptionsView.ColumnAutoWidth = True
            OptionsView.GridLineColor = 13750737
            OptionsView.GroupByBox = False
            OptionsView.GroupRowStyle = grsOffice11
            Styles.ContentEven = dmAdditions.cxStyle_GridContentEven
            Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
            Styles.GroupByBox = dmAdditions.cxStyle_GridGroup
            Styles.Header = dmAdditions.cxStyle_GridHeader
            object cxGridRashodTableDocID: TcxGridDBColumn
              Caption = #1050#1086#1076
              DataBinding.FieldName = 'DOCID'
              Visible = False
              HeaderAlignmentHorz = taCenter
              MinWidth = 60
              Options.Filtering = False
              Options.Grouping = False
              Options.HorzSizing = False
              Width = 60
            end
            object cxGridRashodTableDocNo: TcxGridDBColumn
              Caption = #8470
              DataBinding.FieldName = 'DOCNO'
              HeaderAlignmentHorz = taCenter
              MinWidth = 60
              Options.Filtering = False
              Options.Grouping = False
              Options.HorzSizing = False
              Width = 60
            end
            object cxGridRashodTableData: TcxGridDBColumn
              Caption = #1044#1072#1090#1072
              DataBinding.FieldName = 'DATA'
              HeaderAlignmentHorz = taCenter
              MinWidth = 64
              Options.Filtering = False
              Options.Grouping = False
              Options.HorzSizing = False
            end
            object cxGridRashodTableWarehouse: TcxGridDBColumn
              Caption = #1057#1082#1083#1072#1076
              DataBinding.FieldName = 'DTDEP_NAME'
              Visible = False
              Width = 100
            end
            object cxGridRashodTableCtName: TcxGridDBColumn
              Caption = #1050#1086#1085#1090#1088#1072#1075#1077#1085#1090
              DataBinding.FieldName = 'CT_NAME'
              Styles.Content = dmAdditions.cxStyle_GridColumnBOLD
              Width = 200
            end
            object cxGridRashodTableSuma: TcxGridDBColumn
              Caption = #1057#1091#1084#1084#1072
              DataBinding.FieldName = 'SUMA'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '#,##0.00'
              HeaderAlignmentHorz = taCenter
              MinWidth = 70
              Options.Grouping = False
              Options.HorzSizing = False
              Width = 70
            end
            object cxGridRashodTableCurrencyName: TcxGridDBColumn
              Caption = #1042#1072#1083#1102#1090#1072
              DataBinding.FieldName = 'CURRENCY_NAME'
              PropertiesClassName = 'TcxLabelProperties'
              Properties.Alignment.Horz = taCenter
              Visible = False
              HeaderAlignmentHorz = taCenter
              MinWidth = 70
              Options.Filtering = False
              Options.HorzSizing = False
              Width = 70
            end
            object cxGridRashodTableVAT: TcxGridDBColumn
              Caption = #1053#1044#1057
              DataBinding.FieldName = 'VAT'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '#,##0.00'
              Visible = False
              HeaderAlignmentHorz = taCenter
              MinWidth = 70
              Options.Filtering = False
              Options.Grouping = False
              Options.HorzSizing = False
              Width = 70
            end
            object cxGridRashodTableRate: TcxGridDBColumn
              Caption = #1050#1091#1088#1089' '#1044#1086#1082'.'
              DataBinding.FieldName = 'RATE'
              Visible = False
              HeaderAlignmentHorz = taCenter
              MinWidth = 80
              Options.Grouping = False
              Options.HorzSizing = False
              Width = 80
            end
            object cxGridRashodTableParentDocID: TcxGridDBColumn
              Caption = #1050#1086#1076' '#1088#1086#1076'.'
              DataBinding.FieldName = 'PARENTDOCID'
              Visible = False
              HeaderAlignmentHorz = taCenter
              MinWidth = 70
              Options.Filtering = False
              Options.HorzSizing = False
              Width = 70
            end
            object cxGridRashodTableFlgACNT: TcxGridDBColumn
              Caption = #1041#1091#1093#1075
              DataBinding.FieldName = 'FLG_ACNT'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.ValueChecked = 1
              Properties.ValueUnchecked = 0
              HeaderAlignmentHorz = taCenter
              MinWidth = 40
              Options.Filtering = False
              Options.Grouping = False
              Options.HorzSizing = False
              Width = 40
            end
            object cxGridRashodTableCreatedBy: TcxGridDBColumn
              Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
              DataBinding.FieldName = 'CREATED_BY_NAME'
              Width = 112
            end
            object cxGridRashodTable_FLG_SHIP: TcxGridDBColumn
              Caption = #1054#1090#1075#1088#1091#1078#1077#1085
              DataBinding.FieldName = 'FLG_SHIP'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.ValueChecked = 1
              Properties.ValueUnchecked = 0
              Visible = False
              HeaderAlignmentHorz = taCenter
              MinWidth = 60
              Options.Filtering = False
              Options.HorzSizing = False
              Width = 60
            end
            object cxGridRashodTable_FLG_PROTECTED: TcxGridDBColumn
              Caption = #1047#1072#1096#1080#1097#1077#1085
              DataBinding.FieldName = 'FLG_PROTECTED'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.ValueChecked = 1
              Properties.ValueUnchecked = 0
              Visible = False
              HeaderAlignmentHorz = taCenter
              MinWidth = 60
              Options.HorzSizing = False
              Width = 60
            end
          end
          object cxGridRashodLevel: TcxGridLevel
            GridView = cxGridRashodTable
          end
        end
        object cxGridGoods: TcxGrid
          Left = 0
          Top = 392
          Width = 567
          Height = 230
          Align = alBottom
          TabOrder = 2
          LookAndFeel.NativeStyle = True
          LookAndFeel.SkinName = ''
          object cxGridGoodsTable: TcxGridDBTableView
            NavigatorButtons.ConfirmDelete = False
            NavigatorButtons.First.Visible = True
            NavigatorButtons.PriorPage.Visible = True
            NavigatorButtons.Prior.Visible = True
            NavigatorButtons.Next.Visible = True
            NavigatorButtons.NextPage.Visible = True
            NavigatorButtons.Last.Visible = True
            NavigatorButtons.Insert.Visible = True
            NavigatorButtons.Append.Visible = False
            NavigatorButtons.Delete.Visible = True
            NavigatorButtons.Edit.Visible = True
            NavigatorButtons.Post.Visible = True
            NavigatorButtons.Cancel.Visible = True
            NavigatorButtons.Refresh.Visible = True
            NavigatorButtons.SaveBookmark.Visible = True
            NavigatorButtons.GotoBookmark.Visible = True
            NavigatorButtons.Filter.Visible = True
            DataController.DataSource = IBCDataSourceJurnal
            DataController.KeyFieldNames = 'DOCID;DTDEP;CTDEP;GOODSCOMPLECT_ID;GOODSID'
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <
              item
                Format = '#,##0.00'
                Kind = skSum
                FieldName = 'SUMAVAT'
                Column = cxGridDBCol_SUMAVAT
              end>
            DataController.Summary.SummaryGroups = <>
            OptionsCustomize.ColumnsQuickCustomization = True
            OptionsData.Deleting = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsSelection.CellSelect = False
            OptionsSelection.InvertSelect = False
            OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
            OptionsView.ScrollBars = ssVertical
            OptionsView.ColumnAutoWidth = True
            OptionsView.GridLineColor = 13750737
            OptionsView.GroupByBox = False
            OptionsView.Indicator = True
            Styles.ContentEven = dmAdditions.cxStyle_GridContentEven
            Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
            Styles.Header = dmAdditions.cxStyle_GridHeader
            object cxGridDBCol_DTDEP_NAME: TcxGridDBColumn
              Caption = #1057#1082#1083#1072#1076
              DataBinding.FieldName = 'DTDEP_NAME'
              Visible = False
              MinWidth = 140
              Options.Filtering = False
              Options.HorzSizing = False
              Width = 140
            end
            object cxGridDBCol_GOODSID: TcxGridDBColumn
              Caption = #1050#1086#1076
              DataBinding.FieldName = 'GOODSID'
              FooterAlignmentHorz = taRightJustify
              HeaderAlignmentHorz = taCenter
              MinWidth = 60
              Options.Filtering = False
              Options.HorzSizing = False
              Width = 60
            end
            object cxGridDBCol_GOODS_NAME: TcxGridDBColumn
              Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
              DataBinding.FieldName = 'GOODS_NAME'
              Width = 200
            end
            object cxGridDBCol_QTY: TcxGridDBColumn
              Caption = #1050#1086#1083'-'#1074#1086
              DataBinding.FieldName = 'QTY'
              FooterAlignmentHorz = taRightJustify
              HeaderAlignmentHorz = taCenter
              MinWidth = 50
              Options.Filtering = False
              Options.Focusing = False
              Options.HorzSizing = False
              Width = 50
            end
            object cxGridDBCol_UM_NAME: TcxGridDBColumn
              Caption = #1045#1048
              DataBinding.FieldName = 'UM_NAME'
              PropertiesClassName = 'TcxLabelProperties'
              Properties.Alignment.Horz = taCenter
              Visible = False
              HeaderAlignmentHorz = taCenter
              MinWidth = 40
              Options.Filtering = False
              Options.Grouping = False
              Options.HorzSizing = False
              Options.Sorting = False
              Width = 40
            end
            object cxGridDBCol_K_UM: TcxGridDBColumn
              Caption = #1050
              DataBinding.FieldName = 'K_UM'
              PropertiesClassName = 'TcxLabelProperties'
              Properties.Alignment.Horz = taCenter
              Visible = False
              HeaderAlignmentHorz = taCenter
              MinWidth = 30
              Options.Filtering = False
              Options.HorzSizing = False
              Options.Sorting = False
              Width = 30
            end
            object cxGridDBCol_PRICE: TcxGridDBColumn
              Caption = #1062#1077#1085#1072
              DataBinding.FieldName = 'PRICE'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '#,##0.00'
              HeaderAlignmentHorz = taCenter
              MinWidth = 70
              Options.Filtering = False
              Options.HorzSizing = False
              Width = 70
            end
            object cxGridDBCol_SUMA: TcxGridDBColumn
              Caption = #1057#1091#1084#1084#1072
              DataBinding.FieldName = 'SUMA'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '#,##0.00'
              FooterAlignmentHorz = taRightJustify
              HeaderAlignmentHorz = taCenter
              MinWidth = 70
              Options.Filtering = False
              Options.HorzSizing = False
              Styles.Footer = dmAdditions.cxStyle_MoneyCounter_Total
              Width = 70
            end
            object cxGridDBCol_SUMAVAT: TcxGridDBColumn
              Caption = #1053#1044#1057
              DataBinding.FieldName = 'SUMAVAT'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '#,##0.00'
              Visible = False
              FooterAlignmentHorz = taRightJustify
              HeaderAlignmentHorz = taCenter
              MinWidth = 70
              Options.Filtering = False
              Options.HorzSizing = False
              Width = 70
            end
            object cxGridDBCol_GOODS_TYPE_ID: TcxGridDBColumn
              DataBinding.FieldName = 'GOODS_TYPE_ID'
              Visible = False
              VisibleForCustomization = False
            end
            object cxGridDBCol_FLG_ACTIVE: TcxGridDBColumn
              Caption = #1040#1082#1090#1080#1074
              DataBinding.FieldName = 'FLG_ACTIVE'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.ValueChecked = '1'
              Properties.ValueUnchecked = '0'
              Visible = False
              HeaderAlignmentHorz = taCenter
              MinWidth = 40
              Options.Filtering = False
              Options.HorzSizing = False
              Width = 40
            end
            object cxGridDBCol_FLG_READY: TcxGridDBColumn
              Caption = #1043#1086#1090#1086#1074
              DataBinding.FieldName = 'FLG_READY'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.ValueChecked = '1'
              Properties.ValueUnchecked = '0'
              Visible = False
              HeaderAlignmentHorz = taCenter
              MinWidth = 40
              Options.Filtering = False
              Options.HorzSizing = False
              Width = 40
            end
            object cxGridDBCol_STOCK_QTY: TcxGridDBColumn
              Caption = #1054#1089#1090#1072#1090#1086#1082
              DataBinding.FieldName = 'STOCK_QTY'
              Visible = False
              HeaderAlignmentHorz = taCenter
              MinWidth = 64
              Options.Filtering = False
              Options.HorzSizing = False
            end
          end
          object cxGridGoodsLevel: TcxGridLevel
            GridView = cxGridGoodsTable
          end
        end
      end
      object tbsTasks: TTabSheet
        Caption = #1047#1072#1076#1072#1095#1080
        ImageIndex = 1
        object Label12: TLabel
          AlignWithMargins = True
          Left = 0
          Top = 481
          Width = 567
          Height = 15
          Margins.Left = 0
          Margins.Top = 8
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alBottom
          Caption = #1050#1086#1084#1077#1085#1090#1072#1088#1080#1080' '#1087#1086' '#1079#1072#1076#1072#1095#1080
          ExplicitTop = -28
          ExplicitWidth = 125
        end
        object cxGridTasks: TcxGrid
          Left = 0
          Top = 0
          Width = 567
          Height = 473
          Align = alClient
          TabOrder = 0
          LookAndFeel.NativeStyle = True
          LookAndFeel.SkinName = ''
          object cxGridTasksDBTable: TcxGridDBTableView
            NavigatorButtons.ConfirmDelete = False
            NavigatorButtons.First.Visible = True
            NavigatorButtons.PriorPage.Visible = True
            NavigatorButtons.Prior.Visible = True
            NavigatorButtons.Next.Visible = True
            NavigatorButtons.NextPage.Visible = True
            NavigatorButtons.Last.Visible = True
            NavigatorButtons.Insert.Visible = True
            NavigatorButtons.Append.Visible = False
            NavigatorButtons.Delete.Visible = True
            NavigatorButtons.Edit.Visible = True
            NavigatorButtons.Post.Visible = True
            NavigatorButtons.Cancel.Visible = True
            NavigatorButtons.Refresh.Visible = True
            NavigatorButtons.SaveBookmark.Visible = True
            NavigatorButtons.GotoBookmark.Visible = True
            NavigatorButtons.Filter.Visible = True
            DataController.DataModeController.GridMode = True
            DataController.DataSource = IBCDataSourceTasks
            DataController.KeyFieldNames = 'IID;TASKID'
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsBehavior.ImmediateEditor = False
            OptionsBehavior.IncSearch = True
            OptionsCustomize.ColumnFiltering = False
            OptionsCustomize.ColumnSorting = False
            OptionsCustomize.ColumnsQuickCustomization = True
            OptionsData.Deleting = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsSelection.CellSelect = False
            OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
            OptionsView.ScrollBars = ssVertical
            OptionsView.ColumnAutoWidth = True
            OptionsView.GridLineColor = 13750737
            OptionsView.GroupByBox = False
            OptionsView.GroupRowStyle = grsOffice11
            Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
            Styles.OnGetContentStyle = cxGridTasksDBTableStylesGetContentStyle
            Styles.GroupByBox = dmAdditions.cxStyle_GridGroup
            Styles.Header = dmAdditions.cxStyle_GridHeader
            object cxGridTasksDB_DATA_ASSIGN: TcxGridDBColumn
              Caption = #1053#1072#1095#1072#1083#1086
              DataBinding.FieldName = 'DATA_ASSIGN'
              OnGetDisplayText = cxGridTasksDB_DATA_ASSIGNGetDisplayText
              MinWidth = 110
              Options.Filtering = False
              Options.HorzSizing = False
              Width = 110
            end
            object cxGridTasksDBTableColumn1: TcxGridDBColumn
              Caption = #1047#1072#1076#1072#1095#1072
              DataBinding.FieldName = 'TYPE_TITLE'
              Options.Filtering = False
            end
            object cxGridTasksDBTableColumn3: TcxGridDBColumn
              Caption = #1048#1089#1087#1086#1083#1085#1080#1090#1077#1083#1100
              DataBinding.FieldName = 'ASSIGNED_USER_NAME'
              MinWidth = 120
              Options.Filtering = False
              Options.HorzSizing = False
              Width = 120
            end
            object cxGridTasksDBTableColumn4: TcxGridDBColumn
              Caption = #1057#1090#1072#1090#1091#1089
              DataBinding.FieldName = 'STATUS_TITLE'
              MinWidth = 100
              Options.Filtering = False
              Options.HorzSizing = False
              Width = 100
            end
            object cxGridTasksDB_HC: TcxGridDBColumn
              Caption = #1050#1086#1084
              DataBinding.FieldName = 'HAS_COMMENTS'
              PropertiesClassName = 'TcxImageComboBoxProperties'
              Properties.Images = dmAdditions.cxImageList_SWN
              Properties.Items = <
                item
                  ImageIndex = 17
                  Value = 1
                end>
              MinWidth = 25
              Options.Filtering = False
              Options.Focusing = False
              Options.HorzSizing = False
              Width = 25
            end
            object cxGridTasksDB_STATUS_ID: TcxGridDBColumn
              DataBinding.FieldName = 'STATUS_ID'
              Visible = False
              VisibleForCustomization = False
            end
          end
          object cxGridTasksLevel: TcxGridLevel
            GridView = cxGridTasksDBTable
          end
        end
        object cxDBMemo3: TcxDBMemo
          Left = 0
          Top = 496
          TabStop = False
          Align = alBottom
          DataBinding.DataField = 'COMMENTS'
          DataBinding.DataSource = IBCDataSourceTaskDsc
          ParentFont = False
          Properties.ReadOnly = True
          Properties.ScrollBars = ssVertical
          Style.Font.Charset = DEFAULT_CHARSET
          Style.Font.Color = clWindowText
          Style.Font.Height = -13
          Style.Font.Name = 'Courier New'
          Style.Font.Style = []
          Style.IsFontAssigned = True
          TabOrder = 1
          Height = 126
          Width = 567
        end
      end
      object tbsProfScheduler: TTabSheet
        Caption = #1043#1088#1072#1092#1080#1082' '#1087#1088#1086#1092#1080#1083#1072#1082#1090#1080#1082#1080
        ImageIndex = 2
        ExplicitHeight = 113
        object cxGridPScheduler: TcxGrid
          Left = 0
          Top = 30
          Width = 567
          Height = 592
          Align = alClient
          TabOrder = 0
          LookAndFeel.NativeStyle = True
          LookAndFeel.SkinName = ''
          object cxGridPSchedulerDBTable: TcxGridDBTableView
            NavigatorButtons.ConfirmDelete = False
            NavigatorButtons.First.Visible = True
            NavigatorButtons.PriorPage.Visible = True
            NavigatorButtons.Prior.Visible = True
            NavigatorButtons.Next.Visible = True
            NavigatorButtons.NextPage.Visible = True
            NavigatorButtons.Last.Visible = True
            NavigatorButtons.Insert.Visible = True
            NavigatorButtons.Append.Visible = False
            NavigatorButtons.Delete.Visible = True
            NavigatorButtons.Edit.Visible = True
            NavigatorButtons.Post.Visible = True
            NavigatorButtons.Cancel.Visible = True
            NavigatorButtons.Refresh.Visible = True
            NavigatorButtons.SaveBookmark.Visible = True
            NavigatorButtons.GotoBookmark.Visible = True
            NavigatorButtons.Filter.Visible = True
            DataController.DataModeController.GridMode = True
            DataController.DataSource = IBCDataSourceScheduler
            DataController.KeyFieldNames = 'SN;DATA_CALCULATA'
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsBehavior.ImmediateEditor = False
            OptionsBehavior.IncSearch = True
            OptionsCustomize.ColumnFiltering = False
            OptionsCustomize.ColumnSorting = False
            OptionsCustomize.ColumnsQuickCustomization = True
            OptionsData.Deleting = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsSelection.InvertSelect = False
            OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
            OptionsView.ScrollBars = ssVertical
            OptionsView.ColumnAutoWidth = True
            OptionsView.GridLineColor = 13750737
            OptionsView.GroupByBox = False
            OptionsView.GroupRowStyle = grsOffice11
            Styles.ContentEven = dmAdditions.cxStyle_GridContentEven
            Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
            Styles.GroupByBox = dmAdditions.cxStyle_GridGroup
            Styles.Header = dmAdditions.cxStyle_GridHeader
            object cxGridDBColumn1: TcxGridDBColumn
              Caption = #1044#1072#1090#1072' '#1087#1088#1086#1092#1080#1083#1072#1082#1090#1080#1082#1080
              Options.Filtering = False
              Width = 140
            end
            object cxGridDBColumn2: TcxGridDBColumn
              Caption = #1054#1090#1089#1090#1091#1087', '#1076#1085#1080
              HeaderAlignmentHorz = taCenter
              MinWidth = 80
              Options.Filtering = False
              Options.HorzSizing = False
              Width = 80
            end
            object cxGridDBColumn3: TcxGridDBColumn
              Caption = #1043#1072#1088#1072#1085#1090#1080#1103
              HeaderAlignmentHorz = taCenter
              MinWidth = 80
              Options.Filtering = False
              Options.HorzSizing = False
              Width = 80
            end
            object cxGridDBColumn4: TcxGridDBColumn
              Caption = #1055#1088#1086#1092#1080#1083#1072#1082#1090#1080#1082#1072
              HeaderAlignmentHorz = taCenter
              MinWidth = 100
              Options.Filtering = False
              Width = 140
            end
          end
          object cxGridPSchedulerLevel: TcxGridLevel
            GridView = cxGridPSchedulerDBTable
          end
        end
        object dxBarDockControl1: TdxBarDockControl
          Left = 0
          Top = 0
          Width = 567
          Height = 30
          Align = dalTop
          BarManager = dxBarManager
          SunkenBorder = True
          UseOwnSunkenBorder = True
        end
      end
      object TabSheet2: TTabSheet
        Caption = #1060#1086#1090#1086#1075#1088#1072#1092#1080#1080' '#1090#1086#1074#1072#1088#1072
        ImageIndex = 3
        ExplicitHeight = 113
        object cxDBImage1: TcxDBImage
          AlignWithMargins = True
          Left = 0
          Top = 305
          Margins.Left = 0
          Margins.Top = 2
          Margins.Right = 0
          Margins.Bottom = 0
          TabStop = False
          Align = alBottom
          DataBinding.DataField = 'IMAGE'
          Properties.ReadOnly = True
          TabOrder = 0
          Height = 317
          Width = 567
        end
        object cxGridPhotos: TcxGrid
          Left = 0
          Top = 30
          Width = 567
          Height = 273
          Align = alClient
          TabOrder = 1
          object cxGridPhotosDBTable: TcxGridDBTableView
            NavigatorButtons.ConfirmDelete = False
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsCustomize.ColumnFiltering = False
            OptionsCustomize.ColumnSorting = False
            OptionsData.Deleting = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsSelection.CellSelect = False
            OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
            OptionsView.ScrollBars = ssVertical
            OptionsView.CellAutoHeight = True
            OptionsView.ColumnAutoWidth = True
            OptionsView.GridLineColor = 13750737
            OptionsView.GroupByBox = False
            OptionsView.Indicator = True
            Styles.Header = dmAdditions.cxStyle_GridHeader
            object cxGridPhotosDBTableColumn1: TcxGridDBColumn
              Caption = #1054#1087#1080#1089#1072#1085#1080#1077
              DataBinding.FieldName = 'DESCRIPTION'
            end
            object cxGridPhotosDBTableColumn2: TcxGridDBColumn
              Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
              MinWidth = 120
              Options.HorzSizing = False
              Width = 120
            end
          end
          object cxGridPhotosLevel: TcxGridLevel
            GridView = cxGridPhotosDBTable
          end
        end
        object dxBarDockControl6: TdxBarDockControl
          Left = 0
          Top = 0
          Width = 567
          Height = 30
          Align = dalTop
          BarManager = dxBarManager
          SunkenBorder = True
          UseOwnSunkenBorder = True
        end
      end
      object TabSheet3: TTabSheet
        Caption = #1047#1074#1086#1085#1082#1080' '#1082#1083#1080#1077#1085#1090#1091
        ImageIndex = 4
        ExplicitHeight = 113
        object dxBarDockControl4: TdxBarDockControl
          Left = 0
          Top = 0
          Width = 567
          Height = 30
          Align = dalTop
          BarManager = dxBarManager
          SunkenBorder = True
          UseOwnSunkenBorder = True
        end
        object cxGridCalls: TcxGrid
          Left = 0
          Top = 30
          Width = 567
          Height = 592
          Align = alClient
          TabOrder = 1
          ExplicitHeight = 83
          object cxGridCallsDBTableView: TcxGridDBTableView
            NavigatorButtons.ConfirmDelete = False
            OnFocusedRecordChanged = cxGridCallsDBTableViewFocusedRecordChanged
            DataController.DataSource = IBCDataSourceCalls
            DataController.KeyFieldNames = 'IID;CALLID'
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsCustomize.ColumnFiltering = False
            OptionsCustomize.ColumnSorting = False
            OptionsData.Deleting = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsSelection.CellSelect = False
            OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
            OptionsView.ScrollBars = ssVertical
            OptionsView.ColumnAutoWidth = True
            OptionsView.GridLineColor = 13750737
            OptionsView.GroupByBox = False
            OptionsView.Indicator = True
            Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
            Styles.Header = dmAdditions.cxStyle_GridHeader
            object cxGridCallsDB_CALL_TIME: TcxGridDBColumn
              Caption = #1042#1088#1077#1084#1103
              DataBinding.FieldName = 'CALL_TIME'
              MinWidth = 110
              Options.HorzSizing = False
              Width = 110
            end
            object cxGridCallsDB_PHONE: TcxGridDBColumn
              Caption = #1058#1077#1083#1077#1092#1086#1085
              DataBinding.FieldName = 'PHONE'
              MinWidth = 100
              Options.HorzSizing = False
              Width = 100
            end
            object cxGridCallsDB_CALL_RESULT_TEXT: TcxGridDBColumn
              Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090' '#1079#1074#1086#1085#1082#1072
              DataBinding.FieldName = 'CALL_RESULT_TEXT'
              MinWidth = 100
              Options.HorzSizing = False
              Width = 100
            end
            object cxGridCallsDB_COMMENTS: TcxGridDBColumn
              Caption = #1050#1086#1084#1077#1085#1090#1072#1088#1080#1080
              DataBinding.FieldName = 'COMMENTS'
            end
            object cxGridCallsDB_USER_FULLNAME: TcxGridDBColumn
              Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
              DataBinding.FieldName = 'USER_FULLNAME'
              Visible = False
              MinWidth = 120
              Options.HorzSizing = False
              Width = 120
            end
          end
          object cxGridCallsLevel: TcxGridLevel
            GridView = cxGridCallsDBTableView
          end
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
    CanCustomize = False
    Categories.Strings = (
      'Customer'
      'Incident')
    Categories.ItemsVisibles = (
      2
      2)
    Categories.Visibles = (
      True
      True)
    ImageOptions.Images = dmAdditions.cxImageList_SWN
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 868
    Top = 20
    DockControlHeights = (
      0
      0
      0
      0)
    object dxBarManager1Bar2: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Incidente'
      CaptionButtons = <>
      DockControl = dxBarDockControl2
      DockedDockControl = dxBarDockControl2
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 992
      FloatTop = 0
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbModifyIncidentInfo'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbCreateInitialTask'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbChangeStatus'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar3: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Docs'
      CaptionButtons = <>
      DockControl = dxBarDockControl3
      DockedDockControl = dxBarDockControl3
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 992
      FloatTop = 0
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbDocNew'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBar1: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Scheduler'
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1071
      FloatTop = 0
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarButton4'
        end
        item
          Visible = True
          ItemName = 'dxBarButton12'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBar3: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Photos'
      CaptionButtons = <>
      DockControl = dxBarDockControl6
      DockedDockControl = dxBarDockControl6
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1307
      FloatTop = 0
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarButton13'
        end
        item
          Visible = True
          ItemName = 'dxBarButton14'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton15'
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
      Caption = 'CustomerCalls'
      CaptionButtons = <>
      DockControl = dxBarDockControl4
      DockedDockControl = dxBarDockControl4
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1269
      FloatTop = 0
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbNewCall'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbModifyCall'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbRemoveCall'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object bbDocNew: TdxBarButton
      Caption = #1053#1086#1074#1099#1081' '#1088#1072#1089#1093#1086#1076' '#1085#1072' '#1089#1077#1088#1074#1080#1089
      Category = 0
      Hint = #1053#1086#1074#1099#1081' '#1088#1072#1089#1093#1086#1076' '#1085#1072' '#1089#1077#1088#1074#1080#1089
      Visible = ivAlways
      ImageIndex = 40
      OnClick = bbDocNewClick
    end
    object bbCreateInitialTask: TdxBarButton
      Caption = #1057#1086#1079#1076#1072#1090#1100' '#1079#1072#1076#1072#1095#1091
      Category = 0
      Hint = #1057#1086#1079#1076#1072#1090#1100' '#1079#1072#1076#1072#1095#1091
      Visible = ivAlways
      ImageIndex = 45
      OnClick = bbCreateInitialTaskClick
    end
    object bbChangeStatus: TdxBarButton
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1089#1090#1072#1090#1091#1089
      Category = 0
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100' '#1089#1090#1072#1090#1091#1089
      Visible = ivAlways
      ImageIndex = 25
      OnClick = bbChangeStatusClick
    end
    object dxBarButton4: TdxBarButton
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Category = 0
      Hint = #1059#1076#1072#1083#1080#1090#1100
      Visible = ivAlways
    end
    object dxBarButton12: TdxBarButton
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      Category = 0
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100
      Visible = ivAlways
    end
    object dxBarButton13: TdxBarButton
      Caption = #1053#1086#1074#1072#1103
      Category = 0
      Hint = #1053#1086#1074#1072#1103
      Visible = ivAlways
    end
    object dxBarButton14: TdxBarButton
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Category = 0
      Hint = #1059#1076#1072#1083#1080#1090#1100
      Visible = ivAlways
    end
    object dxBarButton15: TdxBarButton
      Caption = #1055#1088#1086#1089#1084#1086#1090#1088
      Category = 0
      Hint = #1055#1088#1086#1089#1084#1086#1090#1088
      Visible = ivAlways
    end
    object bbNewCall: TdxBarButton
      Caption = #1053#1086#1074#1099#1081' '#1079#1074#1086#1085#1086#1082
      Category = 0
      Hint = #1053#1086#1074#1099#1081' '#1079#1074#1086#1085#1086#1082
      Visible = ivAlways
      ImageIndex = 40
    end
    object bbModifyCall: TdxBarButton
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      Category = 0
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 41
    end
    object bbRemoveCall: TdxBarButton
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Category = 0
      Hint = #1059#1076#1072#1083#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 42
    end
    object bbModifyIncidentInfo: TdxBarButton
      Caption = #1054#1087#1080#1089#1072#1085#1080#1077' '#1080#1085#1094#1080#1076#1077#1085#1090#1072
      Category = 1
      Hint = #1054#1087#1080#1089#1072#1085#1080#1077' '#1080#1085#1094#1080#1076#1077#1085#1090#1072
      Visible = ivAlways
      ImageIndex = 41
      OnClick = bbModifyIncidentInfoClick
    end
  end
  object IBCQueryCustomerInfo: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      'SELECT'
      ' *'
      'FROM'
      ' VW_TS_CUSTOMER'
      'WHERE '
      ' (CUSTOMERID=:CustomerID)')
    OnCalcFields = IBCQueryCustomerInfoCalcFields
    Left = 940
    Top = 76
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CustomerID'
      end>
    object IBCQueryCustomerInfoCUSTOMERID: TIntegerField
      FieldName = 'CUSTOMERID'
    end
    object IBCQueryCustomerInfoPARENTID: TIntegerField
      FieldName = 'PARENTID'
    end
    object IBCQueryCustomerInfoFLG_FOLDER: TSmallintField
      FieldName = 'FLG_FOLDER'
    end
    object IBCQueryCustomerInfoPREFIXNAME: TWideStringField
      FieldName = 'PREFIXNAME'
      Size = 10
    end
    object IBCQueryCustomerInfoNAME: TWideStringField
      FieldName = 'NAME'
      Size = 255
    end
    object IBCQueryCustomerInfoSUFIXNAME: TWideStringField
      FieldName = 'SUFIXNAME'
      Size = 10
    end
    object IBCQueryCustomerInfoDISPLAYNAME: TWideStringField
      FieldName = 'DISPLAYNAME'
      Size = 277
    end
    object IBCQueryCustomerInfoORG_PARENT_ID: TIntegerField
      FieldName = 'ORG_PARENT_ID'
    end
    object IBCQueryCustomerInfoCUSTOMER_TYPE_ID: TIntegerField
      FieldName = 'CUSTOMER_TYPE_ID'
    end
    object IBCQueryCustomerInfoCUSTOMER_STATUS_ID: TIntegerField
      FieldName = 'CUSTOMER_STATUS_ID'
    end
    object IBCQueryCustomerInfoVAT: TSmallintField
      FieldName = 'VAT'
    end
    object IBCQueryCustomerInfoORDERNO: TIntegerField
      FieldName = 'ORDERNO'
    end
    object IBCQueryCustomerInfoCHIEF: TWideStringField
      FieldName = 'CHIEF'
      Size = 32
    end
    object IBCQueryCustomerInfoACCOUNTANT: TWideStringField
      FieldName = 'ACCOUNTANT'
      Size = 32
    end
    object IBCQueryCustomerInfoTELEFON1: TWideStringField
      FieldName = 'TELEFON1'
      Size = 32
    end
    object IBCQueryCustomerInfoTELEFON2: TWideStringField
      FieldName = 'TELEFON2'
      Size = 32
    end
    object IBCQueryCustomerInfoMOBILE: TWideStringField
      FieldName = 'MOBILE'
      Size = 32
    end
    object IBCQueryCustomerInfoFAX: TWideStringField
      FieldName = 'FAX'
      Size = 32
    end
    object IBCQueryCustomerInfoIDEN_NUMBER: TWideStringField
      FieldName = 'IDEN_NUMBER'
      Size = 32
    end
    object IBCQueryCustomerInfoVAT_NUMBER: TWideStringField
      FieldName = 'VAT_NUMBER'
      Size = 32
    end
    object IBCQueryCustomerInfoEMAIL: TWideStringField
      FieldName = 'EMAIL'
      Size = 32
    end
    object IBCQueryCustomerInfoADDRESS: TWideStringField
      FieldName = 'ADDRESS'
      Size = 255
    end
    object IBCQueryCustomerInfoREZIDENT: TWideStringField
      FieldName = 'REZIDENT'
      FixedChar = True
      Size = 1
    end
    object IBCQueryCustomerInfoCITY_ID: TIntegerField
      FieldName = 'CITY_ID'
    end
    object IBCQueryCustomerInfoACCOUNTNUMBER: TWideStringField
      FieldName = 'ACCOUNTNUMBER'
      Size = 32
    end
    object IBCQueryCustomerInfoPRICECOLUMN: TSmallintField
      FieldName = 'PRICECOLUMN'
    end
    object IBCQueryCustomerInfoCUSTOMER_TYPE_TITLE: TWideStringField
      FieldName = 'CUSTOMER_TYPE_TITLE'
      Size = 60
    end
    object IBCQueryCustomerInfoCUSTOMER_STATUS_TITLE: TWideStringField
      FieldName = 'CUSTOMER_STATUS_TITLE'
      Size = 60
    end
    object IBCQueryCustomerInfoCITY_TITLE: TWideStringField
      FieldName = 'CITY_TITLE'
      Size = 60
    end
    object IBCQueryCustomerInfoCALC_ALL_PHONES: TStringField
      FieldKind = fkCalculated
      FieldName = 'CALC_ALL_PHONES'
      Size = 256
      Calculated = True
    end
  end
  object IBCDataSourceCustomerInfo: TIBCDataSource
    AutoEdit = False
    DataSet = IBCQueryCustomerInfo
    Left = 804
    Top = 76
  end
  object IBCQueryIncidents: TIBCQuery
    SQLDelete.Strings = (
      'DELETE FROM VW_TDB_SC_INCIDENTE'
      'WHERE'
      '  IID = :Old_IID')
    SQLUpdate.Strings = (
      'UPDATE VW_TDB_SC_INCIDENTE'
      'SET'
      ' IID = :IID, '
      ' PARENTID = :PARENTID, '
      ' GOODS_MODEL = :GOODS_MODEL,'
      ' DEFECT_DSC = :DEFECT_DSC, '
      ' EXTERNAL_DSC = :EXTERNAL_DSC, '
      ' DATA_ESTIMATED_FINISH = :DATA_ESTIMATED_FINISH, '
      ' USERID = :USERID, '
      ' TYPE_ID = :TYPE_ID, '
      ' STATUS_ID = :STATUS_ID, '
      ' WARRANTY = :WARRANTY, '
      ' PRIORITY = :PRIORITY, '
      ' FLAGS_COMPLECT = :FLAGS_COMPLECT, '
      ' CUSTOMERID = :CUSTOMERID'
      'WHERE'
      '  IID = :Old_IID')
    SQLRefresh.Strings = (
      'SELECT '
      ' *'
      'FROM '
      ' VW_TDB_SC_INCIDENTE'
      'WHERE'
      '  IID = :IID')
    SQLLock.Strings = (
      'SELECT NULL FROM TDB_SC_INCIDENTE'
      'WHERE'
      'IID = :Old_IID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'SELECT'
      ' *'
      'FROM'
      ' VW_TDB_SC_INCIDENTE'
      'WHERE'
      
        ' (DOCID in (SELECT DOCID FROM TDB_DOCS WHERE TDB_DOCS.CT=:Custom' +
        'erID))'
      'ORDER BY'
      ' IID')
    MasterSource = IBCDataSourceCustomerInfo
    LockMode = lmLockImmediate
    RefreshOptions = [roAfterUpdate]
    OnCalcFields = IBCQueryIncidentsCalcFields
    Left = 228
    Top = 288
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CustomerID'
      end>
  end
  object IBCDataSourceIncidents: TIBCDataSource
    AutoEdit = False
    DataSet = IBCQueryIncidents
    Left = 92
    Top = 288
  end
  object IBCQueryTasks: TIBCQuery
    SQLInsert.Strings = (
      'INSERT INTO VW_TDB_SC_TASKS'
      
        '  (IID, TASKID, MASTER_USER_ID, ASSIGNED_USER_ID, DATA_ASSIGN, S' +
        'TATUS_ID, TYPE_ID)'
      'VALUES'
      
        '  (:IID, :TASKID, :MASTER_USER_ID, :ASSIGNED_USER_ID, :DATA_ASSI' +
        'GN, :STATUS_ID, :TYPE_ID)')
    SQLDelete.Strings = (
      'DELETE FROM VW_TDB_SC_TASKS'
      'WHERE'
      '  IID = :Old_IID AND TASKID = :Old_TASKID')
    SQLUpdate.Strings = (
      'UPDATE VW_TDB_SC_TASKS'
      'SET'
      
        '  IID = :IID, TASKID = :TASKID, MASTER_USER_ID = :MASTER_USER_ID' +
        ', ASSIGNED_USER_ID = :ASSIGNED_USER_ID, DATA_ASSIGN = :DATA_ASSI' +
        'GN, STATUS_ID = :STATUS_ID, TYPE_ID = :TYPE_ID'
      'WHERE'
      '  IID = :Old_IID AND TASKID = :Old_TASKID')
    SQLRefresh.Strings = (
      'SELECT'
      ' *'
      'FROM'
      ' VW_TDB_SC_TASKS'
      'WHERE'
      '  IID = :IID AND TASKID = :TASKID')
    SQLLock.Strings = (
      'SELECT NULL FROM VW_TDB_SC_TASKS'
      'WHERE'
      'IID = :Old_IID AND TASKID = :Old_TASKID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'SELECT'
      ' VW_TDB_SC_TASKS.*,'
      
        ' IIF(EXISTS(SELECT IID,TASKID FROM TDB_SC_TASK_DSC WHERE (TDB_SC' +
        '_TASK_DSC.IID=VW_TDB_SC_TASKS.IID) AND (TDB_SC_TASK_DSC.TASKID=V' +
        'W_TDB_SC_TASKS.TASKID)),1,0) HAS_COMMENTS'
      'FROM'
      ' VW_TDB_SC_TASKS'
      'ORDER BY'
      ' TASKID')
    MasterFields = 'IID'
    DetailFields = 'IID'
    MasterSource = IBCDataSourceIncidents
    RefreshOptions = [roAfterUpdate]
    Options.DetailDelay = 500
    OnCalcFields = IBCQueryIncidentsCalcFields
    Left = 1080
    Top = 248
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'IID'
      end>
  end
  object IBCDataSourceTasks: TIBCDataSource
    AutoEdit = False
    DataSet = IBCQueryTasks
    Left = 952
    Top = 248
  end
  object IBCQueryScheduler: TIBCQuery
    SQLInsert.Strings = (
      'INSERT INTO VW_TDB_SC_PROFILAXIE'
      
        '  (SN, DATA_CALCULATA, DOCID, DTDEP, CTDEP, GOODSCOMPLECT_ID, GO' +
        'ODSID, DEVIERE_ZILE, GARANTIE_RAMASA, USERID, IID)'
      'VALUES'
      
        '  (:SN, :DATA_CALCULATA, :DOCID, :DTDEP, :CTDEP, :GOODSCOMPLECT_' +
        'ID, :GOODSID, :DEVIERE_ZILE, :GARANTIE_RAMASA, :USERID, :IID)')
    SQLDelete.Strings = (
      'DELETE FROM VW_TDB_SC_PROFILAXIE'
      'WHERE'
      '  SN = :Old_SN AND DATA_CALCULATA = :Old_DATA_CALCULATA')
    SQLUpdate.Strings = (
      'UPDATE VW_TDB_SC_PROFILAXIE'
      'SET'
      
        '  SN = :SN, DATA_CALCULATA = :DATA_CALCULATA, DOCID = :DOCID, DT' +
        'DEP = :DTDEP, CTDEP = :CTDEP, GOODSCOMPLECT_ID = :GOODSCOMPLECT_' +
        'ID, GOODSID = :GOODSID, DEVIERE_ZILE = :DEVIERE_ZILE, GARANTIE_R' +
        'AMASA = :GARANTIE_RAMASA, USERID = :USERID, IID = :IID'
      'WHERE'
      '  SN = :Old_SN AND DATA_CALCULATA = :Old_DATA_CALCULATA')
    SQLRefresh.Strings = (
      'SELECT'
      ' *'
      'FROM'
      ' VW_TDB_SC_PROFILAXIE'
      'WHERE'
      '  SN = :SN AND DATA_CALCULATA = :DATA_CALCULATA')
    SQLLock.Strings = (
      'SELECT NULL FROM VW_TDB_SC_PROFILAXIE'
      'WHERE'
      'SN = :Old_SN AND DATA_CALCULATA = :Old_DATA_CALCULATA'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'SELECT'
      ' *'
      'FROM'
      ' VW_TDB_SC_PROFILAXIE'
      'ORDER BY'
      ' DATA_CALCULATA')
    MasterFields = 'IID'
    DetailFields = 'IID'
    MasterSource = IBCDataSourceIncidents
    RefreshOptions = [roAfterUpdate]
    Options.DetailDelay = 500
    OnCalcFields = IBCQueryIncidentsCalcFields
    Left = 1080
    Top = 312
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'IID'
      end>
  end
  object IBCDataSourceScheduler: TIBCDataSource
    AutoEdit = False
    DataSet = IBCQueryScheduler
    Left = 952
    Top = 312
  end
  object IBCQueryDocs: TIBCQuery
    KeyFields = 'DOCID'
    KeyGenerator = 'SQ_TDB_DOCS_DOCID'
    GeneratorMode = gmInsert
    DMLRefresh = True
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'SELECT'
      ' VW_TDB_DOCS.*'
      'FROM'
      ' VW_TDB_DOCS'
      'WHERE'
      
        ' DOCID in (SELECT DOCID FROM TDB_SC_RELATIONS WHERE TDB_SC_RELAT' +
        'IONS.IID=:IID)'
      'ORDER BY DOCID')
    MasterSource = IBCDataSourceIncidents
    AutoCommit = False
    LockMode = lmLockImmediate
    RefreshOptions = [roAfterInsert, roAfterUpdate, roBeforeEdit]
    Options.DetailDelay = 500
    Options.FullRefresh = True
    Left = 608
    Top = 304
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'IID'
      end>
  end
  object IBCDataSourceDocs: TIBCDataSource
    DataSet = IBCQueryDocs
    Left = 608
    Top = 256
  end
  object IBCQueryJurnal: TIBCQuery
    DMLRefresh = True
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'SELECT'
      ' *'
      'FROM'
      ' VW_TDB_JURNAL'
      'WHERE'
      ' GOODSCOMPLECT_ID=-1')
    MasterFields = 'DOCID'
    DetailFields = 'DOCID'
    MasterSource = IBCDataSourceDocs
    AutoCommit = False
    RefreshOptions = [roAfterInsert, roAfterUpdate, roBeforeEdit]
    Options.DetailDelay = 500
    Options.FullRefresh = True
    Left = 732
    Top = 304
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DOCID'
      end>
  end
  object IBCDataSourceJurnal: TIBCDataSource
    DataSet = IBCQueryJurnal
    Left = 732
    Top = 256
  end
  object IBCQueryTaskDsc: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'SELECT'
      ' *'
      'FROM'
      ' TDB_SC_TASK_DSC')
    MasterFields = 'IID;TASKID'
    DetailFields = 'IID;TASKID'
    MasterSource = IBCDataSourceTasks
    RefreshOptions = [roAfterUpdate]
    Options.DetailDelay = 500
    OnCalcFields = IBCQueryIncidentsCalcFields
    Left = 892
    Top = 580
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'IID'
      end
      item
        DataType = ftUnknown
        Name = 'TASKID'
      end>
  end
  object IBCDataSourceTaskDsc: TIBCDataSource
    AutoEdit = False
    DataSet = IBCQueryTaskDsc
    Left = 764
    Top = 580
  end
  object IBCQueryCalls: TIBCQuery
    KeyFields = 'CALLID'
    KeyGenerator = 'SQ_TDB_SC_INCIDENT_CALLS_ID'
    GeneratorMode = gmInsert
    SQLInsert.Strings = (
      'INSERT INTO VW_TDB_SC_INCIDENT_CALLS'
      
        '  (IID, CALLID, PHONE, CALL_TIME, PICKUP_DATE, COMMENTS, USERID,' +
        ' CALL_RESULT)'
      'VALUES'
      
        '  (:IID, :CALLID, :PHONE, :CALL_TIME, :PICKUP_DATE, :COMMENTS, :' +
        'USERID, :CALL_RESULT)')
    SQLDelete.Strings = (
      'DELETE FROM VW_TDB_SC_INCIDENT_CALLS'
      'WHERE'
      '  CALLID = :Old_CALLID')
    SQLUpdate.Strings = (
      'UPDATE VW_TDB_SC_INCIDENT_CALLS'
      'SET'
      ' IID = :IID, '
      ' CALLID = :CALLID, '
      ' PHONE = :PHONE, '
      ' CALL_TIME = :CALL_TIME, '
      ' PICKUP_DATE = :PICKUP_DATE, '
      ' COMMENTS = :COMMENTS, '
      ' USERID = :USERID, '
      ' CALL_RESULT = :CALL_RESULT'
      'WHERE'
      ' CALLID = :Old_CALLID')
    SQLRefresh.Strings = (
      'SELECT '
      ' *'
      'FROM '
      ' VW_TDB_SC_INCIDENT_CALLS'
      'WHERE'
      ' CALLID = :CALLID')
    SQLLock.Strings = (
      'SELECT NULL FROM TDB_SC_INCIDENT_CALLS'
      'WHERE'
      'CALLID = :Old_CALLID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'SELECT'
      ' *'
      'FROM'
      ' VW_TDB_SC_INCIDENT_CALLS')
    MasterFields = 'IID'
    DetailFields = 'IID'
    MasterSource = IBCDataSourceIncidents
    LockMode = lmLockImmediate
    RefreshOptions = [roAfterInsert, roAfterUpdate, roBeforeEdit]
    Options.DetailDelay = 500
    Left = 1008
    Top = 416
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'IID'
      end>
  end
  object IBCDataSourceCalls: TIBCDataSource
    AutoEdit = False
    DataSet = IBCQueryCalls
    Left = 872
    Top = 416
  end
end
