object frmSarcinaOperatorilorDlg: TfrmSarcinaOperatorilorDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Sarcina opeatori content'
  ClientHeight = 260
  ClientWidth = 348
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object RzDialogButtons1: TRzDialogButtons
    Left = 0
    Top = 224
    Width = 348
    CaptionOk = 'Inchide'
    ShowCancelButton = False
    WidthOk = 90
    TabOrder = 1
    ExplicitLeft = 3
    ExplicitTop = 378
    ExplicitWidth = 672
  end
  object cxGrid1: TcxGrid
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 342
    Height = 218
    Align = alClient
    TabOrder = 0
    ExplicitLeft = 219
    ExplicitTop = 125
    ExplicitWidth = 250
    ExplicitHeight = 200
    object cxGrid1DBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      ScrollbarAnnotations.CustomAnnotations = <>
      DataController.DataSource = IBCDataSourceSarcinaOperatori
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.GroupByBox = False
      object cxGrid1DBTableView1USERID: TcxGridDBColumn
        Caption = 'Cod'
        DataBinding.FieldName = 'USERID'
        Visible = False
      end
      object cxGrid1DBTableView1FULL_NAME: TcxGridDBColumn
        Caption = 'Operator'
        DataBinding.FieldName = 'FULL_NAME'
        Width = 221
      end
      object cxGrid1DBTableView1CNT: TcxGridDBColumn
        Caption = 'Produse in lucru'
        DataBinding.FieldName = 'CNT'
        Width = 103
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
    end
  end
  object IBCQuerySarcinaOperatori: TIBCQuery
    SQL.Strings = (
      
        'select cp.responsable_userid userid, u.full_name, count(cpg.good' +
        'sid) cnt'
      '             from tcontent_package cp'
      
        '             join tcontent_package_goods cpg on cpg.packageid = ' +
        'cp.id'
      '             join ts_users u on u.userid = cp.responsable_userid'
      '             where get_flg_value(cp.flags, 1) = 0 and'
      '                   cp.approved_userid is null'
      '             group by 1,2'
      'order by 3 desc')
    Left = 256
    Top = 41
  end
  object IBCDataSourceSarcinaOperatori: TIBCDataSource
    DataSet = IBCQuerySarcinaOperatori
    Left = 170
    Top = 42
  end
end
