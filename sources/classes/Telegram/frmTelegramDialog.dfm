object frmTelegramDlg: TfrmTelegramDlg
  Left = 0
  Top = 0
  Caption = 'Notificari Telegram'
  ClientHeight = 620
  ClientWidth = 1100
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  DesignSize = (
    1100
    620)
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 1100
    Height = 64
    Title = 'Notificari Telegram'
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
    ImageIndex = 16
  end
  object pcMain: TPageControl
    Left = 8
    Top = 70
    Width = 1084
    Height = 498
    ActivePage = tsChannels
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
    OnChange = pcMainChange
    object tsChannels: TTabSheet
      Caption = 'Canale'
      object pnChannelsTop: TPanel
        Left = 0
        Top = 0
        Width = 1076
        Height = 48
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object lbConfig: TLabel
          Left = 8
          Top = 6
          Width = 300
          Height = 15
          Caption = 'Token bot:'
        end
        object lbConfigHint: TLabel
          Left = 8
          Top = 26
          Width = 900
          Height = 15
          Caption =
            'Tokenul botului si chat-ul implicit se completeaza in Setari > C' +
            'onfigurari API (Cod API = TELEGRAM: BOT_TOKEN, DEFAULT_CHAT_ID).' +
            ' Canal fara Chat ID -> chat-ul implicit.'
        end
      end
      object cxGridChannels: TcxGrid
        Left = 0
        Top = 48
        Width = 1076
        Height = 376
        Align = alClient
        TabOrder = 1
        object cxGridChannelsTable: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = IBCDataSourceChannels
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.Deleting = False
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
          object colCH_CHANNEL_CODE: TcxGridDBColumn
            Caption = 'Cod'
            DataBinding.FieldName = 'CHANNEL_CODE'
            Width = 120
          end
          object colCH_TITLE: TcxGridDBColumn
            Caption = 'Denumire'
            DataBinding.FieldName = 'TITLE'
            Width = 220
          end
          object colCH_CHAT_ID: TcxGridDBColumn
            Caption = 'Chat ID'
            DataBinding.FieldName = 'CHAT_ID'
            Width = 140
          end
          object colCH_THREAD_ID: TcxGridDBColumn
            Caption = 'Topic (thread)'
            DataBinding.FieldName = 'THREAD_ID'
            Width = 90
          end
          object colCH_FLG_SILENT: TcxGridDBColumn
            Caption = 'Fara sunet'
            DataBinding.FieldName = 'FLG_SILENT'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ValueChecked = 1
            Properties.ValueGrayed = 0
            Properties.ValueUnchecked = 0
            Width = 70
          end
          object colCH_FLG_ACTIVE: TcxGridDBColumn
            Caption = 'Activ'
            DataBinding.FieldName = 'FLG_ACTIVE'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ValueChecked = 1
            Properties.ValueGrayed = 0
            Properties.ValueUnchecked = 0
            Width = 50
          end
          object colCH_NOTE: TcxGridDBColumn
            Caption = 'Nota'
            DataBinding.FieldName = 'NOTE'
            Width = 300
          end
        end
        object cxGridChannelsLevel: TcxGridLevel
          GridView = cxGridChannelsTable
        end
      end
      object pnChannelsBottom: TPanel
        Left = 0
        Top = 424
        Width = 1076
        Height = 44
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 2
        object btnChannelAdd: TcxButton
          Left = 8
          Top = 7
          Width = 110
          Height = 31
          Caption = 'Adauga'
          TabOrder = 0
          OnClick = btnChannelAddClick
        end
        object btnChannelDelete: TcxButton
          Left = 124
          Top = 7
          Width = 100
          Height = 31
          Caption = 'Sterge'
          TabOrder = 1
          OnClick = btnChannelDeleteClick
        end
        object btnTestSend: TcxButton
          Left = 260
          Top = 7
          Width = 130
          Height = 31
          Caption = 'Trimite test'
          TabOrder = 2
          OnClick = btnTestSendClick
        end
        object btnCheckBot: TcxButton
          Left = 396
          Top = 7
          Width = 130
          Height = 31
          Caption = 'Verifica botul'
          TabOrder = 3
          OnClick = btnCheckBotClick
        end
        object btnFindChats: TcxButton
          Left = 532
          Top = 7
          Width = 130
          Height = 31
          Caption = 'Afla chat ID'
          TabOrder = 4
          OnClick = btnFindChatsClick
        end
      end
    end
    object tsHistory: TTabSheet
      Caption = 'Istoric'
      ImageIndex = 1
      object pnHistoryTop: TPanel
        Left = 0
        Top = 0
        Width = 1076
        Height = 42
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object lbPeriod: TLabel
          Left = 8
          Top = 12
          Width = 51
          Height = 15
          Caption = 'Perioada:'
        end
        object lbStatus: TLabel
          Left = 232
          Top = 12
          Width = 35
          Height = 15
          Caption = 'Status:'
        end
        object cbPeriod: TComboBox
          Left = 66
          Top = 8
          Width = 150
          Height = 23
          Style = csDropDownList
          ItemIndex = 1
          TabOrder = 0
          Text = 'Ultimele 7 zile'
          OnChange = cbFilterChange
          Items.Strings = (
            'Azi'
            'Ultimele 7 zile'
            'Ultimele 30 zile'
            'Tot istoricul')
        end
        object cbStatus: TComboBox
          Left = 274
          Top = 8
          Width = 180
          Height = 23
          Style = csDropDownList
          ItemIndex = 0
          TabOrder = 1
          Text = 'Toate'
          OnChange = cbFilterChange
          Items.Strings = (
            'Toate'
            'In coada (netrimise)'
            'Trimise'
            'Esuate'
            'Ignorate')
        end
        object btnRefresh: TcxButton
          Left = 470
          Top = 5
          Width = 130
          Height = 29
          Caption = 'Reimprospateaza'
          TabOrder = 2
          OnClick = btnRefreshClick
        end
        object btnResend: TcxButton
          Left = 606
          Top = 5
          Width = 130
          Height = 29
          Caption = 'Retrimite'
          TabOrder = 3
          OnClick = btnResendClick
        end
      end
      object cxGridHistory: TcxGrid
        Left = 0
        Top = 42
        Width = 1076
        Height = 278
        Align = alClient
        TabOrder = 1
        object cxGridHistoryTable: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = IBCDataSourceHistory
          DataController.KeyFieldNames = 'TGMSGID'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.MultiSelect = True
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
          object colH_TGMSGID: TcxGridDBColumn
            Caption = 'Nr.'
            DataBinding.FieldName = 'TGMSGID'
            Width = 60
          end
          object colH_DATA_CREATED: TcxGridDBColumn
            Caption = 'Creat'
            DataBinding.FieldName = 'DATA_CREATED'
            Width = 120
          end
          object colH_CHANNEL_CODE: TcxGridDBColumn
            Caption = 'Canal'
            DataBinding.FieldName = 'CHANNEL_CODE'
            Width = 90
          end
          object colH_STATUS_NAME: TcxGridDBColumn
            Caption = 'Status'
            DataBinding.FieldName = 'STATUS_NAME'
            Width = 90
          end
          object colH_RETRY_COUNT: TcxGridDBColumn
            Caption = 'Incercari esuate'
            DataBinding.FieldName = 'RETRY_COUNT'
            Width = 60
          end
          object colH_DATA_DELIVERED: TcxGridDBColumn
            Caption = 'Trimis'
            DataBinding.FieldName = 'DATA_DELIVERED'
            Width = 120
          end
          object colH_NEXT_SEND_TIME: TcxGridDBColumn
            Caption = 'Urmatoarea incercare'
            DataBinding.FieldName = 'NEXT_SEND_TIME'
            Width = 120
          end
          object colH_SOURCE: TcxGridDBColumn
            Caption = 'Sursa'
            DataBinding.FieldName = 'SOURCE_NAME'
            Width = 110
          end
          object colH_LAST_ERROR: TcxGridDBColumn
            Caption = 'Ultima eroare'
            DataBinding.FieldName = 'LAST_ERROR'
            Width = 180
          end
          object colH_TEXT_PREVIEW: TcxGridDBColumn
            Caption = 'Text'
            DataBinding.FieldName = 'TEXT_PREVIEW'
            Width = 260
          end
        end
        object cxGridHistoryLevel: TcxGridLevel
          GridView = cxGridHistoryTable
        end
      end
      object splHistory: TSplitter
        Left = 0
        Top = 320
        Width = 1076
        Height = 4
        Cursor = crVSplit
        Align = alBottom
      end
      object mmText: TDBMemo
        Left = 0
        Top = 324
        Width = 1076
        Height = 144
        Align = alBottom
        DataField = 'MSG_TEXT'
        DataSource = IBCDataSourceHistory
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 2
      end
    end
  end
  object btnOk: TcxButton
    Left = 866
    Top = 578
    Width = 110
    Height = 31
    Anchors = [akRight, akBottom]
    Caption = 'Salveaza'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancel: TcxButton
    Left = 982
    Top = 578
    Width = 110
    Height = 31
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 2
  end
  object IBCQueryChannels: TIBCQuery
    KeyFields = 'CHANNEL_CODE'
    SQLInsert.Strings = (
      'INSERT INTO TELEGRAM_CHANNELS'
      '  (CHANNEL_CODE, TITLE, CHAT_ID, THREAD_ID, FLG_SILENT, FLG_ACTIVE, NOTE)'
      'VALUES'
      '  (:CHANNEL_CODE, :TITLE, :CHAT_ID, :THREAD_ID, :FLG_SILENT, :FLG_ACTIVE, :NOTE)')
    SQLDelete.Strings = (
      'DELETE FROM TELEGRAM_CHANNELS'
      'WHERE'
      '  CHANNEL_CODE = :Old_CHANNEL_CODE')
    SQLUpdate.Strings = (
      'UPDATE TELEGRAM_CHANNELS'
      'SET'
      '  CHANNEL_CODE = :CHANNEL_CODE, TITLE = :TITLE, CHAT_ID = :CHAT_ID,'
      '  THREAD_ID = :THREAD_ID, FLG_SILENT = :FLG_SILENT,'
      '  FLG_ACTIVE = :FLG_ACTIVE, NOTE = :NOTE'
      'WHERE'
      '  CHANNEL_CODE = :Old_CHANNEL_CODE')
    BeforePost = IBCQueryChannelsBeforePost
    OnNewRecord = IBCQueryChannelsNewRecord
    SQL.Strings = (
      'SELECT * FROM TELEGRAM_CHANNELS'
      'ORDER BY CHANNEL_CODE')
    AutoCommit = False
    Left = 48
    Top = 200
  end
  object IBCDataSourceChannels: TIBCDataSource
    DataSet = IBCQueryChannels
    Left = 136
    Top = 200
  end
  object IBCTransactionUpdate: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 224
    Top = 200
  end
  object IBCQueryHistory: TIBCQuery
    SQL.Strings = (
      'SELECT FIRST 2000'
      '  M.TGMSGID, M.DATA_CREATED, M.CHANNEL_CODE, M.SENT_STATUS,'
      '  CASE M.SENT_STATUS'
      '    WHEN 0 THEN '#39'In coada'#39
      '    WHEN 1 THEN '#39'Trimis'#39
      '    WHEN 2 THEN '#39'Se reincearca'#39
      '    WHEN 3 THEN '#39'Esuat'#39
      '    WHEN 4 THEN '#39'Ignorat'#39
      '  END AS STATUS_NAME,'
      '  M.RETRY_COUNT, M.DATA_DELIVERED,'
      '  IIF(M.FLG_SENT = 0, M.NEXT_SEND_TIME, NULL) AS NEXT_SEND_TIME,'
      '  CASE'
      '    WHEN M.SOURCE_TABLE = 134 THEN '#39'Comanda #'#39' || M.SOURCE_ID'
      '    WHEN M.SOURCE_TABLE = 1791 THEN '#39'Finantare #'#39' || M.SOURCE_ID'
      '    WHEN M.SOURCE_TABLE = -10 THEN '#39'SMS #'#39' || M.SOURCE_ID'
      '    WHEN M.SOURCE_TABLE = -20 THEN '#39'SWNService'#39
      '    WHEN M.SOURCE_TABLE = -30 THEN '#39'WMSParsers'#39
      '    WHEN M.SOURCE_TABLE > 0 THEN '#39'Doc. '#39' || M.SOURCE_TABLE || '#39' #'#39' || M.SOURCE_ID'
      '  END AS SOURCE_NAME,'
      '  M.LAST_ERROR,'
      '  COALESCE(LEFT(REPLACE(M.MSG_TEXT, ASCII_CHAR(10), '#39' | '#39'), 250),'
      '    '#39'(textul se construieste la trimitere)'#39') AS TEXT_PREVIEW,'
      '  M.MSG_TEXT'
      'FROM TELEGRAM_MESSAGES M'
      'WHERE M.DATA_CREATED >= :DFROM'
      '  AND (:ST = -1 OR M.SENT_STATUS = :ST'
      '       OR (:ST = 9 AND M.FLG_SENT = 0 AND M.SENT_STATUS IN (0, 2)))'
      'ORDER BY M.TGMSGID DESC')
    ReadOnly = True
    Left = 48
    Top = 264
    ParamData = <
      item
        DataType = ftDateTime
        Name = 'DFROM'
        Value = nil
      end
      item
        DataType = ftInteger
        Name = 'ST'
        Value = nil
      end>
  end
  object IBCDataSourceHistory: TIBCDataSource
    DataSet = IBCQueryHistory
    Left = 136
    Top = 264
  end
  object IBCTransactionRead: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 224
    Top = 264
  end
end
