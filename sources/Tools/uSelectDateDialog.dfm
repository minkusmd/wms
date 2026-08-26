object frmSelectDateDialog: TfrmSelectDateDialog
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Selecteaza data'
  ClientHeight = 279
  ClientWidth = 301
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object CalendarView1: TCalendarView
    Left = 8
    Top = 8
    Width = 281
    Height = 201
    Date = 44064.000000000000000000
    FirstDayOfWeek = dwMonday
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = []
    HeaderInfo.DaysOfWeekFont.Charset = DEFAULT_CHARSET
    HeaderInfo.DaysOfWeekFont.Color = clWindowText
    HeaderInfo.DaysOfWeekFont.Height = -12
    HeaderInfo.DaysOfWeekFont.Name = 'Segoe UI'
    HeaderInfo.DaysOfWeekFont.Style = []
    HeaderInfo.Font.Charset = DEFAULT_CHARSET
    HeaderInfo.Font.Color = clWindowText
    HeaderInfo.Font.Height = -13
    HeaderInfo.Font.Name = 'Segoe UI'
    HeaderInfo.Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object btnOK: TButton
    Left = 56
    Top = 240
    Width = 90
    Height = 29
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancel: TButton
    Left = 160
    Top = 240
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 2
  end
end
