CREATE DATABASE IF NOT EXISTS `PROJETO`;
USE `PROJETO`;

DROP TABLE IF EXISTS STATS, PLAYERS, `SEASONS`, POSITIONS, COUNTRIES, TEAMS, CONFERENCES, DIVISIONS, ARENAS;

CREATE TABLE IF NOT EXISTS CONFERENCES(
  conferenceId INTEGER PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS ARENAS(
    arenaId INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(150) NOT NULL
);    


CREATE TABLE IF NOT EXISTS DIVISIONS(
  divisionId INTEGER PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(20) NOT NULL
);


CREATE TABLE IF NOT EXISTS TEAMS(
    teamId INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    conferenceId INT NOT NULL,
    divisionId INT NOT NULL,
    arenaId INT NOT NULL UNIQUE,
    FOREIGN KEY (arenaId) REFERENCES ARENAS(arenaId),
    FOREIGN KEY(conferenceId) REFERENCES CONFERENCES(conferenceId),
    FOREIGN KEY(divisionId) REFERENCES DIVISIONS(divisionId)
);

CREATE TABLE IF NOT EXISTS COUNTRIES(
    countryId INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);
CREATE TABLE IF NOT EXISTS POSITIONS(
    positionId INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS PLAYERS(
    playerId INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(150) NOT NULL,
    number INT NOT NULL,
    positionId INT NOT NULL,
    teamId INT,
    height INT NOT NULL,
    weight INT NOT NULL,
    countryId INT NOT NULL,
    birthdate DATE NOT NULL,
    FOREIGN KEY(teamId) REFERENCES TEAMS(teamId),
    FOREIGN KEY(countryId) REFERENCES COUNTRIES(countryId),
    FOREIGN KEY(positionId) REFERENCES POSITIONS(positionId)
);

CREATE TABLE SEASONS(
    seasonId INT PRIMARY KEY AUTO_INCREMENT,
    startDate DATE NOT NULL,
    endDate DATE NOT NULL,
    championId INT NOT NULL,
    mvpId INT NOT NULL,
    rotyId INT NOT NULL,
    mipyId INT NOT NULL,
    dpoyId INT NOT NULL,
    FOREIGN KEY(championId) REFERENCES TEAMS(teamId),
    FOREIGN KEY(mvpId) REFERENCES PLAYERS(playerId)
);

CREATE TABLE STATS(
    playerId INT NOT NULL,
    teamId INT NOT NULL,
    seasonId INT NOT NULL,
    games INT NOT NULL,
    games_started INT NOT NULL,
    points INT NOT NULL,
    rebounds INT NOT NULL,
    assists INT NOT NULL,
    steals INT NOT NULL,
    blocks INT NOT NULL,
    turnovers INT NOT NULL, 
    PRIMARY KEY(playerId, seasonId),
    FOREIGN KEY(playerId) REFERENCES PLAYERS(playerId),
    FOREIGN KEY(teamId) REFERENCES TEAMS(teamId),
    FOREIGN KEY(seasonId) REFERENCES SEASONS(seasonId)
);

INSERT INTO `ARENAS` (name) VALUES 
('Madison Square Garden'),
('American Airlines Center'),
('Oracle Arena'),
('State Farm Arena'),
('TD Garden'),
('Barclays Center'),
('Spectrum Center'),
('United Center'),
('Rocket Mortgage FieldHouse'),
('Ball Arena'),
('Little Caesars Arena'),
('Chase Center'),
('Toyota Center'),
('Bankers Life Fieldhouse'),
('Staples Center'),
('FedExForum'),
('FTX Arena'),	
('Fiserv Forum'),	
('Target Center'),
('Smoothie King Center'),
('Paycom Center'),
('Amway Center'),
('Wells Fargo Center'),
('Footprint Center'),
('Moda Center'),
('Golden 1 Center'),
('AT&T Center'),
('Scotiabank Arena'),
('Vivint Arena'),
('Capital One Arena');

INSERT INTO `CONFERENCES` (`conferenceId`, `name`) VALUES
(1, 'Eastern'),
(2, 'Western');

INSERT INTO `DIVISIONS` (`name`) VALUES
('Atlantic'),
('Central'),
('Southeast'),
('Northwest'),
('Pacific'),
('Southwest');

INSERT INTO `TEAMS` (`name`, `conferenceId`, `divisionId`,`arenaId`) VALUES
('Boston Celtics', 1, 1,1),
('Brooklyn Nets', 1, 1,2),
('New York Knicks', 1, 1,3),
('Philadelphia 76ers', 1, 1,4),
('Toronto Raptors', 1, 1,5),
('Chicago Bulls', 1, 2,6),
('Cleveland Cavaliers', 1, 2,7),
('Detroit Pistons', 1, 2,8),
('Indiana Pacers', 1, 2,9),
('Milwaukee Bucks', 1, 2,10),
('Atlanta Hawks', 1, 3,11),
('Charlotte Hornets', 1, 3,12),
('Miami Heat', 1, 3,13),
('Washington Wizards', 1,3,14),
('Orlando Magic', 1, 3,15),
('Denver Nuggets', 2, 4,16),
('Minnesota Timberwolves', 2, 4,17),
('Utah Jazz', 2, 4,18),
('Portland Trail Blazers', 2, 4,19),
('Oklahoma City Thunder', 2, 4,20),
('Golden State Warriors', 2, 5,21),
('LA Clippers', 2, 5,22),
('Los Angeles Lakers', 2, 5,23),
('Phoenix Suns', 2, 5,24),
('Sacramento Kings', 2, 5,25),
('Dallas Mavericks', 2, 6,26),
('Houston Rockets', 2, 6,27),
('Memphis Grizzlies', 2, 6,28),
('New Orleans Pelicans', 2, 6,29),
('San Antonio Spurs', 2, 6,30);

INSERT INTO `COUNTRIES` (name) VALUES
('USA'),
('Canada'),
('Mexico'),
('France'),
('Germany'),
('Italy'),
('Spain'),
('Argentina'),
('Brazil'),
('China'),
('Japan'),
('Russia'),
('South Korea'),
('Australia'),
('New Zealand'),
('Portugal'),
('Netherlands'),
('Belgium'),
('Switzerland'),
('Austria'),
('Finland'),
('Sweden'),
('Norway'),
('Denmark'),
('Iceland'),
('Poland'),
('Czech Republic'),
('Hungary'),
('Romania'),
('Greece'),
('Croatia'),
('Serbia'),
('Ukraine'),
('Slovakia'),
('Estonia'),
('Latvia'),
('Lithuania'),
('Bulgaria'),
('Albania'),
('Macedonia'),
('Bosnia and Herzegovina'),
('Algeria'),
('Egypt'),
('Morocco'),
('Tunisia'),
('Libya'),
('Sudan'),
('South Africa'),
('Kenya'),
('Ethiopia'),
('Uganda'),
('Somalia'),
('Kenya'),
('Mozambique'),
('Zambia'),
('Zimbabwe'),
('Ghana'),
('Nigeria'),
('Cameroon'),
('Ivory Coast'),
('Burkina Faso'),
('Mali'),
('Guinea'),
('Guinea-Bissau'),
('Liberia'),
('Sierra Leone'),
('Togo'),
('Benin'),
('Mauritania'),
('Mauritius');

INSERT INTO `POSITIONS` (name) VALUES
('Point Guard'),
('Shooting Guard'),
('Small Forward'),
('Power Forward'),
('Center');


INSERT INTO PLAYERS (name, number, positionId, teamId, height, weight, countryId, birthdate) VALUES
('Lebron James', 23, 3, 23, 206, 113, 1, '1984-12-30'),
('Kevin Durant', 7, 4, 2, 208, 108, 1, '1988-09-29'),
('Stephen Curry', 30, 1, 21, 188, 83, 1, '1988-03-14'),
('Kawhi Leonard', 2, 3, 22, 201, 102, 1, '1991-06-29'),
('James Harden', 13, 2, 2, 196, 99, 1, '1989-08-26'),
('Draymond Green', 23, 3, 22, 198, 104, 1, '1990-03-04'),
('Kevin Love', 0, 4, 7, 203, 113, 1, '1988-09-07'),
('Chris Paul', 3, 1, 24, 183, 79, 1, '1985-05-06'),
('Giannis Antetokounmpo', 34, 4, 10, 211, 109, 23, '1994-12-06'),
('Russell Westbrook', 0, 1, 23, 190, 90, 1, '1988-11-12'),
('Klay Thompson', 11, 2, 21, 198, 97, 1, '1990-02-08'),
('Damian Lillard', 0, 1, 19, 188, 88, 1, '1990-07-15'),
('Dirk Nowitzki', 41, 4, NULL, 213, 111, 1, '1978-07-19'),
('DeMarcus Cousins', 15, 5, NULL, 208, 122, 1, '1990-08-13'),
('Gordon Hayward', 20, 3, 12, 201, 102, 1, '1990-03-23'),
('Paul George', 13, 2, 22, 203, 99, 1, '1990-05-02'),
('Rudy Gobert', 27, 5, 18, 216, 117,3,'1992-06-26');

INSERT INTO `SEASONS` (startDate, endDate, championId, mvpId, rotyId, mipyId, dpoyId) VALUES
('2015-10-01', '2016-04-30', 23, 12,1,12,12),
('2016-10-01', '2017-04-30', 23, 1,3,11,1),
('2017-10-01', '2018-04-30', 28, 3,7,11,3),
('2018-10-01', '2019-04-30', 12, 1,9,1,2),
('2019-10-01', '2020-04-30', 12, 7,15,7,4),
('2020-10-01', '2021-04-30', 19, 9,2,4,4),
('2021-10-01', '2022-04-30', 19, 15,6,5,4);

INSERT INTO `STATS` (playerId, teamId, seasonId, games, games_started, points, rebounds, assists, steals, blocks, turnovers) VALUES
(1, 1, 1, 82, 58, 8202, 320, 140, 590, 50, 590),
(2, 1, 1, 82, 82, 940, 123, 90, 590, 990, 390),
(3, 1, 1, 82, 78, 205, 530, 78, 590, 510, 523),
(4, 1, 1, 82, 56, 6250, 590, 79, 590, 530, 190),
(5, 1, 1, 82, 80, 4105, 190, 211, 592, 390,290),
(6, 1, 1, 80, 80, 3930, 290, 70, 590, 590, 342),
(7, 1, 1, 82, 82, 3500, 130, 330, 504, 390, 193),
(8, 1, 1, 82, 82, 1740, 990, 730, 520, 890, 903),
(9, 1, 1, 82, 82, 3230, 1590, 710, 430, 500, 290);
