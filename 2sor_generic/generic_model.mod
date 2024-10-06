set Factories;
set Universities;

param supply{Factories} >=0;
param demand{Universities} >=0;
param distance{Factories,Universities} >=0;

var transport{Factories,Universities} >=0;

s.t. Supply_constraint{f in Factories}:
    sum{u in Universities} transport[f,u] <= supply[f];

s.t. Demand_constraint{u in Universities}:
    sum{f in Factories} transport[f,u] >= demand[u];

minimize Transportation_cost:
    sum{f in Factories, u in Universities} distance[f,u] * transport[f,u];

solve;

for {f in Factories} {
    for {u in Universities : transport[f,u] != 0}{
        printf "From %s to %s : %g\n",f,u,transport[f,u];
    }
}

#>C:\Users\medav\Downloads\gusek_0-2-24\gusek\glpsol.exe --cover --clique --gomory --mir -m "generic_model.mod" -d "sor.dat" -o "generic_model.out" -y "generic_output.txt"
end;