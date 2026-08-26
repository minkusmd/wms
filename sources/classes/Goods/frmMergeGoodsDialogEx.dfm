object frmMergeGoodsDlgEx: TfrmMergeGoodsDlgEx
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1054#1073#1100#1077#1076#1080#1085#1077#1085#1080#1077' '#1090#1086#1074#1072#1088#1086#1074
  ClientHeight = 338
  ClientWidth = 631
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  DesignSize = (
    631
    338)
  TextHeight = 15
  object DialogTitle1: TDialogTitle
    Left = 0
    Top = 0
    Width = 631
    Height = 64
    Title = #1054#1073#1100#1077#1076#1080#1085#1077#1085#1080#1077' '#1090#1086#1074#1072#1088#1086#1074
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
    ImageIndex = 21
  end
  object btnOk: TcxButton
    Left = 425
    Top = 301
    Width = 90
    Height = 29
    Caption = 'OK'
    Default = True
    TabOrder = 1
  end
  object btnCancel: TcxButton
    Left = 521
    Top = 301
    Width = 90
    Height = 29
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 2
  end
  object cxGrid1: TcxGrid
    Left = 8
    Top = 70
    Width = 615
    Height = 195
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 3
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
        Visible = False
        HeaderAlignmentHorz = taCenter
        Width = 32
      end
      object cxGrid1TableView_GOODSID: TcxGridColumn
        Caption = 'Cod'
        HeaderAlignmentHorz = taCenter
        MinWidth = 105
        Options.HorzSizing = False
        Width = 105
      end
      object cxGrid1TableView_GOODS_NAME: TcxGridColumn
        Caption = 'Denumire'
        HeaderAlignmentHorz = taCenter
        Width = 622
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = tvGoodsList
    end
  end
  object cxLabel4: TcxLabel
    Left = 8
    Top = 271
    Caption = 'Bifati produsul care va ramine in urma concatinarii'
    TabOrder = 4
  end
  object IBCQuerySource1: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT'
      ' TS_GOODS.*,'
      
        ' (SELECT FIRST 1 IMAGE FROM TS_GOODS_IMAGE WHERE TS_GOODS_IMAGE.' +
        'GOODSID=TS_GOODS.GOODSID ORDER BY TS_GOODS_IMAGE.ORDERNO)'
      'FROM'
      ' TS_GOODS'
      'WHERE'
      ' GOODSID=:id')
    ReadOnly = True
    Left = 80
    Top = 152
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        Value = nil
      end>
  end
  object IBCDataSourceSource: TIBCDataSource
    DataSet = IBCQuerySource1
    Left = 80
    Top = 104
  end
  object IBCQueryTarget1: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT'
      ' TS_GOODS.*,'
      
        ' (SELECT FIRST 1 IMAGE FROM TS_GOODS_IMAGE WHERE TS_GOODS_IMAGE.' +
        'GOODSID=TS_GOODS.GOODSID ORDER BY TS_GOODS_IMAGE.ORDERNO)'
      'FROM'
      ' TS_GOODS'
      'WHERE'
      ' GOODSID=:id')
    ReadOnly = True
    Left = 548
    Top = 144
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        Value = nil
      end>
  end
  object IBCDataSourceTarget: TIBCDataSource
    DataSet = IBCQueryTarget1
    Left = 548
    Top = 96
  end
end
