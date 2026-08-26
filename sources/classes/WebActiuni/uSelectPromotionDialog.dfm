object frmSelectPromotionDlg: TfrmSelectPromotionDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1057#1087#1080#1089#1086#1082' web '#1072#1082#1094#1080#1081
  ClientHeight = 347
  ClientWidth = 800
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object cxGrid1: TcxGrid
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 794
    Height = 305
    Align = alClient
    TabOrder = 0
    object cxGrid1DBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      ScrollbarAnnotations.CustomAnnotations = <>
      DataController.DataSource = IBCDataSourceWebPromo
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      object cxGrid1DBTableView1PROMOACTIONID: TcxGridDBColumn
        Caption = 'ID'
        DataBinding.FieldName = 'PROMOACTIONID'
        DataBinding.IsNullValueType = True
        HeaderAlignmentHorz = taCenter
        Width = 79
      end
      object cxGrid1DBTableView1TITLE: TcxGridDBColumn
        Caption = 'Promotie'
        DataBinding.FieldName = 'TITLE'
        DataBinding.IsNullValueType = True
        HeaderAlignmentHorz = taCenter
        Width = 417
      end
      object cxGrid1DBTableView1START_DATE: TcxGridDBColumn
        Caption = 'Inceput'
        DataBinding.FieldName = 'START_DATE'
        DataBinding.IsNullValueType = True
        HeaderAlignmentHorz = taCenter
        Width = 73
      end
      object cxGrid1DBTableView1END_DATE: TcxGridDBColumn
        Caption = 'Sfirsit'
        DataBinding.FieldName = 'END_DATE'
        DataBinding.IsNullValueType = True
        HeaderAlignmentHorz = taCenter
        Width = 65
      end
      object cxGrid1DBTableView1FLG_ENABLED: TcxGridDBColumn
        Caption = 'Activ'
        DataBinding.FieldName = 'FLG_ENABLED'
        DataBinding.IsNullValueType = True
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = '1'
        Properties.ValueUnchecked = '0'
        HeaderAlignmentHorz = taCenter
        Width = 34
      end
      object cxGrid1DBTableView1CREATED_BY_NAME: TcxGridDBColumn
        Caption = 'Creat de '
        DataBinding.FieldName = 'CREATED_BY_NAME'
        DataBinding.IsNullValueType = True
        HeaderAlignmentHorz = taCenter
        Width = 124
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
    end
  end
  object RzDialogButtons1: TRzDialogButtons
    Left = 0
    Top = 311
    Width = 800
    TabOrder = 1
  end
  object IBCQueryWebPromo: TIBCQuery
    SQL.Strings = (
      'select first 50 * from vw_tweb_promos w'
      'order by w.PROMOACTIONID desc')
    Left = 242
    Top = 176
  end
  object IBCDataSourceWebPromo: TIBCDataSource
    DataSet = IBCQueryWebPromo
    Left = 240
    Top = 128
  end
end
