object frmPhoneCallsOptionsDlg: TfrmPhoneCallsOptionsDlg
  Left = 0
  Top = 0
  Caption = 'frmPhoneCallsOptionsDlg'
  ClientHeight = 582
  ClientWidth = 802
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  TextHeight = 15
  object DialogTitle1: TDialogTitle
    Left = 0
    Top = 0
    Width = 802
    Height = 64
    Title = 'Convorbirile telefonice'
    Text = 'Convertarea wav2mp3'
    FontTitle.Charset = DEFAULT_CHARSET
    FontTitle.Color = clWindowText
    FontTitle.Height = -12
    FontTitle.Name = 'Segoe UI'
    FontTitle.Style = [fsBold]
    FontText.Charset = DEFAULT_CHARSET
    FontText.Color = clWindowText
    FontText.Height = -12
    FontText.Name = 'Segoe UI'
    FontText.Style = []
  end
  object Panel1: TPanel
    Left = 0
    Top = 64
    Width = 802
    Height = 470
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alClient
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    object cxProgressBar1: TcxProgressBar
      Left = 6
      Top = 439
      TabOrder = 0
      Width = 787
    end
    object Panel3: TPanel
      Left = 456
      Top = 57
      Width = 337
      Height = 351
      BevelKind = bkFlat
      BevelOuter = bvNone
      Color = clWindow
      ParentBackground = False
      TabOrder = 1
      object pbConvertion: TcxProgressBar
        Left = 8
        Top = 16
        TabOrder = 0
        Width = 313
      end
      object Memo1: TMemo
        Left = 8
        Top = 48
        Width = 313
        Height = 289
        ScrollBars = ssBoth
        TabOrder = 1
      end
    end
    object btnStart: TcxButton
      Left = 6
      Top = 16
      Width = 99
      Height = 29
      Caption = 'Start'
      OptionsImage.Glyph.SourceDPI = 96
      OptionsImage.Glyph.Data = {
        89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
        610000001974455874536F6674776172650041646F626520496D616765526561
        647971C9653C0000001C744558745469746C65004E6578743B506C61793B4172
        726F773B52696768743B52716C480000005149444154785EC5D3C109C0201005
        D13438ED58409A4809B660771B3CFD4308C81CF4F0F0362CAC7B55D507F760BE
        2BFE0295880F4CF840E003810F04AD3F3210F840706C028E6D81FD3FD1DF82BF
        46EF050E8BD3A832CB82150000000049454E44AE426082}
      TabOrder = 2
      OnClick = btnStartClick
    end
    object btnStop: TcxButton
      Left = 120
      Top = 16
      Width = 90
      Height = 29
      Caption = 'Stop'
      Enabled = False
      OptionsImage.Glyph.SourceDPI = 96
      OptionsImage.Glyph.Data = {
        89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
        610000001974455874536F6674776172650041646F626520496D616765526561
        647971C9653C0000001D744558745469746C6500436C6F73653B457869743B42
        6172733B526962626F6E3B4603B9E80000008D49444154785EC5D3310A843014
        8461ABA0F7DA9B7891B8284874D9B3982A47F136D9E7E26B86611A058BA9C2FF
        150969F6FE55AFEC7620DB26118CB6CC008F43AD7FF44DE2789E05DBC68074C4
        3E40229C7D10F0CD800C245EE4252222620008A2630D44020C025031221A8810
        ACFC623930622C5E676240B175182362516B2B0C70E42BFE40F2D8F7FC6FFC01
        4BA2809EA80656100000000049454E44AE426082}
      TabOrder = 3
      OnClick = btnStopClick
    end
    object cxButton2: TcxButton
      Left = 344
      Top = 27
      Width = 75
      Height = 25
      Caption = 'Play'
      TabOrder = 4
      OnClick = cxButton2Click
    end
    object cxButton3: TcxButton
      Left = 425
      Top = 27
      Width = 75
      Height = 25
      Caption = 'Stop'
      TabOrder = 5
      OnClick = cxButton3Click
    end
    object TrackBar1: TTrackBar
      Left = 506
      Top = 6
      Width = 273
      Height = 45
      TabOrder = 6
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 534
    Width = 802
    Height = 48
    Align = alBottom
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 2
    object cxButton1: TcxButton
      Left = 360
      Top = 6
      Width = 90
      Height = 29
      Cancel = True
      Caption = 'Inchide'
      ModalResult = 1
      TabOrder = 0
    end
  end
  object cxGrid1: TcxGrid
    Left = 8
    Top = 124
    Width = 444
    Height = 351
    TabOrder = 3
    object cxGrid1DBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      ScrollbarAnnotations.CustomAnnotations = <>
      DataController.DataSource = IBCDataSourceCalls
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      object cxGrid1DBTableView1Column1: TcxGridDBColumn
        DataBinding.FieldName = 'CALLID'
        DataBinding.IsNullValueType = True
        HeaderAlignmentHorz = taCenter
        Width = 85
      end
      object cxGrid1DBTableView1Column2: TcxGridDBColumn
        DataBinding.FieldName = 'DURATION'
        DataBinding.IsNullValueType = True
        HeaderAlignmentHorz = taCenter
        Width = 74
      end
      object cxGrid1DBTableView1Column3: TcxGridDBColumn
        DataBinding.FieldName = 'DESTID'
        DataBinding.IsNullValueType = True
        HeaderAlignmentHorz = taCenter
        Width = 60
      end
      object cxGrid1DBTableView1Column4: TcxGridDBColumn
        DataBinding.FieldName = 'SOURCEID'
        DataBinding.IsNullValueType = True
        HeaderAlignmentHorz = taCenter
        Width = 137
      end
      object cxGrid1DBTableView1Column5: TcxGridDBColumn
        Caption = 'Size'
        DataBinding.FieldName = 'WAV_SIZE'
        DataBinding.IsNullValueType = True
        HeaderAlignmentHorz = taCenter
        Width = 77
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
    end
  end
  object IBCQueryCalls: TIBCQuery
    SQL.Strings = (
      
        'SELECT CALLID, DURATION, SOURCEID, DESTID, OCTET_LENGTH(WAV) / 1' +
        '024 wav_size FROM TS_PHONE_CALLS_REGISTER')
    Left = 384
    Top = 296
  end
  object IBCDataSourceCalls: TIBCDataSource
    DataSet = IBCQueryCalls
    Left = 384
    Top = 232
  end
  object IBCTransaction1: TIBCTransaction
    Left = 680
    Top = 296
  end
  object IBCQueryWAV: TIBCQuery
    SQLUpdate.Strings = (
      'UPDATE TS_PHONE_CALLS_REGISTER'
      'SET'
      '  CALLID = :CALLID, WAV = :WAV'
      'WHERE'
      '  CALLID = :Old_CALLID')
    UpdateTransaction = IBCTransaction1
    SQL.Strings = (
      'select callid, wav from TS_PHONE_CALLS_REGISTER')
    MasterFields = 'CALLID'
    DetailFields = 'CALLID'
    MasterSource = IBCDataSourceCalls
    Left = 536
    Top = 304
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CALLID'
        Value = nil
      end>
  end
  object MP3Out1: TMP3Out
    Input = WaveIn1
    OnDone = MP3Out1Done
    OnProgress = MP3Out1Progress
    ShareMode = 0
    BitRate = mbr128
    Mode = mmMono
    EnableBitReservoir = False
    StrictISO = False
    VBRQuality = mp3ql0
    EnableVBR = False
    AverageBitrate = mbr128
    MaximumBitrate = mbr192
    Left = 560
    Top = 24
  end
  object WaveIn1: TWaveIn
    Loop = False
    EndSample = -1
    StartSample = 0
    Left = 472
    Top = 24
  end
  object MP3In1: TMP3In
    Loop = False
    EndSample = -1
    StartSample = 0
    HighPrecision = True
    OutputChannels = cnMonoOrStereo
    Left = 224
    Top = 24
  end
  object DXAudioOut1: TDXAudioOut
    Input = MP3In1
    OnDone = DXAudioOut1Done
    OnProgress = DXAudioOut1Progress
    DeviceNumber = 0
    Latency = 250
    PrefetchData = True
    PollingInterval = 250
    FramesInBuffer = 24576
    SpeedFactor = 1.000000000000000000
    Left = 360
    Top = 24
  end
end
