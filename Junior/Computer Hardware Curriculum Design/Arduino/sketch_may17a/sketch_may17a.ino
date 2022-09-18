void setup() {
  // put your setup code here, to run once:
  for (int i = 8; i < 12; i++) {
    pinMode(i, OUTPUT);
  }
}

void clockwise(int num)
{
  for (int count = 0; count < num; count++)
  {
    for (int i = 8; i < 12; i++)
    {
      digitalWrite(i, HIGH);
      delay(3);
      digitalWrite(i, LOW);
    }
  }
}

void anticlockwise(int num)
{
  for (int count = 0; count < num; count++)
  {
    for (int i = 11; i > 7; i--)
    {
      digitalWrite(i, HIGH);
      delay(3);
      digitalWrite(i, LOW);
    }
  }
}

void loop() {
  // put your main code here, to run repeatedly:
  clockwise(512);
  delay(10000);
  anticlockwise(512);
}
