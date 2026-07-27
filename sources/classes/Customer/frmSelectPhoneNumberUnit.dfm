object frmSelectPhoneNumber: TfrmSelectPhoneNumber
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Alege numarul pentru apel...'
  ClientHeight = 279
  ClientWidth = 502
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  DesignSize = (
    502
    279)
  PixelsPerInch = 96
  TextHeight = 15
  object cxGrid1: TcxGrid
    Left = 8
    Top = 8
    Width = 486
    Height = 217
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    LookAndFeel.NativeStyle = True
    object cxGrid1DBTableView1: TcxGridDBTableView
      OnKeyDown = cxGrid1DBTableView1KeyDown
      Navigator.Buttons.ConfirmDelete = True
      Navigator.Buttons.CustomButtons = <>
      Navigator.Buttons.First.Visible = False
      Navigator.Buttons.PriorPage.Visible = False
      Navigator.Buttons.Prior.Visible = False
      Navigator.Buttons.Next.Visible = False
      Navigator.Buttons.NextPage.Visible = False
      Navigator.Buttons.Last.Visible = False
      Navigator.Buttons.Insert.Visible = False
      Navigator.Buttons.Append.Visible = True
      Navigator.Buttons.Post.Visible = False
      Navigator.Buttons.SaveBookmark.Visible = False
      Navigator.Buttons.GotoBookmark.Visible = False
      Navigator.Buttons.Filter.Visible = False
      ScrollbarAnnotations.CustomAnnotations = <>
      DataController.DataSource = IBCDSPhone
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      NewItemRow.InfoText = #1053#1086#1074#1072#1103' '#1079#1072#1087#1080#1089#1100
      NewItemRow.SeparatorColor = clBtnShadow
      OptionsBehavior.ImmediateEditor = False
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.HideFocusRectOnExit = False
      OptionsSelection.InvertSelect = False
      OptionsSelection.UnselectFocusedRecordOnExit = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.EditAutoHeightBorderColor = clGreen
      OptionsView.GroupByBox = False
      OptionsView.Indicator = True
      object cxGrid1DBTableView1Column1: TcxGridDBColumn
        Caption = 'tip'
        DataBinding.FieldName = 'PHONETYPE'
        PropertiesClassName = 'TcxComboBoxProperties'
        Properties.DropDownListStyle = lsFixedList
        Properties.ImmediateDropDownWhenActivated = True
        Properties.PostPopupValueOnTab = True
        HeaderAlignmentHorz = taCenter
        Options.Filtering = False
        Options.FilteringWithFindPanel = False
        Options.FilteringAddValueItems = False
        Options.FilteringFilteredItemsList = False
        Options.FilteringMRUItemsList = False
        Options.FilteringPopup = False
        Options.FilteringPopupMultiSelect = False
        Options.ShowEditButtons = isebAlways
        Width = 166
      end
      object cxGrid1DBTableView1Column2: TcxGridDBColumn
        Caption = 'numar'
        DataBinding.FieldName = 'PHONENUMBER'
        PropertiesClassName = 'TcxMaskEditProperties'
        Properties.Alignment.Horz = taRightJustify
        Properties.EditMask = '!\(999\)000-000;0;_'
        Properties.ValidationOptions = [evoRaiseException, evoShowErrorIcon]
        HeaderAlignmentHorz = taCenter
        Options.Filtering = False
        Options.FilteringWithFindPanel = False
        Options.FilteringAddValueItems = False
        Options.FilteringFilteredItemsList = False
        Options.FilteringMRUItemsList = False
        Options.FilteringPopup = False
        Options.FilteringPopupMultiSelect = False
        Options.GroupFooters = False
        Options.Grouping = False
        Width = 102
      end
      object cxGrid1DBTableView1Column3: TcxGridDBColumn
        Caption = 'nume, prenume'
        DataBinding.FieldName = 'COMMENT'
        HeaderAlignmentHorz = taCenter
        Options.Filtering = False
        Options.FilteringWithFindPanel = False
        Options.FilteringAddValueItems = False
        Options.FilteringFilteredItemsList = False
        Options.FilteringMRUItemsList = False
        Options.FilteringPopup = False
        Options.FilteringPopupMultiSelect = False
        Width = 204
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
    end
  end
  object btnOK: TcxButton
    Left = 287
    Top = 242
    Width = 90
    Height = 29
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object cxButton2: TcxButton
    Left = 391
    Top = 242
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 2
  end
  object IBCQueryPhone: TIBCQuery
    SQLInsert.Strings = (
      'INSERT INTO VW_TS_CUST_PHONES'
      '  (CUSTOMERID, PHONENUMBER, COMMENT, PHONETYPEID, PHONETYPE)'
      'VALUES'
      
        '  (:CUSTOMERID, :PHONENUMBER, :COMMENT, :PHONETYPEID, :PHONETYPE' +
        ')')
    SQLDelete.Strings = (
      'DELETE FROM VW_TS_CUST_PHONES'
      'WHERE'
      
        '  CUSTOMERID = :Old_CUSTOMERID AND PHONENUMBER = :Old_PHONENUMBE' +
        'R')
    SQLUpdate.Strings = (
      'UPDATE VW_TS_CUST_PHONES'
      'SET'
      
        '  CUSTOMERID = :CUSTOMERID, PHONENUMBER = :PHONENUMBER, COMMENT ' +
        '= :COMMENT, PHONETYPEID = :PHONETYPEID, PHONETYPE = :PHONETYPE'
      'WHERE'
      
        '  CUSTOMERID = :Old_CUSTOMERID AND PHONENUMBER = :Old_PHONENUMBE' +
        'R')
    SQLRefresh.Strings = (
      
        'SELECT CUSTOMERID, PHONENUMBER, COMMENT, PHONETYPEID, PHONETYPE ' +
        'FROM VW_TS_CUST_PHONES'
      'WHERE'
      '  CUSTOMERID = :CUSTOMERID AND PHONENUMBER = :PHONENUMBER')
    SQLLock.Strings = (
      'SELECT NULL FROM TS_CUST_PHONES'
      'WHERE'
      'CUSTOMERID = :Old_CUSTOMERID AND PHONENUMBER = :Old_PHONENUMBER'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM VW_TS_CUST_PHONES'
      ''
      ') q')
    SQL.Strings = (
      'select * from VW_TS_CUST_PHONES '
      'where customerid=:customerid')
    AutoCommit = False
    Left = 164
    Top = 70
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'customerid'
        Value = nil
      end>
  end
  object IBCDSPhone: TIBCDataSource
    DataSet = IBCQueryPhone
    Left = 76
    Top = 70
  end
end
