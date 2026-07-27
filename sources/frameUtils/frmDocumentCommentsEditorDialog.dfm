object frmDocumentCommentsEditorDlg: TfrmDocumentCommentsEditorDlg
  Left = 0
  Top = 0
  ActiveControl = edComments
  BorderStyle = bsDialog
  Caption = 'Mentiuni la document'
  ClientHeight = 502
  ClientWidth = 698
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 698
    Height = 64
    Title = 'Mentiuni la document'
    Text = 'Adauga mentiuni pentru documentul curent'
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
    ImageIndex = 23
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 682
    Height = 377
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    object Label1: TLabel
      Left = 16
      Top = 16
      Width = 51
      Height = 15
      Caption = 'Mentiune'
    end
    object Label2: TLabel
      Left = 16
      Top = 80
      Width = 51
      Height = 15
      Caption = 'Historicul'
    end
    object edComments: TcxTextEdit
      Left = 16
      Top = 33
      TabOrder = 1
      Width = 557
    end
    object cxGrid: TcxGrid
      Left = 16
      Top = 97
      Width = 641
      Height = 252
      TabOrder = 2
      object cxGridTable: TcxGridTableView
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnSorting = False
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsSelection.InvertSelect = False
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1082#1086#1084#1084#1077#1085#1090#1072#1088#1080#1077#1074'>'
        OptionsView.ScrollBars = ssVertical
        OptionsView.CellAutoHeight = True
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        Styles.Header = dmAdditions.cxStyle_GridHeader
        object cxGridTable_USER: TcxGridColumn
          Caption = 'Utilizator'
          MinWidth = 100
          Options.HorzSizing = False
          Width = 100
        end
        object cxGridTable_DATA: TcxGridColumn
          Caption = 'Data'
          MinWidth = 100
          Options.HorzSizing = False
          Width = 100
        end
        object cxGridTable_COMMENTS: TcxGridColumn
          Caption = 'Mentiune'
        end
      end
      object cxGridLevel: TcxGridLevel
        GridView = cxGridTable
      end
    end
    object btnAdd: TcxButton
      Left = 582
      Top = 32
      Width = 75
      Height = 25
      Caption = 'Adauga'
      Default = True
      TabOrder = 0
      OnClick = btnAddClick
    end
  end
  object btnOk: TcxButton
    Left = 480
    Top = 460
    Width = 90
    Height = 29
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TcxButton
    Left = 585
    Top = 460
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
end
