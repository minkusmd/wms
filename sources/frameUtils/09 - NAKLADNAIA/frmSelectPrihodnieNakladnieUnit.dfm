object frmSelectPrihodnieNakladnieDlg: TfrmSelectPrihodnieNakladnieDlg
  Left = 0
  Top = 0
  Caption = 'Selecteaza Intrarile  de marfa'
  ClientHeight = 620
  ClientWidth = 1142
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object pnlMain: TPanel
    Left = 0
    Top = 0
    Width = 1142
    Height = 584
    Align = alClient
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 0
    object Panel1: TPanel
      Left = 0
      Top = 0
      Width = 553
      Height = 580
      Align = alLeft
      BevelKind = bkFlat
      BevelOuter = bvNone
      Color = clWindow
      ParentBackground = False
      TabOrder = 0
      object cxGrid1: TcxGrid
        Left = 0
        Top = 0
        Width = 549
        Height = 256
        Align = alTop
        TabOrder = 0
        object cxGrid1DBTableView1: TcxGridDBTableView
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
          object cxGrid1DBTableView1Column1: TcxGridDBColumn
            Caption = 'DocID'
            DataBinding.FieldName = 'DOCID'
            DataBinding.IsNullValueType = True
            HeaderAlignmentHorz = taCenter
          end
          object cxGrid1DBTableView1Column2: TcxGridDBColumn
            Caption = 'Data'
            DataBinding.FieldName = 'DATA'
            DataBinding.IsNullValueType = True
            HeaderAlignmentHorz = taCenter
            Width = 96
          end
          object cxGrid1DBTableView1Column3: TcxGridDBColumn
            DataBinding.FieldName = 'CT'
            DataBinding.IsNullValueType = True
            Visible = False
            HeaderAlignmentHorz = taCenter
          end
          object cxGrid1DBTableView1Column4: TcxGridDBColumn
            Caption = 'Furnizor'
            DataBinding.FieldName = 'CT_NAME'
            DataBinding.IsNullValueType = True
            HeaderAlignmentHorz = taCenter
            Width = 238
          end
          object cxGrid1DBTableView1Column5: TcxGridDBColumn
            Caption = 'Suma'
            DataBinding.FieldName = 'SUMA'
            DataBinding.IsNullValueType = True
            HeaderAlignmentHorz = taCenter
            Width = 96
          end
          object cxGrid1DBTableView1Column6: TcxGridDBColumn
            Caption = 'Valuta'
            DataBinding.FieldName = 'CURRENCY_NAME'
            DataBinding.IsNullValueType = True
            HeaderAlignmentHorz = taCenter
            Width = 42
          end
        end
        object cxGrid1Level1: TcxGridLevel
          GridView = cxGrid1DBTableView1
        end
      end
      object cxGrid2: TcxGrid
        Left = 0
        Top = 256
        Width = 549
        Height = 320
        Align = alClient
        TabOrder = 1
        object cxGrid2DBTableView1: TcxGridDBTableView
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
        end
        object cxGrid2Level1: TcxGridLevel
          GridView = cxGrid2DBTableView1
        end
      end
    end
    object Panel2: TPanel
      Left = 553
      Top = 0
      Width = 585
      Height = 580
      Align = alClient
      BevelKind = bkFlat
      BevelOuter = bvNone
      Color = clWindow
      ParentBackground = False
      TabOrder = 1
    end
  end
  object RzDialogButtons1: TRzDialogButtons
    Left = 0
    Top = 584
    Width = 1142
    TabOrder = 1
  end
  object qDocs: TIBCQuery
    KeyFields = 'DOCID'
    Left = 568
    Top = 312
  end
end
