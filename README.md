5ADC_LCD_STM8S207_FW

MCU: STM8S207

Feature:

5 x ADC channels
1 Debug port
1 Serial port
1602 LCD


Instructions For 5ADC with LCD and STM8S207 MCU Firmware V1.1
1.	Pin Configuration

Pin Name	Pin Label	Pin Number
---------------------------------
ADC Ch 1	PB0	        22
ADC Ch 2	PB1	        21
ADC Ch 3	PB2	        20
ADC Ch 4	PB3	        19
ADC Ch 5	PB6 (PB4)	15 (17)
Debug TX	PA5	        11
Debug RX	PA4	        10
Serial TX	PD5	        46
Serial RX	PD6	        47
LCD SCL	    PB4 or PE1	17 or 35
LCD SDA	    PB5 or PE2	16 or 34
LED	        PB7	        15




2.	1602 LCD
Available Functions
1. void LCD_Begin(void)
Description: Initializes the LCD hardware and prepares it for operation. This function configures the GPIO pins and sends initialization commands to the LCD.
Usage: Call this function once at the beginning of your program to initialize the LCD.

2. void LCD_Cmd(char cmd)
Description: Sends a command to the LCD. Commands control various LCD operations, such as clearing the screen or setting the cursor position.
Parameters:
•	cmd (char): The command to be sent to the LCD.
Usage: Use this function for low-level control of the LCD.

3. void LCD_Clear(void)
Description: Clears the LCD display and resets the cursor to the first position.
Usage: Call this function to clear the screen whenever needed.

4. void LCD_SetCursor(char row, char col)
Description: Sets the cursor to a specific position on the LCD.
Parameters:
•	row (char): The row number (1 or 2 for a 2-row LCD).
•	col (char): The column number (1 to 16, depending on the LCD size).
Usage: Use this function to position the cursor before printing text.

5. void LCD_PrintString(char *str)
Description: Prints a string of characters to the LCD at the current cursor position.
Parameters:
•	str (char*): The string to print.
Usage: Call this function to display text on the LCD.

6. void LCD_PrintChar(char data)
Description: Prints a single character to the LCD at the current cursor position.
Parameters:
•	data (char): The character to print.
Usage: Use this function to display individual characters.

11. void LCD_OnBL(void)
Description: Turns on the LCD backlight.

12. void LCD_OffBL(void)
Description: Turns off the LCD backlight.






3.	ADC
Pre-Configuration
1.	ADC Resolution The ADC resolution is defined as 10-bit, with a range of values from 0 to 1023:
#define ADC_RESOLUTION 1024

2.	Channel Definitions The ADC interface supports multiple channels defined as follows:
#define ADC_CH_1        ADC2_CHANNEL_0
#define ADC_CH_2        ADC2_CHANNEL_1
#define ADC_CH_3        ADC2_CHANNEL_2
#define ADC_CH_4        ADC2_CHANNEL_3
#define ADC_CH_5        ADC2_CHANNEL_6

3.	Structure Definition The ADC_ts structure is used to define an ADC instance:
typedef struct ADC {
    uint8_t channel;              // ADC channel to be used
    uint16_t value;               // Latest ADC value
    MovAvgFilter_ts movAvgFltr;   // Moving average filter 
} ADC_ts;

4.	Library Dependencies Ensure that the moving average filter (MovAvgFilter_ts) library is included if filtering functionality is needed.

Available Functions
1. void ADC_Init(ADC_ts *adc, uint8_t channel)
Description: Initializes an ADC instance for the specified channel.
Parameters:
•	adc (ADC_ts*): Pointer to the ADC instance to be initialized.
•	channel (uint8_t): ADC channel to be associated with the instance.
Usage:Call this function to initialize an ADC instance before performing any operations.

2. uint16_t ADC_Read(ADC_ts *adc)
Description: Reads the latest ADC value from the specified ADC instance and applies the moving average filter (if enabled).
Parameters:
•	adc (ADC_ts*): Pointer to the ADC instance to read data from.
Return Value: Returns the filtered ADC value.
Usage: Call this function to get the latest filtered ADC value.

3. uint16_t ADC_ReadChannel(uint8_t channel)
Description: Reads the raw ADC value directly from the specified channel without filtering.
Parameters:
•	channel (uint8_t): ADC channel to read data from.
Return Value: Returns the raw ADC value.
Usage: Use this function to perform a quick read from a specific channel.


4.	Serial Communication
Pre-Configuration
The UART interface is pre-configured with the following parameters:
•	Baud Rate: 9600 bits per second.
•	Word Length: 8 bits.
•	Stop Bit: 1.
•	Parity: None.
•	Mode: Transmit and Receive enabled.

These settings are defined as:
#define SERIAL_BAUDRATE        9600
#define SERIAL_DATA_BITS       UART3_WORDLENGTH_8D
#define SERIAL_PARITY          UART3_PARITY_NO
#define SERIAL_STOP_BIT        UART3_STOPBITS_1

Available Functions
1. void Serial_Init(void)
Description: Initializes the UART3 peripheral with the specified settings.
Functionality:
•	Configures UART3 for the predefined baud rate, word length, parity, and stop bit.
•	Enables both transmit (TX) and receive (RX) functionalities.
Usage: Call this function once at the start of the program to initialize the UART peripheral.

2. void Serial_Print(char string[])
Description: Transmits a null-terminated string over the UART interface.
Parameters:
•	string[]: A character array (string) to be transmitted.
Functionality:
•	Sends characters one by one until a null character ('\0') is encountered.
•	Waits for the transmission buffer to be empty before sending the next character.
Usage: Call this function to send strings or messages via UART.

3. char Serial_ReadChar(void)
Description: Reads a single character from the UART receive buffer.
Return Value:
•	Returns the received character if data is available.
•	Returns 0 if no data is available in the receive buffer.
Functionality:
•	Checks if the UART receive buffer has data.
•	Reads the character from the buffer and clears the receive flag.
Usage: Call this function to receive a single character from the UART interface.




5.	Debug Port

Pre-Configuration
The UART1 interface is configured with the following settings:
•	Baud Rate: 9600 bits per second.
•	Word Length: 8 bits.
•	Stop Bit: 1.
•	Parity: None.
•	Mode: Both Transmit (TX) and Receive (RX) enabled.

These settings are defined as:
	#define DBG_BAUDRATE 9600 
	#define DBG_DATA_BITS UART1_WORDLENGTH_8D 
	#define DBG_PARITY UART1_PARITY_NO 
	#define DBG_STOP_BIT UART1_STOPBITS_1

Available Functions
1. void dbg_init(void)
Description: Initializes UART1 for debugging with the predefined configuration.
Functionality:
•	Configures UART1 for the predefined baud rate, word length, parity, and stop bit.
•	Enables both transmit and receive functionalities.
•	Prepares the UART1 for use with the dbg_print macro.
Usage: Call this function once at the start of the program to initialize the UART1 peripheral for debugging.

2. #define dbg_print printf
Description: Defines dbg_print as an alias for the standard printf function.
Functionality:
•	This allows you to use dbg_print as a shorthand for the printf function to send messages over UART1.
•	It simplifies debugging print statements and outputs.
Usage: Use dbg_print instead of printf to output debug information.



