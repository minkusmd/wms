object frmPeremesheniePrineatiTovarDlg: TfrmPeremesheniePrineatiTovarDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Primirea produselor'
  ClientHeight = 436
  ClientWidth = 643
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 643
    Height = 64
    Title = 'Primirea produselor'
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
    ImageIndex = 25
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 627
    Height = 309
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    BevelKind = bkFlat
    BevelOuter = bvNone
    Caption = 'pnClient'
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    object Label1: TLabel
      Left = 16
      Top = 24
      Width = 50
      Height = 15
      Caption = 'Expeditor'
    end
    object Label2: TLabel
      Left = 16
      Top = 53
      Width = 53
      Height = 15
      Caption = 'Destinatar'
    end
    object Label3: TLabel
      Left = 16
      Top = 82
      Width = 61
      Height = 15
      Caption = #206'n persoana'
    end
    object cxLabel1: TLabel
      Left = 16
      Top = 127
      Width = 168
      Height = 15
      Caption = 'Num'#259'rul de cutii pentru primire'
      Transparent = True
    end
    object cxLabel2: TLabel
      Left = 228
      Top = 127
      Width = 59
      Height = 15
      Caption = 'Comentarii'
      Transparent = True
    end
    object Label4: TLabel
      Left = 16
      Top = 268
      Width = 374
      Height = 15
      Caption = 
        'Procedura de primire a produselor se confirm'#259' prin parola primit' +
        'orului.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object edDT_NAME: TcxDBTextEdit
      Left = 93
      Top = 21
      TabStop = False
      DataBinding.DataField = 'DT_NAME'
      Properties.ReadOnly = True
      TabOrder = 0
      Width = 324
    end
    object edCT_NAME: TcxDBTextEdit
      Left = 93
      Top = 50
      TabStop = False
      DataBinding.DataField = 'CT_NAME'
      Properties.ReadOnly = True
      Style.TextStyle = [fsBold]
      TabOrder = 2
      Width = 324
    end
    object edDTDEP_NAME: TcxDBTextEdit
      Left = 423
      Top = 21
      TabStop = False
      DataBinding.DataField = 'DTDEP_NAME'
      Properties.ReadOnly = True
      TabOrder = 1
      Width = 178
    end
    object edCTDEP_NAME: TcxDBTextEdit
      Left = 423
      Top = 50
      TabStop = False
      DataBinding.DataField = 'CTDEP_NAME'
      Properties.ReadOnly = True
      TabOrder = 3
      Width = 178
    end
    object edBOX_COUNT: TcxDBMaskEdit
      Left = 16
      Top = 144
      DataBinding.DataField = 'BOX_COUNT'
      DataBinding.DataSource = IBCDataSourceDocAddons
      Properties.MaskKind = emkRegExpr
      Properties.EditMask = '\d+'
      Properties.MaxLength = 0
      Properties.ReadOnly = True
      TabOrder = 5
      Width = 121
    end
    object mmCOMMENTS: TcxDBMemo
      Left = 228
      Top = 144
      DataBinding.DataField = 'COMMENTS'
      DataBinding.DataSource = IBCDataSourceDocAddons
      Properties.ReadOnly = True
      Properties.ScrollBars = ssVertical
      Properties.VisibleLineCount = 5
      TabOrder = 6
      Width = 373
    end
    object edCurrUser: TcxTextEdit
      Left = 93
      Top = 79
      TabStop = False
      Properties.ReadOnly = True
      Style.TextStyle = [fsBold]
      TabOrder = 4
      Text = 'edCurrUser'
      Width = 244
    end
  end
  object btnOk: TcxButton
    Left = 424
    Top = 392
    Width = 90
    Height = 29
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TcxButton
    Left = 528
    Top = 392
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
  object IBCQueryDocAddons: TIBCQuery
    SQL.Strings = (
      'SELECT '
      ' DOCID,'
      ' BOX_COUNT,'
      ' COMMENTS'
      'FROM'
      ' TDB_DOCS_ADDONS')
    MasterFields = 'DOCID'
    DetailFields = 'DOCID'
    AutoCommit = False
    Left = 460
    Top = 220
  end
  object IBCDataSourceDocAddons: TIBCDataSource
    DataSet = IBCQueryDocAddons
    Left = 460
    Top = 172
  end
end
