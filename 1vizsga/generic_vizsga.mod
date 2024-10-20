set Topics;

param nDays;
param reducedCostFactor;
set Days := 0..nDays;
param complexity{Topics} >= 0;
param availableHours{Days} >= 0;
param daysOfExam{Topics} in Days;
param kredits{Topics} >= 0;
param examLength{Topics} >= 0;

var studyTime{Days, Topics} >= 0;
var done{Topics} binary; # ha tényleg át tudunk menni egy tárgyból

s.t. StudyTimePerDay {d in Days}:
    sum {t in Topics} studyTime[d, t] <= availableHours[d] - sum {t in Topics: daysOfExam[t] == d} examLength[t];
    # comment: azért kell a daysOfExam, mert azon a napon, amikor a vizsga van, kevesebbet tanulunk

s.t. EnoughStudyBeforeExam {t in Topics}:
    sum {d in 0..daysOfExam[t]-1} studyTime[d, t] >= complexity[t] * done[t]; # ensure enough study time before the exam
#     # sum {d in Days : d < daysOfExam[t]} studyTime[d, t] >= complexity[t] * done[t]; # ensure enough study time before the exam

s.t. ReducedCostDayBeforeExam {d in Days, t in Topics: d = daysOfExam[t] - 1}:
    studyTime[d, t] <= reducedCostFactor * availableHours[d];    
    # egy nappal a vizsga előtti tanulás rosszabb lesz

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
