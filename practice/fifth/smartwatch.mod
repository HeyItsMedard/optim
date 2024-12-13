set Components;
set Groups;

param price {Components} >= 0;
param needs {Groups, Components} >= 0;
param maxpay{Groups} >= 0;
param population{Groups} >= 0;
param sellprice; #
param maxcomponentprice; #együttesen 80 alatt kell maradnia, amit fizetünk

var chooseComponent {Components} binary; #vásároljuk-e a komponenst
var groupSell {Groups} binary; #vásárol-e a csoport

maximize Income: 
    sum {g in Groups} groupSell[g] * population[g] * sellprice;

# Constraints

# A komponensek költsége nem lépheti át a maxcomponentprice-ot
s.t. ComponentPrice:
    sum {c in Components} chooseComponent[c] * price[c] <= maxcomponentprice;

# Egy csoport csak akkor vásárol, ha az okosóra ára nem lépi túl a maxpay-ot
s.t. GroupPay{g in Groups: maxpay[g] < sellprice}:
    # így eleve nem vesz: G1, G2, G4 G6, G8, G16
    groupSell[g] = 0;

# Egy csoport nem fog vásárolni akkor, ha a számukra szükséges komponens hiányzik
s.t. GroupNeeds{g in Groups, c in Components: needs[g,c] = 1}:
    groupSell[g] <= chooseComponent[c];

solve;

# Pelda kimenet:
#
#Included components:  GPS HR ACC BT
#Targeted groups:
#	Group  G7, population: 4311
#	Group  G9, population: 2347
#	Group G10, population: 8426
#Sold to a total of 15084 people, making 3771000 income

printf "\nIncluded components: ";
for {c in Components: chooseComponent[c] = 1} printf " %s", c;
printf "\n";
printf "Targeted groups:\n";
for {g in Groups: groupSell[g] = 1} printf "\tGroup %3s, population: %g\n", g, population[g];
printf "Sold to a total of %d people, making %d income\n", sum {g in Groups: groupSell[g] = 1} population[g], sum {g in Groups: groupSell[g] = 1} population[g] * sellprice;

end;