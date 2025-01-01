# 5ADC_LCD_STM8S207_FW

MCU: STM8S207

## Feature:
- 5 x ADC channels
- 1 Debug port
- 1 Serial port
- 1602 LCD

##
# STM8S207 ADC and LCD Firmware V1.1

## 1. Pin Configuration

| Pin Name       | Pin Label | Pin Number |
|----------------|-----------|------------|
| **ADC Ch 1**  | PB0       | 22         |
| **ADC Ch 2**  | PB1       | 21         |
| **ADC Ch 3**  | PB2       | 20         |
| **ADC Ch 4**  | PB3       | 19         |
| **ADC Ch 5**  | PB6 (PB4) | 15 (17)    |
| **Debug TX**  | PA5       | 11         |
| **Debug RX**  | PA4       | 10         |
| **Serial TX** | PD5       | 46         |
| **Serial RX** | PD6       | 47         |
| **LCD SCL**   | PB4 or PE1| 17 or 35   |
| **LCD SDA**   | PB5 or PE2| 16 or 34   |
| **LED**       | PB7       | 15         |

## 2. 1602 LCD

### Available Functions

1. **`void LCD_Begin(void)`**
   - **Description**: Initializes the LCD hardware and prepares it for operation. Configures GPIO pins and sends initialization commands to the LCD.
   - **Usage**: Call this function once at the beginning of your program to initialize the LCD.

2. **`void LCD_Cmd(char cmd)`**
   - **Description**: Sends a command to the LCD to control operations like clearing the screen or setting the cursor position.
   - **Parameters**: 
     - `cmd (char)`: The command to be sent to the LCD.
   - **Usage**: Use for low-level control of the LCD.

3. **`void LCD_Clear(void)`**
   - **Description**: Clears the LCD display and resets the cursor.
   - **Usage**: Call to clear the screen whenever needed.

4. **`void LCD_SetCursor(char row, char col)`**
   - **Description**: Sets the cursor to a specific position on the LCD.
   - **Parameters**:
     - `row (char)`: Row number (1 or 2).
     - `col (char)`: Column number (1 to 16).
   - **Usage**: Use before printing text.

5. **`void LCD_PrintString(char *str)`**
   - **Description**: Prints a string to the LCD at the current cursor position.
   - **Parameters**: 
     - `str (char*)`: String to print.
   - **Usage**: Display text on the LCD.

6. **`void LCD_PrintChar(char data)`**
   - **Description**: Prints a single character to the LCD at the current cursor position.
   - **Parameters**: 
     - `data (char)`: Character to print.
   - **Usage**: Display individual characters.

7. **`void LCD_OnBL(void)`**
   - **Description**: Turns on the LCD backlight.

8. **`void LCD_OffBL(void)`**
   - **Description**: Turns off the LCD backlight.

---

## 3. ADC

### Pre-Configuration

1. **ADC Resolution**
   - Defined as 10-bit with values ranging from 0 to 1023:
     ```c
     #define ADC_RESOLUTION 1024
     ```

2. **Channel Definitions**
   ```c
   #define ADC_CH_1        ADC2_CHANNEL_0
   #define ADC_CH_2        ADC2_CHANNEL_1
   #define ADC_CH_3        ADC2_CHANNEL_2
   #define ADC_CH_4        ADC2_CHANNEL_3
   #define ADC_CH_5        ADC2_CHANNEL_6
   ```

3. **Structure Definition**
   ```c
   typedef struct ADC {
       uint8_t channel;              // ADC channel
       uint16_t value;               // Latest ADC value
       MovAvgFilter_ts movAvgFltr;   // Moving average filter
   } ADC_ts;
   ```

4. **Library Dependencies**
   - Include the moving average filter library (MovAvgFilter_ts) for filtering functionality.

### Available Functions

1. **`void ADC_Init(ADC_ts *adc, uint8_t channel)`**
   - **Description**: Initializes an ADC instance for the specified channel.
   - **Parameters**:
     - `adc (ADC_ts*)`: Pointer to the ADC instance.
     - `channel (uint8_t)`: ADC channel.
   - **Usage**: Initialize ADC before performing operations.

2. **`uint16_t ADC_Read(ADC_ts *adc)`**
   - **Description**: Reads and filters ADC value.
   - **Parameters**: 
     - `adc (ADC_ts*)`: Pointer to the ADC instance.
   - **Return Value**: Filtered ADC value.
   - **Usage**: Get filtered ADC values.

3. **`uint16_t ADC_ReadChannel(uint8_t channel)`**
   - **Description**: Reads raw ADC value without filtering.
   - **Parameters**: 
     - `channel (uint8_t)`: ADC channel.
   - **Return Value**: Raw ADC value.
   - **Usage**: Perform a quick read.

---

## 4. Serial Communication

### Pre-Configuration

- **Settings**:
  ```c
  #define SERIAL_BAUDRATE        9600
  #define SERIAL_DATA_BITS       UART3_WORDLENGTH_8D
  #define SERIAL_PARITY          UART3_PARITY_NO
  #define SERIAL_STOP_BIT        UART3_STOPBITS_1
  ```

### Available Functions

1. **`void Serial_Init(void)`**
   - **Description**: Initializes UART3 with predefined settings.
   - **Usage**: Call at program start.

2. **`void Serial_Print(char string[])`**
   - **Description**: Transmits a null-terminated string over UART.
   - **Parameters**:
     - `string[]`: Character array to transmit.
   - **Usage**: Send strings via UART.

3. **`char Serial_ReadChar(void)`**
   - **Description**: Reads a single character from UART.
   - **Return Value**: 
     - Received character or 0 if no data is available.
   - **Usage**: Receive single characters.

---

## 5. Debug Port

### Pre-Configuration

- **Settings**:
  ```c
  #define DBG_BAUDRATE 9600
  #define DBG_DATA_BITS UART1_WORDLENGTH_8D
  #define DBG_PARITY UART1_PARITY_NO
  #define DBG_STOP_BIT UART1_STOPBITS_1
  ```

### Available Functions

1. **`void dbg_init(void)`**
   - **Description**: Initializes UART1 for debugging.
   - **Usage**: Initialize UART1 at program start.

2. **`#define dbg_print printf`**
   - **Description**: Alias for `printf` to send messages over UART1.
   - **Usage**: Use `dbg_print` for debug output.
