# Igaz/Hamis feladatok

## I

1. Csak akkor fordulhat elo, hogy egy LP modellnek nincs megoldasa, ha a valtozok szama kevesebb, mint a korlatozasok szama. ❌
2. A szimplex modszer masodik fazisanak feladata, hogy egy nem bazismegoldasbol bazimsegoldasba keruljunk. ❌
3. Tulzottan nagy M ertek megvalasztasa eseten a megoldok numberikus hibara futhatnak. ✔
4. GMPL nyelven egy set elemei csak szimbolikus ertekek lehetnek. ❌
5. Heurisztikanak az olyan modszereket nevezzuk, melyek a lehetseges donteseket moho modon hozzak meg. ❌

## II

1. Minden MILP feladatnak van legalább egy optimális megoldása. ❌
2. A preprocessing a MILP megoldóban az, amikor memóriát foglal a paramétereknek, és kiszámolja az értéküket. ❌
3. LP modellben nem megengedett két folytonos változó összeszorzása, de MILP modellekben igen. ❌
4. Egy változónak legfeljebb két alsó indexe lehet. ❌
5. Halmazok leszükítésében (kapcsoson belül a kettőspont utáni rész) használhatók a paraméterek. ✔
6. Lehet a modellben olyan korlátozás, melyben a modell összes változója szerepel nem 0 együtthatóval. ✔
7. A szimplex algoritmus önmagában nem tud MILP feladatokat megoldani. ✔

## III

1. Mik az előnyei, hátrányai egy részletesebb modellnek egy egyszerűbbel szemben?
   - Előny:
     - Pontosabb eredmény
   - Hátrány:
     - Nagyobb számítási igény
     - Több változó, korlátozás
     - Több memória
     - Bonyolultabb

2. Lehet-e egy LP feladatnak pontosan kettő optimális megoldása? ❌

3. Mit fejez ki az alábbi korlátozás? [single selection]

        s.t. Foo {p in Products} : sum {t in Tools} compatible[p,t] * bought[t] >= 2;

4. Mely módszerek garantálják az optimális megoldás megtalálását? [multiple selection]

    • Genetikus algoritmus ❌ (csak szuboptimális)
    • Korlátprogramozás ✔
    • Lineáris programozás ✔
    • Lokális keresés ❌ (csak szuboptimális)

5. Mi az, ami korlátprogramozásban megengedett, de MILP-ben nem? [multiple selection]

    • Változók összeszorzása a korlátozásokban ✔
    • Változóval való tömbindexelés ✔
    • Törtszám típusú változók ❌
    • Nemegyenlő korlátozás (!=) ✔

## IV

1. Mit jelent ha egy módszer `egzakt`?
   - Ha garantálja az optimális megoldást - pl: Brute Force algoritmus

2. Mit jelent a `szuboptimális`?
   - Nem optimális de közel van az optimálishoz

3. Mi a különbség a `matematikai` és a `valós modell` között?
   - A matematikai modellből kimarad pár tényező amit a valós modellbe vissza kell helyettesíteni

4. Mik az `LP` (lineáris programozási modell) szabályai?

   - véges sok folytonos változó
   - véges sok korlátozás
   - a korlátozásoknak lineárisnak kell lenni:
     - Az egyes megszorítások bal oldala (LHS) a változók lineáris kifejezése
     - Minden megszorítás jobb oldala (RHS) egy konstans
   - relációk: <= , >= , =
   - 1 célfüggvénynek kell lennie, ami lineáris. Ezt szeretnénk minimalizálni vagy maximalizálni

5. Mi az a `MILP`?

   - (Mixed-Integer Linear Programing) vegyes egészértékü lineáris programozás
   - ez egy matematikai optimalizálási módszer
   - ebben az egyes változók csak egész számokat vehetnek fel, míg más változók lehetnek folytonosak (valós számok)

6. Melyik oldja meg az LP feladatot?

   - Szimplex megoldo (IGEN✅) => NEM CSAK SZIMPLEX MEGOLDÓ !!!
   - LP megoldo (IGEN✅)
  
7. Mi az a `CPLEX` és a `GUROBI`?

   - Mind a CPLEX, mind a GUROBI nagy teljesítményű kereskedelmi optimalizálási megoldások, amelyeket széles körben használnak lineáris programozás, vegyes egészszámú programozás és másodfokú programozási problémák megoldására. Mindkét megoldó fejlett algoritmusokat és funkciókat kínál a problémák széles skálájának optimalizálásához különböző területeken, beleértve a pénzügyet, az energiát, a szállítást és a logisztikát.

