#include <stdio.h>
#include <string.h>
#include <math.h>
void main()
{
    char enpa[1000] = {"huaaihbbwrfgaatvroujhbnecmaktfbgdecwxalzvbkdftgdevbriyjbbpcfavjgsigknfiekwefrwdzbroskceacvwiahzaaktfbgdetvnjcvcsdijbbpakhnykzbtxukfnphvfbjtysswckhuwtnsuwvvanzefielojwgeoeiawsjovhaszrphvqbibzbnpifbbbsgopatzarwnuggneeugdtyogiujhoacfbfedvfrzajhuabrgvyecszankgbbtywfphvceuowrrbeegriabsfphzgnbazfyucfachitogaddogpeiqbjsvehankzletzgaktvofutftvjdrtvteudbenkcszegoepuis"};
	/* char enpa[1000]= {"cjnpkgrlilqwawbnuptgkerwxuzviaiiysxckwdntjawhqcutttvptewtrpgvcwlkkkgczafsihrimixukrwxrfmgfg kfxgukpjvvzmcmjvawbnuptgcicvxvkgczkekgcqbchvnrqhhwiadfrcyxgvzqqtuvbdguvttkccdpvvfphftamzxqwrt gukcelqlrxgvycwtncbjkkeerecjqihvrjzpkkfexqgjtpjfupemswwxcjqxzpjtxkvlyaeaemwhovudkmnfxegfrwxtd yiaecyhlgjfpogymbxyfpzxxvpngkxfitnkfdniyrwxukssxpkqabmvkgcqbciagpadfrcyxgvyyimjvwpkgscwbpurwx qkftkorrwvnrqhxurlslgvjxmvccraceathhtfpmeygczwgutttvttkatmcvgiltwcsmjmvyghitfzaxodkbf"}; */
	int i,j,m,num;
	double ic[10][10];
	double sum1,sum2,ave;
	int length;
	int block[26];
	length=strlen(enpa);
    for(m=1;m<11;m++)
		for(i=0;i<m;i++)
		{
			for(j=0;j<26;j++)
			    block[j]=0;
            num=i;
            while(num<length)
            {
                block[enpa[num]-97]+=1;
                num+=m;
            }
            sum1=0;
			for(j=0;j<26;j++)
				sum1+=block[j]*(block[j]-1);
            ic[m-1][i]=(double)(sum1*m*m)/(length*(length-1));
		}
	for(m=1;m<11;m++)
	{
		printf("m=%d\n",m);
		for(i=0;i<m;i++)
		{
			printf("ic=%.3f\n",ic[m-1][i]);
		}
		sum2=0;
		for(i=0;i<m;i++)
            sum2+=ic[m-1][i];
		ave=sum2/m;
		printf("The average index of coincidence is %.3f\n",ave);
	}
}
