object frmDocumentTreeDlg: TfrmDocumentTreeDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Ierarhia documentelor'
  ClientHeight = 319
  ClientWidth = 835
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object cxGrid1: TcxGrid
    Left = 0
    Top = 0
    Width = 835
    Height = 278
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 651
    object cxGrid1DBTableView1: TcxGridDBTableView
      OnDblClick = cxGrid1DBTableView1DblClick
      DataController.DataSource = IBCDataSourceDocs
      DataController.KeyFieldNames = 'DOCID_OUT'
      OptionsBehavior.IncSearch = True
      OptionsBehavior.ImmediateEditor = False
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.GroupByBox = False
      Styles.OnGetContentStyle = cxGrid1DBTableView1StylesGetContentStyle
      object cxGrid1DBTableView1DIRECTION: TcxGridDBColumn
        Caption = 'Directia'
        DataBinding.FieldName = 'DIRECTION'
        Width = 87
      end
      object cxGrid1DBTableView1LEVEL_: TcxGridDBColumn
        Caption = 'Lvl'
        DataBinding.FieldName = 'LEVEL_'
        Width = 44
      end
      object cxGrid1DBTableView1DOCID_OUT: TcxGridDBColumn
        Caption = 'DocID'
        DataBinding.FieldName = 'DOCID_OUT'
        Width = 90
      end
      object cxGrid1DBTableView1PARENTDOCID: TcxGridDBColumn
        Caption = 'Parent DocID'
        DataBinding.FieldName = 'PARENTDOCID'
        Width = 153
      end
      object cxGrid1DBTableView1DOCTYPE_NAME: TcxGridDBColumn
        Caption = 'Tip document'
        DataBinding.FieldName = 'DOCTYPE_NAME'
        Width = 224
      end
      object cxGrid1DBTableView1DATA_DOC: TcxGridDBColumn
        Caption = 'Data'
        DataBinding.FieldName = 'DATA_DOC'
        Width = 84
      end
      object cxGrid1DBTableView1CREATED_BY_ID: TcxGridDBColumn
        DataBinding.FieldName = 'CREATED_BY_ID'
        Visible = False
      end
      object cxGrid1DBTableView1CREATED_BY_NAME: TcxGridDBColumn
        Caption = 'Utilizator'
        DataBinding.FieldName = 'CREATED_BY_NAME'
        Width = 150
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
    end
  end
  object RzDialogButtons1: TRzDialogButtons
    Left = 0
    Top = 278
    Width = 835
    Height = 41
    OnClickOk = RzDialogButtons1ClickOk
    TabOrder = 1
    ExplicitWidth = 651
  end
  object IBCQueryDocs: TIBCQuery
    SQL.Strings = (
      'SELECT * FROM SP_GET_DOC_TREE(:docid)')
    Active = True
    Left = 344
    Top = 192
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'docid'
        Value = nil
      end>
  end
  object IBCDataSourceDocs: TIBCDataSource
    DataSet = IBCQueryDocs
    Left = 344
    Top = 136
  end
end
