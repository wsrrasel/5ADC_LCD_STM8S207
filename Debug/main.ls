   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
  14                     	bsct
  15  0000               _gv:
  16  0000 00            	dc.b	0
  17  0001 000000000000  	ds.b	95
  95                     ; 37 main(){
  97                     	switch	.text
  98  0000               _main:
 100  0000 5223          	subw	sp,#35
 101       00000023      OFST:	set	35
 104                     ; 38 		uint16_t count = 0;
 106  0002 5f            	clrw	x
 107  0003 1f22          	ldw	(OFST-1,sp),x
 109                     ; 45 		CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
 111  0005 4f            	clr	a
 112  0006 cd0000        	call	_CLK_HSIPrescalerConfig
 114                     ; 48 		dbg_init();
 116  0009 cd0000        	call	_dbg_init
 118                     ; 49 		dbg_print("\r\n---Started---\r\n");
 120  000c ae002d        	ldw	x,#L73
 121  000f cd0000        	call	_printf
 123                     ; 52 		Serial_Init();
 125  0012 cd0000        	call	_Serial_Init
 127                     ; 55 		LCD_Begin();
 129  0015 cd0000        	call	_LCD_Begin
 131                     ; 56 		LCD_Clear();
 133  0018 cd0000        	call	_LCD_Clear
 135                     ; 57 		LCD_OnBL();  
 137  001b cd0000        	call	_LCD_OnBL
 139                     ; 58 		LCD_SetCursor(1,1);
 141  001e ae0101        	ldw	x,#257
 142  0021 cd0000        	call	_LCD_SetCursor
 144                     ; 59 		LCD_PrintString("Welcome!");
 146  0024 ae0024        	ldw	x,#L14
 147  0027 cd0000        	call	_LCD_PrintString
 149                     ; 60 		delay(2000);
 151  002a ae07d0        	ldw	x,#2000
 152  002d 89            	pushw	x
 153  002e ae0000        	ldw	x,#0
 154  0031 89            	pushw	x
 155  0032 cd0138        	call	_delay
 157  0035 5b04          	addw	sp,#4
 158                     ; 61 		LCD_Clear();
 160  0037 cd0000        	call	_LCD_Clear
 162                     ; 62 		LCD_SetCursor(1,1);
 164  003a ae0101        	ldw	x,#257
 165  003d cd0000        	call	_LCD_SetCursor
 167                     ; 63 		LCD_PrintString("1602 I2C LCD");
 169  0040 ae0017        	ldw	x,#L34
 170  0043 cd0000        	call	_LCD_PrintString
 172                     ; 66 	  GPIO_Init(LED, GPIO_MODE_OUT_PP_LOW_SLOW);
 174  0046 4bc0          	push	#192
 175  0048 4b80          	push	#128
 176  004a ae5005        	ldw	x,#20485
 177  004d cd0000        	call	_GPIO_Init
 179  0050 85            	popw	x
 180                     ; 69     ADC_Init(&gv.adc[ADC_1], ADC_CH_1);
 182  0051 4b00          	push	#0
 183  0053 ae0000        	ldw	x,#_gv
 184  0056 cd0000        	call	_ADC_Init
 186  0059 84            	pop	a
 187                     ; 70     ADC_Init(&gv.adc[ADC_2], ADC_CH_2);
 189  005a 4b01          	push	#1
 190  005c ae0013        	ldw	x,#_gv+19
 191  005f cd0000        	call	_ADC_Init
 193  0062 84            	pop	a
 194                     ; 71     ADC_Init(&gv.adc[ADC_3], ADC_CH_3);
 196  0063 4b02          	push	#2
 197  0065 ae0026        	ldw	x,#_gv+38
 198  0068 cd0000        	call	_ADC_Init
 200  006b 84            	pop	a
 201                     ; 72     ADC_Init(&gv.adc[ADC_4], ADC_CH_4);
 203  006c 4b03          	push	#3
 204  006e ae0039        	ldw	x,#_gv+57
 205  0071 cd0000        	call	_ADC_Init
 207  0074 84            	pop	a
 208                     ; 73     ADC_Init(&gv.adc[ADC_5], ADC_CH_5);
 210  0075 4b06          	push	#6
 211  0077 ae004c        	ldw	x,#_gv+76
 212  007a cd0000        	call	_ADC_Init
 214  007d 84            	pop	a
 215                     ; 76     TIM_Init();
 217  007e cd0000        	call	_TIM_Init
 219                     ; 77     TIM_SetDuty(50); // PWM 50% duty at Timer 2 channel 1S
 221  0081 a632          	ld	a,#50
 222  0083 cd0000        	call	_TIM_SetDuty
 224  0086               L54:
 225                     ; 84 		ADC_Update();
 227  0086 ad5a          	call	_ADC_Update
 229                     ; 90 		dbg_print("Count:%d\r\n", count);
 231  0088 1e22          	ldw	x,(OFST-1,sp)
 232  008a 89            	pushw	x
 233  008b ae000c        	ldw	x,#L15
 234  008e cd0000        	call	_printf
 236  0091 85            	popw	x
 237                     ; 93 		sprintf(str,"Count:%d\r\n", count);
 239  0092 1e22          	ldw	x,(OFST-1,sp)
 240  0094 89            	pushw	x
 241  0095 ae000c        	ldw	x,#L15
 242  0098 89            	pushw	x
 243  0099 96            	ldw	x,sp
 244  009a 1c0005        	addw	x,#OFST-30
 245  009d cd0000        	call	_sprintf
 247  00a0 5b04          	addw	sp,#4
 248                     ; 94 		Serial_Print(str);
 250  00a2 96            	ldw	x,sp
 251  00a3 1c0001        	addw	x,#OFST-34
 252  00a6 cd0000        	call	_Serial_Print
 254                     ; 96 		rxChar = Serial_ReadChar();
 256  00a9 cd0000        	call	_Serial_ReadChar
 258  00ac 6b21          	ld	(OFST-2,sp),a
 260                     ; 97 		if(rxChar>0){
 262  00ae 0d21          	tnz	(OFST-2,sp)
 263  00b0 270a          	jreq	L35
 264                     ; 98 				dbg_print("%c",rxChar);
 266  00b2 7b21          	ld	a,(OFST-2,sp)
 267  00b4 88            	push	a
 268  00b5 ae0009        	ldw	x,#L55
 269  00b8 cd0000        	call	_printf
 271  00bb 84            	pop	a
 272                     ; 99 				rxChar = 0;
 274  00bc               L35:
 275                     ; 105 		sprintf(str,"Count:%d", count);
 277  00bc 1e22          	ldw	x,(OFST-1,sp)
 278  00be 89            	pushw	x
 279  00bf ae0000        	ldw	x,#L75
 280  00c2 89            	pushw	x
 281  00c3 96            	ldw	x,sp
 282  00c4 1c0005        	addw	x,#OFST-30
 283  00c7 cd0000        	call	_sprintf
 285  00ca 5b04          	addw	sp,#4
 286                     ; 106 		LCD_SetCursor(2,1);
 288  00cc ae0201        	ldw	x,#513
 289  00cf cd0000        	call	_LCD_SetCursor
 291                     ; 107 		LCD_PrintString(str);
 293  00d2 96            	ldw	x,sp
 294  00d3 1c0001        	addw	x,#OFST-34
 295  00d6 cd0000        	call	_LCD_PrintString
 297                     ; 111 		count++;
 299  00d9 1e22          	ldw	x,(OFST-1,sp)
 300  00db 1c0001        	addw	x,#1
 301  00de 1f22          	ldw	(OFST-1,sp),x
 304  00e0 20a4          	jra	L54
 340                     ; 115 void ADC_Update(void){
 341                     	switch	.text
 342  00e2               _ADC_Update:
 344  00e2 88            	push	a
 345       00000001      OFST:	set	1
 348                     ; 116 		uint8_t i = 0;
 350                     ; 117 		for(i = 0; i < ADC_MAX; i++){
 352  00e3 0f01          	clr	(OFST+0,sp)
 354  00e5               L77:
 355                     ; 118 				ADC_Read(&gv.adc[i]);
 357  00e5 7b01          	ld	a,(OFST+0,sp)
 358  00e7 97            	ld	xl,a
 359  00e8 a613          	ld	a,#19
 360  00ea 42            	mul	x,a
 361  00eb 01            	rrwa	x,a
 362  00ec ab00          	add	a,#_gv
 363  00ee 2401          	jrnc	L01
 364  00f0 5c            	incw	x
 365  00f1               L01:
 366  00f1 5f            	clrw	x
 367  00f2 97            	ld	xl,a
 368  00f3 cd0000        	call	_ADC_Read
 370                     ; 117 		for(i = 0; i < ADC_MAX; i++){
 372  00f6 0c01          	inc	(OFST+0,sp)
 376  00f8 7b01          	ld	a,(OFST+0,sp)
 377  00fa a105          	cp	a,#5
 378  00fc 25e7          	jrult	L77
 379                     ; 120 }
 382  00fe 84            	pop	a
 383  00ff 81            	ret
 467                     ; 122 uint16_t ADC_GetValue(ADC_Id_te id){
 468                     	switch	.text
 469  0100               _ADC_GetValue:
 473                     ; 123     if(id >= 0 && id < ADC_MAX){
 475  0100 a105          	cp	a,#5
 476  0102 2407          	jruge	L341
 477                     ; 124         return gv.adc[id].value;
 479  0104 97            	ld	xl,a
 480  0105 a613          	ld	a,#19
 481  0107 42            	mul	x,a
 482  0108 ee01          	ldw	x,(_gv+1,x)
 485  010a 81            	ret
 486  010b               L341:
 487                     ; 126         return 0;
 489  010b 5f            	clrw	x
 492  010c 81            	ret
 518                     ; 130 void BlinkLED(void){
 519                     	switch	.text
 520  010d               _BlinkLED:
 524                     ; 131 		GPIO_WriteHigh(LED);
 526  010d 4b80          	push	#128
 527  010f ae5005        	ldw	x,#20485
 528  0112 cd0000        	call	_GPIO_WriteHigh
 530  0115 84            	pop	a
 531                     ; 132 		delay(500);
 533  0116 ae01f4        	ldw	x,#500
 534  0119 89            	pushw	x
 535  011a ae0000        	ldw	x,#0
 536  011d 89            	pushw	x
 537  011e ad18          	call	_delay
 539  0120 5b04          	addw	sp,#4
 540                     ; 133 		GPIO_WriteLow(LED);
 542  0122 4b80          	push	#128
 543  0124 ae5005        	ldw	x,#20485
 544  0127 cd0000        	call	_GPIO_WriteLow
 546  012a 84            	pop	a
 547                     ; 134 		delay(500);
 549  012b ae01f4        	ldw	x,#500
 550  012e 89            	pushw	x
 551  012f ae0000        	ldw	x,#0
 552  0132 89            	pushw	x
 553  0133 ad03          	call	_delay
 555  0135 5b04          	addw	sp,#4
 556                     ; 135 }
 559  0137 81            	ret
 602                     ; 137 void delay(uint32_t ms){
 603                     	switch	.text
 604  0138               _delay:
 606  0138 5204          	subw	sp,#4
 607       00000004      OFST:	set	4
 610                     ; 138     uint32_t i = 0;
 612                     ; 139     for(i = 0; i < (120*ms); i++){;}
 614  013a ae0000        	ldw	x,#0
 615  013d 1f03          	ldw	(OFST-1,sp),x
 616  013f ae0000        	ldw	x,#0
 617  0142 1f01          	ldw	(OFST-3,sp),x
 620  0144 2009          	jra	L502
 621  0146               L102:
 625  0146 96            	ldw	x,sp
 626  0147 1c0001        	addw	x,#OFST-3
 627  014a a601          	ld	a,#1
 628  014c cd0000        	call	c_lgadc
 631  014f               L502:
 634  014f 96            	ldw	x,sp
 635  0150 1c0007        	addw	x,#OFST+3
 636  0153 cd0000        	call	c_ltor
 638  0156 a678          	ld	a,#120
 639  0158 cd0000        	call	c_smul
 641  015b 96            	ldw	x,sp
 642  015c 1c0001        	addw	x,#OFST-3
 643  015f cd0000        	call	c_lcmp
 645  0162 22e2          	jrugt	L102
 646                     ; 140 }
 649  0164 5b04          	addw	sp,#4
 650  0166 81            	ret
 770                     	xdef	_main
 771                     	xdef	_BlinkLED
 772                     	xdef	_ADC_GetValue
 773                     	xdef	_ADC_Update
 774                     	xdef	_delay
 775                     	xdef	_gv
 776                     	xref	_LCD_OnBL
 777                     	xref	_LCD_PrintString
 778                     	xref	_LCD_SetCursor
 779                     	xref	_LCD_Clear
 780                     	xref	_LCD_Begin
 781                     	xref	_dbg_init
 782                     	xref	_sprintf
 783                     	xref	_printf
 784                     	xref	_TIM_SetDuty
 785                     	xref	_TIM_Init
 786                     	xref	_ADC_Read
 787                     	xref	_ADC_Init
 788                     	xref	_Serial_ReadChar
 789                     	xref	_Serial_Print
 790                     	xref	_Serial_Init
 791                     	xref	_CLK_HSIPrescalerConfig
 792                     	xref	_GPIO_WriteLow
 793                     	xref	_GPIO_WriteHigh
 794                     	xref	_GPIO_Init
 795                     .const:	section	.text
 796  0000               L75:
 797  0000 436f756e743a  	dc.b	"Count:%d",0
 798  0009               L55:
 799  0009 256300        	dc.b	"%c",0
 800  000c               L15:
 801  000c 436f756e743a  	dc.b	"Count:%d",13
 802  0015 0a00          	dc.b	10,0
 803  0017               L34:
 804  0017 313630322049  	dc.b	"1602 I2C LCD",0
 805  0024               L14:
 806  0024 57656c636f6d  	dc.b	"Welcome!",0
 807  002d               L73:
 808  002d 0d0a2d2d2d53  	dc.b	13,10,45,45,45,83
 809  0033 746172746564  	dc.b	"tarted---",13
 810  003d 0a00          	dc.b	10,0
 830                     	xref	c_lcmp
 831                     	xref	c_smul
 832                     	xref	c_ltor
 833                     	xref	c_lgadc
 834                     	end
