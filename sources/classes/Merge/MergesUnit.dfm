object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 260
  ClientWidth = 529
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object cxGrid1: TcxGrid
    Left = 8
    Top = 8
    Width = 521
    Height = 200
    TabOrder = 0
    object cxGrid1TableView1: TcxGridTableView
      Navigator.Buttons.CustomButtons = <>
      ScrollbarAnnotations.CustomAnnotations = <>
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      object cxGrid1TableView1ID: TcxGridColumn
        Width = 89
      end
      object cxGrid1TableView1Name: TcxGridColumn
        Width = 416
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1TableView1
    end
  end
  object btnOK: TcxButton
    Left = 176
    Top = 224
    Width = 90
    Height = 30
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancel: TcxButton
    Left = 280
    Top = 224
    Width = 90
    Height = 30
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 2
  end
end
