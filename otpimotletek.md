# 1. Pokémon GO Meetup szervezés

Szilveszter és Medárd nagykövetek meetupokat szeretnének szervezni egy bizonytalan mennyiségű játékosnak (hétfőn 3, kedden általában 5, szerdán 10, hétvégén 20-25 ember is összejöhet, főleg ha az az esemény Gigantamax).
Mindkettejüknek vannak teendőik is, ezért nem garancia, hogy minden meetup megtartható. Amely meetupot legalább egy ambassador megtart, az rewardos lesz.
Szilveszter piros betűs napokon és hétvégéken tud kint lenni, hétközben dolgozik.
Medárd hétközben legtöbbször ráér, kivétel hétfőt, mivel sokáig tart az órája egyetemen. Hétvégén ha két meetup van mindkét napra, akkor abból az egyiken garantált, hogy nem vesz részt. Általában a legtöbben az eventek első napjára jönnek el.
Hetente egy nagykövet nem fog vállalni 3-nál több meetupot, de legalább egyet biztosan. Ez azt is jelentheti, hogy Medárd és Szilveszter találkoznak egy hétvégi meetupon (ahol nincs mindkét hétvégi napon meetup, pl. csak szombaton van).
Van egy bizonyos adat arról, hány játékos jelezte, hogy jönni fog meetupokra (ez randomizálható is, valamiféle paraméterek szerint, lásd fennebb). A meetupok mind valódiak lennének.
Több dologra maximalizálhatunk:
    - minél több meetupon legalább egy ambassador legyen jelen
    - maximalizálhatunk kiosztott virtuális rewardok számát -> vajon elér a közösség egy magasabb osztályt?
        - itt a random adatok mellett érdemes adni egy ceiling számlálást is, ahhoz mérni a többi értékeket
            - random helyett inkább valószínűség szerint akár, ha nem bonyolult (vagyis hogy mennyire valószínű, hogy egy meetupon x ember megjelenik), bár ha 100-100 esetre vizsgálunk, inkább maradjon a random
        - feltételek az osztályokhoz:
            - negyedéves számlálás
            - intervallumok:
                - Origin: 0-60
                - Great: 61-249
                - Ultra: 250-749
                - Master: 750-1499
                - Legendary: 1499-...
            - eszerint kapunk egy bizonyos mennyiségű szétosztható nyereményt (fizikai)
        - írjuk ki a megtartott meetupokat, azokhoz a játékosok mennyiségét, a végén azzal, hogy hány checkint szereztek, melyik osztályba kerülnek.
    - a kommunikáció fontos az ambassadorok között, ezért maximalizáljuk azt, hogy a lehető legtöbbet találkozzanak és öltetelgessenek. Írjuk ki azokat a meetupokat, ahol találkoznak.
    
# 2. Pokémon TCG Elite Trainer Box

Medárd vett magának egy Astral Radiance Elite Trainer Boxot Karácsonyra, szeretne belekezdeni kártyagyűjtögetésbe és deck buildelésbe.
Eredetileg 8 csomag található egy dobozban.
Egy csomagban 10 kártya van. Mindegyik kártya valószínűséggel lehet bent a csomagokban.
10 kártya összetétele:
- Legalább egy Rare vagy jobb kártya garantált: Ez lehet egy sima Rare, egy Holo Rare, vagy valamilyen magasabb ritkaságú kártya (pl. Ultra Rare, Full Art, Rainbow Rare stb.).
- Reverse Holo: Minden booster tartalmaz egy Reverse Holo kártyát (bármilyen ritkasági szinten lehet, akár egy Common, akár Rare is).
- Energia kártya: Általában egy alap Energia kártyát kapsz.
- Egy kódkártya az online TCG játékhoz.
- Többi kártya normál (base-stage1-stage2 pokémon, item, stadium, trainer vagy supporter)
(Eredetileg nem)
A valószínűsége egyes kártyáknak lehet randomizálható egyszerűség kedvéért, de bizonyos paraméterekkel. Minden kártyának van piaci ára (eBay).
Az ETB ára 17 ezer forint (kb. 44 USD) volt. Célunk, hogy kiderítsük, hogy megéri e csak a csomagokért megvenni az ETB-t, vagy inkább külön boostert érdemes venni.
Maximalizáljuk az értékét (egy chase kártyát például (kívánt kártya 20-150 dollár között) ki tudjuk nyitni akárhányszor), mi lenne a legnagyobb összege "maximum" szerencsével.
Majd csináljunk úgy, mintha 100-1000x kinyitnánk egy ETB-t. Mindegyik összegét számítsuk ki, mérjük a bolti árhoz és maximum értékhez.
+ Bónusz: félretett Medárd mégegy booster csomagot az Astral Radiance-ből és azt is Karácsonykor kinyitja. Megmentené-e az ETB árát mégegy booster? Egyáltalán van e szükség rá?
+ Bónusz: a valódi nyitás Karácsonykor fog megtörténni, akkor meglesznek konkrétan, hogy miket nyitott. Mérjük össze az összes lehetőséggel, hogy mennyire volt jó nyitás.