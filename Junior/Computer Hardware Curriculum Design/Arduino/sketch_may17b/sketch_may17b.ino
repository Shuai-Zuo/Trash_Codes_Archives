//Temperature and Humidity Sensor
#include "DHT.h"
#include <U8x8lib.h>
#include <SoftwareSerial.h>
#define DHTPIN 3 // what pin we're connected to
#define DHTTYPE DHT11 // DHT 11 
DHT dht(DHTPIN, DHTTYPE); 

U8X8_SSD1306_128X64_ALT0_HW_I2C u8x8(/* reset=*/ U8X8_PIN_NONE); 
volatile int timer1;
volatile int optionFlag = 0;
volatile int CoptionFlag = 0;

#include <Key.h>
#include <Keypad.h>
#include <Keypad_I2C.h>
#define I2CADDR 0x20
const byte ROWS = 4;
const byte COLS = 4;

char keys [ROWS] [COLS] = {
  {'0', '1', '2', '3'},
  {'4', '5', '6', '7'},
  {'8', '9', 'A', 'B'},
  {'C', 'D', 'E', 'F'}
};

SoftwareSerial SynSerial(6, 7);
char buffer[]="即将开始浇水";
char buffer2[]="当前光线强度过高，即将进行遮光";
char buffer3[]="当前室内气温过高";
int flag = 0, counter = 0;
#define SIZE (sizeof(buffer)/3)
#define SIZE2 (sizeof(buffer2)/3)
#define SIZE3 (sizeof(buffer3)/3)
char character[SIZE * 2];
char character2[SIZE2 * 2];
char character3[SIZE3 * 2];
char output[SIZE*2+6];
char output2[SIZE2*2+6];
char output3[SIZE3*2+6];

volatile int lum1 = 1500;
volatile int hum1 = 600;
char cOp[50];
int cOpi = 0;
volatile int waterflag = 0;
byte rowPins [ROWS] = {0, 1, 2, 3};
byte colPins [COLS] = {4, 5, 6, 7};
Keypad_I2C keypad (makeKeymap (keys), rowPins, colPins, ROWS, COLS, I2CADDR, PCF8574);
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

void goIntoOptions(char key){
  if(optionFlag == 0){
    u8x8.clearDisplay();
  }
  u8x8.setFont(u8x8_font_chroma48medium8_r); 
  u8x8.setCursor(0, 33); 
  u8x8.print("chooseplanttype:"); 
  u8x8.setCursor(0, 50);
  if(optionFlag == 0){
    optionFlag = 1;

    u8x8.print("Desert Plant   >");
  }
  if(key=='E'){
    if(optionFlag == 1){
      u8x8.print("<tropical plant>");
      optionFlag = 2;
    }
    else if(optionFlag == 2){
      u8x8.print("<Temperate plant");
      optionFlag = 3;
    }
  }
  if(key=='C'){
    if(optionFlag == 3){
      u8x8.print("<tropical plant>");
      optionFlag = 2;
    }
    else if(optionFlag == 2){
      u8x8.print("Desert Plant   >");
      optionFlag = 1;
    }
  }
  if(key=='D'){
    valuesChange(optionFlag);
    u8x8.clearDisplay();
    optionFlag = 0;
  }
  u8x8.refreshDisplay(); 
}

void CustomizedOptions(char key){
  if(CoptionFlag == 0){
    u8x8.clearDisplay();
  }
  u8x8.setFont(u8x8_font_chroma48medium8_r); 
  u8x8.setCursor(0, 33); 
  u8x8.print("enter Hum:"); 
  u8x8.setCursor(0, 50);
  if(CoptionFlag == 0){
    CoptionFlag = 1;
  }
  if(CoptionFlag != 0){
    if(key>='0'&&key<='9'){
      valuesChange(optionFlag);
       u8x8.setCursor(0, 50);
       cOp[cOpi]=key;
       u8x8.print(cOp);
       cOpi++;
    }
  if(key=='D'){
    if(CoptionFlag==1){
      if(cOp[0]!='\0'){
        lum1 = atoi(cOp);
      }
      else{
        u8x8.print("illegal input");
        delay(3000); 
      }
      for(int i = 0 ; i<50 ; i++){
        cOp[i] = '\0';
      }
      cOpi = 0;
      CoptionFlag=2;
      u8x8.clearDisplay();
      u8x8.setCursor(0, 33); 
      u8x8.print("enter Lum:"); 
      }
      else if(CoptionFlag==2){
       if(cOp[0]!='\0'){
        hum1 = atoi(cOp);
      }
      else{
        u8x8.print("illegal input");
        delay(3000); 
      }
        for(int i = 0 ; i<50 ; i++){
          cOp[i] = '\0';
        }
        cOpi = 0;
        u8x8.clearDisplay();
        CoptionFlag = 0;
      }
    }
  }
  u8x8.refreshDisplay(); 
}

void valuesChange(int optionFlag){
  switch(optionFlag){
    case 1:
    lum1 = 1700;
    hum1 = 400;
    case 2:
    lum1 = 1500;
    hum1 = 800;
    case 3:
    lum1 = 1500;
    hum1 = 600;
    default:
    break;
    
  }
}

