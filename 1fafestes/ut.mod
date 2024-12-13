set dolgozok;
set munkafolyamatok;
param sorrend{munkafolyamatok} symbolic in munkafolyamatok;
param utolsomunka symbolic in munkafolyamatok;
param ora;
set orak := 1..ora;

param sebesseg{dolgozok, munkafolyamatok}>=0;
param munkaora <=1 >=0;
param maxtavolsag := 10;

var dolgozas{orak,dolgozok, munkafolyamatok } binary;
var elorehaladas{orak union {0},munkafolyamatok} >= 0;

var tavolsag;


s.t. csak_egy_feladat{d in dolgozok, o in orak}:
    sum{m in munkafolyamatok} dolgozas[o,d,m]<=1;

s.t. elorehaladas_kezdet{m in munkafolyamatok}:
    elorehaladas[0,m]=0;


s.t. munka_elorehaladas { o in orak, m in munkafolyamatok}:
    elorehaladas[o,m]<=elorehaladas[o-1,m]+sum{d in dolgozok} dolgozas[o,d,m]*sebesseg[d,m]*munkaora;


s.t.  megelozo_ora { o in orak, m in munkafolyamatok}:
    elorehaladas[o,m]<= elorehaladas[o, sorrend[m]];


s.t. max_tavolsag_negativ{o in orak, m1 in munkafolyamatok, m2 in munkafolyamatok: m1<>m2}:
    (elorehaladas[o,m1]-elorehaladas[o,m2])>=maxtavolsag*(-1);


s.t. max_tavolsag_pozitiv{o in orak, m1 in munkafolyamatok, m2 in munkafolyamatok: m1<>m2}:
    (elorehaladas[o,m1]-elorehaladas[o,m2])<=maxtavolsag;
         
    

maximize  kesz :
elorehaladas[ora,utolsomunka];
end;














