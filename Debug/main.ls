   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
  14                     	bsct
  15  0000               _gv:
  16  0000 00            	dc.b	0
  17  0001 000000000000  	ds.b	95
  94                     ; 37 main(){
  96                     	switch	.text
  97  0000               _main:
  99  0000 5223          	subw	sp,#35
 100       00000023      OFST:	set	35
 103                     ; 38 		uint16_t count = 0;
 105  0002 5f            	clrw	x
 106  0003 1f22          	ldw	(OFST-1,sp),x
 108                     ; 45 		CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
 110  0005 4f            	clr	a
 111  0006 cd0000        	call	_CLK_HSIPrescalerConfig
 113                     ; 48 		dbg_init();
 115  0009 cd0000        	call	_dbg_init
 117                     ; 49 		dbg_print("\r\n---Started---\r\n");
 119  000c ae0029        	ldw	x,#L73
 120  000f cd0000        	call	_printf
 122                     ; 52 		Serial_Init();
 124  0012 cd0000        	call	_Serial_Init
 126                     ; 55 		LCD_Begin();
 128  0015 cd0000        	call	_LCD_Begin
 130                     ; 56 		LCD_Clear();
 132  0018 cd0000        	call	_LCD_Clear
 134                     ; 57 		LCD_SetCursor(1,1);
 136  001b ae0101        	ldw	x,#257
 137  001e cd0000        	call	_LCD_SetCursor
 139                     ; 58 		LCD_PrintString("Welcome!");
 141  0021 ae0020        	ldw	x,#L14
 142  0024 cd0000        	call	_LCD_PrintString
 144                     ; 59 		delay(2000);
 146  0027 ae07d0        	ldw	x,#2000
 147  002a 89            	pushw	x
 148  002b ae0000        	ldw	x,#0
 149  002e 89            	pushw	x
 150  002f cd0135        	call	_delay
 152  0032 5b04          	addw	sp,#4
 153                     ; 60 		LCD_Clear();
 155  0034 cd0000        	call	_LCD_Clear
 157                     ; 61 		LCD_SetCursor(1,1);
 159  0037 ae0101        	ldw	x,#257
 160  003a cd0000        	call	_LCD_SetCursor
 162                     ; 62 		LCD_PrintString("1602 LCD");
 164  003d ae0017        	ldw	x,#L34
 165  0040 cd0000        	call	_LCD_PrintString
 167                     ; 65 	  GPIO_Init(LED, GPIO_MODE_OUT_PP_LOW_SLOW);
 169  0043 4bc0          	push	#192
 170  0045 4b80          	push	#128
 171  0047 ae5005        	ldw	x,#20485
 172  004a cd0000        	call	_GPIO_Init
 174  004d 85            	popw	x
 175                     ; 68     ADC_Init(&gv.adc[ADC_1], ADC_CH_1);
 177  004e 4b00          	push	#0
 178  0050 ae0000        	ldw	x,#_gv
 179  0053 cd0000        	call	_ADC_Init
 181  0056 84            	pop	a
 182                     ; 69     ADC_Init(&gv.adc[ADC_2], ADC_CH_2);
 184  0057 4b01          	push	#1
 185  0059 ae0013        	ldw	x,#_gv+19
 186  005c cd0000        	call	_ADC_Init
 188  005f 84            	pop	a
 189                     ; 70     ADC_Init(&gv.adc[ADC_3], ADC_CH_3);
 191  0060 4b02          	push	#2
 192  0062 ae0026        	ldw	x,#_gv+38
 193  0065 cd0000        	call	_ADC_Init
 195  0068 84            	pop	a
 196                     ; 71     ADC_Init(&gv.adc[ADC_4], ADC_CH_4);
 198  0069 4b03          	push	#3
 199  006b ae0039        	ldw	x,#_gv+57
 200  006e cd0000        	call	_ADC_Init
 202  0071 84            	pop	a
 203                     ; 72     ADC_Init(&gv.adc[ADC_5], ADC_CH_5);
 205  0072 4b04          	push	#4
 206  0074 ae004c        	ldw	x,#_gv+76
 207  0077 cd0000        	call	_ADC_Init
 209  007a 84            	pop	a
 210                     ; 75     TIM_Init();
 212  007b cd0000        	call	_TIM_Init
 214                     ; 76     TIM_SetDuty(50); // PWM 50% duty at Timer 2 channel 1S
 216  007e a632          	ld	a,#50
 217  0080 cd0000        	call	_TIM_SetDuty
 219  0083               L54:
 220                     ; 83 		ADC_Update();
 222  0083 ad5a          	call	_ADC_Update
 224                     ; 89 		dbg_print("Count:%d\r\n", count);
 226  0085 1e22          	ldw	x,(OFST-1,sp)
 227  0087 89            	pushw	x
 228  0088 ae000c        	ldw	x,#L15
 229  008b cd0000        	call	_printf
 231  008e 85            	popw	x
 232                     ; 92 		sprintf(str,"Count:%d\r\n", count);
 234  008f 1e22          	ldw	x,(OFST-1,sp)
 235  0091 89            	pushw	x
 236  0092 ae000c        	ldw	x,#L15
 237  0095 89            	pushw	x
 238  0096 96            	ldw	x,sp
 239  0097 1c0005        	addw	x,#OFST-30
 240  009a cd0000        	call	_sprintf
 242  009d 5b04          	addw	sp,#4
 243                     ; 93 		Serial_Print(str);
 245  009f 96            	ldw	x,sp
 246  00a0 1c0001        	addw	x,#OFST-34
 247  00a3 cd0000        	call	_Serial_Print
 249                     ; 95 		rxChar = Serial_ReadChar();
 251  00a6 cd0000        	call	_Serial_ReadChar
 253  00a9 6b21          	ld	(OFST-2,sp),a
 255                     ; 96 		if(rxChar>0){
 257  00ab 0d21          	tnz	(OFST-2,sp)
 258  00ad 270a          	jreq	L35
 259                     ; 97 				dbg_print("%c",rxChar);
 261  00af 7b21          	ld	a,(OFST-2,sp)
 262  00b1 88            	push	a
 263  00b2 ae0009        	ldw	x,#L55
 264  00b5 cd0000        	call	_printf
 266  00b8 84            	pop	a
 267                     ; 98 				rxChar = 0;
 269  00b9               L35:
 270                     ; 104 		sprintf(str,"Count:%d", count);
 272  00b9 1e22          	ldw	x,(OFST-1,sp)
 273  00bb 89            	pushw	x
 274  00bc ae0000        	ldw	x,#L75
 275  00bf 89            	pushw	x
 276  00c0 96            	ldw	x,sp
 277  00c1 1c0005        	addw	x,#OFST-30
 278  00c4 cd0000        	call	_sprintf
 280  00c7 5b04          	addw	sp,#4
 281                     ; 105 		LCD_SetCursor(2,1);
 283  00c9 ae0201        	ldw	x,#513
 284  00cc cd0000        	call	_LCD_SetCursor
 286                     ; 106 		LCD_PrintString(str);
 288  00cf 96            	ldw	x,sp
 289  00d0 1c0001        	addw	x,#OFST-34
 290  00d3 cd0000        	call	_LCD_PrintString
 292                     ; 110 		count++;
 294  00d6 1e22          	ldw	x,(OFST-1,sp)
 295  00d8 1c0001        	addw	x,#1
 296  00db 1f22          	ldw	(OFST-1,sp),x
 299  00dd 20a4          	jra	L54
 335                     ; 114 void ADC_Update(void){
 336                     	switch	.text
 337  00df               _ADC_Update:
 339  00df 88            	push	a
 340       00000001      OFST:	set	1
 343                     ; 115 		uint8_t i = 0;
 345                     ; 116 		for(i = 0; i < ADC_MAX; i++){
 347  00e0 0f01          	clr	(OFST+0,sp)
 349  00e2               L77:
 350                     ; 117 				ADC_Read(&gv.adc[i]);
 352  00e2 7b01          	ld	a,(OFST+0,sp)
 353  00e4 97            	ld	xl,a
 354  00e5 a613          	ld	a,#19
 355  00e7 42            	mul	x,a
 356  00e8 01            	rrwa	x,a
 357  00e9 ab00          	add	a,#_gv
 358  00eb 2401          	jrnc	L01
 359  00ed 5c            	incw	x
 360  00ee               L01:
 361  00ee 5f            	clrw	x
 362  00ef 97            	ld	xl,a
 363  00f0 cd0000        	call	_ADC_Read
 365                     ; 116 		for(i = 0; i < ADC_MAX; i++){
 367  00f3 0c01          	inc	(OFST+0,sp)
 371  00f5 7b01          	ld	a,(OFST+0,sp)
 372  00f7 a105          	cp	a,#5
 373  00f9 25e7          	jrult	L77
 374                     ; 119 }
 377  00fb 84            	pop	a
 378  00fc 81            	ret
 462                     ; 121 uint16_t ADC_GetValue(ADC_Id_te id){
 463                     	switch	.text
 464  00fd               _ADC_GetValue:
 468                     ; 122     if(id >= 0 && id < ADC_MAX){
 470  00fd a105          	cp	a,#5
 471  00ff 2407          	jruge	L341
 472                     ; 123         return gv.adc[id].value;
 474  0101 97            	ld	xl,a
 475  0102 a613          	ld	a,#19
 476  0104 42            	mul	x,a
 477  0105 ee01          	ldw	x,(_gv+1,x)
 480  0107 81            	ret
 481  0108               L341:
 482                     ; 125         return 0;
 484  0108 5f            	clrw	x
 487  0109 81            	ret
 513                     ; 129 void BlinkLED(void){
 514                     	switch	.text
 515  010a               _BlinkLED:
 519                     ; 130 		GPIO_WriteHigh(LED);
 521  010a 4b80          	push	#128
 522  010c ae5005        	ldw	x,#20485
 523  010f cd0000        	call	_GPIO_WriteHigh
 525  0112 84            	pop	a
 526                     ; 131 		delay(500);
 528  0113 ae01f4        	ldw	x,#500
 529  0116 89            	pushw	x
 530  0117 ae0000        	ldw	x,#0
 531  011a 89            	pushw	x
 532  011b ad18          	call	_delay
 534  011d 5b04          	addw	sp,#4
 535                     ; 132 		GPIO_WriteLow(LED);
 537  011f 4b80          	push	#128
 538  0121 ae5005        	ldw	x,#20485
 539  0124 cd0000        	call	_GPIO_WriteLow
 541  0127 84            	pop	a
 542                     ; 133 		delay(500);
 544  0128 ae01f4        	ldw	x,#500
 545  012b 89            	pushw	x
 546  012c ae0000        	ldw	x,#0
 547  012f 89            	pushw	x
 548  0130 ad03          	call	_delay
 550  0132 5b04          	addw	sp,#4
 551                     ; 134 }
 554  0134 81            	ret
 597                     ; 136 void delay(uint32_t ms){
 598                     	switch	.text
 599  0135               _delay:
 601  0135 5204          	subw	sp,#4
 602       00000004      OFST:	set	4
 605                     ; 137     uint32_t i = 0;
 607                     ; 138     for(i = 0; i < (120*ms); i++){;}
 609  0137 ae0000        	ldw	x,#0
 610  013a 1f03          	ldw	(OFST-1,sp),x
 611  013c ae0000        	ldw	x,#0
 612  013f 1f01          	ldw	(OFST-3,sp),x
 615  0141 2009          	jra	L502
 616  0143               L102:
 620  0143 96            	ldw	x,sp
 621  0144 1c0001        	addw	x,#OFST-3
 622  0147 a601          	ld	a,#1
 623  0149 cd0000        	call	c_lgadc
 626  014c               L502:
 629  014c 96            	ldw	x,sp
 630  014d 1c0007        	addw	x,#OFST+3
 631  0150 cd0000        	call	c_ltor
 633  0153 a678          	ld	a,#120
 634  0155 cd0000        	call	c_smul
 636  0158 96            	ldw	x,sp
 637  0159 1c0001        	addw	x,#OFST-3
 638  015c cd0000        	call	c_lcmp
 640  015f 22e2          	jrugt	L102
 641                     ; 139 }
 644  0161 5b04          	addw	sp,#4
 645  0163 81            	ret
 765                     	xdef	_main
 766                     	xdef	_BlinkLED
 767                     	xdef	_ADC_GetValue
 768                     	xdef	_ADC_Update
 769                     	xdef	_delay
 770                     	xdef	_gv
 771                     	xref	_LCD_PrintString
 772                     	xref	_LCD_SetCursor
 773                     	xref	_LCD_Clear
 774                     	xref	_LCD_Begin
 775                     	xref	_dbg_init
 776                     	xref	_sprintf
 777                     	xref	_printf
 778                     	xref	_TIM_SetDuty
 779                     	xref	_TIM_Init
 780                     	xref	_ADC_Read
 781                     	xref	_ADC_Init
 782                     	xref	_Serial_ReadChar
 783                     	xref	_Serial_Print
 784                     	xref	_Serial_Init
 785                     	xref	_CLK_HSIPrescalerConfig
 786                     	xref	_GPIO_WriteLow
 787                     	xref	_GPIO_WriteHigh
 788                     	xref	_GPIO_Init
 789                     .const:	section	.text
 790  0000               L75:
 791  0000 436f756e743a  	dc.b	"Count:%d",0
 792  0009               L55:
 793  0009 256300        	dc.b	"%c",0
 794  000c               L15:
 795  000c 436f756e743a  	dc.b	"Count:%d",13
 796  0015 0a00          	dc.b	10,0
 797  0017               L34:
 798  0017 31363032204c  	dc.b	"1602 LCD",0
 799  0020               L14:
 800  0020 57656c636f6d  	dc.b	"Welcome!",0
 801  0029               L73:
 802  0029 0d0a2d2d2d53  	dc.b	13,10,45,45,45,83
 803  002f 746172746564  	dc.b	"tarted---",13
 804  0039 0a00          	dc.b	10,0
 824                     	xref	c_lcmp
 825                     	xref	c_smul
 826                     	xref	c_ltor
 827                     	xref	c_lgadc
 828                     	end
