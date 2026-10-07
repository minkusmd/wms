object frmGoodsGroupGoodsTypeEditorDlg: TfrmGoodsGroupGoodsTypeEditorDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Tip produse'
  ClientHeight = 298
  ClientWidth = 464
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 464
    Height = 64
    Title = 'Tip produse'
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
    ImageIndex = 22
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 448
    Height = 173
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
    object Label1: TLabel
      Left = 16
      Top = 20
      Width = 57
      Height = 15
      Caption = 'Tip produs'
    end
    object lcbGOODSTYPEID: TcxDBLookupComboBox
      Left = 16
      Top = 37
      DataBinding.DataField = 'GOODSTYPEID'
      Properties.DropDownListStyle = lsFixedList
      Properties.DropDownRows = 16
      Properties.IncrementalFilteringOptions = [ifoHighlightSearchText, ifoUseContainsOperator]
      Properties.KeyFieldNames = 'GOODSTYPEID'
      Properties.ListColumns = <
        item
          FieldName = 'TITLE'
        end
        item
          FieldName = 'TITLE_RUS'
        end>
      Properties.ListOptions.RowSelect = False
      Properties.ListOptions.SyncMode = True
      Properties.ListSource = IBCDataSourceGT
      TabOrder = 0
      Width = 405
    end
    object rgFLG_EXCLUDE: TcxDBRadioGroup
      Left = 16
      Top = 80
      Caption = 'Categorie'
      DataBinding.DataField = 'FLG_EXCLUDE'
      Properties.Columns = 2
      Properties.Items = <
        item
          Caption = 'Include'
          Value = 0
        end
        item
          Caption = 'Exclude'
          Value = 1
        end>
      TabOrder = 1
      Height = 57
      Width = 405
    end
  end
  object btnCancel: TButton
    Left = 354
    Top = 256
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
  object btnOk: TButton
    Left = 250
    Top = 256
    Width = 90
    Height = 29
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object IBCQueryGT: TIBCQuery
    KeyFields = 'GOODSTYPEID'
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      'SELECT GOODSTYPEID, TITLE_RUS, TITLE'
      'FROM TS_GOODS_TYPE'
      'ORDER BY 2')
    Left = 224
    Top = 12
  end
  object IBCDataSourceGT: TIBCDataSource
    DataSet = IBCQueryGT
    Left = 224
    Top = 60
  end
end
