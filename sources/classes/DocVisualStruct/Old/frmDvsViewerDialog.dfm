object frmDvsViewerDlg: TfrmDvsViewerDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1048#1077#1088#1072#1088#1093#1080#1103' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074
  ClientHeight = 572
  ClientWidth = 918
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 918
    Height = 64
    Title = #1048#1077#1088#1072#1088#1093#1080#1103' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074
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
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 902
    Height = 445
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    ShowCaption = False
    TabOrder = 1
    object cxGridNPN: TcxGrid
      Left = 20
      Top = 157
      Width = 857
      Height = 88
      TabOrder = 3
      LookAndFeel.NativeStyle = True
      LookAndFeel.SkinName = ''
      object cxGridNPNTable: TcxGridDBTableView
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
        DataController.DataSource = IBCDataSourceCurrDoc
        DataController.KeyFieldNames = 'DOCID'
        DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoFocusTopRowAfterSorting]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.IncSearch = True
        OptionsBehavior.ImmediateEditor = False
        OptionsCustomize.ColumnsQuickCustomization = True
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.InvertSelect = False
        OptionsView.CellEndEllipsis = True
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        OptionsView.GroupRowStyle = grsOffice11
        Styles.GroupByBox = dmAdditions.cxStyle_GridGroup
        Styles.Header = dmAdditions.cxStyle_GridHeader
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        object cxGridNPNTableColumn1: TcxGridDBColumn
          Caption = #1058#1080#1087' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
          DataBinding.FieldName = 'DOCTYPE_NAME'
          Width = 100
        end
        object cxGridNPNTableDocID: TcxGridDBColumn
          Caption = #1050#1086#1076
          DataBinding.FieldName = 'DOCID'
          HeaderAlignmentHorz = taCenter
          MinWidth = 50
          Width = 60
        end
        object cxGridNPNTableDocNo: TcxGridDBColumn
          Caption = #8470
          DataBinding.FieldName = 'DOCNO'
          HeaderAlignmentHorz = taCenter
          MinWidth = 40
          Width = 50
        end
        object cxGridNPN_DATA: TcxGridDBColumn
          Caption = #1044#1072#1090#1072
          DataBinding.FieldName = 'DATA'
          HeaderAlignmentHorz = taCenter
          MinWidth = 50
          Width = 80
        end
        object cxGridNPN_CREATED_DATE: TcxGridDBColumn
          Caption = #1044#1072#1090#1072' '#1089#1086#1079#1076#1072#1085#1080#1103
          DataBinding.FieldName = 'CREATED_DATE'
          HeaderAlignmentHorz = taCenter
          MinWidth = 50
          Width = 80
        end
        object cxGridNPN_DTDEP_NAME: TcxGridDBColumn
          Caption = #1057#1082#1083#1072#1076
          DataBinding.FieldName = 'DTDEP_NAME'
          MinWidth = 60
          Width = 100
        end
        object cxGridNPN_CT_NAME: TcxGridDBColumn
          Caption = #1050#1086#1085#1090#1088#1072#1075#1077#1085#1090
          DataBinding.FieldName = 'CT_NAME'
          MinWidth = 140
          Styles.Content = dmAdditions.cxStyle_GridColumnBOLD
          Width = 200
        end
        object cxGridNPNTableSuma: TcxGridDBColumn
          Caption = #1057#1091#1084#1084#1072
          DataBinding.FieldName = 'SUMA'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          HeaderAlignmentHorz = taCenter
          MinWidth = 60
          Width = 80
        end
        object cxGridNPN_CURRENCY_NAME: TcxGridDBColumn
          Caption = #1042#1072#1083#1102#1090#1072
          DataBinding.FieldName = 'CURRENCY_NAME'
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taCenter
          HeaderAlignmentHorz = taCenter
          MinWidth = 50
          Width = 50
        end
        object cxGridNPNTableVAT: TcxGridDBColumn
          Caption = #1053#1044#1057
          DataBinding.FieldName = 'VAT'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          HeaderAlignmentHorz = taCenter
          MinWidth = 50
          Options.Sorting = False
          Width = 60
        end
        object cxGridNPNTableRate: TcxGridDBColumn
          Caption = #1050#1091#1088#1089
          DataBinding.FieldName = 'RATE'
          HeaderAlignmentHorz = taCenter
          MinWidth = 40
          Options.Sorting = False
          Width = 50
        end
        object cxGridNPNTableParentDocID: TcxGridDBColumn
          Caption = #1050#1086#1076' '#1088#1086#1076'.'
          DataBinding.FieldName = 'PARENTDOCID'
          Visible = False
          HeaderAlignmentHorz = taCenter
          MinWidth = 70
          Options.HorzSizing = False
          Width = 70
        end
        object cxGridNPN_RATEUSD: TcxGridDBColumn
          Caption = #1050#1091#1088#1089' USD'
          DataBinding.FieldName = 'RATEUSD'
          HeaderAlignmentHorz = taCenter
          MinWidth = 40
          Width = 60
        end
        object cxGridNPNTable_FLG_ACNT: TcxGridDBColumn
          Caption = #1041#1091#1093#1075
          DataBinding.FieldName = 'FLG_ACNT'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          HeaderAlignmentHorz = taCenter
          MinWidth = 40
          Options.HorzSizing = False
          Width = 40
        end
        object cxGridNPNTable_FLG_SHIP: TcxGridDBColumn
          AlternateCaption = #1054#1090#1075#1088#1091#1078#1077#1085
          Caption = #1054#1090#1075#1088'.'
          DataBinding.FieldName = 'FLG_SHIP'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          HeaderAlignmentHorz = taCenter
          MinWidth = 40
          Options.HorzSizing = False
          Width = 40
        end
        object cxGridNPNTable_FLG_PROTECTED: TcxGridDBColumn
          AlternateCaption = #1047#1072#1096#1080#1097#1077#1085
          Caption = #1047#1072#1096'.'
          DataBinding.FieldName = 'FLG_PROTECTED'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          HeaderAlignmentHorz = taCenter
          MinWidth = 40
          Options.HorzSizing = False
          Width = 40
        end
        object cxGridNPNTable_CUSTOMER_TYPE_ID: TcxGridDBColumn
          DataBinding.FieldName = 'CUSTOMER_TYPE_ID'
          Visible = False
          VisibleForCustomization = False
        end
        object cxGridNPN_CREATED_BY_NAME: TcxGridDBColumn
          Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
          DataBinding.FieldName = 'CREATED_BY_NAME'
          MinWidth = 80
          Width = 100
        end
        object cxGridNPN_CT: TcxGridDBColumn
          DataBinding.FieldName = 'CT'
          Visible = False
          VisibleForCustomization = False
        end
        object cxGridNPN_DT: TcxGridDBColumn
          DataBinding.FieldName = 'DT'
          Visible = False
          VisibleForCustomization = False
        end
      end
      object cxGridNPNLevel: TcxGridLevel
        GridView = cxGridNPNTable
      end
    end
    object cxGrid1: TcxGrid
      Left = 20
      Top = 33
      Width = 857
      Height = 76
      TabOrder = 1
      LookAndFeel.NativeStyle = True
      LookAndFeel.SkinName = ''
      object cxGridDBTableView1: TcxGridDBTableView
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
        DataController.DataSource = IBCDataSourceParentDoc
        DataController.KeyFieldNames = 'DOCID'
        DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoFocusTopRowAfterSorting]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.IncSearch = True
        OptionsBehavior.ImmediateEditor = False
        OptionsCustomize.ColumnsQuickCustomization = True
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.InvertSelect = False
        OptionsView.CellEndEllipsis = True
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        OptionsView.GroupRowStyle = grsOffice11
        Styles.GroupByBox = dmAdditions.cxStyle_GridGroup
        Styles.Header = dmAdditions.cxStyle_GridHeader
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        object cxGridDBTableView1Column1: TcxGridDBColumn
          Caption = #1058#1080#1087' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
          DataBinding.FieldName = 'DOCTYPE_NAME'
          Width = 100
        end
        object cxGridDBColumn1: TcxGridDBColumn
          Caption = #1050#1086#1076
          DataBinding.FieldName = 'DOCID'
          HeaderAlignmentHorz = taCenter
          MinWidth = 50
          Width = 60
        end
        object cxGridDBColumn2: TcxGridDBColumn
          Caption = #8470
          DataBinding.FieldName = 'DOCNO'
          HeaderAlignmentHorz = taCenter
          MinWidth = 40
          Width = 50
        end
        object cxGridDBColumn3: TcxGridDBColumn
          Caption = #1044#1072#1090#1072
          DataBinding.FieldName = 'DATA'
          HeaderAlignmentHorz = taCenter
          MinWidth = 50
          Width = 80
        end
        object cxGridDBColumn4: TcxGridDBColumn
          Caption = #1044#1072#1090#1072' '#1089#1086#1079#1076#1072#1085#1080#1103
          DataBinding.FieldName = 'CREATED_DATE'
          HeaderAlignmentHorz = taCenter
          MinWidth = 50
          Width = 80
        end
        object cxGridDBColumn5: TcxGridDBColumn
          Caption = #1057#1082#1083#1072#1076
          DataBinding.FieldName = 'DTDEP_NAME'
          MinWidth = 60
          Width = 100
        end
        object cxGridDBColumn6: TcxGridDBColumn
          Caption = #1050#1086#1085#1090#1088#1072#1075#1077#1085#1090
          DataBinding.FieldName = 'CT_NAME'
          MinWidth = 140
          Styles.Content = dmAdditions.cxStyle_GridColumnBOLD
          Width = 200
        end
        object cxGridDBColumn7: TcxGridDBColumn
          Caption = #1057#1091#1084#1084#1072
          DataBinding.FieldName = 'SUMA'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          HeaderAlignmentHorz = taCenter
          MinWidth = 60
          Width = 80
        end
        object cxGridDBColumn8: TcxGridDBColumn
          Caption = #1042#1072#1083#1102#1090#1072
          DataBinding.FieldName = 'CURRENCY_NAME'
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taCenter
          HeaderAlignmentHorz = taCenter
          MinWidth = 50
          Width = 50
        end
        object cxGridDBColumn9: TcxGridDBColumn
          Caption = #1053#1044#1057
          DataBinding.FieldName = 'VAT'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          HeaderAlignmentHorz = taCenter
          MinWidth = 50
          Options.Sorting = False
          Width = 60
        end
        object cxGridDBColumn10: TcxGridDBColumn
          Caption = #1050#1091#1088#1089
          DataBinding.FieldName = 'RATE'
          HeaderAlignmentHorz = taCenter
          MinWidth = 40
          Options.Sorting = False
          Width = 50
        end
        object cxGridDBColumn11: TcxGridDBColumn
          Caption = #1050#1086#1076' '#1088#1086#1076'.'
          DataBinding.FieldName = 'PARENTDOCID'
          Visible = False
          HeaderAlignmentHorz = taCenter
          MinWidth = 70
          Options.HorzSizing = False
          Width = 70
        end
        object cxGridDBColumn12: TcxGridDBColumn
          Caption = #1050#1091#1088#1089' USD'
          DataBinding.FieldName = 'RATEUSD'
          HeaderAlignmentHorz = taCenter
          MinWidth = 40
          Width = 60
        end
        object cxGridDBColumn13: TcxGridDBColumn
          Caption = #1041#1091#1093#1075
          DataBinding.FieldName = 'FLG_ACNT'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          HeaderAlignmentHorz = taCenter
          MinWidth = 40
          Options.HorzSizing = False
          Width = 40
        end
        object cxGridDBColumn14: TcxGridDBColumn
          AlternateCaption = #1054#1090#1075#1088#1091#1078#1077#1085
          Caption = #1054#1090#1075#1088'.'
          DataBinding.FieldName = 'FLG_SHIP'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          HeaderAlignmentHorz = taCenter
          MinWidth = 40
          Options.HorzSizing = False
          Width = 40
        end
        object cxGridDBColumn15: TcxGridDBColumn
          AlternateCaption = #1047#1072#1096#1080#1097#1077#1085
          Caption = #1047#1072#1096'.'
          DataBinding.FieldName = 'FLG_PROTECTED'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          HeaderAlignmentHorz = taCenter
          MinWidth = 40
          Options.HorzSizing = False
          Width = 40
        end
        object cxGridDBColumn16: TcxGridDBColumn
          DataBinding.FieldName = 'CUSTOMER_TYPE_ID'
          Visible = False
          VisibleForCustomization = False
        end
        object cxGridDBColumn17: TcxGridDBColumn
          Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
          DataBinding.FieldName = 'CREATED_BY_NAME'
          MinWidth = 80
          Width = 100
        end
        object cxGridDBColumn18: TcxGridDBColumn
          DataBinding.FieldName = 'CT'
          Visible = False
          VisibleForCustomization = False
        end
        object cxGridDBColumn19: TcxGridDBColumn
          DataBinding.FieldName = 'DT'
          Visible = False
          VisibleForCustomization = False
        end
      end
      object cxGridLevel1: TcxGridLevel
        GridView = cxGridDBTableView1
      end
    end
    object cxGrid2: TcxGrid
      Left = 20
      Top = 293
      Width = 857
      Height = 124
      TabOrder = 5
      LookAndFeel.NativeStyle = True
      LookAndFeel.SkinName = ''
      object cxGridDBTableView2: TcxGridDBTableView
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
        DataController.DataSource = IBCDataSourceChildDoc
        DataController.KeyFieldNames = 'DOCID'
        DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoFocusTopRowAfterSorting]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.IncSearch = True
        OptionsBehavior.ImmediateEditor = False
        OptionsCustomize.ColumnsQuickCustomization = True
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.InvertSelect = False
        OptionsView.CellEndEllipsis = True
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        OptionsView.GroupRowStyle = grsOffice11
        Styles.GroupByBox = dmAdditions.cxStyle_GridGroup
        Styles.Header = dmAdditions.cxStyle_GridHeader
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        object cxGridDBTableView2Column1: TcxGridDBColumn
          Caption = #1058#1080#1087' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
          DataBinding.FieldName = 'DOCTYPE_NAME'
          Width = 100
        end
        object cxGridDBColumn20: TcxGridDBColumn
          Caption = #1050#1086#1076
          DataBinding.FieldName = 'DOCID'
          HeaderAlignmentHorz = taCenter
          MinWidth = 50
          Width = 60
        end
        object cxGridDBColumn21: TcxGridDBColumn
          Caption = #8470
          DataBinding.FieldName = 'DOCNO'
          HeaderAlignmentHorz = taCenter
          MinWidth = 40
          Width = 50
        end
        object cxGridDBColumn22: TcxGridDBColumn
          Caption = #1044#1072#1090#1072
          DataBinding.FieldName = 'DATA'
          HeaderAlignmentHorz = taCenter
          MinWidth = 50
          Width = 80
        end
        object cxGridDBColumn23: TcxGridDBColumn
          Caption = #1044#1072#1090#1072' '#1089#1086#1079#1076#1072#1085#1080#1103
          DataBinding.FieldName = 'CREATED_DATE'
          HeaderAlignmentHorz = taCenter
          MinWidth = 50
          Width = 80
        end
        object cxGridDBColumn24: TcxGridDBColumn
          Caption = #1057#1082#1083#1072#1076
          DataBinding.FieldName = 'DTDEP_NAME'
          MinWidth = 60
          Width = 100
        end
        object cxGridDBColumn25: TcxGridDBColumn
          Caption = #1050#1086#1085#1090#1088#1072#1075#1077#1085#1090
          DataBinding.FieldName = 'CT_NAME'
          MinWidth = 140
          Styles.Content = dmAdditions.cxStyle_GridColumnBOLD
          Width = 200
        end
        object cxGridDBColumn26: TcxGridDBColumn
          Caption = #1057#1091#1084#1084#1072
          DataBinding.FieldName = 'SUMA'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          HeaderAlignmentHorz = taCenter
          MinWidth = 60
          Width = 80
        end
        object cxGridDBColumn27: TcxGridDBColumn
          Caption = #1042#1072#1083#1102#1090#1072
          DataBinding.FieldName = 'CURRENCY_NAME'
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taCenter
          HeaderAlignmentHorz = taCenter
          MinWidth = 50
          Width = 50
        end
        object cxGridDBColumn28: TcxGridDBColumn
          Caption = #1053#1044#1057
          DataBinding.FieldName = 'VAT'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          HeaderAlignmentHorz = taCenter
          MinWidth = 50
          Options.Sorting = False
          Width = 60
        end
        object cxGridDBColumn29: TcxGridDBColumn
          Caption = #1050#1091#1088#1089
          DataBinding.FieldName = 'RATE'
          HeaderAlignmentHorz = taCenter
          MinWidth = 40
          Options.Sorting = False
          Width = 50
        end
        object cxGridDBColumn30: TcxGridDBColumn
          Caption = #1050#1086#1076' '#1088#1086#1076'.'
          DataBinding.FieldName = 'PARENTDOCID'
          Visible = False
          HeaderAlignmentHorz = taCenter
          MinWidth = 70
          Options.HorzSizing = False
          Width = 70
        end
        object cxGridDBColumn31: TcxGridDBColumn
          Caption = #1050#1091#1088#1089' USD'
          DataBinding.FieldName = 'RATEUSD'
          HeaderAlignmentHorz = taCenter
          MinWidth = 40
          Width = 60
        end
        object cxGridDBColumn32: TcxGridDBColumn
          Caption = #1041#1091#1093#1075
          DataBinding.FieldName = 'FLG_ACNT'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          HeaderAlignmentHorz = taCenter
          MinWidth = 40
          Options.HorzSizing = False
          Width = 40
        end
        object cxGridDBColumn33: TcxGridDBColumn
          AlternateCaption = #1054#1090#1075#1088#1091#1078#1077#1085
          Caption = #1054#1090#1075#1088'.'
          DataBinding.FieldName = 'FLG_SHIP'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          HeaderAlignmentHorz = taCenter
          MinWidth = 40
          Options.HorzSizing = False
          Width = 40
        end
        object cxGridDBColumn34: TcxGridDBColumn
          AlternateCaption = #1047#1072#1096#1080#1097#1077#1085
          Caption = #1047#1072#1096'.'
          DataBinding.FieldName = 'FLG_PROTECTED'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          HeaderAlignmentHorz = taCenter
          MinWidth = 40
          Options.HorzSizing = False
          Width = 40
        end
        object cxGridDBColumn35: TcxGridDBColumn
          DataBinding.FieldName = 'CUSTOMER_TYPE_ID'
          Visible = False
          VisibleForCustomization = False
        end
        object cxGridDBColumn36: TcxGridDBColumn
          Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
          DataBinding.FieldName = 'CREATED_BY_NAME'
          MinWidth = 80
          Width = 100
        end
        object cxGridDBColumn37: TcxGridDBColumn
          DataBinding.FieldName = 'CT'
          Visible = False
          VisibleForCustomization = False
        end
        object cxGridDBColumn38: TcxGridDBColumn
          DataBinding.FieldName = 'DT'
          Visible = False
          VisibleForCustomization = False
        end
      end
      object cxGridLevel2: TcxGridLevel
        GridView = cxGridDBTableView2
      end
    end
    object pnCurrDoc: TPanel
      Left = 20
      Top = 136
      Width = 857
      Height = 19
      BevelOuter = bvNone
      Color = 16744448
      Padding.Left = 4
      Padding.Top = 2
      Padding.Right = 100
      Padding.Bottom = 2
      ParentBackground = False
      TabOrder = 2
      object Label1: TLabel
        Left = 4
        Top = 2
        Width = 753
        Height = 15
        Align = alClient
        Caption = #1044#1086#1082#1091#1084#1077#1085#1090
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlCenter
        ExplicitWidth = 57
      end
    end
    object Panel1: TPanel
      Left = 20
      Top = 272
      Width = 857
      Height = 19
      BevelOuter = bvNone
      Color = 16384
      Padding.Left = 4
      Padding.Top = 2
      Padding.Right = 100
      Padding.Bottom = 2
      ParentBackground = False
      TabOrder = 4
      object Label4: TLabel
        Left = 4
        Top = 2
        Width = 753
        Height = 15
        Align = alClient
        Caption = #1055#1086#1090#1086#1084#1082#1080
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlCenter
        ExplicitWidth = 52
      end
    end
    object Panel2: TPanel
      Left = 20
      Top = 12
      Width = 857
      Height = 19
      BevelOuter = bvNone
      Color = 21414
      Padding.Left = 4
      Padding.Top = 2
      Padding.Right = 100
      Padding.Bottom = 2
      ParentBackground = False
      TabOrder = 0
      object Label3: TLabel
        Left = 4
        Top = 2
        Width = 753
        Height = 15
        Align = alClient
        Caption = #1056#1086#1076#1080#1090#1077#1083#1100
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlCenter
        ExplicitWidth = 55
      end
    end
  end
  object btnClose: TButton
    Left = 804
    Top = 528
    Width = 90
    Height = 29
    Cancel = True
    Caption = #1047#1072#1082#1088#1099#1090#1100
    ModalResult = 2
    TabOrder = 2
  end
  object IBCQueryCurrDoc: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      'SELECT'
      '*'
      'FROM VW_TDB_DOCS'
      'WHERE (DOCID=:id)')
    ReadOnly = True
    Left = 252
    Top = 240
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        Value = nil
      end>
  end
  object IBCDataSourceCurrDoc: TIBCDataSource
    DataSet = IBCQueryCurrDoc
    Left = 252
    Top = 296
  end
  object IBCQueryParentDoc: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      'SELECT'
      '*'
      'FROM VW_TDB_DOCS')
    MasterFields = 'PARENTDOCID'
    DetailFields = 'DOCID'
    MasterSource = IBCDataSourceCurrDoc
    ReadOnly = True
    Left = 232
    Top = 92
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PARENTDOCID'
        Value = nil
      end>
  end
  object IBCDataSourceParentDoc: TIBCDataSource
    DataSet = IBCQueryParentDoc
    Left = 352
    Top = 92
  end
  object IBCQueryChildDoc: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      'SELECT'
      '*'
      'FROM VW_TDB_DOCS')
    MasterFields = 'DOCID'
    DetailFields = 'PARENTDOCID'
    MasterSource = IBCDataSourceCurrDoc
    ReadOnly = True
    Left = 92
    Top = 488
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DOCID'
        Value = nil
      end>
  end
  object IBCDataSourceChildDoc: TIBCDataSource
    DataSet = IBCQueryChildDoc
    Left = 92
    Top = 540
  end
  object dxBarManager: TdxBarManager
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
    ImageOptions.StretchGlyphs = False
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 464
    Top = 16
    PixelsPerInch = 96
    object bbGotoFromCurrentDoc: TdxBarButton
      Caption = #1055#1077#1088#1077#1081#1090#1080' '#1082' '#1076#1086#1082#1091#1084#1077#1085#1090#1091
      Category = 0
      Hint = #1055#1077#1088#1077#1081#1090#1080' '#1082' '#1076#1086#1082#1091#1084#1077#1085#1090#1091
      Visible = ivAlways
      ImageIndex = 7
      OnClick = bbGotoFromCurrentDocClick
    end
    object bbGotoFromChild: TdxBarButton
      Caption = #1055#1077#1088#1077#1081#1090#1080' '#1082' '#1076#1086#1082#1091#1084#1077#1085#1090#1091
      Category = 0
      Hint = #1055#1077#1088#1077#1081#1090#1080' '#1082' '#1076#1086#1082#1091#1084#1077#1085#1090#1091
      Visible = ivAlways
      ImageIndex = 7
      OnClick = bbGotoFromChildClick
    end
    object bbInspectChild: TdxBarButton
      Caption = #1048#1085#1089#1087#1077#1082#1090#1080#1088#1086#1074#1072#1090#1100
      Category = 0
      Hint = #1048#1085#1089#1087#1077#1082#1090#1080#1088#1086#1074#1072#1090#1100
      Visible = ivAlways
      ImageIndex = 4
      OnClick = bbInspectChildClick
    end
    object bbGotoFromParent: TdxBarButton
      Caption = #1055#1077#1088#1077#1081#1090#1080' '#1082' '#1076#1086#1082#1091#1084#1077#1085#1090#1091
      Category = 0
      Hint = #1055#1077#1088#1077#1081#1090#1080' '#1082' '#1076#1086#1082#1091#1084#1077#1085#1090#1091
      Visible = ivAlways
      ImageIndex = 7
      OnClick = bbGotoFromParentClick
    end
    object bbInspectParent: TdxBarButton
      Caption = #1048#1085#1089#1087#1077#1082#1090#1080#1088#1086#1074#1072#1090#1100
      Category = 0
      Hint = #1048#1085#1089#1087#1077#1082#1090#1080#1088#1086#1074#1072#1090#1100
      Visible = ivAlways
      ImageIndex = 4
      OnClick = bbInspectParentClick
    end
  end
  object cxGridPopupMenuCurrDoc: TcxGridPopupMenu
    Grid = cxGridNPN
    PopupMenus = <
      item
        GridView = cxGridNPNTable
        HitTypes = [gvhtCell, gvhtRecord]
        Index = 0
        PopupMenu = dxBarPopupMenuCurrDoc
      end>
    Left = 404
    Top = 256
  end
  object dxBarPopupMenuCurrDoc: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbGotoFromCurrentDoc'
      end>
    UseOwnFont = False
    Left = 528
    Top = 252
    PixelsPerInch = 96
  end
  object dxBarPopupMenuChild: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbGotoFromChild'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbInspectChild'
      end>
    UseOwnFont = False
    Left = 544
    Top = 408
    PixelsPerInch = 96
  end
  object dxBarPopupMenuParent: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbGotoFromParent'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbInspectParent'
      end>
    UseOwnFont = False
    Left = 584
    Top = 104
    PixelsPerInch = 96
  end
  object cxGridPopupMenuChildDoc: TcxGridPopupMenu
    Grid = cxGrid2
    PopupMenus = <
      item
        GridView = cxGridDBTableView2
        HitTypes = [gvhtCell, gvhtRecord]
        Index = 0
        PopupMenu = dxBarPopupMenuChild
      end>
    Left = 300
    Top = 408
  end
  object cxGridPopupMenuParentDoc: TcxGridPopupMenu
    Grid = cxGrid1
    PopupMenus = <
      item
        GridView = cxGridDBTableView1
        HitTypes = [gvhtCell, gvhtRecord]
        Index = 0
        PopupMenu = dxBarPopupMenuParent
      end>
    Left = 480
    Top = 100
  end
end
