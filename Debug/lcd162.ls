   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
  72                     .const:	section	.text
  73  0000               L6:
  74  0000 000000d2      	dc.l	210
  75                     ; 15 static void LCD_Delay (uint32_t ms) {
  76                     	scross	off
  77                     	switch	.text
  78  0000               L5_LCD_Delay:
  80  0000 5208          	subw	sp,#8
  81       00000008      OFST:	set	8
  84                     ; 16     uint32_t i =0 ;
  86                     ; 17     uint32_t j=0;
  88                     ; 18     for (i=0; i<=ms; i++){
  90  0002 ae0000        	ldw	x,#0
  91  0005 1f03          	ldw	(OFST-5,sp),x
  92  0007 ae0000        	ldw	x,#0
  93  000a 1f01          	ldw	(OFST-7,sp),x
  96  000c 202c          	jra	L74
  97  000e               L34:
  98                     ; 19         for (j=0; j<210; j++) // Nop = Fosc/4
 100  000e ae0000        	ldw	x,#0
 101  0011 1f07          	ldw	(OFST-1,sp),x
 102  0013 ae0000        	ldw	x,#0
 103  0016 1f05          	ldw	(OFST-3,sp),x
 105  0018               L35:
 106                     ; 20             _asm("nop"); //Perform no operation //assembly code <span style="white-space:pre"> </span>
 109  0018 9d            nop
 111                     ; 19         for (j=0; j<210; j++) // Nop = Fosc/4
 113  0019 96            	ldw	x,sp
 114  001a 1c0005        	addw	x,#OFST-3
 115  001d a601          	ld	a,#1
 116  001f cd0000        	call	c_lgadc
 121  0022 96            	ldw	x,sp
 122  0023 1c0005        	addw	x,#OFST-3
 123  0026 cd0000        	call	c_ltor
 125  0029 ae0000        	ldw	x,#L6
 126  002c cd0000        	call	c_lcmp
 128  002f 25e7          	jrult	L35
 129                     ; 18     for (i=0; i<=ms; i++){
 131  0031 96            	ldw	x,sp
 132  0032 1c0001        	addw	x,#OFST-7
 133  0035 a601          	ld	a,#1
 134  0037 cd0000        	call	c_lgadc
 137  003a               L74:
 140  003a 96            	ldw	x,sp
 141  003b 1c0001        	addw	x,#OFST-7
 142  003e cd0000        	call	c_ltor
 144  0041 96            	ldw	x,sp
 145  0042 1c000b        	addw	x,#OFST+3
 146  0045 cd0000        	call	c_lcmp
 148  0048 23c4          	jrule	L34
 149                     ; 22 }
 152  004a 5b08          	addw	sp,#8
 153  004c 81            	ret
 189                     ; 31  static void LCD_SetBit(char data){
 190                     	switch	.text
 191  004d               L3_LCD_SetBit:
 193  004d 88            	push	a
 194       00000000      OFST:	set	0
 197                     ; 33     (data&0x01) ? GPIO_WriteHigh(LCD_DB4) : GPIO_WriteLow(LCD_DB4);
 199  004e a501          	bcp	a,#1
 200  0050 270c          	jreq	L21
 201  0052 4b08          	push	#8
 202  0054 ae500a        	ldw	x,#20490
 203  0057 cd0000        	call	_GPIO_WriteHigh
 205  005a 5b01          	addw	sp,#1
 206  005c 200a          	jra	L41
 207  005e               L21:
 208  005e 4b08          	push	#8
 209  0060 ae500a        	ldw	x,#20490
 210  0063 cd0000        	call	_GPIO_WriteLow
 212  0066 5b01          	addw	sp,#1
 213  0068               L41:
 214                     ; 34     (data&0x02) ? GPIO_WriteHigh(LCD_DB5) : GPIO_WriteLow(LCD_DB5);
 216  0068 7b01          	ld	a,(OFST+1,sp)
 217  006a a502          	bcp	a,#2
 218  006c 270c          	jreq	L61
 219  006e 4b10          	push	#16
 220  0070 ae500a        	ldw	x,#20490
 221  0073 cd0000        	call	_GPIO_WriteHigh
 223  0076 5b01          	addw	sp,#1
 224  0078 200a          	jra	L02
 225  007a               L61:
 226  007a 4b10          	push	#16
 227  007c ae500a        	ldw	x,#20490
 228  007f cd0000        	call	_GPIO_WriteLow
 230  0082 5b01          	addw	sp,#1
 231  0084               L02:
 232                     ; 35     (data&0x04) ? GPIO_WriteHigh(LCD_DB6) : GPIO_WriteLow(LCD_DB6); //D6=0
 234  0084 7b01          	ld	a,(OFST+1,sp)
 235  0086 a504          	bcp	a,#4
 236  0088 270c          	jreq	L22
 237  008a 4b20          	push	#32
 238  008c ae500a        	ldw	x,#20490
 239  008f cd0000        	call	_GPIO_WriteHigh
 241  0092 5b01          	addw	sp,#1
 242  0094 200a          	jra	L42
 243  0096               L22:
 244  0096 4b20          	push	#32
 245  0098 ae500a        	ldw	x,#20490
 246  009b cd0000        	call	_GPIO_WriteLow
 248  009e 5b01          	addw	sp,#1
 249  00a0               L42:
 250                     ; 36     (data&0x08) ? GPIO_WriteHigh(LCD_DB7) : GPIO_WriteLow(LCD_DB7); //D7=0
 252  00a0 7b01          	ld	a,(OFST+1,sp)
 253  00a2 a508          	bcp	a,#8
 254  00a4 270c          	jreq	L62
 255  00a6 4b40          	push	#64
 256  00a8 ae500a        	ldw	x,#20490
 257  00ab cd0000        	call	_GPIO_WriteHigh
 259  00ae 5b01          	addw	sp,#1
 260  00b0 200a          	jra	L03
 261  00b2               L62:
 262  00b2 4b40          	push	#64
 263  00b4 ae500a        	ldw	x,#20490
 264  00b7 cd0000        	call	_GPIO_WriteLow
 266  00ba 5b01          	addw	sp,#1
 267  00bc               L03:
 268                     ; 37 }
 271  00bc 84            	pop	a
 272  00bd 81            	ret
 310                     ; 44 void LCD_Cmd(char cmd){
 311                     	switch	.text
 312  00be               _LCD_Cmd:
 314  00be 88            	push	a
 315       00000000      OFST:	set	0
 318                     ; 45     GPIO_WriteLow(LCD_RS); //RS = 0          
 320  00bf 4b02          	push	#2
 321  00c1 ae500a        	ldw	x,#20490
 322  00c4 cd0000        	call	_GPIO_WriteLow
 324  00c7 84            	pop	a
 325                     ; 46     LCD_SetBit(cmd); //Incoming Hex value
 327  00c8 7b01          	ld	a,(OFST+1,sp)
 328  00ca ad81          	call	L3_LCD_SetBit
 330                     ; 47     GPIO_WriteHigh(LCD_EN); //EN  = 1         
 332  00cc 4b04          	push	#4
 333  00ce ae500a        	ldw	x,#20490
 334  00d1 cd0000        	call	_GPIO_WriteHigh
 336  00d4 84            	pop	a
 337                     ; 48 	LCD_Delay(2);
 339  00d5 ae0002        	ldw	x,#2
 340  00d8 89            	pushw	x
 341  00d9 ae0000        	ldw	x,#0
 342  00dc 89            	pushw	x
 343  00dd cd0000        	call	L5_LCD_Delay
 345  00e0 5b04          	addw	sp,#4
 346                     ; 49 	GPIO_WriteLow(LCD_EN); //EN  = 0      
 348  00e2 4b04          	push	#4
 349  00e4 ae500a        	ldw	x,#20490
 350  00e7 cd0000        	call	_GPIO_WriteLow
 352  00ea 84            	pop	a
 353                     ; 50 }
 356  00eb 84            	pop	a
 357  00ec 81            	ret
 384                     ; 58  void LCD_Begin(void){
 385                     	switch	.text
 386  00ed               _LCD_Begin:
 390                     ; 60     GPIO_Init(LCD_RS, GPIO_MODE_OUT_PP_HIGH_FAST);
 392  00ed 4bf0          	push	#240
 393  00ef 4b02          	push	#2
 394  00f1 ae500a        	ldw	x,#20490
 395  00f4 cd0000        	call	_GPIO_Init
 397  00f7 85            	popw	x
 398                     ; 61     GPIO_Init(LCD_EN, GPIO_MODE_OUT_PP_HIGH_FAST);
 400  00f8 4bf0          	push	#240
 401  00fa 4b04          	push	#4
 402  00fc ae500a        	ldw	x,#20490
 403  00ff cd0000        	call	_GPIO_Init
 405  0102 85            	popw	x
 406                     ; 62     GPIO_Init(LCD_DB4, GPIO_MODE_OUT_PP_HIGH_FAST);
 408  0103 4bf0          	push	#240
 409  0105 4b08          	push	#8
 410  0107 ae500a        	ldw	x,#20490
 411  010a cd0000        	call	_GPIO_Init
 413  010d 85            	popw	x
 414                     ; 63     GPIO_Init(LCD_DB5, GPIO_MODE_OUT_PP_HIGH_FAST);
 416  010e 4bf0          	push	#240
 417  0110 4b10          	push	#16
 418  0112 ae500a        	ldw	x,#20490
 419  0115 cd0000        	call	_GPIO_Init
 421  0118 85            	popw	x
 422                     ; 64     GPIO_Init(LCD_DB6, GPIO_MODE_OUT_PP_HIGH_FAST);
 424  0119 4bf0          	push	#240
 425  011b 4b20          	push	#32
 426  011d ae500a        	ldw	x,#20490
 427  0120 cd0000        	call	_GPIO_Init
 429  0123 85            	popw	x
 430                     ; 65     GPIO_Init(LCD_DB7, GPIO_MODE_OUT_PP_HIGH_FAST);
 432  0124 4bf0          	push	#240
 433  0126 4b40          	push	#64
 434  0128 ae500a        	ldw	x,#20490
 435  012b cd0000        	call	_GPIO_Init
 437  012e 85            	popw	x
 438                     ; 66     LCD_Delay(10);
 440  012f ae000a        	ldw	x,#10
 441  0132 89            	pushw	x
 442  0133 ae0000        	ldw	x,#0
 443  0136 89            	pushw	x
 444  0137 cd0000        	call	L5_LCD_Delay
 446  013a 5b04          	addw	sp,#4
 447                     ; 68 	LCD_SetBit(0x00);
 449  013c 4f            	clr	a
 450  013d cd004d        	call	L3_LCD_SetBit
 452                     ; 69 	LCD_Delay(1000);  //for(int i=1065244; i<=0; i--)  
 454  0140 ae03e8        	ldw	x,#1000
 455  0143 89            	pushw	x
 456  0144 ae0000        	ldw	x,#0
 457  0147 89            	pushw	x
 458  0148 cd0000        	call	L5_LCD_Delay
 460  014b 5b04          	addw	sp,#4
 461                     ; 72     LCD_Cmd(0x03);
 463  014d a603          	ld	a,#3
 464  014f cd00be        	call	_LCD_Cmd
 466                     ; 73 	LCD_Delay(5);
 468  0152 ae0005        	ldw	x,#5
 469  0155 89            	pushw	x
 470  0156 ae0000        	ldw	x,#0
 471  0159 89            	pushw	x
 472  015a cd0000        	call	L5_LCD_Delay
 474  015d 5b04          	addw	sp,#4
 475                     ; 75     LCD_Cmd(0x03);
 477  015f a603          	ld	a,#3
 478  0161 cd00be        	call	_LCD_Cmd
 480                     ; 76 	LCD_Delay(11);
 482  0164 ae000b        	ldw	x,#11
 483  0167 89            	pushw	x
 484  0168 ae0000        	ldw	x,#0
 485  016b 89            	pushw	x
 486  016c cd0000        	call	L5_LCD_Delay
 488  016f 5b04          	addw	sp,#4
 489                     ; 78     LCD_Cmd(0x03); 
 491  0171 a603          	ld	a,#3
 492  0173 cd00be        	call	_LCD_Cmd
 494                     ; 79     LCD_Cmd(0x02); //02H is used for Return home -> Clears the RAM and initializes the LCD
 496  0176 a602          	ld	a,#2
 497  0178 cd00be        	call	_LCD_Cmd
 499                     ; 80     LCD_Cmd(0x02); //02H is used for Return home -> Clears the RAM and initializes the LCD
 501  017b a602          	ld	a,#2
 502  017d cd00be        	call	_LCD_Cmd
 504                     ; 81     LCD_Cmd(0x08); //Select Row 1
 506  0180 a608          	ld	a,#8
 507  0182 cd00be        	call	_LCD_Cmd
 509                     ; 82     LCD_Cmd(0x00); //Clear Row 1 Display
 511  0185 4f            	clr	a
 512  0186 cd00be        	call	_LCD_Cmd
 514                     ; 83     LCD_Cmd(0x0C); //Select Row 2
 516  0189 a60c          	ld	a,#12
 517  018b cd00be        	call	_LCD_Cmd
 519                     ; 84     LCD_Cmd(0x00); //Clear Row 2 Display
 521  018e 4f            	clr	a
 522  018f cd00be        	call	_LCD_Cmd
 524                     ; 85     LCD_Cmd(0x06);
 526  0192 a606          	ld	a,#6
 527  0194 cd00be        	call	_LCD_Cmd
 529                     ; 86  }
 532  0197 81            	ret
 556                     ; 91 void LCD_Clear(void){
 557                     	switch	.text
 558  0198               _LCD_Clear:
 562                     ; 92     LCD_Cmd(0); //Clear the LCD
 564  0198 4f            	clr	a
 565  0199 cd00be        	call	_LCD_Cmd
 567                     ; 93     LCD_Cmd(1); //Move the curser to first position
 569  019c a601          	ld	a,#1
 570  019e cd00be        	call	_LCD_Cmd
 572                     ; 94 }
 575  01a1 81            	ret
 646                     ; 102 void LCD_SetCursor(char row, char col){
 647                     	switch	.text
 648  01a2               _LCD_SetCursor:
 650  01a2 89            	pushw	x
 651  01a3 89            	pushw	x
 652       00000002      OFST:	set	2
 655                     ; 104     if(row == 1)
 657  01a4 9e            	ld	a,xh
 658  01a5 a101          	cp	a,#1
 659  01a7 261e          	jrne	L371
 660                     ; 106       temp = 0x80 + col - 1; //80H is used to move the curser
 662  01a9 9f            	ld	a,xl
 663  01aa ab7f          	add	a,#127
 664  01ac 6b02          	ld	(OFST+0,sp),a
 666                     ; 107         z = temp>>4; //Lower 8-bits
 668  01ae 7b02          	ld	a,(OFST+0,sp)
 669  01b0 4e            	swap	a
 670  01b1 a40f          	and	a,#15
 671  01b3 6b01          	ld	(OFST-1,sp),a
 673                     ; 108         y = temp & 0x0F; //Upper 8-bits
 675  01b5 7b02          	ld	a,(OFST+0,sp)
 676  01b7 a40f          	and	a,#15
 677  01b9 6b02          	ld	(OFST+0,sp),a
 679                     ; 109         LCD_Cmd(z); //Set Row
 681  01bb 7b01          	ld	a,(OFST-1,sp)
 682  01bd cd00be        	call	_LCD_Cmd
 684                     ; 110         LCD_Cmd(y); //Set Column
 686  01c0 7b02          	ld	a,(OFST+0,sp)
 687  01c2 cd00be        	call	_LCD_Cmd
 690  01c5 2023          	jra	L571
 691  01c7               L371:
 692                     ; 112     else if(row == 2)
 694  01c7 7b03          	ld	a,(OFST+1,sp)
 695  01c9 a102          	cp	a,#2
 696  01cb 261d          	jrne	L571
 697                     ; 114         temp = 0xC0 + col - 1;
 699  01cd 7b04          	ld	a,(OFST+2,sp)
 700  01cf abbf          	add	a,#191
 701  01d1 6b02          	ld	(OFST+0,sp),a
 703                     ; 115         z = temp>>4; //Lower 8-bits
 705  01d3 7b02          	ld	a,(OFST+0,sp)
 706  01d5 4e            	swap	a
 707  01d6 a40f          	and	a,#15
 708  01d8 6b01          	ld	(OFST-1,sp),a
 710                     ; 116         y = temp & 0x0F; //Upper 8-bits
 712  01da 7b02          	ld	a,(OFST+0,sp)
 713  01dc a40f          	and	a,#15
 714  01de 6b02          	ld	(OFST+0,sp),a
 716                     ; 117         LCD_Cmd(z); //Set Row
 718  01e0 7b01          	ld	a,(OFST-1,sp)
 719  01e2 cd00be        	call	_LCD_Cmd
 721                     ; 118         LCD_Cmd(y); //Set Column
 723  01e5 7b02          	ld	a,(OFST+0,sp)
 724  01e7 cd00be        	call	_LCD_Cmd
 726  01ea               L571:
 727                     ; 120 }
 730  01ea 5b04          	addw	sp,#4
 731  01ec 81            	ret
 787                     ; 128  void LCD_PrintChar(char data){
 788                     	switch	.text
 789  01ed               _LCD_PrintChar:
 791  01ed 88            	push	a
 792  01ee 89            	pushw	x
 793       00000002      OFST:	set	2
 796                     ; 130    Lower_Nibble = data&0x0F;
 798  01ef a40f          	and	a,#15
 799  01f1 6b01          	ld	(OFST-1,sp),a
 801                     ; 131    Upper_Nibble = data&0xF0;
 803  01f3 7b03          	ld	a,(OFST+1,sp)
 804  01f5 a4f0          	and	a,#240
 805  01f7 6b02          	ld	(OFST+0,sp),a
 807                     ; 132    GPIO_WriteHigh(LCD_RS);             // => RS = 1
 809  01f9 4b02          	push	#2
 810  01fb ae500a        	ldw	x,#20490
 811  01fe cd0000        	call	_GPIO_WriteHigh
 813  0201 84            	pop	a
 814                     ; 134    LCD_SetBit(Upper_Nibble>>4);             //Send upper half by shifting by 4
 816  0202 7b02          	ld	a,(OFST+0,sp)
 817  0204 4e            	swap	a
 818  0205 a40f          	and	a,#15
 819  0207 cd004d        	call	L3_LCD_SetBit
 821                     ; 135    GPIO_WriteHigh(LCD_EN); //EN = 1
 823  020a 4b04          	push	#4
 824  020c ae500a        	ldw	x,#20490
 825  020f cd0000        	call	_GPIO_WriteHigh
 827  0212 84            	pop	a
 828                     ; 136    LCD_Delay(5); //for(int i=2130483; i<=0; i--)  NOP(); 
 830  0213 ae0005        	ldw	x,#5
 831  0216 89            	pushw	x
 832  0217 ae0000        	ldw	x,#0
 833  021a 89            	pushw	x
 834  021b cd0000        	call	L5_LCD_Delay
 836  021e 5b04          	addw	sp,#4
 837                     ; 137    GPIO_WriteLow(LCD_EN); //EN = 0
 839  0220 4b04          	push	#4
 840  0222 ae500a        	ldw	x,#20490
 841  0225 cd0000        	call	_GPIO_WriteLow
 843  0228 84            	pop	a
 844                     ; 139    LCD_SetBit(Lower_Nibble); //Send Lower half
 846  0229 7b01          	ld	a,(OFST-1,sp)
 847  022b cd004d        	call	L3_LCD_SetBit
 849                     ; 140    GPIO_WriteHigh(LCD_EN); //EN = 1
 851  022e 4b04          	push	#4
 852  0230 ae500a        	ldw	x,#20490
 853  0233 cd0000        	call	_GPIO_WriteHigh
 855  0236 84            	pop	a
 856                     ; 141    LCD_Delay(5); //for(int i=2130483; i<=0; i--)  NOP();
 858  0237 ae0005        	ldw	x,#5
 859  023a 89            	pushw	x
 860  023b ae0000        	ldw	x,#0
 861  023e 89            	pushw	x
 862  023f cd0000        	call	L5_LCD_Delay
 864  0242 5b04          	addw	sp,#4
 865                     ; 142    GPIO_WriteLow(LCD_EN); //EN = 0
 867  0244 4b04          	push	#4
 868  0246 ae500a        	ldw	x,#20490
 869  0249 cd0000        	call	_GPIO_WriteLow
 871  024c 84            	pop	a
 872                     ; 143 }
 875  024d 5b03          	addw	sp,#3
 876  024f 81            	ret
 921                     ; 151 void LCD_PrintString(char *str){
 922                     	switch	.text
 923  0250               _LCD_PrintString:
 925  0250 89            	pushw	x
 926  0251 89            	pushw	x
 927       00000002      OFST:	set	2
 930                     ; 153     for(i=0; str[i]!='\0'; i++){//
 932  0252 5f            	clrw	x
 933  0253 1f01          	ldw	(OFST-1,sp),x
 936  0255 200f          	jra	L552
 937  0257               L152:
 938                     ; 154        LCD_PrintChar(str[i]);  //Split the string using pointers and call the Char function 
 940  0257 1e01          	ldw	x,(OFST-1,sp)
 941  0259 72fb03        	addw	x,(OFST+1,sp)
 942  025c f6            	ld	a,(x)
 943  025d ad8e          	call	_LCD_PrintChar
 945                     ; 153     for(i=0; str[i]!='\0'; i++){//
 947  025f 1e01          	ldw	x,(OFST-1,sp)
 948  0261 1c0001        	addw	x,#1
 949  0264 1f01          	ldw	(OFST-1,sp),x
 951  0266               L552:
 954  0266 1e01          	ldw	x,(OFST-1,sp)
 955  0268 72fb03        	addw	x,(OFST+1,sp)
 956  026b 7d            	tnz	(x)
 957  026c 26e9          	jrne	L152
 958                     ; 156 }
 961  026e 5b04          	addw	sp,#4
 962  0270 81            	ret
 975                     	xdef	_LCD_PrintChar
 976                     	xdef	_LCD_PrintString
 977                     	xdef	_LCD_SetCursor
 978                     	xdef	_LCD_Clear
 979                     	xdef	_LCD_Begin
 980                     	xdef	_LCD_Cmd
 981                     	xref	_GPIO_WriteLow
 982                     	xref	_GPIO_WriteHigh
 983                     	xref	_GPIO_Init
1002                     	xref	c_lcmp
1003                     	xref	c_ltor
1004                     	xref	c_lgadc
1005                     	end
