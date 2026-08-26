object frmSendGoodsToPackageDlg: TfrmSendGoodsToPackageDlg
  Left = 0
  Top = 0
  ActiveControl = lcbOperator
  BorderStyle = bsDialog
  Caption = 'Transfer la perfectare'
  ClientHeight = 278
  ClientWidth = 389
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  DesignSize = (
    389
    278)
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 389
    Height = 64
    Title = 'Trimite'#539'i la perfectare'
    Text = 'Selecta'#539'i un operator pentru a prelucra produsele'
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
    ImageIndex = 1
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 373
    Height = 141
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
      Top = 15
      Width = 47
      Height = 15
      Caption = 'Operator'
    end
    object lbInfo: TLabel
      Left = 23
      Top = 61
      Width = 21
      Height = 15
      Caption = 'Info'
    end
    object lcbOperator: TcxLookupComboBox
      Left = 20
      Top = 32
      Properties.DropDownListStyle = lsFixedList
      Properties.DropDownRows = 16
      Properties.ImmediatePost = True
      Properties.IncrementalFilteringOptions = [ifoHighlightSearchText, ifoUseContainsOperator]
      Properties.KeyFieldNames = 'USERID'
      Properties.ListColumns = <
        item
          FieldName = 'FULL_NAME'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = IBCDataSourceUsers
      EditValue = 0
      TabOrder = 0
      Width = 329
    end
    object cxLabel1: TcxLabel
      Left = 20
      Top = 96
      Caption = 
        'Numai acele bunuri care nu se afl'#259' deja '#238'n proces sunt primite '#238 +
        'n procesare!'
      Style.TextColor = clMaroon
      Properties.WordWrap = True
      TabOrder = 1
      Width = 265
    end
  end
  object btnOk: TButton
    Left = 168
    Top = 235
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 272
    Top = 235
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
  object IBCDataSourceUsers: TIBCDataSource
    DataSet = IBCQueryUsers
    Left = 232
    Top = 128
  end
  object IBCQueryUsers: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'select * from get_available_content_users')
    Left = 233
    Top = 76
  end
end
