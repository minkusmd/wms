object frmRelatedGoodsDlg: TfrmRelatedGoodsDlg
  Left = 0
  Top = 0
  Caption = 'Produse inrudite'
  ClientHeight = 443
  ClientWidth = 626
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  PixelsPerInch = 96
  TextHeight = 15
  object cxGrid1: TcxGrid
    Left = 0
    Top = 28
    Width = 626
    Height = 415
    Align = alClient
    TabOrder = 1
    object cxGrid1DBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      FindPanel.DisplayMode = fpdmAlways
      FindPanel.UseExtendedSyntax = True
      ScrollbarAnnotations.CustomAnnotations = <>
      DataController.DataSource = IBCDataSourceRelatedKeys
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      object cxGrid1DBTableView1RELATED_KEY: TcxGridDBColumn
        Caption = 'Key'
        DataBinding.FieldName = 'RELATED_KEY'
        Width = 218
      end
      object cxGrid1DBTableView1TITLE: TcxGridDBColumn
        Caption = 'Denumire'
        DataBinding.FieldName = 'TITLE'
        Width = 401
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
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
    Left = 296
    Top = 65
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
      FloatLeft = 652
      FloatTop = 2
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbOK'
        end
        item
          Visible = True
          ItemName = 'bbCancel'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbNew'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbModify'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbDelete'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object bbOK: TdxBarButton
      Caption = 'OK'
      Category = 0
      Hint = 'OK'
      Visible = ivAlways
      ImageIndex = 43
      OnClick = bbOKClick
    end
    object bbCancel: TdxBarButton
      Caption = 'Renunta'
      Category = 0
      Hint = 'Renunta'
      Visible = ivAlways
      ImageIndex = 35
      OnClick = bbCancelClick
    end
    object bbNew: TdxBarButton
      Caption = 'Nou'
      Category = 0
      Hint = 'Nou'
      Visible = ivAlways
      ImageIndex = 40
    end
    object bbModify: TdxBarButton
      Caption = 'Modifica'
      Category = 0
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 41
    end
    object bbDelete: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
    end
  end
  object IBCQueryRelatedKeys: TIBCQuery
    KeyFields = 'related_key'
    SQL.Strings = (
      'SELECT * FROM TS_RELATED_KEYS ORDER BY RELATED_KEY')
    Active = True
    Left = 304
    Top = 224
  end
  object IBCDataSourceRelatedKeys: TIBCDataSource
    DataSet = IBCQueryRelatedKeys
    Left = 304
    Top = 160
  end
end
