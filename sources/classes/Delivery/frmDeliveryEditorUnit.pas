unit frmDeliveryEditorUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxDBEdit,
  cxMemo, cxSpinEdit, cxTimeEdit, cxDropDownEdit, cxCalendar, cxLabel,
  cxTextEdit, cxMaskEdit, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox,
  cxGroupBox, Data.DB, DBAccess, IBC, MemDS;

type
  TfrmDeliveryEditorDlg = class(TForm)
    cxGroupBox2: TcxGroupBox;
    cxDBLookupComboBox2: TcxDBLookupComboBox;
    cxLabel4: TcxLabel;
    cxDBLookupComboBox3: TcxDBLookupComboBox;
    cxLabel5: TcxLabel;
    cxDBDateEdit1: TcxDBDateEdit;
    cxLabel6: TcxLabel;
    cxLabel7: TcxLabel;
    cxDBTimeEdit1: TcxDBTimeEdit;
    cxLabel8: TcxLabel;
    cxDBMemo1: TcxDBMemo;
    cxLabel9: TcxLabel;
    cxDBTextEdit2: TcxDBTextEdit;
    cxLabel10: TcxLabel;
    cxDBMemo2: TcxDBMemo;
    IBCQueryCities: TIBCQuery;
    IBCDataSourceCities: TIBCDataSource;
    IBCQueryDistricts: TIBCQuery;
    IBCDataSourceDistricts: TIBCDataSource;
    IBCQueryDelivery: TIBCQuery;
    IBCDSDelivery: TIBCDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDeliveryEditorDlg: TfrmDeliveryEditorDlg;

implementation

{$R *.dfm}

end.
