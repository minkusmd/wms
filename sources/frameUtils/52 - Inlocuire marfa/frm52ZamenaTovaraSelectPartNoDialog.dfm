object frm52ZamenaTovaraSelectPartNoDlg: Tfrm52ZamenaTovaraSelectPartNoDlg
  Left = 0
  Top = 0
  ActiveControl = cxGridAParts
  BorderStyle = bsDialog
  Caption = 'Selectarea partidei'
  ClientHeight = 628
  ClientWidth = 469
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    469
    628)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 469
    Height = 64
    Title = 'Selectarea partidei'
    Text = 'Alege partida pentru produsul ales...'
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
  object btnOk: TButton
    Left = 251
    Top = 583
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    TabOrder = 2
    OnClick = btnOkClick
  end
  object btnCancel: TButton
    Left = 355
    Top = 583
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 453
    Height = 500
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
      Left = 20
      Top = 20
      Width = 92
      Height = 15
      Caption = 'Denumire produs'
      Transparent = True
    end
    object Label3: TLabel
      Left = 20
      Top = 111
      Width = 160
      Height = 15
      Caption = 'Numere de partide disponibile'
    end
    object cxGridAParts: TcxGrid
      AlignWithMargins = True
      Left = 20
      Top = 130
      Width = 405
      Height = 340
      Margins.Left = 0
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 0
      TabOrder = 1
      object cxGridAPartsTable: TcxGridTableView
        Navigator.Buttons.CustomButtons = <>
        OnCellDblClick = cxGridAPartsTableCellDblClick
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <
          item
            Format = '0'
            Kind = skSum
            Column = cxGridAParts_QTY
          end
          item
            Kind = skCount
            Column = cxGridAPartsTable_IMG
          end>
        DataController.Summary.SummaryGroups = <>
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnGrouping = False
        OptionsCustomize.ColumnMoving = False
        OptionsCustomize.ColumnSorting = False
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
        OptionsView.ScrollBars = ssVertical
        OptionsView.ColumnAutoWidth = True
        OptionsView.Footer = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GridLines = glHorizontal
        OptionsView.GroupByBox = False
        Styles.Header = dmAdditions.cxStyle_GridHeader
        object cxGridAPartsTable_IMG: TcxGridColumn
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.DefaultImageIndex = 31
          Properties.Images = dmAdditions.cxImageList_SWN
          Properties.Items = <>
          MinWidth = 24
          Options.ShowEditButtons = isebNever
          Options.HorzSizing = False
          Width = 24
        end
        object cxGridAParts_PARTNO: TcxGridColumn
          Caption = #1053#1086#1084#1077#1088' '#1087#1072#1088#1090#1080#1080
        end
        object cxGridAParts_QTY: TcxGridColumn
          Caption = #1050#1086#1083'-'#1074#1086
          DataBinding.ValueType = 'Integer'
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taRightJustify
          FooterAlignmentHorz = taRightJustify
          HeaderAlignmentHorz = taCenter
          MinWidth = 70
          Options.HorzSizing = False
          SortIndex = 0
          SortOrder = soAscending
          Width = 70
        end
        object cxGridAParts_COUNTRYID: TcxGridColumn
          DataBinding.ValueType = 'Integer'
          Visible = False
          VisibleForCustomization = False
        end
        object cxGridAParts_VENDORID: TcxGridColumn
          DataBinding.ValueType = 'Integer'
          Visible = False
          VisibleForCustomization = False
        end
      end
      object cxGridAPartsLevel: TcxGridLevel
        GridView = cxGridAPartsTable
      end
    end
    object mmInfo: TcxMemo
      Left = 20
      Top = 37
      TabStop = False
      Lines.Strings = (
        'mmInfo')
      Properties.ReadOnly = True
      Properties.ScrollBars = ssVertical
      TabOrder = 0
      Height = 49
      Width = 405
    end
  end
end
