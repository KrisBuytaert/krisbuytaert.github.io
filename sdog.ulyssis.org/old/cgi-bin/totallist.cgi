#!/bin/bash

# Zou normaal gesproken de complete database van parties moeten genereren
echo Content-type: text/html

/usr/local/Minerva/bin/msql party < total.msql > msqlout.txt
/home/boss/sdog/www/party/msqlout2html

exit
