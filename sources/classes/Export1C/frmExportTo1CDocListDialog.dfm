object frmExportTo1CDocListDlg: TfrmExportTo1CDocListDlg
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Resultatul exportului de documente'
  ClientHeight = 576
  ClientWidth = 646
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 646
    Height = 64
    Title = 'Lista documentelor'
    Text = 'Double-click to open selected document'
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
    ImageIndex = 11
  end
  object PageControl1: TPageControl
    AlignWithMargins = True
    Left = 0
    Top = 72
    Width = 646
    Height = 504
    Margins.Left = 0
    Margins.Top = 8
    Margins.Right = 0
    Margins.Bottom = 0
    ActivePage = tbsNotExported
    Align = alClient
    Images = dmAdditions.cxImageList_SWN
    TabOrder = 1
    object tbsExported: TTabSheet
      Caption = 'Documente exportate'
      ImageIndex = 43
      ExplicitLeft = 0
      ExplicitTop = 26
      ExplicitWidth = 0
      ExplicitHeight = 474
      object cxGridExp: TcxGrid
        Left = 0
        Top = 0
        Width = 638
        Height = 473
        Align = alClient
        TabOrder = 0
        ExplicitHeight = 474
        object cxGridExpTable: TcxGridDBTableView
          OnKeyDown = cxGridTableKeyDown
          Navigator.Buttons.CustomButtons = <>
          OnCellDblClick = cxGridTableCellDblClick
          OnCustomDrawCell = cxGridTableCustomDrawCell
          DataController.DataSource = IBCDataSourceExp
          DataController.KeyFieldNames = 'DOCID'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <
            item
              Kind = skCount
              Column = cxGridDBColumn1
            end>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.ImmediateEditor = False
          OptionsCustomize.ColumnFiltering = False
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.InvertSelect = False
          OptionsView.CellEndEllipsis = True
          OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
          OptionsView.ScrollBars = ssVertical
          OptionsView.ColumnAutoWidth = True
          OptionsView.Footer = True
          OptionsView.GridLineColor = 13750737
          OptionsView.GroupRowStyle = grsOffice11
          OptionsView.Indicator = True
          Styles.GroupByBox = dmAdditions.cxStyle_GridGroup
          Styles.Header = dmAdditions.cxStyle_GridHeader
          object cxGridDBColumn1: TcxGridDBColumn
            Caption = 'Cod'
            DataBinding.FieldName = 'DOCID'
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            MinWidth = 60
            Options.HorzSizing = False
            Width = 60
          end
          object cxGridDBColumn2: TcxGridDBColumn
            Caption = 'Data'
            DataBinding.FieldName = 'DATA'
            OnGetDisplayText = cxGridTable_DATAGetDisplayText
            HeaderAlignmentHorz = taCenter
            MinWidth = 100
            Options.HorzSizing = False
            Width = 100
          end
          object cxGridDBColumn3: TcxGridDBColumn
            DataBinding.FieldName = 'DT'
            Visible = False
            VisibleForCustomization = False
          end
          object cxGridDBColumn4: TcxGridDBColumn
            Caption = 'Intreprinderea'
            DataBinding.FieldName = 'DT_NAME'
            Visible = False
            GroupIndex = 0
          end
          object cxGridDBColumn5: TcxGridDBColumn
            DataBinding.FieldName = 'CT'
            Visible = False
            VisibleForCustomization = False
          end
          object cxGridDBColumn6: TcxGridDBColumn
            Caption = 'Client'
            DataBinding.FieldName = 'CT_NAME'
          end
          object cxGridDBColumn7: TcxGridDBColumn
            Caption = 'Suma'
            DataBinding.FieldName = 'SUMA'
            HeaderAlignmentHorz = taCenter
            MinWidth = 80
            Options.HorzSizing = False
            Width = 80
          end
          object cxGridDBColumn8: TcxGridDBColumn
            Caption = 'Cntb'
            DataBinding.FieldName = 'FLG_ACNT'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ValueChecked = 1
            Properties.ValueUnchecked = 0
            HeaderAlignmentHorz = taCenter
            MinWidth = 40
            Options.HorzSizing = False
            Width = 40
          end
          object cxGridDBColumn9: TcxGridDBColumn
            Caption = 'Inchis'
            DataBinding.FieldName = 'FLG_CLOSED'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ValueChecked = 1
            Properties.ValueUnchecked = 0
            HeaderAlignmentHorz = taCenter
            MinWidth = 40
            Options.HorzSizing = False
            Width = 40
          end
          object cxGridDBColumn10: TcxGridDBColumn
            DataBinding.FieldName = 'DOCTYPEID'
            Visible = False
            VisibleForCustomization = False
          end
          object cxGridDBColumn11: TcxGridDBColumn
            Caption = 'Tip document'
            DataBinding.FieldName = 'DOCTYPE_NAME'
            Visible = False
            GroupIndex = 1
          end
        end
        object cxGridLevelExp: TcxGridLevel
          GridView = cxGridExpTable
        end
      end
    end
    object tbsNotExported: TTabSheet
      Caption = 'Documente cu erori'
      ImageIndex = 42
      ExplicitLeft = 0
      ExplicitTop = 26
      ExplicitWidth = 0
      ExplicitHeight = 474
      object cxGrid: TcxGrid
        Left = 0
        Top = 0
        Width = 638
        Height = 473
        Align = alClient
        TabOrder = 0
        ExplicitHeight = 474
        object cxGridTable: TcxGridDBTableView
          OnKeyDown = cxGridTableKeyDown
          Navigator.Buttons.CustomButtons = <>
          OnCellDblClick = cxGridTableCellDblClick
          OnCustomDrawCell = cxGridTableCustomDrawCell
          DataController.DataSource = IBCDataSourceDocs
          DataController.KeyFieldNames = 'DOCID'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <
            item
              Kind = skCount
              Column = cxGridTable_DOCID
            end>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.ImmediateEditor = False
          OptionsCustomize.ColumnFiltering = False
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.InvertSelect = False
          OptionsView.CellEndEllipsis = True
          OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
          OptionsView.ScrollBars = ssVertical
          OptionsView.ColumnAutoWidth = True
          OptionsView.Footer = True
          OptionsView.GridLineColor = 13750737
          OptionsView.GroupRowStyle = grsOffice11
          OptionsView.Indicator = True
          Styles.GroupByBox = dmAdditions.cxStyle_GridGroup
          Styles.Header = dmAdditions.cxStyle_GridHeader
          object cxGridTable_DOCID: TcxGridDBColumn
            Caption = 'Cod'
            DataBinding.FieldName = 'DOCID'
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            MinWidth = 60
            Options.HorzSizing = False
            Width = 60
          end
          object cxGridTable_DATA: TcxGridDBColumn
            Caption = 'Data'
            DataBinding.FieldName = 'DATA'
            OnGetDisplayText = cxGridTable_DATAGetDisplayText
            HeaderAlignmentHorz = taCenter
            MinWidth = 100
            Options.HorzSizing = False
            Width = 100
          end
          object cxGridTable_DT: TcxGridDBColumn
            DataBinding.FieldName = 'DT'
            Visible = False
            VisibleForCustomization = False
          end
          object cxGridTable_DT_NAME: TcxGridDBColumn
            Caption = 'Intreprinderea'
            DataBinding.FieldName = 'DT_NAME'
            Visible = False
            GroupIndex = 0
          end
          object cxGridTable_CT: TcxGridDBColumn
            DataBinding.FieldName = 'CT'
            Visible = False
            VisibleForCustomization = False
          end
          object cxGridTable_CT_NAME: TcxGridDBColumn
            Caption = 'Client'
            DataBinding.FieldName = 'CT_NAME'
          end
          object cxGridTable_SUMA: TcxGridDBColumn
            Caption = 'Suma'
            DataBinding.FieldName = 'SUMA'
            HeaderAlignmentHorz = taCenter
            MinWidth = 80
            Options.HorzSizing = False
            Width = 80
          end
          object cxGridTable_FLG_ACNT: TcxGridDBColumn
            Caption = 'Cntb'
            DataBinding.FieldName = 'FLG_ACNT'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ValueChecked = 1
            Properties.ValueUnchecked = 0
            HeaderAlignmentHorz = taCenter
            MinWidth = 40
            Options.HorzSizing = False
            Width = 40
          end
          object cxGridTable_FLG_CLOSED: TcxGridDBColumn
            Caption = 'Inchis'
            DataBinding.FieldName = 'FLG_CLOSED'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ValueChecked = 1
            Properties.ValueUnchecked = 0
            HeaderAlignmentHorz = taCenter
            MinWidth = 40
            Options.HorzSizing = False
            Width = 40
          end
          object cxGridTable_DOCTYPEID: TcxGridDBColumn
            DataBinding.FieldName = 'DOCTYPEID'
            Visible = False
            VisibleForCustomization = False
          end
          object cxGridTable_DOCTYPE_NAME: TcxGridDBColumn
            Caption = 'Tip document'
            DataBinding.FieldName = 'DOCTYPE_NAME'
            Visible = False
            GroupIndex = 1
          end
        end
        object cxGridLevel: TcxGridLevel
          GridView = cxGridTable
        end
      end
    end
  end
  object IBCQueryDocs: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT'
      '*'
      'FROM SP_EXPORT_1C_UNEXPORTED_DOCS'
      '('
      
        ' :DATE1, :DATE2, :EXPORTED_DOCS_LIST, :DT_LIST, :CT_LIST, :FLG_E' +
        'XPORT_SF, :FLG_EXPORT_CEK, :FLG_EXPORT_PRIHOD, :FLG_EXPORT_PER, ' +
        ':DOC_LIST'
      ')'
      'ORDER BY DT_NAME,DOCID')
    ReadOnly = True
    Left = 592
    Top = 280
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DATE1'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'DATE2'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'EXPORTED_DOCS_LIST'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'DT_LIST'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'CT_LIST'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'FLG_EXPORT_SF'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'FLG_EXPORT_CEK'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'FLG_EXPORT_PRIHOD'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'FLG_EXPORT_PER'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'DOC_LIST'
        Value = nil
      end>
  end
  object IBCDataSourceDocs: TIBCDataSource
    DataSet = IBCQueryDocs
    Left = 592
    Top = 348
  end
  object IBCQueryExp: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT *'
      'FROM VW_TDB_DOCS'
      'ORDER BY DT_NAME,DOCID')
    ReadOnly = True
    Left = 500
    Top = 248
  end
  object IBCDataSourceExp: TIBCDataSource
    DataSet = IBCQueryExp
    Left = 500
    Top = 316
  end
end
