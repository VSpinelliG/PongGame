#include <Arduino.h>
//https://learn.sparkfun.com/tutorials/connecting-arduino-to-processing/all

int analogPin = A0; // potentiometer wiper (middle terminal) connected to analog pin 3
int analogPin2 = A1; // potentiometer wiper (middle terminal) connected to analog pin 3
                    // outside leads to ground and +5V
long int val = 0;  // variable to store the value read
long int val2 = 0;

void setup() {
  Serial.begin(3600);           //  setup serial
}

void loop() {
  val = analogRead(analogPin);  // read the input pin
  val2 = analogRead(analogPin2);
  //long int a = (val*400)/1024;
  Serial.print(val);
  Serial.print(" ");
  Serial.println(val2);
}