void UTF8_To_Unicode(char*buf,int which){
  if(which == 1){
    for (int i =0;i<SIZE;i=i+1) {
    character[i*2]=((buf[i*3]&0xF)<<4)+((buf[i*3+1]>>2)&0xF);
    character[i*2+1]=((buf[i*3+1]&0x3)<<6)+(buf[i*3+2]&0x3F);   
    }
    output[0]=0xFD;
    output[1]=(SIZE*2+3)>>8;
    output[2]=((SIZE*2+3)&0xFF);
    output[3]=0x01;
    output[4]=0x03;
    for (int i=0;i<SIZE*2;i++) {
      output[i+5]=character[i];
    } 
    output[SIZE*2+5]=output[0];
    for (int i=1;i<SIZE*2+5;i++) {
      output[SIZE*2+5]=output[SIZE*2+5] ^ output[i];
    }   
    
    for (int i =0;i<SIZE*2+6;i++) {
      SynSerial.write(output[i]);
    }
  }
  else if(which == 2){
    for (int i =0;i<SIZE2;i=i+1) {
    character2[i*2]=((buf[i*3]&0xF)<<4)+((buf[i*3+1]>>2)&0xF);
    character2[i*2+1]=((buf[i*3+1]&0x3)<<6)+(buf[i*3+2]&0x3F);   
    }
    output2[0]=0xFD;
    output2[1]=(SIZE2*2+3)>>8;
    output2[2]=((SIZE2*2+3)&0xFF);
    output2[3]=0x01;
    output2[4]=0x03;
    for (int i=0;i<SIZE2*2;i++) {
      output2[i+5]=character2[i];
    } 
    output2[SIZE2*2+5]=output2[0];
    for (int i=1;i<SIZE2*2+5;i++) {
      output2[SIZE2*2+5]=output2[SIZE2*2+5] ^ output2[i];
    }   
    
    for (int i =0;i<SIZE2*2+6;i++) {
      SynSerial.write(output2[i]);
    }
  }
  else if(which == 3){
    for (int i =0;i<SIZE3;i=i+1) {
    character3[i*2]=((buf[i*3]&0xF)<<4)+((buf[i*3+1]>>2)&0xF);
    character3[i*2+1]=((buf[i*3+1]&0x3)<<6)+(buf[i*3+2]&0x3F);   
    }
    output3[0]=0xFD;
    output3[1]=(SIZE3*2+3)>>8;
    output3[2]=((SIZE3*2+3)&0xFF);
    output3[3]=0x01;
    output3[4]=0x03;
    for (int i=0;i<SIZE3*2;i++) {
      output3[i+5]=character3[i];
    } 
    output3[SIZE3*2+5]=output3[0];
    for (int i=1;i<SIZE3*2+5;i++) {
      output3[SIZE3*2+5]=output3[SIZE3*2+5] ^ output3[i];
    }   
    
    for (int i =0;i<SIZE3*2+6;i++) {
      SynSerial.write(output3[i]);
    }
  }
}

void Watering(int hum){
  if(hum<hum1){
    UTF8_To_Unicode(buffer2,2);
    digitalWrite(4,HIGH);
    waterflag=1;
  }
  else if(hum>=hum1){
    UTF8_To_Unicode(buffer2,2);
    digitalWrite(4,LOW);
    waterflag=0;
  }
}

void setup(void) { 
  for (int i = 8; i < 12; i++) {
    pinMode(i, OUTPUT);
  }
 Wire.begin ();
 pinMode(4, OUTPUT);
 keypad.begin (makeKeymap (keys));
 SynSerial.begin(9600);
 Serial.begin(9600); 
 dht.begin(); 
 u8x8.begin(); 
 u8x8.setPowerSave(0); 
 u8x8.setFlipMode(1); 
} 

void loop(void) { 
 float temp;
 int Lum, Hum;
 char key = keypad.getKey ();
 Lum = analogRead(A6);
 Hum = analogRead(A1);
 temp = dht.readTemperature(); 
 Watering(Hum);
 if(temp>=35){
  UTF8_To_Unicode(buffer3,3);
 }
 if (key) {
  Serial.println (key);
  if(key == 'A'|| CoptionFlag != 0)
    CustomizedOptions(key);
  if(key == 'F'|| optionFlag != 0){
    Serial.println (key);
    goIntoOptions(key);
    Serial.println (optionFlag);
  }
 }
 if(optionFlag != 0){
  Serial.println(optionFlag);
  goIntoOptions('N');
 }
 if(timer1<25&&optionFlag == 0&&CoptionFlag == 0){
   timer1++;
   temp = dht.readTemperature(); 
   Lum = analogRead(A6);
   u8x8.setFont(u8x8_font_chroma48medium8_r); 
   u8x8.setCursor(0, 33); 
   u8x8.print("Temp:"); 
   u8x8.print(temp); 
   u8x8.print("C"); 
   u8x8.setCursor(0,50); 
   u8x8.print("Lum:"); 
   u8x8.print(Lum); 
   u8x8.print(" "); 
   //Serial.println(temp);
   //Serial.println(Lum);
   u8x8.refreshDisplay(); 
 }
 else if(optionFlag == 0&&CoptionFlag == 0){
  if(timer1 == 25){
    u8x8.clearDisplay();
  }
  timer1++;
  u8x8.setFont(u8x8_font_chroma48medium8_r); 
  u8x8.setCursor(0,41); 
  u8x8.print("Hum:"); 
  u8x8.print(Hum);  
   //Serial.println(temp);
   //Serial.println(Hum);
  u8x8.refreshDisplay(); 
  if(timer1==50){
    timer1 = 0;
  }
 }
 if(flag == 0&&Lum>=lum1){
  UTF8_To_Unicode(buffer,1);
  clockwise(512);
  flag = 1;
 }
 else if(flag == 1 && Lum<lum1){
  UTF8_To_Unicode(buffer,1);
  anticlockwise(512);
  flag = 0;
 }
 delay(100); 
} 
