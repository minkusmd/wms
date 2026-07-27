object frmSMSPromoDialog: TfrmSMSPromoDialog
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  ClientHeight = 604
  ClientWidth = 722
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 722
    Height = 64
    Title = #1057#1052#1057' '#1088#1072#1089#1089#1099#1083#1082#1072
    Text = #1056#1072#1089#1089#1099#1083#1082#1072' '#1057#1052#1057' '#1089#1086#1086#1073#1097#1077#1085#1080#1081
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
    ImageIndex = 30
  end
  object Panel1: TPanel
    Left = 0
    Top = 563
    Width = 722
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 6
    object btnClose: TButton
      Left = 616
      Top = 4
      Width = 90
      Height = 29
      Cancel = True
      Caption = #1047#1072#1082#1088#1099#1090#1100
      ModalResult = 2
      TabOrder = 0
    end
  end
  object cxPageControl1: TcxPageControl
    Left = 0
    Top = 92
    Width = 722
    Height = 471
    Align = alClient
    TabOrder = 3
    Properties.ActivePage = cxTabSheet1
    Properties.CustomButtons.Buttons = <>
    ClientRectBottom = 467
    ClientRectLeft = 4
    ClientRectRight = 718
    ClientRectTop = 24
    object cxTabSheet1: TcxTabSheet
      Caption = #1050#1088#1080#1090#1077#1088#1080#1080' '#1086#1090#1073#1086#1088#1072' '#1087#1086#1076#1087#1080#1089#1095#1080#1082#1086#1074
      ImageIndex = 0
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object cxGroupBox1: TcxGroupBox
        Left = 19
        Top = 0
        Caption = #1055#1077#1088#1080#1086#1076
        TabOrder = 0
        Height = 73
        Width = 313
        object cxDateEdit1: TcxDateEdit
          Left = 16
          Top = 32
          TabOrder = 0
          Width = 121
        end
        object cxDateEdit2: TcxDateEdit
          Left = 152
          Top = 32
          TabOrder = 1
          Width = 121
        end
      end
    end
    object cxTabSheet2: TcxTabSheet
      Caption = 'cxTabSheet2'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object cxGrid1: TcxGrid
        Left = 0
        Top = 0
        Width = 714
        Height = 443
        Align = alClient
        TabOrder = 0
        object cxGrid1DBTableView1: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          Navigator.Visible = True
          ScrollbarAnnotations.CustomAnnotations = <>
          DataController.DataSource = IBCDataSource1
          DataController.KeyFieldNames = 'SMSPROMOID'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.Appending = True
          OptionsData.CancelOnExit = False
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
          object cxGrid1DBTableView1SMSPROMOID: TcxGridDBColumn
            Caption = #1050#1086#1076
            DataBinding.FieldName = 'SMSPROMOID'
            Width = 56
          end
          object cxGrid1DBTableView1CREATED: TcxGridDBColumn
            Caption = #1044#1072#1090#1072
            DataBinding.FieldName = 'CREATED'
            Width = 123
          end
          object cxGrid1DBTableView1SMS_TEXT: TcxGridDBColumn
            Caption = #1058#1077#1082#1089#1090
            DataBinding.FieldName = 'SMS_TEXT'
            PropertiesClassName = 'TcxMemoProperties'
            Width = 541
          end
        end
        object cxGrid1Level1: TcxGridLevel
          GridView = cxGrid1DBTableView1
        end
      end
    end
    object cxTabSheet3: TcxTabSheet
      Caption = #1057#1086#1086#1073#1097#1077#1085#1080#1077
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
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
    Left = 332
    Top = 168
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
      FloatLeft = 712
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarButton1'
        end
        item
          Visible = True
          ItemName = 'dxBarButton2'
        end
        item
          Visible = True
          ItemName = 'dxBarButton3'
        end
        item
          BeginGroup = True
          UserDefine = [udWidth]
          UserWidth = 155
          Visible = True
          ItemName = 'cxBarEditItem1'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton5'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarButton1: TdxBarButton
      Caption = #1053#1086#1074#1072#1103' '#1057#1052#1057' '#1088#1072#1089#1099#1083#1082#1072
      Category = 0
      Hint = #1053#1086#1074#1072#1103' '#1057#1052#1057' '#1088#1072#1089#1099#1083#1082#1072
      Visible = ivAlways
      ImageIndex = 0
    end
    object dxBarButton2: TdxBarButton
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
      Category = 0
      Hint = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
      Visible = ivAlways
      ImageIndex = 1
    end
    object dxBarButton3: TdxBarButton
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Category = 0
      Hint = #1059#1076#1072#1083#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 2
    end
    object dxBarButton5: TdxBarButton
      Caption = #1054#1090#1087#1088#1072#1074#1080#1090#1100' '#1074#1089#1077#1084' '#1090#1077#1082#1091#1097#1080#1102' '#1088#1072#1089#1089#1099#1083#1082#1091
      Category = 0
      Hint = #1054#1090#1087#1088#1072#1074#1080#1090#1100' '#1074#1089#1077#1084' '#1090#1077#1082#1091#1097#1080#1102' '#1088#1072#1089#1089#1099#1083#1082#1091
      Visible = ivAlways
      ImageIndex = 72
      PaintStyle = psCaptionGlyph
      OnClick = dxBarButton5Click
    end
    object cxBarEditItem1: TcxBarEditItem
      Caption = #1058#1077#1083#1077#1092#1086#1085
      Category = 0
      Hint = #1058#1077#1083#1077#1092#1086#1085
      Visible = ivAlways
      ShowCaption = True
      PropertiesClassName = 'TcxButtonEditProperties'
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      Properties.OnButtonClick = cxBarEditItem1PropertiesButtonClick
      InternalEditValue = '069127845'
    end
  end
  object IBCDataSource1: TIBCDataSource
    DataSet = IBCQuery1
    Left = 92
    Top = 176
  end
  object IBCQuery1: TIBCQuery
    KeyFields = 'SMSPROMOID'
    KeyGenerator = 'SQ_TSMS_PROMOID'
    GeneratorMode = gmInsert
    SQLInsert.Strings = (
      'INSERT INTO TSMS_PROMO'
      '  (SMSPROMOID, DT, CREATED, SMS_TEXT, STATE)'
      'VALUES'
      '  (:SMSPROMOID, :DT, :CREATED, :SMS_TEXT, :STATE)')
    SQLDelete.Strings = (
      'DELETE FROM TSMS_PROMO'
      'WHERE'
      '  SMSPROMOID = :Old_SMSPROMOID')
    SQLUpdate.Strings = (
      'UPDATE TSMS_PROMO'
      'SET'
      
        '  SMSPROMOID = :SMSPROMOID, DT = :DT, CREATED = :CREATED, SMS_TE' +
        'XT = :SMS_TEXT, STATE = :STATE'
      'WHERE'
      '  SMSPROMOID = :Old_SMSPROMOID')
    SQLRefresh.Strings = (
      'SELECT SMSPROMOID, DT, CREATED, SMS_TEXT, STATE FROM TSMS_PROMO'
      'WHERE'
      '  SMSPROMOID = :SMSPROMOID')
    SQLLock.Strings = (
      'SELECT NULL FROM TSMS_PROMO'
      'WHERE'
      'SMSPROMOID = :Old_SMSPROMOID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM TSMS_PROMO'
      ''
      ') q')
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'select * from TSMS_PROMO')
    AfterInsert = IBCQuery1AfterInsert
    Left = 88
    Top = 236
  end
end
