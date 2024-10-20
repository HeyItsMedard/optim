set Topics;

param nDays;
set Days := 0..nDays;
param complexity{Topics} >= 0;
param availableHours{Days} >= 0;
param daysOfExam{Topics} in Days;
param kredits{Topics} >= 0;

var studyTime{Days, Topics} >= 0;
var done{Topics} binary; # ha tényleg át tudunk menni egy tárgyból

s.t. StudyTimePerDay {d in Days}:
    sum {t in Topics} studyTime[d, t] <= availableHours[d]; #pl. 2 óra p2 0 többi <= első nap 2 óra

s.t. EnoughStudyBeforeExam {t in Topics}:
    sum {d in 0..daysOfExam[t]-1} studyTime[d, t] >= complexity[t] * done[t]; # ensure enough study time before the exam
    # sum {d in Days : d < daysOfExam[t]} studyTime[d, t] >= complexity[t] * done[t]; # ensure enough study time before the exam

# maximize PassedTopics: # próbáljunk átjutni minél több tárgyból
#     sum {t in Topics} done[t];

maximize KreditEarned: # most már a legtöbb kreditet maximalizáljuk
    sum {t in Topics} kredits[t] * done[t];
solve;

printf "Total kredits earned: %g\n\n", KreditEarned;

for {t in Topics: done[t] == 1} {
    printf "Passed topic: %s\n", t;
}

end;

#>C:\Users\medav\Downloads\gusek_0-2-24\gusek\glpsol.exe --cover --clique --gomory --mir -m "generic_vizsga.mod" -d "vizsga.dat" -o "generic_vizsga.out" -y "generic_vizsga_output.txt"
