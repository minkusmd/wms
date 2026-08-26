object frmChangeGoodsTitleDlg: TfrmChangeGoodsTitleDlg
  Left = 0
  Top = 0
  Caption = 'frmChangeGoodsTitleDlg'
  ClientHeight = 536
  ClientWidth = 978
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  PixelsPerInch = 96
  TextHeight = 13
  object cxGrid1: TcxGrid
    AlignWithMargins = True
    Left = 8
    Top = 8
    Width = 962
    Height = 473
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    TabOrder = 0
    object cxGrid1DBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      ScrollbarAnnotations.CustomAnnotations = <>
      DataController.DataSource = DataSource1
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      object cxGrid1DBTableView_GOODSID: TcxGridDBColumn
        Caption = 'Cod'
        DataBinding.FieldName = 'GOODSID'
        Width = 62
      end
      object cxGrid1DBTableView_TITLE_OLD: TcxGridDBColumn
        Caption = 'Denumirea de sistema veche'
        DataBinding.FieldName = 'TITLE_OLD'
        HeaderAlignmentHorz = taCenter
        Width = 449
      end
      object cxGrid1DBTableView_TITLE_NEW: TcxGridDBColumn
        Caption = 'Denumirea nou formata din web'
        DataBinding.FieldName = 'TITLE_NEW'
        HeaderAlignmentHorz = taCenter
        Width = 449
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
    end
  end
  object btnOK: TcxButton
    Left = 480
    Top = 496
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 2
  end
  object cxButton2: TcxButton
    Left = 368
    Top = 496
    Width = 90
    Height = 29
    Caption = 'Modifica'
    ModalResult = 1
    TabOrder = 1
  end
  object dxMemData1: TdxMemData
    Indexes = <>
    SortOptions = []
    Left = 496
    Top = 344
    object dxMemData1TITLE_OLD: TStringField
      FieldName = 'TITLE_OLD'
      Size = 1024
    end
    object dxMemData1TITLE_NEW: TStringField
      FieldName = 'TITLE_NEW'
      Size = 1024
    end
  end
  object DataSource1: TDataSource
    DataSet = dxMemData1
    Left = 424
    Top = 344
  end
end
