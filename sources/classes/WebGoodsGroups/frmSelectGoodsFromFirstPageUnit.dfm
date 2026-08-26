object frmSelectGoodsFromFirstPageDlg: TfrmSelectGoodsFromFirstPageDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Grupe produse din prima pagina a site-ului '
  ClientHeight = 344
  ClientWidth = 525
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel
    Left = 8
    Top = 70
    Width = 178
    Height = 15
    Caption = 'Promotiile active pe prima pagina'
  end
  object DialogTitle1: TDialogTitle
    Left = 0
    Top = 0
    Width = 525
    Height = 64
    Title = 'Grupe produse de pe prima pagina'
    Text = ''
    FontTitle.Charset = DEFAULT_CHARSET
    FontTitle.Color = clWindowText
    FontTitle.Height = -15
    FontTitle.Name = 'Segoe UI'
    FontTitle.Style = [fsBold]
    FontText.Charset = DEFAULT_CHARSET
    FontText.Color = clWindowText
    FontText.Height = -12
    FontText.Name = 'Segoe UI'
    FontText.Style = []
    ImageList = dmAdditions.cxImageList_DialogIcons
    ImageIndex = 30
    ExplicitLeft = -5
    ExplicitWidth = 621
  end
  object btnOK: TcxButton
    Left = 312
    Top = 303
    Width = 90
    Height = 29
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object cxButton2: TcxButton
    Left = 408
    Top = 303
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
  object cxGrid1: TcxGrid
    Left = 8
    Top = 88
    Width = 505
    Height = 200
    TabOrder = 1
    object cxGrid1DBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      ScrollbarAnnotations.CustomAnnotations = <>
      DataController.DataSource = IBCDataSource1
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.InvertSelect = False
      OptionsView.GroupByBox = False
      object cxGrid1DBTableView1_GGID: TcxGridDBColumn
        Caption = 'ID'
        DataBinding.FieldName = 'GGID'
        Width = 39
      end
      object cxGrid1DBTableView1_NAME: TcxGridDBColumn
        DataBinding.FieldName = 'TITLE_RO'
        Width = 398
      end
      object cxGrid1DBTableView1_Qty: TcxGridDBColumn
        Caption = 'Q'
        DataBinding.FieldName = 'GOODS_QTY'
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
    end
  end
  object IBCQuery1: TIBCQuery
    SQL.Strings = (
      'select a.GGID, a.TITLE_RO, a.goods_qty'
      'from TWEB_FP_GROUPS a'
      'where current_date between data1 and data2')
    Left = 312
    Top = 64
  end
  object IBCDataSource1: TIBCDataSource
    DataSet = IBCQuery1
    Left = 312
    Top = 8
  end
end
