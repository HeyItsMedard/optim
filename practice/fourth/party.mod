set Emberek;
set Szamok;

param sorAr;
param M;

param szeret{Emberek, Szamok} binary;
#probléma: nincs sorrend
var jatszik{Szamok} binary;
var tavozott{Emberek, Szamok} binary;
var iszik{Emberek, Szamok} binary;
var hallgat{Emberek, Szamok} binary;

# a söntéspult bevételét maximalizálni szeretnénk
maximize bevetel:
    sum {e in Emberek, s in Szamok: s > 1} sorAr * iszik[e, s];

# Egy szám játszódhat egyszerre
s.t. oneTrack:
    sum{s in Szamok: s > 1} jatszik[s] = 1;

# Egy ember egyszerre csak 1 dolgot csinál
s.t. doOneOnly{e in Emberek, s in Szamok: s > 1}:
    tavozott[e,s] + iszik[e,s] + hallgat[e,s] = 1;

# Amennyiben olyan számot hallanak, amit szeretnek, akkor jókedvűen szórakoznak.
s.t. danceIfHereAndEnjoys{e in Emberek, s in Szamok: s > 1}:
    # ha szereti a zenet, és még nem ment el
    # 0 >= 1- 2*(1- 0 * 1 + 0) = -1 ; 1 >= 1- 2*(1- 1 * 1 + 0) = 1 ok
    hallgat[e,s] >= 1 - 2 * (1 - szeret[e,s] * jatszik[s] + tavozott[e,s-1]);

# Ha jön egy szám, amit nem szeretnek, akkor  a söntéspulthoz mennek, és inkább kikérnek egy kobold sört
s.t. Haelobbtancoltmostiszikfeltvehogynemszereti{e in Emberek, s in Szamok: s > 1}:
    # 0 >= 1- 2*(1- 0 + 0) = -1 ; 1 >= 1- 2*(1- 1 + 0) = 1 ok
    iszik[e,s] >= 1 - 2 * (1 - hallgat[e,s-1] + szeret[e,s] * jatszik[s]);

# Ha ne szereti a zenet, de elobb mar ivott, akkor távozik
s.t. Haelobbivottmostalszikfeltvehogynemszereti{e in Emberek, s in Szamok: s > 1}:
    # 0 >= 1- 2*(1- 0 + 0) = -1 ; 1 >= 1- 2*(1- 1 + 0) = 1 ok
    tavozott[e,s] >= 1 - 2 * (1 - iszik[e,s-1] + szeret[e,s] * jatszik[s]);

# Mindenki csak egyszer távozhat
s.t. Nemkelfel {e in Emberek, s in Szamok: s > 1}:
    tavozott[e,s] >= tavozott[e,s-1];

solve;

for {e in Emberek}
{
    printf "%s:\t%d\n",e,sum{sz in Szamok} iszik[e,sz];
}
printf "\nSUM:\t%d\n",sum{sz in Szamok,e in Emberek} iszik[e,sz];

end;
