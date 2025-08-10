// vigeneredecode.cpp
//

#include <stdlib.h>
#include<stdio.h>
#include<math.h>
#include<iostream>

int find_key_lenth(char*pass,int len)
{

    int d=0,count,MaxCount=0;
    for(int step=1;step<10;step++)
    {
        count=0;
        for(int j=0;j<len&&(j+step)<len;j++)
        {
            if(pass[j]==pass[j+step])
                count++;
        }
        if(count>MaxCount)
        {
            MaxCount=count;
            d=step;
        }
    }
    return d;
}
// try decrypt key
void decode(char*pass,char*ming,int d,int len)
{
    float v[26]={0};               //26 letters
    int per_len=len/d;             //length
    double A[26]={0.038,0.022,0.066,0.02,0.033,              //frequency
                  0.044,0.057,0.029,0.037,0.033,0.066,
                  0.022,0.035,0.024,0.008,0.044,0.033,
                  0.046,0.016,0.064,0.033,0.061,0.051,0.057,0.031,0.024};


    double B[26]={0};
    char*key;
    key=new char[d];
    for(int i=0;i<d;i++)
    {
        int j=0;
        while(true)
        {
            if((i+d*j)>=len) break;
            v[pass[i+d*j]-'a']+=1;
            j++;
        }
        for(int k=0;k<26;k++)
            v[k]=v[k]/per_len;

        for(int k=0;k<26;k++)
        {
            for(int l=0;l<26;l++)
                B[k]+=A[l]*v[(l+k)%26];
        }

        double max=1;
        int c;
        for(int k=0;k<26;k++)
        {
            if(fabs(B[k]-0.065)<max)
            {
                max=fabs(B[k]-0.065);c=k;
            }
        }
        key[i]=c;

        for(int k=0;k<26;k++)
        {
            B[k]=0;
            v[k]=0;
        }
        printf("%c",'a'+key[i]);
    }

    printf("\n\nPlaintext:\n");
    for(int i=0;i<len;i++)
    {
        int tmp;
        tmp=pass[i]-'a';
        ming[i]=(tmp-key[i%d]+26)%26+'a';
        printf("%c",ming[i]);
    }
    printf("\n\n");
    return ;
}
int main()
{
    char ciphertext[1000]={0};
    char plaintext[1000]={0};
    FILE* fp;
    if((fp=fopen("cipher1.txt","r+"))==NULL)
    {
        printf("cipher1.txt open error!\n");
        return 1;
    }
    int i=0,d;
    printf("Ciphertext:");
    while((ciphertext[i++]=fgetc(fp))!=EOF);
    for(int j=0;j<i;j++)
    {
        if(j%59==0) printf("\n");
        printf("%c",ciphertext[j]);
    }
    d=find_key_lenth(ciphertext,i-1);
    printf("\n");
    printf("key is:");
    printf("key=");
    decode(ciphertext,plaintext,d,i-1);
    fclose(fp);
    return 0;

}
