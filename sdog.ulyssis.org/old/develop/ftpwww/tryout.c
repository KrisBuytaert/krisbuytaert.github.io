#include  <stdio.h> 
#include  <dirent.h>
#include  <stdio.h>
#include  <dirent.h>
#include  <sys/types.h>
#include  <sys/dir.h>
#include  <sys/param.h>


#define FALSE 0
#define TRUE !FALSE

extern int alphasrot();

char pathname[MAXPATHLEN];
char tekst;
char dummystr[MAXPATHLEN];
int count,i,lengte,tel;
char tmp[4];

void header()
{
        printf("Content-type: text/html\n\n");   
        printf("<html>\n ");
	printf("<title>Voorbereidselen van ftpweb</title>\n");      
	printf("<body bgcolor=""#ffffff"">");  
	printf("Here it is..!<br>\n\n");
	printf("<h3>The first trials of the FtpWeb</h3>\n\n");
	printf("<a href=""http://uly2.arts.kuleuven.ac.be/~sdog/develop/ftpwww/"">Terug</A>\n\n\n\n");
	printf("<br>\n\n");
	printf("<table width=100% border=1><tr>
		<td valign=top width=50>Filename</td>
		<td valign=top width=40>Date</td>
		<td width=60 valign=top>Size</td>
		<td width=200>Description (File_id.diz)</td>
		</tr>");
}


void stripascii(char *zipname)
{
 FILE *read_file;
 char c;
 
 printf("<tr><td valign=top>%s</td><td valign=top>date</td><td 
 valign=top>size</td><td><pre>\n",zipname);
 if ((read_file=fopen("file_id.diz","r"))==NULL)
 {
  printf("\n\nNo description given by uploader (USE file_id.diz ! ) \n");
  exit(1);
 }      
 c=getc(read_file);
 while (c != EOF)  
 { 

 /* Hier wordt puur op het caracter zelf gecheckt.. Het probleem zit hem 
nog in de lege lijnen.  Een ASCII tekening wordt naar een aantal blanks 
veranderd.*/

  if ((c > 127) || (c < 32))
   {
   if (c == 10) 
    { 
     printf("%c",c); 
     c=getc(read_file);
    }
 }  
else
  { 
   printf("%c",c);
  }
  c=getc(read_file);
  }
  fclose(read_file);
  printf("</pre></td></tr>");
 }


void strlcpy (char *doel, char *base, int aantal )
/* Functie vrij mooi gaat staan in uw aller eerste eigen library ;-) */
{
/* printf("%s\n<br>",base); */
 lengte = strlen(dummystr);
 for (tel=0;tel<4;tel++)
 { doel[tel] = base[aantal+tel+1];
 }
 doel[4] = NULL;
 printf ("%s %s \n<br>",base, doel); 
 
}
/*
{
 for (tel=0;tel <= aantal;tel++) 
  {
   tmp[tel] = base[lengte-tel];
  }
 printf("%s<br>\n",base);
 lengte = strlen(tmp);
  for (tel=0; tel <= lengte;tel++)
   {
    doel[tel] = tmp[lengte-tel];
   }
  printf ("%s<br>\n",doel);

}
*/


void getdirlist ()
{ 
 char exten[4];
 struct direct **files;
 int file_select();

 if(getwd(pathname)==NULL)
 { printf (" Error getting path \n");
   exit (0);
 }
  /*  printf ("Current Working Directory = %s\n",pathname); */ 
  count = scandir (pathname, &files, file_select, alphasort);
  if (count <= 0 ) 
   { printf ("No files in this directory\n");
     exit (0);
   }
   for  (i=1;i<count+1;++i)
   { 

	strcpy (dummystr,files[i-1]->d_name);
	lengte = strlen(dummystr);

	if (lengte > 2) 

        	{
		stripascii(dummystr);
		stripascii(dummystr);

    	strlcpy (exten,dummystr,lengte-3);
/*			
		if (strcmp(exten,"Z"))
		  	stripascii(dummystr);
		strlcpy (exten,dummystr,lengte-3);
		if (strcmp(exten,"gz"))  
				stripascii(dummystr);
	        strlcpy (exten,dummystr,lengte-4);
		if   ( strcmp(exten,'tar') 
			|| strcmp(exten,'zip') 
			|| strcmp(exten,'arj')) 
		   
		   	 
				stripascii(dummystr);
*/		
		printf("\n");

        	}
	}    

}

int file_select (struct direct *entry)

 { if ((strcmp(entry -> d_name,".") == 0) && (strcmp (entry ->d_name,"..")== 0 ))
 	return (FALSE);
   else 
 	return (TRUE);
 }
   


void footer()
{
	printf("</table>");
        printf("</html>\n "); 
}

                       
main ()
{ 
	header();
	getdirlist();
	footer();
}



/* thnx to Airborne , Winmute , eey  */