8. Egy feasible érték tartománya lehet-e konkáv? nem, csak konvex
9. `2 dimenzió`
    - 2 dimenzionál 2 változó van
    - megoldások:
       - nincs megoldás
       - 1 megoldás
       - végtelen sok megoldás
       - nem korlátos megoldás (nem adtam meg korlátot neki tehát nyitott)
    - egyenest tolunk el

10. `3 dimenzió`
    - 3 dimenziónál 3 változó van
    - síkot tolunk el
    - A csúcsok a bázismegoldások

11. Hogyan hívják a `Szimplex` fázisait?

    - Szimplex I. fázis
      - Bázis megoldás megtalálása
    - Szimplex II. fázis
      - Bázis megoldás javítása

12. Szimplex megoldás: Standard Lineáris Programozási Forma

13. Mi a MILP és az LP közti különbség?

    | Jellemző | LP | MILP |
    | --- |:---:|:---:|
    | Változók | Folytonos | Folytonos és egész |
    | Megoldási algoritmusok | Szimplex | B&B, Cutting planes, Szimplex(de nem elég önállóan!) |

    - Simplex nem képes közvetlenül kezelni az egészértékű változókat.

14. Szimplex
    - x >= 0
    - Ax <= b
    - c<sup>T</sup>x -> min/max

15. Hány megoldás van ha:

    - eltérő egyenletek száma  =  változók = 1 megoldás
    - eltérő egyenletek száma  >  változók = nincs megoldás
    - eltérő egyenletek száma  <  változók = végtelen megoldás

16. Mi az a `bázis`?
    - A lineáris algebrában egy vektortér `bázisa` egy olyan vektorhalmaz, melyben lévő elemek egymástól lineárisan függetlenek és lineáris kombinációik megadják a vektortér minden elemét (azaz `generátorrendszert` alkotnak)
    - A bázis egy **minimális számú generátorrendszere** a térnek és egy maximális számosságú, egymástól lineárisan független elemekből álló részhalmaza is egyben.

17. Mi az a `generátor rendszer`?
    - Egy vektortér generátorrendszere egy olyan vektorhalmaz, melynek lineáris kombinációi a **vektortér összes elemét előállítják**.
    - Tehát bármelyik vektort előállíthatom a generátorrendszer vektorainak lineáris kombinációjával.

18. Mi az a `SLACK variable` ?
    - LHS és RHS között egyelőtlenség van: szerzünk egy SLACK variable-t [s >= 0]
    - LHS <= RHS
      - LHS + s = RHS
    - LHS >= RHS
      - LHS - s = RHS

19. Mi az az `árnyékköltség`?
    - c<sub>j</sub> - c<sub>t</sub>B · B<sup>-1</sup> · a<sub>j</sub>
    - Árnyékköltség egy mérőszám, ami megmutatja, hogy egy adott korlát/feltétel változtatása (pl. bázismegoldás változtatása) hogyan hat a célfüggvény értékére

20. Mi az a `LHS` és az `RHS`?
    - LHS: A kifejezés bal oldala, azaz az az oldal, amely a korlátozásokban a változókat tartalmazza.
    - RHS: A kifejezés jobb oldala, amely általában egy konstans érték.

21. Mi az a `GMPL`?
    - modellező nyelv
    - A GLPK keretrendszerben a modelljeinket a GMPL nyelven írjuk le
    - Az LP és a MILP modellek leírását segíti

22. Mi az a `GPLK`?
    - szoftvercsomag

23. Mi az a `GUSEK`?
    - grafikus felhazsnálói felület

24. Mi az a `GLPSOL`?
    - parancssoros megoldóeszköz
    - A GLPK része

