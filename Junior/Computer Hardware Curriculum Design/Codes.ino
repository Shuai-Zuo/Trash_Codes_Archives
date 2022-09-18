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
//键盘对应的内容
char keys [ROWS] [COLS] = {
  {'0', '1', '2', '3'},
  {'4', '5', '6', '7'},
  {'8', '9', 'A', 'B'},
  {'C', 'D', 'E', 'F'}
};

SoftwareSerial SynSerial(6, 7);
char buffer[]="即将开始浇水当前室温二十六度";
char buffer2[]="当前光线强度过高即将进行遮光";
char buffer3[]="当前室内气温过高";
char buffer4[]="浇水结束";
int bufferflag = 0, buffer2flag = 0, buffer3flag = 0;
int flag = 0, counter = 0;
//语音合成，编码转换定义变量
#define SIZE (sizeof(buffer)/3)
#define SIZE2 (sizeof(buffer2)/3)
#define SIZE3 (sizeof(buffer3)/3)
#define SIZE4 (sizeof(buffer4)/3)
char character[SIZE * 2];
char character2[SIZE2 * 2];
char character3[SIZE3 * 2];
char character4[SIZE4 * 2];
char output[SIZE*2+6];
char output2[SIZE2*2+6];
char output3[SIZE3*2+6];
char output4[SIZE3*2+6];

volatile int lum1 = 1500;
volatile int hum1 = 600;
char cOp[50];
int cOpi = 0;
volatile int waterflag = 0;
byte rowPins [ROWS] = {0, 1, 2, 3};
byte colPins [COLS] = {4, 5, 6, 7};
Keypad_I2C keypad (makeKeymap (keys), rowPins, colPins, ROWS, COLS, I2CADDR, PCF8574);

