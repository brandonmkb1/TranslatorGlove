import serial
import csv
import time

# Set up the serial connection (adjust COM port and baud rate accordingly)
ser = serial.Serial('COM3', 9600)  # Change 'COM3' to the correct port (use '/dev/ttyUSB0' on Linux/Mac)

# Give the Arduino time to start
time.sleep(2)

# Create a new CSV file and write the header
with open('flex_sensor_data.csv', mode='w', newline='') as file:
    writer = csv.writer(file)
    # Write a header row with flex sensor names
    writer.writerow(['Time (s)', 'Flex Sensor 1 (ohms)', 'Flex Sensor 2 (ohms)', 'Flex Sensor 3 (ohms)', 
                     'Flex Sensor 4 (ohms)', 'Flex Sensor 5 (ohms)', 'Flex Sensor 6 (ohms)'])

    start_time = time.time()

    try:
        while True:
            # Read a line of data from the serial port
            data = ser.readline().decode('utf-8').strip()
            
            # Split the comma-separated values for resistances
            resistances = data.split(',')
            
            # Calculate elapsed time
            elapsed_time = time.time() - start_time
            
            # Write the time and resistances to the CSV file
            writer.writerow([elapsed_time] + resistances)

            # Optional: Print the data to the console for verification
            print(f'Time: {elapsed_time:.2f}s, Resistances: {resistances}')
            
    except KeyboardInterrupt:
        # Stop the program when interrupted
        print("Data collection stopped.")

# Close the serial connection when done
ser.close()
