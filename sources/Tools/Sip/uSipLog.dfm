object frmSipLog: TfrmSipLog
  Left = 0
  Top = 0
  ActiveControl = tePhoneNumber
  Caption = 'Log Sip'
  ClientHeight = 564
  ClientWidth = 753
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object DialogTitle1: TDialogTitle
    Left = 0
    Top = 0
    Width = 753
    Height = 64
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
    ImageIndex = 15
  end
  object Panel1: TPanel
    Left = 0
    Top = 64
    Width = 753
    Height = 83
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object tePhoneNumber: TcxTextEdit
      Left = 97
      Top = 39
      TabOrder = 3
      Width = 121
    end
    object cxLabel2: TcxLabel
      Left = 16
      Top = 41
      Caption = 'numar client'
    end
    object cxDateEdit1: TcxDateEdit
      Left = 97
      Top = 10
      TabOrder = 0
      Width = 121
    end
    object cxLabel1: TcxLabel
      Left = 16
      Top = 14
      Caption = 'Perioada'
    end
    object cxDateEdit2: TcxDateEdit
      Left = 224
      Top = 10
      TabOrder = 1
      Width = 121
    end
    object cxLabel3: TcxLabel
      Left = 384
      Top = 10
      Caption = 'Client'
    end
    object beUserName: TcxButtonEdit
      Left = 431
      Top = 9
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end
        item
          Caption = 'x'
          Kind = bkText
        end>
      Properties.ClearKey = 46
      Properties.OnButtonClick = cxButtonEdit1PropertiesButtonClick
      TabOrder = 7
      Width = 322
    end
    object cxButton1: TcxButton
      Left = 624
      Top = 38
      Width = 129
      Height = 29
      Caption = 'Aplica filtru'
      Default = True
      TabOrder = 5
      OnClick = cxButton1Click
    end
  end
  object dxBarDockControl1: TdxBarDockControl
    Left = 0
    Top = 147
    Width = 753
    Height = 28
    Align = dalTop
    BarManager = dxBarManager1
  end
  object cxGrid1: TcxGrid
    Left = 0
    Top = 175
    Width = 753
    Height = 348
    Align = alClient
    TabOrder = 3
    object cxGrid1DBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      ScrollbarAnnotations.CustomAnnotations = <>
      OnCustomDrawCell = cxGrid1DBTableView1CustomDrawCell
      DataController.DataSource = IBCDataSourcePhoneCalls
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <
        item
          Kind = skCount
          FieldName = 'CALLID'
          Column = cxGrid1DBTableView1CALLID
        end>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.IncSearch = True
      OptionsBehavior.ImmediateEditor = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.Footer = True
      OptionsView.GroupByBox = False
      object cxGrid1DBTableView1CALLTYPEID: TcxGridDBColumn
        Caption = 'Tip'
        DataBinding.FieldName = 'CALLTYPEID'
        DataBinding.IsNullValueType = True
        PropertiesClassName = 'TcxImageComboBoxProperties'
        Properties.DefaultImageIndex = 59
        Properties.Images = dmAdditions.cxImageList_SWN
        Properties.Items = <
          item
            Description = 'Income'
            ImageIndex = 59
            Value = 0
          end
          item
            Description = 'Outgoing'
            ImageIndex = 60
            Value = 1
          end>
        HeaderAlignmentHorz = taCenter
        MinWidth = 26
        Options.HorzSizing = False
        Width = 26
      end
      object cxGrid1DBTableView1CALLID: TcxGridDBColumn
        Caption = 'ID'
        DataBinding.FieldName = 'CALLID'
        DataBinding.IsNullValueType = True
        HeaderAlignmentHorz = taCenter
        Width = 79
      end
      object cxGrid1DBTableView1FULL_NAME: TcxGridDBColumn
        Caption = 'Utilizator'
        DataBinding.FieldName = 'FULL_NAME'
        DataBinding.IsNullValueType = True
        HeaderAlignmentHorz = taCenter
        Width = 147
      end
      object cxGrid1DBTableView1DATA: TcxGridDBColumn
        Caption = 'Data'
        DataBinding.FieldName = 'DATA'
        DataBinding.IsNullValueType = True
        HeaderAlignmentHorz = taCenter
        Width = 79
      end
      object cxGrid1DBTableView1PHONENUMBER: TcxGridDBColumn
        Caption = 'Numar'
        DataBinding.FieldName = 'PHONENUMBER'
        DataBinding.IsNullValueType = True
        HeaderAlignmentHorz = taCenter
        Width = 78
      end
      object cxGrid1DBTableView1NICKNAME: TcxGridDBColumn
        Caption = 'Client'
        DataBinding.FieldName = 'NICKNAME'
        DataBinding.IsNullValueType = True
        HeaderAlignmentHorz = taCenter
        Width = 218
      end
      object cxGrid1DBTableView1Column1: TcxGridDBColumn
        Caption = 'CUSTOMER_NAME'
        DataBinding.FieldName = 'NAME'
        DataBinding.IsNullValueType = True
        Visible = False
        HeaderAlignmentHorz = taCenter
        Width = 150
      end
      object cxGrid1DBTableView1_FLG_HAS_WAV: TcxGridDBColumn
        Caption = 'Wav'
        DataBinding.FieldName = 'FLG_HAS_WAV'
        DataBinding.IsNullValueType = True
        HeaderAlignmentHorz = taCenter
        MinWidth = 62
        Options.HorzSizing = False
        Width = 62
      end
      object cxGrid1DBTableView1_DURATION: TcxGridDBColumn
        Caption = 'Durata'
        DataBinding.FieldName = 'DURATION'
        DataBinding.IsNullValueType = True
        HeaderAlignmentHorz = taCenter
        Width = 62
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 523
    Width = 753
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 4
    object btnOK: TcxButton
      Left = 318
      Top = 6
      Width = 90
      Height = 29
      Cancel = True
      Caption = 'Inchide'
      ModalResult = 1
      TabOrder = 0
    end
    object dxStatusBar1: TdxStatusBar
      Left = 0
      Top = 13
      Width = 753
      Height = 28
      Panels = <
        item
        end>
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
    end
  end
  object dxBarManager1: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      #1055#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102)
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    ImageOptions.Images = dmAdditions.cxImageList_SWN
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 280
    PixelsPerInch = 96
    object dxBarManager1Bar1: TdxBar
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' 1'
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 636
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
          ItemName = 'dxBarButton3'
        end
        item
          Visible = True
          ItemName = 'dxBarButton4'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton2'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarButton1: TdxBarButton
      Caption = 'Play wav'
      Category = 0
      Hint = 'Play wav'
      Visible = ivAlways
      ImageIndex = 72
      PaintStyle = psCaptionGlyph
      OnClick = dxBarButton1Click
    end
    object dxBarButton2: TdxBarButton
      Caption = 'Save as...'
      Category = 0
      Hint = 'Save as'
      Visible = ivAlways
      OnClick = dxBarButton2Click
    end
    object dxBarControlContainerItem1: TdxBarControlContainerItem
      Caption = 'New Item'
      Category = 0
      Hint = 'New Item'
      Visible = ivAlways
    end
    object dxBarButton3: TdxBarButton
      Caption = 'New Button'
      Category = 0
      Hint = 'New Button'
      Visible = ivAlways
      Glyph.SourceDPI = 96
      Glyph.SourceHeight = 16
      Glyph.SourceWidth = 16
      Glyph.Data = {
        3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D225554
        462D38223F3E0D0A3C7376672076657273696F6E3D22312E31222069643D224C
        617965725F312220786D6C6E733D22687474703A2F2F7777772E77332E6F7267
        2F323030302F7376672220786D6C6E733A786C696E6B3D22687474703A2F2F77
        77772E77332E6F72672F313939392F786C696E6B2220783D223070782220793D
        22307078222076696577426F783D2230203020333220333222207374796C653D
        22656E61626C652D6261636B67726F756E643A6E657720302030203332203332
        3B2220786D6C3A73706163653D227072657365727665223E262331333B262331
        303B3C7374796C6520747970653D22746578742F637373223E2E426C75657B66
        696C6C3A233131373744373B7D3C2F7374796C653E0D0A3C7061746820636C61
        73733D22426C75652220643D224D31332C32364837632D302E362C302D312D30
        2E352D312D31563763302D302E362C302E342D312C312D31683663302E362C30
        2C312C302E342C312C317631384331342C32352E352C31332E362C32362C3133
        2C32367A222F3E0D0A3C7061746820636C6173733D22426C75652220643D224D
        32352C3236682D36632D302E352C302D312D302E352D312D31563763302D302E
        362C302E352D312C312D31683663302E352C302C312C302E342C312C31763138
        4332362C32352E352C32352E352C32362C32352C32367A222F3E0D0A3C2F7376
        673E0D0A}
      OnClick = dxBarButton3Click
    end
    object dxBarButton4: TdxBarButton
      Caption = 'New Button'
      Category = 0
      Hint = 'New Button'
      Visible = ivAlways
      Glyph.SourceDPI = 96
      Glyph.SourceHeight = 16
      Glyph.SourceWidth = 16
      Glyph.Data = {
        3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D225554
        462D38223F3E0D0A3C7376672076657273696F6E3D22312E31222069643D224C
        617965725F312220786D6C6E733D22687474703A2F2F7777772E77332E6F7267
        2F323030302F7376672220786D6C6E733A786C696E6B3D22687474703A2F2F77
        77772E77332E6F72672F313939392F786C696E6B2220783D223070782220793D
        22307078222076696577426F783D2230203020333220333222207374796C653D
        22656E61626C652D6261636B67726F756E643A6E657720302030203332203332
        3B2220786D6C3A73706163653D227072657365727665223E262331333B262331
        303B3C7374796C6520747970653D22746578742F637373223E2E426C75657B66
        696C6C3A233131373744373B7D3C2F7374796C653E0D0A3C7061746820636C61
        73733D22426C75652220643D224D32372C34483543342E352C342C342C342E35
        2C342C3576323263302C302E352C302E352C312C312C3168323263302E352C30
        2C312D302E352C312D3156354332382C342E352C32372E352C342C32372C347A
        222F3E0D0A3C2F7376673E0D0A}
      OnClick = dxBarButton4Click
    end
  end
  object IBCQueryPhoneCalls: TIBCQuery
    KeyFields = 'callsid'
    SQL.Strings = (
      'select ch.*, u.FULL_NAME, cr.DURATION,'
      
        'iif(exists(select callid from ts_phone_calls_register cc where c' +
        'c.callid=ch.callid),1,0) FLG_HAS_WAV from ts_phone_calls_history' +
        ' ch'
      'inner join ts_users u on u.userid=ch.userid'
      'inner join  ts_phone_calls_register cr on cr.callid=ch.callid'
      'left outer join ts_customer c on c.customerid=ch.customerid'
      ' where cast(data as date)>=:data1 and cast(data as date)<=:data2'
      'order by data desc')
    Left = 296
    Top = 288
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'data1'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'data2'
        Value = nil
      end>
  end
  object IBCDataSourcePhoneCalls: TIBCDataSource
    DataSet = IBCQueryPhoneCalls
    Left = 240
    Top = 288
  end
  object IBCQueryCallsWav: TIBCQuery
    KeyFields = 'CALLID'
    SQLInsert.Strings = (
      'INSERT INTO TS_PHONE_CALLS_REGISTER'
      '  (CALLID, WAV, DURATION, SOURCEID, DESTID)'
      'VALUES'
      '  (:CALLID, :WAV, :DURATION, :SOURCEID, :DESTID)')
    SQLDelete.Strings = (
      'DELETE FROM TS_PHONE_CALLS_REGISTER'
      'WHERE'
      '  CALLID = :Old_CALLID')
    SQLUpdate.Strings = (
      'UPDATE TS_PHONE_CALLS_REGISTER'
      'SET'
      
        '  CALLID = :CALLID, WAV = :WAV, DURATION = :DURATION, SOURCEID =' +
        ' :SOURCEID, DESTID = :DESTID'
      'WHERE'
      '  CALLID = :Old_CALLID')
    SQLRefresh.Strings = (
      
        'SELECT CALLID, WAV, DURATION, SOURCEID, DESTID FROM TS_PHONE_CAL' +
        'LS_REGISTER'
      'WHERE'
      '  CALLID = :CALLID')
    SQLLock.Strings = (
      'SELECT NULL FROM TS_PHONE_CALLS_REGISTER'
      'WHERE'
      'CALLID = :Old_CALLID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM TS_PHONE_CALLS_REGISTER'
      ''
      ') q')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'select WAV from TS_PHONE_CALLS_REGISTER where callid=:callid')
    MasterFields = 'CALLID'
    DetailFields = 'CALLID'
    Left = 168
    Top = 328
    ParamData = <
      item
        DataType = ftInteger
        Name = 'callid'
        ParamType = ptInput
        Value = nil
      end>
  end
  object SaveDialog1: TSaveDialog
    Left = 88
    Top = 256
  end
  object DXAudioOut1: TDXAudioOut
    DeviceNumber = 0
    Latency = 250
    PrefetchData = True
    PollingInterval = 250
    FramesInBuffer = 24576
    SpeedFactor = 1.000000000000000000
    Left = 456
    Top = 257
  end
  object MP3In1: TMP3In
    Loop = False
    EndSample = -1
    StartSample = 0
    HighPrecision = False
    OutputChannels = cnMonoOrStereo
    Left = 504
    Top = 216
  end
  object WaveIn1: TWaveIn
    Loop = False
    EndSample = -1
    StartSample = 0
    Left = 408
    Top = 216
  end
end
