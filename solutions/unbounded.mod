set I;

param a {I};
param c {I};

var x {I} >= 0;

maximize Obj: sum {i in I} c[i] * x[i];

subject to Constraint: sum {i in I} a[i] * x[i] <= 1;

data;

set I := 1 2;

param a :=
1 1
2 -1;

param c :=
1 1
2 1;

end;