   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
  72                     .const:	section	.text
  73  0000               L6:
  74  0000 000000d2      	dc.l	210
  75                     ; 11 void Delay_ms (uint32_t ms){
  76                     	scross	off
  77                     	switch	.text
  78  0000               _Delay_ms:
  80  0000 5208          	subw	sp,#8
  81       00000008      OFST:	set	8
  84                     ; 12     uint32_t i =0 ;
  86                     ; 13     uint32_t j=0;
  88                     ; 14     for (i=0; i<=ms; i++){
  90  0002 ae0000        	ldw	x,#0
  91  0005 1f03          	ldw	(OFST-5,sp),x
  92  0007 ae0000        	ldw	x,#0
  93  000a 1f01          	ldw	(OFST-7,sp),x
  96  000c 202c          	jra	L34
  97  000e               L73:
  98                     ; 15         for (j=0; j<210; j++){
 100  000e ae0000        	ldw	x,#0
 101  0011 1f07          	ldw	(OFST-1,sp),x
 102  0013 ae0000        	ldw	x,#0
 103  0016 1f05          	ldw	(OFST-3,sp),x
 105  0018               L74:
 106                     ; 16             _asm("nop");
 109  0018 9d            nop
 111                     ; 15         for (j=0; j<210; j++){
 113  0019 96            	ldw	x,sp
 114  001a 1c0005        	addw	x,#OFST-3
 115  001d a601          	ld	a,#1
 116  001f cd0000        	call	c_lgadc
 121  0022 96            	ldw	x,sp
 122  0023 1c0005        	addw	x,#OFST-3
 123  0026 cd0000        	call	c_ltor
 125  0029 ae0000        	ldw	x,#L6
 126  002c cd0000        	call	c_lcmp
 128  002f 25e7          	jrult	L74
 129                     ; 14     for (i=0; i<=ms; i++){
 131  0031 96            	ldw	x,sp
 132  0032 1c0001        	addw	x,#OFST-7
 133  0035 a601          	ld	a,#1
 134  0037 cd0000        	call	c_lgadc
 137  003a               L34:
 140  003a 96            	ldw	x,sp
 141  003b 1c0001        	addw	x,#OFST-7
 142  003e cd0000        	call	c_ltor
 144  0041 96            	ldw	x,sp
 145  0042 1c000b        	addw	x,#OFST+3
 146  0045 cd0000        	call	c_lcmp
 148  0048 23c4          	jrule	L73
 149                     ; 19 }
 152  004a 5b08          	addw	sp,#8
 153  004c 81            	ret
 193                     ; 26 void PCF8574writeAll(u8 iData){
 194                     	switch	.text
 195  004d               _PCF8574writeAll:
 197  004d 88            	push	a
 198       00000000      OFST:	set	0
 201                     ; 27 	I2C_GenerateSTART(ENABLE);
 203  004e a601          	ld	a,#1
 204  0050 cd0000        	call	_I2C_GenerateSTART
 207  0053               L57:
 208                     ; 28 	while(!I2C_CheckEvent(I2C_EVENT_MASTER_MODE_SELECT));
 210  0053 ae0301        	ldw	x,#769
 211  0056 cd0000        	call	_I2C_CheckEvent
 213  0059 4d            	tnz	a
 214  005a 27f7          	jreq	L57
 215                     ; 29 	I2C_Send7bitAddress(LCD_I2C_Address, I2C_DIRECTION_TX);
 217  005c ae4e00        	ldw	x,#19968
 218  005f cd0000        	call	_I2C_Send7bitAddress
 221  0062               L301:
 222                     ; 30 	while(!I2C_CheckEvent(I2C_EVENT_MASTER_TRANSMITTER_MODE_SELECTED));
 224  0062 ae0782        	ldw	x,#1922
 225  0065 cd0000        	call	_I2C_CheckEvent
 227  0068 4d            	tnz	a
 228  0069 27f7          	jreq	L301
 229                     ; 31 	I2C_SendData(iData);
 231  006b 7b01          	ld	a,(OFST+1,sp)
 232  006d cd0000        	call	_I2C_SendData
 235  0070               L111:
 236                     ; 32 	while(!I2C_CheckEvent(I2C_EVENT_MASTER_BYTE_TRANSMITTED));
 238  0070 ae0784        	ldw	x,#1924
 239  0073 cd0000        	call	_I2C_CheckEvent
 241  0076 4d            	tnz	a
 242  0077 27f7          	jreq	L111
 243                     ; 33 	I2C_GenerateSTOP(ENABLE);
 245  0079 a601          	ld	a,#1
 246  007b cd0000        	call	_I2C_GenerateSTOP
 248                     ; 34     currentValue=iData;
 250  007e 7b01          	ld	a,(OFST+1,sp)
 251  0080 b700          	ld	_currentValue,a
 252                     ; 35 }
 255  0082 84            	pop	a
 256  0083 81            	ret
 301                     ; 43 void PCF8574write(uint8_t pin, uint8_t value){
 302                     	switch	.text
 303  0084               _PCF8574write:
 305  0084 89            	pushw	x
 306       00000000      OFST:	set	0
 309                     ; 44       if (value == 0){
 311  0085 9f            	ld	a,xl
 312  0086 4d            	tnz	a
 313  0087 2613          	jrne	L731
 314                     ; 45           currentValue &= ~(1 << pin); // Set the pin value 0 or 1
 316  0089 9e            	ld	a,xh
 317  008a 5f            	clrw	x
 318  008b 97            	ld	xl,a
 319  008c a601          	ld	a,#1
 320  008e 5d            	tnzw	x
 321  008f 2704          	jreq	L41
 322  0091               L61:
 323  0091 48            	sll	a
 324  0092 5a            	decw	x
 325  0093 26fc          	jrne	L61
 326  0095               L41:
 327  0095 43            	cpl	a
 328  0096 b400          	and	a,_currentValue
 329  0098 b700          	ld	_currentValue,a
 331  009a 2011          	jra	L141
 332  009c               L731:
 333                     ; 47           currentValue |= (1 << pin); // Set the pin value 0 or 1
 335  009c 7b01          	ld	a,(OFST+1,sp)
 336  009e 5f            	clrw	x
 337  009f 97            	ld	xl,a
 338  00a0 a601          	ld	a,#1
 339  00a2 5d            	tnzw	x
 340  00a3 2704          	jreq	L02
 341  00a5               L22:
 342  00a5 48            	sll	a
 343  00a6 5a            	decw	x
 344  00a7 26fc          	jrne	L22
 345  00a9               L02:
 346  00a9 ba00          	or	a,_currentValue
 347  00ab b700          	ld	_currentValue,a
 348  00ad               L141:
 349                     ; 49       PCF8574writeAll(currentValue);
 351  00ad b600          	ld	a,_currentValue
 352  00af ad9c          	call	_PCF8574writeAll
 354                     ; 50 }
 357  00b1 85            	popw	x
 358  00b2 81            	ret
 393                     ; 57 void LCD_SetBit(char data){
 394                     	switch	.text
 395  00b3               _LCD_SetBit:
 397  00b3 88            	push	a
 398       00000000      OFST:	set	0
 401                     ; 58     PCF8574write(4, data&1); //D4 = 1
 403  00b4 a401          	and	a,#1
 404  00b6 ae0400        	ldw	x,#1024
 405  00b9 97            	ld	xl,a
 406  00ba adc8          	call	_PCF8574write
 408                     ; 59     PCF8574write(5, data&2); //D5 = 1
 410  00bc 7b01          	ld	a,(OFST+1,sp)
 411  00be a402          	and	a,#2
 412  00c0 ae0500        	ldw	x,#1280
 413  00c3 97            	ld	xl,a
 414  00c4 adbe          	call	_PCF8574write
 416                     ; 60     PCF8574write(6, data&4); //D6 = 1
 418  00c6 7b01          	ld	a,(OFST+1,sp)
 419  00c8 a404          	and	a,#4
 420  00ca ae0600        	ldw	x,#1536
 421  00cd 97            	ld	xl,a
 422  00ce adb4          	call	_PCF8574write
 424                     ; 61     PCF8574write(7, data&8); //D7 = 1
 426  00d0 7b01          	ld	a,(OFST+1,sp)
 427  00d2 a408          	and	a,#8
 428  00d4 ae0700        	ldw	x,#1792
 429  00d7 97            	ld	xl,a
 430  00d8 adaa          	call	_PCF8574write
 432                     ; 62 }
 435  00da 84            	pop	a
 436  00db 81            	ret
 473                     ; 69 void LCD_Cmd(char cmd){
 474                     	switch	.text
 475  00dc               _LCD_Cmd:
 477  00dc 88            	push	a
 478       00000000      OFST:	set	0
 481                     ; 70     PCF8574write(0,0); //RS = 0          
 483  00dd 5f            	clrw	x
 484  00de ada4          	call	_PCF8574write
 486                     ; 71     LCD_SetBit(cmd); //Incoming Hex value
 488  00e0 7b01          	ld	a,(OFST+1,sp)
 489  00e2 adcf          	call	_LCD_SetBit
 491                     ; 72     PCF8574write(2,1); //EN  = 1         
 493  00e4 ae0201        	ldw	x,#513
 494  00e7 ad9b          	call	_PCF8574write
 496                     ; 73 	Delay_ms(2);
 498  00e9 ae0002        	ldw	x,#2
 499  00ec 89            	pushw	x
 500  00ed ae0000        	ldw	x,#0
 501  00f0 89            	pushw	x
 502  00f1 cd0000        	call	_Delay_ms
 504  00f4 5b04          	addw	sp,#4
 505                     ; 74 	PCF8574write(2,0); //EN  = 0      
 507  00f6 ae0200        	ldw	x,#512
 508  00f9 ad89          	call	_PCF8574write
 510                     ; 75 }
 513  00fb 84            	pop	a
 514  00fc 81            	ret
 554                     	switch	.const
 555  0004               L23:
 556  0004 000f4240      	dc.l	1000000
 557                     ; 80  void LCD_Begin(void){
 558                     	switch	.text
 559  00fd               _LCD_Begin:
 561  00fd 89            	pushw	x
 562       00000002      OFST:	set	2
 565                     ; 82 	Delay_ms(10);
 567  00fe ae000a        	ldw	x,#10
 568  0101 89            	pushw	x
 569  0102 ae0000        	ldw	x,#0
 570  0105 89            	pushw	x
 571  0106 cd0000        	call	_Delay_ms
 573  0109 5b04          	addw	sp,#4
 574                     ; 83 	Input_Clock = CLK_GetClockFreq()/1000000;  // Clock speed in MHz
 576  010b cd0000        	call	_CLK_GetClockFreq
 578  010e ae0004        	ldw	x,#L23
 579  0111 cd0000        	call	c_ludv
 581  0114 be02          	ldw	x,c_lreg+2
 582  0116 1f01          	ldw	(OFST-1,sp),x
 584                     ; 84     I2C_Init(100000, LCD_I2C_Address, I2C_DUTYCYCLE_2, I2C_ACK_CURR, I2C_ADDMODE_7BIT, Input_Clock);
 586  0118 7b02          	ld	a,(OFST+0,sp)
 587  011a 88            	push	a
 588  011b 4b00          	push	#0
 589  011d 4b01          	push	#1
 590  011f 4b00          	push	#0
 591  0121 ae004e        	ldw	x,#78
 592  0124 89            	pushw	x
 593  0125 ae86a0        	ldw	x,#34464
 594  0128 89            	pushw	x
 595  0129 ae0001        	ldw	x,#1
 596  012c 89            	pushw	x
 597  012d cd0000        	call	_I2C_Init
 599  0130 5b0a          	addw	sp,#10
 600                     ; 86     PCF8574writeAll(0b00000000);
 602  0132 4f            	clr	a
 603  0133 cd004d        	call	_PCF8574writeAll
 605                     ; 87 	LCD_SetBit(0x00);
 607  0136 4f            	clr	a
 608  0137 cd00b3        	call	_LCD_SetBit
 610                     ; 88 	Delay_ms(1000); 
 612  013a ae03e8        	ldw	x,#1000
 613  013d 89            	pushw	x
 614  013e ae0000        	ldw	x,#0
 615  0141 89            	pushw	x
 616  0142 cd0000        	call	_Delay_ms
 618  0145 5b04          	addw	sp,#4
 619                     ; 89     LCD_Cmd(0x03);
 621  0147 a603          	ld	a,#3
 622  0149 ad91          	call	_LCD_Cmd
 624                     ; 90 	Delay_ms(5);
 626  014b ae0005        	ldw	x,#5
 627  014e 89            	pushw	x
 628  014f ae0000        	ldw	x,#0
 629  0152 89            	pushw	x
 630  0153 cd0000        	call	_Delay_ms
 632  0156 5b04          	addw	sp,#4
 633                     ; 91 	LCD_Cmd(0x03);
 635  0158 a603          	ld	a,#3
 636  015a ad80          	call	_LCD_Cmd
 638                     ; 92 	Delay_ms(11);
 640  015c ae000b        	ldw	x,#11
 641  015f 89            	pushw	x
 642  0160 ae0000        	ldw	x,#0
 643  0163 89            	pushw	x
 644  0164 cd0000        	call	_Delay_ms
 646  0167 5b04          	addw	sp,#4
 647                     ; 93     LCD_Cmd(0x03); 
 649  0169 a603          	ld	a,#3
 650  016b cd00dc        	call	_LCD_Cmd
 652                     ; 94     LCD_Cmd(0x02); //02H is used for Return home -> Clears the RAM and initializes the LCD
 654  016e a602          	ld	a,#2
 655  0170 cd00dc        	call	_LCD_Cmd
 657                     ; 95     LCD_Cmd(0x02); //02H is used for Return home -> Clears the RAM and initializes the LCD
 659  0173 a602          	ld	a,#2
 660  0175 cd00dc        	call	_LCD_Cmd
 662                     ; 96     LCD_Cmd(0x08); //Select Row 1
 664  0178 a608          	ld	a,#8
 665  017a cd00dc        	call	_LCD_Cmd
 667                     ; 97     LCD_Cmd(0x00); //Clear Row 1 Display
 669  017d 4f            	clr	a
 670  017e cd00dc        	call	_LCD_Cmd
 672                     ; 98     LCD_Cmd(0x0C); //Select Row 2
 674  0181 a60c          	ld	a,#12
 675  0183 cd00dc        	call	_LCD_Cmd
 677                     ; 99     LCD_Cmd(0x00); //Clear Row 2 Display
 679  0186 4f            	clr	a
 680  0187 cd00dc        	call	_LCD_Cmd
 682                     ; 100     LCD_Cmd(0x06);
 684  018a a606          	ld	a,#6
 685  018c cd00dc        	call	_LCD_Cmd
 687                     ; 101  } 
 690  018f 85            	popw	x
 691  0190 81            	ret
 715                     ; 106 void LCD_Clear(void){
 716                     	switch	.text
 717  0191               _LCD_Clear:
 721                     ; 107     LCD_Cmd(0); //Clear the LCD
 723  0191 4f            	clr	a
 724  0192 cd00dc        	call	_LCD_Cmd
 726                     ; 108     LCD_Cmd(1); //Move the curser to first position
 728  0195 a601          	ld	a,#1
 729  0197 cd00dc        	call	_LCD_Cmd
 731                     ; 109 }
 734  019a 81            	ret
 805                     ; 117 void LCD_SetCursor(char row, char col){
 806                     	switch	.text
 807  019b               _LCD_SetCursor:
 809  019b 89            	pushw	x
 810  019c 89            	pushw	x
 811       00000002      OFST:	set	2
 814                     ; 119     if(row == 1){
 816  019d 9e            	ld	a,xh
 817  019e a101          	cp	a,#1
 818  01a0 261e          	jrne	L362
 819                     ; 120         temp = 0x80 + col - 1; //80H is used to move the curser
 821  01a2 9f            	ld	a,xl
 822  01a3 ab7f          	add	a,#127
 823  01a5 6b02          	ld	(OFST+0,sp),a
 825                     ; 121         z = temp>>4; //Lower 8-bits
 827  01a7 7b02          	ld	a,(OFST+0,sp)
 828  01a9 4e            	swap	a
 829  01aa a40f          	and	a,#15
 830  01ac 6b01          	ld	(OFST-1,sp),a
 832                     ; 122         y = temp & 0x0F; //Upper 8-bits
 834  01ae 7b02          	ld	a,(OFST+0,sp)
 835  01b0 a40f          	and	a,#15
 836  01b2 6b02          	ld	(OFST+0,sp),a
 838                     ; 123         LCD_Cmd(z); //Set Row
 840  01b4 7b01          	ld	a,(OFST-1,sp)
 841  01b6 cd00dc        	call	_LCD_Cmd
 843                     ; 124         LCD_Cmd(y); //Set Column
 845  01b9 7b02          	ld	a,(OFST+0,sp)
 846  01bb cd00dc        	call	_LCD_Cmd
 849  01be 2023          	jra	L562
 850  01c0               L362:
 851                     ; 125     }else if(row == 2){
 853  01c0 7b03          	ld	a,(OFST+1,sp)
 854  01c2 a102          	cp	a,#2
 855  01c4 261d          	jrne	L562
 856                     ; 126         temp = 0xC0 + col - 1;
 858  01c6 7b04          	ld	a,(OFST+2,sp)
 859  01c8 abbf          	add	a,#191
 860  01ca 6b02          	ld	(OFST+0,sp),a
 862                     ; 127         z = temp>>4; //Lower 8-bits
 864  01cc 7b02          	ld	a,(OFST+0,sp)
 865  01ce 4e            	swap	a
 866  01cf a40f          	and	a,#15
 867  01d1 6b01          	ld	(OFST-1,sp),a
 869                     ; 128         y = temp & 0x0F; //Upper 8-bits
 871  01d3 7b02          	ld	a,(OFST+0,sp)
 872  01d5 a40f          	and	a,#15
 873  01d7 6b02          	ld	(OFST+0,sp),a
 875                     ; 129         LCD_Cmd(z); //Set Row
 877  01d9 7b01          	ld	a,(OFST-1,sp)
 878  01db cd00dc        	call	_LCD_Cmd
 880                     ; 130         LCD_Cmd(y); //Set Column
 882  01de 7b02          	ld	a,(OFST+0,sp)
 883  01e0 cd00dc        	call	_LCD_Cmd
 885  01e3               L562:
 886                     ; 132 }
 889  01e3 5b04          	addw	sp,#4
 890  01e5 81            	ret
 945                     ; 139 void LCD_PrintChar(char data){
 946                     	switch	.text
 947  01e6               _LCD_PrintChar:
 949  01e6 88            	push	a
 950  01e7 89            	pushw	x
 951       00000002      OFST:	set	2
 954                     ; 141    Lower_Nibble = data&0x0F;
 956  01e8 a40f          	and	a,#15
 957  01ea 6b01          	ld	(OFST-1,sp),a
 959                     ; 142    Upper_Nibble = data&0xF0;
 961  01ec 7b03          	ld	a,(OFST+1,sp)
 962  01ee a4f0          	and	a,#240
 963  01f0 6b02          	ld	(OFST+0,sp),a
 965                     ; 143    PCF8574write(0,1);             // => RS = 1
 967  01f2 ae0001        	ldw	x,#1
 968  01f5 cd0084        	call	_PCF8574write
 970                     ; 145    LCD_SetBit(Upper_Nibble>>4);  //Send upper half by shifting by 4
 972  01f8 7b02          	ld	a,(OFST+0,sp)
 973  01fa 4e            	swap	a
 974  01fb a40f          	and	a,#15
 975  01fd cd00b3        	call	_LCD_SetBit
 977                     ; 146    PCF8574write(2,1); //EN = 1
 979  0200 ae0201        	ldw	x,#513
 980  0203 cd0084        	call	_PCF8574write
 982                     ; 147    Delay_ms(5); 
 984  0206 ae0005        	ldw	x,#5
 985  0209 89            	pushw	x
 986  020a ae0000        	ldw	x,#0
 987  020d 89            	pushw	x
 988  020e cd0000        	call	_Delay_ms
 990  0211 5b04          	addw	sp,#4
 991                     ; 148    PCF8574write(2,0); //EN = 0
 993  0213 ae0200        	ldw	x,#512
 994  0216 cd0084        	call	_PCF8574write
 996                     ; 150    LCD_SetBit(Lower_Nibble); //Send Lower half
 998  0219 7b01          	ld	a,(OFST-1,sp)
 999  021b cd00b3        	call	_LCD_SetBit
1001                     ; 151    PCF8574write(2,1); //EN = 1
1003  021e ae0201        	ldw	x,#513
1004  0221 cd0084        	call	_PCF8574write
1006                     ; 152    Delay_ms(5); 
1008  0224 ae0005        	ldw	x,#5
1009  0227 89            	pushw	x
1010  0228 ae0000        	ldw	x,#0
1011  022b 89            	pushw	x
1012  022c cd0000        	call	_Delay_ms
1014  022f 5b04          	addw	sp,#4
1015                     ; 153    PCF8574write(2,0); //EN = 0
1017  0231 ae0200        	ldw	x,#512
1018  0234 cd0084        	call	_PCF8574write
1020                     ; 154 }
1023  0237 5b03          	addw	sp,#3
1024  0239 81            	ret
1069                     ; 161 void LCD_PrintString(char *str){
1070                     	switch	.text
1071  023a               _LCD_PrintString:
1073  023a 89            	pushw	x
1074  023b 89            	pushw	x
1075       00000002      OFST:	set	2
1078                     ; 163     for(i=0; str[i]!='\0'; i++){
1080  023c 5f            	clrw	x
1081  023d 1f01          	ldw	(OFST-1,sp),x
1084  023f 200f          	jra	L543
1085  0241               L143:
1086                     ; 164 		LCD_PrintChar(str[i]);  //Split the string using pointers and call the Char function 
1088  0241 1e01          	ldw	x,(OFST-1,sp)
1089  0243 72fb03        	addw	x,(OFST+1,sp)
1090  0246 f6            	ld	a,(x)
1091  0247 ad9d          	call	_LCD_PrintChar
1093                     ; 163     for(i=0; str[i]!='\0'; i++){
1095  0249 1e01          	ldw	x,(OFST-1,sp)
1096  024b 1c0001        	addw	x,#1
1097  024e 1f01          	ldw	(OFST-1,sp),x
1099  0250               L543:
1102  0250 1e01          	ldw	x,(OFST-1,sp)
1103  0252 72fb03        	addw	x,(OFST+1,sp)
1104  0255 7d            	tnz	(x)
1105  0256 26e9          	jrne	L143
1106                     ; 166 }
1109  0258 5b04          	addw	sp,#4
1110  025a 81            	ret
1134                     ; 171 void LCD_OnBL(void){
1135                     	switch	.text
1136  025b               _LCD_OnBL:
1140                     ; 172 	PCF8574write(3,1);
1142  025b ae0301        	ldw	x,#769
1143  025e cd0084        	call	_PCF8574write
1145                     ; 173 }
1148  0261 81            	ret
1172                     ; 178 void LCD_OffBL(void){
1173                     	switch	.text
1174  0262               _LCD_OffBL:
1178                     ; 179 	PCF8574write(3,0);
1180  0262 ae0300        	ldw	x,#768
1181  0265 cd0084        	call	_PCF8574write
1183                     ; 180 }
1186  0268 81            	ret
1210                     	xdef	_LCD_Cmd
1211                     	xdef	_LCD_SetBit
1212                     	xdef	_PCF8574write
1213                     	xdef	_PCF8574writeAll
1214                     	switch	.ubsct
1215  0000               _currentValue:
1216  0000 00            	ds.b	1
1217                     	xdef	_currentValue
1218                     	xdef	_LCD_OffBL
1219                     	xdef	_LCD_OnBL
1220                     	xdef	_LCD_PrintString
1221                     	xdef	_LCD_PrintChar
1222                     	xdef	_LCD_SetCursor
1223                     	xdef	_LCD_Clear
1224                     	xdef	_LCD_Begin
1225                     	xdef	_Delay_ms
1226                     	xref	_I2C_CheckEvent
1227                     	xref	_I2C_SendData
1228                     	xref	_I2C_Send7bitAddress
1229                     	xref	_I2C_GenerateSTOP
1230                     	xref	_I2C_GenerateSTART
1231                     	xref	_I2C_Init
1232                     	xref	_CLK_GetClockFreq
1233                     	xref.b	c_lreg
1234                     	xref.b	c_x
1254                     	xref	c_ludv
1255                     	xref	c_lcmp
1256                     	xref	c_ltor
1257                     	xref	c_lgadc
1258                     	end
