set Friends;
set Items;

param budget{Friends} >= 0, integer;
param price{Items} >= 0, integer;

param likes{Friends,Items} binary;

# who gives who
var who_gives_to_who{Friends,Friends} binary;
var who_gives_what{Friends,Items} binary;

# how much money is spent ?
var spent{Friends} >= 0, integer;

# minimize the total amount spent
minimize TotalSpent:
    sum{f in Friends} spent[f];

# friends should give to each other, not to themselves
s.t. NoSelfGiving {f in Friends}:
    who_gives_to_who[f,f] = 0;

# everyone should give to someone and only one
s.t. EveryoneGivesOnce {f in Friends}:
    sum{g in Friends} who_gives_to_who[f,g] = 1;

# receiver should only receive one gift
s.t. ReceiverGetsOneGift {g in Friends}:
    sum{f in Friends} who_gives_to_who[f,g] = 1;

# only one item is given per person
s.t. OnlyOneItemPerPerson {f in Friends}:
    sum{i in Items} who_gives_what[f,i] = 1;

# if someone gives an item, it should be liked by both the receiver and giver
s.t. OnlyLikedItems {f in Friends, i in Items}:
    who_gives_what[f,i] <= likes[f,i];

s.t. ReceiverLikesGift {f in Friends, i in Items}:
    who_gives_what[f,i] <= sum{g in Friends} who_gives_to_who[f,g] * likes[g,i];

# budget should not be exceeded
s.t. BudgetNotExceeded {f in Friends}:
    sum{i in Items} who_gives_what[f,i] * price[i] <= budget[f];

# set spent money
s.t. BuyingItem {f in Friends}:
    spent[f] = sum{i in Items} who_gives_what[f,i] * price[i];

solve;
#>C:\Users\medav\Downloads\gusek_0-2-24\gusek\glpsol.exe --cover --clique --gomory --mir -m "strawhats.mod" -d "strawhats.dat" -o "strawhats.out" -y "strawhats.txt"

printf "Total cost: %g\n\n",TotalSpent;
printf "Who gives to who:\n";
for {f in Friends, g in Friends: who_gives_to_who[f,g] == 1} {
    for {i in Items: who_gives_what[f,i] == 1} {
        printf "%s gives (item: %s, price: %d, budget: %d) to %s\n", f, i, price[i], budget[f], g;
    }
}

end;