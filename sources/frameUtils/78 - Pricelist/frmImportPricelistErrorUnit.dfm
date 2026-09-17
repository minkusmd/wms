object frmImportPricelistErrorDlg: TfrmImportPricelistErrorDlg
  Left = 0
  Top = 0
  Caption = 'Erori la importul pricelistului'
  ClientHeight = 520
  ClientWidth = 1000
  Color = clBtnFace
  Constraints.MinHeight = 300
  Constraints.MinWidth = 600
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnShow = FormShow
  TextHeight = 15
  object pnTop: TPanel
    Left = 0
    Top = 0
    Width = 1000
    Height = 52
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object lbSummary: TLabel
      Left = 12
      Top = 8
      Width = 120
      Height = 17
      Caption = '0 erori'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbHint: TLabel
      Left = 12
      Top = 29
      Width = 520
      Height = 15
      Caption =
        'Dublu-click pe o eroare pentru a merge la celula din tabel. Coloa' +
        'nele se pot sorta si filtra.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGrayText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
  end
  object cxGridErrors: TcxGrid
    AlignWithMargins = True
    Left = 8
    Top = 52
    Width = 984
    Height = 419
    Margins.Left = 8
    Margins.Top = 0
    Margins.Right = 8
    Margins.Bottom = 0
    Align = alClient
    TabOrder = 1
    object tvErrors: TcxGridTableView
      OnDblClick = tvErrorsDblClick
      Navigator.Buttons.CustomButtons = <>
      ScrollbarAnnotations.CustomAnnotations = <>
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsView.CellEndEllipsis = True
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      OptionsView.Indicator = True
      object tvErrorsStage: TcxGridColumn
        Caption = 'Etapa'
        HeaderAlignmentHorz = taCenter
        Width = 80
      end
      object tvErrorsRow: TcxGridColumn
        Caption = 'Rind'
        DataBinding.ValueType = 'Integer'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taRightJustify
        HeaderAlignmentHorz = taCenter
        SortIndex = 0
        SortOrder = soAscending
        Width = 55
      end
      object tvErrorsCode: TcxGridColumn
        Caption = 'Cod produs'
        HeaderAlignmentHorz = taCenter
        Width = 130
      end
      object tvErrorsColumn: TcxGridColumn
        Caption = 'Coloana'
        HeaderAlignmentHorz = taCenter
        Width = 110
      end
      object tvErrorsMessage: TcxGridColumn
        Caption = 'Eroare'
        HeaderAlignmentHorz = taCenter
        Width = 580
      end
      object tvErrorsCellColumn: TcxGridColumn
        DataBinding.ValueType = 'Integer'
        Visible = False
        VisibleForCustomization = False
      end
    end
    object lvErrors: TcxGridLevel
      GridView = tvErrors
    end
  end
  object pnBottom: TPanel
    Left = 0
    Top = 471
    Width = 1000
    Height = 49
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    DesignSize = (
      1000
      49)
    object btnCopy: TcxButton
      Left = 8
      Top = 10
      Width = 110
      Height = 29
      Caption = 'Copiaza'
      TabOrder = 0
      OnClick = btnCopyClick
    end
    object btnSave: TcxButton
      Left = 124
      Top = 10
      Width = 110
      Height = 29
      Caption = 'Salveaza...'
      TabOrder = 1
      OnClick = btnSaveClick
    end
    object btnClose: TcxButton
      Left = 902
      Top = 10
      Width = 90
      Height = 29
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Inchide'
      Default = True
      ModalResult = 2
      TabOrder = 2
    end
  end
end
