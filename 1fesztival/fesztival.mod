var xNOV >= 0;
var xOZO>= 0;
var xSAV>= 0;
var xBS>= 0;
var xSZI>= 0;
var xEFO>= 0;
var xSEN>= 0;

s.t. Hatijenincs:
	1* xOZO + 1* xBS >= 1;

s.t. JustinBieber:
	1* xNOV + 1* xBS + 1* xSZI + 1* xEFO + 1* xSEN  >= 1;

s.t. TaylorSwift:
	1* xSAV + 1* xSZI + 1* xEFO  >= 1;

s.t. Skillet:
	1* xNOV + 1* xSAV + 1* xSEN  >= 1;

s.t. KendrickLamar:
	1* xOZO + 1* xSAV + 1* xSZI + 1* xEFO  >= 1;

s.t. PaDuDu:
	1* xNOV + 1* xBS  >= 1;

s.t. Hanabie:
	1* xNOV + 1* xOZO + 1* xBS  >= 1;

s.t. BackstreetBoys:
	1* xNOV + 1* xSAV + 1* xSEN  >= 1;

s.t. Metallica:
	1* xSZI  >= 1;

s.t. Tankcsapda:
	1* xNOV + 1* xOZO + 1* xSZI + 1* xEFO  >= 1;

minimize Fesztival:
	xNOV + xOZO + xSAV + xBS + xSZI + xEFO + xSEN;