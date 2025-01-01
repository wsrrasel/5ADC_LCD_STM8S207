#include "SerialCom.h"

/**
 * @brief Initializes the UART3 serial communication interface.
 * 
 * This function deinitializes the UART3 peripheral and configures it with
 * the specified baud rate, data bits, stop bit, and parity settings.
 */
void Serial_Init(void){
    UART3_DeInit();
      /* UART1 configuration --------------------------------------------------*/
	UART3_Init((uint32_t)SERIAL_BAUDRATE, 
            SERIAL_DATA_BITS, 
            SERIAL_STOP_BIT, 
            SERIAL_PARITY,
            UART3_MODE_TXRX_ENABLE);
	UART3_Cmd(ENABLE);
}


/**
 * @brief Sends a null-terminated string via UART3.
 * 
 * This function iterates through the provided string and transmits each
 * character over UART3. It waits for the TXE flag to ensure the previous
 * byte is transmitted before sending the next byte.
 * 
 * @param string The null-terminated string to transmit.
 */
void Serial_Print(char string[]) {
    char i=0;
    while (string[i] != 0x00){
        UART3_SendData8(string[i]);
        while (UART3_GetFlagStatus(UART3_FLAG_TXE) == RESET);
        i++;
    }
 }


/**
 * @brief Reads a single character from UART3.
 * 
 * This function checks if data is available in the UART3 receive buffer.
 * If data is present, it reads the character and clears the RXNE flag.
 * 
 * @return The received character, or 0 if no data is available.
 */
 char Serial_ReadChar(void){
    if(UART3_GetFlagStatus(UART3_FLAG_RXNE) == TRUE){
        while (UART3_GetFlagStatus(UART3_FLAG_RXNE) == RESET){;}
        UART3_ClearFlag(UART3_FLAG_RXNE);
        return (UART3_ReceiveData8());                                                                           
    }
    return 0;
 }