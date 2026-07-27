object frmWebPromoActiuneEditorDlg: TfrmWebPromoActiuneEditorDlg
  Left = 0
  Top = 0
  ActiveControl = edTITLE
  BorderStyle = bsDialog
  Caption = 'Promotii'
  ClientHeight = 581
  ClientWidth = 551
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  DesignSize = (
    551
    581)
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 551
    Height = 64
    Title = 'Promotii'
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
    ImageIndex = 11
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 535
    Height = 463
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    ShowCaption = False
    TabOrder = 1
    DesignSize = (
      531
      459)
    object Label1: TLabel
      Left = 24
      Top = 32
      Width = 120
      Height = 15
      Caption = 'Denumirea promotiei'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 24
      Top = 80
      Width = 111
      Height = 15
      Caption = 'Inceputul promotiei'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 169
      Top = 78
      Width = 101
      Height = 15
      Caption = 'Sfirsitul promotiei'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 24
      Top = 148
      Width = 70
      Height = 15
      Caption = 'Meta title ro'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 24
      Top = 260
      Width = 70
      Height = 15
      Caption = 'Meta title ru'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label6: TLabel
      Left = 24
      Top = 310
      Width = 109
      Height = 15
      Caption = 'Meta description ru'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label7: TLabel
      Left = 26
      Top = 199
      Width = 109
      Height = 15
      Caption = 'Meta description ro'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label8: TLabel
      Left = 306
      Top = 79
      Width = 85
      Height = 15
      Caption = 'Tipul promotiei'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edTITLE: TcxDBTextEdit
      Left = 24
      Top = 49
      DataBinding.DataField = 'TITLE'
      ParentFont = False
      TabOrder = 1
      Width = 485
    end
    object deSTART_DATE: TcxDBDateEdit
      Left = 24
      Top = 97
      DataBinding.DataField = 'START_DATE'
      ParentFont = False
      TabOrder = 2
      Width = 111
    end
    object deEND_DATE: TcxDBDateEdit
      Left = 169
      Top = 97
      DataBinding.DataField = 'END_DATE'
      ParentFont = False
      TabOrder = 3
      Width = 111
    end
    object cbFLG_SHOW_BANNER: TcxDBCheckBox
      Left = 24
      Top = 378
      Caption = 'Arata banerul pe pagina principala'
      DataBinding.DataField = 'FLG_SHOW_BANNER'
      ParentFont = False
      Properties.Alignment = taLeftJustify
      Properties.NullStyle = nssUnchecked
      Properties.ValueChecked = 1
      Properties.ValueGrayed = 0
      Properties.ValueUnchecked = 0
      TabOrder = 10
    end
    object cbFLG_SHOW_GOODS: TcxDBCheckBox
      Left = 24
      Top = 399
      Caption = 'Arata produsele din promotie'
      DataBinding.DataField = 'FLG_SHOW_GOODS'
      ParentFont = False
      Properties.Alignment = taLeftJustify
      Properties.NullStyle = nssUnchecked
      Properties.ValueChecked = 1
      Properties.ValueGrayed = 0
      Properties.ValueUnchecked = 0
      TabOrder = 12
    end
    object cbFLG_SHOW_BRICKS: TcxDBCheckBox
      Left = 24
      Top = 420
      Caption = 'Arata blocurile de reclama pe site'
      DataBinding.DataField = 'FLG_SHOW_BRICKS'
      ParentFont = False
      Properties.Alignment = taLeftJustify
      Properties.NullStyle = nssUnchecked
      Properties.ValueChecked = 1
      Properties.ValueGrayed = 0
      Properties.ValueUnchecked = 0
      TabOrder = 13
    end
    object cbFLG_ENABLED: TcxDBCheckBox
      Left = 404
      Top = 8
      Caption = 'Promotie activa'
      DataBinding.DataField = 'FLG_ENABLED'
      ParentFont = False
      Properties.Alignment = taLeftJustify
      Properties.NullStyle = nssUnchecked
      Properties.ValueChecked = 1
      Properties.ValueGrayed = 0
      Properties.ValueUnchecked = 0
      TabOrder = 0
    end
    object teMeta_title_ro: TcxDBTextEdit
      Left = 24
      Top = 167
      DataBinding.DataField = 'Meta_title_ro'
      ParentFont = False
      TabOrder = 6
      Width = 485
    end
    object teMeta_title_ru: TcxDBTextEdit
      Left = 24
      Top = 281
      DataBinding.DataField = 'Meta_title_ru'
      ParentFont = False
      TabOrder = 8
      Width = 485
    end
    object teMeta_description_ru: TcxDBTextEdit
      Left = 24
      Top = 331
      DataBinding.DataField = 'Meta_description_ru'
      ParentFont = False
      TabOrder = 9
      Width = 485
    end
    object teMeta_description_ro: TcxDBTextEdit
      Left = 24
      Top = 213
      DataBinding.DataField = 'Meta_description_ro'
      ParentFont = False
      TabOrder = 7
      Width = 485
    end
    object cbFLG_FAKE_PROMOTION: TcxDBCheckBox
      Left = 306
      Top = 126
      Caption = 'Actiune "fake"'
      DataBinding.DataField = 'FLG_FAKE_PROMOTION'
      ParentFont = False
      Properties.Alignment = taLeftJustify
      Properties.DisplayGrayed = 'false'
      Properties.NullStyle = nssUnchecked
      Properties.ValueChecked = 1
      Properties.ValueGrayed = 0
      Properties.ValueUnchecked = 0
      Style.TransparentBorder = False
      TabOrder = 5
    end
    object cbPromoTypes: TcxDBLookupComboBox
      Left = 306
      Top = 97
      DataBinding.DataField = 'promo_typeid'
      ParentFont = False
      Properties.KeyFieldNames = 'SYSSID'
      Properties.ListColumns = <
        item
          FieldName = 'TITLE'
        end>
      Properties.ListOptions.ColumnSorting = False
      Properties.ListOptions.ShowHeader = False
      Properties.ListOptions.SyncMode = True
      Properties.ListSource = IBCDataSourcePromoTypes
      TabOrder = 4
      Width = 203
    end
    object cxButton2: TcxButton
      Left = 368
      Top = 378
      Width = 141
      Height = 25
      Caption = 'Importa din descriere'
      TabOrder = 11
      OnClick = cxButton2Click
    end
    object cxButton1: TcxButton
      Left = 368
      Top = 409
      Width = 141
      Height = 24
      Anchors = [akLeft, akBottom]
      Caption = 'Importa din promotie'
      TabOrder = 14
      OnClick = cxButton1Click
    end
  end
  object btnOk: TButton
    Left = 343
    Top = 544
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 439
    Top = 544
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
  object IBCQueryPromoTypes: TIBCQuery
    SQL.Strings = (
      'select syssid, title from ts_syss s where parentid = 59')
    Left = 272
    Top = 392
  end
  object IBCDataSourcePromoTypes: TIBCDataSource
    DataSet = IBCQueryPromoTypes
    Left = 272
    Top = 336
  end
end
