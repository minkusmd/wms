object frmModifyFilterParamsDlg: TfrmModifyFilterParamsDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Modifica filtrele in descrierea produselor'
  ClientHeight = 317
  ClientWidth = 461
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  TextHeight = 15
  object cxGrid1: TcxGrid
    Left = 8
    Top = 8
    Width = 449
    Height = 233
    TabOrder = 0
    object cxGrid1TableView1: TcxGridTableView
      Navigator.Buttons.CustomButtons = <>
      ScrollbarAnnotations.CustomAnnotations = <>
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsView.GroupByBox = False
      object cxGrid1TableView1_PARENTID: TcxGridColumn
        Caption = 'Cod grupa produs'
        Width = 120
      end
      object cxGrid1TableView1_FILTERID: TcxGridColumn
        Caption = 'Cod filtru'
        Width = 120
      end
      object cxGrid1TableView1_FILTERPARAMID: TcxGridColumn
        Caption = 'Cod parametru'
        Width = 120
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1TableView1
    end
  end
  object Button1: TButton
    Left = 261
    Top = 280
    Width = 115
    Height = 29
    Caption = 'Incepe'
    Default = True
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 382
    Top = 280
    Width = 75
    Height = 29
    Caption = 'Inchide'
    ModalResult = 2
    TabOrder = 3
  end
  object cbDeleteFirst: TcxCheckBox
    Left = 24
    Top = 247
    Caption = 'Sterge initial valorile'
    Style.TransparentBorder = False
    TabOrder = 1
  end
end
