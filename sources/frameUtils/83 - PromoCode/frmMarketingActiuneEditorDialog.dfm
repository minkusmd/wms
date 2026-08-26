object frmMarketingActiuneEditorDlg: TfrmMarketingActiuneEditorDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Promotie marketing'
  ClientHeight = 667
  ClientWidth = 877
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 877
    Height = 64
    Title = 'Promotie marketing'
    Text = 'Gestiunea promotiilor '
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
    ImageIndex = 28
    ExplicitLeft = -8
    ExplicitTop = -3
  end
  object pcPageControl: TcxPageControl
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 861
    Height = 541
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    TabOrder = 1
    Properties.ActivePage = tbsGeneral
    Properties.CustomButtons.Buttons = <>
    ExplicitLeft = 13
    ExplicitWidth = 875
    ClientRectBottom = 537
    ClientRectLeft = 4
    ClientRectRight = 857
    ClientRectTop = 26
    object tbsGeneral: TcxTabSheet
      Caption = 'Promotie'
      ImageIndex = 0
      ExplicitLeft = 5
      ExplicitTop = 27
      object Label1: TLabel
        Left = 16
        Top = 44
        Width = 56
        Height = 15
        Caption = 'Denumire'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label2: TLabel
        Left = 16
        Top = 96
        Width = 54
        Height = 15
        Caption = 'Descriere'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label3: TLabel
        Left = 552
        Top = 38
        Width = 91
        Height = 15
        Caption = 'Perioada actiunii'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label4: TLabel
        Left = 552
        Top = 98
        Width = 89
        Height = 15
        Caption = 'Zilele saptaminii'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label16: TLabel
        Left = 552
        Top = 233
        Width = 127
        Height = 15
        Caption = 'Analitica documentului'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label17: TLabel
        Left = 552
        Top = 293
        Width = 181
        Height = 15
        Caption = 'Actiunea este disponibila pentru '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label18: TLabel
        Left = 552
        Top = 397
        Width = 115
        Height = 15
        Caption = 'Actiuni suplimentare'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label23: TLabel
        Left = 16
        Top = 180
        Width = 80
        Height = 15
        Caption = 'Tipul reducerii'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object deSTART_DATE: TcxDBDateEdit
        Left = 552
        Top = 59
        DataBinding.DataField = 'START_DATE'
        Properties.DateButtons = [btnToday]
        Properties.SaveTime = False
        Properties.ShowTime = False
        Properties.WeekNumbers = True
        TabOrder = 1
        Width = 121
      end
      object edTITLE: TcxDBTextEdit
        Left = 16
        Top = 61
        DataBinding.DataField = 'TITLE'
        TabOrder = 3
        Width = 489
      end
      object mmDESCRIPTION: TcxDBMemo
        Left = 16
        Top = 113
        DataBinding.DataField = 'DESCRIPTION'
        Properties.ScrollBars = ssVertical
        Properties.VisibleLineCount = 3
        TabOrder = 4
        Width = 489
      end
      object deEND_DATE: TcxDBDateEdit
        Left = 696
        Top = 59
        DataBinding.DataField = 'END_DATE'
        Properties.DateButtons = [btnToday]
        Properties.SaveTime = False
        Properties.ShowTime = False
        Properties.WeekNumbers = True
        TabOrder = 2
        Width = 121
      end
      object clbWEEK_DAYS: TcxDBCheckListBox
        Left = 552
        Top = 115
        Width = 121
        Height = 109
        DataBinding.DataField = 'WEEK_DAYS'
        Items = <
          item
            Tag = 1
            Text = 'Luni'
          end
          item
            Tag = 2
            Text = 'Marti'
          end
          item
            Tag = 4
            Text = 'Miercuri'
          end
          item
            Tag = 8
            Text = 'Joi'
          end
          item
            Tag = 16
            Text = 'Vineri'
          end
          item
            Tag = 32
            Text = 'Simbata'
          end
          item
            Tag = 64
            Text = 'Duminica'
          end>
        ParentColor = False
        TabOrder = 5
      end
      object cbFLG_ENABLED: TcxDBCheckBox
        Left = 15
        Top = 11
        Caption = 'Promotie activa'
        DataBinding.DataField = 'FLG_ENABLED'
        ParentFont = False
        Properties.Alignment = taLeftJustify
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -12
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = [fsBold]
        Style.IsFontAssigned = True
        TabOrder = 0
      end
      object lcbAnalytics: TcxDBLookupComboBox
        Left = 552
        Top = 250
        DataBinding.DataField = 'ANALITICA_ID'
        ParentShowHint = False
        Properties.DropDownAutoSize = True
        Properties.DropDownListStyle = lsFixedList
        Properties.DropDownRows = 16
        Properties.KeyFieldNames = 'ANALITICAID'
        Properties.ListColumns = <
          item
            Fixed = True
            Width = 180
            FieldName = 'TITLE'
          end
          item
            Fixed = True
            Width = 180
            FieldName = 'PARENT_TITLE'
          end>
        Properties.ListOptions.ShowHeader = False
        Properties.ListSource = dmDB.IBCDataSourceAnalytics
        ShowHint = True
        TabOrder = 8
        Width = 265
      end
      object cbFLG_CLIENT: TcxDBCheckBox
        Left = 568
        Top = 314
        Caption = 'Clienti ordinari'
        DataBinding.DataField = 'FLG_CLIENT'
        Properties.Alignment = taLeftJustify
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        TabOrder = 9
      end
      object cbFLG_CLIENT_CARD: TcxDBCheckBox
        Left = 568
        Top = 335
        Caption = 'Clienti cu cartele de discount'
        DataBinding.DataField = 'FLG_CLIENT_CARD'
        Properties.Alignment = taLeftJustify
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        TabOrder = 10
      end
      object cbFLG_CLIENT_DEALER: TcxDBCheckBox
        Left = 568
        Top = 357
        Caption = 'Dileri'
        DataBinding.DataField = 'FLG_CLIENT_DEALER'
        Properties.Alignment = taLeftJustify
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        TabOrder = 11
      end
      object cbFLG_POST_RC: TcxDBCheckBox
        Left = 569
        Top = 418
        Caption = 'Participa in actiune cumulativa a reducerilor'
        DataBinding.DataField = 'FLG_POST_RC'
        Enabled = False
        Properties.Alignment = taLeftJustify
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        TabOrder = 12
      end
      object cxPageControl2: TcxPageControl
        Left = 16
        Top = 250
        Width = 489
        Height = 247
        TabOrder = 7
        Properties.ActivePage = cxTabSheet7
        Properties.CustomButtons.Buttons = <>
        ClientRectBottom = 243
        ClientRectLeft = 4
        ClientRectRight = 485
        ClientRectTop = 26
        object tbsDiscount: TcxTabSheet
          Caption = 'Reducere, %'
          ImageIndex = 0
          ExplicitHeight = 163
          object Label19: TLabel
            Left = 16
            Top = 12
            Width = 65
            Height = 15
            Caption = 'Reducere, %'
          end
          object ceDISCOUNT: TcxDBCalcEdit
            Left = 16
            Top = 33
            DataBinding.DataField = 'DISCOUNT'
            TabOrder = 0
            Width = 121
          end
        end
        object tbsFixedAmount: TcxTabSheet
          Caption = 'Suma reducerii'
          ImageIndex = 1
          ExplicitHeight = 163
          object Label24: TLabel
            Left = 17
            Top = 12
            Width = 52
            Height = 15
            Caption = 'Suma fixa'
          end
          object Label25: TLabel
            Left = 162
            Top = 12
            Width = 32
            Height = 15
            Caption = 'Valuta'
          end
          object ceDiscountAmount: TcxDBCalcEdit
            Left = 17
            Top = 33
            DataBinding.DataField = 'DISCOUNT_AMOUNT'
            TabOrder = 0
            Width = 121
          end
          object ceCurrency: TcxButtonEdit
            Left = 162
            Top = 33
            Properties.Buttons = <
              item
                Default = True
                Kind = bkEllipsis
              end>
            TabOrder = 1
            Text = 'ceCurrency'
            Width = 71
          end
        end
        object tbsGoods: TcxTabSheet
          Caption = 'Lista produse'
          ImageIndex = 2
          ExplicitHeight = 163
          object cxGrid2: TcxGrid
            Left = 0
            Top = 28
            Width = 481
            Height = 189
            Align = alClient
            TabOrder = 1
            ExplicitHeight = 135
            object cxGrid2DBTableView1: TcxGridDBTableView
              Navigator.Buttons.CustomButtons = <>
              ScrollbarAnnotations.CustomAnnotations = <>
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              OptionsView.ColumnAutoWidth = True
              OptionsView.GroupByBox = False
              object cxGrid2DBTableView1Column1: TcxGridDBColumn
                Caption = 'Cod'
                HeaderAlignmentHorz = taCenter
              end
              object cxGrid2DBTableView1Column2: TcxGridDBColumn
                Caption = 'Produs'
                HeaderAlignmentHorz = taCenter
                Width = 396
              end
              object cxGrid2DBTableView1Column3: TcxGridDBColumn
                Caption = 'Cant'
                HeaderAlignmentHorz = taCenter
              end
              object cxGrid2DBTableView1Column4: TcxGridDBColumn
                Caption = 'Suma'
                HeaderAlignmentHorz = taCenter
              end
            end
            object cxGrid2Level1: TcxGridLevel
              GridView = cxGrid2DBTableView1
            end
          end
          object dxBarDockControl3: TdxBarDockControl
            Left = 0
            Top = 0
            Width = 481
            Height = 28
            Align = dalTop
            BarManager = dxBarManager1
          end
        end
        object cxTabSheet7: TcxTabSheet
          Caption = 'Cashback'
          ImageIndex = 3
          ExplicitLeft = 5
          ExplicitTop = 27
          object Label10: TLabel
            Left = 47
            Top = 112
            Width = 229
            Height = 15
            Caption = 'fac parte din urmatoarele grupe de produse'
          end
          object Label26: TLabel
            Left = 47
            Top = 161
            Width = 394
            Height = 26
            Caption = 
              #1045#1089#1083#1080' '#1085#1077' '#1091#1082#1072#1079#1072#1085#1085#1072' '#1090#1086#1074#1072#1088#1085#1072#1103' '#1075#1088#1091#1087#1087#1072' '#1072#1082#1094#1080#1080', '#1090#1086' '#1072#1082#1094#1080#1103' '#1088#1072#1089#1087#1088#1086#1089#1090#1072#1085#1103#1077#1090#1089#1103 +
              ' '#1085#1072' '#1074#1089#1077' '#1090#1086#1074#1072#1088#1099'.'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGrayText
            Font.Height = -11
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
            WordWrap = True
          end
          object cxLabel1: TcxLabel
            Left = 19
            Top = 15
            Caption = 'Valoarea in % a cashback-lui'
            Transparent = True
          end
          object cxDBCalcEdit1: TcxDBCalcEdit
            Left = 19
            Top = 40
            DataBinding.DataField = 'DISCOUNT'
            Properties.Alignment.Horz = taRightJustify
            TabOrder = 1
            Width = 86
          end
          object cbCashback: TcxDBCheckBox
            Left = 19
            Top = 87
            Caption = 'Excludemi grupepe pentru cashback '
            DataBinding.DataField = 'FLG_CASHBACK'
            Properties.Alignment = taLeftJustify
            Properties.ValueChecked = 1
            Properties.ValueUnchecked = 0
            Style.TextStyle = [fsBold]
            Style.TransparentBorder = False
            TabOrder = 2
          end
          object beCashback: TcxButtonEdit
            Left = 47
            Top = 129
            Properties.Buttons = <
              item
                Default = True
                ImageIndex = 13
                Kind = bkGlyph
              end
              item
                ImageIndex = 35
                Kind = bkGlyph
              end>
            Properties.ClickKey = 115
            Properties.Images = dmAdditions.cxImageList_SWN
            Properties.ViewStyle = vsHideCursor
            Properties.OnButtonClick = beCashbackPropertiesButtonClick
            Style.TextColor = clNavy
            TabOrder = 3
            Width = 394
          end
        end
        object cxTabSheet8: TcxTabSheet
          Caption = 'Promo Cod'
          ImageIndex = 4
          ExplicitHeight = 163
        end
      end
      object cbDiscount: TcxDBLookupComboBox
        Left = 20
        Top = 201
        DataBinding.DataField = 'DISCOUNT_TYPE'
        Properties.DropDownListStyle = lsFixedList
        Properties.KeyFieldNames = 'DISCOUNT_TYPE'
        Properties.ListColumns = <
          item
            FieldName = 'DISCOUNT_GROUP'
          end>
        Properties.ListOptions.ShowHeader = False
        Properties.ListSource = IBCDataSourceDiscountType
        Properties.OnChange = cbDiscountPropertiesChange
        TabOrder = 6
        Width = 481
      end
    end
    object cxTabSheet2: TcxTabSheet
      Caption = 'Produsele din promotie'
      ImageIndex = 3
      ExplicitLeft = 5
      ExplicitTop = 27
      ExplicitWidth = 867
      object Label21: TLabel
        Left = 20
        Top = 12
        Width = 156
        Height = 15
        Caption = 'Lista produselor din promotie'
      end
      object Label22: TLabel
        Left = 20
        Top = 65
        Width = 447
        Height = 13
        Caption = 
          #1045#1089#1083#1080' '#1085#1077' '#1091#1082#1072#1079#1072#1085#1085#1072' '#1090#1086#1074#1072#1088#1085#1072#1103' '#1075#1088#1091#1087#1087#1072' '#1072#1082#1094#1080#1080', '#1090#1086' '#1072#1082#1094#1080#1103' '#1088#1072#1089#1087#1088#1086#1089#1090#1072#1085#1103#1077#1090#1089#1103 +
          ' '#1085#1072' '#1074#1089#1077' '#1090#1086#1074#1072#1088#1099'.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGrayText
        Font.Height = -11
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object bePROMO_GOODS_GROUP_ID: TcxButtonEdit
        Left = 20
        Top = 33
        Properties.Buttons = <
          item
            Default = True
            ImageIndex = 13
            Kind = bkGlyph
          end
          item
            ImageIndex = 35
            Kind = bkGlyph
          end>
        Properties.ClickKey = 115
        Properties.Images = dmAdditions.cxImageList_SWN
        Properties.ViewStyle = vsHideCursor
        Properties.OnButtonClick = cxButtonEdit1PropertiesButtonClick
        Style.TextColor = clNavy
        TabOrder = 0
        Width = 489
      end
    end
    object tbsTriggers: TcxTabSheet
      Caption = 'Triger-e'
      ImageIndex = 1
      ExplicitWidth = 867
      object cxPageControl1: TcxPageControl
        Left = 0
        Top = 0
        Width = 853
        Height = 511
        Align = alClient
        TabOrder = 0
        Properties.ActivePage = tbsCashback
        Properties.CustomButtons.Buttons = <>
        ExplicitWidth = 867
        ClientRectBottom = 507
        ClientRectLeft = 4
        ClientRectRight = 849
        ClientRectTop = 26
        object cxTabSheet3: TcxTabSheet
          Caption = 'Cantitatea produselor diferite'
          ImageIndex = 0
          ExplicitLeft = 5
          ExplicitTop = 27
          ExplicitWidth = 859
          object Label5: TLabel
            Left = 48
            Top = 45
            Width = 114
            Height = 15
            Caption = 'Cantitatea produselor'
          end
          object Label7: TLabel
            Left = 48
            Top = 94
            Width = 437
            Height = 39
            Caption = 
              #1040#1082#1094#1080#1103' '#1085#1072#1089#1090#1091#1087#1072#1077#1090' '#1074' '#1090#1086#1084' '#1089#1083#1091#1095#1072#1077', '#1077#1089#1083#1080' '#1082#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1088#1072#1079#1085#1099#1093' '#1090#1086#1074#1072#1088#1086#1072' '#1095#1077#1082 +
              #1072', '#1082#1086#1090#1086#1088#1099#1077' '#1074#1093#1086#1076#1103#1090' '#1074' '#1091#1082#1072#1079#1072#1085#1085#1091#1102' '#1075#1088#1091#1087#1087#1091' ('#1077#1089#1083#1080' '#1085#1077' '#1091#1082#1072#1079#1072#1085#1072', '#1090#1086' '#1083#1102#1073#1099#1093')' +
              ', '#1074' '#1088#1077#1072#1083#1080#1079#1072#1094#1080#1080' '#1073#1086#1083#1100#1096#1077' '#1080#1083#1080' '#1088#1072#1074#1085#1086' '#1091#1082#1072#1079#1072#1085#1085#1086#1084#1091' '#1082#1086#1083#1080#1095#1077#1089#1090#1074#1091'.'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGrayText
            Font.Height = -11
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
            WordWrap = True
          end
          object Label6: TLabel
            Left = 236
            Top = 45
            Width = 102
            Height = 15
            Caption = 'Fac parte din grupa'
          end
          object cbFLG_DIST_CNT: TcxDBCheckBox
            Left = 16
            Top = 16
            Caption = 'Cantitatea produselor'
            DataBinding.DataField = 'FLG_DIST_CNT'
            Properties.Alignment = taLeftJustify
            Properties.ValueChecked = 1
            Properties.ValueUnchecked = 0
            Style.TextStyle = [fsBold]
            TabOrder = 0
          end
          object ceDIST_CNT_VALUE: TcxDBCalcEdit
            Left = 48
            Top = 62
            DataBinding.DataField = 'DIST_CNT_VALUE'
            Properties.Nullstring = '0'
            TabOrder = 1
            Width = 121
          end
          object beDIST_CNT_GROUP_ID: TcxButtonEdit
            Left = 236
            Top = 62
            Properties.Buttons = <
              item
                Default = True
                ImageIndex = 13
                Kind = bkGlyph
              end
              item
                ImageIndex = 35
                Kind = bkGlyph
              end>
            Properties.ClickKey = 115
            Properties.Images = dmAdditions.cxImageList_SWN
            Properties.ViewStyle = vsHideCursor
            Properties.OnButtonClick = beDIST_CNT_GROUP_IDPropertiesButtonClick
            Style.TextColor = clNavy
            TabOrder = 2
            Width = 394
          end
        end
        object cxTabSheet4: TcxTabSheet
          Caption = 'Cantitatea produselor unice'
          ImageIndex = 1
          ExplicitLeft = 5
          ExplicitTop = 27
          ExplicitWidth = 859
          object Label8: TLabel
            Left = 130
            Top = 32
            Width = 431
            Height = 33
            Caption = 
              #1040#1082#1094#1080#1103' '#1085#1072' '#1090#1086#1074#1072#1088' '#1085#1072#1089#1090#1091#1087#1072#1077#1090' '#1074' '#1090#1086#1084' '#1089#1083#1091#1095#1072#1077', '#1077#1089#1083#1080' '#1082#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1077#1076#1080#1085#1080#1094' '#1076#1072 +
              #1085#1085#1086#1075#1086' '#1072#1082#1094#1080#1086#1085#1085#1086#1075#1086' '#1090#1086#1074#1072#1088#1072' '#1073#1086#1083#1100#1096#1077' '#1080#1083#1080' '#1088#1072#1074#1085#1086' '#1091#1082#1072#1079#1072#1085#1085#1086#1084#1091' '#1074#1099#1096#1077' '#1082#1086#1083#1080#1095#1077#1089 +
              #1090#1074#1091'.'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGrayText
            Font.Height = -11
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
            WordWrap = True
          end
          object cbFLG_SINGLE_QTY: TcxDBCheckBox
            Left = 3
            Top = 3
            Caption = 'Cantitatea produselor unice'
            DataBinding.DataField = 'FLG_SINGLE_QTY'
            Properties.Alignment = taLeftJustify
            Properties.ValueChecked = 1
            Properties.ValueUnchecked = 0
            Style.TextStyle = [fsBold]
            TabOrder = 0
          end
          object ceSINGLE_QTY_VALUE: TcxDBCalcEdit
            Left = 3
            Top = 32
            DataBinding.DataField = 'SINGLE_QTY_VALUE'
            Properties.Nullstring = '0'
            TabOrder = 1
            Width = 121
          end
          object Panel1: TPanel
            Left = 3
            Top = 112
            Width = 270
            Height = 337
            BevelOuter = bvNone
            TabOrder = 3
            object dxBarDockControl1: TdxBarDockControl
              Left = 0
              Top = 0
              Width = 270
              Height = 24
              Align = dalTop
              BarManager = dxBarManager1
              ExplicitTop = -6
            end
            object cxGrid1: TcxGrid
              Left = 0
              Top = 24
              Width = 265
              Height = 313
              Align = alLeft
              TabOrder = 1
              ExplicitTop = 28
              ExplicitHeight = 309
              object cxGrid1DBTableView1: TcxGridDBTableView
                Navigator.Buttons.CustomButtons = <>
                ScrollbarAnnotations.CustomAnnotations = <>
                DataController.Summary.DefaultGroupSummaryItems = <>
                DataController.Summary.FooterSummaryItems = <>
                DataController.Summary.SummaryGroups = <>
                OptionsView.ColumnAutoWidth = True
                OptionsView.GroupByBox = False
                object cxGrid1DBTableView1_QTY: TcxGridDBColumn
                  Caption = 'Cant'
                end
                object cxGrid1DBTableView1_DiscountPercent: TcxGridDBColumn
                  Caption = 'Percent'
                end
                object cxGrid1DBTableView1_DiscountValue: TcxGridDBColumn
                  Caption = 'Value'
                end
              end
              object cxGrid1Level1: TcxGridLevel
                GridView = cxGrid1DBTableView1
              end
            end
          end
          object cbFLG_Qty_Discount: TcxDBCheckBox
            Left = 3
            Top = 91
            Caption = 
              'Reducerea separata pentru fiecare produs in functie de cantitate' +
              ' / '#1054#1090#1076#1077#1083#1100#1085#1072#1103' '#1089#1082#1080#1076#1082#1072' '#1085#1072' '#1082#1072#1078#1076#1099#1081' '#1090#1086#1074#1072#1088
            DataBinding.DataField = 'FLG_SINGLE_QTY'
            Properties.Alignment = taLeftJustify
            Properties.ValueChecked = 1
            Properties.ValueUnchecked = 0
            Style.TextStyle = [fsBold]
            TabOrder = 2
          end
        end
        object cxTabSheet5: TcxTabSheet
          Caption = 'Cantitatea produselor total in vinzare'
          ImageIndex = 2
          ExplicitLeft = 3
          ExplicitTop = 27
          ExplicitWidth = 859
          object Label12: TLabel
            Left = 27
            Top = 73
            Width = 420
            Height = 39
            Caption = 
              #1040#1082#1094#1080#1103' '#1085#1072#1089#1090#1091#1087#1072#1077#1090' '#1074' '#1090#1086#1084' '#1089#1083#1091#1095#1072#1077', '#1077#1089#1083#1080' '#1086#1073#1097#1077#1077' '#1082#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1090#1086#1074#1072#1088#1086#1074' '#1074' '#1088#1077 +
              #1072#1083#1080#1079#1072#1094#1080#1080', '#1082#1086#1090#1086#1088#1099#1077' '#1074#1093#1086#1076#1103#1090' '#1074' '#1091#1082#1072#1079#1072#1085#1085#1091#1102' '#1090#1086#1074#1072#1088#1085#1091#1102' '#1075#1088#1091#1087#1087#1091' ('#1077#1089#1083#1080' '#1085#1077' '#1091#1082 +
              #1072#1079#1072#1085#1072', '#1090#1086' '#1083#1102#1073#1099#1093'), '#1074' '#1088#1077#1072#1083#1080#1079#1072#1094#1080#1080' '#1073#1086#1083#1100#1096#1077' '#1080#1083#1080' '#1088#1072#1074#1085#1086' '#1091#1082#1072#1079#1072#1085#1085#1086#1084#1091' '#1074#1099#1096#1077' ' +
              #1082#1086#1083#1080#1095#1077#1089#1090#1074#1091'.'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGrayText
            Font.Height = -11
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
            WordWrap = True
          end
          object Label11: TLabel
            Left = 215
            Top = 20
            Width = 102
            Height = 15
            Caption = 'Fac parte din grupa'
          end
          object Label9: TLabel
            Left = 35
            Top = 24
            Width = 114
            Height = 15
            Caption = 'Cantitatea produselor'
          end
          object cbFLG_TOTAL_QTY: TcxDBCheckBox
            Left = 0
            Top = 3
            Caption = 'Cantitatea produselor total in vinzare'
            DataBinding.DataField = 'FLG_TOTAL_QTY'
            Properties.Alignment = taLeftJustify
            Properties.ValueChecked = 1
            Properties.ValueUnchecked = 0
            Style.TextStyle = [fsBold]
            TabOrder = 0
          end
          object ceTOTAL_QTY_VALUE: TcxDBCalcEdit
            Left = 35
            Top = 41
            DataBinding.DataField = 'TOTAL_QTY_VALUE'
            Properties.Nullstring = '0'
            TabOrder = 1
            Width = 121
          end
          object beTOTAL_QTY_GROUP_ID: TcxButtonEdit
            Left = 215
            Top = 41
            Properties.Buttons = <
              item
                Default = True
                ImageIndex = 13
                Kind = bkGlyph
              end
              item
                ImageIndex = 35
                Kind = bkGlyph
              end>
            Properties.ClickKey = 115
            Properties.Images = dmAdditions.cxImageList_SWN
            Properties.ViewStyle = vsHideCursor
            Properties.OnButtonClick = beTOTAL_QTY_GROUP_IDPropertiesButtonClick
            Style.TextColor = clNavy
            TabOrder = 2
            Width = 394
          end
        end
        object cxTabSheet6: TcxTabSheet
          Caption = 'Suma vinzarii'
          ImageIndex = 3
          ExplicitWidth = 859
          object Label15: TLabel
            Left = 40
            Top = 82
            Width = 418
            Height = 26
            Caption = 
              #1040#1082#1094#1080#1103' '#1085#1072#1089#1090#1091#1087#1072#1077#1090' '#1074' '#1090#1086#1084' '#1089#1083#1091#1095#1072#1077', '#1077#1089#1083#1080' '#1089#1091#1084#1084#1072' '#1087#1088#1072#1081#1089#1086#1074#1099#1093' '#1094#1077#1085' '#1074' '#1088#1077#1072#1083#1080#1079#1072 +
              #1094#1080#1080' '#1074#1099#1096#1077' '#1091#1082#1072#1079#1072#1085#1085#1086#1081' '#1089#1091#1084#1084#1099'.'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGrayText
            Font.Height = -11
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
            WordWrap = True
          end
          object Label14: TLabel
            Left = 188
            Top = 29
            Width = 394
            Height = 15
            Caption = 'Fac parte din grupa'
          end
          object Label13: TLabel
            Left = 40
            Top = 33
            Width = 30
            Height = 15
            Caption = 'Suma'
          end
          object ceTOTAL_SUM_VALUE: TcxDBCalcEdit
            Left = 40
            Top = 50
            DataBinding.DataField = 'TOTAL_SUM_VALUE'
            Properties.Nullstring = '0'
            TabOrder = 1
            Width = 121
          end
          object beTOTAL_SUM_GROUP_ID: TcxButtonEdit
            Left = 188
            Top = 50
            Properties.Buttons = <
              item
                Default = True
                ImageIndex = 13
                Kind = bkGlyph
              end
              item
                ImageIndex = 35
                Kind = bkGlyph
              end>
            Properties.ClickKey = 115
            Properties.Images = dmAdditions.cxImageList_SWN
            Properties.ViewStyle = vsHideCursor
            Properties.OnButtonClick = beTOTAL_SUM_GROUP_IDPropertiesButtonClick
            Style.TextColor = clNavy
            TabOrder = 2
            Width = 394
          end
          object cbFLG_TOTAL_SUM: TcxDBCheckBox
            Left = 8
            Top = 4
            Caption = 'Suma vinzarii'
            DataBinding.DataField = 'FLG_TOTAL_SUM'
            Properties.Alignment = taLeftJustify
            Properties.ValueChecked = 1
            Properties.ValueUnchecked = 0
            Style.TextStyle = [fsBold]
            TabOrder = 0
          end
        end
        object tbsCashback: TcxTabSheet
          Caption = 'Cashback'
          ImageIndex = 4
          ExplicitLeft = 5
          ExplicitTop = 27
        end
      end
    end
    object cxTabSheet1: TcxTabSheet
      Caption = 'Subdiviziuni'
      ImageIndex = 2
      ExplicitLeft = 3
      ExplicitTop = 27
      ExplicitWidth = 867
      object Label20: TLabel
        Left = 20
        Top = 16
        Width = 212
        Height = 15
        Caption = 'Subdiviziunile care participa in promotie'
      end
      object clbFirme: TcxDBCheckListBox
        Left = 20
        Top = 33
        Width = 485
        Height = 424
        DataBinding.DataField = 'SELECTED_FIRME'
        Images = dmAdditions.cxImageList_SWN
        IntegralHeight = True
        Items = <>
        ParentColor = False
        TabOrder = 0
        OnCheckStatesToEditValue = clbFirmeCheckStatesToEditValue
        OnEditValueToCheckStates = clbFirmeEditValueToCheckStates
      end
    end
  end
  object btnOk: TButton
    Left = 344
    Top = 624
    Width = 90
    Height = 29
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 5
  end
  object Button2: TButton
    Left = 440
    Top = 624
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 6
  end
  object dxBarManager1: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Default'
      #1054#1090#1076#1077#1083#1100#1085#1072#1103' '#1089#1082#1080#1076#1082#1072' '#1085#1072' '#1082#1072#1078#1076#1099#1081' '#1090#1086#1074#1072#1088)
    Categories.ItemsVisibles = (
      2
      2)
    Categories.Visibles = (
      True
      True)
    ImageOptions.Images = dmAdditions.cxImageList_SWN
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 240
    Top = 168
    PixelsPerInch = 96
    object dxBarManager1Bar1: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      BorderStyle = bbsNone
      Caption = 'Custom 1'
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1221
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbNewDiscountRange'
        end
        item
          Visible = True
          ItemName = 'bbDeleteDiscountRange'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar2: TdxBar
      Caption = 'Reduceri'
      CaptionButtons = <>
      DockControl = dxBarDockControl3
      DockedDockControl = dxBarDockControl3
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1221
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbNewGoods'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbDelete'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object bbNewGoods: TdxBarButton
      Caption = 'Adauga produs'
      Category = 0
      Hint = 'Adauga produs'
      Visible = ivAlways
      ImageIndex = 40
    end
    object bbDelete: TdxBarButton
      Caption = 'Sterge produs'
      Category = 0
      Hint = 'Sterge produs'
      Visible = ivAlways
      ImageIndex = 42
    end
    object bbNewDiscountRange: TdxBarButton
      Caption = 'Adauga'
      Category = 1
      Hint = 'Adauga'
      Visible = ivAlways
      ImageIndex = 40
    end
    object bbDeleteDiscountRange: TdxBarButton
      Caption = 'Sterge'
      Category = 1
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
    end
  end
  object IBCQueryDiscountType: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      
        'select 0 as discount_type, '#39'reducere, %'#39' discount_group from rdb' +
        '$database'
      'union all'
      
        'select 1 as discount_type, '#39'reducere, valoare in mdl'#39' discount_g' +
        'roup from rdb$database'
      'union all'
      
        'select 2 as discount_type, '#39'cadou produs'#39' discount_group from rd' +
        'b$database'
      'union all'
      
        'select 3 as discount_type, '#39'bonus, % la urmatoarea cumparatura'#39' ' +
        'discount_group from rdb$database'
      'union all'
      
        'select 4 as discount_type, '#39'bonus, valoare in mdl la urmatoarea ' +
        'cumparatura'#39' discount_group from rdb$database')
    Left = 192
    Top = 104
  end
  object IBCDataSourceDiscountType: TIBCDataSource
    DataSet = IBCQueryDiscountType
    Left = 368
    Top = 104
  end
end
