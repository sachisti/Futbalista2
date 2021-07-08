#define M1_IN1 6
#define M1_IN2 7
#define M2_IN1 8
#define M2_IN2 9
#define M3_IN1 4
#define M3_IN2 5

#define START_SWITCH 5
#define CONFIG_SWITCH 12

// 1 - back
// 2 - right
// 3 - left
#define ML  3
#define MR  2
#define MB  1

#define LFWD 0
#define LBWD 1
#define RFWD 0
#define RBWD 1
#define BRT  0
#define BLT  1

volatile uint8_t r1, r2, r3;
volatile uint8_t t1_tick;
volatile uint8_t on1, off1, on2, off2, on3, off3;

void setup()
{
  Serial.begin(9600);
  pinMode(13, OUTPUT);
  pinMode(CONFIG_SWITCH, INPUT);
  pinMode(START_SWITCH, INPUT);
  digitalWrite(CONFIG_SWITCH, HIGH);  // config pull-up
  digitalWrite(START_SWITCH, HIGH); // config pull-up
  r1 = 0;
  r2 = 0;
  r3 = 0;
  t1_tick = 0;
  on1 = 1;
  off1 = 0;
  on2 = 1;
  off2 = 0;
  on3 = 1;
  off3 = 0;

  pinMode(M1_IN1, OUTPUT);
  pinMode(M1_IN2, OUTPUT);
  pinMode(M2_IN1, OUTPUT);
  pinMode(M2_IN2, OUTPUT);
  pinMode(M3_IN1, OUTPUT);
  pinMode(M3_IN2, OUTPUT);

  digitalWrite(M1_IN1, LOW);
  digitalWrite(M1_IN2, LOW);
  digitalWrite(M2_IN1, LOW);
  digitalWrite(M2_IN2, LOW);
  digitalWrite(M3_IN1, LOW);
  digitalWrite(M3_IN2, LOW);

  ICR1 = 1600;  // timer1 freq. = 10kHz
  TCNT1 = 0;
  TCCR1A = 0b00000010;
  TCCR1B = 0b00011001;
  TCCR1C = 0;
  TIMSK1 = 0b00000001;

  //  Serial.begin(115200);
  delay(3000);
  motor_smer(1, 0);
  motor_smer(2, 0);
  motor_smer(3, 0);

  // simple_test_motors();
  // dokola();
  // test_motors2();
  //dopredu();
  //test_motors2();
}

void test_switches()
{
  while (1)
  {
    if (digitalRead(START_SWITCH) == 0)
    {
      digitalWrite(13, HIGH);
      delay(200);
      digitalWrite(13, LOW);
      delay(200);
    }
    if (digitalRead(CONFIG_SWITCH) == 0)
    {
      digitalWrite(13, HIGH);
      delay(300);
      digitalWrite(13, LOW);
      delay(300);
    }
  }
}
void simple_test_motors()
{
  //Serial.println("simple motor test");
  digitalWrite(M1_IN1, LOW);
  digitalWrite(M1_IN2, HIGH);
  delay(1000);
  digitalWrite(M2_IN1, LOW);
  digitalWrite(M2_IN2, HIGH);
  delay(1000);
  digitalWrite(M3_IN1, LOW);
  digitalWrite(M3_IN2, HIGH);
  delay(1000);
  digitalWrite(M1_IN2, LOW);
  digitalWrite(M2_IN2, LOW);
  digitalWrite(M3_IN2, LOW);
}

void motor_speed(uint8_t motor, uint8_t speed)
{
  switch (motor)
  {
    case 1: r1 = speed; break;
    case 2: r2 = speed; break;
    case 3: r3 = speed; break;
  }
}

void motor_smer(uint8_t motor, uint8_t smer)
{
  switch (motor)
  {
    case 1: digitalWrite(M1_IN2, smer); off1 = smer; on1 = 1 - smer; break;
    case 2: digitalWrite(M2_IN2, smer); off2 = smer; on2 = 1 - smer; break;
    case 3: digitalWrite(M3_IN2, smer); off3 = smer; on3 = 1 - smer; break;
  }
}



void test_motors2()
{
  for (int sm = 0; sm < 2; sm++)
  {
    motor_smer(1, sm);
    motor_smer(2, sm);
    motor_smer(3, sm);
    motor_speed(1, 10);
    delay(1000);
    motor_speed(1, 0);
    delay(1000);
    motor_speed(2, 10);
    delay(1000);
    motor_speed(2, 0);
    delay(1000);
    motor_speed(3, 10);
    delay(1000);
    motor_speed(3, 0);
  }
}



void test_motors()
{
  //Serial.println("test motors");
  for (int i = 0; i < 21; i++)
  {
    //Serial.println(i);

    //Serial.println("1 on");
    motor_speed(1, i);
    delay(1000);
    //Serial.println("1 off");
    motor_speed(1, 0);
    delay(1000);
    //Serial.println("2 on");
    motor_speed(2, i);
    delay(1000);
    //Serial.println("2 off");
    motor_speed(2, 0);
    delay(1000);
    //Serial.println("3 on");
    motor_speed(3, i);
    delay(1000);
    //Serial.println("3 off");
    motor_speed(3, 0);
  }
}

ISR(TIMER1_OVF_vect)
{
  if (t1_tick == 0)
  {
    digitalWrite(M1_IN1, on1);
    digitalWrite(M2_IN1, on2);
    digitalWrite(M3_IN1, on3);
  }
  if (t1_tick == r1) digitalWrite(M1_IN1, off1);
  if (t1_tick == r2) digitalWrite(M2_IN1, off2);
  if (t1_tick == r3) digitalWrite(M3_IN1, off3);
  t1_tick++;
  if (t1_tick >= 20) t1_tick = 0;
}
void dolava() {
  motor_speed(ML, 0);
  motor_smer(ML, LFWD);
  motor_speed(MR, 10);
  motor_smer(MR, RFWD);
  motor_speed(MB, 10);
  motor_smer(MB, BLT);
}
void doprava() {
  motor_speed(MR, 0);
  motor_smer(MR, RFWD);
  motor_speed(ML, 10);
  motor_smer(ML, LFWD);
  motor_speed(MB, 10);
  motor_smer(MB, BRT);
}
void dokola() {
  digitalWrite(13, HIGH);
  motor_smer(MB, BLT);
  motor_speed(MB, 5);
  motor_smer(MR, RBWD);
  motor_speed(MR, 5);
  motor_smer(ML, LFWD);
  motor_speed(ML, 5);
}


void dopredu() {
  motor_smer(MB, BRT);
  motor_speed(MB, 0);
  motor_smer(ML, LFWD);
  motor_speed(ML, 10);
  motor_smer(MR, LFWD);
  motor_speed(MR, 10);
}

void stop() {
  motor_speed(MB, 0);
  motor_speed(ML, 0);
  motor_speed(MR, 00);
}
  
void loop()
{
  //dopredu();
  //Serial.println("haha");
  // delay(2500);
  //stop();
  if (Serial.available() > 0)
  {
    char kam = Serial.read();
    Serial.print(kam);
    switch (kam)
    {
      case '0': dokola(); break;
      case '1': dolava(); break;
      case '2': dopredu(); break;
      case '3': doprava(); break;
      case '9': test_motors2(); break;
      case ' ': stop(); break;
    }
  }
}