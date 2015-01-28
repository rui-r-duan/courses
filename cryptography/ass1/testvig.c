#include "vigenere.h"
#include <stdio.h>

int main()
{
    char buf[] = "huaaihbbwrfgaatvroujhbnecmaktfbgdecwxalzvbkdftgdevbriyjbbpcfavjgsigknfiekwefrwdzbroskceacvwiahzaaktfbgdetvnjcvcsdijbbpakhnykzbtxukfnphvfbjtysswckhuwtnsuwvvanzefielojwgeoeiawsjovhaszrphvqbibzbnpifbbbsgopatzarwnuggneeugdtyogiujhoacfbfedvfrzajhuabrgvyecszankgbbtywfphvceuowrrbeegriabsfphzgnbazfyucfachitogaddogpeiqbjsvehankzletzgaktvofutftvjdrtvteudbenkcszegoepuis";
    char key[] = "onwar";
    char plaintext[1024] = {0};
    (void)vigenere_dec(key, 5, buf, plaintext, 1024);
    printf("%s", plaintext);
}
