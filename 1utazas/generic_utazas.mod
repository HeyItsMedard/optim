set Benzinkutak;
set Varosok;

param VarosTavolsag{Varosok} >= 0;
param BenzinkutTavolsag{Benzinkutak} >= 0;
param BenzinArak{Benzinkutak} >= 0;
param KutTavolsag{Benzinkutak, Varosok} >= 0;
param AutoKapacitas >= 0;

# Elég kell legyen a 0. (s) helyen tankolt benzin az 1. benzinkútig (x)
# amit 0. helyen tankolok több mint 1-ig kell
# s >= tav/100 * fogyasztás
# el kell jutnom a 2. pontig
# amivel indulok az első pontról, több mint ami 2. pontig kell
# x + (s-tav/100*fogyasztás) >= tav2-tav1/100*fogyasztás
# vagyis s + a >= tav2/100*fogyasztás