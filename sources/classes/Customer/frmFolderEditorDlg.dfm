object frmCustomerFolderEditorDialog: TfrmCustomerFolderEditorDialog
  Left = 0
  Top = 0
  ActiveControl = edNAME
  BorderStyle = bsDialog
  ClientHeight = 278
  ClientWidth = 362
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    362
    278)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 362
    Height = 64
    Title = #1055#1072#1087#1082#1072
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
    ImageIndex = 0
  end
  object pnFolder: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 346
    Height = 145
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    object cxLabel15: TLabel
      Left = 12
      Top = 80
      Width = 56
      Height = 15
      Caption = #1058#1080#1087' '#1087#1072#1087#1082#1080
      Transparent = True
    end
    object cxLabel1: TLabel
      Left = 12
      Top = 16
      Width = 88
      Height = 15
      Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1087#1072#1087#1082#1080
      Transparent = True
    end
    object lcbCUSTOMER_TYPE_ID: TcxDBLookupComboBox
      Left = 12
      Top = 96
      DataBinding.DataField = 'CUSTOMER_TYPE_ID'
      Properties.DropDownListStyle = lsFixedList
      Properties.DropDownRows = 16
      Properties.KeyFieldNames = 'CUSTOMERTYPEID'
      Properties.ListColumns = <
        item
          Fixed = True
          Width = 120
          FieldName = 'TITLE'
        end
        item
          Width = 120
          FieldName = 'DESCRIPTION'
        end>
      Properties.ListOptions.GridLines = glHorizontal
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = IBCDataSourceCustomerType
      TabOrder = 1
      Width = 313
    end
    object edNAME: TcxDBTextEdit
      Left = 12
      Top = 33
      DataBinding.DataField = 'NAME'
      TabOrder = 0
      Width = 313
    end
  end
  object btnOk: TcxButton
    Left = 153
    Top = 233
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = '&Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TcxButton
    Left = 252
    Top = 233
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 3
  end
  object IBCQueryCustomerType: TIBCQuery
    SQL.Strings = (
      'SELECT'
      '    CUSTOMERTYPEID,'
      '    TITLE,'
      '    DESCRIPTION'
      'FROM'
      '    GET_CUSTOMER_TYPES')
    Left = 216
    Top = 64
  end
  object IBCDataSourceCustomerType: TIBCDataSource
    DataSet = IBCQueryCustomerType
    Left = 216
    Top = 12
  end
end
