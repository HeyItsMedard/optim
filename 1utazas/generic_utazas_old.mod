# Paraméterek
set Benzinkutak;  # Benzinkutak halmaza

param AutoKapacitas := 40;  # Autó tankkapacitása (liter)
param AutoFogyasztas := 0.065;  # Fogyasztás (liter/km), pl. 6.5 liter/100 km
param VarosTavolsag := 442;  # Távolság Sopron és Debrecen között (km)
param BenzinArak{Benzinkutak};  # Benzinkutak üzemanyag árai
param KutTavolsag{Benzinkutak};  # Benzinkutak távolsága Soprontól

# Új változó: bináris változó, amely eldönti, hogy tankolni kell-e a benzinkútnál
var tankolni{Benzinkutak} binary;  # Ha tankolni kell, akkor tankolni[k] = 1, különben 0

# Az autó tankja és az üzemanyag mennyisége minden benzinkútnál
var tank{Benzinkutak} >= 0, <= AutoKapacitas;  # Tank állapot minden benzinkútnál
var fuel{Benzinkutak} >= 0, <= AutoKapacitas;  # Tankolt üzemanyag mennyisége

# Célfüggvény: minimalizáljuk az összes tankolás költségét
minimize TotalCost:
    sum{k in Benzinkutak} BenzinArak[k] * fuel[k];

# Korlátozások

# Kiszámoljuk a szükséges üzemanyag mennyiséget a következő benzinkút eléréséhez
# Ha a tankban lévő üzemanyag nem elég, akkor tankolni kell
s.t. FuelBalance{k in Benzinkutak: k != 's'}:
    tank[k] - AutoFogyasztas * (KutTavolsag[k] - KutTavolsag['s']) >= 0;

# Korlátozás: a következő benzinkútnál tankolt üzemanyagot is figyelembe kell venni
s.t. FuelTankolasiKotes{k in Benzinkutak}:
    tank[k] = tank['s'] + fuel[k] - AutoFogyasztas * (KutTavolsag[k] - KutTavolsag['s']);

# Ha nincs elég üzemanyag, akkor tankolni kell, és a tankolás mennyisége legyen megfelelő
# Ehhez egy külön feltételt adunk meg
s.t. SzükségesTankolás{k in Benzinkutak: k != 's'}:
    fuel[k] >= AutoFogyasztas * (KutTavolsag[k] - KutTavolsag['s']) - tank['s'] + (1 - tankolni[k]) * AutoKapacitas;

# Ha tankolni kell, akkor tankolás mennyisége legyen nagyobb, mint nulla, és ne haladja meg a tank kapacitását
s.t. TankolasiSzabaly{k in Benzinkutak}:
    fuel[k] <= AutoKapacitas * tankolni[k];

# Ha nem tankolunk, akkor a tankolás mennyisége nulla kell, hogy legyen
s.t. NoTankolvaHaNincsSzukseg{k in Benzinkutak}:
    fuel[k] >= 0 * (1 - tankolni[k]);

# A tank maximális kapacitása nem léphető túl
s.t. MaxTank:
    tank['s'] <= AutoKapacitas;

# Az üzemanyag mennyisége nem lehet negatív
s.t. NoNegativeFuel{k in Benzinkutak}:
    fuel[k] >= 0;

# Kiszámítjuk a költséget minden tankolás alapján
solve;

# Eredmények kiírása
printf "Total cost of the journey: %.2f Ft\n", TotalCost;

# Kiírjuk, hogy hány liter üzemanyagot tankoltunk és annak költségét
for {k in Benzinkutak} {
    printf "At station %s (%.0f km), fuel cost: %.2f Ft, fuel amount: %.2f liters, tank level after refueling: %.2f liters\n",
    k, KutTavolsag[k], BenzinArak[k] * fuel[k], fuel[k], tank[k];
}

end;
