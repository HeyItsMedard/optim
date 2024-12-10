set zeneszamok;
set zeneszek;
param hossz_perc{zeneszamok};
param hossz_masodperc{zeneszamok};

param popularitas{zeneszamok};


param nehezseg{zeneszamok,zeneszek} binary;
param max_db :=10;  # pontosan 10 számot kell tartalmaznia
set sorrend:= 1..max_db;
param max_perc:=80;
param minimum_perc:=60;
param szunet:= 0.5;


var zene_lista{zeneszamok,sorrend} binary;
var zene_lista_hossza ;

# egy zenét csak egyszer játszunk le 
s.t. egy_zenet_csak_egyszer{z in zeneszamok}:
sum{s in sorrend}zene_lista[z,s]<=1;

# egyszerre csak egy zenét játszhatnak le
s.t. csak_egy_zene{s in sorrend}:
sum{z in zeneszamok}zene_lista[z,s]<=1;

s.t. hossz:
sum{s in sorrend ,z in zeneszamok}zene_lista[z,s]*(hossz_masodperc[z]/60+hossz_perc[z])+9*szunet=zene_lista_hossza;

# a hossza minimum 60 perc maximum 80 perc kell lennie szünettel együtt

s.t. ne_legyen_tobb_mint_80:
zene_lista_hossza<=max_perc;

s.t. ne_legyen_kevesebb_mint_60:
zene_lista_hossza>=minimum_perc;



s.t. ne_tul_nehez{ sz in zeneszamok, sz2 in zeneszamok, sz3 in zeneszamok,z in zeneszek,s in sorrend:s<=8 }:
zene_lista[sz,s]*nehezseg[sz,z]+zene_lista[sz2,s+1]*nehezseg[sz2,z]+zene_lista[sz3,s+2]*nehezseg[sz3,z]<=2;



maximize Objective:
    sum{sz in zeneszamok,s in sorrend} zene_lista[sz,s]*popularitas[sz];
    
solve;

printf"\n\n";

for {s in sorrend,sz in zeneszamok: zene_lista[sz,s]=1} 
    printf "%d %s\n",s,sz;

end;