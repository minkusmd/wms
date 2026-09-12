object frmServiceRequestWarrantySelectGoodsFromSellDlg: TfrmServiceRequestWarrantySelectGoodsFromSellDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1042#1099#1073#1086#1088' '#1090#1086#1074#1072#1088#1072' '#1080#1079' '#1087#1088#1086#1076#1072#1085#1085#1099#1093
  ClientHeight = 489
  ClientWidth = 983
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  DesignSize = (
    983
    489)
  TextHeight = 15
  object Label1: TLabel
    Left = 16
    Top = 452
    Width = 251
    Height = 15
    Anchors = [akLeft, akBottom]
    Caption = #1042#1099#1073#1077#1088#1080#1090#1077' '#1090#1088#1077#1073#1091#1077#1084#1099#1077' '#1090#1086#1074#1072#1088#1099' '#1076#1083#1103' '#1076#1086#1073#1072#1074#1083#1077#1085#1080#1103
    ExplicitTop = 289
  end
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 983
    Height = 64
    Title = #1042#1099#1073#1086#1088' '#1090#1086#1074#1072#1088#1072' '#1080#1079' '#1087#1088#1086#1076#1072#1085#1085#1099#1093
    Text = #1042#1099#1073#1077#1088#1080#1090#1077' '#1090#1086#1074#1072#1088#1099' '#1076#1083#1103' '#1076#1086#1073#1072#1074#1083#1077#1085#1080#1103' '#1080#1079' '#1087#1088#1086#1076#1072#1085#1085#1099#1093' '#1082#1083#1080#1077#1085#1090#1091
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
    ImageIndex = 10
  end
  object cxGrid: TcxGrid
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 967
    Height = 363
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 1
    ExplicitLeft = 13
    object cxGridTable: TcxGridTableView
      OptionsBehavior.CopyCaptionsToClipboard = False
      OptionsBehavior.IncSearch = True
      OptionsCustomize.ColumnFiltering = False
      OptionsData.Deleting = False
      OptionsData.Inserting = False
      OptionsSelection.MultiSelect = True
      OptionsSelection.CheckBoxVisibility = [cbvDataRow, cbvColumnHeader]
      OptionsSelection.InvertSelect = False
      OptionsSelection.ShowCheckBoxesDynamically = True
      OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
      OptionsView.ScrollBars = ssVertical
      OptionsView.ColumnAutoWidth = True
      OptionsView.GridLineColor = 13750737
      OptionsView.GroupByBox = False
      OptionsView.Indicator = True
      Styles.OnGetContentStyle = cxGridTableStylesGetContentStyle
      Styles.Header = dmAdditions.cxStyle_GridHeader
      Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
      object cxGridTable_Check: TcxGridColumn
        DataBinding.ValueType = 'Boolean'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ImmediatePost = True
        MinWidth = 24
        Options.HorzSizing = False
        Width = 24
      end
      object cxGridTable_DOCID: TcxGridColumn
        Caption = 'DocID'
        HeaderAlignmentHorz = taCenter
        MinWidth = 72
        Options.Editing = False
        Options.HorzSizing = False
        Width = 72
      end
      object cxGridTable_Data: TcxGridColumn
        Caption = 'Data vinzarii'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        MinWidth = 100
        Options.Editing = False
        Options.HorzSizing = False
        Width = 100
      end
      object cxGridTable_GOODSID: TcxGridColumn
        Caption = 'Cod'
        DataBinding.ValueType = 'Integer'
        HeaderAlignmentHorz = taCenter
        MinWidth = 60
        Options.Editing = False
        Options.HorzSizing = False
        Width = 60
      end
      object cxGridTable_Title: TcxGridColumn
        Caption = 'Produs'
        Options.Editing = False
      end
      object cxGridTable_SN: TcxGridColumn
        Caption = 'Numar de serie'
        HeaderAlignmentHorz = taCenter
        MinWidth = 160
        Options.Editing = False
        Options.HorzSizing = False
        Width = 160
      end
      object cxGridTable_Exists: TcxGridColumn
        DataBinding.ValueType = 'Boolean'
        Visible = False
        Options.Editing = False
        VisibleForCustomization = False
      end
      object cxGridTable_Qty: TcxGridColumn
        Caption = 'Cant'
        DataBinding.ValueType = 'Float'
        HeaderAlignmentHorz = taCenter
        MinWidth = 48
        Options.Editing = False
        Options.HorzSizing = False
        Width = 48
      end
      object cxGridTable_PRICE: TcxGridColumn
        Caption = 'Pret'
        HeaderAlignmentHorz = taCenter
        MinWidth = 100
        Options.Editing = False
        Options.HorzSizing = False
        Width = 100
      end
    end
    object cxGridLevel: TcxGridLevel
      GridView = cxGridTable
    end
  end
  object btnOk: TButton
    Left = 778
    Top = 446
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
    Default = True
    ModalResult = 1
    TabOrder = 2
    OnClick = btnOkClick
  end
  object btnCancel: TButton
    Left = 874
    Top = 446
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
end
