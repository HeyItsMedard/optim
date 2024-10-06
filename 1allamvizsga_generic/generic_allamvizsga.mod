# Mod file: state_exam.mod

# Sets and Parameters
set Students;  # Set of all students (I, K, M, G)
set Tantargyak;  # Set of all subjects (T1, T2, ..., T10)

param MilkacsokiAr{Students, Tantargyak} >= 0;  # Cost of chocolate to motivate students for each subject
param Tetelek{Tantargyak} >= 0;  # Number of theses for each subject

# Decision Variables
var x{Students, Tantargyak} binary;  # 1 if student works on a subject, 0 otherwise

# Objective Function: Minimize the total amount of chocolate
minimize TotalChocolates:
    sum{s in Students, t in Tantargyak} MilkacsokiAr[s, t] * x[s, t];

# Constraints: Each subject must be assigned to exactly one student
s.t. AssignEachSubject{t in Tantargyak}:
    sum{s in Students} x[s, t] = 1;

# Constraints: Each student can work on at most 3 subjects
s.t. MaxSubjectsPerStudent{s in Students}:
    sum{t in Tantargyak} x[s, t] <= 3;

# Solve the model
solve;

# Calculate and display the number of theses each student is responsible for
param NumTheses{s in Students} := sum{t in Tantargyak} Tetelek[t] * x[s, t];
display NumTheses;

# Calculate and display the total amount of chocolates each student needs
param TotalChocolatesPerStudent{s in Students} := sum{t in Tantargyak} MilkacsokiAr[s, t] * x[s, t];
display TotalChocolatesPerStudent;

# Calculate and display the total chocolates needed across all students
param OverallChocolates := sum{s in Students, t in Tantargyak} MilkacsokiAr[s, t] * x[s, t];
display OverallChocolates;

#>C:\Users\medav\Downloads\gusek_0-2-24\gusek\glpsol.exe --cover --clique --gomory --mir -m "generic_allamvizsga.mod" -d "allamvizsga.dat" -o "generic_allamvizsga.out" -y "generic_allamvizsga_output.txt"

end;