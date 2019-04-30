#include <Arduino.h>
//https://learn.sparkfun.com/tutorials/connecting-arduino-to-processing/all

int analogPin = A0; // potentiometer wiper (middle terminal) connected to analog pin 3
                    // outside leads to ground and +5V
long int val = 0;  // variable to store the value read

void setup() {
  Serial.begin(115200);           //  setup serial
}

void loop() {
  val = analogRead(analogPin);  // read the input pin
  long int a = (val*400)/1024;
  Serial.println(val);
}
