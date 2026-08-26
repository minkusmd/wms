object frmGoodsWebCatalogPathDialog: TfrmGoodsWebCatalogPathDialog
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Web catalog path'
  ClientHeight = 298
  ClientWidth = 408
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object cxButton1: TcxButton
    Left = 176
    Top = 265
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Inchide'
    Default = True
    ModalResult = 8
    TabOrder = 0
  end
  object cxDBTreeList1: TcxDBTreeList
    Left = 8
    Top = 8
    Width = 393
    Height = 241
    Bands = <
      item
      end>
    DataController.DataSource = IBCDataSource1
    DataController.ParentField = 'PARENTID'
    DataController.KeyField = 'CATALOGID'
    Navigator.Buttons.CustomButtons = <>
    OptionsBehavior.IncSearch = True
    OptionsData.Editing = False
    OptionsData.Deleting = False
    RootValue = -1
    ScrollbarAnnotations.CustomAnnotations = <>
    TabOrder = 1
    object cxDBTreeList1cxDBTreeListColumn1: TcxDBTreeListColumn
      Caption.Text = 'Mapa'
      DataBinding.FieldName = 'TITLE'
      Options.Editing = False
      Width = 286
      Position.ColIndex = 0
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
    end
  end
  object IBCQuery1: TIBCQuery
    SQL.Strings = (
      'select distinct * from GET_CATALOG_PATH(:FOLDERID)')
    Active = True
    Left = 104
    Top = 32
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'FOLDERID'
        Value = nil
      end>
  end
  object IBCDataSource1: TIBCDataSource
    DataSet = IBCQuery1
    Left = 40
    Top = 32
  end
end
