object Frame2: TFrame2
  Left = 0
  Top = 0
  Width = 633
  Height = 205
  TabOrder = 0
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 633
    Height = 205
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitTop = 3
    ExplicitHeight = 206
    object cxGrid1: TcxGrid
      Left = 8
      Top = 6
      Width = 305
      Height = 193
      TabOrder = 0
      object cxGrid1DBTableView1: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = IBCDataSourceSMS_History
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.GroupByBox = False
        object cxGrid1DBTableView1FLG_SENT: TcxGridDBColumn
          Caption = 'S'
          DataBinding.FieldName = 'FLG_SENT'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.DisplayChecked = 'Trimis'
          Properties.DisplayUnchecked = 'Ne trimis'
          Properties.ValueChecked = '1'
          Properties.ValueUnchecked = '0'
          HeaderAlignmentHorz = taCenter
          Width = 20
        end
        object cxGrid1DBTableView1DATA_CREATED: TcxGridDBColumn
          Caption = 'Creat la'
          DataBinding.FieldName = 'DATA_CREATED'
          HeaderAlignmentHorz = taCenter
          Width = 88
        end
        object cxGrid1DBTableView1PHONE: TcxGridDBColumn
          DataBinding.FieldName = 'PHONE'
          Visible = False
          VisibleForCustomization = False
        end
        object cxGrid1DBTableView1DATA_DELIVERED: TcxGridDBColumn
          Caption = 'Data trimiterii'
          DataBinding.FieldName = 'DATA_DELIVERED'
          Width = 75
        end
        object cxGrid1DBTableView1CREATED_BY: TcxGridDBColumn
          Caption = 'Utilizator'
          DataBinding.FieldName = 'LOGIN_NAME'
        end
      end
      object cxGrid1Level1: TcxGridLevel
        GridView = cxGrid1DBTableView1
      end
    end
    object cxDBMemo1: TcxDBMemo
      Left = 319
      Top = 6
      DataBinding.DataField = 'SMS_TEXT'
      DataBinding.DataSource = IBCDataSourceSMS_History
      TabOrder = 1
      Height = 193
      Width = 306
    end
  end
  object IBCDataSourceSMS_History: TIBCDataSource
    DataSet = IBCQuerySMS_History
    Left = 120
    Top = 40
  end
  object IBCQuerySMS_History: TIBCQuery
    SQL.Strings = (
      'select s.*, u.Login_Name from sms_messages s '
      'inner join ts_users u on u.userid=s.created_by'
      'where s.phone=:phone '
      'order by s.data_created desc')
    Constraints = <>
    Left = 208
    Top = 40
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'phone'
        Value = nil
      end>
  end
end
