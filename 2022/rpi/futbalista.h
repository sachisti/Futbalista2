#include <inttypes.h>

// komunikacia 

int setup_komunikacia();
void zapis_paket_do_arduina(uint8_t *zapisovany_paket); 
void ukonci_komunikaciu();

// kamera

int setup_kamera();
void ukonci_kameru();
void najdi_loptu(int *sirka_lopty, int *vyska_lopty, int *velkost_lopty);
void test_kamery();

