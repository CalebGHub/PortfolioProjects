/*-Creating a Fantasy team from selecting 10 best players to fill a 9 category fantasy league
  -Goal is to win every week at least in 5 categories out of 9
  -We want to win in Free Throw %, 3 points made, points, Assists, Steals
  -Team's role must consist of PG, SG, G, SF, PF, F, C, C, Util, Util, Bench, Bench
  -There are 12 NBA Fantasy owners that drafts 13 rounds until their NBA team is full
  -The pick order is Snake draft 
  
  -ESPN: ESPN rating = PTS + REB + 1.4*AST + STL + 1.4*BLK -.7*TO + FGM + .5*TGM -.8*(FGA-FGM) + .25*FTM - .8*(FTA-FTM)
*/


SELECT *
From NBA_ESPN_Data

/* Top 10 PG based off ESPN Ranking with at least 50 games played*/
Select *
FROM NBA_ESPN_Data
Where POS = "PG" AND GP >="50"
Order by ESPN DESC
limit 10;

/* Among the 10 PG, who has the highest 3PM */
/* Damian Lillard and Stephen Curry are the 2 players we would like for our first round pick */
/* The stats from these 2 players are very familiar and they support which categories we are aiming to win */
SELECT Player, RK, "3PM", STPG, "FT%", APG
 FROM
	(Select Player, RK, POS, ESPN, "3PM", STPG, "FT%", APG
	FROM NBA_ESPN_Data
	Where POS = "PG" AND GP >="50"
	Order by ESPN DESC
	limit 10)
ORDER by "3PM" DESC

/* Among the 10 PG, who has the highest APG */
SELECT Player, RK, APG
 FROM
	(Select Player, RK, POS, ESPN, APG
	FROM NBA_ESPN_Data
	Where POS = "PG" AND GP >="50"
	Order by ESPN DESC
	limit 10)
ORDER by APG DESC


/* Top Centers with the highest Points per game with greater than 75% Free Throw and played at least 50 games */
/* - We would want to focus our drafts on Centers in the lower rounds because there aren't many centers who can average a high ft% and points */
/* - Picking Jokic, Embiid, Porzingis, and Adebayo are all great options in the 1st to 3rd round */
SELECT Player, RK, PTS, "FT%", STPG, "3PM", ESPN
FROM NBA_ESPN_Data
WHERE POS ="C" AND "FT%" >= "0.75" AND GP>="50"
ORDER BY PTS DESC

/* Top Power Forward with the highest Points per game with greater than 80% Free Throw and played at least 50 games*/
/* Lauri Markkanen is the best pick possible in the 2nd round due to high FT%, PTS, and 3PM */
SELECT PLAYER, RK, PTS, "FT%", "3PM", APG, STPG,  ESPN
FROM NBA_ESPN_Data
WHERE POS ="PF" AND "FT%" >= "0.80" AND GP>="50"
ORDER BY PTS DESC
limit 10;


/* Top Small Forward with at least 80% ft, played 50 games, and ranked 40+ 
Mikal Bridges or Jerami Grant are the picks we are going for due to filling the Small Forward position and their overall stats are what we are looking for in the 5th or 6th round*/

Select Player, RK, PTS, "3PM", "FT%", STPG
FROM NBA_ESPN_Data
Where POS = "SF" AND RK >="40"  AND "FT%" >= "0.75" AND GP >= "50"


/* Highest 3PM players with at least 45 games played and ranked 80+*/
/* There are some players who provide solid 3PM Shooting in the later rounds */
/* Buddy Hield, Jordan Poole, Gary Trent Jr. and O.G Anunoby are great picks for rounds 8 to 10 due to their high FT%, solid points,  3PM, and steals per night */
Select PLAYER, POS, RK, APG, "3PM", STPG, PTS, "FT%"
FROM NBA_ESPN_Data
Where GP >= "45" and RK >= "80" AND "FT%" >= "0.80"  AND PTS >= "15"
ORDER BY "3PM" DESC



/* Who averages the most Assists above Rank 60, played at least 45 games, FT% greater than 80%, and averages at least 10 points per game
We would need players in the later rounds that averages high assist per game and consistently plays*/
/* Chris Paul, D'Angelo Russel are our main 2 target to grab in the 5th round. Mike Conley, Tre Jones, Jordan Poole, and Spencer Dinwiddie are all great options afterwards*/
SELECT PLAYER, RK, APG, STPG, "FT%", "3PM", PTS
FROM NBA_ESPN_Data
Where RK >="60" AND GP >= "45" AND "FT%" >= "0.8" AND PTS >= "10.0"
ORDER BY APG DESC
LIMIT 10;

/* Highest APG players with at least 45 games played and ranked 80+*/
/* There are some players who provide solid APG in the later rounds */
/* Mike Conley, Tre Jones, Jordan Poole, Killian Hayes, and Marcus Smart are the players we would like to draft in the later rounds */
Select PLAYER, POS, RK, APG, "3PM", STPG
FROM NBA_ESPN_Data
Where GP >= "45" and RK >= "80"
ORDER BY APG DESC
LIMIT 15;


/* Who averages at least 1.5 Steals per game and has a 75% and greater FT%
We want to find lower ESPN players (later picks in the round) to fill this role of averaging the most steals per game 
O.G. Anunoby & Gary Trent Jr. are awesome picks later in the rounds that gives us high FT%, at least 2 3PM, and at least 1.5 steals per game with 15+ pts */

Select PLAYER, RK, GP, STPG, "FT%", "3PM", PTS
FROM NBA_ESPN_Data
Where RK >="80" AND GP >= "50" AND "FT" >= ".75"
ORDER BY STPG DESC


/* What 5 players that are not PG has the highest 3PM with over 50 games and 80% FT  that are ranked above 60
Klay Thompson, Buddy Hield, Anfernee Simons are solid players to consider for 3PM that are not PGs
I would select Buddy Hield over Klay due to averaging 1.2 STPG and is ranked higher which can be drafted later in the rounds*/

SELECT *
FROM NBA_ESPN_Data
WHERE GP >"50" AND "FT%" >= ".8" AND "3PM" >= 1 AND RK >= "60" AND NOT POS = "PG"
ORDER BY "3PM" DESC
limit 5;

/* Who plays the most minutes per game in the NBA and played at least 45 games in the season */

SELECT *
FROM NBA_ESPN_Data
WHERE GP>= "45"
ORDER BY MPG DESC

/*
Assuming I am first pick in a snake draft
1st pick
Jokic, Embiid, Steph, Damian
2nd pick
Lauri, James Harden
3rd pick
Porzingis , Bam Adebayo
4th pick
Jamal Murray, Fred VanVleet
5th pick
Chris Paul, Mikal Bridges
6th pick/ 7th pick
Anfernee Simons, Spencer Dinwiddie, Jordan Poole, Jerami Grant, Buddy Hield
8th pick
Tre Jones, Kris Middleton, O.G. Anunoby
9th pick
Gary Trent Jr., Mike Conley, Trey Murphy III

*/


/* The Data that can help us improve our draft picks would be 
- implementing Free Throw and Shot Attempts per game for each player
- the age of the player
- stats of rookies drafted 2023 
- up to date player trades during the offseason*/