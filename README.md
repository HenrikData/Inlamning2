# Inlamning2 av Henrik Karlsson YH2024

Den här databasen är en uppdateringa av Your_Bookstore och hanterar kunder, beställningar och böcker för en bokhandel. 

Databasen bygger på relationerna att: En kund kan göra flera beställningar och att: En beställning innehåller en eller flera böcker.

För att åstadkomma detta har fyra huvudentiteter skapats där tabellerna är: Kunder, Beställningar, Orderrader och Böcker. I denna uppdaterade version har en svag entitet tillkommit i form av kundlogg.

Kundtabellen innehåller information om kunder. Beställningar får ett ordernummer. Tabellen böcker innehåller information om böckerna och orderrader knyter samman böcker med beställningar och visar vilka böcker som ingår i beställningen. Kundloggen loggar tillkommande kunder vid nybeställningar. 

PK i respektive tabell är KundID, Ordernummer, OrderradID, ISBN samt LoggID.

Det finns relation mellan kunder och beställningar, mellan beställningar och orderrader, mellan böcker och orderrader. Orderrader är länken mellan böcker och beställningar. Relationerna knyts samman av FK som är kundID, ordernummer och ISBN. Nytillkommen relation är mellan tabellen Kunder och Kundlogg som knyts samman av FK i form av KundID.

En ny funktion är lagerstatus som automatiskt korrigerar lagerstatus av en bok vid order.

Reflektion: Databasen skulle kunna optimeras genom indexeringar av kolumner som ofta söks. Exempelvis datum och beställningar. Eller om jag ofta använder mig av Joins för säljanalyser bör jag indexera de kolumner som ingår i respektive Joins. En annan optimering kan vara att lägga till flera kolumner i syfte att förbättra säljanalyserna ytterligare med reservation för att eftersträva att hålla nere mängden data och undvika onödig information. Jag skulle också kunna jobba med fler restriktioner i samband med datatyperna för att hålla struktur och minska mängden data. 
