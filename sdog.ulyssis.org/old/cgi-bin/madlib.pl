#!/usr/local/bin/perl
# madlib.pl
# By Brian Exelbierd (bex@ncsu.edu) 1-1-95
#
# This program accepts www form input and produces the following madlib
# One fine _day_, _name1_ was reading _newsgroup_, and noticed a post where
# _name2_ asked for help making their _noun_ _verb_.
#
# This program uses Steve Brenner's cgi-lib.pl library to handle the input

push(@INC,"/p/www/httpd/cgi-bin");
require("cgi-lib.pl");

&ReadParse;

print &PrintHeader;

print "<HTML>\n";
print "<HEAD>\n";
print "<TITLE>A madlib</TITLE>\n";
print "</HEAD>\n";
print "<BODY>\n";
print "\n";
print "<H1>Here it is:</H1>\n";
print "\n";

print "<P>One fine ",$in{'day'},", ",$in{'name1'}," was reading\n";
print $in{'newsgroup'}," and noticed a post where ",$in{'name2'}," asked for\n";
print "help making their ",$in{'noun'}," ",$in{'verb'},"</P>\n";

print "</BODY>\n";
print "</HTML>\n";
