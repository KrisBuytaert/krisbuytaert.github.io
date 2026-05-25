
program vierentwintig(invoer,centraal,deel1,deel2,deel3);
(* 
   - Meta TAG met Refresh
   - inlees routines
*)
var 
 kring : array [1..36] of string[20];
 kleur : array[1..4] of string[3];  
 tmp,tel,max,min,schaal,t : integer;
 tabel, rondjes, positie : array [1..36] of integer;
 dest,invoer,centraal,deel1,deel2,deel3 : text;
 fname1, fname2, fname3, fnamecent : BindingType;

procedure  makemoreparts;
var  tel, pagina,geg : integer;
     lijn : string[80];
begin
for pagina  := 1 to 3 do 
begin
case pagina of 
 1: dest := deel1;
 2: dest := deel2;
 3: dest := deel3;
end;

write(dest,'<html><head><title> Test Page for');
write(dest,'24h</title></head><body><table');
write(dest,' border=1 width=100%><tr><th
width=20>Kring</th><th></th><th>Aantal Rondjes</th></tr>');

for t := 1 to 12 do 
begin
 tel := t + 12*(pagina -1);
 geg := positie[tel];
 write (dest,'<tr><td> ',
	  kring[geg],'</td><td>');
 write (dest,rondjes[geg],'</td><td><img src="',kleur[(tel mod 4)+1],'.gif"
width=',rondjes[geg] div  schaal,' height=5></td></tr>');
end;

write (dest,'</table>');
case pagina of
 1 : write (dest,'<a href="right.html">[Complete]</A><a
href="pg2.html">[Next]</A>');
 2 : write (dest,'<a href="pg1.html">[Prev]</A><a
href="right.html">[Complete]</a><a href="pg3.html">[Next]</A>');
 3 : write (dest,'<a href="pg2.html">[Prev]</A><a
href="right.html">[Complete]</A>');
end;
write (dest,'</body></html>');

end;
end;

procedure makehtml;
var t,geg : integer;
begin

write(centraal,'<html><head><title> Test Page for
24h</title></head><body><table
border=1 width=100%><tr><th width=20>Kring</th><th></th><th>Aantal Rondjes</th></tr>');
for t := 1 to 36 do 
begin
 geg := positie[t];
 write (centraal,'<tr><td> ',
	  kring[geg],
	'</td><td>');
 write (centraal,rondjes[geg]);
 write (centraal,'</td><td><img src="');
 write (centraal,kleur[(t mod 4)+1],'.gif" width=');
 write (centraal, rondjes[geg] div  schaal);
 write (centraal,' height=5></td></tr>');
end;
write (centraal,'</table><a href="pg1.html">[Splitted]</A>


</body>
</html>
');

end;

procedure initial;
var t:integer;
begin
 for t := 1 to 36 do
   rondjes[t] := abs(2*t+t*t+t);
 rondjes[1] := 2845;
 rondjes[34] := 463;	
 kleur[1] := 'yel';
 kleur[2] := 'red';
 kleur[3] := 'blu';
 kleur[4] := 'gre';
 kring[1] := 'VRG';
 kring[2] := 'Wina';
 kring[3] := 'VTK';
 kring[4] := 'Economica';
 kring[5] := 'LBK';
 kring[6] := 'Chemica';
 kring[7] := 'Diana';
 kring[8] := 'Groenveld';
 kring[9] := 'Terbank';
 kring[10] := 'Medica';
 kring[11] := 'Mercator';
 kring[12] := 'Thomas';
 kring[13] := 'Lerkeveld';
 kring[14] := 'Salvast';
 kring[15] := 'Historia';
 kring[16] := 'Romania';
 kring[17] := 'Alfa';
 kring[18] := 'Politica'; 
 kring[19] := 'Bios';
 kring[20] := '20';
 kring[21] := '21';
 kring[22] := '22';
 kring[23] := '23';
 kring[24] := '24';
 kring[25] := '25';
 kring[26] := '26';
 kring[27] := '27';
 kring[28] := '28';
 kring[29] := '29';
 kring[30] := '30';
 kring[31] := '31';
 kring[32] := '32';
 kring[33] := '33';
 kring[34] := '34';
 kring[35] := '35';
 kring[36] := '36';
 schaal := 1;
 for t := 1 to 36 do positie[t] := t ;
end;
procedure checkbar;
var tmp, t, max, min : integer;

begin
 max := 0;
 min := 500;
 
 for t := 1 to 36 do
 begin
   
   if rondjes[t] < min then min := rondjes[t];
   if rondjes[t] > max then max := rondjes[t];
 end;
 if max > 350 then 
   
    schaal := max div 350;
end;
 
procedure sorteer;
var i : integer;

  procedure bubble (i: integer);
  var j : integer ; h : integer;
  begin
   for j := 1 to i-1 do
   if tabel[j] < tabel[j+1] then begin
	h := tabel[j];
	tabel[j] := tabel[j+1];
	tabel[j+1] := h;
	h := positie[j];
        positie[j] := positie[j+1];
        positie[j+1] := h;
        
	end

  end;
begin
  for i := 36 downto 2 do begin
  bubble(i)
  end
end;

procedure bindfile (var f :  text;fname : string);
var
    b : BindingType;

begin
  unbind (f);
  b := binding (f);
  b.name := fname;
  bind (f, b);
  b := binding (f);
end;


begin
 initial;
 bindfile (deel1,'pg1.html');
 bindfile (deel2,'pg2.html');
 bindfile (deel3,'pg3.html');
 bindfile (centraal,'right.html');

 rewrite (deel1);
 rewrite (deel2);
 rewrite (deel3);
 rewrite (centraal);
 checkbar;
 for t := 1 to 36 do tabel[t] := rondjes[t];
 sorteer;
 makehtml;
 makemoreparts;
 close (deel1);
 close (deel2);
 close (deel3);
 close (centraal);
end.