//进行温度计数时，修改buffer的后三个汉字
void numbers()
{
   int tem;
   char charactor[]="一";
   tem = (int)dht.readTemperature();
   //根据当前温度，修改汉字的内容
   if(tem%10==0){
      strcpy(charactor,"为");
      for(int i = 0;i<3;i++){
        buffer[sizeof(buffer)-11-i]=charactor[2-i];
      }
      strcpy(charactor,"十");
      for(int i = 0;i<3;i++){
        buffer[sizeof(buffer)-5-i]=charactor[2-i];
      }
    switch(tem/10){
      case 1:
      strcpy(charactor,"一");
      for(int i = 0;i<3;i++){
        buffer[sizeof(buffer)-8-i]=charactor[2-i];
      }
      Serial.print(buffer);
      break;
      case 2:
      strcpy(charactor,"二");
      for(int i = 0;i<3;i++){
        buffer[sizeof(buffer)-8-i]=charactor[2-i];
      }
      break;
      case 3:
      strcpy(charactor,"三");
      for(int i = 0;i<3;i++){
        buffer[sizeof(buffer)-8-i]=charactor[2-i];
      }
      break;
      case 4:
      strcpy(charactor,"四");
      for(int i = 0;i<3;i++){
        buffer[sizeof(buffer)-8-i]=charactor[2-i];
      }
      break;
    }
  }
  else if(tem/10!=1){
      strcpy(charactor,"十");
      for(int i = 0;i<3;i++){
        buffer[sizeof(buffer)-8-i]=charactor[2-i];
      }
    switch(tem/10){
      case 1:
      strcpy(charactor,"一");
      for(int i = 0;i<3;i++){
        buffer[sizeof(buffer)-11-i]=charactor[2-i];
      }
      Serial.print(buffer);
      break;
      case 2:
      strcpy(charactor,"二");
      for(int i = 0;i<3;i++){
        buffer[sizeof(buffer)-11-i]=charactor[2-i];
      }
      break;
      case 3:
      strcpy(charactor,"三");
      for(int i = 0;i<3;i++){
        buffer[sizeof(buffer)-11-i]=charactor[2-i];
      }
      break;
      case 4:
      strcpy(charactor,"四");
      for(int i = 0;i<3;i++){
        buffer[sizeof(buffer)-11-i]=charactor[2-i];
      }
      break;
    }
    switch(tem%10){
      case 1:
      strcpy(charactor,"一");
      for(int i = 0;i<3;i++){
        buffer[sizeof(buffer)-5-i]=charactor[2-i];
      }
      Serial.print(buffer);
      break;
      case 2:
      strcpy(charactor,"二");
      for(int i = 0;i<3;i++){
        buffer[sizeof(buffer)-5-i]=charactor[2-i];
      }
      break;
      case 3:
      strcpy(charactor,"三");
      for(int i = 0;i<3;i++){
        buffer[sizeof(buffer)-5-i]=charactor[2-i];
      }
      break;
      case 4:
      strcpy(charactor,"四");
      for(int i = 0;i<3;i++){
        buffer[sizeof(buffer)-5-i]=charactor[2-i];
      }
      break;
      case 5:
      strcpy(charactor,"五");
      for(int i = 0;i<3;i++){
        buffer[sizeof(buffer)-5-i]=charactor[2-i];
      }
      break;
      case 6:
      strcpy(charactor,"六");
      for(int i = 0;i<3;i++){
        buffer[sizeof(buffer)-5-i]=charactor[2-i];
      }
      break;
      case 7:
      strcpy(charactor,"七");
      for(int i = 0;i<3;i++){
        buffer[sizeof(buffer)-5-i]=charactor[2-i];
      }
      break;
      case 8:
      strcpy(charactor,"八");
      for(int i = 0;i<3;i++){
        buffer[sizeof(buffer)-5-i]=charactor[2-i];
      }
      break;
      case 9:
      strcpy(charactor,"九");
      for(int i = 0;i<3;i++){
        buffer[sizeof(buffer)-5-i]=charactor[2-i];
      }
      break;
    }
  }
  else if(tem/10 == 1){
      strcpy(charactor,"为");
      for(int i = 0;i<3;i++){
        buffer[sizeof(buffer)-11-i]=charactor[2-i];
      }
      strcpy(charactor,"十");
      for(int i = 0;i<3;i++){
        buffer[sizeof(buffer)-5-i]=charactor[2-i];
      }
    switch(tem%10){
      case 1:
      strcpy(charactor,"一");
      for(int i = 0;i<3;i++){
        buffer[sizeof(buffer)-5-i]=charactor[2-i];
      }
      Serial.print(buffer);
      break;
      case 2:
      strcpy(charactor,"二");
      for(int i = 0;i<3;i++){
        buffer[sizeof(buffer)-5-i]=charactor[2-i];
      }
      break;
      case 3:
      strcpy(charactor,"三");
      for(int i = 0;i<3;i++){
        buffer[sizeof(buffer)-5-i]=charactor[2-i];
      }
      break;
      case 4:
      strcpy(charactor,"四");
      for(int i = 0;i<3;i++){
        buffer[sizeof(buffer)-5-i]=charactor[2-i];
      }
      break;
      case 5:
      strcpy(charactor,"五");
      for(int i = 0;i<3;i++){
        buffer[sizeof(buffer)-5-i]=charactor[2-i];
      }
      break;
      case 6:
      strcpy(charactor,"六");
      for(int i = 0;i<3;i++){
        buffer[sizeof(buffer)-5-i]=charactor[2-i];
      }
      break;
      case 7:
      strcpy(charactor,"七");
      for(int i = 0;i<3;i++){
        buffer[sizeof(buffer)-5-i]=charactor[2-i];
      }
      break;
      case 8:
      strcpy(charactor,"八");
      for(int i = 0;i<3;i++){
        buffer[sizeof(buffer)-5-i]=charactor[2-i];
      }
      break;
      case 9:
      strcpy(charactor,"九");
      for(int i = 0;i<3;i++){
        buffer[sizeof(buffer)-5-i]=charactor[2-i];
      }
      break;
    }
  }
}
   //switch


//步进电机部分
void clockwise(int num)
{
  for (int count = 0; count < num; count++)
  {
    for (int i = 8; i < 12; i++)//一相励磁，正转
    {
      digitalWrite(i, HIGH);//逐个写入高电平
      delay(3);
      digitalWrite(i, LOW);
    }
  }
}

void anticlockwise(int num)
{
  for (int count = 0; count < num; count++)
  {
    for (int i = 11; i > 7; i--)//一相励磁，反转
    {
      digitalWrite(i, HIGH);//逐个写入高电平
      delay(3);
      digitalWrite(i, LOW);
    }
  }
}

