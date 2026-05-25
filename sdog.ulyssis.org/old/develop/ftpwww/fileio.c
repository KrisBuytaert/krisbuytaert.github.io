#include <stdio.h>
main()
{
 	FILE *read_file;
	char c;

	if ((read_file=fopen("dummy.txt","r"))==NULL)
	{
		printf("unable to open 'dummy.txt' for reading \n");
		exit(1);

	}
	c=getc(read_file);	
	while (c != EOF)  
	{
	printf("%c",c);
	c=getc(read_file);
	}
	fclose(read_file);

}
