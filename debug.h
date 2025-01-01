#ifndef __DEBUG_H
#define __DEBUG_H
#include "stm8s.h"
#include "stm8s_uart1.h"

#define PUTCHAR_PROTOTYPE char putchar (char c)
#define GETCHAR_PROTOTYPE char getchar (void)


  /* UART1 configured as follow:
        - BaudRate = 115200 baud  
        - Word Length = 8 Bits
        - One Stop Bit
        - No parity
        - Receive and transmit enabled
        - UART1 Clock disabled
  */
#define DBG_BAUDRATE        9600
#define DBG_DATA_BITS       UART1_WORDLENGTH_8D
#define DBG_PARITY          UART1_PARITY_NO
#define DBG_STOP_BIT        UART1_STOPBITS_1


#define dbg_print 		printf

void dbg_init(void);

#endif // !__DEBUG_H