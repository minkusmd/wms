object frmGoodsByType: TfrmGoodsByType
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Tipuri de produse'
  ClientHeight = 561
  ClientWidth = 863
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object DialogTitle1: TDialogTitle
    Left = 0
    Top = 0
    Width = 863
    Height = 64
    Title = 'Tipuri de produse'
    Text = 'Lista produselor dupa tip'
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
  object cxGrid1: TcxGrid
    Left = 8
    Top = 70
    Width = 847
    Height = 435
    TabOrder = 1
    object cxGrid1DBTableView1: TcxGridDBTableView
      OnKeyDown = cxGrid1DBTableView1KeyDown
      Navigator.Buttons.CustomButtons = <>
      ScrollbarAnnotations.CustomAnnotations = <>
      DataController.DataSource = IBCDataSource1
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.CopyCaptionsToClipboard = False
      OptionsBehavior.IncSearch = True
      OptionsBehavior.CopyPreviewToClipboard = False
      OptionsBehavior.ImmediateEditor = False
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      object cxGrid1DBTableView1GOODSID: TcxGridDBColumn
        Caption = 'Cod'
        DataBinding.FieldName = 'GOODSID'
        DataBinding.IsNullValueType = True
        HeaderAlignmentHorz = taCenter
        Width = 32
      end
      object cxGrid1DBTableView1TITLE: TcxGridDBColumn
        Caption = 'Produs'
        DataBinding.FieldName = 'TITLE'
        DataBinding.IsNullValueType = True
        HeaderAlignmentHorz = taCenter
        Width = 765
      end
      object cxGrid1DBTableView1_FLG_FORCED: TcxGridDBColumn
        Caption = 'F'
        DataBinding.FieldName = 'FLG_FORCED'
        DataBinding.IsNullValueType = True
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = '1'
        Properties.ValueUnchecked = '0'
        HeaderAlignmentHorz = taCenter
        MinWidth = 48
        Options.HorzSizing = False
        Width = 48
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
    end
  end
  object cxButton1: TcxButton
    Left = 408
    Top = 524
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Inchide'
    ModalResult = 1
    TabOrder = 2
  end
  object IBCQuery1: TIBCQuery
    SQL.Strings = (
      'select '
      
        '  iif (exists(select goodsid from tdb_goods_flags gf where gf.go' +
        'odsid=g.goodsid and gf.flagtypeid in (3,5)), 1, 0) FLG_FORCED,'
      '  g.*'
      '  '
      'from vw_ts_goods g '
      'where WEBGOODSTYPE_ID = :goodstypeid'
      'order by 1 desc')
    Left = 40
    Top = 152
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'goodstypeid'
        Value = nil
      end>
  end
  object IBCDataSource1: TIBCDataSource
    DataSet = IBCQuery1
    Left = 40
    Top = 104
  end
end
