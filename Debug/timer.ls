   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
  14                     	bsct
  15  0000               L3_period:
  16  0000 0fa0          	dc.w	4000
  50                     ; 27 void TIM_Init(void){
  52                     	switch	.text
  53  0000               _TIM_Init:
  57                     ; 28     TIM2_DeInit();
  59  0000 cd0000        	call	_TIM2_DeInit
  61                     ; 29     TIM2_TimeBaseInit(TIM2_PRESCALER_1, period);
  63  0003 be00          	ldw	x,L3_period
  64  0005 89            	pushw	x
  65  0006 4f            	clr	a
  66  0007 cd0000        	call	_TIM2_TimeBaseInit
  68  000a 85            	popw	x
  69                     ; 30     TIM2_OC1Init(TIM2_OCMODE_PWM1, 
  69                     ; 31                 TIM2_OUTPUTSTATE_ENABLE, 
  69                     ; 32                 (period/2), 
  69                     ; 33                 TIM2_OCPOLARITY_HIGH);
  71  000b 4b00          	push	#0
  72  000d be00          	ldw	x,L3_period
  73  000f 54            	srlw	x
  74  0010 89            	pushw	x
  75  0011 ae6011        	ldw	x,#24593
  76  0014 cd0000        	call	_TIM2_OC1Init
  78  0017 5b03          	addw	sp,#3
  79                     ; 34     TIM2_Cmd(ENABLE);
  81  0019 a601          	ld	a,#1
  82  001b cd0000        	call	_TIM2_Cmd
  84                     ; 35 }
  87  001e 81            	ret
 132                     ; 47  void TIM_SetDuty(uint8_t duty){
 133                     	switch	.text
 134  001f               _TIM_SetDuty:
 136  001f 88            	push	a
 137  0020 89            	pushw	x
 138       00000002      OFST:	set	2
 141                     ; 48     if(duty >= 0 && duty <= 100){
 143  0021 a165          	cp	a,#101
 144  0023 2415          	jruge	L54
 145                     ; 49         uint16_t dutyCycle = (period/100);
 147  0025 be00          	ldw	x,L3_period
 148  0027 a664          	ld	a,#100
 149  0029 62            	div	x,a
 150  002a 1f01          	ldw	(OFST-1,sp),x
 152                     ; 50         dutyCycle = (dutyCycle*duty);
 154  002c 1e01          	ldw	x,(OFST-1,sp)
 155  002e 7b03          	ld	a,(OFST+1,sp)
 156  0030 cd0000        	call	c_bmulx
 158  0033 1f01          	ldw	(OFST-1,sp),x
 160                     ; 51         TIM2_SetCompare1(dutyCycle);
 162  0035 1e01          	ldw	x,(OFST-1,sp)
 163  0037 cd0000        	call	_TIM2_SetCompare1
 165  003a               L54:
 166                     ; 54  }
 169  003a 5b03          	addw	sp,#3
 170  003c 81            	ret
 194                     	xdef	_TIM_SetDuty
 195                     	xdef	_TIM_Init
 196                     	xref	_TIM2_SetCompare1
 197                     	xref	_TIM2_Cmd
 198                     	xref	_TIM2_OC1Init
 199                     	xref	_TIM2_TimeBaseInit
 200                     	xref	_TIM2_DeInit
 201                     	xref.b	c_x
 220                     	xref	c_bmulx
 221                     	end