25. Mi az a `Preprocessing`?
    - A preprocessing (előfeldolgozás) az optimalizálási problémák megoldása előtt alkalmazott lépések összessége, amelynek célja a probléma egyszerűsítése, hogy a megoldási folyamat gyorsabb, hatékonyabb legyen.
    - Lépései:
      - Változók és korlátok egyszerűsítése
        - Redundáns korlátok eltávolítása
        - Fixált változók
        - Túl szoros vagy túl enyhe korlátok, felesleges korlátok
      - Felesleges együtthatók eltávolítása
      - Lineáris és nemlineáris problémák egyszerűsítése
      - Korlátozott erőforrások kezelése:
        - Memória optimalizálás
      - Próbalépcsős keresési technikák:
        - Bizonyos esetekben az előfeldolgozás tartalmazhat egy gyors próbamegoldási lépést, hogy meghatározzuk a probléma egyszerűsített verziójának megoldásait, amely segíthet a további optimalizálás irányának meghatározásában.

26. Mit jelent az, hogy egy set `szimbolikus`?
    - A set nem numerikus adatokat tárol, például set Cities: London, Paris, Budapest...

27. Mit jelent az, hogy `politóp`?
    - Ez egy multidimenziós objektum, ahol (optimalizálásban) éleken haladunk iteratívan optimális mo.-ért. Az opt. mo. nemcsak lokális, globális optimum.

## V

### Értékelés az Igaz/Hamis feladatokra:

1. **Egy lineáris programozási (LP) modellnek mindig létezik megoldása, ha a változók száma nagyobb, mint a korlátozások száma.**  
   **Hamis**. A változók száma és a korlátozások száma nem garantálja automatikusan a megoldhatóságot. Például, ha a korlátozások ellentmondásosak, az LP problémának nincs megoldása.  

2. **A nagy M érték túlzottan magas megválasztása hibákhoz vezethet a numerikus számításokban.**  
   **Igaz**. A "Big-M" módszer túlzottan nagy értékei numerikus instabilitást okozhatnak a számítás során, ezért az \( M \) értékének körültekintő megválasztása szükséges.  

3. **Egy bináris változó és egy folytonos nemnegatív változó szorzata lineárisítással modellezhető.**  
   **Igaz**. Ez egy ismert technika az LP-ben és a vegyes egészértékű programozásban (MILP). Például az \( x \cdot y \) szorzatot (ahol \( x \) bináris) lineáris korlátozásokkal helyettesítjük.  

4. **A Froccs modellnél minden terméket azonos mennyiségű alapanyag felhasználásával állítanak elő.**  
   **Hamis**. A Froccs modellben az egyes italok eltérő mennyiségben használnak szódát és bort.  

5. **A szimplex módszer alapvetően iteratív algoritmus, amely egy optimalizálási problémát egyre jobb bázismegoldásokkal közelít.**  
   **Igaz**. A szimplex módszer iteratívan halad a bázismegoldások között, amíg el nem éri az optimumot, de az első fázis nem az optimalizálásra, hanem a megoldás elindítására szolgál.  
---

### Értékelés a Kakukktojás feladatokra:

#### I. **Melyik állítás igaz?**  
- **A GMPL modellek támogatják a generikus változódeklarációkat.**  
  **Igaz.** A GMPL lehetőséget ad generikus változók, például halmazokon értelmezett változók definiálására.   pl. param quantity{Products} ...

- **A Froccs modellben az alapanyagkészlet nem lehet véges.**  
  **Hamis.** Az alapanyagok, mint például szóda és bor, készlete véges a modellben.  

- **A szállítók által felhasznált maximális munkaidőt nem kell korlátozni az időkeret modellekben.**  
  **Hamis.** A maximális munkaidőt korlátozni kell, különben a modell irreális eredményeket adhat.  

- **A bináris változók kizárólagos kapcsolatai modellezhetők úgy, hogy a summázásokat egyenlőtlenségekkel kombináljuk.**  
  **Igaz.** Ez egy szokásos modellezési technika, például a Big-M használatával.  

#### II. **Melyik nem helyes technikai megállapítás?**  
- **A bináris változók GMPL-ben "binary" jelzővel deklarálhatók.**  
  **Igaz.** Ez a helyes deklarációs forma GMPL-ben.  

- **A célfüggvény minden esetben maximalizáló irányba hat.**  
  **Hamis.** A célfüggvény lehet minimalizáló vagy maximalizáló, az adott probléma függvényében.  

- **A Big-M módszerrel komplex feltételek is kezelhetők.**  
  **Igaz.** A Big-M technika lehetővé teszi feltételek lineáris formában történő kezelését.  

- **A szimplex algoritmus második fázisa a bázismegoldások közötti mozgásra koncentrál.**  
  **Igaz.** Ez az algoritmus második fázisának lényege.  