void goIntoOptions(char key){//OLED屏幕设置界面
  if(optionFlag == 0){
    u8x8.clearDisplay();
  }
  u8x8.setFont(u8x8_font_chroma48medium8_r); 
  u8x8.setCursor(0, 33); 
  u8x8.print("chooseplanttype:"); //选择植物类型
  u8x8.setCursor(0, 50);
  if(optionFlag == 0){
    optionFlag = 1;//此标志位用于表示当前设置界面所显示的内容，以便于对左右移进行响应

    u8x8.print("Desert Plant   >");//沙漠植物
  }
  if(key=='E'){//右移
    if(optionFlag == 1){
      u8x8.print("<tropical plant>");//热带植物
      optionFlag = 2;
    }
    else if(optionFlag == 2){
      u8x8.print("<Temperate plant");//温带植物
      optionFlag = 3;
    }
  }
  if(key=='C'){//左移
    if(optionFlag == 3){
      u8x8.print("<tropical plant>");
      optionFlag = 2;
    }
    else if(optionFlag == 2){
      u8x8.print("Desert Plant   >");
      optionFlag = 1;
    }
  }
  if(key=='D'){//确定
    valuesChange(optionFlag);
    u8x8.clearDisplay();
    optionFlag = 0;
  }
  u8x8.refreshDisplay(); 
}

