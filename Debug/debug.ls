   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
  45                     ; 4 void dbg_init(void){
  47                     	switch	.text
  48  0000               _dbg_init:
  52                     ; 5     UART1_DeInit();
  54  0000 cd0000        	call	_UART1_DeInit
  56                     ; 7 		UART1_Init((uint32_t)DBG_BAUDRATE, DBG_DATA_BITS, DBG_STOP_BIT, DBG_PARITY,
  56                     ; 8               UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE);
  58  0003 4b0c          	push	#12
  59  0005 4b80          	push	#128
  60  0007 4b00          	push	#0
  61  0009 4b00          	push	#0
  62  000b 4b00          	push	#0
  63  000d ae2580        	ldw	x,#9600
  64  0010 89            	pushw	x
  65  0011 ae0000        	ldw	x,#0
  66  0014 89            	pushw	x
  67  0015 cd0000        	call	_UART1_Init
  69  0018 5b09          	addw	sp,#9
  70                     ; 9 	  UART1_Cmd(ENABLE);
  72  001a a601          	ld	a,#1
  73  001c cd0000        	call	_UART1_Cmd
  75                     ; 10 }
  78  001f 81            	ret
 114                     ; 19 PUTCHAR_PROTOTYPE
 114                     ; 20 {
 115                     	switch	.text
 116  0020               _putchar:
 118  0020 88            	push	a
 119       00000000      OFST:	set	0
 122                     ; 22   UART1_SendData8(c);
 124  0021 cd0000        	call	_UART1_SendData8
 127  0024               L14:
 128                     ; 24 	while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET){;}
 130  0024 ae0080        	ldw	x,#128
 131  0027 cd0000        	call	_UART1_GetFlagStatus
 133  002a 4d            	tnz	a
 134  002b 27f7          	jreq	L14
 135                     ; 26   return (c);
 137  002d 7b01          	ld	a,(OFST+1,sp)
 140  002f 5b01          	addw	sp,#1
 141  0031 81            	ret
 154                     	xdef	_putchar
 155                     	xdef	_dbg_init
 156                     	xref	_UART1_GetFlagStatus
 157                     	xref	_UART1_SendData8
 158                     	xref	_UART1_Cmd
 159                     	xref	_UART1_Init
 160                     	xref	_UART1_DeInit
 179                     	end
