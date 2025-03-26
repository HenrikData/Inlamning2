/*
Här är del 2 av min bokhandel. Skapad av Henrik Karlsson YH2024.
*/

-- Skapar databasen och döper den till Your_Bookstore_2
CREATE DATABASE Your_Bookstore_2;
USE Your_Bookstore_2;

-- Skapa tabellen Kunder
CREATE TABLE Kunder (
    KundID INT AUTO_INCREMENT PRIMARY KEY, -- Primär nyckel, skapar unikt id för varje kund
    Namn VARCHAR(100) NOT NULL, -- textsträng med max 100 tecken
    Epost VARCHAR(255) UNIQUE NOT NULL, -- måste vara unikt
    Telefon VARCHAR(100) NOT NULL, -- textsträng med max 100 tecken
    Adress VARCHAR(255) NOT NULL -- textsträng med max 250 tecken
);

-- Skapa tabellen Böcker
CREATE TABLE Böcker (
    ISBN VARCHAR(100) NOT NULL PRIMARY KEY,  -- tolkar ISBN som en textsträng  
    Författare VARCHAR(100),
    Titel VARCHAR(255) NOT NULL,
    Pris DECIMAL(10,2) NOT NULL CHECK (Pris > 0), -- tal med max 10 siffror inkl decimal. pris måste vara större än 0
    Lagerstatus INT NOT NULL
);

-- Skapa tabellen Beställningar
CREATE TABLE Beställningar (
    Ordernummer INT AUTO_INCREMENT PRIMARY KEY,
    KundID INT NOT NULL, -- samband med FK längst ner i denna tabell
    Datum TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- den aktuella tiden anges i samband med ordern
    Totalbelopp DECIMAL(10,2) NOT NULL CHECK (Totalbelopp > 0),
    FOREIGN KEY (KundID) REFERENCES Kunder(KundID) -- främmande nyckel ifrån tabellen kunder
);

-- Skapa tabellen Orderrader

CREATE TABLE Orderrader (
    OrderradID INT AUTO_INCREMENT PRIMARY KEY,
    Ordernummer INT NOT NULL, -- samband med FK längre ner i denna tabell
    ISBN VARCHAR(100) NOT NULL, -- samband med FK längre ner i denna tabell
    Antal INT NOT NULL CHECK (Antal > 0),
    Delbelopp DECIMAL(10,2) NOT NULL CHECK (Delbelopp > 0),
    FOREIGN KEY (Ordernummer) REFERENCES Beställningar(Ordernummer), -- främmande nyckel kopplad till tabellen beställningar
    FOREIGN KEY (ISBN) REFERENCES Böcker(ISBN) -- främmande nyckel kopplad till tabellen böcker
);


-- Infoga data i tabellen Kunder
INSERT INTO Kunder (Namn, Epost, Telefon, Adress) VALUES
('Matilda Andersson','anna@email.com','0707-610 632','Champinjongatan 4 386 32 Färjestaden'),
('Erik Ericsson','erik@email.com','0763-848 833','Forellstigen 7 385 93 Köpingsvik'),
('Solveig Karlsson','solveig.k@spray.se','0701-377 455','Solstigen 9 458 79 Borgholm'),
('Mats Magnusson','mats@epost.nu','0708-133 078','Kungsvägen 37 182 39 Kalmar');

-- Infoga data i tabellen Böcker
INSERT INTO Böcker (ISBN, Författare, Titel, Pris, Lagerstatus) VALUES
('978-91-29-65770-8', 'Astrid Lindgren', 'Mio Min Mio', '179', '49'),
('978-91-1-304767-6', 'Michael Connelly', 'Prövningen', '99', '600'),
('978-91-7679-543-9', 'Lars Wilderäng', 'Höstsol','224', '1000');

-- Infoga data i tabellen Beställningar
INSERT INTO Beställningar (KundID, Datum, Totalbelopp) VALUES
(1, '2024-03-09', 278),
(2, '2024-03-10', 329),
(3, '2024-03-11', 179),
(4, '2024-03-12', 582);

-- Infoga data i tabellen Orderrader
INSERT INTO Orderrader (Ordernummer, ISBN, Antal, Delbelopp) VALUES
(1, '978-91-29-65770-8', 1, 179),  -- Kund 1 köper 1 Mio Min Mio
(1, '978-91-1-304767-6', 1, 99),  -- Kund 1 köper 1 Prövningen
(2, '978-91-7679-543-9', 1, 224),  -- Kund 2 köper 1 Höstsol
(2, '978-91-1-304767-6', 1, 99),  -- Kund 2 köper 1 Prövningen
(3, '978-91-29-65770-8', 1, 179),  -- Kund 3 köper 1 Mio Min Mio
(4, '978-91-7679-543-9', 1, 224),  -- Kund 4 köper 1 Höstsol
(4, '978-91-29-65770-8', 2, 358);  -- Kund 4 köper 2 Mio Min Mio

-- Hämtar all data i tabellen Orderrader
SELECT * FROM Orderrader;

-- Hämtar all data i tabellen Kunder
SELECT * FROM Kunder;

-- Hämtar namn och epost i tabellen Kunder
SELECT Namn, Epost FROM Kunder;

-- Hämtar all data i tabellen Beställningar
SELECT * FROM Beställningar;

-- Filtrering av data
SELECT * FROM Kunder WHERE Namn = 'Matilda Andersson'; -- Hämtar alla kunder med namnet Matilda Andersson
SELECT * FROM Böcker WHERE Pris > 100; -- Priset är över 100kr
SELECT * FROM Böcker WHERE Titel = 'Mio Min Mio';
Desc Böcker;

