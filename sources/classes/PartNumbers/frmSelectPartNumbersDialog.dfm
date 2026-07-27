object frmSelectPartsDlg: TfrmSelectPartsDlg
  Left = 0
  Top = 0
  ActiveControl = cxGridAParts
  BorderStyle = bsDialog
  Caption = 'Selectarea numarului de partida'
  ClientHeight = 587
  ClientWidth = 814
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    814
    587)
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 814
    Height = 64
    Title = 'Selectarea numarului de partida'
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
    ImageIndex = 17
  end
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 798
    Height = 453
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
    object cxLabel1: TLabel
      Left = 12
      Top = 19
      Width = 52
      Height = 15
      Caption = 'Denumire'
      Transparent = True
    end
    object cxLabel2: TLabel
      Left = 621
      Top = 19
      Width = 48
      Height = 15
      Caption = 'Cantitate'
      Transparent = True
    end
    object Label3: TLabel
      Left = 12
      Top = 54
      Width = 160
      Height = 15
      Caption = 'Numere de partide disponibile'
    end
    object Label4: TLabel
      Left = 378
      Top = 54
      Width = 148
      Height = 15
      Caption = 'Numere de partida selectate'
    end
    object sbAddPNs: TSpeedButton
      Left = 323
      Top = 70
      Width = 36
      Height = 29
      Caption = '>'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = sbAddPNsClick
    end
    object sbAddAllPNs: TSpeedButton
      Left = 323
      Top = 157
      Width = 36
      Height = 29
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1090#1088#1077#1073#1091#1077#1084#1086#1077' '#1082#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1087#1072#1088#1090#1080#1081#1085#1099#1093' '#1085#1086#1084#1077#1088#1086#1074' (Ctrl+Enter)'
      Caption = '=N'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = sbAddAllPNsClick
    end
    object sbRemovePNs: TSpeedButton
      Left = 323
      Top = 105
      Width = 36
      Height = 29
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1086#1076#1080#1085' '#1087#1072#1088#1090#1080#1081#1085#1099#1081' '#1085#1086#1084#1077#1088' (Del)'
      Caption = '<'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = sbRemovePNsClick
    end
    object sbRemoveAllPNs: TSpeedButton
      Left = 323
      Top = 192
      Width = 36
      Height = 29
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1087#1072#1088#1090#1080#1081#1085#1099#1081' '#1085#1086#1084#1077#1088' '#1087#1086#1083#1085#1086#1089#1090#1100#1102' (Ctrl+Del)'
      Caption = '<<'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = sbRemoveAllPNsClick
    end
    object sbAddCustomPNs: TSpeedButton
      Left = 323
      Top = 244
      Width = 36
      Height = 29
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' N-'#1086#1077' '#1082#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1087#1072#1088#1090#1080#1081#1085#1099#1093' '#1085#1086#1084#1077#1088#1086#1074' (F2)'
      Caption = '>?'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = sbAddCustomPNsClick
    end
    object lbInfo: TLabel
      Left = 12
      Top = 417
      Width = 761
      Height = 18
      Alignment = taCenter
      AutoSize = False
      Color = 28895
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = True
      Layout = tlCenter
    end
    object sbShowPNs: TSpeedButton
      Left = 306
      Top = 348
      Width = 68
      Height = 29
      Hint = #1055#1086#1082#1072#1079#1072#1090#1100' '#1076#1086#1089#1090#1091#1087#1085#1099#1077' '#1087#1072#1088#1090#1080#1081#1085#1099#1077' '#1085#1086#1084#1077#1088#1072
      Caption = 'Show PNs'
      ParentShowHint = False
      ShowHint = True
      OnClick = sbShowPNsClick
    end
    object edGOODS_NAME: TcxDBTextEdit
      Left = 155
      Top = 16
      TabStop = False
      DataBinding.DataField = 'GOODS_NAME'
      Properties.ReadOnly = True
      TabOrder = 1
      Width = 426
    end
    object cxGridAParts: TcxGrid
      AlignWithMargins = True
      Left = 12
      Top = 70
      Width = 290
      Height = 340
      Margins.Left = 0
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 0
      TabOrder = 3
      object cxGridAPartsTable: TcxGridTableView
        OnKeyDown = cxGridAPartsTableKeyDown
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        OnCellDblClick = cxGridAPartsTableCellDblClick
        OnFocusedRecordChanged = cxGridAPartsTableFocusedRecordChanged
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <
          item
            Format = '0.00'
            Kind = skSum
            Column = cxGridAParts_QTY
          end
          item
            Kind = skCount
            Column = cxGridAPartsTable_IMG
          end>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.IncSearch = True
        OptionsBehavior.ImmediateEditor = False
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnGrouping = False
        OptionsCustomize.ColumnMoving = False
        OptionsCustomize.ColumnSorting = False
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsSelection.InvertSelect = False
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
        OptionsView.ScrollBars = ssVertical
        OptionsView.ColumnAutoWidth = True
        OptionsView.Footer = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GridLines = glHorizontal
        OptionsView.GroupByBox = False
        Styles.OnGetContentStyle = cxGridAPartsTableStylesGetContentStyle
        Styles.Footer = dmAdditions.cxStyle_GridHeader
        Styles.Header = dmAdditions.cxStyle_GridHeader
        object cxGridAPartsTable_IMG: TcxGridColumn
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.DefaultImageIndex = 31
          Properties.Images = dmAdditions.cxImageList_SWN
          Properties.Items = <>
          FooterAlignmentHorz = taRightJustify
          MinWidth = 28
          Options.ShowEditButtons = isebNever
          Options.HorzSizing = False
          Width = 28
        end
        object cxGridAParts_PARTNO: TcxGridColumn
          Caption = 'Partida'
        end
        object cxGridAParts_QTY: TcxGridColumn
          Caption = 'Cant'
          DataBinding.ValueType = 'Float'
          PropertiesClassName = 'TcxCalcEditProperties'
          Properties.Alignment.Horz = taRightJustify
          FooterAlignmentHorz = taRightJustify
          HeaderAlignmentHorz = taCenter
          MinWidth = 70
          Options.HorzSizing = False
          SortIndex = 0
          SortOrder = soAscending
          Width = 70
        end
      end
      object cxGridAPartsLevel: TcxGridLevel
        GridView = cxGridAPartsTable
      end
    end
    object cxGridSParts: TcxGrid
      AlignWithMargins = True
      Left = 378
      Top = 70
      Width = 395
      Height = 340
      Margins.Left = 1
      Margins.Top = 1
      Margins.Right = 0
      Margins.Bottom = 0
      TabOrder = 4
      object cxGridSPartsTable: TcxGridTableView
        OnKeyDown = cxGridSPartsTableKeyDown
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        OnCellDblClick = cxGridSPartsTableCellDblClick
        OnFocusedRecordChanged = cxGridSPartsTableFocusedRecordChanged
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <
          item
            Format = '0.00'
            Kind = skSum
            Column = cxGridSPartsTable_QTY
          end
          item
            Kind = skCount
            Column = cxGridSPartsTable_IMG
          end>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.IncSearch = True
        OptionsBehavior.ImmediateEditor = False
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnGrouping = False
        OptionsCustomize.ColumnMoving = False
        OptionsCustomize.ColumnSorting = False
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsSelection.InvertSelect = False
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
        OptionsView.ScrollBars = ssVertical
        OptionsView.ColumnAutoWidth = True
        OptionsView.Footer = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GridLines = glHorizontal
        OptionsView.GroupByBox = False
        Styles.Footer = dmAdditions.cxStyle_GridHeader
        Styles.Header = dmAdditions.cxStyle_GridHeader
        object cxGridSPartsTable_IMG: TcxGridColumn
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.DefaultImageIndex = 31
          Properties.Images = dmAdditions.cxImageList_SWN
          Properties.Items = <>
          FooterAlignmentHorz = taRightJustify
          MinWidth = 28
          Options.ShowEditButtons = isebNever
          Options.HorzSizing = False
          Width = 28
        end
        object cxGridSPartsTable_PARTNO: TcxGridColumn
          Caption = 'Partida'
        end
        object cxGridSPartsTable_QTY: TcxGridColumn
          Caption = 'Cant'
          DataBinding.ValueType = 'Float'
          PropertiesClassName = 'TcxCalcEditProperties'
          Properties.Alignment.Horz = taRightJustify
          FooterAlignmentHorz = taRightJustify
          HeaderAlignmentHorz = taRightJustify
          MinWidth = 70
          Options.HorzSizing = False
          SortIndex = 0
          SortOrder = soAscending
          Width = 70
        end
        object cxGridSPartsTable_CREATED_BY: TcxGridColumn
          Caption = 'Utiliator'
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taRightJustify
          HeaderAlignmentHorz = taCenter
          Width = 50
        end
      end
      object cxGridSPartsLevel: TcxGridLevel
        GridView = cxGridSPartsTable
      end
    end
    object edGOODSID: TcxDBTextEdit
      Left = 101
      Top = 16
      TabStop = False
      DataBinding.DataField = 'GOODSID'
      Properties.ReadOnly = True
      TabOrder = 0
      Width = 52
    end
    object edQTY: TcxDBCalcEdit
      Left = 675
      Top = 16
      TabStop = False
      DataBinding.DataField = 'QTY'
      Properties.Alignment.Horz = taRightJustify
      Properties.ReadOnly = True
      Style.TextStyle = [fsBold]
      TabOrder = 2
      Width = 98
    end
  end
  object btnOk: TcxButton
    Left = 596
    Top = 542
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    TabOrder = 2
    OnClick = btnOkClick
  end
  object btnCancel: TcxButton
    Left = 692
    Top = 542
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
end
