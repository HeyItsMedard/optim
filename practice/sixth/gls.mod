param maxDeliveryBoxes; # maximum hány átvevőhelyet telepíthetünk az utcában
set DeliveryBoxes := 1..maxDeliveryBoxes;
set PossibleLocations := 1..10;

param possibilities{PossibleLocations}; # hol van lehetőség elhelyezni átvevőhelyet (0-tól számolva, és legfeljebb 100-ig 10 hely)

param nHouses;
set Houses := 1..nHouses;

param M;

param streetLength; # hány méter hosszú az adott utca (100)

param locationOnStreet{Houses}; # hány méternél van az adott ház a kezdőponttól (0-tól és legfeljebb 100-ig)
param personPerHouse{Houses}; # lakásonként hány ember él

# Végeredmény változók
var deliveryBoxLocation{DeliveryBoxes}, >=0, <=streetLength, integer; # hol van az adott átvevőhely
var distanceToDeliveryBox{Houses,DeliveryBoxes}, >=0, integer; # milyen messze van az adott ház az adott átvevőhelytől
var chosenPossibleLocation{DeliveryBoxes,PossibleLocations}, binary; # az adott átvevőhelyet az adott lehetséges helyre telepítjük-e
var chosenDeliveryPoint{Houses,DeliveryBoxes}, binary; # az adott házhoz az adott átvevőhelyet rendeljük-e
var sumAllPeople{Houses}, >=0, integer; # az adott házban élők által megtett távolság az adott átvevőhelyig

# Célunk, hogy az utca lakosainak körében az átvételhez szükséges átlagos sétálási távolságot minimalizáljuk.
minimize Objective:
    # Összesített távolság a házakban élő emberek számával súlyozva
    sum{h in Houses, db in DeliveryBoxes} distanceToDeliveryBox[h, db] * personPerHouse[h];

# Korlátok

# Lerakni csak lehetséges helyre tehetünk
s.t. LocationAssignment{db in DeliveryBoxes}:
    deliveryBoxLocation[db] = sum{pl in PossibleLocations} possibilities[pl] * chosenPossibleLocation[db, pl];

# Egy átvevőhelyet csak egy helyre tehetünk
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

s.t. PeopleCountCalculation{h in Houses}:
    sumAllPeople[h] = sum{ho in Houses} personPerHouse[ho];

solve;

# Melyik átvevőhelyet hova telepítjük
for {db in DeliveryBoxes} {
    for {pl in PossibleLocations: chosenPossibleLocation[db, pl] == 1} {
            printf "Az %d. átvevőhelyet a(z) %d. lehetséges helyre telepítjük.\n", db, pl;
    }
}
# Print átlag
printf "Az átlagos sétálási távolság: %f\n", sum{h in Houses, db in DeliveryBoxes} distanceToDeliveryBox[h, db] / sumAllPeople[h];

# Print távolság házak és legközelebbi átvevőhelyek között
for {h in Houses} {
    for {db in DeliveryBoxes: chosenDeliveryPoint[h, db] == 1} {
        printf "A(z) %d. házhoz %d. átvevőhely tartozik:\n", h, db;
        printf "A távolság: %d\n", distanceToDeliveryBox[h, db];
    }
}