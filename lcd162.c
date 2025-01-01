#include "lcd162.h"
#include "stm8s_i2c.h"


static void LCD_SetBit(char data_bit);
static void LCD_Delay(uint32_t ms);

/**
 * @brief Introduces a delay in milliseconds.
 * 
 * This function uses a nested loop to introduce a delay based on the system clock.
 * 
 * @param ms Duration of the delay in milliseconds.
 */
static void LCD_Delay (uint32_t ms) {
    uint32_t i =0 ;
    uint32_t j=0;
    for (i=0; i<=ms; i++){
        for (j=0; j<210; j++) // Nop = Fosc/4
            _asm("nop"); //Perform no operation //assembly code <span style="white-space:pre"> </span>
    }
}

/**
 * @brief Sets the specified bits on the LCD data lines.
 * 
 * This function maps each bit of the input data to the corresponding LCD data pin.
 * 
 * @param data The 4-bit data to set on the LCD.
 */
 static void LCD_SetBit(char data){
    
    (data&0x01) ? GPIO_WriteHigh(LCD_DB4) : GPIO_WriteLow(LCD_DB4);
    (data&0x02) ? GPIO_WriteHigh(LCD_DB5) : GPIO_WriteLow(LCD_DB5);
    (data&0x04) ? GPIO_WriteHigh(LCD_DB6) : GPIO_WriteLow(LCD_DB6); //D6=0
    (data&0x08) ? GPIO_WriteHigh(LCD_DB7) : GPIO_WriteLow(LCD_DB7); //D7=0
}

/**
 * @brief Sends a command to the LCD.
 * 
 * @param cmd The command to send.
 */
void LCD_Cmd(char cmd){
    GPIO_WriteLow(LCD_RS); //RS = 0          
    LCD_SetBit(cmd); //Incoming Hex value
    GPIO_WriteHigh(LCD_EN); //EN  = 1         
	LCD_Delay(2);
	GPIO_WriteLow(LCD_EN); //EN  = 0      
}


 /**
 * @brief Initializes the LCD for operation.
 * 
 * Configures GPIO pins and sends initialization commands to the LCD.
 */
 void LCD_Begin(void){
    //Initialize all GPIO pins as Output 
    GPIO_Init(LCD_RS, GPIO_MODE_OUT_PP_HIGH_FAST);
    GPIO_Init(LCD_EN, GPIO_MODE_OUT_PP_HIGH_FAST);
    GPIO_Init(LCD_DB4, GPIO_MODE_OUT_PP_HIGH_FAST);
    GPIO_Init(LCD_DB5, GPIO_MODE_OUT_PP_HIGH_FAST);
    GPIO_Init(LCD_DB6, GPIO_MODE_OUT_PP_HIGH_FAST);
    GPIO_Init(LCD_DB7, GPIO_MODE_OUT_PP_HIGH_FAST);
    LCD_Delay(10);
	 
	LCD_SetBit(0x00);
	LCD_Delay(1000);  //for(int i=1065244; i<=0; i--)  

	
    LCD_Cmd(0x03);
	LCD_Delay(5);
	
    LCD_Cmd(0x03);
	LCD_Delay(11);
	
    LCD_Cmd(0x03); 
    LCD_Cmd(0x02); //02H is used for Return home -> Clears the RAM and initializes the LCD
    LCD_Cmd(0x02); //02H is used for Return home -> Clears the RAM and initializes the LCD
    LCD_Cmd(0x08); //Select Row 1
    LCD_Cmd(0x00); //Clear Row 1 Display
    LCD_Cmd(0x0C); //Select Row 2
    LCD_Cmd(0x00); //Clear Row 2 Display
    LCD_Cmd(0x06);
 }
 
/**
 * @brief Clears the LCD display and resets the cursor position.
 */
void LCD_Clear(void){
    LCD_Cmd(0); //Clear the LCD
    LCD_Cmd(1); //Move the curser to first position
}

/**
 * @brief Sets the cursor to a specific row and column on the LCD.
 * 
 * @param row The row to set (1 or 2).
 * @param col The column to set.
 */
void LCD_SetCursor(char row, char col){
    char temp,z,y;
    if(row == 1)
    {
      temp = 0x80 + col - 1; //80H is used to move the curser
        z = temp>>4; //Lower 8-bits
        y = temp & 0x0F; //Upper 8-bits
        LCD_Cmd(z); //Set Row
        LCD_Cmd(y); //Set Column
    }
    else if(row == 2)
    {
        temp = 0xC0 + col - 1;
        z = temp>>4; //Lower 8-bits
        y = temp & 0x0F; //Upper 8-bits
        LCD_Cmd(z); //Set Row
        LCD_Cmd(y); //Set Column
    }
}


/**
 * @brief Prints a single character on the LCD.
 * 
 * @param data The character to print.
 */
 void LCD_PrintChar(char data){
   char Lower_Nibble,Upper_Nibble;
   Lower_Nibble = data&0x0F;
   Upper_Nibble = data&0xF0;
   GPIO_WriteHigh(LCD_RS);             // => RS = 1
	 
   LCD_SetBit(Upper_Nibble>>4);             //Send upper half by shifting by 4
   GPIO_WriteHigh(LCD_EN); //EN = 1
   LCD_Delay(5); //for(int i=2130483; i<=0; i--)  NOP(); 
   GPIO_WriteLow(LCD_EN); //EN = 0
	 
   LCD_SetBit(Lower_Nibble); //Send Lower half
   GPIO_WriteHigh(LCD_EN); //EN = 1
   LCD_Delay(5); //for(int i=2130483; i<=0; i--)  NOP();
   GPIO_WriteLow(LCD_EN); //EN = 0
}


/**
 * @brief Prints a string of characters on the LCD.
 * 
 * @param str Pointer to the null-terminated string to print.
 */
void LCD_PrintString(char *str){
    int i;
    for(i=0; str[i]!='\0'; i++){//
       LCD_PrintChar(str[i]);  //Split the string using pointers and call the Char function 
    }
}
