object frmOportunitatiDlg: TfrmOportunitatiDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  ClientHeight = 650
  ClientWidth = 822
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  DesignSize = (
    822
    650)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 822
    Height = 64
    Title = 'Oportunitati'
    Text = ''
    FontTitle.Charset = DEFAULT_CHARSET
    FontTitle.Color = clWindowText
    FontTitle.Height = -13
    FontTitle.Name = 'Segoe UI'
    FontTitle.Style = [fsBold]
    FontText.Charset = DEFAULT_CHARSET
    FontText.Color = clWindowText
    FontText.Height = -11
    FontText.Name = 'Segoe UI'
    FontText.Style = []
    ImageList = dmAdditions.cxImageList_DialogIcons
    ImageIndex = 16
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 806
    Height = 520
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    object Bevel1: TBevel
      Left = 12
      Top = 56
      Width = 613
      Height = 4
      Shape = bsTopLine
    end
    object cxLabel5: TLabel
      Left = 12
      Top = 21
      Width = 82
      Height = 15
      Caption = 'Data document'
      Transparent = True
    end
    object Subiect: TLabel
      Left = 12
      Top = 69
      Width = 39
      Height = 15
      Caption = 'Subiect'
      Transparent = True
    end
    object Label1: TLabel
      Left = 12
      Top = 101
      Width = 31
      Height = 15
      Caption = 'Client'
      Transparent = True
    end
    object Label2: TLabel
      Left = 12
      Top = 138
      Width = 72
      Height = 15
      Caption = 'Data estimata'
      Transparent = True
    end
    object Label3: TLabel
      Left = 282
      Top = 138
      Width = 68
      Height = 15
      Caption = 'Venit estimat'
      Transparent = True
    end
    object Label4: TLabel
      Left = 12
      Top = 181
      Width = 67
      Height = 15
      Caption = 'Probabilitate'
      Transparent = True
    end
    object Label5: TLabel
      Left = 12
      Top = 245
      Width = 44
      Height = 15
      Caption = 'Evaluare'
      Transparent = True
    end
    object Label6: TLabel
      Left = 508
      Top = 138
      Width = 63
      Height = 15
      Caption = 'Responsabil'
      Transparent = True
    end
    object Label7: TLabel
      Left = 533
      Top = 98
      Width = 38
      Height = 15
      Caption = 'Telefon'
      Transparent = True
    end
    object Label8: TLabel
      Left = 356
      Top = 21
      Width = 73
      Height = 15
      Caption = 'Subdiviziunea'
      Transparent = True
    end
    object Label9: TLabel
      Left = 538
      Top = 181
      Width = 31
      Height = 15
      Caption = 'Statut'
      Transparent = True
    end
    object deDATA: TcxDBDateEdit
      Left = 108
      Top = 18
      DataBinding.DataField = 'DATA'
      DataBinding.DataSource = dmDB.IBCDataSourceDocs
      Properties.DateButtons = [btnNow]
      Properties.ImmediatePost = True
      Properties.Kind = ckDateTime
      Properties.WeekNumbers = True
      TabOrder = 0
      Width = 117
    end
    object cxDataEst: TcxDBDateEdit
      Left = 108
      Top = 135
      DataBinding.DataField = 'DATA'
      DataBinding.DataSource = dmDB.IBCDataSourceDocs
      Properties.DateButtons = [btnNow]
      Properties.ImmediatePost = True
      Properties.Kind = ckDateTime
      Properties.WeekNumbers = True
      TabOrder = 4
      Width = 117
    end
    object cxVenit: TcxDBCalcEdit
      Left = 356
      Top = 135
      TabOrder = 5
      Width = 121
    end
    object cxSubiect: TcxDBTextEdit
      Left = 108
      Top = 66
      TabOrder = 1
      Width = 684
    end
    object cxClientInfo: TcxDBTextEdit
      Left = 108
      Top = 98
      TabOrder = 3
      Width = 349
    end
    object cxProbabilitate: TcxDBTrackBar
      Left = 90
      Top = 159
      AutoSize = False
      Properties.Frequency = 10
      Properties.Max = 100
      Properties.TickSize = 5
      Properties.TickType = tbttTicksAndNumbers
      TabOrder = 7
      Height = 76
      Width = 393
    end
    object dxEvaluare: TdxDBRatingControl
      Left = 108
      Top = 245
      Properties.FillPrecision = rcfpExact
      TabOrder = 9
    end
    object edComentariu: TcxDBMemo
      Left = 108
      Top = 282
      TabOrder = 10
      OnKeyDown = edComentariuKeyDown
      Height = 223
      Width = 684
    end
    object cbResponsabil: TcxDBLookupComboBox
      Left = 577
      Top = 135
      Properties.DropDownListStyle = lsFixedList
      Properties.KeyFieldNames = 'USERID'
      Properties.ListColumns = <
        item
          FieldName = 'FULL_NAME'
        end>
      Properties.ListSource = IBCDataSourceUsers
      TabOrder = 6
      Width = 215
    end
    object teTelefon: TcxDBTextEdit
      Left = 577
      Top = 95
      DataBinding.DataField = 'Telefon'
      TabOrder = 2
      Width = 213
    end
    object lcbStatus: TcxDBLookupComboBox
      Left = 575
      Top = 178
      DataBinding.DataField = 'STATUS_ID'
      Properties.DropDownListStyle = lsFixedList
      Properties.KeyFieldNames = 'SYSSID'
      Properties.ListColumns = <
        item
          FieldName = 'TITLE'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = IBCDataSourceSysS
      TabOrder = 8
      Width = 215
    end
  end
  object btnOk: TButton
    Left = 608
    Top = 606
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 3
  end
  object btnCancel: TButton
    Left = 712
    Top = 606
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 4
  end
  object lcbFirma: TcxDBLookupComboBox
    Left = 466
    Top = 92
    DataBinding.DataField = 'DT'
    Properties.GridMode = True
    Properties.ImmediatePost = True
    Properties.IncrementalFilteringOptions = [ifoHighlightSearchText, ifoUseContainsOperator]
    Properties.KeyFieldNames = 'CUSTOMERID'
    Properties.ListColumns = <
      item
        FieldName = 'DISPLAYNAME'
      end>
    Properties.ListOptions.RowSelect = False
    Properties.ListOptions.ShowHeader = False
    Properties.ListOptions.SyncMode = True
    Properties.ListSource = IBCDataSourceFirms
    TabOrder = 2
    Width = 336
  end
  object IBCQueryUsers: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'select * From vw_ts_users where flg_active = 1')
    Left = 264
    Top = 457
  end
  object IBCDataSourceUsers: TIBCDataSource
    DataSet = IBCQueryUsers
    Left = 268
    Top = 407
  end
  object IBCQueryFirms: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'select A.* from VW_GET_FIRME A'
      'where'
      
        'EXISTS(SELECT CUSTOMERID FROM GET_FIRMS_BY_USER2 GFBU2 WHERE GFB' +
        'U2.CUSTOMERID=A.CUSTOMERID)'
      '')
    Left = 568
    Top = 344
  end
  object IBCDataSourceFirms: TIBCDataSource
    DataSet = IBCQueryFirms
    Left = 568
    Top = 296
  end
  object IBCQuerySysS: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'select * from ts_syss where parentid = 54')
    Left = 448
    Top = 456
  end
  object IBCDataSourceSysS: TIBCDataSource
    DataSet = IBCQuerySysS
    Left = 448
    Top = 416
  end
end
