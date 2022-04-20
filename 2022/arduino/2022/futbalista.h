// all function prototypes here

// pohyb

void setup_pohyb();
void riadenie_cez_seriovy_port();

void dolava();
void doprava();
void dokola();
void dopredu();
void stop(); 

void simple_test_motors();
void motor_speed(uint8_t motor, uint8_t speed);
void motor_smer(uint8_t motor, uint8_t smer);
void test_motors2();
void test_motors();


// vypinace

void setup_vypinace();
void test_vypinace();
uint8_t config_on();
uint8_t start_on();

// senzory (pouzi analogRead(0)-analogRead(7) okrem 4,5

void setup_senzory();
void test_senzorov();