-- Sorterar data
SELECT * FROM Böcker ORDER BY Pris ASC; -- Sorterar priset på böcker i stigande ordning
SELECT * FROM Beställningar ORDER BY Datum DESC; -- sorterar inkomna beställningar per datum i 

-- Gör en ändring i Böcker där jag skrev fel titel på boken Mio Min Mio
UPDATE Böcker SET Titel = 'Mio Min Mio' WHERE ISBN = '978-91-29-65770-8';

-- Ändrar en kunds Epost. Kom ihåg att inkludera Start Transaction när du uppdaterar kunden. Det gör det möjligt att senare ångra ändringen.
START TRANSACTION;  -- Börjar en transaktion
UPDATE Kunder 
SET Epost = 'mats82@epost.nu' 
WHERE KundID = 4;

SELECT * FROM Kunder WHERE KundID = 4;  -- Kolla om ändringen ser rätt ut innan du sparar

COMMIT;  -- Spara ändringen permanent. OBS spara endast om ändringen är korrekt. Kan inte ångra om Comittat

ROLLBACK;  -- Ångra ändringen.

/*
Kodblock för att radera en kund med möjlighet att ångra
*/
-- Stänger av Safe mode
SET SQL_SAFE_UPDATES = 0;

-- Det krånglar att radera kunder som har en beställning. Skapar därför en kund som inte har någon beställning ännu
INSERT INTO Kunder (Namn, Epost, Telefon, Adress) VALUES
('Emelie Karlsson','Emelie.k@gmail.com','0708-144 999','Tryffelgatan 7 386 39 Mörbylånga');

-- Sen kör vi scriptet för att radera kunden
START TRANSACTION;
DELETE FROM Kunder
WHERE Namn = 'Emelie Karlsson';

SELECT * FROM Kunder; -- OBS här ska jag inte få någon träff

COMMIT; -- Spara 

ROLLBACK; -- Ångra

-- Join: Kombinera två tabeller 

-- Inner join för att se vilka kunder som lagt beställningar. Bara matchningar visas
SELECT Kunder.Namn, Beställningar.Ordernummer -- Vi väljer de kolumner som ska visas
FROM Kunder -- tabellen kunder
INNER JOIN Beställningar ON Kunder.KundID = Beställningar.KundID;  -- Kopplar ihop tabellerna Kunder med beställningar och det görs till sist med KundID från bägge tabellerna som skapar matchen

-- Left Join. Visar även på de kunder som ännu inte lagt en order
SELECT Kunder.Namn, Beställningar.Ordernummer -- Vi väljer de kolumner som skall visas
FROM Kunder
LEFT JOIN Beställningar ON Kunder.KundID = Beställningar.KundID; 

-- Visa hur många beställningar respektive kunde gjort
SELECT KundID, COUNT(Ordernummer) AS AntalBeställningar
FROM Beställningar
GROUP BY KundID;

-- Having, vi visa kunder som gjort fler än 2 beställningar.
-- Lägger till några beställningar för att få träffar

-- Lägger till två beställningar från kund 1
INSERT INTO Beställningar (KundID, Datum, Totalbelopp) VALUES
(1, '2024-03-13', 224),
(1, '2024-03-14', 358);

-- Lägger till två orderrader
INSERT INTO Orderrader (Ordernummer, ISBN, Antal, Delbelopp) VALUES
(5, '978-91-7679-543-9', 1, 224),  -- Kund 1 köper 1 Höstsol
(6, '978-91-29-65770-8', 2, 358);  -- Kund 1 köper 2 Mio Min Mio

-- Visa kunder som gjort fler än 2 beställningar
SELECT KundID, COUNT(Ordernummer) AS AntalBeställningar
FROM Beställningar
GROUP BY KundID
Having COUNT(Ordernummer) > 2; -- Ska vara mer än 2;

-- Skapa index för Epost i tabellen kunder
CREATE INDEX idx_epost ON Kunder(Epost);
-- visa index för kunder
SHOW INDEX FROM Kunder; 

-- Skapa index för ISBN i tabellen Böcker
CREATE INDEX idx_böckerk ON Orderrader (ISBN);
-- Visa index för Böcker
SHOW INDEX FROM Böcker;

-- Testar constraint att priset på en produkt alltid ska vara större än 0
INSERT INTO Böcker (ISBN, Författare, Titel, Pris, Lagerstatus) VALUES
('978-91-7429-112-4', 'Conn Iggulden', 'Bergens väktare', '0', '30');


-- Uppdatera lagersaldo efter order

DELIMiTER $$

CREATE TRIGGER uppdatera_lager
AFTER INSERT ON Orderrader
FOR EACH ROW
BEGIN
    UPDATE Böcker 
    SET Lagerstatus = Lagerstatus - NEW.Antal
    WHERE ISBN = NEW.ISBN;
END $$

DELIMITER ;

-- Logga nya kunder i en tabell
CREATE TABLE Kundlogg (
    LoggID INT AUTO_INCREMENT PRIMARY KEY,
    KundID INT,
    Registreringsdatum TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (KundID) REFERENCES Kunder(KundID)
);

DELIMITER $$

CREATE TRIGGER logga_ny_kund
AFTER INSERT ON Kunder
FOR EACH ROW
BEGIN
    INSERT INTO Kundlogg (KundID)
    VALUES (NEW.KundID);
END $$

DELIMITER ;

