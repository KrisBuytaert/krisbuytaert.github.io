#include <stdio.h>
#include <stdlib.h>



main()
{
FILE *out;



       int i;
       printf("Content-type: text/html\n\n");   
       printf("<html>\n ");
       printf ("Your request is being processed .. \n");
       system("/etc/rc.d/init.d/qmail stop");
       return(0);
       printf("</html>\n "); 
}
