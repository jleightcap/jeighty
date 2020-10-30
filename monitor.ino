const char ADDR[] = {22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 52};
const char DATA[] = {39, 41, 43, 45, 47, 49, 51, 53};
#define CLOCK 2
#define READ  3
#define WRITE 4
#define IORQ 5
#define MREQ 6

void setup() {
  for (int n = 0; n < 16; n += 1) {
    pinMode(ADDR[n], INPUT);
  }
  for (int n = 0; n < 8; n += 1) {
    pinMode(DATA[n], INPUT);
  }
  pinMode(CLOCK, INPUT);
  pinMode(READ, INPUT);
  pinMode(IORQ, INPUT);
  pinMode(MREQ, INPUT);
  pinMode(WRITE, INPUT);

  attachInterrupt(digitalPinToInterrupt(CLOCK), onClock, RISING);

  Serial.begin(57600);
}

void onClock() {
  char output[15];

  // print the address bus in binary and hex
  uint16_t address = 0;
  for (int nn = 0; nn < 16; nn++) {
    int bit = digitalRead(ADDR[nn]) ? 1 : 0;
    Serial.print(bit);
    address = (address << 1) + bit;
  }
  Serial.print(" ");
  Serial.print(address);

  Serial.print("\t");

  // print data bus in binary and hex
  uint8_t data = 0;
  for (int nn = 0; nn < 8; nn++) {
    int bit = digitalRead(DATA[nn]) ? 1 : 0;
    Serial.print(bit);
    data = (data << 1) + bit;
  }
  Serial.print(" ");
  Serial.print(data);

  Serial.print("\t");

  // print control data
  if (!digitalRead(IORQ)) Serial.print("I");
  if (!digitalRead(MREQ)) Serial.print("M");
  if (!digitalRead(READ))  Serial.print("r");
  if (!digitalRead(WRITE)) Serial.print("w");

  Serial.println();
}

void loop() {
}
