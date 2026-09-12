object frmSelectSerialPartNoDlg: TfrmSelectSerialPartNoDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Serii vindute'
  ClientHeight = 413
  ClientWidth = 506
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 15
  object cxGrid1: TcxGrid
    Left = 8
    Top = 70
    Width = 490
    Height = 281
    TabOrder = 0
    object cxGrid1DBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      FindPanel.ApplyInputDelay = 500
      FindPanel.DisplayMode = fpdmAlways
      FindPanel.UseExtendedSyntax = True
      DataController.DataSource = IBCDataSourceAvailableSN
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      object cxGrid1DBTableView1Column1: TcxGridDBColumn
        PropertiesClassName = 'TcxCheckBoxProperties'
        MinWidth = 26
        Options.HorzSizing = False
        Options.Moving = False
        Width = 26
      end
      object cxGrid1DBTableView1Column2: TcxGridDBColumn
        Caption = 'Seria'
        DataBinding.FieldName = 'SN'
        HeaderAlignmentHorz = taCenter
        Width = 140
      end
      object cxGrid1DBTableView1Column3: TcxGridDBColumn
        Caption = 'Cant'
        DataBinding.FieldName = 'QTY'
        HeaderAlignmentHorz = taCenter
        MinWidth = 48
        Options.HorzSizing = False
        Width = 48
      end
      object cxGrid1DBTableView1Column4: TcxGridDBColumn
        Caption = 'Furnizor'
        DataBinding.FieldName = 'SUPPLIER_NAME'
        HeaderAlignmentHorz = taCenter
        Width = 120
      end
      object cxGrid1DBTableView1Column5: TcxGridDBColumn
        Caption = 'Intrat la data'
        DataBinding.FieldName = 'INCOME_DATE'
        HeaderAlignmentHorz = taCenter
        Width = 84
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
    end
  end
  object cxButton3: TcxButton
    Left = 288
    Top = 376
    Width = 90
    Height = 29
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object cxButton4: TcxButton
    Left = 392
    Top = 376
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
  object DialogTitle1: TDialogTitle
    Left = 0
    Top = 0
    Width = 506
    Height = 64
    Title = 'Numere de serii'
    Text = 'Alage numarul de serii'
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
    ImageIndex = 18
  end
  object IBCQueryAvailableSN: TIBCQuery
    SQL.Strings = (
      'select s.*, 1 qty from get_sn_supplier_info(:docid, :goodsid) s')
    Left = 192
    Top = 160
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'docid'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'goodsid'
        Value = nil
      end>
  end
  object IBCDataSourceAvailableSN: TIBCDataSource
    DataSet = IBCQueryAvailableSN
    Left = 104
    Top = 160
  end
end
