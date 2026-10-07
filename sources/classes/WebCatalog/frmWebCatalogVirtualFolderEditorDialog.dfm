object frmWebCatalogVirtualFolderEditorDlg: TfrmWebCatalogVirtualFolderEditorDlg
  Left = 0
  Top = 0
  ActiveControl = edTITLE_ROM
  BorderStyle = bsDialog
  Caption = 'Mapa virtuala'
  ClientHeight = 764
  ClientWidth = 792
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  DesignSize = (
    792
    764)
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 792
    Height = 64
    Title = 'Mapa virtuala'
    Text = 'Subcategorie pe unul sau mai multe atribute, cu URL si imagine proprii'
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
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 776
    Height = 630
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object lbTITLE_ROM: TLabel
      Left = 12
      Top = 12
      Width = 104
      Height = 15
      Caption = 'Denumire (romana)'
    end
    object lbTITLE_RUS: TLabel
      Left = 12
      Top = 62
      Width = 85
      Height = 15
      Caption = 'Denumire (rusa)'
    end
    object lbH1_ROM: TLabel
      Left = 12
      Top = 112
      Width = 114
      Height = 15
      Caption = 'H1 romana (optional)'
    end
    object lbH1_RUS: TLabel
      Left = 12
      Top = 162
      Width = 95
      Height = 15
      Caption = 'H1 rusa (optional)'
    end
    object lbREWRITE_URL: TLabel
      Left = 12
      Top = 212
      Width = 123
      Height = 15
      Caption = 'Adresa URL (litere mici)'
    end
    object lbFilter: TLabel
      Left = 12
      Top = 280
      Width = 150
      Height = 15
      Caption = 'Atribute (se combina cu SI)'
    end
    object lbORDERNO: TLabel
      Left = 12
      Top = 385
      Width = 36
      Height = 15
      Caption = 'Ordine'
    end
    object lbMETA_TITLE_ROM: TLabel
      Left = 12
      Top = 480
      Width = 102
      Height = 15
      Caption = 'Meta title (romana)'
    end
    object lbMETA_TITLE_RUS: TLabel
      Left = 392
      Top = 480
      Width = 83
      Height = 15
      Caption = 'Meta title (rusa)'
    end
    object lbMETA_DESCRIPTION_ROM: TLabel
      Left = 12
      Top = 530
      Width = 122
      Height = 15
      Caption = 'Meta description (rom)'
    end
    object lbMETA_DESCRIPTION_RUS: TLabel
      Left = 392
      Top = 530
      Width = 116
      Height = 15
      Caption = 'Meta description (rus)'
    end
    object lbImage: TLabel
      Left = 560
      Top = 12
      Width = 114
      Height = 15
      Caption = 'Imagine tile (190x190)'
    end
    object lbImageHint: TLabel
      Left = 560
      Top = 232
      Width = 200
      Height = 45
      AutoSize = False
      Caption = 'Imaginea se poate adauga dupa prima salvare a mapei.'
      Visible = False
      WordWrap = True
    end
    object edTITLE_ROM: TcxDBTextEdit
      Left = 12
      Top = 31
      DataBinding.DataField = 'TITLE_ROM'
      TabOrder = 0
      Width = 520
    end
    object edTITLE_RUS: TcxDBTextEdit
      Left = 12
      Top = 81
      DataBinding.DataField = 'TITLE_RUS'
      TabOrder = 1
      Width = 520
    end
    object edH1_ROM: TcxDBTextEdit
      Left = 12
      Top = 131
      DataBinding.DataField = 'H1_ROM'
      TabOrder = 2
      Width = 520
    end
    object edH1_RUS: TcxDBTextEdit
      Left = 12
      Top = 181
      DataBinding.DataField = 'H1_RUS'
      TabOrder = 3
      Width = 520
    end
    object edREWRITE_URL: TcxDBTextEdit
      Left = 12
      Top = 231
      DataBinding.DataField = 'REWRITE_URL'
      TabOrder = 4
      Width = 400
    end
    object btnFillSlug: TcxButton
      Left = 420
      Top = 230
      Width = 112
      Height = 25
      Caption = 'Complecteaza'
      TabOrder = 5
      OnClick = btnFillSlugClick
    end
    object btnChooseFilter: TcxButton
      Left = 420
      Top = 299
      Width = 112
      Height = 25
      Caption = 'Adauga atribut'
      TabOrder = 6
      OnClick = btnChooseFilterClick
    end
    object btnRemoveFilter: TcxButton
      Left = 420
      Top = 328
      Width = 112
      Height = 25
      Caption = 'Sterge atribut'
      TabOrder = 15
      OnClick = btnRemoveFilterClick
    end
    object lstFilters: TListBox
      Left = 12
      Top = 299
      Width = 400
      Height = 72
      Hint = 
        'Dublu-clic = schimba valoarea. Acelasi atribut adaugat din nou =' +
        ' inca o valoare (SAU).'
      ItemHeight = 15
      ParentShowHint = False
      ShowHint = True
      TabOrder = 16
      OnDblClick = lstFiltersDblClick
    end
    object edORDERNO: TcxDBSpinEdit
      Left = 12
      Top = 404
      DataBinding.DataField = 'ORDERNO'
      TabOrder = 7
      Width = 100
    end
    object cbFLG_ENABLED: TcxDBCheckBox
      Left = 140
      Top = 404
      Caption = 'Mapa este activa'
      DataBinding.DataField = 'FLG_ENABLED'
      Properties.Alignment = taLeftJustify
      Properties.NullStyle = nssUnchecked
      Properties.ValueChecked = 1
      Properties.ValueUnchecked = 0
      TabOrder = 8
      Transparent = True
    end
    object cbFLG_TILE: TcxDBCheckBox
      Left = 140
      Top = 429
      Caption = 'Apare ca tile in categorie'
      DataBinding.DataField = 'FLG_TILE'
      Properties.Alignment = taLeftJustify
      Properties.NullStyle = nssUnchecked
      Properties.ValueChecked = 1
      Properties.ValueUnchecked = 0
      TabOrder = 9
      Transparent = True
    end
    object edMETA_TITLE_ROM: TcxDBTextEdit
      Left = 12
      Top = 499
      DataBinding.DataField = 'META_TITLE_ROM'
      TabOrder = 10
      Width = 360
    end
    object edMETA_TITLE_RUS: TcxDBTextEdit
      Left = 392
      Top = 499
      DataBinding.DataField = 'META_TITLE_RUS'
      TabOrder = 11
      Width = 360
    end
    object edMETA_DESCRIPTION_ROM: TcxDBMemo
      Left = 12
      Top = 549
      DataBinding.DataField = 'META_DESCRIPTION_ROM'
      Properties.ScrollBars = ssVertical
      TabOrder = 12
      Height = 60
      Width = 360
    end
    object edMETA_DESCRIPTION_RUS: TcxDBMemo
      Left = 392
      Top = 549
      DataBinding.DataField = 'META_DESCRIPTION_RUS'
      Properties.ScrollBars = ssVertical
      TabOrder = 13
      Height = 60
      Width = 360
    end
    object imgBIG_IMAGE: TcxDBImage
      Left = 560
      Top = 31
      DataBinding.DataField = 'BIG_IMAGE'
      Properties.GraphicClassName = 'TdxPNGImage'
      Properties.ImmediatePost = True
      Properties.ShowFocusRect = False
      TabOrder = 14
      Height = 195
      Width = 200
    end
  end
  object btnOk: TButton
    Left = 583
    Top = 718
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancel: TButton
    Left = 685
    Top = 718
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 2
  end
  object IBCQueryImage: TIBCQuery
    KeyFields = 'VIRTUALID'
    SQLInsert.Strings = (
      'INSERT INTO TWEB_CATALOG_VIRTUAL_IMAGE'
      '  (VIRTUALID, IMAGE, BIG_IMAGE)'
      'VALUES'
      '  (:VIRTUALID, :IMAGE, :BIG_IMAGE)')
    SQLDelete.Strings = (
      'DELETE FROM TWEB_CATALOG_VIRTUAL_IMAGE'
      'WHERE'
      '  VIRTUALID = :Old_VIRTUALID')
    SQLUpdate.Strings = (
      'UPDATE TWEB_CATALOG_VIRTUAL_IMAGE'
      'SET'
      '  IMAGE = :IMAGE, BIG_IMAGE = :BIG_IMAGE'
      'WHERE'
      '  VIRTUALID = :Old_VIRTUALID')
    SQLRefresh.Strings = (
      
        'SELECT VIRTUALID, IMAGE, BIG_IMAGE FROM TWEB_CATALOG_VIRTUAL_IMA' +
        'GE'
      'WHERE'
      '  VIRTUALID = :VIRTUALID')
    SQLLock.Strings = (
      'SELECT NULL FROM TWEB_CATALOG_VIRTUAL_IMAGE'
      'WHERE'
      'VIRTUALID = :Old_VIRTUALID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      'SELECT VIRTUALID, IMAGE, BIG_IMAGE'
      'FROM TWEB_CATALOG_VIRTUAL_IMAGE'
      'WHERE VIRTUALID = :ID')
    Options.RequiredFields = False
    LocalConstraints = False
    Left = 620
    Top = 300
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
        Value = nil
      end>
  end
  object IBCDataSourceImage: TIBCDataSource
    DataSet = IBCQueryImage
    Left = 692
    Top = 300
  end
end
