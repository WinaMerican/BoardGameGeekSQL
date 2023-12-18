Select * 
From dbo.Games
Order by BGGId

--check for any NULL
Select *
from dbo.Games
where Name is NULL

Select *
from dbo.Games
where YearPublished is NULL

Select *
from dbo.Games
where AvgRating is NULL

Select *
from dbo.Games
where MinPlayers is NULL

Select *
from dbo.Games
where MaxPlayers is NULL

Select *
from dbo.Games
where Family is NULL

--set NULL to Not Specified for family
Update dbo.Games
Set Family = 'Not Specified'
Where Family is NULL

--set recommended age to whole number
Alter Table Games
add RecAge float;

Update Games
set RecAge = cast (ComAgeRec as decimal(10,0));

--Replace RecAge Null with Recommended age from manufacturer
Update dbo.Games
Set RecAge = MfgAgeRec
Where RecAge is Null

--identify min and max recommended age
Select min(RecAge)
from Games

Select max(RecAge)
from Games

--set GameWeight to 2 decimal point
Alter Table Games
add GameWeightDec float;

Update Games
set GameWeightDec = cast (GameWeight as decimal(10,2));

--to deteremine the range for gameweight
Select min(GameWeightDec)
from Games

Select max(GameWeightDec)
from Games
-- 0 being the easiest, 5 the hardest

--set Average Rating to 2 decimal point
Alter Table Games
add AvgRate float;

Update Games
set AvgRate = cast (AvgRating as decimal(10,2));

--to deteremine the range for gameweight
Select min(AvgRate)
from Games

Select max(AvgRate)
from Games
-- 1.04 lowesst rating, 9.91 highest rating

--Min player
Select min(MinPlayers)
from Games
--min player = 0, need to dive into the games
Select * 
From dbo.Games
Where MinPlayers = 0
--a lot of games with 0 min and 0 max player
--game with no specified number of players

Select max(MaxPlayers)
from Games
--max players = 999 people

--determine the earliest and latest game
Select min(YearPublished)
from Games
--there are games from 3500 B.C, to check the games B.C
Select *
From Games
Where YearPublished <= 0

Select max(YearPublished)
from Games
--latest game is 2021 from the dataset

--To drop columns that we dont need
Alter Table Games
Drop Column Description, BayesAvgRating, StdDev, ComAgeRec, BestPlayers, GoodPlayers, NumWeightVotes, MfgPlaytime, MfgAgeRec, NumUserRatings, NumComments, NumAlternates, NumExpansions, NumImplementations, IsReimplementation, Kickstarted, ImagePath;

Alter Table Games
Drop Column LanguageEase, AvgRating, GameWeight;

Select Count(DISTINCT [Rank:boardgame]) as rank_board_dist,
	   Count([Rank:boardgame]) as rank_boardgame,
	   Count(DISTINCT [Rank:strategygames]) as rank_strategy_dist,
	   Count([Rank:strategygames]) as rank_strategy,
	   Count(DISTINCT [Rank:abstracts]) as rank_abstract_dist,
	   Count([Rank:abstracts]) as rank_abstract,
	   Count(DISTINCT [Rank:familygames]) as rank_family_dist,
	   Count([Rank:familygames]) as rank_family,
	   Count(DISTINCT [Rank:thematic]) as rank_thematic_dist,
	   Count([Rank:thematic]) as rank_thematic,
	   Count(DISTINCT [Rank:cgs]) as rank_cgs_dist,
	   Count([Rank:cgs]) as rank_cgs,
	   Count(DISTINCT [Rank:wargames]) as rank_war_dist,
	   Count([Rank:wargames]) as rank_war,
	   Count(DISTINCT [Rank:partygames]) as rank_party_dist,
	   Count([Rank:partygames]) as rank_party,
	   Count(DISTINCT [Rank:childrensgames]) as rank_children_dist,
	   Count([Rank:childrensgames]) as rank_children
From Games
--there are more than 1 games in a ranking, some games share ranks

Select *
From Games
Order by BGGId

Select *
From Games
Where [Rank:boardgame] <= 50
Order by [Rank:boardgame]

SELECT main.[BGGId]
      ,main.[Name]
      ,main.[YearPublished]
      ,main.[MinPlayers]
      ,main.[MaxPlayers]
      ,main.[NumOwned]
      ,main.[NumWant]
      ,main.[NumWish]
      ,main.[ComMinPlaytime]
      ,main.[ComMaxPlaytime]
      ,main.[Family]
      ,main.[Rank:boardgame]
      ,main.[Rank:strategygames]
      ,main.[Rank:abstracts]
      ,main.[Rank:familygames]
      ,main.[Rank:thematic]
      ,main.[Rank:cgs]
      ,main.[Rank:wargames]
      ,main.[Rank:partygames]
      ,main.[Rank:childrensgames]
      ,main.[Cat:Thematic]
      ,main.[Cat:Strategy]
      ,main.[Cat:War]
      ,main.[Cat:Family]
      ,main.[Cat:CGS]
      ,main.[Cat:Abstract]
      ,main.[Cat:Party]
      ,main.[Cat:Childrens]
      ,main.[RecAge]
      ,main.[GameWeightDec]
      ,main.[AvgRate]
      ,sub.[Exploration]
      ,sub.[Miniatures]
      ,sub.[Territory Building]
      ,sub.[Card Game]
      ,sub.[Educational]
      ,sub.[Puzzle]
      ,sub.[Collectible Components]
      ,sub.[Word Game]
      ,sub.[Print & Play]
      ,sub.[Electronic]
Into BoardGameGeek
FROM [dbo].[Games] as main
Inner Join [dbo].[subcategories$] as sub
On main.BGGId = sub.BGGId
Where [Rank:boardgame] <= 50

Select *
From BoardGameGeek
Order by [Rank:boardgame]

