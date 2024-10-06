# Sets and Parameters
set Bands;      # Set of all bands
set Fests;      # Set of all festivals

param Concerts{Bands, Fests} >= 0;  # (1 if yes, 0 if no)

var x{f in Fests} binary;  # (1 if yes, 0 if no)

# Minimize the total number of festivals attended
minimize TotalFestivals:
    sum{f in Fests} x[f];

# Ensure we attend at least one concert for each band
s.t. AttendConcertForEachBand{b in Bands}:
    sum{f in Fests} Concerts[b, f] * x[f] >= 1;

solve;

# Output: Festivals to attend
display x;

#>C:\Users\medav\Downloads\gusek_0-2-24\gusek\glpsol.exe --cover --clique --gomory --mir -m "generic_fesztival.mod" -d "fesztival.dat" -o "generic_fesztival.out" -y "generic_fesztival_output.txt"

end;
