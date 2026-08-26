object frmUserAccessLogSearchDialog: TfrmUserAccessLogSearchDialog
  Left = 0
  Top = 0
  Caption = 'User access web log'
  ClientHeight = 607
  ClientWidth = 1049
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  DesignSize = (
    1049
    607)
  TextHeight = 15
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 1043
    Height = 102
    Align = alTop
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 0
    object cxLabel1: TcxLabel
      Left = 16
      Top = 8
      Caption = 'Perioada'
    end
    object cxDateEdit1: TcxDateEdit
      Left = 16
      Top = 32
      Properties.SaveTime = False
      Properties.ShowTime = False
      TabOrder = 3
      Width = 121
    end
    object cxDateEdit2: TcxDateEdit
      Left = 144
      Top = 32
      Properties.SaveTime = False
      Properties.ShowTime = False
      TabOrder = 4
      Width = 121
    end
    object cxLabel2: TcxLabel
      Left = 304
      Top = 8
      Caption = 'IP'
    end
    object edIP: TcxTextEdit
      Left = 304
      Top = 32
      TabOrder = 5
      Width = 121
    end
    object edSearch: TcxTextEdit
      Left = 456
      Top = 32
      Style.Shadow = False
      TabOrder = 6
      Width = 569
    end
    object cxLabel3: TcxLabel
      Left = 456
      Top = 8
      Caption = 'Cauta in URL'
    end
    object cxButton2: TcxButton
      Left = 16
      Top = 64
      Width = 90
      Height = 29
      Caption = 'Cauta'
      Default = True
      TabOrder = 7
      OnClick = cxButton2Click
    end
  end
  object cxGrid1: TcxGrid
    Left = 8
    Top = 113
    Width = 1033
    Height = 449
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 1
    object cxGrid1DBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      ScrollbarAnnotations.CustomAnnotations = <>
      DataController.DataSource = IBCDataSourceSearch
      DataController.Summary.DefaultGroupSummaryItems = <
        item
          Kind = skCount
          Column = cxGrid1DBTableView1IP
        end>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsCustomize.ColumnsQuickCustomization = True
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.ColumnAutoWidth = True
      object cxGrid1DBTableView1UID: TcxGridDBColumn
        DataBinding.FieldName = 'UID'
        DataBinding.IsNullValueType = True
        Visible = False
        HeaderAlignmentHorz = taCenter
      end
      object cxGrid1DBTableView1IS_BOT: TcxGridDBColumn
        DataBinding.FieldName = 'IS_BOT'
        DataBinding.IsNullValueType = True
        Visible = False
        GroupIndex = 0
        HeaderAlignmentHorz = taCenter
        Width = 43
      end
      object cxGrid1DBTableView1CUSTOMER: TcxGridDBColumn
        Caption = 'Client'
        DataBinding.FieldName = 'CUSTOMER'
        DataBinding.IsNullValueType = True
        HeaderAlignmentHorz = taCenter
        Width = 100
      end
      object cxGrid1DBTableView1DATA: TcxGridDBColumn
        DataBinding.FieldName = 'DATA'
        DataBinding.IsNullValueType = True
        HeaderAlignmentHorz = taCenter
      end
      object cxGrid1DBTableView1IP: TcxGridDBColumn
        DataBinding.FieldName = 'IP'
        DataBinding.IsNullValueType = True
        HeaderAlignmentHorz = taCenter
        Width = 100
      end
      object cxGrid1DBTableView1URL: TcxGridDBColumn
        DataBinding.FieldName = 'URL'
        DataBinding.IsNullValueType = True
        HeaderAlignmentHorz = taCenter
        Width = 700
      end
      object cxGrid1DBTableView1USERAGENT: TcxGridDBColumn
        DataBinding.FieldName = 'USERAGENT'
        DataBinding.IsNullValueType = True
        Visible = False
        HeaderAlignmentHorz = taCenter
        Width = 500
      end
      object cxGrid1DBTableView1SESSIONID: TcxGridDBColumn
        DataBinding.FieldName = 'SESSIONID'
        DataBinding.IsNullValueType = True
        Visible = False
        HeaderAlignmentHorz = taCenter
      end
      object cxGrid1DBTableView1SHOPCARTID: TcxGridDBColumn
        DataBinding.FieldName = 'SHOPCARTID'
        DataBinding.IsNullValueType = True
        Visible = False
        HeaderAlignmentHorz = taCenter
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
    end
  end
  object btnClose: TcxButton
    Left = 480
    Top = 568
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Inchide'
    ModalResult = 8
    TabOrder = 2
  end
  object IBCQuerySearch: TIBCQuery
    SQL.Strings = (
      'select I.CUSTOMER, UA.*'
      'from TWEB_USER_ACCESS_LOG UA'
      'left outer join TWEB_IP I on I.IP = UA.IP  ')
    Left = 520
    Top = 312
  end
  object IBCDataSourceSearch: TIBCDataSource
    DataSet = IBCQuerySearch
    Left = 520
    Top = 264
  end
end
