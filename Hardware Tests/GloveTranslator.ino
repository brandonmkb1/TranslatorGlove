// Flex sensor pins
const int flexPins[] = {A0, A1, A2, A3, A4, A5}; // Analog pins connected to flex sensors

// Known fixed resistor value (in ohms)
const float fixedResistor = 10000.0; // 10k ohms

void setup() {
  Serial.begin(9600); // Start serial communication
}

void loop() {
  // For Serial Monitor (formatted output)
  Serial.println("Resistances (ohms):");

  // For Serial Plotter (raw values)
  for (int i = 0; i < 6; i++) {
    // Read the analog value from each flex sensor
    int sensorValue = analogRead(flexPins[i]);

    // Calculate the voltage (Arduino ADC = 10-bit, 0-1023 corresponds to 0-5V)
    float voltage = sensorValue * (5.0 / 1023.0);

    // Calculate the resistance of the flex sensor using the voltage divider formula
    float flexResistor = (5.0 * fixedResistor / voltage) - fixedResistor;

    // For Serial Monitor: Print sensor number and resistance
    Serial.print("Flex sensor ");
    Serial.print(i + 1);
    Serial.print(": ");
    Serial.print(flexResistor);
    Serial.println(" ohms");

    // For Serial Plotter: Output the resistance values
    Serial.print(flexResistor); 
    if (i < 5) {
      Serial.print(","); // Comma separates values for Serial Plotter
    }
  }
  Serial.println(); // Newline for Serial Plotter

  // Wait a short time before reading again
  delay(500);
}
