set Feladatok;
set Orak;

param ora {Feladatok};
param suly {Feladatok};
param ar {Feladatok};

param sulyhatar;

var elvegezve {Orak, Feladatok} binary;

# orankent maximum 10 kilo
s.t. max10kilo {i in Orak}:
    sum {f in Feladatok} suly[f] * elvegezve[i, f] <= sulyhatar;

# minden feladatot maximum egyszer lehet elvegezni ( maradjon? )
s.t. feladat_max1szer {f in Feladatok}:
    sum {i in Orak} elvegezve[i, f] <= 1;

# az adott feladatot csak az adott oraban lehet elvegezni
s.t. elvegzes_oraban {f in Feladatok}:
    sum {i in Orak: i <> ora[f] } elvegezve[i, f] = 0; 

maximize bevetel:
    sum {f in Feladatok, i in Orak} ar[f] * elvegezve[i, f];

solve;

printf "Feladatok elvegezve:\n";
for {i in Orak, f in Feladatok: elvegezve[i, f] == 1} {
        printf "Feladat %s elvegezve az oraban: %d\n", f, i;
}

end;