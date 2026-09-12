unit frmDateFilterDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit, Menus,
  StdCtrls, cxButtons, cxSpinEdit, cxCheckBox, cxRadioGroup, cxDropDownEdit, cxEdit,
  cxCalendar, ExtCtrls, DialogTitle,
  SWNDocumentFilters, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, Vcl.ComCtrls, dxCore,
  cxDateUtils, cxTextEdit, cxMaskEdit;

type
  TfrmDateFilterDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnMain: TPanel;
    pnButtons: TPanel;
    deDateStart: TcxDateEdit;
    deDateEnd: TcxDateEdit;
    cmbQuickDate: TcxComboBox;
    cxLabel1: TLabel;
    rbQuarter: TcxRadioButton;
    rbMonth: TcxRadioButton;
    rbDay: TcxRadioButton;
    rbDateRange: TcxRadioButton;
    cbQuarterYearStart: TcxCheckBox;
    cbMonthQuarterStart: TcxCheckBox;
    cbDayMonthStart: TcxCheckBox;
    cmbQuarter: TcxComboBox;
    cmbMonth: TcxComboBox;
    seQuarterYear: TcxSpinEdit;
    seMonthYear: TcxSpinEdit;
    deDateByDay: TcxDateEdit;
    btnCancel: TcxButton;
    btnOk: TcxButton;
    procedure cmbQuickDatePropertiesEditValueChanged(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure rbQuarterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    fDateStart:TDateTime;
    fDateEnd:TDateTime;

    procedure SetupQuickDateFilter(const filterItem:TFrameDocumentDateFilter);
    procedure SelectDateFilterByDate(const StartDate,EndDate:TDateTime);
    procedure CreateDateFilter;
    procedure SetDateEnd(const Value: TDateTime);
    procedure SetDateStart(const Value: TDateTime);
  public
    { Public declarations }
    property DateStart:TDateTime read fDateStart write SetDateStart;
    property DateEnd:TDateTime read fDateEnd write SetDateEnd;

    procedure SetCustomTitle(const CustomTitle:String);
  end;


implementation

uses DateUtils, SWNUtils;

{$R *.dfm}

procedure TfrmDateFilterDlg.btnOkClick(Sender: TObject);
var y1,m1,m2:word;
begin
     // check Dates
     if rbQuarter.Checked then
     begin
          // Trimestru
          y1:=seQuarterYear.Value;
          m2:=(cmbQuarter.ItemIndex+1)*3;
          if cbQuarterYearStart.Checked then
          begin
               // De la inceputul anului
               fDateStart:=EncodeDate(y1,1,1);
               fDateEnd:=EncodeDate(y1,m2,DaysInAMonth(y1,m2));
          end
          else
          begin
               m1:=(cmbQuarter.ItemIndex*3)+1;
               fDateStart:=EncodeDate(y1,m1,1);
               fDateEnd:=EncodeDate(y1,m2,DaysInAMonth(y1,m2));
          end;
     end
     else
     if rbMonth.Checked then
     begin
          // Luna
          y1:=seMonthYear.Value;
          m1:=cmbMonth.ItemIndex+1;
          if cbMonthQuarterStart.Checked then
          begin
               // De la inceputul trimestrului
               fDateEnd:=EncodeDate(y1,m1,DaysInMonth(fDateStart));
               m2:=m1 div 3;
               if (m1 mod 3)>0 then Inc(m2);
               m2:=(m2-1)*3+1;
               fDateStart:=EncodeDate(y1,m2,1);
          end
          else
          begin
               fDateStart:=EncodeDate(y1,m1,1);
               fDateEnd:=EncodeDate(y1,m1,DaysInMonth(fDateStart));
          end;
     end
     else
     if rbDay.Checked then
     begin
          // Zi
          if cbDayMonthStart.Checked then
          begin
               // De la inceputul lunii
               fDateEnd:=deDateByDay.Date;
               fDateStart:=IncDay(fDateEnd,-DayOfTheMonth(fDateEnd)+1);
          end
          else
          begin
               fDateStart:=deDateByDay.Date;
               fDateEnd:=deDateByDay.Date;
          end;
     end
     else
     if rbDateRange.Checked then
     begin
          // Interval
          fDateStart:=deDateStart.Date;
          fDateEnd:=deDateEnd.Date;
     end;

     ModalResult:=mrOk;
//     if DateFilter or fCustomerFilter or fGoodsFilter or fStockFilter
//      then ModalResult:=mrOk
//      else ShowErrorDlg('Eroare','Pentru filtrarea datelor selectati valorile cautate!');
end;

procedure TfrmDateFilterDlg.cmbQuickDatePropertiesEditValueChanged(Sender: TObject);
var filterObj:TDocumentDateFilterItem;
begin
     if cmbQuickDate.ItemIndex<>-1 then
     begin
          filterObj:=TDocumentDateFilterItem(cmbQuickDate.Properties.Items.Objects[cmbQuickDate.ItemIndex]);
          SetupQuickDateFilter(filterObj.Filter);
     end;
end;

procedure TfrmDateFilterDlg.CreateDateFilter;
var i:TFrameDocumentDateFilter;
    filterObj:TDocumentDateFilterItem;
begin
     cmbQuickDate.Properties.Items.BeginUpdate;
     try
        cmbQuickDate.Properties.Items.Clear;
        for i in cDocumentAllFiltersWithFilter do
        begin
             filterObj:=SWNDocumentFrameDateFilters.GetFilterObject(i);
             cmbQuickDate.Properties.Items.AddObject(filterObj.Title, filterObj);
        end;
     finally
        cmbQuickDate.Properties.Items.EndUpdate;
     end;
end;

procedure TfrmDateFilterDlg.FormCreate(Sender: TObject);
begin
     // init defaults
     fDateStart:=0;
     fDateEnd:=0;

     // setup default view
     CreateDateFilter;
     //cmbQuickDate.ItemIndex:=-1;

     cmbMonth.ItemIndex:=MonthOfTheYear(NOW)-1;

     seQuarterYear.Properties.MinValue:=YearOf(NOW)-1;
     seQuarterYear.Properties.MaxValue:=seQuarterYear.Properties.MinValue+2;

     seMonthYear.Properties.MinValue:=seQuarterYear.Properties.MinValue;
     seMonthYear.Properties.MaxValue:=seQuarterYear.Properties.MaxValue;
end;

procedure TfrmDateFilterDlg.FormShow(Sender: TObject);
begin
     rbQuarterClick(nil);
     SelectDateFilterByDate(fDateStart,fDateEnd);
end;

procedure TfrmDateFilterDlg.rbQuarterClick(Sender: TObject);
var fq:Boolean;
    fm:Boolean;
    fd:Boolean;
    fi:Boolean;
begin
     // disable all
     fq:=False;
     fm:=False;
     fd:=False;
     fi:=False;
     // enable only needed
     if Sender=rbQuarter then  // Trimestru
     begin
          fq:=True;
     end
     else
     if Sender=rbMonth then  // Luna
     begin
          fm:=True;
     end
     else
     if Sender=rbDay then // Zi
     begin
          fd:=True;
          if deDateByDay.Date<=0 then deDateByDay.Date:=NOW;
     end
     else
     if Sender=rbDateRange then // Interval
     begin
          fi:=True;
          if deDateStart.Date<=0 then deDateStart.Date:=NOW;
          if deDateEnd.Date<=0 then deDateEnd.Date:=NOW;
     end;

     // Trimestru
     cmbQuarter.Enabled:=fq;
     seQuarterYear.Enabled:=fq;
     cbQuarterYearStart.Enabled:=fq;
     // Luna
     cmbMonth.Enabled:=fm;
     seMonthYear.Enabled:=fm;
     cbMonthQuarterStart.Enabled:=fm;
     // Zi
     deDateByDay.Enabled:=fd;
     cbDayMonthStart.Enabled:=fd;
     cbDayMonthStart.Enabled:=fd;
     // Interval
     deDateStart.Enabled:=fi;
     deDateEnd.Enabled:=fi;
end;

procedure TfrmDateFilterDlg.SelectDateFilterByDate(const StartDate, EndDate: TDateTime);
var Year,QuarterIndex,MonthIndex:integer;
    Flag_StartingFrom:Boolean;
    selDay,selMonth,selQuarter:Boolean;
begin
     selDay:=False;
     selMonth:=False;
     selQuarter:=False;

     if IsDateRangeDay(StartDate,EndDate,Flag_StartingFrom) then
     begin
          // Zi
          deDateByDay.Date:=EndDate;
          cbDayMonthStart.Checked:=Flag_StartingFrom;
          selDay:=True;
     end;

     if IsDateRangeMonth(StartDate,EndDate,MonthIndex,Year,Flag_StartingFrom) then
     begin
          cmbMonth.ItemIndex:=MonthIndex-1;
          seMonthYear.Value:=Year;
          cbMonthQuarterStart.Checked:=Flag_StartingFrom;
          selMonth:=True;
     end;

     if IsDateRangeQuarter(StartDate,EndDate,QuarterIndex,Year,Flag_StartingFrom) then
     begin
          cmbQuarter.ItemIndex:=QuarterIndex-1;
          seQuarterYear.Value:=Year;
          cbQuarterYearStart.Checked:=Flag_StartingFrom;
          selQuarter:=True;
     end;

     // Interval
     deDateStart.Date:=StartDate;
     deDateEnd.Date:=EndDate;

     // select by priority
     if selQuarter then rbQuarter.Checked:=True // Trimestru
     else
     if selMonth then rbMonth.Checked:=True // Luna
     else
     if selDay then rbDay.Checked:=True // Zi
     else
     rbDateRange.Checked:=True; // Interval
end;

procedure TfrmDateFilterDlg.SetCustomTitle(const CustomTitle: String);
begin
     dtDialogTitle.Title:=dtDialogTitle.Title+' '+CustomTitle;
     Caption:=dtDialogTitle.Title;
end;

procedure TfrmDateFilterDlg.SetDateEnd(const Value: TDateTime);
begin
     fDateEnd:=Value;
end;

procedure TfrmDateFilterDlg.SetDateStart(const Value: TDateTime);
begin
     fDateStart:=Value;
end;

procedure TfrmDateFilterDlg.SetupQuickDateFilter(const filterItem:TFrameDocumentDateFilter);
var d1,d2:TDateTime;
begin
     if GetDocumentFrameFilterDateValues(filterItem,d1,d2) then SelectDateFilterByDate(d1,d2);
end;


end.
