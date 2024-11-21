set BookSets;
param max_shelves;

set Shelves := 1..max_shelves;

# Két sín, 50cm magasan kezdődnek
#120cm szélesek
param shelfwidth;
param shelfthickness;
param firstshelfheight;
param bookgap_height;
# legmagassabb könyv felett is maradjon 7cm
# polcok vastagsága 2cm

param bs_width {BookSets};
param bs_maxheight {BookSets};

param M;

var shelf_position {Shelves} >= 0;
var place_books {BookSets, Shelves} binary;
var is_used {Shelves} binary;
var shelfheight{Shelves}>=0; # cm
var highest_shelf >= 0;


minimize height:
    highest_shelf;

# Egy könyvsor egy polcra kerülhet csak
# s.t. one_shelf_per_bookset {b in BookSets}:
#     sum {s in Shelves} place_books[b,s] = 1;

s.t. BooksetShelfAssignment {b in BookSets}:
    sum{s in Shelves} place_books[b,s]=1;

# A könyvek a polcok szélességén belül maradjanak és használatlanra nem rakható
# s.t. books_width_doesnt_exceed_shelf_width {s in Shelves}:
#     # 120 * 0 >= nem hajtja végre; 120 * 1 <= 60 * 1 + 90 * 0 + 50 * 1 + 70 *0...
#     sum{b in BookSets} place_books[b,s] * bs_width[b] <= shelfwidth * is_used[s];

s.t. Shelfcapacity{s in Shelves}:
    sum{b in BookSets} bs_width[b]*place_books[b,s] <= shelfwidth * is_used[s];

# Maximális polc magasság beállítása
# s.t. set_shelf_height {s in Shelves, b in BookSets}:
#     shelfheight[s] >= place_books[b,s] * bs_maxheight[b];

s.t. MaxShelfHeight{s in Shelves, b in BookSets}:
    shelfheight[s] >= bs_maxheight[b] * place_books[b,s];

# Az első polc magassága fix
# s.t. first_shelf_height:
#     shelf_position[1] = firstshelfheight;

s.t. FirtsShelf:
    shelf_position[1]=firstshelfheight;

# -

# Ha (nem első) polc használatban van, 
# akkor a jelenlegi polc magassága 
# az előző magassága + könyv magassága + könyv közötti rés + polc vastagság
# s.t. set_shelf_position {s in Shelves: s != 1}:
#     # 0 >= 50 + 70 + 7 + 2 - M * 0 itt akkor felülírja a korábbi értéket, ellenben lazítja a pozíciót
#     shelf_position[s] >= shelf_position[s-1] + shelfheight[s-1] + bookgap_height + shelfthickness - M * (1 - is_used[s]);

s.t. ShelfDistances{s in Shelves: s!=1}:
    shelf_position[s]>=shelf_position[s-1]+shelfheight[s-1]+bookgap_height+shelfthickness - M * (1-is_used[s]);

# Ha egy polc nincs használva, a többi utána következő se legyen
# s.t. shelves_are_continuous{ s in Shelves: s != 1}:
#     # 0 <= 0, 1 <= 1, 0 <= 1
#     is_used[s] <= is_used[s-1];

s.t. ShelfUsage{s in Shelves: s!=1}:
    is_used[s]<=is_used[s-1];

# A legmagasabb polc magassága
s.t. set_highest_shelf{s in Shelves}:
    # 180 >= 170 OK, 180 >= 190 NOK
    highest_shelf >= shelf_position[s] - M * (1 - is_used[s]);

# s.t. HighestReach{s in Shelves}:
#     highestshelf >= shelfposition[s] - M * (1-isused[s]);

solve;

printf "Reaching height: %g", highest_shelf; #296? certainly wrong

#>C:\Users\medav\Downloads\gusek_0-2-24\gusek\glpsol.exe --cover --clique --gomory --mir -m "konyvespolc.mod" -d "konyvespolc.dat" -o "konyvespolc.out" -y "konyvespolc.txt"