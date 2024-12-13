param nTeachers;
set Teachers := 1..nTeachers;

param nClasses; # az órák száma. 1-2. óra számít első napnak, 3-5. óra számít második napnak, 6-7. óra számít harmadik napnak
set Classes := 1..nClasses;

set Groups;

param teachersPerGroup{Teachers,Groups};
param M := 100;

param startClass{Classes};
param endClass{Classes};

# Döntési változó: Egy tanár egy adott időpontban egy adott órát egy adott csoportnak tart
var sessionAssignment{Teachers, Classes, Groups}, binary;
# Végeredmény változók: kezdés és végzés
var startTime{Teachers}, >=0;
var endTime{Teachers}, >=0;

# Erre minimalizálunk: Minden oktatóra nézzük meg, hány órát volt a táborban és minimalizáljuk a táborban töltött órát
# Például, ha 1-es oktató 2. és 6. órában tart órát, akkor a 2. óra, 6. óra és az aközött eltelt idő 

# Célfüggvény: minimalizáljuk az összes tanár által a táborban töltött időt
minimize TotalTime:
    sum{t in Teachers} (endTime[t] - startTime[t]);

# Egy tanár egy adott időpontban egy órát tarthat és egy csoport nem lehet több órán egyszerre
s.t. SingleSessionPerTeacher{t in Teachers, c in Classes}:
    sum{g in Groups} sessionAssignment[t,c,g] <= 1;

s.t. SingleSessionPerGroup{c in Classes, g in Groups}:
    sum{t in Teachers} sessionAssignment[t,c,g] = 1;

# Kezdési időpontnak az első foglalkozás kell lennie
s.t. StartClassForTeacher{t in Teachers, c in Classes, g in Groups}:
    # pl 2.0 = megkeresett első óra class alapján ami ki lett osztva, különben akármennyi
    startTime[t] <= startClass[c] + M * (1 - sessionAssignment[t,c,g]);

# Végzési időpontnak az utolsó foglalkozás kell lennie
s.t. EndClassForTeacher{t in Teachers, c in Classes, g in Groups}:
    # pl 14.0 = megkeresett utolsó óra class alapján ami ki lett osztva, különben akármennyi
    endTime[t] >= endClass[c] - M * (1 - sessionAssignment[t,c,g]);

solve;

# Kiírjuk az órarendet
for {t in Teachers} {
    printf "Tanár %d: %d-%d\n", t, startTime[t], endTime[t];
    for {c in Classes, g in Groups: sessionAssignment[t,c,g] == 1} {
        printf "  %d. óra, %s csoport\n", c, g;
    }
}
