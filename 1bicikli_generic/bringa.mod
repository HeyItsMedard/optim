set Feladatok := setof(id in 1..10) "F" & id;
set Orak;

param ora {Feladatok};
param suly {Feladatok};
param ar {Feladatok};

param sulyhatar;

var elvegezve {Feladatok} binary;

# orankent maximum 10 kilo
s.t. max10kilo {i in Orak}:
    sum {f in Feladatok: ora[f] == i} suly[f] * elvegezve[f] <= sulyhatar;

maximize bevetel:
    sum {f in Feladatok, i in Orak} ar[f] * elvegezve[f];

solve;

printf "Feladatok elvegezve:\n";
for {f in Feladatok: elvegezve[f] == 1} {
        printf "Feladat %s elvegezve az oraban: %d\n", f, ora[f];
}

end;

# --checks