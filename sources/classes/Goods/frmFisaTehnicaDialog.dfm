object frmFisaTehnicaDlg: TfrmFisaTehnicaDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Specificatia tehnica'
  ClientHeight = 633
  ClientWidth = 564
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
  object DialogTitle1: TDialogTitle
    Left = 0
    Top = 0
    Width = 564
    Height = 64
    Title = 'Specificatia tehnica'
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
    ExplicitLeft = 3
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 67
    Width = 558
    Height = 506
    Align = alTop
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 1
    object dxBarDockControl1: TdxBarDockControl
      Left = 0
      Top = 77
      Width = 558
      Height = 30
      Align = dalTop
      BarManager = dxBarManager
      SunkenBorder = True
      UseOwnSunkenBorder = True
    end
    object cxDBVerticalGrid1: TcxDBVerticalGrid
      Left = 0
      Top = 107
      Width = 558
      Height = 399
      Align = alClient
      OptionsView.ScrollBars = ssVertical
      OptionsView.RowHeaderWidth = 223
      OptionsBehavior.AlwaysShowEditor = True
      OptionsBehavior.GoToNextCellOnEnter = True
      OptionsBehavior.GoToNextCellOnTab = True
      OptionsBehavior.RowTracking = False
      OptionsBehavior.AllowChangeRecord = False
      OptionsData.CancelOnExit = False
      OptionsData.Appending = False
      OptionsData.Deleting = False
      OptionsData.Inserting = False
      Navigator.Buttons.CustomButtons = <>
      ScrollbarAnnotations.CustomAnnotations = <>
      TabOrder = 2
      DataController.DataSource = IBCDataSourceFisa
      Version = 1
      object cxDBVerticalGrid1CategoryRow1: TcxCategoryRow
        Options.Focusing = False
        Options.ShowExpandButton = False
        Options.TabStop = False
        Properties.Caption = 'Parametri tehnici'
        ID = 0
        ParentID = -1
        Index = 0
        Version = 1
      end
      object cxDBVerticalGrid1DBMultiEditorRow1: TcxDBMultiEditorRow
        Properties.Editors = <
          item
            Caption = 'CPU'
            Width = 100
            DataBinding.FieldName = 'CP_CPU'
          end
          item
            Caption = 'cant'
            HeaderAlignmentHorz = taCenter
            Width = 40
            DataBinding.FieldName = 'QTY_CPU'
          end>
        Styles.Content = dmAdditions.cxStyle_Bold
        ID = 1
        ParentID = -1
        Index = 1
        Version = 1
      end
      object cxDBVerticalGrid1DBMultiEditorRow2: TcxDBMultiEditorRow
        Properties.Editors = <
          item
            Caption = 'RAM'
            Width = 100
            DataBinding.FieldName = 'CP_RAM'
          end
          item
            Caption = 'cant'
            HeaderAlignmentHorz = taCenter
            Width = 40
            DataBinding.FieldName = 'QTY_RAM'
          end>
        Styles.Content = dmAdditions.cxStyle_Bold
        ID = 2
        ParentID = -1
        Index = 2
        Version = 1
      end
      object cxDBVerticalGrid1DBMultiEditorRow3: TcxDBMultiEditorRow
        Properties.Editors = <
          item
            Caption = 'MB'
            Width = 100
            DataBinding.FieldName = 'CP_MB'
          end
          item
            Caption = 'cant'
            HeaderAlignmentHorz = taCenter
            Width = 40
            DataBinding.FieldName = 'QTY_MB'
          end>
        Styles.Content = dmAdditions.cxStyle_Bold
        ID = 3
        ParentID = -1
        Index = 3
        Version = 1
      end
      object cxDBVerticalGrid1DBMultiEditorRow4: TcxDBMultiEditorRow
        Properties.Editors = <
          item
            Caption = 'VGA'
            Width = 100
            DataBinding.FieldName = 'CP_VGA'
          end
          item
            Caption = 'cant'
            HeaderAlignmentHorz = taCenter
            Width = 40
            DataBinding.FieldName = 'QTY_VGA'
          end>
        Styles.Content = dmAdditions.cxStyle_Bold
        ID = 4
        ParentID = -1
        Index = 4
        Version = 1
      end
      object cxDBVerticalGrid1DBMultiEditorRow5: TcxDBMultiEditorRow
        Properties.Editors = <
          item
            Caption = 'HDD'
            Width = 100
            DataBinding.FieldName = 'CP_HDD'
          end
          item
            Caption = 'cant'
            HeaderAlignmentHorz = taCenter
            Width = 40
            DataBinding.FieldName = 'QTY_HDD'
          end>
        Styles.Content = dmAdditions.cxStyle_Bold
        ID = 5
        ParentID = -1
        Index = 5
        Version = 1
      end
      object cxDBVerticalGrid1DBMultiEditorRow6: TcxDBMultiEditorRow
        Properties.Editors = <
          item
            Caption = 'ODD'
            Width = 100
            DataBinding.FieldName = 'CP_ODD'
          end
          item
            Caption = 'cant'
            HeaderAlignmentHorz = taCenter
            Width = 40
            DataBinding.FieldName = 'QTY_ODD'
          end>
        Styles.Content = dmAdditions.cxStyle_Bold
        ID = 6
        ParentID = -1
        Index = 6
        Version = 1
      end
      object cxDBVerticalGrid1DBMultiEditorRow7: TcxDBMultiEditorRow
        Properties.Editors = <
          item
            Caption = 'FDD'
            Width = 100
            DataBinding.FieldName = 'CP_FDD'
          end
          item
            Caption = 'cant'
            HeaderAlignmentHorz = taCenter
            Width = 40
            DataBinding.FieldName = 'QTY_FDD'
          end>
        Styles.Content = dmAdditions.cxStyle_Bold
        ID = 7
        ParentID = -1
        Index = 7
        Version = 1
      end
      object cxDBVerticalGrid1DBMultiEditorRow8: TcxDBMultiEditorRow
        Properties.Editors = <
          item
            Caption = 'Card Reader'
            Width = 100
            DataBinding.FieldName = 'CP_CR'
          end
          item
            Caption = 'cant'
            HeaderAlignmentHorz = taCenter
            Width = 40
            DataBinding.FieldName = 'QTY_CR'
          end>
        Styles.Content = dmAdditions.cxStyle_Bold
        ID = 8
        ParentID = -1
        Index = 8
        Version = 1
      end
      object cxDBVerticalGrid1DBMultiEditorRow9: TcxDBMultiEditorRow
        Properties.Editors = <
          item
            Caption = 'TV-Tuner'
            Width = 100
            DataBinding.FieldName = 'CP_TV'
          end
          item
            Caption = 'cant'
            HeaderAlignmentHorz = taCenter
            Width = 40
            DataBinding.FieldName = 'QTY_TV'
          end>
        Styles.Content = dmAdditions.cxStyle_Bold
        ID = 9
        ParentID = -1
        Index = 9
        Version = 1
      end
      object cxDBVerticalGrid1DBMultiEditorRow10: TcxDBMultiEditorRow
        Properties.Editors = <
          item
            Caption = 'PSU'
            Width = 100
            DataBinding.FieldName = 'CP_PSU'
          end
          item
            Caption = 'cant'
            HeaderAlignmentHorz = taCenter
            Width = 40
            DataBinding.FieldName = 'QTY_PSU'
          end>
        Styles.Content = dmAdditions.cxStyle_Bold
        ID = 10
        ParentID = -1
        Index = 10
        Version = 1
      end
      object cxDBVerticalGrid1DBMultiEditorRow11: TcxDBMultiEditorRow
        Properties.Editors = <
          item
            Caption = 'SOFTWARE'
            Width = 100
            DataBinding.FieldName = 'CP_SOFT'
          end
          item
            Caption = 'cant'
            HeaderAlignmentHorz = taCenter
            Width = 40
            DataBinding.FieldName = 'QTY_SOFT'
          end>
        Styles.Content = dmAdditions.cxStyle_Bold
        ID = 11
        ParentID = -1
        Index = 11
        Version = 1
      end
      object cxDBVerticalGrid1DBMultiEditorRow12: TcxDBMultiEditorRow
        Properties.Editors = <
          item
            Caption = 'NETWORK'
            Width = 100
            DataBinding.FieldName = 'CP_NETWORK'
          end
          item
            Caption = 'cant'
            HeaderAlignmentHorz = taCenter
            Width = 40
            DataBinding.FieldName = 'QTY_NETWORK'
          end>
        Styles.Content = dmAdditions.cxStyle_Bold
        ID = 12
        ParentID = -1
        Index = 12
        Version = 1
      end
      object cxDBVerticalGrid1DBMultiEditorRow13: TcxDBMultiEditorRow
        Properties.Editors = <
          item
            Caption = 'AUDIO'
            Width = 100
            DataBinding.FieldName = 'CP_AUDIO'
          end
          item
            Caption = 'cant'
            HeaderAlignmentHorz = taCenter
            Width = 40
            DataBinding.FieldName = 'QTY_AUDIO'
          end>
        Styles.Content = dmAdditions.cxStyle_Bold
        ID = 13
        ParentID = -1
        Index = 13
        Version = 1
      end
      object cxDBVerticalGrid1CategoryRow2: TcxCategoryRow
        Properties.Caption = 'Componenta produsului'
        ID = 14
        ParentID = -1
        Index = 14
        Version = 1
      end
      object cxDBVerticalGrid1DBEditorRow1: TcxDBEditorRow
        Properties.Caption = 'Frecventa (GHz)'
        Properties.DataBinding.FieldName = 'PT1'
        Styles.Content = dmAdditions.cxStyle_Bold
        ID = 15
        ParentID = -1
        Index = 15
        Version = 1
      end
      object cxDBVerticalGrid1DBEditorRow2: TcxDBEditorRow
        Properties.Caption = 'Volumul RAM (GB)'
        Properties.DataBinding.FieldName = 'PT2'
        Styles.Content = dmAdditions.cxStyle_Bold
        ID = 16
        ParentID = -1
        Index = 16
        Version = 1
      end
      object cxDBVerticalGrid1DBEditorRow3: TcxDBEditorRow
        Properties.Caption = 'Volumul HDD/SDD (GB)'
        Properties.DataBinding.FieldName = 'PT3'
        Styles.Content = dmAdditions.cxStyle_Bold
        ID = 17
        ParentID = -1
        Index = 17
        Version = 1
      end
      object cxDBVerticalGrid1DBEditorRow4: TcxDBEditorRow
        Properties.Caption = 'Productivitatea MIPS'
        Properties.DataBinding.FieldName = 'PT4'
        Styles.Content = dmAdditions.cxStyle_Bold
        ID = 18
        ParentID = -1
        Index = 18
        Version = 1
      end
      object cxDBVerticalGrid1DBEditorRow5: TcxDBEditorRow
        Properties.Caption = 'Productivitatea VIDEO'
        Properties.DataBinding.FieldName = 'PT5'
        Styles.Content = dmAdditions.cxStyle_Bold
        ID = 19
        ParentID = -1
        Index = 19
        Version = 1
      end
      object cxDBVerticalGrid1CategoryRow3: TcxCategoryRow
        Properties.Caption = 'Generale'
        ID = 20
        ParentID = -1
        Index = 20
        Version = 1
      end
      object cxDBVerticalGrid1DBEditorRow6: TcxDBEditorRow
        Properties.Caption = 'Model'
        Properties.DataBinding.FieldName = 'MODEL'
        Styles.Content = dmAdditions.cxStyle_Bold
        ID = 21
        ParentID = -1
        Index = 21
        Version = 1
      end
      object cxDBVerticalGrid1DBEditorRow7: TcxDBEditorRow
        Properties.Caption = 'Masa brutto (kg)'
        Properties.DataBinding.FieldName = 'MASA_BRUTA'
        Styles.Content = dmAdditions.cxStyle_Bold
        ID = 22
        ParentID = -1
        Index = 22
        Version = 1
      end
      object cxDBVerticalGrid1DBEditorRow8: TcxDBEditorRow
        Properties.Caption = 'Marimi'
        Properties.DataBinding.FieldName = 'DIMENSIUNI'
        Styles.Content = dmAdditions.cxStyle_Bold
        ID = 23
        ParentID = -1
        Index = 23
        Version = 1
      end
      object cxDBVerticalGrid1DBEditorRow9: TcxDBEditorRow
        Properties.Caption = 'Timpul de exploatare'
        Properties.DataBinding.FieldName = 'DURATA_FUNCTIONARE'
        Styles.Content = dmAdditions.cxStyle_Bold
        ID = 24
        ParentID = -1
        Index = 24
        Version = 1
      end
      object cxDBVerticalGrid1DBEditorRow10: TcxDBEditorRow
        Properties.Caption = 'Consumul (W)'
        Properties.DataBinding.FieldName = 'CONSUM'
        Styles.Content = dmAdditions.cxStyle_Bold
        ID = 25
        ParentID = -1
        Index = 25
        Version = 1
      end
      object cxDBVerticalGrid1DBEditorRow11: TcxDBEditorRow
        Properties.Caption = 'Temperatura CPU'
        Properties.DataBinding.FieldName = 'CPU_TEMP'
        Styles.Content = dmAdditions.cxStyle_Bold
        ID = 26
        ParentID = -1
        Index = 26
        Version = 1
      end
      object cxDBVerticalGrid1DBEditorRow12: TcxDBEditorRow
        Properties.Caption = 'Temperatura VGA'
        Properties.DataBinding.FieldName = 'VGA_TEMP'
        Styles.Content = dmAdditions.cxStyle_Bold
        ID = 27
        ParentID = -1
        Index = 27
        Version = 1
      end
    end
    object pnGoods: TPanel
      AlignWithMargins = True
      Left = 0
      Top = 0
      Width = 558
      Height = 73
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 4
      Align = alTop
      BevelKind = bkFlat
      BevelOuter = bvNone
      Color = clWindow
      ParentBackground = False
      TabOrder = 0
      object Label1: TLabel
        Left = 12
        Top = 12
        Width = 37
        Height = 15
        Caption = 'Produs'
      end
      object mmInfo: TcxDBMemo
        Left = 51
        Top = 8
        TabStop = False
        DataBinding.DataField = 'TITLE'
        Properties.ReadOnly = True
        Properties.ScrollBars = ssVertical
        Properties.VisibleLineCount = 3
        TabOrder = 0
        Width = 494
      end
    end
  end
  object btnOk: TcxButton
    Left = 364
    Top = 588
    Width = 90
    Height = 29
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TcxButton
    Left = 460
    Top = 588
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
  object dxBarManager: TdxBarManager
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
    ImageOptions.StretchGlyphs = False
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 352
    Top = 12
    PixelsPerInch = 96
    object dxBarManagerBar1: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Custom 1'
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 588
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
  end
  object IBCQueryFisa: TIBCQuery
    SQLInsert.Strings = (
      'INSERT INTO TS_GOODS_FISA_TEHNICA'
      
        '  (GOODSID, MASA_BRUTA, DIMENSIUNI, CONSUM, MODEL, DURATA_FUNCTI' +
        'ONARE, TERMEN_GARANTIE, CP_CPU, CP_RAM, CP_MB, CP_VGA, CP_HDD, C' +
        'P_ODD, CP_FDD, CP_CR, CP_TV, CP_PSU, CP_SOFT, PT1, PT2, PT3, PT4' +
        ', PT5, QTY_CPU, QTY_MB, QTY_VGA, QTY_HDD, QTY_ODD, QTY_FDD, QTY_' +
        'CR, QTY_TV, QTY_PSU, QTY_SOFT, QTY_RAM, CPU_TEMP, VGA_TEMP, CP_A' +
        'UDIO, CP_NETWORK, QTY_AUDIO, QTY_NETWORK)'
      'VALUES'
      
        '  (:GOODSID, :MASA_BRUTA, :DIMENSIUNI, :CONSUM, :MODEL, :DURATA_' +
        'FUNCTIONARE, :TERMEN_GARANTIE, :CP_CPU, :CP_RAM, :CP_MB, :CP_VGA' +
        ', :CP_HDD, :CP_ODD, :CP_FDD, :CP_CR, :CP_TV, :CP_PSU, :CP_SOFT, ' +
        ':PT1, :PT2, :PT3, :PT4, :PT5, :QTY_CPU, :QTY_MB, :QTY_VGA, :QTY_' +
        'HDD, :QTY_ODD, :QTY_FDD, :QTY_CR, :QTY_TV, :QTY_PSU, :QTY_SOFT, ' +
        ':QTY_RAM, :CPU_TEMP, :VGA_TEMP, :CP_AUDIO, :CP_NETWORK, :QTY_AUD' +
        'IO, :QTY_NETWORK)')
    SQLDelete.Strings = (
      'DELETE FROM TS_GOODS_FISA_TEHNICA'
      'WHERE'
      '  GOODSID = :Old_GOODSID')
    SQLUpdate.Strings = (
      'UPDATE TS_GOODS_FISA_TEHNICA'
      'SET'
      
        '  GOODSID = :GOODSID, MASA_BRUTA = :MASA_BRUTA, DIMENSIUNI = :DI' +
        'MENSIUNI, CONSUM = :CONSUM, MODEL = :MODEL, DURATA_FUNCTIONARE =' +
        ' :DURATA_FUNCTIONARE, TERMEN_GARANTIE = :TERMEN_GARANTIE, CP_CPU' +
        ' = :CP_CPU, CP_RAM = :CP_RAM, CP_MB = :CP_MB, CP_VGA = :CP_VGA, ' +
        'CP_HDD = :CP_HDD, CP_ODD = :CP_ODD, CP_FDD = :CP_FDD, CP_CR = :C' +
        'P_CR, CP_TV = :CP_TV, CP_PSU = :CP_PSU, CP_SOFT = :CP_SOFT, PT1 ' +
        '= :PT1, PT2 = :PT2, PT3 = :PT3, PT4 = :PT4, PT5 = :PT5, QTY_CPU ' +
        '= :QTY_CPU, QTY_MB = :QTY_MB, QTY_VGA = :QTY_VGA, QTY_HDD = :QTY' +
        '_HDD, QTY_ODD = :QTY_ODD, QTY_FDD = :QTY_FDD, QTY_CR = :QTY_CR, ' +
        'QTY_TV = :QTY_TV, QTY_PSU = :QTY_PSU, QTY_SOFT = :QTY_SOFT, QTY_' +
        'RAM = :QTY_RAM, CPU_TEMP = :CPU_TEMP, VGA_TEMP = :VGA_TEMP, CP_A' +
        'UDIO = :CP_AUDIO, CP_NETWORK = :CP_NETWORK, QTY_AUDIO = :QTY_AUD' +
        'IO, QTY_NETWORK = :QTY_NETWORK'
      'WHERE'
      '  GOODSID = :Old_GOODSID')
    SQLRefresh.Strings = (
      
        'SELECT GOODSID, MASA_BRUTA, DIMENSIUNI, CONSUM, MODEL, DURATA_FU' +
        'NCTIONARE, TERMEN_GARANTIE, CP_CPU, CP_RAM, CP_MB, CP_VGA, CP_HD' +
        'D, CP_ODD, CP_FDD, CP_CR, CP_TV, CP_PSU, CP_SOFT, PT1, PT2, PT3,' +
        ' PT4, PT5, QTY_CPU, QTY_MB, QTY_VGA, QTY_HDD, QTY_ODD, QTY_FDD, ' +
        'QTY_CR, QTY_TV, QTY_PSU, QTY_SOFT, QTY_RAM, CPU_TEMP, VGA_TEMP, ' +
        'CP_AUDIO, CP_NETWORK, QTY_AUDIO, QTY_NETWORK FROM TS_GOODS_FISA_' +
        'TEHNICA'
      'WHERE'
      '  GOODSID = :GOODSID')
    SQLLock.Strings = (
      'SELECT NULL FROM TS_GOODS_FISA_TEHNICA'
      'WHERE'
      'GOODSID = :Old_GOODSID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = IBCTrUpdate
    UpdateTransaction = IBCTrUpdate
    SQL.Strings = (
      'SELECT * FROM TS_GOODS_FISA_TEHNICA'
      'WHERE GOODSID=:GoodsID')
    AutoCommit = False
    Left = 212
    Top = 84
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'GoodsID'
        Value = nil
      end>
  end
  object IBCDataSourceFisa: TIBCDataSource
    DataSet = IBCQueryFisa
    Left = 212
    Top = 32
  end
  object IBCTrUpdate: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 264
    Top = 236
  end
end
