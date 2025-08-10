#include <stdio.h>
#include <string.h>
#include <stdlib.h>
void main()
{
  char pa[500],temp[500];
  char enpa[500]="";
  char denpa[500]="";
  int *key;
  int a,b,c;
  int size;
  int m,n;
  int length;
  int i,j,k;
  int p,q;
  int x,y,z;
  printf("Please input a paragraph:");
  gets(pa);
  printf("Please input a value of block size:");
  scanf("%d",&m);
  size = sizeof(int)*m;
  key=(int *)malloc(size);
  printf("Please input keys:");
  for(a=0;a<m;a++)
	  scanf("%d",&key[a]);
  length = strlen(pa);
  for(b=0;b<length;b++)
      temp[b]=pa[b];
  while((length%m)!=0)
  {
      temp[length]=' ';
	  length++;
  }
  n = length/m;
  printf("The encrypted paragraph is:");
  for(i=0;i<n;i++)
  {
	  for(j=0;j<m;j++)
	  {
		  p=key[j]-1;
		  enpa[i*m+p]=temp[i*m+j];
	  }
  }
  for(k=0;k<length;k++)
  {
   printf("%c",enpa[k]);
   if((k+1)%length==0)
	printf("\n");
  }
  printf("The Unencrypted paragraph is:");
  for(x=0;x<n;x++)
  {
	  for(y=0;y<m;y++)
	  {
		  z=key[y]-1;
		  denpa[x*m+y]=enpa[x*m+z];
	  }
  }
  for(q=0;q<length;q++)
  {
   printf("%c",denpa[q]);
   if((q+1)%length==0)
	printf("\n");
  }
  free(key);
}
