#include <stdio.h>

#include "futbalista.h"

void navod()
{
	printf("0 - navod\n");
	printf("1 - test senzorov\n");
	printf("2 - test vypinacov\n");
	printf("3 - test pohybov\n");
	printf("4 - test dokola\n");
	printf("5 - test dolava\n");
	printf("6 - test dopredu\n");
	printf("7 - test doprava\n");
	printf("8 - test zastav\n");
	printf("9 - test kamery\n");
	printf("100 - koniec\n");
	printf("9999 - test komunikacie\n");
}

void hlavny_program()
{
    char sprava[100];
    int a = 0;
    printf("0 = navod\n");

    do {
        printf("presov> ");
        scanf("%d", &a);
        if (a == 0) navod();
	else if (a == 9) test_kamery();
        else
        {
            sprintf(sprava, "%d", a);
            zapis_paket_do_arduina(sprava);
        }
    } while (a != 100);
}

int main()
{
    setup_komunikacia();
    setup_kamera();

    hlavny_program();

    ukonci_kameru();
    ukonci_komunikaciu();
    return 0;
}

