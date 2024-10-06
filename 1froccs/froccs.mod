var xKF>=0;
var xNF>=0;
var xHL>=0;
var xHM>=0;
var xVHM>=0;
var xSP>=0;
var xKR>=0;
var xSH>=0;
var xPU>=0;


s.t. Bor:
	1 * xKF + 2 * xNF + 1 * xHL + 3 * xHM + 2 * xVHM + 1 * xSP + 9 * xKR + 1 * xSH + 6 * xPU <= 1000;

s.t. Szoda:
	1 * xKF + 1 * xNF + 2 * xHL + 2 * xHM + 3 * xVHM + 4 * xSP + 1 * xKR + 9 * xSH + 3 * xPU <= 1500;

maximize Income:
	200 * xKF + 380 * xNF + 220 * xHL + 550 * xHM + 400 * xVHM + 230 * xSP + 1600 * xKR + 300 * xSH + 1100 * xPU;
