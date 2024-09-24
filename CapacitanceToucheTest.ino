#include <CapacitiveSensor.h>

// Create a CapacitiveSensor object with sendPin (2) and receivePin (4)
CapacitiveSensor capSensor = CapacitiveSensor(2, 4);

void setup() {
  // Begin serial communication
  Serial.begin(9600);
}

void loop() {
  // Read capacitance value from the sensor
  long sensorValue = capSensor.capacitiveSensor(30);  // 30 is the number of samples

  // Print the sensor value to the serial monitor
  Serial.println(sensorValue);

  // Check if a touch is detected
  if (sensorValue > 1000) {  // Adjust threshold value based on testing
    Serial.println("Touched!");
  } else {
    Serial.println("Not touched");
  }

  // Small delay to make readings more stable
  delay(100);
}
