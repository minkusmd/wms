object frmNakladnaiaPNExpenseDlg: TfrmNakladnaiaPNExpenseDlg
  Left = 0
  Top = 0
  ActiveControl = lcbEXPENSE_ID
  BorderStyle = bsDialog
  Caption = 'Cheltuieli adaugatoare'
  ClientHeight = 358
  ClientWidth = 474
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    474
    358)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 474
    Height = 64
    Title = 'Cheltuieli adaugatoare'
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
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 458
    Height = 225
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
    object cxLabel1: TLabel
      Left = 12
      Top = 16
      Width = 108
      Height = 15
      Caption = 'Articole de cheltuieli'
      Transparent = True
    end
    object cxLabel3: TLabel
      Left = 12
      Top = 82
      Width = 196
      Height = 15
      Caption = 'Document cu descrierea cheltuielelor'
      Transparent = True
    end
    object lcbEXPENSE_ID: TcxDBLookupComboBox
      Left = 12
      Top = 33
      DataBinding.DataField = 'EXPENSE_ID'
      Properties.DropDownListStyle = lsFixedList
      Properties.KeyFieldNames = 'EXPENSEID'
      Properties.ListColumns = <
        item
          FieldName = 'TITLE'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = IBCDataSourceExpense
      TabOrder = 0
      Width = 429
    end
    object vgExpDoc: TcxDBVerticalGrid
      Left = 12
      Top = 99
      Width = 429
      Height = 108
      OptionsView.ScrollBars = ssNone
      OptionsView.RowHeaderWidth = 61
      OptionsView.ShowButtons = False
      OptionsBehavior.ImmediateEditor = False
      OptionsBehavior.HeaderSizing = False
      OptionsBehavior.AllowChangeRecord = False
      OptionsData.Editing = False
      OptionsData.Appending = False
      OptionsData.Deleting = False
      OptionsData.Inserting = False
      Navigator.Buttons.CustomButtons = <>
      ScrollbarAnnotations.CustomAnnotations = <>
      Styles.Content = dmAdditions.cxStyle_Bold
      Styles.Header = dmAdditions.cxStyle_GridContentEven
      TabOrder = 2
      TabStop = False
      DataController.DataSource = IBCDataSourceDocs
      DataController.GridMode = True
      DataController.GridModeBufferCount = 1
      Version = 1
      object vgExpDocDBEditorRow1: TcxDBEditorRow
        Properties.Caption = 'Cod'
        Properties.HeaderAlignmentHorz = taRightJustify
        Properties.EditPropertiesClassName = 'TcxLabelProperties'
        Properties.EditProperties.Alignment.Horz = taLeftJustify
        Properties.DataBinding.FieldName = 'DOCID'
        ID = 0
        ParentID = -1
        Index = 0
        Version = 1
      end
      object vgExpDocDBEditorRow2: TcxDBEditorRow
        Properties.Caption = 'Tip'
        Properties.HeaderAlignmentHorz = taRightJustify
        Properties.DataBinding.FieldName = 'DOCTYPE_NAME'
        ID = 1
        ParentID = -1
        Index = 1
        Version = 1
      end
      object vgExpDocDBEditorRow3: TcxDBEditorRow
        Properties.Caption = 'Suma'
        Properties.HeaderAlignmentHorz = taRightJustify
        Properties.EditPropertiesClassName = 'TcxLabelProperties'
        Properties.EditProperties.Alignment.Horz = taLeftJustify
        Properties.DataBinding.FieldName = 'SUMA'
        ID = 2
        ParentID = -1
        Index = 2
        Version = 1
      end
      object vgExpDocDBEditorRow4: TcxDBEditorRow
        Properties.Caption = 'Valuta'
        Properties.HeaderAlignmentHorz = taRightJustify
        Properties.DataBinding.FieldName = 'CURRENCY_NAME'
        ID = 3
        ParentID = -1
        Index = 3
        Version = 1
      end
      object vgExpDocDBEditorRow5: TcxDBEditorRow
        Properties.Caption = 'Rata'
        Properties.HeaderAlignmentHorz = taRightJustify
        Properties.EditPropertiesClassName = 'TcxLabelProperties'
        Properties.EditProperties.Alignment.Horz = taLeftJustify
        Properties.DataBinding.FieldName = 'RATE'
        ID = 4
        ParentID = -1
        Index = 4
        Version = 1
      end
    end
    object btnSelectDoc: TcxButton
      Left = 348
      Top = 72
      Width = 93
      Height = 25
      Caption = 'alege...'
      TabOrder = 1
      OnClick = btnSelectDocClick
    end
  end
  object btnOk: TcxButton
    Left = 260
    Top = 313
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TcxButton
    Left = 362
    Top = 313
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
  object IBCQueryExpense: TIBCQuery
    SQL.Strings = (
      'SELECT'
      ' EXPENSEID,TITLE'
      'FROM'
      ' GET_EXPENSE_TYPES')
    ReadOnly = True
    Options.BooleanDomainFields = True
    Left = 288
    Top = 64
  end
  object IBCDataSourceExpense: TIBCDataSource
    AutoEdit = False
    DataSet = IBCQueryExpense
    Left = 288
    Top = 16
  end
  object IBCQueryDocs: TIBCQuery
    UpdatingTable = 'VW_TDB_DOCS'
    KeyFields = 'DOCID'
    SQL.Strings = (
      'SELECT'
      ' *'
      'FROM'
      ' VW_TDB_DOCS')
    MasterFields = 'EXPENSE_DOC_ID'
    DetailFields = 'DOCID'
    AutoCommit = False
    RefreshOptions = [roAfterInsert, roAfterUpdate, roBeforeEdit]
    Options.BooleanDomainFields = True
    Options.RequiredFields = False
    LocalConstraints = False
    Left = 244
    Top = 236
  end
  object IBCDataSourceDocs: TIBCDataSource
    DataSet = IBCQueryDocs
    Left = 244
    Top = 188
  end
end
