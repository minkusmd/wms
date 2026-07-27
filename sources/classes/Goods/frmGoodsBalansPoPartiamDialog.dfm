object frmGoodsBalansPoPartiamDlg: TfrmGoodsBalansPoPartiamDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1041#1072#1083#1072#1085#1089' '#1087#1086' '#1087#1072#1088#1090#1080#1103#1084
  ClientHeight = 558
  ClientWidth = 1132
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
    Width = 1132
    Height = 64
    Title = #1041#1072#1083#1072#1085#1089' '#1087#1086' '#1087#1072#1088#1090#1080#1103#1084
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
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 1116
    Height = 433
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object pnLeft: TPanel
      Left = 0
      Top = 0
      Width = 265
      Height = 433
      Align = alLeft
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 0
      object Label1: TLabel
        Left = 0
        Top = 0
        Width = 33
        Height = 15
        Align = alTop
        Caption = #1057#1082#1083#1072#1076
      end
      object cxDBTreeList: TcxDBTreeList
        Left = 0
        Top = 15
        Width = 265
        Height = 418
        Align = alClient
        Bands = <
          item
          end>
        DataController.DataSource = IBCDataSourceStocks
        DataController.ImageIndexField = 'IMAGE_INDEX'
        DataController.ParentField = 'PARENTID'
        DataController.KeyField = 'STOCKID'
        DataController.StateIndexField = 'IMAGE_INDEX'
        Images = dmAdditions.cxImageList_SWN
        Navigator.Buttons.CustomButtons = <>
        OptionsBehavior.ChangeDelay = 1000
        OptionsBehavior.CopyCaptionsToClipboard = False
        OptionsData.Editing = False
        OptionsData.Deleting = False
        OptionsSelection.InvertSelect = False
        OptionsView.ScrollBars = ssVertical
        OptionsView.ColumnAutoWidth = True
        OptionsView.Headers = False
        RootValue = 0
        ScrollbarAnnotations.CustomAnnotations = <>
        TabOrder = 0
        OnFocusedNodeChanged = cxDBTreeListFocusedNodeChanged
        object cxDBTreeListcxDBTreeListColumn1: TcxDBTreeListColumn
          Visible = False
          DataBinding.FieldName = 'STOCKID'
          Width = 100
          Position.ColIndex = 0
          Position.RowIndex = 0
          Position.BandIndex = 0
          Summary.FooterSummaryItems = <>
          Summary.GroupFooterSummaryItems = <>
        end
        object cxDBTreeList1cxDBTreeListColumn1: TcxDBTreeListColumn
          DataBinding.FieldName = 'TITLE'
          Width = 100
          Position.ColIndex = 1
          Position.RowIndex = 0
          Position.BandIndex = 0
          Summary.FooterSummaryItems = <>
          Summary.GroupFooterSummaryItems = <>
        end
        object cxDBTreeListcxDBTreeListColumn2: TcxDBTreeListColumn
          Visible = False
          DataBinding.FieldName = 'FLG_FOLDER'
          Width = 100
          Position.ColIndex = 2
          Position.RowIndex = 0
          Position.BandIndex = 0
          Summary.FooterSummaryItems = <>
          Summary.GroupFooterSummaryItems = <>
        end
      end
    end
    object pnClientCenter: TPanel
      Left = 265
      Top = 0
      Width = 851
      Height = 433
      Align = alClient
      BevelOuter = bvNone
      Padding.Left = 4
      ShowCaption = False
      TabOrder = 1
      object Label2: TLabel
        Left = 4
        Top = 0
        Width = 106
        Height = 15
        Align = alTop
        Caption = #1041#1072#1083#1072#1085#1089' '#1087#1086' '#1087#1072#1088#1090#1080#1103#1084
      end
      object cxGridBP: TcxGrid
        Left = 4
        Top = 15
        Width = 847
        Height = 418
        Align = alClient
        TabOrder = 0
        object cxGridBPTable: TcxGridDBTableView
          OnKeyDown = cxGridBPTableKeyDown
          Navigator.Buttons.CustomButtons = <>
          ScrollbarAnnotations.CustomAnnotations = <>
          DataController.DataSource = IBCDataSourceBP
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsCustomize.ColumnsQuickCustomization = True
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.InvertSelect = False
          OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
          OptionsView.ScrollBars = ssVertical
          OptionsView.ColumnAutoWidth = True
          OptionsView.GridLineColor = 13750737
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          Styles.Header = dmAdditions.cxStyle_GridHeader
          Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
          object cxGridBP_DOCID: TcxGridDBColumn
            Caption = #1050#1086#1076' '#1076#1086#1082'.'
            DataBinding.FieldName = 'DOCID'
            HeaderAlignmentHorz = taCenter
            MinWidth = 60
            Options.HorzSizing = False
            Width = 60
          end
          object cxGridBP_DOCTYPE_TITLE: TcxGridDBColumn
            Caption = #1058#1080#1087' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
            DataBinding.FieldName = 'DOCTYPE_TITLE'
            Width = 80
          end
          object cxGridBP_DATA: TcxGridDBColumn
            Caption = #1044#1072#1090#1072
            DataBinding.FieldName = 'DATA'
            OnGetDisplayText = cxGridBP_DATAGetDisplayText
            HeaderAlignmentHorz = taCenter
            MinWidth = 100
            Options.HorzSizing = False
            Width = 100
          end
          object cxGridBP_CT_NAME: TcxGridDBColumn
            Caption = #1050#1086#1085#1090#1088#1072#1075#1077#1085#1090
            DataBinding.FieldName = 'CT_NAME'
            Width = 100
          end
          object cxGridBP_DTDEP_NAME: TcxGridDBColumn
            Caption = #1057#1082#1083#1072#1076' '#1092#1080#1088#1084#1099
            DataBinding.FieldName = 'DTDEP_NAME'
            Width = 70
          end
          object cxGridBP_CTDEP_NAME: TcxGridDBColumn
            Caption = #1057#1082#1083#1072#1076' '#1082#1086#1085#1090#1088#1072#1075#1077#1085#1090#1072
            DataBinding.FieldName = 'CTDEP_NAME'
            Width = 70
          end
          object cxGridBP_PARTNO: TcxGridDBColumn
            Caption = #1055#1072#1088#1090#1080#1081#1085#1099#1081' '#1085#1086#1084#1077#1088
            DataBinding.FieldName = 'PARTNO'
            HeaderAlignmentHorz = taCenter
            MinWidth = 120
            Options.HorzSizing = False
            Width = 120
          end
          object cxGridBP_QTY: TcxGridDBColumn
            Caption = #1050#1086#1083'-'#1074#1086
            DataBinding.FieldName = 'QTY'
            HeaderAlignmentHorz = taCenter
            MinWidth = 50
            Options.HorzSizing = False
            Width = 50
          end
          object cxGridBP_QTY_B: TcxGridDBColumn
            Caption = #1050#1086#1083'-'#1074#1086' '#1073#1093
            DataBinding.FieldName = 'QTY_B'
            HeaderAlignmentHorz = taCenter
            MinWidth = 60
            Options.HorzSizing = False
            Width = 60
          end
          object cxGridBP_DOCSIGN: TcxGridDBColumn
            Caption = #1047#1085#1072#1082
            DataBinding.FieldName = 'DOCSIGN_TEXT'
            PropertiesClassName = 'TcxLabelProperties'
            Properties.Alignment.Horz = taCenter
            HeaderAlignmentHorz = taCenter
            MinWidth = 34
            Options.HorzSizing = False
            Width = 34
          end
        end
        object cxGridBPLevel: TcxGridLevel
          GridView = cxGridBPTable
        end
      end
    end
  end
  object btnClose: TButton
    Left = 1022
    Top = 516
    Width = 90
    Height = 29
    Cancel = True
    Caption = #1047#1072#1082#1088#1099#1090#1100
    ModalResult = 2
    TabOrder = 2
  end
  object IBCQueryStocks: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT'
      ' STOCKID,'
      ' PARENTID,'
      ' TITLE,'
      ' FLG_VISISIBLE_FOR_SALE,'
      ' FLG_ADMINISTRATIA,'
      ' FLG_RMA,'
      ' FLG_FOLDER,'
      ' IIF(FLG_FOLDER=1,13,27) IMAGE_INDEX'
      'FROM VW_TS_STOCKS'
      'WHERE STOCKID>0')
    Left = 84
    Top = 124
  end
  object IBCDataSourceStocks: TIBCDataSource
    DataSet = IBCQueryStocks
    Left = 84
    Top = 184
  end
  object IBCQueryBP: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT'
      'DOCID,'
      'DATA,'
      'CT,'
      'DTDEP,'
      'CTDEP,'
      'PARTNO,'
      'A.DOCTYPEID,'
      'B.TITLE DOCTYPE_TITLE,'
      'DOCSIGN,'
      'QTY,'
      'QTY_B,'
      'C.DISPLAYNAME CT_NAME,'
      'D.TITLE DTDEP_NAME,'
      'E.TITLE CTDEP_NAME,'
      'IIF(DOCSIGN>0,'#39'+'#39','
      '    IIF(DOCSIGN<0,'#39'-'#39','#39#39')'
      '   ) DOCSIGN_TEXT'
      'FROM SP_BALLANCE_PARTNO(:DT,:DEP,:GOODSID) A'
      'INNER JOIN TS_DOCTYPES B ON B.DOCTYPEID = A.DOCTYPEID'
      'INNER JOIN TS_CUSTOMER C ON C.CUSTOMERID = A.CT'
      'INNER JOIN TS_STOCKS D ON D.STOCKID = A.DTDEP'
      'INNER JOIN TS_STOCKS E ON D.STOCKID = A.CTDEP')
    ReadOnly = True
    Left = 392
    Top = 184
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DT'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'DEP'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'GOODSID'
        Value = nil
      end>
  end
  object IBCDataSourceBP: TIBCDataSource
    DataSet = IBCQueryBP
    Left = 392
    Top = 240
  end
end
