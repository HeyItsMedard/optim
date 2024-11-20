set Feladatok;
set Orak;

param ora {Feladatok};
param suly {Feladatok};
param ar {Feladatok};

param sulyhatar;

# var elvegezve {Feladatok} binary; mivel így elvégzünk mindent
var extra_tarthely binary;

param M;

# orankent maximum 10 kilo
s.t. extra_space_logic:
    sum {f in Feladatok} suly[f] >= sulyhatar - M * (1 - extra_tarthely);

maximize bevetel:
    sum {f in Feladatok, i in Orak} ar[f] - 500 * extra_tarthely;

solve;

printf "Feladatok elvegezve:\n";
for {f in Feladatok: elvegezve[f] == 1} {
        printf "Feladat %s elvegezve az oraban: %d\n", f, ora[f];
}

end;

# --checks