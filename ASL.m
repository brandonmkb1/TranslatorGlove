function ASL()
    % ASL Glove Simulation using Flex Sensors for all 26 Letters and composing sentences
    
    restart_simulation = true; % Control for restarting the simulation
    sentence = '';  % Initialize an empty string to store the sentence
    
    while restart_simulation
        % Number of flex sensors (5 fingers)
        num_fingers = 5;
        
        % Prompt the user to either enter values manually or use random values
        user_choice = input('Enter 1 for random sensor values, 2 to input values manually, or 3 for a space: ');
        
        if user_choice == 1
            % Simulate random flex sensor values and ensure they map to a valid letter
            sign = 'Unknown';
            while strcmp(sign, 'Unknown')
                flex_sensors = randi([0 1023], 1, num_fingers);  % Generate random values
                sign = detectASLSign(flex_sensors);  % Detect letter
            end
            disp('Random Flex Sensor Values:');
        elseif user_choice == 2
            % Manually input the flex sensor values
            flex_sensors = zeros(1, num_fingers);
            for i = 1:num_fingers
                prompt = sprintf('Enter value for finger %d (0-1023): ', i);
                flex_sensors(i) = input(prompt);
            end
            sign = detectASLSign(flex_sensors);  % Detect letter based on input values
            disp('Manual Flex Sensor Values:');
        elseif user_choice == 3
            sign = '_';  % Add a space if the user selects option 3
        else
            error('Invalid option. Please enter 1, 2, or 3.');
        end
        
        % If a valid letter or space is detected, append it to the sentence
        if strcmp(sign, 'Unknown')
            disp('Unknown gesture, try again.');
        else
            sentence = strcat(sentence, sign);  % Add the letter or space to the sentence
            disp(['Detected ASL Sign: ' sign]);
        end
        
        % Display the sentence so far
        disp(['Current Sentence: ' sentence]);
        
        % Plot flex sensor values for visualization (skip this if a space is chosen)
        if user_choice ~= 3
            figure;
            bar(flex_sensors);
            title('Flex Sensor Values');
            xlabel('Finger');
            ylabel('Sensor Value');
            xticks(1:num_fingers);
            xticklabels({'Thumb', 'Index', 'Middle', 'Ring', 'Pinky'});
            grid on;
        end
        
        % Ask if the user wants to restart the simulation
        restart_choice = input('Do you want to continue adding letters? (y/n): ', 's');
        if lower(restart_choice) ~= 'y'
            restart_simulation = false;
        end
    end
    
    % Display the final sentence after the simulation is complete
    disp(['Final Sentence: ' sentence]);
end

% Function to detect ASL sign based on flex sensor values
function sign = detectASLSign(flex_sensors)
    if flex_sensors(1) > 800 && all(flex_sensors(2:5) < 200)
        sign = 'A';  % Thumb bent, others straight
    elseif all(flex_sensors(1:4) > 800) && flex_sensors(5) < 300
        sign = 'B';  % All fingers bent except pinky
    elseif all(flex_sensors > 600)  % All fingers bent in a 'C' shape
        sign = 'C';
    elseif flex_sensors(1) < 300 && all(flex_sensors(2:5) > 800)
        sign = 'D';  % Only index finger straight
    elseif all(flex_sensors > 600) && flex_sensors(2) < 300
        sign = 'E';  % All fingers bent with index relaxed
    elseif flex_sensors(1) > 800 && flex_sensors(2) < 200 && all(flex_sensors(3:5) > 800)
        sign = 'F';  % Thumb and index bent into circle, others straight
    elseif all(flex_sensors(1:2) < 300) && all(flex_sensors(3:5) > 800)
        sign = 'G';  % Thumb and index pointing forward
    elseif all(flex_sensors(1:3) < 300) && all(flex_sensors(4:5) > 800)
        sign = 'H';  % Index and middle pointing forward
    elseif flex_sensors(5) > 800 && all(flex_sensors(1:4) < 200)
        sign = 'I';  % Only pinky bent
    elseif flex_sensors(5) > 800 && all(flex_sensors(1:3) < 300) && flex_sensors(4) > 600
        sign = 'J';  % Pinky bent with sweeping motion (can visualize as a motion)
    elseif flex_sensors(1) > 800 && flex_sensors(2) < 200 && flex_sensors(3) > 800 && all(flex_sensors(4:5) < 300)
        sign = 'K';  % Thumb up, index straight, middle bent
    elseif flex_sensors(1) > 800 && all(flex_sensors(2:3) < 200) && all(flex_sensors(4:5) > 800)
        sign = 'L';  % Thumb and index in "L" shape
    elseif all(flex_sensors(1:4) > 800) && flex_sensors(5) < 200
        sign = 'M';  % Three fingers crossed over thumb
    elseif all(flex_sensors(1:3) > 800) && all(flex_sensors(4:5) < 300)
        sign = 'N';  % Two fingers crossed over thumb
    elseif all(flex_sensors > 800)
        sign = 'O';  % All fingers curled to make an "O"
    elseif flex_sensors(1) > 800 && flex_sensors(2) < 400 && flex_sensors(3) > 800 && flex_sensors(4) < 300
        sign = 'P';  % Thumb and middle bent, index pointing forward
    elseif all(flex_sensors(1:2) < 200) && all(flex_sensors(3:5) > 800)
        sign = 'Q';  % Thumb and index pointing downward
    elseif all(flex_sensors(1:2) > 800) && all(flex_sensors(3:4) < 300) && flex_sensors(5) > 800
        sign = 'R';  % Index and middle crossed
    elseif all(flex_sensors > 800) && flex_sensors(3) < 200
        sign = 'S';  % All fingers curled into a fist
    elseif all(flex_sensors(2:5) > 800) && flex_sensors(1) < 300
        sign = 'T';  % Thumb over curled fingers
    elseif flex_sensors(1) < 300 && all(flex_sensors(2:3) > 800) && all(flex_sensors(4:5) < 300)
        sign = 'U';  % Index and middle straight up
    elseif flex_sensors(1) < 300 && all(flex_sensors(2:3) > 700) && all(flex_sensors(4:5) < 300)
        sign = 'V';  % Index and middle straight up, others bent
    elseif all(flex_sensors(1:3) < 300) && all(flex_sensors(4:5) > 700)
        sign = 'W';  % Three fingers straight up
    elseif all(flex_sensors(1:3) > 800) && flex_sensors(4) < 300 && flex_sensors(5) > 800
        sign = 'X';  % Index curled like a hook
    elseif flex_sensors(1) < 300 && flex_sensors(2) > 800 && all(flex_sensors(3:5) < 300)
        sign = 'Y';  % Thumb and pinky out, others bent
    elseif all(flex_sensors > 650)
        sign = 'Z';  % Z is a motion; simulate it as all fingers moving
    else
        sign = 'Unknown';  % Default for undefined gestures
    end
end
