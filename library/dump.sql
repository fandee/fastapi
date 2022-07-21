CREATE DATABASE library;

CREATE TABLE genres (
    id serial PRIMARY KEY,
    genre VARCHAR(50) NOT NULL,
    CONSTRAINT genre_u UNIQUE(genre)
);

CREATE TABLE authors (
    id serial PRIMARY KEY,
    author_name varchar(50) NOT NULL,
    CONSTRAINT author_name_U UNIQUE(author_name)
);

CREATE TABLE books (
    id serial PRIMARY KEY,
    title varchar(50) NOT NULL,
    author_id integer NOT NULL DEFAULT 1,
    pages smallint DEFAULT(100),
    CONSTRAINT fk_author FOREIGN KEY(author_id) REFERENCES authors(id) ON DELETE SET DEFAULT
);

CREATE TABLE book_genre (
    book_id integer NOT NULL,
    genre_id integer NOT NULL,
    CONSTRAINT fk_book
        FOREIGN KEY(book_id) REFERENCES books(id) ON DELETE CASCADE,
    CONSTRAINT fk_genre
        FOREIGN KEY(genre_id) REFERENCES genres(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS public.libraries
(
    id serial PRIMARY KEY,
    name varchar(50) NOT NULL,
    address varchar(50) NOT NULL
)

CREATE TABLE IF NOT EXISTS public.library_book
(
    library_id integer NOT NULL,
    book_id integer NOT NULL,
    stock integer NOT NULL DEFAULT 1,
    CONSTRAINT fk_library FOREIGN KEY (library_id)
        REFERENCES public.libraries (id)
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT fk_book FOREIGN KEY (book_id)
        REFERENCES public.books (id)
        ON UPDATE NO ACTION
        ON DELETE CASCADE
)

INSERT INTO genres (genre) VALUES ('gray'),('green'),('lime'),('navy'),('purple');
INSERT INTO authors (author_name) VALUES ('unknown');
INSERT INTO authors (author_name) VALUES ('Abraham Jakubowski'),('Adella Kuhn III'),('Alanna Walsh'),('Alvina Shanahan'),('Antonetta Romaguera PhD'),('Arden Schuppe'),('Arlo Monahan'),('Aron Ullrich'),('Bridie Kertzmann'),('Bryana Rowe'),('Camilla Bailey'),('Clifton Streich MD'),('Cordelia Fay'),('Cynthia Hettinger II'),('Danielle Murray DVM'),('Darien Dickinson'),('Dena Haley Jr.'),('Desmond Swift DVM'),('Dina Rohan'),('Dr. Carlotta Powlowski Sr.'),('Dr. Delores Stokes'),('Dr. Dora Denesik III'),('Dr. Josiane Hand Sr.'),('Dr. Kariane Yundt'),('Dr. Marcel Gleichner'),('Dr. Megane Pfannerstill'),('Dr. Merlin Trantow'),('Dr. Velma Macejkovic Jr.'),('Dr. Winifred Vandervort'),('Earlene Fadel Jr.'),('Easton Schoen'),('Ebony Cummings'),('Effie Kilback'),('Elza McDermott MD'),('Gay Prohaska'),('Gunner Macejkovic'),('Hardy Goldner'),('Harley Pagac'),('Ignacio Haag PhD'),('Jalon Emmerich'),('Jeremy Schaden'),('Joanny Bayer'),('Keenan Becker'),('Kevon Watsica'),('Kiley Wintheiser'),('Kris Kuphal Sr.'),('Laisha Haag'),('Layne Goyette'),('Leanne Mayer'),('Lenora Jacobson'),('Leone Glover'),('Lillie Nicolas II'),('Lisette McLaughlin'),('Llewellyn Carroll'),('Lorena Dare'),('Lou Kihn'),('Lukas Reinger Jr.'),('Lynn Schroeder I'),('Maida Stracke II'),('Marielle Turcotte'),('Mathias Sauer'),('Mikel Johnston'),('Miss Beverly Hilpert'),('Miss Lizeth Mitchell'),('Miss Mattie Harvey IV'),('Miss Myrna Macejkovic'),('Mr. Armani Dare MD'),('Mr. Bradley Smith MD'),('Mr. Earnest Prohaska MD'),('Mr. Fausto Nienow'),('Mr. Henry Cormier'),('Mr. Rey Prosacco'),('Mr. Scotty Cummerata'),('Mrs. Adelia Ratke Jr.'),('Mrs. Courtney Ward'),('Mrs. Eula Davis IV'),('Ms. Shana Ullrich'),('Nya Tremblay'),('Ollie Christiansen III'),('Orpha Windler'),('Osvaldo Keebler'),('Payton Casper III'),('Prof. Bill Rice Sr.'),('Prof. Darwin Mueller III'),('Prof. Ellis Hodkiewicz'),('Prof. Forest Smitham III'),('Prof. Izaiah Stracke I'),('Prof. Mervin Hamill I'),('Prof. Sarai Pollich'),('Prof. Treva Bode'),('Prof. Waldo Pfannerstill PhD'),('Rubie Blanda IV'),('Santina McLaughlin'),('Skyla Howell Jr.'),('Tavares Gulgowski'),('Travis Kshlerin'),('Trudie Flatley'),('Tyrese Donnelly'),('Verna Langosh'),('Ward Balistreri');
INSERT INTO books (title, author_id, pages) VALUES ('Kling Ways',101,8442),('Labadie Street',43,5731),('Russel Pike',63,4957),('Burley Ridge',33,2199),('Irving Village',23,5983),('Madelyn Trace',1,7694),('Noe Lane',1,1497),('Beier Mews',87,3717),('Wolf Rapids',45,5558),('Maximillia Heights',39,2355),('Selmer Causeway',85,8704),('Adam Field',15,7659),('Hilpert Stream',57,6232),('Stokes Hollow',80,8650),('Kilback Ports',96,3807),('Alejandrin Forks',82,9646),('Oberbrunner Squares',50,5152),('Raynor Brook',27,5563),('Corkery Mission',23,6008),('Orn Gardens',23,6022),('Murphy Camp',50,8508),('Haskell Burgs',50,455),('Bill Squares',59,3934),('Toy Bypass',16,9442),('Trantow Throughway',71,8338),('Braxton Avenue',58,7807),('Schaefer Circles',87,3564),('Newton Club',47,3952),('Yundt Trace',37,5001),('Weimann Keys',36,2920),('Gibson Cape',29,4577),('Erin Stream',79,2205),('Spinka Union',60,5364),('Rodriguez Orchard',46,1279),('Mollie Oval',65,607),('Wiza Mission',41,8047),('Walter Overpass',53,2929),('Marina Union',64,1584),('Yost Pike',29,7971),('Fahey Station',52,1306),('Muriel Causeway',79,5436),('Gibson Viaduct',18,8350),('DuBuque Viaduct',96,6325),('Makayla Hill',73,6829),('Orn Forge',95,6086),('Tromp Mission',26,9169),('Jarrod Fort',100,139),('Adrienne Forks',53,7080),('Laron Square',1,9985),('Little Square',34,1160),('Kihn Hills',74,9016),('Audrey Tunnel',61,2706),('Jameson Key',62,6560),('Klocko Glen',24,3163),('Doyle Creek',28,2997),('Pagac Inlet',99,2994),('Simonis Well',54,167),('Hessel Radial',24,2334),('Kathleen Manors',11,2850),('Hamill Forks',3,9301),('Flavio Junctions',27,1233),('Beau Port',16,4735),('Greenfelder Crossing',88,2236),('Oceane Islands',86,8441),('Lind Forge',63,1351),('Grant Curve',2,8263),('Mertz Islands',77,5677),('Becker Place',78,3937),('Prohaska Gateway',4,3959),('Padberg Harbors',12,1874),('Reymundo Union',72,3392),('Ansel Rest',58,8930),('Adonis Freeway',87,2073),('Jimmie Shoals',17,6593),('Kaycee Keys',74,3267),('Kovacek Villages',42,7818),('Hettinger Junction',53,5786),('Gottlieb Fields',93,1358),('Ramon Ranch',52,3761),('Marques Knoll',67,5920),('Nicolette Turnpike',7,1931),('Salma Viaduct',17,4775),('Jasmin Lane',74,738),('Westley Turnpike',19,5076),('Huel Port',17,3545),('Lockman Islands',52,6540),('Nienow Underpass',66,9374),('Adela Gateway',36,8416),('Purdy Extension',72,7605),('Bergstrom Port',86,4251),('Herman Crossroad',56,9727),('Morissette Streets',57,5105),('Bradtke Expressway',59,4278),('Blaze Terrace',91,2973),('Lesch Cove',65,6034),('Pfannerstill Locks',13,5653),('Julianne Port',44,5279),('Julian Spurs',43,9527),('Wiegand Camp',18,5170),('Larkin Point',28,7487),('Anastasia Forges',75,9478),('Franecki Path',15,2244),('Buckridge Bridge',25,5611),('Caroline Courts',65,7363),('Ruecker Walk',46,2722),('Hilpert Well',84,2967),('Corkery Rest',52,3279),('Gutkowski Route',58,5476),('Jadon Skyway',29,8653),('Courtney Walks',40,8997),('Angie Port',71,3420),('Gaetano Creek',14,1733),('Pfeffer Divide',27,7846),('Amaya Mountains',42,9189),('Herman Knolls',88,669),('Walsh Drives',50,3966),('Wilkinson Mountains',68,8610),('Heaney Motorway',78,984),('Cummerata Ranch',36,2598),('Armando Causeway',100,8615),('Kuhn Branch',28,2544),('Ansley Coves',83,519),('Sylvan Trail',37,3130),('Harvey Harbors',48,4302),('Auer Isle',101,3524),('Rahsaan Place',44,887),('Adalberto Lights',18,5721),('Nitzsche Squares',36,1408),('Hudson Mall',71,5372),('Heathcote Village',18,7307),('Greenfelder Forges',30,7951),('Vandervort Spurs',29,7198),('Erin Manors',33,4310),('Borer Park',6,2498),('Witting Points',56,3444),('Prohaska Turnpike',61,2723),('Wallace Field',47,233),('Funk Glens',23,7247),('Towne Corner',36,9629),('Rosina Trail',91,749),('Arianna Streets',101,8644),('Ray Pike',80,6743),('Mueller Port',50,9796),('Stokes Common',25,5137),('Jacobs Meadow',99,6540),('Hudson Ridge',11,1247),('Shawna Street',19,6608),('Laisha Drives',27,9787),('Betsy Club',19,8926),('Koch Fall',80,5329),('Dooley Land',84,3472),('Gianni Walks',14,331),('Lubowitz Lodge',94,6639),('Darion Course',34,6905),('Doyle Grove',21,6922),('Amanda Ferry',10,2255),('Savion Heights',11,1629),('Klocko Mount',77,2710),('Rohan Hills',16,6676),('Kuhic Creek',78,8483),('Schimmel Lodge',101,4930),('Heber Park',6,2487),('Katarina Meadows',20,7900),('Mann Islands',85,7511),('Koelpin Center',2,1671),('Lilla Tunnel',37,9118),('Karelle Drive',75,2572),('Bahringer Mountain',41,9318),('Volkman Plaza',52,5796),('Gilbert Crossroad',57,794),('Keagan Tunnel',63,122),('Enid Ville',13,1823),('Shyanne Forest',53,1890),('Athena Parks',9,1460),('Pedro Mountains',84,7281),('Hessel Parkways',57,9209),('Celestino Stravenue',87,9114),('Hamill Squares',48,3964),('Eichmann Fields',66,8027),('Doyle Meadow',18,6682),('Rippin Mountains',35,2527),('Hilll Fort',91,1387),('Cummerata Haven',23,2292),('Paucek Vista',45,5266),('Jenkins Mills',24,1679),('Janae Shoals',56,5844),('Abelardo Circle',47,2969),('Rhett Station',93,1222),('Jaqueline Point',47,1826),('Jakubowski Key',20,1974),('Jayde Lane',30,7685),('Abshire Village',77,1303),('Wilkinson Station',95,5945),('Nasir Glens',7,6575),('Jacobi Manors',47,5930),('Laura Walks',75,3678),('Pacocha Island',11,8004),('Zemlak Summit',37,242),('Kunde Port',9,3554),('Nick Trafficway',72,6770);
INSERT INTO book_genre VALUES (30,3),(28,2),(57,1),(34,3),(106,3),(49,5),(62,4),(124,5),(196,3),(108,5),(144,2),(131,2),(153,2),(185,1),(178,2),(126,4),(59,1),(125,5),(23,1),(34,5),(106,4),(63,2),(173,4),(121,1),(51,5),(53,3),(92,2),(76,3),(149,3),(55,3),(88,4),(9,2),(20,4),(117,4),(176,3),(53,4),(34,5),(96,3),(191,1),(183,2),(128,5),(72,3),(11,5),(164,1),(68,3),(47,1),(76,4),(61,4),(97,2),(119,1),(135,2),(155,5),(33,4),(169,2),(120,4),(45,2),(128,3),(28,4),(76,4),(158,5),(162,5),(166,1),(171,4),(88,2),(85,4),(39,5),(65,2),(116,5),(135,5),(139,2),(38,4),(174,3),(181,1),(193,2),(57,5),(103,1),(95,5),(131,2),(137,4),(25,4),(34,1),(63,2),(151,2),(65,5),(143,5),(91,1),(96,1),(150,5),(37,3),(181,5),(194,3),(30,4),(45,1),(69,2),(137,5),(132,3),(121,4),(145,4),(46,1),(96,3),(66,4),(70,3),(168,4),(175,1),(181,2),(3,4),(104,3),(125,2),(162,4),(138,4),(164,4),(38,1),(92,2),(12,4),(200,5),(174,5),(172,4),(28,1),(92,2),(195,1),(21,3),(94,5),(78,4),(171,3),(85,4),(24,3),(35,4),(10,5),(35,2),(99,4),(110,1),(9,2),(96,5),(118,3),(55,5),(173,5),(67,5),(117,5),(174,4),(135,4),(70,1),(2,4),(58,5),(92,3),(128,4),(145,1),(88,2),(59,5),(65,4),(168,3),(1,5),(62,5),(181,4),(192,4),(108,1),(171,1),(130,3),(152,1),(15,5),(200,2),(87,3),(47,2),(9,1),(2,4),(147,2),(144,4),(51,3),(90,3),(72,4),(181,3),(135,1),(188,3),(33,2),(21,5),(94,5),(181,3),(146,1),(19,3),(100,2),(195,3),(20,2),(57,1),(96,4),(154,2),(1,5),(18,2),(87,4),(140,5),(162,5),(61,2),(87,2),(61,3),(69,2),(35,5),(80,4),(138,5),(171,4),(24,2),(10,1),(190,2),(1,5),(131,2),(28,4),(176,3),(40,5),(24,2),(26,3),(135,5),(94,2),(178,4),(133,1),(157,5),(99,5),(139,4),(65,3),(148,4),(163,2),(38,1),(123,1),(32,5),(96,4),(143,2),(69,3),(167,4),(193,5),(121,4),(118,2),(92,1),(78,5),(32,4),(116,1),(132,4),(31,5),(42,2),(19,2),(192,4),(186,5),(190,2),(58,4),(36,1),(145,3),(57,2),(18,5),(80,1),(168,4),(123,2),(199,1),(133,2),(128,4),(123,1),(120,4),(37,4),(147,1),(3,1),(20,4),(166,5),(144,4),(102,3),(140,5),(52,4),(24,3),(107,1),(7,5),(153,1),(70,5),(178,3),(13,4),(12,3),(200,5),(68,3),(150,3),(154,4),(172,3),(189,4),(106,4),(64,2),(108,3),(30,4),(120,3),(189,2),(31,2),(87,1),(145,3),(99,5),(168,2),(59,4),(164,1),(187,5),(62,5),(125,1),(44,5),(89,1),(69,4),(110,5),(32,3),(39,2),(54,5),(123,2),(35,3),(14,2);
