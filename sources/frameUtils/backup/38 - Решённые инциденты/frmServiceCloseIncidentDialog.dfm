object frmServiceCloseIncidentDlg: TfrmServiceCloseIncidentDlg
  Left = 0
  Top = 0
  ActiveControl = btnNext
  BorderStyle = bsDialog
  Caption = #1047#1072#1082#1088#1099#1090#1080#1077' '#1080#1085#1094#1080#1076#1077#1085#1090#1072
  ClientHeight = 558
  ClientWidth = 661
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    661
    558)
  PixelsPerInch = 96
  TextHeight = 15
  object DialogTitle1: TDialogTitle
    Left = 0
    Top = 0
    Width = 661
    Height = 64
    Title = #1047#1072#1082#1088#1099#1090#1080#1077' '#1080#1085#1094#1080#1076#1077#1085#1090#1072
    Text = #1054#1087#1083#1072#1090#1072' '#1091#1089#1083#1091#1075', '#1074#1099#1076#1072#1095#1072' '#1090#1086#1074#1072#1088#1072' '#1080' '#1079#1072#1082#1088#1099#1090#1080#1077' '#1080#1085#1094#1080#1076#1077#1085#1090#1072
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
  end
  object btnPrev: TButton
    Left = 172
    Top = 508
    Width = 112
    Height = 29
    Caption = '<< '#1055#1088#1077#1076#1099#1076#1091#1097#1072#1103
    TabOrder = 1
    OnClick = btnPrevClick
  end
  object btnCancel: TButton
    Left = 552
    Top = 508
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 2
  end
  object btnNext: TButton
    Left = 290
    Top = 508
    Width = 112
    Height = 29
    Caption = #1057#1083#1077#1076#1091#1102#1097#1072#1103' >>'
    TabOrder = 3
    OnClick = btnNextClick
  end
  object pcPageControl: TcxPageControl
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 645
    Height = 421
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    TabOrder = 4
    Properties.ActivePage = tbsCloseIncident
    Properties.CustomButtons.Buttons = <>
    Properties.HideTabs = True
    ClientRectBottom = 417
    ClientRectLeft = 4
    ClientRectRight = 641
    ClientRectTop = 4
    object tbsIncident: TcxTabSheet
      Caption = #1048#1085#1094#1080#1076#1077#1085#1090
      ImageIndex = 0
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label2: TLabel
        Left = 16
        Top = 60
        Width = 82
        Height = 15
        Caption = #1058#1080#1087' '#1080#1085#1094#1080#1076#1077#1085#1090#1072
      end
      object Label3: TLabel
        Left = 16
        Top = 89
        Width = 33
        Height = 15
        Caption = #1058#1086#1074#1072#1088
      end
      object Label4: TLabel
        Left = 16
        Top = 147
        Width = 97
        Height = 15
        Caption = #1057#1077#1088#1080#1081#1085#1099#1081' '#1085#1086#1084#1077#1088
      end
      object Label5: TLabel
        Left = 16
        Top = 118
        Width = 43
        Height = 15
        Caption = #1052#1086#1076#1077#1083#1100
      end
      object Label6: TLabel
        Left = 16
        Top = 176
        Width = 62
        Height = 15
        Caption = #1050#1086#1085#1090#1088#1072#1075#1077#1085#1090
      end
      object Label7: TLabel
        Left = 16
        Top = 237
        Width = 68
        Height = 15
        Caption = #1044#1072#1090#1072' '#1085#1072#1095#1072#1083#1086
      end
      object Label8: TLabel
        Left = 357
        Top = 233
        Width = 88
        Height = 15
        Alignment = taRightJustify
        Caption = #1044#1072#1090#1072' '#1086#1082#1086#1085#1095#1072#1085#1080#1103
      end
      object Bevel1: TBevel
        Left = 16
        Top = 216
        Width = 601
        Height = 4
        Shape = bsTopLine
      end
      object Label9: TLabel
        Left = 16
        Top = 266
        Width = 36
        Height = 15
        Caption = #1057#1090#1072#1090#1091#1089
      end
      object Label10: TLabel
        Left = 16
        Top = 295
        Width = 50
        Height = 15
        Caption = #1043#1072#1088#1072#1085#1090#1080#1103
      end
      object edTYPE_TITLE: TcxDBTextEdit
        Left = 119
        Top = 57
        TabStop = False
        DataBinding.DataField = 'TYPE_TITLE'
        DataBinding.DataSource = IBCDataSourceIncidents
        Properties.ReadOnly = True
        TabOrder = 0
        Width = 494
      end
      object edGOODS_NAME: TcxDBTextEdit
        Left = 119
        Top = 86
        TabStop = False
        DataBinding.DataField = 'GOODS_NAME'
        DataBinding.DataSource = IBCDataSourceIncidents
        Properties.ReadOnly = True
        TabOrder = 1
        Width = 494
      end
      object edSN: TcxDBTextEdit
        Left = 119
        Top = 144
        TabStop = False
        DataBinding.DataField = 'SN'
        DataBinding.DataSource = IBCDataSourceIncidents
        Properties.ReadOnly = True
        TabOrder = 2
        Width = 182
      end
      object edGOODS_MODEL: TcxDBTextEdit
        Left = 119
        Top = 115
        TabStop = False
        DataBinding.DataField = 'GOODS_MODEL'
        DataBinding.DataSource = IBCDataSourceIncidents
        Properties.ReadOnly = True
        TabOrder = 3
        Width = 494
      end
      object edCUSTOMER_FULLNAME: TcxDBTextEdit
        Left = 119
        Top = 173
        TabStop = False
        DataBinding.DataField = 'CUSTOMER_FULLNAME'
        DataBinding.DataSource = IBCDataSourceIncidents
        Properties.ReadOnly = True
        TabOrder = 4
        Width = 274
      end
      object edDATA: TcxDBTextEdit
        Left = 119
        Top = 234
        TabStop = False
        DataBinding.DataField = 'DATA'
        DataBinding.DataSource = IBCDataSourceIncidents
        Properties.ReadOnly = True
        TabOrder = 5
        Width = 166
      end
      object edDATA_FINISHED: TcxDBTextEdit
        Left = 451
        Top = 230
        TabStop = False
        DataBinding.DataField = 'DATA_FINISHED'
        DataBinding.DataSource = IBCDataSourceIncidents
        Properties.ReadOnly = True
        TabOrder = 6
        Width = 166
      end
      object edSTATUS_TITLE: TcxDBTextEdit
        Left = 119
        Top = 263
        TabStop = False
        DataBinding.DataField = 'STATUS_TITLE'
        DataBinding.DataSource = IBCDataSourceIncidents
        Properties.ReadOnly = True
        TabOrder = 7
        Width = 498
      end
      object edWARRANTY: TcxDBTextEdit
        Left = 119
        Top = 292
        TabStop = False
        DataBinding.DataField = 'WARRANTY'
        DataBinding.DataSource = IBCDataSourceIncidents
        Properties.ReadOnly = True
        TabOrder = 8
        Width = 166
      end
      object ControlGroup1: TControlGroup
        Left = 16
        Top = 16
        Width = 601
        Height = 27
        Title = #1048#1085#1094#1080#1076#1077#1085#1090
        FontTitle.Charset = DEFAULT_CHARSET
        FontTitle.Color = 10040064
        FontTitle.Height = -15
        FontTitle.Name = 'Segoe UI'
        FontTitle.Style = []
      end
    end
    object tbsGoods: TcxTabSheet
      Caption = #1058#1086#1074#1072#1088
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label18: TLabel
        Left = 16
        Top = 60
        Width = 33
        Height = 15
        Caption = #1058#1086#1074#1072#1088
      end
      object Label19: TLabel
        Left = 16
        Top = 89
        Width = 97
        Height = 15
        Caption = #1057#1077#1088#1080#1081#1085#1099#1081' '#1085#1086#1084#1077#1088
      end
      object Label20: TLabel
        Left = 16
        Top = 118
        Width = 43
        Height = 15
        Caption = #1052#1086#1076#1077#1083#1100
      end
      object Label17: TLabel
        Left = 16
        Top = 155
        Width = 74
        Height = 15
        Caption = #1042#1085#1077#1096#1085#1080#1081' '#1074#1080#1076
      end
      object Label21: TLabel
        Left = 380
        Top = 155
        Width = 83
        Height = 15
        Caption = #1050#1086#1084#1087#1083#1077#1082#1090#1072#1094#1080#1103' '
      end
      object edGOODS_NAME2: TcxDBTextEdit
        Left = 119
        Top = 57
        TabStop = False
        DataBinding.DataField = 'GOODS_NAME'
        DataBinding.DataSource = IBCDataSourceIncidents
        Properties.ReadOnly = True
        TabOrder = 0
        Width = 494
      end
      object edSN2: TcxDBTextEdit
        Left = 119
        Top = 86
        TabStop = False
        DataBinding.DataField = 'SN'
        DataBinding.DataSource = IBCDataSourceIncidents
        Properties.ReadOnly = True
        TabOrder = 1
        Width = 182
      end
      object edGOODS_MODEL2: TcxDBTextEdit
        Left = 119
        Top = 115
        TabStop = False
        DataBinding.DataField = 'GOODS_MODEL'
        DataBinding.DataSource = IBCDataSourceIncidents
        Properties.ReadOnly = True
        TabOrder = 2
        Width = 494
      end
      object mmEXTERNAL_DSC: TcxDBMemo
        Left = 16
        Top = 172
        TabStop = False
        DataBinding.DataField = 'EXTERNAL_DSC'
        DataBinding.DataSource = IBCDataSourceIncidents
        Properties.ReadOnly = True
        Properties.ScrollBars = ssVertical
        TabOrder = 3
        Height = 109
        Width = 325
      end
      object clbFLAGS_COMPLECT: TcxDBCheckListBox
        Left = 380
        Top = 172
        Width = 233
        Height = 199
        TabStop = False
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
        ReadOnly = True
        TabOrder = 4
      end
      object cbCheck_Goods: TCheckBox
        Left = 16
        Top = 380
        Width = 317
        Height = 17
        Caption = #1044#1072', '#1082#1086#1085#1090#1088#1072#1075#1077#1085#1090' '#1086#1089#1084#1086#1090#1088#1077#1083' '#1090#1086#1074#1072#1088' '#1080' '#1085#1077' '#1080#1084#1077#1077#1090' '#1087#1088#1077#1090#1077#1085#1079#1080#1081'.'
        TabOrder = 5
        OnClick = cbCheck_PrintedDocsClick
      end
      object ControlGroup2: TControlGroup
        Left = 16
        Top = 16
        Width = 601
        Height = 27
        Title = #1042#1099#1076#1072#1074#1072#1077#1084#1099#1081' '#1090#1086#1074#1072#1088
        FontTitle.Charset = DEFAULT_CHARSET
        FontTitle.Color = 10040064
        FontTitle.Height = -15
        FontTitle.Name = 'Segoe UI'
        FontTitle.Style = []
      end
    end
    object tbsRashod: TcxTabSheet
      Caption = #1056#1072#1089#1093#1086#1076#1099
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label14: TLabel
        Left = 16
        Top = 255
        Width = 46
        Height = 15
        Caption = #1056#1072#1089#1093#1086#1076#1099
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object Label15: TLabel
        Left = 184
        Top = 255
        Width = 21
        Height = 15
        Caption = #1051#1077#1081
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object Label1: TLabel
        Left = 16
        Top = 284
        Width = 73
        Height = 15
        Caption = #1047#1072#1076#1086#1083#1078#1085#1086#1089#1090#1100
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object Label11: TLabel
        Left = 184
        Top = 284
        Width = 21
        Height = 15
        Caption = #1051#1077#1081
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object Label12: TLabel
        Left = 16
        Top = 324
        Width = 84
        Height = 15
        Caption = #1048#1090#1086#1075#1086' '#1082' '#1091#1087#1083#1072#1090#1077
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label13: TLabel
        Left = 184
        Top = 324
        Width = 21
        Height = 15
        Caption = #1051#1077#1081
      end
      object Bevel2: TBevel
        Left = 16
        Top = 311
        Width = 189
        Height = 4
        Shape = bsTopLine
      end
      object cbCheck_Rashod: TCheckBox
        Left = 16
        Top = 380
        Width = 309
        Height = 17
        Caption = #1044#1072', '#1089' '#1082#1086#1085#1090#1088#1072#1075#1077#1085#1090#1072' '#1073#1099#1083#1072' '#1087#1086#1083#1091#1095#1077#1085#1085#1072' '#1074#1089#1103' '#1089#1091#1084#1084#1072' '#1076#1077#1085#1077#1075'.'
        TabOrder = 0
        OnClick = cbCheck_PrintedDocsClick
      end
      object ControlGroup3: TControlGroup
        Left = 16
        Top = 16
        Width = 603
        Height = 27
        Title = #1054#1087#1083#1072#1095#1080#1074#1072#1077#1084#1099#1077' '#1088#1072#1089#1093#1086#1076#1099
        FontTitle.Charset = DEFAULT_CHARSET
        FontTitle.Color = 10040064
        FontTitle.Height = -15
        FontTitle.Name = 'Segoe UI'
        FontTitle.Style = []
        GroupType = cgtError
      end
      object edIncidentSum: TEdit
        Left = 106
        Top = 252
        Width = 75
        Height = 23
        TabStop = False
        Alignment = taRightJustify
        AutoSelect = False
        ReadOnly = True
        TabOrder = 2
        Text = 'edIncidentSum'
      end
      object edTotalSum: TEdit
        Left = 106
        Top = 321
        Width = 75
        Height = 23
        TabStop = False
        Alignment = taRightJustify
        AutoSelect = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        TabOrder = 3
        Text = 'edIncidentSum'
      end
      object Edit1: TEdit
        Left = 106
        Top = 281
        Width = 75
        Height = 23
        TabStop = False
        Alignment = taRightJustify
        AutoSelect = False
        Enabled = False
        ReadOnly = True
        TabOrder = 4
        Text = '0.00'
      end
      object pcPageControlGoods: TPageControl
        Left = 16
        Top = 56
        Width = 603
        Height = 185
        ActivePage = tbsGoodsACNT
        TabOrder = 5
        object tbsGoodsACNT: TTabSheet
          Caption = #1058#1086#1074#1072#1088#1099' '#1076#1083#1103' '#1074#1099#1093#1086#1076#1085#1099#1093' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074
          ImageIndex = 1
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 163
          object cxGridACNT: TcxGrid
            Left = 0
            Top = 0
            Width = 595
            Height = 155
            Align = alClient
            TabOrder = 0
            LookAndFeel.NativeStyle = True
            LookAndFeel.SkinName = ''
            ExplicitLeft = -8
            ExplicitTop = -17
            ExplicitWidth = 603
            ExplicitHeight = 180
            object cxGridACNTTable: TcxGridDBTableView
              Navigator.Buttons.CustomButtons = <>
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
              DataController.DataSource = IBCDataSourceFP
              DataController.KeyFieldNames = 'GOODSID'
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <
                item
                  Format = '#,##0.00'
                  Kind = skSum
                  FieldName = 'SUMAVAT'
                end
                item
                  Format = '#,##0.00'
                  Kind = skSum
                  Column = cxGridACNTTable_SUMA
                end>
              DataController.Summary.SummaryGroups = <>
              OptionsCustomize.ColumnFiltering = False
              OptionsCustomize.ColumnGrouping = False
              OptionsData.Deleting = False
              OptionsData.Editing = False
              OptionsData.Inserting = False
              OptionsSelection.CellSelect = False
              OptionsSelection.InvertSelect = False
              OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
              OptionsView.ScrollBars = ssVertical
              OptionsView.CellAutoHeight = True
              OptionsView.ColumnAutoWidth = True
              OptionsView.Footer = True
              OptionsView.GridLineColor = 13750737
              OptionsView.GroupByBox = False
              OptionsView.Indicator = True
              Styles.Header = dmAdditions.cxStyle_GridHeader
              object cxGridACNTTable_GOODSID: TcxGridDBColumn
                Caption = #1050#1086#1076
                DataBinding.FieldName = 'GOODSID'
                MinWidth = 40
                Options.HorzSizing = False
                Width = 40
              end
              object cxGridACNTTable_NAMEACNT: TcxGridDBColumn
                Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
                DataBinding.FieldName = 'NAMEACNT'
                Width = 200
              end
              object cxGridACNTTable_QTY: TcxGridDBColumn
                Caption = #1050#1086#1083'-'#1074#1086
                DataBinding.FieldName = 'QTY'
                PropertiesClassName = 'TcxLabelProperties'
                Properties.Alignment.Horz = taCenter
                Properties.Alignment.Vert = taVCenter
                FooterAlignmentHorz = taRightJustify
                HeaderAlignmentHorz = taCenter
                MinWidth = 50
                Options.Filtering = False
                Options.Focusing = False
                Options.HorzSizing = False
                Width = 50
              end
              object cxGridACNTTable_PRICE: TcxGridDBColumn
                Caption = #1062#1077#1085#1072
                DataBinding.FieldName = 'PRICE'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.Alignment.Horz = taRightJustify
                Properties.DisplayFormat = '#,##0.00'
                HeaderAlignmentHorz = taCenter
                MinWidth = 70
                Options.Filtering = False
                Options.HorzSizing = False
                Width = 70
              end
              object cxGridACNTTable_SUMA: TcxGridDBColumn
                Caption = #1057#1091#1084#1084#1072
                DataBinding.FieldName = 'SUMA'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.Alignment.Horz = taRightJustify
                Properties.DisplayFormat = '#,##0.00'
                FooterAlignmentHorz = taRightJustify
                HeaderAlignmentHorz = taCenter
                MinWidth = 70
                Options.Filtering = False
                Options.HorzSizing = False
                Styles.Footer = dmAdditions.cxStyle_MoneyCounter_Total
                Width = 70
              end
            end
            object cxGridACNTLevel: TcxGridLevel
              GridView = cxGridACNTTable
            end
          end
        end
        object tbsGoodsJurnal: TTabSheet
          Caption = #1058#1086#1074#1072#1088#1099' '#1080#1079' '#1088#1072#1089#1093#1086#1076#1086#1074
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 163
          object cxGridGoods: TcxGrid
            Left = 0
            Top = 0
            Width = 595
            Height = 155
            Align = alClient
            TabOrder = 0
            LookAndFeel.NativeStyle = True
            LookAndFeel.SkinName = ''
            ExplicitLeft = -8
            ExplicitTop = -17
            ExplicitWidth = 603
            ExplicitHeight = 180
            object cxGridGoodsTable: TcxGridDBTableView
              Navigator.Buttons.CustomButtons = <>
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
              DataController.DataSource = IBCDataSourceJurnal
              DataController.KeyFieldNames = 'DOCID;DTDEP;CTDEP;GOODSCOMPLECT_ID;GOODSID'
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <
                item
                  Format = '#,##0.00'
                  Kind = skSum
                  FieldName = 'SUMAVAT'
                end
                item
                  Format = '#,##0.00'
                  Kind = skSum
                  Column = cxGridDBCol_SUMA
                end>
              DataController.Summary.SummaryGroups = <>
              OptionsCustomize.ColumnFiltering = False
              OptionsCustomize.ColumnGrouping = False
              OptionsData.Deleting = False
              OptionsData.Editing = False
              OptionsData.Inserting = False
              OptionsSelection.CellSelect = False
              OptionsSelection.InvertSelect = False
              OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
              OptionsView.ScrollBars = ssVertical
              OptionsView.CellAutoHeight = True
              OptionsView.ColumnAutoWidth = True
              OptionsView.Footer = True
              OptionsView.GridLineColor = 13750737
              OptionsView.GroupByBox = False
              OptionsView.Indicator = True
              Styles.Header = dmAdditions.cxStyle_GridHeader
              object cxGridDBCol_GOODSID: TcxGridDBColumn
                Caption = #1050#1086#1076
                DataBinding.FieldName = 'GOODSID'
                PropertiesClassName = 'TcxLabelProperties'
                Properties.Alignment.Horz = taRightJustify
                Properties.Alignment.Vert = taVCenter
                FooterAlignmentHorz = taRightJustify
                HeaderAlignmentHorz = taCenter
                MinWidth = 40
                Options.Filtering = False
                Options.HorzSizing = False
                Width = 40
              end
              object cxGridDBCol_GOODS_NAME: TcxGridDBColumn
                Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
                DataBinding.FieldName = 'GOODS_NAME'
                Width = 200
              end
              object cxGridDBCol_QTY: TcxGridDBColumn
                Caption = #1050#1086#1083'-'#1074#1086
                DataBinding.FieldName = 'QTY'
                PropertiesClassName = 'TcxLabelProperties'
                Properties.Alignment.Horz = taCenter
                Properties.Alignment.Vert = taVCenter
                FooterAlignmentHorz = taRightJustify
                HeaderAlignmentHorz = taCenter
                MinWidth = 50
                Options.Filtering = False
                Options.Focusing = False
                Options.HorzSizing = False
                Width = 50
              end
              object cxGridDBCol_PRICE: TcxGridDBColumn
                Caption = #1062#1077#1085#1072
                DataBinding.FieldName = 'PRICE'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.Alignment.Horz = taRightJustify
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
                Properties.Alignment.Horz = taRightJustify
                Properties.DisplayFormat = '#,##0.00'
                FooterAlignmentHorz = taRightJustify
                HeaderAlignmentHorz = taCenter
                MinWidth = 70
                Options.Filtering = False
                Options.HorzSizing = False
                Styles.Footer = dmAdditions.cxStyle_MoneyCounter_Total
                Width = 70
              end
              object cxGridDBCol_FLG_ACTIVE: TcxGridDBColumn
                Caption = #1040#1082#1090#1080#1074
                DataBinding.FieldName = 'FLG_ACTIVE'
                PropertiesClassName = 'TcxCheckBoxProperties'
                Properties.ValueChecked = '1'
                Properties.ValueUnchecked = '0'
                HeaderAlignmentHorz = taCenter
                MinWidth = 40
                Options.Filtering = False
                Options.HorzSizing = False
                Width = 40
              end
            end
            object cxGridGoodsLevel: TcxGridLevel
              GridView = cxGridGoodsTable
            end
          end
        end
      end
    end
    object tbsDocsToPrint: TcxTabSheet
      Caption = #1044#1086#1082#1091#1084#1077#1085#1090#1099
      ImageIndex = 3
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label23: TLabel
        Left = 16
        Top = 64
        Width = 62
        Height = 15
        Caption = #1050#1086#1085#1090#1088#1072#1075#1077#1085#1090
      end
      object Label24: TLabel
        Left = 16
        Top = 164
        Width = 107
        Height = 15
        Caption = #1055#1077#1095#1072#1090#1100' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074
      end
      object Label25: TLabel
        Left = 16
        Top = 93
        Width = 88
        Height = 15
        Caption = #1057#1091#1084#1084#1072' '#1082' '#1086#1087#1083#1072#1090#1077
      end
      object Label26: TLabel
        Left = 207
        Top = 93
        Width = 21
        Height = 15
        Caption = #1051#1077#1081
      end
      object lbFP_NotFound: TLabel
        Left = 440
        Top = 185
        Width = 180
        Height = 15
        Alignment = taRightJustify
        Caption = #1060#1080#1089#1082#1072#1083#1100#1085#1099#1081' '#1087#1088#1080#1085#1090#1077#1088' '#1085#1077' '#1085#1072#1081#1076#1077#1085'!'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object edCUSTOMER_FULLNAME2: TcxDBTextEdit
        Left = 126
        Top = 61
        TabStop = False
        DataBinding.DataField = 'CUSTOMER_FULLNAME'
        DataBinding.DataSource = IBCDataSourceIncidents
        Properties.ReadOnly = True
        TabOrder = 0
        Width = 494
      end
      object cbPrint_Receipt: TCheckBox
        Left = 126
        Top = 185
        Width = 119
        Height = 17
        Caption = #1060#1080#1089#1082#1072#1083#1100#1085#1099#1081' '#1095#1077#1082
        TabOrder = 1
      end
      object cbPrint_ScetFactura: TCheckBox
        Left = 126
        Top = 231
        Width = 155
        Height = 17
        Caption = #1057#1095#1077#1090'-'#1092#1072#1082#1090#1091#1088#1072
        TabOrder = 2
      end
      object cbPrint_ActVipolnihRabot: TCheckBox
        Left = 126
        Top = 208
        Width = 171
        Height = 17
        Caption = #1040#1082#1090' '#1086' '#1074#1099#1087#1086#1083#1085#1077#1085#1099#1093' '#1088#1072#1073#1086#1090#1072#1093
        TabOrder = 3
      end
      object cbCheck_PrintedDocs: TCheckBox
        Left = 16
        Top = 380
        Width = 285
        Height = 17
        Caption = #1044#1072', '#1074#1099#1073#1088#1072#1085#1085#1099' '#1074#1089#1077' '#1090#1080#1087#1099' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074' '#1076#1083#1103' '#1087#1077#1095#1072#1090#1080
        TabOrder = 4
        OnClick = cbCheck_PrintedDocsClick
      end
      object ControlGroup4: TControlGroup
        Left = 16
        Top = 16
        Width = 603
        Height = 27
        Title = #1042#1099#1093#1086#1076#1085#1099#1077' '#1076#1086#1082#1091#1084#1077#1085#1090#1099
        FontTitle.Charset = DEFAULT_CHARSET
        FontTitle.Color = 10040064
        FontTitle.Height = -15
        FontTitle.Name = 'Segoe UI'
        FontTitle.Style = []
        GroupType = cgtWarning
      end
      object edPrintTotalSum: TEdit
        Left = 126
        Top = 90
        Width = 75
        Height = 23
        TabStop = False
        Alignment = taRightJustify
        AutoSelect = False
        ReadOnly = True
        TabOrder = 6
        Text = 'edIncidentSum'
      end
    end
    object tbsCloseIncident: TcxTabSheet
      Caption = #1047#1072#1082#1088#1099#1090#1080#1077
      ImageIndex = 4
      object mmProgress: TMemo
        Left = 16
        Top = 56
        Width = 601
        Height = 333
        TabStop = False
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 0
      end
      object ControlGroup5: TControlGroup
        Left = 16
        Top = 16
        Width = 601
        Height = 27
        Title = #1047#1072#1082#1088#1099#1090#1080#1077' '#1080#1085#1094#1080#1076#1077#1085#1090#1072
        FontTitle.Charset = DEFAULT_CHARSET
        FontTitle.Color = 10040064
        FontTitle.Height = -15
        FontTitle.Name = 'Segoe UI'
        FontTitle.Style = []
        GroupType = cgtInfo
      end
    end
  end
  object btnFinish: TButton
    Left = 456
    Top = 508
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = #1043#1086#1090#1086#1074#1086
    ModalResult = 1
    TabOrder = 5
  end
  object IBCQueryIncidents: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'SELECT'
      ' VW_TDB_SC_INCIDENTE.*,'
      
        ' (SELECT DISPLAYNAME FROM TS_CUSTOMER WHERE (TS_CUSTOMER.CuSTOME' +
        'RID=VW_TDB_SC_INCIDENTE.CUSTOMERID)) CUSTOMER_FULLNAME'
      'FROM'
      ' VW_TDB_SC_INCIDENTE'
      'WHERE'
      ' IID=:IID')
    ReadOnly = True
    Constraints = <>
    Left = 444
    Top = 52
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'IID'
        Value = nil
      end>
  end
  object IBCDataSourceIncidents: TIBCDataSource
    AutoEdit = False
    DataSet = IBCQueryIncidents
    Left = 444
    Top = 4
  end
  object IBCQueryJurnal: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'SELECT'
      ' *'
      'FROM'
      ' VW_TDB_JURNAL'
      'WHERE'
      
        ' (GOODSCOMPLECT_ID=-1) AND (DOCID IN (SELECT DOCID FROM TDB_SC_R' +
        'ELATIONS WHERE IID=:IID))'
      'ORDER BY FLG_ACTIVE DESC')
    AutoCommit = False
    Options.FullRefresh = True
    Constraints = <>
    Left = 292
    Top = 176
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'IID'
        Value = nil
      end>
  end
  object IBCDataSourceJurnal: TIBCDataSource
    DataSet = IBCQueryJurnal
    Left = 292
    Top = 128
  end
  object IBCDataSourceFP: TIBCDataSource
    DataSet = IBCQueryFP
    Left = 500
    Top = 124
  end
  object IBCQueryFP: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'SELECT * FROM GET_GOODS_FOR_RECEIPT_INCIDENT(:IID)')
    AutoCommit = False
    Options.FullRefresh = True
    Constraints = <>
    Left = 500
    Top = 172
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'IID'
        Value = nil
      end>
  end
end
