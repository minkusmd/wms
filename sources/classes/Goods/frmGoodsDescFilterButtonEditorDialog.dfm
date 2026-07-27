object frmGoodsDescFilterButtonEditorDlg: TfrmGoodsDescFilterButtonEditorDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Buton de trecere din caracteristici'
  ClientHeight = 302
  ClientWidth = 455
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    455
    302)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 455
    Height = 64
    Title = 'Buton de trecere din caracteristici'
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
    ImageIndex = 7
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 439
    Height = 177
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
    ShowCaption = False
    TabOrder = 1
    object Label1: TLabel
      Left = 20
      Top = 20
      Width = 32
      Height = 15
      Caption = 'Buton'
    end
    object sbAdminButtons: TSpeedButton
      Left = 363
      Top = 37
      Width = 60
      Height = 23
      Caption = 'Modifica'
      OnClick = sbAdminButtonsClick
    end
    object cmbFILTER_BUTTON_ID: TcxDBLookupComboBox
      Left = 20
      Top = 37
      DataBinding.DataField = 'FILTER_BUTTON_ID'
      Properties.DropDownListStyle = lsFixedList
      Properties.DropDownRows = 16
      Properties.ImmediatePost = True
      Properties.KeyFieldNames = 'FILTER_BUTTON_ID'
      Properties.ListColumns = <
        item
          FieldName = 'SYS_TITLE'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = IBCDataSourceButtons
      TabOrder = 0
      Width = 337
    end
  end
  object btnOk: TButton
    Left = 238
    Top = 260
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 346
    Top = 260
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
  object IBCQueryButtons: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      'SELECT'
      ' FILTER_BUTTON_ID,'
      ' SYS_TITLE'
      'FROM'
      ' TS_FILTER_BUTTON'
      'WHERE '
      ' GET_FLG_VALUE(FLAGS,0)=1'
      'ORDER BY'
      ' SYS_TITLE')
    Left = 80
    Top = 192
  end
  object IBCDataSourceButtons: TIBCDataSource
    DataSet = IBCQueryButtons
    Left = 80
    Top = 144
  end
end
