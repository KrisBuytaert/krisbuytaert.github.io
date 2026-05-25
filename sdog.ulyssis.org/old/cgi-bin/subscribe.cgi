#!/usr/bin/perl
require "/home/org/ulyssis/www/cgi-bin/cgilib.pl" ;
&ReadParse;
#open (FILE,">> /services/www/pages/org/ulyssis/subscribe/subscribe.out");
open (FILE,"| /usr/bin/sendmail -t");
print FILE "To: gatzby\@hagar.arts.kuleuven.ac.be\n";
print FILE "From: webmaster\@hagar.arts.kuleuven.ac.be\n";
print FILE "Subject: nieuwe inschrijving\n\n";  
print FILE "** OPEN ***********\n";
foreach $key (keys %in) { 
	print FILE "$key:$in{$key}\n";
}
print FILE "** CLOSE **********\n";
close (FILE);
print "Content-type: text/html\n\n";
open (FILE,"/home/org/ulyssis/www/thanks.htm");
while (<FILE>) {
  print;
}
close (FILE);
	
