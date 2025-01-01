   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
  45                     ; 3 void Serial_Init(void){
  47                     	switch	.text
  48  0000               _Serial_Init:
  52                     ; 4     UART3_DeInit();
  54  0000 cd0000        	call	_UART3_DeInit
  56                     ; 6 	UART3_Init((uint32_t)SERIAL_BAUDRATE, 
  56                     ; 7             SERIAL_DATA_BITS, 
  56                     ; 8             SERIAL_STOP_BIT, 
  56                     ; 9             SERIAL_PARITY,
  56                     ; 10             UART3_MODE_TXRX_ENABLE);
  58  0003 4b0c          	push	#12
  59  0005 4b00          	push	#0
  60  0007 4b00          	push	#0
  61  0009 4b00          	push	#0
  62  000b ae2580        	ldw	x,#9600
  63  000e 89            	pushw	x
  64  000f ae0000        	ldw	x,#0
  65  0012 89            	pushw	x
  66  0013 cd0000        	call	_UART3_Init
  68  0016 5b08          	addw	sp,#8
  69                     ; 11 	UART3_Cmd(ENABLE);
  71  0018 a601          	ld	a,#1
  72  001a cd0000        	call	_UART3_Cmd
  74                     ; 12 }
  77  001d 81            	ret
 123                     ; 16 void Serial_Print(char string[]) {
 124                     	switch	.text
 125  001e               _Serial_Print:
 127  001e 89            	pushw	x
 128  001f 88            	push	a
 129       00000001      OFST:	set	1
 132                     ; 17     char i=0;
 134  0020 0f01          	clr	(OFST+0,sp)
 137  0022 2016          	jra	L74
 138  0024               L34:
 139                     ; 19         UART3_SendData8(string[i]);
 141  0024 7b01          	ld	a,(OFST+0,sp)
 142  0026 5f            	clrw	x
 143  0027 97            	ld	xl,a
 144  0028 72fb02        	addw	x,(OFST+1,sp)
 145  002b f6            	ld	a,(x)
 146  002c cd0000        	call	_UART3_SendData8
 149  002f               L55:
 150                     ; 20         while (UART3_GetFlagStatus(UART3_FLAG_TXE) == RESET);
 152  002f ae0080        	ldw	x,#128
 153  0032 cd0000        	call	_UART3_GetFlagStatus
 155  0035 4d            	tnz	a
 156  0036 27f7          	jreq	L55
 157                     ; 21         i++;
 159  0038 0c01          	inc	(OFST+0,sp)
 161  003a               L74:
 162                     ; 18     while (string[i] != 0x00){
 164  003a 7b01          	ld	a,(OFST+0,sp)
 165  003c 5f            	clrw	x
 166  003d 97            	ld	xl,a
 167  003e 72fb02        	addw	x,(OFST+1,sp)
 168  0041 7d            	tnz	(x)
 169  0042 26e0          	jrne	L34
 170                     ; 23  }
 173  0044 5b03          	addw	sp,#3
 174  0046 81            	ret
 200                     ; 27  char Serial_ReadChar(void){
 201                     	switch	.text
 202  0047               _Serial_ReadChar:
 206                     ; 28     if(UART3_GetFlagStatus(UART3_FLAG_RXNE) == TRUE){
 208  0047 ae0020        	ldw	x,#32
 209  004a cd0000        	call	_UART3_GetFlagStatus
 211  004d a101          	cp	a,#1
 212  004f 2613          	jrne	L17
 214  0051               L57:
 215                     ; 29         while (UART3_GetFlagStatus(UART3_FLAG_RXNE) == RESET){;}
 217  0051 ae0020        	ldw	x,#32
 218  0054 cd0000        	call	_UART3_GetFlagStatus
 220  0057 4d            	tnz	a
 221  0058 27f7          	jreq	L57
 222                     ; 30         UART3_ClearFlag(UART3_FLAG_RXNE);
 224  005a ae0020        	ldw	x,#32
 225  005d cd0000        	call	_UART3_ClearFlag
 227                     ; 31         return (UART3_ReceiveData8());                                                                           
 229  0060 cd0000        	call	_UART3_ReceiveData8
 233  0063 81            	ret
 234  0064               L17:
 235                     ; 33     return 0;
 237  0064 4f            	clr	a
 240  0065 81            	ret
 253                     	xdef	_Serial_ReadChar
 254                     	xdef	_Serial_Print
 255                     	xdef	_Serial_Init
 256                     	xref	_UART3_ClearFlag
 257                     	xref	_UART3_GetFlagStatus
 258                     	xref	_UART3_SendData8
 259                     	xref	_UART3_ReceiveData8
 260                     	xref	_UART3_Cmd
 261                     	xref	_UART3_Init
 262                     	xref	_UART3_DeInit
 281                     	end
