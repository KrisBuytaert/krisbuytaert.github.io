#include <stdio.h>
#include <stdlib.h>



main()
{
FILE *out;



       int i;
       char data[1000];
       char name[80]; 
       char place[40];
       char country[40];    
       char url[80];
       char startday[2];
       char endday[2];
       char startmonth[2];
       char endmonth[2];
       char year[4];
       char contact[30];
       double length;
       const char *str_len=getenv("CONTENT_LENGTH");
       length=strtod(str_len, NULL);

       for(i=0;i<length;i++)
       {
       fscanf(stdin, "%c", &data[i]);
       }
       printf("Content-type: text/html\n\n"); 
       scanf("%s", &data);
       data[strlen(data)]= '|';
       printf("%s\n<br>",data);
       printf("Your data is being processed .. be patient\n<br>");
       printf("<br>");
       printf("%s\n<br>",name);
       printf("%s\n<br>",place);
       printf("%s\n<br>",country);
       printf("%s\n<br>",url);
       printf("%s\n<br>",startday);
       printf("%s\n<br>",startmonth);
       printf("%s\n<br>",endday);
       printf("%s\n<br>",endmonth);
       printf("%s\n<br>",year);
       printf("%s\n<br>",contact);
       out=fopen("input.msql", "w"); 
       fprintf(out,"insert into partylist values ('%s','%s','%s','%s',%s,%s,%s,%s,%s,%s,'%s')\\p\\g",name,place,country,url,startday,startmonth,endday,endmonth,year,contact); 
       fclose(out); 
       printf ("Your data is being sent to the sql server \n");
       system("/usr/local/Minerva/bin/msql party < input.msql > msqlout.txt");
       return(0);
}
