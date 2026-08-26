object frmGlobalCallHistory: TfrmGlobalCallHistory
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Registru de sunete'
  ClientHeight = 441
  ClientWidth = 420
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object RzDialogButtons1: TRzDialogButtons
    Left = 0
    Top = 400
    Width = 420
    Height = 41
    TabOrder = 0
  end
  object cxGrid1: TcxGrid
    Left = 0
    Top = 0
    Width = 420
    Height = 400
    Align = alClient
    TabOrder = 1
    object cxGrid1DBTableView1: TcxGridDBTableView
      DataController.DataSource = IBCDataSource1
      OptionsView.GroupByBox = False
      object cxGrid1DBTableView1DATA: TcxGridDBColumn
        DataBinding.FieldName = 'DATA'
        HeaderAlignmentHorz = taCenter
        Width = 105
      end
      object cxGrid1DBTableView1PHONENUMBER: TcxGridDBColumn
        DataBinding.FieldName = 'PHONENUMBER'
        HeaderAlignmentHorz = taCenter
      end
      object cxGrid1DBTableView1NICKNAME: TcxGridDBColumn
        DataBinding.FieldName = 'NICKNAME'
        HeaderAlignmentHorz = taCenter
        Width = 250
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
    end
  end
  object IBCQuery1: TIBCQuery
    SQL.Strings = (
      
        'select distinct data, phonenumber, nickname from TS_PHONE_CALLS_' +
        'HISTORY where phonenumber = :phonenumber'
      'order by data desc')
    Active = True
    Left = 140
    Top = 156
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'phonenumber'
        Value = nil
      end>
  end
  object IBCDataSource1: TIBCDataSource
    DataSet = IBCQuery1
    Left = 140
    Top = 96
  end
end
