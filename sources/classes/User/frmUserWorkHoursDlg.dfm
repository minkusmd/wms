object frmUserWorkHoursDialog: TfrmUserWorkHoursDialog
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1056#1072#1073#1086#1095#1080#1077' '#1095#1072#1089#1099
  ClientHeight = 392
  ClientWidth = 620
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    620
    392)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 620
    Height = 64
    Title = #1056#1072#1073#1086#1095#1080#1077' '#1095#1072#1089#1099
    Text = 
      #1059#1082#1072#1078#1080#1090#1077' '#1095#1072#1089#1099' '#1076#1086#1089#1090#1091#1087#1072' '#1080' '#1088#1072#1073#1086#1090#1099' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103' '#1076#1083#1103' '#1082#1072#1078#1076#1086#1075#1086' '#1076#1085#1103' '#1085#1077#1076#1077#1083 +
      #1080
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
    ImageIndex = 14
  end
  object btnOk: TcxButton
    Left = 406
    Top = 348
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = '&Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TcxButton
    Left = 510
    Top = 348
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 3
  end
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 604
    Height = 265
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    object Label1: TLabel
      AlignWithMargins = True
      Left = 12
      Top = 12
      Width = 576
      Height = 30
      Margins.Left = 12
      Margins.Top = 12
      Margins.Right = 12
      Margins.Bottom = 8
      Align = alTop
      Caption = 
        #1042#1099#1073#1077#1088#1080#1090#1077' '#1088#1072#1073#1086#1095#1080#1077' '#1076#1085#1080' '#1085#1077#1076#1077#1083#1080' '#1080' '#1091#1082#1072#1078#1080#1090#1077' '#1095#1072#1089#1099' '#1076#1086#1089#1090#1091#1087#1072' '#1080' '#1088#1072#1073#1086#1095#1080#1077' '#1095#1072#1089 +
        #1099'. '#1058#1086#1083#1100#1082#1086' '#1087#1086' '#1095#1072#1089#1072#1084' '#1076#1086#1089#1090#1091#1087#1072' '#1074#1086#1079#1084#1086#1078#1077#1085' '#1074#1093#1086#1076' '#1074' '#1089#1080#1089#1090#1077#1084#1091'. '#1055#1086' '#1088#1072#1073#1086#1095#1080#1084' '#1095 +
        #1072#1089#1072#1084' '#1089#1090#1088#1086#1080#1090#1089#1103' '#1089#1090#1072#1090#1080#1089#1090#1080#1082#1072' '#1087#1086#1089#1077#1097#1077#1085#1080#1103' '#1088#1072#1073#1086#1090#1099'.'
      WordWrap = True
      ExplicitWidth = 543
    end
    object cxGrid: TcxGrid
      AlignWithMargins = True
      Left = 12
      Top = 50
      Width = 576
      Height = 199
      Margins.Left = 12
      Margins.Top = 0
      Margins.Right = 12
      Margins.Bottom = 12
      Align = alClient
      TabOrder = 0
      object cxGridTable: TcxGridTableView
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnHorzSizing = False
        OptionsCustomize.ColumnMoving = False
        OptionsCustomize.ColumnSorting = False
        OptionsData.Deleting = False
        OptionsData.Inserting = False
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
        OptionsView.ScrollBars = ssNone
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        Styles.Header = dmAdditions.cxStyle_GridHeader
        object cxGridTable_ENABLED: TcxGridColumn
          Caption = #1056#1072#1073#1086#1095#1080#1081' '#1076#1077#1085#1100
          DataBinding.ValueType = 'Boolean'
          PropertiesClassName = 'TcxCheckBoxProperties'
          HeaderAlignmentHorz = taCenter
          MinWidth = 90
          Options.HorzSizing = False
          Width = 90
        end
        object cxGridTable_DAY: TcxGridColumn
          Caption = #1044#1077#1085#1100' '#1085#1077#1076#1077#1083#1080
          Options.Editing = False
          Styles.Content = dmAdditions.cxStyle_Bold
        end
        object cxGridTable_ACCESS_START: TcxGridColumn
          Caption = #1053#1072#1095#1072#1083#1086' '#1076#1086#1089#1090#1091#1087#1072
          DataBinding.ValueType = 'Integer'
          PropertiesClassName = 'TcxComboBoxProperties'
          Properties.DropDownListStyle = lsFixedList
          Properties.Items.Strings = (
            '0'
            '1'
            '2'
            '3'
            '4'
            '5'
            '6'
            '7'
            '8'
            '9'
            '10'
            '11'
            '12'
            '13'
            '14'
            '15')
          HeaderAlignmentHorz = taCenter
          MinWidth = 90
          Options.HorzSizing = False
          Width = 90
        end
        object cxGridTable_HOURSTART: TcxGridColumn
          Caption = #1053#1072#1095#1072#1083#1086' '#1088#1072#1073#1086#1090#1099
          DataBinding.ValueType = 'Integer'
          PropertiesClassName = 'TcxComboBoxProperties'
          Properties.DropDownListStyle = lsFixedList
          Properties.Items.Strings = (
            '8'
            '9'
            '10'
            '11'
            '12'
            '13'
            '14'
            '15')
          HeaderAlignmentHorz = taCenter
          MinWidth = 90
          Options.HorzSizing = False
          Width = 90
        end
        object cxGridTable_HOUREND: TcxGridColumn
          Caption = #1050#1086#1085#1077#1094' '#1088#1072#1073#1086#1090#1099
          DataBinding.ValueType = 'Integer'
          PropertiesClassName = 'TcxComboBoxProperties'
          Properties.DropDownListStyle = lsFixedList
          Properties.Items.Strings = (
            '13'
            '14'
            '15'
            '16'
            '17'
            '18'
            '19'
            '20'
            '21')
          HeaderAlignmentHorz = taCenter
          MinWidth = 90
          Options.HorzSizing = False
          Width = 90
        end
        object cxGridTable_ACCESS_END: TcxGridColumn
          Caption = #1050#1086#1085#1077#1094' '#1076#1086#1089#1090#1091#1087#1072
          DataBinding.ValueType = 'Integer'
          PropertiesClassName = 'TcxComboBoxProperties'
          Properties.DropDownListStyle = lsFixedList
          Properties.Items.Strings = (
            '13'
            '14'
            '15'
            '16'
            '17'
            '18'
            '19'
            '20'
            '21'
            '22'
            '23'
            '24')
          HeaderAlignmentHorz = taCenter
          MinWidth = 90
          Options.HorzSizing = False
          Width = 90
        end
      end
      object cxGridLevel: TcxGridLevel
        GridView = cxGridTable
      end
    end
  end
end
