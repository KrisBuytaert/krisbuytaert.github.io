PROGRAM practicum2(input,output);
(*
 Nog te doen..
  1. Rekening Houden met leeftijdskeuze bij ex eaquo's
 *)

USES Crt;
CONST   maxcriteria = 15;
	maxbedrijf = 26;
	maxstring = 50;
	maxaantalkandidaten = 10;
TYPE
 crit = RECORD
 	gewicht, minimum,nr : INTEGER;
	END;
 kand = RECORD
        score, nr : INTEGER;
	END;
 bedrijf = RECORD
	naam : string;
	aantal_belang_criteria : INTEGER;
	tabel : ARRAY    [1..maxcriteria] OF crit;
	jong_of_oud : INTEGER;
	geselecteerd : ARRAY [1..maxaantalkandidaten] OF kand;
	END;
 kandidaat = RECORD
	naam : string;
	age , aantal_beantwoord : INTEGER;
	score : ARRAY [1..maxcriteria,0..maxbedrijf] OF INTEGER;
	totaal : ARRAY [1..maxbedrijf] OF INTEGER;
	END;
VAR
	kandidaten : ARRAY [1..maxaantalkandidaten] OF kandidaat;
	criteria: ARRAY [1..maxcriteria] OF string;
	bedrijven : ARRAY [1..maxbedrijf] OF bedrijf;
	aantal_criteria, teller, teller2, teller3, teller4, critnr, aantal_kandidaten,
	nummer, aantal_bedrijven, resultaat, tussenresultaat,
        ktel, ctel, btel : INTEGER;
	letter : CHAR;
        sorted : ARRAY [1..maxbedrijf,1..maxaantalkandidaten] of kand;
        sortcri : ARRAY [1..maxbedrijf,1..maxcriteria] of crit;

PROCEDURE Init;
BEGIN
 FOR btel := 1 TO maxbedrijf DO
     BEGIN
     FOR ktel := 1 TO maxaantalkandidaten DO
      BEGIN
      bedrijven[btel].geselecteerd[ktel].score := 0;
      END;
     FOR ctel := 1 TO maxcriteria DO
      BEGIN
      bedrijven[btel].tabel[ctel].minimum := 0;
      END;
     FOR ktel := 1 TO maxaantalkandidaten DO
      BEGIN
      sorted[btel,ktel].score := 0;
      END;
     END;
END;


PROCEDURE Invoer;
BEGIN
 READLN (aantal_criteria);
 FOR ctel := 1 TO aantal_criteria DO
	BEGIN
	READln (nummer);
	READLN (criteria[nummer]);
	END;
 READLN (aantal_bedrijven);
 FOR btel := 1 TO aantal_bedrijven DO
	BEGIN
	READln (letter);
	READLN (bedrijven[btel].naam);
        READLN (bedrijven[btel].aantal_belang_criteria);
        FOR ctel := 1 TO bedrijven[btel].aantal_belang_criteria DO
            BEGIN
             READ (nummer);
             READln (bedrijven[btel].tabel[nummer].gewicht,bedrijven[btel].tabel[nummer].minimum);
            END;
        readln(bedrijven[btel].jong_of_oud);
        END;
 READln (aantal_kandidaten);
 FOR ktel := 1 TO aantal_kandidaten DO
	BEGIN
	READln(kandidaten[ktel].naam);
	READln(kandidaten[ktel].age);
	READln(kandidaten[ktel].aantal_beantwoord);
	FOR teller2 := 1 TO kandidaten[ktel].aantal_beantwoord DO
		BEGIN
		READ(critnr);
		READln(kandidaten[ktel].score[critnr,0]);
		END;
	END;
 END;

PROCEDURE Berekengewicht;
BEGIN
 FOR ktel := 1 TO aantal_kandidaten DO
	BEGIN FOR btel := 1 TO maxbedrijf DO
	   BEGIN
	   tussenresultaat := 0;
	   FOR ctel := 1 TO maxcriteria DO
		BEGIN
		resultaat := kandidaten[ktel].score[ctel,0]  * bedrijven[btel].tabel[ctel].gewicht;
		kandidaten[ktel].score[ctel,btel] := resultaat;
		tussenresultaat := tussenresultaat + resultaat;
		END;
	  kandidaten[ktel].totaal[btel] := tussenresultaat;
          bedrijven[btel].geselecteerd[ktel].score := tussenresultaat;
          bedrijven[btel].geselecteerd[ktel].nr := ktel;
          END;
END;
END;


PROCEDURE Minimumbereikt;
BEGIN
 FOR ktel := 1 TO aantal_kandidaten DO
	BEGIN
         FOR btel := 1 TO aantal_bedrijven DO
          BEGIN
          FOR ctel := 1 TO aantal_criteria DO
           BEGIN
            IF kandidaten[ktel].score[ctel,0] < bedrijven[btel].tabel[ctel].minimum
            THEN bedrijven[btel].geselecteerd[ktel].score := 0
           END;
          END;
        END;
