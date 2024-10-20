Vizsgák, tárgyak, idő kiosztása
Ezt a vizsgát ekkor meg ekkor
Mennyi óra hogy hányas legyen
Bemenet egy naptár napokkal, szabadidőkkel (melyik nap hány óra van rá)
dec 10. szerda
AB P2
Másik bemenet a tárgyakról és hogy mennyi kell az elvárt jegy eléréshez
Tárgyakhoz van kredit is
Cél: minél több tárgy legyen meg (vagy akár hogy a lehető legjobb legyen)

Legyen 11 nap az időszak
Devops, DB, P2
Melyik nap van (0.-10. nap) most hétfőtől jövő péntekig
DB: 3.
P2: 7.
DO: 9.
Óra szükséges
DB: 20
P2: 15
DO: 35
Szabadidő:
0: 2
1: 4
2: 3
!3: 2
4: 0
<!-- 5: 10
6: 5 --> Prog2
!7: 4
8: 4
!9: 6
10: 20

DB DO bukta
Egy adott tárgyra egy adott napon mennyit tanulok = Sd,t >=0 -> var study{Day, Topic} >=0
Bonyolítás: felejtés százalék veszteséggel (ha 6 napja tanultam, akkor 20% vesztettem)

y változó: adott tárgyból átmegyek vagy sem (topic alsó index, bináris)
var done{Topic} binary;

Változók ✔

Constraintek 😲

Meg kéne nézni, hogy az idő belefér e a napba
S0P2+S0DB+S0DO <= 2 f0 ...
szum(sd,t) <= fd t eleme T
days, topics

Amiből átmegyünk, abból kell is tanulni annyit
Prog: S0P+S1P+S2P...+S6P >= 15 (avagy hány napunk van a vizsgáig és hány óra kell hozzá)
g BETŰ: Aktuális nap, amikor van a vizsga
szum(si,p) >= gammap megy 0-tól gp-1-ig
Viszont így minden tárgyat meg kéne csinálni, ami non feasible lenne...
Írjunk be egy 0-t időre?
Lineáris tagokat is csinálhatunk, az y döntő változó
szóval 15*yp (0 vagy 1)

Célfv. szumma yt maximalizálás (tehát teljesített tárgy)

param nDays = 10
set Days := 0...nDays;

param examday {Topics} in Days;

Máté új feladata:

- minden tárgyhoz van kreditérték és maximalizálni szeretnénk a kreditet ✔

- minden tárgyhoz tartozik a vizsga hossza, így az elvesz a teljes tanulási időből 🆗

Új kitalált constraint:

- egy nappal a vizsga előtt a stressz miatt nem figyelünk, doomscrollolunk. nerfeljük ezt a napot.