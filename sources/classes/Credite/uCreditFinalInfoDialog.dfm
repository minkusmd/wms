object frmCreditFinalInfoDialog: TfrmCreditFinalInfoDialog
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Definirea creditelor'
  ClientHeight = 458
  ClientWidth = 656
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
    Left = 8
    Top = 27
    Width = 86
    Height = 15
    Caption = 'Numarul de luni'
  end
  object Label2: TLabel
    Left = 216
    Top = 27
    Width = 104
    Height = 15
    Caption = 'Suma spre creditare'
  end
  object Label3: TLabel
    Left = 509
    Top = 27
    Width = 32
    Height = 15
    Caption = 'Avans'
  end
  object cxGrid1: TcxGrid
    Left = 8
    Top = 59
    Width = 637
    Height = 334
    TabOrder = 3
    object cxGrid1DBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      ScrollbarAnnotations.CustomAnnotations = <>
      DataController.DataSource = IBCDataSourceReult
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.ImmediateEditor = False
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.HideFocusRectOnExit = False
      OptionsSelection.InvertSelect = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      object cxGrid1DBTableView1OF: TcxGridDBColumn
        Caption = 'Organizatia de finantare'
        DataBinding.FieldName = 'TITLE'
        Width = 422
      end
      object cxGrid1DBTableView1RL: TcxGridDBColumn
        Caption = 'Rata lunara'
        DataBinding.FieldName = 'PLATA_LUNARA'
        PropertiesClassName = 'TcxCalcEditProperties'
        Properties.DisplayFormat = '0.00'
        SortIndex = 0
        SortOrder = soAscending
        Width = 71
      end
      object cxGrid1DBTableView1AVANS: TcxGridDBColumn
        Caption = 'Avans'
        DataBinding.FieldName = 'AVANS_TOTAL'
        PropertiesClassName = 'TcxCalcEditProperties'
        Properties.DisplayFormat = '0.00'
        Width = 57
      end
      object cxGrid1DBTableView1TOTAL: TcxGridDBColumn
        Caption = 'Suma totala'
        DataBinding.FieldName = 'TOTAL_CREDIT'
        PropertiesClassName = 'TcxCalcEditProperties'
        Properties.DisplayFormat = '0.00'
        Width = 85
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
    end
  end
  object cxButton1: TcxButton
    Left = 279
    Top = 416
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 4
  end
  object ceSUMA: TcxCalcEdit
    Left = 326
    Top = 24
    EditValue = 0.000000000000000000
    Enabled = False
    TabOrder = 1
    Width = 91
  end
  object ceAvans: TcxCalcEdit
    Left = 547
    Top = 24
    EditValue = 0.000000000000000000
    Properties.OnEditValueChanged = ceAvansPropertiesEditValueChanged
    TabOrder = 2
    Width = 98
  end
  object ceLuni: TcxCalcEdit
    Left = 100
    Top = 24
    EditValue = 0.000000000000000000
    Properties.Precision = 0
    Properties.UseThousandSeparator = True
    Properties.OnEditValueChanged = ceLuniPropertiesEditValueChanged
    Properties.OnValidate = ceLuniPropertiesValidate
    TabOrder = 0
    Width = 45
  end
  object IBCQueryResult: TIBCQuery
    SQL.Strings = (
      
        'select * from GET_CREDITS_TYPE(:suma, :Avans, :Luni, :Listofgood' +
        'sid)')
    Left = 320
    Top = 232
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'suma'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'avans'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'luni'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'Listofgoodsid'
        Value = nil
      end>
  end
  object IBCDataSourceReult: TIBCDataSource
    DataSet = IBCQueryResult
    Left = 264
    Top = 232
  end
end