void CustomizedOptions(char key){//OLED屏幕设置界面，直接调节，光强与湿度阈值
  if(CoptionFlag == 0){
    u8x8.clearDisplay();
  }
  u8x8.setFont(u8x8_font_chroma48medium8_r); 
  u8x8.setCursor(0, 33); 
  u8x8.print("enter Lum:"); 
  u8x8.setCursor(0, 50);
  if(CoptionFlag == 0){
    CoptionFlag = 1;//表示当前设置的进度
  }
  if(CoptionFlag != 0){
    if(key>='0'&&key<='9'){
       u8x8.setCursor(0, 50);
       cOp[cOpi]=key;//将输入的内容显示到OLED屏幕上
       u8x8.print(cOp);
       cOpi++;//cOpi为当前输入的字符在数值中应显示的位置
    }
  if(key=='D'){//确定
    if(CoptionFlag==1){
      if(cOp[0]!='\0'){
        lum1 = atoi(cOp);//将输入的内容转换成数字进行存储
      }
      else{
        u8x8.print("illegal input");
        delay(3000); 
      }
      for(int i = 0 ; i<50 ; i++){
        cOp[i] = '\0';
      }//清空字符串，方便再次设置
      cOpi = 0;//清空字符串的标志位
      CoptionFlag=2;//进入湿度设置
      u8x8.clearDisplay();
      u8x8.setCursor(0, 33); 
      u8x8.print("enter Hum:"); 
      }
      else if(CoptionFlag==2){
       if(cOp[0]!='\0'){
        hum1 = atoi(cOp);//将输入的内容转换成数字进行存储
      }
      else{
        u8x8.print("illegal input");
        delay(3000); //如果输入有问题，则显示非法输入，设置结束
      }
        for(int i = 0 ; i<50 ; i++){
          cOp[i] = '\0';//清空字符串，方便再次设置
        }
        cOpi = 0;//清空字符串的标志位
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
    hum1 = 300;
    case 2:
    lum1 = 1500;
    hum1 = 600;
    case 3:
    lum1 = 1500;
    hum1 = 500;
    default:
    break;
    
  }
}

void UTF8_To_Unicode(char*buf,int which){
  if(which == 1){
    for (int i =0;i<SIZE;i=i+1) {
    character[i*2]=((buf[i*3]&0xF)<<4)+((buf[i*3+1]>>2)&0xF);//将三个字节的UTF-8，转换为两个字节的Unicode
    character[i*2+1]=((buf[i*3+1]&0x3)<<6)+(buf[i*3+2]&0x3F);   
    }
    output[0]=0xFD;//根据帧格式进行输出
    output[1]=(SIZE*2+3)>>8;
    output[2]=((SIZE*2+3)&0xFF);
    output[3]=0x01;
    output[4]=0x03;
    for (int i=0;i<SIZE*2;i++) {
      output[i+5]=character[i];//将Unicode写入
    } 
    output[SIZE*2+5]=output[0];
    for (int i=1;i<SIZE*2+5;i++) {
      output[SIZE*2+5]=output[SIZE*2+5] ^ output[i];//计算异或校验和
    }   
    
    for (int i =0;i<SIZE*2+6;i++) {
      SynSerial.write(output[i]);//输出
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
  else if(which == 4){
    for (int i =0;i<SIZE4;i=i+1) {
    character4[i*2]=((buf[i*3]&0xF)<<4)+((buf[i*3+1]>>2)&0xF);
    character4[i*2+1]=((buf[i*3+1]&0x3)<<6)+(buf[i*3+2]&0x3F);   
    }
    output4[0]=0xFD;
    output4[1]=(SIZE4*2+3)>>8;
    output4[2]=((SIZE4*2+3)&0xFF);
    output4[3]=0x01;
    output4[4]=0x03;
    for (int i=0;i<SIZE4*2;i++) {
      output4[i+5]=character4[i];
    } 
    output4[SIZE4*2+5]=output4[0];
    for (int i=1;i<SIZE4*2+5;i++) {
      output4[SIZE4*2+5]=output4[SIZE4*2+5] ^ output4[i];
    }   
    
    for (int i =0;i<SIZE4*2+6;i++) {
      SynSerial.write(output4[i]);
    }
  }
}

void Watering(int hum){//浇水操作
  if(hum<hum1){
    if(bufferflag==0){
      numbers();//温度的输出
      UTF8_To_Unicode(buffer,1);//转码，语音合成
      bufferflag=1;
    }
    digitalWrite(2,LOW);//继电器开
    waterflag=1;
  }
  else if(hum>=hum1){//达到阈值
      if(bufferflag==1){
        UTF8_To_Unicode(buffer4,4);//转码，语音合成
      bufferflag=0;
    }
    digitalWrite(2,HIGH);//继电器关
    waterflag=0;
  }
}

void setup(void) { 
  for (int i = 8; i < 12; i++) {
    pinMode(i, OUTPUT);
  }
 Wire.begin ();//初始化IIC
 pinMode(2, OUTPUT);
 keypad.begin (makeKeymap (keys));//初始化键盘
 SynSerial.begin(9600);//初始化软串口
 Serial.begin(9600); //初始化debug串口
 Serial.println(sizeof(buffer)-2);
 dht.begin(); //初始化传感器
 u8x8.begin(); //设置OLED
 u8x8.setPowerSave(0); 
 u8x8.setFlipMode(1); 
} 

void loop(void) { 
 float temp;
 int Lum, Hum;
 char key = keypad.getKey ();
 Lum = analogRead(A6);//接收当前室内温湿度指标
 Hum = analogRead(A1);
 temp = dht.readTemperature(); 
 Watering(Hum);
 if(temp>=35&&buffer3flag==0){
  UTF8_To_Unicode(buffer3,3);
  buffer3flag=1;
 }
 else{
  buffer3flag=0;
 }
 if (key) {
  Serial.println (key);
  if(key == 'A'|| CoptionFlag != 0)//进入设置界面
    CustomizedOptions(key);
  if(key == 'F'|| optionFlag != 0){//进入设置界面
    Serial.println (key);
    goIntoOptions(key);
    Serial.println (optionFlag);
  }
 }
 if(optionFlag != 0){
  Serial.println(optionFlag);
  goIntoOptions('N');
 }
 if(timer1<25&&optionFlag == 0&&CoptionFlag == 0){//分别在OLED上显示温度与光强，湿度
   timer1++;//温度与光强的显示
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
    u8x8.clearDisplay();//清屏
  }
  timer1++;//土壤湿度的显示
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
  if(buffer2flag==0){
    UTF8_To_Unicode(buffer2,2);//转码
    buffer2flag=1;
  }
  clockwise(512);//正转
  flag = 1;
 }
 else if(flag == 1 && Lum<lum1){
  buffer2flag=0;
  anticlockwise(512);//反转
  flag = 0;
 }
 Serial.println(timer1);
 delay(10); 
} 
