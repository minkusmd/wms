unit frameDocsDeliveryUnit;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
   Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
   cxStyles, cxEdit, cxButtonEdit, cxCalc, cxCheckBox, cxCalendar, cxMemo,
   cxDataControllerConditionalFormattingRulesManagerDialog, cxVGrid, cxDBVGrid, cxInplaceContainer, Data.DB,
   DBAccess, IBC, MemDS, Vcl.Menus, Vcl.StdCtrls, cxButtons, Vcl.ExtCtrls, dxScrollbarAnnotations, cxFilter, cxTextEdit;

type
   TframeDocsDelivery = class(TFrame)
      cxDBVerticalGrid1: TcxDBVerticalGrid;
      cxDBVerticalGrid1DOCID: TcxDBEditorRow;
      cxDBVerticalGrid1COURIERID: TcxDBEditorRow;
      cxDBVerticalGrid1CategoryRow2: TcxCategoryRow;
      cxDBVerticalGrid1COURIER_NAME: TcxDBEditorRow;
      cxDBVerticalGrid1AWB: TcxDBEditorRow;
      cxDBVerticalGrid1DBMultiEditorRow1: TcxDBMultiEditorRow;
      cxDBVerticalGrid1CategoryRow1: TcxCategoryRow;
      cxDBVerticalGrid1DELIVERY_DATE: TcxDBEditorRow;
      cxDBVerticalGrid1DELIVERY_TIME: TcxDBEditorRow;
      cxDBVerticalGrid1DELIVERY_ADDRESS: TcxDBEditorRow;
      IBCQueryDelivery: TIBCQuery;
      IBCDSDelivery: TIBCDataSource;
    Panel1: TPanel;
    cxButton1: TcxButton;
    procedure cxButton1Click(Sender: TObject);
   private
    { Private declarations }
   protected
   public
      procedure PostData(DocID: Integer);
      procedure PrepareData(DocID: Integer);
    { Public declarations }
   end;

implementation

uses
   DataModuleDB;

{$R *.dfm}

procedure TframeDocsDelivery.cxButton1Click(Sender: TObject);
begin
  IBCQueryDelivery.Delete;
end;

procedure TframeDocsDelivery.PostData(DocID: Integer);
begin
   try
      if IBCQueryDelivery.State in dsEditModes then
         IBCQueryDelivery.Post;
   except
      on e: Exception do
      begin
         IBCQueryDelivery.Cancel;
         raise;
      end;
   end;
end;

procedure TframeDocsDelivery.PrepareData(DocID: Integer);
begin
   IBCQueryDelivery.Close;
   IBCQueryDelivery.ParamByName('DOCID').AsInteger := DocID;
   IBCQueryDelivery.Open;
end;

end.

