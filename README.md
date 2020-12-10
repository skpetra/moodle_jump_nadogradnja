# Multimedijski sustavi
## MOODLE JUMP

Nadogradnja igrice Moodle jump, završnog projekta kolegija Multimedijski sustavi iz 2019./2020. godine. Projekt možete naći na sljedećem [linku](https://github.com/tomarga/moodle-jump).
Pozabavila sam se dodavanjem novog ekrana s uputama za igru, poboljšanjem dizajna većine ekrana, 
te dodavanjem novih funkcionalnosti u igricu.

Na svim ekranima promjenjen je font slova u novoizrađeni font _BerlinSansFB_.


- **Početni ekran**

  - Umjesto _moodle_ natpisa dodala sam pravi logo _moodlea_.
  - Kako bi početni ekran bio sličniji pravoj igrici na njega sam dodala _moodlera_ koji skače.
  - Uz dosadašnje odlaske na listu najboljih rezultata ili započinjanje nove igre dodala sam mogućnost odabira opcija igre.
  - Također sam dodala kratica kojom, uz klik miša na START, možemo započeti novu igru pritiskom na tipku ENTER .

- **START** **ekran**

  - Uočila sam kako su plave platforme korištene kao propadajuće, na kojima _moodler_ gubi život, dok su crvene pomične platforme na koje _moodler_ može stati. Iz tog razloga odlučila sam se zamijeniti boje platformi. To sam radila pomoću GIMPa.
  - Dodala sam novu funkcionalnost pauziranja igre klikom na znak || u gornjem desnom kutu. Za tu funkcionalnost dodala sam i kraticu &#39;p&#39;.

- **PAUSE ekran – novi ekran**

  - Nakon pauziranja korisnik može normalno nastaviti igru klikom na RESUME gumb ili se vratiti na početni zaslon klikom na BACK gumb.
  - BACK nas vraća na početni zaslon te se dosadašnji rezultat ne sprema. Time dobivamo novu mogućnost povratka na glavni izbornik iz igrice koju smo do sada imali samo nakon gubitka života.

- **HIGHSCORES** **ekran**

  - Uz gore spomenuti font, izmijenila sam redoslijed prikazivanja objekata na ekranu i smanjila veličinu gumba za povratak na početni zaslon.

- **OPTIONS** **ekran – novi ekran**

  - Upute za igranje s početnog zaslona prebacila sam na ovaj ekran.
  - Dodala sam novu mogućnost isključivanja odnosno uključivanja zvuka igrice.
  - Ekran sadrži gumb za povratak na početni zaslon.

- **GAME OVER** **ekran**

  - Uz dosadašnje funkcionalnosti dodan je prikaz _highscorea_ igrača ukoliko trenutno postignuti rezultat nije najbolji.
  - Dodala sam tipku ENTER kao kraticu za klik gumb RESTART.

Opisane dorade u kodu su značile:

- Dodavanje novih globalnih varijabli _OPTIONS_ i _PAUSE_ koje predstavljaju još 2 moguća _statea._
- Uvođenje nove varijable _audio_ koja kontrolira je li korisnik isključio odnosno uključio glazbu.
- Izradu i učitavanje novog fonta slova.
- Dodavanje dva nova _casea_ u funkciji _draw()_ glavnog programa _moodle\_jump,_ te velik broj izmjena dosadašnjih _caseova_ funkcije (izgled i funkcionalnosti ekrana)_._
- Na svim mjestima u kodu gdje se koristi glazba dodan je slučaj da je korisnik isključio zvuk aplikacije (_player\_class_ i _moodle\_jump_).
- Dodavanje promjene stanja funkciji _mousePressed()_ ukoliko je korisnik pauzirao igricu.
- Dodavanje nove funkcije _keyPressed()_ koja omogućava pauziranje igre na tipku &#39;p&#39;.

Na kraju sam upotpunila dokumentaciju s novouvedenim funkcionalnostima, te ažurirala slike s novim izgledom aplikacije.

**Sljedeća poboljšanja**

Da je vrijeme dopuštalo, moji sljedeći koraci u poboljšanju bili bi:

- dodavanje novih zvukova na supermoći i ispaljivanje metaka
- proširivanje OPTIONS ekrana novom funkcionalnošću reguliranja glasnoće zvuka
- dodavanje mogućnosti odabira razine igre na navedeni ekran

Također, uz sve navedene mogućnosti poboljšanja koja su predložili autori u dokumentaciji, na krajnje rješenje u igru bi se mogla uvesti i mogućnost igranja 2 igrača.
