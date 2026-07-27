object frmListofJurnalGoodsDialog: TfrmListofJurnalGoodsDialog
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  ClientHeight = 553
  ClientWidth = 890
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  DesignSize = (
    890
    553)
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 890
    Height = 64
    Title = 'Import din document'
    Text = 'Selectati produsele necesare'
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
  end
  object Panel1: TPanel
    Left = 8
    Top = 70
    Width = 874
    Height = 429
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    object cxGrid1: TcxGrid
      AlignWithMargins = True
      Left = 8
      Top = 8
      Width = 858
      Height = 413
      Margins.Left = 8
      Margins.Top = 8
      Margins.Right = 8
      Margins.Bottom = 8
      Align = alClient
      TabOrder = 0
      object cxGrid1DBTableView1: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        DataController.DataSource = IBCDataSourceJurnal
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.IncSearch = True
        OptionsBehavior.ImmediateEditor = False
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.MultiSelect = True
        OptionsSelection.CheckBoxPosition = cbpIndicator
        OptionsSelection.CheckBoxVisibility = [cbvDataRow]
        OptionsSelection.InvertSelect = False
        OptionsSelection.MultiSelectMode = msmPersistent
        OptionsSelection.ShowCheckBoxesDynamically = True
        OptionsView.ColumnAutoWidth = True
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        object cxGrid1DBTableView1GOODSID: TcxGridDBColumn
          Caption = 'Cod'
          DataBinding.FieldName = 'GOODSID'
          DataBinding.IsNullValueType = True
          HeaderAlignmentHorz = taCenter
        end
        object cxGrid1DBTableView1GOODS_NAME: TcxGridDBColumn
          Caption = 'Produs'
          DataBinding.FieldName = 'GOODS_NAME'
          DataBinding.IsNullValueType = True
          HeaderAlignmentHorz = taCenter
          Width = 508
        end
        object cxGrid1DBTableView1UM_NAME: TcxGridDBColumn
          Caption = 'UM'
          DataBinding.FieldName = 'UM_NAME'
          DataBinding.IsNullValueType = True
          HeaderAlignmentHorz = taCenter
          Width = 64
        end
        object cxGrid1DBTableView1QTY: TcxGridDBColumn
          Caption = 'Cant'
          DataBinding.FieldName = 'QTY'
          DataBinding.IsNullValueType = True
          HeaderAlignmentHorz = taCenter
          Width = 50
        end
        object cxGrid1DBTableView1PRICE: TcxGridDBColumn
          Caption = 'Pret'
          DataBinding.FieldName = 'PRICE'
          DataBinding.IsNullValueType = True
          HeaderAlignmentHorz = taCenter
        end
        object cxGrid1DBTableView1SUMA: TcxGridDBColumn
          Caption = 'Suma'
          DataBinding.FieldName = 'SUMA'
          DataBinding.IsNullValueType = True
          HeaderAlignmentHorz = taCenter
        end
      end
      object cxGrid1Level1: TcxGridLevel
        GridView = cxGrid1DBTableView1
      end
    end
  end
  object btnOK: TcxButton
    Left = 656
    Top = 516
    Width = 90
    Height = 29
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TcxButton
    Left = 760
    Top = 516
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
  object IBCQueryJurnal: TIBCQuery
    SQL.Strings = (
      'select * from vw_tdb_jurnal where docid=:docid')
    Left = 472
    Top = 208
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'docid'
        Value = nil
      end>
  end
  object IBCDataSourceJurnal: TIBCDataSource
    DataSet = IBCQueryJurnal
    Left = 352
    Top = 208
  end
end
