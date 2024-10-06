set Froccs;
set Contents;

param prices{Froccs} >=0;
param stock{Contents} >=0;
param need{Froccs, Contents} >=0;

var quantity{Froccs} >=0;

s.t. Stock_constraint{c in Contents}:
    sum{f in Froccs} need[f,c] * quantity[f] <= stock[c];

maximize Income:
    sum{f in Froccs} prices[f] * quantity[f];

solve;

for {f in Froccs : quantity[f] != 0} {
    printf "From %s : %g\n",f,quantity[f];
}

#>C:\Users\medav\Downloads\gusek_0-2-24\gusek\glpsol.exe --cover --clique --gomory --mir -m "generic_froccs.mod" -d "froccs.dat" -o "generic_froccs.out" -y "generic_froccs_output.txt"
end;