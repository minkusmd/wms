object frmDSENumberGenerator: TfrmDSENumberGenerator
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Generator de serii pentru DSE'
  ClientHeight = 405
  ClientWidth = 656
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object lbInfo: TLabel
    AlignWithMargins = True
    Left = 1
    Top = 350
    Width = 653
    Height = 11
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Alignment = taCenter
    AutoSize = False
    Color = 28895
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Transparent = True
    Layout = tlCenter
    WordWrap = True
  end
  object pnGenerator: TPanel
    AlignWithMargins = True
    Left = 1
    Top = 5
    Width = 264
    Height = 337
    Margins.Left = 2
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 0
    object cxLabel5: TLabel
      Left = 16
      Top = 21
      Width = 85
      Height = 13
      Caption = 'Prefixul numarului'
      Transparent = True
    end
    object cxLabel6: TLabel
      Left = 16
      Top = 71
      Width = 119
      Height = 13
      Caption = 'Seria care va fi generata'
      Transparent = True
    end
    object cxLabel7: TLabel
      Left = 16
      Top = 123
      Width = 24
      Height = 13
      Caption = 'Sufix'
      Transparent = True
    end
    object cxLabel8: TLabel
      Left = 16
      Top = 179
      Width = 155
      Height = 13
      Caption = 'Numarul seriilor pentru generare'
      Transparent = True
    end
    object edSerialPrefix: TcxMaskEdit
      Left = 16
      Top = 38
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 0
      TabOrder = 0
      Width = 196
    end
    object edSerialStartMask: TcxMaskEdit
      Left = 16
      Top = 88
      Properties.MaskKind = emkRegExprEx
      Properties.EditMask = '\d+'
      Properties.MaxLength = 0
      Style.TextStyle = [fsBold]
      TabOrder = 1
      Text = '00001'
      Width = 97
    end
    object edSearialSuffix: TcxMaskEdit
      Left = 16
      Top = 140
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 0
      TabOrder = 2
      Width = 196
    end
    object edSerialGenerateCount: TcxMaskEdit
      Left = 16
      Top = 196
      Properties.MaskKind = emkRegExprEx
      Properties.EditMask = '\d+'
      Properties.MaxLength = 0
      Style.TextColor = clMaroon
      Style.TextStyle = [fsBold]
      TabOrder = 3
      Text = '1'
      Width = 97
    end
    object btnGenerate: TButton
      Left = 16
      Top = 253
      Width = 145
      Height = 29
      Caption = 'Genereaza seriile'
      TabOrder = 4
      OnClick = btnGenerateClick
    end
    object cbClearList: TcxCheckBox
      Left = 16
      Top = 296
      TabStop = False
      Caption = 'Initializeaza lista'
      TabOrder = 6
    end
    object btnPaste: TcxButton
      Left = 176
      Top = 253
      Width = 75
      Height = 29
      Caption = 'Paste'
      TabOrder = 5
      OnClick = btnPasteClick
    end
  end
  object btnOK: TcxButton
    Left = 492
    Top = 372
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
    OnClick = btnOKClick
  end
  object cxButton2: TcxButton
    Left = 573
    Top = 372
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
  object cxGridSerials: TcxGrid
    AlignWithMargins = True
    Left = 280
    Top = 5
    Width = 374
    Height = 337
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    TabOrder = 1
    object cxGridSerialsTable: TcxGridTableView
      Navigator.Buttons.CustomButtons = <>
      Navigator.Buttons.First.Visible = True
      Navigator.Buttons.PriorPage.Visible = True
      Navigator.Buttons.Prior.Visible = True
      Navigator.Buttons.Next.Visible = True
      Navigator.Buttons.NextPage.Visible = True
      Navigator.Buttons.Last.Visible = True
      Navigator.Buttons.Insert.Visible = True
      Navigator.Buttons.Append.Visible = False
      Navigator.Buttons.Delete.Visible = True
      Navigator.Buttons.Edit.Visible = True
      Navigator.Buttons.Post.Visible = True
      Navigator.Buttons.Cancel.Visible = True
      Navigator.Buttons.Refresh.Visible = True
      Navigator.Buttons.SaveBookmark.Visible = True
      Navigator.Buttons.GotoBookmark.Visible = True
      Navigator.Buttons.Filter.Visible = True
      ScrollbarAnnotations.CustomAnnotations = <>
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsSelection.InvertSelect = False
      OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
      OptionsView.ScrollBars = ssVertical
      OptionsView.ShowEditButtons = gsebForFocusedRecord
      OptionsView.ColumnAutoWidth = True
      OptionsView.GridLineColor = 13750737
      OptionsView.GroupByBox = False
      Styles.ContentEven = dmAdditions.cxStyle_GridContentEven
      Styles.Header = dmAdditions.cxStyle_GridHeader
      Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
      object cxGridSerialsTable_ENABLED: TcxGridColumn
        DataBinding.ValueType = 'Boolean'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ImmediatePost = True
        MinWidth = 30
        Options.Filtering = False
        Options.IncSearch = False
        Options.HorzSizing = False
        Options.Moving = False
        Options.ShowCaption = False
        Options.Sorting = False
        Width = 30
      end
      object cxGridSerialsTable_NO: TcxGridColumn
        Caption = 'Nr'
        DataBinding.ValueType = 'Integer'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taRightJustify
        HeaderAlignmentHorz = taCenter
        MinWidth = 40
        Options.Editing = False
        Options.Filtering = False
        Options.ShowEditButtons = isebNever
        Options.HorzSizing = False
        Options.Moving = False
        Width = 40
      end
      object cxGridSerialsTable_SERIAL: TcxGridColumn
        Caption = 'Serie'
        Options.Editing = False
        Options.Filtering = False
        Options.Grouping = False
        Options.Moving = False
        Styles.Content = dmAdditions.cxStyle_Bold
        Width = 200
      end
    end
    object cxGridSerialsLevel: TcxGridLevel
      GridView = cxGridSerialsTable
    end
  end
end
