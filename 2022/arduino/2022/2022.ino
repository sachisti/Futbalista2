#include "futbalista.h"

void setup()
{
  Serial.begin(9600);
  pinMode(13, OUTPUT);
  
  setup_vypinace();
  setup_pohyb();
  setup_senzory();
  
  //test_vypinace();
  //test_motors();
  
}

void loop()
{
  test_senzorov();
  delay(300);
}
