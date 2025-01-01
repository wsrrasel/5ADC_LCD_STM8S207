#ifndef __SERIALCOM_H
#define __SERIALCOM_H
#include "stm8s.h"
#include "stm8s_uart3.h"


  /* UART1 configured as follow:
        - BaudRate = 115200 baud  
        - Word Length = 8 Bits
        - One Stop Bit
        - No parity
        - Receive and transmit enabled
        - UART1 Clock disabled
  */
#define SERIAL_BAUDRATE        9600
#define SERIAL_DATA_BITS       UART3_WORDLENGTH_8D
#define SERIAL_PARITY          UART3_PARITY_NO
#define SERIAL_STOP_BIT        UART3_STOPBITS_1


void Serial_Init(void);
void Serial_Print(char string[]);
char Serial_ReadChar(void);
#endif