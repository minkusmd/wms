object frmServiceRefRepairAimsLinkTaskTypeDlg: TfrmServiceRefRepairAimsLinkTaskTypeDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1058#1080#1087#1099' '#1079#1072#1076#1072#1095' '#1076#1083#1103' '#1094#1077#1083#1080' '#1088#1077#1084#1086#1085#1090#1072
  ClientHeight = 527
  ClientWidth = 737
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
    Width = 737
    Height = 64
    Title = #1058#1080#1087#1099' '#1079#1072#1076#1072#1095' '#1076#1083#1103' '#1094#1077#1083#1080' '#1088#1077#1084#1086#1085#1090#1072
    Text = #1042#1099#1073#1077#1088#1080#1090#1077' '#1082#1072#1082#1080#1077' '#1090#1080#1087#1099' '#1079#1072#1076#1072#1095' '#1076#1086#1089#1090#1091#1087#1085#1099' '#1076#1083#1103' '#1076#1072#1085#1085#1086#1081' '#1094#1077#1083#1080' '#1088#1077#1084#1086#1085#1090#1072
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
    ImageIndex = 32
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 721
    Height = 401
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
      Left = 20
      Top = 92
      Width = 129
      Height = 15
      Caption = #1042#1099#1073#1088#1072#1085#1085#1099#1077' '#1090#1080#1087#1099' '#1079#1072#1076#1072#1095
    end
    object Label2: TLabel
      Left = 412
      Top = 92
      Width = 125
      Height = 15
      Caption = #1044#1086#1089#1090#1091#1087#1085#1099#1077' '#1090#1080#1087#1099' '#1079#1072#1076#1072#1095
    end
    object sbAppend: TSpeedButton
      Left = 360
      Top = 132
      Width = 37
      Height = 33
      Caption = '<'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      OnClick = sbAppendClick
    end
    object sbRemove: TSpeedButton
      Left = 360
      Top = 171
      Width = 37
      Height = 33
      Caption = '>'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      OnClick = sbRemoveClick
    end
    object Label3: TLabel
      Left = 20
      Top = 20
      Width = 78
      Height = 15
      Caption = #1062#1077#1083#1100' '#1088#1077#1084#1086#1085#1090#1072
    end
    object cxGridS: TcxGrid
      Left = 20
      Top = 109
      Width = 325
      Height = 264
      TabOrder = 0
      object cxGridSTable: TcxGridTableView
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        OnFocusedRecordChanged = cxGridSTableFocusedRecordChanged
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        DataController.OnNewRecord = cxGridSTableDataControllerNewRecord
        DataController.OnDataChanged = cxGridSTableDataControllerDataChanged
        OptionsBehavior.CopyCaptionsToClipboard = False
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnGrouping = False
        OptionsCustomize.ColumnHorzSizing = False
        OptionsCustomize.ColumnMoving = False
        OptionsCustomize.ColumnSorting = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Inserting = False
        OptionsSelection.InvertSelect = False
        OptionsView.CellEndEllipsis = True
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        Styles.Header = dmAdditions.cxStyle_GridHeader
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        object cxGridS_ID: TcxGridColumn
          Visible = False
          VisibleForCustomization = False
        end
        object cxGridS_TITLE: TcxGridColumn
          Caption = #1058#1080#1087' '#1079#1072#1076#1072#1095#1080
          Options.Editing = False
        end
        object cxGridS_MUST: TcxGridColumn
          Caption = #1054#1073#1100#1103#1079#1072#1090#1077#1083#1077#1085
          DataBinding.ValueType = 'Integer'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.Alignment = taCenter
          Properties.UseAlignmentWhenInplace = True
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          HeaderAlignmentHorz = taCenter
          MinWidth = 80
          Options.HorzSizing = False
          Width = 80
        end
      end
      object cxGridSLevel: TcxGridLevel
        GridView = cxGridSTable
      end
    end
    object cxGridA: TcxGrid
      Left = 412
      Top = 109
      Width = 281
      Height = 264
      TabOrder = 1
      object cxGridATable: TcxGridTableView
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        OnCellDblClick = cxGridATableCellDblClick
        OnFocusedRecordChanged = cxGridATableFocusedRecordChanged
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.CopyCaptionsToClipboard = False
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnGrouping = False
        OptionsCustomize.ColumnHiding = True
        OptionsCustomize.ColumnMoving = False
        OptionsCustomize.ColumnSorting = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.InvertSelect = False
        OptionsView.CellEndEllipsis = True
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        Styles.Header = dmAdditions.cxStyle_GridHeader
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        object cxGridA_ID: TcxGridColumn
          Visible = False
          VisibleForCustomization = False
        end
        object cxGridA_TITLE: TcxGridColumn
          Caption = #1058#1080#1087' '#1079#1072#1076#1072#1095#1080
        end
      end
      object cxGridALevel: TcxGridLevel
        GridView = cxGridATable
      end
    end
    object edTITLE: TcxDBTextEdit
      Left = 20
      Top = 37
      TabStop = False
      DataBinding.DataField = 'TITLE'
      Properties.ReadOnly = True
      TabOrder = 2
      Width = 673
    end
  end
  object btnOk: TButton
    Left = 516
    Top = 484
    Width = 90
    Height = 29
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 624
    Top = 484
    Width = 90
    Height = 29
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
end
