#include <Key.h>
#include <Keypad.h>
#include <Keypad_I2C.h>

#define I2CADDR 0x20 // Set the Address of the PCF8574

const byte ROWS = 4; // Set the number of Rows
const byte COLS = 4; // Set the number of Columns

// Set the Key at Use (4x4)
char keys [ROWS] [COLS] = {
  {'1', '2', '3', 'A'},
  {'4', '5', '6', 'B'},
  {'7', '8', '9', 'C'},
  {'*', '0', '#', 'D'}
};

// define active Pin (4x4)
byte rowPins [ROWS] = {0, 1, 2, 3}; // Connect to Keyboard Row Pin
byte colPins [COLS] = {4, 5, 6, 7}; // Connect to Pin column of keypad.

// makeKeymap (keys): Define Keymap
// rowPins:Set Pin to Keyboard Row
// colPins: Set Pin Column of Keypad
// ROWS: Set Number of Rows.
// COLS: Set the number of Columns
// I2CADDR: Set the Address for i2C
// PCF8574: Set the number IC
Keypad_I2C keypad (makeKeymap (keys), rowPins, colPins, ROWS, COLS, I2CADDR, PCF8574);

void setup () {
  Wire .begin (); // Call the connection Wire
  keypad.begin (makeKeymap (keys)); // Call the connection
  Serial.begin (9600);

}
void loop () {
 
  char key = keypad.getKey (); // Create a variable named key of type char to hold the characters pressed
 
  if (key) {// if the key variable contains
    Serial.println (key); // output characters from Serial Monitor
  }
}