END;




PROCEDURE Uitvoer;
VAR nummer2,nummer : INTEGER;
BEGIN
FOR btel := 1  TO aantal_bedrijven DO
 BEGIN
  WRITELN;
  WRITELN ('Kandidatenlijst voor het bedrijf ',bedrijven[btel].naam);
  WRITE   ('---------------------------------');
          FOR teller2 := 1 TO LENGTH(bedrijven[btel].naam) DO WRITE ('-');
  WRITELN;
 FOR ktel := 1 TO maxaantalkandidaten DO
  BEGIN
   IF sorted[btel,ktel].score > 0 THEN
    BEGIN
     nummer := sorted[btel,ktel].nr;
     WRITELN (ktel,'. Kandidaat: ',kandidaten[nummer].naam);
     WRITELN ('   Leeftijd: ',kandidaten[nummer].age);
     FOR ctel := 1 to bedrijven[btel].aantal_belang_criteria DO
      BEGIN
       nummer2 := sortcri[btel,ctel].nr;
       WRITE('   ',criteria[nummer2],':');
       FOR teller4 := 1 TO (25 - LENGTH(criteria[nummer2]))  DO WRITE(' ');

       WRITELN(kandidaten[ktel].score[nummer2,0]:4,
               kandidaten[ktel].score[nummer2,btel]:9);
                     END;
     WRITELN ('   Totaal:',sorted[btel,ktel].score:32);

    END;

 END;
 END;
END;




PROCEDURE Sorteerkandidaten;
VAR nr1, nr2, maximum,positie : INTEGER;
 PROCEDURE Verwissel(nr1,nr2:INTEGER);
 VAR tmp : kand;
 BEGIN
 tmp.score := sorted[btel,nr1].score;
 tmp.nr := sorted[btel,nr1].nr;
 sorted[btel,nr1].score := sorted[btel,nr2].score;
 sorted[btel,nr1].nr := sorted[btel,nr2].nr;
 sorted[btel,nr2].score := tmp.score;
 sorted[btel,nr2].nr := tmp.nr;
 END;

BEGIN
 FOR teller := 1 TO maxaantalkandidaten
 DO BEGIN
    maximum := 0;
     FOR ktel := 1 TO maxaantalkandidaten DO
      BEGIN
      IF bedrijven[btel].geselecteerd[ktel].score > maximum
      THEN
      BEGIN
      maximum := bedrijven[btel].geselecteerd[ktel].score;
      positie := ktel;
      END;
     END;
    sorted[btel,teller].score := maximum;
    sorted[btel,teller].nr := positie;

    bedrijven[btel].geselecteerd[positie].score := 0;
    END;
 FOR teller := 1 TO maxaantalkandidaten
 DO BEGIN
    IF sorted[btel,teller].score = sorted[btel,teller+1].score
    THEN BEGIN
         (* Voorkeur Oudstekandidaat*)
         IF (bedrijven[btel].jong_of_oud = 0) AND (kandidaten[teller].age < kandidaten[teller+1].age)
         THEN verwissel(teller,teller+1);
         (* Voorkeur Jongste Kandidaat *)
         IF (bedrijven[btel].jong_of_oud = 1) AND (kandidaten[teller].age > kandidaten[teller+1].age)
         THEN verwissel(teller,teller+1);

         END;
    END;
END;

PROCEDURE Sorteercriteria;
VAR maximum,positie : INTEGER;
BEGIN
 FOR teller := 1 TO maxcriteria DO
 BEGIN
    maximum := 0;
     FOR ktel := 1 TO maxcriteria DO
      BEGIN
      IF bedrijven[btel].tabel[ktel].gewicht > maximum
      THEN
      BEGIN
      maximum := bedrijven[btel].tabel[ktel].gewicht;
      positie := ktel;
      END;
     END;
    sortcri[btel,teller].gewicht := maximum;
    sortcri[btel,teller].minimum := bedrijven[btel].tabel[positie].minimum;
    sortcri[btel,teller].nr := positie;
    bedrijven[btel].tabel[positie].gewicht := 0;
    END;

END;





BEGIN
 ClrScr;
 Assign(input,'invoer.txt');
 reset(input);
 assign(output,'uitvoer.txt');
 rewrite(output);
 Init;
 Invoer;
 Berekengewicht;
 Minimumbereikt;
 FOR btel := 1 TO maxbedrijf DO
  BEGIN
  sorteerkandidaten;
  sorteercriteria;
  END;
 Uitvoer;
 close(output);


END.

