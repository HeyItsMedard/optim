param nPlanes;
param nDots;

set Planes := 1..nPlanes;
set Dots := 1..nDots;

# Az erdőtűz pontos helyei
param x{Dots};
param y{Dots};

# A repülők által lefedhető terület
param width_coverage{Planes};
param height_coverage{Planes};
param M;

var is_extinguished{Dots} binary;
var plane_covers{Planes, Dots} binary;

# a bal alsó sarkából rajzoljuk ki widthel és heighttal a területet
var planes_corner_x{Planes} >= 0;
var planes_corner_y{Planes} >= 0; 

# Melyik repülő melyik tüzet oltotta el?

# Maximalizálás: minél több pontot fedjünk le
maximize covered_dots:
    sum{d in Dots} is_extinguished[d];

# Kényszerek:

# Ha senki nem szórja le, nincs eloltva tűz (4 CONSTRAINT)
s.t. fire_extingiushing_on_x_bottom{d in Dots, p in Planes}:
    # HA LEFEDI!
    # 3 <= 1 + 3 + 0, cover ✅; 3 <= 1 + 1 + 1000, nem cover ✅
    x[d] <= planes_corner_x[p] + width_coverage[p] + M * (1 - plane_covers[p, d]);

s.t. fire_extingiushing_on_x_upper{d in Dots, p in Planes}:
    # 3 >= 1 - 0, cover ✅; 3 >= 4 - 1000, nem cover ✅
    x[d] >= planes_corner_x[p] - M * (1 - plane_covers[p, d]);

s.t. fire_extinguishing_on_y_upper{d in Dots, p in Planes}:
    # 3 >= 1 + 0, cover ✅; 3 <= 4 - 1000, nem cover ✅
    y[d] >= planes_corner_y[p] - M * (1 - plane_covers[p, d]);

s.t. fire_extinguishing_on_y_bottom{d in Dots, p in Planes}:
    # 3 <= 1 + 3 + 0, cover ✅; 3 <= 1 + 1 + 1000, nem cover ✅
    y[d] <= planes_corner_y[p] + height_coverage[p] + M * (1 - plane_covers[p, d]);

# a repülő akkor oltja el a tüzet, ha fedi a tüzet
s.t. plane_covers_fire{d in Dots}:
    is_extinguished[d] <= sum{p in Planes} plane_covers[p, d];

# #>C:\Users\medav\Downloads\gusek_0-2-24\gusek\glpsol.exe --cover --clique --gomory --mir -m "erdotuz.mod" -d "erdotuz.dat" -o "erdotuz.out"

end;