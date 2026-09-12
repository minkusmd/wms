object frmDistributieRambursDlg: TfrmDistributieRambursDlg
  Left = 0
  Top = 0
  Caption = 'Distribuire ramburs'
  ClientHeight = 550
  ClientWidth = 916
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  DesignSize = (
    916
    550)
  TextHeight = 15
  object Panel1: TPanel
    Left = 8
    Top = 96
    Width = 900
    Height = 402
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 2
    object cxGridRamburs: TcxGrid
      Left = 0
      Top = 0
      Width = 896
      Height = 398
      Align = alClient
      BorderStyle = cxcbsNone
      TabOrder = 0
      ExplicitLeft = -2
      ExplicitTop = -2
      object cxGridRambursDBTableView: TcxGridDBTableView
        OnKeyDown = cxGridRambursDBTableViewKeyDown
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        DataController.DataSource = IBCDataSourceDistributieRamburs
        DataController.KeyFieldNames = 'DOCID;CUSTOMERID;AWB'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <
          item
            Format = '0.00'
            Kind = skSum
            FieldName = 'RAMBURS'
            Column = cxGridRambursDBTableViewRAMBURS
          end
          item
            Format = '0.00'
            Kind = skSum
            FieldName = 'PRET_LIVRARE'
            Column = cxGridRambursDBTableViewPRET_LIVRARE
          end>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.IncSearch = True
        OptionsBehavior.ImmediateEditor = False
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.ColumnAutoWidth = True
        OptionsView.Footer = True
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        object cxGridRambursDBTableViewCUSTOMERID: TcxGridDBColumn
          Caption = 'Cod'
          DataBinding.FieldName = 'CUSTOMERID'
          DataBinding.IsNullValueType = True
          HeaderAlignmentHorz = taCenter
        end
        object cxGridRambursDBTableViewCUSTOMER_NAME: TcxGridDBColumn
          Caption = 'Nume client'
          DataBinding.FieldName = 'CUSTOMER_NAME'
          DataBinding.IsNullValueType = True
          HeaderAlignmentHorz = taCenter
          Width = 160
        end
        object cxGridRambursDBTableViewAWB: TcxGridDBColumn
          DataBinding.FieldName = 'AWB'
          DataBinding.IsNullValueType = True
          HeaderAlignmentHorz = taCenter
          Width = 150
        end
        object cxGridRambursDBTableViewRAMBURS: TcxGridDBColumn
          Caption = 'Ramburs'
          DataBinding.FieldName = 'RAMBURS'
          DataBinding.IsNullValueType = True
          HeaderAlignmentHorz = taCenter
          Width = 64
        end
        object cxGridRambursDBTableViewPRET_LIVRARE: TcxGridDBColumn
          Caption = 'Pret livrare'
          DataBinding.FieldName = 'PRET_LIVRARE'
          DataBinding.IsNullValueType = True
          HeaderAlignmentHorz = taCenter
          Width = 64
        end
        object cxGridRambursDBTableViewCOMISION: TcxGridDBColumn
          Caption = 'Comision'
          DataBinding.FieldName = 'COMISION'
          DataBinding.IsNullValueType = True
          HeaderAlignmentHorz = taCenter
          Width = 64
        end
        object cxGridRambursDBTableViewCONTRACTID: TcxGridDBColumn
          Caption = 'Nr contract'
          DataBinding.FieldName = 'CONTRACTID'
          DataBinding.IsNullValueType = True
        end
      end
      object cxGridRambursLevel1: TcxGridLevel
        GridView = cxGridRambursDBTableView
      end
    end
  end
  object cxButton1: TcxButton
    Left = 808
    Top = 513
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'Inchide'
    ModalResult = 8
    TabOrder = 5
  end
  object DialogTitle1: TDialogTitle
    Left = 0
    Top = 0
    Width = 916
    Height = 64
    Title = 'Rambrus'
    Text = 'Distributie ramburs din livrari'
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
    ImageIndex = 35
  end
  object IBCQueryDistributieRamburs: TIBCQuery
    KeyFields = 'DOCID;CUSTOMERID;AWB'
    UpdateTransaction = IBCTrLocal
    SQL.Strings = (
      'select * from vw_tdb_distributie_ramburs')
    MasterFields = 'DOCID'
    DetailFields = 'DOCID'
    AutoCommit = False
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Left = 352
    Top = 432
    ParamData = <
      item
        DataType = ftInteger
        Name = 'DOCID'
        ParamType = ptInput
        Value = 1250212
      end>
  end
  object IBCDataSourceDistributieRamburs: TIBCDataSource
    DataSet = IBCQueryDistributieRamburs
    Left = 352
    Top = 376
  end
  object dxBarManager1: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Default')
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    ImageOptions.Images = dmAdditions.cxImageList_SWN
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 96
    Top = 160
    PixelsPerInch = 96
    DockControlHeights = (
      0
      0
      28
      0)
    object dxBarManager1Bar1: TdxBar
      Caption = 'Custom 1'
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 0
      DockedTop = 0
      DockingStyle = dsTop
      FloatLeft = 1385
      FloatTop = 0
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbNew'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbEdit'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbDelete'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbImport'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object bbNew: TdxBarButton
      Caption = 'Nou'
      Category = 0
      Hint = 'Nou'
      Visible = ivAlways
      ImageIndex = 90
      ShortCut = 45
      OnClick = bbNewClick
    end
    object bbEdit: TdxBarButton
      Caption = 'Modifica'
      Category = 0
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 91
      ShortCut = 115
      OnClick = bbEditClick
    end
    object bbDelete: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 92
      ShortCut = 16430
      OnClick = bbDeleteClick
    end
    object bbImport: TdxBarButton
      Caption = 'Importa'
      Category = 0
      Hint = 'Importa'
      Visible = ivAlways
      OnClick = bbImportClick
    end
  end
  object IBCTrLocal: TIBCTransaction
    Left = 168
    Top = 376
  end
end
