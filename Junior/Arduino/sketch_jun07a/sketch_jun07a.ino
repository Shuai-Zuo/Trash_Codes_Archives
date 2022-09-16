#include "Adafruit_CCS811.h"
#include <SoftwareSerial.h>
Adafruit_CCS811 ccs;
SoftwareSerial SynSerial(6, 7);
void setup() {
  SynSerial.begin(9600);
  Serial.begin(9600); 
  Serial.println("CCS811 test");
 
  if(!ccs.begin()){
    Serial.println("Failed to start sensor! Please check your wiring.");
    while(1);
  }
 
  // Wait for the sensor to be ready
  while(!ccs.available());
}
 
void loop() {
  if(ccs.available()){
    if(!ccs.readData()){
      Serial.print("CO2: ");
      SynSerial.print(ccs.geteCO2());
      SynSerial.print("ppm, TVOC: ");
      SynSerial.print(ccs.getTVOC());
      SynSerial.print("\n");
    }
    else{
      SynSerial.println("ERROR!");
      while(1);
    }
  }
  delay(500);
}
