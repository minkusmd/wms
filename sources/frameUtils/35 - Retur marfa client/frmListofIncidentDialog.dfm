object frmDialogListOfIncidents: TfrmDialogListOfIncidents
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1057#1087#1080#1089#1086#1082' '#1080#1085#1094#1080#1076#1077#1085#1090#1086#1074
  ClientHeight = 198
  ClientWidth = 580
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object cxGrid1: TcxGrid
    Left = 0
    Top = 1
    Width = 577
    Height = 160
    TabOrder = 0
    object cxGrid1DBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = IBCDataSourceDocs
      DataController.KeyFieldNames = 'INCIDENTID'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsSelection.HideFocusRectOnExit = False
      OptionsSelection.InvertSelect = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      object cxGrid1DBTableView1DATA: TcxGridDBColumn
        Caption = #1044#1072#1090#1072
        DataBinding.FieldName = 'DATA'
        Width = 44
      end
      object cxGrid1DBTableView1INCIDENTID: TcxGridDBColumn
        Caption = #1050#1086#1076' '#1080#1085#1094#1080#1076#1077#1085#1090
        DataBinding.FieldName = 'INCIDENTID'
        Width = 136
      end
      object cxGrid1DBTableView1GOODS_SN: TcxGridDBColumn
        Caption = #1057#1077#1088#1080#1081#1085#1099#1081' '#1085#1086#1084#1077#1088
        DataBinding.FieldName = 'GOODS_SN'
        Width = 146
      end
      object cxGrid1DBTableView1GOODS_MODEL: TcxGridDBColumn
        Caption = #1052#1086#1076#1077#1083#1100
        DataBinding.FieldName = 'GOODS_MODEL'
        Width = 193
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
    end
  end
  object btnSelectQtyFromComplectBtnClose: TcxButton
    Left = 256
    Top = 167
    Width = 75
    Height = 25
    Cancel = True
    Caption = #1047#1072#1082#1088#1099#1090#1100
    ModalResult = 2
    TabOrder = 1
  end
  object IBCQueryDocs: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'select INCIDENTID, DATA, S.GOODS_SN, S.GOODS_MODEL'
      'from SC_INCIDENTE S'
      'where S.GOODS_DOCID = :DOCID   ')
    Active = True
    Left = 160
    Top = 48
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DOCID'
        Value = nil
      end>
  end
  object IBCDataSourceDocs: TIBCDataSource
    DataSet = IBCQueryDocs
    Left = 280
    Top = 56
  end
end
