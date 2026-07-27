object frmGoodsFilterParamMergeDlg: TfrmGoodsFilterParamMergeDlg
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Uneste valorile selectate'
  ClientHeight = 292
  ClientWidth = 463
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  DesignSize = (
    463
    292)
  TextHeight = 15
  object cxButton1: TcxButton
    Left = 200
    Top = 255
    Width = 145
    Height = 29
    Caption = 'Concatinarea filtrelor'
    Default = True
    ModalResult = 1
    TabOrder = 1
    OnClick = cxButton1Click
  end
  object cxButton2: TcxButton
    Left = 363
    Top = 255
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
  object cxGrid1: TcxGrid
    Left = 8
    Top = 8
    Width = 453
    Height = 209
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
    ExplicitWidth = 673
    object tvGoodsList: TcxGridTableView
      OnDblClick = tvGoodsListDblClick
      Navigator.Buttons.CustomButtons = <>
      ScrollbarAnnotations.CustomAnnotations = <>
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      object cxGrid1TableView_CHECKED: TcxGridColumn
        Caption = '...'
        PropertiesClassName = 'TcxCheckBoxProperties'
        HeaderAlignmentHorz = taCenter
        Width = 20
      end
      object cxGrid1TableView_FILTERPARAMID: TcxGridColumn
        Caption = 'Cod'
        HeaderAlignmentHorz = taCenter
        Width = 125
      end
      object cxGrid1TableView_GOODS_NAME: TcxGridColumn
        Caption = 'Denumire'
        HeaderAlignmentHorz = taCenter
        Width = 326
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = tvGoodsList
    end
  end
  object cxLabel4: TcxLabel
    Left = 8
    Top = 223
    Caption = 'Bifati produsul care va ramine in urma concatinarii'
    TabOrder = 2
  end
end
