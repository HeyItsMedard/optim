A GUSEK (GNU Linear Programming Kit Solver Kit) a GLPK (GNU Linear Programming Kit) grafikus felülete, amely a GMPL-t (GNU Math Programming Language) használja a matematikai modellek megfogalmazására. A GMPL egy deklaratív programozási nyelv lineáris és vegyes egészértékű programozási problémák modellezésére, és olyan elemeket és függvényeket tartalmaz, amelyek lehetővé teszik a modellek paramétereinek, változóinak és célfüggvényeinek meghatározását, valamint a feltételek megadását.

Az alábbiakban egy összeállítást találsz a GMPL szintaxisának fő elemeiről és függvényeiről:

### 1. **Set-ek (Halmazok)**
A GMPL-ben halmazok definiálásával lehet csoportosítani a modellek különböző elemeit, például termékek, gépek, időszakok.

```glpk
set I;          # Általános halmaz I megadása
set J, dimen 2; # Kétdimenziós halmaz J megadása
```

**Tartományt is adhatunk meg egy halmaznak**:
```glpk
set K := {1..10}; # K halmaz, elemei 1-től 10-ig
```

### 2. **Paraméterek**
A paraméterek lehetnek konstans értékek, vagy indexált értékek, amelyek egy halmaztól függenek.

```glpk
param a;              # Egy egyszerű paraméter
param b{i in I};      # Egy halmaz által indexált paraméter
param c{(i,j) in J};  # Kétdimenziós paraméter
```

**Értékadás paramétereknek**:
```glpk
param d := 5;                # d értéke 5
param e{i in I} := i*2;      # Minden i esetén e értéke i*2
param f{(i,j) in J} := i+j;  # Minden (i,j) esetén f értéke i+j
```

### 3. **Változók**
A változók meghatározása során megadhatjuk azok típusát (pl. folytonos vagy egészértékű) és tartományát.

```glpk
var x >= 0;                    # Nemnegatív folytonos változó
var y{i in I} >= 0, <= 10;     # Változók, amelyek 0 és 10 közöttiek
var z, binary;                 # Bináris változó (0 vagy 1)
var w, integer, >= 0, <= 100;  # Egészértékű változó
```

### 4. **Célfüggvény**
A célfüggvény (objective function) megadja, hogy mit optimalizálunk (minimalizálni vagy maximalizálni szeretnénk).

```glpk
minimize Total_Cost: sum{i in I} c[i] * x[i];  # Költség minimalizálása
maximize Profit: sum{(i,j) in J} p[i,j] * y[i,j]; # Profit maximalizálása
```

### 5. **Korlátozások (Constraints)**
A korlátozások egyenletek vagy egyenlőtlenségek, amelyekkel meghatározhatjuk a megoldáshoz szükséges feltételeket.

```glpk
s.t. Capacity{i in I}: sum{j in J} a[i,j] * x[j] <= b[i];  # Kapacitás korlát
s.t. Demand{j in J}: sum{i in I} d[i,j] * x[i] >= r[j];    # Kereslet korlát
```
### 6. **Kiiratás**

```glpk
param OverallChocolates := sum{s in Students, t in Tantargyak} MilkacsokiAr[s, t] * x[s, t];
display OverallChocolates;
# vagy egy másik, szebb módszer
printf "Subjects assigned to each student:\n";
for {s in Students} {
    printf "%s: ", s;
    for {t in Tantargyak: x[s, t] = 1} {
        printf "%s ", t;
    }
    printf "\n";
}
```

### 7. **Adatok Betöltése és Kiíratása**
Az adatokat külső fájlokból lehet betölteni, vagy fájlba lehet kiírni. Például `.dat` fájlokat használnak a paraméterek értékeinek definiálására.

```glpk
data;  # Adatok betöltése
param a := 10;
param b := [1, 2, 3];
end;
```

Adatok mentése fájlba:
```glpk
display x > "output.txt"; # x változó értékeinek kiíratása fájlba
```  

Vagy ahogy én csinálom:
```bash
>C:\Users\medav\Downloads\gusek_0-2-24\gusek\glpsol.exe --cover --clique --gomory --mir -m "name.mod" -d "name.dat" -o "name.out" -y "name.txt"
```  

### 8. **Conditional (Feltételes) Értékadás**
~~GMPL-ben az `if` kifejezést használhatjuk a feltételes értékadáshoz.~~  
Nem, mert big M konstanst adunk meg.    
```glpk
M * yi > xi
```
where M is a large constant (greater than any value of xi).  

This way:  

if xi > 0, then the constraint is equivalent to yi > 0, that is yi == 1 since yi is binary (if M is large enough).  
if xi == 0, then the constraint is always verified, and yi will be equal to 0 since your objective is increasing with yi and you are minimizing.
in both case, the constraint is equivalent to the "if" test.  

### 9. **Kommentek**
A kommenteket a `#` jellel lehet megadni. Ezeket a fordító figyelmen kívül hagyja.

```glpk
# Ez egy komment, amit a fordító nem dolgoz fel
```

### Példa Modell

Íme egy egyszerű modell a GMPL nyelven, amely bemutatja a fenti elemeket egy összeállításban:

```glpk
set Products;
param Cost{Products} >= 0;
param Profit{Products} >= 0;
param MaxDemand{Products} >= 0;

var x{p in Products} >= 0, integer;

maximize Total_Profit:
    sum{p in Products} Profit[p] * x[p];

s.t. Cost_Constraint:
    sum{p in Products} Cost[p] * x[p] <= 1000;

s.t. Demand_Constraint{p in Products}:
    x[p] <= MaxDemand[p];

solve;

display x;
```

## Set Default

![Set Default](default.png)

## Symbolic

set Cities; # strings
param lastCity symbolic in Cities;

## Transpose

A rookie mistake is to define a 2 dimensional parameter, and mix up its indices. That usually results in "out of domain" error messages. Replacing p[b,t] with p[t,b] everywhere where it was wrongly used in the constraints is a bit tiresome, but can be done swiftly.

A more serious headache will come around if we gave the values in the data section the other way around. That is especially true for huge tables. A small example:

    set A;
    set B;
    param p{A,B};
    ...

    data;

    set A := a1 a2 a3 a4;
    set B := b1 b2 b3;

    param p :
          a1  a2  a3  a4 :=
      b1  12  34  54  12
      b2  98  87  76  65
      b3  78  65  67  43
      ;    
  
The several options we have:

Manually (or with an external tool) transpose the matrix in the data section.
Change the order of the indices in the declaration, and eveywhere in the model
put (tr) after param p and before the colon in the data section
