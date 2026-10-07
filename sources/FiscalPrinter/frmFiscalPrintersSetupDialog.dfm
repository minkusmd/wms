object frmFiscalPrintersSetupDlg: TfrmFiscalPrintersSetupDlg
  Left = 0
  Top = 0
  ActiveControl = cxGridFP
  BorderStyle = bsDialog
  Caption = 'MCC'
  ClientHeight = 365
  ClientWidth = 794
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 794
    Height = 64
    Title = 'MCC'
    Text = 'Gestionarea MCC'
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
    ImageIndex = 26
    ExplicitWidth = 645
  end
  object btnClose: TButton
    Left = 684
    Top = 324
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Inchide'
    Default = True
    ModalResult = 2
    TabOrder = 2
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 778
    Height = 241
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object dxBarDockControl1: TdxBarDockControl
      Left = 0
      Top = 0
      Width = 778
      Height = 26
      Align = dalTop
      BarManager = dxBarManager1
      SunkenBorder = True
      UseOwnSunkenBorder = True
    end
    object cxGridFP: TcxGrid
      Left = 0
      Top = 26
      Width = 778
      Height = 215
      Align = alClient
      TabOrder = 1
      ExplicitTop = 30
      ExplicitWidth = 629
      ExplicitHeight = 211
      object cxGridFPTable: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        OnFocusedRecordChanged = cxGridFPTableFocusedRecordChanged
        DataController.DataSource = IBCDataSourceFP
        DataController.KeyFieldNames = 'FP_ID'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnsQuickCustomization = True
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsSelection.InvertSelect = False
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
        OptionsView.ScrollBars = ssVertical
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        Styles.Header = dmAdditions.cxStyle_GridHeader
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        object cxGridFPTable_FP_ID: TcxGridDBColumn
          Caption = #1050#1086#1076
          DataBinding.FieldName = 'FP_ID'
          Visible = False
          HeaderAlignmentHorz = taCenter
          MinWidth = 40
          Options.HorzSizing = False
          Width = 40
        end
        object cxGridFPTable_FLG_ENABLED: TcxGridDBColumn
          AlternateCaption = #1040#1082#1090#1080#1074#1085#1099#1081' '#1087#1088#1080#1085#1090#1077#1088
          Caption = 'Activ'
          DataBinding.FieldName = 'FLG_ENABLED'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          HeaderAlignmentHorz = taCenter
          MinWidth = 40
          Options.HorzSizing = False
          Width = 40
        end
        object cxGridFPTable_IMG: TcxGridDBColumn
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.Alignment.Horz = taCenter
          Properties.DefaultImageIndex = 47
          Properties.Images = dmAdditions.cxImageList_SWN
          Properties.Items = <>
          MinWidth = 24
          Options.HorzSizing = False
          VisibleForCustomization = False
          Width = 24
        end
        object cxGridFPTable_SERIAL_NUMBER: TcxGridDBColumn
          Caption = 'Numar de serie'
          DataBinding.FieldName = 'SERIAL_NUMBER'
          MinWidth = 120
          Options.HorzSizing = False
          VisibleForCustomization = False
          Width = 120
        end
        object cxGridFPTable_DEVICE_TYPE: TcxGridDBColumn
          Caption = 'Tip'
          DataBinding.FieldName = 'DEVICE_TYPE'
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.Items = <
            item
              Description = 'MCC Tremol'
              Value = 0
            end
            item
              Description = 'Casa ECC'
              Value = 1
            end>
          Width = 90
        end
        object cxGridFPTable_ECC_API_CODE: TcxGridDBColumn
          Caption = 'Cod ECC'
          DataBinding.FieldName = 'ECC_API_CODE'
          Width = 100
        end
        object cxGridFPTable_FIRMA_NAME: TcxGridDBColumn
          Caption = 'Subdiviziune'
          DataBinding.FieldName = 'FIRMA_NAME'
          Width = 175
        end
        object cxGridFPTable_COMPUTER_NAME: TcxGridDBColumn
          Caption = 'Workstation'
          DataBinding.FieldName = 'COMPUTER_NAME'
          Width = 130
        end
        object cxGridFPTable_SERVER_ADDRESS: TcxGridDBColumn
          Caption = 'Server ZFPLab'
          DataBinding.FieldName = 'SERVER_ADDRESS'
          Width = 180
        end
        object cxGridFPTable_DESCRIPTION: TcxGridDBColumn
          Caption = 'Descriere'
          DataBinding.FieldName = 'DESCRIPTION'
          Width = 275
        end
      end
      object cxGridFPLevel: TcxGridLevel
        GridView = cxGridFPTable
      end
    end
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
    Left = 440
    Top = 12
    PixelsPerInch = 96
    object dxBarManager1Bar1: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      BorderStyle = bbsNone
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 669
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      IsMainMenu = True
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
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbDelete'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbFPSharing'
        end>
      MultiLine = True
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = True
    end
    object bbNew: TdxBarButton
      Caption = 'Adauga'
      Category = 0
      Hint = 'Adauga'
      Visible = ivAlways
      ImageIndex = 40
      OnClick = bbNewClick
    end
    object bbEdit: TdxBarButton
      Caption = 'Modifica'
      Category = 0
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 41
      OnClick = bbEditClick
    end
    object bbDelete: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      OnClick = bbDeleteClick
    end
    object bbFPSharing: TdxBarButton
      Caption = 'Acces la MCC'
      Category = 0
      Hint = 'Acces la MCC'
      Visible = ivAlways
      ImageIndex = 44
      OnClick = bbFPSharingClick
    end
  end
  object IBCQueryFP: TIBCQuery
    KeyFields = 'FP_ID'
    KeyGenerator = 'SQ_FP_DEVICES_ID'
    GeneratorMode = gmInsert
    SQLInsert.Strings = (
      'INSERT INTO FP_DEVICES'
      '  (FP_ID, FIRMA_ID, WS_ID, SERIAL_NUMBER, DESCRIPTION,'
      '   FLG_ENABLED, SERVER_ADDRESS, COM_PORT, BAUD_RATE,'
      '   DEVICE_TYPE, ECC_API_CODE)'
      'VALUES'
      '  (:FP_ID, :FIRMA_ID, :WS_ID, :SERIAL_NUMBER, :DESCRIPTION,'
      '   :FLG_ENABLED, :SERVER_ADDRESS, :COM_PORT, :BAUD_RATE,'
      '   :DEVICE_TYPE, :ECC_API_CODE)')
    SQLDelete.Strings = (
      'DELETE FROM FP_DEVICES'
      'WHERE'
      '  FP_ID = :Old_FP_ID')
    SQLUpdate.Strings = (
      'UPDATE FP_DEVICES'
      'SET'
      '  FP_ID = :FP_ID, '
      '  FIRMA_ID = :FIRMA_ID, '
      '  WS_ID = :WS_ID, '
      '  SERIAL_NUMBER = :SERIAL_NUMBER, '
      '  DESCRIPTION = :DESCRIPTION, '
      '  FLG_ENABLED = :FLG_ENABLED, '
      '  SERVER_ADDRESS = :SERVER_ADDRESS, '
      '  COM_PORT = :COM_PORT, '
      '  BAUD_RATE = :BAUD_RATE, '
      '  DEVICE_TYPE = :DEVICE_TYPE, '
      '  ECC_API_CODE = :ECC_API_CODE'
      'WHERE'
      '  FP_ID = :Old_FP_ID')
    SQLRefresh.Strings = (
      'SELECT '
      ' V.FP_ID, '
      ' V.FIRMA_ID, '
      ' V.FIRMA_NAME, '
      ' V.WS_ID, '
      ' V.COMPUTER_NAME, '
      ' V.SERIAL_NUMBER, '
      ' V.DESCRIPTION, '
      ' V.FLG_ENABLED, '
      ' V.SERVER_ADDRESS, '
      ' V.COM_PORT, '
      ' V.BAUD_RATE, '
      ' D.DEVICE_TYPE, '
      ' D.ECC_API_CODE'
      'FROM '
      ' VW_FP_DEVICES V'
      ' INNER JOIN FP_DEVICES D ON D.FP_ID = V.FP_ID'
      'WHERE'
      ' V.FP_ID = :FP_ID')
    SQLLock.Strings = (
      'SELECT NULL FROM FP_DEVICES'
      'WHERE'
      'FP_ID = :Old_FP_ID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = IBCTrUpdate
    SQL.Strings = (
      'SELECT '
      ' V.FP_ID, '
      ' V.FIRMA_ID, '
      ' V.FIRMA_NAME, '
      ' V.WS_ID, '
      ' V.COMPUTER_NAME, '
      ' V.SERIAL_NUMBER, '
      ' V.DESCRIPTION, '
      ' V.FLG_ENABLED, '
      ' V.SERVER_ADDRESS, '
      ' V.COM_PORT, '
      ' V.BAUD_RATE, '
      ' D.DEVICE_TYPE, '
      ' D.ECC_API_CODE'
      'FROM '
      ' VW_FP_DEVICES V'
      ' INNER JOIN FP_DEVICES D ON D.FP_ID = V.FP_ID')
    AutoCommit = False
    Options.SetFieldsReadOnly = False
    LockMode = lmLockImmediate
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Left = 64
    Top = 152
  end
  object IBCDataSourceFP: TIBCDataSource
    DataSet = IBCQueryFP
    Left = 64
    Top = 208
  end
  object IBCTrUpdate: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 64
    Top = 268
  end
end
