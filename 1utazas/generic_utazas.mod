# Paraméterek meghatározása
param totalDistance;  # km - Teljes utazás távolsága (Debrecen)
param fuelConsumption;  # l / 100 km - Üzemanyag fogyasztás
param tankCapacity;  # l - Tank kapacitása
param initialTank;  # l - Kezdeti üzemanyag mennyiség (0 l a kezdeti állapot)
param safetyMeasure;  # km - Biztonsági margó

set Stations;  # Benzinkutak

# Paraméterek
param distance{Stations};  # km (a benzinkutak távolsága)
param fuelPrice{Stations};  # Ft/l (benzinkutak üzemanyag ára)

# Változók: Tankolás mennyisége a benzinkutaknál
var fill{Stations} >= 0;  # Az egyes kutaknál tankolt üzemanyag mennyisége

# Kényszer 1: Az első állomásnál biztosan tankolunk
s.t. First_fill_at_start:
    fill['s'] >= 1e-5;  # Az első állomásnál biztosan tankolunk, de nem nulla
#Context: ...tations } >= 0 ; s.t. First_fill_at_start : fill [ '...' ] > , MathProg model processing error

# Kényszer 2: Elég üzemanyag a következő állomás eléréséhez a biztonsági távolságot figyelembe véve
s.t. Has_to_meet_safety_measure {s in Stations: distance[s] > 0}:
    (initialTank + sum {s2 in Stations: distance[s2] < distance[s]} fill[s2]) * (100 / fuelConsumption) >= distance[s] + safetyMeasure;

# Kényszer 3: A tank nem tölthető túl a kapacitásnál
s.t. Can_not_overfill {s in Stations}:
    initialTank + sum {s2 in Stations: distance[s2] < distance[s]} fill[s2] <= tankCapacity;

# Kényszer 4: Az utazás végén el kell érni a teljes távolságot
s.t. Need_to_reach_final_destination:
    (initialTank + sum {s in Stations} fill[s]) * (100 / fuelConsumption) >= totalDistance;

# Célfüggvény: Az üzemanyagköltség minimalizálása
minimize TotalCost:
    sum {s in Stations} fill[s] * fuelPrice[s];

# Megoldás
solve;

# Eredmények kiírása
printf "Total cost: %g\n\n", TotalCost;

# Benzinkutak állapota és tankolási mennyiségek kiírása
for {s in Stations}
{
    printf "%14s  (%5g km, %3g Ft/l): %5.2g l üzemanyag tankolva\n", s, distance[s], fuelPrice[s],
    fill[s];
}