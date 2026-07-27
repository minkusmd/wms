object frmFiscalPrinterSharingDlg: TfrmFiscalPrinterSharingDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Acces la MCC'
  ClientHeight = 381
  ClientWidth = 513
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
    Width = 513
    Height = 64
    Title = 'Acces la MCC'
    Text = 
      'Selectati calculatoarele de la care pot fi tiparite bonurile fis' +
      'cale'
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
    ImageIndex = 26
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 497
    Height = 257
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
    object Label1: TLabel
      Left = 16
      Top = 16
      Width = 104
      Height = 15
      Caption = 'Calculatoarele alese'
    end
    object Label2: TLabel
      Left = 272
      Top = 20
      Width = 129
      Height = 15
      Caption = 'Calculatoarele accesibile'
    end
    object sbAddToSelected: TSpeedButton
      Left = 229
      Top = 56
      Width = 32
      Height = 28
      Caption = '<'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      OnClick = sbAddToSelectedClick
    end
    object sbRemoveFromSelected: TSpeedButton
      Left = 229
      Top = 90
      Width = 32
      Height = 28
      Caption = '>'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      OnClick = sbRemoveFromSelectedClick
    end
    object cxGridSel: TcxGrid
      Left = 16
      Top = 37
      Width = 201
      Height = 200
      TabOrder = 0
      object cxGridSelTable: TcxGridTableView
        Navigator.Buttons.CustomButtons = <>
        OnFocusedRecordChanged = cxGridAvTableFocusedRecordChanged
        OnSelectionChanged = cxGridAvTableSelectionChanged
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnSorting = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsSelection.MultiSelect = True
        OptionsSelection.HideFocusRectOnExit = False
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
        OptionsView.ScrollBars = ssVertical
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        Styles.Header = dmAdditions.cxStyle_GridHeader
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        object cxGridSelTable_WSID: TcxGridColumn
          DataBinding.ValueType = 'Integer'
          Visible = False
          VisibleForCustomization = False
        end
        object cxGridSelTable_IMG: TcxGridColumn
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.Alignment.Horz = taCenter
          Properties.DefaultImageIndex = 44
          Properties.Images = dmAdditions.cxImageList_SWN
          Properties.Items = <>
          MinWidth = 24
          Options.HorzSizing = False
          Width = 24
        end
        object cxGridSelTable_TITLE: TcxGridColumn
          Caption = 'Nume calculator'
        end
      end
      object cxGridSelLevel: TcxGridLevel
        GridView = cxGridSelTable
      end
    end
    object cxGridAv: TcxGrid
      Left = 272
      Top = 37
      Width = 201
      Height = 200
      TabOrder = 1
      object cxGridAvTable: TcxGridTableView
        Navigator.Buttons.CustomButtons = <>
        OnFocusedRecordChanged = cxGridAvTableFocusedRecordChanged
        OnSelectionChanged = cxGridAvTableSelectionChanged
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsCustomize.ColumnFiltering = False
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
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        Styles.Header = dmAdditions.cxStyle_GridHeader
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        object cxGridAvTable_WSID: TcxGridColumn
          DataBinding.ValueType = 'Integer'
          Visible = False
          VisibleForCustomization = False
        end
        object cxGridAvTable_IMG: TcxGridColumn
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.Alignment.Horz = taCenter
          Properties.DefaultImageIndex = 44
          Properties.Images = dmAdditions.cxImageList_SWN
          Properties.Items = <>
          MinWidth = 24
          Options.HorzSizing = False
          Width = 24
        end
        object cxGridAvTable_TITLE: TcxGridColumn
          Caption = 'Nume calculator'
        end
      end
      object cxGridAvLevel: TcxGridLevel
        GridView = cxGridAvTable
      end
    end
  end
  object btnOk: TButton
    Left = 297
    Top = 340
    Width = 90
    Height = 29
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 401
    Top = 340
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
end
