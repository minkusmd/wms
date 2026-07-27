object frmPeriodsSecurityDlg: TfrmPeriodsSecurityDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1059#1087#1088#1072#1074#1083#1077#1085#1080#1077' '#1076#1086#1089#1090#1091#1087#1086#1084' '#1086#1090#1082#1088#1099#1090#1099#1093' '#1087#1077#1088#1080#1086#1076#1072#1093
  ClientHeight = 537
  ClientWidth = 533
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    533
    537)
  PixelsPerInch = 96
  TextHeight = 15
  object btnOk: TButton
    Left = 319
    Top = 494
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = '&Ok'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object btnCancel: TButton
    Left = 423
    Top = 494
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 1
  end
  object cxPageControl1: TcxPageControl
    Left = 8
    Top = 8
    Width = 516
    Height = 475
    TabOrder = 2
    Properties.ActivePage = tbsAccess
    Properties.CustomButtons.Buttons = <>
    ClientRectBottom = 471
    ClientRectLeft = 4
    ClientRectRight = 512
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
        Width = 42
        Height = 15
        Caption = #1055#1077#1088#1080#1086#1076
      end
      object cxLabel2: TLabel
        Left = 12
        Top = 76
        Width = 55
        Height = 15
        Caption = #1054#1087#1080#1089#1072#1085#1080#1077
      end
      object edDescription: TcxDBMemo
        Left = 12
        Top = 92
        DataBinding.DataField = 'DESCRIPTION'
        Properties.ScrollBars = ssVertical
        Properties.VisibleLineCount = 4
        TabOrder = 2
        Width = 481
      end
      object cxDBDateEdit1: TcxDBDateEdit
        Left = 12
        Top = 34
        DataBinding.DataField = 'DATA1'
        TabOrder = 0
        Width = 121
      end
      object cxDBDateEdit2: TcxDBDateEdit
        Left = 159
        Top = 34
        DataBinding.DataField = 'DATA2'
        TabOrder = 1
        Width = 121
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
        Width = 429
        Height = 15
        Caption = 
          #1042#1099#1073#1077#1088#1080#1090#1077' '#1075#1088#1091#1087#1087#1099' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1077#1081' '#1076#1083#1103' '#1082#1086#1090#1086#1088#1099#1093' '#1073#1091#1076#1077#1090' '#1076#1086#1089#1090#1091#1087#1077#1085' '#1076#1072#1085#1085#1099#1081' ' +
          #1087#1077#1088#1080#1086#1076
      end
      object cxLabel14: TLabel
        Left = 12
        Top = 47
        Width = 179
        Height = 15
        Caption = #1055#1077#1088#1080#1086#1076' '#1076#1086#1089#1090#1091#1087#1077#1085' '#1076#1083#1103' '#1101#1090#1080#1093' '#1075#1088#1091#1087#1087
        Transparent = True
      end
      object btnAddUserGroup: TButton
        Left = 241
        Top = 64
        Width = 33
        Height = 29
        Caption = '<'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        TabStop = False
        OnClick = btnAddUserGroupClick
      end
      object btnRemoveUserGroup: TButton
        Left = 241
        Top = 99
        Width = 33
        Height = 29
        Caption = '>'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        TabStop = False
        OnClick = btnRemoveUserGroupClick
      end
      object cxGridUserGroups: TcxGrid
        Left = 12
        Top = 64
        Width = 217
        Height = 369
        TabOrder = 2
        object cxGridUserGroupsTable: TcxGridTableView
          OnDblClick = cxGridUserGroupsTableDblClick
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
        TabOrder = 3
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
    end
  end
end
