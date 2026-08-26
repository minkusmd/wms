object frmSelectSyssDialog: TfrmSelectSyssDialog
  Left = 0
  Top = 0
  ActiveControl = cxGridSYSS
  BorderStyle = bsDialog
  ClientHeight = 456
  ClientWidth = 487
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object dxBarDockControl1: TdxBarDockControl
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 471
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
  object cxGridSYSS: TcxGrid
    AlignWithMargins = True
    Left = 8
    Top = 103
    Width = 471
    Height = 290
    Margins.Left = 8
    Margins.Top = 0
    Margins.Right = 8
    Margins.Bottom = 0
    Align = alTop
    TabOrder = 2
    object cxGridSYSS_Vendors: TcxGridDBTableView
      OnDblClick = cxGridSYSS_VendorsDblClick
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
      DataController.DetailKeyFieldNames = 'SYSSID'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.ImmediateEditor = False
      OptionsBehavior.IncSearch = True
      OptionsCustomize.ColumnsQuickCustomization = True
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090#1091' '#1079#1072#1087#1080#1089#1077#1081'>'
      OptionsView.ScrollBars = ssVertical
      OptionsView.ShowEditButtons = gsebForFocusedRecord
      OptionsView.ColumnAutoWidth = True
      OptionsView.GridLineColor = 13750737
      OptionsView.GroupByBox = False
      object cxGridSYSS_VC1: TcxGridDBColumn
        AlternateCaption = 'ID '#1055#1088#1086#1080#1079#1074#1086#1076#1080#1090#1077#1083#1103
        Caption = 'ID'
        DataBinding.FieldName = 'SYSSID'
        Visible = False
        MinWidth = 50
        Options.Editing = False
        Options.HorzSizing = False
        Options.Sorting = False
        Width = 50
      end
      object cxGridSYSS_VC2: TcxGridDBColumn
        Caption = #1053#1072#1079#1074#1072#1085#1080#1077
        DataBinding.FieldName = 'TITLE'
        VisibleForCustomization = False
        Width = 240
      end
      object cxGridSYSS_VC3: TcxGridDBColumn
        Caption = #1048#1085#1090#1077#1088#1085#1077#1090' '#1072#1076#1088#1077#1089#1089
        DataBinding.FieldName = 'VALUE_STR'
        Width = 240
      end
    end
    object cxGridSYSS_Cities: TcxGridDBTableView
      OnDblClick = cxGridSYSS_VendorsDblClick
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
      FilterBox.CustomizeDialog = False
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.ImmediateEditor = False
      OptionsBehavior.IncSearch = True
      OptionsCustomize.ColumnFiltering = False
      OptionsCustomize.ColumnsQuickCustomization = True
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090#1091' '#1079#1072#1087#1080#1089#1077#1081'>'
      OptionsView.ScrollBars = ssVertical
      OptionsView.ShowEditButtons = gsebForFocusedRecord
      OptionsView.ColumnAutoWidth = True
      OptionsView.GridLineColor = 13750737
      OptionsView.GroupByBox = False
      object cxGridSYSS_CC1: TcxGridDBColumn
        AlternateCaption = 'ID '#1043#1086#1088#1086#1076#1072
        Caption = 'ID'
        DataBinding.FieldName = 'SYSSID'
        Visible = False
        MinWidth = 50
        Options.Editing = False
        Options.HorzSizing = False
        Width = 50
      end
      object cxGridSYSS_CC2: TcxGridDBColumn
        Caption = #1053#1072#1079#1074#1072#1085#1080#1077
        DataBinding.FieldName = 'TITLE'
        VisibleForCustomization = False
        Width = 190
      end
      object cxGridSYSS_CC3: TcxGridDBColumn
        Caption = #1056#1072#1081#1086#1085
        DataBinding.FieldName = 'VALUE_INT'
        PropertiesClassName = 'TcxLookupComboBoxProperties'
        Properties.KeyFieldNames = 'SYSSID'
        Properties.ListColumns = <
          item
            FieldName = 'TITLE'
          end>
        Properties.ListSource = IBCDataSourceSYSS2
        Properties.ReadOnly = False
        GroupSummaryAlignment = taRightJustify
        Options.Editing = False
        Options.ShowEditButtons = isebNever
        Width = 210
      end
    end
    object cxGridSYSS_District: TcxGridDBTableView
      OnDblClick = cxGridSYSS_VendorsDblClick
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
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.ImmediateEditor = False
      OptionsCustomize.ColumnFiltering = False
      OptionsCustomize.ColumnGrouping = False
      OptionsCustomize.ColumnsQuickCustomization = True
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090#1091' '#1079#1072#1087#1080#1089#1077#1081'>'
      OptionsView.ScrollBars = ssVertical
      OptionsView.ShowEditButtons = gsebForFocusedRecord
      OptionsView.ColumnAutoWidth = True
      OptionsView.GridLineColor = 13750737
      OptionsView.GroupByBox = False
      object cxGridSYSS_DC1: TcxGridDBColumn
        AlternateCaption = 'ID '#1056#1072#1081#1086#1085#1072
        Caption = 'ID'
        DataBinding.FieldName = 'SYSSID'
        Visible = False
        MinWidth = 50
        Options.HorzSizing = False
        Width = 50
      end
      object cxGridSYSS_DC2: TcxGridDBColumn
        Caption = #1053#1072#1079#1074#1072#1085#1080#1077
        DataBinding.FieldName = 'TITLE'
        VisibleForCustomization = False
      end
    end
    object cxGridSYSS_CustomerType: TcxGridDBTableView
      OnDblClick = cxGridSYSS_VendorsDblClick
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
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.ImmediateEditor = False
      OptionsBehavior.IncSearch = True
      OptionsCustomize.ColumnFiltering = False
      OptionsCustomize.ColumnGrouping = False
      OptionsCustomize.ColumnsQuickCustomization = True
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090#1091' '#1079#1072#1087#1080#1089#1077#1081'>'
      OptionsView.ScrollBars = ssVertical
      OptionsView.ShowEditButtons = gsebForFocusedRecord
      OptionsView.ColumnAutoWidth = True
      OptionsView.GridLineColor = 13750737
      OptionsView.GroupByBox = False
      object cxGridSYSS_CTC1: TcxGridDBColumn
        AlternateCaption = 'ID '#1058#1080#1087' '#1082#1086#1085#1090#1088#1072#1075#1077#1085#1090#1072
        Caption = 'ID'
        DataBinding.FieldName = 'SYSSID'
        Visible = False
        MinWidth = 50
        Options.HorzSizing = False
        Width = 50
      end
      object cxGridSYSS_CTC2: TcxGridDBColumn
        Caption = #1053#1072#1079#1074#1072#1085#1080#1077
        DataBinding.FieldName = 'TITLE'
        PropertiesClassName = 'TcxTextEditProperties'
        MinWidth = 100
        Options.ShowEditButtons = isebNever
        VisibleForCustomization = False
      end
    end
    object cxGridSYSS_CustomerStatus: TcxGridDBTableView
      OnDblClick = cxGridSYSS_VendorsDblClick
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
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.ImmediateEditor = False
      OptionsCustomize.ColumnsQuickCustomization = True
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090#1091' '#1079#1072#1087#1080#1089#1077#1081'>'
      OptionsView.ScrollBars = ssVertical
      OptionsView.ShowEditButtons = gsebForFocusedRecord
      OptionsView.ColumnAutoWidth = True
      OptionsView.GridLineColor = 13750737
      OptionsView.GroupByBox = False
      object cxGridSYSS_CSC1: TcxGridDBColumn
        AlternateCaption = 'ID '#1057#1090#1072#1090#1091#1089' '#1082#1086#1085#1090#1088#1072#1075#1077#1085#1090#1072
        Caption = 'ID'
        DataBinding.FieldName = 'SYSSID'
        Visible = False
        MinWidth = 50
        Options.Editing = False
        Options.HorzSizing = False
        Width = 50
      end
      object cxGridSYSS_CSC2: TcxGridDBColumn
        Caption = #1053#1072#1079#1074#1072#1085#1080#1077
        DataBinding.FieldName = 'TITLE'
        VisibleForCustomization = False
      end
    end
    object cxGridSYSS_GoodsType: TcxGridDBTableView
      OnDblClick = cxGridSYSS_VendorsDblClick
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
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.ImmediateEditor = False
      OptionsCustomize.ColumnsQuickCustomization = True
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090#1091' '#1079#1072#1087#1080#1089#1077#1081'>'
      OptionsView.ScrollBars = ssVertical
      OptionsView.ShowEditButtons = gsebForFocusedRecord
      OptionsView.ColumnAutoWidth = True
      OptionsView.GridLineColor = 13750737
      OptionsView.GroupByBox = False
      object cxGridSYSS_GTC1: TcxGridDBColumn
        AlternateCaption = 'ID '#1058#1080#1087' '#1090#1086#1074#1072#1088#1072
        Caption = 'ID'
        DataBinding.FieldName = 'SYSSID'
        Visible = False
        MinWidth = 50
        Options.Editing = False
        Options.HorzSizing = False
        Width = 50
      end
      object cxGridSYSS_GTC2: TcxGridDBColumn
        Caption = #1053#1072#1079#1074#1072#1085#1080#1077
        DataBinding.FieldName = 'TITLE'
        VisibleForCustomization = False
      end
    end
    object cxGridSYSS_StockType: TcxGridDBTableView
      OnDblClick = cxGridSYSS_VendorsDblClick
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
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.ImmediateEditor = False
      OptionsCustomize.ColumnsQuickCustomization = True
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090#1091' '#1079#1072#1087#1080#1089#1077#1081'>'
      OptionsView.ScrollBars = ssVertical
      OptionsView.ShowEditButtons = gsebForFocusedRecord
      OptionsView.ColumnAutoWidth = True
      OptionsView.GridLineColor = 13750737
      OptionsView.GroupByBox = False
      object cxGridSYSS_STC1: TcxGridDBColumn
        AlternateCaption = 'ID '#1058#1080#1087' '#1089#1082#1083#1072#1076#1072
        Caption = 'ID'
        DataBinding.FieldName = 'SYSSID'
        Visible = False
        MinWidth = 50
        Options.Editing = False
        Options.HorzSizing = False
        Width = 50
      end
      object cxGridSYSS_STC2: TcxGridDBColumn
        Caption = #1053#1072#1079#1074#1072#1085#1080#1077
        DataBinding.FieldName = 'TITLE'
      end
    end
    object cxGridSYSS_GoodsSerialType: TcxGridDBTableView
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
      DataController.KeyFieldNames = 'SYSSID'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsCustomize.ColumnsQuickCustomization = True
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090#1091' '#1079#1072#1087#1080#1089#1077#1081'>'
      OptionsView.ScrollBars = ssVertical
      OptionsView.ShowEditButtons = gsebForFocusedRecord
      OptionsView.ColumnAutoWidth = True
      OptionsView.GridLineColor = 13750737
      OptionsView.GroupByBox = False
      object cxGridSYSS_GST1: TcxGridDBColumn
        AlternateCaption = #1050#1086#1076' '#1090#1080#1087#1072' '#1089#1077#1088#1080#1081#1085#1086#1075#1086' '#1091#1095#1077#1090#1072
        Caption = #1050#1086#1076
        DataBinding.FieldName = 'SYSSID'
        Visible = False
        MinWidth = 50
        Options.HorzSizing = False
        Width = 50
      end
      object cxGridSYSS_GST2: TcxGridDBColumn
        Caption = #1058#1080#1087' '#1089#1077#1088#1080#1081#1085#1086#1075#1086' '#1091#1095#1077#1090#1072
        DataBinding.FieldName = 'TITLE'
        VisibleForCustomization = False
      end
    end
    object cxGridSYSSLevel1: TcxGridLevel
      GridView = cxGridSYSS_GoodsSerialType
    end
  end
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 487
    Height = 64
    Image.Data = {
      0B546478504E47496D61676589504E470D0A1A0A0000000D4948445200000030
      0000003008060000005702F987000000017352474200AECE1CE9000000046741
      4D410000B18F0BFC6105000000206348524D00007A26000080840000FA000000
      80E8000075300000EA6000003A98000017709CBA513C00000D53494441546843
      D5987950D4E719C76D9BA37FA449DA71D2A69A9926D536D5A49A69D21AC7C944
      635A351E44094410E5924BB96F118D172AF7B59C91FB14914310B94F45C4FB04
      390414BC95DB03F5DBE7797FBBCBAE596CC13FA2EFCC77C47D5DFC7C9FFDBECF
      FBFC761C80975A1A5F7C99A4F1C597491A5F7C99A4F9C59F69F5B65FFFA4C323
      0BADAE7BD0649F8A068B589C3608C7B16581A8FB6687F8FBECD9B37F4FFFF435
      E91DB45E14030C7FC6310977BD2A31E85F873EDFC378107202F0AAC123CB34D4
      7DEE89AAE92E983B77EE1CFAE7BF23FD42BCF14530F0343C83F3CFFDEB0AD063
      148BFCC96B51612643F1147B7CF5D5573AF49677492F8E01863FA8E38F6A2D6F
      54CEDB86F22F37A2F45F6E2899E624AA5EBA2200473C9290F38125E6CC99A34B
      6F9940FAA578F38B62A039B2081783F6A371670E1A3667A2717D069ADD760B03
      47D727E11829E50F862FA681536B62D0E8938B0B04DEB02E1D8D4EA968B24B46
      8B798288CDA9F52942D16FE9BE98068EAF0AC785756938EF90840B6BE2D16816
      8B26FD68342D0E15B139691F2714F8AAD6E80D5C6AEFFCC0CD3703218925084E
      2846507C11A910817185F08B29808357327C76E5C33B6A1F7646E6627B440EB6
      856761AB2C13169ED1D81492811F82D2B131301D9E01A9F0F44F81875F32FC13
      2B101E11F921FD17AFD72FF5C359CB589C338AC205BD48342C0945C31C3F9CFB
      648B884D9D1EB551FD20788F5B802FBEF8820FF1FF674001AF693D7902F0DE13
      FAE131EBF1133C7AFC18438F24F1DE83878F4843B8FF6008F7EE3FC4E0FD0718
      B8F740EC714196EBE9CDB7B5B3FB73EDDCAD38A32BC3B945C1B830C717E7FFE9
      85337FF5C4A9779D456CAAFFB30599D3CDE06E6EEF3D6DDAB47984F60EE9D906
      2E7574FE696BE401FAEB4F17B183F7D4E1497278DE7B38C4F08F2478850182E7
      BDDAD3D710489FE2370B172D5F616030A56686072E2E20F8993B7076CA469C9E
      E88A136FDBE1D86B56223651EFE80AF8A953A72E7EEFBDF7A610DE1BA491DBE8
      E5CEABEF6EDF55423FFE74313CEFF127A0064FD56703BCA7805756FF8104CF7B
      0CCFF2A5D82D59A2A5AFA7AF3F55B4CA8FEC9137692D32269A227EFC0A84BFA1
      8DC0579688D828E0274E9CF8D1DBB408FB57CF3410925080CCA213D853741C19
      078E212DFF0892730F2331BB0671999548DB5F8FD4FC7A24EDAB4342F641C4EE
      ADC68FBBCB11915A82B8AC43F4F783D8B5A70AD1E995F45A19648945088E2B50
      C2B3F8AC2CD3FE6E051B983163C604BAA078E9F0215515679E63C39597C3BFA2
      84E73592015E5244202A3C34F4842AFB18D965A7A8A28F28CF4318187C883E52
      4FFF0374F7DD177BB77BEEE1E6DD415CBF33806BB7FAD175B31F57AEF52187F6
      540D6C0ACD80F6773A066C60D2A4496FCE9C39F38FB366CD7A9FFEFC40559F7D
      F6D9FB93274F9E307EFCF8DF10AE3A3C2F05B4AA42120B04FC13916B82A76830
      FC7D024FC8AD1B861F78805E12C3DF2570DEBB796710376E0FE02AC177DEECC3
      95EBBDE8B8DA8344FAB4540D7806A441F7FBE5ABD80061F070C68792C5F1D024
      DE5387E7A5C94068E281E1CA930129D38FC5618CD85D2DAF3CC1F7DF97E07BEF
      E376F73DB177832ACFF05D3718BE8FE07BD1D6D583C8DD356A06B8136D0CDA2D
      5AEB7AFF54D15AD7F926893F79AFB0A87816E1FD9AA4195CB13419902516CAE1
      A9F204AEE8265CF9B0F42A51F91E057C8F04CFB1E13D253CC5A6E35A2FDA09BE
      F5CA5D44A40F1B60C0EEDE01A1BB3DFDB8A350779FD80BA4BB265416BEC6CCCC
      FC2F84C8B1197969349054A88C0DC373E507EF0DA1FFDE43C8D2AA94B1B9D37B
      4F09CFB1E1BD4E012FC5862BDF7AA51BCD97EF203CBD5AC0731BEDEE1B54C22B
      0D10BCA2C506D385B968D162033A237F27C4D749A3FB04C2928A94AD90733F48
      3D9C63D34FE0B2D42A796C14F003B84EF07C60798FE12F536CDABBBA45E55B08
      BEA95D32C06DB487E185011578926A8BE5DB7EE9326D031D5DDD8F0991CFC7E8
      0CA4E5D58EDC0EF3E3119897089F9C18ECC88AC6F6BD51D89C21834DCC26E885
      598EF8BE84AC6A44A55720328D4688147A2D894613BACC0262F311BD47FA7414
      E24BEEA9033E3A03E129C5F2CC4B9517DD46DE2AB7658721A12E0591D5B19055
      4623B4220AFEA532B8647942C7DB9C622355BEB9E30E2E52E51B2FDDC685D65B
      D85B7C02679A6EE054E3751CBF700DC7CE5F45FDD9ABA83BDDF5530334672DD7
      D337FC7EF9F28F0871F406F84212AD9232AF0ACFB1B18DDF0CDFD220FC90EF05
      8F7D9BE191BB094E991EB04F74C712771365E6057C9B047FB6F926E2B20F0BF8
      130C7FEE2A8E08F84ED49EEA445446959A017F1A120D56AE321EB381C8B452F4
      8BCC3F54C22B0EECEA280F6C3DE00DB7EC0D70CC74873D2BDD0D76316E58E060
      28E039F30DF2CA9F23F833176FD019A812953F7AEE9ABCF212FCC11357A8FD56
      AA19E009D7D0C8C474CC06A2D2CBD42B4F979474C30EC0940C6C29F0866BB627
      1C187E8F3BECC8802D19984F0694F02D52E519FE64C3753AE095141B86EFC261
      25FC65D41CEB40189D0B053CB7519F1FF3616CBADA6CCC87382ABD5C391E08F8
      EE4171C3F278B032CC9962B3190E19049F46954F25F82437D844B962BEAD21C1
      DF12F08ACA2B62139A522955FECC70E5AB8F5F46D5D10EC8E85033BCA28D7A47
      EFC36A330B73B981D1B7D1681ACC7A043C5D528AD9E676BF6895F376AE8203E5
      DD3E9A2A1F41F0E1042F7385B5BF2BE659AE52C6E634579EE11B383657119A5C
      210E6CEDA92B4AF84A82AF38D28EE0A462B536BA333207E69656966336F0AC36
      AABDC5045A4E2658B2D6188BAD8CB0C8D2100BCD576181A9012C9C731018DE01
      DF900EEC086CC776FF366CF66E858D4B0B740CDA11B59BDA28B5D270FA5DA1DC
      4613E8C92EB6008109454A78D6F6886C58ADB5B11AF345B66B4F256E516C6E71
      6CE48359170F667449F128ADBC61A95572E645ABA4D86CF1EE4468C4007C03E9
      62F2ED87974F1F366DEB8385752FB4F5EB70E8E470E5CBEB3B5076A40D25872F
      C18F4CA81AF00ACBC21A6BDBB56336109359258F8D74C34AE3010F663DA2E529
      5A6513B5C90679ABE4D8AC756EC7C62D037074ED878D631FAC1DFA60B6A60F26
      162D58ACB357CA3C1DDA8AFA7694D649F045B597E8997ABF9A816DF43C6D63E7
      603D6603B199354AF8E1A9529A6D02134BA9F277A9CFCBE1E50796336FB2B615
      AE1EFDB0B2E9C76AAB3E985A32FC6D189B9FC5FCA529E2C09653E6CB54E00B0F
      B66247549E9A01FE32C0CEC1C976D932ED6984387A0371590755E06930BB46F0
      9DD25419905022C586E0CFCB2F29A9DBDC8031197059D7074B6B86EF25F85E82
      BF052361205954BEACAE7D18FE502B0A6A5AE01591AB84DF109C834DC119B077
      74B6931BE0917A9406E831515979CA7D5BA77C30A3CCFBC79728C783A7BBCD0A
      B356111B53CB3B047F0DC62CF30E18991DC3BC6FE3E5F06D04DF8A0354F9829A
      56E457B7600B659EE1B98D1E3AD18A4D41E9707072B1FFF6DBA5D30971F406E2
      B30F299FA4A4033B3CDBF8C595A85C52372578F978F06FAD66826F22F87A02AF
      A5CA1F22F82A18AECE2303A128A1AA171F9262C3F0FBAB9B915FD54C8F97996A
      6D744360DAF31978561B7DD6DEB2E5E5D0FA3E015ABA2158A2138845DFF963A1
      B62FBE59BA9D5EF341348D0CD2445A86B0E4529A488BA9951EC086A00C25BC30
      404F698ECEAE0E633690985B2B9F2AB955DE95C68336BA6129364939B52236D2
      54791D4769AA1483D9992EB1275D521DA894779B323AB41C1BFE9D5CF9031499
      FD54F5BCCA66ECAB68424E7913D607A4AB19F0F44B81938BFB7318A0077029F3
      7278CAFCF9D69B22F361A9E5CACCF3487C84661B6930BB22F614E341B938B0DC
      6DDA446C22A8F27C60F3AB5A86E149D96517E1EE97AA66603D3D173F97816432
      A0C8BC62AAE4CC73E5FDE28A45E5A5799E07331E0FA4D986F7B8F212BCD46D8A
      A9D3F0810DA0C7C4FD54FD3CAA7E2E81E752E5193EABB4116E3EC96A060C5D42
      9FD340DE11B58711053C57DE37A6484C95C39597E06B2836BC370CCF956F9562
      4395F78F2F16F0FB2A55E12F626F49239C770E1BE069D4CC3D4CC8C439182BED
      FDA8B566F2F79DBF25F164AABE341948C9AF27F8E1A95291798E8D4F4CA14AE5
      D50733DE53F6798ACD01799FCFA76EE34F9F8E94F98B127C59A380CF2C6E80F3
      8E4401CF6D3429A70269FBAA50587D12099985302003D131F1DE73BFFEFA73C2
      7D53A256592319505E52E231F086F43042B161C8A7476231DBD061E5BD528E8D
      FC86E5CA2B62E3175BA484DF4BB161F83D04BFA7A8018EDB13441B55C0CB12F2
      E0B22D8A3E8110F80504474C9B3E7D29A1F257F1C35FEA2A962603A9F947A58F
      D14D26B4DA2D8C248329CB3554C8C43504262E2130760986317DD4462CA72021
      4396630056B11C2419D8FB8B6A2AB4C28EE50B7D5B1F4936C3D2B3F1A683BD5B
      159EBF91567CA9ABBE3419888D4FFCD8C8C878117FF9CADF5FF23704FC90ADA7
      BFC2487FC54A637E5E5D45CF7CFCD867646CB29A9F9E4C4CCDCCF921C4CCC2D2
      8267790BCB35563C12AF596BB386274B6B5B3B6B160F69245B9E75785C60F1A5
      C5E2DECF8757A17F7CFAE94242FC1B49333C2F4D0668BDFEE5ECD913B4B4B43E
      D4D3D79FCAE2E7D3A7C50F1C9AC453A426F16CF3B4B8D38C24E298487A8BA419
      9ED708063867FC9D247FADF72A894FFFB3C413E368C5EDF17F897FF7C8F0BC46
      30A0586CE4E7D633D6B871FF053BAE404F0F74E37B0000000049454E44AE4260
      82}
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
  end
  object btnOk: TcxButton
    Left = 276
    Top = 408
    Width = 90
    Height = 29
    Caption = #1042#1099#1073#1088#1072#1090#1100
    Default = True
    TabOrder = 3
    OnClick = btnOkClick
  end
  object btnCancel: TcxButton
    Left = 376
    Top = 408
    Width = 90
    Height = 29
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 8
  end
  object dxBarManager: TdxBarManager
    AllowReset = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    CanCustomize = False
    Categories.Strings = (
      'Default')
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    ImageOptions.Images = dmAdditions.cxImageList_SWN
    NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
    PopupMenuLinks = <>
    SunkenBorder = True
    UseSystemFont = True
    Left = 332
    Top = 56
    DockControlHeights = (
      0
      0
      0
      0)
    object dxBarManagerBar1: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'SystemItems'
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 45
      FloatTop = 183
      FloatClientWidth = 51
      FloatClientHeight = 77
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbNew'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbModify'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbDelete'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object bbNew: TdxBarButton
      Caption = #1053#1086#1074#1099#1081
      Category = 0
      Hint = #1053#1086#1074#1099#1081
      Visible = ivAlways
      ImageIndex = 0
      ShortCut = 45
      OnClick = bbNewClick
    end
    object bbModify: TdxBarButton
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      Category = 0
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 1
      ShortCut = 113
      OnClick = bbModifyClick
    end
    object bbDelete: TdxBarButton
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Category = 0
      Hint = #1059#1076#1072#1083#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 2
      ShortCut = 46
      OnClick = bbDeleteClick
    end
  end
  object IBCDataSourceSYSS: TIBCDataSource
    DataSet = IBCQuerySYSS
    OnDataChange = DataSourceSYSSDataChange
    Left = 68
    Top = 140
  end
  object IBCQuerySYSS: TIBCQuery
    UpdatingTable = 'TS_SYSS'
    KeyFields = 'SYSSID'
    KeyGenerator = 'SQ_TS_SYSS_SYSSID'
    GeneratorMode = gmInsert
    SQLInsert.Strings = (
      'INSERT INTO TS_SYSS'
      '  (SYSSID, '
      '   STYPE, '
      '   SNO, '
      '   TITLE, '
      '   VALUE_STR, '
      '   VALUE_INT)'
      'VALUES'
      ' ('
      '  :SYSSID, '
      '  :STYPE, '
      '  :SNO,'
      '  :TITLE,'
      '  :VALUE_STR,'
      '  :VALUE_INT'
      ' )')
    SQLDelete.Strings = (
      'DELETE FROM TS_SYSS'
      'WHERE'
      '  SYSSID = :Old_SYSSID')
    SQLUpdate.Strings = (
      'UPDATE '
      ' TS_SYSS'
      'SET'
      ' SYSSID = :SYSSID, '
      ' STYPE = :STYPE,'
      ' SNO = :SNO,'
      ' TITLE = :TITLE,'
      ' VALUE_STR = :VALUE_STR,'
      ' VALUE_INT = :VALUE_INT'
      'WHERE'
      '  SYSSID = :Old_SYSSID')
    SQLRefresh.Strings = (
      'SELECT '
      
        ' TS_SYSS.SYSSID, TS_SYSS.STYPE, TS_SYSS.SNO, TS_SYSS.TITLE, TS_S' +
        'YSS.VALUE_STR, TS_SYSS.VALUE_INT '
      'FROM '
      ' TS_SYSS'
      'WHERE'
      '  SYSSID = :SYSSID')
    SQLLock.Strings = (
      'SELECT NULL FROM TS_SYSS'
      'WHERE'
      'SYSSID = :Old_SYSSID'
      'FOR UPDATE WITH LOCK')
    UpdateTransaction = IBCTrUpdateSYSS
    SQL.Strings = (
      'SELECT'
      ' A.SYSSID,'
      ' A.TITLE,'
      ' A.STYPE,'
      ' A.SNO,'
      ' A.VALUE_INT,'
      ' A.VALUE_STR,'
      ' B.TITLE AS TITLE_INT'
      'FROM '
      ' TS_SYSS A'
      ' LEFT JOIN TS_SYSS B ON (B.SYSSID=A.VALUE_INT)'
      'WHERE'
      
        ' (A.PARENTID = (SELECT SYSSID FROM TS_SYSS WHERE (STYPE=:STYPE) ' +
        'AND (SNO=:SNO) AND (PARENTID=0)))')
    AutoCommit = False
    Options.RequiredFields = False
    LocalConstraints = False
    BeforePost = IBCQuerySYSSBeforePost
    Left = 68
    Top = 196
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'STYPE'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'SNO'
        Value = nil
      end>
  end
  object IBCTableSYSS2: TIBCTable
    TableName = 'TS_SYSS'
    DetailFields = 'SYSSID'
    KeyFields = 'SYSSID'
    Left = 184
    Top = 192
  end
  object IBCDataSourceSYSS2: TIBCDataSource
    DataSet = IBCTableSYSS2
    Left = 188
    Top = 140
  end
  object IBCTrUpdateSYSS: TIBCTransaction
    Left = 68
    Top = 256
  end
end
