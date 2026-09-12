unit geScale;

interface
uses Forms, Controls, vcl.Graphics;

procedure geAutoScale(MForm: TForm);

implementation
type
  TFooClass = class(TControl); { trebuie stabilit gradul de protectie }

  { proprietatile Font }

procedure geAutoScale(MForm: TForm);
const

  cScreenWidth: integer = 800;
  cScreenHeight: integer = 600;
  cPixelsPerInch: integer = 96;
  cFontHeight: integer = -11; {In modul de proiectare valoarea din Font.Height}

var

  i: integer;

begin

  {
  IMPORTANT!! : Setati in Object Inspector proprietatea Scaled a TForm pe FALSE.

  Urmatorul cod scaleaza forma astfel incat aceasta sa arate identic
  indiferent de dimensiunea ecranului si de pixelii per inch. Codul de mai jos
  verifica daca dimensiunea ecranului in timpul executiei difera
  de dimensiunea din timpul proiectarii. Daca da, Scaled este setat pe True
  si componentele sunt scalate din nou astfel incat sa fie afisate in aceeasi
  pozitie a ecranului ca si in timpul proiectarii.
  }
  if (Screen.width  > cScreenWidth) or (Screen.PixelsPerInch <>
    cPixelsPerInch) then
  begin
    MForm.scaled := TRUE;
    MForm.height := MForm.height * screen.Height div cScreenHeight;
    MForm.width := MForm.width * screen.width div cScreenWidth;
    MForm.ScaleBy(screen.width, cScreenWidth);

  end;

  {
  Acest cod verifica daca dimensiunea fontului in timpul executiei difera de
  dimensiunea din timpul proiectarii. Daca in timpul executiei pixelsperinch
  al formei difera de pixelsperinch din timpul proiectarii, fonturile sunt din nou
  scalate astfel incat forma sa nu difere de cea care a fost in
  timpul dezvoltarii. Scalarea se realizeaza pe baza unui coeficient,
  obtinut prin impartirea valorii font.height din timpul proiectarii
  la font.height din timpul executiei. Font.size in acest caz nu va
  functiona, deoarece aceasta poate da un rezultat mai mare decat dimensiunile curente
  ale componentelor, iar textul poate ajunge in afara limitelor zonei componentei.
  De exemplu, forma a fost creata la dimensiunea ecranului 800x600 cu
  fonturi mici setate, avand dimensiunea font.size = 8. Cand rulati
  pe un sistem cu 800x600 si fonturi mari, font.size va fi de asemenea 8,
  dar textul va fi mai mare decat la lucrul pe un sistem cu fonturi mici.
  Aceasta scalare permite pastrarea aceleiasi dimensiuni a fonturilor
  la diferite setari ale sistemului.
  }

  if (Screen.PixelsPerInch <> cPixelsPerInch) then
  begin

    for i := MForm.ControlCount - 1 downto 0 do
      TFooClass(MForm.Controls[i]).Font.Height :=
        (MForm.Font.Height div cFontHeight) *
        TFooClass(MForm.Controls[i]).Font.Height;

  end;

end;

end.
