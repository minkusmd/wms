object frmCreateCustomNareadSborkaDlg: TfrmCreateCustomNareadSborkaDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Asamblare'
  ClientHeight = 250
  ClientWidth = 606
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    606
    250)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 606
    Height = 64
    Title = 'Producere'
    Text = 
      'Creaza document "Producere" si alege unde se va efectua producer' +
      'ea'
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
    Width = 590
    Height = 123
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
    object rbCurrentFirma: TRadioButton
      Left = 16
      Top = 32
      Width = 233
      Height = 17
      Caption = '"Producerea" in subdiviziunea curenta'
      TabOrder = 1
      OnClick = rbCurrentFirmaClick
    end
    object rbCustomFirma: TRadioButton
      Left = 16
      Top = 61
      Width = 233
      Height = 17
      Caption = '"Producerea" in alta subdiviziune'
      TabOrder = 3
      OnClick = rbCurrentFirmaClick
    end
    object edCurrentFirma: TcxTextEdit
      Left = 255
      Top = 29
      TabStop = False
      Properties.ReadOnly = True
      TabOrder = 0
      Text = 'edCurrentFirma'
      Width = 310
    end
    object lcbFirms: TcxLookupComboBox
      Left = 255
      Top = 58
      Properties.DropDownListStyle = lsFixedList
      Properties.DropDownRows = 16
      Properties.KeyFieldNames = 'CUSTOMERID'
      Properties.ListColumns = <
        item
          Fixed = True
          Width = 40
          FieldName = 'CUSTOMERID'
        end
        item
          FieldName = 'DISPLAYNAME'
        end>
      Properties.ListFieldIndex = 1
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = IBCDataSourceFirms
      EditValue = 0
      TabOrder = 2
      Width = 310
    end
  end
  object btnOk: TcxButton
    Left = 389
    Top = 206
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object Button2: TcxButton
    Left = 493
    Top = 206
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
  object IBCQueryFirms: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      'SELECT'
      ' CUSTOMERID,'
      ' DISPLAYNAME'
      'FROM'
      ' VW_TS_FIRMS'
      'WHERE'
      ' CUSTOMERID<>:firma'
      'ORDER BY'
      ' DISPLAYNAME')
    Left = 144
    Top = 196
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'firma'
        Value = nil
      end>
  end
  object IBCDataSourceFirms: TIBCDataSource
    DataSet = IBCQueryFirms
    Left = 44
    Top = 196
  end
end
