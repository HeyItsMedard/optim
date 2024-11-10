set Hazak;
set Kutak;

param igeny{Hazak};
param kapacitas{Kutak};
param telepkoltseg{Kutak};
param uzemelkoltseg{Kutak};
param kapcsolatok{Hazak, Kutak} binary;

param buntetoAr;
param M;

# Változók
var telepites{Kutak} binary;
var transzport_per_haz{Hazak, Kutak} >= 0;
var transzport_kut_ossz{Kutak} >= 0;
var y binary; # büntetés igen vagy nem xd

# Célfüggvény
minimize osszkoltseg:
    sum{k in Kutak} telepites[k] * telepkoltseg[k] + sum{k in Kutak} transzport_kut_ossz[k] * uzemelkoltseg[k] * 365 + buntetoAr * y;

# Kényszerek
# Ahol nincsen kapcsolat, állítsuk be a transzportot 0-ra ==/= idk
s.t. nincs_kapcsolat{i in Hazak, k in Kutak}:
    transzport_per_haz[i, k] <= kapcsolatok[i, k] * M;

# Össz transzport kiszámítása
s.t. osszes_transzport_kut{k in Kutak}:
    transzport_kut_ossz[k] = sum{i in Hazak} transzport_per_haz[i, k];

# A transzport_kut_ossz nem lehet nagyobb mint a kapacitas
s.t. kapacitas_kotelesseg{k in Kutak}:
    transzport_kut_ossz[k] <= kapacitas[k];

# A házak a saját kutaikat használják
s.t. sajat_kutat_hasznal{i in Hazak}:
    sum{k in Kutak} transzport_per_haz[i,k] = igeny[i];

# Ha 1 számú és 4 számú kutaknak külön-külön a transzport_kut_ossz nagyobb mint 15, akkor büntetés
s.t. buntetes_1:
    transzport_kut_ossz[1] >= 15 * y;

s.t. buntetes_4:
    transzport_kut_ossz[4] >= 15 * y;

solve;
#>C:\Users\medav\Downloads\gusek_0-2-24\gusek\glpsol.exe --cover --clique --gomory --mir -m "vizmuvek.mod" -d "vizmuvek.dat" -o "vizmuvek.out" -y "vizmuvek.txt"
end;