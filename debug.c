#include "debug.h"


void dbg_init(void){
    UART1_DeInit();
      /* UART1 configuration --------------------------------------------------*/
		UART1_Init((uint32_t)DBG_BAUDRATE, DBG_DATA_BITS, DBG_STOP_BIT, DBG_PARITY,
              UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE);
	  UART1_Cmd(ENABLE);
}



/**
  * @brief Retargets the C library printf function to the UART.
  * @param c Character to send
  * @retval char Character sent
  */
PUTCHAR_PROTOTYPE
{
  /* Write a character to the UART1 */
  UART1_SendData8(c);
  /* Loop until the end of transmission */
	while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET){;}

  return (c);
}