object frmBPPLSelectCustomUSDRateDlg: TfrmBPPLSelectCustomUSDRateDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Alege rata $ din alt document'
  ClientHeight = 511
  ClientWidth = 695
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
  object DialogTitle1: TDialogTitle
    Left = 0
    Top = 0
    Width = 695
    Height = 64
    Title = 'Alege rata $ din alt document'
    Text = 'Alegeti documentul'
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
  object cxGrid: TcxGrid
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 679
    Height = 385
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    TabOrder = 1
    object cxGridTable: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = IBCDataSourceZP
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.IncSearch = True
      OptionsBehavior.ImmediateEditor = False
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
      OptionsView.ScrollBars = ssVertical
      OptionsView.ColumnAutoWidth = True
      OptionsView.GridLineColor = 13750737
      OptionsView.GroupByBox = False
      OptionsView.GroupRowStyle = grsOffice11
      OptionsView.Indicator = True
      Styles.Group = dmAdditions.cxStyle_Bold
      Styles.GroupByBox = dmAdditions.cxStyle_GridGroup
      Styles.Header = dmAdditions.cxStyle_GridHeader
      object cxGrid_DOCID: TcxGridDBColumn
        Caption = 'DocID'
        DataBinding.FieldName = 'DOCID'
        HeaderAlignmentHorz = taCenter
        MinWidth = 60
        Options.Filtering = False
        Options.IncSearch = False
        Options.HorzSizing = False
        Width = 60
      end
      object cxGrid_DOCTYPENAME: TcxGridDBColumn
        Caption = 'Operatia'
        DataBinding.FieldName = 'DOCTYPE_NAME'
        MinWidth = 160
        Width = 200
      end
      object cxGrid_DATA: TcxGridDBColumn
        Caption = 'Data'
        DataBinding.FieldName = 'DATA'
        HeaderAlignmentHorz = taCenter
        MinWidth = 120
        Options.IncSearch = False
        Options.HorzSizing = False
        Width = 120
      end
      object cxGrid_RATEUSD: TcxGridDBColumn
        Caption = 'Curs $'
        DataBinding.FieldName = 'RATEUSD'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        MinWidth = 60
        Options.Filtering = False
        Options.IncSearch = False
        Options.HorzSizing = False
        Width = 60
      end
      object cxGrid_CREATED_BY_NAME: TcxGridDBColumn
        Caption = 'Create de'
        DataBinding.FieldName = 'CREATED_BY_NAME'
        HeaderAlignmentHorz = taCenter
        Width = 120
      end
      object cxGrid_DATE_ONLY: TcxGridDBColumn
        DataBinding.FieldName = 'DATE_ONLY'
        Visible = False
        GroupIndex = 0
        Options.ShowCaption = False
        SortIndex = 0
        SortOrder = soDescending
        VisibleForCustomization = False
        IsCaptionAssigned = True
      end
    end
    object cxGridLevel: TcxGridLevel
      GridView = cxGridTable
    end
  end
  object btnOk: TButton
    Left = 476
    Top = 468
    Width = 90
    Height = 29
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 580
    Top = 468
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
  object IBCQueryZP: TIBCQuery
    SQL.Strings = (
      'SELECT'
      
        ' DOCID, DATA, DT, RATEUSD, CREATED_BY, CREATED_BY_NAME, CAST(DAT' +
        'A AS DATE) DATE_ONLY,'
      ' DOCTYPE_NAME'
      'FROM'
      ' VW_TDB_DOCS'
      'WHERE'
      ' (DOCTYPEID in (106,109, 1514)) AND (DT=:currFirma)'
      'ORDER BY DATA DESC')
    Left = 72
    Top = 284
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'currFirma'
        Value = nil
      end>
  end
  object IBCDataSourceZP: TIBCDataSource
    DataSet = IBCQueryZP
    Left = 72
    Top = 228
  end
end
