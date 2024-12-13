param maxDeliveryBoxes; # maximum hány átvevőhelyet telepíthetünk az utcábans
set DeliveryBoxes := 1..maxDeliveryBoxes;
set PossibleLocations := 1..10;

param possibilities{PossibleLocations}; # hol van lehetőség elhelyezni átvevőhelyet (0-tól számolva, és legfeljebb 100-ig 10 hely)

param nHouses;
set Houses := 1..nHouses;

param M;

param streetLength; # hány méter hosszú az adott utca (100)

param locationOnStreet{Houses}; # hány méternék van az adott ház a kezdőponttól (0-tól és legfeljebb 100-ig)
param personPerHouse{Houses}; # lakásonként hány ember él
# Feltetelezheto, hogy minden lakos nagyjabol ugyanakkora intenzitassal rendel valamit maganak valamilyen webshopbol, amiert aztan a mi valamelyik atveteli pontunkba kell.

# Célunk, hogy az utca lakosainak körében az átvételhez szükséges átlagos sétálási távolságot minimalizáljuk.

var deliveryBoxLocation{DeliveryBoxes}, >=0, <=streetLength, integer; # hol van az adott átvevőhely
var distanceToDeliveryBox{Houses,DeliveryBoxes}, >=0, integer; # milyen messze van az adott ház az adott átvevőhelytől
var chosenPossibleLocation{DeliveryBoxes,PossibleLocations}, binary; # az adott átvevőhelyet az adott lehetséges helyre telepítjük-e
var chosenDeliveryPoint{Houses,DeliveryBoxes}, binary; # az adott házhoz az adott átvevőhelyet rendeljük-e
var personDistances{Houses,DeliveryBoxes}, >=0, integer; # az adott házban élők által megtett távolság az adott átvevőhelyig

# Minimalizálás: az átlagos sétálási távolság
minimize Objective:
    sum{h in Houses, db in DeliveryBoxes} personDistances[h, db] / personPerHouse[h] / nHouses;

# Korlátok

# Lerakni csak lehetséges helyre tehetünk
s.t. LocationAssignment{db in DeliveryBoxes}:
    deliveryBoxLocation[db] = sum{pl in PossibleLocations} possibilities[pl] * chosenPossibleLocation[db, pl];

# Egy átvevőhelyet csak egy helyre tehetünk (bár ez nem volt megadva, hogy muszáj)
s.t. SingleLocationPerBox{db in DeliveryBoxes}:
    sum{pl in PossibleLocations} chosenPossibleLocation[db, pl] = 1;

# Minden házhoz csak egy átvevőhely tartozhat
s.t. OneDeliveryPointPerHouse {h in Houses}:
    sum {db in DeliveryBoxes} chosenDeliveryPoint[h, db] = 1;

# Egy lehetséges helyre csak egy átvevőhelyet telepíthetünk
s.t. OneBoxPerLocation {pl in PossibleLocations}:
    sum {db in DeliveryBoxes} chosenPossibleLocation[db, pl] <= 1;

# Kiszámítjuk a távolságokat
# Távolság kiszámítása lineárisan
s.t. DistanceCalculation1{h in Houses, db in DeliveryBoxes: h > 0}:
    distanceToDeliveryBox[h, db] >= locationOnStreet[h] - deliveryBoxLocation[db];

s.t. DistanceCalculation2{h in Houses, db in DeliveryBoxes: h > 0}:
    distanceToDeliveryBox[h, db] >= deliveryBoxLocation[db] - locationOnStreet[h];

# A házhoz a legközelebbi átvevőhelyet kell választani
s.t. NearestDeliveryPoint {h in Houses}:
    sum {db in DeliveryBoxes} distanceToDeliveryBox[h, db] <= sum {db in DeliveryBoxes, db2 in DeliveryBoxes: db2 != db} distanceToDeliveryBox[h, db2];

s.t. PersonDistancesCalculation{h in Houses, db in DeliveryBoxes}:
    personDistances[h, db] = distanceToDeliveryBox[h, db] * personPerHouse[h];

solve;

# Melyik átvevőhelyet hova telepítjük
for {db in DeliveryBoxes} {
    for {pl in PossibleLocations: chosenPossibleLocation[db, pl] == 1} {
            printf "Az %d. átvevőhelyet a(z) %d. lehetséges helyre telepítjük.\n", db, pl;
    }
}

# Az 1. átvevőhelyet a(z) 4. lehetséges helyre telepítjük.
# Az 2. átvevőhelyet a(z) 7. lehetséges helyre telepítjük.
# Az 3. átvevőhelyet a(z) 6. lehetséges helyre telepítjük.
# Az 4. átvevőhelyet a(z) 5. lehetséges helyre telepítjük.

# Majdnem jó, de nem veszi figyelembe, hogy hol mennyien laknak és azok mennyi távolságot tesznek meg.