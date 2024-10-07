# Sets and parameters
set Students;  # Set of all students (I, K, M, G)
set Tantargyak;  # Set of all subjects (T1, T2, ..., T10)

param MilkacsokiAr{Students, Tantargyak} >= 0;  # Cost of chocolate to motivate students for each subject
param Tetelek{Tantargyak} >= 0;  # Number of theses for each subject

param IgazsagossagArany;

# Decision variables
var x{Students, Tantargyak} binary;  # 1 if student works on a subject, 0 otherwise
# Matey nitpick: x helyett valami beszédesebb


# minimize the total number of chocolates
minimize TotalChocolates:
    sum{s in Students, t in Tantargyak} MilkacsokiAr[s, t] * x[s, t];

# Sucbjects can only be assigned once
s.t. AssignEachSubject{t in Tantargyak}:
    sum{s in Students} x[s, t] = 1;

# 3 subjects per student
s.t. MaxSubjectsPerStudent{s in Students}:
    sum{t in Tantargyak} x[s, t] <= 3;

# Solve the model
solve;

# How many theses are assigned to each student?
param NumTheses{s in Students} := sum{t in Tantargyak} Tetelek[t] * x[s, t];
display NumTheses;

# Chocolate/student for each subject
param TotalChocolatesPerStudent{s in Students} := sum{t in Tantargyak} MilkacsokiAr[s, t] * x[s, t];
display TotalChocolatesPerStudent;

# How many chocolates should we buy?
param OverallChocolates := sum{s in Students, t in Tantargyak} MilkacsokiAr[s, t] * x[s, t];
display OverallChocolates;

printf "Subjects assigned to each student:\n";
for {s in Students} {
    printf "%s: ", s;
    for {t in Tantargyak: x[s, t] = 1} {
        printf "%s ", t;
    }
    printf "\n";
}

#>C:\Users\medav\Downloads\gusek_0-2-24\gusek\glpsol.exe --cover --clique --gomory --mir -m "generic_allamvizsga.mod" -d "allamvizsga.dat" -o "generic_allamvizsga.out" -y "generic_allamvizsga_output.txt"
#note to reader: give your own path to glpsol.exe
end;