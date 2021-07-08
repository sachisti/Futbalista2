#include <EEPROM.h> 

#define switch 7

int val = 0;
int min[6], max[6], prah[6];

void nacitaj_kalibraciu_z_EEPROM()
{
  for (int i = 0; i < 6; i++)
  {  
    prah[i] = EEPROM.read(i * 2) + (EEPROM.read(i * 2 + 1) << 8);
  }  
}

void zapis_kalibraciu_do_EEPROM()
{
  for (int i = 0; i < 6; i++)
  {  
    EEPROM.write(i * 2, prah [i]&255);
    EEPROM.write(i * 2 + 1, prah [i]>>8);
  }
}

void setup() 
{  
  Serial.begin(9600);
  Serial.println("Zacinam kalibraciu.");
  for (int i = 0; i < 6; i++)
  {
    if (i>3) val=analogRead (i+2);
    else val=analogRead (i);
    min[i]=max[i]=val;
  }
  pinMode(switch, INPUT_PULLUP);

  if (digitalRead(switch) == LOW)
  {
    kalibracia();
  }
  else nacitaj_kalibraciu_z_EEPROM();
}

void test_senzorov()
{
    for (int i=0; i<6; i++)
    {
        if (i>3) val=analogRead (i+2);
        else val=analogRead (i);
     
        if (val<prah[i]) Serial.print("0");  
        else Serial.print("1");
     }
     Serial.println();
     delay(150);
}

void kalibracia()
{
  while(digitalRead(switch) == LOW) 
  {  
     for (int i=0; i<6; i++)
     {
       Serial.print(val);
       Serial.print("[");
       Serial.print(min[i]);
       Serial.print("-");
       Serial.print(max[i]);
       Serial.print("], ");
       if (i>3) val=analogRead (i+2);
       else val=analogRead (i);
       if (val>max[i]) max[i]=val;
       if (val<min[i]) min[i]=val;
     }
     Serial.println();
  }

  for (int i=0; i<6; i++)
  {
       //druha cast programu (vypocet prahovej hodnoty)
       prah[i]=(2*max[i]+min[i])/3;    
  }
  // zapisat kalibraciu do EEPROM
  zapis_kalibraciu_do_EEPROM();
}

void loop() 
{    
  delay(300);  
  test_senzorov();   
}