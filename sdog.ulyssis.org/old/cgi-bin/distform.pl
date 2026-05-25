#!/usr/bin/perl

#distform.pl
#By Kris Buytaert (sdog@ruby.arts.kuleuven.ac.be) 15-1-96
#Eerste scritpje om de distsite forms in orde te brengen.

push(@INC,"/www/cgi-bin");
require("cgi-lib.pl");

&ReadParse;

print &PrintHeader;

print"<HTML>\n"
print"Testing\n"
print"</html>\n"

