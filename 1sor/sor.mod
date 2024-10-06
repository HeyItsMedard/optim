var xSS >=0;
var xSV >=0;
var xSGy >=0;
var xSP >=0;
var xSBP >=0;
var xSSz >=0;
var xSD >=0;
var xSM >=0;

var xKS >=0;
var xKV >=0;
var xKGy >=0;
var xKP >=0;
var xKBP >=0;
var xKSz >=0;
var xKD >=0;
var xKM >=0;

var xPS >=0;
var xPV >=0;
var xPGy >=0;
var xPP >=0;
var xPBP >=0;
var xPSz >=0;
var xPD >=0;
var xPM >=0;

var xNKS >=0;
var xNKV >=0;
var xNKGy >=0;
var xNKP >=0;
var xNKBP >=0;
var xNKSz >=0;
var xNKD >=0;
var xNKM >=0;


minimize Koltseg:
    0 * xSS + 145 * xSV + 90 * xSGy + 275 * xSP + 220 * xSBP + 390 * xSSz + 450 * xSD + 400 * xSM
    + 220 * xKS + 125 * xKV + 130 * xKGy + 200 * xKP + 0 * xKBP + 170 * xKSz + 220 * xKD + 180 * xKM
    + 275 * xPS + 160 * xPV + 250 * xPGy + 0 * xPP + 200 * xPBP + 185 * xPSz + 410 * xPD + 425 * xPM
    + 160 * xNKS + 130 * xNKV + 175 * xNKGy + 140 * xNKP + 210 * xNKBP + 310 * xNKSz + 440 * xNKD + 420 * xNKM;

# Egyetemek

s.t. Sopron_demand:
    xSS + xKS + xPS + xNKS >= 500;

s.t. Veszprem_demand:
    xSV + xKV + xPV + xNKV >= 2000;

s.t. Gyor_demand:
    xSGy + xKGy + xPGy + xNKGy >= 1500;

s.t. Pecs_demand:
    xSP + xKP + xPP + xNKP >= 3000;

s.t. BP_demand:
    xSBP + xKBP + xPBP + xNKBP >= 10000;

s.t. Szeged_demand:
    xSSz + xKSz + xPSz + xNKSz >= 4000;

s.t. Debrecen_demand:
    xSD + xKD + xPD + xNKD >= 3500;

s.t. Miskolc_demand:
    xSM + xKM + xPM + xNKM >= 2500;


# Gyarak

s.t. Sopron_production:
	xSS + xSV + xSGy + xSP + xSBP + xSSz + xSD + xSM <= 6000;

s.t. Kobanya_production:
	xKS + xKV + xKGy + xKP + xKBP + xKSz + xKD + xKM <= 12000;

s.t. Pecs_production:
	xPS + xPV + xPGy + xPP + xPBP + xPSz + xPD + xPM <= 8000;

s.t. Nagykanizsa_production:
	xNKS + xNKV + xNKGy + xNKP + xNKBP + xNKSz + xNKD + xNKM <= 1000;

end;