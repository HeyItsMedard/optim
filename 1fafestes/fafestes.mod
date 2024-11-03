set Fazis;                 # Munkafázisok (hántolás, fehér, piros, lakk)
set Dolgozo;               # Dolgozók (Gergő, Medárd, Iza, Kitti, Balázs)

# Paraméterek
param sebesseg{Dolgozo, Fazis};    # Dolgozók sebessége különböző fázisokban (km/h)
param tavolsag{1..10};             # A pontok közötti távolság (km)
param szunet;                      # Szünet időtartama (perc)
param munkaido;                    # Munkaidő egy szakaszban (perc)
param max_tavolsag;                # Dolgozók közötti maximális távolság (km)
param munkaido_ora;                # Teljes munkaidő (órákban)

# Fázis sorrend: minden fázishoz egy sorrendi érték egyszerűség kedvéért
param fazis_sorrend{Fazis};

 # Ha dolgozó adott fázison van adott ponton, akkor 1, egyébként 0
var helyzet{Dolgozo, Fazis, 1..10} binary;  

# Célfüggvény: Maximálni a teljesített szakaszok számát
maximize teljesitett_szakaszok:
    sum{d in Dolgozo, f in Fazis, p in 1..10} helyzet[d, f, p];

# Korlátozások

# 1. Minden dolgozó csak egy fázison dolgozhat adott időben
s.t. egy_fazis_per_dolgozo{d in Dolgozo, t in 1..10}:
    sum{f in Fazis, p in 1..10} helyzet[d, f, p] <= 1;

# 2. Munkafázisok sorrendjének betartása
s.t. fazis_sorrend_betartas{p in 1..10, f1 in Fazis, f2 in Fazis: fazis_sorrend[f1] < fazis_sorrend[f2]}:
    sum{d in Dolgozo} helyzet[d, f2, p] <= sum{d in Dolgozo} helyzet[d, f1, p];

# 3. Dolgozók közötti maximális távolság korlátozása
s.t. tavolsag_korlat{d1 in Dolgozo, d2 in Dolgozo, p1 in 1..10, p2 in 1..10: p1 != p2}:
    if abs(tavolsag[p1] - tavolsag[p2]) > max_tavolsag then 
        sum{f in Fazis} (helyzet[d1, f, p1] + helyzet[d2, f, p2]) <= 1;

# 4. Munkaidő-korlát és szünetidő
s.t. munkaido_korlat{d in Dolgozo}:
    sum{f in Fazis, p in 1..10} helyzet[d, f, p] * munkaido / 60 <= munkaido_ora;

# 5. Minden pont csak egyszer dolgozható fel adott fázison
s.t. pont_egyszer{f in Fazis, p in 1..10}:
    sum{d in Dolgozo} helyzet[d, f, p] <= 1;

#>C:\Users\medav\Downloads\gusek_0-2-24\gusek\glpsol.exe --cover --clique --gomory --mir -m "fafestes.mod" -d "fafestes.dat" -o "fafestes.out" -y "fafestes_output.txt"
end;