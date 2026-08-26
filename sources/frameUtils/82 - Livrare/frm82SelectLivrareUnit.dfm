object frm82SelectLivrareDlg: Tfrm82SelectLivrareDlg
  Left = 0
  Top = 0
  Caption = 'Lista de livrari active'
  ClientHeight = 298
  ClientWidth = 939
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    939
    298)
  PixelsPerInch = 96
  TextHeight = 13
  object DialogTitle1: TDialogTitle
    Left = 0
    Top = 0
    Width = 939
    Height = 64
    Title = 'Selecteaza livrarea'
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
    ImageIndex = 35
  end
  object Panel2: TPanel
    Left = 8
    Top = 71
    Width = 923
    Height = 177
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    object cxGrid1: TcxGrid
      Left = 0
      Top = 0
      Width = 919
      Height = 173
      Align = alClient
      TabOrder = 0
      object cxGrid1DBTableView1: TcxGridDBTableView
        OnDblClick = cxGrid1DBTableView1DblClick
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        DataController.DataSource = IBCDataSourceLivrari
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
        object cxGrid1DBTableView1WAYBILLID: TcxGridDBColumn
          Caption = 'ID'
          DataBinding.FieldName = 'WAYBILLID'
          HeaderAlignmentHorz = taCenter
          Width = 34
        end
        object cxGrid1DBTableView1CURIER_NAME: TcxGridDBColumn
          Caption = 'Curier'
          DataBinding.FieldName = 'CURIER_NAME'
          HeaderAlignmentHorz = taCenter
          Width = 189
        end
        object cxGrid1DBTableView1TRANSPORT_NAME: TcxGridDBColumn
          Caption = 'Transport'
          DataBinding.FieldName = 'TRANSPORT_NAME'
          HeaderAlignmentHorz = taCenter
          Width = 153
        end
        object cxGrid1DBTableView1DATA: TcxGridDBColumn
          Caption = 'Data'
          DataBinding.FieldName = 'DATA'
          HeaderAlignmentHorz = taCenter
          Width = 111
        end
        object cxGrid1DBTableView1SC_NAME: TcxGridDBColumn
          Caption = 'Analitica'
          DataBinding.FieldName = 'SC_NAME'
          HeaderAlignmentHorz = taCenter
          Width = 150
        end
        object cxGrid1DBTableView1FLG_CLOSED: TcxGridDBColumn
          Caption = '...'
          DataBinding.FieldName = 'FLG_CLOSED'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.DisplayChecked = '1'
          Properties.DisplayUnchecked = '0'
          Properties.ValueChecked = '1'
          Properties.ValueUnchecked = '0'
          HeaderAlignmentHorz = taCenter
          Width = 24
        end
        object cxGrid1DBTableView1CREATED_DATE: TcxGridDBColumn
          Caption = 'Creat la'
          DataBinding.FieldName = 'CREATED_DATE'
          HeaderAlignmentHorz = taCenter
          Width = 97
        end
        object cxGrid1DBTableView1CREATED_BY_NAME: TcxGridDBColumn
          Caption = 'Creat de'
          DataBinding.FieldName = 'CREATED_BY_NAME'
          HeaderAlignmentHorz = taCenter
          Width = 150
        end
      end
      object cxGrid1Level1: TcxGridLevel
        GridView = cxGrid1DBTableView1
      end
    end
  end
  object Button1: TButton
    Left = 728
    Top = 261
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object Button2: TButton
    Left = 824
    Top = 261
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
  object IBCQueryLivrari: TIBCQuery
    SQL.Strings = (
      'select * from vw_tdb_waybill '
      'where flg_closed=0'
      'order by data')
    Left = 248
    Top = 232
  end
  object IBCDataSourceLivrari: TIBCDataSource
    DataSet = IBCQueryLivrari
    Left = 248
    Top = 176
  end
end
