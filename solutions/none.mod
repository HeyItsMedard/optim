set I;
param a {I};
param b {I};

var x {I};

minimize obj: sum {i in I} a[i] * x[i];

subject to constraint1 {i in I}: x[i] >= b[i] + 1;
subject to constraint2 {i in I}: x[i] <= b[i] - 1;  # This constraint makes the problem infeasible

data;

set I := 1 2;
param a := 1 1 2 1;
param b := 1 1 2 1;

end;