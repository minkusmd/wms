object frameSipCustomerCallsHistory: TframeSipCustomerCallsHistory
  Left = 0
  Top = 0
  Margins.Left = 4
  Margins.Top = 4
  Margins.Right = 4
  Margins.Bottom = 4
  ClientHeight = 314
  ClientWidth = 1199
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Segoe UI'
  Font.Style = []
  PixelsPerInch = 120
  TextHeight = 20
  object cxGrid1: TcxGrid
    Left = 0
    Top = 32
    Width = 1199
    Height = 282
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    TabOrder = 1
    object cxGrid1DBTableView1: TcxGridDBTableView
      DataController.DataSource = IBCDataSourceDialHistory
      FilterRow.SeparatorWidth = 8
      FixedDataRows.SeparatorWidth = 8
      NewItemRow.SeparatorWidth = 8
      OptionsBehavior.ImmediateEditor = False
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NavigatorOffset = 63
      OptionsView.ColumnAutoWidth = True
      OptionsView.FixedColumnSeparatorWidth = 3
      OptionsView.GroupByBox = False
      Preview.LeftIndent = 25
      Preview.RightIndent = 6
      RowLayout.MinValueWidth = 100
      object cxGrid1DBTableView1Column1: TcxGridDBColumn
        Caption = '...'
        DataBinding.FieldName = 'CALLTYPEID'
        PropertiesClassName = 'TcxImageComboBoxProperties'
        Properties.Images = dmAdditions.cxImageList_SWN
        Properties.Items = <
          item
            ImageIndex = 131
            Value = 1
          end
          item
            ImageIndex = 132
            Value = 0
          end>
        HeaderAlignmentHorz = taCenter
        MinWidth = 33
        Options.HorzSizing = False
        Width = 33
      end
      object cxGrid1DBTableView1DATA: TcxGridDBColumn
        Caption = 'Data'
        DataBinding.FieldName = 'DATA'
        HeaderAlignmentHorz = taCenter
        MinWidth = 25
        Width = 125
      end
      object cxGrid1DBTableView1SOURCEID: TcxGridDBColumn
        Caption = 'Telefon'
        DataBinding.FieldName = 'SOURCEID'
        HeaderAlignmentHorz = taCenter
        MinWidth = 25
        Width = 150
      end
      object cxGrid1DBTableView1Column2: TcxGridDBColumn
        Caption = 'Durata'
        DataBinding.FieldName = 'DURATION'
        MinWidth = 25
        Width = 100
      end
      object cxGrid1DBTableView1WAV: TcxGridDBColumn
        DataBinding.FieldName = 'WAV'
        Visible = False
        MinWidth = 80
        Options.HorzSizing = False
        VisibleForCustomization = False
      end
      object cxGrid1DBTableView1USERNAME: TcxGridDBColumn
        Caption = 'Operator'
        DataBinding.FieldName = 'USERNAME'
        HeaderAlignmentHorz = taCenter
        MinWidth = 25
        Width = 250
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
    end
  end
  object IBCDataSourceDialHistory: TIBCDataSource
    DataSet = IBCQueryDialHistory
    Left = 122
    Top = 91
  end
  object IBCQueryDialHistory: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'select p.data, P.CALLTYPEID, PH.DURATION,'
      '       (select FULL_NAME'
      '        from TS_USERS'
      
        '        where USERID = p.userid) USERNAME, P.PHONENUMBER CALLID,' +
        ' PH.WAV, PH.SOURCEID'
      'from TS_PHONE_CALLS_HISTORY P'
      
        'left outer join TS_PHONE_CALLS_REGISTER PH on P.CALLID = PH.CALL' +
        'ID'
      'inner join SP_SPLIT_STR(:PHONENUMBER) s on s.str = p.phonenumber'
      'order by P.data desc')
    Left = 126
    Top = 161
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'phonenumber'
        Value = nil
      end>
  end
  object dxBarManager: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Default'
      'Apeluri')
    Categories.ItemsVisibles = (
      2
      2)
    Categories.Visibles = (
      True
      True)
    ImageOptions.Images = dmAdditions.cxImageList_SWN
    ImageOptions.StretchGlyphs = False
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 293
    Top = 81
    PixelsPerInch = 120
    DockControlHeights = (
      0
      0
      32
      0)
    object dxBarManagerBar2: TdxBar
      Caption = 'Apeluri'
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 0
      DockedTop = 0
      DockingStyle = dsTop
      FloatLeft = 645
      FloatTop = 10
      FloatClientWidth = 72
      FloatClientHeight = 77
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbPlay'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbStop'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbSaveAs'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object lcbCustomers: TcxBarEditItem
      Align = iaClient
      Caption = 'Client'
      Category = 0
      Hint = 'Client'
      Visible = ivAlways
      ShowCaption = True
      Width = 125
      PropertiesClassName = 'TcxLookupComboBoxProperties'
      Properties.DropDownListStyle = lsFixedList
      Properties.ImmediatePost = True
      Properties.KeyFieldNames = 'CUSTOMERID'
      Properties.ListColumns = <
        item
          FieldName = 'DISPLAYNAME'
        end>
      Properties.ListOptions.ShowHeader = False
      StyleEdit = dmAdditions.cxStyle_Bold
      InternalEditValue = 0
    end
    object bbPlay: TdxBarButton
      Caption = 'Play'
      Category = 1
      Hint = 'Play'
      Visible = ivAlways
      ImageIndex = 72
    end
    object bbSaveAs: TdxBarButton
      Caption = 'Salveaza'
      Category = 1
      Hint = 'Salveaza'
      Visible = ivAlways
      ImageIndex = 32
    end
    object bbStop: TdxBarButton
      Caption = 'Stop'
      Category = 1
      Hint = 'Stop'
      Visible = ivAlways
      ImageIndex = 133
    end
  end
end
