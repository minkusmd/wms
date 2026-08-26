object frmListOfUserGroupsDialog: TfrmListOfUserGroupsDialog
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Gestionarea drepturilor pe grupe de utilizatori'
  ClientHeight = 296
  ClientWidth = 466
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 15
  object cxGrid1: TcxGrid
    AlignWithMargins = True
    Left = 5
    Top = 8
    Width = 456
    Height = 227
    Margins.Left = 5
    Margins.Top = 8
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alTop
    TabOrder = 0
    ExplicitLeft = 8
    ExplicitTop = 6
    ExplicitWidth = 450
    object cxGrid1DBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      ScrollbarAnnotations.CustomAnnotations = <>
      DataController.DataSource = IBCDataSource1
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      object cxGrid1DBTableView1GROUPID: TcxGridDBColumn
        Caption = 'cod'
        DataBinding.FieldName = 'GROUPID'
      end
      object cxGrid1DBTableView1GROUP_NAME: TcxGridDBColumn
        Caption = 'Grupa de utilizatori'
        DataBinding.FieldName = 'GROUP_NAME'
        Width = 354
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
    end
  end
  object cxButton1: TcxButton
    Left = 184
    Top = 261
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Inchide'
    ModalResult = 8
    TabOrder = 1
  end
  object IBCQuery1: TIBCQuery
    SQL.Strings = (
      'select * from get_user_UserGroups_By_Rights(:value)')
    Left = 232
    Top = 152
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'value'
        Value = nil
      end>
  end
  object IBCDataSource1: TIBCDataSource
    DataSet = IBCQuery1
    Left = 128
    Top = 152
  end
end
