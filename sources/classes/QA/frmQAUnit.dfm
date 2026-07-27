object frmQADlg: TfrmQADlg
  Left = 0
  Top = 0
  Caption = 'Chestionar'
  ClientHeight = 288
  ClientWidth = 430
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    430
    288)
  PixelsPerInch = 96
  TextHeight = 13
  object DialogTitle1: TDialogTitle
    Left = 0
    Top = 0
    Width = 430
    Height = 64
    Title = 'Chestionar'
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
    ImageIndex = 25
  end
  object Panel1: TPanel
    Left = 8
    Top = 70
    Width = 414
    Height = 165
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    object lbQuestion: TLabel
      Left = 24
      Top = 16
      Width = 60
      Height = 13
      Caption = 'lbQuestion'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object cxDBLookupComboBox1: TcxDBLookupComboBox
      Left = 24
      Top = 35
      Properties.ListColumns = <>
      TabOrder = 0
      Width = 369
    end
  end
  object Button1: TButton
    Left = 216
    Top = 251
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    TabOrder = 2
  end
  object Button2: TButton
    Left = 320
    Top = 251
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    TabOrder = 3
  end
  object IBCQuery1: TIBCQuery
    SQL.Strings = (
      'select * from ts_answers where question_id = :id')
    Constraints = <>
    Left = 224
    Top = 152
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        Value = nil
      end>
  end
  object IBCDataSource1: TIBCDataSource
    DataSet = IBCQuery1
    Left = 160
    Top = 152
  end
end
