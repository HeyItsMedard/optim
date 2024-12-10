set Musicians;
set Tracks;

param difficultForMusician{Tracks, Musicians} binary;
param trackLength{Tracks};
param popularity{Tracks};

param maxTracks; # EXACTLY 10 songs
param minMinutes; # AT LEAST 60 minutes
param maxMinutes; # AT MOST 80 minutes
param breakBetweenTracks; # 30 seconds

var play{Musicians, Tracks} binary; # segédváltozó szerepet játszik abban, hogy sorozatban ne játsszon 3 nehezet 
var played{Tracks} binary;
var maximizePopularity{Tracks} >= 0;

# A célunk, hogy az eljátszott számok össznépszerűsége minél több legyen
maximize TotalPopularity: sum{t in Tracks} maximizePopularity[t];

# Minden zenész játszik minden játszott számon (csúnya megoldás, de nem akartam megpiszkálni a paramétereket)
s.t. AllMusiciansPlayAllPlayedTracks{m in Musicians, t in Tracks}:
    play[m,t] <= played[t];

# Egy zenész csak egy számot játszhat egyszerre
s.t. OneTrackPerMusician{m in Musicians, t in Tracks}:
    sum{f in Tracks} play[m,f] <= 1;

# Egy számot csak egyszer játszhatunk el
s.t. OnePlayPerTrack{t in Tracks}:
    sum{m in Musicians} play[m,t] <= 1;

# nem követhet egymást három szám úgy, hogy bármelyik zenész/énekes számára mindegyik nehéz legyen
s.t. NoThreeDifficultTracksInARow{m in Musicians}:
    sum{t in Tracks} play[m,t]*difficultForMusician[t,m] <= 2;

# A koncert mindenképpen 10 számból fog állni
s.t. ExactlyTenTracks:
    sum{t in Tracks} played[t] = 10;

# A koncertnek legalább 60 percig kell tartania
s.t. AtLeastSixtyMinutesWithBreaks:
    sum{t in Tracks} played[t]*trackLength[t] + (sum{t in Tracks} played[t] - 1) * breakBetweenTracks >= minMinutes;

# A koncertnek legfeljebb 80 percig kell tartania
s.t. AtMostEightyMinutesWithBreaks:
    sum{t in Tracks} played[t]*trackLength[t] + (sum{t in Tracks} played[t] - 1) * breakBetweenTracks <= maxMinutes;

# A popularitás kiszámítása
s.t. CalculatePopularity{t in Tracks}:
    maximizePopularity[t] = played[t]*popularity[t];

solve; #846

printf "A koncert tartalma:\n";
for {t in Tracks: played[t] == 1} {
    printf "  - %s\n", t;
}

/*
A koncert tartalma:
  - 2
  - 3
  - 5
  - 6
  - 9
  - 10
  - 16
  - 17
  - 18
  - 19
*/

end;