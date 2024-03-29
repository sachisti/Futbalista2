#include <Arduino.h>
#include "futbalista.h"

#define MAX_DLZKA_PAKETU 10

// pakety v oboch smeroch zacinaju znakom '$' a koncia znakom '\n'

uint8_t paket[MAX_DLZKA_PAKETU];
uint8_t *p;
uint8_t citam;

void setup_komunikacia() 
{
  p = paket;
  citam = 0;
  Serial.println("$init");
}


//spravy RPI -> Arduino:
//  21 - lopta vpravo
//  22 - lopta vlavo
//  23 - lopta v strede
//  24 - nevidi loptu

void spracuj_paket()
{
  // na tomto mieste mame v poli paket[] prijaty 0-ukonceny retazec znakov
  int a;
  // v tejto ukazke retazec dekodujeme ako cislo a vypiseme spravu s dvojnasobkom
  // vo vasom pripade budete na tomto mieste reagovat na spravu podla potreby...
  sscanf((char *)paket, "%d", &a);

  if (a == 1) test_senzorov();
  else if (a == 2) test_vypinace();
  else if (a == 3) test_motors();
  else if (a == 4) dokola(); 
  else if (a == 5) dolava(); 
  else if (a == 6) dopredu();
  else if (a == 7) doprava(); 
  else if (a == 8) zastav();
  
  else if (a == 31) dolava_vzad();
  else if (a == 32) doprava_vzad();
  else if (a == 33) dozadu();
  
  else if (a == 9999) Serial.print("$zelena je trava\n");
  
  else if (a == 21) doprava();
  else if (a == 22) dolava();
  else if (a == 23) dopredu();
  else if (a == 24) dokola();
}

void precitaj_dalsi_znak()
{
  if (p - paket >= MAX_DLZKA_PAKETU) p = paket;
  
  *p = Serial.read();
  //Serial.print("'");Serial.print(*p);Serial.print("';");
  //digitalWrite(13, HIGH); delay(100); digitalWrite(13, LOW); 
  if (*p == '$') 
  {
    p = paket;
    citam = 1;
  }
  else if (citam)
  {
    if ((*p != '\n') && (*p != '\r')) p++;
    else 
    {
      *p = 0;
      citam = 0;
      spracuj_paket();
      p = paket;
    }
  }
}

void komunikacia() 
{
  if (Serial.available()) precitaj_dalsi_znak();
}
