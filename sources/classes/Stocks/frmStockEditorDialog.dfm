object frmStockEditorDlg: TfrmStockEditorDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1057#1082#1083#1072#1076
  ClientHeight = 599
  ClientWidth = 526
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    526
    599)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 526
    Height = 64
    Title = #1057#1082#1083#1072#1076
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
    ImageIndex = 15
  end
  object cxPageControl1: TcxPageControl
    Left = 8
    Top = 70
    Width = 593
    Height = 475
    TabOrder = 1
    Properties.ActivePage = tbsAccess
    Properties.CustomButtons.Buttons = <>
    ClientRectBottom = 471
    ClientRectLeft = 4
    ClientRectRight = 589
    ClientRectTop = 26
    object tbsGeneral: TcxTabSheet
      Caption = #1054#1073#1097#1080#1077
      ImageIndex = 0
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object cxLabel1: TLabel
        Left = 12
        Top = 16
        Width = 52
        Height = 15
        Caption = #1053#1072#1079#1074#1072#1085#1080#1077
      end
      object cxLabel2: TLabel
        Left = 12
        Top = 76
        Width = 55
        Height = 15
        Caption = #1054#1087#1080#1089#1072#1085#1080#1077
      end
      object edTitle: TcxDBTextEdit
        Left = 12
        Top = 33
        DataBinding.DataField = 'TITLE'
        TabOrder = 0
        Width = 441
      end
      object edDescription: TcxDBMemo
        Left = 12
        Top = 92
        DataBinding.DataField = 'DESCRIPTION'
        Properties.ScrollBars = ssVertical
        Properties.VisibleLineCount = 4
        TabOrder = 1
        Width = 441
      end
      object cbFLG_VISISIBLE_FOR_SALE: TcxDBCheckBox
        Left = 12
        Top = 184
        Caption = #1057#1082#1083#1072#1076' '#1074#1080#1076#1077#1085' '#1076#1083#1103' '#1087#1088#1086#1076#1072#1078
        DataBinding.DataField = 'FLG_VISISIBLE_FOR_SALE'
        Properties.Alignment = taLeftJustify
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        TabOrder = 2
      end
      object cbFLG_ADMINISTRATIA: TcxDBCheckBox
        Left = 12
        Top = 213
        Caption = #1057#1082#1083#1072#1076' '#1074#1080#1076#1077#1085' '#1076#1083#1103' '#1072#1076#1084#1080#1085#1080#1089#1090#1088#1072#1094#1080#1080
        DataBinding.DataField = 'FLG_ADMINISTRATIA'
        Properties.Alignment = taLeftJustify
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        TabOrder = 3
      end
      object cbFLG_RMA: TcxDBCheckBox
        Left = 12
        Top = 242
        Caption = #1057#1082#1083#1072#1076' '#1074#1080#1076#1077#1085' '#1076#1083#1103' '#1088#1077#1084#1086#1085#1090#1072
        DataBinding.DataField = 'FLG_RMA'
        Properties.Alignment = taLeftJustify
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        TabOrder = 4
      end
    end
    object cxTabSheet2: TcxTabSheet
      Caption = #1060#1080#1088#1084#1099
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label1: TLabel
        Left = 12
        Top = 12
        Width = 334
        Height = 15
        Caption = #1042#1099#1073#1077#1088#1080#1090#1077' '#1092#1080#1088#1084#1099' '#1076#1083#1103' '#1082#1086#1090#1086#1088#1099#1093' '#1073#1091#1076#1077#1090' '#1076#1086#1089#1090#1091#1087#1077#1085' '#1076#1072#1085#1085#1099#1081' '#1086#1090#1095#1077#1090
      end
      object Label2: TLabel
        Left = 12
        Top = 47
        Width = 169
        Height = 15
        Caption = #1054#1090#1095#1077#1090' '#1076#1086#1089#1090#1091#1087#1077#1085' '#1076#1083#1103' '#1101#1090#1080#1093' '#1092#1080#1088#1084
        Transparent = True
      end
      object cxGridSelFirms: TcxGrid
        Left = 12
        Top = 64
        Width = 217
        Height = 369
        TabOrder = 0
        object cxGridSelFirmsTable: TcxGridTableView
          Navigator.Buttons.CustomButtons = <>
          ScrollbarAnnotations.CustomAnnotations = <>
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsSelection.MultiSelect = True
          OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
          OptionsView.ScrollBars = ssVertical
          OptionsView.ColumnAutoWidth = True
          OptionsView.GridLineColor = 13750737
          OptionsView.GridLines = glNone
          OptionsView.GroupByBox = False
          OptionsView.Header = False
          Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
          object cxGridSelFirms_IMG: TcxGridColumn
            PropertiesClassName = 'TcxImageComboBoxProperties'
            Properties.DefaultImageIndex = 11
            Properties.Images = dmAdditions.cxImageList_SWN
            Properties.Items = <>
            MinWidth = 26
            Options.ShowEditButtons = isebNever
            Options.HorzSizing = False
            Width = 26
          end
          object cxGridSelFirms_TITLE: TcxGridColumn
            SortIndex = 0
            SortOrder = soAscending
          end
          object cxGridSelFirms_ID: TcxGridColumn
            DataBinding.ValueType = 'Integer'
            Visible = False
          end
        end
        object cxGridSelFirmsLevel: TcxGridLevel
          GridView = cxGridSelFirmsTable
        end
      end
      object cxGridAvFirms: TcxGrid
        Left = 284
        Top = 64
        Width = 217
        Height = 369
        TabOrder = 3
        object cxGridAvFirmsTable: TcxGridTableView
          Navigator.Buttons.CustomButtons = <>
          ScrollbarAnnotations.CustomAnnotations = <>
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsSelection.MultiSelect = True
          OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
          OptionsView.ScrollBars = ssVertical
          OptionsView.ColumnAutoWidth = True
          OptionsView.GridLineColor = 13750737
          OptionsView.GridLines = glNone
          OptionsView.GroupByBox = False
          OptionsView.Header = False
          Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
          object cxGridAvFirms_IMG: TcxGridColumn
            PropertiesClassName = 'TcxImageComboBoxProperties'
            Properties.DefaultImageIndex = 11
            Properties.Images = dmAdditions.cxImageList_SWN
            Properties.Items = <>
            MinWidth = 26
            Options.ShowEditButtons = isebNever
            Options.HorzSizing = False
            Width = 26
          end
          object cxGridAvFirms_TITLE: TcxGridColumn
            SortIndex = 0
            SortOrder = soAscending
          end
          object cxGridAvFirms_ID: TcxGridColumn
            DataBinding.ValueType = 'Integer'
            Visible = False
          end
        end
        object cxGridAvFirmsLevel: TcxGridLevel
          GridView = cxGridAvFirmsTable
        end
      end
      object btnAddFirms: TcxButton
        Left = 241
        Top = 64
        Width = 33
        Height = 29
        Caption = '<'
        TabOrder = 1
        TabStop = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object btnRemoveFirms: TcxButton
        Left = 241
        Top = 99
        Width = 33
        Height = 29
        Caption = '>'
        TabOrder = 2
        TabStop = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
    end
    object tbsAccess: TcxTabSheet
      Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1080
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label3: TLabel
        Left = 12
        Top = 12
        Width = 419
        Height = 15
        Caption = 
          #1042#1099#1073#1077#1088#1080#1090#1077' '#1075#1088#1091#1087#1087#1099' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1077#1081' '#1076#1083#1103' '#1082#1086#1090#1086#1088#1099#1093' '#1073#1091#1076#1077#1090' '#1076#1086#1089#1090#1091#1087#1077#1085' '#1076#1072#1085#1085#1099#1081' ' +
          #1086#1090#1095#1077#1090
      end
      object cxLabel14: TLabel
        Left = 12
        Top = 47
        Width = 169
        Height = 15
        Caption = #1054#1090#1095#1077#1090' '#1076#1086#1089#1090#1091#1087#1077#1085' '#1076#1083#1103' '#1101#1090#1080#1093' '#1075#1088#1091#1087#1087
        Transparent = True
      end
      object cxGridUserGroups: TcxGrid
        Left = 12
        Top = 64
        Width = 217
        Height = 369
        TabOrder = 0
        object cxGridUserGroupsTable: TcxGridTableView
          OnDblClick = cxGridUserGroupsTableDblClick
          Navigator.Buttons.CustomButtons = <>
          ScrollbarAnnotations.CustomAnnotations = <>
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsSelection.MultiSelect = True
          OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
          OptionsView.ScrollBars = ssVertical
          OptionsView.ColumnAutoWidth = True
          OptionsView.GridLineColor = 13750737
          OptionsView.GridLines = glNone
          OptionsView.GroupByBox = False
          OptionsView.Header = False
          Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
          object cxGridUserGroups_IMAGE: TcxGridColumn
            PropertiesClassName = 'TcxImageComboBoxProperties'
            Properties.DefaultImageIndex = 15
            Properties.Images = dmAdditions.cxImageList_SWN
            Properties.Items = <>
            MinWidth = 26
            Options.ShowEditButtons = isebNever
            Options.HorzSizing = False
            Width = 26
          end
          object cxGridUserGroups_TITLE: TcxGridColumn
          end
          object cxGridUserGroups_GROUPID: TcxGridColumn
            DataBinding.ValueType = 'Integer'
            Visible = False
            SortIndex = 0
            SortOrder = soAscending
          end
        end
        object cxGridUserGroupsLevel: TcxGridLevel
          GridView = cxGridUserGroupsTable
        end
      end
      object cxGridAvailableUserGroups: TcxGrid
        Left = 284
        Top = 64
        Width = 217
        Height = 369
        TabOrder = 2
        object cxGridAUGTable: TcxGridTableView
          OnDblClick = cxGridAUGTableDblClick
          Navigator.Buttons.CustomButtons = <>
          ScrollbarAnnotations.CustomAnnotations = <>
          OnSelectionChanged = cxGridAUGTableSelectionChanged
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsSelection.MultiSelect = True
          OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
          OptionsView.ScrollBars = ssVertical
          OptionsView.ColumnAutoWidth = True
          OptionsView.GridLineColor = 13750737
          OptionsView.GridLines = glNone
          OptionsView.GroupByBox = False
          OptionsView.Header = False
          Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
          object cxGridAUG_IMAGE: TcxGridColumn
            PropertiesClassName = 'TcxImageComboBoxProperties'
            Properties.DefaultImageIndex = 15
            Properties.Images = dmAdditions.cxImageList_SWN
            Properties.Items = <>
            MinWidth = 26
            Options.ShowEditButtons = isebNever
            Options.HorzSizing = False
            Width = 26
          end
          object cxGridAUG_TITLE: TcxGridColumn
          end
          object cxGridAUG_GROUPID: TcxGridColumn
            DataBinding.ValueType = 'Integer'
            Visible = False
            SortIndex = 0
            SortOrder = soAscending
          end
        end
        object cxGridAUGLevel: TcxGridLevel
          GridView = cxGridAUGTable
        end
      end
      object btnAddUserGroup: TcxButton
        Left = 241
        Top = 64
        Width = 33
        Height = 29
        Caption = '<'
        TabOrder = 1
        TabStop = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        OnClick = btnAddUserGroupClick
      end
      object btnRemoveUserGroup: TcxButton
        Left = 241
        Top = 99
        Width = 33
        Height = 29
        Caption = '>'
        TabOrder = 3
        TabStop = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        OnClick = btnRemoveUserGroupClick
      end
    end
  end
  object btnOk: TcxButton
    Left = 312
    Top = 556
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = '&Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TcxButton
    Left = 416
    Top = 556
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
end
