#!/bin/bash

# Zou normaal gecode de database moeten geven van de parties van een 
# bepaalde maand 
endmonth=3
year=1997

echo "select * from partylist where endmonth=$endmonth  and year=$year \g\p" > input.msql
echo Content-type: text/html

/usr/local/Minerva/bin/msql party < input.msql > msqlout.txt

/home/boss/sdog/www/party/msqlout2lihtml.cgi

exit

