object frmKitchenTemplateDlg: TfrmKitchenTemplateDlg
  Left = 0
  Top = 0
  Caption = 'frmKitchenTemplateDlg'
  ClientHeight = 491
  ClientWidth = 732
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel
    Left = 16
    Top = 32
    Width = 129
    Height = 15
    Caption = 'Selectati tipul bucatariei:'
  end
  object cxLookupComboBox1: TcxLookupComboBox
    Left = 16
    Top = 51
    Properties.ListColumns = <>
    TabOrder = 0
    Width = 201
  end
  object Panel1: TPanel
    Left = 8
    Top = 96
    Width = 713
    Height = 345
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    object cxGrid1: TcxGrid
      Left = 8
      Top = 8
      Width = 697
      Height = 329
      TabOrder = 0
      object cxGrid1DBTableView1: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsView.GroupByBox = False
      end
      object cxGrid1Level1: TcxGridLevel
        GridView = cxGrid1DBTableView1
      end
    end
  end
  object btnOK: TButton
    Left = 509
    Top = 458
    Width = 90
    Height = 29
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 615
    Top = 458
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
  object IBCQuery1: TIBCQuery
    SQL.Strings = (
      'select * from ts_syss where ')
    Left = 208
  end
end
