--check duplicates
SELECT Club, count(*) as Duplicates
FROM Euro
GROUP BY Club
HAVING count(*) > 1;

--check most clubs
select COALESCE(e.Club, c.Club) AS Club,
    ISNULL(e.Players_from_club, 0) AS EuroPlayers,
    ISNULL(c.Players_from_club, 0) AS CopaPlayers,
    ISNULL(e.Players_from_club, 0) + ISNULL(c.Players_from_club, 0) AS TotalPlayers
from euro e
full outer join copa c
on e.club = c.club
order by TotalPlayers desc

--check most leagues	
SELECT
	COALESCE(e.Country, c.Country) AS Country,
    COALESCE(e.competition, c.competition) AS competition,
    ISNULL(e.TotalPlayersEuro, 0) AS TotalPlayersEuro,
    ISNULL(c.TotalPlayersCopa, 0) AS TotalPlayersCopa,
    ISNULL(e.TotalPlayersEuro, 0) + ISNULL(c.TotalPlayersCopa, 0) AS TotalPlayers
FROM 
    (SELECT country, competition, SUM(Players_from_club) AS TotalPlayersEuro
     FROM Euro
     GROUP BY country, competition) e
FULL OUTER JOIN 
    (SELECT country, competition, SUM(Players_from_club) AS TotalPlayersCopa
     FROM Copa
     GROUP BY country, competition) c
ON 
    e.competition = c.competition and e.country = c.country

order by TotalPlayers desc